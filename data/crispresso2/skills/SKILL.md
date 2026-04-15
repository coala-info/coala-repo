---
name: crispresso2
description: CRISPResso2 is a bioinformatics pipeline that analyzes genome editing outcomes by quantifying insertions, deletions, and substitutions from sequencing data. Use when user asks to evaluate CRISPR-Cas9 editing frequency, analyze base editing or prime editing experiments, compare treated samples to controls, or process pooled amplicon sequencing data.
homepage: https://github.com/pinellolab/CRISPResso2
metadata:
  docker_image: "quay.io/biocontainers/crispresso2:2.3.3--py39hff726c5_0"
---

# crispresso2

## Overview

CRISPResso2 is a specialized bioinformatics pipeline designed to transform raw sequencing data into actionable insights regarding genome editing outcomes. It automates the complex process of aligning reads to a reference sequence, distinguishing between modified and unmodified reads, and quantifying specific types of edits such as insertions, deletions, and substitutions. This skill enables the efficient execution of the CRISPResso2 suite to evaluate editing frequency, compare experimental conditions, and generate high-quality visualizations for CRISPR-Cas9, base editing, and prime editing experiments.

## Core Tool Suite

The CRISPResso2 package includes several specialized tools for different experimental designs:

- **CRISPResso**: The primary tool for analyzing a single amplicon from one or two FASTQ files.
- **CRISPRessoBatch**: Used for high-throughput analysis of multiple experimental conditions or samples at the same genomic site.
- **CRISPRessoPooled**: Designed for pooled amplicon sequencing experiments where multiple different amplicons are sequenced together.
- **CRISPRessoWGS**: Analyzes specific target sites within whole-genome sequencing (WGS) datasets.
- **CRISPRessoCompare**: Performs a comparative analysis between two samples, typically a treated sample and a control.
- **CRISPRessoAggregate**: Combines results from multiple previously completed CRISPResso runs into a single summary.

## Common CLI Patterns

### Basic Amplicon Analysis
To analyze a single-end or paired-end sequencing run against a reference:
```bash
CRISPResso --fastq_r1 reads_R1.fastq.gz --fastq_r2 reads_R2.fastq.gz --amplicon_seq [SEQUENCE] --guide_seq [GUIDE]
```

### HDR Quantification
When providing an expected donor sequence for Homology-Directed Repair (HDR) analysis:
```bash
CRISPResso -r1 reads.fq.gz -a [AMPLICON] -g [GUIDE] -e [HDR_EXPECTED_SEQUENCE]
```

### Base Editing Analysis
For base editing experiments, use the specific output parameters to track substitutions:
```bash
CRISPResso -r1 reads.fq.gz -a [AMPLICON] -g [GUIDE] --base_editor_output
```

### Batch Processing
Process multiple samples defined in a comma-separated or tab-separated file:
```bash
CRISPRessoBatch --batch_settings batch_params.csv
```

## Expert Tips and Best Practices

- **Sequence Input**: Ensure the `--amplicon_seq` matches the expected sequence in the FASTQ files exactly. If using paired-end reads, the amplicon should cover the entire region where the reads overlap.
- **Guide Specification**: Provide the `--guide_seq` without the PAM sequence unless specifically analyzing PAM-proximal mutations. The tool uses the guide to center its quantification window (typically 1bp to 4bp upstream of the PAM).
- **Quality Filtering**: Use `--min_average_read_quality` (default is 0) to filter out low-quality reads before alignment to reduce noise in mutation calling.
- **Window Adjustment**: For larger deletions or distal editing (like with some Cpf1/Cas12a guides), adjust the `--quantification_window_size` to ensure all relevant edits are captured.
- **File Path Management**: Avoid spaces in file paths or extremely long filenames, as these can cause execution errors in the underlying alignment tools (like Bowtie2 or Needle).
- **Output Interpretation**:
    - **Allele Plots**: Use these to visualize the most frequent mutation patterns.
    - **Modification Summary**: Check the "Nucleotide_percentage_quilt" to see the distribution of substitutions across the guide region.
    - **BAM Files**: Use the `--bam_output` flag to generate alignment files for manual inspection in IGV (Integrative Genomics Viewer).

## Reference documentation
- [CRISPResso2 GitHub Repository](./references/github_com_pinellolab_CRISPResso2.md)
- [CRISPResso2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_crispresso2_overview.md)