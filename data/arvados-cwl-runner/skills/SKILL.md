---
name: arvados-cwl-runner
description: arvados-cwl-runner orchestrates the execution of CWL workflows on the Arvados distributed computing platform. Use when user asks to submit workflows to a remote cluster, manage petabyte-scale data storage, or track provenance for bioinformatics pipelines.
homepage: https://arvados.org
metadata:
  docker_image: "quay.io/biocontainers/arvados-cwl-runner:3.1.2--pyhdfd78af_0"
---

# arvados-cwl-runner

## Overview
The `arvados-cwl-runner` is the primary interface for orchestrating distributed computations within the Arvados ecosystem. It acts as a bridge between CWL workflow definitions and the Arvados "Crunch" dispatching system. Use this tool to submit workflows that require petabyte-scale data management, automatic provenance tracking, and cloud-based compute scaling. It is particularly effective for production-grade bioinformatics pipelines where reproducibility and data integrity are mandatory.

## Core CLI Patterns

### Workflow Submission
To run a workflow on a remote Arvados cluster, use the runner with your workflow file and input object:
`arvados-cwl-runner [options] workflow.cwl inputs.yml`

### Data Management
*   **Storage Classes**: Use `--storage-classes` to specify the storage tier for final outputs (e.g., `default`, `cold`).
*   **Intermediate Data**: Use `--intermediate-storage-classes` to set different tiers for temporary files generated during workflow execution to optimize costs.
*   **Replication**: Control data redundancy with `--collection-replication-level N`.

### Runtime Configuration
*   **Project Targeting**: Use `--project-uuid` to ensure all outputs and workflow records are organized within a specific Arvados project.
*   **Resource Overrides**: Use `--default-ram` or `--default-cores` to provide fallback values if the CWL file lacks specific resource requirements.
*   **GPU Support**: For workflows requiring hardware acceleration, ensure the cluster is configured for ROCm or CUDA; the runner handles the dispatch to appropriate nodes based on the workflow's runtime constraints.

### Process Control
*   **Wait/No-Wait**: By default, the runner stays attached to the terminal. Use `--no-wait` to submit the job and exit, allowing the workflow to run asynchronously in the background.
*   **Caching**: Arvados automatically tracks job signatures. If a step with the same inputs and version has been run before, the runner will reuse the cached output unless `--no-reuse` is specified.

## Expert Tips
*   **API Credentials**: Ensure `ARVADOS_API_HOST` and `ARVADOS_API_TOKEN` are set in your environment. The runner uses these to communicate with the cluster.
*   **Log Management**: Use `--log-level` (INFO, DEBUG) to troubleshoot submission issues. Detailed hardware performance reports (CPU/Memory/Network) are automatically generated and viewable in the Arvados Workbench after completion.
*   **Collection Handling**: When passing large datasets, use Arvados Keep URIs (`keep:uuid/path`) in your input files to avoid unnecessary data uploads.

## Reference documentation
- [Arvados Technology Overview](./references/arvados_org_technology.md)
- [Arvados 3.1 Release Highlights](./references/arvados_org_feed.xml.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_arvados-cwl-runner_overview.md)