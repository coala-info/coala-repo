---
name: snakemake-executor-plugin-googlebatch
description: This plugin allows Snakemake to execute workflows as managed jobs on Google Cloud Batch. Use when user asks to run Snakemake rules on GCP, manage cloud resource allocation, or use specialized hardware like GPUs in a cloud environment.
homepage: https://github.com/snakemake/snakemake-executor-plugin-googlebatch
---


# snakemake-executor-plugin-googlebatch

## Overview
The `snakemake-executor-plugin-googlebatch` enables Snakemake to transition from local execution to a managed cloud environment. It translates Snakemake rules into Google Batch jobs, managing the submission, resource allocation, and monitoring of tasks. This skill provides the necessary command-line patterns to interface with GCP, including handling storage buckets, service accounts, and specialized hardware like GPUs.

## Installation
Install the plugin via Conda/Mamba to ensure all dependencies (including the Snakemake core and Google Cloud SDK components) are satisfied:

```bash
conda install -c bioconda snakemake-executor-plugin-googlebatch
```

## Core CLI Usage
To use the Google Batch executor, specify it during the Snakemake call. You must provide your GCP project and region.

### Basic Execution
```bash
snakemake --executor googlebatch \
    --googlebatch-project YOUR_GCP_PROJECT_ID \
    --googlebatch-region us-central1 \
    --default-resources googlebatch_storage_bucket=YOUR_GCS_BUCKET
```

### Resource Management
The plugin supports specific resource requests that map directly to Google Batch capabilities. These can be passed via `--default-resources` or defined within individual rules in your Snakefile.

*   **Preemptible Instances**: Reduce costs by using spot/preemptible VMs.
    ```bash
    --default-resources googlebatch_preemptible=True
```
*   **GPU Acceleration**: Request NVIDIA GPUs for specific tasks.
    ```bash
    --set-resources rule_name:googlebatch_gpu=1
```
*   **Custom Boot Disks**: Specify size and type for jobs with high I/O requirements.
    ```bash
    --default-resources googlebatch_boot_disk_size=50 googlebatch_boot_disk_type=pd-ssd
```

## Expert Tips and Best Practices

### Service Account Configuration
For production environments, avoid using default compute engine service accounts. Use a dedicated service account with minimal required permissions (Batch Job Editor, Storage Object Admin).
```bash
snakemake --executor googlebatch \
    --googlebatch-service-account your-service-account@your-project.iam.gserviceaccount.com
```

### Container OS (COS) vs. Custom Containers
By default, the plugin uses the Container-Optimized OS (COS). If your workflow requires specific system-level dependencies not present in the Snakemake image, ensure your rules specify a custom Docker container.
*   The plugin will automatically use the default Snakemake container unless a `container:` directive is found in the rule.
*   Ensure your container is hosted in Google Artifact Registry or Docker Hub and is accessible by the Batch service account.

### Log Retrieval
As of version 0.5.1, the plugin includes improved log retrieval after job finalization. If jobs fail without clear errors, check the Google Cloud Console under **Batch > Jobs** or ensure your environment is updated to the latest version to benefit from automatic log fetching.

### Large-Scale Workflow Optimization
When running thousands of jobs, the Google Logging API limits can be a bottleneck. 
*   Use GCS for all input/output files to minimize data transfer overhead.
*   Group small, fast-running rules into a single batch job using Snakemake's `groups` feature to reduce the overhead of VM provisioning.

## Reference documentation
- [GitHub Repository](./references/github_com_snakemake_snakemake-executor-plugin-googlebatch.md)
- [Plugin Tags and Version History](./references/github_com_snakemake_snakemake-executor-plugin-googlebatch_tags.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-executor-plugin-googlebatch_overview.md)