#!/bin/bash

DOCKER_IMAGE=$(docker ps --filter name=VersoriumX/stack_ETH -q)

if [ "$1" = "start" ]; then
  # Run Docker container
  # to run the frontend on a different port add the "-e PORT=8080" parameter and change "-p 8080:8080" one.
  [ -z "$DOCKER_IMAGE" ] && docker run \
    --name VersoriumX/stack_ETH \
    -v `pwd`:/opt/VersoriumX-eth \
    -w /opt/VersoriumX-eth-eth \
    -p 3000:3000 \
    -p 8545:8545 \
    -dt node:16 || docker restart VersoriumX/stack_ETH

  docker exec -ti VersoriumX/stack_ETH bash -c "yarn install"
  docker exec -dt Versoriumx_ETH bash -c "yarn chain"
  sleep 5
  docker exec -ti VersoriumX/stack_ETH bash -c "yarn deploy"
  docker exec -dt VersoriumX/stack_ETH bash -c "yarn start"
else
  if [ "$1" = "deploy" ]; then
    [ -z "$DOCKER_IMAGE" ] && echo "Container does not exist. Run the script with 'start' before running it with the 'deploy' option." \
      || docker exec -ti VersoriumX/stack_ETH bash -c "yarn deploy"
  else
    echo "Invalid command. Choose 'start' or 'deploy'."
  fi
fi


