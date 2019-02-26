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

