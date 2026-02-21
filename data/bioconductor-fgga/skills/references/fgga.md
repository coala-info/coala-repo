# FGGA: Factor Graph GO Annotation

F.E. Spetale1\* and E. Tapia1

1Bioinformatics Group. CIFASIS-UNR-CONICET. Rosario (Argentina)

\*spetale@cifasis-conicet.gov.ar

#### 2025-10-29

#### Abstract

We present a tutorial to use **FGGA**, a hierarchical ensemble method that exploits the ability of factor graphs for modeling logical and statistical constraints over system variables. The **FGGA model** is built in two main steps. In the first step, a core Factor Graph (FG) modeling hidden GO-term predictions and relationships is created. In the second step, the FG is enriched with nodes modeling observable GO-term predictions issued by **binary SVM classifiers**. In addition, probabilistic constraints modeling learning gaps between hidden and observable GO-term predictions are introduced. These gaps are assumed to be independent among GO-terms, locally additive with respect to observed predictions, and zero-mean Gaussian. **FGGA predictions** are issued by the native iterative **message passing algorithm** of factor graphs.

#### Package

fgga 1.18.0

# Contents

* [1 Automated Gene Ontology (GO) annotation methods](#automated-gene-ontology-go-annotation-methods)
* [2 Installation](#installation)
* [3 Input data](#input-data)
* [4 An example of the usage of FGGA for the automated GO annotation](#an-example-of-the-usage-of-fgga-for-the-automated-go-annotation)
  + [4.1 Data Loading](#data-loading)
  + [4.2 GO subgraph building](#go-subgraph-building)
  + [4.3 Matching a GO-DAG to a Factor Graph](#matching-a-go-dag-to-a-factor-graph)
  + [4.4 Flat prediction with FGGA clasiffier](#flat-prediction-with-fgga-clasiffier)
  + [4.5 Compute marginal probabilities of GO-terms by each protein](#compute-marginal-probabilities-of-go-terms-by-each-protein)
* [5 FGGA Performance](#fgga-performance)
* [6 References](#references)
* **Appendix**

# 1 Automated Gene Ontology (GO) annotation methods

As volume of genomic data grows, computational methods become essential for providing a first glimpse onto gene annotations. Automated Gene Ontology (GO) annotation methods based on hierarchical ensemble classification techniques are particularly interesting when interpretability of annotation results is a main concern. In these methods, raw GO-term predictions computed by base binary classifiers are leveraged by checking the consistency of predefined GO relationships. FGGA is a factor graph approach to the hierarchical ensemble formulation of the automated GO annotation problem. In this formal method, a core factor graph is first built based on the GO structure and then enriched to take into account the noisy nature of GO-term predictions. Hence, starting from raw GO-term predictions, an iterative message passing algorithm between nodes of the factor graph is used to compute marginal probabilities of target GO-terms.

The method is detailed in the original [publications](#references) [1, 2], but this brief **vignette** explains how to use **FGGA** to predict a set of GO-terms (GO node labels) from gene-product sequences of a given organism. The aim is to improve the quality of existing electronic annotations and provide a new annotation for those unknown sequences that can not be classified by traditional methods such as Blast.

Thus, **FGGA** is a tool to the automated annotation of protein sequences, however, the annotation of other types of striking functional gene products is also possible, e.g., long non-coding RNAs. FGGA may bring an opportunity for improving the annotation of long non-coding RNA sequences through boosting the confidence of base binary classifiers by the characterization of their structures primary, secondary and tertiary. Along the vignette, we used protein coding genes data from Cannis familiaris organism obtained with [UniProt](https://www.uniprot.org/uniprot/?query=taxonomy:9615).

![](data:image/png;base64...)

Fig. 1 - Workflow of FGGA algorithm.

# 2 Installation

The **fgga** R source package can be downloaded from [**Bioconductor repository**](https://bioconductor.org/) or [**GitHub repository**](https://github.com/fspetale/fgga). This R package contains a experimental dataset as example, one pre-run R object and all functions needed to run FGGA.

```
## From Bioconductor repository
if (!requireNamespace("BiocManager", quietly = TRUE)) {
        install.packages("BiocManager")
    }
BiocManager::install("fgga")

## Or from GitHub repository using devtools
BiocManager::install("devtools")
devtools::install_github("fspetale/fgga")
```

After the package is installed, it can be loaded into R workspace by

```
library(fgga)
```

# 3 Input data

At present, the method directly supports data characterized from gene product sequences. This characterization can be generated according to the expert’s criteria. For example, possible characterizations can be: [PFAM motifs](https://pfam.xfam.org/), [physico-chemical properties](https://web.expasy.org/protparam/), [signal peptides](http://www.cbs.dtu.dk/services/), among others. The admitted values can be of the numeric, boolean or character type. However, for greater efficiency of the binary classification algorithm it is recommended that the use of normalized numerical values. These datasets must have at least 50 annotations per GO-term to train the FGGA model.

# 4 An example of the usage of FGGA for the automated GO annotation

In this section, we apply **FGGA** to predict the biological functions, GO-terms, of *Canis lupus familiaris* proteins. We download 6962 *Canis lupus familiaris*, Cf, protein sequences with their GO annotations from [UniProt](https://www.uniprot.org/uniprot/?query=taxonomy:9615) and then were characterized through physico-chemical properties from R package [Peptides](https://cran.r-project.org/web/packages/Peptides).

## 4.1 Data Loading

Let us import the toy dataset in the workspace:

```
# Loading Canis lupus familiaris dataset and example R objects
data(CfData)
```

```
# To see the summarized experiment object
summary(CfData)
#>             Length Class  Mode
#> dxCf        501264 -none- numeric
#> graphCfGO     1296 -none- numeric
#> indexGO          2 -none- list
#> tableCfGO   250632 -none- numeric
#> nodesGO         36 -none- character
#> varianceGOs     36 -none- numeric

# To see the information of characterized data
dim(CfData$dxCf)
#> [1] 6962   72

colnames(CfData$dxCf)[1:20]
#>  [1] "Numb_Amino" "A"          "C"          "D"          "E"          "F"          "G"
#>  [8] "H"          "I"          "K"          "L"          "M"          "N"          "P"
#> [15] "Q"          "R"          "S"          "T"          "V"          "W"

rownames(CfData$dxCf)[1:10]
#>  [1] "E2QTB2" "F1PQ93" "E2RQU4" "E2RN67" "E2RGI4" "E2RFJ5" "J9P0Z9" "E2RL61" "F1PAF1" "J9P1G2"

head.matrix(CfData$dxCf[, 51:61], n = 10)
#>           pK.C Surrounding.hydrop Mol.weight     pI Pos_charged_res2 Pos_changed_res3
#> E2QTB2 -0.0790             0.0474   58225.55 4.9492           0.1175           0.1368
#> F1PQ93 -0.0953             0.0494   27833.13 4.6956           0.1250           0.1371
#> E2RQU4 -0.0117             0.1234   83933.57 9.0031           0.1344           0.1694
#> E2RN67  0.0185             0.0424   73821.11 7.9705           0.0848           0.1161
#> E2RGI4  0.0715             0.0368   28713.98 5.3223           0.1304           0.1423
#> E2RFJ5 -0.0194             0.0066   30101.85 4.6895           0.1049           0.1199
#> J9P0Z9  0.0010             0.0619   67510.79 6.3768           0.1267           0.1467
#> E2RL61 -0.0559             0.0226  163422.56 5.6757           0.1291           0.1463
#> F1PAF1 -0.0407            -0.0550  107808.45 5.4839           0.0932           0.1087
#> J9P1G2 -0.1119             0.0330   26295.98 9.1588           0.1040           0.1200
#>        Neg_changed_res Carbon Hydrogen Nitrogen Oxygen
#> E2QTB2          0.1676   2518     3935      739    816
#> F1PQ93          0.1976   1209     1922      330    402
#> E2RQU4          0.1183   3779     5963     1033   1083
#> E2RN67          0.0818   3374     5180      910    914
#> E2RGI4          0.1542   1289     2035      331    387
#> E2RFJ5          0.1723   1327     2072      348    426
#> J9P0Z9          0.1333   3003     4694      808    908
#> E2RL61          0.1470   7269    11378     2012   2209
#> F1PAF1          0.1118   4755     7406     1294   1451
#> J9P1G2          0.0800   1166     1842      328    347

# to see the information of GO data
dim(CfData$tableCfGO)
#> [1] 6962   36

colnames(CfData$tableCfGO)[1:10]
#>  [1] "GO:0000166" "GO:0003674" "GO:0003676" "GO:0003677" "GO:0003824" "GO:0004888" "GO:0005102"
#>  [8] "GO:0005215" "GO:0005488" "GO:0005515"

rownames(CfData$tableCfGO)[1:10]
#>  [1] "E2QTB2" "F1PQ93" "E2RQU4" "E2RN67" "E2RGI4" "E2RFJ5" "J9P0Z9" "E2RL61" "F1PAF1" "J9P1G2"

head(CfData$tableCfGO)[, 1:8]
#>        GO:0000166 GO:0003674 GO:0003676 GO:0003677 GO:0003824 GO:0004888 GO:0005102 GO:0005215
#> E2QTB2          0          1          1          0          0          0          0          0
#> F1PQ93          0          1          0          0          0          0          0          0
#> E2RQU4          1          1          0          0          1          0          0          0
#> E2RN67          0          1          0          0          1          0          0          0
#> E2RGI4          0          1          0          0          0          0          0          1
#> E2RFJ5          0          1          1          0          0          0          0          0
```

*tableCfGO* is a binary matrix whose \((i, j)\_{th}\) component is 1 if protein \(i\) is annotated with \(GO-term\_j\), 0 otherwise. Note that the row names of both dxCf and tableCfGO are identical. Our binary classifiers require at least 50 annotations per GO-terms. Therefore, this condition is checked and those GO-terms that do not comply are eliminated.

```
# Checking the amount of annotations by GO-term

apply(CfData$tableCfGO, MARGIN=2, sum)
#> GO:0000166 GO:0003674 GO:0003676 GO:0003677 GO:0003824 GO:0004888 GO:0005102 GO:0005215 GO:0005488
#>        995       6962       1558        857       2679        516        520        565       5183
#> GO:0005515 GO:0005524 GO:0008144 GO:0016740 GO:0016787 GO:0017076 GO:0019899 GO:0030554 GO:0032553
#>       2738        682        764       1040       1097        878        870        707        882
#> GO:0032555 GO:0032559 GO:0035639 GO:0036094 GO:0038023 GO:0042802 GO:0043167 GO:0043168 GO:0043169
#>        871        702        847       1147        593        656       2273       1232       1307
#> GO:0046872 GO:0060089 GO:0097159 GO:0097367 GO:0098772 GO:0140096 GO:0140110 GO:1901265 GO:1901363
#>       1274        610       2523        992        650        978        615        995       2498
```

## 4.2 GO subgraph building

If we want to predict GO-terms in a single subdomain, *BP, MF or CC* , we must build the GO-DAG associated with these GO-terms.

```
library(GO.db)
library(GOstats)

mygraph <- GOGraph(CfData$nodesGO, GOMFPARENTS)

# Delete root node called all
mygraph <- subGraph(CfData$nodesGO, mygraph)

# We adapt the graph to the format used by FGGA
mygraph <- t(as(mygraph, "matrix"))
mygraphGO <- as(mygraph, "graphNEL")

# We search the root GO-term
rootGO <- leaves(mygraphGO, "in")

rootGO
#> [1] "GO:0003674" "GO:0008144" "GO:0097159"

plot(mygraphGO)
```

![](data:image/png;base64...)

On the other hand, if you want to predict in two or three subdomains you should use the preCoreFG function. This function builds a graph respecting the GO constraints of inference and also links the GO-terms of the selected subdomains.

```
# We add GO-terms corresponding to Cellular Component subdomain
myGOs <- c(CfData[['nodesGO']], "GO:1902494", "GO:0032991", "GO:1990234",
            "GO:0005575")

# We build a graph respecting the GO constraints of inference to MF, CC and BP subdomains
mygraphGO <- preCoreFG(myGOs, domains="GOMF")

plot(mygraphGO)
```

![](data:image/png;base64...)

Fig. 3 - GO-Plus subgraph.

## 4.3 Matching a GO-DAG to a Factor Graph

Let’s a GO subgraph, GO-terms *GO:i* are mapped to binary-valued variable nodes \(x\_i\) of a factor graph while relationships between GO-terms are mapped to logical factor nodes \(f\_k\) describing valid *GO:i* configurations under the True Path Graph constraint.

```
modelFGGA <- fgga2bipartite(mygraphGO)
```

## 4.4 Flat prediction with FGGA clasiffier

Now, let’s use the MF subgraph to build our model of binary SVM classifiers with a training set of the Cf data.

```
# We take a subset of Cf data to train our model
idsTrain <- CfData$indexGO[["indexTrain"]][1:750]

# We build our model of binary SVM classifiers
modelSVMs <- lapply(CfData[["nodesGO"]], FUN = svmTrain,
                    tableOntoTerms = CfData[["tableCfGO"]][idsTrain, ],
                    dxCharacterized = CfData[["dxCf"]][idsTrain, ],
                    graphOnto = mygraphGO, kernelSVM = "radial")
```

```
# We calculate the reliability of each GO-term
varianceGOs <- varianceOnto(tableOntoTerms = CfData[["tableCfGO"]][idsTrain, ],
                        dxCharacterized = CfData[["dxCf"]][idsTrain, ],
                        kFold = 5, graphOnto = mygraphGO, rootNode = rootGO,
                        kernelSVM = "radial")

varianceGOs
```

```
#> GO:0000166 GO:0003674 GO:0003676 GO:0003677 GO:0003824 GO:0004888 GO:0005102 GO:0005215 GO:0005488
#>      1.401      0.001      2.591      1.545      3.344      1.434      1.476      1.785      3.896
#> GO:0005515 GO:0005524 GO:0008144 GO:0016740 GO:0016787 GO:0017076 GO:0019899 GO:0030554 GO:0032553
#>      3.153      0.911      1.039      2.026      2.428      1.128      2.171      0.891      0.960
#> GO:0032555 GO:0032559 GO:0035639 GO:0036094 GO:0038023 GO:0042802 GO:0043167 GO:0043168 GO:0043169
#>      1.014      0.949      0.975      1.243      1.770      1.383      2.982      1.654      2.973
#> GO:0046872 GO:0060089 GO:0097159 GO:0097367 GO:0098772 GO:0140096 GO:0140110 GO:1901265 GO:1901363
#>      3.070      1.548      3.112      1.431      1.839      2.205      1.745      1.429      3.135
```

Next, we predict each GO-terms from a test set using our model of binary SVM classifiers.

```
dxTestCharacterized <- CfData[["dxCf"]][CfData$indexGO[["indexTest"]][1:50], ]

matrixGOTest <- svmOnto(svmMoldel = modelSVMs,
                    dxCharacterized = dxTestCharacterized,
                    rootNode = rootGO,
                    varianceSVM = varianceGOs)

head(matrixGOTest)[,1:8]
#>        GO:0000166 GO:0003674 GO:0003676 GO:0003677 GO:0003824 GO:0004888 GO:0005102 GO:0005215
#> J9P8X1 0.42163447     0.9999  0.5673337 0.40277420  0.3213095 0.40449466  0.6434772  0.5724810
#> F1PVD9 0.15257140     0.9999  0.6810226 0.77342547  0.1875907 0.20751810  0.7009616  0.1716904
#> F1PTQ9 0.46202260     0.9999  0.5674606 0.33157825  0.3993549 0.38859086  0.3478986  0.1894946
#> E2R8P1 0.78094880     0.9999  0.2439744 0.14385536  0.5969643 0.63748941  0.2184415  0.3050734
#> F6UWV4 0.01187462     0.9999  0.1485072 0.07729759  0.5342228 0.06318607  0.7994885  0.6114300
#> E2RQR5 0.59798835     0.9999  0.1871167 0.03286376  0.5083126 0.25116606  0.1564732  0.4965275
```

## 4.5 Compute marginal probabilities of GO-terms by each protein

Once a factor graph model *FG* for the automated GO annotation problem has been defined, an iterative message passing algorithm between nodes of *FG* can be used to compute maximum a posteriori (MAP) estimates of variable nodes \(x\_i\) modeling actual *GO:i* annotations.

The function *msgFGGA* returns a matrix with *k* rows and *m* columns corresponding to the Cf proteins and MF GO-terms respectively.

```
matrixFGGATest <- t(apply(matrixGOTest, MARGIN = 1, FUN = msgFGGA,
                        matrixFGGA = modelFGGA, graphOnto = mygraphGO,
                        tmax = 50, epsilon = 0.001))

head(matrixFGGATest)[,1:8]
#>          GO:0000166 GO:0003674  GO:0003676   GO:0003677 GO:0003824  GO:0004888 GO:0005102
#> J9P8X1 2.526629e-01  1.0000000 0.515438915 0.2076428652  0.5789544 0.088775536  0.5840677
#> F1PVD9 1.164295e-02  1.0000000 0.827229415 0.6396055691  0.4614633 0.005966365  0.6741567
#> F1PTQ9 7.404091e-02  1.0000000 0.488310565 0.1618753567  0.6593767 0.277551394  0.3246322
#> E2R8P1 1.000000e+00  1.0000000 0.273746586 0.0393799137  0.9363221 0.195601007  0.1850547
#> F6UWV4 1.099937e-06  0.9999999 0.003899414 0.0003012219  0.9524774 0.003706036  0.4960777
#> E2RQR5 9.987481e-01  1.0000000 0.192093045 0.0063128429  0.8952768 0.010315160  0.1292278
#>        GO:0005215
#> J9P8X1  0.5724810
#> F1PVD9  0.1716904
#> F1PTQ9  0.1894946
#> E2R8P1  0.3050734
#> F6UWV4  0.6114300
#> E2RQR5  0.4965275
```

# 5 FGGA Performance

We now evaluate the performance of **FGGA** in terms of hierarchical F-score. The hierarchical classification performance metrics like the hierarchical precision (HP), the hierarchical recall (HR), and the hierarchical F-score (HF) measures [publications](#references) [3] properly recognize partially correct classifications and correspondingly penalize more distant or more superficial errors. The formulas of the hierarchical metrics are shown below:

\[
HP(s) = \frac{1}{\mid l(P\_{G}(s)) \mid} \hspace{1.25mm} \sum\_{q \hspace{0.5mm} \in \hspace{0.5mm} l(P\_{G}(s))} \hspace{1.5mm} \max\_{c \hspace{0.5mm} \in \hspace{0.5mm} l(C\_{G}(s))} \frac{\mid \uparrow c \hspace{1mm} \cap \uparrow q \mid}{\uparrow q}
\]

\[ HR(s) = \frac{1}{\mid l(C\_{G}(s)) \mid} \hspace{1.25mm} \sum\_{c \hspace{0.5mm} \in \hspace{0.5mm} (C\_{G}(s))} \hspace{1.5mm} \max\_{q \hspace{0.5mm} \in \hspace{0.5mm} l(P\_{G}(s))} \frac{\mid \uparrow c \hspace{1mm} \cap \uparrow q \mid}{\uparrow c}
\]

\[ HF(s) = \frac{2 \cdot HP \cdot HR}{HP + HR}
\]

```
fHierarchicalMeasures(CfData$tableCfGO[rownames(matrixFGGATest), ],
                        matrixFGGATest, mygraphGO)
#> $HP
#> [1] 0.676726
#>
#> $HR
#> [1] 0.8221254
#>
#> $HF
#> [1] 0.7279337
#>
#> $nSample
#> [1] 50
#>
#> $noEvalSample
#> logical(0)
```

Finally, we evaluate the performance of *FGGA* in terms of Area under the ROC Curve (AUC) and in terms of Precision x Recall (PxR). We use the R package [pROC](https://cran.r-project.org/web/packages/pROC), which provides functions to compute the performance measures we need.

```
# Computing F-score
Fs <- fMeasures(CfData$tableCfGO[rownames(matrixFGGATest), ], matrixFGGATest)

# Average F-score
Fs$perfByTerms[4]

library(pROC)

# Computing ROC curve to the first term
rocGO <- roc(CfData$tableCfGO[rownames(matrixFGGATest), 1],  matrixFGGATest[, 1])

# Average AUC the first term
auc(roc)

# Computing precision at different recall levels to the first term
rocGO <- roc(CfData$tableCfGO[rownames(matrixFGGATest), 1],
            matrixFGGATest[, 1], percent=TRUE)
PXR <- coords(rocGO, "all", ret = c("recall", "precision"), transpose = FALSE)

# Average PxR to the first term
apply(as.matrix(PXR$precision[!is.na(PXR$precision)]), MARGIN = 2, mean
```

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
#>  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
#> [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] GOstats_2.76.0       Category_2.76.0      Matrix_1.7-4         GO.db_3.22.0
#>  [5] AnnotationDbi_1.72.0 IRanges_2.44.0       S4Vectors_0.48.0     Biobase_2.70.0
#>  [9] fgga_1.18.0          RBGL_1.86.0          graph_1.88.0         BiocGenerics_0.56.0
#> [13] generics_0.1.4       BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0        xfun_0.53              bslib_0.9.0            httr2_1.2.1
#>  [5] lattice_0.22-7         bitops_1.0-9           vctrs_0.6.5            tools_4.5.1
#>  [9] curl_7.0.0             tibble_3.3.0           proxy_0.4-27           RSQLite_2.4.3
#> [13] blob_1.2.4             pkgconfig_2.0.3        dbplyr_2.5.1           AnnotationForge_1.52.0
#> [17] lifecycle_1.0.4        compiler_4.5.1         Biostrings_2.78.0      tinytex_0.57
#> [21] gRbase_2.0.3           Seqinfo_1.0.0          htmltools_0.5.8.1      class_7.3-23
#> [25] sass_0.4.10            RCurl_1.98-1.17        yaml_2.3.10            pillar_1.11.1
#> [29] crayon_1.5.3           jquerylib_0.1.4        cachem_1.1.0           magick_2.9.0
#> [33] genefilter_1.92.0      tidyselect_1.2.1       digest_0.6.37          dplyr_1.1.4
#> [37] purrr_1.1.0            bookdown_0.45          splines_4.5.1          fastmap_1.2.0
#> [41] grid_4.5.1             cli_3.6.5              magrittr_2.0.4         survival_3.8-3
#> [45] XML_3.99-0.19          GSEABase_1.72.0        e1071_1.7-16           filelock_1.0.3
#> [49] rappdirs_0.3.3         bit64_4.6.0-1          rmarkdown_2.30         XVector_0.50.0
#> [53] httr_1.4.7             matrixStats_1.5.0      igraph_2.2.1           bit_4.6.0
#> [57] png_0.1-8              memoise_2.0.1          evaluate_1.0.5         knitr_1.50
#> [61] BiocFileCache_3.0.0    rlang_1.1.6            Rcpp_1.1.0             xtable_1.8-4
#> [65] glue_1.8.0             DBI_1.2.3              Rgraphviz_2.54.0       BiocManager_1.30.26
#> [69] annotate_1.88.0        jsonlite_2.0.0         R6_2.6.1               MatrixGenerics_1.22.0
```

# 6 References

# Appendix

1: Spetale F.E., Tapia E., Krsticevic F., Roda F. and Bulacio P. “A Factor Graph Approach to Automated GO Annotation”. PLoS ONE 11(1): e0146986, 2016.

2: Spetale Flavio E., Arce D., Krsticevic F., Bulacio P. and Tapia E. “Consistent prediction of GO protein localization”. Scientific Report 7787(8), 2018

3: Verspoor K., Cohn J., Mnizewski S., Joslyn C. “A categorization approach to automated ontological function annotation”. Protein Science. 2006;15:1544–1549