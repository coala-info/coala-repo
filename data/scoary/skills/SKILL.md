---
name: scoary
description: Scoary is a specialized tool for microbial pan-genome wide association studies.
homepage: https://github.com/AdmiralenOla/Scoary
---

# scoary

## Overview
Scoary is a specialized tool for microbial pan-genome wide association studies. It bridges the gap between pan-genome pipelines (like Roary or LS-BSR) and phenotypic data. By taking a gene presence/absence matrix and a binary trait file, Scoary calculates the statistical strength of association for every gene in the accessory genome, providing a ranked list of candidate genes based on p-values and sensitivity/specificity metrics.

## Core Command Line Usage

The primary command requires a genotype file (gene presence/absence) and a phenotypic trait file.

```bash
# Basic association analysis
scoary -g gene_presence_absence.csv -t traits.csv
```

### Working with Variants (VCF)
If you are working with SNPs, indels, or structural variants instead of gene presence/absence, use the `vcf2scoary` utility to convert your data into the required format.

```bash
# Convert VCF to Scoary format
vcf2scoary myvariants.vcf

# Extract specific variant types during conversion
vcf2scoary --types snp,mnp,complex myvariants.vcf
```

## Input Requirements

### Genotype File (`-g`)
- Typically the `gene_presence_absence.csv` output from Roary.
- Can also be converted from LS-BSR or VCF files.

### Traits File (`-t`)
- **Format**: CSV file where rows are isolates and columns are traits.
- **Values**: Must be dichotomized (binary). Use `1` for presence/positive and `0` for absence/negative.
- **Isolate Names**: Must match the names used in the genotype file exactly.
- **Header**: The top-left cell (A1) should be left blank.
- **Missing Data**: Represent missing phenotypic measurements as `NA`, `.`, or `-`. Scoary will exclude these isolates from the specific trait analysis.

## Expert Tips and Best Practices

- **Delimiter Consistency**: Ensure the `traits.csv` uses the same delimiter as the `gene_presence_absence.csv` (default is a comma).
- **Naming Conventions**: Avoid using special characters (e.g., `%;,/&[]@?`) in isolate or trait names, as these can cause parsing errors.
- **Performance**: While a GUI (`scoary_GUI`) is available, the CLI version is significantly faster, especially when performing many permutations or handling large datasets.
- **VCF Allele Handling**: When using `vcf2scoary` on sites with more than two alleles, the tool compares each non-reference allele against the reference. It does not test every possible contrast between non-reference alleles (e.g., it tests Ref vs. Alt1 and Ref vs. Alt2, but not Alt1 vs. Alt2).
- **Output Interpretation**: Scoary generates one CSV file per trait. Focus on the `Corrected_P` or `Empirical_P` values rather than the naive p-value to account for multiple testing and population structure.

## Reference documentation
- [Scoary GitHub Repository](./references/github_com_AdmiralenOla_Scoary.md)
- [Scoary Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scoary_overview.md)