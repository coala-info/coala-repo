# Applying mitch to pathway analysis of Infinium Methylation array data

#### Antony Kaspi & Mark Ziemann

#### 2026-01-08

* [Background](#background)
* [Requirements](#requirements)
* [Gene sets](#gene-sets)
* [Probe gene relationship for HM450K array data](#probe-gene-relationship-for-hm450k-array-data)
* [Update deprecated gene symbols](#update-deprecated-gene-symbols)
* [Importing profiling data](#importing-profiling-data)
* [Calculating enrichment](#calculating-enrichment)
* [Downstream presentation](#downstream-presentation)
* [Probe gene relationship for EPIC array data](#probe-gene-relationship-for-epic-array-data)
* [Session Info](#session-info)

## Background

Applying enrichment analysis to methylation array data is difficult due to the presence of a variable number of probes per gene and the fact that a probe could belong to overlapping genes. There are existing over-representation based approaches to this, however they appear to lack sensitivity. To address this, we have developed a simple approach to aggregating differential methylation data to make it suitable for downstream use by mitch. The process begins with the differential probe methylation results from limma. Here, we summarise the limma t-statistics by gene using the arithmetic mean. The resulting gene level differential methylation scores then undergo mitch as usual.

## Requirements

In addition to mitch v1.15.0 of higher, you will need an annotation set for the array you are using. These are conveniently provided as Bioconductor packages for HM450K and EPIC arrays.

HM450k: IlluminaHumanMethylation450kanno.ilmn12.hg19

EPIC: IlluminaHumanMethylationEPICanno.ilm10b4.hg19

One issue with these is that the annotations are quite old, which means that some of the gene names have changed (~12%), so it is a good idea to screen the list of gene names and update obsolete names using the HGNChelper package.

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mitch")
```

```
suppressPackageStartupMessages({
    library("mitch")
    library("dplyr")
    library("HGNChelper")
    library("IlluminaHumanMethylation450kanno.ilmn12.hg19")
    library("IlluminaHumanMethylationEPICanno.ilm10b4.hg19")
})
```

## Gene sets

In this cut down example we will be using a sample of 200 Reactome gene sets.

```
data(genesetsExample)
head(genesetsExample,3)
```

```
## $`2-LTR circle formation`
##  [1] "Reactome Pathway" "BANF1"            "HMGA1"            "LIG4"
##  [5] "PSIP1"            "XRCC4"            "XRCC5"            "XRCC6"
##  [9] "gag"              "gag-pol"          "rev"              "vif"
## [13] "vpr"              "vpu"
##
## $`5-Phosphoribose 1-diphosphate biosynthesis`
## [1] "Reactome Pathway" "PRPS1"            "PRPS1L1"          "PRPS2"
##
## $`A tetrasaccharide linker sequence is required for GAG synthesis`
##  [1] "Reactome Pathway" "AGRN"             "B3GALT6"          "B3GAT1"
##  [5] "B3GAT2"           "B3GAT3"           "B4GALT7"          "BCAN"
##  [9] "BGN"              "CSPG4"            "CSPG5"            "DCN"
## [13] "GPC1"             "GPC2"             "GPC3"             "GPC4"
## [17] "GPC5"             "GPC6"             "HSPG2"            "NCAN"
## [21] "SDC1"             "SDC2"             "SDC3"             "SDC4"
## [25] "VCAN"             "XYLT1"            "XYLT2"
```

## Probe gene relationship for HM450K array data

In order to get mitch working, we need a 2 column table that maps probes to genes. The workflow shown here is for the HM450k array, and an EPIC example is show at the end of the report.

```
anno <- getAnnotation(IlluminaHumanMethylation450kanno.ilmn12.hg19)
myann <- data.frame(anno[,c("UCSC_RefGene_Name","UCSC_RefGene_Group","Islands_Name","Relation_to_Island")])
head(myann)
```

```
##            UCSC_RefGene_Name   UCSC_RefGene_Group           Islands_Name
## cg00050873    TSPY4;FAM197Y2         Body;TSS1500   chrY:9363680-9363943
## cg00212031            TTTY14               TSS200 chrY:21238448-21240005
## cg00213748                                          chrY:8147877-8148210
## cg00214611     TMSB4Y;TMSB4Y        1stExon;5'UTR chrY:15815488-15815779
## cg00455876                                          chrY:9385471-9385777
## cg01707559 TBL1Y;TBL1Y;TBL1Y TSS200;TSS200;TSS200   chrY:6778574-6780028
##            Relation_to_Island
## cg00050873            N_Shore
## cg00212031             Island
## cg00213748            S_Shore
## cg00214611             Island
## cg00455876             Island
## cg01707559             Island
```

```
gp <- myann[,"UCSC_RefGene_Name",drop=FALSE]
gp2 <- strsplit(gp$UCSC_RefGene_Name,";")
names(gp2) <- rownames(gp)
gp2 <- lapply(gp2,unique)
gt1 <- stack(gp2)
colnames(gt1) <- c("gene","probe")
gt1$probe <- as.character(gt1$probe)
dim(gt1)
```

```
## [1] 407090      2
```

```
head(gt1)
```

```
##       gene      probe
## 1    TSPY4 cg00050873
## 2 FAM197Y2 cg00050873
## 3   TTTY14 cg00212031
## 4   TMSB4Y cg00214611
## 5    TBL1Y cg01707559
## 6   TMSB4Y cg02004872
```

## Update deprecated gene symbols

Update old gene symbols using HGNChelper (13% of 21k names). Last updated 4th Sep 2024.

```
#new.hgnc.table <- getCurrentHumanMap()
new.hgnc.table <- readRDS("../inst/extdata/new.hgnc.table.rds")
fix <- checkGeneSymbols(gt1$gene,map=new.hgnc.table)
```

```
## Warning in checkGeneSymbols(gt1$gene, map = new.hgnc.table): Human gene symbols
## should be all upper-case except for the 'orf' in open reading frames. The case
## of some letters was corrected.
```

```
## Warning in checkGeneSymbols(gt1$gene, map = new.hgnc.table): x contains
## non-approved gene symbols
```

```
fix2 <- fix[which(fix$x != fix$Suggested.Symbol),]
length(unique(fix2$x))
```

```
## [1] 2793
```

```
gt1$gene <- fix$Suggested.Symbol
head(gt1)
```

```
##       gene      probe
## 1    TSPY4 cg00050873
## 2 FAM197Y2 cg00050873
## 3   TTTY14 cg00212031
## 4   TMSB4Y cg00214611
## 5    TBL1Y cg01707559
## 6   TMSB4Y cg02004872
```

## Importing profiling data

Here we will read in a table of differential probe methylation data generated by limma. We will use the t-statistics for downstream analysis.

```
x <- read.table("https://ziemann-lab.net/public/gmea/dma3a.tsv",header=TRUE,row.names=1)
head(x)
```

```
##                 logFC   AveExpr         t      P.Value adj.P.Val        B
## cg04905210 -0.2926788 -2.812451 -5.380966 2.372336e-07 0.1002013 5.906039
## cg09338148 -0.2938597 -1.155475 -5.114443 8.261969e-07 0.1744820 4.880538
## cg04247967 -0.2070451  3.180593 -4.986000 1.484616e-06 0.2090211 4.399278
## cg06458106 -0.1906572  1.675741 -4.793141 3.511038e-06 0.2413324 3.693145
## cg26425904 -0.2540917 -4.019515 -4.761482 4.034832e-06 0.2413324 3.579161
## cg19590707 -0.2471850 -1.237702 -4.716409 4.912691e-06 0.2413324 3.417844
```

Now that the profiling data is loaded, we need to import with mitch package, which establishes the probe-gene relationships and aggregates the data to gene level scores. As you can see, the input was a table of 422k probes and the output is 19,380 gene scores. Many probes not annotated to genes are discarded.

```
y <- mitch_import(x,DEtype="limma",geneTable=gt1)
```

```
## The input is a single dataframe; one contrast only. Converting
##         it to a list for you.
```

```
## Note: Mean no. genes in input = 422374
```

```
## Note: no. genes in output = 19380
```

```
## Warning in mitch_import(x, DEtype = "limma", geneTable = gt1): Warning: less than half of the input genes are also in the
##         output
```

```
head(y)
```

```
##                   x
## A1BG     -0.3505339
## A1BG-AS1 -0.1904379
## A1CF     -0.8443613
## A2M      -0.6794687
## A2ML1     0.2157592
## A4GALT   -0.4001430
```

```
dim(y)
```

```
## [1] 19380     1
```

## Calculating enrichment

The `mitch_calc` function performs an enrichment test. If you imported multiple data tables in the previous step, mitch will conduct a multivariate enrichment test. The results can be prioritised by significance or effect size. My recommendation is to discard results with FDR>0.05 then prioritise by effect size, which for us is the mitch enrichment score called S distance. In this example I also set the minimum gene set size to 5.

```
res<-mitch_calc(y,genesetsExample,priority="effect",cores=2,minsetsize=5)
```

```
## Note: Enrichments with large effect sizes may not be
##             statistically significant.
```

```
head(res$enrichment_result,10)
```

```
##                                                 set setSize       pANOVA
## 113   Apoptotic cleavage of cell adhesion  proteins      11 6.207579e-04
## 1                            2-LTR circle formation       7 4.362176e-02
## 33     Acetylcholine Neurotransmitter Release Cycle      17 1.672291e-03
## 52                          Activation of C3 and C5       6 6.479358e-02
## 155                        Bicarbonate transporters      10 2.806954e-02
## 68                                Activation of SMO      18 4.483409e-03
## 88             Adenylate cyclase inhibitory pathway      14 1.240799e-02
## 87             Adenylate cyclase activating pathway      10 3.530185e-02
## 80             Acyl chain remodeling of DAG and TAG       5 1.416075e-01
## 134 Autodegradation of the E3 ubiquitin ligase COP1      50 4.346153e-06
##         s.dist p.adjustANOVA
## 113 -0.5958772  4.947074e-03
## 1    0.4403846  1.541302e-01
## 33  -0.4402727  1.063577e-02
## 52   0.4353429  2.102485e-01
## 155 -0.4010945  1.117618e-01
## 68  -0.3869091  2.545936e-02
## 88  -0.3859415  5.636774e-02
## 87  -0.3843986  1.277451e-01
## 80  -0.3795716  3.482414e-01
## 134  0.3755137  7.678203e-05
```

## Downstream presentation

For presentation of the results you could consider making a volcano plot and/or making a barplot of S.dist values for selected gene sets that meet the FDR cutoff. You can also use the built in functions to make a set of charts and html report. It is vitally important to inspect the detailed resports to understand which genes are driving the enrichment in your dataset.

```
mitch_plots(res,outfile="methcharts.pdf")
```

```
## png
##   2
```

```
mitch_report(res,"methreport.html")
```

```
## Dataset saved as " /tmp/RtmpakUw8j/methreport.rds ".
```

```
## processing file: mitch.Rmd
```

```
## output file: /tmp/RtmpHUMx7F/Rbuild12b3a21274add1/mitch/vignettes/mitch.knit.md
```

```
##
## Output created: /tmp/RtmpakUw8j/mitch_report.html
```

We have a `networkplot()` function that produces two network plots, one for increased methylation (nodes shaded red), and one for decreased methylation (nodes shaded blue). See `?networkplot()` for more details.

Lists of enriched gene set members are shown.

```
networkplot(res,FDR=0.1,n_sets=10)
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
network_genes(res,FDR=1,n_sets=10)
```

```
## [[1]]
## [[1]]$`UP genesets.2-LTR circle formation`
## character(0)
##
## [[1]]$`UP genesets.APC/C:Cdc20 mediated degradation of Securin`
## character(0)
##
## [[1]]$`UP genesets.APC/C:Cdc20 mediated degradation of mitotic proteins`
## character(0)
##
## [[1]]$`UP genesets.Activation of C3 and C5`
## character(0)
##
## [[1]]$`UP genesets.Activation of the mRNA upon binding of the cap-binding complex and eIFs, and subsequent binding to 43S`
## character(0)
##
## [[1]]$`UP genesets.Assembly of the ORC complex at the origin of replication`
## character(0)
##
## [[1]]$`UP genesets.Autodegradation of Cdh1 by Cdh1:APC/C`
## character(0)
##
## [[1]]$`UP genesets.Autodegradation of the E3 ubiquitin ligase COP1`
## character(0)
##
## [[1]]$`UP genesets.Beta defensins`
## character(0)
##
## [[1]]$`UP genesets.Beta oxidation of hexanoyl-CoA to butanoyl-CoA`
## character(0)
##
## [[1]]$`DOWN genesets.Acetylcholine Neurotransmitter Release Cycle`
##  [1] "CHAT"    "CPLX1"   "PPFIA1"  "PPFIA2"  "PPFIA3"  "PPFIA4"  "RAB3A"
##  [8] "RIMS1"   "SLC18A3" "SLC5A7"  "SNAP25"  "STX1A"   "STXBP1"  "SYT1"
## [15] "TSPOAP1" "UNC13B"  "VAMP2"
##
## [[1]]$`DOWN genesets.Activated NTRK2 signals through FYN`
## [1] "BDNF"   "DOCK3"  "FYN"    "GRIN2B" "NTRK2"  "RAC1"   "SRC"
##
## [[1]]$`DOWN genesets.Activation of SMO`
##  [1] "ARRB1"   "ARRB2"   "BOC"     "CDON"    "CSNK1A1" "DHH"     "EFCAB7"
##  [8] "EVC"     "EVC2"    "GAS1"    "GAS8"    "GRK2"    "IHH"     "IQCE"
## [15] "KIF3A"   "PTCH1"   "SHH"     "SMO"
##
## [[1]]$`DOWN genesets.Acyl chain remodeling of DAG and TAG`
## [1] "DGAT1"  "DGAT2"  "MGLL"   "PNPLA2" "PNPLA3"
##
## [[1]]$`DOWN genesets.Adenylate cyclase activating pathway`
##  [1] "ADCY1" "ADCY2" "ADCY3" "ADCY4" "ADCY5" "ADCY6" "ADCY7" "ADCY8" "ADCY9"
## [10] "GNAL"
##
## [[1]]$`DOWN genesets.Adenylate cyclase inhibitory pathway`
##  [1] "ADCY1" "ADCY2" "ADCY3" "ADCY4" "ADCY5" "ADCY6" "ADCY7" "ADCY8" "ADCY9"
## [10] "GNAI1" "GNAI2" "GNAI3" "GNAL"  "GNAT3"
##
## [[1]]$`DOWN genesets.Adherens junctions interactions`
##  [1] "AFDN"    "ANG"     "CADM1"   "CADM2"   "CADM3"   "CDH1"    "CDH10"
##  [8] "CDH11"   "CDH12"   "CDH13"   "CDH15"   "CDH17"   "CDH18"   "CDH2"
## [15] "CDH24"   "CDH3"    "CDH4"    "CDH5"    "CDH6"    "CDH7"    "CDH8"
## [22] "CDH9"    "CTNNA1"  "CTNNB1"  "CTNND1"  "JUP"     "NECTIN1" "NECTIN2"
## [29] "NECTIN3" "NECTIN4" "PVR"
##
## [[1]]$`DOWN genesets.Amine ligand-binding receptors`
##  [1] "ADRA1A" "ADRA1B" "ADRA1D" "ADRA2A" "ADRA2B" "ADRA2C" "ADRB1"  "ADRB2"
##  [9] "ADRB3"  "CHRM1"  "CHRM2"  "CHRM3"  "CHRM4"  "CHRM5"  "DRD1"   "DRD2"
## [17] "DRD3"   "DRD4"   "DRD5"   "HRH1"   "HRH2"   "HRH3"   "HRH4"   "HTR1A"
## [25] "HTR1B"  "HTR1D"  "HTR1E"  "HTR1F"  "HTR2A"  "HTR2B"  "HTR4"   "HTR5A"
## [33] "HTR6"   "HTR7"   "TAAR1"  "TAAR2"  "TAAR5"  "TAAR6"  "TAAR8"  "TAAR9"
##
## [[1]]$`DOWN genesets.Apoptotic cleavage of cell adhesion  proteins`
##  [1] "CASP3"  "CDH1"   "CTNNB1" "DSG1"   "DSG2"   "DSG3"   "DSP"    "OCLN"
##  [9] "PKP1"   "TJP1"   "TJP2"
##
## [[1]]$`DOWN genesets.Bicarbonate transporters`
##  [1] "AHCYL2"  "SLC4A1"  "SLC4A10" "SLC4A2"  "SLC4A3"  "SLC4A4"  "SLC4A5"
##  [8] "SLC4A7"  "SLC4A8"  "SLC4A9"
```

## Probe gene relationship for EPIC array data

Here is the code to create a probe-gene table for EPIC array data. Be sure to update the gene symbols with `HGNChelper` before conducting enrichment analysis.

```
anno <- getAnnotation(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)
myann <- data.frame(anno[,c("UCSC_RefGene_Name","UCSC_RefGene_Group","Islands_Name","Relation_to_Island")])
gp <- myann[,"UCSC_RefGene_Name",drop=FALSE]
gp2 <- strsplit(gp$UCSC_RefGene_Name,";")
names(gp2) <- rownames(gp)
gp2 <- lapply(gp2,unique)
gt <- stack(gp2)
colnames(gt) <- c("gene","probe")
gt$probe <- as.character(gt$probe)
dim(gt)
```

```
## [1] 684970      2
```

```
str(gt)
```

```
## 'data.frame':    684970 obs. of  2 variables:
##  $ gene : chr  "YTHDF1" "EIF2S3" "PKN3" "CCDC57" ...
##  $ probe: chr  "cg18478105" "cg09835024" "cg14361672" "cg01763666" ...
```

## Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] gtools_3.9.5
##  [2] IlluminaHumanMethylationEPICanno.ilm10b4.hg19_0.6.0
##  [3] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
##  [4] minfi_1.56.0
##  [5] bumphunter_1.52.0
##  [6] locfit_1.5-9.12
##  [7] iterators_1.0.14
##  [8] foreach_1.5.2
##  [9] Biostrings_2.78.0
## [10] XVector_0.50.0
## [11] SummarizedExperiment_1.40.0
## [12] Biobase_2.70.0
## [13] MatrixGenerics_1.22.0
## [14] matrixStats_1.5.0
## [15] GenomicRanges_1.62.1
## [16] Seqinfo_1.0.0
## [17] IRanges_2.44.0
## [18] S4Vectors_0.48.0
## [19] BiocGenerics_0.56.0
## [20] generics_0.1.4
## [21] HGNChelper_0.8.15
## [22] dplyr_1.1.4
## [23] mitch_1.22.1
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.2             later_1.4.5
##   [3] BiocIO_1.20.0             bitops_1.0-9
##   [5] tibble_3.3.0              preprocessCore_1.72.0
##   [7] XML_3.99-0.20             lifecycle_1.0.5
##   [9] lattice_0.22-7            MASS_7.3-65
##  [11] base64_2.0.2              scrime_1.3.5
##  [13] magrittr_2.0.4            limma_3.66.0
##  [15] sass_0.4.10               rmarkdown_2.30
##  [17] jquerylib_0.1.4           yaml_2.3.12
##  [19] httpuv_1.6.16             otel_0.2.0
##  [21] doRNG_1.8.6.2             askpass_1.2.1
##  [23] DBI_1.2.3                 RColorBrewer_1.1-3
##  [25] abind_1.4-8               quadprog_1.5-8
##  [27] purrr_1.2.0               RCurl_1.98-1.17
##  [29] rentrez_1.2.4             genefilter_1.92.0
##  [31] annotate_1.88.0           svglite_2.2.2
##  [33] DelayedMatrixStats_1.32.0 codetools_0.2-20
##  [35] DelayedArray_0.36.0       xml2_1.5.1
##  [37] tidyselect_1.2.1          farver_2.1.2
##  [39] beanplot_1.3.1            illuminaio_0.52.0
##  [41] GenomicAlignments_1.46.0  jsonlite_2.0.0
##  [43] multtest_2.66.0           survival_3.8-3
##  [45] systemfonts_1.3.1         tools_4.5.2
##  [47] Rcpp_1.1.0                glue_1.8.0
##  [49] gridExtra_2.3             SparseArray_1.10.8
##  [51] xfun_0.55                 HDF5Array_1.38.0
##  [53] withr_3.0.2               fastmap_1.2.0
##  [55] GGally_2.4.0              rhdf5filters_1.22.0
##  [57] openssl_2.3.4             caTools_1.18.3
##  [59] digest_0.6.39             R6_2.6.1
##  [61] mime_0.13                 textshaping_1.0.4
##  [63] dichromat_2.0-0.1         RSQLite_2.4.5
##  [65] cigarillo_1.0.0           h5mread_1.2.1
##  [67] tidyr_1.3.2               data.table_1.18.0
##  [69] rtracklayer_1.70.1        httr_1.4.7
##  [71] htmlwidgets_1.6.4         S4Arrays_1.10.1
##  [73] ggstats_0.12.0            pkgconfig_2.0.3
##  [75] gtable_0.3.6              blob_1.2.4
##  [77] S7_0.2.1                  siggenes_1.84.0
##  [79] htmltools_0.5.9           echarts4r_0.4.6
##  [81] scales_1.4.0              kableExtra_1.4.0
##  [83] png_0.1-8                 knitr_1.51
##  [85] rstudioapi_0.17.1         tzdb_0.5.0
##  [87] reshape2_1.4.5            rjson_0.2.23
##  [89] coda_0.19-4.1             statnet.common_4.13.0
##  [91] nlme_3.1-168              curl_7.0.0
##  [93] cachem_1.1.0              rhdf5_2.54.1
##  [95] stringr_1.6.0             KernSmooth_2.23-26
##  [97] AnnotationDbi_1.72.0      restfulr_0.0.16
##  [99] GEOquery_2.78.0           pillar_1.11.1
## [101] grid_4.5.2                reshape_0.8.10
## [103] vctrs_0.6.5               gplots_3.3.0
## [105] promises_1.5.0            xtable_1.8-4
## [107] beeswarm_0.4.0            evaluate_1.0.5
## [109] readr_2.1.6               GenomicFeatures_1.62.0
## [111] cli_3.6.5                 compiler_4.5.2
## [113] Rsamtools_2.26.0          rlang_1.1.6
## [115] crayon_1.5.3              rngtools_1.5.2
## [117] nor1mix_1.3-3             mclust_6.1.2
## [119] plyr_1.8.9                stringi_1.8.7
## [121] viridisLite_0.4.2         network_1.19.0
## [123] BiocParallel_1.44.0       Matrix_1.7-4
## [125] hms_1.1.4                 sparseMatrixStats_1.22.0
## [127] bit64_4.6.0-1             ggplot2_4.0.1
## [129] Rhdf5lib_1.32.0           KEGGREST_1.50.0
## [131] statmod_1.5.1             shiny_1.12.1
## [133] memoise_2.0.1             bslib_0.9.0
## [135] bit_4.6.0                 splitstackshape_1.4.8
```