# ***tanggle***: Visualization of phylogenetic networks in a *ggplot2* framework

Klaus Schliep1, Marta Vidal-García2, Leann Biancani3, Francisco Henao Diaz4, Eren Ada3 and Claudia Solís-Lemus5\*

1Graz University of Technology
2University of Calgary
3University of Rhode Island
4University of British Columbia
5University of Wisconsin-Madison

\*klaus.schliep@gmail.com

#### 30 October 2025

#### Package

tanggle 1.16.0

# 1 Introduction

Here we present a vignette for the R package ***tanggle***, and provide an
overview of its functions and their usage. ***Tanggle*** extends the *ggtree*
R package (Yu et al. [2017](#ref-Yu2017)) to allow for the visualization of several types of
phylogenetic networks using the *ggplot2* (Wickham [2016](#ref-Wickham2016)) syntax. More
specifically, *tanggle* contains functions to allow the user to effectively
plot: (1) split (i.e. implicit) networks (unrooted, undirected) and
(2) explicit networks (rooted, directed) with reticulations.
It offers an alternative to the plot functions already available
in *ape* (Paradis and Schliep [2018](#ref-Paradis2018)) and *phangorn* (Schliep [2011](#ref-Schliep2011)).

# 2 List of functions

| Function name | Brief description |
| --- | --- |
| `geom_splitnet` | Adds a *splitnet* layer to a ggplot, to combine visualising data and the network |
| `ggevonet` | Plots an explicit network from a *phylo* object |
| `ggsplitnet` | Plots an implicit network from a *phylo* object |
| `minimize_overlap` | Reduces the number of reticulation lines crossing over in the plot |
| `node_depth_evonet` | Returns the depths or heights of nodes and tips in the phylogenetic network |

# 3 Getting started

Install the package from Bioconductor directly:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("tanggle")
```

Or install the development version of the package from
[Github](https://github.com/KlausVigo/tanggle).

```
if (!requireNamespace("remotes", quietly=TRUE))
  install.packages("remotes")
remotes::install_github("KlausVigo/tanggle")
```

If you need to install *ggtree* from github:

```
remotes::install_github("YuLab-SMU/ggtree")
```

And load all the libraries:

```
library(tanggle)
library(phangorn)
library(ggtree)
```

---

# 4 Split Networks

Split networks are data-display objects which allow for the definition of 2 (or
more) options for non-compatible splits. Split networks are most often used to
visualize consensus networks (Holland et al. [2004](#ref-Holland2004)) or neighbor-nets
(Bryant and Moulton [2004](#ref-Bryant2004)). This can be done either by using the `consensusNet` or
`neighbor-net` functions in *phangorn* (Schliep [2011](#ref-Schliep2011)) or by importing
nexus files from SplitsTree (Huson and Bryant [2006](#ref-Huson2006)).

## 4.1 Data Types

*tanggle* accepts three forms of input data for split networks. The
following input options all generate a *networx* object for plotting.

* Nexus file created with SplitsTree (Huson and Bryant [2006](#ref-Huson2006)) and read with the
  `read.nexus.network` function in *phangorn* (Schliep [2011](#ref-Schliep2011)).
* Read in a split network in nexus format:

```
fdir <- system.file("extdata/trees", package = "phangorn")
Nnet <- phangorn::read.nexus.networx(file.path(fdir,"woodmouse.nxs"))
```

2. A collection of gene trees (e.g.~from RAxML
   (Stamatakis [2014](#ref-Stamatakis2014RAxML))) in one of the following formats:
   * Nexus file read with the function `read.nexus`
   * Text file in Newick format (one gene tree per line) read with the
     function `read.tree`
     A consensus split network is then computed using the function `consensusNet`
     in *phangorn* (Schliep [2011](#ref-Schliep2011)).

* Sequences in nexus, fasta or phylip format, read with the function
  `read.phyDat` in *phangorn* (Schliep [2011](#ref-Schliep2011)) or the function `read.dna` in
  *ape* (Paradis and Schliep [2018](#ref-Paradis2018)). Distances matrices are then computed for specific models
  of evolution using the function `dist.ml` in *phangorn* (Schliep [2011](#ref-Schliep2011)) or
  `dist.dna` in *ape* (Paradis and Schliep [2018](#ref-Paradis2018)). From the distance matrix, a split network is
  reconstructed using the function `neighborNet` in *phangorn* (Schliep [2011](#ref-Schliep2011)).
  ***Optional***: branch lengths may be estimated using the function
  `splitsNetworks` in *phangorn* (Schliep [2011](#ref-Schliep2011)).

## 4.2 Plotting a Split Network:

We can plot the network with the default options:

```
p <- ggsplitnet(Nnet) + geom_tiplab2()
p
```

![](data:image/png;base64...)

When we can set the limits for the x and y axis so that the labels are readable.

```
p <- p + xlim(-0.019, .003) + ylim(-.01,.012)
p
```

![](data:image/png;base64...)

You can rename tip labels. Here we changed the names to species from 1 to 15:

```
Nnet$translate$label <- seq_along(Nnet$tip.label)
```

We can include the tip labels with `geom_tiplab2`, and customize some of the
options. For example, here the tip labels are in blue and both in bold and
italics, and we show the internal nodes in green:

```
ggsplitnet(Nnet) + geom_tiplab2(col = "blue", font = 4, hjust = -0.15) +
    geom_nodepoint(col = "green", size = 0.25)
```

![](data:image/png;base64...)

Nodes can also be annotated with `geom_point`.

```
ggsplitnet(Nnet) + geom_point(aes(shape=isTip, color=isTip), size=2)
```

![](data:image/png;base64...)

## 4.3 Plotting Explicit Networks

The function `ggevonet` plots explicit networks (phylogenetic trees
with reticulations). A recent addition to *ape* (Paradis and Schliep [2018](#ref-Paradis2018)) made
it possible to read in trees in extended newick format (Cardona, Rosselló, and Valiente [2008](#ref-Cardona2008)).

Read in an explicit network (example from Fig. 2 in Cardona et al. 2008):

```
z <- read.evonet(text = "((1,((2,(3,(4)Y#H1)g)e,(((Y#H1,5)h,6)f)X#H2)c)a,
                 ((X#H2,7)d,8)b)r;")
```

Plot an explicit network:

```
ggevonet(z, layout = "rectangular") + geom_tiplab() + geom_nodelab()
```

![](data:image/png;base64...)

```
p <- ggevonet(z, layout = "slanted") + geom_tiplab() + geom_nodelab()
p + geom_tiplab(size=3, color="purple")
```

![](data:image/png;base64...)

```
p + geom_nodepoint(color="#b5e521", alpha=1/4, size=10)
```

![](data:image/png;base64...)

# 5 Summary

This vignette illustrates all the functions in the R package ***tanggle***, and
provides some examples on how to plot both explicit and implicit networks. The
split network plots should take most of the functions compatible with unrooted
trees in ggtree. The layout options for explicit network plots are *rectangular*
or *slanted*.

# Session info

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
#> [1] phangorn_2.12.1  ape_5.8-1        tanggle_1.16.0   ggtree_4.0.1
#> [5] ggplot2_4.0.0    BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] fastmatch_1.1-6         gtable_0.3.6            xfun_0.54
#>  [4] bslib_0.9.0             htmlwidgets_1.6.4       lattice_0.22-7
#>  [7] quadprog_1.5-8          vctrs_0.6.5             tools_4.5.1
#> [10] generics_0.1.4          yulab.utils_0.2.1       parallel_4.5.1
#> [13] tibble_3.3.0            pkgconfig_2.0.3         Matrix_1.7-4
#> [16] ggplotify_0.1.3         RColorBrewer_1.1-3      S7_0.2.0
#> [19] lifecycle_1.0.4         compiler_4.5.1          farver_2.1.2
#> [22] treeio_1.34.0           tinytex_0.57            codetools_0.2-20
#> [25] ggfun_0.2.0             fontquiver_0.2.1        fontLiberation_0.1.0
#> [28] htmltools_0.5.8.1       sass_0.4.10             yaml_2.3.10
#> [31] lazyeval_0.2.2          pillar_1.11.1           jquerylib_0.1.4
#> [34] tidyr_1.3.1             cachem_1.1.0            magick_2.9.0
#> [37] nlme_3.1-168            fontBitstreamVera_0.1.1 tidyselect_1.2.1
#> [40] aplot_0.2.9             digest_0.6.37           dplyr_1.1.4
#> [43] purrr_1.1.0             bookdown_0.45           labeling_0.4.3
#> [46] fastmap_1.2.0           grid_4.5.1              cli_3.6.5
#> [49] magrittr_2.0.4          patchwork_1.3.2         dichromat_2.0-0.1
#> [52] withr_3.0.2             gdtools_0.4.4           scales_1.4.0
#> [55] rappdirs_0.3.3          rmarkdown_2.30          igraph_2.2.1
#> [58] evaluate_1.0.5          knitr_1.50              gridGraphics_0.5-1
#> [61] rlang_1.1.6             ggiraph_0.9.2           Rcpp_1.1.0
#> [64] glue_1.8.0              tidytree_0.4.6          BiocManager_1.30.26
#> [67] jsonlite_2.0.0          R6_2.6.1                systemfonts_1.3.1
#> [70] fs_1.6.6
```

# 6 References

Bryant, David, and Vincent Moulton. 2004. “Neighbor-Net: An Agglomerative Method for the Construction of Phylogenetic Networks.” *Molecular Biology and Evolution* 21 (2): 255–65. <https://doi.org/10.1093/molbev/msh018>.

Cardona, Gabriel, Francesc Rosselló, and Gabriel Valiente. 2008. “Extended Newick: It Is Time for a Standard Representation of Phylogenetic Networks.” *BMC Bioinformatics* 9 (1): 532. <https://doi.org/10.1186/1471-2105-9-532>.

Holland, Barbara R., Katharina T. Huber, Vincent Moulton, and Peter J. Lockhart. 2004. “Using Consensus Networks to Visualize Contradictory Evidence for Species Phylogeny.” *Molecular Biology and Evolution* 21 (7): 1459–61. <https://doi.org/10.1093/molbev/msh145>.

Huson, D. H., and D. Bryant. 2006. “Application of Phylogenetic Networks in Evolutionary Studies.” *Molecular Biology and Evolution* 23 (2): 254–67.

Paradis, Emmanuel, and Klaus Schliep. 2018. “Ape 5.0: An Environment for Modern Phylogenetics and Evolutionary Analyses in R.” *Bioinformatics* 35 (3): 526–28.

Schliep, Klaus Peter. 2011. “Phangorn: Phylogenetic Analysis in R.” *Bioinformatics* 27 (4): 592–93. <https://doi.org/10.1093/bioinformatics/btq706>.

Stamatakis, A. 2014. “raXml Version 8: A Tool for Phylogenetic Analysis and Post-Analysis of Large Phylogenies.” *Bioinformatics* 30 (9): 1312–3.

Wickham, Hadley. 2016. *Ggplot2: Elegant Graphics for Data Analysis*. Springer-Verlag New York. <https://ggplot2.tidyverse.org>.

Yu, Guangchuang, David Smith, Huachen Zhu, Yi Guan, and Tommy Tsan-Yuk Lam. 2017. “Ggtree: An R Package for Visualization and Annotation of Phylogenetic Trees with Their Covariates and Other Associated Data.” *Methods in Ecology and Evolution* 8 (1): 28–36. <https://doi.org/10.1111/2041-210X.12628>.

# Appendix