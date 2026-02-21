# Introduction to bayNorm

Wenhao Tang\*, Franois Bertaux\*\*, Philipp Thomas\*\*\*, Claire Stefanelli\*\*\*\*, Malika Saint\*\*\*\*\*, Samuel Marguerat\*\*\*\*\*\* and Vahid Shahrezaei\*\*\*\*\*\*\*

\*wt215@ic.ac.uk
\*\*f.bertaux@imperial.ac.uk
\*\*\*p.thomas@imperial.ac.uk
\*\*\*\*c.stefanelli.v@gmail.com
\*\*\*\*\*malikasaint@gmail.com
\*\*\*\*\*\*samuel.marguerat@lms.mrc.ac.uk
\*\*\*\*\*\*\*v.shahrezaei@imperial.ac.uk

#### 29 October 2025

#### Package

bayNorm 1.28.0

# Contents

* [1 Installation](#installation)
* [2 Quick start: for either one or multi groups of cells](#quick-start-for-either-one-or-multi-groups-of-cells)
  + [2.1 Estimation of capture efficiencies](#estimation-of-capture-efficiencies)
  + [2.2 Run bayNorm](#run-baynorm)
  + [2.3 Non-UMI scRNAseq dataset](#non-umi-scrnaseq-dataset)
  + [2.4 Generate 3D array or 2D matrix with existing estimated prior parameters.](#generate-3d-array-or-2d-matrix-with-existing-estimated-prior-parameters.)
* [3 Other functions](#other-functions)
* [4 Methods](#methods)
  + [4.1 Rationale of bayNorm](#rationale-of-baynorm)
  + [4.2 Estimation of capture efficiencies](#estimation-of-capture-efficiencies-1)
  + [4.3 Estimation of prior parameters](#estimation-of-prior-parameters)
  + [4.4 Method of Moments](#method-of-moments)
  + [4.5 The combined method (default setting in bayNorm for estimating priors)](#the-combined-method-default-setting-in-baynorm-for-estimating-priors)
* [5 Session information](#session-information)
* [6 References](#references)
* **Appendix**

# 1 Installation

bayNorm has been submitted to Bioconductor, once it is accepted, it can be installed via:

```
library(BiocManager)
BiocManager::install("bayNorm")
```

Currently bayNorm can be installed via github:

```
library(devtools)
devtools::install_github("WT215/bayNorm")
```

---

# 2 Quick start: for either one or multi groups of cells

The main function is `bayNorm` which is a wrapper function of prior parameters estimation and normalized array or matrix generation.

Essential parameters for running `bayNorm` are:

* `Data`: a `SummarizedExperiment` object or matrix (rows: genes, columns: cells).
* `BETA_vec`: a vector of probabilities which is of length equal to the number of cells.
* `Conditions`: If `Conditions` is provided, prior parameters will be estimated within each group of cells (we name this kind of procedure as “LL” procedure where “LL” stands for estimating both \(\mu\) and \(\phi\) locally). Otherwise, bayNorm applied “GG” procedure for estimating prior parameters (estimating both \(\mu\) and \(\phi\) globally).
* `Prior_type`: Even if you have specified the `Conditions`, you can still choose to estimate prior parameters across all the cells by setting `Prior_type="GG"`.

The input parameters `BETA_vec`, `Conditions` (if specified), `UMI_sffl` (if specified), `Prior_type`, `FIX_MU`, `BB_SIZE` and `GR` are stored in the list `input_params` which should be output from `bayNorm`. Objects `PRIORS` together with `input_params` output from `bayNorm` should be input in `bayNorm_sup` for transforming between 3D array, mode or mean version’s output of normalized count matricies.

---

## 2.1 Estimation of capture efficiencies

Apart from the raw data, another parameter which user may need to provide is the mean capture efficiency \(<\beta>\) and hence \(\beta\) can be further calculated using scaling factors estimated from any other methods. The default \(\beta\) is calculated to be total counts normalized to 6%. Or you can use `BetaFun` in bayNorm to estimate \(\beta\):

```
data('EXAMPLE_DATA_list')
#Suppose the input data is a SummarizedExperiment object:
#Here we just used 30 cells for illustration
rse <- SummarizedExperiment::SummarizedExperiment(assays=SimpleList(counts=EXAMPLE_DATA_list$inputdata[,seq(1,30)]))
#SingleCellExperiment object can also be input in bayNorm:
#rse <- SingleCellExperiment::SingleCellExperiment(assays=list(counts=EXAMPLE_DATA_list$inputdata))

BETA_est<-BetaFun(Data=rse,MeanBETA=0.06)
summary(BETA_est$BETA)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
## 0.02299 0.03859 0.05255 0.06000 0.07473 0.11168
```

The function `BetaFun` selects a subset of genes such that outlier genes and genes with high proportion of zeros across cells are excluded. Then the total counts of the subset of genes in each cell are normalized to \(<\beta>\). Another way is to normalize scaling factors estimated from the R package `scran` to \(<\beta>\).

## 2.2 Run bayNorm

`BETA_vec` can be set to be `NULL`, then the \(\beta\) are estimated to be total counts normalized to 6%.

```
#Return 3D array normalzied data, draw 20 samples from posterior distribution:
bayNorm_3D<-bayNorm(
    Data=rse,
    BETA_vec = NULL,
    mode_version=FALSE,
    mean_version = FALSE,S=20
    ,verbose =FALSE,
    parallel = TRUE)
```

```
##
  |
  |                                                                      |   0%
  |
  |====                                                                  |   5%
  |
  |=======                                                               |  10%
  |
  |==========                                                            |  15%
  |
  |==============                                                        |  20%
  |
  |==================                                                    |  25%
  |
  |=====================                                                 |  30%
  |
  |========================                                              |  35%
  |
  |============================                                          |  40%
  |
  |================================                                      |  45%
  |
  |===================================                                   |  50%
  |
  |======================================                                |  55%
  |
  |==========================================                            |  60%
  |
  |==============================================                        |  65%
  |
  |=================================================                     |  70%
  |
  |====================================================                  |  75%
  |
  |========================================================              |  80%
  |
  |============================================================          |  85%
  |
  |===============================================================       |  90%
  |
  |==================================================================    |  95%
  |
  |======================================================================| 100%
```

```
#Return 2D matrix normalized data (MAP of posterior):
#Simply set mode_version=TRUE, but keep mean_version=FALSE

#Return 2D matrix normalized data (mean of posterior):
#Simply set mean_version=TRUE, but keep mode_version=FALSE
```

## 2.3 Non-UMI scRNAseq dataset

bayNorm’s mathematical model is suitable for UMI dataset. However it can be also applied on non-UMI dataset. In `bayNorm`, you need to specify the following parameter:
\* `UMI_sffl`: bayNorm can also be applied on the non-UMI dataset. However, user need to provide a scaled number. Raw data will be divided by the scaled number and bayNorm will be applied on the rounded scaled data. By doing so, the Dropout vs Mean expression plots will be similar to that of UMI dataset.

## 2.4 Generate 3D array or 2D matrix with existing estimated prior parameters.

If you have run bayNorm on a dataset before but want to output another kind of data (3D array or 2D matrix), you can use the function `bayNorm_sup`. It is important to input the existing estimated parameters by specifying the following parameter in `bayNorm_sup`:

* `BETA_vec`: If `Conditions` has been specified previously, then input `unlist(bayNorm_output$BETA)`
* `PRIORS`: `input bayNorm_output$PRIORS_LIST`
* `Conditions`: make sure to specify the same `Conditions` as before.
  You can find these two objects from the previous output of bayNorm function, which is a list.

```
#Now if you want to generate 2D matrix (MAP) using the same prior
#estimates as generated before:
bayNorm_2D<-bayNorm_sup(
    Data=rse,
    PRIORS=bayNorm_3D$PRIORS,
    input_params=bayNorm_3D$input_params,
    mode_version=TRUE,
    mean_version = FALSE,
    verbose =FALSE)

#Or you may want to generate 2D matrix
#(mean of posterior) using the same prior
#estimates as generated before:
bayNorm_2D<-bayNorm_sup(
    Data=rse,
    PRIORS=bayNorm_3D$PRIORS,
    input_params=bayNorm_3D$input_params,
    mode_version=FALSE,
    mean_version = TRUE,
    verbose =FALSE)
```

# 3 Other functions

1. `Prior_fun`: This is a wrapper function of `EstPrior`, `BB_Fun` and `AdjustSIZE_fun`:

   * `EstPrior`: Estimating priors using MME methods.
   * `BB_Fun`: Estimating priors by maximizing marginal likelihood function with respect to either \(\phi\) or both \(\mu\) and \(\phi\).
   * `AdjustSIZE_fun`: Adjusting \(\phi\) estimated from `BB_Fun`.
2. `noisy_gene_detection`: This is a higher wrapper function over `bayNorm`, `bayNorm_sup` and `SyntheticControl`. For details about the rationale behind this function, see the Methods part in the paper [2](https://www.biorxiv.org/content/early/2018/04/23/306795).
3. `SyntheticControl`: Given a real scRNA-seq data with estimated \(\beta\), it will estimate \(\mu\) and \(\phi\) from it and simulate control data using `Poisson` distribution. See the Methods part in the paper [2](https://www.biorxiv.org/content/early/2018/04/23/306795) for more details.

#Downstream analysis: DE genes detection
DE function used in bayNorm paper, which was kindly provided by the author of SCnorm.

```
library(MAST)
library(reshape2)
########SCnorm_runMAST3##########
SCnorm_runMAST3 <- function(Data, NumCells) {
    if(length(dim(Data))==2){
        resultss<-SCnorm_runMAST(Data, NumCells)
    } else if(length(dim(Data))==3){

        library(foreach)
        resultss<- foreach(sampleind=1:dim(Data)[3],.combine=cbind)%do%{
            print(sampleind)

            qq<-SCnorm_runMAST(Data[,,sampleind], NumCells)
            return(qq$adjpval)
        }
    }

    return(resultss)
}

SCnorm_runMAST <- function(Data, NumCells) {

  NA_ind<-which(rowSums(Data)==0)
  Data = as.matrix(log2(Data+1))

  G1<-Data[,seq(1,NumCells[1])]
  G2<-Data[,-seq(1,NumCells[1])]

  qq_temp<- rowMeans(G2)-rowMeans(G1)
  qq_temp[NA_ind]=NA

  numGenes = dim(Data)[1]
  datalong = melt(Data)
  Cond = c(rep("c1", NumCells[1]*numGenes), rep("c2", NumCells[2]*numGenes))
  dataL = cbind(datalong, Cond)
  colnames(dataL) = c("gene","cell","value","Cond")
  dataL$gene = factor(dataL$gene)
  dataL$cell = factor(dataL$cell)
  vdata = FromFlatDF(dataframe = dataL, idvars = "cell", primerid = "gene", measurement = "value",  id = numeric(0), cellvars = "Cond", featurevars = NULL,  phenovars = NULL)

  zlm.output = zlm(~ Cond, vdata, method='glm', ebayes=TRUE)

  zlm.lr = lrTest(zlm.output, 'Cond')

  gpval = zlm.lr[,,'Pr(>Chisq)']
  adjpval = p.adjust(gpval[,1],"BH") ## Use only pvalues from the continuous part.
  adjpval = adjpval[rownames(Data)]
  return(list(adjpval=adjpval, logFC_re=qq_temp))
}
```

```
#Now, detect DE genes between two groups of cells with 15 cells in each group respectively

#For 3D array
DE_out<-SCnorm_runMAST3(Data=bayNorm_3D$Bay_out, NumCells=c(15,15))
med_pvals<-apply(DE_out,1,median)
#DE genes are called with threshold 0.05:
DE_genes<-names(which(med_pvals<0.05))

#For 2D array
DE_out<-SCnorm_runMAST3(Data=bayNorm_2D$Bay_out, NumCells=c(15,15))
DE_genes<-names(which(DE_out$adjpval<0.05))
```

# 4 Methods

## 4.1 Rationale of bayNorm

A scRNA-seq dataset is typically represented in a matrix of dimension \(P\times Q\), where P denotes the total number of genes observed and Q denotes the total number of cells studied. The element \(x\_{ij}\) (\(i \in \{1,2,\ldots, P\}\) and \(j \in \{1,2,\ldots, Q\}\)) in the matrix represents the number of transcripts reported for the \(i^{\text{th}}\) gene in the \(j^{\text{th}}\) cell. This is equal to the total number of sequencing reads mapping to that gene in that cell for a non-UMI protocol. For UMI based protocols this is equal to the number of individual UMIs mapping to each gene. The matrix can include data from different groups or batches of cells, representing different biological conditions. This can be represented as a vector of labels for the cell groups or conditions (\(C\_j\)). bayNorm generates for each gene (i) in each cell (j) a posterior distribution of original expression counts (\(x\_{ij}^0\)), given the observed scRNA-seq read count for that gene (\(x\_{ij}\)).

A common approach for normalizing scRNA-seq data is based on the use of a global scaling factor (\(s\_j\)), ignoring any gene specific biases. The normalized data \(\tilde{x}\_{ij}\) is obtained by dividing the raw data for each cell \(j\) by the its global scaling factor \(s\_j\):

\[\begin{equation} \label{equ::scaling}
\tilde{x}\_{ij} = \frac{x\_{ij}}{s\_j}
\end{equation}\]

In bayNorm, we implement global scaling using a Bayesian approach. We assume given the original number of transcripts in the cell (\(x\_{ij}^0\)), the number of transcripts observed (\(x\_{ij}\)) follows a Binomial model with probability \(\beta\_j\), which we refer to as capture effeiciency and it represents the probability of original transcripts in the cell to be observed. In addition, we assume that the original number or true count of the \(i^{\text{th}}\) gene in the \(j^{\text{th}}\) cell (\(x\_{ij}^0\)) follows Negative Binomial distribution with parameters mean (\(\mu\)), size (or dispersion parameter, \(\phi\)), such that:
\[\Pr(x^0\_{ij}=n|\phi\_i,\mu\_i)=\frac{\Gamma(n+\phi\_i)}{\Gamma(\phi\_i)n!}(\frac{\phi\_i}{\mu\_i+\phi\_i})^{\phi\_i}(\frac{\mu\_i}{\mu\_i+\phi\_i})^{n}\]

So, overall we have the following model:

\[\begin{equation} \label{model:bay}
\begin{split}
&x\_{ij}\sim \text{Binom}(x\_{ij}^0,\text{prob}=\beta\_j)\\
&x\_{ij}^0 \sim \text{NB}(\text{mean}=\mu\_i,\text{size}=\phi\_i)
\end{split}
\end{equation}\]

Using the Bayes rule, we have the following posterior distribution of original number of mRNAs for each gene in each cell:

\[\begin{equation}
\underbrace{\Pr(x\_{ij}^0|x\_{ij},\beta\_j,\mu\_i,\phi\_i)}\_\text{Posterior} = \dfrac{ \overbrace{\Pr(x\_{ij}|x\_{ij}^0,\beta\_j)}^\text{Likelihood} \times \overbrace{\Pr(x\_{ij}^0|\mu\_i,\phi\_i)}^\text{Prior}}{\underbrace{\Pr(x\_{ij}|\mu\_i,\phi\_i,\beta\_j)}\_\text{Marginal likelihood}}
\end{equation}\]

The prior parameters \(\mu\) and \(\phi\) of each gene were estimated using an empirical Bayesian method as discussed in detail in Supplementary Information of [1](https://github.com/WT215/bayNorm_papercode).

For more details about the rationale of bayNorm, please see [1](https://github.com/WT215/bayNorm_papercode).

## 4.2 Estimation of capture efficiencies

Cell specific capture efficiency \(\beta\_j\) and global scaling factor (\(s\_j\)) are closely related. We can transform scaling factors estimated by different methods (see below) into \(\beta\_j\) values with the following formula:

\[\begin{equation}
\beta\_j = (s\_j/\bar{s})\bar{\beta}
\end{equation}\]

\(\bar{\beta}\) or \(<\beta>\), a scalar, is an estimate of global mean capture efficiency across all cells, which ranges between 0 and 1.

There are two different methods for estimating \(\bar{\beta}\) and \(\beta\_j\):

1. If spike-ins or smFISH data are available they can be used to estimate capture efficiencies. We can either divide the total number of observed spik-ins in each cell by the total number of input spike-ins, or we can fit a linear regression to estimate the cell specific \(\beta\_j\). If smFISH data is available, we can fit a linear regression between the mean expression of raw data (response variable) and the mean expression of the smFISH data (explanatory variable). The coefficient of the explanatory variable can be used as \(\bar{\beta}\).
2. The raw data itself can be directly used for estimation of cell specific global scaling factors (\(s\_j\)). Then an estimate of \(\bar{\beta}\) can be used to estimate \(\beta\_j\). There are different methods available for estimation of global scaling factors. Some were developed for bulk RNA-seq data and some are specific to scRNA-seq data. The value of \(\bar{\beta}\) depends on the protocol used and can be batch dependent. For example, for Droplet based protocol, it is about 0.06 (inDrop) or 0.12 (Drop-seq). \(\bar{\beta}\) can also be estimated by spike-ins or smFISH data as explained above.

We finally note, that estimates of capture efficiency discussed above will assume cells have simular original transcript content. Therefore, the bayNorm outputs estimates of original transcript counts for a typical cell, which is corrected for variation in cell size and transcript content. This is usually desirable for down-stream analysis such as DE detection. However, if one is interested in absolute origianl count and has additional information such as cell size or total transcirpt content per cell, the capture efficiencies can be approporiatly rescaled for this purpose.

## 4.3 Estimation of prior parameters

### 4.3.1 Maximisation of marginal distribution

Using an emperical bayes approach, one can use the maximisation of marginal likelihood distribution of the observed counts across cells to estimate prior parameters. Let \(M\_i\) denotes the marginal likelihood function for the \(i^\text{th}\) gene across cells. Assuming independence between cells, the log-marginal distribution for the \(i^\text{th}\) gene is

\[\begin{equation}
\log M\_i = \sum\_{j=1}^Q \log \Pr(x\_{ij}|\mu\_i,\phi\_i,\beta\_j),
\end{equation}\]
where \(\Pr(x\_{ij}|\mu\_i,\phi\_i,\beta\_j)\) is the Negative Binomial (see Methods). Maximizing of this equation yields the pair \((\mu\_i,\phi\_i)\).

The above optimization needs to be done for each of the P genes. We refer to the \(\phi\) and/or \(\mu\) estimated by maximizing marginal distribution as BB estimates for convenience, because bayNorm utilizes spectral projected gradient method (spg) from the R package named ``BB’’. Optimizing the marginal distribution with respect to both \(\mu\) and \(\phi\) (2D optimization) is computationally intensive. If we had a good estimate \(\mu\), then we could optimize the marginal distribution with respect to \(\phi\) alone, which would be much more efficient.

## 4.4 Method of Moments

A heuristic way of estimating \(\mu\_i\) and \(\phi\_i\) is through a variant of the Method of Moments. The first step is to do a simple normalization of the raw data, to scale expressions given the cell specific capture efficiencies (\(\beta\_j\)). The simple normalized count \(x\_{ij}^s\) is calculated as following:

\[\begin{equation}
x\_{ij}^s=x\_{ij}\frac{\langle\sum\_{i=1}^Px\_{ij}/\beta\_j\rangle\_j}{\sum\_{i=1}^P{x\_{ij}}},
\end{equation}\]
where the numerator of the scaling factor of \(x\_{ij}\) is obtained by taking the average of scaled total counts across cells.

Based on simple normalized data, we are able to estimate prior parameters \(\mu\) and \(\phi\) of the Negative Binomial distribution using the Method of Moments Estimation (MME), which simply equates the theoretical and empirical moments. This estimation method is fast and simulations suggests it provides good estimates of \(\mu\) but the drawback is that the estimation of \(\phi\) show a systematic bias (see Supplementary Figure S24 a-b in [1](https://github.com/WT215/bayNorm_papercode)).

## 4.5 The combined method (default setting in bayNorm for estimating priors)

Based on simulation studies (Supplementary Figure S24 in [1](https://github.com/WT215/bayNorm_papercode)), the most robust and efficient estimation of \(\mu\) and \(\phi\) can be obtained using the following combined approach, which is the default setting in bayNorm:

1. Based on simple normalized data, we use the MME method for each gene to obtain MME estimated \(\mu\) and \(\phi\).
2. Although the BB estimated \(\phi\) is much closer to the true \(\phi\), many estimates are at the upper boundary of the search space (Supplementary Figures S24 c-d in [1](https://github.com/WT215/bayNorm_papercode)). So, we find adjusting the MME estimated \(\phi\) by a factor which can be estimated by fitting a linear regression between MME estimated \(\phi\) and BB estimated \(\phi\) works best (Supplementary Figures S24 c-d in [1](https://github.com/WT215/bayNorm_papercode)). This adjusted MME estimated \(\phi\) together with the MME estimated \(\mu\) and estimates of \(\beta\_j\) can be used in approximating posterior distribution for each gene in each cell.

Cells are grouped together for prior estimation, based on cell-specific attributes (\(C\_j\)). Prior estimation can be done over all cells irrespective of the experimental condition. We refer to this procedure as “global”. Alternatively, suppose that there are multiple groups of cells in the datasets and we have reasons to believe each group could behave differently. Then we can estimate the prior parameters “\(\mu\) and \(\phi\)” within each group respectively (within groups with the same \(C\_j\) value). We refer to this procedure as “local”. Estimating prior parameters across a certain group of cells based on “global” procedure allow for removing potential batch effects. Multiple groups normalization based on “local” procedure allows for amplifying the inter-groups’ differences while mitigating the intra-group’s variability, which is suitable for DE detection.

---

# 5 Session information

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           bayNorm_1.28.0
## [13] knitr_1.50                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 Rcpp_1.1.0          parallel_4.5.1
##  [7] jquerylib_0.1.4     splines_4.5.1       BiocParallel_1.44.0
## [10] yaml_2.3.10         fastmap_1.2.0       lattice_0.22-7
## [13] XVector_0.50.0      R6_2.6.1            S4Arrays_1.10.0
## [16] doSNOW_1.0.20       iterators_1.0.14    MASS_7.3-65
## [19] DelayedArray_0.36.0 bookdown_0.45       snow_0.4-4
## [22] bslib_0.9.0         rlang_1.1.6         cachem_1.1.0
## [25] xfun_0.53           sass_0.4.10         SparseArray_1.10.0
## [28] cli_3.6.5           fitdistrplus_1.2-4  digest_0.6.37
## [31] foreach_1.5.2       grid_4.5.1          locfit_1.5-9.12
## [34] lifecycle_1.0.4     evaluate_1.0.5      codetools_0.2-20
## [37] abind_1.4-8         survival_3.8-3      rmarkdown_2.30
## [40] tools_4.5.1         htmltools_0.5.8.1
```

---

# 6 References

# Appendix

* [1] [Tang *et al.* (2018). bioRxiv.](https://www.biorxiv.org/content/early/2018/08/03/384586)
* [2] [Saint *et al.* (2018). bioRxiv.](https://www.biorxiv.org/content/early/2018/04/23/306795)