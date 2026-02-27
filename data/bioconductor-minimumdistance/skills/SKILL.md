---
name: bioconductor-minimumdistance
description: This tool detects de novo copy number alterations in case-parent trios using genotyping array data. Use when user asks to identify offspring-specific mutations, calculate the minimum distance statistic, perform circular binary segmentation, or infer trio copy number states via Maximum A Posteriori estimation.
homepage: https://bioconductor.org/packages/release/bioc/html/MinimumDistance.html
---


# bioconductor-minimumdistance

name: bioconductor-minimumdistance
description: Detection of de novo copy number alterations (CNAs) in case-parent trios using genotyping array data (Illumina/Affymetrix). Use this skill to identify offspring-specific mutations by calculating the "minimum distance" statistic, performing circular binary segmentation (CBS), and inferring trio copy number states via Maximum A Posteriori (MAP) estimation.

# bioconductor-minimumdistance

## Overview

The `MinimumDistance` package provides a framework for identifying *de novo* copy number variants in case-parent trios. It defines a "minimum distance" statistic—the signed minimum absolute difference of the offspring and parental log2 R ratios—to isolate alterations present in the offspring but not the parents. The workflow integrates Log R Ratios (LRR) and B Allele Frequencies (BAF) to provide high-confidence calls for deletions and duplications.

## Core Workflow

### 1. Data Preparation and Annotation
The package requires marker-level annotation (genomic coordinates) and an indicator for polymorphic markers.

```r
library(MinimumDistance)
library(VanillaICE)
library(oligoClasses)

# Create SnpGRanges for marker annotation
fgr <- SnpGRanges(GRanges(paste0("chr", features$Chr), 
                  IRanges(features$Position, width=1),
                  isSnp=features[["Intensity Only"]]==0))
names(fgr) <- features[["Name"]]
fgr <- sort(fgr)
```

### 2. Organizing Raw Data (ArrayViews)
Use `ArrayViews` to manage paths to raw LRR and BAF files without loading everything into RAM.

```r
views <- ArrayViews(rowRanges=fgr, sourcePaths=files, parsedPath="ParsedFiles")

# Define parsing parameters
scan_params <- CopyNumScanParams(index_genome=match(names(fgr), dat[["SNP Name"]]),
                                 select=select_columns,
                                 cnvar="Log R Ratio",
                                 bafvar="B Allele Freq",
                                 gtvar=c("Allele1 - AB", "Allele2 - AB"))

# Parse files to disk
invisible(sapply(views, parseSourceFile, param=scan_params))
```

### 3. Defining Pedigrees and Experiments
The `MinDistExperiment` object binds the pedigree structure to the genomic data.

```r
# Define the trio
ped <- ParentOffspring(id = "trio_id", 
                       father="father_sample_id", 
                       mother="mother_sample_id", 
                       offspring="offspring_sample_id", 
                       parsedPath="ParsedFiles")

# Create the experiment container
me <- MinDistExperiment(views, pedigree=ped)
```

### 4. Segmentation and De Novo Calling
The analysis involves two main steps: segmenting the minimum distance statistic and assigning trio states.

```r
# 1. Segmentation using Circular Binary Segmentation (CBS)
params <- MinDistParam()
mdgr <- segment2(me, params)

# 2. MAP Estimation to call trio states (e.g., 221 for de novo hemizygous deletion)
md_g <- MAP2(me, mdgr, params)
```

### 5. Filtering and Visualization
Filter results based on posterior probability, number of markers, or specific trio states.

```r
# Filter for de novo hemizygous deletions
denovo_calls <- denovoHemizygous(md_g)

# Custom filtering
filter_param <- FilterParamMD(state=c("221", "223"), min.number.probes=10)
filtered_cnvs <- cnvFilter(md_g, filter_param)

# Visualization
vps <- pedigreeViewports()
p <- plotDenovo(me, filtered_cnvs)
pedigreeGrid(g=filtered_cnvs, vps=vps, figs=p)
```

## Key Trio States
The package uses a 3-digit code (Father-Mother-Offspring) to represent copy numbers:
- `222`: Normal (Diploid in all)
- `221`: *De novo* hemizygous deletion in offspring
- `223`: *De novo* duplication in offspring
- `220`: *De novo* homozygous deletion in offspring

## Tips for Success
- **Memory Management**: Use the `ArrayViews` approach for large cohorts to avoid RAM exhaustion.
- **Parameter Tuning**: Adjust `nMAD(params)` to change the sensitivity of the segmentation. Smaller values increase the number of segments called.
- **Breakpoint Editing**: `segment2` automatically edits minimum distance breakpoints if they conflict with offspring-specific segmentation boundaries, providing more precise coordinates.

## Reference documentation
- [MinimumDistance](./references/MinimumDistance.md)