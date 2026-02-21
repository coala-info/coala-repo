# miRNA and pathway analysis with PanomiR

Pourya Naderi, Alan Teo, Ilya Sytchev, and Winston Hide

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Overview](#overview)
* [4 Pathway summarization](#pathway-summarization)
* [5 Differential Pathway activation](#differential-pathway-activation)
* [6 Finding clusters of pathways](#finding-clusters-of-pathways)
* [7 Prioritizing miRNAs per cluster of pathways.](#prioritizing-mirnas-per-cluster-of-pathways.)
  + [7.1 Enrichment reference](#enrichment-reference)
  + [7.2 Generating targeting scores](#generating-targeting-scores)
  + [7.3 Sampling parameter](#sampling-parameter)
* [8 miRNA-Pathway enrichment tables](#mirna-pathway-enrichment-tables)
* [9 Customized genesets and recommendations](#geneset)
* [10 Session info](#session-info)
* [References](#references)

# 1 Introduction

MicroRNAs (miRNAs) can target co-expressed genes to coordinate multiple
pathways. “Pathway networks of miRNA Regulation” (PanomiR) is a
framework to support the discovery of miRNA regulators based on their targeting
of coordinated pathways. It analyzes and prioritizes multi-pathway dynamics
of miRNA-orchestrated regulation, as opposed to investigating isolated
miRNA-pathway interaction events. PanomiR uses predefined pathways, their
co-activation, gene expression, and annotated miRNA-mRNA interactions to extract
miRNA-pathway targeting events. This vignette describes PanomiR’s functions
and analysis tools to derive these multi-pathway targeting events.

If you use PanomiR for your research, please cite PanomiR’s manuscript
(Naderi Yeganeh et al. [2022](#ref-yeganeh2022panomir)). Please send any questions/suggestions you may have to
`pnaderiy [at] bidmc [dot] harvard [dot] edu` or submit Github issues at
https://github.com/pouryany/PanomiR.

Naderi Yeganeh, Pourya, Yue Yang Teo, Dimitra Karagkouni,
Yered Pita-Juarez, Sarah L. Morgan, Ioannis S. Vlachos, and Winston Hide.
“PanomiR: A systems biology framework for analysis of multi-pathway targeting
by miRNAs.” bioRxiv (2022). doi: https://doi.org/10.1101/2022.07.12.499819.

# 2 Installation

PanomiR can be accessed via Bioconductor. To install, start R (version >= 4.2.0)
and run the following code.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("PanomiR")
```

You can also install the latest development version of PanomiR using GitHub.

```
devtools::install_github("pouryany/PanomiR")
```

# 3 Overview

PanomiR is a framework to prioritize disease-associated miRNAs using activity
of disease-associated pathways. The input datasets for PanomiR are (a) a gene
expression dataset along with covariates such as disease-state and batch,
(b) a background collection of pathways/genesets, and (c) a collection of
miRNAs and their gene targets.

The workflow of PanomiR includes (a) generation of pathway summary
statistics from gene expression data, (b) detection of differentially activated
pathways, (c) finding coherent groups, or clusters, of differentially activated
pathways, and (d) detecting miRNAs that target each group of pathways.

Individual steps of the workflow can be used in isolation to carry out specific
analyses. The following sections outline each step and the material needed to
execute PanomiR.

# 4 Pathway summarization

PanomiR generates pathway activity summary profiles from gene expression data
and a list of pathways. Pathway summaries are numbers that represent the overall
activity of genes that belong to each pathway. These numbers are calculated
based on a methodology previously described in part by Altschuler et al.
(Altschuler et al. [2013](#ref-altschuler2013pathprinting); Joachim et al. [2018](#ref-joachim2018relative)).
Briefly, genes in each sample are ranked by their expression values and then
pathway summaries are calculated as the average rank-squared of genes within a
pathway. The summaries are then center and scaled (zNormalized) across samples.

The default list of background pathways in PanomiR is formatted into a table
(`data("path_gene_table")`). The table is based on canonical pathways collection
of Molecular Signatures Database (MSigDB) V6.2 and it contains annotated
pathways from a variety of sources (Liberzon et al. [2011](#ref-liberzon2011molecular)).

\*\* Users interested in using other pathway/geneset backgrounds, such as newer
versions of MSigDB or KEGG, should refer to the [appendix](#geneset) of
this manual.

This section uses a reduced example dataset from The Cancer Genome Atlas (TCGA)
Liver Hepatocellular Carcinoma (LIHC) dataset to generate
pathway summary statistics (Ally et al. [2017](#ref-ally2017comprehensive)). **Note:** Make sure that
you select a gene representation type that matches the rownames of your
expression data. The type can be modified using the `id` argument in the
function below. The default value for this argument is `ENSEMBL`.

```
library(PanomiR)

# Pathway reference from the PanomiR package
data("path_gene_table")
data("miniTestsPanomiR")
# Generating pathway summary statistics

summaries <- pathwaySummary(miniTestsPanomiR$mini_LIHC_Exp,
                            path_gene_table, method = "x2",
                            zNormalize = TRUE, id = "ENSEMBL")

head(summaries)[,1:2]
#>                         TCGA-BC-A10S-01A-22R-A131-07
#> BIOCARTA_41BB_PATHWAY                     -0.1506216
#> BIOCARTA_ACE2_PATHWAY                     -0.5676447
#> BIOCARTA_ACH_PATHWAY                      -0.3211747
#> BIOCARTA_ACTINY_PATHWAY                    1.4363526
#> BIOCARTA_AGPCR_PATHWAY                    -0.1948523
#> BIOCARTA_AGR_PATHWAY                       0.6802993
#>                         TCGA-BC-4073-01B-02R-A131-07
#> BIOCARTA_41BB_PATHWAY                     -0.1269436
#> BIOCARTA_ACE2_PATHWAY                     -0.8327436
#> BIOCARTA_ACH_PATHWAY                      -0.4390042
#> BIOCARTA_ACTINY_PATHWAY                    1.4975456
#> BIOCARTA_AGPCR_PATHWAY                    -0.2499193
#> BIOCARTA_AGR_PATHWAY                       0.5420588
```

# 5 Differential Pathway activation

Once you generate the pathway activity profiles, as discussed in the last
section, there are several possible analyses that you can perform. We have
bundled some of the most important ones into standalone functions. Here, we
describe differential pathway activity profiling to determine dysregulatd
pathways. This function analyzes differences in pathway activity profiles
in user-determined conditions.

At this stage you need to provide a pathway-gene association table, an
expression dataset, and a covariates table. You need to specify covariates that
you would like to contrast. You also need to provide a contrast, as formatted in
limma (Ritchie et al. [2015](#ref-ritchie2015limma)). If the contrast is not provided, the function assumes
the first two levels of the provided covariate are to be contrasted.
**Note:** make sure the contrast covariate is formatted as factor.

```
output0 <- differentialPathwayAnalysis(
                        geneCounts = miniTestsPanomiR$mini_LIHC_Exp,
                        pathways =  path_gene_table,
                        covariates = miniTestsPanomiR$mini_LIHC_Cov,
                        condition = 'shortLetterCode')

de.paths <- output0$DEP

head(de.paths,3)
#>                                                 logFC   AveExpr          t
#> REACTOME_GROWTH_HORMONE_RECEPTOR_SIGNALING -0.9159376 0.3044281 -10.404966
#> BIOCARTA_AKT_PATHWAY                       -0.5744103 0.3123897  -6.770069
#> PID_IL5_PATHWAY                            -0.6219876 0.4240432  -6.255756
#>                                                 P.Value   adj.P.Val        B
#> REACTOME_GROWTH_HORMONE_RECEPTOR_SIGNALING 1.942463e-06 0.002012391 5.240095
#> BIOCARTA_AKT_PATHWAY                       6.903010e-05 0.035757593 2.126311
#> PID_IL5_PATHWAY                            1.276971e-04 0.040289104 1.550780
#>                                                                       contrast
#> REACTOME_GROWTH_HORMONE_RECEPTOR_SIGNALING shortLetterCodeTP-shortLetterCodeNT
#> BIOCARTA_AKT_PATHWAY                       shortLetterCodeTP-shortLetterCodeNT
#> PID_IL5_PATHWAY                            shortLetterCodeTP-shortLetterCodeNT
```

# 6 Finding clusters of pathways

PanomiR provides a function to find groups coordinated differentially
activated pathways based on a pathway co-expression network (PCxN) previously
described in (Pita-Juárez et al. [2018](#ref-pita2018pathway)). Briefly, PCxN
is a network where nodes are pathways and links are co-expression between the
nodes. It is formatted into a table were rows represent edges. The edges of PCxN
are marked by two numbers, 1- a correlation co-efficient and 2- a significance
adjusted p-value. Cut-offs for both of these numbers can be manually set using
PanomiR functions. See function manuals for more info.

PCxN and its associated genesets are already released and can be accessed
through following Bioconductor packages:
[pcxn](http://bioconductor.org/packages/release/bioc/html/pcxn.html) and
[pcxnData](http://bioconductor.org/packages/release/data/experiment/html/pcxnData.html).

Here we have provided a small version of PCxN for tutorial purposes. A more
recent version of PCxN based on MSigDB V6.2 is available through the
data repository accompanying PanomiR manuscript, which can be found
[here](https://github.com/pouryany/PanomiR_paper).

```
# using an updated version of pcxn

set.seed(2)
pathwayClustsLIHC <- mappingPathwaysClusters(
                            pcxn = miniTestsPanomiR$miniPCXN,
                            dePathways = de.paths[1:300,],
                            topPathways = 200,
                            outDir=".",
                            plot = FALSE,
                            subplot = FALSE,
                            prefix='',
                            clusteringFunction = "cluster_louvain",
                            correlationCutOff = 0.1)

head(pathwayClustsLIHC$Clustering)
#>                      Pathway cluster
#> 1       BIOCARTA_NO1_PATHWAY       1
#> 2       BIOCARTA_AKT_PATHWAY       1
#> 3       BIOCARTA_ALK_PATHWAY       1
#> 4     BIOCARTA_RANKL_PATHWAY       1
#> 5       BIOCARTA_MCM_PATHWAY       3
#> 6 BIOCARTA_CELLCYCLE_PATHWAY       3
```

# 7 Prioritizing miRNAs per cluster of pathways.

PanomiR identifies miRNAs that target clusters of pathways, as defined in the
last section. In order to this, you would need a reference table of
miRNA-Pathway association score (enrichment). We recommend using a customized
miRNA-Pathway association table, tailored to your experimental data.
This section provides an overview of prioritization process. Readers who
interested in knowing more about the technical details of PanomiR can access
PanomiR’s accompanying publication (Naderi Yeganeh et al. [2022](#ref-yeganeh2022panomir)).

## 7.1 Enrichment reference

Here, we provide a pre-processed small example table of miRNA-pathway enrichment
in `miniTestsPanomiR$miniEnrich` object. This table contains enrichment analysis
results using Fisher’s Exact Test between MSigDB pathways and TargetScan miRNA
targets. The individual components are accessible via `data(msigdb_c2)` and
`data(targetScan_03)` (Agarwal et al. [2015](#ref-agarwal2015predicting); Liberzon et al. [2011](#ref-liberzon2011molecular)). This
example table contains only a subset of the full pairwise enrichment.
You can refer to [section 5](#geneset) of this manual to learn how to create
enrichment tables and how to customize them to your specific gene expression
data.

## 7.2 Generating targeting scores

PanomiR generates individual scores for individual miRNAs, which quantify
targeting a group of pathways. These scores are generated based on the reference
enrichment table described in the previous section. We are interested in knowing
to what extent each miRNA targets clusters of pathways identified in the last
step (see previous section).

PanomiR constructs a null distribution of the targeting score for each miRNA.
It then contrasts observed scores from a given group of pathways (clusters)
against the null distribution in order to generate a targeting p-value.
These p-values are used to rank miRNAs per cluster.

## 7.3 Sampling parameter

The process described above requires repeated sampling to empirically obtain the
null distribution. The argument `sampRate` denotes the number of repeats in the
process. Note that in the example below, we use a sampling rate of 50, the
recommended rate is between 500-1000. Also, we set the `saveSampling` argument
to `FALSE`. This argument, when set `TRUE`, ensures that the null distribution
is obtained only once. This argument should be set to TRUE if you wish to save
your sampling and check for different outputs from the clustering algorithms or
pathway thresholds.

```
set.seed(1)
output2 <- prioritizeMicroRNA(enriches0 = miniTestsPanomiR$miniEnrich,
                    pathClust = miniTestsPanomiR$miniPathClusts$Clustering,
                    topClust = 1,
                    sampRate = 50,
                    method = c("aggInv"),
                    outDir = "Output/",
                    dataDir = "outData/",
                    saveSampling = FALSE,
                    runJackKnife = FALSE,
                    numCores = 1,
                    prefix = "outmiR",
                    saveCSV = FALSE)
#> Working on Cluster1.
#> Performing aggInv function.
#> aggInv Method Done

head(output2$Cluster1)
#>                                 x cluster_hits aggInv_cover  aggInv_pval
#> 1                hsa-miR-101-3p.2            6   -1.9566603 0.0001216703
#> 2                hsa-miR-101-3p.1            4   -0.3395771 0.0006214715
#> 3 hsa-miR-124-3p.2/hsa-miR-506-3p            7   -0.2357761 0.0008599272
#> 4                 hsa-miR-1247-5p            4   -1.6599230 0.0021625662
#> 5                 hsa-miR-1249-3p            1   -2.4578993 0.0042061415
#> 6                 hsa-miR-1252-5p            4   -0.7572036 0.0050836835
#>    aggInv_fdr
#> 1 0.002433406
#> 2 0.005732848
#> 3 0.005732848
#> 4 0.010812831
#> 5 0.016824566
#> 6 0.016945612
```

# 8 miRNA-Pathway enrichment tables

We recommend using PanomiR with on tissue/experiment-customized datasets.
In order to do this, you need to create a customized enrichment table.
You can simply do so by using the pathway and miRNA list that we have provided
as a part of the package. Simply, plug in the name of the genes that are present
(expressed) in your experiment in the following code:

```
# using an updated version of pcxn
data("msigdb_c2")
data("targetScan_03")

customeTableEnrich <- miRNAPathwayEnrichment(mirSets = targetScan_03,
                                              pathwaySets = msigdb_c2,
                                              geneSelection = yourGenes,
                                              mirSelection = yourMicroRNAs,
                                              fromID = "ENSEMBL",
                                              toID = "ENTREZID",
                                              minPathSize = 9,
                                              numCores = 1,
                                              outDir = ".",
                                              saveOutName = NULL)
```

In the above section, the field `fromID` denotes the gene representation
format of your input list. Here is a quick example that runs fast. Note that
the `miRNAPathwayEnrichment()` function creates a detailed report with
parameters that are used internally. To get a smaller table that is suitable
for publication purposes, use `reportEnrichment()` function.

```
# using an updated version of pcxn
data("msigdb_c2")
data("targetScan_03")

tempEnrich <-miRNAPathwayEnrichment(targetScan_03[1:30],msigdb_c2[1:30])

head(reportEnrichment(tempEnrich))
#>                               miRNA                Pathway    pval pAdjust
#> 14                  hsa-miR-1252-5p   BIOCARTA_CSK_PATHWAY 0.00179   0.259
#> 55    hsa-miR-1271-5p/hsa-miR-96-5p   BIOCARTA_AKT_PATHWAY 0.01100   1.000
#> 122                hsa-miR-124-3p.1 BIOCARTA_RANKL_PATHWAY 0.01550   1.000
#> 53  hsa-miR-124-3p.2/hsa-miR-506-3p   BIOCARTA_AKT_PATHWAY 0.03740   1.000
#> 99                  hsa-miR-1252-5p BIOCARTA_AGPCR_PATHWAY 0.03940   1.000
#> 112                hsa-miR-124-3p.1   BIOCARTA_BCR_PATHWAY 0.05360   1.000
```

# 9 Customized genesets and recommendations

PanomiR can integrate genesets and pathways from external sources including
those annotated in MSigDB. In order to do so, you need to provide a
`GeneSetCollection` object as defined in the `GSEABase` package.

The example below illustrates using external sources to create your
own customized pathway-gene association table. This customized table can
replace the `path_gene_table` input in sections 1, 2, and 5
of this manual.

```
data("gscExample")

newPathGeneTable <-tableFromGSC(gscExample)
#>
#>
#> 'select()' returned 1:1 mapping between keys and columns
#> 'select()' returned 1:1 mapping between keys and columns
```

The the pathway correlation network in section 3 is build upon an MSigDB V6.2,
canonical pathways (cp) collection dataset that includes KEGG Pathways.
KEGG prohibits distribution of its pathways by third parties. You can
access desired versions of MSigDB in gmt format via
[this link](https://www.gsea-msigdb.org/gsea/downloads_archive.jsp)
(Subramanian et al. [2005](#ref-subramanian2005gene)).

The library `msigdb` provides an programmatic interface to download different
geneset collections. Including how to add KEGG pathways or download mouse
genesets. Use the this [MSigDB tutorial](https://bioconductor.org/packages/release/data/experiment/vignettes/msigdb/inst/doc/msigdb.html)
to create your desired gene sets.

You can also use the following code chunk to create pathway-gene association
tables from gmt files.

```
library(GSEABase)

yourGeneSetCollection <- getGmt("YOUR GMT FILE")
newPathGeneTable      <- tableFromGSC(yourGeneSetCollection)
```

# 10 Session info

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
#> [1] PanomiR_1.14.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3               gson_0.1.0              GSEABase_1.72.0
#>   [4] rlang_1.1.6             magrittr_2.0.4          DOSE_4.4.0
#>   [7] compiler_4.5.1          RSQLite_2.4.3           systemfonts_1.3.1
#>  [10] png_0.1-8               vctrs_0.6.5             reshape2_1.4.4
#>  [13] stringr_1.5.2           pkgconfig_2.0.3         crayon_1.5.3
#>  [16] fastmap_1.2.0           XVector_0.50.0          rmarkdown_2.30
#>  [19] enrichplot_1.30.0       graph_1.88.0            purrr_1.1.0
#>  [22] bit_4.6.0               xfun_0.53               cachem_1.1.0
#>  [25] aplot_0.2.9             jsonlite_2.0.0          blob_1.2.4
#>  [28] BiocParallel_1.44.0     parallel_4.5.1          R6_2.6.1
#>  [31] bslib_0.9.0             stringi_1.8.7           RColorBrewer_1.1-3
#>  [34] limma_3.66.0            jquerylib_0.1.4         GOSemSim_2.36.0
#>  [37] Rcpp_1.1.0              Seqinfo_1.0.0           bookdown_0.45
#>  [40] knitr_1.50              ggtangle_0.0.7          R.utils_2.13.0
#>  [43] IRanges_2.44.0          Matrix_1.7-4            splines_4.5.1
#>  [46] igraph_2.2.1            tidyselect_1.2.1        qvalue_2.42.0
#>  [49] dichromat_2.0-0.1       yaml_2.3.10             codetools_0.2-20
#>  [52] lattice_0.22-7          tibble_3.3.0            plyr_1.8.9
#>  [55] treeio_1.34.0           Biobase_2.70.0          withr_3.0.2
#>  [58] KEGGREST_1.50.0         S7_0.2.0                evaluate_1.0.5
#>  [61] gridGraphics_0.5-1      Biostrings_2.78.0       ggtree_4.0.0
#>  [64] pillar_1.11.1           BiocManager_1.30.26     stats4_4.5.1
#>  [67] clusterProfiler_4.18.0  ggfun_0.2.0             generics_0.1.4
#>  [70] S4Vectors_0.48.0        ggplot2_4.0.0           tidytree_0.4.6
#>  [73] scales_1.4.0            xtable_1.8-4            glue_1.8.0
#>  [76] gdtools_0.4.4           lazyeval_0.2.2          tools_4.5.1
#>  [79] data.table_1.17.8       fgsea_1.36.0            annotate_1.88.0
#>  [82] ggiraph_0.9.2           forcats_1.0.1           fs_1.6.6
#>  [85] XML_3.99-0.19           fastmatch_1.1-6         cowplot_1.2.0
#>  [88] grid_4.5.1              tidyr_1.3.1             ape_5.8-1
#>  [91] AnnotationDbi_1.72.0    nlme_3.1-168            patchwork_1.3.2
#>  [94] cli_3.6.5               rappdirs_0.3.3          fontBitstreamVera_0.1.1
#>  [97] dplyr_1.1.4             gtable_0.3.6            R.methodsS3_1.8.2
#> [100] yulab.utils_0.2.1       fontquiver_0.2.1        sass_0.4.10
#> [103] digest_0.6.37           BiocGenerics_0.56.0     ggrepel_0.9.6
#> [106] ggplotify_0.1.3         org.Hs.eg.db_3.22.0     htmlwidgets_1.6.4
#> [109] farver_2.1.2            memoise_2.0.1           htmltools_0.5.8.1
#> [112] R.oo_1.27.1             lifecycle_1.0.4         httr_1.4.7
#> [115] GO.db_3.22.0            statmod_1.5.1           fontLiberation_0.1.0
#> [118] bit64_4.6.0-1
```

# References

Agarwal, Vikram, George W Bell, Jin-Wu Nam, and David P Bartel. 2015. “Predicting Effective microRNA Target Sites in Mammalian mRNAs.” *Elife* 4: e05005.

Ally, Adrian, Miruna Balasundaram, Rebecca Carlsen, Eric Chuah, Amanda Clarke, Noreen Dhalla, Robert A Holt, et al. 2017. “Comprehensive and Integrative Genomic Characterization of Hepatocellular Carcinoma.” *Cell* 169 (7): 1327–41.

Altschuler, Gabriel M, Oliver Hofmann, Irina Kalatskaya, Rebecca Payne, Shannan J Ho Sui, Uma Saxena, Andrei V Krivtsov, et al. 2013. “Pathprinting: An Integrative Approach to Understand the Functional Basis of Disease.” *Genome Medicine* 5 (7): 1–13.

Joachim, Rose B, Gabriel M Altschuler, John N Hutchinson, Hector R Wong, Winston A Hide, and Lester Kobzik. 2018. “The Relative Resistance of Children to Sepsis Mortality: From Pathways to Drug Candidates.” *Molecular Systems Biology* 14 (5): e7998.

Liberzon, Arthur, Aravind Subramanian, Reid Pinchback, Helga Thorvaldsdóttir, Pablo Tamayo, and Jill P Mesirov. 2011. “Molecular Signatures Database (Msigdb) 3.0.” *Bioinformatics* 27 (12): 1739–40.

Naderi Yeganeh, Pourya, Yue Yang Teo, Dimitra Karagkouni, Yered Pita-Juarez, Sarah L Morgan, Ioannis S Vlachos, and Winston Hide. 2022. “PanomiR: A Systems Biology Framework for Analysis of Multi-Pathway Targeting by miRNAs.” *bioRxiv*.

Pita-Juárez, Yered, Gabriel Altschuler, Sokratis Kariotis, Wenbin Wei, Katjuša Koler, Claire Green, Rudolph E Tanzi, and Winston Hide. 2018. “The Pathway Coexpression Network: Revealing Pathway Relationships.” *PLoS Computational Biology* 14 (3): e1006042.

Ritchie, Matthew E, Belinda Phipson, DI Wu, Yifang Hu, Charity W Law, Wei Shi, and Gordon K Smyth. 2015. “Limma Powers Differential Expression Analyses for Rna-Sequencing and Microarray Studies.” *Nucleic Acids Research* 43 (7): e47–e47.

Subramanian, Aravind, Pablo Tamayo, Vamsi K Mootha, Sayan Mukherjee, Benjamin L Ebert, Michael A Gillette, Amanda Paulovich, et al. 2005. “Gene Set Enrichment Analysis: A Knowledge-Based Approach for Interpreting Genome-Wide Expression Profiles.” *Proceedings of the National Academy of Sciences* 102 (43): 15545–50.