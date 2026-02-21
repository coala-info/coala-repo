# Overview of the tidySingleCellExperiment package

#### Stefano Mangiola

* [Introduction](#introduction)
* [Installation](#installation)
* [1 Data representation of `tidySingleCellExperiment`](#data-representation-of-tidysinglecellexperiment)
* [2 Annotation polishing](#annotation-polishing)
* [3 Preliminary plots](#preliminary-plots)
* [4 Preprocessing](#preprocessing)
* [5 Clustering](#clustering)
* [6 Combining datasets](#combining-datasets)
* [7 Reduce dimensions](#reduce-dimensions)
* [8 Cell type prediction](#cell-type-prediction)
* [9 Nested analyses](#nested-analyses)
* [10 Aggregating cells](#aggregating-cells)
* [11 Session Info](#session-info)
* [References](#references)

# Introduction

`tidySingleCellExperiment` provides a bridge between Bioconductor single-cell packages (Amezquita et al. 2019) and the *tidyverse* (Wickham et al. 2019). It enables viewing the Bioconductor *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* object as a *tidyverse* `tibble`, and provides `SingleCellExperiment`-compatible *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)*, *[tidyr](https://CRAN.R-project.org/package%3Dtidyr)*, *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* and *[plotly](https://CRAN.R-project.org/package%3Dplotly)* functions (see Table @ref(tab:table)). This allows users to get the best of both Bioconductor and *tidyverse* worlds.

(#tab:table) Available `tidySingleCellExperiment` functions and utilities.

|  |  |
| --- | --- |
| All functions compatible with `SingleCellExperiment`s | After all, a `tidySingleCellExperiment`   is a `SingleCellExperiment`, just better! |
| ***tidyverse*** |  |
| `dplyr` | All `tibble`-compatible   functions (e.g., `select()`) |
| `tidyr` | All `tibble`-compatible   functions (e.g., `pivot_longer()`) |
| `ggplot2` | Plotting with `ggplot()` |
| `plotly` | Plotting with `plot_ly()` |
| **Utilities** |  |
| `as_tibble()` | Convert cell-wise information to a `tbl_df` |
| `join_features()` | Add feature-wise information;   returns a `tidySingleCellExperiment` object |
| `aggregate_cells()` | Aggregate feature abundances as pseudobulks;   returns a `SummarizedExperiment` |

# Installation

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")

BiocManager::install("tidySingleCellExperiment")
```

Load libraries used in this vignette.

```
# Bioconductor single-cell packages
library(scran)
library(scater)
library(igraph)
library(celldex)
library(SingleR)
library(SingleCellSignalR)

# Tidyverse-compatible packages
library(purrr)
library(GGally)
library(tidyHeatmap)

# Both
library(tidySingleCellExperiment)

# Other
library(Matrix)
library(dittoSeq)
```

# 1 Data representation of `tidySingleCellExperiment`

This is a `SingleCellExperiment` object but it is evaluated as a `tibble`. So it is compatible both with `SingleCellExperiment` and *tidyverse*.

```
data(pbmc_small, package="tidySingleCellExperiment")
pbmc_small_tidy <- pbmc_small
```

**It looks like a `tibble`…**

```
pbmc_small_tidy
```

```
## # A SingleCellExperiment-tibble abstraction: 80 × 17
## # [90mFeatures=230 | Cells=80 | Assays=counts, logcounts[0m
##    .cell orig.ident nCount_RNA nFeature_RNA RNA_snn_res.0.8 letter.idents groups
##    <chr> <fct>           <dbl>        <int> <fct>           <fct>         <chr>
##  1 ATGC… SeuratPro…         70           47 0               A             g2
##  2 CATG… SeuratPro…         85           52 0               A             g1
##  3 GAAC… SeuratPro…         87           50 1               B             g2
##  4 TGAC… SeuratPro…        127           56 0               A             g2
##  5 AGTC… SeuratPro…        173           53 0               A             g2
##  6 TCTG… SeuratPro…         70           48 0               A             g1
##  7 TGGT… SeuratPro…         64           36 0               A             g1
##  8 GCAG… SeuratPro…         72           45 0               A             g1
##  9 GATA… SeuratPro…         52           36 0               A             g1
## 10 AATG… SeuratPro…        100           41 0               A             g1
## # ℹ 70 more rows
## # ℹ 10 more variables: RNA_snn_res.1 <fct>, file <chr>, ident <fct>,
## #   PC_1 <dbl>, PC_2 <dbl>, PC_3 <dbl>, PC_4 <dbl>, PC_5 <dbl>, tSNE_1 <dbl>,
## #   tSNE_2 <dbl>
```

**…but it is a `SingleCellExperiment` after all!**

```
counts(pbmc_small_tidy)[1:5, 1:4]
```

```
## 5 x 4 sparse Matrix of class "dgCMatrix"
##         ATGCCAGAACGACT CATGGCCTGTGCAT GAACCTGATGAACC TGACTGGATTCTCA
## MS4A1                .              .              .              .
## CD79B                1              .              .              .
## CD79A                .              .              .              .
## HLA-DRA              .              1              .              .
## TCL1A                .              .              .              .
```

The `SingleCellExperiment` object’s tibble visualisation can be turned off, or back on at any time.

```
# Turn off the tibble visualisation
options("restore_SingleCellExperiment_show" = TRUE)
pbmc_small_tidy
```

```
## class: SingleCellExperiment
## dim: 230 80
## metadata(0):
## assays(2): counts logcounts
## rownames(230): MS4A1 CD79B ... SPON2 S100B
## rowData names(5): vst.mean vst.variance vst.variance.expected
##   vst.variance.standardized vst.variable
## colnames(80): ATGCCAGAACGACT CATGGCCTGTGCAT ... GGAACACTTCAGAC
##   CTTGATTGATCTTC
## colData names(9): orig.ident nCount_RNA ... file ident
```

```
# Turn on the tibble visualisation
options("restore_SingleCellExperiment_show" = FALSE)
```

# 2 Annotation polishing

We may have a column that contains the directory each run was taken from, such as the “file” column in `pbmc_small_tidy`.

```
pbmc_small_tidy$file[1:5]
```

```
## [1] "../data/sample2/outs/filtered_feature_bc_matrix/"
## [2] "../data/sample1/outs/filtered_feature_bc_matrix/"
## [3] "../data/sample2/outs/filtered_feature_bc_matrix/"
## [4] "../data/sample2/outs/filtered_feature_bc_matrix/"
## [5] "../data/sample2/outs/filtered_feature_bc_matrix/"
```

We may want to extract the run/sample name out of it into a separate column. The *tidyverse* function `extract()` can be used to convert a character column into multiple columns using regular expression groups.

```
# Create sample column
pbmc_small_polished <-
    pbmc_small_tidy %>%
    extract(file, "sample", "../data/([a-z0-9]+)/outs.+", remove=FALSE)

# Reorder to have sample column up front
pbmc_small_polished %>%
    select(sample, everything())
```

```
## # A SingleCellExperiment-tibble abstraction: 80 × 18
## # [90mFeatures=230 | Cells=80 | Assays=counts, logcounts[0m
##    .cell sample orig.ident nCount_RNA nFeature_RNA RNA_snn_res.0.8 letter.idents
##    <chr> <chr>  <fct>           <dbl>        <int> <fct>           <fct>
##  1 ATGC… sampl… SeuratPro…         70           47 0               A
##  2 CATG… sampl… SeuratPro…         85           52 0               A
##  3 GAAC… sampl… SeuratPro…         87           50 1               B
##  4 TGAC… sampl… SeuratPro…        127           56 0               A
##  5 AGTC… sampl… SeuratPro…        173           53 0               A
##  6 TCTG… sampl… SeuratPro…         70           48 0               A
##  7 TGGT… sampl… SeuratPro…         64           36 0               A
##  8 GCAG… sampl… SeuratPro…         72           45 0               A
##  9 GATA… sampl… SeuratPro…         52           36 0               A
## 10 AATG… sampl… SeuratPro…        100           41 0               A
## # ℹ 70 more rows
## # ℹ 11 more variables: groups <chr>, RNA_snn_res.1 <fct>, file <chr>,
## #   ident <fct>, PC_1 <dbl>, PC_2 <dbl>, PC_3 <dbl>, PC_4 <dbl>, PC_5 <dbl>,
## #   tSNE_1 <dbl>, tSNE_2 <dbl>
```

# 3 Preliminary plots

Set colours and theme for plots.

```
# Use colourblind-friendly colours
friendly_cols <- dittoSeq::dittoColors()

# Set theme
custom_theme <- list(
    scale_fill_manual(values=friendly_cols),
    scale_color_manual(values=friendly_cols),
    theme_bw() + theme(
        aspect.ratio=1,
        legend.position="bottom",
        axis.line=element_line(),
        text=element_text(size=12),
        panel.border=element_blank(),
        strip.background=element_blank(),
        panel.grid.major=element_line(linewidth=0.2),
        panel.grid.minor=element_line(linewidth=0.1),
        axis.title.x=element_text(margin=margin(t=10, r=10, b=10, l=10)),
        axis.title.y=element_text(margin=margin(t=10, r=10, b=10, l=10))))
```

We can treat `pbmc_small_polished` as a `tibble` for plotting.

Here we plot number of features per cell.

```
pbmc_small_polished %>%
    ggplot(aes(nFeature_RNA, fill=groups)) +
    geom_histogram() +
    custom_theme
```

![](data:image/png;base64...)

Here we plot total features per cell.

```
pbmc_small_polished %>%
    ggplot(aes(groups, nCount_RNA, fill=groups)) +
    geom_boxplot(outlier.shape=NA) +
    geom_jitter(width=0.1) +
    custom_theme
```

![](data:image/png;base64...)

Here we plot abundance of two features for each group.

```
pbmc_small_polished %>%
    join_features(features=c("HLA-DRA", "LYZ"), shape="long") %>%
    ggplot(aes(groups, .abundance_counts + 1, fill=groups)) +
    geom_boxplot(outlier.shape=NA) +
    geom_jitter(aes(size=nCount_RNA), alpha=0.5, width=0.2) +
    scale_y_log10() +
    custom_theme
```

![](data:image/png;base64...)

# 4 Preprocessing

We can also treat `pbmc_small_polished` as a `SingleCellExperiment` object and proceed with data processing with Bioconductor packages, such as *[scran](https://bioconductor.org/packages/3.22/scran)* (Lun, Bach, and Marioni 2016) and *[scater](https://bioconductor.org/packages/3.22/scater)* (McCarthy et al. 2017).

```
# Identify variable genes with scran
variable_genes <-
    pbmc_small_polished %>%
    modelGeneVar() %>%
    getTopHVGs(prop=0.1)

# Perform PCA with scater
pbmc_small_pca <-
    pbmc_small_polished %>%
    runPCA(subset_row=variable_genes)

pbmc_small_pca
```

```
## # A SingleCellExperiment-tibble abstraction: 80 × 18
## # [90mFeatures=230 | Cells=80 | Assays=counts, logcounts[0m
##    .cell orig.ident nCount_RNA nFeature_RNA RNA_snn_res.0.8 letter.idents groups
##    <chr> <fct>           <dbl>        <int> <fct>           <fct>         <chr>
##  1 ATGC… SeuratPro…         70           47 0               A             g2
##  2 CATG… SeuratPro…         85           52 0               A             g1
##  3 GAAC… SeuratPro…         87           50 1               B             g2
##  4 TGAC… SeuratPro…        127           56 0               A             g2
##  5 AGTC… SeuratPro…        173           53 0               A             g2
##  6 TCTG… SeuratPro…         70           48 0               A             g1
##  7 TGGT… SeuratPro…         64           36 0               A             g1
##  8 GCAG… SeuratPro…         72           45 0               A             g1
##  9 GATA… SeuratPro…         52           36 0               A             g1
## 10 AATG… SeuratPro…        100           41 0               A             g1
## # ℹ 70 more rows
## # ℹ 11 more variables: RNA_snn_res.1 <fct>, file <chr>, sample <chr>,
## #   ident <fct>, PC1 <dbl>, PC2 <dbl>, PC3 <dbl>, PC4 <dbl>, PC5 <dbl>,
## #   tSNE_1 <dbl>, tSNE_2 <dbl>
```

If a *tidyverse*-compatible package is not included in the `tidySingleCellExperiment` collection, we can use `as_tibble()` to permanently convert a `tidySingleCellExperiment` into a `tibble`.

```
# Create pairs plot with 'GGally'
pbmc_small_pca %>%
    as_tibble() %>%
    select(contains("PC"), everything()) %>%
    GGally::ggpairs(columns=1:5, aes(colour=groups)) +
    custom_theme
```

![](data:image/png;base64...)

# 5 Clustering

We can proceed with cluster identification with *[scran](https://bioconductor.org/packages/3.22/scran)*.

```
pbmc_small_cluster <- pbmc_small_pca

# Assign clusters to the 'colLabels'
# of the 'SingleCellExperiment' object
colLabels(pbmc_small_cluster) <-
    pbmc_small_pca %>%
    buildSNNGraph(use.dimred="PCA") %>%
    igraph::cluster_walktrap() %$%
    membership %>%
    as.factor()

# Reorder columns
pbmc_small_cluster %>%
    select(label, everything())
```

```
## # A SingleCellExperiment-tibble abstraction: 80 × 19
## # [90mFeatures=230 | Cells=80 | Assays=counts, logcounts[0m
##    .cell  label orig.ident nCount_RNA nFeature_RNA RNA_snn_res.0.8 letter.idents
##    <chr>  <fct> <fct>           <dbl>        <int> <fct>           <fct>
##  1 ATGCC… 2     SeuratPro…         70           47 0               A
##  2 CATGG… 2     SeuratPro…         85           52 0               A
##  3 GAACC… 2     SeuratPro…         87           50 1               B
##  4 TGACT… 1     SeuratPro…        127           56 0               A
##  5 AGTCA… 2     SeuratPro…        173           53 0               A
##  6 TCTGA… 2     SeuratPro…         70           48 0               A
##  7 TGGTA… 1     SeuratPro…         64           36 0               A
##  8 GCAGC… 2     SeuratPro…         72           45 0               A
##  9 GATAT… 2     SeuratPro…         52           36 0               A
## 10 AATGT… 2     SeuratPro…        100           41 0               A
## # ℹ 70 more rows
## # ℹ 12 more variables: groups <chr>, RNA_snn_res.1 <fct>, file <chr>,
## #   sample <chr>, ident <fct>, PC1 <dbl>, PC2 <dbl>, PC3 <dbl>, PC4 <dbl>,
## #   PC5 <dbl>, tSNE_1 <dbl>, tSNE_2 <dbl>
```

And interrogate the output as if it was a regular `tibble`.

```
# Count number of cells for each cluster per group
pbmc_small_cluster %>%
    count(groups, label)
```

We can identify and visualise cluster markers combining `SingleCellExperiment`, *tidyverse* functions and *[tidyHeatmap](https://CRAN.R-project.org/package%3DtidyHeatmap)* (Mangiola and Papenfuss 2020).

```
# Identify top 10 markers per cluster
marker_genes <-
    pbmc_small_cluster %>%
    findMarkers(groups=pbmc_small_cluster$label) %>%
    as.list() %>%
    map(~ .x %>%
        head(10) %>%
        rownames()) %>%
    unlist() %>%
    unique()

# Plot heatmap
pbmc_small_cluster %>%
    join_features(features=marker_genes, shape="long") %>%
    group_by(label) %>%
    heatmap(
        .row=.feature, .column=.cell,
        .value=.abundance_counts, scale="column")
```

![](data:image/png;base64...)

# 6 Combining datasets

We can use `append_samples()` to combine multiple SingleCellExperiment objects by samples. This is useful when you have multiple datasets that you want to analyze together.

```
# Create two subsets of the data
pbmc_subset1 <- pbmc_small_cluster %>%
    filter(groups == "g1")

pbmc_subset2 <- pbmc_small_cluster %>%
    filter(groups == "g2")

# Combine them using append_samples
combined_data <- append_samples(pbmc_subset1, pbmc_subset2)
combined_data
```

```
## # A SingleCellExperiment-tibble abstraction: 80 × 19
## # [90mFeatures=230 | Cells=80 | Assays=counts, logcounts[0m
##    .cell orig.ident nCount_RNA nFeature_RNA RNA_snn_res.0.8 letter.idents groups
##    <chr> <fct>           <dbl>        <int> <fct>           <fct>         <chr>
##  1 CATG… SeuratPro…         85           52 0               A             g1
##  2 TCTG… SeuratPro…         70           48 0               A             g1
##  3 TGGT… SeuratPro…         64           36 0               A             g1
##  4 GCAG… SeuratPro…         72           45 0               A             g1
##  5 GATA… SeuratPro…         52           36 0               A             g1
##  6 AATG… SeuratPro…        100           41 0               A             g1
##  7 AGAG… SeuratPro…        191           61 0               A             g1
##  8 CTAA… SeuratPro…        168           44 0               A             g1
##  9 TTGG… SeuratPro…        135           45 0               A             g1
## 10 CATC… SeuratPro…         79           43 0               A             g1
## # ℹ 70 more rows
## # ℹ 12 more variables: RNA_snn_res.1 <fct>, file <chr>, sample <chr>,
## #   ident <fct>, label <fct>, PC1 <dbl>, PC2 <dbl>, PC3 <dbl>, PC4 <dbl>,
## #   PC5 <dbl>, tSNE_1 <dbl>, tSNE_2 <dbl>
```

# 7 Reduce dimensions

We can calculate the first 3 UMAP dimensions using *[scater](https://bioconductor.org/packages/3.22/scater)*.

```
pbmc_small_UMAP <-
    pbmc_small_cluster %>%
    runUMAP(ncomponents=3)
```

And we can plot the result in 3D using *[plotly](https://CRAN.R-project.org/package%3Dplotly)*.

```
pbmc_small_UMAP %>%
    plot_ly(
        x=~`UMAP1`,
        y=~`UMAP2`,
        z=~`UMAP3`,
        color=~label,
        colors=friendly_cols[1:4])
```

![](data:image/png;base64...)

plotly screenshot

# 8 Cell type prediction

We can infer cell type identities using *[SingleR](https://bioconductor.org/packages/3.22/SingleR)* (Aran et al. 2019) and manipulate the output using *tidyverse*.

```
# Get cell type reference data
blueprint <- celldex::BlueprintEncodeData()

# Infer cell identities
cell_type_df <-
    logcounts(pbmc_small_UMAP) %>%
    Matrix::Matrix(sparse = TRUE) %>%
    SingleR::SingleR(
        ref=blueprint,
        labels=blueprint$label.main,
        method="single") %>%
    as.data.frame() %>%
    as_tibble(rownames="cell") %>%
    select(cell, first.labels)
```

```
# Join UMAP and cell type info
data(cell_type_df)
pbmc_small_cell_type <-
    pbmc_small_UMAP %>%
    left_join(cell_type_df, by="cell")

# Reorder columns
pbmc_small_cell_type %>%
    select(cell, first.labels, everything())
```

```
## # A SingleCellExperiment-tibble abstraction: 80 × 23
## # [90mFeatures=230 | Cells=80 | Assays=counts, logcounts[0m
##    cell          first.labels orig.ident nCount_RNA nFeature_RNA RNA_snn_res.0.8
##    <chr>         <chr>        <fct>           <dbl>        <int> <fct>
##  1 ATGCCAGAACGA… CD4+ T-cells SeuratPro…         70           47 0
##  2 CATGGCCTGTGC… CD8+ T-cells SeuratPro…         85           52 0
##  3 GAACCTGATGAA… CD8+ T-cells SeuratPro…         87           50 1
##  4 TGACTGGATTCT… CD4+ T-cells SeuratPro…        127           56 0
##  5 AGTCAGACTGCA… CD4+ T-cells SeuratPro…        173           53 0
##  6 TCTGATACACGT… CD4+ T-cells SeuratPro…         70           48 0
##  7 TGGTATCTAAAC… CD4+ T-cells SeuratPro…         64           36 0
##  8 GCAGCTCTGTTT… CD4+ T-cells SeuratPro…         72           45 0
##  9 GATATAACACGC… CD4+ T-cells SeuratPro…         52           36 0
## 10 AATGTTGACAGT… CD4+ T-cells SeuratPro…        100           41 0
## # ℹ 70 more rows
## # ℹ 17 more variables: letter.idents <fct>, groups <chr>, RNA_snn_res.1 <fct>,
## #   file <chr>, sample <chr>, ident <fct>, label <fct>, PC1 <dbl>, PC2 <dbl>,
## #   PC3 <dbl>, PC4 <dbl>, PC5 <dbl>, tSNE_1 <dbl>, tSNE_2 <dbl>, UMAP1 <dbl>,
## #   UMAP2 <dbl>, UMAP3 <dbl>
```

We can easily summarise the results. For example, we can see how cell type classification overlaps with cluster classification.

```
# Count number of cells for each cell type per cluster
pbmc_small_cell_type %>%
    count(label, first.labels)
```

We can easily reshape the data for building information-rich faceted plots.

```
pbmc_small_cell_type %>%
    # Reshape and add classifier column
    pivot_longer(
        cols=c(label, first.labels),
        names_to="classifier", values_to="label") %>%
    # UMAP plots for cell type and cluster
    ggplot(aes(UMAP1, UMAP2, color=label)) +
    facet_wrap(~classifier) +
    geom_point() +
    custom_theme
```

![](data:image/png;base64...)

We can easily plot gene correlation per cell category, adding multi-layer annotations.

```
pbmc_small_cell_type %>%
    # Add some mitochondrial abundance values
    mutate(mitochondrial=rnorm(dplyr::n())) %>%
    # Plot correlation
    join_features(features=c("CST3", "LYZ"), shape="wide") %>%
    ggplot(aes(CST3+1, LYZ+1, color=groups, size=mitochondrial)) +
    facet_wrap(~first.labels, scales="free") +
    geom_point() +
    scale_x_log10() +
    scale_y_log10() +
    custom_theme
```

![](data:image/png;base64...)

# 9 Nested analyses

A powerful tool we can use with `tidySingleCellExperiment` is *tidyverse*’s `nest()`. We can easily perform independent analyses on subsets of the dataset. First, we classify cell types into lymphoid and myeloid, and then `nest()` based on the new classification.

```
pbmc_small_nested <-
    pbmc_small_cell_type %>%
    filter(first.labels != "Erythrocytes") %>%
    mutate(cell_class=if_else(
        first.labels %in% c("Macrophages", "Monocytes"),
        true="myeloid", false="lymphoid")) %>%
    nest(data=-cell_class)

pbmc_small_nested
```

Now we can independently for the lymphoid and myeloid subsets (i) find variable features, (ii) reduce dimensions, and (iii) cluster using both tidyverse and SingleCellExperiment seamlessly.

```
pbmc_small_nested_reanalysed <-
    pbmc_small_nested %>%
    mutate(data=map(data, ~ {
        # feature selection
        variable_genes <- .x %>%
            modelGeneVar() %>%
            getTopHVGs(prop=0.3)
        # dimension reduction
        .x <- .x %>%
            runPCA(subset_row=variable_genes) %>%
            runUMAP(ncomponents=3)
        # clustering
        colLabels(.x) <- .x %>%
            buildSNNGraph(use.dimred="PCA") %>%
            cluster_walktrap() %$%
            membership %>%
            as.factor()
        return(.x)
    }))
pbmc_small_nested_reanalysed
```

We can then `unnest()` and plot the new classification.

```
pbmc_small_nested_reanalysed %>%
    # Convert to 'tibble', else 'SingleCellExperiment'
    # drops reduced dimensions when unifying data sets.
    mutate(data=map(data, ~as_tibble(.x))) %>%
    unnest(data) %>%
    # Define unique clusters
    unite("cluster", c(cell_class, label), remove=FALSE) %>%
    # Plotting
    ggplot(aes(UMAP1, UMAP2, color=cluster)) +
    facet_wrap(~cell_class) +
    geom_point() +
    custom_theme
```

![](data:image/png;base64...)

We can perform a large number of functional analyses on data subsets. For example, we can identify intra-sample cell-cell interactions using `SingleCellSignalR` (Cabello-Aguilar et al. 2020), and then compare whether interactions are stronger or weaker across conditions. The code below demonstrates how this analysis could be performed. It won’t work with this small example dataset as we have just two samples (one for each condition). But some example output is shown below and you can imagine how you can use tidyverse on the output to perform t-tests and visualisation.

```
pbmc_small_nested_interactions <-
    pbmc_small_nested_reanalysed %>%
    # Unnest based on cell category
    unnest(data) %>%
    # Create unambiguous clusters
    mutate(integrated_clusters=first.labels %>% as.factor() %>% as.integer()) %>%
    # Nest based on sample
    nest(data=-sample) %>%
    mutate(interactions=map(data, ~ {
        # Produce variables. Yuck!
        cluster <- colData(.x)$integrated_clusters
        data <- data.frame(assay(.x) %>% as.matrix())
        # Ligand/Receptor analysis using 'SingleCellSignalR'
        data %>%
            cell_signaling(genes=rownames(data), cluster=cluster) %>%
            inter_network(data=data, signal=., genes=rownames(data), cluster=cluster) %$%
            `individual-networks` %>%
            map_dfr(~ append_samples(as_tibble(.x)))
    }))

pbmc_small_nested_interactions %>%
    select(-data) %>%
    unnest(interactions)
```

If the dataset was not so small, and interactions could be identified, you would see something like below.

```
data(pbmc_small_nested_interactions)
pbmc_small_nested_interactions
```

# 10 Aggregating cells

Sometimes, it is necessary to aggregate the gene-transcript abundance from a group of cells into a single value. For example, when comparing groups of cells across different samples with fixed-effect models.

In `tidySingleCellExperiment`, cell aggregation can be achieved using `aggregate_cells()`, which will return an object of class *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*.

```
pbmc_small_tidy %>%
  aggregate_cells(groups, assays="counts")
```

```
## class: SummarizedExperiment
## dim: 230 2
## metadata(0):
## assays(1): counts
## rownames(230): ACAP1 ACRBP ... ZNF330 ZNF76
## rowData names(5): vst.mean vst.variance vst.variance.expected
##   vst.variance.standardized vst.variable
## colnames(2): g1 g2
## colData names(4): .aggregated_cells groups orig.ident file
```

# 11 Session Info

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
##  [1] dittoSeq_1.22.0                 Matrix_1.7-4
##  [3] tidyr_1.3.1                     dplyr_1.1.4
##  [5] tidySingleCellExperiment_1.20.1 ttservice_0.5.3
##  [7] tidyHeatmap_1.13.1              GGally_2.4.0
##  [9] purrr_1.2.0                     SingleCellSignalR_2.0.1
## [11] SingleR_2.12.0                  celldex_1.20.0
## [13] igraph_2.2.1                    scater_1.38.0
## [15] ggplot2_4.0.0                   scran_1.38.0
## [17] scuttle_1.20.0                  SingleCellExperiment_1.32.0
## [19] SummarizedExperiment_1.40.0     Biobase_2.70.0
## [21] GenomicRanges_1.62.0            Seqinfo_1.0.0
## [23] IRanges_2.44.0                  S4Vectors_0.48.0
## [25] BiocGenerics_0.56.0             generics_0.1.4
## [27] MatrixGenerics_1.22.0           matrixStats_1.5.0
## [29] knitr_1.50
##
## loaded via a namespace (and not attached):
##   [1] fs_1.6.6                  bitops_1.0-9
##   [3] httr_1.4.7                RColorBrewer_1.1-3
##   [5] doParallel_1.0.17         tools_4.5.1
##   [7] backports_1.5.0           alabaster.base_1.10.0
##   [9] utf8_1.2.6                R6_2.6.1
##  [11] HDF5Array_1.38.0          uwot_0.2.4
##  [13] lazyeval_0.2.2            rhdf5filters_1.22.0
##  [15] GetoptLong_1.0.5          withr_3.0.2
##  [17] gridExtra_2.3             cli_3.6.5
##  [19] Cairo_1.7-0               labeling_0.4.3
##  [21] alabaster.se_1.10.0       sass_0.4.10
##  [23] S7_0.2.0                  ggridges_0.5.7
##  [25] systemfonts_1.3.1         yulab.utils_0.2.1
##  [27] dichromat_2.0-0.1         orthogene_1.16.0
##  [29] limma_3.66.0              RSQLite_2.4.4
##  [31] FNN_1.1.4.1               gridGraphics_0.5-1
##  [33] shape_1.4.6.1             car_3.1-3
##  [35] dendextend_1.19.1         homologene_1.4.68.19.3.27
##  [37] fansi_1.0.6               ggbeeswarm_0.7.2
##  [39] abind_1.4-8               lifecycle_1.0.4
##  [41] yaml_2.3.10               edgeR_4.8.0
##  [43] carData_3.0-5             rhdf5_2.54.0
##  [45] SparseArray_1.10.1        BiocFileCache_3.0.0
##  [47] Rtsne_0.17                grid_4.5.1
##  [49] blob_1.2.4                dqrng_0.4.1
##  [51] ExperimentHub_3.0.0       crayon_1.5.3
##  [53] lattice_0.22-7            cowplot_1.2.0
##  [55] beachmat_2.26.0           KEGGREST_1.50.0
##  [57] magick_2.9.0              pillar_1.11.1
##  [59] ComplexHeatmap_2.26.0     metapod_1.18.0
##  [61] rjson_0.2.23              codetools_0.2-20
##  [63] glue_1.8.0                ggiraph_0.9.2
##  [65] ggfun_0.2.0               fontLiberation_0.1.0
##  [67] data.table_1.17.8         vctrs_0.6.5
##  [69] png_0.1-8                 gypsum_1.6.0
##  [71] treeio_1.34.0             gtable_0.3.6
##  [73] cachem_1.1.0              xfun_0.54
##  [75] S4Arrays_1.10.0           survival_3.8-3
##  [77] pheatmap_1.0.13           BulkSignalR_1.2.1
##  [79] iterators_1.0.14          statmod_1.5.1
##  [81] bluster_1.20.0            ellipsis_0.3.2
##  [83] nlme_3.1-168              ggtree_4.0.1
##  [85] bit64_4.6.0-1             fontquiver_0.2.1
##  [87] alabaster.ranges_1.10.0   filelock_1.0.3
##  [89] bslib_0.9.0               irlba_2.3.5.1
##  [91] vipor_0.4.7               colorspace_2.1-2
##  [93] DBI_1.2.3                 tidyselect_1.2.1
##  [95] bit_4.6.0                 compiler_4.5.1
##  [97] curl_7.0.0                glmnet_4.1-10
##  [99] httr2_1.2.1               BiocNeighbors_2.4.0
## [101] matrixTests_0.2.3.1       h5mread_1.2.0
## [103] fontBitstreamVera_0.1.1   DelayedArray_0.36.0
## [105] plotly_4.11.0             scales_1.4.0
## [107] rappdirs_0.3.3            stringr_1.6.0
## [109] SpatialExperiment_1.20.0  digest_0.6.37
## [111] alabaster.matrix_1.10.0   rmarkdown_2.30
## [113] XVector_0.50.0            htmltools_0.5.8.1
## [115] pkgconfig_2.0.3           sparseMatrixStats_1.22.0
## [117] stabledist_0.7-2          dbplyr_2.5.1
## [119] fastmap_1.2.0             rlang_1.1.6
## [121] GlobalOptions_0.1.2       htmlwidgets_1.6.4
## [123] prettydoc_0.4.1           DelayedMatrixStats_1.32.0
## [125] farver_2.1.2              jquerylib_0.1.4
## [127] jsonlite_2.0.0            BiocParallel_1.44.0
## [129] BiocSingular_1.26.0       RCurl_1.98-1.17
## [131] magrittr_2.0.4            Formula_1.2-5
## [133] ggplotify_0.1.3           patchwork_1.3.2
## [135] Rhdf5lib_1.32.0           Rcpp_1.1.0
## [137] ape_5.8-1                 babelgene_22.9
## [139] viridis_0.6.5             gdtools_0.4.4
## [141] stringi_1.8.7             alabaster.schemas_1.10.0
## [143] ggalluvial_0.12.5         MASS_7.3-65
## [145] AnnotationHub_4.0.0       ggstats_0.11.0
## [147] parallel_4.5.1            ggrepel_0.9.6
## [149] Biostrings_2.78.0         splines_4.5.1
## [151] multtest_2.66.0           circlize_0.4.16
## [153] locfit_1.5-9.12           ggpubr_0.6.2
## [155] ggsignif_0.6.4            ScaledMatrix_1.18.0
## [157] gprofiler2_0.2.3          BiocVersion_3.22.0
## [159] evaluate_1.0.5            BiocManager_1.30.26
## [161] foreach_1.5.2             grr_0.9.5
## [163] RANN_2.6.2                clue_0.3-66
## [165] rsvd_1.0.5                broom_1.0.10
## [167] RSpectra_0.16-2           tidytree_0.4.6
## [169] rstatix_0.7.3             viridisLite_0.4.2
## [171] tibble_3.3.0              aplot_0.2.9
## [173] memoise_2.0.1             beeswarm_0.4.0
## [175] AnnotationDbi_1.72.0      cluster_2.1.8.1
## [177] BiocStyle_2.38.0
```

# References

Amezquita, Robert A, Aaron TL Lun, Etienne Becht, Vince J Carey, Lindsay N Carpp, Ludwig Geistlinger, Federico Martini, et al. 2019. “Orchestrating Single-Cell Analysis with Bioconductor.” *Nature Methods*, 1–9.

Aran, Dvir, Agnieszka P Looney, Leqian Liu, Esther Wu, Valerie Fong, Austin Hsu, Suzanna Chak, et al. 2019. “Reference-Based Analysis of Lung Single-Cell Sequencing Reveals a Transitional Profibrotic Macrophage.” *Nature Immunology* 20 (2): 163–72.

Cabello-Aguilar, Simon, Mélissa Alame, Fabien Kon-Sun-Tack, Caroline Fau, Matthieu Lacroix, and Jacques Colinge. 2020. “SingleCellSignalR: Inference of Intercellular Networks from Single-Cell Featureomics.” *Nucleic Acids Research* 48 (10): e55–e55.

Lun, Aaron TL, Karsten Bach, and John C Marioni. 2016. “Pooling Across Cells to Normalize Single-Cell Rna Sequencing Data with Many Zero Counts.” *Genome Biology* 17 (1): 75.

Mangiola, Stefano, and Anthony T Papenfuss. 2020. “TidyHeatmap: An R Package for Modular Heatmap Production Based on Tidy Principles.” *Journal of Open Source Software* 5 (52): 2472.

McCarthy, Davis J, Kieran R Campbell, Aaron TL Lun, and Quin F Wills. 2017. “Scater: Pre-Processing, Quality Control, Normalization and Visualization of Single-Cell Rna-Seq Data in R.” *Bioinformatics* 33 (8): 1179–86.

Wickham, Hadley, Mara Averick, Jennifer Bryan, Winston Chang, Lucy D’Agostino McGowan, Romain François, Garrett Grolemund, et al. 2019. “Welcome to the Tidyverse.” *Journal of Open Source Software* 4 (43): 1686.