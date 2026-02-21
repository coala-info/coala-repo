---
name: galaxy-k8s-runtime
description: The galaxy-k8s-runtime is a specialized version of the Galaxy platform (version 18.01-pheno) designed to run as a containerized service within a Kubernetes (K8s) cluster.
homepage: https://github.com/phnmnl/container-galaxy-k8s-runtime
---

# galaxy-k8s-runtime

## Overview

The galaxy-k8s-runtime is a specialized version of the Galaxy platform (version 18.01-pheno) designed to run as a containerized service within a Kubernetes (K8s) cluster. Unlike standard Galaxy installations, this runtime is capable of scheduling Kubernetes jobs directly from within the cluster and is optimized for PhenoMeNal (Phenomics and Metabolomics) workflows. It features native support for ISA-tab and ISA-json datatypes and includes an integrated ISA dataset viewer.

## Deployment and Installation

### Helm Deployment (Recommended)
The most effective way to deploy this runtime is via Helm on an existing Kubernetes cluster or Minikube instance.

1. Add the PhenoMeNal Galaxy Helm repository:
   helm repo add galaxy-helm-repo https://pcm32.github.io/galaxy-helm-charts

2. Install the chart:
   helm install galaxy-helm-repo/galaxy

### Docker Usage
While a Docker image is available, it is not intended for standalone use and requires connectivity to a Kubernetes cluster to be functional.

Pull the latest runtime image:
docker pull container-registry.phenomenal-h2020.eu/phnmnl/galaxy-k8s-runtime

## Repository Management

The repository relies heavily on submodules. To ensure all components and tools are available, use recursive flags during git operations.

### Initial Clone
git clone --recurse-submodules https://github.com/phnmnl/container-galaxy-k8s-runtime.git

### Updating an Existing Clone
To pull the latest changes along with all submodule updates:
git pull --recurse-submodules
git submodule update --recursive --remote

## Maintenance and Utility Scripts

The runtime includes several Shell scripts for initialization and health checking located in the root directory:

- **Container Health Checks**: Run `bash container-simple-checks.sh` to verify the internal state of the Galaxy instance.
- **Tool Validation**: Use the `check_tools` utility to verify the integrity of integrated tools.
- **Post-Startup**: The `post-start-actions.sh` script handles automated configuration tasks after the container enters a running state.
- **Custom Builds**: For creating modified versions of the stable container, use `bash simplified_galaxy_stable_container_creation.sh`.

## Expert Tips

- **Accessing Minikube**: If deploying locally on Minikube, the default access URL is typically `http://192.168.99.100:30700`.
- **Lightweight Design**: This runtime does not require ToolShed dependencies, as it is designed to use containerized tools scheduled as K8s jobs.
- **ISA Support**: Leverage the native `ISA-tab` and `ISA-json` composite datatypes for metabolomics metadata management without needing additional plugins.

## Reference documentation
- [Main Repository Overview](./references/github_com_phnmnl_container-galaxy-k8s-runtime.md)
- [Commit History and Versioning](./references/github_com_phnmnl_container-galaxy-k8s-runtime_commits_develop.md)
- [Issue Tracking and Known Bugs](./references/github_com_phnmnl_container-galaxy-k8s-runtime_issues.md)