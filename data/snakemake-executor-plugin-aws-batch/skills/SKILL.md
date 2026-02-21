---
name: snakemake-executor-plugin-aws-batch
description: The `snakemake-executor-plugin-aws-batch` enables Snakemake to seamlessly submit and manage jobs within the AWS Batch ecosystem.
homepage: https://github.com/snakemake/snakemake-executor-plugin-aws-batch
---

# snakemake-executor-plugin-aws-batch

## Overview

The `snakemake-executor-plugin-aws-batch` enables Snakemake to seamlessly submit and manage jobs within the AWS Batch ecosystem. It transforms Snakemake from a local execution engine into a cloud-orchestrator, allowing individual rules to be dispatched as Batch jobs. This is particularly useful for high-throughput genomic pipelines or data processing tasks that require elastic scaling, specialized hardware (like GPUs), or long-running compute instances that exceed local capabilities.

## Installation

Install the plugin via Bioconda or pip to make it available to the Snakemake runtime:

```bash
conda install -c bioconda snakemake-executor-plugin-aws-batch
```

## CLI Usage Patterns

To use the plugin, specify `aws-batch` as the executor. You must provide the target AWS region and the job queue defined in your AWS environment.

### Basic Execution
```bash
snakemake --executor aws-batch --jobs 10 --aws-batch-job-queue <your-queue-name> --aws-batch-region <region>
```

### Common CLI Arguments
While specific flags are often discovered via `snakemake --help`, the following are standard requirements for this plugin:
- `--aws-batch-job-queue`: The name or ARN of the AWS Batch job queue.
- `--aws-batch-region`: The AWS region where your Batch resources are provisioned.
- `--aws-batch-job-role-arn`: The IAM role ARN that the job container will assume.
- `--aws-batch-execution-role-arn`: The IAM role ARN that allows AWS Batch to make calls to AWS APIs on your behalf (e.g., pulling images from ECR).

## Expert Tips and Best Practices

### vCPU and Thread Mapping
The plugin maps the Snakemake `threads` directive directly to AWS Batch vCPUs. Ensure your compute environment (EC2 or Fargate) has instance types that support the thread counts defined in your Snakefile.
- **Tip**: Use `threads: 1` for small tasks to maximize binning on multi-core instances.

### Container Requirements
AWS Batch requires a container image for every job. 
- Ensure every rule in your Snakefile has a `container:` directive or define a global container image.
- If using private images, ensure the `execution-role-arn` has permissions to pull from Amazon ECR.

### Resource Validation
Be aware that resource validation can differ between Fargate and EC2 compute environments. 
- **Fargate**: Requires specific combinations of vCPU and Memory.
- **EC2**: Offers more flexibility but requires the instance types in your compute environment to match the requested resources.

### Environment Variables
The plugin supports passing environment variables to the Batch job. This is critical for workflows that rely on specific AWS configurations or custom software flags passed via the shell.

### Job Definition Cleanup
Recent versions of the plugin include features to clean up temporary job definitions created during the workflow run. This prevents "resource leaking" in your AWS account where thousands of inactive job definitions might otherwise accumulate.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-executor-plugin-aws-batch_overview.md)
- [GitHub Repository README](./references/github_com_snakemake_snakemake-executor-plugin-aws-batch.md)
- [GitHub Issues - Resource Mapping](./references/github_com_snakemake_snakemake-executor-plugin-aws-batch_issues.md)