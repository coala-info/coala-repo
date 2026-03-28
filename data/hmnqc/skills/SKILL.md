---
name: hmnqc
description: hmnqc is a bioinformatics utility that generates quality reports and verifies sample integrity for targeted sequencing workflows. Use when user asks to extract quality metrics, identify low-coverage positions, calculate target coverage, infer sample sex, or extract SNPs for identity checking.
homepage: https://github.com/guillaume-gricourt/HmnQc
---

# hmnqc

## Overview

hmnqc is a specialized bioinformatics utility designed for targeted sequencing workflows. It streamlines the process of generating quality reports and verifying sample integrity by processing raw and aligned sequencing data. It is particularly useful for clinical or research pipelines requiring standardized QC metrics in JSON or Excel formats. The tool integrates several core libraries like pysam, biopython, and CNVkit to provide a unified interface for quality, coverage, and identity metrics.

## Command Line Usage

### Quality Metrics Extraction
Use the `quality` command to generate a comprehensive JSON file containing statistics from various stages of the pipeline.

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

### Coverage Analysis
hmnqc provides two primary ways to assess coverage: identifying gaps and calculating target statistics.

**Identify low-coverage positions:**
Extract specific genomic positions that fall below a defined depth threshold.
```bash
hmnqc depthmin \
    --input-sample-bam <aligned.bam> \
    --input-sample-bed <targets.bed> \
    --parameter-cut-off <int_threshold> \
    --output-hmnqc-xlsx <low_coverage.xlsx>
```

**Calculate target coverage:**
Compute summary statistics for regions defined in a BED file.
```bash
hmnqc depthtarget \
    --input-sample-bam <aligned.bam> \
    --input-sample-bed <targets.bed> \
    --parameter-mode target \
    --ouput-hmnqc-xlsx <coverage_stats.xlsx>
```

### Identity and Sex Inference
Verify sample metadata and integrity using alignment data.

**Infer Sample Sex:**
Determines sex based on coverage across sex chromosomes defined in the BED file.
```bash
hmnqc infersexe \
    --input-sample-bam <aligned.bam> \
    --input-sample-bed <targets.bed> \
    --output-hmnqc-xlsx <sex_inference.xlsx>
```

**Extract SNPs for Identity Checking:**
Extracts specific SNPs from a BAM file based on a reference VCF to facilitate sample tracking or contamination checks.
```bash
hmnqc extractvcf \
    --input-sample-bam <aligned.bam> \
    --input-reference-vcf <reference_snps.vcf> \
    --output-hmnqc-xlsx <extracted_snps.xlsx>
```

## Expert Tips

- **Input Flexibility**: The `quality` command can take a subset of inputs if certain files (like trimmed FASTQs or VCFs) are not available, though providing all files yields the most complete JSON report.
- **Threshold Selection**: When using `depthmin`, ensure the `--parameter-cut-off` matches your clinical or experimental sensitivity requirements (e.g., 20x or 100x for targeted panels).
- **Environment Setup**: hmnqc is best managed via Bioconda. If dependencies like `pysam` or `CNVkit` conflict with your local environment, use a dedicated conda environment: `conda create -n hmnqc_env -c bioconda hmnqc`.



## Subcommands

| Command | Description |
|---------|-------------|
| hmnqc depthmin | Calculate minimal depth coverage for QC reporting |
| hmnqc depthtarget | Calculate depth on target regions for BAM files using a BED file |
| hmnqc extractvcf | Extract VAF or SNP information from VCF files into an Excel output |
| hmnqc infersexe | Infer sex based on coverage of autosomes and sex chromosomes from BAM files. |
| hmnqc quality | Quality analysis of fastq, bam, and vcf files |

## Reference documentation
- [HmnQc README](./references/github_com_guillaume-gricourt_HmnQc_blob_main_README.md)
- [HmnQc Main Repository](./references/github_com_guillaume-gricourt_HmnQc.md)