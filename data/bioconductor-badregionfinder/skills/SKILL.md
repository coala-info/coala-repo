---
name: bioconductor-badregionfinder
description: BadRegionFinder identifies and classifies genomic regions with suboptimal coverage in sequencing data across multiple samples. Use when user asks to identify regions with low read depth, classify coverage quality based on custom thresholds, or generate summary reports of problematic genomic regions from BAM files.
homepage: https://bioconductor.org/packages/release/bioc/html/BadRegionFinder.html
---

# bioconductor-badregionfinder

name: bioconductor-badregionfinder
description: Identify and classify genomic regions with bad coverage in sequencing data. Use this skill when you need to analyze BAM files to find regions (on or off target) that fall below specific coverage thresholds across multiple samples, or when you need to generate summary reports and visualizations of coverage quality for specific genes or regions.

# bioconductor-badregionfinder

## Overview
BadRegionFinder is a Bioconductor package designed to identify genomic regions with suboptimal coverage in targeted sequencing experiments. It allows for the simultaneous analysis of multiple samples, classifying coverage into "bad", "acceptable", or "good" based on user-defined thresholds for both read depth and the percentage of samples meeting that depth. It is particularly useful for identifying problematic amplicons, GC-rich regions that are difficult to sequence, or off-target high-coverage areas.

## Workflow and Core Functions

### 1. Data Preparation
You need a data frame of sample names (without .bam extension) and a set of target regions (BED-like data frame or GRanges).

```r
library(BadRegionFinder)

# Sample names data frame
samples <- data.frame(V1 = c("Sample1", "Sample2"))

# Target regions (Chr, Start, End)
targetRegions <- data.frame(
  chr = c("1", "17"),
  start = c(100000, 74732937),
  end = c(101000, 74733301)
)
```

### 2. Determining Coverage
Use `determineCoverage` to scan BAM files. Set `TRonly = TRUE` to focus only on target regions for faster performance, or `FALSE` to include off-target covered bases.

```r
# bam_path should contain .bam and .bai files
coverage_summary <- determineCoverage(samples, bam_path, targetRegions, TRonly = TRUE, output_file = "")
```

### 3. Classifying Quality
Define thresholds to categorize coverage.
*   `threshold1`, `threshold2`: Read depth cutoffs (e.g., 20x, 100x).
*   `percentage1`, `percentage2`: Fraction of samples required to meet the depth (e.g., 0.80, 0.90).

```r
# Indicators: 0/1 (Bad), 2/3 (Acceptable), 4/5 (Good). Odd = On-target, Even = Off-target.
coverage_indicators <- determineCoverageQuality(threshold1 = 20, threshold2 = 100, 
                                                percentage1 = 0.8, percentage2 = 0.9, 
                                                coverage_summary)
```

### 4. Reporting Results
The package provides three main reporting variants:

*   **Summary (Regions):** Sums up contiguous bases with the same quality and assigns genes via biomaRt.
    ```r
    summary_report <- reportBadRegionsSummary(threshold1, threshold2, percentage1, percentage2, 
                                              coverage_indicators, mart = "", output_file = "")
    ```
*   **Detailed (Basewise):** Provides per-base coverage and quality information.
    ```r
    detailed_report <- reportBadRegionsDetailed(threshold1, threshold2, percentage1, percentage2, 
                                                coverage_indicators, mart = "", samples, output_file = "")
    ```
*   **Genewise Summary:** Aggregates quality statistics at the gene level.
    ```r
    gene_report <- reportBadRegionsGenes(threshold1, threshold2, percentage1, percentage2, 
                                         summary_report, output_file = "")
    ```

### 5. Visualization
*   `plotSummary(..., summary_report, "")`: Line graph of coverage quality categories across regions.
*   `plotDetailed(..., detailed_report, "")`: Median coverage plot with color-coded quality indicators.
*   `plotSummaryGenes(..., gene_report, "")`: Stacked barplot showing the percentage of each gene falling into quality categories.

## Tips and Best Practices
*   **Genome Assembly:** By default, the package uses `hg19`. For other genomes, provide a custom `biomaRt` object to the reporting functions.
*   **Performance:** `determineCoverage` is the most time-consuming step. Use `TRonly = TRUE` if you are only interested in your capture targets.
*   **Quantiles:** Use `determineQuantiles(coverage_summary, c(0.25, 0.5, 0.75), "")` to get specific depth distributions across samples without applying quality classifications.
*   **Region Selection:** Use `determineRegionsOfInterest()` to filter a large coverage dataset down to specific genomic coordinates before reporting.

## Reference documentation
- [BadRegionFinder](./references/BadRegionFinder.md)