---
name: biopet
description: Biopet is a framework for managing and executing complex bioinformatics workflows and pipelines. Use when user asks to run DNA or RNA sequencing pipelines, manage cluster job submissions, or execute bioinformatics tools like Shiva and Gentrap.
homepage: https://github.com/biopet/biopet
---


# biopet

## Overview
Biopet (Bio Pipeline Execution Toolkit) is a comprehensive framework for managing and executing bioinformatics workflows. It bundles a variety of specialized tools and multi-step pipelines into a single JAR-based interface. The toolkit is designed to handle the complexities of cluster job submission, providing standardized flags for configuration, retries, and parallel environments. It is particularly useful for processing high-throughput sequencing data through established pipelines like Shiva (DNA alignment/variant calling) or Gentrap (RNA-seq).

## Command Line Usage

### Environment Setup
On systems using environment modules (like the SHARK cluster), initialize the toolkit using:
```bash
module load biopet/v0.4.0
```
This provides the `biopet` alias, which maps to `java -jar <path_to_biopet.jar>`.

### Tool and Pipeline Discovery
To list all available components or filter by type:
*   **List everything**: `biopet`
*   **List pipelines only**: `biopet pipeline`
*   **List tools only**: `biopet tool`

### Common Execution Pattern
Most Biopet pipelines follow a consistent command structure:
```bash
biopet pipeline <pipeline_name> -config <config.json> [options]
```

### Standard Flags
*   `-config <file.json>`: Path to the required JSON configuration file defining samples and parameters.
*   `-qsub`: Enables job submission to a cluster (Grid Engine).
*   `-jobParaEnv <env>`: Specifies the parallel environment (e.g., `BWA`).
*   `-retry <int>`: Sets the maximum number of times to retry a failing job.
*   `-run`: Executes the pipeline. **If omitted, Biopet performs a dry run.**

## Best Practices

### The Dry Run Workflow
Always execute your command without the `-run` flag first.
1.  Run the command to validate the configuration and check for missing files.
2.  Review the output for potential errors.
3.  If the dry run succeeds, append `-run` to start the actual processing.

### Long-Running Jobs
Since pipelines can take hours or days, avoid running the main Biopet process directly in an interactive session that might disconnect. Use terminal multiplexers or background execution:
*   **Screen/Tmux**: Start a session before running the command.
*   **Nohup**: `nohup biopet pipeline <name> ... -run &`

### Configuration Management
Each pipeline requires a specific JSON layout. Ensure your `config.json` correctly defines the tool-specific parameters and sample paths required by the chosen pipeline (e.g., Shiva, Gentrap, or Flexiprep).

## Reference documentation
- [Welcome to Biopet](./references/github_com_biopet_biopet.md)