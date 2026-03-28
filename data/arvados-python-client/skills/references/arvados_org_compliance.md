* [Skip to primary navigation](#nav-primary)
* [Skip to main content](#main)
* [Skip to footer](#site-footer)

* [Home](/)
* About
  + [Technology](/technology)
  + [Regulatory Compliance](/compliance)
  + [Standards](/standards)
  + [Releases](/releases)
* Development
  + [Developer Site](https://dev.arvados.org/)
  + [GitHub](https://github.com/arvados/arvados)
* [Community](/community)
* [Documentation](https://doc.arvados.org/)
* [Blog](/blog)

[![Arvados Logo](/images/arvados/logo.png)](/)

[![Arvados Logo](/images/arvados/logo.png)](/)

* [Home](/)
* About
  + [Technology](/technology)
  + [Regulatory Compliance](/compliance)
  + [Standards](/standards)
  + [Releases](/releases)
* Development
  + [Developer Site](https://dev.arvados.org/)
  + [GitHub](https://github.com/arvados/arvados)
* [Community](/community)
* [Documentation](https://doc.arvados.org/)
* [Blog](/blog)

# Arvados in Regulated Environments

A properly configured and secured Arvados deployment should comply
with [HIPAA Security and Privacy standards](https://www.hhs.gov/sites/default/files/ocr/privacy/hipaa/administrative/combined/hipaa-simplification-201303.pdf)
§164.312 Technical safeguards. Along with proper Administrative and
Physical safeguards, Arvados may be used as a component in building systems
that are compliant with HIPAA, GxP, and other regulatory regimes.

## Access Control

### i. Unique user identification

Arvados is a [multi-user system](https://doc.arvados.org/v2.1/admin/user-management.html).
Each user accessing protected data is given a separate account. Every
access (API call) to the system must provide a [valid access token that identifies the user](https://doc.arvados.org/v2.1/api/tokens.html).

### ii. Emergency access procedure

All data uploaded to Arvados is private by default. However, in an
emergency, system administrators can access protected data in
accordance with organizational processes and procedures.

### iii. Automatic logoff

Arvados can be configured so that [idle user sessions automatically log off, and that all access tokens automatically expire](https://doc.arvados.org/main/admin/token-expiration-policy.html).

### iv. Encryption and decryption

Arvados achieves encryption at rest by being deployed on top of [whole disk encryption](https://en.wikipedia.org/wiki/Dm-crypt)
and/or utilizing [encrypted cloud buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/default-bucket-encryption.html).

## Audit Controls

Each access to the system is [recorded in a log, with an associated request id](https://doc.arvados.org/v2.1/admin/logging.html).
A “logs” table records [changes to the system](https://doc.arvados.org/main/admin/logs-table-management.html), and
[collection versioning](https://doc.arvados.org/main/admin/collection-versioning.html)
provides a history of changes to a given data set.

## Data Integrity

Use of [immutable, hash-based identifiers](https://doc.arvados.org/main/architecture/storage.html)
for data sets enables the receiver to verify that the data requested
is the data returned. [Collection versioning](https://doc.arvados.org/main/admin/collection-versioning.html)
provides a history of changes to a given data set.

## Authentication

Arvados integrates with [various enterprise authentication mechanisms](https://doc.arvados.org/main/install/setup-login.html),
including LDAP and OpenID Connect, to verify the identity of a user.

## Transmission Security

Arvados uses industry standard TLS to encrypt all data in transit.
Use of [immutable, hash-based identifiers](https://doc.arvados.org/main/architecture/storage.html)
for data sets enables the receiver to verify that the data was not modified in transit.

## Arvados

* [About](/about/)
* [Development](https://github.com/arvados/arvados)
* [Community](/community/)
* [Documentation](https://doc.arvados.org/)
* [Blog](/blog/)

[![Link to Arvados Github](/images/social/github.svg "Github icon")](https://github.com/arvados/arvados)
[![Link to Arvados Twitter](/images/social/twitter.svg "Twitter icon")](https://twitter.com/arvados)

©2024 Arvados Project. Unless otherwise noted, site content licensed under Creative Commons Attribution-ShareAlike 4.0 International licensed.

[Privacy Policy](/privacy)