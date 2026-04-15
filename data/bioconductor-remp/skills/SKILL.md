---
name: bioconductor-remp
description: REMP predicts site-specific DNA methylation of repetitive elements using genetic and epigenetic information from Illumina arrays or sequencing data. Use when user asks to predict Alu, LINE-1, or LTR methylation, preprocess methylation data for repetitive element analysis, or aggregate CpG-level predictions to repetitive element levels.
homepage: https://bioconductor.org/packages/release/bioc/html/REMP.html
---

# bioconductor-remp

## Overview

REMP (Repetitive Element Methylation Prediction) is a Bioconductor package designed to predict site-specific DNA methylation of repetitive elements (REs). It leverages surrounding genetic and epigenetic information from Illumina BeadChip arrays (450k/EPIC) or sequencing platforms to provide genome-wide, single-base resolution of RE methylation. It currently supports Human (hg19/hg38) Alu, LINE-1 (L1), and Long Terminal Repeat (LTR) elements.

## Core Workflow

### 1. Data Preprocessing (Grooming)
Before prediction, methylation data must be cleaned. The `grooMethy` function handles missing values (KNN imputation), infinite values, and boundary issues (0/1 beta values).

```r
library(REMP)
# For array data (RatioSet, GenomicRatioSet, matrix, or data.frame)
# Rows must be Illumina probe IDs (e.g., cg00000029)
my_data <- grooMethy(my_methylation_data)

# For sequencing data, provide a GRanges object for CpG locations
my_seq_data <- grooMethy(my_matrix, Seq.GR = my_cpg_locations)
```

### 2. Annotation Preparation
Initialize the annotation "parcel" for the specific RE type and genome build.

```r
# annotation.source can be "AH" (AnnotationHub) or "UCSC"
remparcel <- initREMP(arrayType = "450k", # or "EPIC", "Sequencing"
                      REtype = "Alu",      # "Alu", "L1", or "LTR"
                      genome = "hg19",     # "hg19" or "hg38"
                      annotation.source = "AH")
```

### 3. Running Prediction
The `remp` function performs the prediction, typically using Random Forest (`method = 'rf'`).

```r
remp.res <- remp(my_data,
                 REtype = "Alu",
                 parcel = remparcel,
                 ncore = 1,
                 seed = 777)

# View summary
details(remp.res)
```

### 4. Post-Processing and Quality Control
Predictions include a reliability score (lower is better). Use `rempTrim` to remove low-quality predictions.

```r
# Trim results (threshold 1.7 is default for high reliability)
remp.res <- rempTrim(remp.res, threshold = 1.7, missingRate = 0.2)

# Aggregate CpG-level data to RE-level data (averaging)
remp.res <- rempAggregate(remp.res, NCpG = 2)

# Add gene/region annotations (TSS, 5'UTR, Exon, etc.)
remp.res <- decodeAnnot(remp.res)
```

## Data Extraction and Visualization

### Extracting Profiled REs
If you only want to extract methylation values for RE-associated CpGs that were *actually measured* on the array (without prediction):

```r
profiled.res <- remprofile(my_data, REtype = "Alu", genome = "hg19")
```

### Accessors
`REMProduct` objects (the output of `remp`) allow easy access to data:
- `rempB(remp.res)`: Get Beta values.
- `rempM(remp.res)`: Get M-values.
- `rempQC(remp.res)`: Get reliability scores.
- `rempAnnot(remp.res)`: Get genomic annotations.
- `rempImp(remp.res)`: Get predictor importance.

### Visualization
```r
# Density plot of predicted methylation
remplot(remp.res, main = "Alu Methylation", col = "blue")
```

## Tips for Success
- **Memory Management**: For large datasets, use `ncore` to parallelize and specify a `work.dir` in `initREMP` to save/reuse annotation parcels.
- **Genome Builds**: If using hg38 with array data, REMP will automatically perform liftover of probe locations.
- **Reliability**: Always check the distribution of reliability scores in `details()`. Scores > 1.7 generally indicate less reliable predictions.

## Reference documentation
- [An Introduction to the REMP Package](./references/REMP.md)