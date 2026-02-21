# A guide to the GEMINI R package

#### Mahdi Zamanighomi and Sidharth Jain

#### 2025-10-30

* [Abstract](#abstract)
  + [Introduction](#introduction)
  + [Model](#model)
  + [Installation](#installation)
  + [Import Big Papi data](#import-big-papi-data)
  + [Input](#input)
  + [Pre-processing](#pre-processing)
  + [Initialization and Inference](#initialization-and-inference)
  + [Convergence](#convergence)
  + [Scoring and Visualization](#scoring-and-visualization)
  + [Summary](#summary)
  + [Session Info](#session-info)

## Abstract

Systems for CRISPR-based combinatorial perturbation of two or more genes are emerging as powerful tools for uncovering genetic interactions. However, systematic identification of these relationships is complicated by sample, reagent, and biological variability. We develop a variational Bayes approach (GEMINI) that jointly analyzes all samples and reagents to identify genetic interactions in pairwise knockout screens. The improved accuracy and scalability of GEMINI enables the systematic analysis of combinatorial CRISPR knockout screens, regardless of design and dimension.

### Introduction

GEMINI follows a basic workflow:

* Create Input (`gemini_create_input`)
* Initialize Model (`gemini_initialize`)
* Perform Coordinate-Ascent Variational Inference (CAVI) (`gemini_inference`)
* Score Interactions (`gemini_score`)

Using counts data derived from a combination CRISPR screen, and annotations for both samples/replicates and guide/gene IDs, GEMINI can identify genetic interactions such as synthetic lethality and recovery.

### Model

GEMINI uses the following model:

\(D\_{gihjl} = N(x\_{gi} \* y\_{gl} + x\_{hj}\*x\_{hl} + x\_{gihj}\*s\_{ghl}, \tau\_{gihjl})\)

* \(D\) is the observation, the log-fold change of a guide pair in a cell line.
* \(x\) is the reagent-level effect, reflecting the consistency of a single guide or guide pair across samples
* \(y\) is the gene-level effect, reflecting the effect of gene knockout in a single sample.
* \(s\) is the combination effect, reflecting the effect of the interaction between a gene pair
* \(\tau\) is the precision of the data
* \(g\) is a gene targeted by guide \(i\)
* \(h\) is a gene targeted by guide \(j\)
* \(l\) is the sample

### Installation

The stable version used in the publication Zamanighomi et al., 2019 can be found on Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("gemini")
```

For the latest development version, you can download from GitHub using the devtools package:

```
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")

devtools::install_github("foo/bar", build_opts = c("--no-resave-data", "--no-manual"), build_vignettes = TRUE)
```

### Import Big Papi data

This is the data published in Najm et al., 2018 (doi: [10.1038/nbt.4048](https://doi.org/10.1038/nbt.4048)). All data was obtained from Supplementary Tables 2 and 3.

```
library("gemini")
data("counts", "guide.annotation", "sample.replicate.annotation", package = "gemini")
```

### Input

GEMINI takes a counts matrix as follows:

```
knitr::kable(head(counts[,1:5]), caption = "Counts matrix", align = 'l')
```

Counts matrix

|  | pDNA | 786O.RepA | 786O.RepB | 786O.RepC | A375.RepA |
| --- | --- | --- | --- | --- | --- |
| AAAGTGGAACTCAGGACATG;AAAAAAAGAGTCGAATGTTTT | 1137 | 2438 | 1997 | 2175 | 1459 |
| AAAGTGGAACTCAGGACATG;AAAGAGTCCACTCTGCACTTG | 1112 | 2176 | 1385 | 1485 | 1484 |
| AAAGTGGAACTCAGGACATG;AACAGCTCCGTGTACTGAGGC | 796 | 2294 | 1579 | 1844 | 1506 |
| AAAGTGGAACTCAGGACATG;AAGACGAAATTGAAGACGAAG | 839 | 2169 | 1229 | 1705 | 1344 |
| AAAGTGGAACTCAGGACATG;AAGCGTACTGCTCATCATCGT | 689 | 1771 | 984 | 1526 | 524 |
| AAAGTGGAACTCAGGACATG;ACATTGCATACATAGAAGATC | 858 | 2833 | 1820 | 1866 | 1642 |

GEMINI also requires sample/replicate annotation and guide/gene annotation:

```
knitr::kable(head(sample.replicate.annotation), caption = "Sample/replicate annotations")
```

Sample/replicate annotations

| colname | samplename | replicate |
| --- | --- | --- |
| pDNA | pDNA | NA |
| 786O.RepA | 786O | RepA |
| 786O.RepB | 786O | RepB |
| 786O.RepC | 786O | RepC |
| A375.RepA | A375 | RepA |
| A375.RepB | A375 | RepB |

```
knitr::kable(head(guide.annotation[,1:3]), caption = "Guide/gene annotation")
```

Guide/gene annotation

| rowname | U6.gene | H1.gene |
| --- | --- | --- |
| AAAGTGGAACTCAGGACATG;AAAAAAAGAGTCGAATGTTTT | HPRT intron | 6T |
| AAAGTGGAACTCAGGACATG;AAAGAGTCCACTCTGCACTTG | HPRT intron | UBC |
| AAAGTGGAACTCAGGACATG;AACAGCTCCGTGTACTGAGGC | HPRT intron | CD81 |
| AAAGTGGAACTCAGGACATG;AAGACGAAATTGAAGACGAAG | HPRT intron | CD81 |
| AAAGTGGAACTCAGGACATG;AAGCGTACTGCTCATCATCGT | HPRT intron | HSP90AA1 |
| AAAGTGGAACTCAGGACATG;ACATTGCATACATAGAAGATC | HPRT intron | CHEK2 |

These can be used to create a `gemini.input` object using the `gemini_create_input` function.

```
Input <- gemini_create_input(counts.matrix = counts,
                    sample.replicate.annotation = sample.replicate.annotation,
                    guide.annotation = guide.annotation,
                    ETP.column = 'pDNA',
                    gene.column.names = c("U6.gene", "H1.gene"),
                    sample.column.name = "samplename",
                    verbose = TRUE)
```

```
## Merging sample annotations with colnames of counts.matrix...
```

```
## Merging guide annotations with rownames()...
```

```
## Created gemini input object.
```

```
# Note: ETP column can also be specified by column index
# (e.g. ETP.column = c(1))
```

### Pre-processing

GEMINI requires log-fold changes as an input, which are calculated using the `gemini_calculate_lfc` function. A pseudo-count (`CONSTANT`) of \(32\) is used by default.

```
Input %<>% gemini_calculate_lfc(normalize = TRUE,
                                CONSTANT = 32)
```

### Initialization and Inference

To initialize the CAVI approach, a `gemini.model` object is created using the `gemini_initialize` function. For large libraries, more cores can be specified to speed up the initialization (see ?gemini\_parallelization).

To note, it is **highly recommended** that at least one negative control gene should be specified here, and all other genes should be paired with at least one negative control. We use CD81 in this example.

In the absence of a negative control gene, the median LFC of all guide pairs targeting each gene is used to initialize the CAVI approach. However, this is only reasonable in all-by-all format screens.

Also to note, the `pattern_split` argument must describe a separator used in the rownames of the counts.matrix. For example, a semi-colon (“;”) is used in the Big Papi data and therefore specified here. On the other hand, `pattern_join` is specified by the user to join the gene pairs. For example, if the `U6.gene` is BRCA2, and the `H1.gene` is PARP1, the output will be “BRCA2{pattern\_join}PARP1”.

```
Model <- gemini_initialize(Input = Input,
                  nc_gene = "CD81",
                  pattern_join = ';',
                  pattern_split = ';',
                  cores = 1,
                  verbose = TRUE)
```

```
## Initializing x
```

```
## Initializing y
```

```
## Initializing s
```

```
## Initializing tau
```

```
## Updating mae
```

```
## Model initialized.
```

Inference is performed with the `gemini_inference` function. For large libraries, more cores can be specified to speed up the inference (see ?gemini\_parallelization).

```
Model %<>% gemini_inference(cores = 1,
                            verbose = FALSE)
```

### Convergence

After running `gemini_inference`, the resulting convergence rate can be visualized. If the model is divergent, alternative parameters for the priors should be selected until convergence is achieved. This can be done through cross-validation. Details on this will be added soon.

```
gemini_plot_mae(Model)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the gemini package.
##   Please report the issue at <https://github.com/sellerslab/gemini/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

### Scoring and Visualization

To score genetic interactions, use the `gemini_score` function.

To note, at least one positive control gene (`pc_gene`) should be specified to remove interactions involving individually lethal genes. If no positive control is explicitly specified, lethality is estimated as described in Zamanighomi *et al*. In short, the most lethal 1st percentile of individual gene effects is treated as the positive control value.

Additionally, non-interacting gene pairs (`nc_pairs`) should be specified for the calculation of p-values and false discovery rates (FDRs). If not specified, only scores are calculated, which reflects the relative strengths of interactions in each sample.

```
# Use non-interacting gene pairs as nc_pairs.
# A caveat here is that this set is constructed only using negative controls!
# This probably leads to biased sampling of the null distribution,
# thereby overestimating the number of significant hits, but still is useful in this case.
nc_pairs <- grep("6T|HPRT", rownames(Model$s), value = TRUE)

# An example of some nc_pairs...
head(nc_pairs, n = 5)
```

```
## [1] "6T;HPRT intron"       "HPRT intron;UBC"      "HPRT intron;HSP90AA1"
## [4] "CHEK2;HPRT intron"    "AKT1;HPRT intron"
```

```
Score <- gemini_score(Model = Model,
             pc_gene = "EEF2",
             nc_pairs = nc_pairs)
```

GEMINI’s scores for interactions can be seen in the Score object. Here, we show the top 10 interacting gene pairs in A549, with their scores across all cell lines.

```
knitr::kable(Score$strong[order(Score$strong[,"A549"], decreasing = TRUE)[1:10],], caption = "Strong scores for top 10 interactions from A549 in all samples")
```

Strong scores for top 10 interactions from A549 in all samples

|  | 786O | A375 | A549 | HT29 | Meljuso | OVCAR8 |
| --- | --- | --- | --- | --- | --- | --- |
| PARP1;WEE1 | 0.0453403 | 1.2379052 | 1.457047 | 0.3425539 | 0.4460586 | 0.2163869 |
| MAPK1;MAPK3 | -0.0161569 | 0.7844598 | 1.382672 | 1.2829978 | 0.9680055 | 0.7177184 |
| MAP2K1;PARP1 | 0.3458751 | 0.9409076 | 1.322750 | -0.2186067 | 0.1133638 | 0.0676618 |
| BRCA2;PARP1 | 0.3805435 | 1.0314724 | 1.320199 | 0.2962005 | 0.5850402 | 0.5321259 |
| AKT2;WEE1 | -0.1786742 | 0.4083603 | 1.272535 | 0.5039544 | 0.3303675 | -0.1330083 |
| BRCA1;BRCA2 | 0.0733881 | 0.8185404 | 1.250131 | 0.6374952 | 0.9092236 | 0.4984216 |
| BRCA2;WEE1 | -0.1443077 | 1.0850858 | 1.233050 | 0.6096170 | 0.8376799 | 0.0318263 |
| BCL2L1;MCL1 | -1.4310350 | 1.1813920 | 1.156947 | -0.2542358 | 0.5450757 | 0.5775085 |
| AKT2;BRCA2 | -0.1435939 | 0.1336293 | 1.141525 | 0.1821932 | 0.3429816 | -0.1009591 |
| AKT2;PARP1 | 0.2634264 | 0.6327186 | 1.123986 | 0.2891668 | 0.2070908 | 0.0936534 |

Significant interactions can be identified through the FDR and p-value slots in the `Score` object. Again, we show the top 10 interacting gene pairs in A549, but now present FDRs across all cell lines.

```
knitr::kable(Score$fdr_strong[order(Score$fdr_strong[,"A549"], decreasing = FALSE)[1:10],], caption = "FDRs for top 10 interactions in A549")
```

FDRs for top 10 interactions in A549

|  | 786O | A375 | A549 | HT29 | Meljuso | OVCAR8 |
| --- | --- | --- | --- | --- | --- | --- |
| BRCA2;PARP1 | 0.3318827 | 0.0000590 | 8.10e-06 | 0.5034640 | 0.0132811 | 0.0310663 |
| PARP1;WEE1 | 0.9995686 | 0.0000360 | 8.10e-06 | 0.3592092 | 0.0719586 | 0.4733378 |
| MAP2K1;PARP1 | 0.4056094 | 0.0000746 | 8.10e-06 | 0.9959788 | 0.5728980 | 0.7975755 |
| MAPK1;MAPK3 | 0.9995686 | 0.0002654 | 8.10e-06 | 0.0000156 | 0.0002616 | 0.0051505 |
| AKT2;WEE1 | 0.9995686 | 0.0699194 | 1.03e-05 | 0.0649227 | 0.2031566 | 0.9547407 |
| BRCA1;BRCA2 | 0.9995146 | 0.0001786 | 1.07e-05 | 0.0115084 | 0.0002616 | 0.0482600 |
| BRCA2;WEE1 | 0.9995686 | 0.0000587 | 1.08e-05 | 0.0165822 | 0.0002846 | 0.8451784 |
| BCL2L1;MCL1 | 0.9995686 | 0.0000382 | 1.92e-05 | 0.9959788 | 0.0246745 | 0.0174912 |
| AKT2;BRCA2 | 0.9995686 | 0.4545398 | 1.96e-05 | 0.8869871 | 0.1809226 | 0.9546188 |
| AKT2;PARP1 | 0.6929921 | 0.0028113 | 2.07e-05 | 0.5223458 | 0.3815660 | 0.7572944 |

To visualize these interactions, we can use the `gemini_boxplot` function. For example, in BRCA2-PARP1:

```
gemini_boxplot(Model = Model,
               g = "BRCA2",
               h = "PARP1",
               nc_gene = "CD81",
               sample = "A549",
               show_inference = TRUE,
               identify_guides = TRUE
               )
```

![](data:image/png;base64...)

We can see that GEMINI makes adjustments to the individual gene effects of both BRCA2 and PARP1, and adjusts the sample-independent values of each to account for variation in the screen.

This boxplot can also be re-colored by the adjustment made to each guide or guide pair through the sample-independent effects. Guides/guide pairs with the least adjustment to x (grey) are considered to have the least variation within the screen.

```
gemini_boxplot(Model = Model,
               g = "BRCA2",
               h = "PARP1",
               nc_gene = "CD81",
               sample = "A549",
               show_inference = TRUE,
               color_x = TRUE
               )
```

```
## Warning: The following aesthetics were dropped during statistical transformation:
## colour.
## ℹ This can happen when ggplot fails to infer the correct grouping structure in
##   the data.
## ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
##   variable into a factor?
```

![](data:image/png;base64...)

### Summary

GEMINI can be run on any counts matrix from a pairwise screen. GEMINI computes log fold changes and infers sample-dependent and sample-independent effects using CAVI. Then, GEMINI calculates interaction strength and significance.

The manuscript and more visualization tools will be made available soon.

### Session Info

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
## [1] gemini_1.24.0
##
## loaded via a namespace (and not attached):
##  [1] plotly_4.11.0      sass_0.4.10        generics_0.1.4     tidyr_1.3.1
##  [5] lattice_0.22-7     digest_0.6.37      magrittr_2.0.4     evaluate_1.0.5
##  [9] grid_4.5.1         RColorBrewer_1.1-3 fastmap_1.2.0      jsonlite_2.0.0
## [13] Matrix_1.7-4       survival_3.8-3     httr_1.4.7         purrr_1.1.0
## [17] kernlab_0.9-33     viridisLite_0.4.2  scales_1.4.0       lazyeval_0.2.2
## [21] jquerylib_0.1.4    cli_3.6.5          crayon_1.5.3       rlang_1.1.6
## [25] pbmcapply_1.5.1    splines_4.5.1      withr_3.0.2        cachem_1.1.0
## [29] yaml_2.3.10        tools_4.5.1        parallel_4.5.1     dplyr_1.1.4
## [33] ggplot2_4.0.0      vctrs_0.6.5        R6_2.6.1           lifecycle_1.0.4
## [37] htmlwidgets_1.6.4  segmented_2.1-4    MASS_7.3-65        pkgconfig_2.0.3
## [41] pillar_1.11.1      bslib_0.9.0        gtable_0.3.6       data.table_1.17.8
## [45] glue_1.8.0         xfun_0.53          tibble_3.3.0       tidyselect_1.2.1
## [49] mixtools_2.0.0.1   knitr_1.50         dichromat_2.0-0.1  farver_2.1.2
## [53] htmltools_0.5.8.1  nlme_3.1-168       rmarkdown_2.30     labeling_0.4.3
## [57] compiler_4.5.1     S7_0.2.0
```