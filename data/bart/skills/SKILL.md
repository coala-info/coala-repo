---
name: bart
description: Bacterial Read Typer (BART) identifies sequence types and antimicrobial resistance genes directly from raw bacterial sequencing data without requiring assembly. Use when user asks to perform MLST typing, identify bacterial species schemes, or screen for AMR genes using raw reads.
homepage: https://github.com/tomdstanton/bart
---


# bart

## Overview

`bart` (Bacterial Read Typer) is a high-performance tool designed to identify the sequence type (ST) of bacterial samples directly from raw sequencing data. It is particularly useful for researchers who need to perform MLST without first assembling reads into contigs. The tool uses heuristics to automatically select the most appropriate MLST scheme for a given sample, though users can manually specify schemes if the species is already known. Beyond typing, `bart` includes functionality for rapid AMR gene detection using the NCBI AMRFinderPlus database.

## Command Line Usage

### Basic MLST Typing
The simplest usage allows `bart` to guess the scheme based on the input reads:
```bash
bart input.fq.gz > results.tab
```

### Specifying Read Types
By default, `bart` handles various sequencing formats. Use the `-r` flag to ensure correct processing:
- **Paired-end**: `bart sample_R1.fq.gz sample_R2.fq.gz -r pe`
- **Single-end**: `bart sample.fq.gz -r se`
- **Nanopore**: `bart sample.fq.gz -r ont`
- **Interleaved**: `bart sample.fq.gz -r int`

### Manual Scheme Selection
If the species is known, bypassing the heuristic selection saves time and improves accuracy:
1. List available schemes: `bart-update -s`
2. Run with specific scheme: `bart reads.fq.gz -s Staphylococcus_aureus`

### AMR Gene Screening
To screen for antimicrobial resistance genes instead of performing MLST, use the `-amr` flag. This uses the NCBI database to identify genes with specific identity and coverage metrics:
```bash
bart reads.fq.gz -amr > amr_results.tab
```

### Increasing Output Detail
- **Verbose (`-v`)**: Prints the top hit allele and alternative hits if they differ from the profile.
- **Verboser (`-vv`)**: Provides full mapping data including %identity, %coverage, and depth for every allele.

## Database Management

### Updating Schemes
Keep the MLST and AMR databases current to ensure compatibility with the latest nomenclature:
- Update PubMLST schemes: `bart-update -p`
- Update AMR index: `bart-update -amr`

### Custom Schemes
You can add proprietary or niche schemes by providing a FASTA file of alleles and a TAB-separated profile mapping file:
```bash
bart-update -a custom_scheme.fna custom_profiles.tab
```

## Interpreting Results

The output is a tab-separated line where alleles are presented as `gene(allele)`. Pay attention to the following symbols:
- **`?`**: Indicates a non-perfect hit (mismatch in sequence).
- **`~`**: Indicates a potential novel hit.
- **`-`**: Indicates no hit was found for that locus.

## Expert Tips
- **Thread Optimization**: Use `-t` to specify the number of threads (default is 4). For large batches of SRA data, increasing threads significantly reduces mapping time.
- **Filtering Hits**: Use `-p` to set a custom template percent identity cutoff (default is 95). Lowering this can help with highly divergent samples, while raising it increases stringency.
- **Interactive Profiling**: Use the `bart-profile` utility to manually check which ST corresponds to a specific set of alleles:
  ```bash
  bart-profile [scheme_name]
  ```

## Reference documentation
- [bart - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bart_overview.md)
- [tomdstanton/bart: bacterial read typer](./references/github_com_tomdstanton_bart.md)