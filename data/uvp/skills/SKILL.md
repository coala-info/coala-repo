---
name: uvp
description: UVP is a bioinformatics pipeline for analyzing *Mycobacterium tuberculosis* genomic data, automating read mapping, variant calling, and lineage assignment. Use when user asks to analyze *Mycobacterium tuberculosis* genomic data, map reads, call variants, assign lineage, annotate SNPs, or filter contamination.
homepage: https://github.com/CPTR-ReSeqTB/UVP
---


# uvp

## Overview

The Unified Variant Pipeline (UVP) is a specialized bioinformatics suite designed for the analysis of *Mycobacterium tuberculosis* complex (MTBC) genomic data. It automates a multi-step workflow—including read mapping, variant calling, and lineage assignment—by orchestrating tools such as BWA, GATK, and snpEff. It is specifically optimized for the H37Rv reference genome and requires significant computational resources (100GB RAM) for local execution.

## Environment Setup

Before running the pipeline, two manual setup steps are required due to licensing and database requirements:

1.  **GATK Registration**: UVP relies on GATK v3.6. After installing the package via Conda, you must manually register the GATK jar file:
    ```bash
    gatk-register GenomeAnalysisTK.jar
    ```
2.  **snpEff Database**: Download the specific *M. tuberculosis* annotation database:
    ```bash
    snpEff download m_tuberculosis_H37Rv
    ```

## Command Line Usage

### Basic Analysis
To run a standard analysis on paired-end data with variant annotation enabled:
```bash
uvp -n "Sample_ID" \
    -r "H37Rv_reference.fasta" \
    -q "reads_R1.fastq.gz" \
    -q2 "reads_R2.fastq.gz" \
    --annotate \
    --verbose
```

### Performance and Contamination Filtering
For production environments, specify CPU threads and a Kraken database to filter non-MTBC reads:
```bash
uvp -n "Sample_ID" \
    -r "reference.fasta" \
    -q "R1.fq" -q2 "R2.fq" \
    --krakendb "/path/to/minikraken" \
    --threads 16 \
    --annotate
```

## Key Parameters

| Flag | Description |
| :--- | :--- |
| `-n` | Sample name/identifier used for output files. |
| `-r` | Path to the H37Rv reference genome in FASTA format. |
| `-q` / `-q2` | Paths to the first and second (paired) FASTQ input files. |
| `--annotate` | Enables SNP annotation using snpEff. |
| `-k` | Path to the Kraken database for contamination detection. |
| `-t` | Number of CPU threads for parallel processing. |
| `-c` | Path to an optional configuration file to override defaults. |

## Expert Tips

*   **Memory Requirements**: Ensure the host system has at least 100GB of RAM available. The pipeline involves memory-intensive GATK and Picard operations.
*   **Input Formats**: While the tool documentation mentions `.fastq`, ensure your files are decompressed if you encounter "invalid literal" errors, as some versions of the underlying scripts have historically struggled with certain `.gz` headers.
*   **Reference Consistency**: Always use the H37Rv reference genome (NC_000962.3) to ensure lineage assignment logic and snpEff annotations remain compatible with the pipeline's internal logic.
*   **Configuration Overrides**: Use the `-c` flag to point to a custom configuration if you need to permanently set the `krakendb` path or thread count for a specific environment, avoiding long CLI strings.

## Reference documentation
- [UVP GitHub Repository](./references/github_com_CPTR-ReSeqTB_UVP.md)
- [Bioconda UVP Package Overview](./references/anaconda_org_channels_bioconda_packages_uvp_overview.md)