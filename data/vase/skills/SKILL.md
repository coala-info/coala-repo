---
name: vase
description: VASE filters genetic variants in rare-disease cohorts and family trios to identify disease-causing candidates. Use when user asks to filter genetic variants by frequency, functional impact, or quality; identify de novo or recessive variants; or perform burden analysis.
homepage: https://github.com/david-a-parry/vase
metadata:
  docker_image: "quay.io/biocontainers/vase:0.5.1--pyh086e186_0"
---

# vase

## Overview
VASE is a specialized tool designed for the analysis of rare-disease cohorts and family trios. It streamlines the process of narrowing down thousands of variants to a manageable list of candidates by integrating population frequency data, functional impact predictions, and pedigree-based segregation logic. It is particularly effective when working with joint-called, VEP-annotated VCF files.

## Core Workflows

### Frequency Filtering
Filter against public databases like gnomAD to remove common variants.
```bash
# Filter variants with >1% frequency in any gnomAD population
vase -i input.vcf -g gnomad.exomes.vcf.gz --freq 0.01 -o rare_variants.vcf
```

### Functional Impact Filtering
Select variants based on their predicted effect on the protein.
```bash
# Keep only HIGH impact variants in canonical transcripts
vase -i input.vcf --impact HIGH --canonical -o high_impact.vcf

# Filter for HIGH or MODERATE impact
vase -i input.vcf --impact HIGH MODERATE -o functional_variants.vcf
```

### Familial Segregation
Identify variants following specific inheritance models using a PED file.

**De Novo Mutations:**
```bash
# Identify de novo variants with quality thresholds to reduce false positives
vase -i input.vcf --ped family.ped --de_novo --dp 10 --gq 20 --het_ab 0.27 --control_het_ab 0.05 -o denovo.vcf
```

**Recessive Inheritance:**
```bash
# Identify biallelic or compound heterozygous variants
vase -i input.vcf --ped family.ped --recessive --freq 0.005 -o recessive.vcf
```

### Burden Analysis
Count alleles passing filters per transcript, useful for cohort-based gene discovery.
```bash
vase -i input.vcf --burden_counts output_counts.tsv --cases sample1 sample2 --controls sample3 sample4
```

## Expert Tips & Best Practices
- **Joint Calling:** For family studies, always use a VCF produced by joint-calling (e.g., GATK GenotypeGVCFs) to ensure reference calls are explicitly represented, which is critical for de novo and recessive filtering.
- **VEP Annotation:** Run VEP with `--everything`, `--fasta`, and `--vcf` flags before using VASE to ensure all necessary fields (like `Allele_Number`) are present for accurate filtering.
- **Quality Control:** Use `--het_ab` (heterozygote allele balance) and `--dp` (depth) flags to filter out sequencing artifacts that often mimic de novo mutations.
- **Reporting:** Use the companion tool `vase_reporter` to convert filtered VCFs into user-friendly Excel or JSON formats for clinical review.
- **Performance:** If performing multiple filtering runs, annotate with frequency data once and save the output. Subsequent runs on the annotated VCF will be significantly faster.

## Reference documentation
- [VASE GitHub Repository](./references/github_com_david-a-parry_vase.md)
- [VASE Wiki and Examples](./references/github_com_david-a-parry_vase_wiki.md)