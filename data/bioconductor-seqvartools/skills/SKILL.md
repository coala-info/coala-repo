---
name: bioconductor-seqvartools
description: SeqVarTools provides a high-level interface for the efficient analysis and manipulation of large-scale sequencing data stored in SeqArray GDS files. Use when user asks to convert VCF files to GDS format, filter genomic variants, calculate quality control metrics like Ti/Tv ratios or Hardy-Weinberg equilibrium, and perform association testing using regression models.
homepage: https://bioconductor.org/packages/release/bioc/html/SeqVarTools.html
---

# bioconductor-seqvartools

## Overview
`SeqVarTools` provides a high-level interface for interacting with `SeqArray` GDS (Genomic Data Structure) files. It is designed for efficient analysis of large-scale sequencing datasets, offering tools for data manipulation, quality control metrics, and association testing. It utilizes a filtering-based approach to handle data subsets without loading entire datasets into memory.

## Core Workflows

### 1. Data Initialization and Conversion
To use `SeqVarTools`, VCF files must first be converted to the GDS format.

```r
library(SeqVarTools)

# Convert VCF to GDS
vcffile <- "input.vcf"
gdsfile <- "output.gds"
seqVCF2GDS(vcffile, gdsfile)

# Open the GDS file
gds <- seqOpen(gdsfile)

# Basic exploration
refChar(gds)      # Reference alleles
altChar(gds)      # Alternate alleles
nAlleles(gds)     # Number of alleles per site
granges(gds)      # Genomic coordinates
```

### 2. Filtering and Subsetting
Filters restrict subsequent function calls to specific samples or variants.

```r
# Set filters
seqSetFilter(gds, variant.id=1:100, sample.id=c("S1", "S2"))
seqSetFilterChrom(gds, include="22")

# Apply a method to a specific subset without changing global filter
applyMethod(gds, getGenotype, variant=variant_ids, sample=sample_ids)

# Reset filters
seqResetFilter(gds)
```

### 3. Quality Control Metrics
Common population genetics metrics used to assess variant and sample quality.

```r
# Transition/Transversion ratio
titv(gds)
titv(gds, by.sample=TRUE)

# Missingness and Heterozygosity
missingGenotypeRate(gds, margin="by.variant")
heterozygosity(gds, margin="by.sample")

# Hardy-Weinberg Equilibrium
hw <- hwe(gds)
# Inbreeding coefficient
ic <- inbreedCoeff(gds, margin="by.sample")

# Mendelian Errors (requires pedigree data)
err <- mendelErr(gds, pedigree)
```

### 4. Iterators for Large Data
Iterators allow processing data in chunks (blocks, ranges, or windows) to manage memory.

```r
# Block iterator (500 variants at a time)
iterator <- SeqVarBlockIterator(seqData, variantBlock=500)
while(iterateFilter(iterator)) {
    var_info <- variantInfo(iterator)
    # Process chunk...
}

# Window iterator (sliding windows)
iterator <- SeqVarWindowIterator(seqData, windowSize=10000, windowShift=5000)
```

### 5. Association Testing
Perform regression analysis by combining GDS data with sample metadata in a `SeqVarData` object.

```r
library(Biobase)
# Create SeqVarData object
sample_data <- AnnotatedDataFrame(pedigree_df)
seqData <- SeqVarData(gds, sample_data)

# Linear regression (continuous outcome)
assoc_lin <- regression(seqData, outcome="phenotype", covar="sex", model.type="linear")

# Logistic/Firth regression (binary outcome)
# Firth is recommended for rare variants
assoc_log <- regression(seqData, outcome="case.status", covar=c("sex", "age"), model.type="firth")
```

## Tips and Best Practices
- **Variant IDs**: By default, GDS uses integer IDs. You can rename them to rsIDs using `setVariantID()`, but note that character IDs may be slower for very large datasets.
- **Memory Management**: Always use `seqClose(gds)` when finished to release file handles.
- **Genotype Formats**: `getGenotype()` returns 0/1/2/NA format, while `getGenotypeAlleles()` returns the actual nucleotides (e.g., "A/C").
- **Performance**: If running the same analysis on multiple subsets, set the filter once rather than calling `applyMethod` repeatedly.

## Reference documentation
- [Using Iterators in SeqVarTools](./references/Iterators.md)
- [Introduction to SeqVarTools](./references/SeqVarTools.md)