---
name: srst2
description: SRST2 identifies genetic profiles, sequence types, and resistance markers by mapping raw Illumina reads directly against known allele and gene databases. Use when user asks to perform multi-locus sequence typing, detect antimicrobial resistance or virulence genes, and screen bacterial pathogens for specific genetic markers.
homepage: https://github.com/katholt/srst2
metadata:
  docker_image: "biocontainers/srst2:v0.2.0-6-deb_cv1"
---

# srst2

## Overview
SRST2 (Short Read Sequence Typing for Bacterial Pathogens) is a specialized tool for identifying the genetic profile of bacteria using raw Illumina sequence data. Instead of relying on de novo assembly, which can be error-prone or require high coverage, SRST2 maps reads directly against known databases of alleles and genes. This makes it highly effective for determining Sequence Types (ST) and detecting resistance or virulence markers even in low-depth sequencing runs.

## Basic Usage Patterns

### Multi-Locus Sequence Typing (MLST)
To determine the ST of a sample using paired-end reads, you need the MLST database (FASTA) and the corresponding definitions file (profiles).

```bash
srst2 --input_pe sample_R1.fastq.gz sample_R2.fastq.gz \
  --mlst_db species_mlst.fasta \
  --mlst_definitions species_profiles.txt \
  --mlst_delimiter "_" \
  --output sample_mlst_report
```

### Gene Detection (Resistance/Virulence)
To screen for specific genes (e.g., AMR genes) without performing MLST:

```bash
srst2 --input_pe sample_R1.fastq.gz sample_R2.fastq.gz \
  --gene_db resistance_genes.fasta \
  --output sample_gene_report
```

### Combined Analysis
You can run MLST and gene typing simultaneously in a single command:

```bash
srst2 --input_pe R1.fastq R2.fastq \
  --mlst_db mlst.fasta --mlst_definitions profiles.txt --mlst_delimiter "_" \
  --gene_db genes.fasta \
  --output combined_results
```

## Database Preparation
SRST2 requires specific database formats. Use the included helper scripts to fetch and format data from public repositories like PubMLST.

- **Fetch MLST data**: Use `getmlst.py` to download the required files for a specific organism.
- **Clustered Gene Databases**: For gene typing, it is often better to use a clustered database (e.g., 80% identity) to avoid redundant hits.

## Expert Tips and Best Practices

- **Samtools Version**: For optimum results, especially at low read depths (<20x), use **Samtools v0.1.18**. Later versions may result in a slight loss of reads at the ends of alleles due to changes in mapping algorithms.
- **Performance**: Use the `--threads` option to parallelize the Bowtie2 mapping step, which is the most computationally intensive part of the workflow.
- **Read Mapping**: SRST2 automatically handles both `.fastq` and `.fastq.gz` files.
- **Output Interpretation**:
    - `*.results.txt`: Summary of MLST and gene hits.
    - `*.genes.txt`: Detailed table of gene hits including coverage and depth.
    - `*.full_genes.txt`: All hits including those that did not meet the reporting thresholds.
- **Environment Variables**: You can set `SRST2_SAMTOOLS` and `SRST2_BOWTIE2` environment variables to point to specific versions of the dependencies if they are not in your default PATH.

## Reference documentation
- [SRST2 Main Documentation](./references/github_com_katholt_srst2.md)