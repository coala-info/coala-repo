---
name: bioconductor-tvtb
description: This tool filters, summarizes, and visualizes genetic variation data from VCF files pre-processed by Ensembl VEP. Use when user asks to calculate allele frequencies across phenotypes, filter VCF data using Ensembl VEP annotations, or manage genetic variants with specialized S4 classes.
homepage: https://bioconductor.org/packages/release/bioc/html/TVTB.html
---

# bioconductor-tvtb

name: bioconductor-tvtb
description: Filtering, summarizing, and visualizing genetic variation data from VCF files (pre-processed by Ensembl VEP). Use this skill to manage VCF data using specialized S4 classes (TVTBparam, VcfFilterRules), calculate allele frequencies across phenotypes, and generate genomic visualizations.

## Overview

The `TVTB` (VCF Tool Box) package provides a robust framework for analyzing genetic variants stored in `VCF` objects (from the `VariantAnnotation` package). It is specifically designed to work with Ensembl Variant Effect Predictor (VEP) annotations. Its core strengths are the `TVTBparam` class for centralized analysis settings and a suite of specialized `FilterRules` that simplify complex filtering across different VCF slots (fixed, info, and VEP predictions).

## Core Workflow

### 1. Initialize Analysis Parameters

Use `TVTBparam` to store recurrent settings like genotype encodings and genomic ranges. This object is used by most functions in the package.

```r
library(TVTB)

# Define genotype encodings and target regions
tparam <- TVTBparam(
    Genotypes(
        ref = "0|0",
        het = c("0|1", "1|0", "0|2", "2|0", "1|2", "2|1"),
        alt = c("1|1", "2|2")
    ),
    ranges = GRangesList(
        gene1 = GRanges("15", IRanges(48413170, 48434757))
    )
)
```

### 2. Data Import and Pre-processing

Import VCF data using `VariantAnnotation::readVcf`. Passing the `TVTBparam` object to `readVcf` automatically restricts the import to the specified genomic ranges.

```r
# Import with phenotypes in colData
vcf <- readVcf(vcfFile, param = tparam, colData = phenotypes)

# Expand multi-allelic records to bi-allelic records (required for many TVTB methods)
vcf <- expand(vcf, row.names = TRUE)
```

### 3. Calculating Allele Frequencies

`TVTB` can calculate and add genotype counts and allele frequencies (AAF, MAF) directly into the `info` slot of the VCF object, either globally or grouped by phenotype.

```r
# Add overall frequencies
vcf <- addOverallFrequencies(vcf)

# Add frequencies for specific phenotype levels (e.g., super_pop == "AFR")
vcf <- addPhenoLevelFrequencies(vcf, pheno = "super_pop", level = "AFR")

# Add frequencies for all levels of a phenotype
vcf <- addFrequencies(vcf, phenos = "pop")
```

### 4. Advanced Filtering with VcfFilterRules

`TVTB` provides specialized classes to filter different parts of a VCF object. These can be combined into a single `VcfFilterRules` object.

*   **VcfFixedRules**: Filters the `fixed` slot (e.g., FILTER, QUAL).
*   **VcfInfoRules**: Filters the `info` slot (e.g., MAF, AC).
*   **VcfVepRules**: Filters VEP predictions (e.g., Consequence, SIFT).

```r
# Define rules
fixedR <- VcfFixedRules(list(pass = expression(FILTER == "PASS")))
infoR <- VcfInfoRules(list(common = expression(MAF > 0.05)))
vepR <- VcfVepRules(list(missense = expression(Consequence == "missense_variant")))

# Combine and apply
vcfRules <- VcfFilterRules(fixedR, infoR, vepR)
vcf_filtered <- subsetByFilter(vcf, vcfRules)

# Toggle rules without deleting them
active(vcfRules)["missense"] <- FALSE
```

### 5. Visualization

The package integrates with `Gviz` and `GGally` for genomic and statistical plots.

```r
# Plot INFO data (e.g., AAF) along genomic coordinates by phenotype
plotInfo(
    vcf_filtered, 
    field = "AAF", 
    range = range(granges(vcf)),
    reference = EnsDb.Hsapiens.v75, # Annotation object
    pheno = "super_pop"
)

# Pairwise comparison of frequencies between phenotype levels
pairsInfo(vcf_filtered, "AAF", "super_pop")
```

## Tips for Success

*   **ExpandedVCF**: Most `TVTB` methods expect `ExpandedVCF` objects (bi-allelic). Use `VariantAnnotation::expand()` after import.
*   **Enclosing Environments**: When using variables from the global environment inside filter expressions (like a numeric cutoff), pass `enclos = .GlobalEnv` to `eval()` or `subsetByFilter()`.
*   **VEP Key**: Ensure the `vep` slot in `TVTBparam` matches the INFO key in your VCF (usually "CSQ"). Use `parseCSQToGRanges(vcf)` to inspect available VEP fields.
*   **Suffixes**: Be mindful of INFO key suffixes in `TVTBparam` (default: REF, HET, ALT, AAF, MAF) to avoid overwriting existing data.

## Reference documentation

- [Introduction to TVTB](./references/Introduction.md)
- [VCF filter rules](./references/VcfFilterRules.md)
- [Shiny Variant Explorer (tSVE)](./references/tSVE.md)