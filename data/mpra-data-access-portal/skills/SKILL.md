---
name: mpra-data-access-portal
description: This tool provides a structured interface for retrieving and analyzing single-nucleotide variant and single-base deletion data from the Saturation Mutagenesis MPRA data portal. Use when user asks to access functional data for regulatory elements, retrieve log2 expression effects for non-coding variants, or download saturation mutagenesis datasets for specific promoters and enhancers.
homepage: https://mpra.gs.washington.edu/satMutMPRA
metadata:
  docker_image: "quay.io/biocontainers/mpra-data-access-portal:0.1.11--hdfd78af_0"
---

# mpra-data-access-portal

## Overview
This skill provides a structured interface for working with the Saturation Mutagenesis MPRA data portal. It enables the retrieval of single-nucleotide variant (SNV) and single-base deletion data across 21 critical regulatory elements. The data includes log2 expression effects, p-values, and tag counts derived from linear model fitting, allowing for high-resolution functional analysis of non-coding variants.

## Data Access and Installation
The portal's data and tools are distributed via Bioconda. To set up the environment:

```bash
conda install bioconda::mpra-data-access-portal
```

## Core Regulatory Elements
The portal contains data for the following categories. Use these names when querying or downloading specific datasets:

### Promoters
- **Blood/Heme**: HBB (Thalassemia), HBG1 (HPFH), GP1BB (Bernard-Soulier)
- **Metabolic**: LDLR (Hypercholesterolemia), HNF4A (MODY), PKLR (Pyruvate kinase deficiency)
- **Cancer/Growth**: TERT (Various cancers), FOXE1 (Thyroid cancer), MSMB (Prostate cancer)
- **Coagulation**: F9 (Hemophilia B)

### Enhancers
- **Developmental**: UC88 (Ultraconserved), ZRS (Limb malformations), IRF6 (Cleft lip)
- **Disease-Linked**: BCL11A (Sickle cell), MYC (rs6983267/rs11986220), SORT1 (Myocardial infarction), TCF7L2/ZFAND3 (Type 2 diabetes)

## Data Format Specifications
When processing downloaded `.tsv` or `.csv` files, expect the following schema:

| Column | Description |
| :--- | :--- |
| **Chromosome** | Genomic location (e.g., chr11) |
| **Position** | Coordinate based on GRCh37 or GRCh38 |
| **Ref / Alt** | Reference and Alternative alleles (Deletions marked as `-`) |
| **Tags** | Number of unique barcodes associated with the variant |
| **DNA / RNA** | Raw counts used for linear model fitting |
| **Value** | **Log2 variant expression effect** (Coefficient from the model) |
| **P-Value** | Statistical significance of the expression effect |

## Best Practices
- **Coordinate Systems**: Always verify if you are using GRCh37 or GRCh38 coordinates, as the portal provides identical variant data mapped to both assemblies.
- **Missing Variants**: If a specific position/allele combination is missing from the file, it means the variant was not observed in the saturation mutagenesis library and was excluded from the final model.
- **Filtering**: For high-confidence functional analysis, filter variants based on the `Tags` count (higher counts indicate more robust measurements) and the `P-Value`.
- **Citation**: Data usage must cite Kircher et al. (Nature Communications, 2019) and adhere to the Fort Lauderdale principle regarding global analyses.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mpra-data-access-portal_overview.md)
- [Saturation Mutagenesis MPRA Portal Details](./references/kircherlab_bihealth_org_satMutMPRA.md)