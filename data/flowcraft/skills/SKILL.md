---
name: flowcraft
description: FlowCraft is a specialized tool for genomics that automates the assembly of Nextflow pipelines.
homepage: https://github.com/assemblerflow/flowcraft
---

# flowcraft

## Overview

FlowCraft is a specialized tool for genomics that automates the assembly of Nextflow pipelines. Instead of writing complex Nextflow DSL from scratch, you can use FlowCraft to chain together pre-defined bioinformatics modules. It handles the "plumbing" of the pipeline—ensuring that the output of one tool matches the input requirements of the next—and automatically generates the necessary configuration files for containerized execution (Docker/Singularity).

## Core CLI Workflows

### Building a Pipeline
The primary command is `flowcraft build`. You define the pipeline logic by passing a string of components to the `-t` (template) flag.

```bash
# Basic assembly pipeline
flowcraft build -t "trimmomatic fastqc spades abricate" -o assembly_pipe.nf -n "MyAssembly"
```

**Key Rules for Building:**
*   **Component Order**: Components must be compatible. For example, a component requiring FastQ files (like Trimmomatic) must come before an assembler.
*   **Output File**: Always specify the `-o` flag to name your main Nextflow executable.
*   **Naming**: Use `-n` to give your pipeline a descriptive internal name.

### Running the Generated Pipeline
Once built, you execute the pipeline using the `nextflow` command, not `flowcraft`.

```bash
# Run locally with Singularity
nextflow run assembly_pipe.nf --fastq "data/*_{1,2}.fastq.gz" -profile singularity

# Run on a SLURM cluster
nextflow run assembly_pipe.nf --fastq "data/*_{1,2}.fastq.gz" -profile slurm_sing
```

### Inspecting Progress
To monitor a running pipeline's status in the terminal:
```bash
flowcraft inspect
```
*Note: Run this command within the directory where the pipeline was launched.*

## Component Parameters and Configuration

FlowCraft dynamically generates help documentation for every pipeline you build. Because components can be used multiple times, parameters are indexed based on their position in the chain (e.g., `_1_1`, `_1_2`).

### Discovering Parameters
Always check the specific help for your generated file:
```bash
nextflow run my_pipeline.nf --help
```

### Common Parameter Patterns
*   **Input Data**: Use `--fastq` for paired-end reads. The default pattern is usually `fastq/*_{1,2}.*`.
*   **Component-Specific Flags**: If you have `trimmomatic` as the second component, its parameters will likely look like `--trimLeading_1_2`.
*   **Genome Size**: Many assembly components require `--genomeSize_X_X` (in Mb) to estimate coverage.

## Expert Tips

*   **Container Engines**: FlowCraft pipelines are designed to be portable. Always use a profile (e.g., `-profile docker` or `-profile singularity`) to ensure all software dependencies are handled via containers.
*   **Resource Management**: When running on clusters, the `slurm` profiles automatically handle the translation of Nextflow directives to sbatch submissions.
*   **Integrity Checks**: Include the `integrity_coverage` component at the start of your templates to validate input file quality and depth before proceeding to computationally expensive steps.
*   **Reports and Results**: By default, FlowCraft organizes outputs into `./reports` and `./results` directories. Check these folders continuously during execution as FlowCraft updates them in real-time.

## Reference documentation
- [FlowCraft GitHub Repository](./references/github_com_assemblerflow_flowcraft.md)
- [FlowCraft Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_flowcraft_overview.md)