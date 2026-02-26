---
name: itero
description: itero is a bioinformatics pipeline that performs guided contig assembly using a reference-based seed approach to iteratively map reads and extend sequences. Use when user asks to perform guided assembly, extend contigs from seeds, or run iterative local assemblies using BWA and SPAdes.
homepage: https://github.com/faircloth-lab/itero
---


# itero

## Overview

itero is a "strongly opinionated" bioinformatics pipeline designed for guided contig assembly. Unlike standard de novo assemblers, itero uses a reference-based "seed" approach to iteratively map reads, perform local assemblies, and extend contigs over multiple rounds. This method is particularly effective for capturing specific loci or resolving complex regions where general assembly methods might struggle. It streamlines the integration of BWA for alignment, Samtools for data handling, and SPAdes for the actual assembly process.

## Installation and Environment

The most reliable way to deploy itero is via Conda. Note that itero is built for Python 2.7 environments.

```bash
# Environment setup
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda

# Installation
conda install itero

# Verify dependencies
itero check binaries
```

## Configuration

itero requires a configuration file (typically `.conf`) to define the reference seeds and the sample data.

### Sample Configuration File (`project.conf`)
The file uses an INI-style format. The `[individuals]` section expects a path to a directory containing the R1 and R2 FASTQ files for each taxon.

```ini
[reference]
/path/to/locus/seeds.fasta

[individuals]
taxon-one:/path/to/fastq/sample1/
taxon-two:/path/to/fastq/sample2/
```

### Binary Path Overrides
If binaries are not in your PATH or you are using non-standard locations, create a `~/.itero.conf` file:

```ini
[executables]
bedtools:/path/to/bin/bedtools
bwa:/path/to/bin/bwa
samtools:/path/to/bin/samtools
spades:/path/to/bin/spades.py
```

## Execution Patterns

### Local Assembly
Use this for single-node execution. itero will parallelize alignments first, then distribute individual locus assemblies across the available cores.

```bash
itero assemble local \
    --config project.conf \
    --output results_dir \
    --local-cores 16 \
    --iterations 6
```

### MPI Assembly
Use this for high-performance computing (HPC) clusters to distribute assemblies across multiple nodes.

```bash
mpirun -hostfile cluster_hosts -n 96 \
    itero assemble mpi \
    --config project.conf \
    --output mpi_results \
    --local-cores 16 \
    --iterations 6
```

## Expert Tips and Best Practices

- **Iteration Count**: 6 iterations is the standard recommendation. Increasing this may help extend contigs further but carries a diminishing return in assembly length versus computational time.
- **Memory Management**: itero defaults to approximately 2GB of RAM per process. Ensure your node has sufficient memory (e.g., 16 cores * 2GB = 32GB RAM minimum).
- **Input Validation**: Ensure that each taxon directory in the config file contains only the relevant paired-end FASTQ files. itero may fail or produce warnings if it encounters multiple sets of FASTQs for a single sample.
- **Seed Selection**: The quality of your `seeds.fasta` is critical. Seeds should be representative of the target loci to ensure efficient initial mapping by BWA.
- **Cleaning Up**: itero generates temporary SAM files during the alignment phases; the pipeline is designed to remove these automatically to save disk space, but ensure your output partition has enough overhead for intermediate BAM files.

## Reference documentation
- [itero Main Repository](./references/github_com_faircloth-lab_itero.md)
- [itero Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_itero_overview.md)