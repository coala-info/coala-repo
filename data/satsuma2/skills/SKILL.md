---
name: satsuma2
description: Satsuma2 is a high-performance synteny aligner optimized for large-scale genomic comparisons.
homepage: https://github.com/bioinfologics/satsuma2
---

# satsuma2

## Overview

Satsuma2 is a high-performance synteny aligner optimized for large-scale genomic comparisons. It employs Fast Fourier Transform (FFT) cross-correlation and an asynchronous "battleship" search strategy to detect homology with high sensitivity and specificity. The tool is designed to scale across parallel computing environments, including multi-core workstations and HPC clusters (SLURM, LSF, PBS), making it capable of handling the computational demands of billion-base-pair vertebrate genomes.

## Environment Setup

Before running the tool, ensure the binaries are in your path or set the environment variable:

```bash
export SATSUMA2_PATH=/path/to/satsuma2/bin
```

If installed via Conda:
```bash
conda install -c bioconda satsuma2
```

## Basic Usage

The primary wrapper for high-sensitivity alignments is `SatsumaSynteny2`. At a minimum, you must provide a query, a target, and an output directory.

```bash
SatsumaSynteny2 -q query.fasta -t target.fasta -o output_directory
```

## Command Line Parameters

### Core Arguments
- `-q <string>`: Query FASTA sequence.
- `-t <string>`: Target FASTA sequence.
- `-o <string>`: Output directory for alignment results.
- `-l <int>`: Minimum alignment length (default=0).

### Parallelism and Performance
- `-slaves <int>`: Number of processing slave jobs to launch (default=1).
- `-threads <int>`: Number of working threads per slave (default=1).
- `-km_mem <int>`: Memory reserved for the `kmatch` phase in Gb (default=100).
- `-sl_mem <int>`: Memory requirement for each slave process in Gb (default=100).

### Search and Sensitivity Tuning
- `-t_chunk <int>` / `-q_chunk <int>`: Size of sequence chunks for comparison (default=4096).
- `-min_prob <double>`: Minimum probability threshold to retain a match (default=0.99999).
- `-cutoff <double>`: Signal-to-noise cutoff for cross-correlation (default=1.8).
- `-dups <bool>`: Set to 1 to allow for duplications in the query sequence (default=0).

## HPC Integration

Satsuma2 uses a helper script, `satsuma_run.sh`, to dispatch jobs. To run on a cluster, you must edit this script in the installation directory to uncomment the section corresponding to your scheduler (SLURM, PBS, or LSF) and specify the correct queue name.

Example SLURM configuration in `satsuma_run.sh`:
```bash
srun --mem=${4}gb -c $3 --export=ALL -p YourQueueName "$2"
```

## Expert Tips

1. **Memory Management**: The default memory requirement is high (100Gb). If working with smaller genomes or limited hardware, explicitly lower `-km_mem` and `-sl_mem` to avoid job rejection.
2. **Sensitivity vs. Speed**: For highly divergent sequences, consider decreasing the `-cutoff` or increasing chunk sizes, though this will impact runtime.
3. **Refinement**: Use `-do_refine 1` if you require higher resolution in the final alignment boundaries, though this adds computational overhead.
4. **Large Genomes**: When aligning two large vertebrate genomes, maximize `-slaves` based on your available cluster nodes to take advantage of the asynchronous search strategy.

## Reference documentation
- [Satsuma2 GitHub Repository](./references/github_com_bioinfologics_satsuma2.md)
- [Bioconda Satsuma2 Overview](./references/anaconda_org_channels_bioconda_packages_satsuma2_overview.md)