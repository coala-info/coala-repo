---
name: bioconductor-rtcga.pancan12
description: This package provides a unified collection of clinical, expression, and mutation data from the Pan-Cancer 12 project for analysis within the RTCGA ecosystem. Use when user asks to load Pan-Cancer 12 datasets, merge clinical and genomic data for survival analysis, or visualize expression patterns across multiple tumor types.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RTCGA.PANCAN12.html
---


# bioconductor-rtcga.pancan12

## Overview
The `RTCGA.PANCAN12` package provides a unified collection of data from the Pan-Cancer 12 project, which analyzed 12 different tumor types to identify commonalities and differences across cancer lineages. This skill facilitates the loading, merging, and visualization of clinical, expression, and mutation data specifically formatted for the `RTCGA` ecosystem.

## Key Workflows

### Loading and Preparing Data
The Pan-Cancer 12 data is split into specific objects. Expression data is often split into two parts due to size.

```r
library(RTCGA.PANCAN12)

# Combine expression datasets
expression.cb <- rbind(expression.cb1, expression.cb2)

# Access clinical and mutation data
# clinical.cb
# mutation.cb
```

### Extracting Specific Features
Use `grep` to find specific genes within the expression or mutation matrices.

```r
# Extract MDM2 Expression
mdm2_idx <- grep("MDM2", expression.cb[,1])
MDM2v <- t(expression.cb[mdm2_idx, -1])

# Extract TP53 Mutations (0/1 coding)
tp53_idx <- grep("TP53$", mutation.cb[,1])
TP53v <- t(mutation.cb[tp53_idx, -1])
```

### Merging Datasets for Analysis
To perform survival analysis or correlation studies, merge clinical data with genomic features. Note that clinical data uses hyphens (`-`) while genomic data uses dots (`.`) in barcodes; these must be aligned.

```r
# Clean barcodes and select clinical variables
dfC <- data.frame(
  names = gsub("-", ".", clinical.cb[,1]), 
  clinical.cb[, c("X_cohort", "X_TIME_TO_EVENT", "X_EVENT")]
)

# Create data frames for merging
dfT <- data.frame(names = rownames(TP53v), TP53 = factor(TP53v))
dfM <- data.frame(names = rownames(MDM2v), MDM2 = MDM2v)

# Merge into a master analysis frame
dfTMC <- merge(merge(dfT, dfM), dfC)
colnames(dfTMC) <- c("barcode", "TP53", "MDM2", "cohort", "time", "event")
```

### Visualization and Survival Analysis
The package works seamlessly with `ggplot2` and `RTCGA` visualization functions.

```r
library(ggplot2)
library(survival)

# Boxplot of expression across cohorts
ggplot(dfTMC, aes(x = cohort, y = MDM2)) + 
  geom_boxplot() + 
  coord_flip()

# Survival analysis by mutation status
survp <- survfit(Surv(time/365, event) ~ TP53, data = dfTMC, subset = cohort == "TCGA Breast Cancer")
plot(survp)
```

## Tips for RTCGA Integration
- **Cohort Names**: Use `infoTCGA()` from the base `RTCGA` package to see available cohort abbreviations.
- **Sample Types**: Barcodes ending in `01` typically represent primary solid tumors. Use `filter(substr(barcode, 14, 15) == "01")` to isolate them.
- **Tidy Data**: Use `expressionsTCGA()` or `mutationsTCGA()` from the `RTCGA` package to gather data from multiple cohorts into a tidy format before plotting.

## Reference documentation
- [Quick Data Download Guide](./references/Data_Download.Rmd)
- [RTCGA package workflow](./references/RTCGA_Workflow.Rmd)
- [Visualizations](./references/Visualizations.Rmd)
- [Using RTCGA.PANCAN12 package](./references/pancan12.md)