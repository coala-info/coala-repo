# Analyzing differential co-expression with csdR

#### 29 October 2025

# Contents

* [1 When and why to use this package](#when-and-why-to-use-this-package)
* [2 Installation](#installation)
* [3 Some theoretical considerations](#some-theoretical-considerations)
* [4 Workflow outline](#workflow-outline)
  + [4.1 How to we approach from here?](#how-to-we-approach-from-here)
* [5 Considerations to note](#considerations-to-note)
  + [5.1 Number of bootstrap iterations](#number-of-bootstrap-iterations)
  + [5.2 Number of threads](#number-of-threads)
  + [5.3 Memory consumption](#memory-consumption)
  + [5.4 Number of top gene pairs to pick](#number-of-top-gene-pairs-to-pick)
* [6 Session info for this vignette](#session-info-for-this-vignette)
* [References](#references)

# 1 When and why to use this package

The purpose of this package is to compare the gene expression of the genes
in *two* different conditions.
The most typical case is when comparing gene expression in patients
with a disease with gene expression in study participants without the disease.
Hence, we may construct a network containing genes which are relevant
for the development of the disease.
The input data may come from different measurements of expression such as
microarray, proteomics or RNA-seq as long as:

* There are no missing values in the data.
  Consider filling in with average values
  or pseudo-values if this is not the case.
* The expression values are coded as continuous numerical values which
  are comparable between samples.
  Note that only the ranks of each gene across the samples does matter
  as CSD uses the rank-based Spearman correlation.
* The gene labels for the two conditions must match.

For differential gene-expression involving more than two separate conditions,
consider `CoDiNA` (Morselli Gysi [2020](#ref-MorselliGysi2020)) instead.

# 2 Installation

This package is hosted on Bioconductor. To install it, type:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("csdR")
```

Then,

```
library(csdR)
#>
```

should load the package into the current **R** session.
For this vignette, we further load some auxiliary packages
and set the random seed

```
suppressPackageStartupMessages({
    library(magrittr)
    library(igraph)
    library(glue)
    library(dplyr)
})
set.seed(45394534)
```

# 3 Some theoretical considerations

This is a re-implementation and slight modification of the CSD algorithm
presented by Voigt *et al.* 2017(Voigt [2017](#ref-Voigt2017)).
In the first phase, the algorithm finds the co-expression between
all genes within each condition using the Spearman correlation.
For each pair of genes, we apply bootstrapping across the samples
and compute the mean Spearman correlation
\(\rho\_1\) and \(\rho\_2\) for the two conditions and the associated
standard errors \(\sigma\_1\) and \(\sigma\_2\).
In the second stage, the values for the two conditions are compared and gives us
the following *differential* co-expression scores:

* Conserved score,
  \(C=\frac{\left|\rho\_1+\rho\_2\right|}{\sqrt{\sigma\_1^2+\sigma\_2^2}}\),
  a high value indicating the same strong co-expression in both conditions.
* Specific score,
  \(S=\frac{\left|\left|\rho\_1\right|-\left|\rho\_2\right|\right|}{\sqrt{\sigma\_1^2+\sigma\_2^2}}\),
  a high value indicating a strong co-expression in one condition,
  but not in the other.
* Differentiated score,
  \(D=\frac{\left|\left|\rho\_1\right|+\left|\rho\_2\right|-\left|\rho\_1+\rho\_2\right|\right|}{\sqrt{\sigma\_1^2+\sigma\_2^2}}\),
  a high value indicating a strong co-expression in both conditions,
  but with the opposite sign.

# 4 Workflow outline

In this example, we are provided by two expression expression matrices
from thyroid glands,
`sick_expression` for patients with thyroid cancer
and `normal_expression` for healthy controls.
To run the CSD analysis for these two conditions, we simply do the following:

```
data("sick_expression")
data("normal_expression")
csd_results <- run_csd(
    x_1 = sick_expression, x_2 = normal_expression,
    n_it = 10, nThreads = 2L, verbose = FALSE
)
```

After obtaining these results, we may write them to disk.
However, for datasets with thousands of genes,
we will get millions upon millions of gene pairs.
Writing the results to disk is likely to fill up gigabytes
of valuable storage space
while the disk IO itself might take a considerable amount of time.
Furthermore, we must reduce the information load to create meaningful results,
so we better to that while the data is still in memory.
We decide to select the 100 edges with highest C, S, and D-score.

```
pairs_to_pick <- 100L
c_filter <- partial_argsort(csd_results$cVal, pairs_to_pick)
c_frame <- csd_results[c_filter, ]
s_filter <- partial_argsort(csd_results$sVal, pairs_to_pick)
s_frame <- csd_results[s_filter, ]
d_filter <- partial_argsort(csd_results$dVal, pairs_to_pick)
d_frame <- csd_results[d_filter, ]
```

Why does the `csdR` package provide a general `partial_argsort` function
which takes in a numeric vector
and spits out the indecies of the largest elements
instead of a more specialized function
directly extracting the top results from the dataframe?
The answer is flexibility.
Writing an additional line of code and a dollar sign
is not that much work after all
and we may want more flexible approaches such
as displaying the union of the C, S- and D-edges:

```
csd_filter <- c_filter %>%
    union(s_filter) %>%
    union(d_filter)
csd_frame <- csd_results[csd_filter, ]
```

## 4.1 How to we approach from here?

The next logical step is to construct a network and do some analysis.
This is outside the scope of this package,
but we will provide some pointers for completeness.
One viable approach is to use the ordinary `write.table` function
to write the results of a file
and then use an external tools such as Cytoscape to further make conclusions.
Often, you may want to make an ontology enrichment of the genes.

The other option is of course to continue using R.
Here, we provide an example of combining the C-, S- and D-networks
and coloring the edges blue, green and red,
respectively depending of where they come from.

```
c_network <- graph_from_data_frame(c_frame, directed = FALSE)
s_network <- graph_from_data_frame(s_frame, directed = FALSE)
d_network <- graph_from_data_frame(d_frame, directed = FALSE)
E(c_network)$edge_type <- "C"
E(s_network)$edge_type <- "S"
E(d_network)$edge_type <- "D"
combined_network <- igraph::union(c_network, s_network, d_network)
# Auxillary function for combining
# the attributes of the three networks in a proper way
join_attributes <- function(graph, attribute) {
    ifelse(
        test = is.na(edge_attr(graph, glue("{attribute}_1"))),
        yes = ifelse(
            test = is.na(edge_attr(graph, glue("{attribute}_2"))),
            yes = edge_attr(graph, glue("{attribute}_3")),
            no = edge_attr(graph, glue("{attribute}_2"))
        ),
        no = edge_attr(graph, glue("{attribute}_1"))
    )
}
E(combined_network)$edge_type <- join_attributes(combined_network, "edge_type")
layout <- layout_nicely(combined_network)
E(combined_network)$color <- recode(E(combined_network)$edge_type,
    C = "darkblue", S = "green", D = "darkred"
)
plot(combined_network, layout = layout,
    vertex.size = 3, edge.width = 2, vertex.label.cex = 0.001)
```

![](data:image/png;base64...)

# 5 Considerations to note

## 5.1 Number of bootstrap iterations

As with any bootstrap procedure the number of iterations represented by
the argument `n_it` needs to be *sufficiently large*
in order to get reproducible results.
What this means is a matter of trial and error.
In general this means that you should re-run the computations
with a different random seed to see whether
the number of bootstrap iterations are sufficient.
Experience has shown that ~ 100 iterations might
be sufficient to reproduce almost the same results in some cases,
whereas in other cases,
especially when the values are close,
you may choose to run several thousand iterations.

## 5.2 Number of threads

The parallelization of `csdR` occurs within each individual iteration. While parallelizing across the iterations would in theory yield better CPU utilization, this approach is unfeasible due the fact that memory consumption use would almost be proportional to the number of threads. Instead, parallelization is used in computing the co-expression matrix and updating the mean and variance for each iteration. As shown in the `csdR` paper, parallelism can provide 2x-3x speedup, but there are diminishing returns in the performance gained, so running more than 10 threads is most likely a waste a resources. Limited memory bandwidth is the most likely culprit behind the failure to scale, so systems with higher memory bandwidth are more likely to utilize multiple threads better.

## 5.3 Memory consumption

For datasets with 20 000 to 30 000 genes,
a considerable amount of memory is consumed during the computations.
It it therefore not recommended in such cases to run CSD on your laptop
or even a workstation,
but rather on a compute server with several hundreds GB of RAM.

## 5.4 Number of top gene pairs to pick

How many gene pairs to select depends on the specific needs
and how big a network you want to handle.
A 10 000 edge network may not be easy to visualize,
but quantitative network metrics can still be extracted.
Also, generating more edges than necessary usually does not make
any major harm as superfluous edges can quickly be filter out afterwards.
However, if you select fewer edges than you actually need,
you have to re-do all calculations to increase the number.

# 6 Session info for this vignette

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
#> [1] dplyr_1.1.4      glue_1.8.0       igraph_2.2.1     magrittr_2.0.4
#> [5] csdR_1.16.0      BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1      WGCNA_1.73            farver_2.1.2
#>  [4] blob_1.2.4            Biostrings_2.78.0     S7_0.2.0
#>  [7] fastmap_1.2.0         digest_0.6.37         rpart_4.1.24
#> [10] lifecycle_1.0.4       cluster_2.1.8.1       survival_3.8-3
#> [13] KEGGREST_1.50.0       RSQLite_2.4.3         compiler_4.5.1
#> [16] rlang_1.1.6           Hmisc_5.2-4           sass_0.4.10
#> [19] tools_4.5.1           yaml_2.3.10           data.table_1.17.8
#> [22] knitr_1.50            htmlwidgets_1.6.4     bit_4.6.0
#> [25] RColorBrewer_1.1-3    foreign_0.8-90        BiocGenerics_0.56.0
#> [28] nnet_7.3-20           dynamicTreeCut_1.63-1 grid_4.5.1
#> [31] stats4_4.5.1          preprocessCore_1.72.0 colorspace_2.1-2
#> [34] fastcluster_1.3.0     GO.db_3.22.0          ggplot2_4.0.0
#> [37] scales_1.4.0          iterators_1.0.14      tinytex_0.57
#> [40] dichromat_2.0-0.1     cli_3.6.5             rmarkdown_2.30
#> [43] crayon_1.5.3          generics_0.1.4        rstudioapi_0.17.1
#> [46] httr_1.4.7            DBI_1.2.3             cachem_1.1.0
#> [49] stringr_1.5.2         splines_4.5.1         parallel_4.5.1
#> [52] impute_1.84.0         AnnotationDbi_1.72.0  BiocManager_1.30.26
#> [55] XVector_0.50.0        matrixStats_1.5.0     base64enc_0.1-3
#> [58] vctrs_0.6.5           Matrix_1.7-4          jsonlite_2.0.0
#> [61] bookdown_0.45         IRanges_2.44.0        S4Vectors_0.48.0
#> [64] bit64_4.6.0-1         htmlTable_2.4.3       Formula_1.2-5
#> [67] magick_2.9.0          foreach_1.5.2         jquerylib_0.1.4
#> [70] codetools_0.2-20      stringi_1.8.7         gtable_0.3.6
#> [73] tibble_3.3.0          pillar_1.11.1         htmltools_0.5.8.1
#> [76] Seqinfo_1.0.0         R6_2.6.1              doParallel_1.0.17
#> [79] evaluate_1.0.5        lattice_0.22-7        Biobase_2.70.0
#> [82] backports_1.5.0       png_0.1-8             RhpcBLASctl_0.23-42
#> [85] memoise_2.0.1         bslib_0.9.0           Rcpp_1.1.0
#> [88] checkmate_2.3.3       gridExtra_2.3         xfun_0.53
#> [91] pkgconfig_2.0.3
```

# References

Morselli Gysi, Tiago AND Zebardast, Deisy AND de Miranda Fragoso. 2020. “Whole Transcriptomic Network Analysis Using Co-Expression Differential Network Analysis (Codina).” *PLOS ONE* 15 (10): 1–28. <https://doi.org/10.1371/journal.pone.0240523>.

Voigt, Katja AND Almaas, André AND Nowick. 2017. “A Composite Network of Conserved and Tissue Specific Gene Interactions Reveals Possible Genetic Interactions in Glioma.” *PLOS Computational Biology* 13 (9): 1–34. <https://doi.org/10.1371/journal.pcbi.1005739>.