---
name: pywgsim
description: pywgsim is a Python-wrapped tool that simulates paired-end sequencing reads with controlled genomic variations and sequencing errors. Use when user asks to simulate short reads from a reference genome, generate ground truth datasets with specific mutation rates, or produce a fixed number of reads per contig.
homepage: https://github.com/ialbert/pywgsim
---


# pywgsim

## Overview
pywgsim is a Python-wrapped enhancement of the `wgsim` short-read simulator. It generates paired-end reads while introducing controlled sequencing errors and genomic variations (SNPs and indels). Key improvements over the original tool include a standardized read-naming convention using pipe separators, the ability to output simulated mutations in GFF3 format for easy downstream comparison, and a "fixed" mode that ensures every contig in a multi-fasta file produces the same number of reads regardless of its length.

## Common CLI Patterns

### Basic Read Simulation
To generate a standard set of 1,000 read pairs (70bp each) from a reference genome:
```bash
pywgsim reference.fa read1.fq read2.fq
```

### Simulating Specific Library Profiles
Adjust the insert size and read lengths to match specific sequencing protocols (e.g., 150bp paired-end with a 300bp insert):
```bash
pywgsim -N 1000000 -1 150 -2 150 -D 300 -s 30 reference.fa r1.fq r2.fq
```

### Generating Ground Truth for Classifiers
Use the `--fixed` (or `-f`) flag to generate exactly N reads for every chromosome/contig in the file. This is essential for evaluating how well a tool performs across different sequences without length bias:
```bash
pywgsim -f -N 5000 reference.fa r1.fq r2.fq
```

### Controlling Mutation Rates
Fine-tune the biological variation introduced into the simulated reads:
- `-r 0.001`: Mutation rate (default 0.1%).
- `-R 0.15`: Fraction of mutations that are indels.
- `-X 0.25`: Probability an indel is extended.

## Expert Tips and Best Practices

### Interpreting the GFF Output
pywgsim automatically generates a GFF3 file describing the mutations. 
- **Heterozygous (het):** Represented as `A/R` (Ref/Alt).
- **Homozygous (hom):** Represented as `G/A` (where both alleles differ from the reference).
- **Indels:** Represented with `-` (e.g., `G/-` for a deletion).

### Understanding Read Names
The tool uses a specific naming convention: `@Contig|Start|End|Read1_Stats|Read2_Stats|PairID`.
The stats fields (`errors:substitutions:indels`) allow you to immediately identify why a read might fail to map or call correctly without looking at the GFF.

### Handling Ambiguous Bases
If your reference contains many `N` bases, use the `-A` flag. By default, pywgsim disregards reads if the fraction of ambiguous bases is higher than 0.05. Increase this if working with highly repetitive or poorly assembled genomes.

### Python API Usage
For integration into larger Python scripts, use the `wgsim.core` function:
```python
from pywgsim import wgsim
wgsim.core(r1="out1.fq", r2="out2.fq", ref="gen.fa", N=10000, is_fixed=1)
```

## Reference documentation
- [pywgsim GitHub Repository](./references/github_com_ialbert_pywgsim.md)
- [pywgsim Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pywgsim_overview.md)