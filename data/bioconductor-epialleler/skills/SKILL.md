---
name: bioconductor-epialleler
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/epialleleR.html
---

# bioconductor-epialleler

## Overview
The `epialleleR` package is designed for fast and scalable analysis of DNA methylation at the level of individual sequencing reads (epialleles). Unlike conventional methods that average methylation levels (beta values), `epialleleR` identifies concordant methylation patterns and calculates Variant Epiallele Frequency (VEF). This is particularly useful for detecting low-frequency hypermethylated alleles in cancer research and mosaicism studies.

## Typical Workflow

### 1. Data Preprocessing
The package requires BAM files. Short-read data (bisulfite) should ideally have `XM` (methylation call) and `XG` (genomic strand) tags. Long-read data requires `MM` and `ML` tags.

```r
library(epialleleR)

# Preprocess BAM to load into memory (recommended for multiple reports)
bam.data <- preprocessBam("path/to/file.bam")

# If tags are missing in short-read BAMs (e.g., from bwa-meth), call methylation first:
# genome <- preprocessGenome("reference.fasta")
# callMethylation(input.bam, output.bam, genome)
```

### 2. Generating Reports
`epialleleR` provides several reporting functions depending on the unit of analysis:

*   **Cytosine Report**: Conventional or thresholded (VEF) reports for individual cytosines.
    ```r
    # VEF report (default)
    vef.report <- generateCytosineReport(bam.data)
    
    # Conventional report (no thresholding)
    cg.report <- generateCytosineReport(bam.data, threshold.reads=FALSE)
    ```
*   **BED/Region Report**: Aggregated VEF for specific genomic regions (amplicons or capture targets).
    ```r
    # For amplicon sequencing (exact matches)
    amp.report <- generateAmpliconReport(bam="file.bam", bed="regions.bed")
    
    # For capture sequencing (overlaps)
    cap.report <- generateCaptureReport(bam="file.bam", bed="regions.bed")
    ```
*   **lMHL Report**: Linearized Methylated Haplotype Load, useful for long-read data where thresholding is not recommended.
    ```r
    mhl.report <- generateMhlReport(bam.data)
    ```

### 3. Pattern Exploration and Visualization
Visualize the actual methylation strings of individual reads within a region.

```r
# Extract patterns for a specific range
patterns <- extractPatterns(bam="file.bam", bed=as("chr17:43125200-43125600","GRanges"))

# Plot the most abundant patterns
plotPatterns(patterns)
```

### 4. Sequence Variation (SNV) Association
Test if specific single-nucleotide variations are associated with hypermethylated epialleles.

```r
vcf.report <- generateVcfReport(
  bam="file.bam", 
  bed="regions.bed", 
  vcf="variants.vcf.gz",
  min.baseq=13
)
# FEp+ and FEp- columns provide Fisher's Exact test p-values for strand-specific association
```

### 5. Bimodality Assessment
Assess the distribution of methylation across reads to identify bimodal populations.

```r
ecdfs <- generateBedEcdf(bam="file.bam", bed="regions.bed")
plot(ecdfs[[1]]$context, col="red", main="Within-context Beta Distribution")
```

## Tips for Success
*   **Memory Management**: For very large BAM files, use `preprocessBam` once and pass the resulting object to reporting functions to avoid redundant disk I/O.
*   **Multithreading**: Use the `nthreads` parameter in functions like `preprocessBam` or `generateCytosineReport` to speed up HTSlib decompression.
*   **Paired-end Data**: Ensure paired-end BAMs are sorted by name (`samtools sort -n`) so `epialleleR` can correctly merge read pairs into single templates.
*   **Thresholding**: The default `threshold.reads=TRUE` in cytosine reports treats reads with low methylation density as unmethylated, which is the core mechanism for calculating VEF.

## Reference documentation
- [The epialleleR User's Guide](./references/epialleleR.md)
- [The epialleleR output values](./references/values.md)