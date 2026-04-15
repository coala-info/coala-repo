---
name: bactopia-py
description: Bactopia-py is an automated pipeline for the comprehensive analysis of bacterial genomes, covering quality control, assembly, and annotation. Use when user asks to process raw sequencing data, identify antimicrobial resistance genes, perform pangenome analysis, or conduct taxonomic classification.
homepage: https://bactopia.github.io/
metadata:
  docker_image: "quay.io/biocontainers/bactopia-py:1.7.0--pyhdfd78af_0"
---

# bactopia-py

## Overview
Bactopia is a comprehensive, automated pipeline designed for the complete analysis of bacterial genomes. It leverages Nextflow for workflow management and Bioconda for software dependencies, ensuring portability and reproducibility. This skill enables the processing of raw sequencing data through a standardized path: quality control, assembly, annotation, and sketching. It also facilitates the use of "Bactopia Tools"—a suite of over 50 independent sub-workflows for specific tasks like AMR gene identification, pangenome analysis, and taxonomic classification.

## Installation and Setup
The primary method for installing the Bactopia Python wrapper is via Conda.

```bash
# Install bactopia-py from the bioconda channel
conda install -c bioconda bactopia-py
```

## Core Workflow Execution
Bactopia follows a "Gather, QC, Assemble, Annotate" pattern. The Python package provides a CLI to manage these runs.

### Basic Command Structure
```bash
bactopia --samples samples.txt --outdir ./results
```

### Key Parameters
- `--samples`: A FOFN (File Of File Names) or a directory containing FASTQ files.
- `--outdir`: The directory where all analysis results will be stored.
- `--species`: (Optional) Specify the species to enable species-specific tools (e.g., `Lactobacillus crispatus`).
- `--coverage`: Set a target coverage for subsampling to speed up assembly.

## Using Bactopia Tools
Bactopia Tools are modular sub-workflows that can be run on the output of a standard Bactopia run.

### Common Tool Patterns
- **Pangenome Analysis**: Use `roary` or `pirate` via the tools interface.
  ```bash
  bactopia tools pangenome --bactopia_dir ./results --outdir ./pangenome
  ```
- **AMR Detection**: Run `amrfinderplus` or `rgi`.
  ```bash
  bactopia tools amrfinderplus --bactopia_dir ./results --outdir ./amr
  ```
- **Phylogeny**: Generate a tree using `mashtree` or `iqtree`.
  ```bash
  bactopia tools mashtree --bactopia_dir ./results --outdir ./tree
  ```

## Expert Tips
- **Resource Management**: Since Bactopia uses Nextflow, you can pass Nextflow-specific arguments like `-profile` (e.g., `docker`, `singularity`, `conda`) and `-resume` to restart a failed run from the last successful step.
- **Data Gathering**: Use the `bactopia search` command to automatically fetch metadata and SRA accession numbers for public datasets before running the pipeline.
- **Species-Specific Analysis**: Always check if a specialized "Bactopia Tool" exists for your specific organism (e.g., `staphopiasccmec` for S. aureus) to get higher resolution typing.

## Reference documentation
- [Bactopia Introduction](./references/bactopia_github_io_index.md)
- [Bactopia Python Package Overview](./references/anaconda_org_channels_bioconda_packages_bactopia-py_overview.md)