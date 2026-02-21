# Gene set scores computation with NetActivity

Carlos Ruiz Arenas1\*

1Centro de Investigación Biomédica en Red de Enfermedades Raras (CIBERER), Barcelona, Spain

\*carlos.ruiza@upf.edu

#### 2025-10-30

#### Package

NetActivity 1.12.0

# 1 Installation

You can install the current release version of NetActivity from [Bioconductor](https://bioconductor.org/) with:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("NetActivity")
```

You can install the development version of NetActivity from [GitHub](https://github.com/) with:

```
# install.packages("devtools")
devtools::install_github("yocra3/NetActivity")
devtools::install_github("yocra3/NetActivityData")
```

# 2 Introduction

The coordination of multiple genes is required to perform specific biological functions, so grouping gene expression in gene sets provides better biological insights than studying individual genes. We have developed a framework, [NetActivityTrain](http://github.com/yocra3/NetActivityTrain), to encode individual gene expression measurements into gene set scores. This framework is implemented in [Nextflow](http://nextflow.io/) and is based on sparsely-connected autoencoders. In our framework, each gene set is represented by a neuron in the hidden layer, which is connected to only the gene set genes from the input layer. Nonetheless, to ensure a better representation of the gene sets, all gene sets are connected to all genes in the output layer.

Our framework, `NetActivityTrain`, is implemented in Nextflow, which is useful to train the models but not to apply the models to new data. To overcome this issue, we have implemented the package *[NetActivity](https://github.com/yocra3/NetActivity)*. *[NetActivity](https://github.com/yocra3/NetActivity)* enables to easily apply the gene set representations obtained with `NetActivityTrain` to new datasets. We have included two models containing GO Biological processes and KEGG pathways trained with GTEx or TCGA data in *[NetActivityData](https://github.com/yocra3/NetActivityData)*.

# 3 Pre-processing

Computation of gene set scores is performed with `computeGeneSetScores`. The `computeGeneSetScores` functions requires a *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* with the gene expression data standardized at gene level. The function `prepareSummarizedExperiment` facilitates the process.

*[NetActivity](https://github.com/yocra3/NetActivity)* can be applied to RNAseq or microarray data. We will exemplify how to process each dataset independently.

## 3.1 RNAseq

For this vignette, we will show how to process RNAseq using the *[airway](https://bioconductor.org/packages/3.22/airway)* dataset:

```
library(NetActivity)
library(DESeq2)
library(airway)
data(airway)
```

The `airway` dataset contains 63677 genes and 8 samples. Gene expression data is represented as counts. *NetActivity* functions require normalized data to work. We suggest using Variance Stabilizing Transformation from *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* to normalize gene expression data:

```
ddsSE <- DESeqDataSet(airway, design = ~ cell + dex)
vst <- varianceStabilizingTransformation(ddsSE)
```

Once we have normalized the data, we can proceed with the pre-processing. `prepareSummarizedExperiment` requires two arguments: a `SummarizedExperiment` and a model trained from `NetActivityTrain`. The current version of *NetActivityData* includes a model with GO-BP (Biological Processes) terms and KEGG pathways trained with GTEx or with TCGA. In this vignette, we will use the model trained in GTEx:

```
out <- prepareSummarizedExperiment(vst, "gtex_gokegg")
```

```
## Warning in prepareSummarizedExperiment(vst, "gtex_gokegg"): 50 genes present in
## the model not found in input data. The expression of all samples will be set to
## 0.
```

```
out
```

```
## class: SummarizedExperiment
## dim: 63727 8
## metadata(0):
## assays(1): ''
## rownames(63727): ENSG00000000003 ENSG00000000005 ... ENSG00000278637
##   ENSG00000280789
## rowData names(0):
## colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
## colData names(10): SampleName cell ... BioSample sizeFactor
```

`prepareSummarizedExperiment` performs two steps. First, it checks whether all genes in the model are present in the input `SummarizedExperiment`. Missing genes are added as a row of 0s. Second, the function standardizes gene expression data by gene. We can compare the genes values before and after `prepareSummarizedExperiment` to see the effect of normalization:

```
library(tidyverse)
```

```
rbind(assay(vst[1:5, ]) %>%
        data.frame() %>%
        mutate(Gene = rownames(.)) %>%
        gather(Sample, Expression, 1:8) %>%
        mutate(Step = "Before"),
    assay(out[1:5, ]) %>%
        data.frame() %>%
        mutate(Gene = rownames(.)) %>%
        gather(Sample, Expression, 1:8) %>%
        mutate(Step = "After")) %>%
    mutate(Step = factor(Step, levels = c("Before", "After"))) %>%
    ggplot(aes(x = Gene, y = Expression, col = Gene)) +
        geom_boxplot() +
        theme_bw() +
        facet_grid(~ Step, scales = "free") +
        theme(axis.ticks = element_blank(), axis.text.x = element_blank())
```

![Standardization. Effect of standardization on gene expression values. Before represent the gene expression values passed to prepareSummarizedExperiment. After are the values obtained after prepareSummarizedExperiment.](data:image/png;base64...)

Figure 1: Standardization
Effect of standardization on gene expression values. Before represent the gene expression values passed to prepareSummarizedExperiment. After are the values obtained after prepareSummarizedExperiment.

In Figure [1](#fig:plot), we can see that the original gene expression values are normalized values with different medians and dispersions. After standardization, all gene values are centered to a mean of 0 and have more similar distributions.

Next, we can check the values of a gene not present originally in the data:

```
assay(out["ENSG00000278637", ])
```

```
##                 SRR1039508 SRR1039509 SRR1039512 SRR1039513 SRR1039516
## ENSG00000278637          0          0          0          0          0
##                 SRR1039517 SRR1039520 SRR1039521
## ENSG00000278637          0          0          0
```

Notice that functions included in *NetActivity* require that the `SummarizedExperiment` and the model shared the same annotation. In this example, both objects were annotated using ENSEMBL annotation, so no additional steps were required. In case the genes in the `SummarizedExperiment` use a different annotation, see how to convert them in the next section. Notice that the current models included in *NetActivityData* contain the genes using ENSEMBL annotation.

## 3.2 Microarray data

For this vignette, we will show how to process microarray data using the *[Fletcher2013a](https://bioconductor.org/packages/3.22/Fletcher2013a)* dataset:

```
library(limma)
library(Fletcher2013a)
data(Exp1)
Exp1
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 47231 features, 46 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: MA1 MA2 ... MI6 (46 total)
##   varLabels: Sample Time ... Target (10 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: ILMN_1343291 ILMN_1343295 ... ILMN_3311190 (47231
##     total)
##   fvarLabels: PROBEID ENTREZ SYMBOL
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation: illuminaHumanv4
```

`Exp1` is an `ExpressionSet` containing the information for 47231 genes and 46 samples. Genes are named with Affymetrix ids, but the SYMBOL information is available.

The first step is converting the `ExpressionSet` to a `SummarizedExperiment`:

```
SE_fletcher <- SummarizedExperiment(exprs(Exp1), colData = pData(Exp1), rowData = fData(Exp1))
```

Second, we will set the rownames to ENSEMBL. For this, we will first map probe ids to SYMBOL and then to ENSEMBL id. Notice that mapping probes to SYMBOL and then to ENSEMBL might result in probes without annotation or duplicated probes with the same ENSEMBL id. For the sake of simplicity, in this vignette we will remove probes without SYMBOL or with duplicated SYMBOLs based on order. Nonetheless, the users are encouraged to apply other criteria in order to get the final set.

```
library(AnnotationDbi)
library(org.Hs.eg.db)
```

```
rownames(SE_fletcher) <- rowData(SE_fletcher)$SYMBOL
SE_fletcher <- SE_fletcher[!is.na(rownames(SE_fletcher)), ]
SE_fletcher <- SE_fletcher[!duplicated(rownames(SE_fletcher)), ]

rownames(SE_fletcher) <- mapIds(org.Hs.eg.db,
    keys = rownames(SE_fletcher),
    column = 'ENSEMBL',
    keytype = 'SYMBOL')
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
SE_fletcher <- SE_fletcher[!is.na(rownames(SE_fletcher)), ]
SE_fletcher <- SE_fletcher[!duplicated(rownames(SE_fletcher)), ]
SE_fletcher
```

```
## class: SummarizedExperiment
## dim: 18003 46
## metadata(0):
## assays(1): ''
## rownames(18003): ENSG00000156508 ENSG00000111640 ... ENSG00000221493
##   ENSG00000221545
## rowData names(3): PROBEID ENTREZ SYMBOL
## colnames(46): MA1 MA2 ... MI4 MI6
## colData names(10): Sample Time ... TreatmentGroups Target
```

Now, we can pass the resulting `SummarizedExperiment` to `prepareSummarizedExperiment`:

```
out_array <- prepareSummarizedExperiment(SE_fletcher, "gtex_gokegg")
```

```
## Warning in prepareSummarizedExperiment(SE_fletcher, "gtex_gokegg"): 810 genes
## present in the model not found in input data. The expression of all samples
## will be set to 0.
```

```
out_array
```

```
## class: SummarizedExperiment
## dim: 18813 46
## metadata(0):
## assays(1): ''
## rownames(18813): ENSG00000156508 ENSG00000111640 ... ENSG00000278637
##   ENSG00000280789
## rowData names(0):
## colnames(46): MA1 MA2 ... MI4 MI6
## colData names(10): Sample Time ... TreatmentGroups Target
```

# 4 Computing the scores

Once we have pre-processed the data, we are ready to compute the gene set scores. We will continue with the output of the microarray data (`out_array`).

`computeGeneSetScores` requires two arguments: a `SummarizedExperiment` and a model trained from `NetActivityTrain`:

```
scores <- computeGeneSetScores(out_array, "gtex_gokegg")
scores
```

```
## class: SummarizedExperiment
## dim: 1518 46
## metadata(0):
## assays(1): ''
## rownames(1518): GO:0006734 GO:0008340 ... path:hsa04966 path:hsa04977
## rowData names(4): Term GeneSet Weights Weights_SYMBOL
## colnames(46): MA1 MA2 ... MI4 MI6
## colData names(10): Sample Time ... TreatmentGroups Target
```

`computeGeneSetScores` returns a `SummarizedExperiment` with the gene set scores for all the gene sets present in the model. The `colData` of the input `SummarizedExperiment` is preserved, so this object can be directly used for downstream analyses. The `rowData` contains annotation of the gene sets, which can be useful for downstream analyses:

```
rowData(scores)
```

```
## DataFrame with 1518 rows and 4 columns
##                                 Term       GeneSet
##                          <character>   <character>
## GO:0006734    NADH metabolic process    GO:0006734
## GO:0008340    determination of adu..    GO:0008340
## GO:0014854    response to inactivity    GO:0014854
## GO:0019081         viral translation    GO:0019081
## GO:0019835                 cytolysis    GO:0019835
## ...                              ...           ...
## path:hsa04614 Renin-angiotensin sy.. path:hsa04614
## path:hsa04744      Phototransduction path:hsa04744
## path:hsa04964 Proximal tubule bica.. path:hsa04964
## path:hsa04966 Collecting duct acid.. path:hsa04966
## path:hsa04977 Vitamin digestion an.. path:hsa04977
##                                                  Weights
##                                                   <list>
## GO:0006734           0.0209889, 0.0738816,-0.0206952,...
## GO:0008340           0.1628420,-0.0977037,-0.1346692,...
## GO:0014854          -0.2046938,-0.1480707,-0.0132261,...
## GO:0019081     0.002303295, 0.027539201,-0.000309411,...
## GO:0019835          -0.0330166, 0.0329533, 0.0290691,...
## ...                                                  ...
## path:hsa04614       -0.0728291,-0.0747844,-0.0602768,...
## path:hsa04744       0.14130385,0.13613251,0.00561176,...
## path:hsa04964        0.0112757, 0.0593170,-0.0692757,...
## path:hsa04966       -0.0475978, 0.1188805, 0.0976878,...
## path:hsa04977       -0.0478214, 0.0285422,-0.0713180,...
##                                           Weights_SYMBOL
##                                                   <list>
## GO:0006734           0.0209889, 0.0738816,-0.0206952,...
## GO:0008340           0.1628420,-0.0977037,-0.1346692,...
## GO:0014854          -0.2046938,-0.1480707,-0.0132261,...
## GO:0019081     0.002303295, 0.027539201,-0.000309411,...
## GO:0019835          -0.0330166, 0.0329533, 0.0290691,...
## ...                                                  ...
## path:hsa04614       -0.0728291,-0.0747844,-0.0602768,...
## path:hsa04744       0.14130385,0.13613251,0.00561176,...
## path:hsa04964        0.0112757, 0.0593170,-0.0692757,...
## path:hsa04966       -0.0475978, 0.1188805, 0.0976878,...
## path:hsa04977       -0.0478214, 0.0285422,-0.0713180,...
```

# 5 Differential gene set scores analysis

Once the gene set scores are computed, we can test for differential expression using *[limma](https://bioconductor.org/packages/3.22/limma)*. We will run a differential analysis due to treatment, adjusted for time points:

```
mod <- model.matrix(~ Treatment + Time, colData(scores))
fit <- lmFit(assay(scores), mod) %>% eBayes()
topTab <- topTable(fit, coef = 2:4, n = Inf)
head(topTab)
```

```
##            TreatmentE2FGF10 TreatmentE2FGF10PD TreatmentUT       AveExpr
## GO:1990440        1.0255687         0.03220728  -0.9531159 -2.665365e-15
## GO:0045943        0.5426360         0.03697507  -0.8617941 -4.529891e-16
## GO:0000470       -0.3737068        -0.12955486   0.8604381 -1.766401e-16
## GO:2000232       -0.3266975        -0.12581617   0.7801178 -2.485934e-16
## GO:0000083        0.2643651        -0.10021547  -1.0062766 -3.378940e-16
## GO:1902570        0.3195350         0.15336997  -0.5789914 -1.704554e-17
##                   F      P.Value    adj.P.Val
## GO:1990440 64.18723 1.516264e-17 2.301689e-14
## GO:0045943 52.22794 9.355324e-16 7.100691e-13
## GO:0000470 42.28934 5.107530e-14 2.584410e-11
## GO:2000232 31.04809 1.139619e-11 4.324854e-09
## GO:0000083 30.55057 1.488520e-11 4.519148e-09
## GO:1902570 27.49184 8.183920e-11 2.070532e-08
```

For easing the interpretation, we can add the gene set full name to the results table:

```
topTab$GeneSetName <- rowData(scores)[rownames(topTab), "Term"]
head(topTab)
```

```
##            TreatmentE2FGF10 TreatmentE2FGF10PD TreatmentUT       AveExpr
## GO:1990440        1.0255687         0.03220728  -0.9531159 -2.665365e-15
## GO:0045943        0.5426360         0.03697507  -0.8617941 -4.529891e-16
## GO:0000470       -0.3737068        -0.12955486   0.8604381 -1.766401e-16
## GO:2000232       -0.3266975        -0.12581617   0.7801178 -2.485934e-16
## GO:0000083        0.2643651        -0.10021547  -1.0062766 -3.378940e-16
## GO:1902570        0.3195350         0.15336997  -0.5789914 -1.704554e-17
##                   F      P.Value    adj.P.Val
## GO:1990440 64.18723 1.516264e-17 2.301689e-14
## GO:0045943 52.22794 9.355324e-16 7.100691e-13
## GO:0000470 42.28934 5.107530e-14 2.584410e-11
## GO:2000232 31.04809 1.139619e-11 4.324854e-09
## GO:0000083 30.55057 1.488520e-11 4.519148e-09
## GO:1902570 27.49184 8.183920e-11 2.070532e-08
##                                                                                                                 GeneSetName
## GO:1990440 positive regulation of transcription from RNA polymerase II promoter in response to endoplasmic reticulum stress
## GO:0045943                                                         positive regulation of transcription by RNA polymerase I
## GO:0000470                                                                                           maturation of LSU-rRNA
## GO:2000232                                                                                    regulation of rRNA processing
## GO:0000083                                    regulation of transcription involved in G1/S transition of mitotic cell cycle
## GO:1902570                                                                                protein localization to nucleolus
```

Many gene sets present high differences due to treatment. We will further explore the top gene set (GO:1990440 or positive regulation of transcription from RNA polymerase II promoter in response to endoplasmic reticulum stress).

Once we have our candidate gene set, we recommend taking a look to the distribution of gene set scores based on our variable of interest:

```
data.frame(Expression = as.vector(assay(scores["GO:1990440", ])),
    Treatment = scores$Treatment) %>%
    ggplot(aes(x = Treatment, y = Expression, col = Treatment)) +
        geom_boxplot() +
        theme_bw() +
    ylab("NetActivity scores")
```

![GO:1990440 activity scores. GO:1990440 presented the most significant difference due to treatment.](data:image/png;base64...)

Figure 2: GO:1990440 activity scores
GO:1990440 presented the most significant difference due to treatment.

We can clearly see differences in GO:1990440 activation scores between the different treatment groups in Figure [2](#fig:plotScores). UT samples have the lowest gene set activity scores while E2FGF10 have the highest activation scores.

Nonetheless, notice that the sign of the gene set score is arbitrary and cannot be directly interpreted. To be able to interpret the scores, we can take a look to the weights used for the computation:

```
weights <- rowData(scores)["GO:1990440", ]$Weights_SYMBOL[[1]]
data.frame(weight = weights, gene = names(weights)) %>%
    mutate(Direction = ifelse(weight > 0, "Positive", "Negative")) %>%
    ggplot(aes(x = gene, y = abs(weight), fill = Direction)) +
    geom_bar(stat = "identity") +
    theme_bw() +
    ylab("Weight") +
    xlab("Gene")
```

![Weights of GO:1990440 gene set. The figure represents the weights used for computing the GO:1990440 gene set score. Weights are in absolute value to enable an easier comparison of their magnitude. Positive weights are shown in blue and negative in red.](data:image/png;base64...)

Figure 3: Weights of GO:1990440 gene set
The figure represents the weights used for computing the GO:1990440 gene set score. Weights are in absolute value to enable an easier comparison of their magnitude. Positive weights are shown in blue and negative in red.

In Figure [3](#fig:plotWeight), we can see a comparison between the gene weights used for the gene set score computation. Genes with larger weights have a higher importance on gene set computation. Thus, ATF6, ATF4, DDIT3, CEBPB and TP53 are the most relevant genes for the gene set computation. As all of them have a positive sign, individuals with higher gene set activity scores for GO:1990440 will have higher expression of these genes.

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] org.Hs.eg.db_3.22.0         AnnotationDbi_1.72.0
##  [3] Fletcher2013a_1.45.0        limma_3.66.0
##  [5] lubridate_1.9.4             forcats_1.0.1
##  [7] stringr_1.5.2               dplyr_1.1.4
##  [9] purrr_1.1.0                 readr_2.1.5
## [11] tidyr_1.3.1                 tibble_3.3.0
## [13] ggplot2_4.0.0               tidyverse_2.0.0
## [15] airway_1.29.0               DESeq2_1.50.0
## [17] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [19] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [21] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [23] IRanges_2.44.0              S4Vectors_0.48.0
## [25] BiocGenerics_0.56.0         generics_0.1.4
## [27] NetActivity_1.12.0          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                 bitops_1.0-9
##  [3] formatR_1.14              rlang_1.1.6
##  [5] magrittr_2.0.4            NetActivityData_1.11.0
##  [7] compiler_4.5.1            RSQLite_2.4.3
##  [9] DelayedMatrixStats_1.32.0 png_0.1-8
## [11] vctrs_0.6.5               pkgconfig_2.0.3
## [13] crayon_1.5.3              fastmap_1.2.0
## [15] magick_2.9.0              XVector_0.50.0
## [17] labeling_0.4.3            caTools_1.18.3
## [19] rmarkdown_2.30            tzdb_0.5.0
## [21] tinytex_0.57              bit_4.6.0
## [23] xfun_0.53                 cachem_1.1.0
## [25] jsonlite_2.0.0            blob_1.2.4
## [27] DelayedArray_0.36.0       BiocParallel_1.44.0
## [29] parallel_4.5.1            R6_2.6.1
## [31] bslib_0.9.0               stringi_1.8.7
## [33] RColorBrewer_1.1-3        jquerylib_0.1.4
## [35] Rcpp_1.1.0                bookdown_0.45
## [37] knitr_1.50                VennDiagram_1.7.3
## [39] Matrix_1.7-4              timechange_0.3.0
## [41] tidyselect_1.2.1          dichromat_2.0-0.1
## [43] abind_1.4-8               yaml_2.3.10
## [45] gplots_3.2.0              codetools_0.2-20
## [47] lattice_0.22-7            withr_3.0.2
## [49] KEGGREST_1.50.0           S7_0.2.0
## [51] evaluate_1.0.5            lambda.r_1.2.4
## [53] futile.logger_1.4.3       Biostrings_2.78.0
## [55] pillar_1.11.1             BiocManager_1.30.26
## [57] KernSmooth_2.23-26        hms_1.1.4
## [59] sparseMatrixStats_1.22.0  scales_1.4.0
## [61] gtools_3.9.5              glue_1.8.0
## [63] tools_4.5.1               locfit_1.5-9.12
## [65] grid_4.5.1                cli_3.6.5
## [67] futile.options_1.0.1      S4Arrays_1.10.0
## [69] gtable_0.3.6              sass_0.4.10
## [71] digest_0.6.37             SparseArray_1.10.0
## [73] farver_2.1.2              memoise_2.0.1
## [75] htmltools_0.5.8.1         lifecycle_1.0.4
## [77] httr_1.4.7                statmod_1.5.1
## [79] bit64_4.6.0-1
```