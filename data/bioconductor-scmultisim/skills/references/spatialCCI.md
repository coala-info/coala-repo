# 3. Simulating Spatial Cell-Cell Interactions

## Simulating Spatial Cell-Cell Interactions

scMultiSim can simulate spatial cell-cell interactions.
To do so, we need to provide the `cci` option as a list.
The following code will print more instructions on how to use the `cci` option.

```
library(scMultiSim)

scmultisim_help("cci")
```

```
##
## To enable simulating cell-cell interaction, the value should be a list including
## the following names:
##
## - grid.size: (integer)
##     Manually specify the width and height of the grid.
## - layout: (character or function)
##     Supported values are "enhanced",  "layers", "islands", or a custom function.
##     If set to "islands", you can specify which cell types are the islands,
##         e.g. "islands:1,2".
##     The custom function should take two arguments: (grid_size, cell_types)
##         grid_size: (integer)
##             The width and height of the grid.
##         cell_types: (integer vector)
##             Each cell's cell type.
##     It should return a n_cell x 2 matrix, where each row is the x and y coordinates of a cell.
## - params: (data.frame)
##     The spatial effect between neighbor cells.
##     It should be a data frame similar to the GRN parameter.
## - step.size: (number, optional)
##     If using continuous population, use this step size to further divide the
##     cell types on the tree. For example, if the tree only has one branch `a -> b`
##     and the branch length is 1 while the step size is 0.34,
##     there will be totally three cell types: a_b_1, a_b_2, a_b_3.
## - cell.type.interaction: ("random" or a matrix)
##     The interaction level between different cell types.
##     They act as factors multiplied to the ligand effect.
##     Supply the string "random" to let scMultiSim generate these factors randomly.
##     Otherwise, use cci_cell_type_params() to generate the template data structure.
##     See the help of this method for more info.
## - cell.type.lr.pairs: (integer vector)
##     If cell.type.interaction is "random", how many LR pairs should be enabled
##     between each cell type pair.
##     Should be a range, e.g. 4:6. The actual number of LR pairs will be uniformly
##     sampled from this range.
## - max.neighbors: (integer)
##     Constraint the maxinum number of neighbors with CCI for each cell.
##     The neighbors with CCI will be randomly sampled.
## - radius: (number or string)
##     Which cells should be considered as neighbors.
##     The interacting cells are those within these neighbors.
##     When it is a number, it controls the maximum distance between two cells for
##     them to interact.
##     When it is a string, it should be in the format `gaussian:sigma`, for example,
##     `gaussian:1.2`.
##     In this case, the probability of two cells interacting is proportional to
##     the distance with a Gaussian kernel applied.
## - start.layer: (integer)
##     From which layer (time step) the simulation should start.
##     If set to 1, the simulation will start with one cell in the grid and add one
##     more cell in each following layer.
##     If set to `num_cells`, the simulation will start from all cells available in
##     the grid and only continues for a few static layers, which will greatly speed
##     up the simulation.
##
```

```
## NULL
```

Now, we prepare a ligand-receptor interaction database.
This is pretty similar to the GRN network: it is a data frame with three columns,
specifying `target`, `regulator`, and `effect`, respectively.
The target and regulator columns should contain the IDs of the target and regulator genes.
In the following example, we have two ligand-receptor pairs interacting between two neighboring cells.

```
lig_params <- data.frame(
  target    = c(101, 102),
  regulator = c(103, 104),
  effect    = c(5.2, 5.9)
)
```

We can now simulate the spatial cell-cell interactions.
In scMultiSim, the CCI network is cell-type based, which means that between each cell type pair,
we can have a different CCI network sampled from the database defined above.
Here, we set the `step.size` to 0.5, so the differentiation tree is divided into segments of length 0.5,
each segment is treated as a cell type in CCI.
We set `cell.type.interaction` to `random`, so the CCI network between each cell type pair is randomly sampled from the database.

Here, we use only 100 cells to speed up the simulation. Feel free to try a larger number of cells when running this vignette locally.

```
data(GRN_params_100)
set.seed(42)

options_ <- list(
  GRN = GRN_params_100,
  speed.up = TRUE,
  num.genes = 120,
  num.cells = 80,
  num.cifs = 20,
  cif.sigma = 0.2,
  tree = Phyla3(),
  intrinsic.noise = 0.5,
  cci = list(
    params = lig_params,
    max.neighbors = 4,
    grid.size = 13,
    cell.type.interaction = "random",
    step.size = 0.5
  )
)

results <- sim_true_counts(options_)
```

```
## Experimental speed optimization enabled.
```

```
## CCI simulation is enabled.
## Get CIF...Done
## Get params...Done
## Simulating...50..
## Time spent: 0.31 mins
```

The `results$cell_meta` will contain the cell type information used in CCI.
We can plot the cell spatial locations using `plot_cell_loc()`.
The arrows indicate cell-cell interactions between two cells (for the first ligand-receptor pair).

```
plot_cell_loc(results)
```

![plot of chunk plot-cell-loc](data:image/png;base64...)

The cell locations are available in `results$cci_locs`.

```
head(results$cci_locs)
```

```
##       x y
## cell1 6 6
## cell2 9 4
## cell3 6 3
## cell4 6 5
## cell5 8 9
## cell6 8 8
```

### Speeding up the Simulation

Simulating spatial cell-cell interactions can be computationally expensive.
Setting these two options can speed up the simulation:

```
options_ <- list(
    # ...
    speed.up = T,
    cci = list(
        # ...
        start.layer = ncells
    )
)
```

First of all, it is recommended to set the experimental `speed.up = T` option. This option will become default in later versions of scMultiSim.

Next, it is possible to set the CCI option `start.layer = n_cells`, where `n_cells` is the number of cells.
scMultiSim simulates a spatial dataset by following `n_cells` steps, adding one more cell to the spatial grid in each step.
Only the final step is outputted as the result.
The CCI option `start.layer` can be used to start simulation from a specific time step.
When set to `n_cells`, the simulation will skip all previous steps by adding all cells at once.
By default, `start.layer` will be set to `n_cells` when number of cells is greater than 800.

## Spatial layouts

scMultiSim provides powerful customization options for spatial cell layouts.

### Built-in layouts

scMultiSim ships with several built-in spatial layouts.
The `enhanced` layout is the default layout, where cells are added to the grid one by one.
When adding a new cell, it has a higher probability of being placed near the existing cells of the same cell type.

```
# helper function to add `layout` to options, to make the code more readable
spatial_options <- function (...) {
  cci_opt <- list(
    params = lig_params,
    max.neighbors = 4,
    start.layer = 300,
    grid.size = 28,
    cell.type.interaction = "random"
  )
  list(
    rand.seed = 0,
    GRN = GRN_params_100,
    speed.up = TRUE,
    num.genes = 200,
    num.cells = 300,
    num.cifs = 50,
    tree = Phyla3(),
    cci = c(cci_opt, list(...))
  )
}

results <- sim_true_counts(spatial_options(
  layout = "enhanced"
))
```

```
## Experimental speed optimization enabled.
```

```
## CCI simulation is enabled.
```

```
## Spatial: only the last layer will be simulated.
```

```
## Get CIF...100..200..300..Done
## Get params...Done
## Simulating...300..
## Time spent: 0.37 mins
```

```
plot_cell_loc(results, show.arrows = FALSE)
```

![plot of chunk layout-enhanced](data:image/png;base64...)

An option `same.type.prob` decides the probability of a new cell being placed near the existing cells of the same cell type.
By default, it is 0.8; and if we use a lower value, the new cell will be placed more randomly.

```
results <- sim_true_counts(spatial_options(
  layout = "enhanced",
  same.type.prob = 0.1
))
```

```
## Experimental speed optimization enabled.
```

```
## CCI simulation is enabled.
```

```
## Spatial: only the last layer will be simulated.
```

```
## Get CIF...100..200..300..Done
## Get params...Done
## Simulating...300..
## Time spent: 0.35 mins
```

```
plot_cell_loc(results, show.arrows = FALSE)
```

![plot of chunk layout-random](data:image/png;base64...)

The `layers` layout arranges cells in layers.

```
results <- sim_true_counts(spatial_options(
  layout = "layers"
))
```

```
## Experimental speed optimization enabled.
```

```
## CCI simulation is enabled.
```

```
## Spatial: only the last layer will be simulated.
```

```
## Get CIF...100..200..300..Done
## Get params...Done
## Simulating...300..
## Time spent: 0.34 mins
```

```
plot_cell_loc(results, show.arrows = FALSE)
```

![plot of chunk layout-layers](data:image/png;base64...)

The `islands` layout will put some cell types in the center like islands, and others around them.
You may specify which cell type should be islands in the format `islands:1,2,3`.
The number here can be looked up in `results$cci_cell_types`.

```
results$cci_cell_types
```

```
##   4_5   5_2   5_3 4_1_1 4_1_2
##     1     2     3     4     5
```

```
results <- sim_true_counts(spatial_options(
  # cell type 4_1_2 should be the island
  layout = "islands:5"
))
```

```
## Experimental speed optimization enabled.
```

```
## CCI simulation is enabled.
```

```
## Spatial: only the last layer will be simulated.
```

```
## Get CIF...100..200..300..Done
## Get params...Done
## Simulating...300..
## Time spent: 0.34 mins
```

```
plot_cell_loc(results, show.arrows = FALSE)
```

![plot of chunk layout-islands](data:image/png;base64...)

### Custom layouts

It is also possible to layout the cells programmatically.
The `layout` option can be a function that takes the cell type information and returns the spatial locations of the cells:

```
# grid_size is a number
# cell_types is an integer vector, representing the cell types
function(grids_size, cell_types) {
  # return a matrix with two columns, representing the x and y coordinates of the cells
  return matrix(nrow = 2, ncol = ncells)
}
```

For example, the following layout function will place the cells sequentially in the grid,
starting from the bottom-left corner.

```
results <- sim_true_counts(spatial_options(
  layout = function (grid_size, cell_types) {
    ncells <- length(cell_types)
    new_locs <- matrix(nrow = ncells, ncol = 2)
    # for each cell...
    for (i in 1:ncells) {
      # ...place it in the grid
      new_locs[i,] <- c(i %% grid_size, i %/% grid_size)
    }
    return(new_locs)
  }
))
```

```
## Experimental speed optimization enabled.
```

```
## CCI simulation is enabled.
```

```
## Spatial: only the last layer will be simulated.
```

```
## Get CIF...100..200..300..Done
## Get params...Done
## Simulating...300..
## Time spent: 0.33 mins
```

```
plot_cell_loc(results, show.arrows = FALSE)
```

![plot of chunk layout-custom](data:image/png;base64...)

## Spatial domains

Next, we demonstrate how to use custom layout function to create spatial domains.
We want to have three spatial domains in a layered layout, and we have four cell types.
Each cell type has a different probability of being in each domain.

The following layout function will do this job: First of all, it generates a set of locations that form a circular shape.
Next, it assigns cells to these locations; the leftmost cell is selected as the origin.
Then, we can create a layered layout by sorting the locations based on their euclidian distance to the origin.
The three domains are determined by the distance to the origin.
We have a matrix `ct_matrix` that specifies the probability of each cell type being in each domain.
Finally, we sample the cells based on the probabilities and assign them to the domains.

```
layout_fn <- function(grid_size, final_types) {
  ncells <- length(final_types)
  grid_center <- c(round(grid_size / 2), round(grid_size / 2))
  all_locs <- gen_clutter(ncells, grid_size, grid_center)
  # center is bottom-left
  left_ones <- which(all_locs[,1] == min(all_locs[,1]))
  new_center <<- all_locs[left_ones[which.min(all_locs[left_ones, 2])],]
  dist_to_center <- sqrt(colSums((t(all_locs) - new_center)^2))
  new_locs <- all_locs[order(dist_to_center),]
  # prob of a cell type being in a zone (cell_type x zone)
  ct_matrix <- matrix(c(
    0.9, 0.1, 0.0,
    0.1, 0.8, 0.1,
    0.1, 0.7, 0.2,
    0.0, 0.1, 0.9
  ), nrow = 4, byrow = TRUE)
  # number of cells per type
  ct_pop <- c(160, 80, 100, 140)
  pop_mtx <- round(ct_matrix * ct_pop)
  if (sum(pop_mtx) != ncells) {
    diffrence <- ncells - sum(pop_mtx)
    pop_mtx[1, 1] <- pop_mtx[1, 1] + diffrence
  }
  # number of cells per zone
  zone_pop <- colSums(pop_mtx)
  # assign cells to zones
  cs <- cumsum(zone_pop)
  # sample cells
  cell_idx <- unlist(lapply(1:3, function(izone) {
    sample(rep(1:4, pop_mtx[,izone]), zone_pop[izone])
  }))
  locs <<- new_locs[order(cell_idx),]
  zone_gt <<- rep(1:3, zone_pop)[order(cell_idx)]
  return(locs)
}
```

Inspecting the result, we can see the three spatial domains, where the middle one contains a mix of two cell types.

```
results <- sim_true_counts(list(
  num.cells = 500,
  num.genes = 300,
  num.cifs = 40,
  GRN = NA,
  speed.up = T,
  cif.sigma = 0.8,
  tree = ape::read.tree(text = "(A:1,B:1,C:1,D:1);"),
  diff.cif.fraction = 0.8,
  discrete.cif = T,
  discrete.pop.size = as.integer(c(120,150,100,130)),
  cci = list(
    params = lig_params,
    max.neighbors = 4,
    start.layer = 500,
    cell.type.interaction = "random",
    layout = layout_fn,
    step.size = 1
  )
))
```

```
## Experimental speed optimization enabled.
```

```
## CCI simulation is enabled.
```

```
## Spatial: only the last layer will be simulated.
```

```
## Get CIF...Get params...Done
## Simulating...500..
## Time spent: 0.69 mins
```

```
plot_cell_loc(results, show.arrows = FALSE)
```

![plot of chunk layout-domains-plot](data:image/png;base64...)

## Spatially variable genes

The `ext.cif.giv` option allows us to append custom CIF and GIV entries for each cell and gene.
We can use this option to simulate spatially variable genes.
This option should be a function that takes the kinetic parameter index and returns a list of extra CIF and GIV matrices.

```
scmultisim_help("ext.cif.giv")
```

```
## ext.cif.giv  (default: NA)
## 	Add customized CIF and GIV. The function takes one argument, the kinetic
## 	 parameter index (1=kon, 2=koff, 3=s). It should return a list of two el
## 	ements: the extra CIF matrix (n_extra_cif x n_cells) and the GIV matrix
## 	(n_genes x n_extra_cif). Return NULL for no extra CIF and GIV.
## 	should be a function
```

Using the previous layout function, we can add extra CIF with value based on the distance to the origin.

```
ext_cif <- function(i) {
  # We manually set genes 290-300 to be spatially variable
  spatial_genes <- 290:300
  dist_to_center <- colSums((t(locs) - new_center)^2)
  dist_to_center <- dist_to_center / max(dist_to_center)
  # 3 is the s parameter
  if (i == 3) {
    # n_extra_cif x n_cells
    ex_cif <- cbind(
      # the two CIFs have large values when distance to the center is near 0.5
      rnorm(500, 0.5 * dnorm(abs(dist_to_center - 0.5), 0, 0.04), 0.02),
      rnorm(500, 0.5 * dnorm(abs(dist_to_center - 0.5), 0, 0.04), 0.02)
    )
    # n_genes x n_extra_cif
    ex_giv <- matrix(0, nrow = 300, ncol = 2)
    for (i in spatial_genes) {
      # odd genes affected by the first two CIF, even genes affected by the last two CIF
      ex_giv[i, ] <- rnorm(2, 1, 0.5)
    }
    list(ex_cif, ex_giv * 2)
  } else {
    NULL
  }
}
```

```
results <- sim_true_counts(list(
  num.cells = 500,
  num.genes = 300,
  num.cifs = 40,
  GRN = NA,
  speed.up = T,
  cif.sigma = 0.8,
  tree = ape::read.tree(text = "(A:1,B:1,C:1,D:1);"),
  diff.cif.fraction = 0.8,
  ext.cif.giv = ext_cif,
  discrete.cif = T,
  discrete.pop.size = as.integer(c(120,150,100,130)),
  cci = list(
    params = lig_params,
    max.neighbors = 4,
    start.layer = 500,
    cell.type.interaction = "random",
    layout = layout_fn,
    step.size = 1
  )
))
```

```
## Experimental speed optimization enabled.
```

```
## CCI simulation is enabled.
```

```
## Spatial: only the last layer will be simulated.
```

```
## Get CIF...Get params...Done
## Simulating...500..
## Time spent: 0.67 mins
```

Try plotting one of the spatially variable genes. We can see that the gene expression is higher in the specific spatial
region.

```
library(ggplot2)

plot_cell_loc(results, show.arrows = FALSE,
              .cell.pop = log(results$counts[299,] + 1)) + scale_colour_viridis_c()
```

![plot of chunk spatially-variable-gene](data:image/png;base64...)

## Long-distance Cell-Cell Interactions

scMultiSim also supports simulation of long-distance cell-cell interactions.

The CCI option `radius` controls the maximum distance between two cells for them to interact.
It can be a number or a string.
When it is a number, it specifies the maximum distance.
When it is a string it should be in the format `gaussian:sigma`, for example, `gaussian:1.2`.
In this case, the probability of two cells interacting is proportional to the distance with a Gaussian kernel applied.

By default, `radius = 1`, which means scMultiSim only consider the four nearest neighbors.

We can compare the result with different sigma values 1 and 3:

```
options <- lapply(c(1, 3), \(sigma) {
  list(
    rand.seed = 1,
    GRN = NA,
    num.genes = 200,
    num.cells = 500,
    num.cifs = 50,
    tree = Phyla5(),
    discrete.cif = T,
    discrete.min.pop.size = 20,
    discrete.pop.size = as.integer(c(110, 80, 140, 40, 130)),
    do.velocity = F,
    scale.s = 1,
    cci = list(
      params = lig_params,
      max.neighbors = 4,
      cell.type.interaction = "random",
      cell.type.lr.pairs = 3:6,
      step.size = 0.3,
      grid.size = 35,
      start.layer = 500,
      radius = paste0("gaussian:", sigma),
      layout = "layers"
    )
  )

})

results_1 <- sim_true_counts(options[[1]])
```

```
## CCI simulation is enabled.
```

```
## Spatial: only the last layer will be simulated.
```

```
## Get CIF...Get params...Done
## Simulating...500..
## Time spent: 1.51 mins
```

```
results_3 <- sim_true_counts(options[[2]])
```

```
## CCI simulation is enabled.
```

```
## Spatial: only the last layer will be simulated.
```

```
## Get CIF...Get params...Done
## Simulating...500..
## Time spent: 1.53 mins
```

```
plot_cell_loc(results_1, show.arrows = T, .cell.pop = as.character(results$grid$final_types))
```

![plot of chunk plot-long-distance-cci](data:image/png;base64...)

```
plot_cell_loc(results_3, show.arrows = T, .cell.pop = as.character(results$grid$final_types))
```

![plot of chunk plot-long-distance-cci](data:image/png;base64...)

## Session Information

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
## [1] ggplot2_4.0.0    dplyr_1.1.4      scMultiSim_1.6.0 knitr_1.50
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
## [17] ape_5.8-1                   viridisLite_0.4.2
## [19] scales_1.4.0                codetools_0.2-20
## [21] abind_1.4-8                 cli_3.6.5
## [23] rlang_1.1.6                 XVector_0.50.0
## [25] Biobase_2.70.0              litedown_0.7
## [27] commonmark_2.0.0            withr_3.0.2
## [29] DelayedArray_0.36.0         Rtsne_0.17
## [31] S4Arrays_1.10.0             tools_4.5.1
## [33] parallel_4.5.1              BiocParallel_1.44.0
## [35] zeallot_0.2.0               SummarizedExperiment_1.40.0
## [37] BiocGenerics_0.56.0         assertthat_0.2.1
## [39] mime_0.13                   vctrs_0.6.5
## [41] R6_2.6.1                    matrixStats_1.5.0
## [43] stats4_4.5.1                lifecycle_1.0.4
## [45] Seqinfo_1.0.0               S4Vectors_0.48.0
## [47] IRanges_2.44.0              MASS_7.3-65
## [49] pkgconfig_2.0.3             pillar_1.11.1
## [51] gtable_0.3.6                glue_1.8.0
## [53] Rcpp_1.1.0                  xfun_0.53
## [55] tibble_3.3.0                GenomicRanges_1.62.0
## [57] tidyselect_1.2.1            KernelKnn_1.1.6
## [59] MatrixGenerics_1.22.0       dichromat_2.0-0.1
## [61] farver_2.1.2                nlme_3.1-168
## [63] labeling_0.4.3              compiler_4.5.1
## [65] S7_0.2.0                    markdown_2.0
```