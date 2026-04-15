---
name: somalier
description: Somalier is a high-performance tool used to verify sample identity, relatedness, and ancestry in genomic datasets by extracting genotypes at informative polymorphic sites. Use when user asks to identify sample swaps, confirm family relationships in pedigree files, predict sample ancestry, or perform quality control on large cohorts.
homepage: https://github.com/brentp/somalier
metadata:
  docker_image: "quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0"
---

# somalier

## Overview
Somalier is a high-performance tool designed to ensure the integrity of genomic datasets. It operates by extracting genotypes at a small set of highly informative, common polymorphic sites (typically ~17k to 60k sites). Because it focuses on a subset of the genome, it is orders of magnitude faster than full-genome comparisons. It is particularly useful for identifying sample swaps in large cohorts, confirming family relationships in pedigree files, and predicting the ancestry of unknown samples against a reference population like the 1000 Genomes Project.

## Core Workflow

### 1. Extraction
The first step is to extract site information from your alignment or variant files. This creates a small `.somalier` binary file for each sample.

**From BAM/CRAM (Recommended):**
```bash
somalier extract -d extracted/ --sites sites.vcf.gz -f reference.fa $sample.cram
```
*   **Tip**: Extracting from alignments is more accurate than from single-sample VCFs because it uses all available reads at the target sites.

**From Joint-Called VCF/BCF:**
```bash
somalier extract -d extracted/ --sites sites.vcf.gz -f reference.fa cohort.vcf.gz
```

### 2. Relatedness and QC
Once extracted, use the `relate` command to compare all samples. This step is extremely fast (seconds for hundreds of samples).

```bash
somalier relate --ped project.ped extracted/*.somalier
```

**Key Outputs:**
- `somalier.html`: An interactive report for visualizing sample relationships and QC metrics.
- `somalier.samples.tsv`: A PED-like file updated with inferred sex and other QC data.
- `somalier.pairs.tsv`: Detailed IBS (Identity By State) and relatedness coefficients for every pair.

### 3. Ancestry Prediction
To predict ancestry, you must provide labeled reference samples (e.g., 1000 Genomes) separated from your query samples by `++`.

```bash
somalier ancestry --labels labels.tsv ref/*.somalier ++ query/*.somalier
```

## Expert Tips and Best Practices

- **Site Selection**: Always use the pre-computed sites files provided in the somalier releases (e.g., `sites.hg38.vcf.gz`). These are selected for high minor allele frequency and low linkage disequilibrium.
- **Parallelization**: The `extract` step is the most time-consuming. Run it in parallel across samples on a cluster. If you have split a single sample by chromosome, you can concatenate the resulting `.somalier` files using the provided Python helper scripts before running `relate`.
- **Handling VCFs**: If extracting from VCFs that were not jointly called, use the `-u` or `--unknown` flag in `somalier relate` to treat missing genotypes as homozygous reference, which often improves results for sparse data.
- **Pedigree Inference**: Use the `--infer` flag during `relate` to have somalier attempt to reconstruct the pedigree based on the data. This is excellent for catching "hidden" relationships or mislabeled family members.
- **RNA-Seq Data**: When working with RNA-Seq, adjust the allele balance threshold using `--min-ab 0.2` (default is 0.3) to account for potential allele-specific expression or higher noise.



## Subcommands

| Command | Description |
|---------|-------------|
| somalier pca | dimensionality reduction |
| somalier_extract | extract genotype-like information for a single-sample at selected sites |
| somalier_find-sites | Finds sites from a VCF file based on various criteria. |
| somalier_pedrel | report pairwise relationships from pedigree file |
| somalier_relate | calculate relatedness among samples from extracted, genotype-like information |

## Reference documentation
- [Somalier GitHub Repository](./references/github_com_brentp_somalier.md)
- [Ancestry Prediction Guide](./references/github_com_brentp_somalier_wiki_ancestry.md)
- [Pedigree Inference Details](./references/github_com_brentp_somalier_wiki_pedigree-inference.md)
- [Frequently Asked Questions](./references/github_com_brentp_somalier_wiki_Frequently-Asked-Questions.md)