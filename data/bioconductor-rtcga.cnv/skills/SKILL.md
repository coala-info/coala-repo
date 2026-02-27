---
name: bioconductor-rtcga.cnv
description: This tool provides access to and analysis of segmented Copy Number Variation data from The Cancer Genome Atlas. Use when user asks to load TCGA CNV datasets, analyze gene-specific copy number variations, or integrate CNV data with clinical and other multi-omic data types.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RTCGA.CNV.html
---


# bioconductor-rtcga.cnv

name: bioconductor-rtcga.cnv
description: Access and analyze Copy Number Variation (CNV) data from The Cancer Genome Atlas (TCGA). Use this skill to load pre-processed CNV datasets for various cancer cohorts, calculate gene-specific CNV scores, and integrate CNV data with other TCGA data types (clinical, mutations, RNASeq) for multi-omic analysis.

## Overview
The `RTCGA.CNV` package is a data-experiment package providing segmented Copy Number Variation (CNV) data from the TCGA project. It is part of the `RTCGA` family of packages, which simplifies the process of downloading and integrating complex genomic data. The CNV data typically includes genomic coordinates (Chromosome, Start, End) and the `Segment_Mean` (log2 ratio of copy number).

## Loading CNV Data
Datasets are named using the convention `[COHORT].CNV`. To use them, you must load the package and the specific dataset of interest.

```r
library(RTCGA.CNV)
# List available datasets
data(package = "RTCGA.CNV")

# Load a specific cohort (e.g., Breast Invasive Carcinoma)
data(BRCA.CNV)
head(BRCA.CNV)
```

## Typical Workflow: Gene-Specific CNV Analysis
To analyze a specific gene (e.g., MDM2), you must filter the segmented data based on the gene's genomic coordinates.

### 1. Define a Region Search Function
Since the data is segmented, you need to find segments that overlap with your gene of interest.

```r
# Example: MDM2 is on Chr 12, approx 69200000-69240000
get_gene_cnv <- function(cohort_data, chr, start, stop) {
  cohort_data[cohort_data$Chromosome == chr & 
              pmin(cohort_data$Start, cohort_data$End) <= stop & 
              pmax(cohort_data$Start, cohort_data$End) >= start, ]
}

mdm2_brca <- get_gene_cnv(BRCA.CNV, "12", 69200000, 69240000)
```

### 2. Interpret Segment Means
The `Segment_Mean` column represents $log_2(copy\_number/2)$.
*   **0**: Normal (2 copies)
*   **> 0.58**: Potential Gain (approx. > 3 copies)
*   **< -1**: Potential Loss (approx. < 1 copy)

```r
# Identify high-level amplifications (> 3 copies)
cutoff <- log2(3/2) 
mdm2_brca$status <- ifelse(mdm2_brca$Segment_Mean > cutoff, "Amplified", "Normal/Loss")
```

## Integration with RTCGA Ecosystem
`RTCGA.CNV` is most powerful when combined with the `RTCGA` base package for clinical or expression data.

### Joining with Clinical Data
Use the `bcr_patient_barcode` (or `Sample` column in CNV data) to join datasets. Note that CNV barcodes are often longer; use `substr()` to trim them to the 12-character patient ID.

```r
library(RTCGA.clinical)
data(BRCA.clinical)

# Standardize barcodes to 12 characters
BRCA.CNV$Sample_Short <- substr(BRCA.CNV$Sample, 1, 12)
BRCA.clinical$Patient_Short <- substr(BRCA.clinical$bcr_patient_barcode, 1, 12)

# Merge
combined_data <- merge(BRCA.clinical, BRCA.CNV, 
                       by.x = "Patient_Short", by.y = "Sample_Short")
```

## Tips
*   **Barcode Matching**: TCGA barcodes in CNV data often include sample/vial info (e.g., characters 14-15). "01" usually indicates primary tumor.
*   **Multiple Segments**: A single gene might span multiple segments for one patient. You may need to aggregate (e.g., take the mean or max `Segment_Mean`) per patient.
*   **Data Updates**: While `RTCGA.CNV` provides static snapshots, use the `RTCGA` package's `downloadTCGA` function to fetch the latest Firehose releases if needed.

## Reference documentation
- [Quick Data Download Guide](./references/Data_Download.Rmd)
- [RTCGA package workflow](./references/RTCGA_Workflow.Rmd)
- [Visualizations](./references/Visualizations.Rmd)
- [How to download CNV data](./references/downloading_cnv_datasets.md)
- [Frequency of MDM2 duplications](./references/frequency_of_cnv_for_mdm3.md)