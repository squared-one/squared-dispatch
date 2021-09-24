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

ARG FEDEX_PRINTER_IP
ENV FEDEX_PRINTER_IP=$FEDEX_PRINTER_IP

ARG DEFAULT_PRINTER_IP
ENV DEFAULT_PRINTER_IP=$DEFAULT_PRINTER_IP

CMD bin/run
