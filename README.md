# Proxmox Terraform Provisioning

Terraform configurations for provisioning VMs. "Inspired" by [terraform-proxmox-cloud-init](https://github.com/jodykpw/terraform-proxmox-cloud-init).

Terraform state and lock are managed by GitLab itself check [official documentation](https://docs.gitlab.com/ee/user/infrastructure/iac/terraform_state.html) for more details on how to use the backend from your local machine, but prefer provisioning over GitLab CI.

## Setup

Before you begin, ensure that you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine
- SSH key pair for authenticating to the Proxmox server(s).
- [Proxmox user and role for terraform](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs#creating-the-proxmox-user-and-role-for-terraform)
- [Connection to Proxmox using API token](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs#creating-the-connection-via-username-and-api-token)

Follow these steps to get started with the project:

1. Clone the repository

2. Locate the `terraform.tfvars.example` file in the project directory.

3. Create a new file named `terraform.tfvars` by making a copy of the example file: `cp terraform.tfvars.example terraform.tfvars`

4. Update the variable values in the `terraform.tfvars` file with your desired configurations. Make sure to replace the example values with your actual settings.
   - Note: Take special note of `connection_private_key_path` which should be the path to your private key that will be used to SCP the cloud-init file to the Proxmox server.

5. Locate the `vms` map object declaration the desired module definition in the `main.tf` file.
    - Note: Module definitions in the root `main.tf` act as environments.
    - Note: Create a new module definition if your VM environment does not match the existing module definitions.  

6. Update the vms map object with your desired virtual machine configurations. Modify the Proxmox connection details, virtual machine settings, Cloud-Init configuration, etc., to match your desired setup.

7. Save the `main.tf` file.

## Usage

Easiest way is to use the Makefile in the root of the repo.

But to use manual commands

Initialize the Terraform working directory: `terraform init`

Review the execution plan: `terraform plan`

Provision the virtual machines: `terraform apply`

Any resources defined in the root `main.tf` can be targeted by using `-target="<RESOURCE>.<RESOURCE NAME>"`. For example, target `base-infra` module: `terraform apply -target=module.base-infra`

You will be prompted to confirm the provisioning. Type yes to proceed. Or use the `-auto-approve` flag to skip the confirmation.

To clean up and destroy all resources, run the following command: `terraform destroy`

Note: Be cautious while running this command as it will destroy all the virtual machines and associated resources.

## Known Issues

`Error: scsi0 - cloud-init drive is already attached at 'ide0'`:

- Cause: Bug in terraform-provider-proxmox, also discussed in [this issue](https://github.com/Telmate/terraform-provider-proxmox/issues/704)
- Workaround: change anything in the `disks` definition and/or re-run `terraform apply`. Move cloud-init drive from ide0 to ide1.

`400 Parameter verification failed. scsi0: hotplug problem - can't unplug bootdisk 'scsi0'` when resizing disks:

- Cause: Bug in terraform-provider-proxmox causes nondeterministic issues with disk resizing and removals, also discussed in [here](https://github.com/Telmate/terraform-provider-proxmox/issues/744) and [here](https://github.com/Telmate/terraform-provider-proxmox/issues/132) and [here](https://github.com/Telmate/terraform-provider-proxmox/issues/700) and [here](https://github.com/Telmate/terraform-provider-proxmox/issues/704).
- Workaround: None, all workarounds inconsistent. Set `backup` to `false` in `disks` definition. Move cloud-init drive from ide0 to ide1. Re-run `terraform apply`.
