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
    --publish 5000:5000 \
    --restart=always \
    --name registry \
    registry:2.8.1
fi
