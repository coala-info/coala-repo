---
name: orthanc-dev
description: The orthanc-dev tool manages a containerized Orthanc DICOM server environment integrated with a Radiology Information System and secure Nginx reverse proxy. Use when user asks to generate TLS certificates, deploy the Docker Compose stack, manage MySQL and Postgres databases, or configure Modality Worklists for medical imaging.
homepage: https://github.com/hieutnbk2011/Orthanc-Docker-DEV_RIS
---


# orthanc-dev

## Overview
The orthanc-dev skill provides a procedural framework for managing a containerized Orthanc DICOM server environment integrated with a Radiology Information System (RIS). It streamlines the setup of a complex stack involving Nginx reverse proxies with TLS, Python-enhanced Orthanc instances, and multi-database backends (MySQL for RIS and Postgres for Orthanc indexing). This skill is essential for developers building medical imaging applications that require Modality Worklist (MWL) support, custom Python scripting for DICOM processing, and secure web-based access to imaging data.

## Core Workflows

### 1. Security and TLS Initialization
Before starting the containers, you must generate and distribute self-signed certificates to ensure the Nginx reverse proxy functions correctly.

*   **Generate Certificates**: Navigate to the `tls` directory and execute the generation script.
    ```bash
    cd tls
    ./generate-tls.sh
    ```
*   **Distribute Certificates**: Copy the generated keys to the appropriate Docker volumes.
    ```bash
    ./copy-tls-to-docker-volumes.sh
    ```
    *Note: If Nginx fails to start or reports SSL errors, re-run the copy script to ensure volumes are correctly populated.*

### 2. Environment Deployment
The environment uses Docker Compose to orchestrate multiple services.

*   **Initial Build and Start**: Run from the project root to build custom images (including Python modules and PHP extensions).
    ```bash
    docker-compose up --build
    ```
*   **Service Verification**: Ensure the `pacs-1` (Orthanc) and `nginx` containers are healthy to allow traffic through the `/pacs-1/` and `/api/` routes.

### 3. Database Access and Management
The stack utilizes two distinct database engines.

*   **MySQL (RIS/Laravel)**: Accessible on the host at `127.0.0.1:3333`.
    *   Credentials: `root` / `root`
*   **Postgres (Orthanc Index)**: Accessible on the host at port `5555`.
*   **Initialization**: SQL scripts located in `mysql_init/init.sql` are automatically executed on the first volume creation to set up the required schemas.

### 4. Orthanc and API Interaction
*   **Web Interface**: Access the Orthanc Explorer via `https://nginx-tls.medical.ky/pacs-1/app/explorer.html`.
*   **Internal API**: From within the Docker network (e.g., from the PHP-FPM container), use `http://pacs-1:8042/`.
*   **External API**: Use the Nginx proxy route `https://nginx-tls.medical.ky/api/`.

### 5. Modality Worklist (MWL) Configuration
*   **File Storage**: MWL files (.wl) should be placed in the `MWLFiles` directory on the host.
*   **Mapping**: These are automatically mapped to `/var/lib/orthanc/worklists` inside the `pacs-1` container for Orthanc to serve to modalities.

## Best Practices
*   **Python Scripting**: Custom logic for PDF creation and pagination is located in the `pacs-1` directory. When modifying these scripts, restart the `pacs-1` container to apply changes.
*   **Domain Mapping**: Ensure your host's `/etc/hosts` file maps `nginx-tls.medical.ky` and `uploader.medical.ky` to `127.0.0.1` to match the Nginx `server_name` configurations.
*   **Authentication**: By default, remote access is allowed and internal Orthanc authentication may be disabled to favor Nginx-level or Python-plugin authorization. Always verify the `nginx/default.conf` for active `http_auth_request` hooks.

## Reference documentation
- [Orthanc-Docker-DEV_RIS Main Documentation](./references/github_com_hieutnbk2011_Orthanc-Docker-DEV_RIS.md)