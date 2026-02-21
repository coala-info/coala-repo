---
name: nullarbor
description: Nullarbor is a "reads-to-report" pipeline designed for the rapid analysis of bacterial NGS data, specifically tailored for public health microbiology.
homepage: https://github.com/tseemann/nullarbor
---

# nullarbor

## Overview

Nullarbor is a "reads-to-report" pipeline designed for the rapid analysis of bacterial NGS data, specifically tailored for public health microbiology. It automates the complex orchestration of multiple bioinformatics tools—including Trimmomatic for cleaning, Kraken for identification, Prokka for annotation, and Snippy for variant calling—to produce a centralized HTML report. It is particularly effective for outbreak investigations where identifying genomic distances and strain relationships across a batch of isolates is the primary goal.

## Core Workflow

### 1. Environment Validation
Before starting a project, verify that all dependencies (Perl modules, binaries, and databases) are correctly installed and accessible.
```bash
nullarbor.pl --check
```

### 2. Input Preparation
Create a tab-separated `samples.tab` file. Each line represents one isolate with three columns: `ID`, `R1_fastq`, and `R2_fastq`.
```text
Isolate_01    /path/to/reads/01_R1.fq.gz    /path/to/reads/01_R2.fq.gz
Isolate_02    /path/to/reads/02_R1.fq.gz    /path/to/reads/02_R2.fq.gz
```

### 3. Project Initialization
Generate the analysis directory and the execution `Makefile`. You must provide a reference genome (FASTA or Genbank).
```bash
nullarbor.pl --name PROJECT_NAME --ref reference.gbk --input samples.tab --outdir output_dir
```
*Tip: Using a Genbank file (.gbk) as a reference allows Nullarbor to use existing annotations for SNP effect prediction.*

### 4. Execution
Nullarbor uses GNU Make to manage the workflow. Execute the pipeline using the generated Makefile in the output directory.
```bash
# Run with 8 threads
make -j 8 -C output_dir
```

## Advanced CLI Patterns

### Quick Outlier Detection
Before committing to a full run (which includes time-consuming assembly and pan-genome analysis), use the preview mode to generate a "rough" phylogenetic tree.
```bash
make -C output_dir preview
```
If outliers are identified, remove them from the `samples.tab` file, then run:
```bash
make -C output_dir again
make -C output_dir preview
```

### Prefilling Data
To avoid re-computing assemblies or annotations for isolates used in previous runs, use the `--prefill` option in your `nullarbor.conf` to point to existing `contigs.fa` files.

### Specific Genotyping
If the species is known, specify the MLST scheme to ensure accurate genotyping:
```bash
nullarbor.pl --mlst saureus [other_options]
```

## Expert Tips
- **Resource Management**: Nullarbor runs on a single compute node. Use the `-j` flag with `make` to specify the number of CPU cores.
- **Database Paths**: Ensure `KRAKEN_DEFAULT_DB` or `KRAKEN2_DEFAULT_DB` environment variables are set in your shell profile so Nullarbor can find the identification databases.
- **Supported Data**: Nullarbor 2.x only supports Illumina paired-end data. Do not attempt to use single-end reads or Ion Torrent data.
- **Cleaning Up**: If a run fails or needs to be restarted with different parameters, `make again` safely removes temporary files while keeping the core configuration.

## Reference documentation
- [Nullarbor GitHub Repository](./references/github_com_tseemann_nullarbor.md)
- [Bioconda Nullarbor Overview](./references/anaconda_org_channels_bioconda_packages_nullarbor_overview.md)