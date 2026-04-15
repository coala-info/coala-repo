---
name: bioconductor-ampliqueso
description: This tool analyzes amplicon sequencing panels using coverage-based non-parametric tests and read counting. Use when user asks to perform coverage analysis, generate read counts from BAM files, call variants using samtools, or produce comprehensive experiment reports for RNA or DNA amplicon data.
homepage: https://bioconductor.org/packages/3.8/bioc/html/ampliQueso.html
---

# bioconductor-ampliqueso

name: bioconductor-ampliqueso
description: Analysis of amplicon sequencing panels (e.g., AmpliSeq) using the ampliQueso R package. Use this skill to perform coverage-based non-parametric tests, generate read counts from BAM files, call variants using samtools integration, and produce comprehensive experiment reports for RNA or DNA amplicon data.

# bioconductor-ampliqueso

## Overview

The `ampliQueso` package is designed for the analysis of multiple-amplicon sequencing panels. Unlike standard RNA-seq workflows that rely on tools like DESeq2 (which may struggle with the small number of amplicons in some panels), `ampliQueso` utilizes coverage analysis (camel measures) and non-parametric tests to identify differential expression or genomic variations. It is particularly effective for degraded samples (e.g., paraffin-embedded) and supports both RNA and DNA amplicon technologies.

## Core Workflows

### 1. Data Preparation and Visualization
Load the library and inspect coverage shapes for specific genomic regions.

```r
library(ampliQueso)
data(ampliQueso)

# Plot coverage for specific regions (e.g., ndMin and ndMax objects)
par(mfrow=c(1,2))
simplePlot(ndMin, exps=1:2, xlab="genome coordinates", ylab="coverage")
simplePlot(ndMax, exps=1:2, xlab="genome coordinates", ylab="coverage")
```

### 2. Non-parametric Coverage Tests (Camel Tests)
Compare coverage shapes between groups using "camel" measures to generate p-values.

```r
# Requires a covdesc file (sample descriptions) and a BED file (amplicon regions)
iCovdesc <- "path/to/covdesc"
iBedFile <- "path/to/AQ.bed"

camelTestTable <- camelTest(
  iBedFile = iBedFile, 
  iCovdesc = iCovdesc, 
  iT1 = "group1_label", 
  iT2 = "group2_label", 
  iParallel = FALSE, 
  iNPerm = 100
)

# Results include p-values for DA, QQ, PP, HD1, and HD2 density measures
head(camelTestTable)
```

### 3. Read Counting
Generate a count table from BAM files based on the amplicon design in a BED file.

```r
counts <- getCountTable(
  covdesc = "path/to/covdesc", 
  bedFile = "path/to/AQ.bed"
)
```

### 4. Variant Calling
Call SNPs and indels by wrapping `samtools mpileup`. This requires a reference genome in FASTA format.

```r
snpList <- getSNP(
  covdesc = "path/to/covdesc", 
  bedFile = "path/to/AQ.bed",
  refSeqFile = "hg19.fa", 
  minQual = 10
)
```

### 5. Automated Reporting
Generate a complete PDF report (LaTeX/Beamer) covering counts, camel tests, and SNPs.

```r
runAQReport(
  iCovdesc = "path/to/covdesc",
  iBedFile = "path/to/AQ.bed",
  iRefSeqFile = "path/to/ref.fa",
  iGroup = "group_column_name",
  iT1 = "control_label",
  iT2 = "test_label",
  iReportFormat = "pdf",
  iReportType = "article",
  iReportPath = getwd()
)
```

## File Format Requirements

### BED Format
The package expects a specific 6-column BED format:
1. `chromName` (e.g., chr1)
2. `chromStart`
3. `chromEnd`
4. `strand`
5. `unspecified` (often a dot `.`)
6. `name` (Amplicon ID)

If your BED file has columns 4, 5, and 6 in a different order, rearrange them in R or via shell (e.g., `awk '{print($1,"\t",$2,"\t",$3,"\t",$5,"\t",$6,"\t",$4)}'`).

## Troubleshooting

- **Mac OS X:** If using `rgl`, ensure the `DISPLAY` environment variable is not set before starting R to avoid hangs. It is recommended to run `ampliQueso` from a terminal session rather than R.app when using parallel processing (`foreach`).
- **Windows:** Ensure firewall exceptions are allowed for R slave servers if running parallel tasks.

## Reference documentation
- [ampliQueso](./references/ampliQueso.md)