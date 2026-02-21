# Loci2path: regulatory annotation of genomic intervals based on tissue-specific expression QTLs

Tianlei Xu

#### 30 October 2025

#### Abstract

Annotating a given genomic locus or a set of genomic loci is an important yet challenging task. This is especially true for the non-coding part of the genome which is enormous yet poorly understood. Since gene set enrichment analyses have demonstrated to be effective approach to annotate a set of genes, this idea can be extended to explore the enrichment of functional elements or features in a set of genomic intervals to reveal potential functional connections. In this study, we describe a novel computational strategy that takes advantage of the newly emerged, genome-wide and tissue-specific expression quantitative trait loci (eQTL) information to help annotate a set of genomic intervals in terms of transcription regulation. By checking the presence or absence of millions of eQTLs in the set of genomic intervals of interest, loci2path build a bridge connecting genomic intervals to biological pathway or pre-defined biological-meaningful gene sets. Our method enjoys two key advantages over existing methods: first, we no longer rely on proximity to link a locus to a gene which has shown to be unreliable; second, eQTL allows us to provide the regulatory annotation under the context of specific tissue types which is important.

#### Package

loci2path 1.30.0

# Contents

* [1 Prepare input dataset for query](#prepare-input-dataset-for-query)
  + [1.1 Query regions](#query-regions)
  + [1.2 Prepare eQTL sets.](#prepare-eqtl-sets.)
    - [1.2.1 construct eQTL set](#construct-eqtl-set)
    - [1.2.2 construct eQTL set list](#construct-eqtl-set-list)
  + [1.3 Prepare gene set collection](#prepare-gene-set-collection)
* [2 Perform query](#perform-query)
  + [2.1 peroform query from one eQTL set](#peroform-query-from-one-eqtl-set)
  + [2.2 peroform query from multiple eQTL sets](#peroform-query-from-multiple-eqtl-sets)
  + [2.3 parallel query from multiple eQTL sets](#parallel-query-from-multiple-eqtl-sets)
* [3 explore query result](#explore-query-result)
  + [3.1 obtain eQTL gene list](#obtain-eqtl-gene-list)
  + [3.2 obtain average tissue degree for each pathway](#obtain-average-tissue-degree-for-each-pathway)
  + [3.3 obtain tissue enrichment for query regions](#obtain-tissue-enrichment-for-query-regions)
  + [3.4 extract tissue-pathway heatmap](#extract-tissue-pathway-heatmap)
  + [3.5 extract word cloud from result](#extract-word-cloud-from-result)
* [4 Session info](#session-info)
* [References](#references)

# 1 Prepare input dataset for query

## 1.1 Query regions

`loci2path` takes query regions in the format of `GenomicRanges`. Only the
Genomic Locations (chromosomes, start and end position) will be used. Strand
information and other metadata columns are ignored.
In the demo data, 47 regions associated with Psoriasis disease were downloaded
from **immunoBase.org** and used as demo query regions.

```
require(GenomicRanges)
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
bed.file <- system.file("extdata", "query/Psoriasis.BED", package = "loci2path")
query.bed <- read.table(bed.file, header=FALSE)
colnames(query.bed) <- c("chr","start","end")
query.gr <- makeGRangesFromDataFrame(query.bed)
```

## 1.2 Prepare eQTL sets.

eQTL sets are entities recording 1-to-1 links between eQTL SNPs and genes.
eQTL set entity also contains the following information: tissue name for the
eQTL study, IDs and genomic ranges for the eQTL SNPs, IDs for the associated
genes.

eQTL set can be constructed manually by specifying the corresponding
information in each slot.

eQTL set list is a list of multiple eQTL sets, usually collected from
different tissues.

Below is an example to construct customized eQTL set and eQTL set list using
demo data files. In the demo data folder, three eQTL sets downloaded from GTEx
project are included. Due to the large size, each eQTL dataset is down sampled
to 3000 records for demostration purpose.

### 1.2.1 construct eQTL set

```
library(loci2path)
library(GenomicRanges)
brain.file <- system.file("extdata", "eqtl/brain.gtex.txt",
                       package="loci2path")
tab <- read.table(brain.file, stringsAsFactors=FALSE, header=TRUE)
snp.gr <- GRanges(seqnames=Rle(tab$snp.chr),
  ranges=IRanges(start=tab$snp.pos,
  width=1))
brain.eset <- eqtlSet(tissue="brain",
  eqtlId=tab$snp.id,
  eqtlRange=snp.gr,
  gene=as.character(tab$gene.entrez.id))
brain.eset
```

```
## An object of class eqtlSet
##  eQTL collected from tissue: brain
##  number of eQTLs: 3000
##  number of associated genes: 815
```

```
skin.file <- system.file("extdata", "eqtl/skin.gtex.txt", package="loci2path")
tab=read.table(skin.file, stringsAsFactors=FALSE, header=TRUE)
snp.gr <- GRanges(seqnames=Rle(tab$snp.chr),
  ranges=IRanges(start=tab$snp.pos,
  width=1))
skin.eset <- eqtlSet(tissue="skin",
  eqtlId=tab$snp.id,
  eqtlRange=snp.gr,
  gene=as.character(tab$gene.entrez.id))
skin.eset
```

```
## An object of class eqtlSet
##  eQTL collected from tissue: skin
##  number of eQTLs: 3000
##  number of associated genes: 1588
```

```
blood.file <- system.file("extdata", "eqtl/blood.gtex.txt",
                       package="loci2path")
tab <- read.table(blood.file, stringsAsFactors=FALSE, header=TRUE)
snp.gr <- GRanges(seqnames=Rle(tab$snp.chr),
  ranges=IRanges(start=tab$snp.pos,
  width=1))
blood.eset <- eqtlSet(tissue="blood",
  eqtlId=tab$snp.id,
  eqtlRange=snp.gr,
  gene=as.character(tab$gene.entrez.id))
blood.eset
```

```
## An object of class eqtlSet
##  eQTL collected from tissue: blood
##  number of eQTLs: 3000
##  number of associated genes: 1419
```

### 1.2.2 construct eQTL set list

```
eset.list <- list(Brain=brain.eset, Skin=skin.eset, Blood=blood.eset)
eset.list
```

```
## $Brain
## An object of class eqtlSet
##  eQTL collected from tissue: brain
##  number of eQTLs: 3000
##  number of associated genes: 815
##
## $Skin
## An object of class eqtlSet
##  eQTL collected from tissue: skin
##  number of eQTLs: 3000
##  number of associated genes: 1588
##
## $Blood
## An object of class eqtlSet
##  eQTL collected from tissue: blood
##  number of eQTLs: 3000
##  number of associated genes: 1419
```

## 1.3 Prepare gene set collection

A geneset collection contains a list of gene sets, with each gene set is
represented as a vector of member genes. A vector of description is also
provided as the metadata slot for each gene set. The total number of gene in
the geneset collection is also required to perform the enrichment test. In
this tutorial the BIOCARTA pathway collection was downloaded from MSigDB.

```
biocarta.link.file <- system.file("extdata", "geneSet/biocarta.txt",
                               package="loci2path")
biocarta.set.file <- system.file("extdata", "geneSet/biocarta.set.txt",
                              package="loci2path")

biocarta.link <- read.delim(biocarta.link.file, header=FALSE,
                         stringsAsFactors=FALSE)
set.geneid <- read.table(biocarta.set.file, stringsAsFactors=FALSE)
set.geneid <- strsplit(set.geneid[,1], split=",")
names(set.geneid) <- biocarta.link[,1]

head(biocarta.link)
```

```
##                              V1
## 1         BIOCARTA_RELA_PATHWAY
## 2          BIOCARTA_NO1_PATHWAY
## 3          BIOCARTA_CSK_PATHWAY
## 4      BIOCARTA_SRCRPTP_PATHWAY
## 5          BIOCARTA_AMI_PATHWAY
## 6 BIOCARTA_GRANULOCYTES_PATHWAY
##                                                                              V2
## 1         http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_RELA_PATHWAY
## 2          http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_NO1_PATHWAY
## 3          http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_CSK_PATHWAY
## 4      http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_SRCRPTP_PATHWAY
## 5          http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_AMI_PATHWAY
## 6 http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_GRANULOCYTES_PATHWAY
```

```
head(set.geneid)
```

```
## $BIOCARTA_RELA_PATHWAY
##  [1] "8517" "1147" "2033" "5970" "7124" "3551" "7133" "8841" "7132" "7189"
## [11] "8772" "1387" "8737" "4790" "4792" "8717"
##
## $BIOCARTA_NO1_PATHWAY
##  [1] "5140"   "805"    "58"     "124827" "801"    "5577"   "3827"   "6262"
##  [9] "1128"   "7422"   "3320"   "6541"   "5139"   "5138"   "624"    "147908"
## [17] "121916" "4846"   "1134"   "2321"   "3791"   "5567"   "7135"   "5568"
## [25] "2324"   "857"    "207"    "5573"   "5576"   "5575"   "808"    "5592"
## [33] "5593"
##
## $BIOCARTA_CSK_PATHWAY
##  [1] "7535" "1445" "920"  "5577" "5567" "915"  "5568" "916"  "917"  "2778"
## [11] "2792" "6957" "2782" "6955" "5573" "5576" "919"  "1387" "5575" "107"
## [21] "3932" "5788" "3123" "3122"
##
## $BIOCARTA_SRCRPTP_PATHWAY
##  [1] "1445" "6714" "994"  "995"  "5579" "2885" "993"  "5578" "891"  "5786"
## [11] "983"
##
## $BIOCARTA_AMI_PATHWAY
##  [1] "2159"  "7035"  "2147"  "1282"  "2149"  "1284"  "1285"  "1286"  "5627"
## [10] "2266"  "5624"  "2243"  "5340"  "462"   "2244"  "5327"  "1288"  "51327"
## [19] "1287"  "2155"
##
## $BIOCARTA_GRANULOCYTES_PATHWAY
##  [1] "5175" "7124" "3552" "3683" "3684" "3383" "6402" "6403" "3458" "6404"
## [11] "727"  "3689" "1440" "3576"
```

In order to build gene set, we also need to know the total number of genes in
order to perform enrichment test. In this study, the total number of gene in
MSigDB pathway collection is 31,847(Liberzon et al. [2015](#ref-Liberzon2015))

```
#build geneSet
biocarta <- geneSet(
    numGene=31847,
    description=biocarta.link[,2],
    geneSetList=set.geneid)
biocarta
```

```
## An object of class geneSet
##  Number of gene sets: 217
##     6 ~ 87  genes within sets
```

# 2 Perform query

## 2.1 peroform query from one eQTL set

```
#query from one eQTL set.
res.one <- query(
  query.gr=query.gr,
  loci=skin.eset,
  path=biocarta)

#enrichment result table
res.one$result.table
```

```
##                     name_pthw eQTL_pthw eQTL_total_tissue eQTL_query
## V41  BIOCARTA_CLASSIC_PATHWAY        14              3000         78
## V42     BIOCARTA_COMP_PATHWAY        14              3000         78
## V111  BIOCARTA_LECTIN_PATHWAY        14              3000         78
##      eQTL_pthw_query log_ratio pval_lr pval_fisher num_gene_set num_gene_query
## V41                2  1.703749      NA  0.04961954           14             29
## V42                2  1.703749      NA  0.04961954           19             29
## V111               2  1.703749      NA  0.04961954           12             29
##      num_gene_hit gene_hit log_ratio_gene pval_fisher_gene
## V41             1      721       4.362345       0.01267584
## V42             1      721       4.056964       0.01716522
## V111            1      721       4.516496       0.01087455
```

```
#all the genes associated with eQTLs covered by the query region
res.one$cover.gene
```

```
##  [1] "100129271" "353134"    "353144"    "353135"    "130872"    "11127"
##  [7] "64167"     "3106"      "253018"    "285834"    "5460"      "170679"
## [13] "3107"      "100130889" "100507436" "721"       "4277"      "23586"
## [19] "10330"     "283635"    "80270"     "84148"     "29108"     "201229"
## [25] "27175"     "4669"      "11201"     "57153"     "9825"
```

## 2.2 peroform query from multiple eQTL sets

```
#query from one eQTL set.
res.esetlist <- query(
  query.gr=query.gr,
  loci=eset.list,
  path=biocarta)
```

```
## Start query: 3 eqtl Sets...
## 1 of 3: Brain...
## 2 of 3: Skin...
## 3 of 3: Blood...
##
## done!
```

```
#enrichment result table, tissue column added
resultTable(res.esetlist)
```

```
##   tissue                name_pthw eQTL_pthw eQTL_total_tissue eQTL_query
## 1  Blood  BIOCARTA_LECTIN_PATHWAY        24              3000         60
## 2  Blood BIOCARTA_CLASSIC_PATHWAY        24              3000         60
## 3  Blood    BIOCARTA_COMP_PATHWAY        24              3000         60
## 4   Skin  BIOCARTA_LECTIN_PATHWAY        14              3000         78
## 5   Skin BIOCARTA_CLASSIC_PATHWAY        14              3000         78
## 6   Skin    BIOCARTA_COMP_PATHWAY        14              3000         78
## 7  Blood      BIOCARTA_DC_PATHWAY         4              3000         60
## 8  Blood BIOCARTA_CHREBP2_PATHWAY         7              3000         60
##   eQTL_pthw_query log_ratio pval_lr pval_fisher num_gene_set num_gene_query
## 1               2  1.427116      NA  0.08196929           12             29
## 2               2  1.427116      NA  0.08196929           14             29
## 3               2  1.427116      NA  0.08196929           19             29
## 4               2  1.703749      NA  0.04961954           12             29
## 5               2  1.703749      NA  0.04961954           14             29
## 6               2  1.703749      NA  0.04961954           19             29
## 7               1  2.525729      NA  0.07766952           22             29
## 8               1  1.966113      NA  0.13199866           42             29
##   num_gene_hit gene_hit log_ratio_gene pval_fisher_gene
## 1            2  720;721       5.209643     5.254381e-05
## 2            2  720;721       5.055492     7.236494e-05
## 3            2  720;721       4.750111     1.355988e-04
## 4            1      721       4.516496     1.087455e-02
## 5            1      721       4.362345     1.267584e-02
## 6            1      721       4.056964     1.716522e-02
## 7            1     3687       3.910360     1.984938e-02
## 8            1     6945       3.263733     3.756375e-02
```

```
#all the genes associated with eQTLs covered by the query region;
#names of the list are tissue names from eqtl set list
coveredGene(res.esetlist)
```

```
## $Brain
##  [1] "84542"     "130872"    "64167"     "3107"      "100507436" "55012"
##  [7] "116028"    "9810"      "84148"     "27175"     "11201"     "164592"
##
## $Skin
##  [1] "100129271" "353134"    "353144"    "353135"    "130872"    "11127"
##  [7] "64167"     "3106"      "253018"    "285834"    "5460"      "170679"
## [13] "3107"      "100130889" "100507436" "721"       "4277"      "23586"
## [19] "10330"     "283635"    "80270"     "84148"     "29108"     "201229"
## [25] "27175"     "4669"      "11201"     "57153"     "9825"
##
## $Blood
##  [1] "130872"    "6584"      "51752"     "64167"     "100130889" "720"
##  [7] "3106"      "5460"      "3107"      "4277"      "253018"    "100507436"
## [13] "1590"      "721"       "6821"      "6231"      "280655"    "283635"
## [19] "79759"     "80270"     "3687"      "9810"      "3965"      "2548"
## [25] "2145"      "6945"      "10053"     "57153"     "147727"
```

## 2.3 parallel query from multiple eQTL sets

```
#query from one eQTL set.
res.paral <- query(
  query.gr=query.gr,
  loci=eset.list,
  path=biocarta,
  parallel=TRUE)
```

```
## Start query: 3 eqtl Sets...
## Run in parallel mode...
##
## done!
```

```
#should return the same result as res.esetlist
```

# 3 explore query result

```
result <- resultTable(res.esetlist)
```

## 3.1 obtain eQTL gene list

```
#all the genes associated with eQTLs covered by the query region
res.one$cover.gene
```

```
##  [1] "100129271" "353134"    "353144"    "353135"    "130872"    "11127"
##  [7] "64167"     "3106"      "253018"    "285834"    "5460"      "170679"
## [13] "3107"      "100130889" "100507436" "721"       "4277"      "23586"
## [19] "10330"     "283635"    "80270"     "84148"     "29108"     "201229"
## [25] "27175"     "4669"      "11201"     "57153"     "9825"
```

```
#all the genes associated with eQTLs covered by the query region;
#names of the list are tissue names from eqtl set list
coveredGene(res.esetlist)
```

```
## $Brain
##  [1] "84542"     "130872"    "64167"     "3107"      "100507436" "55012"
##  [7] "116028"    "9810"      "84148"     "27175"     "11201"     "164592"
##
## $Skin
##  [1] "100129271" "353134"    "353144"    "353135"    "130872"    "11127"
##  [7] "64167"     "3106"      "253018"    "285834"    "5460"      "170679"
## [13] "3107"      "100130889" "100507436" "721"       "4277"      "23586"
## [19] "10330"     "283635"    "80270"     "84148"     "29108"     "201229"
## [25] "27175"     "4669"      "11201"     "57153"     "9825"
##
## $Blood
##  [1] "130872"    "6584"      "51752"     "64167"     "100130889" "720"
##  [7] "3106"      "5460"      "3107"      "4277"      "253018"    "100507436"
## [13] "1590"      "721"       "6821"      "6231"      "280655"    "283635"
## [19] "79759"     "80270"     "3687"      "9810"      "3965"      "2548"
## [25] "2145"      "6945"      "10053"     "57153"     "147727"
```

## 3.2 obtain average tissue degree for each pathway

```
tissue.degree <- getTissueDegree(res.esetlist, eset.list)

#check gene-tissue mapping for each gene
head(tissue.degree$gene.tissue.map)
```

```
## $`100101267`
## [1] "Brain"
##
## $`100125556`
## [1] "Brain" "Skin"  "Blood"
##
## $`100128081`
## [1] "Brain"
##
## $`100129583`
## [1] "Brain"
##
## $`100130418`
## [1] "Brain" "Skin"
##
## $`100130958`
## [1] "Brain" "Skin"  "Blood"
```

```
#check degree for each gene
head(tissue.degree$gene.tissue.degree)
```

```
## 100101267 100125556 100128081 100129583 100130418 100130958
##         1         3         1         1         2         3
```

```
#average tissue degree for the input result table
tissue.degree$mean.tissue.degree
```

```
## [1] 2 2 2 2 2 2 1 1
```

```
#add avg. tissue degree to existing result table
res.tissue <- data.frame(resultTable(res.esetlist),
                      t.degree=tissue.degree$mean.tissue.degree)
```

## 3.3 obtain tissue enrichment for query regions

In this case, in the generic function , only the argunment
need to be provided. This will trigger the query of tissue
specificity

```
#query tissue specificity
gr.tissue <- query(query.gr, loci=eset.list)
gr.tissue
```

```
##       eQTL_gene_in_tissue eQTL_gene_in_query         pval         padj
## Blood                1419                 29 8.922769e-14 2.676831e-13
## Skin                 1588                 29 1.432947e-12 2.865894e-12
## Brain                 815                 12 1.653003e-05 1.653003e-05
```

## 3.4 extract tissue-pathway heatmap

```
#extract tissue-pathway matrix
mat <- getMat(res.esetlist, test.method="gene")

#plot heatmap
heatmap.para <- getHeatmap(res.esetlist)
```

![](data:image/png;base64...)

## 3.5 extract word cloud from result

```
#plot word cloud
wc <- getWordcloud(res.esetlist)
```

![](data:image/png;base64...)

##plot p-value distribution of result

```
#plot p-value distribution of result
pval <- getPval(res.esetlist, test.method="gene")
```

![](data:image/png;base64...)

##obtain geneset description from object

```
#obtain geneset description from object
description <- getPathDescription(res.esetlist, biocarta)
head(description)
```

```
## [1] "http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_LECTIN_PATHWAY"
## [2] "http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_CLASSIC_PATHWAY"
## [3] "http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_COMP_PATHWAY"
## [4] "http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_LECTIN_PATHWAY"
## [5] "http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_CLASSIC_PATHWAY"
## [6] "http://www.broadinstitute.org/gsea/msigdb/cards/BIOCARTA_COMP_PATHWAY"
```

# 4 Session info

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
## [1] loci2path_1.30.0     GenomicRanges_1.62.0 Seqinfo_1.0.0
## [4] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
## [7] generics_0.1.4       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 tinytex_0.57        Rcpp_1.1.0
##  [7] magick_2.9.0        parallel_4.5.1      dichromat_2.0-0.1
## [10] jquerylib_0.1.4     scales_1.4.0        BiocParallel_1.44.0
## [13] yaml_2.3.10         fastmap_1.2.0       R6_2.6.1
## [16] knitr_1.50          bookdown_0.45       bslib_0.9.0
## [19] RColorBrewer_1.1-3  rlang_1.1.6         wordcloud_2.6
## [22] cachem_1.1.0        xfun_0.53           sass_0.4.10
## [25] cli_3.6.5           magrittr_2.0.4      digest_0.6.37
## [28] grid_4.5.1          lifecycle_1.0.4     pheatmap_1.0.13
## [31] evaluate_1.0.5      glue_1.8.0          data.table_1.17.8
## [34] farver_2.1.2        codetools_0.2-20    rmarkdown_2.30
## [37] tools_4.5.1         htmltools_0.5.8.1
```

# References

Liberzon, Arthur, Chet Birger, Helga Thorvaldsd??ttir, Mahmoud Ghandi, Jill P. Mesirov, and Pablo Tamayo. 2015. “The Molecular Signatures Database Hallmark Gene Set Collection.” *Cell Systems* 1 (6): 417–25. <https://doi.org/10.1016/j.cels.2015.12.004>.