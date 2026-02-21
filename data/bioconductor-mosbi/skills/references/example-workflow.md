# Example workflow

Tim Daniel Rose

#### 2025-10-30

# Contents

* [0.0.1 Load packages](#load-packages)
* [0.0.2 Helper functions](#helper-functions)
* [0.0.3 1. Download and prepare data](#download-and-prepare-data)
* [0.0.4 2. Compute biclusters](#compute-biclusters)
* [0.0.5 3. Compute network](#compute-network)
* [0.0.6 4. Extract louvain communities](#extract-louvain-communities)
* [1 Session Info](#session-info)

This vignette shows an example workflow for ensemble biclustering analysis
with the `mosbi` package.
Every function of the package has a help page with a detailed documentation.
To access these type `help(package=mosbi)` in the `R` console.

### 0.0.1 Load packages

Import dependencies.

```
library(mosbi)
```

### 0.0.2 Helper functions

Two additional functions are defined, to calculate z-scores of the data and
to visualize the biclusters as a histogram.

```
z_score <- function(x, margin = 2) {
    z_fun <- function(y) {
        (y - mean(y, na.rm = TRUE)) / sd(y, na.rm = TRUE)
    }

    if (margin == 2) {
        return(apply(x, margin, z_fun))
    } else if (margin == 1) {
        return(t(apply(x, margin, z_fun)))
    }
}

bicluster_histo <- function(biclusters) {
    cols <- mosbi::colhistogram(biclusters)
    rows <- mosbi::rowhistogram(biclusters)

    graphics::par(mfrow = c(1, 2))
    hist(cols, main = "Column size ditribution")
    hist(rows, main = "Row size ditribution")
}
```

### 0.0.3 1. Download and prepare data

Biclustering will be done on a data matrix. As an example,
lipidomics dataset from the metabolights database will be used
`https://www.ebi.ac.uk/metabolights/MTBLS562`.
The data consists of 40 samples (columns) and 245 lipids (rows).

```
# get data
data(mouse_data)

mouse_data <- mouse_data[c(
    grep(
        "metabolite_identification",
        colnames(mouse_data)
    ),
    grep("^X", colnames(mouse_data))
)]

# Make data matrix
data_matrix <- z_score(log2(as.matrix(mouse_data[2:ncol(mouse_data)])), 1)

rownames(data_matrix) <- mouse_data$metabolite_identification

stats::heatmap(data_matrix)
```

![](data:image/png;base64...)
The data has a gaussian-like distribution and no missing values,
so we can proceed with biclustering.

### 0.0.4 2. Compute biclusters

The `mosbi` package is able to work with results of different
biclustering algorithms. The approach unites the results
from different algorithms.
The results of four example algorithms will be computed and
converted to `mosbi::bicluster` objects. For a list of all
supported biclustering algorithms/packages type `?mosbi::get_biclusters`
in the `R` console.

```
# Fabia
fb <- mosbi::run_fabia(data_matrix) # In case the algorithms throws an error,
#> Cycle: 0
Cycle: 20
Cycle: 40
Cycle: 60
Cycle: 80
Cycle: 100
Cycle: 120
Cycle: 140
Cycle: 160
Cycle: 180
Cycle: 200
Cycle: 220
Cycle: 240
Cycle: 260
Cycle: 280
Cycle: 300
Cycle: 320
Cycle: 340
Cycle: 360
Cycle: 380
Cycle: 400
Cycle: 420
Cycle: 440
Cycle: 460
Cycle: 480
Cycle: 500
# return an empty list

# isa2
BCisa <- mosbi::run_isa(data_matrix)

# Plaid
BCplaid <- mosbi::run_plaid(data_matrix)
#> layer: 0
#>  5882.744
#> layer: 1
#> [1]   0 110  10
#> [1]   1 103  10
#> [1]   2 101  10
#> [1]  30 101  10
#> [1] 31 39 10
#> [1] 32 39  9
#> [1] 33 37  9
#> [1] 34 37  9
#> [1] 35 37  9
#> [1] 60 37  9
#> [1] 3
#> [1] 154.413   0.000   0.000   0.000
#> back fitting 2 times
#> layer: 2
#> [1]  0 92 17
#> [1]  1 84 17
#> [1]  2 81 18
#> [1]  3 78 18
#> [1]  4 77 18
#> [1] 30 77 18
#> [1] 31 29 18
#> [1] 32 29  7
#> [1] 33 29  7
#> [1] 60 29  7
#> [1] 5
#> [1] 174.1425   0.0000   0.0000   0.0000
#> back fitting 2 times
#> layer: 3
#> [1]   0 118  19
#> [1]  1 90 16
#> [1]  2 76 15
#> [1]  3 67 15
#> [1]  4 65 15
#> [1]  5 63 15
#> [1]  6 59 15
#> [1]  7 54 15
#> [1]  8 51 15
#> [1]  9 50 15
#> [1] 30 50 15
#> [1] 31  3 15
#> [1] 32  3  9
#> [1] 33  3  9
#> [1] 34  3  8
#> [1] 35  3  8
#> [1] 60  3  8
#> [1] 10
#> [1] 18.23024  0.00000  0.00000  0.00000
#> back fitting 2 times
#> layer: 4
#> [1]   0 120  20
#> [1]   1 102  18
#> [1]  2 96 18
#> [1] 30 96 18
#> [1] 31  0 18
#> [1] 32
#> [1] 0 0 0 0
#>
#> Layer Rows Cols  Df      SS    MS Convergence Rows Released Cols Released
#>     0  245   40 284 6265.03 22.06          NA            NA            NA
#>     1   37    9  45  305.74  6.79           1            64             1
#>     2   29    7  35  295.26  8.44           1            48            11
#>     3    3    8  10   25.20  2.52           1            47             7

# QUBIC
BCqubic <- mosbi::run_qubic(data_matrix)

# Merge results of all algorithms
all_bics <- c(fb, BCisa, BCplaid, BCqubic)

bicluster_histo(all_bics)
```

![](data:image/png;base64...)
The histogram visualizes the distribution of bicluster sizes
(separately for the number of rows and columns of each bicluster).
The total number of found biclusters are given in the title.

### 0.0.5 3. Compute network

The next step of the ensemble approach is the computation of a
similarity network of biclusters. To filter for for similarities due to
random overlaps of biclusters, we apply an error
model (For more details refer to our publication).
Different similarity metrics are available.
For details type `mosbi::bicluster_network` in the `R` console.

```
bic_net <- mosbi::bicluster_network(all_bics, # List of biclusters
    data_matrix, # Data matrix
    n_randomizations = 5,
    # Number of randomizations for the
    # error model
    MARGIN = "both",
    # Use datapoints for metric evaluation
    metric = 4, # Fowlkes–Mallows index
    # For information about the metrics,
    # visit the "Similarity metrics
    # evaluation" vignette
    n_steps = 1000,
    # At how many steps should
    # the cut-of is evaluated
    plot_edge_dist = TRUE
    # Plot the evaluation of cut-off estimation
)
#> Esimated cut-off:  0.03803804
```

![](data:image/png;base64...)
The two resulting plot visualize the process of cut-off estimation.
The right plot show the remaining number of edges for the computed
bicluster network (red) and for randomizations of biclusters (black).
The vertical red line showed the threshold with the highest
signal-to-noise ratio (SNR). All evaluated SNRs are again
visualized in the left plot.

The next plot shows the bicluster similarity matrix.
It reveals highly similar biclusters.

```
stats::heatmap(get_adjacency(bic_net))
```

![](data:image/png;base64...)

#### 0.0.5.1 Visualize network

Before the final step, extraction of bicluster
communities (ensemble biclusters), the bicluster
network can be layouted as a network.

```
plot(bic_net)
```

![](data:image/png;base64...)
The networks are plotted using the `igraph` package. `igraph`
specific plotting parameters can be added.
For help type: `?igraph::plot.igraph`

To see, which bicluster was generated by which algorithm,
the following function can be executed:

```
mosbi::plot_algo_network(bic_net, all_bics, vertex.label = NA)
```

![](data:image/png;base64...)

The downloaded data contains samples from different weeks of
development. This can be visualized on the network, showing
from which week the samples within a bicluster come from.

```
# Prepare groups for plotting
weeks <- vapply(
    strsplit(colnames(data_matrix), "\\."),
    function(x) {
        return(x[1])
    }, ""
)

names(weeks) <- colnames(data_matrix)

print(sort(unique(weeks))) # 5 colors required
#> [1] "X12W" "X24W" "X32W" "X4W"  "X52W"

week_cols <- c("yellow", "orange", "red", "green", "brown")

# Plot network colored by week
mosbi::plot_piechart_bicluster_network(bic_net, all_bics, weeks,
    week_cols,
    vertex.label = NA
)
graphics::legend("topright",
    legend = sort(unique(weeks)),
    fill = week_cols, title = "Week"
)
```

![](data:image/png;base64...)

Such a visualization is also possible for the samples:

```
# Prepare groups for plotting
samples <- vapply(
    strsplit(colnames(data_matrix), "\\."),
    function(x) {
        return(x[2])
    }, ""
)

names(samples) <- colnames(data_matrix)

samples_cols <- RColorBrewer::brewer.pal(
    n = length(sort(unique(samples))),
    name = "Set3"
)

# Plot network colored by week
mosbi::plot_piechart_bicluster_network(bic_net, all_bics, samples,
    samples_cols,
    vertex.label = NA
)
graphics::legend("topright",
    legend = sort(unique(samples)),
    fill = samples_cols, title = "Sample"
)
```

![](data:image/png;base64...)

### 0.0.6 4. Extract louvain communities

Calculate the communities

```
coms <- mosbi::get_louvain_communities(bic_net,
    min_size = 3,
    bics = all_bics
)
# Only communities with a minimum size of 3 biclusters are saved.
```

#### 0.0.6.1 Visualization of the communities

```
# Plot all communities
for (i in seq(1, length(coms))) {
    tmp_bics <- mosbi::select_biclusters_from_bicluster_network(
        coms[[i]],
        all_bics
    )

    mosbi::plot_piechart_bicluster_network(coms[[i]], tmp_bics,
        weeks, week_cols,
        main = paste0("Community ", i)
    )
    graphics::legend("topright",
        legend = sort(unique(weeks)),
        fill = week_cols, title = "Week"
    )

    cat("\nCommunity ", i, " conists of results from the
             following algorithms:\n")
    cat(get_bic_net_algorithms(coms[[i]]))
    cat("\n")
}
```

![](data:image/png;base64...)

```
#>
#> Community  1  conists of results from the
#>              following algorithms:
#> fabia
```

![](data:image/png;base64...)

```
#>
#> Community  2  conists of results from the
#>              following algorithms:
#> isa2 biclust-qubic
```

![](data:image/png;base64...)

```
#>
#> Community  3  conists of results from the
#>              following algorithms:
#> isa2
```

![](data:image/png;base64...)

```
#>
#> Community  4  conists of results from the
#>              following algorithms:
#> isa2
```

![](data:image/png;base64...)

```
#>
#> Community  5  conists of results from the
#>              following algorithms:
#> isa2 biclust-plaid biclust-qubic
```

![](data:image/png;base64...)

```
#>
#> Community  6  conists of results from the
#>              following algorithms:
#> biclust-qubic
```

![](data:image/png;base64...)

```
#>
#> Community  7  conists of results from the
#>              following algorithms:
#> biclust-qubic
```

#### 0.0.6.2 Extraction of the communities

Finally, communities of the network can be extracted as ensemble biclusters.
The are saved as a list of `mosbi::bicluster` objects and therefore in the
same format as the imported results of all the algorithms.
With the parameters `row_threshold` & `col_threshold`,
the minimum occurrence of a row- or column-element in the biclusters
of a community can be defined.

```
ensemble_bicluster_list <- mosbi::ensemble_biclusters(coms, all_bics,
    data_matrix,
    row_threshold = .1,
    col_threshold = .1
)
```

# 1 Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] mosbi_1.16.0     BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyr_1.3.1             sass_0.4.10             generics_0.1.4
#>  [4] class_7.3-23            lattice_0.22-7          digest_0.6.37
#>  [7] magrittr_2.0.4          evaluate_1.0.5          grid_4.5.1
#> [10] RColorBrewer_1.1-3      bookdown_0.45           fastmap_1.2.0
#> [13] jsonlite_2.0.0          tinytex_0.57            BiocManager_1.30.26
#> [16] purrr_1.1.0             scales_1.4.0            modeltools_0.2-24
#> [19] jquerylib_0.1.4         cli_3.6.5               isa2_0.3.6
#> [22] rlang_1.1.6             Biobase_2.70.0          cachem_1.1.0
#> [25] yaml_2.3.10             tools_4.5.1             parallel_4.5.1
#> [28] biclust_2.0.3.1         dplyr_1.1.4             colorspace_2.1-2
#> [31] ggplot2_4.0.0           BiocGenerics_0.56.0     vctrs_0.6.5
#> [34] R6_2.6.1                stats4_4.5.1            lifecycle_1.0.4
#> [37] magick_2.9.0            QUBIC_1.38.0            MASS_7.3-65
#> [40] pkgconfig_2.0.3         RcppParallel_5.1.11-1   bslib_0.9.0
#> [43] pillar_1.11.1           gtable_0.3.6            glue_1.8.0
#> [46] Rcpp_1.1.0              tidyselect_1.2.1        tibble_3.3.0
#> [49] xfun_0.53               flexclust_1.5.0         knitr_1.50
#> [52] dichromat_2.0-0.1       farver_2.1.2            fabia_2.56.0
#> [55] igraph_2.2.1            htmltools_0.5.8.1       rmarkdown_2.30
#> [58] BH_1.87.0-1             compiler_4.5.1          S7_0.2.0
#> [61] additivityTests_1.1-4.2
```