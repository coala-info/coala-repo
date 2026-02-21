---
name: mitobim
description: MITObim (Mitochondrial Baiting and Iterative Mapping) is a specialized bioinformatics pipeline for reconstructing mitochondrial genomes directly from NGS data.
homepage: https://github.com/chrishah/MITObim
---

# mitobim

## Overview

MITObim (Mitochondrial Baiting and Iterative Mapping) is a specialized bioinformatics pipeline for reconstructing mitochondrial genomes directly from NGS data. It eliminates the need for labor-intensive long-range PCR by using an iterative process: it baits reads from a total genomic pool using a starting reference (seed), maps those reads to extend the sequence, and uses the new assembly as the reference for the next round of baiting. This process continues until the mitochondrial genome is fully recovered or no further extensions are possible.

## Core CLI Usage

The primary interface is the `MITObim.pl` Perl script.

### Basic Command Structure
```bash
MITObim.pl -start <iteration> -end <iteration> -sample <sample_name> -ref <reference_name> -readpool <fastq_file> --mirapath <path_to_mira_binaries>
```

### Key Parameters
- `-start`: The iteration number to begin with (usually `1`).
- `-end`: The maximum number of iterations to perform (e.g., `10` or `15`).
- `-sample`: The name of the sample/strain being assembled (replaces the older `-strain` flag).
- `-ref`: The name of the starting reference sequence (e.g., the species name of the seed).
- `-readpool`: The FASTQ file containing the genomic reads.
- `--mirapath`: Path to the directory containing MIRA executables (required if MIRA is not in your PATH).

## Common Workflows

### 1. Assembly from a Related Species Reference
Use this when you have a complete mitogenome from a distantly related taxon.
```bash
MITObim.pl -start 1 -end 10 -sample target_species -ref related_species -readpool reads.fastq --mirapath /path/to/mira/bin
```

### 2. Assembly from a Short Barcode Seed (e.g., COI)
Use this when only a short sequence (seed) is available. This often requires more iterations to reach completion.
```bash
MITObim.pl -start 1 -end 30 -sample target_species -ref COI_seed -readpool reads.fastq --mirapath /path/to/mira/bin
```

### 3. Resuming a Failed or Incomplete Run
If a run stops at iteration 5 and you want to continue:
```bash
MITObim.pl -start 6 -end 15 -sample target_species -ref related_species -readpool reads.fastq
```

## Expert Tips and Best Practices

- **MIRA Version Compatibility**: MITObim 1.9.1 (stable) is designed to work with **MIRA 4.0.2**. Using older versions of MIRA (like 3.4) requires using MITObim 1.6.
- **Proofreading**: The proofreading algorithm is disabled in versions 1.8 and newer. If your project specifically requires the proofreading functionality described in the original Hahn et al. 2013 paper, you must use MITObim 1.6 with MIRA 3.4.1.1.
- **Environment Isolation**: Use the official Docker image (`chrishah/mitobim`) to avoid dependency conflicts with MIRA and Perl.
- **Read Pool Preparation**: Ensure your read pool is in a single FASTQ file. If you have paired-end data, they should be interleaved or provided in a format MIRA recognizes.
- **Iteration Limits**: If the assembly does not converge (i.e., the number of reads baited stops increasing), you can manually terminate the process. Conversely, if the sequence is still growing at the final iteration, increase the `-end` parameter and resume.

## Reference documentation
- [MITObim GitHub Repository](./references/github_com_chrishah_MITObim.md)
- [MITObim Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mitobim_overview.md)