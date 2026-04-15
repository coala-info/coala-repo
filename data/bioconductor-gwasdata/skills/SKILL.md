---
name: bioconductor-gwasdata
description: This package provides example SNP genotype and intensity data from HapMap subjects in GDS and NetCDF formats to support GWASTools workflows. Use when user asks to access sample GWAS datasets, load Illumina or Affymetrix annotation data, or practice using GWASTools for genotype analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/GWASdata.html
---

# bioconductor-gwasdata

## Overview
The `GWASdata` package is a supplemental data package for Bioconductor, primarily designed to support the examples and vignettes in the `GWASTools` package. It contains selected SNP data from 77 HapMap subjects genotyped on Illumina arrays and 47 subjects on Affymetrix arrays. The data includes genotypes, intensities (X and Y), quality scores, and B-allele frequencies stored in NetCDF and GDS formats, along with corresponding annotation data frames.

## Data Access and Workflows

### Loading Annotation Data
The package provides pre-loaded `data.frame` and `AnnotationDataFrame` objects for both Affymetrix and Illumina platforms.

```R
library(GWASdata)

# Load Illumina annotations
data(illumina_scan_annot) # data.frame
data(illumina_snp_annot)  # data.frame
data(illuminaScanADF)     # ScanAnnotationDataFrame
data(illuminaSnpADF)      # SnpAnnotationDataFrame

# Load Affymetrix annotations
data(affy_scan_annot)
data(affy_snp_annot)
data(affyScanADF)
data(affySnpADF)
```

### Accessing External Data Files (NetCDF and GDS)
The core genotype and intensity data are stored in the `extdata` directory of the package. Use `system.file` to locate these files for use with `GWASTools` readers.

**Working with Illumina GDS Files:**
```R
# Locate the GDS file
gds_file <- system.file("extdata", "illumina_geno.gds", package="GWASdata")

# Open the reader (requires GWASTools)
library(GWASTools)
gds <- GdsGenotypeReader(gds_file)

# Create a GenotypeData object combining genotypes and annotations
genoData <- GenotypeData(gds, snpAnnot=illuminaSnpADF, scanAnnot=illuminaScanADF)

# Retrieve specific genotypes (e.g., first 10 SNPs for first 5 scans)
geno <- getGenotype(gds, snp=c(1,10), scan=c(1,5))
close(gds)
```

**Working with NetCDF Files:**
```R
# Locate the NetCDF file
nc_file <- system.file("extdata", "illumina_geno.nc", package="GWASdata")

# Open the reader
nc <- NcdfGenotypeReader(nc_file)
# ... perform analysis ...
close(nc)
```

### Available Data Files in extdata
- **Genotypes:** `illumina_geno.gds`, `illumina_geno.nc`, `affy_geno.nc`
- **Intensities/Quality:** `illumina_qxy.gds`, `illumina_qxy.nc`, `affy_qxy.nc`
- **B-Allele Freq/LogR Ratio:** `illumina_bl.gds`, `illumina_bl.nc`
- **Raw Text Data:** Located in `illumina_raw_data` and `affy_raw_data` directories for 3 subjects.
- **PLINK Format:** `illumina_subj.ped`, `illumina_subj.map`, `illumina_subj.bim`

## Tips for Usage
- **GWASTools Dependency:** This package is almost always used in conjunction with `GWASTools`. Ensure `GWASTools` is loaded to provide the reader functions (`GdsGenotypeReader`, `NcdfGenotypeReader`).
- **Data Subsets:** Note that this is "Experiment Data." It only contains 1000 SNPs for chromosomes 21, 22, and X, and 100 SNPs for Y, M, and the pseudoautosomal region. It is not intended for full-scale biological discovery but for pipeline validation.
- **Memory Management:** Always `close()` the reader objects (GDS or NetCDF) after you are finished to release file handles.

## Reference documentation
- [GWASdata Reference Manual](./references/reference_manual.md)