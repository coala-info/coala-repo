# OPPAR: Outlier Profile and Pathway Analysis in R

#### Soroor Hediyehzadeh

#### 2025-10-30

Cancer Outlier Profile Analysis (COPA) is a common analysis to identify genes that might be down-regulated or up-regulated only in a proportion of samples with the codition of interest. OPPAR is the R implementation of modified COPA [(mCOPA)](http://jclinbioinformatics.biomedcentral.com/articles/10.1186/2043-9113-2-22) method, originally published by Chenwei Wang et al. in 2012. The aim is to identify genes that are outliers in samples with condition of interest, compared to normal samples. The methods implemented in OPPAR enable the users to perform the analysis in various ways, namely detecting outlier features in control versus condition samples (whether or not there is a information on subtypes), and detecting genes that are outlier in one subtype compared to the other samples, if the subtypes are known.

OPPAR can also be used for Gene Set Enrichment Analysis (GSEA). Here, a modified version of [GSVA](http://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-14-7) method is implemented. GSVA can be used to determine which samples in the study are enriched for gene expression signatures that are of interest. The `gsva` function in GSVA package returns an enrichment score for each sample, for the given signatures/gene sets. With the current implementation of the method, samples that strongly show enrichment for down(-regulated) gene expression signatures will receive negative scores. However, Often it is in the interest of the biologists and researchers to get positive scores for samples that are enriched in both up and down signatures. Therefore, the `gsva` function has been modified to assign positive scores to samples that are enriched for the up-regulated and down-regulated gene expression signatures.

OPPAR comes with four functions:

* **opa()** generates the outlier profile using the method described in [mcopa](http://jclinbioinformatics.biomedcentral.com/articles/10.1186/2043-9113-2-22)
* **getSampleOutlier()** is used to extract the outliers detected for a given sample(s)
* **getSubtypeProbes()** is used to extract the outliers for a group of related samples e.g subtypes
* **gsva()** A modified version of gsva function in GSVA package is presented here. The original function returns negative enrichment scores (es) for samples that are enriched for a gene list of down-regulated gene signature. However, it is often of interest of researchers to obtain positive scores for samples that are enriched in both up gene signatures and down gene signatures. In the modified version the ranking is reversed for the genes in down gene signature, such that they receive high ranks and, therefore, high es scores. The es scores for samples in down gene signature is then added to the es scores in up gene signature resulting in large positive es scores for samples displaying enrichment in both up- regulated genes and down-regulated genes in a given gene signature.

This vignette illustrates a possible workflow for OPPAR, using [Tomlins et al.](http://www.nature.com/ng/journal/v39/n1/full/ng1935.html) prostate cancer [data](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE6099). In addition, [Maupin](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE23952)’s TGFb data have been analyzed for enrichement of a TGFb gene signature in the samples measured in this study.

**Please note although the analysis presented here have been done on microarray studies, one can apply oppar tools to RPKM values of gene expression measurements in NGS studies.**

---

# Analysis of Tomlins et al. prostate cancer dataset

Data was retrieved from GEO database, checked for normalization and subsetted according to procedure outlined in the mCOPA paper. In addition, probes with no annotation were removed. The `impute` package was used to impute the missing values using K-nearest neighbours method (k = 10). The subsetted dataset is available in the package as a sample data, and contains an ExpressionSet object, storing information on samples, genes and gene expressions. We apply `opa` on Tomlins et al. data, then use `getSubtypeProbes` to get all down- regulated and all up-regulated outliers.

`opa` returns the outlier profile matrix, which is a matrix of -1 ( for down-regulated outliers), 0 ( not an outlier) and 1 (up-regulated outlier). For more information see `?opa`

For a brief overview of `oppar` package and functions, please see `?oppar`

```
## Loading required package: knitr
```

```
## Warning: multiple methods tables found for 'gsva'
```

```
data(Tomlins) # loads processed Tomlins data
```

```
## Warning in data(Tomlins): data set 'Tomlins' not found
```

```
# the first 21 samples are Normal samples, and the rest of
# the samples are our cases (metastatic). We, thus, generate a group
# variable for the samples based on this knowledge.

g <- factor(c(rep(0,21),rep(1,ncol(exprs(eset)) - 21)))
g
```

```
##  [1] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
## [39] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
## [77] 1 1 1 1 1 1 1 1 1 1
## Levels: 0 1
```

```
# Apply opa on Tomlins data, to detect outliers relative to the
# lower 10% (lower.quantile = 0.1) and upper 5% (upper.quantile = 0.95 -- Default) of
# gene expressions.
tomlins.opa <- opa(eset, group = g, lower.quantile = 0.1)
tomlins.opa
```

```
## Object of type OPPARList
## Features: 663
## Samples: 65
## Upper quantile: 0.95
## Lower quantile: 0.10
## Groups:
##  [1] 1 1 1 1 1 1 1 1 1 1
## Levels: 0 1
```

The matrix containing the outlier profiles is called `profileMatrix` and can be accessed using the $ operator. The `upper.quantile` and `lower.quantile` parameters used to run the function can also be retrieved using this operator.

```
tomlins.opa$profileMatrix[1:6,1:5]
```

```
##             GSM141341 GSM141342 GSM141343 GSM141356 GSM141357
## Hs6-1-10-7          0         0         0         0         0
## Hs6-1-11-3          0         0         0         0         0
## Hs6-1-12-24         0         0         0         0         0
## Hs6-1-12-8          0         0         0         0         0
## Hs6-1-13-12         0         0         0         0         0
## Hs6-1-13-13         0         0         0         0         0
```

```
tomlins.opa$upper.quantile
```

```
## [1] 0.95
```

```
tomlins.opa$lower.quantile
```

```
## [1] 0.1
```

We can extract outlier profiles for any individual samples in the `profileMatrix`, using `getSampleOutlier`. see `?getSampleOutlier` for more detailed information

```
getSampleOutlier(tomlins.opa, c(1,5))
```

```
## $GSM141341.up
## [1] "Hs6-26-18-3"
##
## $GSM141341.down
## [1] "Hs6-17-9-11" "Hs6-2-11-4"
##
## $GSM141357.up
##  [1] "Hs6-10-22-5"  "Hs6-14-25-7"  "Hs6-15-22-3"  "Hs6-15-5-11"  "Hs6-16-2-15"
##  [6] "Hs6-16-9-2"   "Hs6-18-9-13"  "Hs6-20-13-20" "Hs6-20-7-7"   "Hs6-22-21-5"
## [11] "Hs6-26-23-5"  "Hs6-28-5-5"
##
## $GSM141357.down
## [1] "Hs6-13-3-14"  "Hs6-22-5-9"   "Hs6-24-7-23"  "Hs6-25-12-19" "Hs6-25-2-9"
```

Extracting down-regulated and up-regulated outliers in all samples using `getSubtypeProbes`:

```
outlier.list <- getSubtypeProbes(tomlins.opa, 1:ncol(tomlins.opa$profileMatrix))
```

We can then obtain a list of GO terms from `org.Hs.eg.db`. Each element of the list will be a GO terms with the Entrez gene IDs corresponding to that term. We can the apply `mroast` from `limma` package for multiple gene set enrichment testing.

```
# gene set testing with limma::mroast
#BiocManager::install(org.Hs.eg.db)
library(org.Hs.eg.db)
library(limma)
org.Hs.egGO2EG
```

```
## GO2EG map for Human (object of class "Go3AnnDbBimap")
```

```
go2eg <- as.list(org.Hs.egGO2EG)
head(go2eg)
```

```
## $`GO:0000012`
##         IDA         IDA         IDA         IDA         TAS         IEA
##      "1161"      "2074"      "3981"      "7141"      "7374"      "7515"
##         IMP         IMP         IBA         IDA         IEA         IMP
##      "7515"     "23411"     "54840"     "54840"     "54840"     "54840"
##         IDA         IDA         IEA         IMP         IMP         IEA
##     "55247"     "55775"     "55775"     "55775"    "200558" "100133315"
##
## $`GO:0000017`
##    IDA    IMP    ISS    IDA
## "6523" "6523" "6523" "6524"
##
## $`GO:0000018`
##     TAS     TAS     TAS     IEA     IEP
##  "3575"  "3836"  "3838" "51750" "56916"
##
## $`GO:0000019`
##     TAS     IDA
##  "4361" "10111"
##
## $`GO:0000022`
##    TAS    TAS
## "9055" "9493"
##
## $`GO:0000023`
##     IC
## "2548"
```

```
# Gene Set analysis using rost from limma

# need to subset gene express data based on up outliers
up.mtrx <- exprs(eset)[fData(eset)$ID %in% outlier.list[["up"]], ]
# get Entrez gene IDs for genes in up.mtrx

entrez.ids.up.mtrx <- fData(eset)$Gene.ID[fData(eset)$ID %in% rownames(up.mtrx)]

# find the index of genes in GO gene set in the gene expression matrix
gset.idx <- lapply(go2eg, function(x){
    match(x, entrez.ids.up.mtrx)
})

# remove missing values
gset.idx <- lapply(gset.idx, function(x){
    x[!is.na(x)]
})

# removing gene sets with less than 10 elements
gset.ls <- unlist(lapply(gset.idx, length))
gset.idx <- gset.idx[which(gset.ls > 10)]

# need to define a model.matrix for mroast
design <- model.matrix(~ g)
up.mroast <- mroast(up.mtrx, index = gset.idx, design = design)
head(up.mroast, n=5)
```

```
##            NGenes PropDown PropUp Direction PValue   FDR PValue.Mixed FDR.Mixed
## GO:0005576     30        0      1        Up  5e-04 5e-04        5e-04     5e-04
## GO:0005615     25        0      1        Up  5e-04 5e-04        5e-04     5e-04
## GO:0005813     20        0      1        Up  5e-04 5e-04        5e-04     5e-04
## GO:0051301     17        0      1        Up  5e-04 5e-04        5e-04     5e-04
## GO:0061630     16        0      1        Up  5e-04 5e-04        5e-04     5e-04
```

The GO terms for the first 10 GO Ids detected by `mroast` can be retrieved in the following way.

```
go.terms <- rownames(up.mroast[1:10,])
#BiocManager::install(GO.db)
library(GO.db)
columns(GO.db)
```

```
## [1] "DEFINITION" "GOID"       "ONTOLOGY"   "TERM"
```

```
keytypes(GO.db)
```

```
## [1] "DEFINITION" "GOID"       "ONTOLOGY"   "TERM"
```

```
r2tab <- select(GO.db, keys=go.terms,
                columns=c("GOID","TERM"),
                keytype="GOID")
r2tab
```

```
##          GOID                                         TERM
## 1  GO:0005576                         extracellular region
## 2  GO:0005615                          extracellular space
## 3  GO:0005813                                   centrosome
## 4  GO:0051301                                cell division
## 5  GO:0061630            ubiquitin protein ligase activity
## 6  GO:0007186 G protein-coupled receptor signaling pathway
## 7  GO:0006974                          DNA damage response
## 8  GO:0008017                          microtubule binding
## 9  GO:0005635                             nuclear envelope
## 10 GO:0007155                                cell adhesion
```

We repeating the above steps for down-regulated outliers, to see what GO terms they are enriched for.

```
library(org.Hs.eg.db)
library(limma)
org.Hs.egGO2EG
```

```
## GO2EG map for Human (object of class "Go3AnnDbBimap")
```

```
go2eg <- as.list(org.Hs.egGO2EG)
head(go2eg)
```

```
## $`GO:0000012`
##         IDA         IDA         IDA         IDA         TAS         IEA
##      "1161"      "2074"      "3981"      "7141"      "7374"      "7515"
##         IMP         IMP         IBA         IDA         IEA         IMP
##      "7515"     "23411"     "54840"     "54840"     "54840"     "54840"
##         IDA         IDA         IEA         IMP         IMP         IEA
##     "55247"     "55775"     "55775"     "55775"    "200558" "100133315"
##
## $`GO:0000017`
##    IDA    IMP    ISS    IDA
## "6523" "6523" "6523" "6524"
##
## $`GO:0000018`
##     TAS     TAS     TAS     IEA     IEP
##  "3575"  "3836"  "3838" "51750" "56916"
##
## $`GO:0000019`
##     TAS     IDA
##  "4361" "10111"
##
## $`GO:0000022`
##    TAS    TAS
## "9055" "9493"
##
## $`GO:0000023`
##     IC
## "2548"
```

```
# subsetting gene expression matrix based on down outliers
down_mtrx <- exprs(eset)[fData(eset)$ID %in% outlier.list[["down"]], ]
entrez_ids_down_mtrx <- fData(eset)$Gene.ID[fData(eset)$ID %in% rownames(down_mtrx)]

gset_idx_down <- lapply(go2eg, function(x){
    match(x, entrez_ids_down_mtrx)
})

# remove missing values
gset_idx_down <- lapply(gset_idx_down, function(x){
    x[!is.na(x)]
})

# removing gene sets with less than 10 elements
gset_ls_down <- unlist(lapply(gset_idx_down, length))
gset_idx_down <- gset_idx_down[which(gset_ls_down > 10)]

# apply mroast
down_mroast <- mroast(down_mtrx, gset_idx_down, design)
head(down_mroast, n=5)
```

```
##            NGenes PropDown PropUp Direction PValue   FDR PValue.Mixed FDR.Mixed
## GO:0042802     25        1      0      Down  5e-04 5e-04        5e-04     5e-04
## GO:0008270     23        1      0      Down  5e-04 5e-04        5e-04     5e-04
## GO:0005615     17        1      0      Down  5e-04 5e-04        5e-04     5e-04
## GO:0005813     16        1      0      Down  5e-04 5e-04        5e-04     5e-04
## GO:0007165     15        1      0      Down  5e-04 5e-04        5e-04     5e-04
```

And extract GO terms for the top 10 results:

```
go_terms_down <- rownames(down_mroast[1:10,])

dr2tab <- select(GO.db, keys=go_terms_down,
                columns=c("GOID","TERM"),
                keytype="GOID")
dr2tab
```

```
##          GOID                                     TERM
## 1  GO:0042802                identical protein binding
## 2  GO:0008270                         zinc ion binding
## 3  GO:0005615                      extracellular space
## 4  GO:0005813                               centrosome
## 5  GO:0007165                      signal transduction
## 6  GO:0031410                      cytoplasmic vesicle
## 7  GO:0016787                       hydrolase activity
## 8  GO:0000139                           Golgi membrane
## 9  GO:0048471          perinuclear region of cytoplasm
## 10 GO:0043066 negative regulation of apoptotic process
```

---

# Gene Set Enrichment Analysis

We are now going to perform enrichment analysis for on Maupin’s TGFb data (see `?maupin`), given a gene signature. The `maupin` data object contains a matrix containing gene expression measurements on 3 control samples and 3 TGFb induced samples. We run the modified gsva function introduced in this package to get one large positive scores for samples enriched in the given gene signature, both for down gene signature and up gene signature. This is while the original gsva function returns negative scores for samples that are enriched in down gene signature, and positive scores for samples enriched in up gene signature. Therefore, the scores returned by the gsva function in this package are the sum of the scores for up gene signature and down gene signature. Note that in order for the modified version of the gsva function to work properly, the `gset.idx.list` has to be a named list, with the up signature gene list being named ‘up’ and down gene signature gene list being names ‘down’ (see example code below). Also note that the `is.gset.list.up.down` argument has to be set to TRUE if the user wishes to use the modified version (i.e to get the sum of es scores for up and down gene signatures). See `?gsva` for more details.

```
data("Maupin")
names(maupin)
```

```
## [1] "data" "sig"
```

```
head(maupin$data)
```

```
##    M_Ctrl_R1 M_Ctrl_R2 M_Ctrl_R3 M_TGFb_R1 M_TGFb_R2 M_TGFb_R3
## 2   4.551955  4.391799  4.306602  4.738577  4.579810  4.576038
## 9   7.312850  7.155411  7.274249  7.520725  7.381180  7.279445
## 10  4.699286  4.625667  4.624420  4.613213  4.779147  4.845243
## 12  5.552299  5.806786  5.891174  6.976169  7.169206  7.200424
## 13  5.524958  5.341497  5.422172  5.569487  5.597191  5.585326
## 14  9.025984  9.075223  8.951924  9.062231  9.130251  9.204617
```

```
head(maupin$sig)
```

```
##   EntrezID  Symbol upDown_integrative_signature upDown_comparative_signature
## 1       19   ABCA1                            0                           up
## 2       87   ACTN1                            0                           up
## 3      136 ADORA2B                            0                         down
## 4      182    JAG1                           up                           up
## 5      220 ALDH1A3                         down                            0
## 6      224 ALDH3A2                            0                         down
##   upDown
## 1     up
## 2     up
## 3   down
## 4     up
## 5   down
## 6   down
```

```
geneSet<- maupin$sig$EntrezID    #Symbol  ##EntrezID # both up and down genes:

up_sig<- maupin$sig[maupin$sig$upDown == "up",]
d_sig<- maupin$sig[maupin$sig$upDown == "down",]
u_geneSet<- up_sig$EntrezID   #Symbol   # up_sig$Symbol  ## EntrezID
d_geneSet<- d_sig$EntrezID

enrichment_scores <- gsva(maupin$data, list(up = u_geneSet, down= d_geneSet), mx.diff=1,
               verbose=TRUE, abs.ranking=FALSE, is.gset.list.up.down=TRUE, parallel.sz = 1 )$es.obs
```

```
## Estimating GSVA scores for 2 gene sets.
## Computing observed enrichment scores
## Estimating ECDFs in microarray data with Gaussian kernels
## Using parallel with 1 cores
##   |                                                                              |                                                                      |   0%  |                                                                              |===================================                                   |  50%  |                                                                              |======================================================================| 100%
```

```
head(enrichment_scores)
```

```
##          M_Ctrl_R1  M_Ctrl_R2  M_Ctrl_R3 M_TGFb_R1 M_TGFb_R2 M_TGFb_R3
## GeneSet -0.8991905 -0.7841492 -0.8329552 0.9041564 0.7714735 0.8147947
```

```
## calculating enrichment scores using ssgsea method
# es.dif.ssg <- gsva(maupin, list(up = u_geneSet, down= d_geneSet),
#                                                        verbose=TRUE, abs.ranking=FALSE, is.gset.list.up.down=TRUE,
#                                                        method = "ssgsea")
```

A histogram of enrichment scores is plotted below and the density of es scores for TGFb samples is shown in red. The distribution of es scores of control samples is shown in blue. As it can be seen from the plot below, TGFb induced samples that are expected to be enriched in the given TGFb signature have received positive scores and are on the right side of the histogram, whereas the control samples are on the left side of the histogram. In addition, TGFb induced samples and contorl samples have been nicely separated from each other.

```
hist(enrichment_scores, main = "enrichment scores", xlab="es")
lines(density(enrichment_scores[,1:3]), col = "blue") # control samples
lines(density(enrichment_scores[,4:6]), col = "red") # TGFb samples
legend("topleft", c("Control","TGFb"), lty = 1, col=c("blue","red"), cex = 0.6)
```

![](data:image/png;base64...)