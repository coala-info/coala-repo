---
name: bioconductor-phenstat
description: PhenStat performs statistical analysis of phenotypic data from high-throughput pipelines to identify significant differences between control and experimental groups. Use when user asks to analyze knockout mouse phenotyping data, account for sex or weight effects in phenotypic studies, or apply linear mixed models and Fisher's exact tests to biological datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/PhenStat.html
---


# bioconductor-phenstat

name: bioconductor-phenstat
description: Statistical analysis of phenotypic data from high-throughput pipelines. Use when analyzing knockout mouse phenotyping data (e.g., IMPC) to identify significant differences between control and experimental groups. Supports Linear Mixed Models (MM), Fisher's Exact Test (FE), and Reference Range Plus (RR) frameworks, accounting for sex, weight, and batch effects.

# bioconductor-phenstat

## Overview
PhenStat provides a complete framework for the statistical analysis of phenotypic data. It is specifically designed to handle the complexities of large-scale phenotyping projects, such as sexual dimorphism, body weight dependencies, and temporal batch effects. The package automates the selection of appropriate statistical methods based on the data type (continuous or categorical) and distribution.

## Core Workflow

### 1. Data Preparation and Loading
Data must be structured with columns for Genotype, Sex, and the dependent variable. Optional columns include Weight and Batch.

```r
library(PhenStat)

# Load data into a PhenList object
# dataset: data frame containing the phenodeviant data
# testGenotype: the label used for the experimental group (e.g., "Mutant")
# refGenotype: the label for the control group (default is "Control")
phenList <- PhenList(dataset = my_data, 
                     testGenotype = "Mutant",
                     refGenotype = "WT",
                     dataset.clean = TRUE)
```

### 2. Statistical Analysis
The `testDataset` function is the primary interface for running analyses. It automatically detects the data type and applies the default method (Linear Mixed Model for continuous data).

```r
# Perform analysis on a continuous variable (e.g., "Bone.Mineral.Density")
result <- testDataset(phenList, 
                      depVariable = "Bone.Mineral.Density", 
                      method = "MM")

# Perform analysis on a categorical variable (e.g., "Heart.Morphology")
result_cat <- testDataset(phenList, 
                          depVariable = "Heart.Morphology", 
                          method = "FE")
```

### 3. Interpreting Results
PhenStat provides tools to extract p-values, effect sizes, and automated classification tags.

```r
# View a summary of the statistical output
summary(result)

# Get the classification tag (e.g., "Sexual Dimorphism", "Main Genotype Effect")
classificationTag(result)

# Extract specific p-values
result$analysisResults$model.output.genotype.nulltest.pVal
```

### 4. Visualization
Generate diagnostic and summary plots to validate model assumptions.

```r
# Boxplot of the dependent variable by genotype and sex
plot(phenList, depVariable = "Bone.Mineral.Density")

# Diagnostic plots for the Mixed Model (residuals, normality)
plot(result)
```

## Advanced Usage and Parameters

### Method Selection
- **MM (Mixed Model)**: Default for continuous data. Accounts for batch as a random effect and weight as a covariate.
- **FE (Fisher's Exact Test)**: Used for categorical/qualitative data.
- **RR (Reference Range Plus)**: Used for continuous data that does not follow a normal distribution and cannot be transformed.

### Equation Selection (MM Method)
Control how weight is handled in the model:
- `equation = "withWeight"`: Includes body weight as a covariate.
- `equation = "withoutWeight"`: Excludes body weight.

### Handling Batch Effects
If your data contains a "Batch" column, PhenStat will treat it as a random effect in the Mixed Model to account for temporal variation in measurements.

## Tips for Success
- **Column Naming**: Ensure your input data frame uses standard names or map them using the `PhenList` arguments (e.g., `columnName.Sex`, `columnName.Batch`).
- **Data Cleaning**: Use `dataset.clean = TRUE` in `PhenList` to automatically remove records with missing Genotype or Sex values.
- **Transformation**: For skewed continuous data, consider log transformation before creating the `PhenList` object, or use the `method = "RR"` approach.
- **Large Datasets**: When processing multiple phenotypes, wrap `testDataset` in a loop or `lapply`, but ensure you check the model convergence for each variable.

## Reference documentation
- [PhenStat Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/PhenStat.html)