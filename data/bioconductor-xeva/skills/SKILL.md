---
name: bioconductor-xeva
description: The Xeva package provides a standardized framework for analyzing patient-derived xenograft pharmacogenomic data by integrating tumor growth kinetics with molecular profiles. Use when user asks to visualize PDX growth curves, calculate drug response metrics like mRECIST or waterfall plots, identify gene-drug associations, or create XevaSet objects for custom datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/Xeva.html
---


# bioconductor-xeva

## Overview
The `Xeva` package is designed for the efficient analysis of Patient-Derived Xenograft (PDX) pharmacogenomic data. It provides a standardized framework (the `XevaSet` class) to integrate tumor growth kinetics (time vs. volume), metadata (patient and model info), and molecular profiles (RNA-seq, mutation, CNV). Key capabilities include visualizing growth curves, calculating drug sensitivity metrics, and identifying biomarkers through gene-drug association analysis.

## Core Workflows

### 1. Data Loading and Inspection
Load the package and example datasets (like the Novartis PDXE breast cancer data) to explore the structure.
```r
library(Xeva)
data(brca)
print(brca)

# Access model metadata
mod_info <- modelInfo(brca)
head(mod_info)

# Access specific tumor growth data for a model
model_data <- getExperiment(brca, model.id = "X.1004.BG98")
```

### 2. Visualizing Growth Curves
Use `plotPDX` to visualize treatment vs. control arms. You can plot by `batch`, `patient.id`, or include replicates.
```r
# Plot by batch
plotPDX(brca, batch = "X-4567.BKM120")

# Plot normalized volume with custom colors and time limits
plotPDX(brca, batch = "X-4567.BKM120", vol.normal = TRUE, 
        control.col = "#a6611a", treatment.col = "#018571", max.time = 40)

# Plot with replicates using error bars or ribbons
data("repdx")
plotPDX(repdx, batch = "P3", SE.plot = "errorbar")
plotPDX(repdx, batch = "P4", vol.normal = TRUE, SE.plot = "ribbon")
```

### 3. Quantifying Drug Response
Xeva supports multiple response metrics, including mRECIST, waterfall plots, and statistical modeling.
```r
# Summarize mRECIST values
mr_res <- summarizeResponse(brca, response.measure = "mRECIST")

# Create a waterfall plot
waterfall(brca, drug="binimetinib", res.measure="best.average.response")

# Calculate response using Angle or Linear Mixed-effects Models (LMM)
response(repdx, batch="P1", res.measure="angle")
response(repdx, batch="P1", res.measure="lmm")
```

### 4. Gene-Drug Association
Identify biomarkers by correlating molecular features with drug sensitivity.
```r
# Compute association between RNASeq and drug slope using linear regression
sig <- drugSensitivitySig(object=brca, drug="tamoxifen", mDataType="RNASeq", 
                          features=c(1:5), sensitivity.measure="slope", fit="lm")

# Use different fit methods like Pearson correlation
sig_pearson <- drugSensitivitySig(object=brca, drug="tamoxifen", mDataType="RNASeq",
                                  features=c(1:5), sensitivity.measure="best.average.response", 
                                  fit="pearson")
```

### 5. Creating New XevaSet Objects
To analyze custom data, use `createXevaSet`. You need data frames for models, drugs, experiments, and a list for molecular profiles.
```r
xeva.set <- createXevaSet(name="my_study", 
                          model=model_df, 
                          drug=drug_df, 
                          experiment=experiment_df, 
                          expDesign=batch_list, 
                          molecularProfiles=list(RNASeq = eset_object), 
                          modToBiobaseMap = mapping_df)
```

## Tips and Best Practices
- **Batch Structure**: A `batch` in Xeva typically consists of a control arm and one or more treatment arms originating from the same patient.
- **Parallel Computing**: For large-scale gene-drug associations, use the `nthread` parameter in `drugSensitivitySig` to speed up calculations.
- **Molecular Mapping**: Ensure the `modToBiobaseMap` correctly links `model.id` from the experiment data to the sample names in the `molecularProfiles` (ExpressionSet) objects.
- **Visualization**: When using `waterfall`, you can color bars by genomic properties (e.g., mutation status) by passing a named vector to `model.type`.

## Reference documentation
- [Xeva](./references/Xeva.md)