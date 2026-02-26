---
name: gimbleprep
description: "gimbleprep preprocesses and filters VCF and BAM files to prepare genomic datasets for the gIMble analysis suite. Use when user asks to decompose MNPs, filter variants for site frequency spectrum analyses, or synchronize VCF and BED files for gIMble."
homepage: https://github.com/LohseLab/gimbleprep
---


# gimbleprep

## Overview

gimbleprep is a specialized preprocessing tool designed to bridge the gap between raw bioinformatic outputs and the gIMble analysis suite. It automates the rigorous filtering required for site frequency spectrum (SFS) based analyses, including MNP decomposition, coverage-based site calling, and quality-based variant pruning. Use this tool to ensure your VCF and BED files are perfectly synchronized and formatted for gIMble's `parse` module.

## Installation

Install via Bioconda:
```bash
conda install -c bioconda gimbleprep
```

## Core Workflow

To prepare a dataset, provide the reference genome, a directory containing all sample BAM files, and a compressed/indexed VCF:

```bash
gimbleprep -f reference.fasta -b ./bam_dir/ -v variants.vcf.gz
```

### Input Requirements
- **FASTA (-f)**: The reference genome used for mapping.
- **BAM Directory (-b)**: A folder containing BAM files. Each file must have readgroup-labelled reads (@RG tags) to identify samples.
- **VCF (-v)**: A Freebayes VCF file that must be compressed (`bgzip`) and indexed (`tabix`).

## VCF and BAM Processing Logic

gimbleprep applies specific filters to ensure data integrity:
- **MNP Decomposition**: Automatically breaks Multi-Nucleotide Polymorphisms into individual SNPs.
- **Variant Filtering**: Removes non-SNPs, variants near gaps, low-quality calls, and variants with unbalanced allele observations (RPL, RPR, SAF, SAR).
- **Callable Sites**: Defines `{CALLABLE_SITES}` for each sample based on read depth thresholds, then performs a `bedtools multiintersect` to find regions covered across all samples.
- **Genotype Masking**: Genotypes with read depths outside the calculated coverage thresholds are set to missing (`./.`).

## Mandatory Manual Modifications

After running the tool, you must manually edit the generated files before proceeding to `gimble parse`:

1.  **gimble.samples.csv**: You **must** add population IDs in the second column. gIMble requires exactly two populations for most analyses.
2.  **gimble.genomefile**: (Optional) Remove sequence IDs (e.g., small scaffolds or organellar DNA) that should be excluded from the analysis.
3.  **gimble.bed**: (Recommended) Intersect this file with specific regions of interest (like intergenic regions) using `bedtools intersect` to focus your analysis.

## Expert Tips

- **ReadGroup Consistency**: Ensure the `SM` tag in your BAM readgroups matches the sample names in your VCF. gimbleprep relies on these IDs to link coverage data to genotypes.
- **Disk Space**: Preprocessing large VCFs and multiple BAMs is I/O intensive. Ensure the output directory has sufficient space for the intermediate BED files generated during the multi-intersection step.
- **Docker Usage**: If running via Docker, you must bind your current working directory to the container's home directory:
  ```bash
  docker run --rm --mount type=bind,source="$(pwd)",target=/home/newuser gimbleprep -f ref.fa -v var.vcf.gz -b ./bams
  ```

## Reference documentation
- [gimbleprep GitHub Repository](./references/github_com_LohseLab_gimbleprep.md)
- [gimbleprep Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gimbleprep_overview.md)