docker buildx build --platform linux/amd64 -t mcp-demo -f Mcp.Dockerfile --load .
docker tag mcp-demo:latest mbcmvpconf.azurecr.io/mcp-demo:latest
docker push mbcmvpconf.azurecr.io/mcp-demo:latest