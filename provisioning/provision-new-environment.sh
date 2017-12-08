#!/bin/bash


if [ -z "$GIT_COMMIT" ];
then
    export GIT_COMMIT='d80bb4f3507f36d0fac5de7766a4a9339db9002f'
fi


source ./create-aws-docker-host-instance.sh
source ./update-env.sh ${INSTANCE_PUBLIC_NAME}

echo New environment provisioned
