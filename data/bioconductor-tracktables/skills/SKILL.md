---
name: bioconductor-tracktables
description: This tool creates IGV session files and interactive HTML reports from R data frames to organize genomic data with metadata. Use when user asks to create IGV sessions, generate HTML track reports, or organize high-throughput sequencing files for visualization.
homepage: https://bioconductor.org/packages/release/bioc/html/tracktables.html
---


# bioconductor-tracktables

name: bioconductor-tracktables
description: Create IGV (Integrative Genomics Viewer) session files and HTML reports from R data frames. Use when you need to organize high-throughput sequencing data (BAM, BigWig, BED) with metadata for visualization, grouping, and filtering in IGV.

# bioconductor-tracktables

## Overview

The `tracktables` package automates the creation of IGV session XML files and interactive HTML reports. It allows users to map sample metadata (e.g., cell type, antibody, condition) to genomic data files (BAM, BigWig, and BED/Interval files). This enables rapid interrogation of large datasets by providing a structured interface to group, sort, and filter tracks within the IGV browser.

## Core Workflow

### 1. Prepare Input Data Frames

The package requires two specific data frames that share a common `SampleName` column.

**The SampleSheet (Metadata):**
Contains unique sample IDs and any associated experimental metadata.
```r
# Example SampleSheet
SampleSheet <- data.frame(
  SampleName = c("EBF", "H3K4me3"),
  Antibody = c("EBF", "H3K4me3"),
  Species = c("ProB", "ProB"),
  stringsAsFactors = FALSE
)
```

**The FileSheet (File Paths):**
Must contain the columns `SampleName`, `bam`, `bigwig`, and `interval`. Use `NA` for missing file types.
```r
# Example FileSheet
FileSheet <- data.frame(
  SampleName = c("EBF", "H3K4me3"),
  bigwig = c("path/to/EBF.bw", "path/to/H3K4me3.bw"),
  interval = c("path/to/EBF_peaks.bed", NA),
  bam = c(NA, NA),
  stringsAsFactors = FALSE
)
```

### 2. Create an IGV Session

Use `MakeIGVSession()` to generate the XML file that IGV loads to display tracks.

```r
library(tracktables)
MakeIGVSession(
  SampleSheet = SampleSheet,
  FileSheet = FileSheet,
  igvdirectory = getwd(),
  sessionname = "MyExperiment",
  genome = "mm9" # or "hg19", "hg38", etc.
)
```
This produces `MyExperiment.xml` and `SampleMetadata.txt` in the specified directory.

### 3. Create an HTML Report

Use `maketracktable()` to create a portable HTML dashboard. This report allows you to click links to automatically focus IGV on specific samples or genomic intervals.

```r
# Basic report
html_report <- maketracktable(
  fileSheet = FileSheet,
  SampleSheet = SampleSheet,
  filename = "Report.html",
  basedirectory = getwd(),
  genome = "mm9"
)
```

### 4. Advanced Configuration (igvParam)

You can control how tracks appear in IGV (e.g., scaling, colors) using the `igvParam` class.

```r
# Define display parameters
igvDisplayParams <- igvParam(
  bigwig.autoScale = "false",
  bigwig.minimum = 0,
  bigwig.maximum = 10
)

# Create report with specific coloring and parameters
maketracktable(
  FileSheet, 
  SampleSheet, 
  "Report_Custom.html", 
  getwd(), 
  "mm9",
  colourBy = "Antibody", # Color tracks based on metadata column
  igvParam = igvDisplayParams
)
```

## Key Tips

- **Relative Paths:** It is highly recommended to create the report in a directory alongside the data files. `tracktables` uses relative paths to ensure the report remains portable and functional when moved to different systems or shared with collaborators.
- **Sample Matching:** Only samples present in both the `SampleSheet` and `FileSheet` will be included in the final output.
- **Interval Reports:** If a sample has an entry in the `interval` column, the HTML report will automatically generate a sub-report containing a searchable table of those genomic regions.

## Reference documentation

- [tracktables](./references/tracktables.md)