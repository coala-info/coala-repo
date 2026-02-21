# GeneNetworkBuilder Guide

Jianhong Ou, Lihua Julie Zhu

#### 30 October 2025

#### Abstract

Appliation for discovering direct or indirect targets of
transcription factors using ChIP-chip or ChIP-seq, and
microarray or RNA-seq gene expression data. Inputting a list of
genes of potential targets of one TF from ChIP-chip or
ChIP-seq, and the gene expression results, GeneNetworkBuilder
generates a regulatory network of the TF.

#### Package

GeneNetworkBuilder 1.52.0

# Contents

* [1 Introduction](#introduction)
* [2 Examples of using GeneNetworkBuilder](#examples-of-using-genenetworkbuilder)
* [3 Quick start](#quick-start)
* [4 Example using gene expression profile](#example-using-gene-expression-profile)
* [5 Example using both gene and miRNA expression profile](#example-using-both-gene-and-mirna-expression-profile)
* [6 Session Info](#session-info)
* [References](#references)

# 1 Introduction

Transcription factors (TFs), chromatin modifications and microRNAs (miRNAs) are
important in regulating gene expression[1](#ref-Walhout2010).
Chromatin immunoprecipitation (ChIP) followed by
high-throughput sequencing (ChIP-seq)[2](#ref-Peter2009) or genome tiling
array analysis (ChIP-chip)[3](#ref-Tae2006) are widely used
technologies for identifying genome-wide binding sites of TFs (TFBDs)[4](#ref-Kerstin2010).
The role of the TF on genome-wide gene expression can be
determined by expression microarray or RNA-seq experiments[5](#ref-Zhong2009). By combining
both technologies, researchers have the potential to decipher the regulatory
network of the TF. Genes bound by the TF and altered in expression are
considered direct targets of the TF, and genes altered in expression but not
bound by the TF are the indirect targets of the TF. The indirect targets can
potentially form a complex network itself, especially when the TF is a
master regulator who regulates other TFs. To facilitate identification of
the complex regulatory network of TFs and how indirect targets are
inter-connected, we have developed GeneNetworkBuilder (GNB). Each genereated
network is consisted of a directed acyclic graph with each edge representing
TF -> gene, TF -> miRNA, or miRNA -> gene where a -> b represents “a
regulates b”.

# 2 Examples of using GeneNetworkBuilder

To use GNB, users need to input a list of genes bound by a given
TF and another list of genes/miRNAs with altered expression by knockdown/knockout of the
same TF. The bound gene list could be obtained from ChIP-seq or ChIP-chip
experiment. The gene list with altered expression are from RNA-seq or
expression microarray experiment. ChIP experiments and expression
experiments should preferably be performed in similar experimental condition
such as tissue type, development stage etc. In addition, users need to
select a TF regulatory network from GNB or upload customized TF regulatory
network.

GNB provides two embedded regulatory networks. One is designed for *Caenorhabditis elegans*
combining database EDGEdb[6](#ref-Barrasa2007) and microCosm Targets[7](#ref-Sam2008). Database
MicroCosm Targets contains computationally predicted targets for miRNAs
across many species. EDGEdb contains experimentally determined interactions
of ~934 worm TFs by high-throughput yeast on-hybrid (Y1H) assay. And the
other embedded regulatory network is designed for *Homo sapiens* combining database FANTOM[8](#ref-Ravasi2010),
miRGen[9](#ref-Panagiotis2010) and microCosm Targets[7](#ref-Sam2008). FANTOM stores physical
interactions among the majority of human/mouse DNA-binding TFs. The miRGen
is an integrated database of miRNA regulation by TFs and miRNA targets mainly for human.

Figure 1 depicts the relationships of various databases and
its role in GNB.

![](data:image/png;base64...)

Workflow of GeneNetworkBuilder

# 3 Quick start

Here is an example to use GNB to generate a simple regulatory network for *C. elegans*.
There are three steps,
1. buildNetwork, build the network by GNB-embedded or user-defined regulatory network
starting from the bound gene list.
2. filterNetwork, filter the network by differential expressed genes/miRNAs.
3. polishNetwork, generate the graphNEL object with display style.

```
library(GeneNetworkBuilder)
##load C. elegans miRNA ID lists
data("ce.miRNA.map")
##load GNB-embedded regulatory network of C. elegans.
data("ce.interactionmap")
##load data required
data("example.data")
##build the network by binding list and interaction map
sifNetwork<-buildNetwork(TFbindingTable=example.data$ce.bind,
                        interactionmap=ce.interactionmap, level=2)
##filter the network by expression data
cifNetwork<-filterNetwork(rootgene="WBGene00000912", sifNetwork=sifNetwork,
                    exprsData=uniqueExprsData(example.data$ce.exprData),
                    mergeBy="symbols",
                    miRNAlist=as.character(ce.miRNA.map[ , 1]),
                    remove_miRNA=FALSE, tolerance=1)
##generate graphNEL object for the network
gR<-polishNetwork(cifNetwork=cifNetwork,
                  nodecolor=colorRampPalette(c("green",
                                               "yellow",
                                               "red"))(5))
##show network
(html <- browseNetwork(gR))
```

```
##save network
exportNetwork(html, tempfile(fileext = ".network.html"))
```

# 4 Example using gene expression profile

Here is an example to use GNB to generate a simple regulatory network for
*C. elegans*. And also show some examples how to use the `graphNEL` object
for further analysis.

```
library(GeneNetworkBuilder)
data("example.data")
##Initialize a binding matrix by TF and the related gene lists of TFBDs.
##For example, TF is daf-16, and the ChIP-chip result indicates that it can bind to
##upstream regions of gene "zip-2", "zip-4", "nhr-3" and "nhr-66".
bind<-cbind(from="daf-16", to=c("zip-2", "zip-4", "nhr-3", "nhr-66"))
##For same gene, there are multple gene alias. In order to eliminate the possibility of
##missing any interactions, convert the gene symbols to unique gene ids is important.
data("ce.IDsMap")
bind<-convertID(toupper(bind), IDsMap=ce.IDsMap, ByName=c("from", "to"))
##build the network by binding list and interaction map
data("ce.interactionmap")
sifNetwork<-buildNetwork(TFbindingTable=example.data$ce.bind,
                        interactionmap=ce.interactionmap, level=2)
##filter the network by expression data
##For each gene id, it should have only single record for expression change.
unique.ce.microarrayData<-uniqueExprsData(example.data$ce.exprData,
                        method="Max", condenseName='logFC')
data("ce.miRNA.map")
cifNetwork<-filterNetwork(rootgene="WBGene00000912", sifNetwork=sifNetwork,
                    exprsData=unique.ce.microarrayData, mergeBy="symbols",
                    miRNAlist=as.character(ce.miRNA.map[ , 1]),
                    tolerance=1, cutoffPVal=0.01, cutoffLFC=1)
##convert the unique gene ids back to gene symbols
data("ce.mapIDs")
cifNetwork<-convertID(cifNetwork, ce.mapIDs, ByName=c("from","to"))
##generate graphNEL object for the network
gR<-polishNetwork(cifNetwork, nodecolor=colorRampPalette(c("green", "yellow", "red"))(10))
##plot the figure
browseNetwork(gR)
```

```
## or plot by Rgraphviz
library(Rgraphviz)
plotNetwork<-function(gR, layouttype="dot", ...){
    if(!is(gR,"graphNEL")) stop("gR must be a graphNEL object")
    if(!(GeneNetworkBuilder:::inList(layouttype, c("dot", "neato", "twopi", "circo", "fdp")))){
        stop("layouttype must be dot, neato, twopi, circo or fdp")
    }
    g1<-Rgraphviz::layoutGraph(gR, layoutType=layouttype, ...)
    nodeRenderInfo(g1)$col <- nodeRenderInfo(gR)$col
    nodeRenderInfo(g1)$fill <- nodeRenderInfo(gR)$fill
    renderGraph(g1)
}
plotNetwork(gR)
```

![](data:image/png;base64...)

```
##output file for cytoscape
exportNetwork(browseNetwork(gR),
              file=tempfile(fileext = ".network.xgmml"),
              format = "XGMML")
##output the GXL file
library("XML")
xml<-saveXML(toGXL(gR)$value())
z<-textConnection(xml)
cat(readLines(z, 8), sep="\n")
```

```
## <?xml version="1.0"?>
## <gxl:gxl xmlns:gxl="http://www.gupro.de/GXL/gxl-1.1.dtd">
##  <gxl:graph id="graphNEL" edgemode="directed">
##   <gxl:node id="zip-4">
##    <gxl:attr name="label">
##     <gxl:string>zip-4</gxl:string>
##    </gxl:attr>
##    <gxl:attr name="fill">
```

```
##calculate shortest path, ...
library(RBGL)
sp.between(gR,"daf-16","lam-2")
```

```
## $`daf-16:lam-2`
## $`daf-16:lam-2`$length
## [1] 3
##
## $`daf-16:lam-2`$path_detail
## [1] "daf-16" "zip-4"  "mir-46" "lam-2"
##
## $`daf-16:lam-2`$length_detail
## $`daf-16:lam-2`$length_detail[[1]]
## daf-16->zip-4 zip-4->mir-46 mir-46->lam-2
##             1             1             1
```

# 5 Example using both gene and miRNA expression profile

Using several advanced genomic technologies including micorarray profiling and miRNA sequencing,
not only the gene expression profile, but also the miRNA expression profile can be obtained.
A more robust network can be built if miRNA expression profiling is available. Here is an example to build *SOX2* response
network for *H. sapiens*. The data was downloaded from [BMC Genomics](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3022822/?tool=pubmed)[10](#ref-xuefeng2011).

```
library(GeneNetworkBuilder)
data("hs.interactionmap")
data("hs.miRNA.map")
data("hs.IDsMap")
data("hs.mapIDs")
data("example.data")
rootgene<-"6657"
sifNetwork<-buildNetwork(example.data$hs.bind, hs.interactionmap, level=3)
##example.data$ce$exprData is the combination of gene/miRNA expression profile
##note, here should set the miRNAtol to TRUE
cifNetwork<-filterNetwork(rootgene=rootgene, sifNetwork=sifNetwork,
                   exprsData=example.data$hs.exprData, mergeBy="symbols",
                   miRNAlist=as.character(hs.miRNA.map[,1]),
                   tolerance=0, miRNAtol=TRUE)
cifNetwork<-convertID(cifNetwork, hs.mapIDs, ByName=c("from","to"))
gR<-polishNetwork(cifNetwork)
##plot the figure
browseNetwork(gR)
```

```
## or plot by Rcyjs
# library(RCyjs)
# rcy <- RCyjs(portRange=9047:9067, title='sox2', graph=gR)
# setBrowserWindowTitle(rcy, "sox2")
# setNodeLabelRule(rcy, "label")
# setNodeLabelAlignment(rcy, "center", "center")
# setDefaultNodeColor(rcy, "white")
# setDefaultNodeBorderColor(rcy, "black")
# setDefaultNodeBorderWidth(rcy, 1)
# logFC.range <- range(cifNetwork$logFC)
# logFC.range <- max(abs(logFC.range))
# setNodeColorRule(rcy, "logFC", c(-logFC.range, 0, logFC.range), c("green", "yellow", "red"), mode="interpolate")
# size.range <- range(noa(gR, "size"))
# setNodeSizeRule(rcy, "size", size.range, size.range)
# layout(rcy, "cose")
# redraw(rcy)
```

# 6 Session Info

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
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] RBGL_1.86.0               XML_3.99-0.19
## [3] Rgraphviz_2.54.0          graph_1.88.0
## [5] BiocGenerics_0.56.0       generics_0.1.4
## [7] GeneNetworkBuilder_1.52.0 Rcpp_1.1.0
## [9] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         gplots_3.2.0        bitops_1.0-9
##  [4] KernSmooth_2.23-26  gtools_3.9.5        stringi_1.8.7
##  [7] RCy3_2.30.0         magrittr_2.0.4      digest_0.6.37
## [10] caTools_1.18.3      evaluate_1.0.5      RColorBrewer_1.1-3
## [13] pbdZMQ_0.3-14       bookdown_0.45       fastmap_1.2.0
## [16] plyr_1.8.9          jsonlite_2.0.0      backports_1.5.0
## [19] tinytex_0.57        BiocManager_1.30.26 httr_1.4.7
## [22] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
## [25] crayon_1.5.3        base64enc_0.1-3     repr_1.1.7
## [28] cachem_1.1.0        yaml_2.3.10         tools_4.5.1
## [31] RJSONIO_2.0.0       uuid_1.2-1          base64url_1.4
## [34] IRdisplay_1.1       vctrs_0.6.5         R6_2.6.1
## [37] magick_2.9.0        stats4_4.5.1        lifecycle_1.0.4
## [40] fs_1.6.6            htmlwidgets_1.6.4   pillar_1.11.1
## [43] bslib_0.9.0         glue_1.8.0          xfun_0.53
## [46] knitr_1.50          IRkernel_1.3.2      rjson_0.2.23
## [49] htmltools_0.5.8.1   rmarkdown_2.30      compiler_4.5.1
## [52] RCurl_1.98-1.17
```

# References

1. Arda, H. E. & Walhout, A. J. Gene-centered regulatory networks. *Briefings in functional genomics* **9,** 4–12 (2010).

2. Park, P. J. ChIP–seq: Advantages and challenges of a maturing technology. *Nature Reviews Genetics* **10,** 669–680 (2009).

3. Kim, T. H. & Ren, B. Genome-wide analysis of protein-dna interactions. *Annu. Rev. Genomics Hum. Genet.* **7,** 81–102 (2006).

4. Kaufmann, K. *et al.* Chromatin immunoprecipitation (chip) of plant transcription factors followed by sequencing (chip-seq) or hybridization to whole genome arrays (chip-chip). *Nature protocols* **5,** 457–472 (2010).

5. Wang, Z., Gerstein, M. & Snyder, M. RNA-seq: A revolutionary tool for transcriptomics. *Nature reviews genetics* **10,** 57–63 (2009).

6. Barrasa, M. I., Vaglio, P., Cavasino, F., Jacotot, L. & Walhout, A. J. EDGEdb: A transcription factor-dna interaction database for the analysis of c. Elegans differential gene expression. *BMC genomics* **8,** 21 (2007).

7. Griffiths-Jones, S., Saini, H. K., Dongen, S. van & Enright, A. J. MiRBase: Tools for microRNA genomics. *Nucleic acids research* **36,** D154–D158 (2008).

8. Ravasi, T. *et al.* An atlas of combinatorial transcriptional regulation in mouse and man. *Cell* **140,** 744–752 (2010).

9. Alexiou, P. *et al.* MiRGen 2.0: A database of microRNA genomic information and regulation. *Nucleic acids research* gkp888 (2009).

10. Fang, X. *et al.* The sox2 response program in glioblastoma multiforme: An integrated chip-seq, expression microarray, and microRNA analysis. *BMC genomics* **12,** 1 (2011).