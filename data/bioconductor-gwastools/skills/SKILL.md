---
name: bioconductor-gwastools
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GWASTools.html
---

# bioconductor-gwastools

name: bioconductor-gwastools
description: Expert guidance for using the GWASTools R package for quality control and analysis of Genome-Wide Association Study (GWAS) data. Use this skill when you need to prepare SNP and Scan annotation objects, convert raw genotype/intensity data into GDS or NetCDF formats, perform batch quality checks (missingness, chi-square tests), conduct sample quality checks (BAF variance, heterozygosity, sex verification), or estimate relatedness and population structure.

## Overview

GWASTools provides a comprehensive infrastructure for GWAS data management and quality control. It utilizes high-performance data formats (GDS and NetCDF) to handle large-scale datasets that exceed system memory. The package centers around three main object classes: `SnpAnnotationDataFrame`, `ScanAnnotationDataFrame`, and `GenotypeData`/`IntensityData` (which link annotations to the underlying data files).

## Core Workflow

### 1. Creating Annotation Objects
Annotations are the backbone of GWASTools. They must contain specific required variables.

**SNP Annotation:**
Requires `snpID` (unique integer), `chromosome` (integer 1-27), and `position` (base pair).
```r
library(GWASTools)
# df is a data frame with snpID, chromosome, position
snpAnnot <- SnpAnnotationDataFrame(df)
# Add metadata for clarity
varMetadata(snpAnnot)["chromosome", "labelDescription"] <- "1:22=autosomes, 23=X, 24=XY, 25=Y, 26=M, 27=U"
```

**Scan Annotation:**
Requires `scanID` (unique integer) and `sex` ("M"/"F").
```r
# df is a data frame with scanID, subjectID, sex
scanAnnot <- ScanAnnotationDataFrame(df)
```

### 2. Data File Creation (GDS)
Convert raw text files (e.g., Affymetrix CHP or Illumina CSV) into GDS format using `createDataFile`.

```r
# Define column mapping
col.nums <- as.integer(c(2, 3))
names(col.nums) <- c("snp", "geno")

createDataFile(path = "path/to/raw",
               filename = "output.gds",
               file.type = "gds",
               variables = "genotype",
               snp.annotation = snp_df,
               scan.annotation = scan_df,
               col.nums = col.nums,
               sep.type = "\t",
               skip.num = 1)
```

### 3. Linking Data and Annotations
Create a `GenotypeData` or `IntensityData` object to perform analyses.

```r
gds <- GdsGenotypeReader("output.gds")
genoData <- GenotypeData(gds, snpAnnot=snpAnnot, scanAnnot=scanAnnot)

# Access data
getGenotype(genoData, snp=c(1,10), scan=c(1,5))
close(genoData)
```

## Quality Control Procedures

### Missingness Analysis
Calculate missing call rates per SNP and per Scan.
*   `missingGenotypeBySnpSex(genoData)`: Returns missing fraction per SNP, handling Y chromosome correctly for females.
*   `missingGenotypeByScanChrom(genoData)`: Returns missing fraction per scan across chromosomes.

### Sex Verification
Identify mis-annotated samples by comparing genetic data to records.
*   `meanIntensityByScanChrom(intenData)`: Calculate mean X and Y intensities.
*   `hetByScanChrom(genoData)`: Calculate X chromosome heterozygosity (expected high in females, near zero in males).

### B-Allele Frequency (BAF) and Log R Ratio (LRR)
Used to detect chromosomal anomalies (duplications, deletions, or contamination).
*   `BAFfromGenotypes()`: Calculates BAF/LRR from intensities and genotypes (primarily for Affymetrix).
*   `sdByScanChromWindow()`: Identifies regions of high BAF variance using a sliding window.
*   `chromIntensityPlot()`: Visualizes BAF and LRR across a chromosome for specific scans.

### Batch Effects
*   `batchChisqTest()`: Performs chi-square tests for allele frequency differences between batches.
*   `batchFisherTest()`: Use for low-frequency SNPs.

## Relatedness and Population Structure
GWASTools integrates with `SNPRelate` for high-performance IBD and PCA.
*   `snpgdsIBDKING()`: Robust kinship estimation.
*   `snpgdsPCA()`: Principal Component Analysis to identify population stratification.

## Best Practices
*   **Integer Chromosomes:** Always use the 1-27 integer mapping. Use `getChromosome(obj, char=TRUE)` for display.
*   **Closing Files:** Always use `close(genoData)` or `close(gds)` to free file handles and prevent data corruption.
*   **Ordering:** Ensure SNP annotations are ordered by chromosome and position before creating GDS files.
*   **Diagnostics:** Always check the output of `createDataFile` (e.g., `diag$chk`) to ensure all raw files were read correctly.

## Reference documentation
- [Preparing Affymetrix Data](./references/Affymetrix.md)
- [GWAS Data Cleaning](./references/DataCleaning.md)
- [Data Formats](./references/Formats.md)