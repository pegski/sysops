DATE = $(shell date)
TF_ENV = dev
TF_BUCKET = pegski-tfstate
PLANNED_STATE_FILE=/tmp/${TF_ENV}-planned.terraform

all: init get plan apply graph
restart: clean plan apply

init:
	@echo "Setting remote S3 state to ${TF_ENV}.tfstate"
	terraform remote config \
		-backend=s3 \
		-backend-config="bucket=${TF_BUCKET}" \
		-backend-config="key=${TF_ENV}.tfstate" \
		-backend-config="region=${TF_VAR_region}" \
		-backend-config="access_key=${TF_VAR_access_key}" \
		-backend-config="secret_key=${TF_VAR_secret_key}"

get:
	@echo "importing terraform modules"
	terraform get

plan: get
	terraform plan -out=${PLANNED_STATE_FILE}

apply:
	terraform apply ${PLANNED_STATE_FILE}

graph:
	terraform graph -module-depth=1 | dot -Tpng -o images/terraform-graph.png

show:
	terraform show

clean:
	terraform destroy
	rm -rf $(CURDIR)/.terraform
