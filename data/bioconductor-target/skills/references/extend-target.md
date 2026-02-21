# Using `target` to predict combined binding

#### Mahmoud Ahmed

#### 2025-10-30

## Overview

In this document, we extend the BETA algorithm to predict cooperative and/or competitive binding events of two factors at the same region of interest. This method uses the same theory described in `vignette('target')` with one modification. Instead of using an individual statistics from a factor perturbation experiment, we use two separate statistics from two comparable factor perturbation experiments to define a regulatory interaction (\(RI\)). This regulatory interaction terms are used to calculate rank products of the regions of interest. In addition, we illustrate the use of this method with a simulated dataset and an example of real-world data.

## Theory

This method is an extension of the BETA *basic* algorithm. Briefly, the rank product of a regions of interest (\(RP\_g\)) is the product of two terms; the rank of a statistics from factor perturbation experiment (\(R\_{ge}\)) and the rank of the regulatory potential (\(R\_{gb}\)). The regulatory potential of region of interest (\(S\_g\)) is the sum of the peaks within a predefined distance:

\[
S\_g = \sum\_{i=1}^k e^{-(0.5+4\Delta\_i)}
\quad\text{and}\quad
RP\_g = \frac{R\_{gb}\times R\_{ge}}{n^2}
\] Where \(p\) is a peak in \(\{1,...,k\}\) with a distance, \(\Delta\), from the center of the region of interest.

Two determine the relation of two factors \(x\) and \(y\) on a common peak near a region of interest, we define a new term; the regulatory interaction (\(RI\)) as the product of two signed statistics from comparable perturbation experiments. The rank of this term is used to calculate a rank product (\(PR\_g\)) for each region of interest as described above

\[
RI\_{g} = x\_{ge}\times y\_{ge}
\quad\text{and}\quad
RP\_g = \frac{R\_{gb}\times RI\_{ge}}{n^2}
\]

This term would represent the interaction magnitude assuming a linear relation between the two factor. The sign of the term would define the direction of the relation were positive means cooperative and negative means competitive.

## Example

The `target` package contain two simulated datasets. `sim_peaks` is random peaks with random distances from the transcripts of chromosome 1 of the mm10 mouse genome. `sim_transcripts` is the same transcripts with random singed statistics assigned to each. In the following two examples, we introduce changes in these statistics to simulate conditions where two factors are working cooperatively or competitively on the same transcripts.

```
# load libraries
library(target)
```

```
# load data
data("sim_peaks")
data("sim_transcripts")
```

To help visualize these cases, a plotting function `plot_profiles` was constructed to introduce the changes `change` in the statistics of the transcripts near the `n` number of peaks. The source code for the function is available in `inst/extdata/plot-profiles.R` which we source to use here. The output of the function is a series of plots to visualize the statistics of the two factors before and after introducing the changes, the peaks distances and scores and the predicted functions of the factors individually and combined.

```
# source the plotting function
source(system.file('extdata', 'plot-profiles.R', package = 'target'))
```

### Cooperative factors example

The first two inputs to the plotting function is the simulated peaks and transcripts. We chose to introduce positive changes to the statistics of the transcripts with the top 5000 nearby peaks of the two factors.

```
# simulate and plot cooperative factors
plot_profiles(sim_peaks,
              sim_transcripts,
              n = 5000,
              change = c(3, 3))
```

![](data:image/png;base64...)

The changes introduced above are illustrated in the right upper quadrant of the scatter plot. The predicted functions of the two factors are similar, as shown by distribution function of the regulatory potential of their targets. Finally, when the targets are predicted based on the two statistics combined, the sign of the statistics product determines the direction of the factor interactions. Here, more higher ranking transcripts had positive/red/ cooperative change associated with the two factors.

### Competitive factors example

Similar to the example above, we chose to introduce change to the statistics of the transcripts with nearby peaks for the two factors. To simulate the competitive conditions of the two factors, the changes have opposite signs.

```
# simulate and plot competitve factors
plot_profiles(sim_peaks,
              sim_transcripts,
              n = 5000,
              change = c(3, -3))
```

![](data:image/png;base64...)

By contrast, the changes associated with each factor are opposite in sign, as shown in the lower right quadrant. The predicted functions of the individual factors are also the opposite. The predicted combined effect of the two factors is negative/green/competitive.

## References

Wang S, Sun H, Ma J, et al. Target analysis by integration of transcriptome and ChIP-seq data with BETA. Nat Protoc. 2013;8(12):2502–2515. doi:10.1038/nprot.2013.150

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
#> [1] target_1.24.0
#>
#> loaded via a namespace (and not attached):
#>  [1] cli_3.6.5            knitr_1.50           rlang_1.1.6
#>  [4] xfun_0.53            otel_0.2.0           promises_1.4.0
#>  [7] generics_0.1.4       shiny_1.11.1         xtable_1.8-4
#> [10] jsonlite_2.0.0       S4Vectors_0.48.0     htmltools_0.5.8.1
#> [13] httpuv_1.6.16        sass_0.4.10          stats4_4.5.1
#> [16] rmarkdown_2.30       Seqinfo_1.0.0        evaluate_1.0.5
#> [19] jquerylib_0.1.4      fastmap_1.2.0        yaml_2.3.10
#> [22] IRanges_2.44.0       lifecycle_1.0.4      compiler_4.5.1
#> [25] Rcpp_1.1.0           later_1.4.4          digest_0.6.37
#> [28] R6_2.6.1             magrittr_2.0.4       GenomicRanges_1.62.0
#> [31] bslib_0.9.0          tools_4.5.1          mime_0.13
#> [34] matrixStats_1.5.0    BiocGenerics_0.56.0  cachem_1.1.0
```