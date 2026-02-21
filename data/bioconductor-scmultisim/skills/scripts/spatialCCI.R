# Code example from 'spatialCCI' vignette. See references/ for full tutorial.

## ----"setup", include=FALSE---------------------------------------------------
require("knitr")
opts_chunk$set(fig.width=4, fig.height=3)

# devtools::load_all(".")

## ----help-cci-----------------------------------------------------------------
library(scMultiSim)

scmultisim_help("cci")

## ----cci-network--------------------------------------------------------------
lig_params <- data.frame(
  target    = c(101, 102),
  regulator = c(103, 104),
  effect    = c(5.2, 5.9)
)

## -----------------------------------------------------------------------------
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

## ----plot-cell-loc, fig.width=6, fig.height=6---------------------------------
plot_cell_loc(results)

## ----print-cell-loc-----------------------------------------------------------
head(results$cci_locs)

## ----layout-enhanced, fig.width=6, fig.height=6-------------------------------
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
plot_cell_loc(results, show.arrows = FALSE)

## ----layout-random, fig.width=6, fig.height=6---------------------------------

results <- sim_true_counts(spatial_options(
  layout = "enhanced",
  same.type.prob = 0.1
))
plot_cell_loc(results, show.arrows = FALSE)

## ----layout-layers, fig.width=6, fig.height=6---------------------------------
results <- sim_true_counts(spatial_options(
  layout = "layers"
))
plot_cell_loc(results, show.arrows = FALSE)

## -----------------------------------------------------------------------------
results$cci_cell_types

## ----layout-islands, fig.width=6, fig.height=6--------------------------------
results <- sim_true_counts(spatial_options(
  # cell type 4_1_2 should be the island
  layout = "islands:5"
))
plot_cell_loc(results, show.arrows = FALSE)

## ----layout-custom, fig.width=6, fig.height=6---------------------------------
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
plot_cell_loc(results, show.arrows = FALSE)

## ----layout-domains-----------------------------------------------------------
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

## ----layout-domains-plot, fig.width=6, fig.height=6---------------------------
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

plot_cell_loc(results, show.arrows = FALSE)

## -----------------------------------------------------------------------------
scmultisim_help("ext.cif.giv")

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
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

## ----spatially-variable-gene, fig.width=6, fig.height=6-----------------------
library(ggplot2)

plot_cell_loc(results, show.arrows = FALSE,
              .cell.pop = log(results$counts[299,] + 1)) + scale_colour_viridis_c()

## ----long-distance-cci--------------------------------------------------------

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
results_3 <- sim_true_counts(options[[2]])


## ----plot-long-distance-cci, fig.width=6, fig.height=6------------------------
plot_cell_loc(results_1, show.arrows = T, .cell.pop = as.character(results$grid$final_types))
plot_cell_loc(results_3, show.arrows = T, .cell.pop = as.character(results$grid$final_types))

## ----session-info-------------------------------------------------------------
sessionInfo()

