---
name: liqa
description: "LIQA quantifies isoform-specific expression from long-read RNA-seq data. Use when user asks to quantify isoform expression, detect differential alternative splicing, or analyze long-read RNA-seq data for isoform levels."
homepage: https://github.com/WGLab/LIQA
---


# liqa

liqa/SKILL.md
```yaml
name: liqa
description: A statistical tool for quantifying isoform-specific expression from long-read RNA-seq data. Use when you need to analyze isoform expression levels, detect differential alternative splicing (DAS) events, or process long-read RNA-seq data with a focus on isoform quantification.
```
## Overview
LIQA is a statistical tool designed to quantify isoform expression and identify differential alternative splicing (DAS) events using long-read RNA-seq data. It leverages base-pair quality scores and isoform-specific read length information to assign weights to reads, offering a more nuanced approach than simple read count summarization. LIQA can also detect DAS events between different experimental conditions.

## Usage Instructions

LIQA operates on the command line and requires BAM-formatted long-read RNA-seq data and a reference annotation file.

### Core Functionality

The primary function of LIQA is to quantify isoform expression. The general command structure involves specifying input files and output directories.

### Input Requirements

*   **BAM File**: Long-read RNA-seq data aligned to a reference genome, provided in BAM format.
*   **Reference Annotation File**: A GTF or GFF3 file containing the reference transcriptome annotation.

### Basic Command Structure

While specific command-line arguments can vary, a typical workflow involves:

```bash
liqa --input_bam <path/to/your/reads.bam> --annotation <path/to/your/annotation.gtf> --output_dir <path/to/output/directory>
```

### Key Considerations and Best Practices

*   **Annotation Quality**: Ensure your reference annotation file is accurate and comprehensive for the organism and experiment.
*   **BAM File Preparation**: The input BAM file should be sorted and indexed for efficient processing. Tools like `samtools` can be used for this.
*   **Output Interpretation**: LIQA will generate various output files detailing isoform expression levels and potentially differential splicing analysis results. Familiarize yourself with the output formats to interpret the findings correctly.
*   **Resource Requirements**: Long-read RNA-seq data analysis can be computationally intensive. Ensure you have sufficient memory and processing power.

### Advanced Usage (Differential Splicing)

LIQA can also be used to detect differential alternative splicing (DAS) events between conditions. This typically involves providing multiple BAM files and corresponding condition labels.

```bash
liqa --input_bam <path/to/condition1.bam> --input_bam <path/to/condition2.bam> --annotation <path/to/your/annotation.gtf> --conditions condition1 condition2 --output_dir <path/to/output/directory>
```

Refer to the official documentation for detailed parameter explanations and advanced options.

## Reference documentation
- [LIQA Usage Documentation](./references/github_com_WGLab_LIQA.md)