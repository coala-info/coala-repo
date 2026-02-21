# An introduction to **survClust package**

Arshi Arora
 Department of Epidemiology and Biostatistics, MSKCC

#### 2025-10-30

# Contents

* [1 Install](#install)
* [2 Overview](#overview)
  + [2.1 The tldr version](#the-tldr-version)
* [3 Data and Pre-processing](#data-and-pre-processing)
* [4 Supervised integrative cluster analysis](#supervised-integrative-cluster-analysis)
  + [4.1 UVM data](#uvm-data)
    - [4.1.1 Picking k cluster solution](#picking-k-cluster-solution)
  + [4.2 simulation example](#simulation-example)
    - [4.2.1 Picking k cluster solution](#picking-k-cluster-solution-1)
  + [4.3 Bonus - UVM mutation data alone](#bonus---uvm-mutation-data-alone)
    - [4.3.1 Picking k cluster solution](#picking-k-cluster-solution-2)
* [5 Appendix](#appendix)
  + [5.1 Process TCGA dataset](#process-tcga-dataset)
  + [5.2 Create simulation dataset](#create-simulation-dataset)
* [6 Refrences](#refrences)
* [7 SessionInfo](#sessioninfo)

# 1 Install

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("survClust")
```

# 2 Overview

## 2.1 The tldr version

**survClust**\(^1\) is an outcome weighted integrative supervised clustering algorithm, designed to classify patients according to their molecular as well as time-event or end point of interest. Until now, sub-typing in cancer biology has relied heavily upon clustering/mining of molecular data alone. We present classification of samples on molecular data supervised by time-event data like Overall Survival (OS), Progression Free Survival (PFS) etc.

Below is the workflow of proposed survClust method:

`getDist` - Compute a weighted distance matrix based on outcome across given `m` data types. Standardization across data types to facilitate the integration proces and accounting for non-overlapping samples is also accomplished in this step.

`combineDist` - Integrate `m` data types by averaging over `m` weighted distance matrices.

`survClust` and `cv_survclust` - Cluster integrated weighted distance matrices via `survClust`. Optimal `k` is estimated via cross-validation using `cv_survclust`. Cross-validated results are assessed over the following performance metrics - the **logrank statistic, standardized pooled within-cluster sum of squares (SPWSS)** and cluster solutions with **class size less than 5 samples**.

Note:

1. The input datatypes needs to be carefully pre-processed. See the data pre-processing section.
2. `cv_survclust` is a wrapper function that cross-validates and outputs cluster assignments. If you run without cross validation and just the commands on its own (`getDist`, `combineDist` and `survClust`), you are **over-fitting!**

In this document, we use the TCGA UVM data set and a simulation example to demonstrate how to use survClust to perform integrative supervised clustering.

All TCGA data has been downloaded from the TCGA pan-cancer paper\(^2\)

# 3 Data and Pre-processing

The data and pre-processing steps are largely followed from iCluster\(^3\) manual by - iCluster (Mo Q, Shen R (2022). iClusterPlus: Integrative clustering of multi-type genomic data. R package version 1.32.0.). The pre-processing steps that we used in the manuscript are described here.

* Copy Number data was segmented using CBS\(^4\) and reduced to non-redundant regions of alterations using the `CNregion` function in `iClusterPlus` with default epsilon of `0.001`, keeping in mind that the total numbers of features don’t exceed 10,000. See below and pre-processed data is provided with the package - `uvm_dat` See [Appendix](#appendix) for how the data attached with the package was processed.
* For DNA methylation, mRNA expression and miRNA expression, if a certain feature had more than 20% missing data, that feature was removed and remaining were used for analysis.
* For mRNA expression, we further removed genes having a mean expression lower than the threshold of mean expression of lower 10% quantile.
* Similarly, methylation probes with mean beta values < 0.1 and > 0.9 were discarded.
* For mutation data, we first filtered variants that were classified as `SILENT`. Secondly, genes harboring mutants in less than 1% of the samples were also removed. For our case study of UVM, we just removed singleton mutations. See below and pre-processed data is provided with the package - `uvm_dat`

```
library(survClust)
library(survival)
library(BiocParallel)

#mutation data
uvm_dat[[1]][1:5,1:5]
#>              RYR2 OBSCN TTN DNAH17 PLCB4
#> TCGA-RZ-AB0B    0     0   0      0     0
#> TCGA-V3-A9ZX    0     0   0      0     0
#> TCGA-V3-A9ZY    0     0   0      0     0
#> TCGA-V4-A9E5    0     0   0      0     0
#> TCGA-V4-A9E7    0     0   0      0     0

#copy number data
uvm_dat[[2]][1:5,1:5]
#>              chr1.3218610-4658538 chr1.4658538-4735056 chr1.4735056-4735908
#> TCGA-RZ-AB0B              -0.3696              -0.3696              -0.3696
#> TCGA-V3-A9ZX               0.0366               0.0366               0.0366
#> TCGA-V3-A9ZY              -0.0373              -0.0373              -0.0373
#> TCGA-V4-A9E5              -0.0614              -0.0614              -0.0614
#> TCGA-V4-A9E7              -1.0061              -1.0061              -1.0061
#>              chr1.4735908-4736456 chr1.4736456-6876455
#> TCGA-RZ-AB0B              -0.3696              -0.3696
#> TCGA-V3-A9ZX               0.0366               0.0366
#> TCGA-V3-A9ZY              -0.0373              -0.0373
#> TCGA-V4-A9E5              -0.0614              -0.0614
#> TCGA-V4-A9E7              -0.8835              -0.8835

#TCGA UVM clinical data
head(uvm_survdat)
#>              OS.time OS
#> TCGA-RZ-AB0B     149  1
#> TCGA-V3-A9ZX     470  0
#> TCGA-V3-A9ZY     459  0
#> TCGA-V4-A9E5    2499  0
#> TCGA-V4-A9E7     415  1
#> TCGA-V4-A9E8     808  1
```

# 4 Supervised integrative cluster analysis

To run supervised integrative clustering analysis - we will be calling `cv_survclust`. Cross-validation takes time and we will be using the `BiocParallel` package and splitting cross-validation across `k` clusters.

We will perform **3-fold** cross-validation over **10** rounds as follows:

```
cv_rounds = 10

#function to do cross validation
uvm_all_cvrounds<-function(kk){
    this.fold<-3
    fit<-list()
    for (i in seq_len(cv_rounds)){
        fit[[i]] <- cv_survclust(uvm_dat,uvm_survdat,kk,this.fold)
        print(paste0("finished ", i, " rounds for k= ", kk))
    }
    return(fit)
}
```

We will be using this code for both UVM data and then use this as a simulation example as discussed in the manuscript\(^1\).

*Note* that 10 rounds of cross-validation is not enough and we recommend at least 50 rounds of cross-validation to get some stability in results.

## 4.1 UVM data

```
ptm <- Sys.time()
cv.fit<-bplapply(2:7, uvm_all_cvrounds)
ptm2 <- Sys.time()

#> ptm
#[1] "2022-09-05 20:54:21 EDT"
#> ptm2
#[1] "2022-09-05 21:01:12 EDT"
```

Supervised integrative clustering was performed on TCGA UVM consisting of about 80 samples and 87 genes in the mutation data and CN data summarized over 749 segments.

```
lapply(uvm_dat, function(x) dim(x))
#> $uvm_mut
#> [1] 80 87
#>
#> $uvm_cn
#> [1]  80 749
```

The above process took about ~7 minutes on a *macOS Catalina* with *2.6 GHz Dual-Core Intel Core i5* running on *8Gb RAM*. If you wish to skip the run-time, output is available as `uvm_survClust_cv.fit`. Due to 10 rounds of cross validation, the results from your run might differ from what is provided.

The output is a list object consisting of 6 sub-lists for \(k = 2:7\), with 10 `cv_survclust` outputs (for each round of cross-validation), each consisting of `cv.labels`, `cv.logrank`, `cv.spwss` for 3 folds.

```
#for k=2, 1st round of cross validation
names(uvm_survClust_cv.fit[[1]][[1]])
#> [1] "cv.labels"  "cv.logrank" "cv.spwss"
```

Now, let’s use `survClust::getStats` to summarize and `survClust::plotStats` to plot some of the supervised integrative clustering metrics.

```
ss_stats <- getStats(uvm_survClust_cv.fit, kk=7, cvr=10)
plotStats(ss_stats, 2:7)
```

![survClust analysis of TCGA UVM mutation and Copy Number data](data:image/png;base64...)

Figure 1: survClust analysis of TCGA UVM mutation and Copy Number data

### 4.1.1 Picking k cluster solution

In the above plot, the topleft plot is summarizing logrank over 10 rounds of cross-validated class labels across 3-fold cross-validation. Here, we see how logrank peaks at `k=4`.

the topright plot is summarizing `SPWSS` or `Standardized Pooled Within Sum of Squares`. Briefly, pooled within-cluster sum of squares were standardized by the total sum of squares similar to methodology used in the gap statistic\(^5\) to select the appropriate number of clusters.

Here `SPWSS` decreases monotonically as the number of clusters `k` increases. The optimal number of clusters is where `SPWSS` is minimized and creates an “elbow” or a point of inflection, where addition of more clusters does not improve cluster separation. For example, here the plot elbows at `k=4`

Another property of `SPWSS` is that it can be used to compare among different datasets as it lies between 0 and 1 after standardization. This is useful for comparing survClust runs between individual data types and when we integrate them.

The last plot, on the bottomleft, shows for each `k` how many `k` class labels have `<=5` samples in 10 rounds of cross validation. In our case here, for `k >5` the number of classes with `<=5` samples increases, so we can choose `k=4`.

```
k4 <- cv_voting(uvm_survClust_cv.fit, getDist(uvm_dat, uvm_survdat), pick_k=4)
table(k4)
#> k4
#>  1  2  3  4
#> 18 23 13 26

plot(survfit(Surv(uvm_survdat[,1], uvm_survdat[,2])~k4), mark.time=TRUE, col=1:4)
```

![survClust KM analysis for integrated TCGA UVM Mutation and Copy Number for k=4](data:image/png;base64...)

Figure 2: survClust KM analysis for integrated TCGA UVM Mutation and Copy Number for k=4

Let’s see some of the differentiating features in mutation data.

```
mut_k4_test <- apply(uvm_dat[[1]],2,function(x) fisher.test(x,k4)$p.value)
head(sort(p.adjust(mut_k4_test)))
#>        SF3B1         GNAQ        GNA11         BAP1       EIF1AX         RYR2
#> 3.916339e-09 1.956023e-06 3.456072e-05 1.293877e-01 1.933046e-01 1.000000e+00
```

All the figures as shown in the manuscript are plotted using `panelmap`. It is available on GitHub over here - <https://github.com/arorarshi/panelmap>

We will use it to see the distribution of these mutations across the 4 clusters from a previous run. An example from previous runs is shown below. *This is only for illustration process and the cluster groups might differ between the latest run.*

![](data:image/png;base64...)

And for Copy Number data as follows -

```
cn_imagedata <- uvm_dat[[2]]
cn_imagedata[cn_imagedata < -1.5] <- -1.5
cn_imagedata[cn_imagedata > 1.5] <- 1.5

oo <- order(k4)
cn_imagedata <- cn_imagedata[oo,]
cn_imagedata <- cn_imagedata[,ncol(cn_imagedata):1]
#image(cn_imagedata,col=gplots::bluered(50),axes=F)

#image y labels - chr names
cnames <- colnames(cn_imagedata)
cnames <- unlist(lapply(strsplit(cnames, "\\."), function(x) x[1]))
tt <- table(cnames)
nn <- paste0("chr",1:22)

chr.labels <- rep(NA, length(cnames))

index <- 1
chr.labels[1] <- "1"

for(i in seq_len(length(nn)-1)) {
    index <- index + tt[nn[i]]
    chr.labels[index] <- gsub("chr","",nn[i+1])
}

idx <- which(!(is.na(chr.labels)))

image(cn_imagedata,col=gplots::bluered(50),axes=FALSE)

axis(2, at = 1 - (idx/length(cnames)), labels = chr.labels[idx], las=1, cex.axis=0.8)
abline(v = c(cumsum(prop.table(table(k4)))))
abline(h=c(0,1))
```

![TCGA UVM Copy Number k=4](data:image/png;base64...)

Figure 3: TCGA UVM Copy Number k=4

## 4.2 simulation example

Simulation example is presented in the survClust manuscript \(^1\).See Figure **(S1)** and **Supplementary Note**. Below we provide [code](#appendix) on how we generated the simulated dataset and how to run it via survClust.

```
#function to do cross validation
sim_cvrounds<-function(kk){
    this.fold<-3
    fit<-list()
    for (i in seq_len(cv_rounds)){
        fit[[i]] <- cv_survclust(simdat, simsurvdat,kk,this.fold)
        print(paste0("finished ", i, " rounds for k= ", kk))
    }
    return(fit)
}

ptm <- Sys.time()
sim_cv.fit<-bplapply(2:7, sim_cvrounds)
#> [1] "finished 1 rounds for k= 2"
#> [1] "finished 2 rounds for k= 2"
#> [1] "finished 3 rounds for k= 2"
#> [1] "finished 4 rounds for k= 2"
#> [1] "finished 5 rounds for k= 2"
#> [1] "finished 6 rounds for k= 2"
#> [1] "finished 7 rounds for k= 2"
#> [1] "finished 8 rounds for k= 2"
#> [1] "finished 9 rounds for k= 2"
#> [1] "finished 10 rounds for k= 2"
#> [1] "finished 1 rounds for k= 3"
#> [1] "finished 2 rounds for k= 3"
#> [1] "finished 3 rounds for k= 3"
#> [1] "finished 4 rounds for k= 3"
#> [1] "finished 5 rounds for k= 3"
#> [1] "finished 6 rounds for k= 3"
#> [1] "finished 7 rounds for k= 3"
#> [1] "finished 8 rounds for k= 3"
#> [1] "finished 9 rounds for k= 3"
#> [1] "finished 10 rounds for k= 3"
#> [1] "finished 1 rounds for k= 4"
#> [1] "finished 2 rounds for k= 4"
#> [1] "finished 3 rounds for k= 4"
#> [1] "finished 4 rounds for k= 4"
#> [1] "finished 5 rounds for k= 4"
#> [1] "finished 6 rounds for k= 4"
#> [1] "finished 7 rounds for k= 4"
#> [1] "finished 8 rounds for k= 4"
#> [1] "finished 9 rounds for k= 4"
#> [1] "finished 10 rounds for k= 4"
#> [1] "finished 1 rounds for k= 5"
#> [1] "finished 2 rounds for k= 5"
#> [1] "finished 3 rounds for k= 5"
#> [1] "finished 4 rounds for k= 5"
#> [1] "finished 5 rounds for k= 5"
#> [1] "finished 6 rounds for k= 5"
#> [1] "finished 7 rounds for k= 5"
#> [1] "finished 8 rounds for k= 5"
#> [1] "finished 9 rounds for k= 5"
#> [1] "finished 10 rounds for k= 5"
#> [1] "finished 1 rounds for k= 6"
#> [1] "finished 2 rounds for k= 6"
#> [1] "finished 3 rounds for k= 6"
#> [1] "finished 4 rounds for k= 6"
#> [1] "finished 5 rounds for k= 6"
#> [1] "finished 6 rounds for k= 6"
#> [1] "finished 7 rounds for k= 6"
#> [1] "finished 8 rounds for k= 6"
#> [1] "finished 9 rounds for k= 6"
#> [1] "finished 10 rounds for k= 6"
#> [1] "finished 1 rounds for k= 7"
#> [1] "finished 2 rounds for k= 7"
#> [1] "finished 3 rounds for k= 7"
#> [1] "finished 4 rounds for k= 7"
#> [1] "finished 5 rounds for k= 7"
#> [1] "finished 6 rounds for k= 7"
#> [1] "finished 7 rounds for k= 7"
#> [1] "finished 8 rounds for k= 7"
#> [1] "finished 9 rounds for k= 7"
#> [1] "finished 10 rounds for k= 7"
ptm2 <- Sys.time()

ptm
#> [1] "2025-10-30 02:50:21 EDT"
ptm2
#> [1] "2025-10-30 02:51:13 EDT"
```

The above process took about 51.6205949783325 on a *macOS Catalina* with *2.6 GHz Dual-Core Intel Core i5* running on *8Gb RAM*.

The output is a list object consisting of 6 sub-lists for \(k = 2:7\), with 10 `cv_survclust` output (for each round of cross-validation), each consisting of `cv.labels`, `cv.logrank`, `cv.spwss` for 3 folds.

Now, let’s use `survClust::getStats` to summarize and `survClust::plotStats` to plot some of the supervised integrative clustering metrics.

```
ss_stats <- getStats(sim_cv.fit, kk=7, cvr=10)
plotStats(ss_stats, 2:7)
```

![survClust analysis of simulated dataset](data:image/png;base64...)

Figure 4: survClust analysis of simulated dataset

### 4.2.1 Picking k cluster solution

In the above plot, the topleft plot is summarizing logrank over 10 rounds of cross-validated class labels across 3-fold cross-validation. Here, we see that logrank peaks at `k=3`.

The topright plot is summarizing `SPWSS` or `Standardized Pooled Within Sum of Squares`. The plot elbows at `k=4`

The last plot, on the bottomleft, shows for each `k` how many `k` class labels have `<=5` samples in 10 rounds of cross validation. In the simulation example, cluster solutions having `<5` samples increases at `k=7`

```
k3 <- cv_voting(sim_cv.fit, getDist(simdat, simsurvdat), pick_k=3)

sim_class_labels <- c(rep(1, 50), rep(2,50), rep(3,50))

table(k3, sim_class_labels)
#>    sim_class_labels
#> k3   1  2  3
#>   1  0 50  1
#>   2 50  0  0
#>   3  0  0 49

plot(survfit(Surv(simsurvdat[,1], simsurvdat[,2]) ~ k3), mark.time=TRUE, col=1:3)
```

![survClust k=3 class labels KM analysis for simulated dataset ](data:image/png;base64...)

Figure 5: survClust k=3 class labels KM analysis for simulated dataset

We see, that we are able to get the simulated class labels as survClust solution with good concordance.

## 4.3 Bonus - UVM mutation data alone

survClust allows for integration of one or more data types. The data can be either continuous (RNA, methylation, miRNA or protein expression or copy number segmentation values) or binary (mutation status, `wt=0, mut =1`).

One can perform survClust on individual data alone. In this example, we will perform survClust on TCGA UVM mutation data alone.

```
#function to do cross validation
cvrounds_mut <- function(kk){
    this.fold<-3
    fit<-list()
    for (i in seq_len(cv_rounds)){
        fit[[i]] <- cv_survclust(uvm_mut_dat, uvm_survdat,kk,this.fold, type="mut")
        print(paste0("finished ", i, " rounds for k= ", kk))
    }
    return(fit)
}

#let's create a list object with just the mutation data
uvm_mut_dat <- list()
uvm_mut_dat[[1]] <- uvm_dat[[1]]

ptm <- Sys.time()
uvm_mut_cv.fit<-bplapply(2:7, cvrounds_mut)
#> [1] "finished 1 rounds for k= 2"
#> [1] "finished 2 rounds for k= 2"
#> [1] "finished 3 rounds for k= 2"
#> [1] "finished 4 rounds for k= 2"
#> [1] "finished 5 rounds for k= 2"
#> [1] "finished 6 rounds for k= 2"
#> [1] "finished 7 rounds for k= 2"
#> [1] "finished 8 rounds for k= 2"
#> [1] "finished 9 rounds for k= 2"
#> [1] "finished 10 rounds for k= 2"
#> [1] "finished 1 rounds for k= 3"
#> [1] "finished 2 rounds for k= 3"
#> [1] "finished 3 rounds for k= 3"
#> [1] "finished 4 rounds for k= 3"
#> [1] "finished 5 rounds for k= 3"
#> [1] "finished 6 rounds for k= 3"
#> [1] "finished 7 rounds for k= 3"
#> [1] "finished 8 rounds for k= 3"
#> [1] "finished 9 rounds for k= 3"
#> [1] "finished 10 rounds for k= 3"
#> [1] "finished 1 rounds for k= 6"
#> [1] "finished 2 rounds for k= 6"
#> [1] "finished 3 rounds for k= 6"
#> [1] "finished 4 rounds for k= 6"
#> [1] "finished 5 rounds for k= 6"
#> [1] "finished 6 rounds for k= 6"
#> [1] "finished 7 rounds for k= 6"
#> [1] "finished 8 rounds for k= 6"
#> [1] "finished 9 rounds for k= 6"
#> [1] "finished 10 rounds for k= 6"
#> [1] "finished 1 rounds for k= 7"
#> [1] "finished 2 rounds for k= 7"
#> [1] "finished 3 rounds for k= 7"
#> [1] "finished 4 rounds for k= 7"
#> [1] "finished 5 rounds for k= 7"
#> [1] "finished 6 rounds for k= 7"
#> [1] "finished 7 rounds for k= 7"
#> [1] "finished 8 rounds for k= 7"
#> [1] "finished 9 rounds for k= 7"
#> [1] "finished 10 rounds for k= 7"
#> [1] "finished 1 rounds for k= 4"
#> [1] "finished 2 rounds for k= 4"
#> [1] "finished 3 rounds for k= 4"
#> [1] "finished 4 rounds for k= 4"
#> [1] "finished 5 rounds for k= 4"
#> [1] "finished 6 rounds for k= 4"
#> [1] "finished 7 rounds for k= 4"
#> [1] "finished 8 rounds for k= 4"
#> [1] "finished 9 rounds for k= 4"
#> [1] "finished 10 rounds for k= 4"
#> [1] "finished 1 rounds for k= 5"
#> [1] "finished 2 rounds for k= 5"
#> [1] "finished 3 rounds for k= 5"
#> [1] "finished 4 rounds for k= 5"
#> [1] "finished 5 rounds for k= 5"
#> [1] "finished 6 rounds for k= 5"
#> [1] "finished 7 rounds for k= 5"
#> [1] "finished 8 rounds for k= 5"
#> [1] "finished 9 rounds for k= 5"
#> [1] "finished 10 rounds for k= 5"
ptm2 <- Sys.time()
```

```
ss_stats <- getStats(uvm_mut_cv.fit, kk=7, cvr=10)
plotStats(ss_stats, 2:7)
```

![survClust analysis of TCGA UVM mutation data alone](data:image/png;base64...)

Figure 6: survClust analysis of TCGA UVM mutation data alone

### 4.3.1 Picking k cluster solution

Firstly, since, these are only 10 rounds of cross validation, there is a lot of variability in each rounds of cross-validation, and the results here are for demonstration purpose only.

In the above plot, the topleft plot is summarizing logrank over 10 rounds of cross-validated class labels across 3-fold cross-validation. Here, we see how logrank peaks at `k=4`.

The topright plot is summarizing `SPWSS` or `Standardized Pooled Within Sum of Squares`. Here the plot elbows at `k=4`

The last plot, on the bottomleft, shows for each `k` how many `k` class labels have `<=5` samples in 10 rounds of cross validation. We see that `k=3` has cluster solutions with `<=5` samples a lot more than `k=4`.

```
k4 <- cv_voting(uvm_mut_cv.fit, getDist(uvm_mut_dat, uvm_survdat), pick_k=4)
plot(survfit(Surv(uvm_survdat[,1], uvm_survdat[,2]) ~ k4), mark.time=TRUE, col=2:5)
```

![survClust k=3 class labels KM analysis for TCGA UVM mutation data alone](data:image/png;base64...)

Figure 7: survClust k=3 class labels KM analysis for TCGA UVM mutation data alone

Let’ see these discriminant features.

```
mut_k4_test <- apply(uvm_mut_dat[[1]],2,function(x) fisher.test(x,k4)$p.value)
head(sort(p.adjust(mut_k4_test)))
#>         GNAQ        GNA11        SF3B1      CYSLTR2        PLCB4         UTRN
#> 1.132947e-20 7.604755e-19 6.634843e-05 3.578384e-02 5.515823e-01 5.515823e-01
```

# 5 Appendix

## 5.1 Process TCGA dataset

```
# DO NOT RUN. Use provided dataset
#Process mutation maf data
#Download data from - https://gdc.cancer.gov/about-data/publications/pancanatlas

maf <- data.table::fread("mc3.v0.2.8.PUBLIC.maf.gz", header = TRUE)
maf_filter <- maf %>% filter(FILTER == "PASS",
                            Variant_Classification != "Silent")

# few lines of code in tidyR to convert maf to a binary file
maf_binary <- maf_filter %>%
    select(Tumor_Sample_Barcode, Hugo_Symbol) %>%
    distinct() %>%
    pivot_wider(names_from = "Hugo_Symbol",
                values_from = 'Hugo_Symbol',
                values_fill = 0, values_fn = function(x) 1)

maf_binary$tcga_short <- substr(maf_binary$Tumor_Sample_Barcode, 1, 12)

# Process clinical file
tcga_clin <- readxl::read_excel("TCGA-CDR-SupplementalTableS1.xlsx", sheet=1, col_names = TRUE)

uvm_clin <- tcga_clin %>% filter(type == "UVM")
uvm_maf_binary <- maf_binary %>%
    filter(tcga_short %in% uvm_clin$bcr_patient_barcode) %>%
    select(-Tumor_Sample_Barcode)
rnames <- uvm_maf_binary$tcga_short

uvm_maf <- uvm_maf_binary %>% select(-tcga_short) %>%
    apply(., 2, as.numeric)

# Remove singletons
gene_sum <- apply(uvm_maf,2,sum)
idx <- which(gene_sum > 1)

uvm_maf <- uvm_maf[,idx]
rownames(uvm_maf) <- rnames

uvm_survdat <- uvm_clin %>% select(OS.time, OS) %>%
    apply(., 2, as.numeric)

rownames(uvm_survdat) <- uvm_clin$bcr_patient_barcode

# process CN
library(cluster)#pam function for derive medoid
library(GenomicRanges) #interval overlap to remove CNV
library(iClusterPlus)

seg <- read.delim(file="broad.mit.edu_PANCAN_Genome_Wide_SNP_6_whitelisted.seg", header=TRUE,sep="\t", as.is=TRUE)

pp <- substr(seg$Sample,13,16)
seg.idx <- c(grep("-01A",pp),grep("-01B",pp),grep("-03A",pp))

#only take tumors
seg.idx <- c(grep("-01A",pp),grep("-01B",pp))
seg <- seg[seg.idx,]

seg$Sample <- substr(seg[,1],1,12)

uvm_seg <- seg[seg$Sample %in% uvm_clin$bcr_patient_barcode,]

colnames(uvm_seg) <- c("Sample", "Chromosome", "Start", "End", "Num_Probes", "Segment_Mean")

# pass epsilon as 0.001 default or user
reducedMseg <- CNregions(ss_seg,epsilon=0.001,adaptive=FALSE,rmCNV=FALSE, cnv=NULL, frac.overlap=0.5, rmSmallseg=TRUE, nProbes=75)

uvm_dat <- list(uvm_mut = uvm_maf, uvm_cn = uvm_seg)
```

## 5.2 Create simulation dataset

```
set.seed(112)
n1 <- 50 #class1
n2 <- 50 #class2
n3 <- 50 #class3
n <- n1+n2+n3
p <- 15 #survival related features (10%)
q <- 120 #noise

#class1 ~ N(1.5,1), class2 ~ N(0,1), class3 ~ N(-1.5,1)

sample_names <- paste0("S",1:n)
feature_names <- paste0("features", 1:n)

#final matrix
x_big <- NULL

################
# sample 15 informant features

#simulating class1
x1a <- matrix(rnorm(n1*p, 1.5, 1), ncol=p)

#simulating class2
x2a <- matrix(rnorm(n2*p), ncol=p)

#simulating class3
x3a <- matrix(rnorm(n3*p, -1.5,1), ncol=p)

#this concluded that part shaded in red of the matrix -
#corresponding to related to survival and molecularly distinct
xa <- rbind(x1a,x2a,x3a)

################
# sample 15 other informant features, but scramble them.

permute.idx<-sample(1:length(sample_names),length(sample_names))

x1b <- matrix(rnorm(n1*p, 1.5, 1), ncol=p)
x2b <- matrix(rnorm(n2*p), ncol=p)
x3b <- matrix(rnorm(n3*p, -1.5,1), ncol=p)

#this concluded that part shaded in blue of the matrix -
#containing the molecular distinct features but not related to survival
xb <- rbind(x1b,x2b,x3b)

#this concludes the area shaded area in grey which corresponds to noise
xc <- matrix(rnorm(n*q), ncol=q)

x_big <- cbind(xa,xb[permute.idx,], xc)

rownames(x_big) <- sample_names
colnames(x_big) <- feature_names
simdat <- list()
simdat[[1]] <- x_big

#the three classes will have a median survival of 4.5, 3.25 and 2 yrs respectively
set.seed(112)
med_surv_class1 <- log(2)/4.5
med_surv_class2 <- log(2)/3.25
med_surv_class3 <- log(2)/2

surv_dist_class1 <- rexp(n1,rate=med_surv_class1)
censor_events_class1 <- runif(n1,0,10)

surv_dist_class2 <- rexp(n2,rate=med_surv_class2)
censor_events_class2 <- runif(n2,0,10)

surv_dist_class3 <- rexp(n3,rate=med_surv_class3)
censor_events_class3 <- runif(n3,0,10)

surv_time_class1 <- pmin(surv_dist_class1,censor_events_class1)
surv_time_class2 <- pmin(surv_dist_class2,censor_events_class2)
surv_time_class3 <- pmin(surv_dist_class3,censor_events_class3)

event <- c((surv_time_class1==surv_dist_class1),
          (surv_time_class2==surv_dist_class2),
          (surv_time_class3==surv_dist_class3))

time <- c(surv_time_class1, surv_time_class2, surv_time_class3)

survdat <- cbind(time, event)

simsurvdat <- cbind(time, event)
rownames(simsurvdat) <- sample_names
```

# 6 Refrences

1. Arora, Arshi, et al. “Pan-cancer identification of clinically relevant genomic subtypes using outcome-weighted integrative clustering.” Genome medicine 12.1 (2020): 1-13.
2. Hoadley, Katherine A., et al. “Cell-of-origin patterns dominate the molecular classification of 10,000 tumors from 33 types of cancer.” Cell 173.2 (2018): 291-304.
3. Shen, Ronglai, Adam B. Olshen, and Marc Ladanyi. “Integrative clustering of multiple genomic data types using a joint latent variable model with application to breast and lung cancer subtype analysis.” Bioinformatics 25.22 (2009): 2906-2912.
4. Seshan, Venkatraman E., et al. “Package ‘DNAcopy’.” Package “DNAcopy.” (2013).
5. Tibshirani R, Walther G, Hastie T. Estimating the number of clusters in a data set via the gap statistic. J Roy Stat Soc B. 2001;63:411–23. <https://doi.org/10.1111/1467-9868.00293>.

# 7 SessionInfo

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
#> [1] BiocParallel_1.44.0 survival_3.8-3      survClust_1.4.0
#> [4] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10                 generics_0.1.4
#>  [3] gplots_3.2.0                bitops_1.0-9
#>  [5] SparseArray_1.10.0          KernSmooth_2.23-26
#>  [7] gtools_3.9.5                lattice_0.22-7
#>  [9] caTools_1.18.3              digest_0.6.37
#> [11] magrittr_2.0.4              evaluate_1.0.5
#> [13] grid_4.5.1                  bookdown_0.45
#> [15] fastmap_1.2.0               jsonlite_2.0.0
#> [17] Matrix_1.7-4                tinytex_0.57
#> [19] BiocManager_1.30.26         codetools_0.2-20
#> [21] jquerylib_0.1.4             abind_1.4-8
#> [23] cli_3.6.5                   rlang_1.1.6
#> [25] XVector_0.50.0              Biobase_2.70.0
#> [27] splines_4.5.1               cachem_1.1.0
#> [29] DelayedArray_0.36.0         yaml_2.3.10
#> [31] BiocBaseUtils_1.12.0        S4Arrays_1.10.0
#> [33] tools_4.5.1                 parallel_4.5.1
#> [35] SummarizedExperiment_1.40.0 BiocGenerics_0.56.0
#> [37] MultiAssayExperiment_1.36.0 mime_0.13
#> [39] R6_2.6.1                    matrixStats_1.5.0
#> [41] stats4_4.5.1                lifecycle_1.0.4
#> [43] magick_2.9.0                Seqinfo_1.0.0
#> [45] S4Vectors_0.48.0            IRanges_2.44.0
#> [47] pdist_1.2.1                 bslib_0.9.0
#> [49] Rcpp_1.1.0                  xfun_0.53
#> [51] GenomicRanges_1.62.0        MatrixGenerics_1.22.0
#> [53] knitr_1.50                  htmltools_0.5.8.1
#> [55] rmarkdown_2.30              compiler_4.5.1
```