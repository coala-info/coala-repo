---
name: bioconductor-peakpanther
description: This tool performs targeted peak picking and annotation for high-resolution mass spectrometry data using pre-defined regions of interest. Use when user asks to detect and integrate metabolites, perform parallel multi-file batch annotation, or refine peak integration parameters in LC/MS datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/peakPantheR.html
---

# bioconductor-peakpanther

name: bioconductor-peakpanther
description: Expert guidance for using the peakPantheR R package for Peak Picking and ANnoTation of High resolution Experiments. Use this skill when performing metabolomics data processing, specifically for detecting, integrating, and reporting pre-defined features (compounds, fragments, adducts) in MS files (NetCDF, mzML, mzXML, mzData). It supports both real-time single-file processing and parallel multi-file batch annotation.

# bioconductor-peakpanther

## Overview
`peakPantheR` is a Bioconductor package designed for targeted peak integration in LC/MS datasets. Unlike untargeted methods, it uses pre-defined Regions of Interest (ROI) defined by m/z and retention time (RT) windows to extract and fit peak shapes (skewed Gaussian or EMG). It is particularly powerful for large-scale studies where consistency across hundreds of files is required.

## Core Workflow: Parallel Annotation
The standard workflow for processing a large dataset involves an initial pass on representative samples to refine parameters, followed by a full pass on all samples.

### 1. Define Input Data
You need a table of targeted features and a vector of file paths.
```r
library(peakPantheR)

# Define features (ROI)
target_feats <- data.frame(
  cpdID = c("ID1", "ID2"),
  cpdName = c("Compound A", "Compound B"),
  rtMin = c(3310, 3280),
  rt = c(3344, 3385),
  rtMax = c(3390, 3440),
  mzMin = c(522.19, 496.19),
  mz = c(522.2, 496.2),
  mzMax = c(522.21, 496.21),
  stringsAsFactors = FALSE
)

# Define file paths
files <- c("sample1.mzML", "sample2.mzML")
```

### 2. Initialize and Run First Pass
Initialize a `peakPantheRAnnotation` object and run the parallel annotation.
```r
# Initialize object
annotation <- peakPantheRAnnotation(spectraPaths = files, targetFeatTable = target_feats)

# Run annotation (ncores > 0 for parallel)
results <- peakPantheR_parallelAnnotation(annotation, ncores = 4, curveModel = "skewedGaussian")
annot_obj <- results$annotation
```

### 3. Refine Parameters (uROI and FIR)
Use the results from the first pass to update Regions of Interest (uROI) and Fallback Integration Regions (FIR) for better consistency.
```r
# Automatically determine uROI and FIR based on found peaks
annot_obj <- annotationParamsDiagnostic(annot_obj)

# Optional: Apply Retention Time Correction if drift is present
# annot_obj <- retentionTimeCorrection(annot_obj, method = "polynomial")$annotation
```

### 4. Final Annotation and Export
Reset the object with all study samples and the refined parameters, then run the final integration.
```r
# Add all samples and enable uROI/FIR
final_obj <- resetAnnotation(annot_obj, spectraPaths = all_files, useUROI = TRUE, useFIR = TRUE)
final_results <- peakPantheR_parallelAnnotation(final_obj, ncores = 4)

# Export results to CSV
outputAnnotationResult(final_results$annotation, saveFolder = "results_dir", annotationName = "MyProject")
```

## Real-Time Single File Search
For processing a single file (e.g., immediately after acquisition), use the simplified search function:
```r
rt_results <- peakPantheR_singleFileSearch(
  singleSpectraDataPath = "new_file.mzML",
  targetFeatTable = target_feats,
  peakStatistic = TRUE
)
# Access results
peak_table <- rt_results$peakTable
```

## Key Functions and Tips
- `peakPantheR_start_GUI(browser = TRUE)`: Launches the Shiny interface for visual ROI refinement and diagnostic exploration.
- `annotationTable(obj, column = "peakArea")`: Conveniently extracts a specific metric (area, rt, mz, etc.) into a sample-by-compound matrix.
- `curveModel`: Choose between `"skewedGaussian"` (default) and `"emgGaussian"`.
- **NetCDF Files**: Note that polarity and acquisition time often cannot be extracted from NetCDF; use mzML for full metadata support.

## Reference documentation
- [Getting Started with peakPantheR](./references/getting-started.md)
- [Parallel Annotation](./references/parallel-annotation.md)
- [peakPantheR Graphical User Interface](./references/peakPantheR-GUI.md)
- [Real Time Annotation](./references/real-time-annotation.md)