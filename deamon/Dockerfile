# syntax=docker/dockerfile:1
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Prague

RUN apt-get update && \
  apt-get install -y \
    cups \
    inotify-tools && \
  apt-get autoremove -y && \
  apt-get clean

RUN mkdir target
COPY bin/run bin/run

CMD service cups start && \
  lpadmin -p Zebra_Technologies_ZTC_ZP_505 \
    -v socket://192.168.1.5 \
    -E \
    -o Resolution=203dpi && \
  bin/run
