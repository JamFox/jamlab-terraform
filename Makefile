# Optional environment variables:
# TF_LOG: Set to TRACE, DEBUG, INFO, WARN or ERROR
# TF_LOG_PATH: Set to a file path to write log messages to a file

all: plan

plan:
	terraform init
	terraform plan

apply:
	terraform init
	terraform apply

os-migration:
	terraform init
	terraform apply -target=module.os-migration

destroy:
	terraform destroy

clean:
	rm -rf .terraform
	rm -rf .terraform.lock.hcl
	rm -rf terraform.tfstate.backup
	rm -rf terraform.tfstate
	rm -rf plan.tfplan
	rm -rf destroy.tfdestroy
