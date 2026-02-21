# Suppl. Ch. 4 - Test Pathway Significance

#### Gabriel Odom

#### 2025-10-30

* [1. Overview](#overview)
  + [1.1 Outline](#outline)
  + [1.2 Load Packages](#load-packages)
  + [1.3 Load `Omics` Data](#load-omics-data)
* [2. Pathway Testing Setup](#pathway-testing-setup)
  + [2.1 Pathway Significance Testing Overview](#pathway-significance-testing-overview)
  + [2.2 Extract Pathway PCs](#extract-pathway-pcs)
  + [2.3 Test Pathway Association](#test-pathway-association)
  + [2.4 Adjust the Pathway \(p\)-Values for FDR](#adjust-the-pathway-p-values-for-fdr)
  + [2.5 Output a Sorted Data Frame / Tibble](#output-a-sorted-data-frame-tibble)
* [3. AES-PCA](#aes-pca)
  + [3.1 Method Details](#method-details)
  + [3.2 AES-PCA Examples](#aes-pca-examples)
* [4. Supervised PCA](#supervised-pca)
  + [4.1 Method Details](#method-details-1)
  + [4.2 Supervised PCA Examples](#supervised-pca-examples)
* [5. Inspect the Results](#inspect-the-results)
  + [5.1 Table of \(p\)-Values](#table-of-p-values)
  + [5.2 Pathway PC and Loading Vectors](#pathway-pc-and-loading-vectors)
* [6. Review](#review)

# 1. Overview

This vignette is the fourth chapter in the “Pathway Significance Testing with `pathwayPCA`” workflow, providing a detailed perspective to the [Pathway Significance Testing](https://gabrielodom.github.io/pathwayPCA/articles/Supplement1-Quickstart_Guide.html#test-pathways-for-significance) section of the Quickstart Guide. This vignette builds on the material covered in the [“Import and Tidy Data”](https://gabrielodom.github.io/pathwayPCA/articles/Supplement2-Importing_Data.html) and [“Creating -Omics Data Objects”](https://gabrielodom.github.io/pathwayPCA/articles/Supplement3-Create_Omics_Objects.html) vignettes. This guide will outline the major steps needed analyze `Omics`-class objects with pathway-level adaptive, elastic-net, sparse or supervised modifications to principal components analysis (PCA), abbreviated AES-PCA and Supervised PCA, respectively. We will consider examples for three types of response information: survival, regression, and binary responses. The predictor information is subsets of assay data which correspond to individual pathways, where a pathway is a bundle of genes with shared biological function. The main goal of pathway significance testing is to discover potential relationships between a given collection of pathways and the response.

## 1.1 Outline

Before we move on, we will outline our steps. After reading this vignette, you should

1. Understand the basics of the AES-PCA pathway-significance testing approach.
2. Understand the basics of the Supervised PCA pathway-significance testing approach.
3. Be able to apply AES-PCA or Supervised PCA to analyze `Omics` data objects with survival, regression, or classification response.

## 1.2 Load Packages

Before we begin, if you want your analysis to be performed with parallel computing, you will need a package to help you. We recommend the `parallel` package (it comes with `R` automatically). We also recommend the `tidyverse` package to help you run some of the examples in these vignettes (while the `tidyverse` package suite is required for many of the examples in the vignettes, it is not required for any of the functions in this package).

```
library(parallel)
library(tidyverse)
library(pathwayPCA)
```

## 1.3 Load `Omics` Data

Because you have already read through the [Import and Tidy Data](https://gabrielodom.github.io/pathwayPCA/articles/Importing_Data.html) and [Creating -Omics Data Objects](https://gabrielodom.github.io/pathwayPCA/articles/Create_Omics_Objects.html) vignettes, we will pick up with the `colon_OmicsSurv` object we created in the last vignette. For our pathway analysis to be meaningful, we need gene expression data (from a microarray or something similar), corresponding phenotype information (such as weight, type of cancer, or survival time and censoring indicator), and a pathways list. The `colon_OmicsSurv` data object we constructed in [Chapter 3](https://gabrielodom.github.io/pathwayPCA/articles/Create_Omics_Objects.html) has all of this.

```
colon_OmicsSurv
#> Formal class 'OmicsSurv' [package "pathwayPCA"] with 6 slots
#>   ..@ eventTime            : num [1:250] 64.9 59.8 62.4 54.5 46.3 ...
#>   ..@ eventObserved        : logi [1:250] FALSE FALSE FALSE FALSE TRUE FALSE ...
#>   ..@ assayData_df         : tibble [250 × 656] (S3: tbl_df/tbl/data.frame)
#>   ..@ sampleIDs_char       : chr [1:250] "subj1" "subj2" "subj3" "subj4" ...
#>   ..@ pathwayCollection    :List of 3
#>   .. ..- attr(*, "class")= chr [1:2] "pathwayCollection" "list"
#>   ..@ trimPathwayCollection:List of 4
#>   .. ..- attr(*, "class")= chr [1:2] "pathwayCollection" "list"
```

---

# 2. Pathway Testing Setup

In this section, we will describe the workflow of the Supervised PCA (`SuperPCA_pVals`) and AES-PCA (`AESPCA_pVals`) pathway significance-testing methods. **The implementation of Supervised PCA in this package does not currently support analysis of responses with missingness.** If you plan to test your pathways using the Supervised PCA method, please remove observations with missing entries before analysis. Unlike the current implementation of Supervised PCA, our current implementation of AES-PCA can handle some missingness in the response.

Also, when we compare computing times in this vignette, we use a Dell Precision Tower 5810 with 64-bit Windows 7 Enterprise OS. This machine has 64 GB of RAM and an Intel Xeon E5-2640 v4 2.40 GHz processor with 20 threads. We use two threads for parallel computing. Please adjust your expectations of computing time accordingly.

## 2.1 Pathway Significance Testing Overview

Now that we have our data stored in an `Omics`-class object, we can test the significance of each pathway with AES- or Supervised PCA. These functions both

1. Extract the first principal components (PCs) from each pathway-subset of the assay design matrix.
2. Test the association between the extracted PCs and the response matrix (survival) or vector (all others).
3. Adjust the pathway \(p\)-values for False Discovery Rate (FDR) or Family-wise Error Rate (FWER).
4. Return a sorted data frame of the adjusted \(p\)-values, a list of the first PCs, and a list of the first loading vectors, all for each pathway.

The major differences between the AES-PCA and Supervised PCA methods involve the execution of (1) and (2), which we will describe in their respective methods sections.

## 2.2 Extract Pathway PCs

The details of this step will depend on the method, but the overall idea remains the same. For each pathway in the trimmed pathway collection, select the columns of the assay data frame that correspond to each genes contained within that pathway. Then, given the pathway-specific assay data subset, use the chosen PCA method to extract the first PCs from that subset of the assay data. The end result of this step is a list of the first PCs and a list of the loading vectors which correspond to these PCs.

## 2.3 Test Pathway Association

The details of this step will also depend on the method. At this point in the method execution, we will have a list of PCs representing the data corresponding to each pathway. We then apply simple models to test if the PCs associated with that pathway are significantly related to the output. For survival output, we use Cox Proportional Hazards (Cox PH) regression. For categorical output, (because we only support binary responses in this version) we use logistic regression to test for a relationship between pathway PCs and the response. For continuous output, we use a simple multiple regression model. The AES- and Supervised PCA methods differ on *how* the \(p\)-values from these models are calculated, but the end result of this step is a \(p\)-value for each of the trimmed pathways.

## 2.4 Adjust the Pathway \(p\)-Values for FDR

At this step, we have a vector of \(p\)-values corresponding to the list of trimmed pathways. We know that repeated comparisons inflate the Type-I error rate, so we adjust these \(p\)-values to control the Type-I error. We use the FDR adjustments executed in the `mt.rawp2adjp` function from the `multtest` [Bioconductor package](https://www.bioconductor.org/packages/3.7/bioc/manuals/multtest/man/multtest.pdf). We modified this function’s code to better fit into our package workflow. While we do not depend on this package directly, we acknowledge their work in this area and express our gratitude. Common adjustment methods to control the FWER or FDR are the Bonferroni, Sidak, Holm, or Benjamini and Hochberg techniques.

## 2.5 Output a Sorted Data Frame / Tibble

The end result of either PCA variant is a data frame (`pVals_df`), list of PCs (`PCs_ls`), and list of loadings to match the PCs (`loadings_ls`). The \(p\)-values data frame has the following columns:

* `pathways`: The names of the pathways in the `Omics` object. The names will match those given in

```
names(getPathwayCollection(colon_OmicsSurv)$pathways)
#>  [1] "pathway3"    "pathway60"   "pathway87"   "pathway120"  "pathway176"
#>  [6] "pathway177"  "pathway187"  "pathway266"  "pathway390"  "pathway413"
#> [11] "pathway491"  "pathway536"  "pathway757"  "pathway781"  "pathway1211"
```

* `n_tested`: The number of genes in each of the pathways after trimming to match the given data assay. The number of genes per pathway given in

```
getTrimPathwayCollection(colon_OmicsSurv)$n_tested
#>    pathway3   pathway60   pathway87  pathway120  pathway176  pathway177
#>          26          45          86          73          54          26
#>  pathway187  pathway266  pathway390  pathway413  pathway491  pathway536
#>          16          11          29          23          40          44
#>  pathway757  pathway781 pathway1211
#>          83         180         104
```

* `terms`: The pathway description, as given in

```
getPathwayCollection(colon_OmicsSurv)$TERMS
#>                                       pathway3
#>               "KEGG_PENTOSE_PHOSPHATE_PATHWAY"
#>                                      pathway60
#>                      "KEGG_RETINOL_METABOLISM"
#>                                      pathway87
#>                  "KEGG_ERBB_SIGNALING_PATHWAY"
#>                                     pathway120
#>     "KEGG_ANTIGEN_PROCESSING_AND_PRESENTATION"
#>                                     pathway176
#>              "KEGG_NON_SMALL_CELL_LUNG_CANCER"
#>                                     pathway177
#>                                  "KEGG_ASTHMA"
#>                                     pathway187
#>                        "BIOCARTA_RELA_PATHWAY"
#>                                     pathway266
#>                         "BIOCARTA_SET_PATHWAY"
#>                                     pathway390
#>                       "BIOCARTA_TNFR1_PATHWAY"
#>                                     pathway413
#>                              "ST_GA12_PATHWAY"
#>                                     pathway491
#>                         "PID_EPHB_FWD_PATHWAY"
#>                                     pathway536
#>                              "PID_TNF_PATHWAY"
#>                                     pathway757
#> "REACTOME_INSULIN_RECEPTOR_SIGNALLING_CASCADE"
#>                                     pathway781
#>             "REACTOME_PHOSPHOLIPID_METABOLISM"
#>                                    pathway1211
#>       "REACTOME_SIGNALING_BY_INSULIN_RECEPTOR"
```

* `rawp`: The unadjusted \(p\)-values of each pathway.
* `...`: Additional columns for each requested FDR/FWER adjustment.

The data frame will have its rows sorted in increasing order by the adjusted \(p\)-value corresponding to the first adjustment method requested. Ties are broken by the raw \(p\)-values. Additionally, if you use the [`tidyverse`](https://www.tidyverse.org/) package suite (and have these packages loaded), then the output will be a tibble object, rather than a data frame object. This object class comes with enhanced printing methods and some other benefits.

---

# 3. AES-PCA

Now that we have described the overview of the pathway analysis methods, we can discuss and give examples in more detail.

## 3.1 Method Details

### 3.1.1 AES-PCA Method Sources

Adaptive, elastic-net, sparse PCA is a combination of the [Adaptive Elastic-Net](https://doi.org/10.1214/08-AOS625) of Zou and Zhang (2009) and [Sparse PCA](https://doi.org/10.1198/106186006X113430) of Zou et al. (2006). This method was applied to pathways association testing by [Chen (2011)](https://doi.org/10.2202/1544-6115.1697). Accoding to Chen (2011), the “AES-PCA method removes noisy expression signals and also account[s] for correlation structure between the genes. It is computationally efficient, and the estimation of the PCs does not depend on clinical outcomes.” This package uses a legacy version of the [LARS algorithm](https://web.stanford.edu/~hastie/Papers/LARS/LeastAngle_2002.pdf) of Efron et al. (2003) to calculate the PCs.

### 3.1.2 Calculate Pathway-Specific Model \(p\)-Values

For the AES-PCA method, pathway \(p\)-values can be calculated with a permutation test. Therefore, when testing the relationship between the response and the PCs extracted by AES-PCA, the accuracy of the permuted \(p\)-values will depend on how many permutations you call for. We recommend 1000. Be warned, however, that this may be too few permutations to create accurate seperation in pathway significance \(p\)-values. You could increase the permutations to a larger value, should your computing resources allow for that. For even moderately-sized data sets (~2000 features) and 1000 pathways, this could take half an hour or more. If you choose to calculate the pathway \(p\)-values non-parametrically, about 20-30% of the computing costs will be extracting the AES-PCs from each pathway (though this proportion will increase if the LARS algorithm has convergence issues with the given pathway). The remaining 70-80% of the cost will be the permutation test (for 1000 permutations).

### 3.1.3 AES-PCA Pros and Cons

Pros:

* The AES-PCA method can handle some missingness in the response.
* The \(p\)-values can be calculated non-parametrically.

Cons:

* The AES-PCA algorithm requires optimization over two tuning parameters and can therefore be considerably slower than using the singular value decomposition or eigendecomposition to extract PCs.
* The \(p\)-values calculated may be too discrete for fewer than 10,000 permutations, which can affect the behavior of the adjustment procedures.

## 3.2 AES-PCA Examples

Now that we have discussed both the overview of the AES-PCA method and some of its specific details, we can run some examples. We have included in this package a toy data collection: a small tidy assay and corresponding pathway collection. This assay has 656 gene expression measurements on 250 colon cancer patients. Survival responses pertaining to these patients are also included. Further, the subset of the pathways collection containts 15 pathways which match most of the genes measured in our example colon cancer assay.

### 3.2.1 Survival Response

We will use two of our available cores with the parallel computing approach. We will adjust the \(p\)-values with the Hochberg (1988) and Sidak Step-Down FWER-adjustment procedures. We will now describe the computational cost for the non-parametric approach.

For the tiny \(250 \times 656\) assay with 15 associated pathways, calculating pathway \(p\)-values with 1000 replicates completes in 28 seconds. If we increase the number of permutations from 1000 to 10,000, this calculation takes 222 seconds (\(7.9\times\) longer). Even though we increased the permutations tenfold, the function completed execution less than 10 times longer (as we mentioned above, roughly a quarter of the computing time is extracting the PCs from each pathway, which does not depend on the number of permutations).

In the example that we show, we will calculate the pathway \(p\)-values parametrically, by specifying `numReps = 0`. Furthermore, the AES-PCA and Supervised PCA functions give some messages concerning the setup and progress of the computation.

```
colonSurv_aespcOut <- AESPCA_pVals(
  object = colon_OmicsSurv,
  numReps = 0,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = c("Hoch", "SidakSD")
)
#> Part 1: Calculate Pathway AES-PCs
#> Initializing Computing Cluster: DONE
#> Extracting Pathway PCs in Parallel: DONE
#>
#> Part 2: Calculate Pathway p-Values
#> Initializing Computing Cluster: DONE
#> Extracting Pathway p-Values in Parallel: DONE
#>
#> Part 3: Adjusting p-Values and Sorting Pathway p-Value Data Frame
#> DONE
```

### 3.2.2 Regression Response

We can also make a mock regression data set by treating the event time as the necessary continuous response. For this example, we will adjust the \(p\)-values with the Holm (1979) FWER- and Benjamini and Hochberg (1995) FDR-adjustment procedures (as an aside, note that this type of multiple testing violates the independence assumption of the [Simes inequality](https://doi.org/10.1214/193940307000000167)). For 1000 permutations, this calculation takes 17 seconds. For 10,000 permutations, this calculation takes 102 seconds (\(6.1\times\) longer).

```
colonReg_aespcOut <- AESPCA_pVals(
  object = colon_OmicsReg,
  numReps = 0,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = c("Holm", "BH")
)
```

### 3.2.3 Binary Classification Response

Finally, we can simulate a mock classification data set by treating the event indicator as the necessary binary response. For this example, we will adjust the \(p\)-values with the Sidak Single-Step FWER- and Benjamini and Yekutieli (2001) FDR-adjustment procedures. For 1000 permutations, this calculation takes 30 seconds. For 10,000 permutations, this calculation takes 226 seconds (\(7.6\times\) longer).

```
colonCateg_aespcOut <- AESPCA_pVals(
  object = colon_OmicsCateg,
  numReps = 0,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = c("SidakSS", "BY")
)
```

---

# 4. Supervised PCA

We now discuss and give examples of the Supervised PCA method.

## 4.1 Method Details

### 4.1.1 Supervised PCA Method Sources

While PCA is a commonly-applied *unsupervised* learning technique (i.e., response information is unnecessary), one limitation of this method is that ignoring response information may yield a first PC completely unrelated to outcome. In an effort to bolster this weakness, [Bair et al. (2006)](https://doi.org/10.1198/016214505000000628) employed response information to rank predictors by the strength of their association. Then, they extracted PCs from feature design matrix subsets constructed from the predictors most strongly associated with the response. [Chen et al. (2008)](https://doi.org/10.1093/bioinformatics/btn458) extend this technique to subsets of biological features within pre-defined biological pathways; they applied the Supervised PCA routine independently to each pathway in a pathway collection. [Chen et al. (2010)](https://doi.org/10.1002/gepi.20532) built on this work, testing if pathways were significantly associated with a given biological or clinical response.

### 4.1.2 Calculate Pathway-Specific Model \(p\)-Values

As thoroughly discussed in Chen et al. (2008), the model fit and regression coefficient test statistics no longer come from their expected distributions. Necessarily, this is due to Supervised PCA’s strength in finding features already associated with outcome. Therefore, for the Supervised PCA method, pathway \(p\)-values are calculated from a mixture of extreme value distributions. We use a constrained numerical optimization routine to calculate the maximum likelihood estimates of the mean, precision, and mixing proportion components of a mixture of two Gumbel extreme value distributions (for minima and maxima of a random normal sample). The \(p\)-values from the pathways after permuting the response is used to estimate this null distribution, so result accuracy may be degraded for a very small set of pathways.

### 4.1.3 Supervised-PCA Pros and Cons

Pros:

* The Supervised PCs are extracted without numerical optimization, so calculating the PCs for each pathway is considerably faster than calculating AES-PCs.
* The \(p\)-values are calculated parametrically, so calculating the \(p\)-values is considerably faster than the non-parametric AES-PCA option, while holding better distributional properties than the parametric AES-PCA option.

Cons:

* In rare cases, numerical routines used to find the maximum likelihood estimates for the mixture distribution needed to calculate the \(p\)-values in Supervised PCA can fail to converge.
* The Supervised PCA method cannot have missing values in the response.

## 4.2 Supervised PCA Examples

### 4.2.1 Survival Response

We will use two of our available cores with the parallel computing approach. We will adjust the \(p\)-values with the Hochberg (1988) and Sidak Step-Down FWER-adjustment procedures. For the tiny \(250 \times 656\) assay with 15 associated pathways, this calculation is completed in 6 seconds. If we compare this to AES-PCA at 1000 permutations, Supervised PCA is \(4.6\times\) faster; for 10,000 permutations, it’s \(36.1\times\) faster.

```
colonSurv_superpcOut <- SuperPCA_pVals(
  object = colon_OmicsSurv,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = c("Hoch", "SidakSD")
)
```

```
#> Initializing Computing Cluster: DONE
#> Calculating Pathway Test Statistics in Parallel: DONE
#> Calculating Pathway Critical Values in Parallel: DONE
#> Calculating Pathway p-Values: DONE
#> Adjusting p-Values and Sorting Pathway p-Value Data Frame: DONE
```

### 4.2.2 Regression Response

We can also make a mock regression data set by treating the event time as the necessary continuous response. For this example, we will adjust the \(p\)-values with the Holm (1979) FWER- and Benjamini and Hochberg (1995) FDR-adjustment procedures. This calculation took 5 seconds. If we compare this to AES-PCA at 1000 permutations, Supervised PCA is \(3.4\times\) faster; for 10,000 permutations, it’s \(20.7\times\) faster.

```
colonReg_superpcOut <- SuperPCA_pVals(
  object = colon_OmicsReg,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = c("Holm", "BH")
)
```

### 4.2.3 Binary Classification Response

Finally, we can simulate a mock classification data set by treating the event indicator as the necessary binary response. For this example, we will adjust the \(p\)-values with the Sidak Single-Step FWER- and Benjamini and Yekutieli (2001) FDR-adjustment procedures. This calculation took 8 seconds. If we compare this to AES-PCA at 1000 permutations, Supervised PCA is \(3.7\times\) faster; for 10,000 permutations, it’s \(27.6\times\) faster.

```
colonCateg_superpcOut <- SuperPCA_pVals(
  object = colon_OmicsCateg,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = c("SidakSS", "BY")
)
```

---

# 5. Inspect the Results

Now that we have the pathway-specific \(p\)-values, we can inspect the top pathways ordered by significance. Further, we can assess the loadings of each gene, or the first principal component, corresponding to each pathway.

## 5.1 Table of \(p\)-Values

For a quick and easy view of the pathway significance testing results, we can simply access the \(p\)-values data frame in the output object with the `getPathpVals()` function. (Note: if you are not using the `tidyverse` package suite, your results will print differently.)

```
getPathpVals(colonSurv_aespcOut)
#> # A tibble: 15 × 4
#>    terms                                         rawp FWER_Hochberg FWER_SidakSD
#>    <chr>                                        <dbl>         <dbl>        <dbl>
#>  1 PID_EPHB_FWD_PATHWAY                       6.53e-6     0.0000980    0.0000980
#>  2 REACTOME_PHOSPHOLIPID_METABOLISM           1.96e-4     0.00275      0.00275
#>  3 REACTOME_INSULIN_RECEPTOR_SIGNALLING_CASC… 4.90e-4     0.00637      0.00635
#>  4 KEGG_ASTHMA                                8.21e-4     0.00985      0.00981
#>  5 KEGG_ERBB_SIGNALING_PATHWAY                1.47e-3     0.0162       0.0161
#>  6 PID_TNF_PATHWAY                            2.60e-3     0.0260       0.0257
#>  7 REACTOME_SIGNALING_BY_INSULIN_RECEPTOR     4.42e-3     0.0387       0.0390
#>  8 KEGG_PENTOSE_PHOSPHATE_PATHWAY             4.84e-3     0.0387       0.0390
#>  9 ST_GA12_PATHWAY                            1.48e-2     0.103        0.0990
#> 10 KEGG_RETINOL_METABOLISM                    2.55e-2     0.153        0.143
#> 11 KEGG_NON_SMALL_CELL_LUNG_CANCER            4.69e-2     0.234        0.213
#> 12 KEGG_ANTIGEN_PROCESSING_AND_PRESENTATION   7.37e-2     0.295        0.264
#> 13 BIOCARTA_RELA_PATHWAY                      7.09e-1     0.801        0.975
#> 14 BIOCARTA_TNFR1_PATHWAY                     7.76e-1     0.801        0.975
#> 15 BIOCARTA_SET_PATHWAY                       8.01e-1     0.801        0.975
```

## 5.2 Pathway PC and Loading Vectors

We also may be interested in which genes or proteins “drive” a specific pathway. We can extract the pathway-specific PCs and loadings (PC & L) from either the AESPCA or Supervised PCA output with the `getPathPCLs()` function. This function will take in either the proper name of a pathway (as given in the `terms` column) or the unique pathway identifier (as shown in the `pathways` column). Note that the PCs and Loadings are stored in tidy data frames, so they will have enhanced printing properties if you have the `tidyverse` package suite loaded.

```
PCLs_ls <- getPathPCLs(colonSurv_aespcOut, "KEGG_ASTHMA")
PCLs_ls
#> $PCs
#> # A tibble: 250 × 3
#>    sampleID     V1     V2
#>    <chr>     <dbl>  <dbl>
#>  1 subj1    -1.36   1.98
#>  2 subj2    -0.649  3.35
#>  3 subj3     1.73  -0.822
#>  4 subj4    -0.156  7.11
#>  5 subj5     2.11   3.70
#>  6 subj6     0.284  1.78
#>  7 subj7    -1.93   3.21
#>  8 subj8     3.28   0.551
#>  9 subj9    -0.118 -0.458
#> 10 subj10   -1.56   0.266
#> # ℹ 240 more rows
#>
#> $Loadings
#> # A tibble: 26 × 3
#>    featureID    PC1   PC2
#>    <chr>      <dbl> <dbl>
#>  1 HLA-DRB4  0      0
#>  2 HLA-DOA   0.228  0
#>  3 HLA-DOB   0.0851 0.287
#>  4 IL3       0      0.318
#>  5 TNF       0      0.153
#>  6 CCL11     0      0
#>  7 EPX       0      0.494
#>  8 FCER1G    0.331  0
#>  9 MS4A2     0      0
#> 10 HLA-DMB   0.347  0
#> # ℹ 16 more rows
#>
#> $pathway
#> [1] "pathway177"
#>
#> $term
#> [1] "KEGG_ASTHMA"
#>
#> $description
#> [1] NA
```

As an example, we see that the HLA-DRA gene positively loads onto this pathway, and [has been shown to be related to colorectal cancer](https://www.ncbi.nlm.nih.gov/pubmed/16367922).

```
PCLs_ls$Loadings %>%
  filter(PC1 != 0) %>%
  select(-PC2) %>%
  arrange(desc(PC1))
#> # A tibble: 11 × 2
#>    featureID    PC1
#>    <chr>      <dbl>
#>  1 HLA-DPB1  0.472
#>  2 HLA-DRA   0.421
#>  3 HLA-DPA1  0.372
#>  4 HLA-DMB   0.347
#>  5 FCER1G    0.331
#>  6 HLA-DMA   0.256
#>  7 IL10      0.254
#>  8 HLA-DOA   0.228
#>  9 CD40      0.163
#> 10 HLA-DQA1  0.126
#> 11 HLA-DOB   0.0851
```

---

# 6. Review

We have has covered in this vignette:

1. The basics of the AES-PCA pathway-significance testing approach.
2. The basics of the Supervised PCA pathway-significance testing approach.
3. Applying AES-PCA or Supervised PCA to analyze survival, regression, or classification `Omics` data objects.

Please read vignette chapter 5 next: [Visualizing the Results](https://gabrielodom.github.io/pathwayPCA/articles/Supplement5-Analyse_Results.html).

Here is the R session information for this vignette:

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
#> [1] stats4    parallel  stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [5] IRanges_2.44.0              S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0         generics_0.1.4
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] survminer_0.5.1             ggpubr_0.6.2
#> [13] survival_3.8-3              pathwayPCA_1.26.0
#> [15] lubridate_1.9.4             forcats_1.0.1
#> [17] stringr_1.5.2               dplyr_1.1.4
#> [19] purrr_1.1.0                 readr_2.1.5
#> [21] tidyr_1.3.1                 tibble_3.3.0
#> [23] ggplot2_4.0.0               tidyverse_2.0.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1    farver_2.1.2        S7_0.2.0
#>  [4] fastmap_1.2.0       digest_0.6.37       timechange_0.3.0
#>  [7] lifecycle_1.0.4     magrittr_2.0.4      compiler_4.5.1
#> [10] rlang_1.1.6         sass_0.4.10         tools_4.5.1
#> [13] utf8_1.2.6          yaml_2.3.10         data.table_1.17.8
#> [16] knitr_1.50          ggsignif_0.6.4      S4Arrays_1.10.0
#> [19] labeling_0.4.3      bit_4.6.0           DelayedArray_0.36.0
#> [22] RColorBrewer_1.1-3  abind_1.4-8         withr_3.0.2
#> [25] grid_4.5.1          lars_1.3            xtable_1.8-4
#> [28] scales_1.4.0        dichromat_2.0-0.1   cli_3.6.5
#> [31] rmarkdown_2.30      crayon_1.5.3        km.ci_0.5-6
#> [34] tzdb_0.5.0          cachem_1.1.0        splines_4.5.1
#> [37] XVector_0.50.0      survMisc_0.5.6      vctrs_0.6.5
#> [40] Matrix_1.7-4        jsonlite_2.0.0      carData_3.0-5
#> [43] car_3.1-3           hms_1.1.4           bit64_4.6.0-1
#> [46] rstatix_0.7.3       archive_1.1.12      Formula_1.2-5
#> [49] jquerylib_0.1.4     glue_1.8.0          stringi_1.8.7
#> [52] gtable_0.3.6        pillar_1.11.1       htmltools_0.5.8.1
#> [55] R6_2.6.1            KMsurv_0.1-6        vroom_1.6.6
#> [58] evaluate_1.0.5      lattice_0.22-7      backports_1.5.0
#> [61] broom_1.0.10        bslib_0.9.0         SparseArray_1.10.0
#> [64] gridExtra_2.3       nlme_3.1-168        mgcv_1.9-3
#> [67] xfun_0.53           zoo_1.8-14          pkgconfig_2.0.3
```