---
name: r-eacon
description: EaCoN is an R package for performing full-workflow copy-number analysis on microarray and whole-exome sequencing data. Use when user asks to normalize raw data, perform segmentation, estimate copy numbers, or generate interactive reports.
homepage: https://cran.r-project.org/web/packages/eacon/index.html
---


# r-eacon

## Overview
EaCoN (Easy Copy Number) is an R package designed for full-workflow copy-number analysis. It supports multiple data sources including Affymetrix microarrays and WES BAM files. The workflow typically follows a sequence of normalization, segmentation, copy-number estimation, and reporting.

## Installation
```R
install.packages("devtools")
# Core dependencies
devtools::install_github("Crick-CancerGenomics/ascat/ASCAT")
devtools::install_github("mskcc/facets")
if(!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("affxparser", "Biostrings", "aroma.light", "BSgenome", "copynumber", "GenomicRanges", "limma", "rhdf5", "sequenza"))

# Install EaCoN
devtools::install_github("gustaveroussy/EaCoN")
```
*Note: Microarray analysis requires additional annotation and APT packages (e.g., `apt.oncoscan.2.4.0`, `affy.CN.norm.data`).*

## Workflows

### 1. Raw Data Processing (Normalization)
Functions vary by platform but all generate a `_processed.RDS` file.

*   **OncoScan**: `OS.Process(ATChannelCel, GCChannelCel, samplename)`
*   **CytoScan**: `CS.Process(CEL, samplename)`
*   **SNP6**: `SNP6.Process(CEL, samplename)`
*   **WES**:
    1.  Create BINpack: `BINpack.Maker(bed.file, bin.size = 50, genome.pkg)`
    2.  Bin data: `WES.Bin(testBAM, refBAM, BINpack, samplename)`
    3.  Normalize: `WES.Normalize.ff(BIN.RDS.file, BINpack)`

### 2. Segmentation
Performs bivariate segmentation on the processed RDS.
```R
# Supported segmenters: "ASCAT" (recommended), "FACETS", "SEQUENZA"
Segment.ff(RDS.file = "sample_processed.RDS", segmenter = "ASCAT")
```

### 3. Copy-Number Estimation
Estimates total (TCN) and allele-specific (ASCN) copy numbers, ploidy, and cellularity.
```R
ASCN.ff(RDS.file = "sample.SEG.ASCAT.RDS")
```

### 4. Reporting
Generates an interactive HTML report.
```R
Annotate.ff(RDS.file = "sample.SEG.ASCAT.RDS", author.name = "Your Name")
```

## Batch Processing
For multiple samples, use the `.Batch` suffix. These functions support multithreading via the `nthread` parameter.
*   `OS.Process.Batch(pairs.file, nthread = 2)`
*   `CS.Process.Batch(CEL.list.file, nthread = 2)`
*   `WES.Bin.Batch(BAM.list.file, BINpack, nthread = 2)`
*   `Segment.ff.Batch(RDS.files, segmenter = "ASCAT", nthread = 2)`

## Recommended Segmentation Parameters
| Source | SER.pen | smooth.k | nrf | BAF.filter |
| :--- | :--- | :--- | :--- | :--- |
| OncoScan | 40 | NULL | 0.5 | 0.90 |
| CytoScan HD | 20 | 5 | 1.0 | 0.75 |
| SNP6 | 60 | 5 | 0.25 | 0.75 |
| WES | 2-10 | 5 | 0.5-1.0 | 0.75 |

## Tips
*   **SNP6 Limitations**: FACETS is not supported for SNP6. SEQUENZA is not recommended for SNP6 due to high RAM requirements.
*   **Genomes**: Ensure the correct `BSgenome` package is installed (e.g., `BSgenome.Hsapiens.UCSC.hg19` for NA33/NA35).
*   **Piping**: Use `magrittr` pipes (`%>%`) with the base functions (e.g., `OS.Process(...) %>% Segment(...)`) by setting `return.data = TRUE`.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)