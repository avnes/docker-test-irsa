FROM nginx:1.27-alpine

RUN apk update && \
apk add aws-cli less postgresql14-client
