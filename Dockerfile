FROM nginx:1.27-alpine

ENV PGSSLROOTCERT=/etc/ssl/certs/ca-certificates.crt
ENV PGSSLMODE=verify-full

RUN apk update && \
apk add aws-cli less postgresql14-client ca-certificates && rm -rf /var/cache/apk/* \
&& wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -O /tmp/rds-combined-ca-bundle.pem \
&& mv /tmp/rds-combined-ca-bundle.pem /usr/local/share/ca-certificates/rds-combined-ca-bundle.crt \
&& update-ca-certificates
