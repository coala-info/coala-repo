---
name: bioconductor-hapfabia
description: The package supports VCF formats, is based on sparse matrix operations, and provides visualization of haplotype clusters in different formats.
homepage: https://bioconductor.org/packages/release/bioc/html/hapFabia.html
---

# bioconductor-hapfabia

name: bioconductor-hapfabia
description: Identification of very short identity by descent (IBD) segments tagged by rare variants in large sequencing data using FABIA biclustering. Use this skill to process VCF files, convert them to sparse matrix formats, identify IBD segments shared among multiple individuals, and visualize haplotype clusters.

## Overview
The `hapFabia` package implements the HapFABIA method, which utilizes sparse matrix factor analysis (FABIA) to detect short IBD segments. It is specifically designed to leverage the information provided by rare variants, which are more informative for IBD detection than common variants. The workflow typically involves converting VCF data to a specialized sparse matrix format, splitting the genome into manageable intervals, running the biclustering algorithm, and post-processing the results to extract and prune IBD segments.

## Typical Workflow

### 1. Data Preparation
Convert VCF files to the sparse matrix format required by the package.

```R
library(hapFabia)
fileName <- "my_genotypes" # without .vcf extension

# Convert VCF to sparse matrix (generates _matG.txt, _annot.txt, etc.)
vcftoFABIA(fileName = fileName)

# Copy genotype matrix to the processing matrix
file.copy(paste0(fileName, "_matG.txt"), paste0(fileName, "_mat.txt"))

# Split into overlapping intervals (e.g., 10000 SNVs with 5000 overlap)
split_sparse_matrix(fileName = fileName, intervalSize = 10000, shiftSize = 5000, annotation = TRUE)
```

### 2. Running the Pipeline
The easiest way to execute the full analysis is to generate and source a pipeline file.

```R
# Create a pipeline script
makePipelineFile(fileName = "my_genotypes", shiftSize = 5000, intervalSize = 10000, haplotypes = TRUE)

# Execute the pipeline
source("pipeline.R")
```

### 3. Manual Analysis of Intervals
If you prefer to run steps manually or in parallel:

```R
# Identify IBD segments in a specific range
iterateIntervals(startRun = 1, endRun = 10, shift = 5000, intervalSize = 10000, fileName = "my_genotypes")

# Identify and mark duplicates from overlapping intervals
identifyDuplicates(fileName = "my_genotypes", startRun = 1, endRun = 10, shift = 5000, intervalSize = 10000)

# Analyze results and get statistics
anaRes <- analyzeIBDsegments(fileName = "my_genotypes", startRun = 1, endRun = 10, shift = 5000, intervalSize = 10000)
```

## Key Functions and Objects

### IBD Segment Extraction
The core algorithm is `hapFabia()`. It identifies biclusters and then extracts IBD segments based on local tagSNV accumulations.
- `Lt`: Threshold for FABIA loadings (default 0.1).
- `Zt`: Threshold for FABIA factors (default 0.2).
- `minTagSNVs`: Minimum number of tagSNVs to call an IBD segment.

### Visualization
Use the `plot` method on `IBDsegment` or `IBDsegmentList` objects to visualize the sharing pattern.
- **Yellow**: Major alleles.
- **Violet**: Minor alleles of tagSNVs (identified by the model).
- **Blue**: Minor alleles of other SNVs.

```R
# Load results for a specific interval
load("my_genotypes_0_10000_resAnno.Rda")
ibdList <- resHapFabia$mergedIBDsegmentList

# Plot the first segment
plot(ibdList[[1]], filename = "my_genotypes_0_10000_mat")
```

### Result Inspection
- `summary(ibdList)`: Provides statistics on segment lengths (SNVs and bp), number of individuals, and tagSNV frequencies.
- `topLZ()`: Extracts the largest loadings (SNVs) and factors (individuals) from a FABIA result.

## Tips for Success
- **Rare Variants**: HapFABIA is optimized for rare variants. Ensure your data includes them, as they provide the signal for short IBD segments.
- **Memory Management**: For large cohorts, always use the `split_sparse_matrix` approach to process the genome in chunks.
- **Phasing**: While HapFABIA works on unphased data (using genotypes or dosages), phased data (haplotypes) generally provides cleaner results for IBD detection.
- **Parameter Tuning**: If finding too many or too few segments, adjust `alpha` (sparseness) or `thresCount` (binomial test threshold for local accumulation).

## Reference documentation
- [hapFabia: Identification of very short segments of identity by descent (IBD) characterized by rare variants in large sequencing data](./references/hapfabia.md)