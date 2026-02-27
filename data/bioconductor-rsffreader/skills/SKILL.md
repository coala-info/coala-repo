---
name: bioconductor-rsffreader
description: This tool loads and manipulates SFF files from Roche 454 and Ion Torrent sequencing platforms. Use when user asks to read .sff files, extract sequence data and quality scores, or apply different clipping modes to flowgram data.
homepage: https://bioconductor.org/packages/3.8/bioc/html/rSFFreader.html
---


# bioconductor-rsffreader

name: bioconductor-rsffreader
description: Loading and manipulating SFF (Standard Flowgram Format) files from Roche 454 and Ion Torrent sequencing platforms. Use this skill when you need to read .sff files, extract sequence data (DNAStringSet), quality scores (BStringSet/FastqQuality), or flowgram information, and when you need to apply different clipping modes (adapter, quality, full, raw) to the sequence data.

## Overview

The `rSFFreader` package provides an interface for SFF files, maintaining compatibility with the `ShortRead` package. It allows for the direct processing of next-generation sequencing data that uses flow-based chemistry, enabling users to access headers, sequences, and quality metrics while providing flexible control over sequence clipping.

## Core Workflow

### Loading Data
Read an SFF file into an `SFFContainer` object:
```R
library(rSFFreader)
sff <- readSff("path/to/file.sff")
```

### Accessing Data Components
Extract standard components from the `SFFContainer`:
*   **Sequences**: `sread(sff)` returns a `DNAStringSet`.
*   **Quality Scores**: `quality(sff)` returns a `FastqQuality` object.
*   **Header Metadata**: `header(sff)` returns a list containing file-level information (e.g., flow chars, key sequence, number of reads).
*   **Read Names**: `id(sff)` or `names(sread(sff))` retrieves read identifiers.
*   **Read Lengths**: `width(sff)` returns the lengths based on the current clipping mode.

### Managing Clipping Modes
Clipping determines which part of the read is visible/processed.
*   **Check available modes**: `availableClipModes(sff)`
*   **Check current mode**: `clipMode(sff)`
*   **Set mode**: `clipMode(sff) <- "quality"`

**Supported Modes:**
*   `raw`: No clipping; returns the full sequence.
*   `adapter`: Removes adapter sequences defined in the SFF file.
*   `quality`: Removes low-quality regions defined in the SFF file.
*   `full`: Most conservative; uses the interior of both quality and adapter clips.
*   `custom`: Uses user-defined `IRanges`.

### Custom Clipping
To set specific coordinates for clipping (e.g., to inspect barcodes/MIDs in the first 15 bases):
```R
customClip(sff) <- IRanges(start = 1, end = 15)
clipMode(sff) <- "custom"
# Now sread(sff) returns only the first 15 bases
```

## Quality Assessment and Visualization

### Read Length Distribution
Compare raw vs. clipped lengths using histograms:
```R
par(mfrow=c(1,2))
clipMode(sff) <- "raw"
hist(width(sff), main="Raw")
clipMode(sff) <- "full"
hist(width(sff), main="Clipped")
```

### Base Composition by Cycle
Analyze nucleotide frequency across positions:
```R
clipMode(sff) <- "full"
# Calculate frequencies
ac <- alphabetByCycle(sread(sff), alphabet=c("A","C","T","G","N"))
acf <- sweep(ac, MARGIN=2, FUN="/", STATS=apply(ac, 2, sum))

# Plot
matplot(t(acf), type="l", lty=1, xlab="Base Position", ylab="Frequency")
```

## Reference documentation

- [An introduction to rSFFreader](./references/rSFFreader.md)