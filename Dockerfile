FROM alpine:3.17.1

RUN apk add --update --no-cache python3 py3-pip jq git

RUN pip3 install -U pip setuptools  \
    git+https://github.com/psf/black@22.3.0 \
    git+https://github.com/timothycrosley/isort@5.12.0 \
    git+https://github.com/pycqa/flake8@5.0.4

ENV PATH=/scripts:$PATH

COPY ./configs /configs
COPY lint.sh /scripts/lint
