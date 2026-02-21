Code

* Show All Code
* Hide All Code

# Pi User Manual (R/Bioconductor package)

Hai Fang, the ULTRA-DD Consortium, Julian C Knight

#### *2018-10-30*

#### Abstract

This user manual provides instructions on how to use an R/Bioconductor package “Pi”. Pi is developed as a genetics-led target prioritisation system, with the focus on leveraging human genetic data to prioritise potential drug targets at the gene and pathway level. The long-term goal is to use such information to enhance early-stage target selection and validation. Based on evidence of disease association from genome-wide association studies (GWAS), this prioritisation system is able to generate evidence to support identification of the specific modulated genes (genomic seed genes) that are responsible for the genetic association signal: (i) nearby genes (nGene) based on genomic proximity; (ii) expression-associated genes (eGene) based on summary data produced from eQTL mapping; and (iii) chromatin conformation genes (cGene) based on summary data produced from promoter capture Hi-C studies. Restricted to genomic seed genes (nGene, eGene and cGene), gene-level ontology annotations are further used to define three types of annotation predictors on the basis of relatedness to immune function and dysfunction: (i) function genes (fGene) using Gene Ontology; (ii) disease gene (dGene), causing rare genetic disease using OMIM and Disease Ontology; and (iii) phenotype genes (pGene) using Human Phenotype Ontology and using Mammalian Phenotype Ontology. For each type of seed genes (and their scores), non-seed genes under network influence are identified using the random walk with restart (RWR) algorithm, that is, identification of non-seed genes based on network connectivity/affinity of gene interaction information to seed genes. In summary, given GWAS summary data for a trait, a gene-predictor matrix is constructed containing affinity scores, with columns for genomic and annotation predictors and rows for seed and non-seed genes. Using the gene-predictor matrix prepared, target prioritizations are enabled at the gene and pathway level under two modes (“discovery” and “supervised”), each consisting of three sequential steps: Step 1 (shared by both modes), the preparation of the predictor matrix from GWAS summary data; Step 2 (specific to each mode), the prioritisation of target genes, either through meta-analysis (discovery mode) to prioritise target genes with substantial genetic support and/or with rich network connectivity, or through machine learning (supervised mode) to prioritise target genes guided by knowledge of efficacious drugs; and Step 3 (shared by both modes), the prioritisation of target pathways individually and at crosstalk based on the prioritised target genes.

#### Package

Pi 1.10.0

# 1 Installation

## 1.1 R

The latest version on different platforms can be installed following instructions at <http://bioconductor.org/install/#install-R>.

## 1.2 Packages

**Install [`Pi`](http://www.bioconductor.org/packages/Pi) (the latest stable release version from Bioconductor):**

```
source("http://bioconductor.org/biocLite.R")
# to use the latest version of Bioconductor, upgrade it: biocLite("BiocUpgrade")
biocLite("Pi")
```

**Also install the latest development version from github (highly recommended):**

```
# first, install the dependant packages (the stable version)
source("http://bioconductor.org/biocLite.R")
biocLite(c("XGR","devtools"), siteRepos=c("http://cran.r-project.org"))

# then, install the `Pi` package and its dependency (the latest version)
library(devtools)
install_github(c("hfang-bristol/XGR", "hfang-bristol/Pi"))
```

# 2 Workflow

![](data:image/png;base64...)

# 3 R functions

Priority functions are designed in a nested way. The core relation follows this route: `xPierSNPs` -> `xPierGenes` -> `xPier` -> `xRWR`, achieving gene-level prioritisation from an input list of SNPs (along with their significant level). The output of this route is taken as the input of either `xPierManhattan` for visualising gene priority scores, `xPierPathways` for prioritising pathways, or `xPierSubnet` for identifying a network of top prioritised genes.

![](data:image/png;base64...)

## 3.1 xRWR

*[`xRWR`](http://rawgit.com/hfang-bristol/Pi/master/inst/xRWR.html)*: implements Random Walk with Restart (RWR) estimating the affinity score of nodes in a graph to a list of seed nodes. The affinity score can be viewed as the `influential impact` over the graph that is collectively imposed by seed nodes. If the seeds are not given, it will pre-compute affinity matrix for nodes in the input graph with respect to each starting node (as a seed) by looping over every node in the graph. A higher-level function `xPier` directly relies on it.

## 3.2 xPier

*[`xPier`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPier.html)*: uses RWR to calculate the affinity score of nodes in a graph to a list of seed nodes. A node that has a higher affinity score to seed nodes will receive a higher priority score. It is an internal function acting as a general template for RWR-based prioritisation. A higher-level function `xPierGenes` directly relies on it.

## 3.3 xPierGenes

*[`xPierGenes`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierGenes.html)*: prioritises gene targets from an input gene interaction network and the score info imposed on its seed nodes/genes. This function can be considered to be a specific instance of `xPier`, that is, specifying a gene interaction network as a graph and seed nodes as seed genes.

There are two sources of gene interaction network information: the STRING database (Szklarczyk et al. 2015) and the Pathway Commons database (Cerami et al. 2011). STRING is a meta-integration of undirect interactions from a functional aspect, while Pathway Commons mainly contains both undirect and direct interactions from a physical/pathway aspect. In addition to interaction type, users can choose the interactions of varying quality:

Table 1:

| Code | Interaction (type and quality) | Database |
| --- | --- | --- |
| STRING\_high | Functional interactions (with high confidence scores>=700) | STRING |
| STRING\_medium | Functional interactions (with medium confidence scores>=400) | STRING |
| PCommonsUN\_high | Physical/undirect interactions (with references & >=2 sources) | Pathway Commons |
| PCommonsUN\_medium | Physical/undirect interactions (with references & >=1 sources) | Pathway Commons |
| PCommonsDN\_high | Pathway/direct interactions (with references & >=2 sources) | Pathway Commons |
| PCommonsDN\_medium | Pathway/direct interactions (with references & >=1 sources) | Pathway Commons |

## 3.4 xPierSNPs

*[`xPierSNPs`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierSNPs.html)*: prioritises gene targets from an input gene interaction network and a given list of SNPs together with the significance level (eg GWAS reported p-values). To do so, it first defines seed genes and their scores that are calculated in an integrative manner to quantify the genetic influence under SNPs. Genetic influential score on a seed gene is calculated from the SNP score (reflecting the SNP significant level), the gene-to-SNP distance weight, the eQTL mapping weight and the promoter capture HiC weight. This function can be considered to be a specific instance of `xPierGenes`, that is, specifying seed genes plus their scores.

Knowledge of co-inherited variants is also used to include additional SNPs that are in Linkage Disequilibrium (LD) with GWAS lead SNPs. LD SNPs are calculated based on 1000 Genomes Project data (1000 Genomes Project Consortium 2012). LD SNPs are defined to be any SNPs having R2 > 0.8 with GWAS lead SNPs. The user can choose the population used to calculate LD SNPs:

Table 2:

| Code | Population | Project |
| --- | --- | --- |
| AFR | African | 1000 Genomes Project |
| AMR | Admixed American | 1000 Genomes Project |
| EAS | East Asian | 1000 Genomes Project |
| EUR | European | 1000 Genomes Project |
| SAS | South Asian | 1000 Genomes Project |

## 3.5 xPierAnno

*[`xPierAnno`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierAnno.html)*: prioritises seed genes only from a list of pNode objects using annotation data. To do so, it first extracts seed genes from a list of pNode objects and then scores seed genes using annotation data (or something similar), followed by `xPierGenes`.

## 3.6 xPierMatrix and xPierEvidence

*[`xPierMatrix`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierMatrix.html)*: extracts priority matrix from a list of `pNode` objects, in which rows are genes and columns for the predictors (corresponding to the `pNode` objects). Also highlighted is to generate priority results in the discovery mode, that is, (similar to meta-analysis) aggregation of priority matrix.

*[`xPierEvidence`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierEvidence.html)*: extracts evidence from a list of `pNode` objects, in terms of seed genes under genetic influence.

*[`xVisEvidence`](http://rawgit.com/hfang-bristol/Pi/master/inst/xVisEvidence.html)*: visualises evidence for prioritised genes in a gene network.

## 3.7 xPierManhattan and xPierTrack

*[`xPierManhattan`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierManhattan.html)*: visualises prioritised genes using manhattan plot, in which priority for genes is displayed on the Y-axis along with genomic locations on the X-axis. Also highlighted are genes with the top priority.

*[`xPierTrack`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierTrack.html)*: visualises a prioritised gene using track plot, in which priority for the gene in query is displayed on the data track and nearby genes on the annotation track. Genomic locations on the X-axis are indicated on the X-axis, and the gene in query is highlighted.

*[`xPierTrackAdv`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierTrackAdv.html)*: visualises a list of prioritised genes using advanced track plot.

## 3.8 xPierPathways and xPierGSEA

*[`xPierPathways`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierPathways.html)*: prioritises pathways based on enrichment analysis of genes with the top priority (eg top 100 genes) using a compendium of pathways. It returns an object of class `eTerm`. A highly prioritised pathway has its member genes with high gene-level priority scores, that is, having evidence of direct modulation by disease-associated lead (or LD) SNPs, and/or having evidence of indirect modulation at the network level.

*[`xPierGSEA`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierGSEA.html)*: prioritises pathways based on gene set enrichment analysis (GSEA) of prioritised genes using a compendium of pathways. It returns an object of class `eGSEA`. A highly prioritised pathway has its member genes with a tendency of having high gene-level priority scores.

In addition to pathways, analysis can be extended to other ontologies, as listed below:

Table 3:

| Code | Ontology | Category |
| --- | --- | --- |
| DO | Disease Ontology | Disease |
| GOMF | Gene Ontology Molecular Function | Function |
| GOBP | Gene Ontology Biological Process | Function |
| GOCC | Gene Ontology Cellular Component | Function |
| HPPA | Human Phenotype Phenotypic Abnormality | Phenotype |
| HPMI | Human Phenotype Mode of Inheritance | Phenotype |
| HPCM | Human Phenotype Clinical Modifier | Phenotype |
| HPMA | Human Phenotype Mortality Aging | Phenotype |
| MP | Mammalian/Mouse Phenotype | Phenotype |
| DGIdb | DGI druggable gene categories | Druggable |
| SF | SCOP domain superfamilies | Structural domain |
| Pfam | Pfam domain families | Structural domain |
| PS2 | phylostratific age information (our ancestors) | Evolution |
| MsigdbH | Hallmark gene sets | Hallmark (MsigDB) |
| MsigdbC1 | Chromosome and cytogenetic band positional gene sets | Cytogenetics (MsigDB) |
| MsigdbC2CGP | Chemical and genetic perturbation gene sets | Perturbation (MsigDB) |
| MsigdbC2CPall | All pathway gene sets | Pathways (MsigDB) |
| MsigdbC2CP | Canonical pathway gene sets | Pathways (MsigDB) |
| MsigdbC2KEGG | KEGG pathway gene sets | Pathways (MsigDB) |
| MsigdbC2REACTOME | Reactome pathway gene sets | Pathways (MsigDB) |
| MsigdbC2BIOCARTA | BioCarta pathway gene sets | Pathways (MsigDB) |
| MsigdbC3TFT | Transcription factor target gene sets | TF targets (MsigDB) |
| MsigdbC3MIR | microRNA target gene sets | microRNA targets (MsigDB) |
| MsigdbC4CGN | Cancer gene neighborhood gene sets | Cancer (MsigDB) |
| MsigdbC4CM | Cancer module gene sets | Cancer (MsigDB) |
| MsigdbC5BP | GO biological process gene sets | Function (MsigDB) |
| MsigdbC5MF | GO molecular function gene sets | Function (MsigDB) |
| MsigdbC5CC | GO cellular component gene sets | Function (MsigDB) |
| MsigdbC6 | Oncogenic signature gene sets | Oncology (MsigDB) |
| MsigdbC7 | Immunologic signature gene sets | Immunology (MsigDB) |

## 3.9 xPierSubnet

*[`xPierSubnet`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierSubnet.html)*: identifies a gene network that contains as many highly prioritised genes as possible but a few lowly prioritised genes as linkers. An iterative procedure of choosing different priority cutoff is also used to identify the network with a desired number of nodes/genes.

## 3.10 Evaluation functions

* *[`xPredictROCR`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPredictROCR.html)*: assesses the prediction/prioritisation performance via Receiver Operating Characteristic (ROC) and Precision-Recall (PR) analysis.
* *[`xPredictCompare`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPredictCompare.html)*: compares the prediction/prioritisation performance.
* *[`xGSsimulator`](http://rawgit.com/hfang-bristol/Pi/master/inst/xGSsimulator.html)*: simulates the gold standard negatives (GSN) from gold standard positives (GSP) considering the gene interaction evidence and returns an object of class `sGS`.
* *[`xPierROCR`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierROCR.html)*: assesses the dTarget performance via ROC and PR analysis.
* *[`xMLfeatureplot`](http://rawgit.com/hfang-bristol/Pi/master/inst/xMLfeatureplot.html)*: visualises/assesses features used for machine learning.

## 3.11 Integral functions

* *[`xMLrandomforest`](http://rawgit.com/hfang-bristol/Pi/master/inst/xMLrandomforest.html)*: integrates predictor matrix via machine learning algorithm random forest and returns an object of class `sTarget`.
* *[`xMLcaret`](http://rawgit.com/hfang-bristol/Pi/master/inst/xMLcaret.html)*: integrates predictor matrix in a supervised manner via machine learning algorithms using caret and returns an object of class `sTarget`.
* *[`xMLparameters`](http://rawgit.com/hfang-bristol/Pi/master/inst/xMLparameters.html)*: visualises cross-validation performance against tuning parameters.
* *[`xMLdotplot`](http://rawgit.com/hfang-bristol/Pi/master/inst/xMLdotplot.html)*: visualise machine learning results (a `sTarget` object) using dot plot and returns an object of class `ggplot`.
* *[`xMLdensity`](http://rawgit.com/hfang-bristol/Pi/master/inst/xMLdensity.html)*: visualise machine learning results (a `sTarget` or `dTarget` object) using density plot and returns an object of class `ggplot`.
* *[`xMLzoom`](http://rawgit.com/hfang-bristol/Pi/master/inst/xMLzoom.html)*: visualise machine learning results (a `sTarget` or `dTarget` object) using zoom plot and returns an object of class `ggplot`.

## 3.12 Elementary functions

* *[`xPierSNPsAdv`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierSNPs.html)*: prepares genetic predictors given a list of seed SNPs together with the significance level (e.g. GWAS reported p-values).
* *[`xPierCross`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPierCross.html)*: extracts priority matrix from a list of `dTarget`/`sTarget` objects.
* *[`xSNP2eGenes`](http://rawgit.com/hfang-bristol/Pi/master/inst/xSNP2eGenes.html)*: defines eQTL genes given a list of SNPs.
* *[`xSNP2cGenes`](http://rawgit.com/hfang-bristol/Pi/master/inst/xSNP2cGenes.html)*: defines HiC genes given a list of SNPs.
* *[`xPCHiCplot`](http://rawgit.com/hfang-bristol/Pi/master/inst/xPCHiCplot.html)*: visualises promoter capture HiC data using different network layouts.
* *[`xContour`](http://rawgit.com/hfang-bristol/Pi/master/inst/xContour.html)*: visualises a numeric matrix as a contour plot.
* *[`xGSEAdotplot`](http://rawgit.com/hfang-bristol/Pi/master/inst/xGSEAdotplot.html)*: visualises GSEA results using dot plot.
* *[`xGSEAbarplot`](http://rawgit.com/hfang-bristol/Pi/master/inst/xGSEAbarplot.html)*: visualises GSEA results using bar plot.
* *[`xGSEAconciser`](http://rawgit.com/hfang-bristol/Pi/master/inst/xGSEAconciser.html)*: makes GSEA results conciser by removing redundant terms.

# 4 Showcases

In this section, we use GWAS SNPs about an inflammatory disease `Spondyloarthritis` (including `Ankylosing Spondylitis` and `Psoriatic Arthritis`) as a case study, and give a step-by-step demo showing how to use `Pi` to achieve disease-specific genetic prioritisation of targets at the gene, pathway and network level.

**First of all, load the packages including `Pi`:**

```
library(Pi)

# optionally, specify the local location of built-in RData
# by default:
RData.location <- "http://galahad.well.ox.ac.uk/bigdata"
```

## 4.1 Input data

Spondyloarthritis-associated GWAS lead SNPs are collected mainly from GWAS Catalog (Welter et al. 2014), complemented by [ImmunoBase](http://www.immunobase.org) and latest publications.

```
data.file <- "http://galahad.well.ox.ac.uk/bigdata/Spondyloarthritis.txt"
data <- read.delim(data.file, header=TRUE, stringsAsFactors=FALSE)
```

The first 15 rows of `data` are shown below, with the column `SNP` for GWAS SNPs and the column `Pval` for GWAS-detected P-values.

Table 4:

| SNP | Pval |
| --- | --- |
| rs6600247 | 2.6e-15 |
| rs11209026 | 2.0e-27 |
| rs11209026 | 9.1e-14 |
| rs12141575 | 9.4e-11 |
| rs4129267 | 3.4e-13 |
| rs1801274 | 1.4e-09 |
| rs41299637 | 1.9e-15 |
| rs1250550 | 1.5e-09 |
| rs1250550 | 1.5e-09 |
| rs1250550 | 1.5e-09 |
| rs11190133 | 4.9e-14 |
| rs1860545 | 2.8e-10 |
| rs11065898 | 4.7e-08 |
| rs11624293 | 1.5e-10 |
| imm\_16\_28525386 | 2.6e-09 |

## 4.2 Gene-level prioritisation

It includes the following steps:

* `define seed genes`, that is, seed genes are defined based on distance-to-SNP window, genetic association with gene expression, and physical interaction involving variants and genes: `nearby genes` that are located within defined distance window (by default, 50kb) of lead or Linkage Disequilibrium (LD) SNPs that are calculated based on European population data from 1000 Genome Project; `expression associated genes (eQTL genes)` for which gene expression is, either in a cis- or trans-acting manner, significantly associated with lead or LD SNPs, based on eQTL mapping; `promoter capture HiC genes (HiC genes)` for which gene promoters physically interact with variants, based on genome-wide capture HiC-generated promoter interactomes.
* `score seed genes`, that is, quantifying the genetic influence under lead or LD SNPs.
* `prioritise target genes`, that is, estimating their global network connectivity to seed genes. With scored seed genes superposed onto a gene interaction network, RWR algorithm is implemented to prioritise candidate target genes based on their network connectivity/affinity to seed genes. As such, a gene that has a higher affinity score to seed genes will receive a higher priority score.

> **Specify parameters**

```
include.LD <- 'EUR'
LD.r2 <- 0.8
LD.customised <- NULL
significance.threshold <- 5e-8
distance.max <- 50000
decay.kernel <- "rapid"
decay.exponent <- 2
include.eQTL <- c("JKscience_TS2A","JKscience_TS2B","JKscience_TS3A","JKng_bcell","JKng_mono","JKnc_neutro", "GTEx_V4_Whole_Blood")
eQTL.customised <- NULL
include.HiC <- c("Monocytes","Neutrophils","Total_B_cells")
GR.SNP <- "dbSNP_GWAS"
GR.Gene <- "UCSC_knownGene"
cdf.function <- "empirical"
relative.importance <- c(1/3, 1/3, 1/3)
scoring.scheme <- 'max'
network <- "STRING_high"
network.customised <- NULL
weighted <- FALSE
normalise <- "laplacian"
normalise.affinity.matrix <- "none"
restart <- 0.75
parallel <- TRUE
multicores <- NULL
verbose <- TRUE
```

> **Do prioritisation**

```
pNode <- xPierSNPs(data, include.LD=include.LD, LD.r2=LD.r2, significance.threshold=significance.threshold, distance.max=distance.max, decay.kernel=decay.kernel, decay.exponent=decay.exponent, include.eQTL=include.eQTL, include.HiC=include.HiC, GR.SNP=GR.SNP, GR.Gene=GR.Gene, cdf.function=cdf.function, scoring.scheme=scoring.scheme, network=network, restart=restart, RData.location=RData.location)
```

The results are stored in the data frame `pNode$priority`, which can be saved into a file `Genes_priority.txt`:

```
write.table(pNode$priority, file="Genes_priority.txt", sep="\t", row.names=FALSE)
```

> **Visualise in manhattan plot**

Top genes can be highlighted in manhattan plot, in which priority scores for genes are displayed on the Y-axis along with genomic locations on the X-axis.

```
mp <- xPierManhattan(pNode, top=40, y.scale="sqrt", RData.location=RData.location)
print(mp)
```

![](data:image/png;base64...)

## 4.3 Pathway-level prioritisation

Pathway-level prioritisation is based on top 100 genes using a compendium of pathways from diverse sources (Canonical, KEGG, BioCarta and Reactome). Since diverse sources are used, it is necessary to remove redundant pathways (of the same granularity to the similar pathways with higher priority scores), done by XGR (Fang et al. 2016).

```
eTerm <- xPierPathways(pNode, priority.top=100, ontology="MsigdbC2CPall", RData.location=RData.location)
eTerm_nonred <- xEnrichConciser(eTerm)

# view the top pathways/terms
xEnrichViewer(eTerm_nonred)

# save results to a file `Pathways_priority.nonredundant.txt`
Pathways_nonred <- xEnrichViewer(eTerm_nonred, top_num=length(eTerm_nonred$adjp), sortBy="fdr", details=TRUE)
output <- data.frame(term=rownames(Pathways_nonred), Pathways_nonred)
write.table(output, file="Pathways_priority.nonredundant.txt", sep="\t", row.names=FALSE)
```

Barplot of prioritised pathways (non-redundant and informative):

```
bp <- xEnrichBarplot(eTerm_nonred, top_num="auto", displayBy="fdr", FDR.cutoff=1e-3, wrap.width=50, signature=FALSE)
bp
```

![](data:image/png;base64...)

## 4.4 Network-level prioritisation

Network-level prioritisation is to identify a gene network that contains as many highly prioritised genes as possible but a few lowly prioritised genes as linkers. Given a gene network (the same as used in gene-level prioritisation) with nodes labelled with gene priority scores, the search for a maximum-scoring gene subnetwork is briefed as follows:

* `score transformation`, that is, given a threshold of tolerable priority scores, nodes above this threshold (nodes of interest) are scored positively, and negative scores for nodes below the threshold (intolerable).
* `subnetwork identification`, that is, to find an interconnected gene subnetwork enriched with positive-score nodes but allowing for a few negative-score nodes as linkers, done via heuristically solving prize-collecting Steiner tree problem (Fang and Gough 2014).
* `controlling the subnetwork size`, that is, an iterative procedure of scanning different priority thresholds is used to identify the network with a desired number of nodes/genes.

Notably, the preferential use of the same network as used in gene-level prioritisation is due to the fact that gene-level affinity/priority scores are smoothly distributed over the network after being walked. In other words, the chance of identifying such a gene network enriched with top prioritised genes is much higher. To reduce the runtime, by default only top 10% prioritised genes will be used to search for the maximum-scoring gene network.

```
# find maximum-scoring gene network with the desired node number=50
g <- xPierSubnet(pNode, priority.quantite=0.1, subnet.size=50, RData.location=RData.location)
```

The identified gene network has nodes/genes colored according to their priority scores (see below). Notably, if nodes appear abnormally, please remove `vertex.shape="sphere"` when running the function `xVisNet`.

```
pattern <- as.numeric(V(g)$priority)
zmax <- ceiling(quantile(pattern,0.75)*1000)/1000
xVisNet(g, pattern=pattern, vertex.shape="sphere", colormap="yr", newpage=FALSE, edge.arrow.size=0.3, vertex.label.color="blue", vertex.label.dist=0.35, vertex.label.font=2, zlim=c(0,zmax), signature=FALSE)
```

![](data:image/png;base64...)

# 5 Session Info

**Here is the output of `sessionInfo()` on the system on which this user manual was compiled:**

```
> R version 3.5.1 Patched (2018-07-12 r74967)
> Platform: x86_64-pc-linux-gnu (64-bit)
> Running under: Ubuntu 16.04.5 LTS
>
> Matrix products: default
> BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
> LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
>
> locale:
>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
>
> attached base packages:
> [1] grid      stats     graphics  grDevices utils     datasets  methods
> [8] base
>
> other attached packages:
> [1] Pi_1.10.0        XGR_1.1.4        ggplot2_3.1.0    dnet_1.1.4
> [5] supraHex_1.20.0  hexbin_1.27.2    igraph_1.2.2     png_0.1-7
> [9] BiocStyle_2.10.0
>
> loaded via a namespace (and not attached):
>   [1] tidyselect_0.2.5            RSQLite_2.1.1
>   [3] AnnotationDbi_1.44.0        htmlwidgets_1.3
>   [5] BiocParallel_1.16.0         munsell_0.5.0
>   [7] codetools_0.2-15            misc3d_0.8-4
>   [9] withr_2.1.2                 colorspace_1.3-2
>  [11] Biobase_2.42.0              OrganismDbi_1.24.0
>  [13] highr_0.7                   knitr_1.20
>  [15] rstudioapi_0.8              geometry_0.3-6
>  [17] stats4_3.5.1                ROCR_1.0-7
>  [19] robustbase_0.93-3           dimRed_0.1.0
>  [21] GenomeInfoDbData_1.2.0      bit64_0.9-7
>  [23] rprojroot_1.3-2             coda_0.19-2
>  [25] ipred_0.9-7                 xfun_0.4
>  [27] biovizBase_1.30.0           randomForest_4.6-14
>  [29] R6_2.3.0                    GenomeInfoDb_1.18.0
>  [31] AnnotationFilter_1.6.0      DRR_0.0.3
>  [33] bitops_1.0-6                reshape_0.8.8
>  [35] DelayedArray_0.8.0          assertthat_0.2.0
>  [37] scales_1.0.0                nnet_7.3-12
>  [39] gtable_0.2.0                ddalpha_1.3.4
>  [41] ggbio_1.30.0                ensembldb_2.6.0
>  [43] timeDate_3043.102           rlang_0.3.0.1
>  [45] CVST_0.2-2                  RcppRoll_0.3.0
>  [47] splines_3.5.1               rtracklayer_1.42.0
>  [49] lazyeval_0.2.1              ModelMetrics_1.2.0
>  [51] acepack_1.4.1               dichromat_2.0-0
>  [53] broom_0.5.0                 checkmate_1.8.5
>  [55] BiocManager_1.30.3          yaml_2.2.0
>  [57] reshape2_1.4.3              abind_1.4-5
>  [59] GenomicFeatures_1.34.0      ggnetwork_0.5.1
>  [61] backports_1.1.2             Hmisc_4.1-1
>  [63] RBGL_1.58.0                 caret_6.0-80
>  [65] tools_3.5.1                 lava_1.6.3
>  [67] bookdown_0.7                statnet.common_4.1.4
>  [69] gplots_3.0.1                RColorBrewer_1.1-2
>  [71] BiocGenerics_0.28.0         Rcpp_0.12.19
>  [73] plyr_1.8.4                  base64enc_0.1-3
>  [75] progress_1.2.0              zlibbioc_1.28.0
>  [77] purrr_0.2.5                 RCurl_1.95-4.11
>  [79] prettyunits_1.0.2           rpart_4.1-13
>  [81] S4Vectors_0.20.0            sfsmisc_1.1-2
>  [83] SummarizedExperiment_1.12.0 ggrepel_0.8.0
>  [85] cluster_2.0.7-1             magrittr_1.5
>  [87] data.table_1.11.8           sna_2.4
>  [89] ProtGenerics_1.14.0         matrixStats_0.54.0
>  [91] hms_0.4.2                   evaluate_0.12
>  [93] XML_3.98-1.16               IRanges_2.16.0
>  [95] gridExtra_2.3               compiler_3.5.1
>  [97] biomaRt_2.38.0              tibble_1.4.2
>  [99] KernSmooth_2.23-15          crayon_1.3.4
> [101] htmltools_0.3.6             Formula_1.2-3
> [103] tidyr_0.8.2                 lubridate_1.7.4
> [105] DBI_1.0.0                   magic_1.5-9
> [107] MASS_7.3-51                 Matrix_1.2-14
> [109] gdata_2.18.0                parallel_3.5.1
> [111] Gviz_1.26.0                 bindr_0.1.1
> [113] gower_0.1.2                 GenomicRanges_1.34.0
> [115] pkgconfig_2.0.2             GenomicAlignments_1.18.0
> [117] RCircos_1.2.0               foreign_0.8-71
> [119] recipes_0.1.3               foreach_1.4.4
> [121] XVector_0.22.0              prodlim_2018.04.18
> [123] stringr_1.3.1               VariantAnnotation_1.28.0
> [125] digest_0.6.18               pls_2.7-0
> [127] graph_1.60.0                Biostrings_2.50.0
> [129] rmarkdown_1.10              htmlTable_1.12
> [131] curl_3.2                    kernlab_0.9-27
> [133] Rsamtools_1.34.0            gtools_3.8.1
> [135] nlme_3.1-137                bindrcpp_0.2.2
> [137] network_1.13.0.1            BSgenome_1.50.0
> [139] pillar_1.3.0                lattice_0.20-35
> [141] GGally_1.4.0                httr_1.3.1
> [143] DEoptimR_1.0-8              survival_2.43-1
> [145] glue_1.3.0                  iterators_1.0.10
> [147] plot3D_1.1.1                glmnet_2.0-16
> [149] bit_1.1-14                  Rgraphviz_2.26.0
> [151] class_7.3-14                stringi_1.2.4
> [153] blob_1.1.1                  latticeExtra_0.6-28
> [155] caTools_1.17.1.1            memoise_1.1.0
> [157] dplyr_0.7.7                 ape_5.2
```

# 6 References

**Below is the list of references that Pi stands on:**

1000 Genomes Project Consortium. 2012. “An integrated map of genetic variation from 1,092 human genomes.” *Nature* 491 (7422):56–65. <https://doi.org/10.1038/nature11632>.

Cerami, E. G., B. E. Gross, E. Demir, I. Rodchenkov, O. Babur, N. Anwar, N. Schultz, G. D. Bader, and C. Sander. 2011. “Pathway Commons, a web resource for biological pathway data.” *Nucleic Acids Research* 39 (Database):D685–D690. <https://doi.org/10.1093/nar/gkq1039>.

Fang, Hai, and Julian Gough. 2014. “The ’dnet’ approach promotes emerging research on cancer patient survival.” *Genome Medicine* 6 (8):64. <https://doi.org/10.1186/s13073-014-0064-8>.

Fang, Hai, Bogdan Knezevic, Katie L. Burnham, and Julian C. Knight. 2016. “XGR software for enhanced interpretation of genomic summary data, illustrated by application to immunological traits.” *Genome Medicine* 8 (1). Genome Medicine:129. <https://doi.org/10.1186/s13073-016-0384-y>.

Szklarczyk, Damian, Andrea Franceschini, Stefan Wyder, Kristoffer Forslund, Davide Heller, Jaime Huerta-cepas, Milan Simonovic, et al. 2015. “STRING v10 : protein – protein interaction networks , integrated over the tree of life.” *Nucleic Acids Res* 43 (Database):D447–D452. <https://doi.org/10.1093/nar/gku1003>.

Welter, Danielle, Jacqueline MacArthur, Joannella Morales, Tony Burdett, Peggy Hall, Heather Junkins, Alan Klemm, et al. 2014. “The NHGRI GWAS Catalog, a curated resource of SNP-trait associations.” *Nucleic Acids Research* 42 (D1):1001–6. <https://doi.org/10.1093/nar/gkt1229>.