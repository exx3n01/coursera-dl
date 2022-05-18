FROM ubuntu:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles

RUN apt-get -qq update --fix-missing 

RUN apt-get -qq install -y git wget curl busybox python3 python3-pip locales ffmpeg p7zip-full p7zip-rar

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc g++ libssl-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove gcc g++ libssl-dev

ARG VERSION

RUN pip install coursera-dl==$VERSION | bash

COPY requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

WORKDIR /courses
ENTRYPOINT ["coursera-dl"]
CMD ["bash","start.sh","--help"]
