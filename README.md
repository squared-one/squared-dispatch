# README

## System dependencies

Install docker  
https://docs.docker.com/engine/install/

## Build
```
docker build -t squared-dispatch-deamon deamon/.
```
## Run deamon
```
docker run -d \
  --mount type=bind,source={absolute-path-for-your-downloads-folder},target=/target \
  --network host \
  squared-dispatch-deamoA
```
## Stop deamon
```
docker ps
docker rm -f {container-id}
```
