# tidybulk: An R tidy framework for modular transcriptomic data analysis

Stefano Mangiola

#### 2025-11-13

#### Package

tidybulk 2.0.1

[![Lifecycle:maturing](data:image/svg+xml;charset=utf-8;base64...)](https://www.tidyverse.org/lifecycle/#maturing)
[![R build status](data:image/svg+xml; charset=utf-8;base64...)](https://github.com/stemangiola/tidybulk/actions/)
[![Bioconductor status](data:image/svg+xml;base64...)](https://bioconductor.org/checkResults/release/bioc-LATEST/tidybulk/)

**tidybulk** is a powerful R package designed for modular transcriptomic data analysis that brings transcriptomics to the tidyverse.

## 0.1 Why tidybulk?

Tidybulk provides a unified interface for comprehensive transcriptomic data analysis with seamless integration of SummarizedExperiment objects and tidyverse principles. It streamlines the entire workflow from raw data to biological insights.

## 0.2 Functions/utilities available

### 0.2.1 Abundance Normalization Functions

| Function | Description |
| --- | --- |
| `scale_abundance()` | Scale abundance data |
| `quantile_normalise_abundance()` | Quantile normalization |
| `adjust_abundance()` | Adjust abundance for unwanted variation |
| `fill_missing_abundance()` | Fill missing abundance values |
| `impute_missing_abundance()` | Impute missing abundance values |

### 0.2.2 Filtering and Selection Functions

| Function | Description |
| --- | --- |
| `identify_abundant()` | Identify abundant transcripts without removing them |
| `keep_abundant()` | Keep abundant transcripts |
| `keep_variable()` | Keep variable transcripts |
| `filterByExpr()` | Filter by expression |

### 0.2.3 Dimensionality Reduction Functions

| Function | Description |
| --- | --- |
| `reduce_dimensions()` | Reduce dimensions with PCA/MDS/tSNE/UMAP |
| `rotate_dimensions()` | Rotate dimensions |
| `remove_redundancy()` | Remove redundant features |

### 0.2.4 Clustering Functions

| Function | Description |
| --- | --- |
| `cluster_elements()` | Cluster elements with various methods |
| `kmeans clustering` | K-means clustering |
| `SNN clustering` | Shared nearest neighbor clustering |
| `hierarchical clustering` | Hierarchical clustering |
| `DBSCAN clustering` | Density-based clustering |

### 0.2.5 Differential Analysis Functions

| Function | Description |
| --- | --- |
| `test_differential_expression()` | Test differential expression with various methods |

### 0.2.6 Cellularity Analysis Functions

| Function | Description |
| --- | --- |
| `deconvolve_cellularity()` | Deconvolve cellularity with various methods |
| `cibersort()` | CIBERSORT analysis |

### 0.2.7 Gene Enrichment Functions

| Function | Description |
| --- | --- |
| `test_gene_enrichment()` | Test gene enrichment |
| `test_gene_overrepresentation()` | Test gene overrepresentation |
| `test_gene_rank()` | Test gene rank |

### 0.2.8 Utility Functions

| Function | Description |
| --- | --- |
| `describe_transcript()` | Describe transcript characteristics |
| `get_bibliography()` | Get bibliography |
| `resolve_complete_confounders_of_non_interest()` | Resolve confounders |

### 0.2.9 Validation and Utility Functions

| Function | Description |
| --- | --- |
| `check_if_counts_is_na()` | Check if counts contain NA values |
| `check_if_duplicated_genes()` | Check for duplicated genes |
| `check_if_wrong_input()` | Validate input data |
| `log10_reverse_trans()` | Log10 reverse transformation |
| `logit_trans()` | Logit transformation |

All functions are directly compatible with `SummarizedExperiment` objects and follow tidyverse principles for seamless integration with the tidyverse ecosystem.

### 0.2.10 Scientific Citation

Mangiola, Stefano, Ramyar Molania, Ruining Dong, Maria A. Doyle, and Anthony T. Papenfuss. 2021. “Tidybulk: An R tidy framework for modular transcriptomic data analysis.” Genome Biology 22 (42). <https://doi.org/10.1186/s13059-020-02233-7>

[Genome Biology - tidybulk: an R tidy framework for modular transcriptomic data analysis](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-020-02233-7)

# 1 Full vignette

[HERE](https://stemangiola.github.io/tidybulk/)

# 2 Installation Guide

**Bioconductor**

```
if (!requireNamespace("BiocManager")) install.packages("BiocManager")
BiocManager::install("tidybulk")
```

**Github**

```
devtools::install_github("stemangiola/tidybulk")
```

In this vignette we will use the `airway` dataset, a `SummarizedExperiment` object containing RNA-seq data from an experiment studying the effect of dexamethasone treatment on airway smooth muscle cells. This dataset is available in the [airway](https://bioconductor.org/packages/airway/) package.

```
library(airway)
data(airway)
```

This workflow, will use the [tidySummarizedExperiment](https://bioconductor.org/packages/tidySummarizedExperiment/) package to manipulate the data in a `tidyverse` fashion. This approach streamlines the data manipulation and analysis process, making it more efficient and easier to understand.

```
library(tidySummarizedExperiment)
```

Here we will add a gene symbol column to the `airway` object. This will be used to interpret the differential expression analysis, and to deconvolve the cellularity.

```
library(org.Hs.eg.db)
```

```
## Loading required package: AnnotationDbi
```

```
##
## Attaching package: 'AnnotationDbi'
```

```
## The following object is masked from 'package:dplyr':
##
##     select
```

```
##
```

```
library(AnnotationDbi)

# Add gene symbol and entrez
airway <-
  airway |>

  mutate(entrezid = mapIds(org.Hs.eg.db,
                                      keys = gene_name,
                                      keytype = "SYMBOL",
                                      column = "ENTREZID",
                                      multiVals = "first"
))
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
detach("package:org.Hs.eg.db", unload = TRUE)
detach("package:AnnotationDbi", unload = TRUE)
```

```
## Warning: 'AnnotationDbi' namespace cannot be unloaded:
##   namespace 'AnnotationDbi' is imported by 'annotate', 'genefilter' so cannot be unloaded
```

# 3 Comprehensive Example Pipeline

This vignette demonstrates a complete transcriptomic analysis workflow using tidybulk, with special emphasis on differential expression analysis.

## 3.1 Data Overview

We will use the `airway` dataset, a `SummarizedExperiment` object containing RNA-seq data from an experiment studying the effect of dexamethasone treatment on airway smooth muscle cells:

```
airway
```

```
## class: RangedSummarizedExperiment
## dim: 63677 8
## metadata(2): '' latest_mutate_scope_report
## assays(1): counts
## rownames(63677): ENSG00000000003 ENSG00000000005 ... ENSG00000273492
##   ENSG00000273493
## rowData names(10): gene_id gene_name ... seq_coord_system symbol
## colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
## colData names(9): SampleName cell ... Sample BioSample
```

Loading `tidySummarizedExperiment` makes the `SummarizedExperiment` objects compatible with tidyverse tools while maintaining its `SummarizedExperiment` nature. This is useful because it allows us to use the `tidyverse` tools to manipulate the data.

```
class(airway)
```

```
## [1] "RangedSummarizedExperiment"
## attr(,"package")
## [1] "SummarizedExperiment"
```

### 3.1.1 Prepare Data for Analysis

Before analysis, we need to ensure our variables are in the correct format:

```
# Convert dex to factor for proper differential expression analysis
airway = airway |>
  mutate(dex = as.factor(dex))
```

### 3.1.2 Visualize Raw Counts

Visualize the distribution of raw counts before any filtering:

```
airway |>
  ggplot(aes(counts + 1, group = .sample, color = dex)) +
  geom_density() +
  scale_x_log10() +
  my_theme +
  labs(title = "Raw counts by treatment (before any filtering)")
```

![](data:image/png;base64...)

## 3.2 Step 1: Data Preprocessing

### 3.2.1 Aggregate Duplicated Transcripts (optional)

Aggregate duplicated transcripts (e.g., isoforms, ensembl IDs):

> Transcript aggregation is a standard bioinformatics approach for gene-level summarization.

```
# Aggregate duplicates
airway = airway |> aggregate_duplicates(feature = "gene_name", aggregation_function = mean)
```

### 3.2.2 Abundance Filtering

Abundance filtering can be performed using established methods (Robinson, McCarthy, and Smyth [2010](#ref-robinson2010edger); Chen, Lun, and Smyth [2016](#ref-chen2016edgeR)).

#### 3.2.2.1 Run multiple methods

```
# Default (simple filtering)
airway_abundant_default = airway |> keep_abundant(minimum_counts = 10, minimum_proportion = 0.5)
```

```
## Warning in filterByExpr.DGEList(y, design = design, group = group, lib.size =
## lib.size, : All samples appear to belong to the same group.
```

```
# With factor_of_interest (recommended for complex designs)
airway_abundant_formula = airway |> keep_abundant(minimum_counts = 10, minimum_proportion = 0.5, factor_of_interest = dex)
```

```
## Warning: The `factor_of_interest` argument of `keep_abundant()` is deprecated as of
## tidybulk 2.0.0.
## ℹ Please use the `formula_design` argument instead.
## ℹ The argument 'factor_of_interest' is deprecated and will be removed in a
##   future release. Please use the 'design' or 'formula_design' argument instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
# With CPM threshold (using design parameter)
airway_abundant_cpm = airway |> keep_abundant(minimum_count_per_million  = 10, minimum_proportion = 0.5, factor_of_interest = dex)
```

#### 3.2.2.2 Compare methods

```
# Example: summary for default tidybulk filtering
# Before filtering
airway |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)
```

```
## tidySummarizedExperiment says: A data frame is returned for independent data analysis.
```

```
## # A tibble: 1 × 4
##   n_features min_count median_count max_count
##        <int>     <int>        <int>     <int>
## 1     113276        NA           NA        NA
```

```
# After filtering
airway_abundant_default |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)
```

```
## tidySummarizedExperiment says: A data frame is returned for independent data analysis.
```

```
## # A tibble: 1 × 4
##   n_features min_count median_count max_count
##        <int>     <int>        <int>     <int>
## 1      28240        NA           NA        NA
```

```
airway_abundant_formula |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)
```

```
## tidySummarizedExperiment says: A data frame is returned for independent data analysis.
```

```
## # A tibble: 1 × 4
##   n_features min_count median_count max_count
##        <int>     <int>        <int>     <int>
## 1      31580        NA           NA        NA
```

```
airway_abundant_cpm |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)
```

```
## tidySummarizedExperiment says: A data frame is returned for independent data analysis.
```

```
## # A tibble: 1 × 4
##   n_features min_count median_count max_count
##        <int>     <int>        <int>     <int>
## 1      18376        NA           NA        NA
```

```
# Merge all methods into a single tibble
airway_abundant_all =
  bind_rows(
    airway |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "no filter"),
    airway_abundant_default |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "default"),
    airway_abundant_formula |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "formula"),
    airway_abundant_cpm |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "cpm")
  )

# Density plot across methods
airway_abundant_all |>
  ggplot(aes(counts + 1, group = .sample, color = method)) +
    geom_density() +
    scale_x_log10() +
    facet_wrap(~fct_relevel(method, "no filter", "default", "formula", "cpm")) +
    my_theme +
    labs(title = "Counts after abundance filtering (tidybulk default)")
```

![](data:image/png;base64...)

Update the `airway` object with the filtered data:

```
airway = airway_abundant_formula
```

> **Tip:** Use `formula_design` for complex designs, and use the CPM threshold for library-size-aware filtering.

### 3.2.3 Remove Redundant Transcripts

Redundancy removal is a standard approach for reducing highly correlated features.

```
airway_non_redundant =
  airway |>
  remove_redundancy(method = "correlation", top = 100, of_samples = FALSE)
```

```
## Getting the 100 most variable genes
```

```
  # Make

airway |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)
```

```
## tidySummarizedExperiment says: A data frame is returned for independent data analysis.
```

```
## Warning in check_se_dimnames(se): tidySummarizedExperiment says: the assays in
## your SummarizedExperiment have row names, but they don't agree with the row
## names of the SummarizedExperiment object itself. It is strongly recommended to
## make the assays consistent, to avoid erroneous matching of features.
```

```
## # A tibble: 1 × 4
##   n_features min_count median_count max_count
##        <int>     <int>        <int>     <int>
## 1      31580        NA           NA        NA
```

```
# Summary statistics
airway_non_redundant |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)
```

```
## tidySummarizedExperiment says: A data frame is returned for independent data analysis.
```

```
## Warning in check_se_dimnames(se): tidySummarizedExperiment says: the assays in
## your SummarizedExperiment have row names, but they don't agree with the row
## names of the SummarizedExperiment object itself. It is strongly recommended to
## make the assays consistent, to avoid erroneous matching of features.
```

```
## # A tibble: 1 × 4
##   n_features min_count median_count max_count
##        <int>     <int>        <int>     <int>
## 1      31578        NA           NA        NA
```

```
# Plot before and after
# Merge before and after into a single tibble
airway_all = bind_rows(
  airway |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |>  mutate(method = "before"),
  airway_non_redundant |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |>  mutate(method = "after")
)

# Density plot
airway_all |>
  ggplot(aes(counts + 1, group = .sample, color = method)) +
  geom_density() +
  scale_x_log10() +
  facet_wrap(~fct_relevel(method, "before", "after")) +
  my_theme +
  labs(title = "Counts after removing redundant transcripts")
```

![](data:image/png;base64...)

### 3.2.4 Filter Variable Transcripts

Keep only the most variable transcripts for downstream analysis.

Variance-based feature selection using edgeR methodology (Robinson, McCarthy, and Smyth [2010](#ref-robinson2010edger)) is used for selecting informative features.

```
airway_variable = airway |> keep_variable()
```

```
## Getting the 500 most variable genes
```

### 3.2.5 Visualize After Variable Filtering Variable Transcripts (optional)

```
# Before filtering
airway |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)
```

```
## tidySummarizedExperiment says: A data frame is returned for independent data analysis.
```

```
## Warning in check_se_dimnames(se): tidySummarizedExperiment says: the assays in
## your SummarizedExperiment have row names, but they don't agree with the row
## names of the SummarizedExperiment object itself. It is strongly recommended to
## make the assays consistent, to avoid erroneous matching of features.
```

```
## # A tibble: 1 × 4
##   n_features min_count median_count max_count
##        <int>     <int>        <int>     <int>
## 1      31580        NA           NA        NA
```

```
# After filtering
airway_variable |> summarise(
  n_features = n_distinct(.feature),
  min_count = min(counts),
  median_count = median(counts),
  max_count = max(counts)
)
```

```
## tidySummarizedExperiment says: A data frame is returned for independent data analysis.
```

```
## Warning in check_se_dimnames(se): tidySummarizedExperiment says: the assays in
## your SummarizedExperiment have row names, but they don't agree with the row
## names of the SummarizedExperiment object itself. It is strongly recommended to
## make the assays consistent, to avoid erroneous matching of features.
```

```
## # A tibble: 1 × 4
##   n_features min_count median_count max_count
##        <int>     <int>        <int>     <int>
## 1       1000        NA           NA        NA
```

```
# Density plot
# Merge before and after into a single tibble
airway_all = bind_rows(
  airway |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "before"),
  airway_variable |> assay() |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "after")
)

# Density plot
airway_all |>
  ggplot(aes(counts + 1, group = .sample, color = method)) +
  geom_density() +
  scale_x_log10() +
  facet_wrap(~fct_relevel(method, "before", "after")) +
  my_theme +
  labs(title = "Counts after variable filtering")
```

![](data:image/png;base64...)

### 3.2.6 Scale Abundance

Scale for sequencing depth using TMM (Robinson, McCarthy, and Smyth [2010](#ref-robinson2010edger)), upper quartile (Bullard et al. [2010](#ref-bullard2010uq)), and RLE (Anders and Huber [2010](#ref-anders2010rle)) normalization.

```
airway =
airway |>
    scale_abundance(method = "TMM", suffix = "_tmm") |>
    scale_abundance(method = "upperquartile", suffix = "_upperquartile") |>
    scale_abundance(method = "RLE", suffix = "_RLE")
```

```
## tidybulk says: the sample with largest library size SRR1039517 was chosen as reference for scaling
## tidybulk says: the sample with largest library size SRR1039517 was chosen as reference for scaling
## tidybulk says: the sample with largest library size SRR1039517 was chosen as reference for scaling
```

### 3.2.7 Visualize After Scaling

```
# Before scaling
airway |> assay("counts") |> as.matrix() |> rowMeans() |> summary()
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
##      7.38     70.50    315.25   1349.47    961.47 328812.62
```

```
airway |> assay("counts_tmm") |> as.matrix() |> rowMeans() |> summary()
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
##     10.50     95.82    432.54   1848.78   1315.63 457450.72
```

```
airway |> assay("counts_upperquartile") |> as.matrix() |> rowMeans() |> summary()
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
##     10.47     97.16    438.49   1871.36   1331.12 462648.85
```

```
airway |> assay("counts_RLE") |> as.matrix() |> rowMeans() |> summary()
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
##     10.45     95.61    431.75   1845.81   1313.26 456675.06
```

```
# Merge all methods into a single tibble
airway_scaled_all = bind_rows(
  airway |> assay("counts") |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "no_scaling"),
  airway |> assay("counts_tmm") |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "TMM"),
  airway |> assay("counts_upperquartile") |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "upperquartile"),
  airway |> assay("counts_RLE") |> as_tibble(rownames = ".feature") |> pivot_longer(cols = -.feature, names_to = ".sample", values_to = "counts") |> mutate(method = "RLE")
)

# Density plot
airway_scaled_all |>
  ggplot(aes(counts + 1, group = .sample, color = method)) +
  geom_density() +
  scale_x_log10() +
  facet_wrap(~fct_relevel(method, "no_scaling", "TMM", "upperquartile", "RLE")) +
  my_theme +
  labs(title = "Scaled counts by method (after scaling)")
```

![](data:image/png;base64...)

## 3.3 Step 2: Exploratory Data Analysis

### 3.3.1 Remove Zero-Variance Features (required for PCA)

Variance filtering is a standard preprocessing step for dimensionality reduction.

```
library(matrixStats)
# Remove features with zero variance across samples
airway = airway[rowVars(assay(airway)) > 0, ]
```

### 3.3.2 Dimensionality Reduction

MDS (Kruskal [1964](#ref-kruskal1964mds)) using limma::plotMDS (**???**) and PCA (Hotelling [1933](#ref-hotelling1933pca)) are used for dimensionality reduction.

```
airway = airway |>
  reduce_dimensions(method="MDS", .dims = 2)
```

```
## Getting the 500 most variable genes
```

```
## [1] "MDS result_df colnames: sample, 1, 2"
```

```
## tidybulk says: to access the raw results do `metadata(.)$tidybulk$MDS`
```

```
airway = airway |>
  reduce_dimensions(method="PCA", .dims = 2)
```

```
## Getting the 500 most variable genes
```

```
## Fraction of variance explained by the selected principal components
```

```
## # A tibble: 2 × 2
##   `Fraction of variance`    PC
##                    <dbl> <int>
## 1                 0.0654     1
## 2                 0.0558     2
```

```
## tidybulk says: to access the raw results do `metadata(.)$tidybulk$PCA`
```

### 3.3.3 Visualize Dimensionality Reduction Results

```
# MDS plot
airway |>
    pivot_sample() |>
    ggplot(aes(x=`Dim1`, y=`Dim2`, color=`dex`)) +
  geom_point() +
    my_theme +
    labs(title = "MDS Analysis")
```

![](data:image/png;base64...)

```
# PCA plot
    airway |>
    pivot_sample() |>
    ggplot(aes(x=`PC1`, y=`PC2`, color=`dex`)) +
    geom_point() +
    my_theme +
    labs(title = "PCA Analysis")
```

![](data:image/png;base64...)

### 3.3.4 Clustering Analysis

K-means clustering (MacQueen [1967](#ref-macqueen1967kmeans)) is used for unsupervised grouping.

```
airway = airway |>
  cluster_elements(method="kmeans", centers = 2)

# Visualize clustering
    airway |>
    ggplot(aes(x=`Dim1`, y=`Dim2`, color=`cluster_kmeans`)) +
  geom_point() +
  my_theme +
  labs(title = "K-means Clustering")
```

![](data:image/png;base64...)

## 3.4 Step 3: Differential Expression Analysis

### 3.4.1 Basic Differential Expression

**Methods:**

* **edgeR quasi-likelihood:** Quasi-likelihood F-tests for differential expression (Robinson, McCarthy, and Smyth [2010](#ref-robinson2010edger); Chen, Lun, and Smyth [2016](#ref-chen2016edgeR))
* **edgeR robust likelihood ratio:** Robust likelihood ratio tests (Chen, Lun, and Smyth [2016](#ref-chen2016edgeR))
* **DESeq2:** Negative binomial distribution with dispersion estimation (Love, Huber, and Anders [2014](#ref-love2014deseq2))
* **limma-voom:** Linear modeling with empirical Bayes moderation (Law et al. [2014](#ref-law2014voom))
* **limma-voom with sample weights:** Enhanced voom with quality weights (Liu et al. [2015](#ref-liu2015voomweights))

**References:**

* Robinson et al. (2010) edgeR: a Bioconductor package for differential expression analysis
* Chen et al. (2016) From reads to genes to pathways: differential expression analysis of RNA-Seq experiments using Rsubread and the edgeR quasi-likelihood pipeline
* Love et al. (2014) Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2
* Law et al. (2014) voom: precision weights unlock linear model analysis tools for RNA-seq read counts
* Liu et al. (2015) Why weight? Modelling sample and observational level variability improves power in RNA-seq analyses

```
# Standard differential expression analysis
airway = airway |>

# Use QL method
    test_differential_expression(~ dex, method = "edgeR_quasi_likelihood", prefix = "ql__") |>

    # Use edger_robust_likelihood_ratio
    test_differential_expression(~ dex, method = "edger_robust_likelihood_ratio", prefix = "lr_robust__") |>

# Use DESeq2 method
    test_differential_expression(~ dex, method = "DESeq2", prefix = "deseq2__") |>

    # Use limma_voom
    test_differential_expression(~ dex, method = "limma_voom", prefix = "voom__") |>

# Use limma_voom_sample_weights
    test_differential_expression(~ dex, method = "limma_voom_sample_weights", prefix = "voom_weights__")
```

### 3.4.2 Quality Control of the Fit

It is important to check the quality of the fit. All methods produce a fit object that can be used for quality control. The fit object produced by each underlying method are stored in as attributes of the `airway_mini` object. We can use them for example to perform quality control of the fit.

#### 3.4.2.1 For edgeR

Plot the biological coefficient of variation (BCV) trend. This plot is helpful to understant the dispersion of the data.

```
library(edgeR)
```

```
## Loading required package: limma
```

```
##
## Attaching package: 'limma'
```

```
## The following object is masked from 'package:BiocGenerics':
##
##     plotMA
```

```
metadata(airway)$tidybulk$edgeR_quasi_likelihood_object |>
  plotBCV()
```

![](data:image/png;base64...)

Plot the log-fold change vs mean plot.

```
library(edgeR)

metadata(airway)$tidybulk$edgeR_quasi_likelihood_fit |>
  plotMD()
```

![](data:image/png;base64...)

#### 3.4.2.2 For DESeq2

Plot the mean-variance trend.

```
library(DESeq2)

metadata(airway)$tidybulk$DESeq2_object |>
  plotDispEsts()
```

![](data:image/png;base64...)

Plot the log-fold change vs mean plot.

```
library(DESeq2)

metadata(airway)$tidybulk$DESeq2_object |>
  plotMA()
```

![](data:image/png;base64...)

### 3.4.3 Histograms of p-values across methods

Inspection of the raw p-value histogram provides a rapid check of differential-expression results. When no gene is truly differentially expressed, the p-values follow a uniform U(0,1) distribution across the interval 0–1, so the histogram appears flat [Source](https://bioconductor.org/help/course-materials/2014/useR2014/Workflows.html). In a more realistic scenario where only a subset of genes changes, this uniform background is still present but an obvious spike emerges close to zero, created by the genuine signals.

Thanks to the modularity of the `tidybulk` workflow, that can multiplex different methods, we can easily compare the p-values across methods.

```
    airway |>
  pivot_transcript() |>
  select(
    ql__PValue,
    lr_robust__PValue,
    voom__P.Value,
    voom_weights__P.Value,
    deseq2__pvalue
  ) |>
  pivot_longer(everything(), names_to = "method", values_to = "pvalue") |>
  ggplot(aes(x = pvalue, fill = method)) +
  geom_histogram(binwidth = 0.01) +
  facet_wrap(~method) +
  my_theme +
  labs(title = "Histogram of p-values across methods")
```

```
## Warning: Removed 29 rows containing non-finite outside the scale range
## (`stat_bin()`).
```

![](data:image/png;base64...)

### 3.4.4 Compare Results Across Methods

```
# Summary statistics
airway |>
  pivot_transcript() |>
  select(contains("ql|lr_robust|voom|voom_weights|deseq2")) |>
  select(contains("logFC")) |>
  summarise(across(everything(), list(min = min, median = median, max = max), na.rm = TRUE))
```

```
## Warning: There was 1 warning in `summarise()`.
## ℹ In argument: `across(...)`.
## Caused by warning:
## ! The `...` argument of `across()` is deprecated as of dplyr 1.1.0.
## Supply arguments directly to `.fns` through an anonymous function instead.
##
##   # Previously
##   across(a:b, mean, na.rm = TRUE)
##
##   # Now
##   across(a:b, \(x) mean(x, na.rm = TRUE))
```

```
## # A tibble: 1 × 0
```

### 3.4.5 Pairplot of pvalues across methods (GGpairs)

```
library(GGally)
airway |>
  pivot_transcript() |>
  select(ql__PValue, lr_robust__PValue, voom__P.Value, voom_weights__P.Value, deseq2__pvalue) |>
  ggpairs(columns = 1:5, size = 0.5) +
  scale_y_log10_reverse() +
  scale_x_log10_reverse() +
  my_theme +
  labs(title = "Pairplot of p-values across methods")
```

![](data:image/png;base64...)

### 3.4.6 Pairplot of effect sizes across methods (GGpairs)

```
library(GGally)
airway |>
  pivot_transcript() |>
  select(ql__logFC, lr_robust__logFC, voom__logFC, voom_weights__logFC, deseq2__log2FoldChange) |>
  ggpairs(columns = 1:5, size = 0.5) +
  my_theme +
  labs(title = "Pairplot of effect sizes across methods")
```

![](data:image/png;base64...)

### 3.4.7 Volcano Plots for Each Method

Visualising the significance and effect size of the differential expression results as a volcano plots we appreciate that some methods have much lower p-values distributions than other methods, for the same model and data.

```
# Create volcano plots
airway |>

    # Select the columns we want to plot
    pivot_transcript() |>
    select(
            .feature,
      ql__logFC, ql__PValue,
      lr_robust__logFC, lr_robust__PValue,
      voom__logFC, voom__P.Value,
      voom_weights__logFC, voom_weights__P.Value,
      deseq2__log2FoldChange, deseq2__pvalue
    ) |>

    # Pivot longer to get a tidy data frame
    pivot_longer(
      - .feature,
      names_to = c("method", "stat"),
      values_to = "value", names_sep = "__"
    ) |>

    # Harmonize column names
    mutate(stat  = case_when(
        stat %in% c("logFC", "log2FoldChange") ~ "logFC",
        stat %in% c("PValue", "pvalue", "P.Value", "p.value") ~ "PValue"
    )) |>
  pivot_wider(names_from = "stat", values_from = "value") |>
  unnest(c(logFC, PValue)) |>

    # Plot
  ggplot(aes(x = logFC, y = PValue)) +
  geom_point(aes(color = PValue < 0.05, size = PValue < 0.05)) +
  scale_y_log10_reverse() +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black")) +
  scale_size_manual(values = c("TRUE" = 0.5, "FALSE" = 0.1)) +
  facet_wrap(~method) +
  my_theme +
  labs(title = "Volcano Plots by Method")
```

```
## Warning: Removed 29 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)

Plotting independent y-axis scales for the p-values and effect sizes allows us to compare the top genes across methods.

```
# Create volcano plots
airway |>

    # Select the columns we want to plot
    pivot_transcript() |>
    select(
            symbol,
      ql__logFC, ql__PValue,
      lr_robust__logFC, lr_robust__PValue,
      voom__logFC, voom__P.Value,
      voom_weights__logFC, voom_weights__P.Value,
      deseq2__log2FoldChange, deseq2__pvalue
    ) |>

    # Pivot longer to get a tidy data frame
    pivot_longer(
      - symbol,
      names_to = c("method", "stat"),
      values_to = "value", names_sep = "__"
    ) |>

    # Harmonize column names
    mutate(stat  = case_when(
        stat %in% c("logFC", "log2FoldChange") ~ "logFC",
        stat %in% c("PValue", "pvalue", "P.Value", "p.value") ~ "PValue"
    )) |>
  pivot_wider(names_from = "stat", values_from = "value") |>
  unnest(c(logFC, PValue)) |>

    # Plot
  ggplot(aes(x = logFC, y = PValue)) +
  geom_point(aes(color = PValue < 0.05, size = PValue < 0.05)) +
  ggrepel::geom_text_repel(aes(label = symbol), size = 2, max.overlaps = 20) +
  scale_y_log10_reverse() +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black")) +
  scale_size_manual(values = c("TRUE" = 0.5, "FALSE" = 0.1)) +
  facet_wrap(~method, scales = "free_y") +
  my_theme +
  labs(title = "Volcano Plots by Method")
```

```
## Warning: Removed 29 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

```
## Warning: Removed 29 rows containing missing values or values outside the scale range
## (`geom_text_repel()`).
```

```
## Warning: ggrepel: 15750 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

```
## Warning: ggrepel: 15790 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

```
## Warning: ggrepel: 15780 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

```
## Warning: ggrepel: 15789 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

```
## Warning: ggrepel: 15790 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

![](data:image/png;base64...)

### 3.4.8 Differential Expression with Contrasts

Contrast-based differential expression analysis, is available for most methods. It is a standard statistical approach for testing specific comparisons in complex designs.

#### 3.4.8.1 For edgeR

```
# Using contrasts for more complex comparisons
airway |>
    test_differential_expression(
        ~ 0 + dex,
        contrasts  = c("dextrt - dexuntrt"),
        method = "edgeR_quasi_likelihood",
        prefix = "contrasts__"
    ) |>

    # Print the gene statistics
  pivot_transcript() |>
  select(contains("contrasts"))
```

```
## tidybulk says: The design column names are "dextrt, dexuntrt"
```

```
## tidybulk says: to access the DE object do `metadata(.)$tidybulk$edgeR_quasi_likelihood_object`
## tidybulk says: to access the raw results (fitted GLM) do `metadata(.)$tidybulk$edgeR_quasi_likelihood_fit`
```

```
## # A tibble: 15,790 × 5
##    contrasts__logFC___dextrt...d…¹ contrasts__logCPM___…² contrasts__F___dextr…³
##                              <dbl>                  <dbl>                  <dbl>
##  1                         -0.389                    5.10                 6.81
##  2                          0.194                    4.65                 6.00
##  3                          0.0231                   3.52                 0.0544
##  4                         -0.125                    1.52                 0.219
##  5                          0.432                    8.13                 2.92
##  6                         -0.251                    5.95                 6.14
##  7                         -0.0395                   4.88                 0.0338
##  8                         -0.498                    4.16                 7.07
##  9                         -0.141                    3.16                 1.06
## 10                         -0.0533                   7.08                 0.0338
## # ℹ 15,780 more rows
## # ℹ abbreviated names: ¹​contrasts__logFC___dextrt...dexuntrt,
## #   ²​contrasts__logCPM___dextrt...dexuntrt, ³​contrasts__F___dextrt...dexuntrt
## # ℹ 2 more variables: contrasts__PValue___dextrt...dexuntrt <dbl>,
## #   contrasts__FDR___dextrt...dexuntrt <dbl>
```

#### 3.4.8.2 For DESeq2

```
# Using contrasts for more complex comparisons
airway |>
    test_differential_expression(
        ~ 0 + dex,
        contrasts  = list(c("dex", "trt", "untrt")),
        method = "DESeq2",
        prefix = "contrasts__"
  ) |>
  pivot_transcript() |>
  select(contains("contrasts"))
```

```
## estimating size factors
```

```
## estimating dispersions
```

```
## gene-wise dispersion estimates
```

```
## mean-dispersion relationship
```

```
## final dispersion estimates
```

```
## fitting model and testing
```

```
## tidybulk says: to access the DE object do `metadata(.)$tidybulk$DESeq2_object`
## tidybulk says: to access the raw results (fitted GLM) do `metadata(.)$tidybulk$DESeq2_fit`
```

```
## # A tibble: 15,790 × 6
##    contrasts__baseMean___dex.trt…¹ contrasts__log2FoldC…² contrasts__lfcSE___d…³
##                              <dbl>                  <dbl>                  <dbl>
##  1                           710.                 -0.385                  0.172
##  2                           521.                  0.197                  0.0953
##  3                           238.                  0.0279                 0.122
##  4                            58.0                -0.124                  0.308
##  5                          5826.                  0.434                  0.260
##  6                          1285.                 -0.248                  0.116
##  7                           611.                 -0.0360                 0.233
##  8                           370.                 -0.496                  0.211
##  9                           184.                 -0.140                  0.164
## 10                          2820.                 -0.0494                 0.294
## # ℹ 15,780 more rows
## # ℹ abbreviated names: ¹​contrasts__baseMean___dex.trt.untrt,
## #   ²​contrasts__log2FoldChange___dex.trt.untrt,
## #   ³​contrasts__lfcSE___dex.trt.untrt
## # ℹ 3 more variables: contrasts__stat___dex.trt.untrt <dbl>,
## #   contrasts__pvalue___dex.trt.untrt <dbl>,
## #   contrasts__padj___dex.trt.untrt <dbl>
```

#### 3.4.8.3 For limma-voom

```
# Using contrasts for more complex comparisons
airway |>
    test_differential_expression(
        ~ 0 + dex,
        contrasts  = c("dextrt - dexuntrt"),
        method = "limma_voom",
        prefix = "contrasts__"
    ) |>
  pivot_transcript() |>
  select(contains("contrasts"))
```

```
## tidybulk says: The design column names are "dextrt, dexuntrt"
```

```
## tidybulk says: to access the DE object do `metadata(.)$tidybulk$limma_voom_object`
## tidybulk says: to access the raw results (fitted GLM) do `metadata(.)$tidybulk$limma_voom_fit`
```

```
## # A tibble: 15,790 × 6
##    contrasts__logFC___dextrt...d…¹ contrasts__AveExpr__…² contrasts__t___dextr…³
##                              <dbl>                  <dbl>                  <dbl>
##  1                         -0.383                    5.07                -2.55
##  2                          0.196                    4.64                 2.49
##  3                          0.0318                   3.51                 0.324
##  4                         -0.0677                   1.45                -0.241
##  5                          0.408                    8.07                 1.55
##  6                         -0.252                    5.94                -2.47
##  7                         -0.0656                   4.84                -0.305
##  8                         -0.481                    4.11                -2.58
##  9                         -0.159                    3.14                -1.14
## 10                         -0.0273                   7.02                -0.0956
## # ℹ 15,780 more rows
## # ℹ abbreviated names: ¹​contrasts__logFC___dextrt...dexuntrt,
## #   ²​contrasts__AveExpr___dextrt...dexuntrt, ³​contrasts__t___dextrt...dexuntrt
## # ℹ 3 more variables: contrasts__P.Value___dextrt...dexuntrt <dbl>,
## #   contrasts__adj.P.Val___dextrt...dexuntrt <dbl>,
## #   contrasts__B___dextrt...dexuntrt <dbl>
```

### 3.4.9 Differential Expression with minimum fold change (TREAT method)

TREAT method (McCarthy and Smyth [2009](#ref-mccarthy2009treat)) is used for testing significance relative to a fold-change threshold.

```
# Using contrasts for more complex comparisons
airway |>
    test_differential_expression(
        ~ 0 + dex,
        contrasts  = c("dextrt - dexuntrt"),
        method = "edgeR_quasi_likelihood",
        test_above_log2_fold_change = 2,
        prefix = "treat__"
    ) |>

    # Print the gene statistics
  pivot_transcript() |>
  select(contains("treat"))
```

```
## tidybulk says: The design column names are "dextrt, dexuntrt"
```

```
## tidybulk says: to access the DE object do `metadata(.)$tidybulk$edgeR_quasi_likelihood_object`
## tidybulk says: to access the raw results (fitted GLM) do `metadata(.)$tidybulk$edgeR_quasi_likelihood_fit`
```

```
## # A tibble: 15,790 × 5
##    treat__logFC___dextrt...dexun…¹ treat__unshrunk.logF…² treat__logCPM___dext…³
##                              <dbl>                  <dbl>                  <dbl>
##  1                         -0.389                 -0.389                    5.10
##  2                          0.194                  0.194                    4.65
##  3                          0.0231                 0.0232                   3.52
##  4                         -0.125                 -0.125                    1.52
##  5                          0.432                  0.432                    8.13
##  6                         -0.251                 -0.251                    5.95
##  7                         -0.0395                -0.0395                   4.88
##  8                         -0.498                 -0.498                    4.16
##  9                         -0.141                 -0.141                    3.16
## 10                         -0.0533                -0.0533                   7.08
## # ℹ 15,780 more rows
## # ℹ abbreviated names: ¹​treat__logFC___dextrt...dexuntrt,
## #   ²​treat__unshrunk.logFC___dextrt...dexuntrt,
## #   ³​treat__logCPM___dextrt...dexuntrt
## # ℹ 2 more variables: treat__PValue___dextrt...dexuntrt <dbl>,
## #   treat__FDR___dextrt...dexuntrt <dbl>
```

### 3.4.10 Mixed Models for Complex Designs

glmmSeq (Ma et al. [2020](#ref-ma2020glmmseq)) is used for generalized linear mixed models for RNA-seq data.

```
# Using glmmSeq for mixed models
airway |>
  keep_abundant(formula_design = ~ dex) |>

  # Select 100 genes in the interest of execution time
  _[1:100,] |>

  # Fit model
  test_differential_expression(
    ~ dex + (1|cell),
    method = "glmmseq_lme4",
    cores = 1,
    prefix = "glmmseq__"
  )
```

```
## Warning in check_dep_version(dep_pkg = "TMB"): package version mismatch:
## glmmTMB was built with TMB package version 1.9.17
## Current TMB package version is 1.9.18
## Please re-install glmmTMB from source or restore original 'TMB' package (see '?reinstalling' for more information)
```

```
##
## n = 8 samples, 4 individuals
```

```
## Time difference of 1.682176 mins
```

```
## tidybulk says: to access the DE object do
## `metadata(.)$tidybulk$glmmseq_lme4_object`
```

```
## tidybulk says: to access the raw results (fitted GLM) do
## `metadata(.)$tidybulk$glmmseq_lme4_fit`
```

```
## class: RangedSummarizedExperiment
## dim: 100 8
## metadata(1): tidybulk
## assays(4): counts counts_tmm counts_upperquartile counts_RLE
## rownames(100): TSPAN6 DPM1 ... SYNRG TMEM132A
## rowData names(64): gene_name gene_seq_end ... glmmseq__P_dex
##   glmmseq__P_dex_adjusted
## colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
## colData names(16): SampleName cell ... PC2 cluster_kmeans
```

```
  airway |>
  pivot_transcript()
```

```
## # A tibble: 15,790 × 42
##    .feature gene_name gene_seq_end gene_seq_start seq_coord_system seq_strand
##    <chr>    <chr>            <dbl>          <dbl>            <dbl>      <dbl>
##  1 TSPAN6   TSPAN6        99894988       99883667               NA         -1
##  2 DPM1     DPM1          49575092       49551404               NA         -1
##  3 SCYL3    SCYL3        169863408      169818772               NA         -1
##  4 C1orf112 C1orf112     169823221      169631245               NA          1
##  5 CFH      CFH          196716634      196621008               NA          1
##  6 FUCA2    FUCA2        143832827      143815948               NA         -1
##  7 GCLC     GCLC          53481768       53362139               NA         -1
##  8 NFYA     NFYA          41067715       41040684               NA          1
##  9 STPG1    STPG1         24743424       24683489               NA         -1
## 10 NIPAL3   NIPAL3        24799466       24742284               NA          1
## # ℹ 15,780 more rows
## # ℹ 36 more variables: entrezid <chr>, gene_biotype <chr>, gene_id <chr>,
## #   seq_name <chr>, symbol <chr>, merged_transcripts <int>, .abundant <lgl>,
## #   ql__logFC <dbl>, ql__logCPM <dbl>, ql__F <dbl>, ql__PValue <dbl>,
## #   ql__FDR <dbl>, lr_robust__logFC <dbl>, lr_robust__logCPM <dbl>,
## #   lr_robust__LR <dbl>, lr_robust__PValue <dbl>, lr_robust__FDR <dbl>,
## #   deseq2__baseMean <dbl>, deseq2__log2FoldChange <dbl>, …
```

### 3.4.11 Gene Description

With tidybulk, retrieving gene descriptions is straightforward, making it easy to enhance the interpretability of your differential expression results.

```
# Add gene descriptions using the original SummarizedExperiment
airway |>

    describe_transcript() |>

    # Filter top significant genes
    filter(ql__FDR < 0.05) |>

    # Print the gene statistics
    pivot_transcript() |>
  filter(description |> is.na() |> not()) |>
    select(.feature, description, contains("ql")) |>
    head()
```

```
##
```

```
##
```

```
## # A tibble: 6 × 7
##   .feature description             ql__logFC ql__logCPM ql__F ql__PValue ql__FDR
##   <chr>    <chr>                       <dbl>      <dbl> <dbl>      <dbl>   <dbl>
## 1 LASP1    LIM and SH3 protein 1      -0.389      8.43   16.4  0.00299   0.0316
## 2 KLHL13   kelch like family memb…     0.930      4.20   31.3  0.000361  0.00892
## 3 CFLAR    CASP8 and FADD like ap…    -1.17       6.94   64.7  0.0000237 0.00232
## 4 MTMR7    myotubularin related p…    -0.967      0.387  17.7  0.00240   0.0280
## 5 ARF5     ARF GTPase 5               -0.358      5.88   17.1  0.00266   0.0295
## 6 KDM1A    lysine demethylase 1A       0.310      5.90   20.0  0.00161   0.0217
```

## 3.5 Step 4: Batch Effect Correction

ComBat-seq (Zhang, Parmigiani, and Johnson [2020](#ref-zhang2017combatseq)) is used for batch effect correction in RNA-seq data.

```
# Adjust for batch effects
airway = airway |>
  adjust_abundance(
      .factor_unwanted = cell,
      .factor_of_interest = dex,
    method = "combat_seq",
      abundance = "counts_tmm"
  )
```

```
## Found 4 batches
## Using null model in ComBat-seq.
## Adjusting for 1 covariate(s) or covariate level(s)
## Estimating dispersions
## Fitting the GLM model
## Shrinkage off - using GLM estimates for parameters
## Adjusting the data
```

```
# Scatter plot of adjusted vs unadjusted
airway |>

  # Subset genes to speed up plotting
  _[1:100,] |>
  select(symbol, .sample, counts_tmm, counts_tmm_adjusted) |>

  ggplot(aes(x = counts_tmm + 1, y = counts_tmm_adjusted + 1)) +
  geom_point(aes(color = .sample), size = 0.1) +
  ggrepel::geom_text_repel(aes(label = symbol), size = 2, max.overlaps = 20) +
  scale_x_log10() +
  scale_y_log10() +
  my_theme +
  labs(title = "Scatter plot of adjusted vs unadjusted")
```

```
## tidySummarizedExperiment says: Key columns are missing. A data frame is returned for independent data analysis.
```

```
## Warning: ggrepel: 784 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

![](data:image/png;base64...)

## 3.6 Step 5: Gene Enrichment Analysis

Gene Set Enrichment Analysis (GSEA) (Subramanian et al. [2005](#ref-subramanian2005gsea)) is used for gene set enrichment.

```
# Run gene rank enrichment (GSEA style)
gene_rank_res =
  airway |>

    # Filter for genes with entrez IDs
  filter(!entrezid |> is.na()) |>
  aggregate_duplicates(feature = "entrezid") |>

  # Test gene rank
  test_gene_rank(
    .entrez = entrezid,
    .arrange_desc = lr_robust__logFC,
    species = "Homo sapiens",
    gene_sets = c("H", "C2", "C5")
  )
```

```
##
```

```
## using 'fgsea' for GSEA analysis, please cite Korotkevich et al (2019).
```

```
## preparing geneSet collections...
```

```
## GSEA analysis...
```

```
## leading edge analysis...
```

```
## done...
```

```
## using 'fgsea' for GSEA analysis, please cite Korotkevich et al (2019).
```

```
## preparing geneSet collections...
```

```
## GSEA analysis...
```

```
## leading edge analysis...
```

```
## done...
```

```
## using 'fgsea' for GSEA analysis, please cite Korotkevich et al (2019).
```

```
## preparing geneSet collections...
```

```
## GSEA analysis...
```

```
## leading edge analysis...
```

```
## done...
```

```
## Warning: There was 1 warning in `mutate()`.
## ℹ In argument: `fit = map(...)`.
## Caused by warning in `fgseaMultilevel()`:
## ! For some pathways, in reality P-values are less than 1e-10. You can set the `eps` argument to zero for better estimation.
```

```
# Inspect significant gene sets (example for C2 collection)
gene_rank_res |>
  filter(gs_collection == "C2") |>
  dplyr::select(-fit) |>
  unnest(test) |>
  filter(p.adjust < 0.05)
```

```
## # A tibble: 44 × 13
##    gs_collection idx_for_plotting ID         Description setSize enrichmentScore
##    <chr>                    <int> <chr>      <chr>         <int>           <dbl>
##  1 C2                           1 CHEN_LVAD… CHEN_LVAD_…      83          -0.726
##  2 C2                           2 VECCHI_GA… VECCHI_GAS…     205          -0.574
##  3 C2                           3 BOQUEST_S… BOQUEST_ST…     374          -0.436
##  4 C2                           4 SHEDDEN_L… SHEDDEN_LU…     154          -0.554
##  5 C2                           5 FEKIR_HEP… FEKIR_HEPA…      27          -0.840
##  6 C2                           6 CHARAFE_B… CHARAFE_BR…     387          -0.418
##  7 C2                           7 HOSHIDA_L… HOSHIDA_LI…     187          -0.505
##  8 C2                           8 CAIRO_HEP… CAIRO_HEPA…     158          -0.502
##  9 C2                           9 ZWANG_CLA… ZWANG_CLAS…     186          -0.483
## 10 C2                          10 TURASHVIL… TURASHVILI…     140          -0.509
## # ℹ 34 more rows
## # ℹ 7 more variables: NES <dbl>, pvalue <dbl>, p.adjust <dbl>, qvalue <dbl>,
## #   rank <dbl>, leading_edge <chr>, core_enrichment <chr>
```

#### 3.6.0.1 Visualize enrichment

```
  library(enrichplot)
```

```
## enrichplot v1.30.2 Learn more at https://yulab-smu.top/contribution-knowledge-mining/
##
## Please cite:
##
## Guangchuang Yu, Qing-Yu He. ReactomePA: an R/Bioconductor package for
## reactome pathway analysis and visualization. Molecular BioSystems.
## 2016, 12(2):477-479
```

```
##
## Attaching package: 'enrichplot'
```

```
## The following object is masked from 'package:GGally':
##
##     ggtable
```

```
  library(patchwork)
  gene_rank_res |>
    unnest(test) |>
    head() |>
    mutate(plot = pmap(
      list(fit, ID, idx_for_plotting, p.adjust),
      ~ enrichplot::gseaplot2(
        ..1, geneSetID = ..3,
        title = sprintf("%s \nadj pvalue %s", ..2, round(..4, 2)),
        base_size = 6, rel_heights = c(1.5, 0.5), subplots = c(1, 2)
      )
    )) |>
    pull(plot)
```

```
## [[1]]
```

![](data:image/png;base64...)

```
##
## [[2]]
```

![](data:image/png;base64...)

```
##
## [[3]]
```

![](data:image/png;base64...)

```
##
## [[4]]
```

![](data:image/png;base64...)

```
##
## [[5]]
```

![](data:image/png;base64...)

```
##
## [[6]]
```

![](data:image/png;base64...)

```
detach("package:enrichplot", unload = TRUE)
```

```
## Warning: 'enrichplot' namespace cannot be unloaded:
##   namespace 'enrichplot' is imported by 'clusterProfiler' so cannot be unloaded
```

Gene Ontology overrepresentation analysis (Ashburner et al. [2000](#ref-ashburner2000go)) is used for functional enrichment.

```
# Test gene overrepresentation
airway_overrep =
  airway |>

  # Label genes to test overrepresentation of
  mutate(genes_to_test = ql__FDR < 0.05) |>

    # Filter for genes with entrez IDs
  filter(!entrezid |> is.na()) |>

  test_gene_overrepresentation(
    .entrez = entrezid,
    species = "Homo sapiens",
    .do_test = genes_to_test,
    gene_sets = c("H", "C2", "C5")
  )

  airway_overrep
```

```
## # A tibble: 5,435 × 13
##    gs_collection ID      Description GeneRatio BgRatio RichFactor FoldEnrichment
##    <chr>         <chr>   <chr>       <chr>     <chr>        <dbl>          <dbl>
##  1 C2            PASINI… PASINI_SUZ… 85/1744   316/22…      0.269           3.45
##  2 C2            CHARAF… CHARAFE_BR… 102/1744  465/22…      0.219           2.82
##  3 C2            CHARAF… CHARAFE_BR… 100/1744  456/22…      0.219           2.81
##  4 C2            REN_AL… REN_ALVEOL… 93/1744   407/22…      0.229           2.93
##  5 C2            CHEN_L… CHEN_LVAD_… 40/1744   102/22…      0.392           5.03
##  6 C2            ONDER_… ONDER_CDH1… 66/1744   257/22…      0.257           3.30
##  7 C2            LIU_PR… LIU_PROSTA… 98/1744   495/22…      0.198           2.54
##  8 C2            BOQUES… BOQUEST_ST… 89/1744   428/22…      0.208           2.67
##  9 C2            LU_AGI… LU_AGING_B… 65/1744   264/22…      0.246           3.16
## 10 C2            LIM_MA… LIM_MAMMAR… 94/1744   479/22…      0.196           2.52
## # ℹ 5,425 more rows
## # ℹ 6 more variables: zScore <dbl>, pvalue <dbl>, p.adjust <dbl>, qvalue <dbl>,
## #   Count <int>, entrez <list>
```

EGSEA (Alhamdoosh et al. [2017](#ref-alhamdoosh2017egsea)) is used for ensemble gene set enrichment analysis. EGSEA is a method that combines multiple gene set enrichment analysis methods to provide a more robust and comprehensive analysis of gene set enrichment. It creates a web-based interactive tool that allows you to explore the results of the gene set enrichment analysis.

```
library(EGSEA)
# Test gene enrichment
  airway |>

  # Filter for genes with entrez IDs
  filter(!entrezid |> is.na()) |>
  aggregate_duplicates(feature = "entrezid") |>

  # Test gene enrichment
  test_gene_enrichment(
    .formula = ~dex,
    .entrez = entrezid,
    species = "human",
    gene_sets = "h",
    methods = c("roast"),  # Use a more robust method
    cores = 2
  )
detach("package:EGSEA", unload = TRUE)
```

## 3.7 Step 6: Cellularity Analysis

CIBERSORT (Newman et al. [2015](#ref-newman2015cibersort)) is used for cell type deconvolution.

Cellularity deconvolution is a standard approach for estimating the cellular composition of a sample.

### 3.7.1 Available Deconvolution Methods

The `tidybulk` package provides several methods for deconvolution:

* **CIBERSORT** (Newman et al. [2015](#ref-newman2015cibersort)): Uses support vector regression to deconvolve cell type proportions. Requires the `class`, `e1071`, and `preprocessCore` packages.
* **LLSR** (Newman et al. [2015](#ref-newman2015cibersort)): Linear Least Squares Regression for deconvolution.
* **EPIC** (**???**): Uses a reference-based approach to estimate cell fractions.
* **MCP-counter** (**???**): Quantifies the abundance of immune and stromal cell populations.
* **quanTIseq** (**???**): A computational framework for inferring the immune contexture of tumors.
* **xCell** (**???**): Performs cell type enrichment analysis.

### 3.7.2 Example Usage

```
airway =
  airway |>

  filter(!symbol |> is.na()) |>
  deconvolve_cellularity(method = "cibersort", cores = 1, prefix = "cibersort__", feature_column = "symbol")
```

For the rest of the methods, you need to install the `immunedeconv` package.

```
if (!requireNamespace("immunedeconv")) BiocManager::install("immunedeconv")
```

```
airway =

airway |>
# Example using LLSR
deconvolve_cellularity(method = "llsr", prefix = "llsr__", feature_column = "symbol") |>

# Example using EPIC
deconvolve_cellularity(method = "epic", cores = 1, prefix = "epic__") |>

# Example using MCP-counter
deconvolve_cellularity(method = "mcp_counter", cores = 1, prefix = "mcp__") |>

# Example using quanTIseq
deconvolve_cellularity(method = "quantiseq", cores = 1, prefix = "quantiseq__") |>

# Example using xCell
deconvolve_cellularity(method = "xcell", cores = 1, prefix = "xcell__")
```

### 3.7.3 Plotting Results

Visualize the cell type proportions as a stacked barplot for each method:

```
# Visualize CIBERSORT results
airway   |>
  pivot_sample() |>
  dplyr::select(.sample, contains("cibersort__")) |>
  pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
  ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::percent) +
  my_theme +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  labs(title = "CIBERSORT Cell Type Proportions")
```

![](data:image/png;base64...)

```
 # Repeat similar plotting for LLSR, EPIC, MCP-counter, quanTIseq, and xCell
airway   |>
  pivot_sample() |>
  select(.sample, contains("llsr__")) |>
  pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
  ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::percent) +
  my_theme +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  labs(title = "LLSR Cell Type Proportions")

  airway     |>
  pivot_sample() |>
  select(.sample, contains("epic__")) |>
  pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
  ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::percent) +
  my_theme +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  labs(title = "EPIC Cell Type Proportions")

  airway     |>
  pivot_sample() |>
  select(.sample, contains("mcp__")) |>
  pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
  ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::percent) +
  my_theme +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  labs(title = "MCP-counter Cell Type Proportions")

  airway     |>
  pivot_sample() |>
  select(.sample, contains("quantiseq__")) |>
  pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
  ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::percent) +
  my_theme +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  labs(title = "quanTIseq Cell Type Proportions")

  airway     |>
  pivot_sample() |>
  select(.sample, contains("xcell__")) |>
  pivot_longer(cols = -1, names_to = "Cell_type_inferred", values_to = "proportion") |>
  ggplot(aes(x = .sample, y = proportion, fill = Cell_type_inferred)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::percent) +
  my_theme +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  labs(title = "xCell Cell Type Proportions")
```

## 3.8 Bibliography

`tidybulk` allows you to get the bibliography of all methods used in our workflow.

```
# Get bibliography of all methods used in our workflow
airway |> get_bibliography()
```

```
##  @Article{tidybulk,
##   title = {tidybulk: an R tidy framework for modular transcriptomic data analysis},
##   author = {Stefano Mangiola and Ramyar Molania and Ruining Dong and Maria A. Doyle & Anthony T. Papenfuss},
##   journal = {Genome Biology},
##   year = {2021},
##   volume = {22},
##   number = {42},
##   url = {https://genomebiology.biomedcentral.com/articles/10.1186/s13059-020-02233-7},
##   }
## @article{wickham2019welcome,
##   title={Welcome to the Tidyverse},
##   author={Wickham, Hadley and Averick, Mara and Bryan, Jennifer and Chang, Winston and McGowan, Lucy D'Agostino and Francois, Romain and Grolemund, Garrett and Hayes, Alex and Henry, Lionel and Hester, Jim and others},
##   journal={Journal of Open Source Software},
##   volume={4},
##   number={43},
##   pages={1686},
##   year={2019}
##  }
## @article{robinson2010edger,
##   title={edgeR: a Bioconductor package for differential expression analysis of digital gene expression data},
##   author={Robinson, Mark D and McCarthy, Davis J and Smyth, Gordon K},
##   journal={Bioinformatics},
##   volume={26},
##   number={1},
##   pages={139--140},
##   year={2010},
##   publisher={Oxford University Press}
##  }
## @article{robinson2010scaling,
##   title={A scaling normalization method for differential expression analysis of RNA-seq data},
##   author={Robinson, Mark D and Oshlack, Alicia},
##   journal={Genome biology},
##   volume={11},
##   number={3},
##   pages={1--9},
##   year={2010},
##   publisher={BioMed Central}
##  }
## @incollection{smyth2005limma,
##   title={Limma: linear models for microarray data},
##   author={Smyth, Gordon K},
##   booktitle={Bioinformatics and computational biology solutions using R and Bioconductor},
##   pages={397--420},
##   year={2005},
##   publisher={Springer}
##  }
## @Manual{,
##     title = {R: A Language and Environment for Statistical Computing},
##     author = {{R Core Team}},
##     organization = {R Foundation for Statistical Computing},
##     address = {Vienna, Austria},
##     year = {2020},
##     url = {https://www.R-project.org/},
##   }
## @article{lund2012detecting,
##   title={Detecting differential expression in RNA-sequence data using quasi-likelihood with shrunken dispersion estimates},
##   author={Lund, Steven P and Nettleton, Dan and McCarthy, Davis J and Smyth, Gordon K},
##   journal={Statistical applications in genetics and molecular biology},
##   volume={11},
##   number={5},
##   year={2012},
##   publisher={De Gruyter}
##     }
## @article{zhou2014robustly,
##   title={Robustly detecting differential expression in RNA sequencing data using observation weights},
##   author={Zhou, Xiaobei and Lindsay, Helen and Robinson, Mark D},
##   journal={Nucleic acids research},
##   volume={42},
##   number={11},
##   pages={e91--e91},
##   year={2014},
##   publisher={Oxford University Press}
##  }
## @article{love2014moderated,
##   title={Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2},
##   author={Love, Michael I and Huber, Wolfgang and Anders, Simon},
##   journal={Genome biology},
##   volume={15},
##   number={12},
##   pages={550},
##   year={2014},
##   publisher={Springer}
##  }
## @article{law2014voom,
##   title={voom: Precision weights unlock linear model analysis tools for RNA-seq read counts},
##   author={Law, Charity W and Chen, Yunshun and Shi, Wei and Smyth, Gordon K},
##   journal={Genome biology},
##   volume={15},
##   number={2},
##   pages={R29},
##   year={2014},
##   publisher={Springer}
##     }
## @article{liu2015weight,
##   title={Why weight? Modelling sample and observational level variability improves power in RNA-seq analyses},
##   author={Liu, Ruijie and Holik, Aliaksei Z and Su, Shian and Jansz, Natasha and Chen, Kelan and Leong, Huei San and Blewitt, Marnie E and Asselin-Labat, Marie-Liesse and Smyth, Gordon K and Ritchie, Matthew E},
##   journal={Nucleic acids research},
##   volume={43},
##   number={15},
##   pages={e97--e97},
##   year={2015},
##   publisher={Oxford University Press}
##     }
## @article{leek2012sva,
##   title={The sva package for removing batch effects and other unwanted variation in high-throughput experiments},
##   author={Leek, Jeffrey T and Johnson, W Evan and Parker, Hilary S and Jaffe, Andrew E and Storey, John D},
##   journal={Bioinformatics},
##   volume={28},
##   number={6},
##   pages={882--883},
##   year={2012},
##   publisher={Oxford University Press}
##  }
## @article{newman2015robust,
##   title={Robust enumeration of cell subsets from tissue expression profiles},
##   author={Newman, Aaron M and Liu, Chih Long and Green, Michael R and Gentles, Andrew J and Feng, Weiguo and Xu, Yue and Hoang, Chuong D and Diehn, Maximilian and Alizadeh, Ash A},
##   journal={Nature methods},
##   volume={12},
##   number={5},
##   pages={453--457},
##   year={2015},
##   publisher={Nature Publishing Group}
##  }
```

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] patchwork_1.3.2                 GGally_2.4.0
##  [3] DESeq2_1.50.2                   edgeR_4.8.0
##  [5] limma_3.66.0                    airway_1.30.0
##  [7] tidySummarizedExperiment_1.20.1 tidybulk_2.0.1
##  [9] ttservice_0.5.3                 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0                  GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0                   IRanges_2.44.0
## [15] S4Vectors_0.48.0                BiocGenerics_0.56.0
## [17] generics_0.1.4                  MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0               ggrepel_0.9.6
## [21] ggplot2_4.0.0                   forcats_1.0.1
## [23] magrittr_2.0.4                  purrr_1.2.0
## [25] tibble_3.3.0                    tidyr_1.3.1
## [27] dplyr_1.1.4                     knitr_1.50
## [29] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] fs_1.6.6                enrichplot_1.30.2       httr_1.4.7
##   [4] RColorBrewer_1.1-3      numDeriv_2016.8-1.1     tools_4.5.1
##   [7] backports_1.5.0         utf8_1.2.6              R6_2.6.1
##  [10] lazyeval_0.2.2          mgcv_1.9-4              withr_3.0.2
##  [13] preprocessCore_1.72.0   cli_3.6.5               sandwich_3.1-1
##  [16] labeling_0.4.3          sass_0.4.10             mvtnorm_1.3-3
##  [19] S7_0.2.0                genefilter_1.92.0       proxy_0.4-27
##  [22] pbapply_1.7-4           systemfonts_1.3.1       yulab.utils_0.2.1
##  [25] gson_0.1.0              DOSE_4.4.0              R.utils_2.13.0
##  [28] dichromat_2.0-0.1       mcprogress_0.1.1        RSQLite_2.4.4
##  [31] gridGraphics_0.5-1      glmmSeq_0.5.7           car_3.1-3
##  [34] GO.db_3.22.0            Matrix_1.7-4            abind_1.4-8
##  [37] R.methodsS3_1.8.2       lifecycle_1.0.4         multcomp_1.4-29
##  [40] yaml_2.3.10             carData_3.0-5           qvalue_2.42.0
##  [43] SparseArray_1.10.1      grid_4.5.1              blob_1.2.4
##  [46] crayon_1.5.3            ggtangle_0.0.8          lattice_0.22-7
##  [49] msigdbr_25.1.1          cowplot_1.2.0           annotate_1.88.0
##  [52] KEGGREST_1.50.0         magick_2.9.0            pillar_1.11.1
##  [55] fgsea_1.36.0            boot_1.3-32             estimability_1.5.1
##  [58] widyr_0.1.5             codetools_0.2-20        fastmatch_1.1-6
##  [61] glue_1.8.0              ggiraph_0.9.2           ggfun_0.2.0
##  [64] fontLiberation_0.1.0    data.table_1.17.8       vctrs_0.6.5
##  [67] png_0.1-8               treeio_1.34.0           Rdpack_2.6.4
##  [70] org.Mm.eg.db_3.22.0     gtable_0.3.6            assertthat_0.2.1
##  [73] cachem_1.1.0            xfun_0.54               rbibutils_2.4
##  [76] S4Arrays_1.10.0         coda_0.19-4.1           reformulas_0.4.2
##  [79] survival_3.8-3          tinytex_0.57            statmod_1.5.1
##  [82] ellipsis_0.3.2          TH.data_1.1-4           nlme_3.1-168
##  [85] ggtree_4.0.1            bit64_4.6.0-1           fontquiver_0.2.1
##  [88] SnowballC_0.7.1         bslib_0.9.0             TMB_1.9.18
##  [91] DBI_1.2.3               tidyselect_1.2.1        emmeans_2.0.0
##  [94] bit_4.6.0               compiler_4.5.1          curl_7.0.0
##  [97] fontBitstreamVera_0.1.1 DelayedArray_0.36.0     plotly_4.11.0
## [100] bookdown_0.45           scales_1.4.0            rappdirs_0.3.3
## [103] stringr_1.6.0           digest_0.6.38           minqa_1.2.8
## [106] rmarkdown_2.30          XVector_0.50.0          htmltools_0.5.8.1
## [109] pkgconfig_2.0.3         lme4_1.1-37             fastmap_1.2.0
## [112] rlang_1.1.6             htmlwidgets_1.6.4       farver_2.1.2
## [115] jquerylib_0.1.4         zoo_1.8-14              jsonlite_2.0.0
## [118] BiocParallel_1.44.0     GOSemSim_2.36.0         tokenizers_0.3.0
## [121] R.oo_1.27.1             Formula_1.2-5           ggplotify_0.1.3
## [124] Rcpp_1.1.0              ape_5.8-1               babelgene_22.9
## [127] gdtools_0.4.4           stringi_1.8.7           MASS_7.3-65
## [130] plyr_1.8.9              org.Hs.eg.db_3.22.0     ggstats_0.11.0
## [133] parallel_4.5.1          Biostrings_2.78.0       splines_4.5.1
## [136] locfit_1.5-9.12         igraph_2.2.1            ggpubr_0.6.2
## [139] ggsignif_0.6.4          reshape2_1.4.5          XML_3.99-0.20
## [142] evaluate_1.0.5          tidytext_0.4.3          BiocManager_1.30.26
## [145] nloptr_2.2.1            broom_1.0.10            xtable_1.8-4
## [148] e1071_1.7-16            tidytree_0.4.6          janeaustenr_1.0.0
## [151] rstatix_0.7.3           viridisLite_0.4.2       class_7.3-23
## [154] lmerTest_3.1-3          clusterProfiler_4.18.1  aplot_0.2.9
## [157] glmmTMB_1.1.13          memoise_2.0.1           AnnotationDbi_1.72.0
## [160] sva_3.58.0
```

Alhamdoosh, M, M Ng, NJ Wilson, JM Sheridan, H Huynh, MJ Wilson, and ME Ritchie. 2017. “Combining Multiple Tools Outperforms Individual Methods in Gene Set Enrichment Analyses.” *Bioinformatics* 33 (3): 414–24.

Anders, Simon, and Wolfgang Huber. 2010. “Differential Expression Analysis for Sequence Count Data.” *Genome Biology* 11 (10): R106.

Ashburner, Michael, Catherine A Ball, Judith A Blake, David Botstein, Heather Butler, J Michael Cherry, J Michael Davis, et al. 2000. “Gene Ontology: Tool for the Unification of Biology.” *Nature Genetics* 25 (1): 25–29.

Bullard, James H, Elizabeth Purdom, Kasper D Hansen, and Sandrine Dudoit. 2010. “Evaluation of Statistical Methods for Normalization and Differential Expression in mRNA-Seq Experiments.” *BMC Bioinformatics* 11 (1): 94.

Chen, Yunshun, Aaron TL Lun, and Gordon K Smyth. 2016. “From Reads to Genes to Pathways: Differential Expression Analysis of Rna-Seq Experiments Using Rsubread and the edgeR Quasi-Likelihood Pipeline.” *F1000Research* 5.

Hotelling, Harold. 1933. “Analysis of a Complex of Statistical Variables into Principal Components.” *Journal of Educational Psychology* 24 (6): 417.

Kruskal, Joseph B. 1964. “Multidimensional Scaling by Optimizing Goodness of Fit to a Nonmetric Hypothesis.” *Psychometrika* 29 (1): 1–27.

Law, Charity W, Yunshun Chen, Wei Shi, and Gordon K Smyth. 2014. “Voom: Precision Weights Unlock Linear Model Analysis Tools for Rna-Seq Read Counts.” *Genome Biology* 15 (2): R29.

Liu, Rui, Anna Z Holik, Shian Su, Nikolas Jansz, Yunshun Chen, Hsiu S Leong, Marnie E Blewitt, Marie-Liesse Asselin-Labat, Gordon K Smyth, and Matthew E Ritchie. 2015. “Why Weight? Modelling Sample and Observational Level Variability Improves Power in Rna-Seq Analyses.” *Nucleic Acids Research* 43 (15): e97–e97.

Love, Michael I, Wolfgang Huber, and Simon Anders. 2014. “Moderated Estimation of Fold Change and Dispersion for Rna-Seq Data with Deseq2.” *Genome Biology* 15 (12): 550.

Ma, Shuang, Bing Zhang, Laura M LaFave, Amanda S Earl, Zhicheng Chiang, Yuling Hu, Jun Ding, et al. 2020. “A General Linear Mixed Model for Differential Expression Analysis of Single-Cell Rna-Seq Data.” *Nature Communications* 11 (1): 1–11.

MacQueen, J. 1967. “Some Methods for Classification and Analysis of Multivariate Observations.” In *Proceedings of the Fifth Berkeley Symposium on Mathematical Statistics and Probability*, 1:281–97. 14. Oakland, CA, USA.

McCarthy, Davis J, and Gordon K Smyth. 2009. “Testing Significance Relative to a Fold-Change Threshold Is a Treat.” *Bioinformatics* 25 (6): 765–71.

Newman, Aaron M, Chih Long Liu, Michael R Green, Andrew J Gentles, Weiguo Feng, Yue Xu, Chuong D Hoang, Maximilian Diehn, and Ash A Alizadeh. 2015. “Robust Enumeration of Cell Subsets from Tissue Expression Profiles.” *Nature Methods* 12 (5): 453–57.

Robinson, Mark D, Davis J McCarthy, and Gordon K Smyth. 2010. “EdgeR: A Bioconductor Package for Differential Expression Analysis of Digital Gene Expression Data.” *Bioinformatics* 26 (1): 139–40.

Subramanian, Aravind, Pablo Tamayo, Vamsi K Mootha, Sayan Mukherjee, Benjamin L Ebert, Michael A Gillette, Amanda Paulovich, et al. 2005. “Gene Set Enrichment Analysis: A Knowledge-Based Approach for Interpreting Genome-Wide Expression Profiles.” *Proceedings of the National Academy of Sciences* 102 (43): 15545–50.

Zhang, Yu, Giovanni Parmigiani, and W Evan Johnson. 2020. “ComBat-Seq: Batch Effect Adjustment for Rna-Seq Count Data.” *NAR Genomics and Bioinformatics* 2 (3): lqaa078.