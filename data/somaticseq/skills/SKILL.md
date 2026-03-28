---
name: somaticseq
description: SomaticSeq is an ensemble framework that combines outputs from multiple somatic mutation callers to produce high-confidence variant sets using consensus or machine learning models. Use when user asks to merge results from multiple somatic callers, train site-specific machine learning models for variant filtering, or identify somatic mutations in tumor-normal paired or tumor-only samples.
homepage: http://bioinform.github.io/somaticseq/
---

# somaticseq

## Overview
SomaticSeq is an ensemble framework that leverages the strengths of multiple individual somatic mutation callers to produce a high-confidence call set. By combining outputs from tools such as MuTect2, VarScan2, and LoFreq, it reduces false positives and improves sensitivity. It can operate in three modes: a simple majority-vote consensus, a training mode to build site-specific machine learning models, and a prediction mode that uses pre-trained models to score and filter variants.

## Core CLI Patterns

### Tumor-Normal Paired Mode
Use `somaticseq_parallel.py paired` to merge results when a matched normal sample is available. This is the most accurate way to distinguish somatic mutations from germline variants.

```bash
somaticseq_parallel.py \
  --output-directory $OUTPUT_DIR \
  --genome-reference GRCh38.fa \
  --threads 8 \
  paired \
  --tumor-bam-file tumor.bam \
  --normal-bam-file matched_normal.bam \
  --mutect2-vcf MuTect2.vcf \
  --varscan-snv VarScan2.snp.vcf \
  --varscan-indel VarScan2.indel.vcf \
  --vardict-vcf VarDict.vcf \
  --strelka-snv Strelka.snv.vcf \
  --strelka-indel Strelka.indel.vcf
```

### Tumor-Only (Single) Mode
Use `somaticseq_parallel.py single` when no matched normal is available. Note that fewer callers support this mode compared to paired analysis.

```bash
somaticseq_parallel.py \
  --output-directory $OUTPUT_DIR \
  --genome-reference GRCh38.fa \
  single \
  --bam-file tumor.bam \
  --mutect2-vcf MuTect2.vcf \
  --vardict-vcf VarDict.vcf \
  --lofreq-vcf LoFreq.vcf
```

### Machine Learning Workflows
To move beyond simple consensus voting, use the training or prediction flags **before** the `paired` or `single` subcommand.

*   **Training Mode**: Requires ground truth VCFs.
    `--somaticseq-train --truth-snv truth_snv.vcf --truth-indel truth_indel.vcf`
*   **Prediction Mode**: Requires pre-built `.RData` classifiers.
    `--classifier-snv SNV.RData --classifier-indel Indel.RData`

## Expert Tips & Best Practices

*   **Parallelization**: Always use the `--threads X` parameter. SomaticSeq parallelizes by splitting the genomic regions (defined in `--inclusion-region`) into chunks, processing them, and merging the results. This requires `bedtools` to be in your PATH.
*   **Input Consistency**: Ensure the reference FASTA, BAM files, and all input VCFs are sorted identically (e.g., all by coordinate). Mismatched headers or sort orders will cause the tool to fail or produce incorrect features.
*   **Region Filtering**: Use `--inclusion-region` (e.g., an exome target BED) to limit analysis to relevant areas and speed up processing. Use `--exclusion-region` to mask out "blacklist" regions known for mapping artifacts.
*   **Software Dependencies**: Ensure `numpy`, `scipy`, `pysam`, `pandas`, and `xgboost` are installed in the Python environment. If using training mode, R and the `ada` package are required.
*   **VCF Formats**: SomaticSeq accepts both `.vcf` and `.vcf.gz` files. It is generally better to provide the specific SNV and Indel files for callers that separate them (like VarScan2 or LoFreq) to ensure the ensemble logic correctly categorizes the variants.



## Subcommands

| Command | Description |
|---------|-------------|
| somaticseq paired | Run somatic variant callers in paired mode |
| somaticseq_single | SomaticSeq single mode |

## Reference documentation
- [SomaticSeq Overview](./references/anaconda_org_channels_bioconda_packages_somaticseq_overview.md)
- [SomaticSeq GitHub Documentation](./references/bioinform_github_io_somaticseq.md)