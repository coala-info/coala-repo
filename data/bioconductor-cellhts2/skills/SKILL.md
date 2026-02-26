---
name: bioconductor-cellhts2
description: This tool provides an end-to-end pipeline for analyzing high-throughput screening data from microtiter plates. Use when user asks to import raw intensity data, configure plate layouts, perform normalization, score replicates, or generate HTML quality reports for RNAi and small molecule screens.
homepage: https://bioconductor.org/packages/3.5/bioc/html/cellHTS2.html
---


# bioconductor-cellhts2

name: bioconductor-cellhts2
description: Expert guidance for the cellHTS2 Bioconductor package to analyze high-throughput screening (HTS) data, specifically RNAi and small molecule screens. Use this skill when you need to: (1) Import raw intensity data from microtiter plates, (2) Configure screen metadata and plate layouts, (3) Perform normalization (POC, NPI, Z-score, B-score), (4) Score and summarize replicates, and (5) Generate comprehensive HTML quality reports.

# bioconductor-cellhts2

## Overview

The `cellHTS2` package provides an end-to-end pipeline for analyzing cell-based high-throughput screens. It is designed to handle multi-plate formats, multiple replicates, and multiple channels. The workflow typically moves from raw intensity readings to a scored and annotated hit list, with automated HTML reporting for quality control at each step.

## Core Workflow

### 1. Data Import
The primary data structure is the `cellHTS` object. Data is usually imported using a "plate list" file (tab-delimited) containing `Filename`, `Plate`, and `Replicate` columns.

```r
library(cellHTS2)
experimentName <- "MyScreen"
dataPath <- "path/to/data"
x <- readPlateList("Platelist.txt", name=experimentName, path=dataPath)
```

For specific formats like EnVision or HTAnalyst, use the `importFun` argument or `readHTAnalystData`.

### 2. Screen Configuration
You must annotate the plate layout (controls vs. samples) and flag invalid measurements.
- **Description file**: General MIAME-compliant metadata.
- **Plate configuration file**: Defines well contents (sample, pos, neg, other, empty).
- **Screen log file**: (Optional) Flags specific wells/plates to be excluded.

```r
x <- configure(x, 
               descripFile="Description.txt", 
               confFile="Plateconf.txt", 
               logFile="Screenlog.txt", 
               path=dataPath)
```

### 3. Normalization
Normalization removes systematic plate or edge effects.
- `method="median"`: Plate median scaling (common).
- `method="Bscore"`: Corrects for row/column biases using median polish.
- `method="POC"`: Percent of control.
- `method="NPI"`: Normalized percent inhibition.

```r
xn <- normalizePlates(x, 
                      scale="multiplicative", 
                      log=FALSE, 
                      method="median", 
                      varianceAdjust="none")
```

### 4. Scoring and Summarization
Standardize replicates (usually via Z-scores) and then collapse replicates into a single score per reagent.

```r
# Calculate robust Z-scores
xsc <- scoreReplicates(xn, sign="-", method="zscore")

# Summarize replicates (mean, median, max, or rms)
xsc <- summarizeReplicates(xsc, summary="mean")
```

### 5. Annotation and Reporting
Link reagents to Gene IDs and generate the final report.

```r
# Annotate with Gene IDs
xsc <- annotate(xsc, geneIDFile="GeneIDs.txt", path=dataPath)

# Generate HTML report
writeReport(raw=x, normalized=xn, scored=xsc, outdir="Report")
```

## Key Functions and Tips

- **`state(x)`**: Check the processing status (configured, normalized, scored, annotated).
- **`Data(x)`**: Access the underlying intensity/score matrices.
- **`wellAnno(x)`**: Access well annotations.
- **`getZfactor(x)`**: Calculate the Z'-factor to evaluate assay quality.
- **`imageScreen(x)`**: Create a heatmap of the entire screen.
- **`writeTab(x)`**: Export the results to a tab-delimited text file.
- **Multi-channel screens**: For dual-channel assays (e.g., firefly and renilla luciferase), normalization is typically performed on the ratio of the two channels.

## Reference documentation

- [End-to-end analysis of cell-based screens (Short version)](./references/cellhts2.md)
- [End-to-end analysis of cell-based screens (Complete version)](./references/cellhts2Complete.md)
- [Analysis of multi-channel cell-based screens](./references/twoChannels.md)
- [Analysis of screens with enhancer and suppressor controls](./references/twoWay.md)