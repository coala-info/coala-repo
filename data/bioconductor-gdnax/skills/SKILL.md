---
name: bioconductor-gdnax
description: The bioconductor-gdnax package diagnoses and filters genomic DNA contamination in RNA-seq data. Use when user asks to estimate library strandedness, quantify intergenic or intronic read distributions, and generate filtered BAM files to remove gDNA contamination.
homepage: https://bioconductor.org/packages/release/bioc/html/gDNAx.html
---


# bioconductor-gdnax

name: bioconductor-gdnax
description: Diagnose and filter genomic DNA (gDNA) contamination in RNA-seq data using the gDNAx R package. Use this skill to estimate library strandedness, calculate diagnostics based on intergenic (IGC), intronic (INT), and splice-compatible (SCJ/SCE) alignments, and generate filtered BAM files to remove potential gDNA origin reads.

## Overview

The `gDNAx` package is designed to identify and mitigate the impact of genomic DNA (gDNA) contamination in RNA-seq experiments, which is particularly critical for total RNA-seq libraries. It provides tools to:
1. **Diagnose**: Quantify the distribution of reads across intergenic, intronic, and exonic regions.
2. **Estimate Strandedness**: Determine the library protocol (stranded vs. unstranded) and strandedness levels.
3. **Filter**: Produce new BAM files containing only high-confidence transcriptomic reads.

## Typical Workflow

### 1. Setup and Annotation
Load the package and a `TxDb` object corresponding to your genome assembly (e.g., hg38).

```r
library(gDNAx)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
```

### 2. Diagnose Contamination
Use `gDNAdx()` to analyze BAM files. This function calculates percentages of Intergenic (IGC), Intronic (INT), Splice-Compatible Junction (SCJ), and Splice-Compatible Exonic (SCE) alignments.

```r
# bamfiles is a character vector of paths to BAM files
gdnax_obj <- gDNAdx(bamfiles, txdb)

# View summary
gdnax_obj
```

### 3. Visualization and Interpretation
Visualize the diagnostics to identify samples with high intergenic or intronic content, which often correlates with gDNA contamination.

```r
# Basic diagnostic plots (IGC vs SCJ/SCE/INT)
plot(gdnax_obj, group=metadata$condition)

# Plot fragment length distributions by alignment origin
plotFrgLength(gdnax_obj)

# Plot proportions of alignment origins per sample
plotAlnOrigins(gdnax_obj)
```

### 4. Strandedness Analysis
Check if the library is stranded. In stranded data, gDNA contamination typically lowers the strandedness value toward 0.5 because DNA reads align to both strands equally.

```r
# Get raw strandedness values
std <- strandedness(gdnax_obj)

# Classify the strand mode (1, 2, or NA for unstranded)
classifyStrandMode(std)
```

### 5. Filtering gDNA Reads
Generate filtered BAM files. By default, `gDNAtx()` keeps splice-compatible alignments found in genomic windows enriched for stranded alignments.

```r
# Define output directory
out_dir <- "filtered_bams"

# Run filtering
filter_stats <- gDNAtx(gdnax_obj, path=out_dir)
```

## Key Functions

- `gDNAdx()`: Main diagnostic function. Returns a `gDNAx` object.
- `getDx()`: Extracts the diagnostic data frame (IGC, INT, SCJ, SCE, JNC, and FLM values).
- `strandedness()`: Estimates the proportion of reads aligned to the expected strand.
- `gDNAtx()`: High-level function to filter BAM files.
- `filterBAMtx()`: Lower-level filtering function for fine-tuning (e.g., using `filterBAMtxFlag()`).
- `getIgc()` / `getInt()`: Retrieve the specific intergenic and intronic GRanges used for analysis.

## Tips
- **Performance**: For large datasets, use the `BPPARAM` argument in `gDNAdx()` to enable parallel processing via `BiocParallel`.
- **Memory**: `gDNAdx()` processes the first 100,000 alignments by default to be efficient; this is usually sufficient for a robust diagnosis.
- **Strandedness**: If you already know your `strandMode` (1 or 2) and layout (singleEnd), provide them to `gDNAdx()` to speed up the process.

## Reference documentation

- [The gDNAx package](./references/gDNAx.md)