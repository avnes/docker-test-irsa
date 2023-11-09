FROM nginx:1.25.3

RUN apt update && \
    apt install awscli less -y
