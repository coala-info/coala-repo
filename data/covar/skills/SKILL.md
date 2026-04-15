---
name: covar
description: covar identifies physically linked clusters of mutations in viral genomic data to distinguish lineages in mixed environmental samples. Use when user asks to identify mutation clusters, analyze wastewater surveillance data, or translate nucleotide changes into amino acid mutations using GFF3 annotations.
homepage: https://github.com/andersen-lab/covar
metadata:
  docker_image: "quay.io/biocontainers/covar:0.3.0--h3dc2dae_0"
---

# covar

## Overview

`covar` is a specialized bioinformatics tool designed for wastewater surveillance and viral genomic analysis. While standard variant callers focus on individual SNPs, `covar` identifies "clusters" of mutations that are physically linked on the same read pair. This approach is critical for distinguishing between different viral lineages (such as SARS-CoV-2 variants) present in mixed environmental samples. It translates nucleotide changes into amino acid mutations using GFF3 annotations and provides frequency data for each detected cluster.

## Installation and Setup

The tool is primarily distributed via Bioconda and Cargo.

```bash
# Recommended: Install via Bioconda
conda install -c bioconda covar

# Alternative: Install via Cargo (Rust)
cargo install covar
```

## Core Command Usage

The tool requires three primary inputs: a BAM file, a reference FASTA, and a GFF3 annotation file.

### Basic Execution
```bash
covar -i sample.bam -r reference.fasta -a annotation.gff3 -o output.tsv
```

### Filtering and Quality Control
To reduce noise in environmental samples, use depth and quality thresholds:
*   `-d, --min_depth`: Minimum number of read pairs required for a cluster (default: 1).
*   `-f, --min_frequency`: Minimum frequency (cluster depth / total depth) to report (default: 0.001).
*   `-q, --min_quality`: Minimum base quality score (default: 20).

```bash
# High-stringency run
covar -i sample.bam -r ref.fasta -a annot.gff3 -d 5 -q 30 -f 0.01 -t 4
```

### Targeted Region Analysis
If you only need to analyze a specific gene or region (e.g., the Spike protein), use start and end coordinates:
```bash
covar -i sample.bam -r ref.fasta -a annot.gff3 -s 21563 -e 25384
```

## Expert Tips and Best Practices

1.  **BAM Preparation**: Input BAM files **must** be primer-trimmed, sorted, and indexed. Failure to trim primers will result in false-positive mutation calls at the ends of amplicons.
2.  **Amino Acid Translation Logic**: `covar` maintains a 1:1 relationship between nucleotide and amino acid mutations. If a single codon contains two SNPs that result in one amino acid change, the output will list the amino acid mutation twice (once for each SNP).
3.  **Handling Indels**: Frameshift indels are typically labeled as 'NA' in the amino acid column, while SNPs in codons that span across different reads may be marked as 'Unknown'.
4.  **Freyja Integration**: `covar` is the underlying engine for the `freyja covariants` command. If you are already using the Freyja suite for wastewater deconvolution, you can access `covar` functionality directly through that interface.
5.  **Performance**: Use the `-t` flag to specify threads. The tool is written in Rust and scales well with multi-threading during the read-pair processing phase.

## Output Column Reference

The resulting `.tsv` file contains:
*   `nt_mutations`: The specific nucleotide changes in the cluster.
*   `aa_mutations`: Corresponding amino acid changes (e.g., `S:K417N`).
*   `cluster_depth`: Number of read pairs supporting this specific combination.
*   `total_depth`: Total coverage at that genomic span.
*   `frequency`: The ratio of cluster depth to total depth.
*   `coverage_start/end`: The genomic range covered by the reads in that cluster.

## Reference documentation
- [covar GitHub Repository](./references/github_com_andersen-lab_covar.md)
- [covar Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_covar_overview.md)