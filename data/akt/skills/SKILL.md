---
name: akt
description: AKT is a high-performance utility for analyzing large-scale genomic datasets to resolve sample relatedness and population structure. Use when user asks to estimate ancestry via PCA, calculate kinship coefficients, identify unrelated individuals, or perform Mendelian phasing on VCF and BCF files.
homepage: https://github.com/Illumina/akt
---

# akt

---

## Overview

AKT (Ancestry and Kinship Toolkit) is a high-performance command-line utility designed for the analysis of large-scale genomic datasets. By utilizing the htslib API, it provides seamless integration with VCF and BCF file formats, allowing for efficient processing of genotype data. The tool is primarily used to resolve sample relatedness, identify population structure, and ensure data integrity in genetic cohorts by identifying pedigree errors or extracting unrelated subsets of individuals.

## Command Reference and Usage

### Principal Component Analysis (PCA)
Used to estimate ancestry and identify population clusters.
- **Basic usage**: `akt pca [options] input.vcf.gz`
- **Key flag**: Use `--assume-homref` if you want to treat missing genotypes as homozygous reference (useful for low-coverage or sparse data).
- **Handling Hemizygosity**: The tool includes specific logic for handling hemizygous genotypes (e.g., X chromosome in males) during PCA.

### Kinship Calculation
Calculates kinship coefficients to determine how closely related pairs of individuals are.
- **Basic usage**: `akt kin -F frequencies.vcf.gz input.vcf.gz`
- **Methods (`-M`)**:
  - `-M 0`: Plink-style kinship.
  - `-M 1`: Standard kinship (default).
  - `-M 2`: Genetic Relationship Matrix (GRM).
- **Allele Frequencies**: You must provide allele frequencies using `-F`. If frequencies are not provided, you must use `--force` to calculate them from the input data (though providing a reference frequency file is preferred for accuracy).

### Pedigree Discovery and Relatedness
Identifies family structures within the data.
- **Discover relatives**: `akt relatives input.vcf.gz`
- **Identify unrelated samples**: `akt unrelated input.vcf.gz`
  - This command generates a list of individuals that share no close relationships, which is a common requirement for association studies.

### Mendelian Phasing
Phases genotypes based on transmission logic in duos and trios.
- **Basic usage**: `akt pedphase input.vcf.gz`
- **Exclude chromosomes**: Use `-x <chrom_list>` to skip specific chromosomes (e.g., sex chromosomes) during the phasing process.
- **Phase Sets**: The tool handles and propagates `PS` (Phase Set) tags and can convert them to indicate agreement with pedigree inheritance.

## Expert Tips and Best Practices

- **Multi-threading**: Use the `-@` flag (or `-n` in older versions) to specify the number of threads for kinship and PCA calculations.
- **Input Compatibility**: Since AKT uses htslib, you can pipe output from `bcftools` directly into `akt` using `-` as the filename.
- **Installation Issues**: If compiling on macOS or systems without OpenMP, use `make no_omp`. This will disable multi-threading but ensures the tool functions correctly on a single core.
- **Memory Efficiency**: AKT is optimized for low memory footprints, though some operations may result in non-deterministic output ordering when multi-threaded.



## Subcommands

| Command | Description |
|---------|-------------|
| ./akt unrelated | Derive a set of pedigrees from the akt kin output. |
| akt kin | Calculate kinship/IBD statistics from a multisample BCF/VCF |
| akt pca | Performs principal component analysis on a vcf/bcf |
| akt pedphase | simple Mendel inheritance phasing of duos/trios |
| akt unrelated | Print a list of unrelated individuals taking the output from akt kin as input. |

## Reference documentation
- [AKT README](./references/github_com_Illumina_akt_blob_master_README.md)
- [AKT Changelog](./references/github_com_Illumina_akt_blob_master_Changelog.md)
- [Haplotype Phasing Logic](./references/github_com_Illumina_akt_blob_master_HaplotypeBuffer.hh.md)