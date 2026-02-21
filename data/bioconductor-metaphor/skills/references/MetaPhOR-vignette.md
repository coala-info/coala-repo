# MetaPhOR

Emily Isenhart

#### 30 October 2025

## 0.1 Introduction

MetaPhOR was developed to enable users to assess metabolic dysregulation using
transcriptomic-level data (RNA-sequencing and Microarray data) and produce
publication-quality figures. A list of differentially expressed genes (DEGs),
which includes fold change and p value, from DESeq2 (Love, Huber, and Anders ([2014](#ref-DESeq2))) or limma (Ritchie et al. ([2015](#ref-limma))),
can be used as input, with sample size for MetaPhOR, and will produce a data
frame of scores for each KEGG pathway. These scores represent the magnitude and
direction of transcriptional change within the pathway, along with estimated
p-values (Rosario et al. ([2018](#ref-MP))). MetaPhOR then uses these scores to visualize
metabolic profiles within and between samples through a variety of mechanisms,
including: bubble plots, heatmaps, and pathway models.

## 0.2 Installation

This command line can be used to install and load MetaPhOR.

if (!require(“BiocManager”, quietly = TRUE))
install.packages(“BiocManager”)
BiocManager::install(“MetaPhOR”)

```
library(MetaPhOR)
```

## 0.3 Data Preparation

Minimal data preparation is required to run MetaPhOR. DEGs may be loaded into R
in the form of .csv or .tsv for use with this package. The DEG file must contain
columns for log fold change, adjusted p-value, and HUGO gene names. By default,
MetaPhOR assumes DESeq2 header stylings: “log2FoldChange” and “padj”. In any
function that assumes these headers, however, the user can define column names
for these values. Below is a sample DEG file resulting from limma:

```
exdegs <- read.csv(system.file("extdata/exampledegs.csv",
                                package = "MetaPhOR"),
                                header = TRUE)
```

| X | logFC | AveExpr | t | P.Value | adj.P.Val | B |
| --- | --- | --- | --- | --- | --- | --- |
| TATDN1 | 0.0996779 | 6.112478 | 6.074387 | 0e+00 | 0.0000523 | 10.736686 |
| ZNF706 | 0.1055866 | 6.446976 | 5.845307 | 0e+00 | 0.0000958 | 9.237467 |
| DCAF13 | 0.0882855 | 6.393943 | 5.513711 | 1e-07 | 0.0002918 | 7.531541 |
| TRMT12 | 0.1093866 | 6.071099 | 5.434470 | 1e-07 | 0.0003550 | 7.377948 |
| IGF2BP1 | 0.9256589 | 4.454204 | 5.631783 | 0e+00 | 0.0002065 | 7.273836 |
| MAP6D1 | 0.1619178 | 5.719428 | 5.342911 | 1e-07 | 0.0004612 | 7.090578 |

## 0.4 Pathway Analysis

“pathwayAnalysis” first assigns scores and their absolute values using log fold
change and p value to each gene (Rosario et al. ([2018](#ref-MP))). These transcript-level
scores, along with sample size, are then utilized to calculate both scores
(directional change) and absolute value scores (magnitude of change)
(Rosario et al. ([2018](#ref-MP))) for each KEGG Pathway (Kanehisa and Goto ([2000](#ref-KEGG))). We then utilize a
bootstrapping method, to randomly calculate 100,000 scores per pathway, based
on the number of genes in that pathway and model the distribution. This
distribution can then be used to evaluate where the actual score for that
pathway sits in relation to the distribution, and can assign a p-value to the
achieved score.

For example, if the polyamine biosynthetic pathway contains 13 genes, we can get
a score for the sum of the 13 genes that exist within that pathway. Using
bootstrapping, we can then randomly sample, with replacement, 13 genes to create
scores, 100,000 times. We use these random samples (100,000) to generate a
distribution, and we can calculate a p-value dependent on where the score that
consists of the 13 genes that actually exist within the pathway falls within the
distribution.

Taken together, the scores and p-values resulting from “pathwayAnalysis” provide
a measure for both the biological and statistical significance of metabolic
dysregulation.

**Note: A seed MUST be set before utilizing this function to ensure reproducible
results by bootstrapping. It is NECESSARY that the seed remain the same
throughout an analysis.**

**Note: Bootrapping is performed, by default, with 100,000 iterations of
resampling for optimal power. The number of iterations can be decreased for
improved speed. We use 50,000 iterations for improved speed of examples.**\*

pathwayAnalysis() requires:

* The file path to the DEG list of interest
* The name of the column containing HUGO gene names
* The sample size of the DEG analysis
* The number of iterations of resampling to be performed during bootstrapping
* Correct headers for fold change and p value columns (as indicated above)

A partial output of the pathway analysis function can be seen as follows:

```
set.seed(1234)

brca <- pathwayAnalysis(DEGpath = system.file("extdata/BRCA_DEGS.csv",
                        package = "MetaPhOR"),
                        genename = "X",
                        sampsize = 1095,
                        iters = 50000,
                        headers = c("logFC", "adj.P.Val"))
```

|  | Scores | ABSScores | ScorePvals | ABSScorePvals |
| --- | --- | --- | --- | --- |
| Cardiolipin.Metabolism | 0.0293332 | 0.0299031 | 0.22996 | 0.60408 |
| Cardiolipin.Biosynthesis | 0.0031671 | 0.0031671 | 0.43074 | 0.91878 |
| Cholesterol.Biosynthesis | 0.2400430 | 0.2614076 | 0.06334 | 0.35952 |
| Citric.Acid.Cycle | 0.0314352 | 0.1469312 | 0.48340 | 0.92848 |
| Cyclooxygenase.Arachidonic.Acid.Metabolism | 0.0004634 | 0.0080444 | 0.52228 | 0.92286 |
| Prostaglandin.Biosynthesis | -0.0392858 | 0.1046875 | 0.79502 | 0.35816 |

## 0.5 bubblePlot

The metabolic profile determined by pathway analysis can be easily visualized
using “bubblePlot.” Scores are plotted on the x-axis, while absolute value
scores are plotted on the y-axis. Each point represents a KEGG pathway, where
point size represents p-value (the smaller the p value, the larger the point)
and point color is dictated by scores. Negative scores, which indicate
transcriptional downregulation, are blue, and positive scores, which indicate
transcriptional upregulation, are red. The top ten points, either by smallest
p value or greatest dysregulation by score, are labeled with their pathway
names. The plot demonstrates which pathways are the most statistically and
biologically relevant.

bubblePlot() requires:

* The output of pathwayAnalysis(), as a data frame
* An indication which values to use, in order to label points: either “Pval” or
  “LogFC”
* Optional: Numeric value for point label text size (default = .25)

**Bubble Plot Labeled by P Value**

```
pval <- bubblePlot(scorelist = brca,
                    labeltext = "Pval",
                    labelsize = .85)
plot(pval)
```

![](data:image/png;base64...)

**Bubble Plot Labeled by LogFC**

```
logfc <- bubblePlot(scorelist = brca,
                    labeltext = "LogFC",
                    labelsize = .85)
plot(logfc)
```

![](data:image/png;base64...)

## 0.6 metaHeatmap

“metaHeatmap” provides a useful visualization for comparing metabolic profiles
between groups, including only significantly dysregulated pathways, and
highlighting those which are most highly changed. This function should be used
when you have multiple groups/DEGs being compared, e.g. if you have 4 conditions
all being compared to each other. This will not be useful if you have a single
DEG list. This function can be used only when multiple DEG comparisons are
scored by “pathwayAnalysis.” The absolute pathway scores are scaled across
outputs and plotted via pheatmap, selecting only those which have absolute score
p values below the level of significance.

Note: A heatmap cannot be produced if there are no pathways significantly
dysregulated below the p value cut off.

metaHeatmap() requires:

* A list of outputs from pathway analysis, as data frames
* A character vector of names for labeling each output
* Optional: The p value cut off to be used (default = 0.05)

```
##read in two additional sets of scores,
##run in the same manner as brca for comparison

ovca <- read.csv(system.file("extdata/OVCA_Scores.csv", package = "MetaPhOR"),
                header = TRUE,
                row.names = 1)
prad <- read.csv(system.file("extdata/PRAD_Scores.csv", package = "MetaPhOR"),
                header = TRUE,
                row.names = 1)

all.scores <- list(brca, ovca, prad)
names <- c("BRCA", "OVCA", "PRAD")

metaHeatmap(scorelist = all.scores,
            samplenames = names,
            pvalcut = 0.05)
```

![](data:image/png;base64...)

## 0.7 cytoPath

“cytoPath” models metabolic pathways, sourced from WikiPathway (Martens et al. ([2021](#ref-Wikipathways))),
using the transcriptional change of individual genes in the pathway. The
resulting figure can be used to identify candidate genes for further study by
providing a detailed look at transcriptional dysregulation within and between
“pathwayAnalysis” outputs. Pathways of interest can be readily identified from
“bubblePlot” or “metaHeatmap.” This function utilizes Cytoscape (Gustavsen et al. ([2019](#ref-Cytoscape)));
the package *RCy3* and a local instance of Cytoscape are required to render this
plot. For details regarding legends, see the Cytoscape Legend Creator Tutorial
(<https://cytoscape.org/cytoscape-tutorials/protocols/legend-creator/#/>
introduction).

cytoPath() requires:

* The name of the pathway to be plotted
* The file path to the DEG list of interest
* The file path to which the figure will be saved
* The name of the column containing HUGE gene names
* Correct headers for fold change and p value columns (as indicated above)

```
cytoPath(pathway = "Tryptophan Metabolism",
            DEGpath = "BRCA_DEGS.csv",
            figpath = paste(getwd(), "BRCA_Tryptophan_Pathway", sep = "/"),
            genename = "X",
            headers = c("logFC", "adj.P.Val"))
```

![](data:image/png;base64...)

## 0.8 pathwayList

The WikiPathways available within MetaPhOR have been restricted to metabolic
pathways. The pathwayList function will provide a complete list of WikiPathways
for mapping with “cytoPath.”

```
pathwayList()
```

| wpid2name$name |
| --- |
| Acetylcholine synthesis |
| Activation of vitamin K-dependent proteins |
| Adipogenesis |
| Aerobic glycolysis |
| Aflatoxin B1 metabolism |
| AGE/RAGE pathway |

## 0.9 Conclusion

MetaPhOR contains five functions for the analysis of metabolic dysregulation
using transcriptomic-level data and the production of publication-quality
figures. This version of MetaPhOR, 0.99.0, is available at
<https://github.com/emilyise/MetaPhOR>.

## 0.10 SessionInfo

```
sessionInfo()
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
## [1] MetaPhOR_1.12.0  kableExtra_1.4.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1           pbdZMQ_0.3-14           bitops_1.0-9
##   [4] ggplotify_0.1.3         tibble_3.3.0            R.oo_1.27.1
##   [7] RCy3_2.30.0             graph_1.88.0            XML_3.99-0.19
##  [10] rpart_4.1.24            lifecycle_1.0.4         globals_0.18.0
##  [13] lattice_0.22-7          MASS_7.3-65             backports_1.5.0
##  [16] magrittr_2.0.4          sass_0.4.10             rmarkdown_2.30
##  [19] jquerylib_0.1.4         yaml_2.3.10             ggtangle_0.0.7
##  [22] cowplot_1.2.0           DBI_1.2.3               RColorBrewer_1.1-3
##  [25] purrr_1.1.0             R.utils_2.13.0          BiocGenerics_0.56.0
##  [28] RCurl_1.98-1.17         yulab.utils_0.2.1       nnet_7.3-20
##  [31] rappdirs_0.3.3          ipred_0.9-15            gdtools_0.4.4
##  [34] lava_1.8.1              IRanges_2.44.0          S4Vectors_0.48.0
##  [37] enrichplot_1.30.0       ggrepel_0.9.6           listenv_0.9.1
##  [40] tidytree_0.4.6          pheatmap_1.0.13         parallelly_1.45.1
##  [43] svglite_2.2.2           codetools_0.2-20        DOSE_4.4.0
##  [46] xml2_1.4.1              tidyselect_1.2.1        aplot_0.2.9
##  [49] farver_2.1.2            stats4_4.5.1            base64enc_0.1-3
##  [52] Seqinfo_1.0.0           jsonlite_2.0.0          e1071_1.7-16
##  [55] survival_3.8-3          systemfonts_1.3.1       tools_4.5.1
##  [58] treeio_1.34.0           Rcpp_1.1.0              glue_1.8.0
##  [61] prodlim_2025.04.28      xfun_0.53               qvalue_2.42.0
##  [64] IRdisplay_1.1           dplyr_1.1.4             withr_3.0.2
##  [67] BiocManager_1.30.26     fastmap_1.2.0           caTools_1.18.3
##  [70] digest_0.6.37           R6_2.6.1                gridGraphics_0.5-1
##  [73] textshaping_1.0.4       GO.db_3.22.0            gtools_3.9.5
##  [76] dichromat_2.0-0.1       RSQLite_2.4.3           R.methodsS3_1.8.2
##  [79] tidyr_1.3.1             generics_0.1.4          fontLiberation_0.1.0
##  [82] data.table_1.17.8       class_7.3-23            httr_1.4.7
##  [85] htmlwidgets_1.6.4       RJSONIO_2.0.0           pkgconfig_2.0.3
##  [88] gtable_0.3.6            blob_1.2.4              S7_0.2.0
##  [91] XVector_0.50.0          clusterProfiler_4.18.0  htmltools_0.5.8.1
##  [94] fontBitstreamVera_0.1.1 bookdown_0.45           fgsea_1.36.0
##  [97] base64url_1.4           scales_1.4.0            Biobase_2.70.0
## [100] png_0.1-8               ggfun_0.2.0             knitr_1.50
## [103] RecordLinkage_0.4-12.5  rstudioapi_0.17.1       reshape2_1.4.4
## [106] uuid_1.2-1              nlme_3.1-168            repr_1.1.7
## [109] proxy_0.4-27            cachem_1.1.0            stringr_1.5.2
## [112] KernSmooth_2.23-26      parallel_4.5.1          AnnotationDbi_1.72.0
## [115] pillar_1.11.1           grid_4.5.1              vctrs_0.6.5
## [118] gplots_3.2.0            ff_4.5.2                ada_2.0-5
## [121] xtable_1.8-4            evaluate_1.0.5          magick_2.9.0
## [124] tinytex_0.57            cli_3.6.5               compiler_4.5.1
## [127] rlang_1.1.6             crayon_1.5.3            future.apply_1.20.0
## [130] labeling_0.4.3          plyr_1.8.9              fs_1.6.6
## [133] ggiraph_0.9.2           stringi_1.8.7           viridisLite_0.4.2
## [136] BiocParallel_1.44.0     Biostrings_2.78.0       lazyeval_0.2.2
## [139] GOSemSim_2.36.0         fontquiver_0.2.1        Matrix_1.7-4
## [142] IRkernel_1.3.2          patchwork_1.3.2         bit64_4.6.0-1
## [145] future_1.67.0           ggplot2_4.0.0           KEGGREST_1.50.0
## [148] evd_2.3-7.1             igraph_2.2.1            memoise_2.0.1
## [151] bslib_0.9.0             ggtree_4.0.0            fastmatch_1.1-6
## [154] bit_4.6.0               ape_5.8-1               gson_0.1.0
```

## References

Gustavsen, Julia A, Shraddha Pai, Ruth Isserlin, Barry Demchak, and Alexander R Pico. 2019. “RCy3: Network Biology Using Cytoscape from Within R.” *f1000Research* 8 (1774). <https://doi.org/10.12688/f1000research.20887.3>.

Kanehisa, Minoru, and Susumu Goto. 2000. “KEGG: Kyoto Encyclopedia of Genes and Genomes.” *Nucleic Acids Research* 28 (1): 27–30. <https://doi.org/10.1093/nar/28.1.27>.

Love, Michael I., Wolfgang Huber, and Simon Anders. 2014. “Moderated Estimation of Fold Change and Dispersion for Rna-Seq Data with Deseq2.” *Genome Biology* 15 (12): 550. <https://doi.org/10.1186/s13059-014-0550-8>.

Martens, Marvin, Ammar Ammar, Anders Riutta, Andra Waagmeester, Denise N Slenter, Kristina Hanspers, Ryan A Miller, et al. 2021. “WikiPathways: Connecting Communities.” *Nucleic Acids Research* 49 (D1): D613–621. <https://doi.org/10.1093/nar/gkaa1024>.

Ritchie, Matthew E, Belinda Phipson, Di Wu, Yifang Hu, Charity W Law, Wei Shi, and Gordon K Smyth. 2015. “limma Powers Differential Expression Analyses for RNA-Sequencing and Microarray Studies.” *Nucleic Acids Research* 43 (7): e47. <https://doi.org/10.1093/nar/gkv007>.

Rosario, S R, M D Long, H C Affronti, A M Rowsam, K H Eng, and D J Smirglia. 2018. “Pan-Cancer Analysis of Transcriptional Metabolic Dysregulation Using the Cancer Genome Atlas.” *Nature Communications* 9 (5330). <https://doi.org/10.1038/s41467-018-07232-8>.