---
name: ascat
description: The ascat tool performs allele-specific copy number analysis of tumor samples to estimate purity, ploidy, and discrete copy number states from genomic signals. Use when user asks to load tumor and germline data, perform allele-specific segmentation, estimate tumor purity and ploidy, or process high-throughput sequencing data for copy number profiling.
homepage: https://www.crick.ac.uk/research/a-z-researchers/researchers-v-y/peter-van-loo/software/
---


# ascat

## Overview
The `ascat` skill provides a specialized workflow for the Allele-Specific Copy number Analysis of Tumors. It transforms raw genomic signals (LogR and B Allele Frequency) into biological insights by estimating the fraction of tumor cells (purity) and the DNA content (ploidy). This tool is essential when analyzing heterogeneous tumor samples where normal cell contamination or large-scale chromosomal imbalances would otherwise bias copy number calls.

## Core R Workflow
The standard ASCAT pipeline follows a specific sequence of R function calls. Ensure the `ASCAT` library is loaded before proceeding.

### 1. Data Loading
Load the tumor and germline data. The input files should be tab-delimited text files where rows are SNP loci and columns are samples.
```r
library(ASCAT)
# Load data (default assumes female 'XX'; use gender = "XY" for males)
ascat.bc = ascat.loadData(
    Tumor_LogR = "Tumor_LogR.txt", 
    Tumor_BAF = "Tumor_BAF.txt", 
    Germline_LogR = "Germline_LogR.txt", 
    Germline_BAF = "Germline_BAF.txt",
    gender = "XX"
)
```

### 2. Visualization and Quality Control
Always plot raw data to inspect for noise or batch effects before proceeding to segmentation.
```r
ascat.plotRawData(ascat.bc)
```

### 3. Segmentation (AS-PCF)
Perform Allele-Specific Piecewise Constant Fitting (AS-PCF) to identify genomic segments with similar copy number states.
```r
ascat.bc = ascat.aspcf(ascat.bc)
ascat.plotSegmentedData(ascat.bc)
```

### 4. Model Execution
Run the main ASCAT algorithm to estimate purity, ploidy, and discrete copy number states.
```r
ascat.output = ascat.runAscat(ascat.bc)
```

## High-Throughput Sequencing (HTS) Workflow
For BAM files instead of SNP arrays, use the HTS-specific preprocessing functions to generate the required LogR and BAF files.

- **Standard HTS**: Use `ascat.prepareHTS()` to extract allele counts and derive signals using reference files.
- **Targeted Sequencing**: Use `ascat.prepareTargetedSeq()` to focus on high-quality SNPs within specific capture regions.

## Best Practices
- **Matched Normals**: While ASCAT can run without matched normal data, using germline samples significantly improves the accuracy of BAF-based segmentation.
- **LogR Correction**: For samples with significant GC-content bias or replication timing artifacts, apply a LogR correction step before segmentation.
- **Gender Specification**: Explicitly set the `gender` parameter in `ascat.loadData` to ensure correct handling of sex chromosomes (X and Y).
- **Platform Independence**: ASCAT works for both Illumina and Affymetrix platforms. For Affymetrix SNP 6.0, ensure you use the specific SNP location and genotype cluster files provided by the Van Loo Lab.

## Reference documentation
- [Van Loo Laboratory Resources](./references/www_mdanderson_org_research_departments-labs-institutes_labs_van-loo-laboratory_resources.html.md)
- [ASCAT Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ascat_overview.md)