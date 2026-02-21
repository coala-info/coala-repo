---
name: pybiolib
description: The `pybiolib` tool is the official Python client and command-line interface for BioLib, a platform designed for hosting and running reproducible bioinformatics applications.
homepage: https://github.com/biolib
---

# pybiolib

## Overview
The `pybiolib` tool is the official Python client and command-line interface for BioLib, a platform designed for hosting and running reproducible bioinformatics applications. It acts as a bridge between local development environments and the BioLib cloud infrastructure. Use this skill to package Dockerized bioinformatics tools, deploy them to a web-accessible interface, and automate workflows that require high-performance biological computing.

## Installation and Setup
Install the client using pip or conda:

```bash
# Using pip
pip install -U pybiolib

# Using Conda
conda install bioconda::pybiolib
```

### Authentication
To interact with the BioLib API (e.g., pushing apps), you must set an API token as an environment variable. Generate tokens at `https://biolib.com/settings/api-tokens/`.

```bash
export BIOLIB_TOKEN=your_api_token_here
```

## Core CLI Patterns

### Initializing a Project
To prepare a local directory for deployment, use the initialization command. This creates the necessary metadata structure for BioLib to understand how to run your code.

```bash
biolib init
```

### Deploying Applications
BioLib applications are powered by Docker. The `push` command finds the Docker image specified in your project configuration and uploads it along with your project files (README, LICENSE, etc.) to the platform.

```bash
# Push to a specific user/organization namespace
biolib push BioLibDevelopment/prediction-app
```

## Expert Tips and Best Practices

### Docker Compatibility
BioLib runs on Linux infrastructure. When building your Docker images on non-Linux machines (like Apple Silicon Macs), ensure you specify the target platform to avoid compatibility issues during the `biolib push` process:

```bash
docker build . --platform linux/amd64 -t your-app-tag
```

### Efficient Deployments
*   **Layer Caching**: In your Dockerfile, place frequently changing files (like your Python scripts) at the end and static dependencies (like library installations) at the beginning to speed up rebuilds.
*   **Interactive Testing**: Use a shell script to mount your local directory into the Docker container for real-time testing before pushing to BioLib.
*   **Base Images**: For CPU-bound tasks, `ubuntu:22.04` is a reliable standard. For GPU-accelerated models, use `nvidia/cuda` devel images.

### Programmatic Access
Once an app is deployed, it can be called via Python. This allows you to use BioLib as a backend for complex bioinformatics pipelines without managing the underlying infrastructure.

## Reference documentation
- [BioLib Example Prediction App](./references/github_com_biolib_example-prediction-app.md)
- [Pybiolib Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pybiolib_overview.md)