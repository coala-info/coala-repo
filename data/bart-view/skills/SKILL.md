---
name: bart-view
description: bart-view performs rapid bacterial characterization including species identification, MLST assignment, and AMR gene detection from raw genomic data. Use when user asks to identify bacterial species, perform MLST typing, screen for antimicrobial resistance genes, or look up MLST profiles.
homepage: https://github.com/tomdstanton/bart
metadata:
  docker_image: "biocontainers/bart-view:v0.1.00-2-deb_cv1"
---

# bart-view

## Overview
The `bart-view` skill enables efficient bacterial characterization from raw genomic data. `bart` (Bacterial Read Typer) is designed for speed and ease of use, employing heuristics to automatically select the most appropriate MLST scheme for a given set of reads. Beyond standard typing, it supports AMR gene detection using the NCBI AMRFinderPlus database and provides interactive tools for profile lookups. Use this skill to automate species identification and typing workflows without manual scheme selection.

## Core CLI Usage

### Bacterial Typing (MLST)
The primary command performs species identification and MLST assignment in a single step.

```bash
# Basic usage (automatic scheme selection)
bart input.fq.gz > results.tab

# Paired-end reads (using wildcards for R1/R2)
bart sample_R*.fastq.gz -r pe > results.tab
```

**Key Options:**
- `-r {pe,se,ont,int}`: Specify read type (paired-end, single-end, Oxford Nanopore, or interleaved).
- `-s [scheme]`: Bypass heuristics and force a specific scheme.
- `-p [95]`: Set the template percent identity cutoff (default is 95).
- `-t [threads]`: Set CPU threads (default is 4).

### AMR Gene Screening
To switch from MLST typing to screening for antimicrobial resistance genes:

```bash
bart input.fq.gz -amr > amr_results.tab
```

### Interpreting Output Alleles
`bart` uses specific notation in the results to indicate match quality:
- `gene(allele)`: Perfect match to the profile.
- `?`: Non-perfect hit.
- `~`: Potential novel hit.
- `-`: No hit found.

### Increasing Detail (Verbosity)
For troubleshooting or deep analysis of non-perfect matches:
- `-v`: Prints the top hit allele and alternative hits if they differ from the profile.
- `-vv`: "Verboser" mode; includes mapping data (percent identity, coverage, and depth) for the top hit.

## Database and Scheme Management
Use `bart-update` to maintain the local environment.

- **List available schemes**: `bart-update -s`
- **Update PubMLST schemes**: `bart-update -p`
- **Update AMR database**: `bart-update -amr`
- **Remove problematic schemes**: `bart-update -r [scheme_name]` (Useful if heuristics consistently pick an undesired variant, e.g., `Acinetobacter_baumannii#1`).

## Interactive Profile Lookup
Use `bart-profile` to query the MLST database without running the full pipeline.

- **Lookup ST by alleles**: Run `bart-profile [scheme]` and follow the interactive prompts to enter allele numbers.
- **Lookup alleles by ST**: `bart-profile [scheme] [ST_number]` (e.g., `bart-profile Staphylococcus_aureus 9`).

## Expert Tips
- **SRA Testing**: You can pipe SRA data directly into `bart` using `fastq-dump` for rapid verification of public datasets.
- **Custom Schemes**: You can add your own schemes by providing a FASTA file of alleles and a tab-separated profile mapping file: `bart-update -a scheme.fna scheme.tab`.
- **Log Files**: Always use `-l [path]` in production environments to generate a log file for auditability.

## Reference documentation
- [github_com_tomdstanton_bart.md](./references/github_com_tomdstanton_bart.md)
- [anaconda_org_channels_bioconda_packages_bart_overview.md](./references/anaconda_org_channels_bioconda_packages_bart_overview.md)