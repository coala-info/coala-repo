---
name: snakemake-executor-plugin-kubernetes
description: This plugin allows Snakemake to execute workflow tasks as individual jobs within a Kubernetes cluster. Use when user asks to run Snakemake workflows on Kubernetes, scale pipelines across cloud or on-premise K8s infrastructure, or manage containerized resource requirements.
homepage: https://github.com/snakemake/snakemake-executor-plugin-kubernetes
metadata:
  docker_image: "quay.io/biocontainers/snakemake-executor-plugin-kubernetes:0.5.1--pyhdfd78af_0"
---

# snakemake-executor-plugin-kubernetes

## Overview

The `snakemake-executor-plugin-kubernetes` enables Snakemake to dispatch workflow tasks as individual Jobs within a Kubernetes cluster. This plugin is essential for scaling bioinformatics or data science pipelines across cloud or on-premise K8s infrastructure. It handles the translation of Snakemake resource requirements into Kubernetes pod specifications, manages container lifecycles, and automates log collection from terminated containers.

## Installation

Install the plugin via Conda/Mamba from the Bioconda channel:

```bash
conda install -c bioconda snakemake-executor-plugin-kubernetes
```

## Core CLI Usage

To use the Kubernetes executor, specify it during the Snakemake call. Ensure your `kubectl` context is correctly set to the target cluster.

### Basic Execution
```bash
snakemake --executor kubernetes --jobs 10
```

### Resource Management
The plugin maps Snakemake `resources` defined in your Snakefile to Kubernetes resource requests and limits.

*   **Memory and CPU**: Standard `mem_mb` and `cpus` resources are translated to K8s requests.
*   **GPUs**: Use the `gpu_manufacturer` resource to target specific hardware (e.g., for GKE GPU node pools).
*   **Scaling**: The `scale` variable can be used to adjust resource requirements dynamically.

### Storage and Persistence
For workflows requiring persistent storage across jobs, the plugin supports Persistent Volume Claims (PVCs). Ensure your environment is configured to mount these volumes so that input/output files are accessible to the pods.

## Expert Tips and Debugging

### Debugging Failed Jobs
By default, Snakemake cleans up successful and failed jobs to keep the cluster tidy. If a job fails and you need to inspect the pod state or environment:
```bash
snakemake --executor kubernetes --kubernetes-omit-job-cleanup
```
*Note: Use this sparingly as it can lead to resource exhaustion in the cluster if many jobs are left behind.*

### Log Retrieval
The plugin includes logic to retrieve logs even from terminated containers. If logs are missing, check if the `container_statuses` in the Kubernetes API returned `None` during the transition phase.

### Node Selection and Tolerations
Recent updates allow for more granular control over where jobs land:
*   **Node Selectors**: Use these to pin jobs to specific node groups (e.g., high-memory nodes).
*   **Tolerations**: Required if your Kubernetes nodes have taints (common in dedicated GPU pools).

### Handling API Exceptions
When running at high scale, you may encounter `ApiExceptions`. The plugin is designed to catch and report these; if they persist, consider reducing the `--jobs` concurrency or checking the rate limits of your Kubernetes API server.

## Reference documentation
- [Overview of snakemake-executor-plugin-kubernetes](./references/anaconda_org_channels_bioconda_packages_snakemake-executor-plugin-kubernetes_overview.md)
- [GitHub Repository and README](./references/github_com_snakemake_snakemake-executor-plugin-kubernetes.md)
- [Recent Commits and Feature Updates](./references/github_com_snakemake_snakemake-executor-plugin-kubernetes_commits_main.md)
- [Issue Tracker for GPU and Node Selector status](./references/github_com_snakemake_snakemake-executor-plugin-kubernetes_issues.md)