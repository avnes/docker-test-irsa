FROM nginx:stable

RUN apt update && \
    apt install awscli -y
