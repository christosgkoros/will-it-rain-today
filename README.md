# will it rain app
```
version 0.1.0
```

## Build docker image
```
docker build -t meldon/willitrain .
```
## Run via docker
```
docker run -d --rm -p8000:8000 meldon/willitrain
```

Other the R plumber api and the client-browser frontend application can be independently build/packaged and deployed
