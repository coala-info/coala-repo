---
name: biom-format-tools
description: "The `biom-format-tools` skill provides procedures for transforming BIOM data between its two primary formats: the legacy JSON-based Version 1.0 and the modern HDF5-based Version 2.x."
homepage: https://github.com/molbiodiv/biom-conversion-server
---

# biom-format-tools

## Overview

The `biom-format-tools` skill provides procedures for transforming BIOM data between its two primary formats: the legacy JSON-based Version 1.0 and the modern HDF5-based Version 2.x. While the official Python `biom-format` package handles these operations, this skill focuses on the implementation and usage of the `biom-conversion-server`, which provides a web-based and API-driven interface for these conversions. This is ideal for environments where a lightweight, containerized conversion service is preferred over a full Python environment installation.

## Conversion Workflows

### Docker-Based Local Conversion
For rapid setup of a local conversion service without manual dependency management, use the official Docker container.

1.  **Deploy the Server**:
    ```bash
    docker pull iimog/biom-conversion-server
    docker run -d --publish 8080:80 --name biomcs iimog/biom-conversion-server
    ```
2.  **Access the Interface**: Navigate to `http://localhost:8080/` to use the web UI for manual file uploads and downloads.

### Programmatic API Conversion
The server provides a `convert.php` endpoint for automated workflows.

*   **Endpoint**: `http://<server-address>/convert.php`
*   **Data Requirements**:
    *   The server requires input data to be passed as a **Base64 encoded string**.
    *   The returned content is also a **Base64 encoded string**.
*   **Request Format**:
    *   Supports POST data passed as JSON.
    *   Ensure the `Content-Type` header is set correctly for JSON requests.
    *   The server supports Cross-Origin Resource Sharing (CORS) for web-based clients.

## Format Specifications

When performing conversions, identify the source and target formats based on the following:

*   **BIOM Version 1 (JSON)**: Best for smaller datasets and compatibility with older BioJS components or legacy bioinformatics pipelines.
*   **BIOM Version 2 (HDF5)**: The standard for modern, large-scale datasets. Requires HDF5 libraries.

## Expert Tips

*   **PHP Limits**: If converting exceptionally large BIOM files via the server, ensure the underlying PHP `memory_limit` and `post_max_size` are configured to accommodate the file size, as the conversion server is designed to handle these via increased limits in its default Docker configuration.
*   **Version Pinning**: This tool specifically utilizes `biom-format` version 2.1.6. Ensure compatibility if your downstream tools require features from later versions of the BIOM specification.
*   **Base64 Overhead**: Remember that Base64 encoding increases data size by approximately 33%. Account for this when calculating network transfer times or memory requirements for large HDF5 files.

## Reference documentation
- [biom-conversion-server README](./references/github_com_molbiodiv_biom-conversion-server.md)