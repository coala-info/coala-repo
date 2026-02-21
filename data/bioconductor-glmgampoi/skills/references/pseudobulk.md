# Pseudobulk and differential expression

Constantin Ahlmann-Eltze

#### 2025-10-30

# Contents

* [1 Pseudobulk](#pseudobulk)
* [2 Example](#example)
* [3 Legacy](#legacy)

# 1 Pseudobulk

A pseudobulk sample is formed by aggregating the expression values from a group of cells from the same individual. The cells are typically grouped by clustering or cell type assignment. Individual refers to the experimental unit of replication (e.g., the individual mice or patients).

Forming pseudobulk samples is important to perform accurate differential expression analysis. Cells from the same individual are more similar to each other than to cells from another individual. This means treating each cell as an independent sample leads to underestimation of the variance and misleadingly small p-values. Working on the level of pseudobulks ensures reliable statistical tests because the samples correspond to the units of replication.

We can use pseudobulks for example to find the expression changes between two conditions for one cell type.

# 2 Example

![](data:image/png;base64...)

I load a `SingleCellExperiment` object containing gene expression counts from eight Lupus patient before and after interferon beta stimulation. The creator of the dataset has already annotated the cell types and if cell is a singlet.

```
sce <- muscData::Kang18_8vs8()
#> see ?muscData and browseVignettes('muscData') for documentation
#> loading from cache
# Keep only genes with more than 5 counts
sce <- sce[rowSums(counts(sce)) > 5,]
colData(sce)
#> DataFrame with 29065 rows and 5 columns
#>                        ind     stim   cluster            cell multiplets
#>                  <integer> <factor> <integer>        <factor>   <factor>
#> AAACATACAATGCC-1       107     ctrl         5 CD4 T cells        doublet
#> AAACATACATTTCC-1      1016     ctrl         9 CD14+ Monocytes    singlet
#> AAACATACCAGAAA-1      1256     ctrl         9 CD14+ Monocytes    singlet
#> AAACATACCAGCTA-1      1256     ctrl         9 CD14+ Monocytes    doublet
#> AAACATACCATGCA-1      1488     ctrl         3 CD4 T cells        singlet
#> ...                    ...      ...       ...             ...        ...
#> TTTGCATGCTAAGC-1       107     stim         6     CD4 T cells    singlet
#> TTTGCATGGGACGA-1      1488     stim         6     CD4 T cells    singlet
#> TTTGCATGGTGAGG-1      1488     stim         6     CD4 T cells    ambs
#> TTTGCATGGTTTGG-1      1244     stim         6     CD4 T cells    ambs
#> TTTGCATGTCTTAC-1      1016     stim         5     CD4 T cells    singlet
```

The `pseudobulk` functions emulates the `group_by` and `summarize` pattern popularized by the `tidyverse`.
You provide the columns from the `colData` that you want to use for grouping the data (akin to `group_by`) and named arguments specifiying how you summarize the remaining columns (akin to `summarize`). Using the `aggregation_functions` you can set how the `assay`’s and `reducedDim`’s are summarized with a named list.

Here, I create a pseudobulk sample for each patient, condition, and cell type. This means for example that the counts of the 119 B-cells from patient 101 in the control condition are summed to one column in the reduced dataset.

The first argument is a `SingleCellExperiment` object. The `group_by` argument uses `vars()` to quote the grouping columns The `fraction_singlet` and `n_cells` arguments demonstrate how additional columns from the `colData` are summarized. For `fraction_singlet`, I use the fact that `mean` automatically coerces a boolean vector to zeros and ones and `n_cells` demonstrates the `n()` function that returns the number of cells that are aggregated for each group.

```
library(glmGamPoi)
reduced_sce <- pseudobulk(sce, group_by = vars(ind, condition = stim, cell),
                          fraction_singlet = mean(multiplets == "singlet"), n_cells = n())
#> Aggregating assay 'counts' using 'rowSums2'.
#> Aggregating reducedDim 'TSNE' using 'rowMeans2'.
colData(reduced_sce)
#> DataFrame with 132 rows and 5 columns
#>                                 ind condition            cell fraction_singlet
#>                           <integer>  <factor>        <factor>        <numeric>
#> 107.ctrl.CD4 T cells            107      ctrl CD4 T cells             0.793970
#> 1016.ctrl.CD14+ Monocytes      1016      ctrl CD14+ Monocytes         0.800434
#> 1256.ctrl.CD14+ Monocytes      1256      ctrl CD14+ Monocytes         0.831557
#> 1488.ctrl.CD4 T cells          1488      ctrl CD4 T cells             0.867205
#> 1039.ctrl.Dendritic cells      1039      ctrl Dendritic cells         0.900000
#> ...                             ...       ...             ...              ...
#> 1256.stim.Megakaryocytes       1256      stim  Megakaryocytes         0.708333
#> 1244.stim.Megakaryocytes       1244      stim  Megakaryocytes         0.764706
#> 107.stim.CD8 T cells            107      stim  CD8 T cells            0.652174
#> 101.stim.Megakaryocytes         101      stim  Megakaryocytes         1.000000
#> 1256.stim.NA                   1256      stim  NA                     0.000000
#>                             n_cells
#>                           <integer>
#> 107.ctrl.CD4 T cells            199
#> 1016.ctrl.CD14+ Monocytes       461
#> 1256.ctrl.CD14+ Monocytes       469
#> 1488.ctrl.CD4 T cells          1363
#> 1039.ctrl.Dendritic cells        10
#> ...                             ...
#> 1256.stim.Megakaryocytes         24
#> 1244.stim.Megakaryocytes         17
#> 107.stim.CD8 T cells             23
#> 101.stim.Megakaryocytes           9
#> 1256.stim.NA                      1
```

You can simulate the pseudobulk sample generation and check if you are using the correct arguments by calling `dplyr::group_by`. Note that the order of the output differs because `group_by` automatically sorts the keys.

```
library(dplyr, warn.conflicts = FALSE)
colData(sce) %>%
  as_tibble() %>%
  group_by(ind, condition = stim, cell) %>%
  summarize(n_cells = n(), .groups = "drop")
#> # A tibble: 132 × 4
#>      ind condition cell              n_cells
#>    <int> <fct>     <fct>               <int>
#>  1   101 ctrl      B cells               119
#>  2   101 ctrl      CD14+ Monocytes       247
#>  3   101 ctrl      CD4 T cells           341
#>  4   101 ctrl      CD8 T cells            99
#>  5   101 ctrl      Dendritic cells        25
#>  6   101 ctrl      FCGR3A+ Monocytes      96
#>  7   101 ctrl      Megakaryocytes         16
#>  8   101 ctrl      NK cells               84
#>  9   101 stim      B cells               151
#> 10   101 stim      CD14+ Monocytes       302
#> # ℹ 122 more rows
```

With the reduced data, we can conduct differential expression analysis the same way we would analyze bulk RNA-seq data (using tools like `DESeq2` and `edgeR`).
For example we can find the genes that change most upon treatment in the B-cells

```
# Remove NA's
reduced_sce <- reduced_sce[,!is.na(reduced_sce$cell)]
# Use DESeq2's size factor calculation procedure
fit <- glm_gp(reduced_sce, design = ~ condition*cell + ind, size_factor = "ratio", verbose = TRUE)
#> Calculate Size Factors (ratio)
#> Make initial dispersion estimate
#> Make initial beta estimate
#> Estimate beta
#> Estimate dispersion
#> Fit dispersion trend
#> Shrink dispersion estimates
#> Estimate beta again
res <- test_de(fit, contrast = cond(cell = "B cells", condition = "stim") - cond(cell = "B cells", condition = "ctrl"))
```

A volcano plot gives a quick impression of the overall distribution of the expression changes.

```
library(ggplot2, warn.conflicts = FALSE)
ggplot(res, aes(x = lfc, y = - log10(pval))) +
  geom_point(aes(color = adj_pval < 0.01), size = 0.5)
```

![](data:image/png;base64...)

# 3 Legacy

Originally, `glmGamPoi`’s API encouraged forming pseudobulks after fitting the model (i.e., within `test_de()`). The advantage was that this reduced the number of functions. Yet, internally `glmGamPoi` basically threw away the original fit and re-ran it on the aggregated data. This meant that computation time was wasted. Thus the original approach forming the pseudobulk in `test_de` is now deprecated in favor of first calling `pseudobulk()` and then proceed by calling `glm_gp()` and `test_de()` on the aggregated data.