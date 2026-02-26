---
name: crispresso
description: CRISPResso is a bioinformatics pipeline that analyzes deep sequencing data to quantify genome editing efficiency and outcomes. Use when user asks to quantify insertions and deletions, distinguish between NHEJ and HDR outcomes, analyze CRISPR editing in coding sequences, or compare editing efficiency between treated and control samples.
homepage: https://github.com/lucapinello/CRISPResso
---


# crispresso

## Overview

CRISPResso is a specialized bioinformatics pipeline designed to transform raw sequencing data into actionable insights regarding genome editing efficiency. It automates the complex workflow of filtering low-quality reads, trimming adapters, merging paired-end sequences, and performing global alignments against a reference template. By using this skill, you can accurately quantify the distribution of insertions, deletions, and substitutions, as well as determine the impact of mutations on coding sequences (frameshifts vs. in-frame). It is particularly useful for researchers needing to distinguish between NHEJ and HDR outcomes in targeted deep sequencing experiments.

## Core CLI Usage

The CRISPResso suite consists of several tools tailored to different experimental designs.

### 1. Standard CRISPResso (Single Amplicon)
Use this for individual deep sequencing experiments.

**Basic NHEJ Quantification:**
```bash
CRISPResso -r1 reads_R1.fastq.gz -r2 reads_R2.fastq.gz -a [AMPLICON_SEQUENCE]
```

**HDR Quantification:**
Include the expected sequence after successful donor integration.
```bash
CRISPResso -r1 R1.fastq -r2 R2.fastq -a [REF_SEQ] -e [HDR_SEQ]
```

**Targeted Analysis with sgRNA:**
Providing the guide sequence (without PAM) allows CRISPResso to center the analysis on the predicted cleavage site.
```bash
CRISPResso -r1 R1.fastq -a [REF_SEQ] -g [sgRNA_SEQ]
```

### 2. CRISPRessoPooled
Use for experiments where multiple amplicons are sequenced in a single library. It requires a description file (typically a tab-delimited text file) mapping barcodes/indices to amplicons.

```bash
CRISPRessoPooled -r1 reads_R1.fastq.gz -r2 reads_R2.fastq.gz -f [DESCRIPTION_FILE]
```

### 3. CRISPRessoWGS
Use for analyzing editing in Whole Genome Sequencing (WGS) data or pre-aligned BAM files.

```bash
CRISPRessoWGS -b [MAPPED_READS.bam] -f [REGIONS_FILE] -r [REFERENCE_FASTA]
```

### 4. CRISPRessoCompare
Use to perform a direct statistical comparison between two CRISPResso runs (e.g., Treated vs. Control).

```bash
CRISPRessoCompare [OUTPUT_FOLDER_1] [OUTPUT_FOLDER_2]
```

## Expert Tips and Best Practices

- **Input Formatting**: Ensure the amplicon sequence (`-a`) does not contain trailing whitespaces or hidden characters, as these can cause alignment errors.
- **sgRNA Specification**: Always provide the sgRNA sequence *without* the PAM. CRISPResso uses this to define the "window" of interest for quantifying indels.
- **Quality Thresholds**: The default filtering uses Phred33. If your data has high background noise, adjust the quality filtering parameters to avoid false-positive indel calls.
- **Coding Sequences**: If your target is in a coding region, provide the CDS sequence using the `-c` flag. This enables the tool to produce a frameshift analysis report.
- **Dependency Management**: CRISPResso relies on `Trimmomatic`, `Flash`, and `Needle` (from the EMBOSS suite). If running in a custom environment, ensure these binaries are in your system PATH or set the `CRISPRESSO_DEPENDENCIES_FOLDER` environment variable.
- **Output Interpretation**: The primary output is a graphical report. Key files to inspect include the `Quantification_of_editing_outcomes.pdf` and the `Alleles_around_cut_site.txt` for specific sequence variants.

## Reference documentation
- [CRISPResso Overview](./references/anaconda_org_channels_bioconda_packages_crispresso_overview.md)
- [CRISPResso GitHub Repository](./references/github_com_lucapinello_CRISPResso.md)