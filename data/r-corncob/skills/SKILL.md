---
name: r-corncob
description: The corncob package models relative abundance and variability in microbiome count data using beta-binomial regression. Use when user asks to perform differential abundance testing, model taxon variability, or analyze overdispersed count data from phyloseq objects.
homepage: https://cran.r-project.org/web/packages/corncob/index.html
---


# r-corncob

## Overview
The `corncob` package provides a suite of tools for modeling relative abundance and variability of count data. It is particularly well-suited for microbiome data where overdispersion and varying sequencing depths are common. It uses a beta-binomial regression framework to allow for both differential abundance and differential variability testing.

## Installation
Install the package from CRAN:
```R
install.packages("corncob")
```

## Core Workflow

### 1. Data Preparation
`corncob` can work with `phyloseq` objects or standard R data frames.
- **Phyloseq**: Pass the `phyloseq` object directly to the `data` argument.
- **Data Frames**: Requires a count table (taxa as rows or columns) and a sample data frame.

### 2. Modeling a Single Taxon
Use `bbdml` to fit a beta-binomial deterministic model to a single taxon.
```R
# formula: model for relative abundance
# phi.formula: model for dispersion (variability)
fit <- bbdml(formula = OTU.1 ~ Condition,
             phi.formula = ~ Condition,
             data = my_phyloseq_object)

# View results
summary(fit)

# Plot model fit
plot(fit, color = "Condition", B = 1000)
```

### 3. Differential Testing Across All Taxa
Use `differentialTest` to perform analysis across all taxa with False Discovery Rate (FDR) control.
```R
da_analysis <- differentialTest(formula = ~ Condition,
                                phi.formula = ~ Condition,
                                formula_null = ~ 1,
                                phi.formula_null = ~ Condition,
                                test = "Wald", 
                                data = my_phyloseq_object,
                                fdr_cutoff = 0.05)

# Significant taxa
da_analysis$significant_taxa

# Plot coefficients for significant taxa
plot(da_analysis)
```

## Key Functions and Parameters

### `bbdml()`
- `formula`: A formula for the mean (abundance). If using data frames, use `cbind(W, M - W) ~ ...` where `W` is the taxon count and `M` is the total count.
- `phi.formula`: A formula for the precision/dispersion (variability).
- `link` and `phi.link`: Link functions (default: "logit").

### `differentialTest()`
- `formula` / `phi.formula`: The full model.
- `formula_null` / `phi.formula_null`: The null model for comparison.
- `test`: "Wald" or "LRT" (Likelihood Ratio Test).
- `taxa_are_rows`: Set to `TRUE` if passing a matrix where rows are taxa.

### `otu_to_taxonomy()`
Converts OTU labels to taxonomic names for easier interpretation.
```R
otu_to_taxonomy(OTU = da_analysis$significant_taxa, data = my_phyloseq_object)
```

## Tips and Best Practices
- **Overdispersion**: `corncob` explicitly models overdispersion. If a model fails to converge, it may be due to extremely sparse data (e.g., a taxon appearing in only one sample).
- **Model Selection**: Use `lrtest(mod_null, mod)` to compare two nested `bbdml` models.
- **Bootstrapping**: In `plot.bbdml`, the parameter `B` controls bootstrap simulations for prediction intervals. Use `B = 1000` for publication-quality plots.
- **Phyloseq Integration**: If using `phyloseq`, ensure you have the package loaded. Use `tax_glom()` to aggregate data to higher taxonomic ranks (e.g., Phylum or Genus) before testing to increase speed and power.

## Reference documentation
- [Introduction to corncob, no phyloseq](./references/corncob-intro-no-phyloseq.Rmd)
- [Introduction to corncob](./references/corncob-intro.Rmd)