# 2. Simulating Multimodal Single-cell Datasets

In this tutorial, we will demonstrate how to use scMultiSim to simulate multi-omics data
with different biological effects, including:

* Simulating true RNA counts and ATAC-seq data
* Controlling the cell population and GRN effects
* Adding technical variation and batch effect to the true counts
* Adjusting the parameters to control different biological effects

We first load the package:

```
library("scMultiSim")
```

# Simulating True Counts

scMultiSim first generates the true RNA counts, and then add technical variation and batch effect to the true counts.
To simulate true counts, call `sim_true_counts(options)` where `options` is a
list. You can use `scmultisim_help()` to get help on the options,
or like `scmulti_help("num.cells")` to get help on the options for a specific function.

```
scmultisim_help("options")
```

## GRN and Differentiation Tree

Before start, we define a utility function to modify a list.

```
library(dplyr)
```

```
list_modify <- function (curr_list, ...) {
  args <- list(...)
  for (i in names(args)) {
    curr_list[[i]] <- args[[i]]
  }
  curr_list
}
```

The minimal input to scMultiSim is a **differentiation tree**, and you can optionally provide
ground truth for GRN and cell-cell interactions.
The differentiation tree is an R phylo object, which can be created using e.g.
`ape::read.tree()` or `ape::rtree()`.
It controls the cell population structure: each node of the tree should represent a cell type,
and connected nodes indicate the differentiation relationship between cell types.
*scMultiSim provides this explicit control on the cell population structure
while preserving all other effects (such as GRN and Cell-Cell Interactions)*,
so you can generate any cell trajectory or clustering structure you want, which is especially useful
for benchmarking trajectory inference and clustering methods.

If generating a continuous population, this tree
specifies the cell differentiation trajectory; if generating a discrete population, the
tips of this tree will be the clusters (cell types are the terminal cell states).

scMultiSim also provides three differentiation trees.
`Phyla5()` and `Phyla3()` return bifurcating trees with 5 and 3 leaves respectively.
`Phyla1()` returns only a single branch, which can be useful when we don’t want any specific trajectory.

```
par(mfrow=c(1,2))
Phyla5(plotting = TRUE)
```

```
##
## Phylogenetic tree with 5 tips and 4 internal nodes.
##
## Tip labels:
##   1, 2, 3, 4, 5
##
## Rooted; includes branch length(s).
```

```
Phyla3(plotting = TRUE)
```

![plot of chunk plot-tree](data:image/png;base64...)

```
##
## Phylogenetic tree with 3 tips and 2 internal nodes.
##
## Tip labels:
##   1, 2, 3
##
## Rooted; includes branch length(s).
```

```
# It's not possible to plot Phyla1() because it only contains 1 branch connecting two nodes.
Phyla1()
```

```
##
## Phylogenetic tree with 1 tip and 1 internal node.
##
## Tip label:
##   A
##
## Rooted; includes branch length(s).
```

If you only need `n` cell clusters without any specific trajectory, you can use code like below to generate a simple tree with `n` leaves.

```
# tree with four leaves
ape::read.tree(text = "(A:1,B:1,C:1,D:1);")
```

```
##
## Phylogenetic tree with 4 tips and 1 internal node.
##
## Tip labels:
##   A, B, C, D
##
## Unrooted; includes branch length(s).
```

The GRN should be a data frame with 3 columns, each representing the `target`, `regulator`, and `effect`.
The target and regulator should be gene names, which can be integers or strings.
The effect should be a numeric value, indicating the effect of the regulator on the target.

scMultiSim provides two sample GRNs, `GRN_params_100` and `GRN_params_1139`,
which contain 100 and 1139 genes respectively.
Let’s load them first.

```
data(GRN_params_100)
GRN_params <- GRN_params_100
head(GRN_params)
```

```
##   regulated.gene regulator.gene regulator.effect
## 1             16             10         1.768699
## 2             29             10         1.675360
## 3             62             10         3.723509
## 4             55             10         2.866182
## 5             81             80         4.020744
## 6             73             80         2.353371
```

## Simulating True Counts

Now, we create the options list for the simulation session.
In the following example, we simulate 500 cells with 50 CIFs.

The number of genes is determined by the option `num.genes` or the number of genes in the GRN.
If `num.genes` is not specified, the number of genes will be the number of unique genes in the GRN,
plus a fraction of genes that are not regulated by any other genes.
this is controlled by the option `unregulated.gene.ratio` (default is 0.1).
Since our `GRN_params` contains 100 gene names, 10% more genes will be added to the simulation,
and the number of genes in the simulated data will be 110.
If you don’t need to simulate GRN effects, simply set `GRN = NA`.

The `cif.sigma` controls the variance of the CIFs. Usually, with `cif.sigma` = 0.1,
the trajectory will be very clear, while with `cif.sigma` = 1, the trajectory will be more
noisy. We use `cif.sigma` = 0.5 in this example.

We also have `do.velocity` option to use the Kinetic model to simulate RNA velocity data.

```
set.seed(42)

options <- list(
  GRN = GRN_params,
  num.cells = 300,
  num.cifs = 20,
  cif.sigma = 1,
  tree = Phyla5(),
  diff.cif.fraction = 0.8,
  do.velocity = TRUE
)
```

### Omitting the GRN

Note that the minimal input to scMultiSim is the cell population structure (differentiation tree) and number of cells.
You can omit the GRN by using `GRN = NA`:

```
options <- list(
  GRN = NA
  num.cells = 1000,
  num.genes = 500,
  tree = Phyla5(),
)
```

### Running the Simulation

Now we run the simulation and check what kind of data is in the returned result:

```
results <- sim_true_counts(options)
```

```
## Time spent: 0.18 mins
```

```
names(results)
```

```
##  [1] ".grn"             "unspliced_counts" ".options"         ".n"
##  [5] "region_to_gene"   "atacseq_data"     "giv"              "kinetic_params"
##  [9] "num_genes"        "velocity"         "cif"              "hge_scale"
## [13] "counts"           "cell_meta"        "atac_counts"      "region_to_tf"
## [17] "grn_params"       "cell_time"
```

## Accessing the Results

The return value will be a `scMultiSim Environment` object,
and you can access various data and parameters using the `$` operator.

* `counts`: Gene-by-cell scRNA-seq counts.
* `atac_counts`: Region-by-cell scATAC-seq counts.
* `region_to_gene`: Region-by-gene 0-1 marix indicating the corresponding relationship between chtomatin regions and genes.
* `atacseq_data`: The “clean” scATAC-seq counts without added intrinsic noise.
* `cell_meta`: A dataframe containing cell type labels and pseudotime information.
* `cif`: The CIF used during the simulation.
* `giv`: The GIV used during the simulation.
* `kinetic_params`: The kinetic parameters used during the simulation.
* `.grn`: The GRN used during the simulation.
* `.grn$regulators`: The list of TFs used by all gene-by-TF matrices.
* `.grn$geff`: Gene-by-TF matrix representing the GRN used during the simulation.
* `.n`: Other metadata, e.g. `.n$cells` is the number of cells.

If `do.velocity` is enabled, it has these additional fields:

* `unspliced_counts`: Gene-by-cell unspliced RNA counts.
* `velocity`: Gene-by-cell RNA velocity ground truth.
* `cell_time`: The pseudotime at which the cell counts were generated.

If dynamic GRN is enabled, it has these additional fields:

* `cell_specific_grn`: A list of length `n_cells`. Each element is a gene-by-TF matrix, indicating the cell’s GRN.

If cell-cell interaction is enabled, it has these additional fields:

* `grid`: The grid object used during the simulation.
* `grid$get_neighbours(i)`: Get the neighbour cells of cell `i`.
* `cci_locs`: A dataframe containing the X and Y coordinates of each cell.
* `cci_cell_type_param`: A dataframe containing the CCI network ground truth: all ligand-receptor pairs between each pair of cell types.
* `cci_cell_types`: For continuous cell population, the sub-divided cell types along the trajectory used when simulating CCI.

If it is a debug session (`debug = TRUE`), a `sim` field is available,
which is an environment contains all internal states and data structures.

## Visualizing the Results

We can visualize the true counts and ATAC-seq data using `plot_tsne()`:

```
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'True RNA Counts Tsne')
```

![plot of chunk plot-counts](data:image/png;base64...)

plot of chunk plot-counts

```
plot_tsne(log2(results$atacseq_data + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'True ATAC-seq Tsne')
```

![plot of chunk plot-counts](data:image/png;base64...)

plot of chunk plot-counts

Since we also have RNA velocity enabled, the `results` also contains the following data:

* `velocity`: the true RNA velocity (genes x cells)
* `unspliced_counts`: the true unspliced RNA counts (genes x cells)

```
plot_rna_velocity(results, arrow.length = 2)
```

```
## $raw
```

![plot of chunk plot-velocity](data:image/png;base64...)

plot of chunk plot-velocity

```
##
## $normalized
```

![plot of chunk plot-velocity](data:image/png;base64...)

plot of chunk plot-velocity

```
##
## $knn_normalized
```

![plot of chunk plot-velocity](data:image/png;base64...)

plot of chunk plot-velocity

We can inspect the gene-gene correlation using `plot_gene_module_cor_heatmap(results)`:

```
plot_gene_module_cor_heatmap(results)
```

![plot of chunk plot-gene-correlation](data:image/png;base64...)

```
## NULL
```

# Adding Technical Variation and Batch Effect

We can also add the technical variation and batch effect to the true counts.

## Adding technical noise

Simply use the `add_expr_noise` function to add technical noise to the dataset.

```
add_expr_noise(
  results,
  # options go here
  alpha_mean = 1e4
)
```

```
## Adding experimental noise...
## 50..100..150..200..250..300..Using atac_counts
```

```
## Time spent: 0.48 mins
```

A `counts_obs` field will be added to the `results` object.

This function also accepts a list of options. See the documentation for more details.

* `protocol`: `"umi"` or `"nonUMI"`, whether simulate the UMI protocol.
* `alpha_mean`, `alpha_sd`: Mean and deviation of rate of subsampling of transcripts during capture step.
* `alpha_gene_mean`, `alpha_gene_sd`: `alpha` parameters, but gene-wise.
* `depth_mean`, `depth_sd`: Mean and deviation of sequencing depth.
* `gene_len`: A vector with lengths of all genes.
* `atac.obs.prob`: For each integer count of a particular region for a particular cell, the probability the count will be observed.
* `atac.sd.frac`: The fraction of ATAC-seq data value used as the standard deviation of added normally distrubted noise.
* `randseed`: random seed.

## Adding batch effects

Finally, use the `divide_batches` function to add batch effects.

```
divide_batches(
  results,
  nbatch = 2,
  effect = 1
)
```

```
## Adding batch effects...
```

A `counts_with_batches` field will be added to the `results` object.

The available options are:

* `nbatch`: Number of batches.
* `effect`: The batch effect size.

We can visualize the result with technical noise and batches:

```
plot_tsne(log2(results$counts_with_batches + 1),
          results$cell_meta$pop,
          legend = 'pop', plot.name = 'RNA Counts Tsne with Batches')
```

![plot of chunk add-expr-noise](data:image/png;base64...)

plot of chunk add-expr-noise

# Adjusting Parameters

scMultiSim provides various parameters to control each type of biological effect.
Here, we describe the most important parameters and how they affect the simulation results:

* `num.cifs`, `diff.cif.fraction`
* `cif.mean`, `cif.sigma`
* `discrete.cif`
* `intinsic.noise`

For a complete list of parameters, please check out the [Parameter Guide](https://zhanglabgt.github.io/scMultiSim/articles/options)
page in the documentation.

## The Shiny App

scMultiSim provides a Shiny app to help you generate the options list and visualize the effects of different parameters.
It is highly recommended to use the Shiny app to explore the available parameters.
You can run the app by calling `run_shiny()`.

```
run_shiny()
```

![Shiny App](https://github.com/ZhangLabGT/scMultiSim/raw/img/img/shiny_app_sc.png)

## Deciding Number of CIFs: `num.cifs`

In scMultiSim, user use `num.cifs` to control the total number of diff-CIF and non-diff-CIFs.
The number of CIFs should be large enough to represent the cell population structure and gene information.
By default, `num.cifs` is set to 50, which is a good starting point for most cases.
However, each gene’s base expression is affected by two random diff-CIF entries,
therefore if you have a large number of genes, they may have similar expression patterns, which may not be ideal.
It is recommended to increase `num.cifs` to 50-100 if you have more than 2000 genes.
If you have a small number of genes (less than 1000), you can also decrease `num.cifs` to 20-40.

## Discrete Cell Population: `discrete.cif`

We can also simulate discrete cell population by setting `discrete.cif = TRUE`.
In this case, each tip of the tree will be one cell type,
therefore there will be 5 clusters in the following result.

```
set.seed(42)

options <- list(
  GRN = GRN_params,
  num.cells = 400,
  num.cifs = 20,
  tree = Phyla5(),
  diff.cif.fraction = 0.8,
  discrete.cif = TRUE
)

results <- sim_true_counts(options)
```

```
## Time spent: 0.14 mins
```

```
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'True RNA Counts Tsne')
```

![plot of chunk simulate-discrete](data:image/png;base64...)

plot of chunk simulate-discrete

## Adjusting the Effect of Cell Population: `diff.cif.fraction`

In scMultiSim, the differentiation tree provides explicit control of the cell population.
The effect of the tree can be adjusted by the option `diff.cif.fraction`,
which controls how many CIFs are affected by the cell population.
With a larger `diff.cif.fraction`, the effect of cell population will be larger
and you may see a clearer trajectory or well separated clusters.
With a smaller `diff.cif.fraction`, the resulting RNA counts will be more affected by
other factors, such as the GRN.

Now let’s visualize the trajectory with different `diff.cif.fraction` values:

```
set.seed(42)

options <- list(
  GRN = GRN_params,
  num.cells = 300,
  num.cifs = 20,
  tree = Phyla5(),
  diff.cif.fraction = 0.8
)

results <- sim_true_counts(
        options %>% list_modify(diff.cif.fraction = 0.4))
```

```
## Time spent: 0.05 mins
```

```
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (diff.cif.fraction = 0.2)')
```

![plot of chunk adjust-diff-cif-fraction](data:image/png;base64...)

plot of chunk adjust-diff-cif-fraction

```
results <- sim_true_counts(
        options %>% list_modify(diff.cif.fraction = 0.9))
```

```
## Time spent: 0.05 mins
```

```
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (diff.cif.fraction = 0.8)')
```

![plot of chunk adjust-diff-cif-fraction](data:image/png;base64...)

plot of chunk adjust-diff-cif-fraction

## Adjusting the Inherent Cell Heterogeneity: `cif.mean` and `cif.sigma`

The inherent cell heterogeneity is controlled by the non-diff-CIF,
which is sampled from a normal distribution with mean `cif.mean` and standard deviation `cif.sigma`.
Therefore, the larger `cif.sigma` is, the larger the inherent cell heterogeneity is.

Now, let’s visualize the effect of `cif.sigma`:

```
set.seed(42)

options <- list(
  GRN = GRN_params,
  num.cells = 300,
  num.cifs = 20,
  tree = Phyla5(),
  diff.cif.fraction = 0.8,
  cif.sigma = 0.5
)

results <- sim_true_counts(
        options %>% list_modify(cif.sigma = 0.1))
```

```
## Time spent: 0.05 mins
```

```
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (cif.sigma = 0.1)')
```

![plot of chunk adjust-cif-sigma](data:image/png;base64...)

plot of chunk adjust-cif-sigma

```
results <- sim_true_counts(
        options %>% list_modify(cif.sigma = 1.0))
```

```
## Time spent: 0.05 mins
```

```
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (cif.sigma = 1.0)')
```

![plot of chunk adjust-cif-sigma](data:image/png;base64...)

plot of chunk adjust-cif-sigma

## Adjusting the Intrinsic Noise: `intinsic.noise`

If we set `do.velocity = FALSE`, scMultiSim will simulate the RNA counts using the Beta-Poisson model,
which is faster but doesn’t output RNA velocity.
When using the Beta-Possion model, scMultiSim provides a `intrinsic.noise` parameter to control the
intrinsic noise during the transcription process.
By default, `intrinsic.noise` is set to 1, which means the true counts will be sampled from the Beta-Poisson
model. If we set `intrinsic.noise` to a smaller value like 0.5,
the true counts will be 0.5 \* (theoretical mean) + 0.5 \* (sampled from the Beta-Poisson model).
*More intrinsic noise will make the encoded effects (e.g. GRN) harder to be inferred.*

```
set.seed(42)

options <- list(
  GRN = GRN_params,
  num.cells = 300,
  num.cifs = 20,
  tree = Phyla5(),
  diff.cif.fraction = 0.8,
  intrinsic.noise = 1
)

results <- sim_true_counts(
        options %>% list_modify(intrinsic.noise = 0.5))
```

```
## Time spent: 0.05 mins
```

```
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (intrinsic.noise = 0.5)')
```

![plot of chunk adjust-intrinsic-noise](data:image/png;base64...)

plot of chunk adjust-intrinsic-noise

```
results <- sim_true_counts(
        options %>% list_modify(intrinsic.noise = 1))
```

```
## Time spent: 0.05 mins
```

```
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (intrinsic.noise = 1)')
```

![plot of chunk adjust-intrinsic-noise](data:image/png;base64...)

plot of chunk adjust-intrinsic-noise

## Adjust the effect of chromatin accessibility: `atac.effect`

`atac.effect` Controls the contribution of the chromatin accessibility.
A higher `atac.effect` means the RNA counts are more affected by the ATAC-seq data,
therefore the correlation between the ATAC-seq and RNA-seq data will be higher.

# Simulating Dynamic GRN

First, call the following function to check the usage of dynamic GRN.

```
scmultisim_help("dynamic.GRN")
```

```
## Dynamic GRN deletes and creates some edges in the GRN in each epoch.
## One epoch contains multiple steps, and the change is done gradually in steps.
## The specific GRN at each step will be used by one or more cells sequentially.
## When an epoch is done, another epoch will start.
##
## Available options for dynamic.GRN:
##   - seed: the random seed
##   - num.steps: number of steps in each epoch.
##   - cell.per.step: how many cells share the GRN in the same step.
##   - involved.genes: a new edge will only be created within these specified genes.
##       The default value is NA, which will use all existing genes in the GRN.
##   - num.changing.edges: if < 1, it means the portion of edges added/deleted in each epoch.
##       if >= 1, it means the number of edges added/deleted in each epoch.
##   - create.tf.edges: whether a new edge can connect two TFs in the GRN.
##   - weight.mean: the mean value of the weight for a newly created edge.
##       The default value is NA, meaning that it will use the mean value of the input GRN.
##   - weight.sd: the standard deviation of the weight for a newly created edge.
##
## See the returned list for the default values.
```

```
## NULL
```

Here we use `Phyla1()` as the differentiation tree to remove the effect of the trajectory. Additionally, we can use `discrete.cif = TRUE` to simulate discrete cell population.

```
set.seed(42)

options_ <- list(
  GRN = GRN_params,
  num.cells = 300,
  num.cifs = 20,
  tree = Phyla1(),
  diff.cif.fraction = 0.8,
  do.velocity = FALSE,
  dynamic.GRN = list(
    cell.per.step = 3,
    num.changing.edges = 5,
    weight.mean = 0,
    weight.sd = 4
  )
)

results <- sim_true_counts(options_)
```

```
## Time spent: 0.05 mins
```

`results$cell_specific_grn` is a list containing the gene effects matrix for each cell. Each row is a target and each column is a regulator. The corresponding gene names are displayed as column and row names.

```
# GRN for cell 1 (first 10 rows)
results$cell_specific_grn[[1]][1:10,]
```

```
##           2        6       10       19 80 91
## 1  2.250484 1.824607 1.941613 4.268812  0  0
## 2  0.000000 0.000000 0.000000 0.000000  0  0
## 3  2.184071 0.000000 0.000000 0.000000  0  0
## 4  1.634807 0.000000 0.000000 0.000000  0  0
## 5  4.677883 4.301893 2.090473 4.047174  0  0
## 6  0.000000 0.000000 0.000000 0.000000  0  0
## 7  3.306285 2.673968 2.414780 3.548154  0  0
## 8  2.707510 4.653263 1.357980 1.829304  0  0
## 9  1.501430 1.970649 4.359262 3.915318  0  0
## 10 0.000000 0.000000 0.000000 0.000000  0  0
```

Since we set `cell.per.step = 3`, we expect each adjacent 3 cells share the same GRN:

```
print(all(results$cell_specific_grn[[1]] == results$cell_specific_grn[[2]]))
```

```
## [1] TRUE
```

```
print(all(results$cell_specific_grn[[2]] == results$cell_specific_grn[[3]]))
```

```
## [1] TRUE
```

```
print(all(results$cell_specific_grn[[3]] == results$cell_specific_grn[[4]]))
```

```
## [1] FALSE
```

# Session Information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] dplyr_1.1.4      scMultiSim_1.6.0 knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] generics_0.1.4              gplots_3.2.0
##  [3] bitops_1.0-9                SparseArray_1.10.0
##  [5] KernSmooth_2.23-26          gtools_3.9.5
##  [7] lattice_0.22-7              caTools_1.18.3
##  [9] digest_0.6.37               magrittr_2.0.4
## [11] evaluate_1.0.5              grid_4.5.1
## [13] RColorBrewer_1.1-3          iterators_1.0.14
## [15] foreach_1.5.2               Matrix_1.7-4
## [17] ape_5.8-1                   scales_1.4.0
## [19] codetools_0.2-20            abind_1.4-8
## [21] cli_3.6.5                   rlang_1.1.6
## [23] XVector_0.50.0              Biobase_2.70.0
## [25] withr_3.0.2                 DelayedArray_0.36.0
## [27] Rtsne_0.17                  S4Arrays_1.10.0
## [29] tools_4.5.1                 parallel_4.5.1
## [31] BiocParallel_1.44.0         ggplot2_4.0.0
## [33] zeallot_0.2.0               SummarizedExperiment_1.40.0
## [35] BiocGenerics_0.56.0         assertthat_0.2.1
## [37] vctrs_0.6.5                 R6_2.6.1
## [39] matrixStats_1.5.0           stats4_4.5.1
## [41] lifecycle_1.0.4             Seqinfo_1.0.0
## [43] S4Vectors_0.48.0            IRanges_2.44.0
## [45] MASS_7.3-65                 pkgconfig_2.0.3
## [47] pillar_1.11.1               gtable_0.3.6
## [49] glue_1.8.0                  Rcpp_1.1.0
## [51] xfun_0.53                   tibble_3.3.0
## [53] GenomicRanges_1.62.0        tidyselect_1.2.1
## [55] KernelKnn_1.1.6             MatrixGenerics_1.22.0
## [57] dichromat_2.0-0.1           farver_2.1.2
## [59] nlme_3.1-168                labeling_0.4.3
## [61] compiler_4.5.1              S7_0.2.0
## [63] markdown_2.0
```