---
name: bioconductor-dar
description: The dar package provides a recipe-based framework for performing and aggregating multiple differential abundance analysis methods on microbiome data. Use when user asks to perform differential abundance analysis, identify microbial biomarkers using consensus strategies, or compare results from multiple statistical methods like ALDEx2, ANCOM-BC, and DESeq2.
homepage: https://bioconductor.org/packages/release/bioc/html/dar.html
---

# bioconductor-dar

## Overview

The `dar` package provides a "recipe-based" framework for differential abundance (DA) analysis of microbiome data. It streamlines the process of applying multiple statistical methods to the same dataset to find a consensus of microbial biomarkers. By using a `recipe` object, users can sequentially define preprocessing steps (filtering, subsetting) and DA methods (ALDEx2, ANCOM-BC, corncob, DESeq2, Lefse, Maaslin2, MetagenomeSeq, and Wilcoxon), execute them in parallel, and extract results based on consensus strategies.

## Typical Workflow

### 1. Recipe Initialization
Start by creating a recipe object from a `phyloseq` or `TreeSummarizedExperiment` (TSE) object. You must specify the categorical variable of interest and the taxonomic rank.

```r
library(dar)
data("metaHIV_phy")

# Initialize recipe
rec <- recipe(metaHIV_phy, var_info = "RiskGroup2", tax_info = "Species")
```

### 2. Quality Control and Preprocessing
Use `phy_qc()` to inspect data metrics (sparsity, singletons) before adding preprocessing steps.

```r
# Check data quality
phy_qc(rec)

# Add preprocessing steps
rec <- rec |>
  step_subset_taxa(tax_level = "Kingdom", taxa = c("Bacteria", "Archaea")) |>
  step_filter_by_prevalence(threshold = 0.01) |>
  step_rarefaction()
```

### 3. Defining DA Methods
Add multiple DA methods to the recipe. You can customize parameters for each method within the `step_*` functions.

```r
rec <- rec |>
  step_deseq() |>
  step_maaslin(min_prevalence = 0) |>
  step_metagenomeseq(rm_zeros = 0.01) |>
  step_aldex()
```

### 4. Execution (Prep)
Execute all defined steps. Use `parallel = TRUE` to speed up computation.

```r
da_results <- prep(rec, parallel = TRUE)
# Printing the object shows a summary of significant taxa per method
print(da_results)
```

### 5. Consensus Strategy (Bake & Cool)
Define how to aggregate results (e.g., taxa found in at least N methods) and extract the final table.

```r
# Define consensus: taxa must be present in all DA methods
count <- length(steps_ids(da_results, type = "da"))
da_results <- bake(da_results, count_cutoff = count)

# Extract final results
final_taxa <- cool(da_results)
```

## Visualization
The package includes several functions to explore method overlaps and abundance:

- `intersection_plt(da_results)`: UpSet plot showing overlaps between methods.
- `corr_heatmap(da_results)`: Heatmap of significant OTU overlaps.
- `mutual_plt(da_results)`: Direction of effect for mutually found features.
- `abundance_plt(da_results, taxa_ids = ids, type = "boxplot")`: Visualize abundance differences for specific taxa.

## Tips
- **Data Import**: If your data is in BIOM, QIIME, or Mothur format, use `phyloseq` or `mia` import functions to convert them to `phyloseq` or `TSE` before calling `recipe()`.
- **Method Selection**: It is recommended to use multiple methods to ensure robust biomarker discovery.
- **IDs**: Every step is assigned a unique ID (e.g., `metagenomeseq__Chouquette`). You can use these IDs to exclude specific methods during the `bake()` phase.

## Reference documentation
- [Main Package Introduction](./references/dar.md)
- [Bioinformatics Workflow Vignette](./references/bioinformatics_vignette.md)
- [Data Import Guide](./references/data_import.md)
- [Filtering and Subsetting Details](./references/filtering_subsetting.md)
- [Recipe Import and Export](./references/import_export_recipes.md)
- [Case Study Article](./references/article.md)