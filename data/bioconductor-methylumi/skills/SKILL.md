---
name: bioconductor-methylumi
description: This tool processes and analyzes Illumina DNA methylation data from GoldenGate and Infinium platforms. Use when user asks to load BeadStudio exports or IDAT files, perform background correction, normalize dye bias, or conduct quality control for methylation arrays.
homepage: https://bioconductor.org/packages/release/bioc/html/methylumi.html
---


# bioconductor-methylumi

name: bioconductor-methylumi
description: Processing and analysis of Illumina DNA methylation data (GoldenGate and Infinium platforms). Use this skill to load BeadStudio/GenomeStudio exports or IDAT files, perform background correction, dye-bias normalization, and quality control for methylation arrays.

# bioconductor-methylumi

## Overview
The `methylumi` package is designed for the analysis of Illumina methylation data. It handles both the older GoldenGate platform and the newer Infinium (27k and 450k) platforms. The package provides a specialized `MethyLumiSet` class (extending `eSet`) to store methylated and unmethylated intensities, betavalues, and detection p-values. It is particularly useful for the initial stages of a methylation pipeline: data ingestion, quality control plotting, and normalization.

## Core Workflows

### 1. Loading Data
There are two primary ways to load data depending on the source format:

**From BeadStudio/GenomeStudio Text Exports:**
Use `methylumiR()` for tab-delimited files.
```r
library(methylumi)
# samps is an optional data.frame with sample metadata
mldat <- methylumiR("Sample_Methylation_Profile.txt", 
                    qcfile = "Control_Probe_Profile.txt", 
                    sampleDescriptions = samps)
```

**From Raw IDAT Files (Infinium):**
Use `methylumIDAT()` to read raw intensity files. This requires the `barcodes` (filenames) and the path to the IDATs.
```r
library(methylumi)
idatPath <- "path/to/idat_folder"
barcodes <- c("sentrix_id_row_col", ...) 
mset450k <- methylumIDAT(barcodes, idatPath = idatPath)
```

### 2. Quality Control
`methylumi` provides tools to identify failed arrays or sample swaps.

*   **Detection P-values:** Calculate the mean p-value per sample to identify failed arrays.
    ```r
    avgPval <- colMeans(pvals(mldat))
    badSamples <- avgPval > 0.05
    ```
*   **QC Plots:** Visualize control probes (e.g., hybridization, extension, or negative controls).
    ```r
    # For GoldenGate
    controlTypes(mldat)
    qcplot(mldat, "FIRST HYBRIDIZATION")
    
    # For Infinium 450k (using ggplot2)
    qc.probe.plot(mset450k, by.type = TRUE)
    ```
*   **MDS Plots:** Use `cmdscale` on X-chromosome probes to verify sample gender.

### 3. Preprocessing and Normalization
Normalization corrects for dye bias between the Cy3 and Cy5 channels.

*   **Background Correction:** For IDAT data, use the out-of-band (OOB) intensities.
    ```r
    mset.bg <- methylumi.bgcorr(mset450k)
    ```
*   **Dye Bias Equalization:**
    ```r
    mset.norm <- normalizeMethyLumiSet(mset.bg)
    ```
*   **Memory Management:** Use `stripOOB()` after normalization to remove out-of-band data and reduce object size if you do not plan to coerce to `minfi` structures later.

### 4. Data Accessors
*   `betas(obj)`: Get the matrix of methylation levels (0 to 1).
*   `pvals(obj)`: Get detection p-values.
*   `methylated(obj)` / `unmethylated(obj)`: Get raw intensities.
*   `fData(obj)` / `pData(obj)`: Access feature (CpG site) and phenotype (sample) metadata.

### 5. Integration with Other Packages
`methylumi` objects can be coerced to formats used by `lumi` or `minfi` for downstream analysis.

*   **To lumi:** `as(mset.norm, "MethyLumiM")`
*   **To minfi (RGChannelSet):** `as(mset450k, "RGChannelSet")` (Note: requires OOB data, so do not run `stripOOB` first).
*   **To GenomicMethylSet:** `mapToGenome(mset.norm)` (allows for genomic interval-based subsetting).

## Reference documentation
- [An Introduction to the methylumi package](./references/methylumi.md)
- [Working with Illumina 450k Methylation Arrays](./references/methylumi450k.md)