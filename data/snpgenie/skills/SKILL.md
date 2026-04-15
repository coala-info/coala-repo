---
name: snpgenie
description: SNPGenie calculates nucleotide diversity and its nonsynonymous and synonymous partitions from single-nucleotide polymorphism data. Use when user asks to estimate dN/dS ratios, analyze evolutionary diversity within pooled samples, or compare genetic variation between groups using VCF or FASTA files.
homepage: https://github.com/chasewnelson/SNPGenie
metadata:
  docker_image: "quay.io/biocontainers/snpgenie:1.0--hdfd78af_1"
---

# snpgenie

## Overview

SNPGenie is a specialized suite of Perl scripts designed to calculate nucleotide diversity and its nonsynonymous/synonymous partitions from single-nucleotide polymorphism (SNP) data. It allows researchers to interpret the evolutionary significance of variant calls by integrating reference sequences, CDS annotations (GTF), and SNP reports. The tool is particularly useful for analyzing pooled samples where individual genotypes are unknown but allele frequencies are available.

## Core Analysis Modes

SNPGenie provides three primary scripts depending on the study design:

1.  **Within-Pool Analysis (`snpgenie.pl`)**: Analyzes diversity within a single pooled sample.
2.  **Within-Group Analysis (`snpgenie_within_group.pl`)**: Calculates dN/dS among aligned sequences in a FASTA file (similar to MEGA but automated).
3.  **Between-Group Analysis (`snpgenie_between_group.pl`)**: Compares two or more groups of aligned sequences.

## Input Requirements

For a successful run, ensure the following files are present in your working directory:
*   **Reference FASTA**: A single file containing exactly one reference sequence.
*   **GTF File**: Must contain "CDS" features. The `gene_id` or product name must match the identifiers in your SNP reports.
*   **SNP Report**: Supports VCF, CLC, or Geneious formats.

## Common CLI Patterns

### Within-Pool VCF Analysis
When using VCF files, you must specify the format version (usually 4).
```bash
snpgenie.pl --vcfformat=4 --snpreport=my_variants.vcf --fastafile=reference.fa --gtffile=annotations.gtf
```

### Within-Group Analysis with Bootstrapping
For aligned sequences, you can enable parallel processing and bootstrapping for statistical confidence.
```bash
snpgenie_within_group.pl --fasta_file_name=aligned.fa --gtf_file_name=annotations.gtf --num_bootstraps=10000 --procs_per_node=8
```

## Expert Tips and Best Practices

### Handling Reverse Strand ('-') Features
SNPGenie processes one strand at a time. If your genes are on the negative strand:
1.  Convert your inputs using the provided utility scripts: `fasta2revcom.pl`, `gtf2revcom.pl`, and `vcf2revcom.pl`.
2.  Run SNPGenie separately on these reverse-complemented files.

### VCF Format Specifics
If the script fails to parse your VCF, verify the `--vcfformat` argument. Format 4 is standard for most modern callers (like GATK or LoFreq), but custom formats may require manual inspection of the tab-delimited columns.

### GTF Formatting
*   Ensure the third column is labeled exactly as `CDS`.
*   The script concatenates multiple segments (exons) for the same `gene_id` automatically.
*   Avoid non-word characters in `gene_id` fields to prevent parsing errors.

### Downstream Analysis
*   **Sliding Windows**: Use `SNPGenie_sliding_windows.R` on the output files to visualize diversity across genomic coordinates.
*   **Tajima's D**: Use `Tajima_D.R` for neutrality testing based on the SNPGenie output.



## Subcommands

| Command | Description |
|---------|-------------|
| snpgenie.pl | SNPGenie: Estimating Evolutionary Parameters from SNPs! |
| snpgenie_fasta2revcom.pl | Converts a '+' strand FASTA file to its reverse complement. |
| snpgenie_gtf2revcom.pl | Converts a '+' strand GTF file to its reverse complement representation. |
| snpgenie_snpgenie_within_group.pl | SNPGenie terminated. |
| snpgenie_vcf2revcom.pl | Converts a VCF format 1 SNP report to a reverse complement sequence. |

## Reference documentation
- [SNPGenie Main Documentation](./references/github_com_chasewnelson_SNPGenie.md)
- [SNPGenie Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_snpgenie_overview.md)