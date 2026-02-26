---
name: r-mutsigextractor
description: The mutSigExtractor R package extracts mutation contexts and fits mutational signatures from VCF files for SNVs, DBSs, indels, and structural variants. Use when user asks to extract mutation contexts, fit mutation signatures using COSMIC or PCAWG profiles, or decompose mutation counts into signature contributions.
homepage: https://cran.r-project.org/web/packages/mutsigextractor/index.html
---


# r-mutsigextractor

## Overview
The `mutSigExtractor` R package is designed to extract mutation contexts and signatures from VCF files. It supports Single Base Substitutions (SNV/SBS), Double Base Substitutions (DBS), Indels, and Structural Variants (SV). It provides built-in support for COSMIC and PCAWG signature profiles and uses non-negative linear least squares for signature fitting.

## Installation
```R
# Bioconductor dependencies
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("BSgenome", "BSgenome.Hsapiens.UCSC.hg19", "GenomeInfoDb"))

# Install mutSigExtractor from GitHub
if (!require("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github('UMCUGenetics/mutSigExtractor')
```

## Core Functions
The package provides specialized functions for different mutation types. Most functions can output either raw mutation counts (`output='contexts'`) or fitted signature contributions (`output='signatures'`).

### SNV Extraction (SBS)
Extracts 96 trinucleotide contexts.
```R
# Extract counts
contexts_snv <- extractSigsSnv(vcf.file="sample.vcf", vcf.filter='PASS', output='contexts')

# Extract signatures directly using PCAWG profiles
sigs_snv <- extractSigsSnv(
  vcf.file="sample.vcf", 
  vcf.filter='PASS', 
  output='signatures',
  signature.profiles=SBS_SIGNATURE_PROFILES_V3
)
```

### DBS and Indel Extraction
```R
# Double Base Substitutions (78 contexts)
contexts_dbs <- extractSigsDbs(vcf.file="sample.vcf", vcf.filter='PASS', output='contexts')

# Indels (CHORD method by default, or PCAWG)
contexts_indel <- extractSigsIndel(vcf.file="sample.vcf", vcf.filter='PASS', method='CHORD')
```

### Structural Variants (SV)
Supports GRIDSS and Manta VCF formats.
```R
contexts_sv <- extractSigsSv(
  vcf.file="sample.sv.vcf", 
  vcf.filter='PASS', 
  output='contexts', 
  sv.caller='gridss'
)
```

## Signature Fitting
If you already have context counts, use `fitToSignatures()` to decompose them into known signature profiles.
```R
sigs <- fitToSignatures(
   mut.context.counts = contexts_snv[,1],
   signature.profiles = SBS_SIGNATURE_PROFILES_V3
)
```

## Reference Genomes
The default is `hg19`. To use `hg38` or others, load the BSgenome object and pass the variable (unquoted).
```R
library(BSgenome.Hsapiens.UCSC.hg38)
extractSigsSnv(..., ref.genome = BSgenome.Hsapiens.UCSC.hg38)
```

## Pre-loaded Data
- `SBS_SIGNATURE_PROFILES_V2`: Original 30 COSMIC SNV signatures.
- `SBS_SIGNATURE_PROFILES_V3`: PCAWG SNV signatures.
- `INDEL_SIGNATURE_PROFILES`: PCAWG indel signatures.
- `DBS_SIGNATURE_PROFILES`: PCAWG DBS signatures.
- `SV_SIGNATURE_PROFILES`: SV signatures (Nik-Zainal et al. 2016).

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)