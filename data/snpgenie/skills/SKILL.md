---
name: snpgenie
description: SNPGenie calculates nucleotide diversity and nonsynonymous/synonymous partitions to identify selective pressures in genomic data. Use when user asks to calculate dN/dS ratios, analyze evolutionary metrics in pooled sequencing data, or identify selective pressures in viral and microbial populations.
homepage: https://github.com/chasewnelson/SNPGenie
---


# snpgenie

## Overview
SNPGenie is a specialized toolkit for population genetics that calculates nucleotide diversity and its nonsynonymous/synonymous partitions. It is particularly useful for identifying selective pressures (positive or purifying selection) in viral or microbial populations where pooled sequencing is common. The tool processes variant calls (VCF, CLC, or Geneious) alongside reference genomes and gene annotations to provide site-specific and gene-level evolutionary metrics.

## Core Workflows

### 1. Within-Pool Analysis (Pooled NGS Data)
Use `snpgenie.pl` to analyze diversity within a single population sample.
```bash
snpgenie.pl --vcfformat=4 --snpreport=variants.vcf --fastafile=reference.fa --gtffile=annotations.gtf
```

### 2. Within-Group Analysis (Aligned FASTA)
Use `snpgenie_within_group.pl` for traditional dN/dS analysis among multiple aligned sequences.
```bash
snpgenie_within_group.pl --fasta_file_name=aligned.fa --gtf_file_name=annotations.gtf --num_bootstraps=10000 --procs_per_node=8
```

### 3. Between-Group Analysis
Use `snpgenie_between_group.pl` to compare two or more groups of aligned sequences.

## Input Requirements and Best Practices

### VCF Formatting
The `--vcfformat` argument is mandatory for VCF inputs. 
- **Format 4**: The most common format for modern SNP callers.
- **Validation**: Ensure the VCF contains the necessary depth (DP) and allele depth (AD) fields if calculating frequency-based measures.

### GTF Requirements
- **Feature Type**: Every coding element must be labeled as "CDS" in the third column.
- **Attributes**: Product names must follow a `gene_id` tag.
- **Redundancy**: Only one transcript per gene should be included. If a gene has multiple exons, use the same `gene_id` for all segments; SNPGenie will concatenate them.

### Handling Reverse Strand ('-') Genes
SNPGenie processes strands separately. For genes on the negative strand:
1. Generate reverse-complement versions of your FASTA, GTF, and SNP reports.
2. Use the provided helper scripts: `fasta2revcom.pl`, `gtf2revcom.pl`, and `vcf2revcom.pl`.
3. Run the analysis specifically using these reverse-complemented files.

### Reference Sequence
- The FASTA file must contain exactly **one** reference sequence.
- If working with multi-sequence FASTA files (e.g., multiple chromosomes or segments), split them into individual files before running SNPGenie.

## Expert Tips
- **Minimum Allele Frequency**: Use the frequency trimming options to filter out low-confidence variants that may be sequencing artifacts.
- **Sliding Windows**: For localized selection analysis, utilize the `SNPGenie_sliding_windows.R` script on the output files to visualize diversity across genomic regions.
- **Parallelism**: When running bootstraps for within-group analysis, always set `--procs_per_node` to match your available CPU cores to significantly reduce computation time.
- **File Organization**: Keep the SNP report, FASTA, and GTF in the same working directory to avoid path resolution issues, as the tool often expects local file access.

## Reference documentation
- [SNPGenie GitHub README](./references/github_com_chasewnelson_SNPGenie.md)
- [Bioconda SNPGenie Overview](./references/anaconda_org_channels_bioconda_packages_snpgenie_overview.md)