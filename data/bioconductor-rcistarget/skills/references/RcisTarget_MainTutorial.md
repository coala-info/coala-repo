# RcisTarget: Transcription factor binding motif enrichment

Abstract

This tutorial shows how to use **RcisTarget** to obtain transcription factor binding motifs enriched on a gene list.

*Vignette built on Oct 07, 2025 with RcisTarget **version 1.29.0***.

# What is RcisTarget?

RcisTarget is an R-package to identify transcription factor (TF) binding motifs over-represented on a gene list.

RcisTarget is based on the methods previously implemented in [i-cisTarget](http://gbiomed.kuleuven.be/apps/lcb/i-cisTarget) (web interface, region-based) and [iRegulon](http://iregulon.aertslab.org) (Cytoscape plug-in, gene-based).

If you use RcisTarget in your research, please cite:

```
## Aibar et al. (2017) SCENIC: single-cell regulatory network
##   inference and clustering. Nature Methods. doi: 10.1038/nmeth.4463
```

# Overview of the workflow

The function `cisTarget()` allows to perform the motif-enrichment analysis on a gene list. The main input parameters are the gene list and the motif databases, which should be chosen depending on the organism and the search space around the TSS of the genes. This is a sample on how to run the analysis (see the following sections for details):

```
library(RcisTarget)

# Load gene sets to analyze. e.g.:
geneList1 <- read.table(file.path(system.file('examples', package='RcisTarget'), "hypoxiaGeneSet.txt"), stringsAsFactors=FALSE)[,1]
geneLists <- list(geneListName=geneList1)
# geneLists <- GSEABase::GeneSet(genes, setName="geneListName") # alternative

# Select motif database to use (i.e. organism and distance around TSS)
data(motifAnnotations_hgnc)
motifRankings <- importRankings("~/databases/hg38_10kbp_up_10kbp_down_full_tx_v10_clust.genes_vs_motifs.rankings.feather")

# Motif enrichment analysis:
motifEnrichmentTable_wGenes <- cisTarget(geneLists, motifRankings,
                               motifAnnot=motifAnnotations)
```

**Advanced use**: The `cisTarget()` function is enough for most simple analyses. However, for further flexibility (e.g. removing unnecessary steps on bigger analyses), RcisTarget also provides the possibility to run the inner functions individually. Running `cisTarget()` is equivalent to running this code:

```
# 1. Calculate AUC
motifs_AUC <- calcAUC(geneLists, motifRankings)

# 2. Select significant motifs, add TF annotation & format as table
motifEnrichmentTable <- addMotifAnnotation(motifs_AUC,
                          motifAnnot=motifAnnotations)

# 3. Identify significant genes for each motif
# (i.e. genes from the gene set in the top of the ranking)
# Note: Method 'iCisTarget' instead of 'aprox' is more accurate, but slower
motifEnrichmentTable_wGenes <- addSignificantGenes(motifEnrichmentTable,
                                                   geneSets=geneLists,
                                                   rankings=motifRankings,
                                                   nCores=1,
                                                   method="aprox")
```

# Before starting

## Setup

RcisTarget uses species-specific databases which are provided as independent R-packages. Prior to running RcisTarget, you will need to download and install the databases for the relevant organism (more details in the “Motif databases” section).

In addition, some extra packages can be installed to run RcisTarget in parallel or run the interactive examples in this tutorial:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
# To support paralell execution:
BiocManager::install(c("doMC", "doRNG"))
# For the examples in the follow-up section of the tutorial:
BiocManager::install(c("DT", "visNetwork"))
```

## Some tips…

### Help

At any time, remember you an access the help files for any function (i.e. `?cisTarget`), and the other tutorials in the package with the following commands:

```
# Explore tutorials in the web browser:
browseVignettes(package="RcisTarget")

# Commnad line-based:
vignette(package="RcisTarget") # list
vignette("RcisTarget") # open
```

### Reports

To generate an HTML report with your own data and comments, you can use the `.Rmd file` of this tutorial as template (i.e. copy the .Rmd file, and edit it as [R notebook](http://rmarkdown.rstudio.com/r_notebooks.html) in RStudio).

```
vignetteFile <- paste(file.path(system.file('doc', package='RcisTarget')),
                      "RcisTarget.Rmd", sep="/")
# Copy to edit as markdown
file.copy(vignetteFile, ".")
# Alternative: extract R code
Stangle(vignetteFile)
```

# Running RcisTarget

## Input: Gene sets

The main input to RcisTarget is the gene set(s) to analyze. The gene sets can be provided as a ‘named list’ in which each element is a gene-set (character vector containing gene names) or as a `GSEABase::GeneSet`. The gene-set name will be used as ID in the following steps.

```
library(RcisTarget)
geneSet1 <- c("gene1", "gene2", "gene3")
geneLists <- list(geneSetName=geneSet1)
# or:
# geneLists <- GSEABase::GeneSet(geneSet1, setName="geneSetName")
```

Some extra help:

```
class(geneSet1)
class(geneLists)
geneSet2 <- c("gene2", "gene4", "gene5", "gene6")
geneLists[["anotherGeneSet"]] <- geneSet2
names(geneLists)
geneLists$anotherGeneSet
lengths(geneLists)
```

In this example we will be using a list of genes up-regulated in MCF7 cells under hypoxia conditions ([PMID:16565084](https://www.ncbi.nlm.nih.gov/pubmed/?term=16565084)).

The original work highlighted the role of hypoxia-inducible factor (HIF1-alpha or HIF1A) pathways under hypoxia. This gene list is also used for the turorials in iRegulon (<http://iregulon.aertslab.org/tutorial.html>).

```
txtFile <- paste(file.path(system.file('examples', package='RcisTarget')),
                 "hypoxiaGeneSet.txt", sep="/")
geneLists <- list(hypoxia=read.table(txtFile, stringsAsFactors=FALSE)[,1])
head(geneLists$hypoxia)
```

```
## [1] "ADM"     "ADORA2B" "AHNAK2"  "AK4"     "AKAP12"  "ALDOC"
```

## Required databases

To analyze the gene list, RcisTarget needs two types of databases:

* 1. Gene-motif rankings: which provides the rankings (based on the motif score) of all the genes for each motif.
* 2. The annotation of motifs to transcription factors.

### Gene-motif rankings

The score of each pair of gene-motif can be performed using different parameters. Therefore, we provide multiple databases ([motif-rankings](https://resources.aertslab.org/cistarget/), or alternative: [mirror](https://resources-mirror.aertslab.org/cistarget/)), according to several possibilities:

* Species: Species of the input gene set. *Available values: Human (Homo sapiens), mouse (Mus musculus) or fly (Drosophila melanogaster)*
* Scoring/search space: determine the search space around the transcription start site (TSS). *Available values: 500 bp uptream the TSS, 5kbp or 10kbp around the TSS (e.g. 10kbp upstream and 10kbp downstream of the TSS).*
* Motif collection: We recommend to use the latest one (mc10\_clust).

If you don’t know which database to choose, for an analisis of a gene list we would suggest using the *500bp upstream TSS*, and a larger search space (e.g. *TSS+/-5kbp* or *TSS+/-10kbp*). Of course, selecting Human, Mouse or fly depending on your input gene list.

For other settings (e.g. **new species**), you can check the tutorial on how to [create databases](https://github.com/aertslab/create_cisTarget_databases).

Each database is stored in a `.feather` file. Note that the download size is typically over 1GB (100GB for human region databases), we recommend downloading the files with `zsync_curl`` (see the [Help with downloads](https://resources.aertslab.org/cistarget/help.html)).

Once you have the .feather files, they can be loaded with `importRankings()`:

```
# Search space: 10k bp around TSS - HUMAN
motifRankings <- importRankings("hg38_10kbp_up_10kbp_down_full_tx_v10_clust.genes_vs_motifs.rankings.feather")
# Load the annotation to human transcription factors
data(motifAnnotations_hgnc)
```

### Motif annotations

All the calculations performed by RcisTarget are motif-based. However, most users will be interested on TFs potentially regulating the gene-set. The association of motif to transcription factors are provided in an independent file. In addition to the motifs annotated by the source datatabse (i.e. **direct** annotation), we have also **inferred** some further annotations based on motif similarity and gene ortology (e.g. similarity to other genes annotated to the motif). These annotations are typically used with the functions `cisTarget()` or `addMotifAnnotation()`.

For the motifs in version ‘mc10nr’ of the rankings, these annotations are already included in RcisTarget package and can be loaded with the command:

```
# mouse:
# data(motifAnnotations_mgi)

# human:
data(motifAnnotations_hgnc)
motifAnnotations[199:202,]
```

```
## Key: <motif, TF>
##            motif     TF directAnnotation inferred_Orthology inferred_MotifSimil
##           <char> <char>           <lgcl>             <lgcl>              <lgcl>
## 1: cisbp__M00192  SMAD3            FALSE               TRUE               FALSE
## 2: cisbp__M00193   TCF7            FALSE               TRUE               FALSE
## 3: cisbp__M00194   HBP1            FALSE               TRUE               FALSE
## 4: cisbp__M00195    CIC            FALSE               TRUE               FALSE
##        annotationSource
##                  <fctr>
## 1: inferredBy_Orthology
## 2: inferredBy_Orthology
## 3: inferredBy_Orthology
## 4: inferredBy_Orthology
##                                                                                                         description
##                                                                                                              <char>
## 1: gene is orthologous to ENSMUSG00000032402 in M. musculus (identity = 100%) which is directly annotated for motif
## 2:  gene is orthologous to ENSMUSG00000000782 in M. musculus (identity = 93%) which is directly annotated for motif
## 3:  gene is orthologous to ENSMUSG00000002996 in M. musculus (identity = 95%) which is directly annotated for motif
## 4:                       motif is annotated for orthologous gene ENSMUSG00000005442 in M. musculus (identity = 92%)
##    keptInRanking
##           <lgcl>
## 1:         FALSE
## 2:         FALSE
## 3:         FALSE
## 4:          TRUE
```

For other versions of the rankings, the function `importAnnotations` allows to import the annotations from the source file.

These annotations can be easily queried to obtain further information about specific motifs or TFs:

```
showLogo(motifAnnotations[(directAnnotation==TRUE) & keptInRanking
                               & (TF %in% c("HIF1A", "HIF2A", "EPAS1")), ])
```

#### Database example (subset)

In addition to the full versions of the databases (~20k motifs), we also provide a subset containing only the 4.6k motifs from cisbp (human only: *RcisTarget.hg19.motifDBs.cisbpOnly.500bp*). These subsets are available in Bioconductor for demonstration purposes. They will provide the same AUC score for the existing motifs. However, we highly recommend to use the full version (~20k motifs) for more accurate results, since the normalized enrichment score (NES) of the motif depends on the total number of motifs in the database.

To install this package:

```
# From Bioconductor
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("RcisTarget.hg19.motifDBs.cisbpOnly.500bp")
```

For this vignette (demonstration purposes), we will use this database:

```
library(RcisTarget.hg19.motifDBs.cisbpOnly.500bp)
# Rankings
data(hg19_500bpUpstream_motifRanking_cispbOnly)
motifRankings <- hg19_500bpUpstream_motifRanking_cispbOnly
motifRankings
```

```
## Rankings for RcisTarget.
##   Organism: human (hg19)
##   Number of genes: 22284 (22285 available in the full DB)
##   Number of MOTIF: 4687
## ** This database includes rankings up to 5050
##
## Subset (4.6k cisbp motifs) of the Human database scoring motifs 500bp upstream the TSS (hg19-500bp-upstream-7species.mc9nr)
```

```
# Annotations
data(hg19_motifAnnotation_cisbpOnly)
motifAnnotations <- hg19_motifAnnotation_cisbpOnly
```

## Running the analysis

Once the gene lists and databases are loaded, they can be used by `cisTarget()`. `cisTarget()` runs sequentially the steps to perform the (**1**) motif enrichment analysis, (**2**) motif-TF annotation, and (**3**) selection of significant genes.

It is also possible to run these steps as individual commands. For example, to skip steps, for analyses in which the user is interested in one of the outputs, or to optimize the workflow to run it on multiple gene lists (see *Advanced* section for details).

```
motifEnrichmentTable_wGenes <- cisTarget(geneLists,
         motifRankings,
         motifAnnot=motifAnnotations)
```

## Advanced: Execute step by step

### 1. Calculate enrichment

The first step to estimate the over-representation of each motif on the gene-set is to calculate the Area Under the Curve (AUC) for each pair of motif-geneSet. This is calculated based on the recovery curve of the gene-set on the motif ranking (genes ranked decreasingly by the score of motif in its proximity, as provided in the motifRanking database).

```
motifs_AUC <- calcAUC(geneLists, motifRankings, nCores=1)
```

The AUC is provided as a matrix of Motifs by GeneSets. In principle, the AUC is mostly meant as input for the next step. However, it is also possible to explore the distribution of the scores, for example in a gene-set of interest:

```
auc <- getAUC(motifs_AUC)["hypoxia",]
hist(auc, main="hypoxia", xlab="AUC histogram",
     breaks=100, col="#ff000050", border="darkred")
nes3 <- (3*sd(auc)) + mean(auc)
abline(v=nes3, col="red")
```

![](data:image/png;base64...)

### 2. Select significant motifs and/or annotate to TFs

The selection of significant motifs is done based on the Normalized Enrichment Score (NES). The NES is calculated -for each motif- based on the AUC distribution of all the motifs for the gene-set [(x-mean)/sd]. Those motifs that pass the given threshold (3.0 by default) are considered significant.

Furthermore, this step also allows to add the TFs annotated to the motif.

```
motifEnrichmentTable <- addMotifAnnotation(motifs_AUC, nesThreshold=3,
     motifAnnot=motifAnnotations,
     highlightTFs=list(hypoxia=c("HIF1A", "EPAS1")))
```

```
class(motifEnrichmentTable)
```

```
## [1] "data.table" "data.frame"
```

```
dim(motifEnrichmentTable)
```

```
## [1] 17  8
```

```
head(motifEnrichmentTable[,-"TF_lowConf", with=FALSE])
```

```
##    geneSet        motif   NES    AUC highlightedTFs TFinDB
##     <char>       <char> <num>  <num>         <char> <char>
## 1: hypoxia cisbp__M6275  4.41 0.0966   HIF1A, EPAS1     **
## 2: hypoxia cisbp__M0062  3.57 0.0841   HIF1A, EPAS1
## 3: hypoxia cisbp__M6279  3.56 0.0840   HIF1A, EPAS1
## 4: hypoxia cisbp__M6212  3.49 0.0829   HIF1A, EPAS1     **
## 5: hypoxia cisbp__M2332  3.48 0.0828   HIF1A, EPAS1
## 6: hypoxia cisbp__M0387  3.41 0.0817   HIF1A, EPAS1
##                   TF_highConf
##                        <char>
## 1: HIF1A (directAnnotation).
## 2:
## 3: HMGA1 (directAnnotation).
## 4: EPAS1 (directAnnotation).
## 5:
## 6:
```

The cathegories considered high/low confidence can me modified with the arguments `motifAnnot_highConfCat` and `motifAnnot_lowConfCat`.

### 3. Identify the genes with the best enrichment for each Motif

Since RcisTarget searches for enrichment of a motif within a gene list, finding a motif ‘enriched’ does not imply that *all* the genes in the gene-list have a high score for the motif. In this way, the third step of the workflow is to identify which genes (of the gene-set) are highly ranked for each of the significant motifs.

There are two methods to identify these genes: (1) equivalent to the ones used in iRegulon and i-cisTarget (`method="iCisTarget"`, recommended if running time is not an issue), and (2) a faster implementation based on an approximate distribution using the average at each rank (`method="aprox"`, useful to scan multiple gene sets).

IMPORTANT: Make sure that the **motifRankings** are the **same as in Step 1**.

```
motifEnrichmentTable_wGenes <- addSignificantGenes(motifEnrichmentTable,
                      rankings=motifRankings,
                      geneSets=geneLists)
dim(motifEnrichmentTable_wGenes)
```

```
## [1] 17 11
```

Plot for a few motifs:

```
geneSetName <- "hypoxia"
selectedMotifs <- c(sample(motifEnrichmentTable$motif, 2))
par(mfrow=c(2,2))
getSignificantGenes(geneLists[[geneSetName]],
                    rankings=motifRankings,
                    signifRankingNames=selectedMotifs,
                    plotCurve=TRUE, maxRank=5000, genesFormat="none",
                    method="aprox")
```

![](data:image/png;base64...)

## Output

The final output of RcisTarget is a `data.table` containing the information about the motif enrichment and its annotation organized in the following fields:

* geneSet: Name of the gene set
* motif: ID of the motif
* NES: Normalized enrichment score of the motif in the gene-set
* AUC: Area Under the Curve (used to calculate the NES)
* TFinDB: Indicates whether the *highlightedTFs* are included within the high confidence annotation (two asterisks) or low confidence annotation (one asterisk).
* TF\_highConf: Transcription factors annotated to the motif according to ‘motifAnnot\_highConfCat’.
* TF\_lowConf: Transcription factors annotated to the motif according to ‘motifAnnot\_lowConfCat’.
* enrichedGenes: Genes that are highly ranked for the given motif.
* nErnGenes: Number of genes highly ranked
* rankAtMax: Ranking at the maximum enrichment, used to determine the number of enriched genes.

```
resultsSubset <- motifEnrichmentTable_wGenes[1:10,]
showLogo(resultsSubset)
```

# Follow up examples

## TFs annotated to the enriched motifs

Note that the TFs are provided based on the motif annotation. They can be used as a guide to select relevant motifs or to prioritize some TFs, but the motif annotation does not imply that all the TFs appearing in the table regulate the gene list.

```
anotatedTfs <- lapply(split(motifEnrichmentTable_wGenes$TF_highConf,
                            motifEnrichmentTable$geneSet),
                      function(x) {
                        genes <- gsub(" \\(.*\\). ", "; ", x, fixed=FALSE)
                        genesSplit <- unique(unlist(strsplit(genes, "; ")))
                        return(genesSplit)
                        })

anotatedTfs$hypoxia
```

```
##  [1] "HIF1A" "HMGA1" "EPAS1" "FOXJ1" "FOXJ2" "FOXJ3" "FOXP1" "FOXP2" "FOXP3"
## [10] "FOXP4" "FOXG1"
```

## Building a network

```
signifMotifNames <- motifEnrichmentTable$motif[1:3]

incidenceMatrix <- getSignificantGenes(geneLists$hypoxia,
                                       motifRankings,
                                       signifRankingNames=signifMotifNames,
                                       plotCurve=TRUE, maxRank=5000,
                                       genesFormat="incidMatrix",
                                       method="aprox")$incidMatrix

library(reshape2)
edges <- melt(incidenceMatrix)
edges <- edges[which(edges[,3]==1),1:2]
colnames(edges) <- c("from","to")
```

*Output not shown:*

```
library(visNetwork)
motifs <- unique(as.character(edges[,1]))
genes <- unique(as.character(edges[,2]))
nodes <- data.frame(id=c(motifs, genes),
      label=c(motifs, genes),
      title=c(motifs, genes), # tooltip
      shape=c(rep("diamond", length(motifs)), rep("elypse", length(genes))),
      color=c(rep("purple", length(motifs)), rep("skyblue", length(genes))))
visNetwork(nodes, edges) %>% visOptions(highlightNearest = TRUE,
                                        nodesIdSelection = TRUE)
```

# sessionInfo()

This is the output of `sessionInfo()` on the system on which this document was compiled:

```
date()
```

```
## [1] "Tue Oct  7 19:36:45 2025"
```

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
## [1] data.table_1.17.8
## [2] DT_0.34.0
## [3] RcisTarget.hg19.motifDBs.cisbpOnly.500bp_1.29.0
## [4] RcisTarget_1.29.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.39.2 KEGGREST_1.49.1
##  [3] xfun_0.53                   bslib_0.9.0
##  [5] htmlwidgets_1.6.4           Biobase_2.69.1
##  [7] lattice_0.22-7              crosstalk_1.2.2
##  [9] vctrs_0.6.5                 tools_4.5.1
## [11] generics_0.1.4              stats4_4.5.1
## [13] tibble_3.3.0                AnnotationDbi_1.71.1
## [15] RSQLite_2.4.3               blob_1.2.4
## [17] pkgconfig_2.0.3             R.oo_1.27.1
## [19] Matrix_1.7-4                S4Vectors_0.47.4
## [21] sparseMatrixStats_1.21.0    assertthat_0.2.1
## [23] graph_1.87.0                lifecycle_1.0.4
## [25] compiler_4.5.1              Biostrings_2.77.2
## [27] codetools_0.2-20            Seqinfo_0.99.2
## [29] GenomeInfoDb_1.45.12        htmltools_0.5.8.1
## [31] sass_0.4.10                 yaml_2.3.10
## [33] pillar_1.11.1               crayon_1.5.3
## [35] jquerylib_0.1.4             R.utils_2.13.0
## [37] DelayedArray_0.35.3         cachem_1.1.0
## [39] abind_1.4-8                 tidyselect_1.2.1
## [41] digest_0.6.37               purrr_1.1.0
## [43] dplyr_1.1.4                 arrow_21.0.0.1
## [45] AUCell_1.31.0               fastmap_1.2.0
## [47] grid_4.5.1                  cli_3.6.5
## [49] SparseArray_1.9.1           magrittr_2.0.4
## [51] S4Arrays_1.9.1              XML_3.99-0.19
## [53] GSEABase_1.71.1             UCSC.utils_1.5.0
## [55] DelayedMatrixStats_1.31.0   bit64_4.6.0-1
## [57] rmarkdown_2.30              XVector_0.49.1
## [59] httr_1.4.7                  matrixStats_1.5.0
## [61] bit_4.6.0                   zoo_1.8-14
## [63] png_0.1-8                   R.methodsS3_1.8.2
## [65] memoise_2.0.1               evaluate_1.0.5
## [67] knitr_1.50                  GenomicRanges_1.61.5
## [69] IRanges_2.43.5              rlang_1.1.6
## [71] Rcpp_1.1.0                  xtable_1.8-4
## [73] glue_1.8.0                  DBI_1.2.3
## [75] BiocGenerics_0.55.1         annotate_1.87.0
## [77] jsonlite_2.0.0              R6_2.6.1
## [79] MatrixGenerics_1.21.0
```