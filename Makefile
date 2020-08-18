VERSION=0.0.0
IMAGE_NAME=sgryczan/trident-installer

.PHONY: build
build:
	operator-sdk build $(IMAGE_NAME):$(VERSION)

.PHONY: push
push:
	docker push $(IMAGE_NAME):$(VERSION)

.PHONY: deploy
deploy:
	kubectl apply -f deploy/crds/tridentinstall.czan.io_tridentinstallations_crd.yaml
	kubectl apply -f deploy/crds/tridentinstall.czan.io_v1alpha1_tridentinstallation_cr.yaml
	kubectl apply -f deploy/operator.yaml
	kubectl apply -f deploy/role.yaml
	kubectl apply -f deploy/role_binding.yaml
	kubectl apply -f deploy/service_account.yaml

.PHONY: destroy
destroy:
	kubectl delete -f deploy/crds/tridentinstall.czan.io_v1alpha1_tridentinstallation_cr.yaml
	kubectl delete -f deploy/operator.yaml
	kubectl delete -f deploy/role.yaml
	kubectl delete -f deploy/role_binding.yaml
	kubectl delete -f deploy/service_account.yaml
