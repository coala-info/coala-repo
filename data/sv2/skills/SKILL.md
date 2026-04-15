---
name: sv2
description: SV2 is a machine learning framework that genotypes and filters structural variants using support vector machines. Use when user asks to genotype deletions and duplications, filter false positive structural variants, or extract features for variant classification.
homepage: https://github.com/dantaki/SV2
metadata:
  docker_image: "quay.io/biocontainers/sv2:1.4.3.4--py27h3010b51_2"
---

# sv2

## Overview

SV2 (Support Vector Structural Variation Genotyper) is a machine learning framework that improves the accuracy of structural variant calling by integrating multiple features from sequencing data. It is particularly effective at filtering false positives from discovery algorithms and providing high-confidence genotypes for deletions and duplications. The tool uses Support Vector Machines (SVM) trained on validated datasets to classify variants and can handle both single-sample and multi-sample (pedigree) workflows.

## Configuration and Setup

Before running genotypes, you must download the required resource files and define the paths to your reference genomes.

```bash
# Download required SVM models and resource files
sv2 -download

# Set paths to reference fasta files (required for feature extraction)
sv2 -hg19 /path/to/hg19.fa -hg38 /path/to/hg38.fa -mm10 /path/to/mm10.fa
```

## Standard Genotyping Workflow

The primary command requires a BAM/CRAM file, a set of SVs to genotype (VCF or BED), an SNV VCF for heterozygous allele depth analysis, and a PED file for family context.

```bash
# Basic execution
sv2 -i input.bam -v structural_variants.vcf -snv snvs.vcf.gz -p family.ped

# Specifying an output prefix
sv2 -i input.bam -v structural_variants.vcf -snv snvs.vcf.gz -p family.ped -O project_name
```

### Required Input Specifications
- **BAM/CRAM (-i)**: Coordinate-sorted and indexed alignment files.
- **SV Input (-v or -b)**: VCF or BED file containing the coordinates of deletions and duplications to be genotyped.
- **SNV VCF (-snv)**: A bgzipped and tabix-indexed VCF containing single nucleotide variants. This is used to calculate heterozygous allele depth (HAR) features.
- **PED file (-p)**: Standard pedigree format file defining sample relationships.

## Common CLI Patterns and Options

### Handling Legacy Alignments
If your BAM files were generated using `bwa mem -M` (where split-reads are flagged as secondary rather than supplementary), use the `-M` flag to ensure proper feature extraction.

```bash
sv2 -i input.bam -v sv.vcf -snv snv.vcf.gz -p fam.ped -M
```

### Skipping Annotations
By default, SV2 provides annotations for genes and repeat elements. To speed up the process if these are not needed:

```bash
sv2 -i input.bam -v sv.vcf -snv snv.vcf.gz -p fam.ped -no-anno
```

### Merging Breakpoints
SV2 can merge divergent breakpoints from different discovery algorithms into a single unified call. This is disabled by default but can be enabled for cleaner output matrices.

```bash
sv2 -i input.bam -v sv.vcf -snv snv.vcf.gz -p fam.ped -m
```

## Output Structure

SV2 generates three primary directories in the output path:
1. `sv2_preprocessing/`: Contains intermediate files from the initial data processing.
2. `sv2_features/`: Contains the extracted features used by the SVM classifier.
3. `sv2_genotypes/`: Contains the final genotyped VCF files with SV2 specific annotations and filters.

## Expert Tips
- **SNV Quality**: Ensure your SNV VCF is high quality; the Heterozygous Allele Depth (HAR) is a critical feature for the SVM classifier to distinguish between true deletions and mapping artifacts.
- **Python Version**: SV2 is designed for Python 2.7 environments. Ensure dependencies like `pysam` (0.9+), `scikit-learn` (v0.19+), and `bedtools` (2.25.0+) are correctly installed in your environment.
- **Memory Management**: For very large variants (>10Mb), ensure you are using the latest version (v1.4.3+) which includes performance optimizations for gene annotations.

## Reference documentation
- [SV2 GitHub Repository](./references/github_com_dantaki_SV2.md)
- [SV2 Wiki and User Guide](./references/github_com_dantaki_SV2_wiki.md)
- [Bioconda SV2 Package Overview](./references/anaconda_org_channels_bioconda_packages_sv2_overview.md)