---
name: bioconductor-cnvfilter
description: CNVfilteR identifies and removes false positive germline CNV calls by analyzing SNV allele frequencies within the called regions. Use when user asks to filter CNV calls, reduce false discovery rates in CNV detection, or cross-reference CNVs with SNV data.
homepage: https://bioconductor.org/packages/release/bioc/html/CNVfilteR.html
---


# bioconductor-cnvfilter

## Overview

CNVfilteR is a Bioconductor package designed to reduce false discovery rates in germline CNV detection. It works by cross-referencing CNV calls with SNV calls (typically from the same NGS pipeline). The core logic relies on the fact that SNV allele frequencies should shift predictably in the presence of a true CNV (e.g., ~33% or ~66% for duplications, or a loss of heterozygosity for deletions). If SNVs within a called CNV region behave like normal diploid variants (e.g., ~50% frequency), the CNV is flagged as a false positive.

## Workflow and Core Functions

### 1. Loading CNV Calls
Load CNV data into a `GRanges` object. The package provides `loadCNVcalls()` to parse CSV/TSV files.

```r
library(CNVfilteR)

# Load from file
cnvs.gr <- loadCNVcalls(cnvs.file = "path/to/calls.csv", 
                        chr.column = "Chromosome", 
                        start.column = "Start", 
                        end.column = "End", 
                        cnv.column = "CNV.type", 
                        sample.column = "Sample", 
                        genome = "hg19")
```
*   **Note:** Use `deletion` and `duplication` parameters if your file uses custom labels (e.g., `deletion = "Loss"`).
*   **Coordinates:** If location is in one column (e.g., "1:500-1000"), use the `coord.column` parameter.

### 2. Loading Variant (SNV) Data
Load VCF files using `loadVCFs()`. It automatically supports VarScan2, Strelka, freeBayes, GATK (HaplotypeCaller/UnifiedGenotyper), and Torrent Variant Caller.

```r
vcf.files <- c("sample1.vcf.gz", "sample2.vcf.gz")
vcfs <- loadVCFs(vcf.files, cnvs.gr = cnvs.gr, genome = "hg19")
```

**Optimization Tips:**
*   **Depth:** Use `min.total.depth` (default 10) to filter low-quality SNVs. Increase this for high-coverage panels.
*   **Exclusions:** Use `regions.to.exclude` (GRanges) to ignore pseudogenes or repetitive regions.
*   **INDELs:** By default, `exclude.indels = TRUE` is recommended as their allele frequency is less stable for this specific filtering logic.

### 3. Identifying False Positives
The `filterCNVs()` function performs the analysis and returns an S3 object containing the results.

```r
results <- filterCNVs(cnvs.gr, vcfs)

# View CNVs flagged for removal
filtered_out <- results$cnvs[results$cnvs$filter == TRUE]
```

**Filtering Logic:**
*   **Deletions:** Filtered out if the percentage of heterozygous variants in the region exceeds `ht.deletions.threshold` (default 30%).
*   **Duplications:** Uses a fuzzy-logic scoring model. If the total `score` (based on proximity of SNVs to 50% vs 33/66% frequency) is >= `dup.threshold.score` (default 0.5), the CNV is discarded.

### 4. Visualizing Results
Visualize specific CNVs to inspect the SNV allele frequencies manually.

```r
# Plot a specific CNV by its ID
plotVariantsForCNV(results, cnv.id = "3")

# Plot all CNVs across the genome
plotAllCNVs(cnvs.gr)
```

## Advanced Configuration

### Scoring Model
The duplication scoring model uses sigmoids. You can adjust the sensitivity by modifying `filterCNVs()` parameters:
*   `expected.ht.mean`: Expected freq for normal diploid (default 0.5).
*   `expected.dup.ht.mean1` / `mean2`: Expected freq for duplication (default 0.33 and 0.66).
*   `margin.pct`: Percentage of the CNV ends to ignore (default 10%). Increase this if your CNV caller has "fuzzy" boundaries.

## Reference documentation

- [CNVfilteR vignette](./references/CNVfilteR.md)
- [CNVfilteR RMarkdown Source](./references/CNVfilteR.Rmd)