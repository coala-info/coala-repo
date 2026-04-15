---
name: pmdtools
description: pmdtools quantifies and utilizes chemical degradation patterns in ancient DNA to separate authentic molecules from modern contaminants. Use when user asks to visualize deamination patterns, compute terminal damage frequencies, or filter sequences based on PMD scores to decontaminate ancient genomes.
homepage: https://github.com/pontussk/PMDtools
metadata:
  docker_image: "quay.io/biocontainers/pmdtools:0.60--hdfd78af_3"
---

# pmdtools

## Overview
pmdtools is a specialized utility for paleogenomics designed to quantify and utilize the chemical degradation patterns characteristic of ancient DNA. It primarily focuses on cytosine-to-thymine (C->T) deamination at the ends of DNA fragments. By modeling these damage patterns alongside base quality scores and biological polymorphism, the tool can assign a "PMD score" to individual sequences, allowing researchers to statistically separate authentic ancient molecules from modern contaminants.

## Core Workflows

### 1. Visualizing Damage Patterns
To generate a table of deamination-derived damage patterns (mismatches by position), pipe SAM data from samtools into pmdtools.

```bash
# Basic deamination table
samtools view input.bam | python pmdtools.py --deamination

# Advanced table for plotting (separating CpG sites)
samtools view input.bam | python pmdtools.py --platypus --requirebaseq 30 > damage_stats.txt
```

### 2. Statistical Screening
For rapid screening of multiple libraries, compute the deamination frequency at the 5' terminal position with a binomial standard error.

```bash
# Standard estimate
samtools view input.bam | python pmdtools.py --first --requirebaseq 30

# UDG/USER-treated data (restricting to CpG sites for mammalian nuclear DNA)
samtools view input.bam | python pmdtools.py --first --requirebaseq 30 --CpG
```

### 3. Decontaminating Ancient Genomes
Filter for sequences that show high confidence of being ancient using the likelihood framework. A PMD score threshold of 3 is a common standard for identifying degraded DNA.

```bash
# Filter by PMD score (Threshold 3)
samtools view -h input.bam | python pmdtools.py --threshold 3 --header | samtools view -Sb - > filtered_ancient.bam

# Simple filtering by terminal C->T mismatches
samtools view -h input.bam | python pmdtools.py --customterminus 0,-1 --header | samtools view -Sb - > filtered_simple.bam
```

## Expert Tips and Best Practices

- **MD Tag Requirement**: pmdtools requires the `MD` tag in the SAM input to identify mismatches against the reference. If your aligner did not produce them, use `samtools calmd` to add them before processing.
- **Library Type**: By default, the tool assumes double-stranded libraries (looking for G->A at the 3' end). If using single-stranded libraries, always include the `--ss` flag to look for C->T mismatches at both ends.
- **Quality Control**: Use `--requirebaseq` (typically 30) to ensure that observed mismatches are likely due to DNA damage rather than sequencing errors.
- **Header Preservation**: When filtering to create a new BAM file, always use the `--header` flag in pmdtools and the `-h` flag in `samtools view` to ensure the resulting file remains valid and includes the necessary metadata.
- **R Plotting**: The tool includes a helper script `plotPMD.v2.R`. After generating a stats file with `--platypus`, you can visualize the damage curves by running `R CMD BATCH plotPMD.v2.R`.

## Reference documentation
- [pmdtools GitHub Repository](./references/github_com_pontussk_PMDtools.md)
- [pmdtools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pmdtools_overview.md)