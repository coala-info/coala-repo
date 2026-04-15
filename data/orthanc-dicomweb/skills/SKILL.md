---
name: orthanc-dicomweb
description: This tool manages a containerized Orthanc PACS environment for medical imaging storage, retrieval, and viewing. Use when user asks to start or stop the PACS stack, perform system health checks, query studies via DICOMweb, or configure remote modalities.
homepage: https://github.com/ThalesMMS/Orthanc-PACS
---

# orthanc-dicomweb

## Overview
This skill provides procedural knowledge for managing a containerized Orthanc PACS environment. It focuses on the ThalesMMS distribution, which integrates Orthanc Explorer 2, the OHIF viewer, and the DICOMweb plugin. Use this skill to perform system health checks, query imaging studies via REST/DICOMweb, and manage the lifecycle of the PACS service using Docker Compose.

## Service Management
The Orthanc-PACS stack is managed using Docker Compose. Ensure the Docker daemon is running before executing these commands.

- **Start the stack**: `docker compose up -d`
- **Check service status**: `docker compose ps`
- **View live logs**: `docker compose logs -f orthanc`
- **Stop and remove containers**: `docker compose down`
- **Wipe data and containers**: `docker compose down -v` (Warning: This deletes the SQLite database in `./orthanc-db`)

## Connectivity and Health Checks
Orthanc defaults to port 8042 for HTTP/REST and 4242 for DICOM (DIMSE).

- **System Health**: Verify the server is responding and check version/plugin info:
  `curl -u admin:admin http://localhost:8042/system`
- **DICOMweb Study List**: Retrieve a list of all studies via the DICOMweb plugin:
  `curl -u admin:admin http://localhost:8042/dicom-web/studies`
- **Web Interfaces**:
  - Orthanc Explorer 2: `http://localhost:8042/ui/app/`
  - OHIF Viewer: `http://localhost:8042/ohif/`

## DICOM Data Operations
Use standard DICOM toolkits (like dcmtk) to interact with the Orthanc DICOM port.

- **Send DICOM files (C-STORE)**:
  `storescu -aec ORTHANC localhost 4242 *.dcm`
- **Verify Connectivity (C-ECHO)**:
  `echoscu -aec ORTHANC localhost 4242`

## Configuration Best Practices
Configuration is primarily handled via `orthanc-config/orthanc.json`.

- **Changing Credentials**: Modify the `RegisteredUsers` section in `orthanc.json`. The default is `admin:admin`.
- **Adding Remote Modalities**: To allow Orthanc to send/receive from other scanners, add them to the `DicomModalities` dictionary:
  `"MODALITY_NAME": ["AE_TITLE", "IP_ADDRESS", PORT]`
- **Storage Optimization**: The stack has `StorageCompression` enabled by default to save disk space at the cost of CPU.
- **Overwriting Instances**: `OverwriteInstances` is set to `true` to allow re-importing the same SOP Instance UID (useful for re-compressed images).

## Troubleshooting
- **Port Conflicts**: If port 8042 or 4242 is in use, modify the `ports` mapping in the `docker-compose.yml` file.
- **Permission Issues**: Ensure the `./orthanc-db` directory is writable by the user running Docker.
- **Plugin Failures**: If DICOMweb or OHIF are not loading, check the logs for GDCM or Python plugin initialization errors.

## Reference documentation
- [Orthanc-PACS Main Guide](./references/github_com_ThalesMMS_Orthanc-PACS.md)
- [Configuration Highlights](./references/github_com_ThalesMMS_Orthanc-PACS_tree_main_orthanc-config.md)