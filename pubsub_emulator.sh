#!/bin/bash

export PATH=$PATH:/google-cloud-sdk/bin

function configAndSimulate {
    /scripts/wait-for-it.sh -t 0 localhost:8085

    $(gcloud beta emulators pubsub env-init)

    python3 /python-api-pubsub-emulator/pubsub/cloud-client/publisher.py project-id create topic-name

    python3 /python-api-pubsub-emulator/pubsub/cloud-client/subscriber.py project-id create topic-name subscription-name

    python3 /python-api-pubsub-emulator/pubsub/cloud-client/custom_publisher.py project-id custom-publish topic-name 'message'
}

configAndSimulate&

gcloud  --quiet beta emulators pubsub start
