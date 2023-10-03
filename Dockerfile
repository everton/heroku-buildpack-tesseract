ARG BASE_IMAGE
FROM $BASE_IMAGE

ARG STACK

RUN useradd -m -d /app non-root-user
RUN mkdir -p /app /cache /env
RUN chown non-root-user /app /cache /env
USER non-root-user

COPY --chown=non-root-user . /buildpack
WORKDIR /app

RUN env -i PATH=$PATH HOME=$HOME STACK=$STACK /buildpack/bin/detect /app
RUN env -i PATH=$PATH HOME=$HOME STACK=$STACK /buildpack/bin/compile /app /cache /env
