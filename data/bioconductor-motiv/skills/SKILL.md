---
name: bioconductor-motiv
description: This tool identifies, validates, and visualizes transcription factor binding motifs by comparing them against known databases. Use when user asks to match discovered motifs to databases like JASPAR or TRANSFAC, filter motif results by E-value or name, and generate sequence logos or genomic distribution plots.
homepage: https://bioconductor.org/packages/3.11/bioc/html/MotIV.html
---

# bioconductor-motiv

name: bioconductor-motiv
description: Motif Identification and Validation (MotIV) for R. Use this skill to identify, validate, and visualize transcription factor binding motifs. It is particularly useful for matching discovered motifs (e.g., from rGADEM) against known databases like JASPAR or TRANSFAC, filtering results by E-value or TF name, and generating sequence logos or genomic distribution plots.

## Overview

MotIV is a Bioconductor package designed for the post-processing of motif discovery results. It provides tools to compare Position Weight Matrices (PWMs) against motif databases using the STAMP algorithm, visualize alignments, and integrate motif data with genomic ranges. It is highly compatible with `rGADEM` objects but also supports standalone PWM files in TRANSFAC or GADEM formats.

## Core Workflow

### 1. Setup and Data Loading
Load the package and the required motif databases. MotIV includes JASPAR 2010 by default.

```R
library(MotIV)

# Load a database (TRANSFAC format)
path <- system.file(package="MotIV")
jaspar <- readPWMfile(paste0(path, "/extdata/jaspar2010.txt"))

# Load or generate database scores (required for E-value calculation)
# Scores are specific to the metric (e.g., PCC) and alignment (e.g., SWU)
jaspar.scores <- readDBScores(paste0(path, "/extdata/jaspar2010_PCC_SWU.scores"))
```

### 2. Motif Matching
Compare input motifs against the database. Input can be a `gadem` object, a list of PWMs, or a file.

```R
# From a gadem object
# motifs <- getPWM(gadem_obj)

# From a file
input.motifs <- readPWMfile("my_motifs.txt")

# Perform analysis
# cc: metric (PCC, ALLR, etc.), align: alignment type (SWU, SWG, Ungapped)
results <- motifMatch(inputPWM=input.motifs, 
                      database=jaspar, 
                      DBscores=jaspar.scores, 
                      cc="PCC", 
                      align="SWU", 
                      top=5)
```

### 3. Filtering and Manipulation
Refine results using specific criteria.

```R
# Define filters
f1 <- setFilter(tfname="FOXA", evalueMax=10^-5)
f2 <- setFilter(tfname="AP1")

# Combine filters with OR (|) or AND (&)
my_filter <- f1 | f2

# Apply filter to results
filtered_results <- filter(results, my_filter, exact=FALSE)

# Split results into a list based on filters
split_list <- split(results, c(f1, f2))
```

### 4. Visualization
MotIV provides several plotting methods to validate matches.

```R
# Summary of matches
summary(filtered_results)

# Sequence logos of matches
plot(filtered_results, ncol=2, top=5)

# View text-based alignments
viewAlignments(filtered_results)[[1]]

# Distribution of motifs relative to peak centers (requires gadem object)
plot(filtered_results, gadem_obj, type="distribution")

# Distance between two motifs (requires gadem object)
plot(filtered_results, gadem_obj, type="distance")
```

### 5. Exporting Results
Save analysis for downstream use or external tools.

```R
# Export as Transfac files (PWMs and alignments)
exportAsTransfacFile(filtered_results, file="my_analysis")

# Export as GenomicRanges (requires gadem object)
gr <- exportAsGRanges(filtered_results, gadem_obj)

# Convert to data frame for custom analysis
df <- as.data.frame(results)
```

## Tips and Best Practices
- **Trimming**: Use `lapply(motifs, trimPWMedge, threshold=1)` on input PWMs to remove low-information edges before matching; this often improves alignment quality.
- **E-values**: Always ensure the `DBscores` used match the `cc` and `align` parameters passed to `motifMatch`.
- **GSL Dependency**: MotIV requires the GNU Scientific Library (GSL). Ensure it is installed on the system path.
- **Object Access**: Use `results["TF_NAME"]` to select specific motifs from a `motiv` object.

## Reference documentation
- [Motif Identification and Validation](./references/MotIV.md)