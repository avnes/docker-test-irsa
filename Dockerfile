FROM nginx:1.25.2

RUN apt update && \
    apt install awscli -y
