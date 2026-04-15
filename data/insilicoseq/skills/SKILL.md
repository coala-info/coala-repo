---
name: insilicoseq
description: InSilicoSeq is a sequencing simulator that generates realistic Illumina reads by modeling error profiles from real sequencing data. Use when user asks to simulate Illumina sequencing reads, generate metagenomic datasets, or create custom error models from alignment files.
homepage: https://github.com/HadrienG/InSilicoSeq
metadata:
  docker_image: "quay.io/biocontainers/insilicoseq:2.0.1--pyh7cba7a3_0"
---

# insilicoseq

## Overview

InSilicoSeq is a Python-based sequencing simulator that produces realistic Illumina reads by utilizing kernel density estimators to model the quality of real sequencing data. Unlike basic simulators, it supports a full range of sequencing errors, including substitutions, insertions, and deletions. It is designed to handle both single-genome inputs and complex metagenomic populations, allowing users to generate FASTQ files that closely mimic data from specific Illumina instruments like MiSeq, HiSeq, and NovaSeq.

## Usage Instructions

### Generating Reads with Pre-computed Models
The most common use case is generating reads using the built-in error models.

```bash
# Generate 1 million reads using the MiSeq model
iss generate --genomes reference.fasta --model miseq --output my_simulation
```

**Key Parameters:**
- `--genomes (-g)`: Path to the (multi-)fasta file containing reference sequences.
- `--model (-m)`: Choose from `miseq`, `hiseq`, or `novaseq`.
- `--n_reads (-n)`: Number of reads to generate (e.g., `1m` for 1 million, `100k` for 100,000).
- `--output (-o)`: Prefix for the output FASTQ files.

### Automated Genome Retrieval
You can simulate a metagenome by downloading random genomes directly from NCBI.

```bash
# Generate 1 million reads from 10 random bacterial genomes
iss generate --ncbi bacteria -u 10 --model miseq --output ncbi_reads
```

### Creating Custom Error Models
If the pre-computed models do not match your specific sequencing run, you can build a custom model from an existing BAM file (reads aligned to a reference).

1. **Prepare the alignment:**
```bash
bowtie2-build ref.fasta ref
bowtie2 -x ref -1 R1.fastq.gz -2 R2.fastq.gz | samtools view -bS | samtools sort -o aligned.bam
samtools index aligned.bam
```

2. **Build the model:**
```bash
iss model -b aligned.bam -o custom_model
```
This produces a `custom_model.npz` file which can then be used in the `generate` command with `--model custom_model.npz`.

## Expert Tips and Best Practices

- **Metagenomic Abundance**: When using multi-fasta files, InSilicoSeq defaults to a metagenomic mode. You can control the abundance of different genomes by providing an abundance file.
- **Error Profiles**: Use the `miseq` model for shorter, higher-error reads typical of benchtop sequencers, and `novaseq` for high-throughput, lower-error production runs.
- **Computational Resources**: Generating tens of millions of reads can be memory-intensive. Ensure your environment has sufficient RAM, especially when building custom models from large BAM files.
- **Python Version**: Ensure you are using Python 3.5 or higher, as older versions are not supported.

## Reference documentation
- [InSilicoSeq GitHub Repository](./references/github_com_HadrienG_InSilicoSeq.md)
- [Bioconda InSilicoSeq Overview](./references/anaconda_org_channels_bioconda_packages_insilicoseq_overview.md)