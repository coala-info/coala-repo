---
name: sga_ice
description: SGA-ICE (SGA-Iteratively Correcting Errors) is a specialized pipeline designed to maximize the accuracy of long Illumina sequencing reads.
homepage: https://github.com/hillerlab/IterativeErrorCorrection
---

# sga_ice

## Overview

SGA-ICE (SGA-Iteratively Correcting Errors) is a specialized pipeline designed to maximize the accuracy of long Illumina sequencing reads. It functions as a wrapper for the String Graph Assembler (SGA), automating a multi-stage workflow that combines the strengths of both small and large k-mers. By running multiple rounds of k-mer-based correction with increasing k-mer sizes, followed by a final overlap-based correction round, it effectively handles base substitutions in repetitive regions and small indels.

The tool does not execute the correction directly; instead, it generates a shell script (typically `runMe.sh`) containing the necessary SGA commands tailored to your data and parameters.

## Installation and Setup

The most efficient way to deploy sga_ice is via Bioconda:

```bash
conda install bioconda::sga_ice
```

Ensure that SGA version v0.10.14 or later is available in your PATH, as sga_ice relies on its modules for the underlying computations.

## Core Workflow

1.  **Preparation**: Place all target `.fastq` or `.fq` files into a single input directory.
2.  **Script Generation**: Run `SGA-ICE.py` pointing to that directory to generate the execution script.
3.  **Execution**: Run the generated shell script to perform the actual error correction.
4.  **Output**: Corrected reads are saved in an `ec/` subdirectory within your input path.

## Command Line Usage and Patterns

### Basic Execution
Generate the default correction script using 8 threads:
```bash
SGA-ICE.py /path/to/fastq/data/ -t 8
./runMe.sh
```

### Customizing K-mer Rounds
If your reads have varying lengths or specific complexity, manually define the k-mer sizes for the iterative rounds:
```bash
SGA-ICE.py /path/to/fastq/data/ -k 40,80,120,160,200
```

### Tuning Overlap Correction
For the final overlap-based round, you can adjust the sensitivity:
```bash
SGA-ICE.py /path/to/fastq/data/ --errorRate 0.02 --minOverlap 50
```

## Expert Tips and Best Practices

- **K-mer Selection**: If the `-k` flag is omitted, the tool automatically determines three k-mer sizes based on the length of the first read in the directory. For datasets with heterogeneous read lengths, always provide k-mer values manually to ensure all data is processed optimally.
- **Resource Management**: Error correction is computationally intensive. Always set `-t` to the maximum number of available CPU cores to reduce runtime.
- **Disk Space**: The pipeline generates significant intermediate data. If disk space is a concern, ensure `--noCleanup` is NOT used (cleanup is the default behavior). If you need to inspect failures, use `--noCleanup` to preserve intermediate SGA files.
- **Unique Identifiers**: Ensure every read in your input FASTQ files has a unique identifier. Duplicate headers can cause SGA modules to fail during the indexing or correction phases.
- **Final Round**: The overlap-based correction round is excellent for fixing small insertions and deletions that k-mer correction might miss. Only use `--noOvlCorr` if you are strictly interested in substitution correction or need to minimize processing time.

## Reference documentation
- [SGA-ICE Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sga_ice_overview.md)
- [IterativeErrorCorrection GitHub Documentation](./references/github_com_hillerlab_IterativeErrorCorrection.md)