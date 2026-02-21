---
name: assemblerflow
description: Assemblerflow (now primarily known as FlowCraft) is a pipeline composer that simplifies the creation of genomics workflows.
homepage: https://github.com/ODiogoSilva/assemblerflow
---

# assemblerflow

## Overview
Assemblerflow (now primarily known as FlowCraft) is a pipeline composer that simplifies the creation of genomics workflows. It allows you to select specific bioinformatics modules and "assemble" them into a functional Nextflow pipeline. The tool automatically handles the underlying Nextflow logic and container integration, making it highly efficient for users who need to build reproducible pipelines quickly.

## Installation
Install the tool via Bioconda to ensure all dependencies, including Nextflow, are correctly managed:
```bash
conda install bioconda::flowcraft
```

## Core CLI Patterns

### Building a Pipeline
The primary command is `flowcraft build`. You define the pipeline structure using the `-t` (template) flag with a space-separated list of components.

- **Basic Build**:
  ```bash
  flowcraft build -t "trimmomatic fastqc skesa pilon" -o my_pipeline.nf
  ```
- **Named Pipeline**:
  ```bash
  flowcraft build -t "trimmomatic spades abricate" -o assembly_pipe.nf -n "Assembly and Annotation"
  ```

### Running the Generated Pipeline
Once the `.nf` file is generated, execute it using Nextflow. FlowCraft pipelines are designed to work with container engines (Singularity, Docker, or Shifter).

- **Local Execution**:
  ```bash
  nextflow run my_pipeline.nf --fastq "path/to/fastq/*_{1,2}.fastq.gz"
  ```
- **Cluster Execution (SLURM + Singularity)**:
  ```bash
  nextflow run my_pipeline.nf --fastq "path/to/fastq/*_{1,2}.fastq.gz" -profile slurm_sing
  ```

### Inspecting Progress
To monitor the status of a running pipeline in the terminal:
```bash
flowcraft inspect
```

## Expert Tips and Best Practices

- **Component Compatibility**: Ensure that the output type of one component matches the input type of the next (e.g., a trimmer outputting FastQ files followed by an assembler that accepts FastQ).
- **Dynamic Help**: Every generated pipeline has a custom help message. Always run `nextflow run your_pipeline.nf --help` to see the specific parameters available for the components you included (e.g., `--trimMinLength_1_2` for a Trimmomatic component).
- **Container Engines**: FlowCraft pipelines require a container engine. Singularity is generally recommended for HPC environments, while Docker is standard for local desktop use.
- **Parameter Customization**: Parameters are namespaced by the component and its position in the pipeline (e.g., `_1_1`, `_1_2`) to avoid conflicts when the same tool is used multiple times.

## Reference documentation
- [FlowCraft GitHub Repository](./references/github_com_assemblerflow_flowcraft.md)
- [Assemblerflow Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_assemblerflow_overview.md)