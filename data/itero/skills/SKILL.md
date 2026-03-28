---
name: itero
description: itero is a bioinformatics pipeline designed for the iterative, guided assembly of target enrichment data using reference seeds. Use when user asks to assemble ultraconserved elements, perform guided assembly of hybrid enrichment data, or recover sequences from target enrichment reads.
homepage: https://github.com/faircloth-lab/itero
---


# itero

## Overview

itero is a specialized bioinformatics pipeline designed for the "guided" assembly of target enrichment data. It addresses the limitations of traditional de novo assemblers by using reference "seeds" to capture relevant reads, which are then assembled into contigs over multiple iterations. This iterative approach is particularly effective for recovering high-quality sequences from Ultraconserved Elements (UCEs) or other anchored hybrid enrichment protocols.

The tool integrates several standard bioinformatic utilities—including BWA for alignment, SAMtools and BEDtools for data manipulation, and SPAdes for the actual assembly—into a single, parallelized workflow that can run on a local workstation or an MPI-enabled high-performance computing (HPC) cluster.

## Installation and Environment Setup

The most reliable way to use itero is through a Conda environment to ensure all third-party dependencies (BWA, SPAdes, etc.) are correctly versioned and linked.

```bash
# Create and configure the environment
conda config --add channels bioconda
conda install itero

# Verify the installation and dependency paths
itero check binaries
```

If running on an HPC without Conda, you must manually define tool paths in a `~/.itero.conf` file:
```ini
[executables]
bedtools:/path/to/bedtools
bwa:/path/to/bwa
gawk:/path/to/gawk
samtools:/path/to/samtools
spades:/path/to/spades.py
```

## Configuration File Structure

Before running an assembly, you must create a configuration file (e.g., `project.conf`) to define your reference seeds and sample locations.

```ini
[reference]
/path/to/seeds.fasta

[individuals]
Sample_1:/path/to/fastq/folder/sample1/
Sample_2:/path/to/fastq/folder/sample2/
```
*Note: The paths in the `[individuals]` section should point to the directory containing the R1 and R2 FastQ files for that specific taxon.*

## Execution Patterns

### Local Multiprocessing
Use this for single-node workstations. The `--local-cores` flag determines how many threads are used for BWA and how many simultaneous assemblies are run.

```bash
itero assemble local \
    --config project.conf \
    --output results_dir \
    --local-cores 16 \
    --iterations 6
```

### MPI for HPC Clusters
Use this to distribute locus-specific assemblies across multiple nodes.

```bash
mpirun -hostfile my_hosts -n 96 itero assemble mpi \
    --config project.conf \
    --output mpi_results \
    --local-cores 16 \
    --iterations 6
```

## Expert Tips and Best Practices

- **Iteration Count**: While 6 iterations is the standard recommendation, you may increase this if you are working with highly divergent references or very low-coverage data.
- **Memory Management**: SPAdes is memory-intensive. itero defaults to approximately 2GB per process. Ensure your node has sufficient RAM (Total Cores × 2GB) to prevent crashes during the assembly phase.
- **Input Data**: Ensure your FastQ files are cleaned of adapters and low-quality bases before running itero, as it does not perform pre-processing of raw reads.
- **Seed Selection**: The quality of your assembly is highly dependent on the "seeds" provided. Use seeds that are as phylogenetically close to your target taxa as possible.
- **Logging**: itero creates a unique log file for every run. If an assembly fails or hangs, check the log file in the output directory to identify if a specific locus or sample is causing the issue.



## Subcommands

| Command | Description |
|---------|-------------|
| check | Check to ensure binaries are installed and configured. |
| itero assemble | Assemble cleaned/trimmed sequencing reads. |

## Reference documentation
- [itero: guided contig assembly for target enrichment data](./references/itero_readthedocs_io_en_latest.md)
- [Running itero](./references/itero_readthedocs_io_en_latest_running.html.md)
- [Installation](./references/itero_readthedocs_io_en_latest_installation.html.md)
- [itero GitHub Repository](./references/github_com_faircloth-lab_itero.md)