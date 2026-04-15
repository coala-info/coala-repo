---
name: bioconductor-enmix
description: This package provides a comprehensive toolset for the analysis and quality control of Illumina DNA methylation beadchip data. Use when user asks to perform quality control, background correction, dye-bias adjustment, probe-type bias adjustment, cell type estimation, methylation age calculation, or differentially methylated region analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/ENmix.html
---

# bioconductor-enmix

name: bioconductor-enmix
description: Comprehensive toolset for Illumina DNA methylation beadchip data analysis. Use when Claude needs to perform quality control, background correction (ENmix), dye-bias correction (RELIC), probe-type bias adjustment (RCP), cell type estimation, methylation age calculation, or differentially methylated region (DMR) analysis for 450k, EPIC, or EPICv2 arrays.

# bioconductor-enmix

## Overview

The ENmix package provides a robust suite of tools for the analysis of Illumina Methylation Beadchips. It excels at removing experimental noise through specialized background correction and probe-type bias adjustment (RCP). It supports large-scale data analysis with multi-processor parallel computing and is compatible with other major Bioconductor packages like minfi, ChAMP, and wateRmelon.

## Data Acquisition and Classes

ENmix uses two primary data classes:
- `rgDataSet`: Contains raw intensity data (red/green channels) and internal control probes.
- `methDataSet`: Contains methylated and unmethylated intensity values organized by CpG.

### Loading Data
Use `readidat()` to import raw .idat files. It is recommended to provide the Illumina manifest file for newer arrays like EPICv2 or mouse Beadchips.

```r
library(ENmix)
# Read idat files from a directory
rgSet <- readidat(path = "path/to/idat", recursive = TRUE)

# Read with a specific manifest
rgSet <- readidat(path = "path/to/idat", manifestfile = "manifest.csv")
```

## Quality Control Workflow

1. **Internal Control Plots**: Use `plotCtrl()` to inspect experimental quality (bisulfite conversion, staining, etc.).
2. **Extract QC Info**: Use `QCinfo()` to identify low-quality samples, probes, and outliers based on detection P-values and intensities.
3. **Visualize Distribution**: Use `multifreqpoly()` for fast frequency polygon plots to identify outlier samples and observe probe-type differences.

```r
# Generate QC metrics
qc <- QCinfo(rgSet, detPtype = "negative", detPthre = 0.000001)

# View bad samples/probes
qc$badsample
qc$badCpG

# Plot distributions
mraw <- getmeth(rgSet)
multifreqpoly(assays(mraw)$Meth + assays(mraw)$Unmeth, xlab = "Total intensity")
```

## Preprocessing

### The Pipeline Approach
Use `mpreprocess()` for a single-command pipeline covering background correction, dye-bias adjustment, normalization, and probe-type bias correction.

```r
beta <- mpreprocess(rgSet, nCores = 6, qc = TRUE, fqcfilter = TRUE, impute = TRUE)
```

### The Step-by-Step Approach
For more control, execute functions sequentially:

1. **Background and Dye Correction**: `preprocessENmix()` using the "oob" (out-of-band) method and "RELIC" for dye bias.
2. **Inter-array Normalization**: `norm.quantile()`.
3. **Probe-type Bias Adjustment**: `rcp()` (Regression on Correlated Probes) to calibrate Type II probes using Type I referents.
4. **Filtering and Imputation**: `qcfilter()` to remove outliers and fill missing values via k-nearest neighbors.

```r
# 1. Background/Dye correction
mdat <- preprocessENmix(rgSet, bgParaEst = "oob", dyeCorr = "RELIC", QCinfo = qc, nCores = 6)

# 2. Normalization
mdat <- norm.quantile(mdat, method = "quantile1")

# 3. RCP adjustment
beta <- rcp(mdat, qcscore = qc)

# 4. Final filtering and imputation
beta <- qcfilter(beta, qcscore = qc, rmcr = TRUE, impute = TRUE)
```

## Downstream Analysis Tools

- **Cell Type Estimation**: Use `estimateCellProp()` with reference datasets (e.g., "FlowSorted.Blood.450k").
- **Methylation Age/Scores**: Use `methyAge()` for biological age or `methscore()` for 150+ predictors.
- **Sex Prediction**: Use `predSex()` based on X and Y chromosome intensities.
- **DMR Analysis**: Use `ipdmr()` or `combp()` to identify differentially methylated regions from EWAS P-values.
- **Batch Effect Detection**: Use `pcrplot()` to perform principal component regression against known covariates (e.g., batch, slide).
- **Batch Correction**: Use `ctrlsva()` to derive surrogate variables from internal control probes.

```r
# Estimate cell proportions
celltype <- estimateCellProp(userdata = beta, refdata = "FlowSorted.Blood.450k")

# Calculate methylation age
mage <- methyAge(beta)

# Predict sex
sex <- predSex(mdat)
```

## Tips for Success

- **Parallelization**: Most functions support `nCores`. Set this to the number of available CPU cores to significantly speed up processing.
- **EPIC v2 Support**: For EPIC v2 arrays, use `rm.cgsuffix()` to combine duplicated CpGs after preprocessing.
- **Missing Values**: PCA-based functions like `pcrplot()` do not allow missing values; ensure `impute = TRUE` is used in `qcfilter()`.
- **Detection P-values**: If using `detPtype = "negative"`, use a stringent threshold (e.g., 10E-6). For `detPtype = "oob"`, 0.01 or 0.05 is usually sufficient.

## Reference documentation
- [ENmix](./references/ENmix.md)