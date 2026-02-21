---
name: arcas-hla
description: arcasHLA is a specialized tool for the fast and accurate in silico inference of HLA genotypes from RNA-sequencing data.
homepage: https://github.com/RabadanLab/arcasHLA
---

# arcas-hla

## Overview

arcasHLA is a specialized tool for the fast and accurate in silico inference of HLA genotypes from RNA-sequencing data. It supports both paired-end and single-end samples and covers HLA class I and class II genes. The tool works by extracting reads mapped to chromosome 6 and HLA decoys, then utilizing Kallisto for transcript quantification followed by an expectation-maximization algorithm to determine the most likely genotype. This skill should be used to guide the multi-step workflow of reference preparation, read extraction, and genotype prediction.

## Core Workflow

### 1. Reference Management
Before processing samples, ensure the HLA reference is initialized or updated to the latest IMGT/HLA database version.

```bash
# Update to the latest reference
arcasHLA reference --update

# Use a specific version (e.g., for reproducibility)
arcasHLA reference --version 3.24.0
```

### 2. Read Extraction
Extract HLA-related reads from a sorted and indexed BAM file. This step isolates reads from chromosome 6 and known HLA alternate loci.

```bash
# Standard paired-end extraction
arcasHLA extract /path/to/sample.bam -o ./output -t 8 -v

# Single-end extraction
arcasHLA extract --single /path/to/sample.bam -o ./output
```
*   **Tip**: Use the `--unmapped` flag if your aligner marks multimapping reads as unmapped; this is often recommended to capture all relevant HLA sequences.

### 3. Genotyping
Predict the HLA genotype from the extracted FASTQ files.

```bash
# Genotype specific genes with a population prior
arcasHLA genotype ./output/sample.extracted.1.fq.gz ./output/sample.extracted.2.fq.gz \
    -g A,B,C,DPB1,DQB1,DQA1,DRB1 \
    -p caucasian \
    -o ./output -t 8
```
*   **Populations**: Supported priors include `asian_pacific_islander`, `black`, `caucasian`, `hispanic`, `native_american`, and `prior` (default).
*   **Efficiency**: If you need to re-run genotyping (e.g., to change the population or gene list), you can input the intermediate `.alignment.p` file instead of the FASTQs to skip the alignment phase.

### 4. Partial Allele Inference (Optional)
After initial genotyping, you can refine results to predict partial alleles.

```bash
arcasHLA partial -G ./output/sample.genotype.json \
    ./output/sample.extracted.1.fq.gz ./output/sample.extracted.2.fq.gz \
    -o ./output
```

### 5. Merging Results
Combine JSON output files from multiple samples into a single summary file for downstream analysis.

```bash
arcasHLA merge --in_dir ./all_outputs --out sample_summary.json
```

## Best Practices and Expert Tips

*   **Input Requirements**: Input BAM files must be sorted. If an index (`.bai`) is missing, `arcasHLA extract` will attempt to create one using `samtools`.
*   **Single-End Data**: When processing single-end reads, you must provide the `--single` flag and should ideally specify the estimated fragment length (`-l`) and standard deviation (`-s`).
*   **Low Read Counts**: For samples with low coverage or single-end data, consider lowering the `--drop_iterations` parameter (default is 10 for paired, 4 for single) to prevent premature filtering of alleles.
*   **Zygosity**: The `--zygosity_threshold` (default 0.15) controls the ratio of minor to major allele counts. Adjust this if you suspect unusual heterozygosity patterns or have very high depth.
*   **Resource Management**: Use the `-t` or `--threads` flag across all commands to utilize multi-core processing, as Kallisto alignment is computationally intensive.

## Reference documentation
- [arcasHLA GitHub Repository](./references/github_com_RabadanLab_arcasHLA.md)
- [arcas-hla Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_arcas-hla_overview.md)