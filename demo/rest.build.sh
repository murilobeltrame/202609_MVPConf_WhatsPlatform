docker buildx build --platform linux/amd64 -t rest-demo -f Rest.Dockerfile --load .
docker tag rest-demo:latest mbcmvpconf.azurecr.io/rest-demo:latest
docker push mbcmvpconf.azurecr.io/rest-demo:latest