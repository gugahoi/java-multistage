FROM openjdk:9-jdk-slim as base
RUN apt-get update && \
    apt-get install --no-install-recommends -y -qq ca-certificates-java
COPY certificates /usr/local/share/ca-certificates/certificates
RUN update-ca-certificates && \
    echo "yes" | keytool -import -v -trustcacerts -alias "gus-cert" \
        -file /usr/local/share/ca-certificates/certificates/gus.crt \
        -storepass "some-secret-pass"

FROM openjdk:9-jdk-slim
RUN groupadd --gid 1000 java &&\
    useradd --uid 1000 --gid java --shell /bin/bash --create-home java && \
    chmod -R a+w /home/java
WORKDIR /home/java
USER java
COPY --from=base /etc/ssl/certs /etc/ssl/certs
COPY --from=base /etc/default/cacerts /etc/default/cacerts
COPY --from=base --chown=1000:1000 /root/.keystore .
CMD keytool -list -v -storepass "some-secret-pass"
