---
name: bioconductor-igvr
description: This tool provides programmatic control of the igv.js genome browser from an R session via a websocket connection. Use when user asks to initialize the igvR browser, set stock or custom genomes, navigate genomic regions, or display track types such as alignments, quantitative data, GWAS results, and genomic interactions.
homepage: https://bioconductor.org/packages/release/bioc/html/igvR.html
---


# bioconductor-igvr

name: bioconductor-igvr
description: Programmatic control of the igv.js genome browser from R. Use this skill to initialize the igvR browser, set genomes (stock or custom), navigate genomic regions, and display various track types including alignments (BAM), quantitative data (bedGraph/BigWig), annotations (BED/GRanges), GWAS results, and paired-end interactions (Hi-C).

# bioconductor-igvr

## Overview

The `igvR` package provides an R interface to `igv.js`, allowing for interactive, web-based genomic visualization directly from an R session. It uses a websocket connection to send commands and data from R to a browser window. This is particularly useful for visual QC of ChIP-seq, RNA-seq, GWAS, and clinical variant data.

## Core Workflow

1.  **Initialize**: Create an `igvR` instance to open the browser connection.
2.  **Set Genome**: Specify a supported stock genome (e.g., "hg38", "mm10") or a custom genome configuration.
3.  **Navigate**: Move to specific genes or coordinates.
4.  **Create Tracks**: Wrap R data objects (data.frames, GRanges, GAlignments) into specific Track objects.
5.  **Display**: Send the tracks to the browser.

## Essential Functions

### Initialization and Navigation
```R
library(igvR)
igv <- igvR() # Opens browser tab
setBrowserWindowTitle(igv, "My Project")
setGenome(igv, "hg38")

# Navigation
showGenomicRegion(igv, "MYC")
showGenomicRegion(igv, "chr8:127,735,434-127,742,951")
zoomOut(igv)
zoomIn(igv)

# Get current view coordinates from browser
loc <- getGenomicRegion(igv)
```

### Track Creation and Display
All tracks are displayed using `displayTrack(igv, track)`.

| Track Type | Constructor | Input Data |
| :--- | :--- | :--- |
| **Annotation** | `DataFrameAnnotationTrack()` | data.frame (chrom, start, end, name) |
| **Quantitative** | `DataFrameQuantitativeTrack()` | data.frame (chrom, start, end, score) |
| **GRanges** | `GRangesQuantitativeTrack()` | GRanges object with one numeric mcol |
| **Alignments** | `GenomicAlignmentTrack()` | GAlignments object (from `readGAlignments`) |
| **GWAS** | `GWASTrack()` | data.frame with chrom, pos, and p-value columns |
| **Interactions** | `BedpeInteractionsTrack()` | data.frame (chrom1, start1, end1, chrom2, start2, end2) |

## Common Patterns

### Displaying a Quantitative BedGraph
```R
tbl.bedGraph <- data.frame(chrom="chr8", start=starts, end=ends, value=values)
track <- DataFrameQuantitativeTrack("My Track", tbl.bedGraph, color="red", autoscale=TRUE)
displayTrack(igv, track)
```

### Loading Local BAM Slices
To avoid sending massive files, read only the region currently visible in the browser:
```R
roi <- getGenomicRegion(igv)
gr.roi <- with(roi, GRanges(chrom, IRanges(start, end)))
param <- ScanBamParam(which=gr.roi, what=scanBamWhat())
alignments <- readGAlignments("path/to/file.bam", use.names=TRUE, param=param)
track <- GenomicAlignmentTrack("BAM Track", alignments)
displayTrack(igv, track)
```

### Custom Genomes
If a genome is not in `getSupportedGenomes(igv)`, use `setCustomGenome()`:
```R
setCustomGenome(igv,
                id="Sars_cov_2",
                genomeName="SARS-CoV-2",
                fastaURL=fasta_url,
                fastaIndexURL=fai_url,
                geneAnnotationURL=gff3_url)
```

## Reference documentation

- [Introduction: a simple demo](./references/v00.basicIntro.md)
- [Use a Stock Genome](./references/v01.stockGenome.md)
- [Use a Custom Genome](./references/v02.customGenome.md)
- [Explore CTCF ChIP-seq alignments, MACS2 narrowPeaks, Motif Matching and H3K4me3 methylation](./references/v03.ctcfChIP.md)
- [Paired-end Interaction Tracks](./references/v04.pairedEnd.md)
- [Obtain and Display H3K4Me3 K562 track from UCSC table browser](./references/v05.ucscTableBrowser.md)
- [Obtain and Display H3K27ac K562 track from the AnnotationHub](./references/v06.annotationHub.md)
- [GWAS Tracks](./references/v07.gwas.md)