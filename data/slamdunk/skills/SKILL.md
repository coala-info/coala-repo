---
name: slamdunk
description: Slamdunk is a high-sensitivity pipeline designed to analyze SLAM-seq data by identifying and quantifying T-to-C conversions in RNA-seq reads. Use when user asks to process metabolic labeling data, map reads to a reference genome, call T-to-C conversions, perform quality control on SLAM-seq experiments, or visualize conversion patterns.
homepage: http://t-neumann.github.io/slamdunk
---


# slamdunk

## Overview
Slamdunk is a high-sensitivity pipeline designed to streamline the analysis of SLAM-seq data. It automates the identification and quantification of T-to-C conversions in RNA-seq reads, which serve as markers for newly synthesized transcripts. This skill provides guidance on using the core CLI components—`slamdunk`, `alleyoop`, and `splash`—to move from raw sequencing files to quantified metabolic labeling results.

## Core Workflow
The slamdunk suite consists of three primary command-line tools:
1.  **slamdunk**: The main processing pipeline for mapping and conversion calling.
2.  **alleyoop**: A utility tool for quality control, statistics, and data conversion.
3.  **splash**: A visualization tool for inspecting conversion patterns.

### 1. Primary Analysis with `slamdunk`
The `slamdunk` command handles the heavy lifting of the pipeline. It typically requires a reference genome (FASTA) and a set of 3' UTR annotations (BED).

**Common Pattern:**
```bash
slamdunk all -r <reference.fa> -b <utr_annotations.bed> -o <output_dir> <input_reads.fastq.gz>
```

**Key Parameters:**
- `all`: Runs the full pipeline (map, filter, snp, count).
- `-n <int>`: Number of threads to use for parallel processing.
- `-m <int>`: Maximum number of mismatches allowed in a read.
- `-mv <float>`: Minimum variant fraction for SNP calling.

### 2. Quality Control with `alleyoop`
Use `alleyoop` to validate the success of the labeling and the accuracy of the conversion calling.

**Essential QC Commands:**
- **Summary Stats**: `alleyoop summary -o <summary_output> <slamdunk_directory>`
- **Conversion Rates**: `alleyoop rates -r <reference.fa> -o <rates_output> <bam_file>`
  - *Tip*: Use this to check the background T-to-C conversion rate in non-labeled control samples.
- **U-Content Analysis**: `alleyoop utail -o <utail_output> <bam_file>`

### 3. Visualization with `splash`
`splash` generates plots to help interpret the distribution of conversions across your samples.

**Usage:**
```bash
splash -o <plot_output> <slamdunk_results.csv>
```

## Expert Tips & Best Practices
- **Reference Preparation**: Ensure your reference FASTA is indexed (`samtools faidx`). Slamdunk relies on precise coordinate mapping to identify T-to-C transitions.
- **3' UTR Focus**: SLAM-seq is most effective when focused on 3' UTRs. If your BED file is too broad (e.g., whole genes), the signal-to-noise ratio for T-to-C conversions may decrease.
- **Multimappers**: By default, slamdunk handles multimappers. If you have a highly repetitive genome, consider adjusting the mapping parameters to avoid over-counting conversions in ambiguous regions.
- **SNP Correction**: Always run the SNP calling step (included in `slamdunk all`) or provide a VCF file. This prevents genomic T-to-C SNPs from being incorrectly counted as metabolic labeling events.



## Subcommands

| Command | Description |
|---------|-------------|
| slamdunk all | Run SLAM-seq analysis |
| slamdunk filter | Filter BAM files based on various criteria. |
| slamdunk snp | Call SNPs from BAM files. |
| slamdunk_count | Count T>C conversions in BAM files. |
| slamdunk_map | Map sequencing reads to a reference genome. |

## Reference documentation
- [Slamdunk GitHub Repository](./references/github_com_t-neumann_slamdunk.md)
- [Slamdunk Documentation Home](./references/t-neumann_github_io_slamdunk.md)
- [Slamdunk Detailed Docs](./references/t-neumann_github_io_slamdunk_docs.html.md)