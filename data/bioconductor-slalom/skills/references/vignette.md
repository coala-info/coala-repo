# Introduction to slalom

Davis McCarthy and Florian Buettner1

1EMBL-EBI

#### 30 October 2025

#### Package

slalom 1.32.0

# Contents

* [1 Quickstart](#quickstart)
* [2 Input data and genesets](#input-data-and-genesets)
* [3 Creating a new model](#creating-a-new-model)
* [4 Initializing the model](#initializing-the-model)
* [5 Training the model](#training-the-model)
* [6 Interpretation of results](#interpretation-of-results)
  + [6.1 Top terms](#top-terms)
  + [6.2 Plotting results](#plotting-results)
* [7 Using results for further analyses](#using-results-for-further-analyses)
  + [7.1 Adding results to a `SingleCellExperiment` object](#adding-results-to-a-singlecellexperiment-object)
  + [7.2 More plots and egressing out hidden/unwanted factors](#more-plots-and-egressing-out-hiddenunwanted-factors)
* [8 Session Info](#session-info)

This document provides an introduction to the capabilities of `slalom`. The
package can be used to identify hidden and biological drivers of variation in
single-cell gene expression data using factorial single-cell latent
variable models.

# 1 Quickstart

Slalom requires:
1. expression data in a `SingleCellExperiment` object (defined in
`SingleCellExperiment` package), typically with log transformed gene expression values;
2. Gene set annotations in a `GeneSetCollection` class (defined in the
`GSEABase` package). A `GeneSetCollection` can be read into R from a `*.gmt`
file as shown below.

Here, we show the minimal steps required to run a `slalom` analysis on a subset
of a mouse embryonic stem cell (mESC) cell cycle-staged dataset.

First, we load the `mesc` dataset included with the package. The `mesc` object
loaded is a `SingleCellExperiment` object ready for input to `slalom`

```
library(slalom)
data("mesc")
```

If we only had a matrix of expression values (assumed to be on the log2-counts
scale), then we can easily construct a `SingleCellExperiment` object as follows:

```
exprs_matrix <- SingleCellExperiment::logcounts(mesc)
mesc <- SingleCellExperiment::SingleCellExperiment(
    assays = list(logcounts = exprs_matrix)
)
```

We also need to supply `slalom` with genesets in a `GeneSetCollection` object.
If we have genesets stored in a `*.gmt` file (e.g. obtained from
[MSigDB](http://software.broadinstitute.org/gsea/msigdb) or
[REACTOME](http://reactome.org/)) then it is easy to read these directory into
an appropriate object, as shown below for a subset of REACTOME genesets.

```
gmtfile <- system.file("extdata", "reactome_subset.gmt", package = "slalom")
genesets <- GSEABase::getGmt(gmtfile)
```

Next we need to create an `Rcpp_SlalomModel` object containing the input data
and genesets (and subsequent results) for the model. We create the object with
the `newSlalomModel` function.

We need to define the number of hidden factors to include in the model
(`n_hidden` argument; 2–5 hidden factors recommended) and the minimum number of
genes required to be present in order to retain a geneset (`min_genes` argument;
default is 10).

```
model <- newSlalomModel(mesc, genesets, n_hidden = 5, min_genes = 10)
```

```
## 14 annotated factors retained;  16 annotated factors dropped.
## 196  genes retained for analysis.
```

Next we need to *initialise* the model with the `init` function.

```
model <- initSlalom(model)
```

With the model prepared, we then *train* the model with the `train` function.

```
model <- trainSlalom(model, nIterations = 10)
```

```
## pre-training model for faster convergence
## iteration 0
## Model not converged after 50 iterations.
## iteration 0
## Model not converged after 50 iterations.
## iteration 0
## Switched off factor 7
## Switched off factor 17
## Model not converged after 10 iterations.
```

Typically, over 1,000 iterations will be required for the model to converge.

Finally, we can analyse and interpret the output of the model and the sources
of variation that it identifies. This process will typically include plots of
factor relevance, gene set augmentation and a scatter plots of the most relevant
factors.

# 2 Input data and genesets

As introduced above, `slalom` requires:
1. expression data in a `SingleCellExperiment` object (defined in
`SingleCellExperiment` package), typically with log transformed gene expression values;
2. Gene set annotations in a `GeneSetCollection` class (defined in the
[`GSEABase`](http://bioconductor.org/packages/GSEABase/) package).

Slalom works best with log-scale expression data that has been QC’d, normalized
and subsetted down to highly-variable genes. Happily, there are Bioconductor
packages available for QC and normalization that also use the
`SingleCellExperiment` class and can provide appropriate input for `slalom`.
The combination of [`scater`](http://bioconductor.org/packages/scater/) and
[`scran`](http://bioconductor.org/packages/scran/) is very effective for QC,
normalization and selection of highly-variable genes. A Bioconductor
[workflow](https://f1000research.com/articles/5-2122/v2) shows how those
packages can be combined to good effect to prepare data suitable for analysis
with `slalom`.

Here, to demonstrate `slalom` we will use simulated data. First, we make a new
`SingleCellExperiment` object. The code below reads in an expression matrix
from file, creates a `SingleCellExperiment` object with these expression values
in the `logcounts` slot.

```
rdsfile <- system.file("extdata", "sim_N_20_v3.rds", package = "slalom")
sim <- readRDS(rdsfile)
sce <- SingleCellExperiment::SingleCellExperiment(
    assays = list(logcounts = sim[["init"]][["Y"]])
)
```

The second crucial input for `slalom` is the set of genesets or pathways that we
provide to the model to see which are active. The model is capable of handling
hundreds of genesets (pathways) simultaneously.

Geneset annotations must be provided as a `GeneSetCollection` object as defined
in the [`GSEABase`](http://bioconductor.org/packages/GSEABase/) package.

Genesets are typically distributed as `*.gmt` files and are available from such
sources as [MSigDB](http://software.broadinstitute.org/gsea/msigdb) or
[REACTOME](http://reactome.org/). The `gmt` format is very simple, so it
is straight-forward to augment established genesets with custom sets tailored to
the data at hand, or indeed to construct custom geneset collections completely
from scratch.

If we have genesets stored in a `*.gmt` file (e.g. from MSigDB, REACTOME or
elsewhere) then it is easy to read these directory into an appropriate object,
as shown below for a subset of REACTOME genesets.

```
gmtfile <- system.file("extdata", "reactome_subset.gmt", package = "slalom")
genesets <- GSEABase::getGmt(gmtfile)
```

Geneset names can be very long, so below we trim the REACTOME geneset names to
remove the “REACTOME\_” string and truncate the names to 30 characters. (This is
much more convenient downstream when we want to print relevant terms and create
plots that show geneset names.)

We also tweak the row (gene) and column (cell) names so that our example data works
nicely.

```
genesets <- GSEABase::GeneSetCollection(
    lapply(genesets, function(x) {
        GSEABase::setName(x) <- gsub("REACTOME_", "", GSEABase::setName(x))
        GSEABase::setName(x) <- strtrim(GSEABase::setName(x), 30)
        x
    })
)
rownames(sce) <- unique(unlist(GSEABase::geneIds(genesets[1:20])))[1:500]
colnames(sce) <- 1:ncol(sce)
```

With our input data prepared, we can proceed to creating a new model.

# 3 Creating a new model

The `newSlalomModel` function takes the `SingleCellExperiment` and
`GeneSetCollection` arguments as input and returns an object of class
`Rcpp_SlalomModel`: our new object for fitting the `slalom` model. All of the
computationally intensive model fitting in the package is done in C++, so the
`Rcpp_SlalomModel` object provides an R interface to an underlying `SlalomModel`
class in C++.

Here we create a small model object, specifying that we want to include one
hidden factor (`n_hidden`) and will retain genesets as long as they have at
least one gene present (`min_genes`) in the `SingleCellExperiment` object
(default value is 10, which would be a better choice for analyses of
experimental data).

```
m <- newSlalomModel(sce, genesets[1:23], n_hidden = 1, min_genes = 1)
```

```
## 20 annotated factors retained;  3 annotated factors dropped.
## 500  genes retained for analysis.
```

Twenty annotated factors are retained here, and three annotated factors are
dropped. 500 genes (all present in the `sce` object) are retained for analysis.
For more options in creating the `slalom` model object consult the documentation
(`?newSlalomModel`).

See documentation (`?Rcpp_SlalomModel`) for more details about what the class
contains.

# 4 Initializing the model

Before training (fitting) the model, we first need to establish a sensible
initialisation. Results of variational Bayes methods, in general, can depend on
starting conditions and we have found developed initialisation approaches that
help the `slalom` model converge to good results.

The `initSlalom` function initialises the model appropriately. Generally, all
that is required is the call `initSlalom(m)`, but here the genesets we are using
do not correspond to anything meaningful (this is just dummy simulated data), so
we explicitly provide the “Pi” matrix containing the prior probability for each
gene to be active (“on”) for each factor. We also tell the initialisation function
that we are fitting one hidden factor and set a randomisation seed to make
analyses reproducible.

```
m <- initSlalom(m, pi_prior = sim[["init"]][["Pi"]], n_hidden = 1, seed = 222)
```

See documentation (`?initSlalom`) for more details.

# 5 Training the model

With the model initialised, we can proceed to training (fitting) it. Training
typically requires one to several thousand iterations, so despite being linear
in the nubmer of factors can be computationally expensive for large datasets (
many cells or many factors, or both).

```
mm <- trainSlalom(m, minIterations = 400, nIterations = 5000, shuffle = TRUE,
                  pretrain = TRUE, seed = 222)
```

```
## pre-training model for faster convergence
## iteration 0
## Model not converged after 50 iterations.
## iteration 0
## Model not converged after 50 iterations.
## iteration 0
## Switched off factor 20
## Switched off factor 17
## Switched off factor 10
## Switched off factor 15
## Switched off factor 16
## iteration 100
## iteration 200
## iteration 300
## Switched off factor 11
## iteration 400
## iteration 500
## iteration 600
## iteration 700
## iteration 800
## iteration 900
## iteration 1000
## Switched off factor 5
## iteration 1100
## iteration 1200
## iteration 1300
## iteration 1400
## iteration 1500
## iteration 1600
## iteration 1700
## iteration 1800
## iteration 1900
## iteration 2000
## iteration 2100
## iteration 2200
## iteration 2300
## iteration 2400
## iteration 2500
## iteration 2600
## iteration 2700
## iteration 2800
## iteration 2900
## iteration 3000
## iteration 3100
## iteration 3200
## iteration 3300
## iteration 3400
## iteration 3500
## iteration 3600
## iteration 3700
## iteration 3800
## iteration 3900
## iteration 4000
## iteration 4100
## iteration 4200
## iteration 4300
## iteration 4400
## iteration 4500
## Model converged after 4550 iterations.
```

We apply the `shuffle` (shuffling the update order of factors at each iteration
of the model) and `pretrain` (burn 100 iterations of the model determine the
best intial update order of factors) options as these generally aid the
convergence of the model. See documentation (`?trainSlalom`) for more details
and further options.

Here the model converges in under 2000 iterations. This takes seconds for 21
factors, 20 cells and 500 genes. The model is, broadly speaking, very scalable,
but could still require hours for many thousands of cells and/or hundreds of
factors.

# 6 Interpretation of results

With the model trained we can move on to the interpretation of results.

## 6.1 Top terms

The `topTerms` function provides a convenient means to identify the most
“relevant” (i.e. important) factors identified by the model.

```
topTerms(m)
```

```
##                              term    relevance      type n_prior n_gain n_loss
## 1  APOPTOTIC_CLEAVAGE_OF_CELLULAR 1.1862945226 annotated      46      0      0
## 2  NEF_MEDIATED_DOWNREGULATION_OF 0.9533517719 annotated      27      0      0
## 3         CELL_CELL_COMMUNICATION 0.8834821681 annotated      76      0      0
## 4  NEF_MEDIATES_DOWN_MODULATION_O 0.8194190105 annotated      49      0      0
## 5                      CELL_CYCLE 0.5370374523 annotated     466      0      0
## 6  NEUROTRANSMITTER_RECEPTOR_BIND 0.0008010153 annotated      33      0      0
## 7              CELL_CYCLE_MITOTIC 0.0007054114 annotated      70      0      0
## 8  CELL_SURFACE_INTERACTIONS_AT_T 0.0006495766 annotated     101      0      0
## 9  ACTIVATION_OF_NF_KAPPAB_IN_B_C 0.0005060579 annotated     104      0      0
## 10 INTEGRIN_CELL_SURFACE_INTERACT 0.0004000095 annotated     179      0      0
## 11 ANTIGEN_ACTIVATES_B_CELL_RECEP 0.0003983484 annotated     107      0      0
## 12 DOWNSTREAM_SIGNALING_EVENTS_OF 0.0003473931 annotated     205      0      0
## 13 NOTCH1_INTRACELLULAR_DOMAIN_RE 0.0003460340 annotated     325      0      0
```

We can see the name of the term (factor/pathway), its relevance and type
(annotated or unannotated (i.e. hidden)), the number genes initially in the
gene set (`n_prior`), the number of genes the model thinks should be added as
active genes to the term (`n_gain`) and the number that should be dropped
from the set (`n_loss`).

## 6.2 Plotting results

The `plotRelevance`, `plotTerms` and `plotLoadings` functions enable us to
visualise the `slalom` results.

The `plotRelevance` function displays the most relevant terms (factors/pathways)
ranked by relevance, showing gene set size and the number of genes gained/lost
as active in the pathway as learnt by the model.

```
plotRelevance(m)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the slalom package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the slalom package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## ℹ The deprecated feature was likely used in the slalom package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

The `plotTerms` function shows the relevance of all terms in the model, enabling
the identification of the most important pathways in the context of all that
were included in the model.

```
plotTerms(m)
```

![](data:image/png;base64...)

Once we have identified terms (factors/pathways) of interest we can look
specifically at the loadings (weights) of genes for that term to see which genes
are particularly active or influential in that pathway.

```
plotLoadings(m, "CELL_CYCLE")
```

![](data:image/png;base64...)

See the appropriate documentation for more options for these plotting functions.

# 7 Using results for further analyses

Having obtained `slalom` model results we would like to use them in downstream
analyses. We can add the results to a `SingleCellExperiment` object, which
allows to plug into other tools, particularly the `scater` package which
provides useful further plotting methods and ways to regress out unwanted
hidden factors or biologically uninteresting pathways (like cell cycle, in some
circumstances).

## 7.1 Adding results to a `SingleCellExperiment` object

The `addResultsToSingleCellExperiment` function allows us to conveniently add
factor states (cell-level states) to the `reducedDim` slot of the
`SingleCellExperiment` object and the gene loadings to the `rowData` of the
object.

It typically makes most sense to add the `slalom` results to the
`SingleCellExperiment` object we started with, which is what we do here.

```
sce <- addResultsToSingleCellExperiment(sce, m)
```

## 7.2 More plots and egressing out hidden/unwanted factors

Now that our results are available in the `SingleCelExperiment` object we can
use the `plotReducedDim` function in the `scater` package to plot factors
against each other in the context of gene expression values and other cell
covariates. We could also use the `normaliseExprs` function in `scater` to
regress out unwanted factors to generate expression values removing the effect of
hidden factors (which may represent batch or other technical variation) or
factors like cell cycle.

# 8 Session Info

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
## [1] slalom_1.32.0    knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0
##  [3] gtable_0.3.6                xfun_0.53
##  [5] bslib_0.9.0                 ggplot2_4.0.0
##  [7] Biobase_2.70.0              lattice_0.22-7
##  [9] vctrs_0.6.5                 tools_4.5.1
## [11] generics_0.1.4              stats4_4.5.1
## [13] tibble_3.3.0                AnnotationDbi_1.72.0
## [15] RSQLite_2.4.3               blob_1.2.4
## [17] pkgconfig_2.0.3             Matrix_1.7-4
## [19] RColorBrewer_1.1-3          S7_0.2.0
## [21] S4Vectors_0.48.0            graph_1.88.0
## [23] lifecycle_1.0.4             compiler_4.5.1
## [25] farver_2.1.2                Biostrings_2.78.0
## [27] tinytex_0.57                codetools_0.2-20
## [29] Seqinfo_1.0.0               htmltools_0.5.8.1
## [31] sass_0.4.10                 yaml_2.3.10
## [33] crayon_1.5.3                pillar_1.11.1
## [35] jquerylib_0.1.4             SingleCellExperiment_1.32.0
## [37] DelayedArray_0.36.0         cachem_1.1.0
## [39] magick_2.9.0                abind_1.4-8
## [41] rsvd_1.0.5                  tidyselect_1.2.1
## [43] digest_0.6.37               dplyr_1.1.4
## [45] bookdown_0.45               labeling_0.4.3
## [47] RcppArmadillo_15.0.2-2      fastmap_1.2.0
## [49] grid_4.5.1                  cli_3.6.5
## [51] SparseArray_1.10.0          magrittr_2.0.4
## [53] S4Arrays_1.10.0             dichromat_2.0-0.1
## [55] XML_3.99-0.19               GSEABase_1.72.0
## [57] withr_3.0.2                 scales_1.4.0
## [59] bit64_4.6.0-1               rmarkdown_2.30
## [61] XVector_0.50.0              httr_1.4.7
## [63] matrixStats_1.5.0           bit_4.6.0
## [65] png_0.1-8                   memoise_2.0.1
## [67] evaluate_1.0.5              GenomicRanges_1.62.0
## [69] IRanges_2.44.0              BH_1.87.0-1
## [71] rlang_1.1.6                 Rcpp_1.1.0
## [73] xtable_1.8-4                glue_1.8.0
## [75] DBI_1.2.3                   BiocManager_1.30.26
## [77] BiocGenerics_0.56.0         annotate_1.88.0
## [79] jsonlite_2.0.0              R6_2.6.1
## [81] MatrixGenerics_1.22.0
```