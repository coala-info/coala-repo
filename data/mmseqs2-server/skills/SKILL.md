---
name: mmseqs2-server
description: The mmseqs2-server (part of the MMseqs2-App ecosystem) provides a graphical interface and API for interactive exploration of massive sequence and structure datasets.
homepage: https://github.com/soedinglab/MMseqs2-App
---

# mmseqs2-server

## Overview

The mmseqs2-server (part of the MMseqs2-App ecosystem) provides a graphical interface and API for interactive exploration of massive sequence and structure datasets. It acts as a wrapper for MMseqs2, Foldseek, FoldMason, and ColabFold, allowing researchers to host their own search instances on workstations or servers. Use this skill to handle the deployment of the web server, the initialization of search databases (like PDB or Uniclust), and the configuration of the backend environment.

## Deployment and Setup

### Docker-Compose Workflow (Recommended)
The most reliable way to deploy the server is via the provided Docker recipes.

1.  **Initialize the environment**:
    ```bash
    git clone https://github.com/soedinglab/MMseqs2-App.git
    cd MMseqs2-App/docker-compose
    ```

2.  **Configure the application**:
    Edit the `.env` file to define the application type and port.
    *   `APP=mmseqs` (for sequence/profile search)
    *   `APP=foldseek` (for structure search)
    *   `PORT=8877` (default)

3.  **Database Setup**:
    Use the `db-setup` utility to manage search targets.
    *   **List available databases**: `docker-compose run db-setup`
    *   **Download a specific database (e.g., PDB)**: `docker-compose run db-setup PDB`
    *   **Download Uniclust**: `docker-compose run db-setup Uniclust30`

4.  **Launch the server**:
    ```bash
    docker-compose up -d
    ```
    Access the interface at `http://localhost:8877`.

### Conda Installation
For environments where Docker is unavailable, install the server component directly:
```bash
conda install -c bioconda mmseqs2-server
```

## Database Management

### Adding Custom Databases
To add your own data for searching, use the Settings panel in the web interface or manually prepare files:
*   **Sequence Databases**: Provide files in FASTA format.
*   **Profile Databases**: Provide files in Stockholm format (e.g., PFAM).
*   **Structure Databases**: Ensure structures are in PDB or mmCIF format for Foldseek.

### Storage Considerations
MMseqs2-server requires significant disk space for indices. Ensure the volume mapped in `docker-compose.yml` has sufficient quota, especially when downloading large datasets like UniRef or the full PDB.

## Expert Tips and Troubleshooting

*   **Switching Search Modes**: If you need to switch from sequence search (MMseqs2) to structure search (Foldseek), you must update the `APP` variable in the `.env` file and restart the containers (`docker-compose down && docker-compose up -d`).
*   **Job Status "PENDING"**: If jobs remain in a pending state, check the backend logs using `docker-compose logs -f backend`. This is often caused by insufficient memory (RAM) to load the database index or a mismatch between the database type and the selected search mode.
*   **Hardware Optimization**: For production servers, ensure high I/O throughput (SSD) for database directories, as MMseqs2 performance is heavily dependent on disk read speeds during the initial search phases.
*   **API Access**: The server exposes a REST API. You can programmatically submit jobs to the backend. Refer to the internal `/api` documentation endpoint once the server is running for specific schema details.

## Reference documentation
- [MMseqs2-App Overview](./references/github_com_soedinglab_MMseqs2-App.md)
- [Bioconda mmseqs2-server](./references/anaconda_org_channels_bioconda_packages_mmseqs2-server_overview.md)
- [MMseqs2-App Wiki](./references/github_com_soedinglab_MMseqs2-App_wiki.md)