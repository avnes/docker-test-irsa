FROM nginx:1.23

RUN apt update && \
    apt install awscli -y
