NODDY_LITE_NUM_REPLICAS=0

# phat runtime container with in-container build step.
# https://hub.docker.com/_/golang/

docker-build-phat:
	docker build -f ./docker/phat/Dockerfile -t noddy-phat .

docker-run-phat: docker-build-phat
	docker run --name noddy-phat -p 8080:8080 -d noddy-phat

# build linux self contained executable
# https://blog.codeship.com/building-minimal-docker-containers-for-go-applications/

clean-lite:
	rm -f noddy-lite

go-build-lite: clean-lite
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o noddy-lite .

docker-build-lite: go-build-lite
	docker build -f ./docker/lite/Dockerfile -t noddy-lite .

docker-run-lite: docker-build-lite
	docker run --name noddy-lite -p 8081:8080 -d noddy-lite

docker-push-lite: docker-build-lite
	docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
	docker tag noddy-lite ${DOCKER_USERNAME}/noddy-lite
	docker push ${DOCKER_USERNAME}/noddy-lite
	docker logout

k8s-deploy-noddy-lite:
	# create a noddy-lite replication controller
	kubectl run noddy-lite --image=templecloud/noddy-lite --port=8080 --generator=run/v1
	kubectl expose rc noddy-lite --type=LoadBalancer --name noddy-lite-http

k8s-scale-noddy-lite:
	kubectl scale rc noddy-lite --replicas=${NODDY_LITE_NUM_REPLICAS}
