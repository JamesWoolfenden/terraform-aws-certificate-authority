#Makefile
AWS_ACCOUNT ?= "10000000"
AWS_ROLE ?= "Jenkins-Local-Admin"
KEY ?= "id_rsa.JIM_mgn"

.PHONY: all

all: init plan build

init:
	rm -rf .terraform/modules/
	terraform init -reconfigure

plan: init
	terraform plan -refresh=true

build: init
	terraform apply -auto-approve

check: init
	terraform plan -detailed-exitcode

destroy: init
	terraform destroy -force

docs:
	terraform-docs md . > README.md

valid:
	tflint
	terraform fmt -check=true -diff=true
