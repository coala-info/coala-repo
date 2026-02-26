---
name: somalier
description: "somalier performs genomic quality control by extracting informative site data to evaluate sample relatedness, sex, and ancestry. Use when user asks to extract genotypes from alignments, calculate relatedness, verify sex, or predict ancestry."
homepage: https://github.com/brentp/somalier
---


# somalier

## Overview

somalier is a high-performance tool designed for genomic quality control. It operates by extracting informative site data into compact binary files and then aggregating those files to calculate relatedness, verify sex, and predict ancestry. It is significantly faster than traditional tools for these specific QC tasks, making it suitable for cohorts ranging from a few samples to tens of thousands. Use this skill to guide the extraction of genotypes from alignments or variants and the subsequent evaluation of sample relationships.

## Core Workflow

The somalier workflow consists of two primary steps: extraction and evaluation.

### 1. Extracting Informative Sites

The `extract` command creates a `.somalier` binary file for each input. This step is parallelizable by sample.

**From BAM or CRAM (Recommended for accuracy):**
```bash
# Run for each sample
somalier extract -d extracted/ --sites sites.vcf.gz -f reference.fa sample.cram
```

**From Jointly-called VCF/BCF:**
```bash
somalier extract -d extracted/ --sites sites.vcf.gz -f reference.fa cohort.vcf.gz
```

*   **--sites**: Use the known polymorphic sites VCF provided in the somalier releases (e.g., `sites.hg38.vcf.gz`).
*   **--fasta**: The reference genome used for the alignments.

### 2. Evaluating Relatedness and QC

The `relate` command compares all extracted files to identify relationships and potential swaps.

```bash
somalier relate --ped project.ped extracted/*.somalier
```

**Key Outputs:**
*   `somalier.html`: An interactive report for visual inspection of relatedness, sex, and heterozygosity.
*   `somalier.samples.tsv`: A PED-like file updated with QC metrics (sex, heterozygosity, depth).
*   `somalier.pairs.tsv`: Detailed IBS (Identity By State) metrics for every possible pair.

## Advanced Usage and Best Practices

### Pedigree Inference
If the pedigree is unknown or suspected to be incorrect, use the `--infer` flag to let somalier predict first-degree relationships.
```bash
somalier relate --infer extracted/*.somalier
```

### Ancestry Prediction
To predict ancestry, you must provide a set of labeled samples (available in somalier releases).
```bash
somalier ancestry --labels labeled_samples.tsv --trained somalier-ancestry-model.ext extracted/*.somalier
```

### Handling Large Cohorts
For very large datasets where the command line argument limit might be reached, pass the files as quoted glob strings:
```bash
somalier relate "/path/to/data/*.somalier"
```

### Expert Tips
*   **Accuracy**: Extracting from BAM/CRAM is generally more accurate than extracting from single-sample VCFs.
*   **RNA-Seq**: When working with RNA-Seq data, set `--min-ab 0.2` in the `relate` step to account for allele-specific expression.
*   **Iterative Updates**: Because `relate` is extremely fast, you can add new samples by running `extract` only on the new files and then re-running `relate` on the entire collection of `.somalier` files.
*   **Unknown Genotypes**: If using VCFs that were not jointly called, use the `-u` or `--unknown` flag in `relate` to treat missing genotypes as homozygous reference.

## Reference documentation
- [Main Documentation and Quick Start](./references/github_com_brentp_somalier.md)
- [Pedigree Inference and Ancestry](./references/github_com_brentp_somalier_wiki.md)