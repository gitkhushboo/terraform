FROM ubuntu:20.04
MAINTAINER khushboo
RUN apt-get update
RUN mkdir /testData

WORKDIR /testData
RUN touch t1 t2 t3

RUN echo "This is 1st DockerFile"
COPY testFile .
EXPOSE 8080
