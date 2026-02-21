# Code example from 'Global-Sigma' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(destiny)
data(guo_norm)

## -----------------------------------------------------------------------------
sigmas <- find_sigmas(guo_norm, verbose = FALSE)
optimal_sigma(sigmas)

## -----------------------------------------------------------------------------
palette(cube_helix(6))

plots <- lapply(
  list('local', 5, round(optimal_sigma(sigmas), 2), 100),
  function(sigma) {
    plot(
      DiffusionMap(guo_norm, sigma), 1:2,
      main = paste('σ =', sigma),
      col_by = 'num_cells', draw_legend = FALSE)
  }
)

do.call(gridExtra::grid.arrange, c(plots, ncol = 2))

