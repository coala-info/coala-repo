---
name: bioconductor-dialignr
description: DIAlignR performs retention time alignment of targeted mass spectrometry data using MS2 chromatograms to establish peak correspondence across multiple runs. Use when user asks to perform star, MST, or progressive alignment, visualize extracted-ion chromatograms, or extract aligned peak intensities across multiple proteomics or metabolomics runs.
homepage: https://bioconductor.org/packages/3.11/bioc/html/DIAlignR.html
---

# bioconductor-dialignr

name: bioconductor-dialignr
description: Retention time alignment of targeted mass-spectrometry runs (DIA, SWATH-MS, PRM, SRM) using MS2 chromatograms. Use this skill to perform star, MST, or progressive alignment, visualize XICs, and extract aligned peak intensities across multiple proteomics or metabolomics runs.

# bioconductor-dialignr

## Overview
DIAlignR is a Bioconductor package designed for the alignment of targeted mass spectrometry data. It uses MS2 chromatograms to establish correspondence between peaks across different runs using a hybrid approach of global and local alignment. It is particularly effective for DIA (Data-Independent Acquisition) data, providing precise retention time (RT) mapping even across distant runs.

## Core Workflow

### 1. Data Preparation
DIAlignR requires two types of input files located in a specific directory structure:
- **.osw files**: FDR-scored features (typically from OpenSWATH/PyProphet).
- **.chrom.sqMass or .chrom.mzML files**: Raw extracted-ion chromatograms (XICs).

The package expects a `dataPath` containing two subdirectories: `osw/` and `xics/` (or `mzml/`).

```r
library(DIAlignR)
dataPath <- "path/to/your/data"
params <- paramsDIAlignR()
params[["context"]] <- "experiment-wide" # Recommended for multi-run studies
```

### 2. Performing Alignment
There are three primary strategies for multi-run alignment. All functions return an intensity table.

**Star Alignment**
Aligns all runs to a reference run.
```r
alignTargetedRuns(dataPath = dataPath, 
                  outFile = "results.csv", 
                  runs = NULL, # NULL aligns all runs in dataPath
                  oswMerged = TRUE, 
                  params = params)
```

**MST (Minimum Spanning Tree) Alignment**
Aligns runs based on a similarity tree.
```r
mstAlignRuns(dataPath = dataPath, 
             outFile = "results.csv", 
             oswMerged = TRUE, 
             params = params)
```

**Progressive Alignment**
Uses a guide tree (Newick format) for step-by-step alignment.
```r
progAlignRuns(dataPath = dataPath, 
              outFile = "results.csv", 
              oswMerged = TRUE, 
              params = params)
```

### 3. Visualization and Inspection
To inspect specific analytes (by ID) across runs:

**Fetch and Plot XICs**
```r
runs <- c("run_name_1", "run_name_2")
XICs <- getXICs(analytes = 4618L, runs = runs, dataPath = dataPath, oswMerged = TRUE)
plotXICgroup(XICs[[1]][["4618"]])
```

**Visualize Aligned Chromatograms**
This shows the experiment run, the reference run, and the experiment run aligned to the reference.
```r
AlignObj <- getAlignObjs(analytes = 4618L, runs = runs, dataPath = dataPath, params = params)
plotAlignedAnalytes(AlignObj, annotatePeak = TRUE)
```

**Visualize Alignment Path**
```r
AlignObjOutput <- getAlignObjs(analytes = 4618L, runs = runs, dataPath = dataPath, objType = "medium", params = params)
plotAlignmentPath(AlignObjOutput)
```

### 4. Signal Processing
You can smooth chromatograms and integrate areas manually if needed.
```r
# Smoothing
XICs.sm <- smoothXICs(XICs_matrix, type = "sgolay", samplingTime = 3.42, kernelLen = 9, polyOrd = 3)

# Integration
area <- areaIntegrator(time_list, intensity_list, left = 5203.7, right = 5268.5, 
                       integrationType = "intensity_sum", baselineType = "base_to_base")
```

## Tips for Success
- **Large-scale studies**: If `pyprophet merge` creates files too large for memory, set `oswMerged = FALSE` and provide the path to the global model via `scoreFile` in the parameters.
- **File Formats**: While `.chrom.mzML` is supported, `.chrom.sqMass` is often preferred for performance. If using mzML, ensure chromatograms are uncompressed (use OpenMS `FileConverter` if `mzR` throws errors).
- **Analyte IDs**: Ensure you use the integer ID (e.g., `4618L`) when querying specific analytes in functions like `getXICs` or `getAlignObjs`.

## Reference documentation
- [MS2 chromatograms based alignment of targeted mass-spectrometry runs](./references/DIAlignR-vignette.Rmd)
- [MS2 chromatograms based alignment of targeted mass-spectrometry runs (Markdown)](./references/DIAlignR-vignette.md)