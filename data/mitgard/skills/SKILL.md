---
name: mitgard
description: "MITGARD reconstructs complete or near-complete mitochondrial genomes from RNA-seq data. Use when user asks to assemble mitochondrial genomes from transcriptomic data, process Illumina or long-read RNA-seq libraries, or recover mitogenomes for non-model organisms."
homepage: https://github.com/pedronachtigall/MITGARD
---


# mitgard

## Overview

MITGARD (Mitochondrial Genome Assembly from RNA-seq Data) is a specialized computational pipeline that leverages the presence of mitochondrial transcripts in RNA-seq libraries to reconstruct complete or near-complete mitochondrial genomes. It is particularly useful for non-model organisms where genomic resources are scarce but transcriptomic data is available. The tool supports standard Illumina paired-end/single-end reads as well as long-read data (MITGARD-LR).

## Installation and Environment Setup

The most reliable way to deploy MITGARD is via Conda or Docker to manage its extensive dependency list (Trinity, SPAdes, Bowtie2, etc.).

### Conda Recommended Setup
To avoid environment resolution delays, use Mamba and ensure the correct channel priority:
```bash
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda create -n mitgard_env mitgard
conda activate mitgard_env
```

### Critical Post-Installation Step
After installation, you must update the NCBI taxonomy database for the tool to function correctly:
```bash
python install_NCBITaxa.py
# OR manually via python:
# from ete3 import NCBITaxa; ncbi = NCBITaxa(); ncbi.update_taxonomy_database()
```

## Usage Patterns

### Standard Execution
MITGARD typically operates in two primary modes. Ensure all binaries in the `bin/` folder have execution permissions (`chmod 777`).

- **Paired-End Mode**: Used for standard Illumina libraries.
- **Single-End Mode**: Used for single-read libraries.
- **Long-Read Mode**: Use the `MITGARD-LR.py` script for PacBio or Oxford Nanopore data.

### Troubleshooting Common Issues

- **Missing Shared Libraries**: If you encounter `error while loading shared libraries: libtbb.so.2`, install the TBB library:
  - Conda: `conda install -c conda-forge tbb`
  - System: `sudo apt-get install libtbb-dev`
- **macOS Compatibility**: The Trinity assembler component often fails when installed via Conda on macOS. For Mac users, it is recommended to use the Docker container or install Trinity manually following its specific macOS documentation.
- **MitoZ Integration**: While optional, MitoZ (v2.4) is highly recommended for the assembly and annotation phase. If installed via Conda, MitoZ may need to be added manually to the PATH as the default Conda package might not include it.

## Expert Tips

- **Handling "N"s in Assembly**: If the resulting assembly contains many ambiguous bases (N), it may interfere with downstream annotation. Check read coverage and consider lowering the k-mer threshold in the underlying assemblers (Trinity/SPAdes) if the mitochondrial expression is low.
- **Resource Allocation**: Trinity and SPAdes are memory-intensive. Ensure the environment has at least 16-32GB of RAM available for eukaryotic mitogenome assembly.
- **Path Management**: Always ensure the MITGARD `bin` directory and the MitoZ release directory are explicitly added to your `$PATH` to prevent "command not found" errors during the pipeline execution.

## Reference documentation

- [MITGARD Main Documentation](./references/github_com_pedronachtigall_MITGARD.md)
- [Bioconda MITGARD Overview](./references/anaconda_org_channels_bioconda_packages_mitgard_overview.md)
- [Known Issues and Troubleshooting](./references/github_com_pedronachtigall_MITGARD_issues.md)