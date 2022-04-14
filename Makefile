TAG=latest
PROJECT_NAME=oscwebmixer
REGISTRY_IMAGE=clarkrochon/$(PROJECT_NAME):$(TAG)


push:  ## Push the application Docker image to registry
	$(call msg,"Publishing application Docker image")
	docker push $(REGISTRY_IMAGE)

build:
	@docker build --pull -t $(REGISTRY_IMAGE) -f Dockerfile .

run: rm  ## Run the application Docker container
	$(call msg,"Starting application Docker container")
	@docker run -d \
			-v /home/pi/default.json:/srv/OSCWebMixer/config/default.json \
			--restart always \
			-p 8081:8081 \
			--name $(PROJECT_NAME) \
			$(REGISTRY_IMAGE)

rm:  ## Remove the application Docker container
	$(call msg,"Removing application Docker container")
	@docker rm -f $(PROJECT_NAME) || true


enter:
	docker exec -it $(PROJECT_NAME) sh
