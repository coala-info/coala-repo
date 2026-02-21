# Reproduce the Diffusion Map vignette with the supplied data()

# Quickstart

A short version to achive the above is by using the preprocessed version of the dataset provided with this package. `data(guo)` is already preprocessed (using the method first mentioned), has its threshold set to a constant 15 and is ready to use. Since the platform’s maximum amplification cycles are 40, that number can be used as upper border of the uncertainty range.

```
library(destiny)
data(guo)
```

It can be used directly for diffusion map creation:

```
dm_guo <- DiffusionMap(guo, verbose = FALSE,
                       censor_val = 15, censor_range = c(15, 40))
dm_guo
```

```
## DiffusionMap (20 Diffusion components and 428 observations)
## eigenvalues:    Named num [1:20] 0.954 0.846 0.798 0.776 0.703 ...
##  - attr(*, "names")= chr [1:20] "DC1" "DC2" "DC3" "DC4" ...
## eigenvectors:   num [1:428, 1:20] -0.0576 -0.0574 -0.0495 -0.0495 -0.0511 ...
##   ..colnames:   chr [1:20] "DC1" "DC2" "DC3" "DC4" ...
## optimal_sigma:  Named num [1:428] 7.69 7.63 9.19 6.76 6.35 ...
##  - attr(*, "names")= chr [1:428] "10" "11" "12" "13" ...
## distance:       chr "euclidean"
```

```
plot(dm_guo)
```

![](data:image/png;base64...)

using the annotation shows that the approximation worked

```
palette(cube_helix(6))
plot(dm_guo, col_by = 'num_cells',
     legend_main = 'Cell stage')
```

![](data:image/png;base64...)

# References