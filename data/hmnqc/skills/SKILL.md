---
name: hmnqc
description: The `hmnqc` tool is a specialized bioinformatics utility for assessing the quality and integrity of targeted NGS datasets.
homepage: https://github.com/guillaume-gricourt/HmnQc
---

# hmnqc

---

## Overview

The `hmnqc` tool is a specialized bioinformatics utility for assessing the quality and integrity of targeted NGS datasets. It streamlines the generation of standardized metrics across different stages of a sequencing pipeline—from raw reads to aligned BAMs and variant calls. Use this skill to automate the extraction of raw statistics into JSON format or to generate Excel-based reports for coverage analysis, sex determination, and SNP extraction.

## Command Line Usage

The tool follows a consistent pattern: `hmnqc <command> <parameters>`.

### Quality Metrics Extraction
Extract comprehensive statistics from multiple file types into a single JSON file. This is typically used at the end of a primary analysis pipeline to aggregate QC data.

```bash
hmnqc quality \
  --input-sample-name <sample_id> \
  --output-hmnqc-json <output.json> \
  --input-fastq-forward-raw <R1_raw.fastq.gz> \
  --input-fastq-reverse-raw <R2_raw.fastq.gz> \
  --input-fastq-forward-trim <R1_trimmed.fastq.gz> \
  --input-fastq-reverse-trim <R2_trimmed.fastq.gz> \
  --input-sample-bam <aligned.bam> \
  --input-sample-bed <targets.bed> \
  --input-sample-vcf <variants.vcf>
```

### Coverage and Depth Analysis
Use these commands to identify gaps in sequencing or to calculate target enrichment efficiency.

*   **Identify Low-Coverage Positions**: Find specific genomic positions falling below a custom depth threshold.
    ```bash
    hmnqc depthmin \
      --input-sample-bam <aligned.bam> \
      --input-sample-bed <targets.bed> \
      --parameter-cut-off <int_threshold> \
      --output-hmnqc-xlsx <low_coverage.xlsx>
    ```

*   **Target Coverage Statistics**: Compute general coverage metrics for regions defined in a BED file.
    ```bash
    hmnqc depthtarget \
      --input-sample-bam <aligned.bam> \
      --input-sample-bed <targets.bed> \
      --parameter-mode target \
      --ouput-hmnqc-xlsx <coverage_stats.xlsx>
    ```

### Identity and Sex Inference
Verify sample metadata and check for potential sample swaps.

*   **Infer Sex**: Determine the biological sex of a sample based on BAM alignment distribution across target regions.
    ```bash
    hmnqc infersexe \
      --input-sample-bam <aligned.bam> \
      --input-sample-bed <targets.bed> \
      --output-hmnqc-xlsx <sex_inference.xlsx>
    ```

*   **Extract SNPs**: Pull specific SNP information from a BAM file using a reference VCF to facilitate identity comparisons.
    ```bash
    hmnqc extractvcf \
      --input-sample-bam <aligned.bam> \
      --input-reference-vcf <reference_snps.vcf> \
      --output-hmnqc-xlsx <extracted_snps.xlsx>
    ```

## Best Practices

*   **Input Consistency**: Ensure the `--input-sample-name` matches the internal identifiers used in your BAM and VCF headers to prevent downstream reporting confusion.
*   **Targeted Analysis**: Always provide a BED file that accurately represents the capture kit or targeted panel used; using a whole-genome or mismatched BED will result in incorrect coverage and sex inference metrics.
*   **Output Formats**: Note that `quality` produces JSON (ideal for machine reading/multi-qc tools), while the depth and identity commands produce XLSX (ideal for manual review by lab technicians).
*   **Trimmed vs Raw**: When running the `quality` command, providing both raw and trimmed FASTQs allows the tool to calculate the efficiency of your adapter clipping and quality filtering steps.

## Reference documentation
- [HmnQc GitHub Repository](./references/github_com_guillaume-gricourt_HmnQc.md)
- [HmnQc Bioconda Package](./references/anaconda_org_channels_bioconda_packages_hmnqc_overview.md)