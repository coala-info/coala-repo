---
name: bioconductor-normr
description: The normr package provides a robust framework for normalizing ChIP-seq data and identifying enriched genomic regions using binomial mixture models. Use when user asks to call peaks from ChIP-seq data, identify differential enrichment between conditions, or stratify genomic regions into multiple enrichment levels.
homepage: https://bioconductor.org/packages/release/bioc/html/normr.html
---

# bioconductor-normr

## Overview
The `normr` package (normR obeys regime mixture Rules) provides a robust framework for normalizing and calling differences in ChIP-seq data. It uses binomial mixture models fitted via Expectation Maximization (EM) to simultaneously normalize for technical biases (like sequencing depth) and identify enriched genomic regions.

## Core Functions

### 1. Enrichment Calling (`enrichR`)
Use `enrichR` to identify peaks in a ChIP-seq track relative to a control (Input).
```r
library(normr)
# genome can be a UCSC ID (e.g., "hg19") or a data.frame with seqnames and length
e <- enrichR(treatment = "ChIP.bam",
             control   = "Control.bam",
             genome    = "hg19")
```

### 2. Differential Enrichment (`diffR`)
Use `diffR` to compare two ChIP-seq tracks directly (e.g., Treatment A vs. Treatment B) to find regions that change between conditions.
```r
de <- diffR(treatment = "ChIP_Cond1.bam",
            control   = "ChIP_Cond2.bam",
            genome    = "hg19")
```

### 3. Regime Stratification (`regimeR`)
Use `regimeR` to identify multiple levels of enrichment, such as distinguishing between broad domains and sharp peaks by specifying the number of model components.
```r
re <- regimeR(treatment = "ChIP.bam",
              control   = "Control.bam",
              genome    = "hg19",
              models    = 3) # e.g., Background, Low Enrichment, High Enrichment
```

## Workflow and Analysis

### Inspecting Results
The functions return a `NormRFit` object. Use `summary()` to see the number of significant regions at various FDR thresholds and `getEnrichment()` for normalized values.
```r
summary(e)
# Get background-normalized enrichment values
enr_values <- getEnrichment(e)
```

### Extracting and Exporting
Extract significant regions as `GRanges` or export them to standard formats (BED, bigWig).
```r
# Get GRanges for regions with FDR <= 0.05
peaks <- getRanges(e, fdr = 0.05)

# Export to file
exportR(e, filename = "peaks.bed", type = "bed", fdr = 0.05)
exportR(e, filename = "normalized.bw", type = "bigWig")
```

### Custom Counting Strategies
Use `NormRCountConfig` to adjust how reads are processed (binsize, mapping quality, fragment shift, or paired-end parameters).
```r
# Example: 500bp bins, filter mapq < 20, shift reads by 100bp
cfg <- countConfigSingleEnd(binsize = 500, mapq = 20, shift = 100)

fit <- enrichR(treatment = "ChIP.bam", control = "Input.bam", 
               genome = "hg19", countConfig = cfg)
```

## Advanced Usage Tips
- **Predefined Regions**: To analyze specific regions (e.g., promoters), provide a `GRanges` object to the `genome` argument. Ensure all regions are of the same size for the binomial model to be valid.
- **CNV Correction**: For cancer samples, you can call differences between two Input tracks using a large binsize (e.g., 25kb) to identify Copy Number Variations (CNVs), then filter your ChIP-seq results against these regions.
- **BAM Requirements**: BAM files must be coordinate-sorted and indexed (`.bai`).

## Reference documentation
- [Introduction to the normR package](./references/normr.Rmd)
- [Introduction to the normR package (Markdown)](./references/normr.md)