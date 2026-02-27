---
name: bioconductor-swimr
description: bioconductor-swimr analyzes and visualizes C. elegans swimming behavior to quantify swimming-induced paralysis and kinetic locomotion data. Use when user asks to process Tracker program files, create frequency matrices using multiple counting methods, or quantify paralysis latency and reversion events in nematodes.
homepage: https://bioconductor.org/packages/3.6/bioc/html/SwimR.html
---


# bioconductor-swimr

name: bioconductor-swimr
description: Analysis and visualization of C. elegans swimming behavior (Swip). Use this skill to process Tracker program files, create frequency matrices using multiple counting methods (FFT, Extrema, PeakDet), and quantify kinetic elements of paralysis and reversion in nematode locomotion.

## Overview

SwimR is a specialized tool for quantifying *Caenorhabditis elegans* swimming behavior, particularly Swimming-Induced Paralysis (Swip). It provides a pipeline to convert raw video tracking data into frequency matrices and then performs downstream analysis to identify paralysis latency, reversion events, and kinetic alterations across different genotypes or drug treatments.

## Typical Workflow

### 1. Creating the Frequency Matrix
The first step converts raw files from the "Tracker" program into a standardized frequency matrix.

```R
library(SwimR)

# Define paths
inputPath <- "path/to/tracker_files"
outputPath <- getwd()

# Create matrix using the 'Extrema' method (default)
# Note: Genotype info is extracted from filenames (e.g., "Genotype-Drug-Date-ID.txt")
freMat <- createFrequencyMatrix(inputPath, 
                                outputPath, 
                                method = "Extrema", 
                                Threshold = 0.6,
                                fps = 15, 
                                minTime = 0, 
                                maxTime = 600)
```

**Counting Methods:**
- `FFT`: Fast Fourier Transform.
- `Extrema`: Local maxima/minima (default).
- `PeakDet`: Peak delta algorithm.
- `RT+GP`: Get Peaks plus Racetrack Filter.

### 2. Analyzing Swimming Data (SwimR Function)
Once the frequency matrix and annotation files are generated, use the `SwimR` function to quantify paralysis.

```R
# Load generated files
expfile <- "frequencyMatrix.txt"
annfile <- "annotationfile.txt"

# Run analysis
result <- SwimR(expfile, 
                annfile, 
                projectname = "MyStudy", 
                outputPath = getwd(),
                data.collection.interval = 0.067, 
                window.size = 150,
                paralysis.interval = 20,
                rev.degree = 0.5)
```

## Key Parameters for Analysis

- `mads`: Median Absolute Deviations for outlier detection (default 4.4478).
- `paralysis.degree`: The threshold (fraction of range) to define paralysis (default 0.2).
- `paralysis.interval`: Minimum time (seconds) below the degree threshold to be called paralyzed.
- `rev.degree`: Threshold to be called a "revertant" (default 0.5, meaning animal regained 50% of frequency range).

## Interpreting Results

The package generates several key files in the `outputPath`:
- **P_group_data.txt**: Summary statistics per genotype (mean max frequency, paralysis counts, latency to paralyze `t_half`, reversion counts).
- **P_heatmap_...jpg**: Visual representation of swimming frequency over time, ordered by paralysis latency.
- **P_individual_data.txt**: Detailed kinetics for every single animal.
- **P_intermediate.results.txt**: Quick look at which animals were excluded as outliers and which were classified as paralyzed/revertants.

## Tips for Success

- **Filenames Matter**: Ensure tracker files follow the naming convention `Genotype-Drug-Dose-Date-#.txt` as the `createFrequencyMatrix` function parses these strings to create the `annotationfile.txt`.
- **Quality Control**: Check `XFigSub.jpg` outputs. If the scatter plots show erratic frequencies, it often indicates the Tracker program lost the worm due to poor contrast.
- **Smoothing**: The `window.size` parameter in the `SwimR` function significantly affects the heatmap and paralysis detection. Increase it for noisier data.

## Reference documentation
- [Manual of SwimR](./references/SwimR.md)