---
name: bioconductor-mcsurvdata
description: This package provides access to curated meta-cohort survival data and gene expression datasets for breast and colorectal cancer. Use when user asks to retrieve processed ExpressionSet objects, access clinical survival metadata from GEO studies, or perform meta-analysis and prognostic modeling for BRCA and CRC.
homepage: https://bioconductor.org/packages/release/data/experiment/html/mcsurvdata.html
---

# bioconductor-mcsurvdata

name: bioconductor-mcsurvdata
description: Access and analyze curated meta-cohort survival data for breast cancer (BRCA) and colorectal cancer (CRC). Use this skill when a user needs to retrieve processed gene expression datasets (ExpressionSet objects) and associated clinical survival metadata from multiple GEO studies for cancer research, prognostic modeling, or meta-analysis in R.

# bioconductor-mcsurvdata

## Overview
The `mcsurvdata` package provides access to two large, curated meta-cohorts of cancer patients: 914 colorectal cancer (CRC) samples and 2,294 breast cancer (BRCA) samples. These datasets are derived from multiple NCBI GEO repositories, processed using standardized pipelines (RMA normalization, batch correction, and gene-level summarization), and formatted as `ExpressionSet` objects for immediate use in survival analysis.

## Data Acquisition
The datasets are hosted on Bioconductor's `ExperimentHub`. You must use the `ExperimentHub` interface to download the data.

```r
library(mcsurvdata)
library(ExperimentHub)

# Initialize ExperimentHub
eh <- ExperimentHub()

# Query for mcsurvdata resources
dat <- query(eh, "mcsurvdata")

# Retrieve specific datasets
# EH1497: Breast Cancer (BRCA) meta-cohort
# EH1498: Colorectal Cancer (CRC) meta-cohort
nda.brca <- dat[["EH1497"]]
nda.crc <- dat[["EH1498"]]
```

## Data Structure and Metadata
The objects are standard `Biobase::ExpressionSet` objects. You can access expression values with `exprs()` and clinical metadata with `pData()`.

### Survival Variables
Both datasets include standardized survival columns:
- `tev`: Follow-up time (months to event/relapse).
- `evn`: Event indicator (1 = event/relapse, 0 = censored).

### Clinical and Technical Features
- **Colorectal Cancer (CRC):** Includes `stage`, `msi` (microsatellite instability status), and `cms` (consensus molecular subtypes).
- **Breast Cancer (BRCA):** Includes `ER.status`, `PGR.status`, and `HER2.status`.
- **Technical Metrics:** Both datasets include Eklund metrics used during quality control: `pm.med`, `pm.iqr`, `rma.iqr`, and `rna.deg`.

## Typical Workflow

### 1. Accessing Phenotype Data
To perform survival analysis (e.g., using the `survival` package), extract the clinical data:
```r
clinical_crc <- pData(nda.crc)
head(clinical_crc[, c("tev", "evn", "stage", "msi")])
```

### 2. Accessing Expression Data
Expression values are summarized at the gene level (Entrez IDs).
```r
exp_matrix <- exprs(nda.brca)
# Check expression for a specific gene (e.g., ESR1)
esr1_id <- "2099" 
esr1_expression <- exp_matrix[esr1_id, ]
```

### 3. Basic Survival Analysis Example
```r
library(survival)
# Fit a Kaplan-Meier curve based on MSI status in CRC
fit <- survfit(Surv(tev, evn) ~ msi, data = pData(nda.crc))
plot(fit, col = c("red", "blue"), main = "Survival by MSI Status")
```

## Tips
- **Gene Identifiers:** The expression matrices use Entrez IDs as row names. Use annotation packages like `org.Hs.eg.db` if you need to map these to Gene Symbols.
- **Data Filtering:** The CRC dataset contains only Microsatellite Stable (MSS) samples in its final processed form, and the BRCA dataset contains only ER+ samples.
- **Standardization:** Datasets were standardized gene-wise using specific reference cohorts (GSE39582 for CRC and METABRIC for BRCA) to minimize inter-study variability.

## Reference documentation
- [Meta cohort survival data mcsurvdata package](./references/mcsurvdata.Rmd)
- [Meta cohort survival data mcsurvdata package](./references/mcsurvdata.md)