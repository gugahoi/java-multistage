# java-multistage

- Convert the original Dockerfile into a multistage build Dockerfile.
- Optimise Dockerfile for caching benefits.
- Ensure the SSL trust store & JKS are in the final image.

To verify the outcome of the excercise, build and run the image:

```bash
> docker build -t gugahoi/java-multistage
> docker run -it --rm gugahoi/java-multistage
Keystore type: PKCS12
Keystore provider: SUN

Your keystore contains 1 entry

Alias name: gus-cert
Creation date: Feb 26, 2019
Entry type: trustedCertEntry

Owner: C=AU, O=Momenton., CN=www.gustavo.momenton
Issuer: C=AU, O=Momenton., CN=www.gustavo.momenton
Serial number: ee5809582074b510
Valid from: Tue Feb 26 04:23:16 UTC 2019 until: Wed Feb 26 04:23:16 UTC 2020
Certificate fingerprints:
	 SHA1: BF:AF:06:0A:D7:12:D3:2D:AB:69:76:AA:0E:49:ED:DA:9D:FE:1A:A5
	 SHA256: 72:FF:3C:F8:15:83:B3:06:09:05:1F:C8:D3:EA:28:20:12:23:19:40:77:4B:63:6F:97:5A:10:C2:F3:83:FA:7B
Signature algorithm name: SHA256withRSA
Subject Public Key Algorithm: 2048-bit RSA key
Version: 1


*******************************************
*******************************************
```

## Build parameters

There are 2 parameters that can be used when building the image:

- `STOREPASS`: this is the password to the JKS trust store.
- `CERTNAME`: this is the filename for the cert to add to the JKS trust store.
  - When multiple files are present, only the one specified in this build arg will be added to the JKS, although all will be added to the system store.

For example:

To set the trust store password to `my-new-password`

```bash
docker build --build-arg STOREPASS=my-new-password -t foo .
```

To add a different cert called `my-new-cert` to the store (it must have been created previously):

```bash
docker build --build-arg CERTNAME=my-new-cert -t foo .
```

## Helper script

I have taken the liberty to create a helper script to generate self-signed certificates out of band.
It can be found in the root of the project as `./generate-certificate.sh` and usage instructions are
at the top of the file.
