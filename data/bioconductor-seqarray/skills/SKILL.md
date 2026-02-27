---
name: bioconductor-seqarray
description: Bioconductor-seqarray provides high-performance data management and analysis of large-scale genome-wide sequence variants by converting VCF files into the efficient GDS format. Use when user asks to convert VCF files to GDS, filter genomic data by samples or ranges, perform parallelized genotype calculations, or integrate with downstream analysis tools like SNPRelate and GENESIS.
homepage: https://bioconductor.org/packages/release/bioc/html/SeqArray.html
---


# bioconductor-seqarray

name: bioconductor-seqarray
description: Data management and high-performance analysis of genome-wide sequence variants (WGS) from VCF files. Use when you need to: (1) Convert large VCF files to the efficient GDS format, (2) Filter genomic data by samples, variants, or genomic ranges (GRanges), (3) Perform parallelized calculations on genotypes (allele frequencies, PCA, relatedness), or (4) Integrate with other Bioconductor packages like SeqVarTools, SNPRelate, and GENESIS for downstream analysis.

# bioconductor-seqarray

## Overview

The `SeqArray` package provides an infrastructure for managing large-scale whole-genome sequencing (WGS) data. It converts Variant Call Format (VCF) files into the Genomic Data Structure (GDS) format, which stores data in a binary, array-oriented manner. This allows for high-performance computing, efficient random access, and significant data compression (especially for rare variants). It is designed to work seamlessly with multi-core architectures and cluster environments.

## Key Workflows

### 1. Data Conversion and Setup
The primary entry point is converting VCF files to GDS.

```R
library(SeqArray)

# Convert VCF to GDS
vcf.fn <- "path/to/data.vcf.gz"
seqVCF2GDS(vcf.fn, "data.gds", storage.option="LZMA_RA")

# Open the GDS file
genofile <- seqOpen("data.gds")

# Get a summary of the file contents
seqSummary(genofile)
```

### 2. Filtering Samples and Variants
Use `seqSetFilter` to define subsets. This is highly efficient as it doesn't load the data into memory until requested.

```R
# Filter by specific IDs
seqSetFilter(genofile, sample.id=c("ID1", "ID2"), variant.id=1:100)

# Filter by genomic ranges (requires GenomicRanges)
library(GenomicRanges)
coords <- GRanges(seqnames="22", ranges=IRanges(1000000, 2000000))
seqSetFilter(genofile, variant.sel=coords)

# Reset filters
seqResetFilter(genofile)
```

### 3. Data Retrieval
Retrieve specific fields for the currently filtered subset.

```R
# Get genotypes (returns a 3D array: ploidy x sample x variant)
geno <- seqGetData(genofile, "genotype")

# Get allele frequencies or missing rates
afreq <- seqAlleleFreq(genofile)
miss <- seqMissing(genofile)
```

### 4. High-Performance Computing with seqApply
`seqApply` is the workhorse for custom calculations. It applies a function over variants or samples.

```R
# Calculate reference allele frequency manually
af <- seqApply(genofile, "genotype", margin="by.variant", as.is="double",
               FUN=function(x) { mean(x == 0L, na.rm=TRUE) })

# Use multiple cores
af <- seqApply(genofile, "genotype", margin="by.variant", as.is="double",
               FUN=function(x) { mean(x == 0L, na.rm=TRUE) }, parallel=4)
```

### 5. Integration with Downstream Packages
`SeqArray` serves as the data backend for several specialized analysis packages:

*   **SNPRelate**: For PCA and Relatedness (IBD/IBS) analysis.
*   **SeqVarTools**: For HWE, Mendelian errors, and regression.
*   **GENESIS**: For mixed-model association testing in structured populations.

```R
library(SNPRelate)
# Run PCA directly on the SeqArray file
pca <- snpgdsPCA(genofile, num.thread=2)
```

## Tips and Best Practices
*   **Memory Management**: Always use `seqClose(genofile)` when finished to release file handles.
*   **Dosage Data**: Use `$dosage` in `seqApply` to get the count of alternate alleles (0, 1, 2) instead of the raw 3D genotype array when appropriate.
*   **Parallel Setup**: For complex parallel tasks, use `seqParallelSetup(cores)` at the start of your script and `seqParallelSetup(FALSE)` at the end.
*   **C++ Integration**: For maximum speed, pass `Rcpp` functions to `seqApply`.

## Reference documentation
- [SeqArray Overview](./references/OverviewSlides.md)
- [R Integration](./references/SeqArray.md)
- [SeqArray Data Format and Access](./references/SeqArrayTutorial.md)