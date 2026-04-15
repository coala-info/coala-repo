---
name: bioconductor-ioniser
description: IONiseR provides a framework for the quality control and visualization of Oxford Nanopore MinION sequencing data. Use when user asks to perform quality control on Fast5 files, visualize flow cell spatial biases, monitor read production rates, or extract FASTQ sequences from MinION data.
homepage: https://bioconductor.org/packages/release/bioc/html/IONiseR.html
---

# bioconductor-ioniser

## Overview

IONiseR provides a framework for the quality control and visualization of data produced by Oxford Nanopore's MinION sequencer. It handles the complex structure of Fast5 files, allowing users to analyze metrics across different processing stages (raw events, basecalled strands, and 2D consensus reads). The package is particularly useful for identifying spatial biases on the flow cell, monitoring data production rates over time, and assessing read quality.

## Core Workflow

### 1. Loading Data
The primary entry point is `readFast5Summary()`, which aggregates metadata and metrics from a collection of Fast5 files into a `Fast5Summary` object.

```r
library(IONiseR)

# Identify Fast5 files
fast5files <- list.files(path = "/path/to/data/", pattern = ".fast5$", full.names = TRUE)

# Create summary object
example.summary <- readFast5Summary(fast5files)

# For testing, example data is available in minionSummaryData
# library(minionSummaryData)
# data(s.typhi.rep1)
```

### 2. Data Extraction
The `Fast5Summary` object organizes data into four categories, accessible via specific methods:
- `readInfo()`: File metadata (channel, mux, pass/fail status).
- `eventData()`: Signal metrics (mean signal, start time, duration, event count).
- `baseCalled()`: Strand-specific info (template vs. complement, 2D status).
- `fastq()`: Sequence data and quality scores.

### 3. Quality Control Visualization
IONiseR provides several plotting functions to diagnose run performance:

**Production Metrics:**
- `plotReadAccumulation(obj)`: Cumulative reads over run time.
- `plotActiveChannels(obj)`: Number of active pores per minute.
- `plotEventRate(obj)` / `plotBaseProductionRate(obj)`: Speed of translocation/basecalling over time.

**Read Composition:**
- `plotReadCategoryCounts(obj)`: Bar chart of template, complement, and 2D read counts.
- `plotReadCategoryQuals(obj)`: Distribution of mean quality scores across read types.

**Spatial Analysis:**
- `layoutPlot(obj, attribute = "nreads")`: Heatmap of the flow cell layout. Attributes include "nreads", "kb", or "signal".
- `channelHeatmap(df, zValue = 'col_name')`: Custom heatmap for user-defined metrics (requires a data frame with a 'channel' column).

**Temporal Analysis:**
- `channelActivityPlot(obj)`: Visualizes individual read durations across all channels over time.
- `plotKmerFrequencyCorrelation(obj)`: Checks if kmer content (pentamers) shifts during the run.

### 4. Extracting FASTQ Sequences
You can extract sequences directly from a summary object or from raw files.

**From Fast5Summary object:**
```r
library(ShortRead)
# Extract all
writeFastq(fastq(obj), file = "output.fastq")

# Extract specific strands
writeFastq(fastqTemplate(obj), file = "template.fastq")
writeFastq(fastq2D(obj), file = "2D.fastq")
```

**Directly from files (Fastest):**
```r
fast5toFastq(files = fast5files, fileName = "my_run", outputDir = getwd(), strand = 'all')
```

## Tips and Best Practices
- **Memory Management:** Reading thousands of Fast5 files can be memory-intensive. `readFast5Summary` extracts metadata rather than full raw signal to keep the object size manageable.
- **2D Reads:** Remember that 2D reads require both template and complement strands. If `plotReadCategoryCounts` shows a large gap between template and 2D, it may indicate issues with the physical chemistry or the basecaller's ability to link strands.
- **Channel Layout:** Use `layoutPlot` to identify "dead" areas of the flow cell or bubbles that might have affected specific pore clusters.

## Reference documentation
- [IONiseR](./references/IONiseR.md)