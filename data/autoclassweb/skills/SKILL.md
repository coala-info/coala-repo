---
name: autoclassweb
description: "AutoClassWeb provides a web interface and management tools for the AutoClass C Bayesian classification system to perform unsupervised clustering on complex datasets. Use when user asks to deploy the clustering service, manage the application lifecycle, or run Bayesian classification on omics data."
homepage: https://github.com/pierrepo/autoclassweb
---


# autoclassweb

## Overview
AutoClassWeb provides a streamlined web interface for AutoClass C, a powerful unsupervised Bayesian classification system originally developed by NASA. It utilizes the `AutoClassWrapper` Python library to bridge the gap between complex omics datasets and the underlying C-based clustering algorithms. This skill enables the deployment of the clustering service on local machines or servers and provides the necessary command-line patterns for managing the application lifecycle.

## Installation and Environment Setup
Before running AutoClassWeb, the environment must be prepared with specific 32-bit libraries and the AutoClass C binary.

### 1. System Dependencies
On 64-bit Linux systems, you must install 32-bit C libraries to support the AutoClass C executable:
```bash
sudo apt install -y libc6-i386
```

### 2. Conda Environment
Create and activate the dedicated environment using the provided configuration:
```bash
conda env create -f environment.yml
conda activate autoclassweb
```

### 3. AutoClass C Binary Setup
Download and extract the core clustering engine, then add it to your PATH:
```bash
wget https://ti.arc.nasa.gov/m/project/autoclass/autoclass-c-3-3-6.tar.gz
tar zxvf autoclass-c-3-3-6.tar.gz
export PATH=$PATH:$(pwd)/autoclass-c
```

## Server Management
AutoClassWeb can be executed as a standalone Flask app for development or via Gunicorn for production-like environments.

### Configuration
Always initialize your configuration from the template before starting the server:
```bash
cp config/autoclassweb-template.cfg config/autoclassweb.cfg
```
Edit `config/autoclassweb.cfg` to adjust parameters such as run time (default is often 48h) and result storage paths.

### Execution Commands
Use the provided Makefile for standard operations:
- **Development Server**: `make run` (Starts at http://127.0.0.1:5000)
- **Production Server**: `make run-gunicorn` (Uses Gunicorn for better concurrency)

## Docker Workflows
For isolated or reproducible deployments, use the Docker-based workflow.

- **Build Image**: `make docker-build`
- **Run Container**: `make docker-run`
- **Cleanup**: `make docker-clean` (Removes unused images)

Official images are also available via Biocontainers: `biocontainers/autoclassweb`.

## Result Handling
After clustering tasks are completed, results are typically stored in the `results/` directory.
- Use `python export_results.py` to process or package clustering outputs for downstream analysis.

## Expert Tips
- **Path Persistence**: If you manually install AutoClass C, ensure the `PATH` variable is updated in your shell profile or the `gunicorn.py` configuration to prevent "binary not found" errors during web-triggered runs.
- **Omics Data Prep**: Ensure your input data is formatted correctly for `AutoClassWrapper`. While the web UI handles uploads, the underlying engine is sensitive to missing values and data types defined in the configuration.
- **Headless Interaction**: While primarily a web UI, the server can be interacted with via `curl` for automated job submission if the API endpoints are known (refer to `flaskapp/` source for route definitions).

## Reference documentation
- [AutoClassWeb Main Documentation](./references/github_com_pierrepo_autoclassweb.md)
- [Issue Tracker (Usage Hints)](./references/github_com_pierrepo_autoclassweb_issues.md)