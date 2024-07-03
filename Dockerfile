FROM nginx:1.27

RUN apt update && \
    apt install awscli less -y
