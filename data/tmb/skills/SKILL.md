---
name: tmb
description: The tmb tool calculates Tumor Mutational Burden (TMB) from VCF files. Use when user asks to calculate tumor mutational burden, filter variants for TMB calculation, define genomic space for TMB, debug TMB filters, or export variants used for TMB.
homepage: https://github.com/bioinfo-pf-curie/TMB
metadata:
  docker_image: "quay.io/biocontainers/tmb:1.5.0--pyhdfd78af_1"
---

# tmb

## Overview

The `tmb` tool (specifically `pyTMB.py`) provides a flexible framework for calculating the number of mutations per megabase (Mb) of the genome. It is designed to be caller-agnostic, using configuration files to map specific VCF INFO fields to filtering logic. This allows users to precisely define which variants (e.g., non-synonymous, coding, specific allele frequencies) contribute to the final TMB score.

## Installation and Preparation

Install via Bioconda:
```bash
conda install -c bioconda tmb
```

### VCF Normalization
To avoid ambiguities with Multi-Nucleotide Variants (MNVs) or multiallelic sites, always normalize your VCF before calculation:
```bash
bcftools norm -f human_g1k_v37.fasta -m- -o normalized.vcf input.vcf
```

## Core CLI Usage

The tool requires an input VCF and two configuration files that define how to interpret the VCF's annotations.

### Basic Command
```bash
python pyTMB.py -i input.vcf --dbConfig config/annovar.yml --varConfig config/mutect2.yml --effGenomeSize 38
```

### Defining the Genomic Space
TMB is calculated as `(Count of Passed Variants) / (Effective Genome Size)`. You must define the denominator using one of two methods:
1. **Fixed Size**: Use `--effGenomeSize` (in Mb).
2. **BED File**: Use `--bed design.bed` to calculate the size from a specific capture design. The BED must be 0-based, ordered, and headerless.

### Common Filtering Patterns
* **Clinical TMB**: Exclude synonymous mutations and common polymorphisms.
  ```bash
  python pyTMB.py -i in.vcf --dbConfig db.yml --varConfig var.yml --filterSyn --filterPolym --maf 0.001
  ```
* **Quality Control**: Filter for "PASS" variants and minimum depth.
  ```bash
  python pyTMB.py -i in.vcf --dbConfig db.yml --varConfig var.yml --filterLowQual --minDepth 20 --minAltDepth 3
  ```
* **Functional Focus**: Filter for coding or splice site variants.
  ```bash
  python pyTMB.py -i in.vcf --dbConfig db.yml --varConfig var.yml --filterNonCoding --filterSplice
  ```

## Expert Tips

* **Configuration Mapping**: The `--dbConfig` and `--varConfig` files are essential because they tell the tool which INFO keys (like `Func.refGene` or `ExAC_ALL`) to look for. Ensure these match your annotation pipeline (e.g., Annovar vs. snpEff).
* **Sample Selection**: In multi-sample VCFs, use `--sample <ID>` to focus the calculation on a specific tumor sample.
* **Debugging Filters**: Use the `--debug` flag to export the original VCF with a `TMB_FILTER` tag in the INFO field. This helps identify exactly why specific variants were included or excluded from the count.
* **Exporting Variants**: Use `--export` to generate a VCF containing only the variants that passed all filters and were used for the TMB calculation.

## Reference documentation
- [tmb - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_tmb_overview.md)
- [GitHub - bioinfo-pf-curie/TMB: Tumor Mutational Burden](./references/github_com_bioinfo-pf-curie_TMB.md)