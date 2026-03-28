---
name: crispresso
description: CRISPResso is a bioinformatics pipeline that processes raw sequencing data to quantify genome editing efficiency and mutation distributions. Use when user asks to analyze CRISPR/Cas9 outcomes from deep sequencing data, quantify NHEJ or HDR, compare treated versus control samples, or process pooled amplicon and whole-genome sequencing libraries.
homepage: https://github.com/lucapinello/CRISPResso
---


# crispresso

## Overview

CRISPResso is a specialized bioinformatics pipeline designed to transform raw sequencing data into actionable insights regarding genome editing efficiency. It automates the processing of FASTQ files by performing quality filtering, adapter trimming, and sequence merging before aligning reads to a user-defined reference. Use this skill to determine the correct sub-tool for your experimental design—whether single amplicons, pooled libraries, or whole-genome sequencing—and to accurately quantify mutation distributions, frameshifts, and splice-site disruptions.

## Core Command Line Usage

### Standard CRISPResso (Single Amplicon)
Use this for individual target sites. It requires at least one FASTQ file and a reference amplicon sequence.

```bash
# Basic NHEJ quantification (Paired-end)
CRISPResso -r1 reads_R1.fastq.gz -r2 reads_R2.fastq.gz -a [AMPLICON_SEQUENCE]

# HDR quantification
# Include the expected sequence after successful repair
CRISPResso -r1 reads_R1.fastq.gz -r2 reads_R2.fastq.gz -a [REF_SEQ] -e [HDR_SEQ]

# Targeted analysis around a guide RNA
# Provide the sgRNA sequence without the PAM to center the analysis
CRISPResso -r1 reads_R1.fastq.gz -a [REF_SEQ] -g [sgRNA_SEQUENCE]
```

### Specialized Utilities
*   **CRISPRessoPooled**: Use for experiments involving multiple amplicons sequenced together.
*   **CRISPRessoWGS**: Use for analyzing genome editing in Whole Genome Sequencing data or pre-aligned `.bam` files.
*   **CRISPRessoCompare**: Use to perform a direct statistical comparison between two samples (e.g., Treated vs. Control).
    ```bash
    CRISPRessoCompare folder_sample1 folder_sample2
    ```

## Expert Tips and Best Practices

*   **Input Formatting**: Ensure the amplicon sequence (`-a`) does not contain trailing whitespaces or hidden characters, as these can cause alignment failures.
*   **Guide RNA Centering**: Always provide the sgRNA sequence (`-g`) when possible. This allows CRISPResso to center its quantification window on the predicted cleavage site, reducing noise from sequencing errors far from the cut site.
*   **Coding Sequence Analysis**: If the target is within a coding region, provide the cDNA sequence using the `-c` parameter. This enables the tool to produce frameshift vs. in-frame mutation reports.
*   **Quality Filtering**: CRISPResso uses Phred33 by default. If working with older Illumina data, verify the encoding.
*   **Successor Note**: While this skill covers the original CRISPResso suite, be aware that CRISPResso2 is the updated version recommended for most new projects due to improved performance and features.
*   **Dependency Management**: The tool relies on `FLASha` for merging and `needle` (from the EMBOSS suite) for global alignment. If the tool fails, verify these binaries are in your system PATH.



## Subcommands

| Command | Description |
|---------|-------------|
| CRISPResso | Analysis of CRISPR/Cas9 outcomes from deep sequencing data |
| CRISPRessoCompare | Comparison of two CRISPResso analysis |
| CRISPRessoPooled | Analysis of CRISPR/Cas9 outcomes from POOLED deep sequencing data |
| CRISPRessoWGS | Analysis of CRISPR/Cas9 outcomes from WGS data |

## Reference documentation
- [CRISPResso GitHub Repository](./references/github_com_lucapinello_CRISPResso.md)
- [CRISPResso Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_crispresso_overview.md)