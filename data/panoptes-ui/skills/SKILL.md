---
name: panoptes-ui
description: Panoptes-ui is a real-time monitoring tool that provides visibility into the status and execution of computational pipelines through a web interface and REST API. Use when user asks to monitor workflow execution, track job status, manage pipeline databases, or query workflow metadata via an API.
homepage: https://github.com/panoptes-organization/panoptes
---


# panoptes-ui

## Overview
Panoptes is a real-time monitoring tool designed to provide visibility into complex computational pipelines, particularly those used in bioinformatics and data science. It functions as a centralized service that tracks the status of individual jobs and overall workflow execution. By providing both a web-based UI and a structured REST API, it allows users to move beyond command-line logs to a more accessible overview of their data processing tasks.

## Installation and Setup

### Environment Preparation
It is recommended to use a virtual environment or a dedicated Conda environment to avoid dependency conflicts.

**Using Conda:**
```bash
conda create --name panoptes -c conda-forge -c bioconda panoptes-ui
conda activate panoptes
```

**Using Pip:**
```bash
pip install panoptes-ui
```

### Running the Server
The Panoptes server manages the monitoring database and serves the web interface.

*   **Development/Local Mode:** Simply run the command to start the server on `127.0.0.1:5000`.
    ```bash
    panoptes
    ```
*   **Production Mode (WSGI):** For better performance and stability, use a WSGI server like Gunicorn.
    ```bash
    gunicorn --timeout 120 --bind :5000 panoptes.app:app
    ```

## Database Management
Panoptes uses a SQLite database named `.panoptes.db` created in the directory where the server is launched.

*   **Persistence:** If running via Docker, ensure you mount a volume to the database path, otherwise, all monitoring history will be lost when the container stops.
*   **Cleanup:** You can wipe the entire monitoring history via the API or by deleting the `.panoptes.db` file when the server is offline.

## REST API Interaction
You can programmatically query or manage workflows using the following endpoints:

| Task | Method | Endpoint |
| :--- | :--- | :--- |
| Check Server Status | GET | `/api/service-info` |
| List All Workflows | GET | `/api/workflows` |
| Get Workflow Status | GET | `/api/workflow/<workflow-id>` |
| Get Job Details | GET | `/api/workflow/<workflow-id>/jobs` |
| Rename Workflow | PUT | `/api/workflow/<workflow-id>` |
| Delete Workflow | DELETE | `/api/workflow/<workflow-id>` |
| Clear Database | DELETE | `/api/workflows/all` |

## Containerized Deployment

### Docker
To run Panoptes without local installation:
```bash
docker pull quay.io/biocontainers/panoptes-ui:0.2.3--pyh7cba7a3_0
docker run -p 5000:5000 -it <image_id> panoptes
```

### Singularity
For HPC environments where Docker is restricted:
```bash
singularity pull docker://quay.io/biocontainers/panoptes-ui:0.2.3--pyh7cba7a3_0
singularity exec panoptes-ui_0.2.3.sif panoptes
```

## Expert Tips
*   **Port Conflicts:** If port 5000 is occupied (common on macOS), use a WSGI server to bind to a different port (e.g., `--bind :8080`).
*   **Workflow Identification:** Panoptes generates a unique UUID for every workflow session. Use the `/api/workflows` endpoint to retrieve these IDs for specific management tasks.
*   **Log Monitoring:** When running in production, always redirect Gunicorn logs to a file using `--access-logfile` and `--error-logfile` for troubleshooting.

## Reference documentation
- [Panoptes GitHub Repository](./references/github_com_panoptes-organization_panoptes.md)
- [Bioconda Panoptes-UI Overview](./references/anaconda_org_channels_bioconda_packages_panoptes-ui_overview.md)