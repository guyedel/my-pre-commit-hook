FROM ubuntu:23.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        jq \
        git \
        python3.10  \
        python3-pip && \
    apt-get clean

COPY ./reqs_for_setup.txt /reqs_for_setup.txt

RUN pip install -U pip
RUN pip install -r /reqs_for_setup.txt

ENV PATH=/scripts:$PATH

COPY ./configs /configs
COPY lint.sh /scripts/lint
