FROM openjdk:9-jdk-slim as base

RUN apt-get update && \
    apt-get install --no-install-recommends -y -qq ca-certificates-java
COPY certificates /usr/local/share/ca-certificates/certificates

ARG CERTNAME=gus
ARG STOREPASS=changeit
RUN update-ca-certificates && \
    echo "yes" | keytool -import -v -trustcacerts -alias "self-signed-cert" \
        -file /usr/local/share/ca-certificates/certificates/${CERTNAME}.crt \
        -storepass ${STOREPASS}

FROM openjdk:9-jdk-slim
RUN groupadd --gid 1000 java && \
    useradd --uid 1000 --gid java --shell /bin/bash --create-home java && \
    chmod -R a+w /home/java
WORKDIR /home/java
COPY --from=base /etc/ssl/certs /etc/ssl/certs
COPY --from=base /etc/default/cacerts /etc/default/cacerts
COPY --from=base --chown=1000:1000 /root/.keystore .
USER java

ARG STOREPASS
ENV STOREPASS ${STOREPASS}
CMD keytool -list -v -storepass ${STOREPASS}
