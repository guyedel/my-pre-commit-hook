FROM alpine:3.17.1

RUN apk add --update --no-cache python3 py3-pip jq git

RUN pip3 install -U pip setuptools

COPY ./reqs_for_setup.txt /reqs_for_setup.txt
RUN pip3 install -r /reqs_for_setup.txt

ENV PATH=/scripts:$PATH

COPY ./configs /configs
COPY lint.sh /scripts/lint
