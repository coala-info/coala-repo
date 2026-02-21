---
name: sqt
description: sqtracker (sqt) is a modern, private BitTorrent tracker platform designed to be content-agnostic and highly customizable.
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

## Reference documentation
- [sqtracker Main Documentation](./references/github_com_tdjsnelling_sqtracker.md)
- [API Service Details](./references/github_com_tdjsnelling_sqtracker_tree_master_api.md)