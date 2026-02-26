---
name: ariba
description: ARIBA identifies antimicrobial resistance genes and performs multi-locus sequence typing by executing local assemblies of sequencing reads against reference databases. Use when user asks to identify antibiotic resistance genes, perform local assembly of sequencing reads, run MLST calling, or summarize resistance gene reports across multiple samples.
homepage: https://github.com/sanger-pathogens/ariba
---


# ariba

## Overview
ARIBA (Antimicrobial Resistance Identification By Assembly) is a bioinformatics pipeline that identifies antibiotic resistance genes by performing local assemblies of sequencing reads. Unlike simple read-mapping approaches, ARIBA clusters reads around reference sequences and assembles them to provide a detailed report on the presence of genes, their assembly quality, and any specific variants or mutations found. It is a robust choice for researchers needing to distinguish between closely related alleles or identify novel mutations in known resistance genes.

## Core Workflow

### 1. Obtain Reference Data
Download a specific database (e.g., CARD, NCBI, MegaRes, ResFinder).
```bash
ariba getref card out.card
```

### 2. Prepare the Reference
Format the downloaded sequences for the ARIBA pipeline.
```bash
ariba prepareref -f out.card.fa -m out.card.tsv out.card.prepareref
```
**Expert Tip:** Always check the stderr and log files after this step. ARIBA automatically removes inconsistent or poor-quality data; if a gene you expect is missing later, it was likely filtered out here.

### 3. Execute Local Assembly
Run the pipeline using paired-end FASTQ files.
```bash
ariba run out.card.prepareref reads_1.fastq reads_2.fastq out.run
```

### 4. Aggregate Results
Summarize multiple ARIBA runs into a single report for comparative analysis.
```bash
ariba summary out.summary out.run1/report.tsv out.run2/report.tsv out.run3/report.tsv
```

## MLST Calling
ARIBA can also perform Multi-Locus Sequence Typing.
1. **Identify species:** `ariba pubmlstspecies`
2. **Download data:** `ariba pubmlstget "Escherichia coli" out.mlst`
3. **Prepare:** `ariba prepareref --is_mlst out.mlst.fa out.mlst.prepareref` (Note: MLST usually doesn't require the `-m` metadata file if using `pubmlstget`).
4. **Run:** Use the standard `ariba run` command.

## Performance and Environment Optimization

### Managing Temporary Files
ARIBA generates many small temporary files. On high-performance computing (HPC) clusters, this can cause filesystem latency.
- Use the `--tmp_dir <path>` flag to point to local node storage (e.g., `/tmp` or `/scratch`).
- Alternatively, set the environment variable: `export ARIBA_TMPDIR=/path/to/fast/disk`.

### Custom Executables
If specific versions of dependencies are required, use environment variables to override the default system path:
- `export ARIBA_BOWTIE2=/path/to/bowtie2`
- `export ARIBA_CDHIT=cdhit-est`

## Interpreting Results
- **Report File:** The `report.tsv` contains a `flag` column. Use `ariba flag <number>` to translate the numerical flag into a human-readable explanation of the assembly/mapping status.
- **Visualization:** The output of `ariba summary` includes `.phandango.csv` and `.phandango.tre` files. These can be dragged directly into [Phandango](https://jameshadfield.github.io/phandango/) for interactive web-based visualization of the resistance gene distribution across your samples.

## Reference documentation
- [ARIBA GitHub Repository](./references/github_com_sanger-pathogens_ariba.md)
- [ARIBA Wiki and Task Guide](./references/github_com_sanger-pathogens_ariba_wiki.md)