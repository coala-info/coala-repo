---
name: tomm40_wgs
description: The tomm40_wgs tool performs automated genotyping of the TOMM40'523 poly-T repeat from genomic alignment files. Use when user asks to genotype the TOMM40'523 poly-T repeat, determine TOMM40 S/L/VL status, or analyze TOMM40 poly-T repeat length.
homepage: https://github.com/RushAlz/TOMM40_WGS/
---


# tomm40_wgs

## Overview

The `tomm40_wgs` skill provides a specialized workflow for automated genotyping of the TOMM40'523 poly-T repeat. It transforms raw genomic alignment files into clinical/research categories by integrating multiple Short Tandem Repeat (STR) tools (HipSTR, GangSTR, ExpansionHunter) and k-mer analysis with a machine learning classifier. This tool is essential for researchers who need to determine the "S", "L", or "VL" status of the rs10524523 locus without manual inspection of sequencing reads.

## Installation and Environment

Install the tool via Bioconda to ensure all dependencies (Snakemake, Samtools, Jellyfish, etc.) are correctly managed:

```bash
conda install -c conda-forge -c bioconda tomm40_wgs
```

Note: Ensure `samtools` and `htslib` are version 1.21 for optimal compatibility with the latest pipeline releases.

## Core CLI Usage

The primary interface is the `TOMM40_WGS` launcher script.

### Single Sample Analysis
For a single BAM or CRAM file, provide the input and the corresponding reference genome:

```bash
TOMM40_WGS --input_wgs sample.bam --ref_fasta GRCh38.fa --cores 4
```

### Batch Processing
There are two primary ways to handle multiple samples:

1.  **Glob Pattern**: Use quotes to prevent shell expansion and allow the pipeline to handle the file list.
    ```bash
    TOMM40_WGS --input_wgs "*.bam" --ref_fasta GRCh38.fa --cores 8
    ```
2.  **Sample Table**: Provide a TSV file containing `sample_id` and `path` columns.
    ```bash
    TOMM40_WGS --input_table samples.tsv --ref_fasta GRCh38.fa --output_dir results_batch
    ```

### Working with Different Genome Builds
The tool defaults to GRCh38. If using hg19/b37 data, you must specify the build to ensure correct coordinate mapping:

```bash
TOMM40_WGS --input_wgs "path/to/*.bam" --ref_fasta hs37d5.fa --genome_build b37 --cores 4
```

## Best Practices and Expert Tips

-   **Reference Indexing**: Always ensure your reference FASTA file is indexed (`.fai`). If using CRAM files, the reference is mandatory for decompression.
-   **Resource Allocation**: The pipeline is built on Snakemake. Use the `--cores` flag to parallelize across samples.
-   **Output Interpretation**: The primary results are found in `results/predictions/tomm40_predictions_summary.tsv`.
    -   **Short (S)**: ≤19 T residues
    -   **Long (L)**: 20-29 T residues
    -   **Very Long (VL)**: ≥30 T residues
-   **Dry Runs**: Since this is a Snakemake wrapper, you can pass `--dryrun` to the command to validate your file paths and configuration before execution.
-   **Read Groups**: Ensure your BAM/CRAM files have proper Read Group (`@RG`) tags, specifically the Sample (`SM`) tag, as the pipeline uses these for identification.

## Reference documentation
- [TOMM40_WGS GitHub Repository](./references/github_com_RushAlz_TOMM40_WGS.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tomm40_wgs_overview.md)