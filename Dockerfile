FROM nginx:1.26.0

RUN apt update && \
    apt install awscli less -y
