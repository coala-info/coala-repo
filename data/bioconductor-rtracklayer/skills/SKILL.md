---
name: bioconductor-rtracklayer
description: This tool provides an interface for importing and exporting genomic tracks and programmatically interacting with the UCSC Genome Browser. Use when user asks to import or export BED, GFF, or BigWig files, manage UCSC browser sessions, or query the UCSC Table Browser.
homepage: https://bioconductor.org/packages/release/bioc/html/rtracklayer.html
---

# bioconductor-rtracklayer

name: bioconductor-rtracklayer
description: Interface for R and genome browsers, specializing in the import/export of genomic tracks (BED, GFF, WIG, BigWig) and programmatic interaction with the UCSC Genome Browser. Use this skill when you need to load genomic annotation files into R as GRanges objects, export GRanges to standard bioinformatics formats, or query/control UCSC browser sessions.

## Overview

The `rtracklayer` package serves as a bridge between Bioconductor and genome browsers. It provides a unified interface for importing and exporting common genomic data formats and allows for the programmatic manipulation of UCSC Genome Browser sessions, including track uploads and view configuration.

## Core Workflows

### 1. Importing and Exporting Tracks
The package uses `import()` and `export()` as generic functions that automatically detect file formats based on extensions.

```R
library(rtracklayer)

# Import a BED, GFF, or WIG file into a GRanges object
gr <- import("data.bed")
gff_data <- import("annotations.gff3")

# Export a GRanges object to a specific format
export(gr, "output.bed")
export(gr, "output.wig", format = "wig")
```

### 2. Interacting with UCSC Genome Browser
You can manage a remote browser session directly from R.

```R
# Start a session
session <- browserSession("UCSC")

# Set the genome build
genome(session) <- "hg19"

# Upload a track to the session
track(session, "my_track_name") <- gr

# Open the browser to a specific region
view <- browserView(session, range(gr[1]) * -10) # Zoomed out 10x

# List available tracks in the session
trackNames(session)
```

### 3. Querying the UCSC Table Browser
Retrieve specific genomic annotations without downloading entire files.

```R
# Create a query for a specific track and table
query <- ucscTableQuery(session, track = "rmsk", table = "rmsk")

# Define a genomic range for the query
range(query) <- GRanges("chr6", IRanges(20400587, 20403336))

# Download the data as a data.frame or GRanges
tbl_data <- getTable(query)
gr_data <- track(query)
```

### 4. Creating UCSC-Compatible GRanges
Use specialized constructors to ensure chromosome names and lengths match UCSC standards.

```R
# Validates intervals against the hg18 genome bounds
targetTrack <- GRangesForUCSCGenome("hg18", chrom = "chr4", 
                                    ranges = IRanges(start, end), 
                                    strand = "+")
```

## Tips and Best Practices
- **Format Support**: Supports BED, GFF(1,2,3), WIG, BigWig, and 2bit.
- **Score Column**: The `score()` function is a shortcut to access the primary numeric metadata column in a track.
- **WIG Limitations**: WIG format does not support strand information. `rtracklayer` will automatically split stranded data into "plus" and "minus" tracks during upload.
- **Performance**: For very large queries (e.g., whole-genome RepeatMasker), it is more efficient to download files via FTP rather than using `getTable`.
- **Coordinate Systems**: `rtracklayer` follows R's 1-based indexing convention. It handles the conversion to 0-based indexing required by formats like BED automatically during export.

## Reference documentation

- [The rtracklayer package](./references/rtracklayer.md)