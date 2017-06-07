
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
	docker tag noddy-lite ${DOCKER_USERNAME}/noddy-lite
	docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
	docker push ${DOCKER_USERNAME}/noddy-lite
	docker logout
