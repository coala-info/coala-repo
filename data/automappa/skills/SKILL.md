---
name: automappa
description: Automappa provides an interactive web interface for the visual exploration and refinement of complex metagenomic datasets into high-quality genomes. Use when user asks to install Automappa via Conda, deploy the service using Docker, or access the interface for manual binning refinement.
homepage: https://github.com/WiscEvan/Automappa
metadata:
  docker_image: "quay.io/biocontainers/automappa:2.2.1--pyhdfd78af_0"
---

# automappa

## Overview
Automappa is a specialized interactive interface designed for the visual exploration and refinement of highly complex metagenomic datasets. It allows researchers to transition from raw automated binning results to high-quality metagenome-assembled genomes (MAGs) through a user-friendly web environment. This skill facilitates the technical setup required to launch the Automappa service, whether locally or on a remote server.

## Installation and Deployment

### Conda Installation
For users who prefer a local environment without Docker, Automappa is available via Bioconda.
```bash
conda install bioconda::automappa
```

### Docker Deployment (Recommended)
The preferred way to run Automappa is via Docker to ensure all dependencies and services (like the web server and database) are correctly orchestrated.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/WiscEvan/Automappa
    cd Automappa
    ```
2.  **Build the images:**
    ```bash
    make build
    ```
3.  **Launch the services:**
    ```bash
    make up
    ```
    *Note: You can skip `make build` and run `make up` directly; Docker will pull or build any missing images automatically.*

## Accessing the Interface
Once the terminal logs indicate that `automappa_web_1` is running, the interface is accessible via a web browser.

*   **Local Access:** Navigate to `http://localhost:8050`
*   **Remote Access:** If running on a server, use SSH tunneling to map the remote port to your local machine:
    ```bash
    ssh -L 8050:localhost:8050 user@remote-server-ip
    ```

## Best Practices and Expert Tips
*   **Resource Management:** Automappa services can be resource-intensive during the initial construction and data loading phases. If the build fails or the UI is unresponsive, ensure that Docker has been allocated sufficient CPU and RAM (at least 8GB recommended for complex metagenomes).
*   **Data Persistence:** When using the Docker deployment, ensure your metagenomic data is placed in the directory structure expected by the `docker-compose.yml` (typically defined in the `.env` file or the `static/` directory) to ensure it is visible to the web application.
*   **Refinement Workflow:** Use the interactive plots to identify outliers in binning clusters. Automappa is specifically designed for "human-in-the-loop" refinement, so focus on using the interface to manually adjust bin boundaries that automated tools like MetaBAT2 or MaxBin2 might have misidentified.
*   **Service Teardown:** To stop the application and free up system resources, use the command:
    ```bash
    make down
    ```

## Reference documentation
- [Automappa GitHub Repository](./references/github_com_evanroyrees_Automappa.md)
- [Bioconda Automappa Package Overview](./references/anaconda_org_channels_bioconda_packages_automappa_overview.md)