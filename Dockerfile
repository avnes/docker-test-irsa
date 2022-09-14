FROM nginx:1.22

RUN apt update && \
    apt install awscli -y
