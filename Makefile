#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#

NS              ?= infra-monitoring
SERVICE_NAME    ?= prometheus
SERVICE_PORT    ?= 80
export

all:        help
## Install all resources
install:                prometheus-install exporter-install sizemetrics-install statemetrics-install
## Delete all resources
delete:                 prometheus-delete exporter-delete sizemetrics-delete statemetrics-delete
## Install Prometheus
prometheus-install:     install-prometheus-configmap install-prometheus-rbac install-prometheus-rules install-prometheus-deployment install-prometheus-service
## Delete Prometheus
prometheus-delete:      delete-prometheus-configmap delete-prometheus-rbac delete-prometheus-rules delete-prometheus-deployment delete-prometheus-service
## Install Node Exporter
exporter-install:       install-exporter-daemonset install-exporter-service
## Delete Node Exporter
exporter-delete:        delete-exporter-daemonset delete-exporter-service
## Install kube-size-metrics
sizemetrics-install:    install-sizemetrics-daemonset
## Delete kube-size-metrics
sizemetrics-delete:     delete-sizemetrics-daemonset
## Install kube-state-metrics
statemetrics-install:   install-statemetrics-rbac install-statemetrics-deployment install-statemetrics-service
## Delete kube-state-metrics
statemetrics-delete:    delete-statemetrics-rbac delete-statemetrics-deployment delete-statemetrics-service
####################################

install-%:

	@envsubst < manifests/$*.yaml | kubectl --namespace $(NS) apply -f -

delete-%:

	@envsubst < manifests/$*.yaml | kubectl --namespace $(NS) delete --ignore-not-found -f -

dump-%:

	envsubst < manifests/$*.yaml

#
# Help Outputs
GREEN  		:= $(shell tput -Txterm setaf 2)
YELLOW 		:= $(shell tput -Txterm setaf 3)
WHITE  		:= $(shell tput -Txterm setaf 7)
RESET  		:= $(shell tput -Txterm sgr0)
help:

	@echo "\nUsage:\n\n  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}\n\nTargets:\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-20s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@echo
