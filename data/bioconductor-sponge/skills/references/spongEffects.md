# spongeEffects.Rmd

#### Hoffmann M - Boniolo F

#### 2/10/2022

In recent years, competing endogenous RNA (ceRNA) networks have established themselves as promising tools to identify biomarkers and inspired the formulation of new hypotheses regarding the post-transcriptional regulatory role of microRNAs (miRNAs). While different studies have proven the potential of these regulatory networks, current methods only allow the study of their global characteristics. Here, we introduce spongEffects, a novel method that infers subnetworks from pre-calculated ceRNA networks and calculates patient/sample-specific scores related to their regulatory activity. Notably, these module scores can be inferred from gene expression data alone and can thus be applied to cohorts where miRNA expression information is lacking. In this vignette, we show how spongEffects can be used for ceRNA module identification and enrichment. We do so by showcasing its use in a reduced breast cancer dataset (TCGA-BRCA). Moreover, we illustrate how the identified modules can be exploited for further downstream subtype classification tasks and identification of biologically meaningfull ceRNA modules.

spongEffects has been developed as an add-on to the SPONGE package (List et al. 2019, <https://www.bioconductor.org/packages/release/bioc/html/SPONGE.html>). SPONGE allows the inference of robust ceRNA networks from gene and miRNA expression data.

Further details demonstrating the implementation and use of spongEffects for stratification and biomarker identification are available in the related manuscript (currently available as preprint at: <https://www.biorxiv.org/content/10.1101/2022.03.29.486212v1>).

1. Loading dependencies for spongEffects

We start with loading the package and its dependencies. spongEffects core functions allow for the registration of a parallel backend (if desired).

```
library(SPONGE)
library(doParallel)
library(foreach)
library(dplyr)

# Register your backend here
num.of.cores <- 4
cl <- makeCluster(num.of.cores)
registerDoParallel(cl)
```

2. Formats of the inputs necessary for spongEffect

spongEffects comes with a very small example datasetd useful for illustrating the functionalities of the package. The data were originally part of the TCGA-BRCA cohort. We downsized it to reduce the computational time required by the vignette.

We provide two gene and miRNA expression datasets together with related metadata, to simulate an optimal scenario where a train set and a test set are available. We also provide a small ceRNA network, gene-miRNA candidates, ceRNA network centrality measures (the ceRNA network and the centrality measures were created using the SPONGE vignette). While these are not required to run spongEffects (only gene expression and a pre-computed ceRNA network are), we want to showcase how to conduct a full downstream analysis of the ceRNA modules.

spongEffects requires a gene x sample expression matrix as input, with gene names as rownames. The type of gene identifier is up to the user but must be consistent between gene expression and ceRNA network. In this vignette we use Ensembl gene IDs.

The example datasets can be accessed once the SPONGE package is loaded:

Gene expression train set:

|  | TCGA-A1-A0SK | TCGA-A1-A0SN | TCGA-A2-A0CK | TCGA-A2-A0CM | TCGA-A2-A0EO | TCGA-A2-A0EP | TCGA-A2-A0EV | TCGA-A2-A0SY |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ENSG00000000005 | -6.4423792 | -2.0500792 | 5.1654208 | -6.4423792 | 1.7425208 | 5.6808208 | 3.5814208 | 3.8919208 |
| ENSG00000000419 | 0.6104042 | 1.2722042 | -0.6313958 | 0.7686042 | -0.3658958 | -0.5337958 | 0.0015042 | -0.6387958 |
| ENSG00000000457 | -1.0013698 | 0.2439302 | -0.3476698 | -0.5785698 | 0.1670302 | 0.7566302 | -0.0322698 | -0.3200698 |
| ENSG00000001460 | 0.3662063 | -0.5251937 | -0.0523937 | 0.9402063 | 0.1126063 | -0.9400937 | 0.4092063 | -0.2140937 |
| ENSG00000001497 | 1.1365396 | -0.6962604 | -0.0888604 | 0.6670396 | -0.1332604 | -0.5305604 | 0.1172396 | -0.3317604 |

Gene expression tes set:

|  | TCGA-4H-AAAK | TCGA-A2-A0EM | TCGA-A2-A0SW | TCGA-A2-A0T0 | TCGA-A2-A0T1 | TCGA-A2-A0YK | TCGA-A2-A1FZ | TCGA-A2-A25F |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ENSG00000000005 | -1.3183 | -2.4659 | 0.0580 | -5.5735 | -1.5105 | 0.0580 | 3.1653 | 2.5363 |
| ENSG00000000419 | 5.4256 | 5.1700 | 5.6268 | 5.9170 | 5.3413 | 5.4006 | 5.5242 | 5.3016 |
| ENSG00000000457 | 3.2602 | 4.0705 | 3.0252 | 3.0002 | 3.3003 | 4.1498 | 4.4700 | 2.5972 |
| ENSG00000001460 | 2.6371 | 2.9013 | 1.8643 | 1.7995 | 2.4934 | 2.7379 | 3.5596 | 1.6558 |
| ENSG00000001497 | 5.2906 | 5.0631 | 4.2669 | 5.4706 | 4.9084 | 4.4588 | 4.9533 | 4.9924 |

miRNA expression train set:

```
knitr::kable(train_cancer_mir_expr[1:5,1:8])
```

|  | TCGA-A1-A0SK | TCGA-A1-A0SN | TCGA-A2-A0CK | TCGA-A2-A0CM | TCGA-A2-A0EO | TCGA-A2-A0EP | TCGA-A2-A0EV | TCGA-A2-A0SY |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| MIMAT0000062 | -0.9498974 | -0.9260029 | 0.7448973 | -0.6404741 | -0.0926522 | 0.2434683 | -0.2048338 | -0.1754074 |
| MIMAT0000063 | 0.0924827 | -0.8716071 | 1.0787497 | -0.9931536 | 0.5592782 | 0.2478954 | -0.1611533 | 1.3213929 |
| MIMAT0000064 | -1.1953576 | -0.4072241 | 0.8010479 | -0.6455455 | 0.8571077 | 1.0259656 | 0.2368933 | 0.3306993 |
| MIMAT0000065 | 1.6249731 | -0.6466453 | -0.3711567 | 1.5371999 | 0.0170191 | -0.2394728 | -0.2496916 | -1.1082111 |
| MIMAT0000066 | 0.0112750 | -1.9443273 | -0.8010375 | 0.2618751 | 0.0433049 | -0.0584883 | -0.0338679 | -0.8529546 |

miRNA expression test set:

```
knitr::kable(test_cancer_mir_expr[1:5,1:8])
```

|  | TCGA-4H-AAAK | TCGA-A2-A0EM | TCGA-A2-A0SW | TCGA-A2-A0T0 | TCGA-A2-A0T1 | TCGA-A2-A0YK | TCGA-A2-A1FZ | TCGA-A2-A25F |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| MIMAT0000062 | 15.413594 | 15.089313 | 13.463049 | 14.208041 | 14.158120 | 14.547002 | 14.740135 | 14.263688 |
| MIMAT0000063 | 14.436443 | 15.224913 | 13.411917 | 14.858243 | 14.656125 | 14.900911 | 15.101607 | 15.460251 |
| MIMAT0000064 | 11.683468 | 11.384820 | 9.037705 | 9.583915 | 11.285468 | 11.883935 | 11.727708 | 11.827215 |
| MIMAT0000065 | 7.293012 | 8.175797 | 7.560531 | 8.262925 | 7.747067 | 7.019939 | 7.922954 | 7.505337 |
| MIMAT0000066 | 10.727595 | 10.369630 | 9.575009 | 9.448063 | 9.866870 | 8.955930 | 10.011460 | 9.916859 |

ceRNA network We use a ceRNA network computed with SPONGE (List et al. 2019) for the TCGA-BRCA dataset. The ceRNA network was downsized for this vignette.

ceRNA networks and related descriptive statistics computed for 22 TCGA datasets can be downloaded from SPONGEdb (Hoffmann et al, 2021): <https://exbio.wzw.tum.de/sponge/home>

```
knitr::kable(train_ceRNA_interactions[1:5,1:8])
```

| geneA | geneB | df | cor | pcor | mscor | p.val | p.adj |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ENSG00000000005 | ENSG00000028528 | 1 | 0.2341518 | 0.2032828 | 0.0308691 | 0.19 | 0.4810039 |
| ENSG00000000005 | ENSG00000059758 | 1 | 0.2479621 | 0.1969036 | 0.0510585 | 0.10 | 0.4575007 |
| ENSG00000000005 | ENSG00000080493 | 1 | 0.2184322 | 0.2182531 | 0.0001792 | 0.54 | 0.6252361 |
| ENSG00000000005 | ENSG00000092096 | 1 | 0.1792994 | 0.1426007 | 0.0366987 | 0.16 | 0.4575007 |
| ENSG00000000005 | ENSG00000107560 | 1 | 0.1762069 | 0.1765033 | -0.0002963 | 0.55 | 0.6314070 |

ceRNA networks downloaded from spongeDB come with centrality measures and other information specific to the downloaded network. Centrality measures are going to be used to define sponge modules.

```
knitr::kable(train_network_centralities[1:5,1:5])
```

| gene | degree | eigenvector | betweenness | page\_rank |
| --- | --- | --- | --- | --- |
| ENSG00000005073 | 2 | 0.0027093 | 235.0000 | 0.0031156 |
| ENSG00000008853 | 1 | 0.0000000 | 0.0000 | 0.0038610 |
| ENSG00000017427 | 3 | 0.0329487 | 196.5353 | 0.0030298 |
| ENSG00000030419 | 2 | 0.0940164 | 0.0000 | 0.0021653 |
| ENSG00000032219 | 10 | 0.6420192 | 1558.6639 | 0.0076750 |

Once calculated, spongEffects scores can be used for further downstream machine learning tasks. In this vignette, we will show how to use the to classifiy samples to different breast cancer subtypes (LuminalA, LuminalB, HER2+, Normal-like, and Basal). The user can use any metadata available for their own data.

Metadata train set

```
knitr::kable(train_cancer_metadata[1:5,1:8])
```

|  | sampleID | SUBTYPE | CANCER\_TYPE\_ACRONYM | OTHER\_PATIENT\_ID | AGE | SEX | AJCC\_PATHOLOGIC\_TUMOR\_STAGE | AJCC\_STAGING\_EDITION |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 108 | TCGA-A2-A4S3 | BRCA\_LumB | BRCA | 418C11E8-2670-48D5-BBF5-95B46BFF1201 | 59 | Female | STAGE IIB | 7TH |
| 125 | TCGA-A7-A26I | BRCA\_Basal | BRCA | b2ecbc0f-2c30-4200-8d5e-7b95424bcadb | 65 | Female | STAGE IIA | 7TH |
| 134 | TCGA-A7-A5ZW | BRCA\_LumA | BRCA | 523E24A2-51B9-4658-BE2F-42E5FCCEBB17 | 47 | Female | STAGE IIA | 7TH |
| 135 | TCGA-A7-A5ZX | BRCA\_LumA | BRCA | BA80DB4E-D899-4DA4-AE49-5263D98E1530 | 48 | Female | STAGE IIIC | 7TH |
| 136 | TCGA-A7-A6VV | BRCA\_Basal | BRCA | 57AF5C72-0D60-4A6B-B1B4-EC6DAB90F80F | 51 | Female | STAGE IIA | 7TH |

Metadata test set

```
knitr::kable(test_cancer_metadata[1:5,1:8])
```

|  | sampleID | SUBTYPE | CANCER\_TYPE\_ACRONYM | OTHER\_PATIENT\_ID | AGE | SEX | AJCC\_PATHOLOGIC\_TUMOR\_STAGE | AJCC\_STAGING\_EDITION |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 128 | TCGA-A7-A3RF | BRCA\_LumA | BRCA | 7451AF3C-ACC0-4D79-8429-6B8BE96911D8 | 79 | Female | STAGE IIA | 7TH |
| 143 | TCGA-A8-A06Q | BRCA\_LumB | BRCA | 281f70c5-876f-44b3-84fb-f2302f85e74c | 63 | Female | STAGE IIIA | 5TH |
| 161 | TCGA-A8-A07W | BRCA\_LumB | BRCA | 01263518-5f7c-49dc-8d7e-84b0c03a6a63 | 76 | Female | STAGE IV | 6TH |
| 167 | TCGA-A8-A08A | BRCA\_LumA | BRCA | 7fe4670d-4626-459d-869b-ab15f478c6a7 | 89 | Female | STAGE I | 5TH |
| 202 | TCGA-A8-A0A9 | BRCA\_LumA | BRCA | 7b605fb6-d077-401e-b870-b87ddf505f82 | 80 | Female | STAGE IIA | 6TH |

3. Filter ceRNA network and add weighted centrality measures information Computationally inferred ceRNA networks often identify spurious associations between RNAs. Therefore, it is good practice to filter out ceRNA networks for weakly associated edges. More at List et al. 2019 and related vignette. In this example, we filter the ceRNA network for size effects (i.e. mscor) and statistical significance. Next, we want to identify the most important nodes in the network as seed genes for ceRNA modules. Various network centrality measures have been proposed in the literature to assess node importance. In the spongEffects paper and in this example, we used a weighted centrality, i.e. we consider the sum of weights of edges attached to a node rather than just the node degree. Node centralities can be computed via the `sponge_node_centralities()` function. The thresholds used here are purely indicative and are likely to be modified when real data are used. If you want to use the centralities of the unfiltered network, you can add your centralities to the Node\_Centrality parameter of the `filter_ceRNA_network()` function. The centralities will be filtered and returned accordingly. If you want the centralities newly caculated based on the filtered network, you need to use the `sponge_node_centralities()` function on the filtered ceRNA network returned from the `filter_ceRNA_network()` function.

```
filtered_network_centralities=filter_ceRNA_network(sponge_effects = train_ceRNA_interactions, Node_Centrality = train_network_centralities,add_weighted_centrality=T, mscor.threshold = 0.01, padj.threshold = 0.1)
```

4. Discover modules Different classes of RNAs can be investigated as central nodes for the SPONGE modules. The user can identify their own class of interest, by modifying the filtering function or by using their own gene names. The data.frame loaded with the package contains gene ensemble IDs for protein coding, long non-coding, and circular RNAs as downloaded from biomaRt (version 2.50.3, see <https://www.bioconductor.org/packages/release/bioc/vignettes/biomaRt/inst/doc/biomaRt.html>). Finally, it is possible to determine the type of degree centrality used to rank the importance of potential central nodes. Possibilities are: degree, eigenvector, betweenness, page\_rank, or Weighted\_Degree

Different number of central nodes can be selected via the cutoff parameter.

```
RNAs <- c("lncRNA","protein_coding")
RNAs.ofInterest <- ensembl.df %>% dplyr::filter(gene_biotype %in% RNAs) %>%
  dplyr::select(ensembl_gene_id)

central_gene_modules<-get_central_modules(central_nodes = RNAs.ofInterest$ensembl_gene_id,node_centrality = filtered_network_centralities$Node_Centrality,ceRNA_class = RNAs, centrality_measure = "Weighted_Degree", cutoff = 10)
```

5. Define SPONGE modules We define SPONGE modules based on a first-neighbout approach, taking into account all classes of potential RNAs around the central nodes identified above. We give the possibility to the user to consider the central node as part of the module or not (remove.central).

```
Sponge.modules <- define_modules(network = filtered_network_centralities$Sponge.filtered, central.modules = central_gene_modules, remove.central = F, set.parallel = F)
# Module size distribution
Size.modules <- sapply(Sponge.modules, length)
```

6. Calculate Enrichment Scores (i.e., spongEffects scores) we implemented three different single sample gene set enrichment approaches to score the modules per sample, Overall Enrichment (OE), single-sample Gene Set Enrichment Analysis (ssGSEA), and Gene Set Variation Analysis (GSVA). The choice of the optimal method may vary by the data set but when we compared the three algorithms in the spongEffects paper we did not observe large differences.

Here, we calculate the spongEffects scores both for the train and test dataset. In a real word scenarios, these are expected to be generated separately. SPONGE modules inferred on one dataset are expected to generalize well to new cohorts, as described in the original publication.

For this example, we run the OE algorithm

```
train.modules <- enrichment_modules(Expr.matrix = train_cancer_gene_expr, modules = Sponge.modules, bin.size = 10, min.size = 1, max.size = 2000, min.expr = 1, method = "OE", cores=1)
```

```
## [1] "Calculating modules with bin size: 10, min size: 1, max size:2000"
```

```
test.modules <-  enrichment_modules(Expr.matrix = test_cancer_gene_expr, modules = Sponge.modules, bin.size = 10, min.size = 1, max.size = 2000, min.expr = 1, method = "OE", cores=1)
```

```
## [1] "Calculating modules with bin size: 10, min size: 1, max size:2000"
```

7. Machine learning spongEffects scores have a tabular format (module x patient) and can thus be used for downstream analysis tasks as, for example, classification or regression. As a typical application case, we show how to calibrate a subtype classification model. In particular, we train a random forest via k-fold repeated cross validation. The resulting object contains the trained model and a confusion matrix evaluated on the train set.

N.B. In order to use a validate a model calibrated with the caret package (as done here), it is necessary that the test set contains the same input features (i.e., SPONGE modules here) as the train set.

```
# We find modules that were identified both in the train and test and use those as input features for the model
common_modules = intersect(rownames(train.modules), rownames(test.modules))
train.modules = train.modules[common_modules, ]
test.modules = test.modules[common_modules, ]

trained.model = calibrate_model(Input = train.modules, modules_metadata = train_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID",Metric = "Exact_match", n_folds = 2, repetitions = 1)

trained.model[["ConfusionMatrix_training"]]
```

```
## Confusion Matrix and Statistics
##
##              Reference
## Prediction    BRCA_Basal BRCA_Her2 BRCA_LumA BRCA_LumB BRCA_Normal
##   BRCA_Basal           7         0         4         5           1
##   BRCA_Her2            0         1         5         3           0
##   BRCA_LumA            5         6        31        13           2
##   BRCA_LumB            4         3         5         1           0
##   BRCA_Normal          0         0         0         0           0
##
## Overall Statistics
##
##                Accuracy : 0.4167
##                  95% CI : (0.3168, 0.5218)
##     No Information Rate : 0.4688
##     P-Value [Acc > NIR] : 0.8699
##
##                   Kappa : 0.1044
##
##  Mcnemar's Test P-Value : NA
##
## Statistics by Class:
##
##                      Class: BRCA_Basal Class: BRCA_Her2 Class: BRCA_LumA
## Sensitivity                    0.43750          0.10000           0.6889
## Specificity                    0.87500          0.90698           0.4902
## Pos Pred Value                 0.41176          0.11111           0.5439
## Neg Pred Value                 0.88608          0.89655           0.6410
## Prevalence                     0.16667          0.10417           0.4688
## Detection Rate                 0.07292          0.01042           0.3229
## Detection Prevalence           0.17708          0.09375           0.5938
## Balanced Accuracy              0.65625          0.50349           0.5895
##                      Class: BRCA_LumB Class: BRCA_Normal
## Sensitivity                   0.04545            0.00000
## Specificity                   0.83784            1.00000
## Pos Pred Value                0.07692                NaN
## Neg Pred Value                0.74699            0.96875
## Prevalence                    0.22917            0.03125
## Detection Rate                0.01042            0.00000
## Detection Prevalence          0.13542            0.00000
## Balanced Accuracy             0.44165            0.50000
```

As in a typical scenario, the model performances can be evaluated on the test set to test for generalization performances of the model.

```
Input.test <- t(test.modules) %>% scale(center = T, scale = T)
Prediction.model <- predict(trained.model$Model, Input.test)

# We compute the confusion metrix on the test set
ConfusionMatrix_testing <- caret::confusionMatrix(as.factor(Prediction.model), as.factor(test_cancer_metadata$SUBTYPE))
trained.model$ConfusionMatrix_testing<-ConfusionMatrix_testing
ConfusionMatrix_testing
```

```
## Confusion Matrix and Statistics
##
##              Reference
## Prediction    BRCA_Basal BRCA_Her2 BRCA_LumA BRCA_LumB BRCA_Normal
##   BRCA_Basal           0         0         6         1           0
##   BRCA_Her2            2         0         3         0           0
##   BRCA_LumA           14         4        29        11           2
##   BRCA_LumB            5         2        13         2           1
##   BRCA_Normal          0         0         0         0           0
##
## Overall Statistics
##
##                Accuracy : 0.3263
##                  95% CI : (0.2336, 0.4302)
##     No Information Rate : 0.5368
##     P-Value [Acc > NIR] : 1
##
##                   Kappa : -0.1123
##
##  Mcnemar's Test P-Value : NA
##
## Statistics by Class:
##
##                      Class: BRCA_Basal Class: BRCA_Her2 Class: BRCA_LumA
## Sensitivity                    0.00000          0.00000           0.5686
## Specificity                    0.90541          0.94382           0.2955
## Pos Pred Value                 0.00000          0.00000           0.4833
## Neg Pred Value                 0.76136          0.93333           0.3714
## Prevalence                     0.22105          0.06316           0.5368
## Detection Rate                 0.00000          0.00000           0.3053
## Detection Prevalence           0.07368          0.05263           0.6316
## Balanced Accuracy              0.45270          0.47191           0.4320
##                      Class: BRCA_LumB Class: BRCA_Normal
## Sensitivity                   0.14286            0.00000
## Specificity                   0.74074            1.00000
## Pos Pred Value                0.08696                NaN
## Neg Pred Value                0.83333            0.96842
## Prevalence                    0.14737            0.03158
## Detection Rate                0.02105            0.00000
## Detection Prevalence          0.24211            0.00000
## Balanced Accuracy             0.44180            0.50000
```

10. 2. Define random modules and calculate spongEffects scores In general, it is good idea to check the performance of a model calibrated on SPONGE modules against the one of a model calibrated on randomly defined modules. We offer a function that calculates random modules and related enrichment scores. The resulting modules have the same size distribution of the original ones.

```
# Define random modules
Random.modules <- Random_spongEffects(sponge_modules = Sponge.modules,
                                      gene_expr = train_cancer_gene_expr, min.size = 1,bin.size = 10, max.size = 200,
                                      min.expression=1, replace = F,method = "OE",cores = 1)
```

```
## [1] "Calculating modules with bin size: 10, min size: 1, max size:200"
```

```
# We can now use the randomly defined modules to calculate their enrichment in the test set
Random.modules.test <- enrichment_modules(Expr.matrix = test_cancer_gene_expr, modules = Random.modules$Random_Modules, bin.size = 10, min.size = 1, max.size = 2000, min.expr = 1, method = "OE", cores=1)
```

```
## [1] "Calculating modules with bin size: 10, min size: 1, max size:2000"
```

Train classification model on randomly defined modules

```
# We find random modules that were identified both in the train and test and use those as input features for the model
common_modules_random = intersect(rownames(Random.modules$Enrichment_Random_Modules), rownames(Random.modules.test))
Random.modules.train = Random.modules$Enrichment_Random_Modules[common_modules_random, ]
Random.modules.test = Random.modules.test[common_modules_random, ]

Random.model = calibrate_model(Input = Random.modules.train, modules_metadata = train_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID",Metric = "Exact_match", n_folds = 2, repetitions = 1)

Random.model[["ConfusionMatrix_training"]]
```

```
## Confusion Matrix and Statistics
##
##              Reference
## Prediction    BRCA_Basal BRCA_Her2 BRCA_LumA BRCA_LumB BRCA_Normal
##   BRCA_Basal           5         3         1         5           0
##   BRCA_Her2            1         0         0         3           0
##   BRCA_LumA            6         4        37         6           3
##   BRCA_LumB            4         3         6         8           0
##   BRCA_Normal          0         0         1         0           0
##
## Overall Statistics
##
##                Accuracy : 0.5208
##                  95% CI : (0.4164, 0.6239)
##     No Information Rate : 0.4688
##     P-Value [Acc > NIR] : 0.1786
##
##                   Kappa : 0.2599
##
##  Mcnemar's Test P-Value : NA
##
## Statistics by Class:
##
##                      Class: BRCA_Basal Class: BRCA_Her2 Class: BRCA_LumA
## Sensitivity                    0.31250          0.00000           0.8222
## Specificity                    0.88750          0.95349           0.6275
## Pos Pred Value                 0.35714          0.00000           0.6607
## Neg Pred Value                 0.86585          0.89130           0.8000
## Prevalence                     0.16667          0.10417           0.4688
## Detection Rate                 0.05208          0.00000           0.3854
## Detection Prevalence           0.14583          0.04167           0.5833
## Balanced Accuracy              0.60000          0.47674           0.7248
##                      Class: BRCA_LumB Class: BRCA_Normal
## Sensitivity                   0.36364            0.00000
## Specificity                   0.82432            0.98925
## Pos Pred Value                0.38095            0.00000
## Neg Pred Value                0.81333            0.96842
## Prevalence                    0.22917            0.03125
## Detection Rate                0.08333            0.00000
## Detection Prevalence          0.21875            0.01042
## Balanced Accuracy             0.59398            0.49462
```

Validate classification model of randomly defined modules on the test set

```
Input.test <- t(Random.modules.test) %>% scale(center = T, scale = T)
Input.test<-Input.test[ , apply(Input.test, 2, function(x) !any(is.na(x)))]

Prediction.model <- predict(Random.model$Model, Input.test)

# We compute the confusion metrix on the test set
ConfusionMatrix_testing_random <- caret::confusionMatrix(as.factor(Prediction.model), as.factor(test_cancer_metadata$SUBTYPE))
Random.model$ConfusionMatrix_testing_random<-ConfusionMatrix_testing_random
ConfusionMatrix_testing_random
```

```
## Confusion Matrix and Statistics
##
##              Reference
## Prediction    BRCA_Basal BRCA_Her2 BRCA_LumA BRCA_LumB BRCA_Normal
##   BRCA_Basal           1         2        12         2           0
##   BRCA_Her2            1         0         0         0           0
##   BRCA_LumA           14         3        21         8           2
##   BRCA_LumB            5         1        18         4           1
##   BRCA_Normal          0         0         0         0           0
##
## Overall Statistics
##
##                Accuracy : 0.2737
##                  95% CI : (0.1872, 0.3748)
##     No Information Rate : 0.5368
##     P-Value [Acc > NIR] : 1
##
##                   Kappa : -0.1286
##
##  Mcnemar's Test P-Value : NA
##
## Statistics by Class:
##
##                      Class: BRCA_Basal Class: BRCA_Her2 Class: BRCA_LumA
## Sensitivity                    0.04762          0.00000           0.4118
## Specificity                    0.78378          0.98876           0.3864
## Pos Pred Value                 0.05882          0.00000           0.4375
## Neg Pred Value                 0.74359          0.93617           0.3617
## Prevalence                     0.22105          0.06316           0.5368
## Detection Rate                 0.01053          0.00000           0.2211
## Detection Prevalence           0.17895          0.01053           0.5053
## Balanced Accuracy              0.41570          0.49438           0.3991
##                      Class: BRCA_LumB Class: BRCA_Normal
## Sensitivity                   0.28571            0.00000
## Specificity                   0.69136            1.00000
## Pos Pred Value                0.13793                NaN
## Neg Pred Value                0.84848            0.96842
## Prevalence                    0.14737            0.03158
## Detection Rate                0.04211            0.00000
## Detection Prevalence          0.30526            0.00000
## Balanced Accuracy             0.48854            0.50000
```

11. Train model on central genes’expression Another way to evaluate the perfomance of the model trained on spongEffects scores is to compare its performances against a model trained on the central genes alone. The idea is to investigate if the module activity that reflects the contribution of miRNA regulation offers additional insights to the expression level of the central genes alone. Thus, as a baseline mode we use only the central genes part of the modules we used to calibrate the model in step G.

Once again, we need to verify that both train and test sets contain all the central genes of interest before model calibration.

```
Input.centralgenes.train <- train_cancer_gene_expr[rownames(train_cancer_gene_expr) %in% names(Sponge.modules), ]
Input.centralgenes.test <- test_cancer_gene_expr[rownames(test_cancer_gene_expr) %in% names(Sponge.modules), ]

common_modules = intersect(rownames(Input.centralgenes.train), rownames(Input.centralgenes.test))
Input.centralgenes.train = Input.centralgenes.train[common_modules, ]
Input.centralgenes.test = Input.centralgenes.test[common_modules, ]

# Calibrate model
CentralGenes.model = calibrate_model(Input = Input.centralgenes.train, modules_metadata = train_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID",Metric = "Exact_match", n_folds = 1, repetitions = 1)

# Validate on test set
Input.centralgenes.test <- t(Input.centralgenes.test) %>% scale(center = T, scale = T)
CentralGenes.prediction <- predict(CentralGenes.model$Model, Input.centralgenes.test)

# We compute the confusion metrix on the test set
ConfusionMatrix_testing <- caret::confusionMatrix(as.factor(CentralGenes.prediction), as.factor(test_cancer_metadata$SUBTYPE))
CentralGenes.model$ConfusionMatrix_testing<-ConfusionMatrix_testing
ConfusionMatrix_testing
```

```
## Confusion Matrix and Statistics
##
##              Reference
## Prediction    BRCA_Basal BRCA_Her2 BRCA_LumA BRCA_LumB BRCA_Normal
##   BRCA_Basal           1         2        11         2           1
##   BRCA_Her2            0         0         1         0           0
##   BRCA_LumA           19         4        32        12           2
##   BRCA_LumB            1         0         7         0           0
##   BRCA_Normal          0         0         0         0           0
##
## Overall Statistics
##
##                Accuracy : 0.3474
##                  95% CI : (0.2526, 0.452)
##     No Information Rate : 0.5368
##     P-Value [Acc > NIR] : 0.9999
##
##                   Kappa : -0.1707
##
##  Mcnemar's Test P-Value : NA
##
## Statistics by Class:
##
##                      Class: BRCA_Basal Class: BRCA_Her2 Class: BRCA_LumA
## Sensitivity                    0.04762          0.00000           0.6275
## Specificity                    0.78378          0.98876           0.1591
## Pos Pred Value                 0.05882          0.00000           0.4638
## Neg Pred Value                 0.74359          0.93617           0.2692
## Prevalence                     0.22105          0.06316           0.5368
## Detection Rate                 0.01053          0.00000           0.3368
## Detection Prevalence           0.17895          0.01053           0.7263
## Balanced Accuracy              0.41570          0.49438           0.3933
##                      Class: BRCA_LumB Class: BRCA_Normal
## Sensitivity                   0.00000            0.00000
## Specificity                   0.90123            1.00000
## Pos Pred Value                0.00000                NaN
## Neg Pred Value                0.83908            0.96842
## Prevalence                    0.14737            0.03158
## Detection Rate                0.00000            0.00000
## Detection Prevalence          0.08421            0.00000
## Balanced Accuracy             0.45062            0.50000
```

It is possible to compare the performances of the different models

```
plot_accuracy_sensitivity_specificity(trained_model=trained.model,central_genes_model=NA,
                                      random_model= Random.model,
                                      training_dataset_name="TCGA",testing_dataset_name="TCGA",
                                      subtypes=as.factor(test_cancer_metadata$SUBTYPE))
```

![](data:image/png;base64...)

17. Interpretation of the results We offer here a few ways to visualize and interpret the SPONGE modules obtained via spongEffects. First, we visualize modules driving subtype prediction. These could be of interest for further validation, to identify biomarkers for the disease of interest.

```
lollipop_plot=plot_top_modules(trained_model=trained.model, k_modules_red = 2, k_modules = 4)
lollipop_plot
```

![](data:image/png;base64...)

Second, we can visualize the distribution of the spongEffects scores in the different groups of interest. spongEffects scores should follow a normal distribution. Divergences from it may highlight the presence of subsets of samples with characteristics different than the ones of the class they belong to.

We show here the distribution of the spongEffects scores for the train set, dividev by the 5 breast cancer subtypes

```
density_plot_train=plot_density_scores(trained_model=trained.model,spongEffects = train.modules, meta_data = train_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID")
density_plot_train
```

![](data:image/png;base64...) Module driving prediction can also be visualized with an heatmap. At the moment, the user can choose one layer of annotation.

```
heatmap.train = plot_heatmaps(trained_model = trained.model,spongEffects = train.modules,
               meta_data = train_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID",Modules_to_Plot = 2,
              show.rownames = F, show.colnames = F)
heatmap.train
```

![](data:image/png;base64...)

```
heatmap.test = plot_heatmaps(trained_model = trained.model,spongEffects = test.modules,
               meta_data = test_cancer_metadata, label = "SUBTYPE", sampleIDs = "sampleID",Modules_to_Plot = 2,
              show.rownames = F, show.colnames = F)
heatmap.test
```

![](data:image/png;base64...)

spongEffects can be interpreted as the effect of ceRNA-ceRNA regulation and miRNA-ceRNA regulation (see publication for more details). If miRNA data are available, it is interesting to identify miRNAs that are involved in the regulation of modules driving prediction. We offer a way to visualize these with an heatmap.

```
plot_involved_miRNAs_to_modules(sponge_modules=Sponge.modules,
                                trained_model=trained.model,
                                gene_mirna_candidates= train_genes_miRNA_candidates,
                                k_modules = 2,
                                filter_miRNAs = 0.0,
                                bioMart_gene_symbol_columns = "hgnc_symbol",
                                bioMart_gene_ensembl = "hsapiens_gene_ensembl")
```

```
## [1] "ENSG00000072364"
## [1] "ENSG00000198108"
```

![](data:image/png;base64...)

17. stop the cluster

```
#stop your backend parallelisation if registered
stopCluster(cl)
```