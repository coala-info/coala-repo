---
name: bioconductor-metacyto
description: MetaCyto performs meta-analysis on flow and mass cytometry data across multiple studies to identify cell subsets and estimate effect sizes. Use when user asks to perform meta-analysis on cytometry data, standardize marker names across studies, identify cell populations using clustering or marker-based searching, and calculate effect sizes while controlling for batch effects.
homepage: https://bioconductor.org/packages/release/bioc/html/MetaCyto.html
---

# bioconductor-metacyto

## Overview
MetaCyto is designed to perform meta-analysis on cytometry data (Flow and CyTOF) across multiple studies. It standardizes marker names, transforms data, identifies common cell subsets using both unsupervised clustering and supervised searching (marker-based definitions), and applies statistical models to estimate effect sizes across studies while controlling for batch effects and covariates.

## Workflow and Key Functions

### 1. Data Collection and Setup
MetaCyto requires two metadata structures:
- **FCS Info**: A table with `fcs_files` (paths) and `study_id`.
- **Sample Info**: A table with `fcs_files` and sample-level variables (e.g., Age, Gender, Treatment).

For ImmPort datasets, use `fcsInfoParser()` and `sampleInfoParser()` to automate this step.

### 2. Preprocessing
Use `preprocessing.batch` to perform compensation and Arcsinh transformation ($f(x) = asinh(b \cdot x)$).
- **Recommended b values**: $1/150$ for Flow Cytometry (FCM); $1/8$ for CyTOF.
- **Marker Standardization**: Use `panelSummary()` to identify naming inconsistencies and `nameUpdator()` to unify marker names (e.g., changing "CD8B" to "CD8") across all studies.

```r
preprocessing.batch(inputMeta = fcs_info, assay = assay_vec, b = b_vec, outpath = "output_dir")
```

### 3. Identifying Cell Subsets
MetaCyto uses two parallel pipelines:
- **Clustering Pipeline**: `autoCluster.batch()` uses unsupervised methods (default: FlowSOM) to find novel clusters.
- **Searching Pipeline**: Define known populations using marker strings (e.g., `"CD3+|CD4-|CD8+|CCR7+"`).
- **Summary Stats**: `searchCluster.batch()` calculates the proportion and median fluorescence intensity (MFI) for all identified subsets.

```r
# Unsupervised clustering
cluster_labels <- autoCluster.batch(preprocessOutputFolder = "preprocess_output", excludeClusterParameters = c("Time", "DNA1"))

# Add manual definitions
cluster_labels <- c(cluster_labels, "CD3+|CD4+|CD25+")

# Calculate statistics
searchCluster.batch(preprocessOutputFolder = "preprocess_output", outpath = "search_output", clusterLabel = cluster_labels)
```

### 4. Statistical Meta-Analysis
Combine the summary statistics with sample metadata using `collectData()` and `inner_join`.
- **GLM Analysis**: `glmAnalysis()` performs regression (e.g., `fraction ~ Variable + Covariates + study_id`) to find subsets affected by a variable of interest.
- **Meta-Analysis**: `metaAnalysis()` provides detailed effect size estimates and forest plots for a specific cell population across studies.

```r
# General analysis across all clusters
GA <- glmAnalysis(value = "value", variableOfInterst = "Age", parameter = "fraction", 
                  otherVariables = c("Gender"), studyID = "study_id", label = "label", data = all_data)

# Detailed analysis for one population
MA <- metaAnalysis(value = "value", variableOfInterst = "Age", main = "CD3+|CD8+", 
                   otherVariables = c("Gender"), studyID = "study_id", data = subset_data)
```

## Tips for Success
- **Study IDs**: Use informative study IDs (e.g., "SDY123_CyTOF") to help the preprocessing script distinguish between assay types.
- **Marker Names**: Meta-analysis fails if the same marker has different names across studies. Always run `panelSummary` before clustering.
- **Scaling**: In `glmAnalysis`, use `ifScale` to decide whether to scale continuous variables.
- **Visualization**: Use `plotGA()` for a summary of all clusters and `metaAnalysis()` for forest plots of specific populations.

## Reference documentation
- [MetaCyto Vignette](./references/MetaCyto_Vignette.md)