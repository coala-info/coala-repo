---
name: bioconductor-variantfiltering
description: This tool filters and functionally annotates genetic variants from VCF files based on inheritance models and functional impact. Use when user asks to filter variants by inheritance patterns like autosomal dominant or recessive, identify de novo mutations, or annotate variants using Sequence Ontology terms and minor allele frequencies.
homepage: https://bioconductor.org/packages/release/bioc/html/VariantFiltering.html
---

# bioconductor-variantfiltering

name: bioconductor-variantfiltering
description: Filtering and functional annotation of genetic variants (coding and non-coding) from VCF files. Use this skill to identify variants segregating according to inheritance models (autosomal dominant/recessive, X-linked, de novo) or to filter variants in unrelated individuals based on functional impact, MAF, and Sequence Ontology (SO) terms.

## Overview

The `VariantFiltering` package is designed for the filtering and annotation of genetic variants. It processes multisample VCF files and integrates with Bioconductor annotation resources to provide functional context. It is particularly powerful for family-based studies where specific inheritance patterns are expected, but it also supports filtering unrelated individuals using a wide array of functional criteria.

## Core Workflow

### 1. Parameter Setup
The analysis begins by creating a `VariantFilteringParam` object. This object defines the input VCF, optional PED file, and the annotation resources (BSgenome, TxDb, OrgDb, etc.) to be used.

```r
library(VariantFiltering)

# Path to VCF
vcf_file <- system.file("extdata", "CEUtrio.vcf.bgz", package="VariantFiltering")

# Basic parameter object
vfpar <- VariantFilteringParam(vcf_file)
```

### 2. Annotating and Filtering by Inheritance
Depending on the study design, use one of the following functions to generate a `VariantFilteringResults` object:

*   **Unrelated Individuals:** `unrelatedIndividuals(vfpar)` - Annotates all variants without inheritance filtering.
*   **Autosomal Recessive (Homozygous):** `autosomalRecessiveHomozygous(vfpar)` - Search for homozygous variants in affected individuals.
*   **Autosomal Recessive (Heterozygous):** `autosomalRecessiveHeterozygous(vfpar)` - Search for compound heterozygotes.
*   **Autosomal Dominant:** `autosomalDominant(vfpar)` - Search for variants present in affected and absent in unaffected.
*   **X-Linked:** `xLinked(vfpar)` - Search for X-linked recessive patterns (currently restricted to affected males).
*   **De Novo:** `deNovo(vfpar)` - Search for variants in offspring not present in parents.

### 3. Exploring Results
The results object can be summarized to see the distribution of variants across Sequence Ontology (SO) terms or Bioconductor categories.

```r
# Summary by SO terms
summary(uind)

# Summary by Bioconductor categories (intron, fiveUTR, etc.)
summary(uind, method="bioc")

# Retrieve variants as VRangesList
vars <- allVariants(uind)
```

### 4. Interactive Filtering and Cutoffs
`VariantFiltering` uses a system of active filters and cutoffs to prioritize variants.

*   **View/Activate Filters:** Use `filters(uind)` and `active()`.
*   **Set Cutoffs:** Use `cutoffs(uind)` to modify thresholds for MAF, SO terms, or other metrics.
*   **MAF Filtering:**
    ```r
    # Set MAF threshold to 0.01
    change(cutoffs(uind)$maxMAF, "maxvalue") <- 0.01
    active(filters(uind))["maxMAF"] <- TRUE
    ```

### 5. Visualization and Reporting
*   **Plotting:** If BAM files are provided via `bamFiles(uind)`, you can visualize specific variants: `plot(uind, what="rsID", sampleName="Sample1")`.
*   **Exporting:** Create a static report or launch an interactive Shiny app:
    ```r
    # Export to CSV
    reportVariants(uind, type="csv", file="results.csv")

    # Launch interactive Shiny UI
    reportVariants(uind, type="shiny")
    ```

## Tips for Efficient Usage
*   **Streaming:** For large VCF files, use the `yieldSize` argument in `VariantFilteringParam` to process the file in chunks and reduce memory footprint.
*   **Parallelization:** Most functions support a `BPPARAM` argument. By default, it uses `bpparam()`, but you can disable parallelism for debugging using `SerialParam()`.
*   **Custom Filters:** You can add custom R functions to the `filters()` list to implement bespoke biological logic.

## Reference documentation
- [VariantFiltering: filtering of coding and non-coding genetic variants](./references/usingVariantFiltering.md)