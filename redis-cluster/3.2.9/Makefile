build: cmd_build docker_build

clean-build: clean cmd_build docker_build

cmd_build:
	GOOS=linux GOARCH=amd64 go build -o cluster main.go

docker_build:
	docker build -t hirokazumiyaji/redis-cluster:3.2.9 .

clean:
	rm cluster
