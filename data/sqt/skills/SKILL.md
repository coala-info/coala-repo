---
name: sqt
description: sqt is a private BitTorrent tracker platform for managing content-agnostic torrent distribution and services. Use when user asks to deploy the tracker using Docker, configure system settings in config.js, manage administrative credentials, or add new language localizations.
homepage: https://github.com/tdjsnelling/sqtracker
---

# sqt

## Overview
sqtracker (sqt) is a modern, private BitTorrent tracker platform designed to be content-agnostic and highly customizable. It operates as a distributed system comprising an API service, a web client, a MongoDB database, and an HTTP proxy. This skill provides the procedural knowledge required to initialize the tracker, manage its configuration via JavaScript, and ensure secure deployment in a production environment.

## Deployment and Lifecycle
The primary method for managing the sqt lifecycle is through Docker.

- **Initialization**: Deploy the full stack by running `docker compose up -d` from the project root.
- **Service Architecture**:
    - **API Service**: Handles BitTorrent specifications (announces/scrapes), authentication, and RSS.
    - **Client Service**: Provides the Next.js-based responsive web interface.
    - **Database**: Requires MongoDB version 5.2 or higher.
    - **Proxy**: Traefik is the default recommended proxy, though Nginx is supported.

## Configuration Management
All system behavior is governed by a single file: `config.js`.

- **Setup**: Copy `config.example.js` to `config.js` before starting the services.
- **Structure**: The file must export an object containing two primary keys:
    - `envs`: General environment settings (URLs, ports, feature flags).
    - `secrets`: Sensitive data (database URIs, session secrets, API keys).
- **Validation**: If the JavaScript object exported by `config.js` is malformed or missing required keys, the API service will fail to start.

## Initial Administrative Setup
- **Default Credentials**: On the first successful boot, the system creates a default user:
    - Username: `admin`
    - Password: `admin`
- **Security First Step**: Log in immediately and change the admin password.
- **Privileges**: The initial admin user is unique; it can send administrative invites and cannot be deleted or banned through the standard UI.

## Network and HTTPS Configuration
To enable production-ready HTTPS, specific values must be modified in the deployment files:

- **Traefik Setup**:
    - Update the `acme.email` field in the certificate resolver to a valid address for Let's Encrypt.
    - Update all `Host` rules to match your specific domain name.
- **Nginx Alternative**: If using the provided `nginx.conf`, ensure the service block in your deployment configuration is enabled and points to the correct upstream API and client ports.
- **Service Naming**: If you rename services in your deployment configuration, you must update the corresponding hostnames in `config.js` so the client and API can communicate.

## Localization Workflow
To add a new language to the tracker interface:

1. Create a new JSON file in `client/locales/` using the 2-character locale code (e.g., `fr.json`).
2. Use `en.json` as the base template for all translation strings.
3. Register the new locale in `client/locales/index.js` by importing the JSON file and adding it to the exported object.

## Expert Tips
- **Performance**: For high-traffic trackers, ensure the VPS has sufficient resources to handle concurrent BitTorrent announces, as the API service implements the tracker spec directly.
- **Search Discovery**: If you want the tracker to be discoverable by search engines, enable the option to browse torrents without logging in within the `envs` configuration.
- **Bonus System**: Configure the bonus point system early to encourage seeding; points can be used by members to purchase invites or upload credit.



## Subcommands

| Command | Description |
|---------|-------------|
| sqt align | Compare two strings |
| sqt bam2fastq | Extract all reads from a BAM file that map to a certain location, but try hard to extract them even if hard clipping is used. |
| sqt bameof | Check whether the EOF marker is present in BAM files. If it's not, this may be a sign that the BAM file was corrupted. |
| sqt chars | Print the number of characters in a string. |
| sqt cutvect | Remove vector sequence |
| sqt fastagrep | Search for a IUPAC string in the sequences of a FASTA file. |
| sqt fastxmod | Modify FASTA and FASTQ files by picking subsets and modifying individual entries. |
| sqt qgramfreq | Print q-gram (also called k-mer) frequencies in a FASTA or FASTQ file. |
| sqt readcov | Print a report for individual reads in a SAM/BAM file. |
| sqt readlen histo | Print and optionally plot a read length histogram of one or more FASTA or FASTQ files. If more than one file is given, a total is also printed. |
| sqt samsetop | Perform set operation on two SAM/BAM files. |
| sqt_randomseq | Generate random sequences in FASTA format |

## Reference documentation
- [sqtracker Main Documentation](./references/github_com_tdjsnelling_sqtracker.md)
- [API Service Details](./references/github_com_tdjsnelling_sqtracker_tree_master_api.md)