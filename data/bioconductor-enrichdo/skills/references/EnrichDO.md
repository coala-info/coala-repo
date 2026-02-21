# EnrichDO: a Global Weighted Model for Disease Ontology Enrichment Analysis

Liang Cheng1, Haixiu Yang1\* and Hongyu Fu1

1College of Bioinformatics Science and Technology, Harbin Medical University

\*yanghaixiu@ems.hrbmu.edu.cn

#### 2025-10-29

#### Package

EnrichDO 1.4.0

# Contents

* [1 Installation](#installation)
* [2 Citation](#citation)
* [3 Introduction](#introduction)
* [4 Disease Ontology Enrichment Analysis](#disease-ontology-enrichment-analysis)
  + [4.1 Data Preparation](#data-preparation)
  + [4.2 doEnrich Function](#doenrich-function)
    - [4.2.1 Weighted Enrichment Function](#weighted-enrichment-function)
    - [4.2.2 Classic Enrichment Function](#classic-enrichment-function)
  + [4.3 Result description and Written](#result-description-and-written)
    - [4.3.1 Result description](#result-description)
    - [4.3.2 Result writing](#result-writing)
* [5 Visualization of enrichment results](#visualization-of-enrichment-results)
  + [5.1 drawBarGraph function](#drawbargraph-function)
  + [5.2 drawPointGraph function](#drawpointgraph-function)
  + [5.3 drawGraphViz function](#drawgraphviz-function)
  + [5.4 drawHeatmap function](#drawheatmap-function)
  + [5.5 convenient drawing](#convenient-drawing)
* [6 Session information](#session-information)

# 1 Installation

`EnrichDO` can be installed from Bioconductor:

```
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")

BiocManager::install("EnrichDO")
```

or github page

```
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")

library(devtools)
devtools::install_github("liangcheng-hrbmu/EnrichDO")
```

# 2 Citation

If you use [EnrichDO](https://www.bioconductor.org/packages/release/bioc/html/EnrichDO.html) in published research, please cite:

Haixiu Yang, Hongyu Fu, Meiyi Zhang, Yangyang Liu, Yongqun Oliver He, Chao Wang, Liang Cheng, EnrichDO: a global weighted model for Disease Ontology enrichment analysis, GigaScience, Volume 14, 2025, giaf021, <https://doi.org/10.1093/gigascience/giaf021>

# 3 Introduction

Disease Ontology (DO) enrichment analysis is an effective means to discover the associations between genes and diseases. However, most current DO-based enrichment methods were unable to solve the over enriched problem caused by the “true-path” rule. To address this problem, we presents EnrichDO, a double weighted iterative model, which is based on the latest annotations of the human genome with DO terms and integrates the DO graph topology on a global scale. On one hand, to reinforce the saliency of direct gene-DO annotations, different initial weights are assigned to directly annotated genes and indirectly annotated genes, respectively. On the other hand, to detect locally most significant node between the parent and its children, less significant nodes are dynamically down-weighted. EnrichDO exhibits high accuracy that it can identify more specific DO terms, which alleviates the over enriched problem.

EnrichDO encompasses various statistical models and visualization schemes for discovering the associations between genes and diseases from biological big data. Currently uploaded to Bioconductor, EnrichDO aims to provide a more convenient and effective DO enrichment analysis tool.

```
library(EnrichDO)
```

# 4 Disease Ontology Enrichment Analysis

EnrichDO presents a double weighted iterative model for DO enrichment analysis. Based on the latest annotations of the human genome with DO terms, EnrichDO can identify locally significant enriched terms by applying different initial weights and dynamic weights for annotated genes and integrating the DO graph topology on a global scale. EnrichDO presents an effective and flexible model, which supplies various statistical testing models and multiple testing correction methods.

## 4.1 Data Preparation

The input data for EnrichDO is a predefined gene set, such as differentially expressed gene sets, significant genes from GWAS, gene sets from high-throughput biological data, etc. The interest gene sets should be protein-coding genes, in the ENTREZID format from NCBI. Taking the *input\_example* as an example, it stores validated protein-coding genes associated with Alzheimer’s disease from the DisGeNET database.

```
Alzheimer<-read.delim(file.path(system.file("extdata", package="EnrichDO"),
                                "Alzheimer_curated.csv"), header = FALSE)
input_example<-Alzheimer[,1]
```

In order to improve the speed of the case, in the following example, several genes (*demo.data*) are randomly selected from the protein-coding genes (NCBI Entrez ID) for analysis.

```
demo.data<-c(1636,351,102,2932,3077,348,4137,54209,5663,5328,23621,3416,3553)
```

## 4.2 doEnrich Function

EnrichDO provides disease ontology enrichment analysis through the ***doEnrich*** function. Depending on the setting of the *traditional* parameter, you can choose between weighted enrichment analysis or classic enrichment analysis. The following is a simple running example using weighted enrichment analysis by default:

```
weighted_demo_result<-doEnrich(interestGenes=demo.data)
```

### 4.2.1 Weighted Enrichment Function

In addition to performing weighted enrichment analysis with default parameters, the following parameters can also be modified to better meet the analysis requirements. The specific meanings of these parameters can be accessed by using the ***?doEnrich*** method.

```
weighted_demo_result<-doEnrich(interestGenes=demo.data,
                        test="fisherTest",
                        method="holm",
                        m=1,
                        minGsize=10,
                        maxGsize=2000,
                        delta=0.05,
                        penalize=TRUE)
```

```
#>       -- Descending rights test--
#> LEVEL: 13    1 nodes 72 genes to be scored
#> LEVEL: 12    2 nodes 457 genes to be scored
#> LEVEL: 11    3 nodes 907 genes to be scored
#> LEVEL: 10    12 nodes    2278 genes to be scored
#> LEVEL: 9 50 nodes    5376 genes to be scored
#> LEVEL: 8 116 nodes   7751 genes to be scored
#> LEVEL: 7 181 nodes   9463 genes to be scored
#> LEVEL: 6 193 nodes   10144 genes to be scored
#> LEVEL: 5 174 nodes   9756 genes to be scored
#> LEVEL: 4 85 nodes    9088 genes to be scored
#> LEVEL: 3 18 nodes    4599 genes to be scored
#> LEVEL: 2 1 nodes 1605 genes to be scored
#> LEVEL: 1 0 nodes 0 genes to be scored
```

### 4.2.2 Classic Enrichment Function

The ***doEnrich*** function can control the parameter *traditional* to perform traditional overexpression enrichment analysis (ORA), which means that it will not down-weight based on the topological structure of the disease ontology. Additionally, Parameters *test, method, m, maxGsize* and *minGsize* can be used flexibly.

```
Tradition_demo_result<-doEnrich(demo.data, traditional=TRUE)
#>       -- Traditional test--
```

## 4.3 Result description and Written

### 4.3.1 Result description

Running ***doEnrich*** will output the terms and total genes involved in each layer of Directed acyclic graph (DAG) to the user. The enrichment results can be summarized using the ***show*** function.

```
show(weighted_demo_result)
```

```
#> ------------------------- EnrichResult object -------------------------
#> Method of enrichment:
#>   Global Weighted Model
#>   'fisherTest' Statistical model with the 'holm' Multiple hypothesis correction
#> Enrichment cutoff layer: 1
#> interestGenes number: 13
#> 354 DOTerms scored: 354 terms with p < 0.05
#> Parameter setting:
#>   Enrichment cutoff layer: 1
#>   Doterm gene number limit: minGsize 10, maxGsize 2000
#>   Enrichment threshold: 0.05
```

The result of ***doEnrich*** is *weighted*\_*demo\_result* which contains *enrich, interestGenes, test, method, m, maxGsize, minGsize, delta, traditional, penalize*. There are 16 columns of *enrich*, including:

* The standard ID corresponding to the DO Term (*DOID*).
* the standard name of the DO Term (*DOTerm*), each DO Term has a unique DOID.
* We constructed a directed acyclic graph according to the is\_a relationship between each node in the DO database, and each DO Term has a corresponding level (*level*).
* The DO database stores the parent node of each DO Term (*parent.arr*) and its number (*parent.len*). For example, “B-cell acute lymphoblastic leukemia” (DOID:0080638) is\_a “acute lymphoblastic leukemia” (DOID:9952) and “lymphoma” (DOID:0060058), then the node “B-cell acute lymphoblastic leukemia” is a child of “acute lymphoblastic leukemia” and “lymphoma”, and the child is a more specific biological classification than its parent.
* child nodes of the DO Term (*child.arr*) and their number (*child.len*).
* the latest GeneRIF information is used to annotate DO Terms, each DO Term has its corresponding disease-associated genes (*gene.arr*), and its number (*gene.len*).
* Assigning a weight to each gene helps assess the contribution of different genes to DO Terms (*weight.arr*).
* The smaller the weights of indirectly annotated genes, the less contribution of these genes in the enrichment analysis.(*gene.w*).
* the P-value of the DO Term (*p*), which arranges the order of enrich, and the value of P-value correction (*p.adjust*).
* the genes of interest annotated to this DO Term (*cg.arr*) and its number (*cg.len*).
* the number of genes in the interest gene set (*ig.len*), this represents the number of genes that are actually used for enrichment analysis.

Generally, a significant P value of the enrichment results should be less than 0.05 or 0.01, indicating a significant association between the interesting gene set and the disease node. In the *enrich*, the node with the most significant enrichment is DOID:0080832, and the DO Term is “mild cognitive impairment”, with its P-value being 9.22e-16. These results suggests that there is statistical significance between the interesting gene set and the DO Term of mild cognitive impairment.

### 4.3.2 Result writing

The ***writeResult*** function can output *DOID, DOTerm, p, p.adjust, geneRatio, bgRatio* and *cg* in the data frame *enrich* as text. The default file name is “result.txt”.

```
writeResult(EnrichResult = weighted_demo_result,file=file.path(tempdir(), "result.txt"), Q=1, P=1)
```

***writeResult*** has four parameters. *EnrichResult* indicates the enrichment result of ***doEnrich***, *file* indicates the write address of a file. The parameter *Q* (and *P*) indicates that a DO term is output only when *p.adjust* (and *p* value) is less than or equal to *Q* (and *P*). The default values for *P* and *Q* are 1.

In the output file *result.txt*, *geneRatio* represents the intersection of the DO term annotated genes with the interest gene set divided by the interest gene set, and *bgRatio* represents all genes of the DO term divided by the background gene set.

# 5 Visualization of enrichment results

EnrichDO provides four methods to visualize enrichment results, including bar plot (***drawBarGraph***), bubble plot (***drawPointGraph***), tree plot (***drawGraphviz***) and heatmap (***drawHeatmap***), which can show the research results more concisely and intuitively. Pay attention to the threshold setting for each visual method, if the threshold is too low, the display is insufficient.

## 5.1 drawBarGraph function

***drawBarGraph*** can draw the top *n* nodes with the most significant p-value as bar chart, and the node’s p-value is less than *delta* (By default, *n* is 10 and *delta* is 1e-15).

```
drawBarGraph(EnrichResult=weighted_demo_result, n=10, delta=0.05)
```

![bar plot](data:image/png;base64...)

Figure 1: bar plot

## 5.2 drawPointGraph function

***drawPointGraph*** can draw the top *n* nodes with the most significant p-value as bubble plot, and the node’s p-value is less than *delta* (By default, *n* is 10 and *delta* is 1e-15).

```
drawPointGraph(EnrichResult=weighted_demo_result, n=10, delta=0.05)
#> Ignoring unknown labels:
#> • colour : "expression(log10p)"
```

![point plot](data:image/png;base64...)

Figure 2: point plot

## 5.3 drawGraphViz function

***drawGraphViz*** draws the DAG structure of the most significant *n* nodes, and *labelfontsize* can set the font size of labels in nodes (By default, *n* is 10 and *labelfontsize* is 14). Each node has a corresponding disease name displayed.

In addition, the ***drawGraphViz*** function can also display the P-value of each node in the enrichment analysis (*pview*=TRUE), and the number of overlapping genes of each DO term and interest gene set (*numview*=TRUE).

```
drawGraphViz(EnrichResult=weighted_demo_result, n=10, numview=FALSE, pview=FALSE, labelfontsize=17)
```

![tree plot](data:image/png;base64...)

Figure 3: tree plot

## 5.4 drawHeatmap function

***drawHeatmap*** function visualizes the strength of the relationship between the top *DOID\_n* nodes from enrichment results and the genes whose weight sum ranks the top *gene\_n* in these nodes. And the gene must be included in the gene of interest.

***drawHeatmap*** also provides additional parameters from the pheatmap function, which you can set according to your needs. Default *DOID\_n* is 10, *gene\_n* is 50, *fontsize\_row* is 10.

```
drawHeatmap(interestGenes=demo.data,
            EnrichResult=weighted_demo_result,
            gene_n=10,
            fontsize_row=8)
```

![heatmap](data:image/png;base64...)

Figure 4: heatmap

## 5.5 convenient drawing

Draw(***drawBarGraph ,drawPointGraph ,drawGraphViz***) from ***writeResult*** output files, so you don’t have to wait for the algorithm to run.

```
#Firstly, read the wrireResult output file,using the following two lines
data <- read.delim(file.path(system.file("examples", package="EnrichDO"), "result.txt"))
enrich <- convDraw(resultDO=data)
#> The enrichment results you provide are stored in enrich
#> Now you can use the drawing function

#then, Use the drawing function you need
drawGraphViz(enrich=enrich)    #Tree diagram
```

![](data:image/png;base64...)

```
drawPointGraph(enrich=enrich, delta = 0.05)  #Bubble diagram
#> Ignoring unknown labels:
#> • colour : "expression(log10p)"
```

![](data:image/png;base64...)

```
drawBarGraph(enrich=enrich, delta = 0.05)    #Bar plot
```

![](data:image/png;base64...)

# 6 Session information

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
#> [1] EnrichDO_1.4.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        jsonlite_2.0.0      dplyr_1.1.4
#>  [4] compiler_4.5.1      BiocManager_1.30.26 Rcpp_1.1.0
#>  [7] tinytex_0.57        tidyselect_1.2.1    magick_2.9.0
#> [10] dichromat_2.0-0.1   tidyr_1.3.1         Rgraphviz_2.54.0
#> [13] jquerylib_0.1.4     scales_1.4.0        yaml_2.3.10
#> [16] fastmap_1.2.0       ggplot2_4.0.0       R6_2.6.1
#> [19] labeling_0.4.3      generics_0.1.4      knitr_1.50
#> [22] BiocGenerics_0.56.0 graph_1.88.0        tibble_3.3.0
#> [25] bookdown_0.45       bslib_0.9.0         pillar_1.11.1
#> [28] RColorBrewer_1.1-3  rlang_1.1.6         cachem_1.1.0
#> [31] xfun_0.53           sass_0.4.10         S7_0.2.0
#> [34] cli_3.6.5           withr_3.0.2         magrittr_2.0.4
#> [37] digest_0.6.37       grid_4.5.1          lifecycle_1.0.4
#> [40] S4Vectors_0.48.0    vctrs_0.6.5         pheatmap_1.0.13
#> [43] evaluate_1.0.5      glue_1.8.0          farver_2.1.2
#> [46] codetools_0.2-20    stats4_4.5.1        hash_2.2.6.3
#> [49] purrr_1.1.0         rmarkdown_2.30      tools_4.5.1
#> [52] pkgconfig_2.0.3     htmltools_0.5.8.1
```