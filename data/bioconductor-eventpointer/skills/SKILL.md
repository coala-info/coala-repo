---
name: bioconductor-eventpointer
description: Bioconductor-eventpointer identifies and analyzes alternative splicing events from junction arrays or RNA-Seq data using splicing graphs. Use when user asks to detect splicing events, perform statistical analysis for differential splicing, calculate Percent Spliced In, or generate visualization files for IGV.
homepage: https://bioconductor.org/packages/release/bioc/html/EventPointer.html
---


# bioconductor-eventpointer

name: bioconductor-eventpointer
description: Identification and analysis of alternative splicing events from junction arrays (Affymetrix) or RNA-Seq data. Use this skill to create splicing graphs, detect events (cassette exons, alternative splice sites, etc.), perform statistical analysis for differential splicing, calculate Percent Spliced In (PSI), and generate visualization files for IGV.

# bioconductor-eventpointer

## Overview

EventPointer is an R package designed to identify alternative splicing events in both microarray (HTA 2.0, Clariom-D, MTA, RTA) and RNA-Seq data. It works by constructing splicing graphs, identifying triplets of subgraphs that represent splicing events, and performing statistical tests to find significant changes in isoform usage across experimental conditions. It supports complex experimental designs, including time-course and paired-sample studies.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("EventPointer")
library(EventPointer)
```

## Workflow: RNA-Seq (BAM-based)

This workflow identifies novel and known events directly from BAM files.

1.  **Prepare BAM files**: Requires `.bam` files with the `XS` flag and corresponding `.bai` indexes.
    ```r
    # Create splicing graph and count features
    SG_RNASeq <- PrepareBam_EP(Samples = sample_names,
                               SamplePath = "/path/to/bams",
                               Ref_Transc = "GTF",
                               fileTransc = "reference.gtf",
                               cores = 1)
    ```
2.  **Event Detection**:
    ```r
    AllEvents <- EventDetection(SG_RNASeq, cores = 1, Path = tempdir())
    ```
3.  **Statistical Analysis**:
    ```r
    # Define Design and Contrast matrices (limma-style)
    Results <- EventPointer_RNASeq(Events = AllEvents,
                                   Design = Dmatrix,
                                   Contrast = Cmatrix,
                                   Statistic = "LogFC",
                                   PSI = TRUE)
    ```

## Workflow: RNA-Seq (Transcriptome-based)

This workflow uses pseudo-alignment results (Kallisto/Salmon) to quantify events in a reference transcriptome.

1.  **Detect Events from GTF**:
    ```r
    EventXtrans <- EventDetection_transcriptome(inputFile = "ref.gtf",
                                                Transcriptome = "MyRef",
                                                Pathtxt = tempdir())
    ```
2.  **Quantify PSI and Expression**:
    ```r
    # Using bootstrap data from Kallisto/Salmon
    data_exp <- getbootstrapdata(PathSamples = "/path/to/output", type = "kallisto")
    PSIss <- GetPSI_FromTranRef(PathsxTranscript = EventXtrans,
                                Samples = data_exp,
                                Bootstrap = TRUE)
    ```
3.  **Statistical Testing**:
    ```r
    # Standard test
    Fit <- EventPointer_RNASeq_TranRef(Count_Matrix = PSIss$ExpEvs,
                                      Design = Dmatrix,
                                      Contrast = Cmatrix)

    # Bootstrap-based test
    BootFit <- EventPointer_Bootstraps(PSI = PSIss$PSI,
                                      Design = Dmatrix,
                                      Contrast = Cmatrix,
                                      nBootstraps = 10)
    ```

## Workflow: Junction Arrays

1.  **CDF Creation**: Generate a custom CDF for aroma.affymetrix.
    ```r
    CDFfromGTF(input = "AffyGTF", inputFile = "ref.gtf",
               PSR = "ExonProbes.txt", Junc = "JuncProbes.txt",
               PathCDF = tempdir(), microarray = "HTA-2_0")
    ```
2.  **Analysis**: After pre-processing with `aroma.affymetrix` to get `ExFit` data.
    ```r
    Events <- EventPointer(Design = Dmatrix,
                           Contrast = Cmatrix,
                           ExFit = ArraysData,
                           Eventstxt = "EventsFound.txt",
                           Statistic = "LogFC",
                           PSI = TRUE)
    ```

## Visualization and Validation

*   **IGV Visualization**: Generate GTF files to view events in IGV.
    *   RNA-Seq: `EventPointer_RNASeq_IGV(...)` or `EventPointer_RNASeq_TranRef_IGV(...)`
    *   Arrays: `EventPointer_IGV(...)`
*   **Primer Design**: Design PCR primers for event validation.
    ```r
    # Requires Primer3 installed and in PATH
    Primers <- FindPrimers(SG = SG_info,
                           EventNum = 1,
                           Primer3Path = Sys.which("primer3_core"),
                           Dir = "/path/to/primer3_config",
                           mygenomesequence = BSgenome.Hsapiens.UCSC.hg38,
                           taqman = 0)
    ```

## Key Parameters and Tips

*   **Statistic**: Choose from `"LogFC"` (combined fold change of both isoforms), `"Dif_LogFC"` (difference of fold changes), or `"DRS"` (Difference of Relative Splicing). `"LogFC"` is generally recommended for best performance.
*   **Multi-Path Events**: Use `EventDetectionMultipath` or `CDFfromGTF_Multipath` for events involving more than two alternative paths.
*   **Complex Events**: Use `Events_ReClassification` to further categorize "Complex" events into more descriptive types like "Multiple Skipping Exons".

## Reference documentation

- [EventPointer: An effective identification of alternative splicing events using junction arrays and RNA-Seq data](./references/EventPointer.md)
- [EventPointer Vignette Source](./references/EventPointer.Rmd)