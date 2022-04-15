# https://docs.docker.com/registry/deploying/#run-a-local-registry
status=$(docker container inspect registry --format "{{.State.Status}}" 2> /dev/null)
if [ $? -eq 0 ]
then
  if [ $status != 'running' ]
  then
    docker start registry
  fi
else
  docker run \
    --detach \
    --publish 80:5000 \
    --restart=always \
    --name registry \
    --mount type=volume,source=registry,destination=/var/lib/registry \
    registry:2.8.1
fi
