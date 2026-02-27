---
name: bioconductor-methvisual
description: This tool performs visualization and exploratory statistical analysis of DNA methylation profiles from bisulfite sequencing data. Use when user asks to align clone sequences to a reference, perform quality control on bisulfite conversion rates, calculate methylation status, or generate visualizations like lollipop plots and cooccurrence matrices.
homepage: https://bioconductor.org/packages/3.8/bioc/html/methVisual.html
---


# bioconductor-methvisual

name: bioconductor-methvisual
description: Visualization and exploratory statistical analysis of DNA methylation profiles from bisulfite sequencing data. Use this skill to align clone sequences to a reference, perform quality control on bisulfite conversion rates, calculate methylation status, and generate visualizations like lollipop plots, cooccurrence matrices, and correspondence analysis.

# bioconductor-methvisual

## Overview

The `methVisual` package is designed for the processing and visualization of DNA methylation data obtained via bisulfite sequencing. It handles the transition from raw FASTA sequences to binary methylation matrices, providing tools for quality control (detecting incomplete bisulfite conversion and sequencing errors) and various statistical visualizations. It is particularly useful for identifying cooccurrence patterns between CpG sites and comparing methylation profiles between experimental groups.

## Typical Workflow

### 1. Data Input and Reference Selection
Load the package and import your sequences. You typically need a reference sequence and a set of clone sequences.

```r
library(methVisual)

# Load a reference sequence (FASTA format)
refseq <- selectRefSeq("path/to/reference.txt")

# Load clone sequences via a tab-delimited file containing PATH and FILE columns
methData <- MethDataInput("path/to/PathFileTab.txt")
```

### 2. Quality Control (QC)
The `MethylQC` function performs alignment control (checking for reverse/complement sequences) and calculates the bisulfite conversion rate (based on C to T conversion outside of CpG sites).

```r
# identity: minimum sequence identity percentage
# conversion: minimum bisulfite conversion rate percentage
QCdata <- MethylQC(refseq, methData, makeChange=TRUE, identity=80, conversion=90)
```

### 3. Calculating Methylation Status
Align the quality-checked sequences to the reference to extract the binary methylation state (1 for methylated, 0 for unmethylated).

```r
# Returns a list containing methylation positions, CpG locations, and alignments
meth_results <- MethAlignNW(refseq, QCdata)
```

## Visualization and Analysis

### Basic Visualization
*   **Lollipop Plots**: Visualize the methylation state of every CpG site across all clones.
    ```r
    MethLollipops(meth_results)
    ```
*   **Absolute Methylation**: Plot the number of methylated sites at each genomic position.
    ```r
    plotAbsMethyl(meth_results, real=TRUE)
    ```

### Cooccurrence Analysis
*   **Neighboring Cooccurrence**: Analyze if adjacent CpG sites are methylated coordinately.
    ```r
    Cooccurrence(meth_results, file="Cooccurrence.pdf")
    ```
*   **Distant Cooccurrence**: Generate a correlation matrix for all pairwise CpG site combinations.
    ```r
    summary_mtx <- matrixSNP(meth_results)
    plotMatrixSNP(summary_mtx, meth_results)
    ```

### Statistical Testing
Compare methylation patterns between two groups of sequences (defined by their indices in the data object).

*   **Fisher's Exact Test**: Test independence for each individual CpG site.
    ```r
    methFisherTest(meth_results, group1=c(1,2,3), group2=c(4,5,6))
    ```
*   **Mann-Whitney U-Test**: Test for differences in the overall distribution of methylation.
    ```r
    methWhitneyUTest(meth_results, group1=c(1,2,3), group2=c(4,5,6))
    ```

### Advanced Exploratory Analysis
*   **Heatmaps**: Perform hierarchical bi-clustering using binary distance.
    ```r
    heatMapMeth(meth_results)
    ```
*   **Correspondence Analysis (CA)**: Detect clusters of samples with similar cooccurrence patterns.
    ```r
    methCA(meth_results)
    ```

## Reference documentation

- [MethVisual - Visualization and statistical analysis of DNA methylation profiles](./references/methVisual.md)