# Including inter-species measurements in differential expression analysis of RNAseq data with the compcodeR package

Paul Bastide & Mélina Gallopin

#### 2025-10-29

#### Package

compcodeR 1.46.0

# Contents

* [1 Introduction](#introduction)
* [2 The `phyloCompData` class](#the-phylocompdata-class)
* [3 A sample workflow](#a-sample-workflow)
  + [3.1 Phylogenetic Tree](#phylogenetic-tree)
  + [3.2 Condition Design](#condition-design)
  + [3.3 Simulating data](#simulating-data)
  + [3.4 Performing differential expression analysis](#performing-differential-expression-analysis)
  + [3.5 Comparing results from several differential expression methods](#comparing-results-from-several-differential-expression-methods)
* [4 Using your own data](#using-your-own-data)
* [5 Providing your own differential expression code](#providing-your-own-differential-expression-code)
* [6 The extended data object](#the-extended-data-object)
* [7 The evaluation metrics](#the-evaluation-metrics)
* [8 Session info](#session-info)
* [References](#references)

```
library(compcodeR)
```

# 1 Introduction

The *[compcodeR](https://bioconductor.org/packages/3.22/compcodeR)* R package
can generate RNAseq counts data and compare the relative performances of
various popular differential analysis detection tools (Soneson and Delorenzi ([2013](#ref-Soneson2013))).

Using the same framework, this document shows how
to generate “orthologous gene” (OG) expression
for different species, taking into account their varying lengths, and
their phylogenetic relationships, as encoded by an evolutionary tree.

This vignette provides a tutorial on how to use the “phylogenetic” functionalities of *[compcodeR](https://bioconductor.org/packages/3.22/compcodeR)*.
It assumes that the reader is already familiar with the [`compcodeR` package vignette](compcodeR.html).

# 2 The `phyloCompData` class

The `phyloCompData` class extends the `compData` class
of the *[compcodeR](https://bioconductor.org/packages/3.22/compcodeR)* package
to account for phylogeny and length information needed in the representation of
OG expression data.

A `phyloCompData` object contains all the slots of a
[`compData` object](compcodeR.html#the-compdata-class),
with an added slot containing a phylogenetic tree
with [`ape`](https://CRAN.R-project.org/package%3Dape) format `phylo`,
and a length matrix.
It can also contain some added variable information, such as species names.
More detailed information about the `phyloCompData` class are available in the
section on [the phylo data object](#the-extended-data-object).
After conducting a differential expression analysis, the `phyloCompData` object
has the same added information than the `compData` object
(see [the result object](compcodeR.html#the-result-object)
in the *[compcodeR](https://bioconductor.org/packages/3.22/compcodeR)* package vignette).

# 3 A sample workflow

The workflow for working with the inter-species extension is very similar to the
[already existing workflow](compcodeR.html#a-sample-workflow)
of the *[compcodeR](https://bioconductor.org/packages/3.22/compcodeR)* package.
In this section, we recall this workflow, stressing out the added functionalities.

## 3.1 Phylogenetic Tree

The simulations are performed following the description by Bastide et al. ([2022](#ref-Bastide2022)).

We use here the phylogenetic tree issued from Stern et al. ([2017](#ref-Stern2017)), normalized to unit height,
that has \(14\) species with up to 3 replicates, for a total number of sample equal to
\(34\) (see Figure below).

```
library(ape)
tree <- system.file("extdata", "Stern2018.tree", package = "compcodeR")
tree <- read.tree(tree)
```

Note that any other tree could be used, for instance randomly generated
using a birth-death process, see e.g. function `rphylo` in the
[`ape`](https://CRAN.R-project.org/package%3Dape) package.

## 3.2 Condition Design

To conduct a differential analysis, each species must be attributed a condition.
Because of the phylogenetic structure, the condition design does matter, and
have a strong influence on the data produced.
Here, we assume that the conditions are
mapped on the tree in a balanced way (“alt” design), which is the “best case scenario”.

```
# link each sample to a species
id_species <- factor(sub("_.*", "", tree$tip.label))
names(id_species) <- tree$tip.label
# Assign a condition to each species
species_names <- unique(id_species)
species_names[c(length(species_names)-1, length(species_names))] <- species_names[c(length(species_names), length(species_names)-1)]
cond_species <- rep(c(1, 2), length(species_names) / 2)
names(cond_species) <- species_names
# map them on the tree
id_cond <- id_species
id_cond <- cond_species[as.vector(id_cond)]
id_cond <- as.factor(id_cond)
names(id_cond) <- tree$tip.label
```

We can plot the assigned conditions on the tree to visualize them.

```
plot(tree, label.offset = 0.01)
tiplabels(pch = 19, col = c("#D55E00", "#009E73")[id_cond])
```

![Phylogenetic tree with $14$ species and $34$ samples, with two conditions](data:image/png;base64...)

Figure 1: Phylogenetic tree with \(14\) species and \(34\) samples, with two conditions

## 3.3 Simulating data

Using this tree with associated condition design, we can then generate a dataset
using a “phylogenetic Poisson Log Normal” (pPLN) distribution.
We use here a Brownian Motion (BM) model of evolution for the latent phylogenetic
log normal continuous trait, and assume that the phylogenetic model accounts for
\(90\%\) of the latent trait variance
(i.e. there is an added uniform intra-species variance representing \(10\%\) of the
total latent trait variation).
Using the `"auto"` setup, the counts are simulated so that they match empirical
moments found in Stern and Crandall ([2018](#ref-Stern2018)).
OG lengths are also drawn from a pPLN model, so that their moments match those
of the empirical dataset of Stern and Crandall ([2018](#ref-Stern2018)).
We choose to simulate \(2000\) OGs, \(10\%\) of which are differentially expressed, with an effect size of \(3\).

The following code creates a `phyloCompData` object containing the simulated
data set and saves it to a file named `"alt_BM_repl1.rds"`.

```
set.seed(12890926)
alt_BM <- generateSyntheticData(dataset = "alt_BM",
                                n.vars = 2000, samples.per.cond = 17,
                                n.diffexp = 200, repl.id = 1,
                                seqdepth = 1e7, effect.size = 3,
                                fraction.upregulated = 0.5,
                                output.file = "alt_BM_repl1.rds",
                                ## Phylogenetic parameters
                                tree = tree,                      ## Phylogenetic tree
                                id.species = id_species,          ## Species structure of samples
                                id.condition = id_cond,           ## Condition design
                                model.process = "BM",             ## The latent trait follows a BM
                                prop.var.tree = 0.9,              ## Tree accounts for 90% of the variance
                                lengths.relmeans = "auto",        ## OG length mean and dispersion
                                lengths.dispersions = "auto")     ## are taken from an empirical exemple
```

The `summarizeSyntheticDataSet` works the same way as in the base
[`compcodeR` package](compcodeR.html), generating a report that summarize
all the parameters used in the simulation, and showing some diagnostic plots.

```
summarizeSyntheticDataSet(data.set = "alt_BM_repl1.rds",
                          output.filename = "alt_BM_repl1_datacheck.html")
```

When applied to a `phyloCompData` object,
it provides some extra diagnostics, related to the phylogenetic nature of the data.
In particular, it contains MA-plots with TPM-normalized expression levels to
take OG length into account, which generally makes the original signal
clearer.

![Example figures from the summarization report generated for a simulated data set. The top panel shows an MA plot, with the genes colored by the true differential expression status. The bottom panel shows the same plot, but using TPM-normalized estimated expression levels.](data:image/png;base64...)![Example figures from the summarization report generated for a simulated data set. The top panel shows an MA plot, with the genes colored by the true differential expression status. The bottom panel shows the same plot, but using TPM-normalized estimated expression levels.](data:image/png;base64...)

Figure 2: Example figures from the summarization report generated for a simulated data set
The top panel shows an MA plot, with the genes colored by the true differential expression status. The bottom panel shows the same plot, but using TPM-normalized estimated expression levels.

It also shows a log2 normalized counts heatmap plotted along the phylogeny,
illustrating the phylogenetic structure of the differentially expressed OGs.

![Example figures from the summarization report generated for a simulated data set. The tips colored by true differential expression status. Only the first 400 genes are represented. The first block of 200 genes are differencially expressed between condition 1 and 2. The second block of 200 genes are not differencially expressed.](data:image/png;base64...)

Figure 3: Example figures from the summarization report generated for a simulated data set
The tips colored by true differential expression status. Only the first 400 genes are represented. The first block of 200 genes are differencially expressed between condition 1 and 2. The second block of 200 genes are not differencially expressed.

## 3.4 Performing differential expression analysis

Differential expression analysis can be conducted using the same framework
used in the [`compcodeR` package](compcodeR.html#performing-differential-expression-analysis),
through the `runDiffExp` function.

All the standard methods can be used. To account for the phylogenetic nature
of the data and for the varying length of the OGs, some methods have been added
to the pool.

The code below applies three differential expression methods to the data set generated above:
the *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* method adapted for varying lengths,
the `log2(TPM)` transformation for length normalization,
combined with *[limma](https://bioconductor.org/packages/3.22/limma)*, using the `trend` empirical Bayes correction,
and accounting for species-related correlations, and
the phylogenetic regression tool
[`phylolm`](https://CRAN.R-project.org/package%3Dphylolm) applied on the same `log2(TPM)`.

```
runDiffExp(data.file = "alt_BM_repl1.rds",
           result.extent = "DESeq2", Rmdfunction = "DESeq2.createRmd",
           output.directory = ".",
           fit.type = "parametric", test = "Wald")
runDiffExp(data.file = "alt_BM_repl1.rds",
           result.extent = "lengthNorm.limma", Rmdfunction = "lengthNorm.limma.createRmd",
           output.directory = ".",
           norm.method = "TMM",
           length.normalization = "TPM",
           data.transformation = "log2",
           trend = FALSE, block.factor = "id.species")
runDiffExp(data.file = "alt_BM_repl1.rds",
           result.extent = "phylolm", Rmdfunction = "phylolm.createRmd",
           output.directory = ".",
           norm.method = "TMM",
           model = "BM", measurement_error = TRUE,
           extra.design.covariates = NULL,
           length.normalization = "TPM",
           data.transformation = "log2")
```

As for a regular *[compcodeR](https://bioconductor.org/packages/3.22/compcodeR)* analysis,
example calls are provided in the reference manual (see the help pages for the `runDiffExp` function),
and a list of all available methods can be obtained with the `listcreateRmd()` function.

```
listcreateRmd()
#>  [1] "DESeq2.createRmd"
#>  [2] "DESeq2.length.createRmd"
#>  [3] "DSS.createRmd"
#>  [4] "EBSeq.createRmd"
#>  [5] "NBPSeq.createRmd"
#>  [6] "NOISeq.prenorm.createRmd"
#>  [7] "TCC.createRmd"
#>  [8] "edgeR.GLM.createRmd"
#>  [9] "edgeR.exact.createRmd"
#> [10] "lengthNorm.limma.createRmd"
#> [11] "lengthNorm.sva.limma.createRmd"
#> [12] "logcpm.limma.createRmd"
#> [13] "phylolm.createRmd"
#> [14] "sqrtcpm.limma.createRmd"
#> [15] "ttest.createRmd"
#> [16] "voom.limma.createRmd"
#> [17] "voom.ttest.createRmd"
```

## 3.5 Comparing results from several differential expression methods

Given that the `phyloCompData` object has the same structure with respect to the
slots added by the differential expression analysis
(see [the result object](compcodeR.html#the-result-object),
the procedure to compare results from several differential expression methods
is exactly the same as for a `compData` object, and can be found in the
[corresponding section](compcodeR.html#comparing-results-from-several-differential-expression-methods)
section of the *[compcodeR](https://bioconductor.org/packages/3.22/compcodeR)* vignette.

# 4 Using your own data

[As for a `compData` object](compcodeR.html#using-your-own-data),
it is still possible to input user-defined data to produce a `phyloCompData`
object for differential expression methods comparisons.
One only needs to provide the additional information needed, that is
the phylogenetic tree, and the length matrix.
The constructor method will make sure that the tree is consistent with the count
and length matrices, with the same dimensions and consistent species names.

```
## Phylogentic tree with replicates
tree <- read.tree(text = "(((A1:0,A2:0,A3:0):1,B1:1):1,((C1:0,C2:0):1.5,(D1:0,D2:0):1.5):0.5);")
## Sample annotations
sample.annotations <- data.frame(
  condition = c(1, 1, 1, 1, 2, 2, 2, 2),                 # Condition of each sample
  id.species = c("A", "A", "A", "B", "C", "C", "D", "D") # Species of each sample
  )
## Count Matrix
count.matrix <- round(matrix(1000*runif(8000), 1000))
## Length Matrix
length.matrix <- round(matrix(1000*runif(8000), 1000))
## Names must match
colnames(count.matrix) <- colnames(length.matrix) <- rownames(sample.annotations) <- tree$tip.label
## Extra infos
info.parameters <- list(dataset = "mydata", uID = "123456")
## Creation of the object
cpd <- phyloCompData(count.matrix = count.matrix,
                     sample.annotations = sample.annotations,
                     info.parameters = info.parameters,
                     tree = tree,
                     length.matrix = length.matrix)
## Check
check_phyloCompData(cpd)
#> [1] TRUE
```

# 5 Providing your own differential expression code

To use your own differential expression code,
you can follow the
[base `compcodeR` instructions](compcodeR.html#providing-your-own-differential-expression-code)
in the *[compcodeR](https://bioconductor.org/packages/3.22/compcodeR)* vignette.

# 6 The extended data object

The `phylocompData` data object is an S4 object that extends
[the `compData` object](compcodeR.html#the-data-object),
with the following added slots:

* `tree` [`class phylo`] (**mandatory**) – the phylogenetic tree describing the relationships between samples.
* `length.matrix` [`class matrix`] (**mandatory**) – the OG length matrix, with rows representing genes and columns representing samples.
* When produced with `generateSyntheticData`, the `sample.annotations` data frame has added column:

  + `id.species` [`class character` or `numeric`] – the species for each sample.
    Should match with the `tip.label` of the `tree` slot.
* When produced with `generateSyntheticData`, the `variable.annotations` data frame has an added columns:

  + `lengths.relmeans` [`class numeric`] – the true mean values used in the simulations of the OG lengths.
  + `lengths.dispersions` [`class numeric`] – the true dispersion values used in the simulations of the OG lengths.
  + `M.value.TPM` [`class numeric`] – the estimated log2-fold change between conditions 1 and 2 for each OG using TPM length normalization.
  + `A.value.TPM` [`class numeric`] – the estimated average expression in conditions 1 and 2 for each OG using TPM length normalization.
  + `prop.var.tree` [`class numeric`] – the proportion of the variance explained by the phylogeny for each gene.

The same way as the `compData` object, the `phyloCompData` object needs to be saved to a file with extension `.rds`.

# 7 The evaluation metrics

The evaluation metrics are unchanged, and described in the
[corresponding section](compcodeR.html#the-evaluation-metrics)
section of the *[compcodeR](https://bioconductor.org/packages/3.22/compcodeR)* vignette.

# 8 Session info

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
#>  [1] LC_CTYPE=en_US.UTF-8
#>  [2] LC_NUMERIC=C
#>  [3] LC_TIME=en_GB
#>  [4] LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8
#>  [6] LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8
#>  [8] LC_NAME=C
#>  [9] LC_ADDRESS=C
#> [10] LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8
#> [12] LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets
#> [6] methods   base
#>
#> other attached packages:
#> [1] ape_5.8-1        compcodeR_1.46.0 sm_2.2-6.0
#> [4] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6         xfun_0.53
#>  [3] bslib_0.9.0          ggplot2_4.0.0
#>  [5] caTools_1.18.3       lattice_0.22-7
#>  [7] vctrs_0.6.5          tools_4.5.1
#>  [9] bitops_1.0-9         generics_0.1.4
#> [11] parallel_4.5.1       tibble_3.3.0
#> [13] cluster_2.1.8.1      pkgconfig_2.0.3
#> [15] KernSmooth_2.23-26   RColorBrewer_1.1-3
#> [17] S7_0.2.0             lifecycle_1.0.4
#> [19] compiler_4.5.1       farver_2.1.2
#> [21] stringr_1.5.2        gplots_3.2.0
#> [23] tinytex_0.57         statmod_1.5.1
#> [25] clue_0.3-66          httpuv_1.6.16
#> [27] htmltools_0.5.8.1    sass_0.4.10
#> [29] rmutil_1.1.10        yaml_2.3.10
#> [31] later_1.4.4          pillar_1.11.1
#> [33] jquerylib_0.1.4      MASS_7.3-65
#> [35] cachem_1.1.0         limma_3.66.0
#> [37] magick_2.9.0         rpart_4.1.24
#> [39] vioplot_0.5.1        nlme_3.1-168
#> [41] mime_0.13            fBasics_4041.97
#> [43] gtools_3.9.5         tidyselect_1.2.1
#> [45] locfit_1.5-9.12      digest_0.6.37
#> [47] stringi_1.8.7        dplyr_1.1.4
#> [49] bookdown_0.45        fastmap_1.2.0
#> [51] grid_4.5.1           cli_3.6.5
#> [53] magrittr_2.0.4       dichromat_2.0-0.1
#> [55] stable_1.1.6         edgeR_4.8.0
#> [57] ROCR_1.0-11          promises_1.4.0
#> [59] scales_1.4.0         rmarkdown_2.30
#> [61] otel_0.2.0           timeDate_4051.111
#> [63] zoo_1.8-14           timeSeries_4041.111
#> [65] statip_0.2.3         shiny_1.11.1
#> [67] evaluate_1.0.5       knitr_1.50
#> [69] stabledist_0.7-2     modeest_2.4.0
#> [71] markdown_2.0         rlang_1.1.6
#> [73] Rcpp_1.1.0           spatial_7.3-18
#> [75] xtable_1.8-4         glue_1.8.0
#> [77] BiocManager_1.30.26  shinydashboard_0.7.3
#> [79] jsonlite_2.0.0       R6_2.6.1
```

# References

Bastide, Paul, Charlotte Soneson, Olivier Lespinet, and Mélina Gallopin. 2022. “Benchmark of Differential Gene Expression Analysis Methods for Inter-Species Rna-Seq Data Using a Phylogenetic Simulation Framework.” *bioRxiv Preprint*. <https://doi.org/10.1101/2022.01.21.476612>.

Soneson, Charlotte, and Mauro Delorenzi. 2013. “A Comparison of Methods for Differential Expression Analysis of RNA-seq Data.” *BMC Bioinformatics* 14: 91.

Stern, David B., Jesse Breinholt, Carlos Pedraza-Lara, Marilú López-Mejía, Christopher L. Owen, Heather Bracken-Grissom, James W. Fetzner, and Keith A. Crandall. 2017. “Phylogenetic Evidence from Freshwater Crayfishes That Cave Adaptation Is Not an Evolutionary Dead-End.” *Evolution* 71 (10): 2522–32. <https://doi.org/10.1111/evo.13326>.

Stern, David B., and Keith A. Crandall. 2018. “The Evolution of Gene Expression Underlying Vision Loss in Cave Animals.” *Molecular Biology and Evolution* 35 (8): 2005–14. <https://doi.org/10.1093/molbev/msy106>.