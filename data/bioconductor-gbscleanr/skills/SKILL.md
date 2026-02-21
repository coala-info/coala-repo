---
name: bioconductor-gbscleanr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GBScleanR.html
---

# bioconductor-gbscleanr

## Overview
GBScleanR is a Bioconductor package designed for error correction of genotype data obtained via NGS-based methods like RAD-seq and GBS. It uses a Hidden Markov Model (HMM) to estimate true genotypes from allele read counts, supporting diploid and polyploid mapping populations derived from two or more parents. The package utilizes the Genomic Data Structure (GDS) for efficient handling of large datasets and is compatible with other Bioconductor tools like SNPRelate and GWASTools.

## Core Workflow

### 1. Data Initialization
Convert a VCF file to GDS format and load it into an R session.
```r
library(GBScleanR)

vcf_fn <- "data.vcf"
gds_fn <- "data.gds"

# Convert VCF to GDS
gbsrVCF2GDS(vcf_fn = vcf_fn, out_fn = gds_fn, force = TRUE)

# Load GDS (specify ploidy if not diploid)
gds <- loadGDS(gds_fn, ploidy = 2)
```

### 2. Data Summarization and Visualization
Calculate statistics to assess data quality before filtering.
```r
# Summarize counts
gds <- countGenotype(gds)
gds <- countRead(gds)

# Visualize statistics (missing rate, heterozygosity, read depth)
histGBSR(gds, stats = "missing")
histGBSR(gds, stats = "dp")
plotGBSR(gds, stats = "raf") # Reference allele frequency along chromosomes
```

### 3. Filtering
Filter markers, samples, or individual genotype calls.
```r
# Filter calls based on read depth (highly recommended)
# Use ref_qtile/alt_qtile to handle over-represented reads from mismapping
gds <- setCallFilter(gds, ref_qtile = c(0, 0.9), alt_qtile = c(0, 0.9))

# Filter markers and samples
gds <- setMarFilter(gds, missing = 0.2, maf = 0.05)
gds <- setSamFilter(gds, missing = 0.8)

# Thin markers to reduce redundancy (e.g., one marker per 150bp)
gds <- thinMarker(gds, range = 150)
```

### 4. Genotype Estimation (Error Correction)
This is the core functionality. It requires defining parents and the breeding scheme.

#### Set Parents
```r
# Identify parent sample IDs
p1 <- "Parent_A"
p2 <- "Parent_B"
gds <- setParents(gds, parents = c(p1, p2), mono = TRUE, bi = TRUE)
```

#### Define Breeding Scheme
```r
# Simple scheme (e.g., selfed F2)
gds <- makeScheme(gds, generation = 2, crosstype = "self")

# Complex/Manual scheme
gds <- initScheme(gds, mating = rbind(1, 2)) # Parent 1 x Parent 2
gds <- addScheme(gds, crosstype = "selfing")
```

#### Run Estimation
```r
# node = "filt" uses the filtered read counts
gds <- estGeno(gds, node = "filt", iter = 4)
```

### 5. Exporting Results
Retrieve corrected genotypes or export to standard formats.
```r
# Get corrected genotypes (0, 1, 2 format)
cor_geno <- getGenotype(gds, node = "cor")

# Export to VCF
gbsrGDS2VCF(gds, "corrected_data.vcf.gz", node = "cor")

# Export to CSV (optionally formatted for R/qtl)
gbsrGDS2CSV(gds, "qtl_data.csv", format = "qtl")
```

## Key Functions Reference
- `gbsrVCF2GDS()`: Converts VCF to GDS.
- `loadGDS()`: Loads GDS file into a GbsrGenotypeData object.
- `setParents()`: Defines founder samples.
- `makeScheme()`: Quickly sets up common breeding pedigrees.
- `estGeno()`: Performs HMM-based genotype estimation and error correction.
- `setCallFilter()`: Filters individual data points (DP, AD).
- `plotDosage()`: Visualizes estimated allele dosage against raw read ratios.
- `closeGDS()`: Safely closes the GDS file connection.

## Tips for Success
- **Memory Efficiency**: GBScleanR uses GDS to avoid loading entire datasets into RAM. Always use `closeGDS(gds)` at the end of a session.
- **Filtering Strategy**: The HMM is robust to low coverage. Focus filtering on removing extremely high-coverage calls (potential mismapping) using `ref_qtile` and `alt_qtile` rather than aggressive missing-data filtering.
- **Replicates**: If you have technical replicates, use `setReplicates()` before `estGeno()` to jointly evaluate read counts.
- **Polyploidy**: Set the `ploidy` argument in `loadGDS()` to enable polyploid haplotype estimation.

## Reference documentation
- [Basic usage of GBScleanR](./references/BasicUsageOfGBScleanR.md)