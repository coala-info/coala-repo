---
name: meraculous
description: Meraculous is a specialized genome assembler designed to efficiently process large-scale Illumina sequencing datasets using a hybrid k-mer and read-based approach. Use when user asks to assemble large genomes, perform de novo assembly of Illumina reads, or manage modular assembly pipelines.
homepage: https://jgi.doe.gov/data-and-tools/meraculous/
metadata:
  docker_image: "quay.io/biocontainers/meraculous:2.2.6--pl5321h9948957_9"
---

# meraculous

## Overview
Meraculous is a specialized genome assembler designed to handle large-scale datasets efficiently. It employs a unique hybrid approach that combines k-mer analysis with read-based assembly, specifically optimized for the high accuracy of Illumina sequencing. By avoiding explicit error correction steps—which the tool treats as redundant within its assembly process—it achieves significant speed and performance gains. This skill provides guidance on deploying Meraculous via Conda and managing its modular pipeline for human-sized genome assembly.

## Installation and Environment
The most reliable way to deploy Meraculous is through the Bioconda channel.

```bash
# Create a dedicated environment and install meraculous
conda create -n assembly_env meraculous
conda activate assembly_env

# Direct installation
conda install bioconda::meraculous
```

## Core Workflow and Best Practices
Meraculous operates as a multi-stage pipeline. Its architecture allows for granular control over the assembly process.

### 1. Job Control and Monitoring
The pipeline is designed to be transparent and portable. You can execute stages separately or in unison.
- **Modular Execution**: If a specific stage fails or requires parameter tuning (e.g., adjusting k-mer size), you can re-execute that specific stage without restarting the entire assembly.
- **Parallelization**: Always leverage multi-threading. Meraculous is built for high-CPU clusters; ensure your environment allocation matches the complexity of the genome (e.g., human-sized genomes typically require a high-compute cluster environment to finish within 24 hours).

### 2. Input Requirements
- **Data Type**: Optimized for Illumina sequence data.
- **Accuracy**: Relies on the inherent accuracy of the reads; do not perform heavy-handed pre-assembly error correction unless specifically required by unique library artifacts, as Meraculous handles this during the k-mer/read-based integration.

### 3. Performance Optimization
- **Memory Management**: Meraculous utilizes lightweight data structures. However, for large genomes, monitor RAM usage during the k-mer counting and graph construction phases.
- **Architecture**: While compatible with standard linux-64 systems, it also supports linux-aarch64 architectures.

## Common CLI Patterns
While specific sub-commands depend on the version installed, the general execution pattern follows the pipeline control logic:

- **Stage-wise execution**: Use the pipeline runner to trigger specific modules (e.g., k-mer counting, contig generation, scaffolding).
- **Re-execution**: Point the tool to the existing project directory to resume or overwrite specific stages.

## Reference documentation
- [Meraculous Overview](./references/anaconda_org_channels_bioconda_packages_meraculous_overview.md)