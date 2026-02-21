---
name: orthanc
description: Orthanc is an open-source DICOM server designed to provide a simple yet powerful standalone Vendor Neutral Archive.
homepage: https://github.com/jodogne/OrthancDocker
---

# orthanc

## Overview
Orthanc is an open-source DICOM server designed to provide a simple yet powerful standalone Vendor Neutral Archive. It features a RESTful API that allows for easy integration with web applications and automated workflows. This skill focuses on the deployment and management of Orthanc via Docker, utilizing various specialized images to support plugins like DICOMweb, PostgreSQL, and Python scripting for medical imaging data management.

## Docker Image Selection
Choose the appropriate image based on the required feature set:

- **jodogne/orthanc**: Core version. Best for lightweight research or development where plugins are not required.
- **jodogne/orthanc-plugins**: Includes essential plugins (Web viewer, PostgreSQL, DICOMweb, Whole-slide imaging). Recommended for production-like environments.
- **jodogne/orthanc-python**: Includes the Python interpreter (3.11+). Use this when custom logic or automation scripts are needed within the Orthanc environment.

## Common Docker Patterns

### Basic Deployment
Run a standard instance with the default Orthanc Explorer interface:
```bash
docker run -p 4242:4242 -p 8042:8042 --name orthanc jodogne/orthanc-plugins
```

### Persistent Storage
To ensure DICOM data and the SQLite database persist across container restarts, mount a local directory to `/var/lib/orthanc/db`:
```bash
docker run -p 4242:4242 -p 8042:8042 \
  -v /path/to/local/storage:/var/lib/orthanc/db \
  jodogne/orthanc-plugins
```

### Custom Configuration
Orthanc looks for configuration files in `/etc/orthanc/`. You can mount a custom configuration directory:
```bash
docker run -p 4242:4242 -p 8042:8042 \
  -v /path/to/orthanc.json:/etc/orthanc/orthanc.json:ro \
  jodogne/orthanc-plugins
```

## Plugin Management
Orthanc supports a wide array of plugins for extended functionality. Key plugins available in the `orthanc-plugins` image include:

- **DICOMweb**: Enables WADO-RS, STOW-RS, and QIDO-RS protocols.
- **PostgreSQL**: Replaces the default SQLite engine for high-concurrency production use.
- **OHIF/Orthanc Explorer 2**: Modern web-based viewers for medical images.
- **Cloud Storage**: Support for AWS S3 and other object storage via specific plugins.

## Expert Tips
- **Memory Optimization**: For Python-heavy workloads, the environment variable `MALLOC_ARENA_MAX` can be tuned (e.g., set to `5`) to manage memory fragmentation.
- **Default UI**: Recent versions of the Docker images default to "Orthanc Explorer" as the user interface.
- **Debugging**: Use the `jodogne/orthanc-debug` image if you need to troubleshoot crashes or performance issues with symbols enabled.
- **WASM Builder**: For developers creating web-based viewers or tools, the `wasm-builder` resource in the repository provides a specialized environment for WebAssembly compilation.

## Reference documentation
- [Orthanc for Docker Overview](./references/github_com_jodogne_OrthancDocker.md)
- [Commit History and Feature Updates](./references/github_com_jodogne_Commits_master.md)