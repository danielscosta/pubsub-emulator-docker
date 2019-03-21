FROM openjdk:8-jre-alpine

RUN apk add --update bash && rm -rf /var/cache/apk/*

RUN apk --no-cache add python3 python3-dev py-crcmod libc6-compat git curl build-base

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

RUN python3 get-pip.py

RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-239.0.0-linux-x86_64.tar.gz

RUN tar xzf google-cloud-sdk-239.0.0-linux-x86_64.tar.gz -C /

RUN rm -f google-cloud-sdk-239.0.0-linux-x86_64.tar.gz

RUN export CLOUDSDK_CORE_DISABLE_PROMPTS=1

RUN /google-cloud-sdk/install.sh

RUN mkdir /python-api-pubsub-emulator

RUN git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git /python-api-pubsub-emulator

RUN cd /python-api-pubsub-emulator/pubsub/cloud-client/ && pip install -r requirements.txt

RUN /google-cloud-sdk/bin/gcloud --quiet components install pubsub-emulator

RUN /google-cloud-sdk/bin/gcloud --quiet components update
