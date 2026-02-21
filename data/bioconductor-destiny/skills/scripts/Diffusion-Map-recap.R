# Code example from 'Diffusion-Map-recap' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(destiny)
data(guo)

## -----------------------------------------------------------------------------
dm_guo <- DiffusionMap(guo, verbose = FALSE,
                       censor_val = 15, censor_range = c(15, 40))
dm_guo

## -----------------------------------------------------------------------------
plot(dm_guo)

## -----------------------------------------------------------------------------
palette(cube_helix(6))
plot(dm_guo, col_by = 'num_cells',
     legend_main = 'Cell stage')

