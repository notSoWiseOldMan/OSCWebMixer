TAG=latest
PROJECT_NAME=osc-web-mixer
REGISTRY_IMAGE=$(PROJECT_NAME):$(TAG)


push:  ## Push the application Docker image to registry
	$(call msg,"Publishing application Docker image")
	docker push $(REGISTRY_IMAGE)

build:
	@docker build --pull -t $(REGISTRY_IMAGE) -f Dockerfile .

run: rm  ## Run the application Docker container
	$(call msg,"Starting application Docker container")
	@docker run -d \
			--restart always \
			--name $(PROJECT_NAME) \
			$(REGISTRY_IMAGE)

rm:  ## Remove the application Docker container
	$(call msg,"Removing application Docker container")
	@docker rm -f $(PROJECT_NAME) || true


enter:
	docker exec -it $(PROJECT_NAME) sh
