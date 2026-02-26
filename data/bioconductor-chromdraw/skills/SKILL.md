---
name: bioconductor-chromdraw
description: This tool visualizes karyotypes in linear and circular formats using genomic data from text files, BED files, or GenomicRanges objects. Use when user asks to visualize chromosome structures, compare multiple karyotypes, or generate karyotype plots from BED files and R data structures.
homepage: https://bioconductor.org/packages/release/bioc/html/chromDraw.html
---


# bioconductor-chromdraw

## Overview

The `chromDraw` package is designed for visualizing karyotypes in two primary formats: linear and circular. Linear visualizations are typically used to demonstrate chromosome structures within a single karyotype, while circular visualizations are optimized for comparing multiple karyotypes. The package supports input from specific text formats, BED files, and R-native `GenomicRanges` objects.

## Core Workflows

### 1. Using GenomicRanges (Recommended for R users)
The `chromDrawGR` function allows for direct visualization using R data structures.

```r
library(chromDraw)
library(GenomicRanges)

# Define chromosome blocks and centromeres
gr <- GRanges(
  seqnames = Rle(c("Chr1"), c(4)),
  ranges = IRanges(
    start = c(0, 500, 0, 1000), 
    end = c(500, 1000, 0, 1500),
    names = c("BlockA", "BlockB", "CENTROMERE", "BlockC")
  ),
  color = c("red", "blue", "", "green")
)

# Define colors (optional)
colors_df <- data.frame(
  name = c("red", "blue", "green"),
  r = c(255, 0, 0),
  g = c(0, 0, 255),
  b = c(0, 255, 0)
)

# Visualize (0 indicates success)
chromDrawGR(list(gr), colors_df)
```

### 2. Using External Files (Text or BED)
The `chromDraw` function uses a C++ style argument vector (`argv`) to process external files.

**Parameters for `argv`:**
- `-d`: Path to input data (CHROMDRAW or BED format).
- `-c`: Path to color definition file.
- `-o`: Output directory path.
- `-f`: Format type ("bed" or "chromdraw").
- `-s`: Use the same scale for linear outputs.

```r
library(chromDraw)

# Setup paths
input_file <- system.file('extdata', 'Ack_and_Stenopetalum_nutans.txt', package ='chromDraw')
color_file <- system.file('extdata', 'default_colors.txt', package ='chromDraw')
out_dir <- getwd()

# Execute using the C++ style interface
chromDraw(argc = 7, argv = c("chromDraw", "-c", color_file, "-d", input_file, "-o", out_dir))
```

### 3. Visualizing BED Files
To visualize BED files, ensure the first nine fields are present and set the format parameter to "bed".

```r
bed_file <- system.file('extdata', 'bed.bed', package ='chromDraw')
chromDraw(argc = 7, argv = c("chromDraw", "-f", "bed", "-d", bed_file, "-o", getwd()))
```

## Data Format Requirements

### CHROMDRAW Text Format
- **Karyotype**: Defined between `KARYOTYPE [Name] [Alias] BEGIN` and `KARYOTYPE END`.
- **Chromosomes**: Defined by `CHR [Name] [Alias] [Start] [Stop]`.
- **Blocks**: Defined by `BLOCK [Name] [Alias] [Chr_Alias] [Start] [Stop] [Color_Name]`.
- **Centromeres**: Defined by `CENTROMERE [Chr_Alias]`. Must follow the block immediately preceding it.
- **Marks**: Defined by `MARK [Title] RECTANGLE [Size] [Chr_Alias] [Position] [Color]`.

### Color Definition Format
Colors are defined in a plain text file or data frame using RGB values (0-255):
`COLOR [Name] [R] [G] [B]`

## Tips for Success
- **Aliases**: Ensure all aliases (karyotype, chromosome, block) are unique within the input file.
- **Centromeres in GRanges**: To define a centromere in a `GRanges` object, set the name to "CENTROMERE" and the range to `[0,0]`.
- **Scale**: When comparing multiple linear karyotypes, use the `-s` (scale) parameter to ensure they are drawn relative to the same genomic length.
- **Output**: The functions return `0` upon successful completion. Check the specified output directory for the generated graphic files.

## Reference documentation
- [Simple karyotypes visualization using chromDraw](./references/chromDraw.md)