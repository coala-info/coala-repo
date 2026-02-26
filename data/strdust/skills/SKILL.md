---
name: strdust
description: "STRdust genotypes tandem repeats and predicts consensus sequences from long-read sequencing data. Use when user asks to genotype specific repeat regions, screen for pathogenic expansions, or resolve complex repeat structures using long reads."
homepage: https://github.com/wdecoster/STRdust
---


# strdust

## Overview

STRdust is a specialized bioinformatics tool designed to genotype tandem repeats using long-read sequencing data (such as Oxford Nanopore or PacBio). Unlike tools that only report repeat counts, STRdust provides both the repeat length and the predicted consensus sequence in a standard VCF format. It is particularly effective for resolving large expansions and complex repeat structures that are often inaccessible to short-read sequencers.

## Core Workflows

### Targeted Genotyping
To genotype a specific genomic coordinate, use the `-r` or `--region` flag. Coordinates should be 1-based and inclusive.

```bash
STRdust -r chr7:154654404-154654432 reference.fa sample.cram > sample.vcf
```

### Batch Processing
For genotyping multiple loci simultaneously, provide a BED file (supports `.bed` or `.bed.gz`).

```bash
STRdust -R targets.bed reference.fa sample.bam | bgzip > repeats.vcf.gz
```

### Pathogenic Expansion Screening
STRdust includes a built-in mode to genotype known pathogenic STRs from the STRchive database. 
**Note:** This feature currently requires the **GRCh38** reference genome.

```bash
STRdust --pathogenic hg38.fa sample.bam > pathogenic_calls.vcf
```

### Handling Sex Chromosomes
For male samples or specific organisms, define haploid chromosomes to ensure correct genotype (GT) calls.

```bash
STRdust -R targets.bed --haploid chrX,chrY reference.fa male_sample.bam > output.vcf
```

## Parameter Optimization

| Parameter | Recommendation |
| :--- | :--- |
| `-m, --minlen` | Default is 5. Increase this value to ignore small indels and focus only on larger expansions. |
| `-s, --support` | Default is 3 reads. For low-coverage data, you may need to lower this, though it increases the risk of false positives. |
| `--unphased` | Use this if your BAM file has not been haplotagged (e.g., by Whatshap). STRdust will attempt to cluster reads into two haplotypes automatically. |
| `--consensus-reads` | Default is 20. Reducing this number (e.g., to 10) significantly speeds up processing at the cost of slightly less accurate ALT sequences. |

## Expert Tips

*   **Somatic Variation:** If you suspect somatic mosaicism or length variation within a single allele, use the `--somatic` flag. This adds the `SEQS` field to the VCF INFO column, containing the individual sequences from each supporting read.
*   **VCF Interpretation:**
    *   **FRB (Full Repeat Base):** The total length of the repeat in nucleotides for each allele.
    *   **RB (Relative Base):** The difference in length between the sample allele and the reference genome.
    *   **SC (Consensus Score):** A measure of how well the consensus sequence represents the underlying reads. Low scores may indicate high sequencing error rates or significant somatic variation.
*   **Performance:** When running on large BED files, always utilize the `-t` or `--threads` option to enable parallel processing.
*   **Input Requirements:** Ensure the reference FASTA is indexed (`.fai`) and the BAM/CRAM file is indexed (`.bai` or `.crai`).

## Reference documentation
- [STRdust GitHub Repository](./references/github_com_wdecoster_STRdust.md)
- [STRdust Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_strdust_overview.md)