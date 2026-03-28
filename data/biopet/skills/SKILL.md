---
name: biopet
description: Biopet is a Java-based framework for executing and managing high-throughput sequencing analysis pipelines and bioinformatics tools. Use when user asks to list available pipelines, execute complex workflows on a computing cluster, or configure pipeline parameters using JSON files.
homepage: https://github.com/biopet/biopet
---

# biopet

## Overview

Biopet (Bio Pipeline Execution Toolkit) is a Java-based framework developed by the LUMC Sequencing Analysis Support Core for high-throughput sequencing analysis. It streamlines the execution of complex bioinformatics workflows by providing a standardized command-line interface for a suite of in-house tools and pipelines. While optimized for the SHARK computing cluster using Grid Engine, it can be adapted for other environments. Use this skill to navigate the toolkit's command structure, manage cluster job submissions, and configure pipeline parameters via JSON.

## CLI Usage and Patterns

The primary way to interact with Biopet is through its JAR file, often aliased to `biopet` via environment modules.

### Basic Commands
- **List all components**: `biopet`
- **List available pipelines**: `biopet pipeline`
- **List available tools**: `biopet tool`
- **Direct JAR execution**: `java -jar <path_to_biopet_jar> <command>`

### Common Pipeline Execution Pattern
Most pipelines follow a consistent flag structure for execution and cluster management:

```bash
biopet pipeline <pipeline_name> \
  -config <path/to/config.json> \
  -qsub \
  -jobParaEnv <environment_name> \
  -retry <number>
```

### Key Arguments
- `-config`: Path to a JSON file containing pipeline-specific parameters, sample information, and tool settings.
- `-qsub`: Enables job submission to a cluster (Grid Engine). Without this, the pipeline may run locally or in dry-run mode depending on the version.
- `-jobParaEnv`: Specifies the parallel environment for the cluster (e.g., `BWA` or `smp`).
- `-retry`: Sets the maximum number of times a failed job should be automatically resubmitted.

## Expert Tips and Best Practices

### Validation and Dry Runs
Before committing to a full production run, always perform a dry run. This validates the JSON configuration and ensures that input paths are accessible and the workflow logic is sound.
- Check the output logs of the initial Biopet command to ensure all dependencies and tools are correctly located.

### Environment Management
On the SHARK cluster, use the module system to ensure the correct version and environment variables are set:
```bash
module load biopet/v0.8.0
```
This sets up the necessary aliases so you can call `biopet` directly instead of managing the `java -jar` path manually.

### Configuration Strategy
Biopet relies heavily on JSON for configuration. Ensure your JSON is valid and follows the schema expected by the specific pipeline (e.g., Shiva, Gentrap, or Flexiprep). Common sections in the config include:
- **Samples**: Definitions of libraries and read groups.
- **Reference**: Paths to FASTA files, indexes, and annotation files.
- **Tools**: Specific parameters for underlying tools like BWA, GATK, or Picard.



## Subcommands

| Command | Description |
|---------|-------------|
| java -jar biopet.jar | A bioinformatics pipeline and tool suite for processing genomic data. |
| java -jar biopet.jar | Biopet is a framework for genomic analysis pipelines and tools developed by the SASC team at LUMC. |

## Reference documentation
- [Welcome to Biopet](./references/github_com_biopet_biopet.md)
- [Biopet Tools Package](./references/github_com_biopet_biopet_tree_develop_biopet-tools-package.md)