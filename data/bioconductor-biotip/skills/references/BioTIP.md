# BioTIP: an R-package for Characterization of Biological Tipping-Points

#### Zhezhen Wang, Andrew Goldstein, Yuxi Sun, Biniam Feleke, Qier An, Antonio Feliciano, Ieva Tolkaciovaite, and Xinan H Yang

#### 10/29/2025

Abstract

Abrupt and irreversible changes (or tipping points) are decisive in the progression of biological processes. To detect tipping points from gene expression profiles, however, longitudinal data required by classic approaches are usually unavailable. When systems have discrete phenotypes with characteristic transcriptomes, we can adopt tipping-point models to sample ensembles in order. Here, we developed a robust framework, BioTIP, to address two computational impediments: detection of tipping-points accurately, and identification of non-chaotic critical transition signals (CTSs). In the first step, we refined correlation-based tipping-point models by a shrinkage estimation of large-scale correlation matrices. Secondly, non-random CTS identification was advanced by new gene selection, network graph-based clustering, and rigorous evaluation. Validating these approaches, we applied BioTIP to disease and normal developmental systems, covering bulk-cell and single-cell transcriptomes. We identified temporal features of gene-regulatory-network dynamics for phenotypically-defined tipping points, which can be exploited to infer the role of key transcription factors. Additional exploration of the critical transitions in discrete systems can be tested using BioTIP.

#### [Standard Workflow](#Standard%20workflow)

We designed the BioTIP workflow in the following five steps (Fig 1). In this workflow, two steps (Steps 2 and 5) calculated the random scores from randomly selected genes. In step 2, the distribution of random scores is designed to predict the potential tipping point. The rationale is that random genes can, in cases, capture the “symmetry-breaking destabilization” at tipping points (Mojtahedi 2016). In step 5, the random scores are used to validate the significance of the predicted critical transition signals (CTSs). A CTS measures the loss of resilience of previous states and the gain of instability during transitions (Scheffer, 2012). Because a CTS could be both “regulated” or “chaotic”, the detection of non-random CTSs is important and has successes in development and diseases (Chen, 2012, Sarkar, 2019). The same R function (Table 1) can be used to calculate the random scores, for which we demonstrate the implication of Step 5 in the two following sections.

![Fig 1. BioTIP workflow with five key analytical steps. RTF: relative transcript fluctuation; PCC: Pearson correlation coefficient; DNB: Dynamic Network Biomarker, of which the score was called as Module-Criticality Index (MCI) in the R package BioTIP; Ic: index of critical transition.; Ic*: our redefined Ic, which is also referred to as the BioTIP score](data:image/jpeg;base64...)

Fig 1. BioTIP workflow with five key analytical steps. RTF: relative transcript fluctuation; PCC: Pearson correlation coefficient; DNB: Dynamic Network Biomarker, of which the score was called as Module-Criticality Index (MCI) in the R package BioTIP; Ic: index of critical transition.; Ic\*: our redefined Ic, which is also referred to as the BioTIP score

![Table 1. The key R functions and customaized parameters for the five analytical steps.](data:image/jpeg;base64...)

Table 1. The key R functions and customaized parameters for the five analytical steps.

* [An Identification of Critical Tipping Point using Bulk RNA-seq](#An%20Identification%20of%20Critical%20Tipping%20Point%20using%20Bulk%20RNA-seq)
  + ##### [Data Preprocessing](#Data%20Preprocessing)
  + ##### [Pre-selection Transcript](#Pre-selection%20Transcript)
  + ##### [Network Partition](#Network%20Partition)
  + ##### [Identifying putative Critical Transition Signals (CTS) using the DNB Module](#Identifying%20putative%20Critical%20Transition%20Signals%20(CTS)%20using%20the%20DNB%20Module)
  + ##### [Finding Tipping Point and Evaluating CTS](#Finding%20Tipping%20Point%20and%20Evaluating%20CTS)
* [Applying to scRNA-seq Data](#Applying%20to%20scRNA-seq%20Data)
  + ##### [Advanced Estimation for Pearson Correlation Coefficient Matrix](#Advanced%20Estimation%20for%20Pearson%20Correlation%20Coefficient%20Matrix)
  + ##### [Data Preprocessing with Trajectory Building Tools](#Data%20Preprocessing%20with%20Trajectory%20Building%20Tools)
  + ##### [Predicting Tipping Point (Advanced Index of Critical Transition (IC\*))](#Predicting%20Tipping%20Point%20(Advanced%20Index%20of%20Critical%20Transition%20(IC*)))
  + ##### [Gene Pre-selection](#Gene%20Pre-selection)
  + ##### [Network Partition](#Network%20Partition2)
  + ##### [Identifying putative Critical Transition Signals (CTS) using the DNB Module](#Identifying%20putative%20Critical%20Transition%20Signals%20(CTS)%20using%20the%20DNB%20Module)
  + ##### [Finding Tipping Point and Evaluating CTS](#Finding%20Tipping%20Point%20and%20Evaluating%20CTS)
  + ##### [Inferring Tipping Point-Driven Transcription Factors](#Inferring%20Tipping%20Point-Driven%20Transcription%20Factors)
* [Transcript Annotation and Biotype](#Transcript%20Annotation%20and%20Biotype)
  + ##### [Quick Start](#Quick%20Start)
  + ##### [Genomic Data Source](#Genomic%20Data%20Source)
  + ##### [Extracting Summary Data](#Extracting%20Summary%20Data)
  + ##### [Loading Data](#Loading%20Data)
  + ##### [Prepare GRanges Object](#Prepare%20GRanges%20Object)
* [Acknowledgements](#Acknowledgements)
* [SessionInfo](#SessionInfo)
* [References](#References)

### An Identification of Critical Tipping Point using Bulk RNA-seq

**Data Preprocessing**

An existing dataset, GSE6136, is used to demonstrate how our functions are applied. Samples were collected from transgenic mouse lymphomas and divided into five groups based on clinical presentation, pathology and flow cytometry (Lenburg 2007), thus belonging to cross-sectional profiles. Noticing these five group represent a control stage similar to non-transgenic B cells and four major periods of B-cell lymphomagenesis, Dr. Chen and coauthors used the DNB method to identify the pre-disease state exists around the normal activated period (P2), i.e., the system transitions to the disease state around the transitional lymphoma period (Figure S12 in publication (Chen 2012)). Start by installing the package ‘BioTIP’ and other dependent packages such as stringr, psych, and igraph if necessary. Below are some examples.

```
# load BioTIP and dependent packages
library(BioTIP)
library(cluster)
library(GenomicRanges)
library(MASS)
require(stringr)
require(psych)
require(igraph)
```

Once all the required packages are installed, load the GEO-downloaded gene expression matrix as follows. Notice that we removed the downloaded first row after assigning it to be column-name of the final numeric data matrix.

```
data(GSE6136_matrix)
dim(GSE6136_matrix)
#> [1] 22690    27
row.names(GSE6136_matrix) = GSE6136_matrix$ID_REF

# remove the downloaded first row after assigning it to be column-name of the final numeric data matrix
GSE6136 = GSE6136_matrix[,-1]
dim(GSE6136)
#> [1] 22690    26
```

The summary of GSE6136\_matrix is the GSE6136\_cli shown below. These two data files can be downloaded from GEO database.

```
data(GSE6136_cli)
##dim(GSE6136_cli) optional: check dimension

cli = t(GSE6136_cli)

colnames(cli) = str_split_fixed(cli[1,],'_',2)[,2]
cli = cli[-1,]
cli = data.frame(cli)
cli[,"cell-type:ch1"] = str_split_fixed(cli$characteristics_ch1.1,": ",2)[,2]
cli[,"Ig clonality:ch1"] = str_split_fixed(cli$characteristics_ch1.3,": ",2)[,2]

colnames(cli)[colnames(cli) == "cell-type:ch1"] = "group"
cli$Row.names = cli[,1]
head(cli[,1:3])
#>    geo_accession                status submission_date
#> V2     GSM142398 Public on Oct 28 2006     Oct 25 2006
#> V3     GSM142399 Public on Oct 28 2006     Oct 25 2006
#> V4     GSM142400 Public on Oct 28 2006     Oct 25 2006
#> V5     GSM142401 Public on Oct 28 2006     Oct 25 2006
#> V6     GSM142402 Public on Oct 28 2006     Oct 25 2006
#> V7     GSM142403 Public on Oct 28 2006     Oct 25 2006
```

We normalized the expression of genes using log2() transformation. This normalization will ensure a more accurate comparison of the variances between expression groups, or clusters.

```
dat <- GSE6136
df <- log2(dat+1)
head(df[,1:6])
#>              GSM142398 GSM142399 GSM142400 GSM142401 GSM142402 GSM142403
#> 1415670_at   10.219169 10.290480  9.987548 10.076816  9.827343  9.871289
#> 1415671_at   10.903581 11.159934 10.776186 10.929998 11.468268 11.200408
#> 1415672_at   11.115304 10.892087 11.091303 11.040290 11.109504 11.325305
#> 1415673_at    8.990388 10.265615  8.742141  8.422065  8.963474  8.874674
#> 1415674_a_at  9.911692 10.665869  9.942661  9.793766 10.243650 10.147078
#> 1415675_at    9.524933  9.896332  9.590774  9.375474  9.392747  9.422065
```

Go to Top

**Pre-selection Transcript**

Once normalized, we can now classify the different stages. The tipping point is within the “activated” state in this case. Here we see the number of samples that are classified into states “activated”, “lymphoma\_aggressive”, “lymphoma\_marginal”, “lymphoma\_transitional” and “resting”. For instance, states “activated” and “resting” contain three and four samples, respectively. All the contents of the data set “test” can be viewed using `View(test)`. The contents of each clinical state can be viewed using the `head` function.

```
cli$group = factor(cli$group,
                   levels = c('resting','activated','lymphoma_marginal','lymphoma_transitional','lymphoma_aggressive'))
samplesL <- split(cli[,"geo_accession"],f = cli$group)
lapply(samplesL, length)
#> $resting
#> [1] 5
#>
#> $activated
#> [1] 3
#>
#> $lymphoma_marginal
#> [1] 6
#>
#> $lymphoma_transitional
#> [1] 5
#>
#> $lymphoma_aggressive
#> [1] 7
test <- sd_selection(df, samplesL,0.01)
head(test[["activated"]])
#>              GSM142399 GSM142422 GSM142423
#> 1415766_at    7.600656  8.778077  9.036723
#> 1415827_a_at 11.002252 13.079218 13.205503
#> 1415904_at   12.229810  5.885086  4.217231
#> 1415985_at   11.786106 10.736656 10.044940
#> 1416034_at   11.417114 13.474682 13.760252
#> 1416071_at   11.194388 10.362273  9.993646
```

Go to Top

**Network Partition**

A graphical represetation of genes of interest can be achieved using the functions shown below. The `getNetwork` function will obtain an igraph object based on a pearson correlation of `test`. This `igraphL` object is then run using the `getCluster_methods` function classify nodes.

```
igraphL <- getNetwork(test, fdr = 1)
#> resting:226 nodes
#> activated:226 nodes
#> lymphoma_marginal:226 nodes
#> lymphoma_transitional:226 nodes
#> lymphoma_aggressive:226 nodes
cluster <- getCluster_methods(igraphL)
```

```
names(cluster)
#> [1] "resting"               "activated"             "lymphoma_marginal"
#> [4] "lymphoma_transitional" "lymphoma_aggressive"
```

Go to Top

**Identifying putative Critical Transition Signals (CTS) using the DNB Module**

Here, ‘module’ refers to a cluster of network nodes (e.g. transcripts) highly linked (e.g. by correlation). “Biomodule” refers to the module representing the score called “Module-Criticality Index (MCI)” per state.

The following step shows a graph of classified clustered samples for five different stages. MCI score is calculated for each module using the `getMCI` function. The `getMaxMCImember` function will obtain a list of modules with highest MCI at each stage, where the parameter min sets the minimal number of genes required in a module. Use `"head(maxCIms)"` to view the MCI scores calculated. Use `plotMaxMCI` function to view the MCI score at each stage.

```
membersL_noweight <- getMCI(cluster,test)
plotBar_MCI(membersL_noweight,ylim = c(0,6))
```

![](data:image/png;base64...)

```
maxMCIms <- getMaxMCImember(membersL_noweight[[1]],membersL_noweight[[2]],min =10)
names(maxMCIms)
#> [1] "idx"     "members"
names(maxMCIms[[1]])
#> [1] "resting"               "activated"             "lymphoma_marginal"
#> [4] "lymphoma_transitional" "lymphoma_aggressive"
names(maxMCIms[[2]])
#> [1] "resting"               "activated"             "lymphoma_marginal"
#> [4] "lymphoma_transitional" "lymphoma_aggressive"
```

```
head(maxMCIms[['idx']])
#> $resting
#> 3
#> 3
#>
#> $activated
#> 3
#> 3
#>
#> $lymphoma_marginal
#> 1
#> 1
#>
#> $lymphoma_transitional
#> 5
#> 5
#>
#> $lymphoma_aggressive
#> 1
#> 1
head(maxMCIms[['members']][['lymphoma_aggressive']])
#> [1] "1416001_a_at" "1416002_x_at" "1416527_at"   "1416754_at"   "1416771_at"
#> [6] "1417133_at"
```

To get the selected statistics of biomodules (the module that has the highest MCI score) of each state, please run the following commands:

```
biomodules = getMaxStats(membersL_noweight[['members']],maxMCIms[[1]])
maxMCI = getMaxStats(membersL_noweight[['MCI']],maxMCIms[[1]])
maxMCI = maxMCI[order(maxMCI,decreasing=TRUE)]
head(maxMCI)
#>             activated   lymphoma_aggressive               resting
#>              3.522785              3.334630              2.886293
#> lymphoma_transitional     lymphoma_marginal
#>              2.448548              2.387766
topMCI = getTopMCI(membersL_noweight[[1]],membersL_noweight[[2]],membersL_noweight[['MCI']],min =10)
head(topMCI)
#> activated
#>  3.522785
```

```
maxSD = getMaxStats(membersL_noweight[['sd']],maxMCIms[[1]])
head(maxSD)
#>               resting             activated     lymphoma_marginal
#>              1.469989              2.139577              1.295115
#> lymphoma_transitional   lymphoma_aggressive
#>              1.790035              1.885470
```

To get the biomodule with the MCI score among all states, as we call it CTS (Critical Transition Signals), please run the following command:

```
CTS = getCTS(topMCI, maxMCIms[[2]])
#> Length: 35
```

Run the following commands to visualize the trendence of every state represented by the cluster with the highest MCI scores:

```
par(mar = c(10,5,0,2))
plotMaxMCI(maxMCIms,membersL_noweight[[2]],states = names(samplesL),las = 2)
```

![](data:image/png;base64...)

We then perform simulation for MCI scores based on identified signature size (length(CTS) ) using the `simulationMCI` function. Use `plot_MCI_simulation`function to visualize the result. This step usually takes 20-30 minutes, so here we picked a small number 3 as the length of the CTS for demonstration purposes.

```
simuMCI <- simulationMCI(3,samplesL,df, B=100)
plot_MCI_Simulation(topMCI[1],simuMCI,las=2)
```

![](data:image/png;base64...)

Go to Top

**Finding Tipping Point and Evaluating CTS**

The next step is to calculate an Index of Critical transition (Ic score) of the dataset. First, use the `getIc` function to calculate the Ic score based on the biomodule previously identified. We use the `plotIc` function to draw a line plot of the Ic score.

```
IC <- getIc(df,samplesL,CTS[[1]],PCC_sample.target = 'average')
par(mar = c(10,5,0,2))
plotIc(IC,las = 2)
```

![](data:image/png;base64...)

Then we use the two functions to evaluate two types of empirical significance, respectively.

The first function `simulation_Ic` calculates random Ic-scores by shuffling features (transcripts). Showing in the plot is Ic-score of the identification (red) against its corresponding size-controlled random scores (grey).

```
simuIC <- simulation_Ic(length(CTS[[1]]),samplesL,df,B=100)
#> Loading required package: iterators
#> Loading required package: parallel
par(mar = c(10,5,0,2))
plot_Ic_Simulation(IC,simuIC,las = 2)
```

![](data:image/png;base64...)

Another function `simulation_Ic_sample` calculates random Ic-scores by shuffling samples and visualizes the results. Showing in the plot is observed Ic-score (red vertical line) comparing to the density of random scores (grey), at the tipping point identified.

```
sample_Ic = simulation_Ic_sample(df, sampleNo=3, genes=CTS[[1]], plot=TRUE)
```

![](data:image/png;base64...)

```
##simulated_Ic = plot_simulation_sample(df,length(samplesL[['lymphoma_aggressive']]),IC[['lym#phoma_aggressive']],CTS)
```

Go to top

### Applying to scRNA-seq Data

As scRNA-seq is becoming more popular, there is a vast amount of information and computational tools. We recommend Bioconductor Workshops which have a variety of topics for not only beginner users but also novice users and developers. Helpful information is available at <https://bioconductor.github.io/BiocWorkshops/>. For orchestrating scRNA-seq analysis with Bioconductor, we recommend the online tutorial <https://osca.bioconductor.org/>. The following figure shows BioTIP’s analytic pipeline of single-cell RNA-seq analysis, as an alternative to differential expression analysis - instead of discovering marker genes from the differential-expression analysis between stable states, BioTIP introduces the tipping-point analysis that focuses on unstable transition states. The orange arrows show that BioTIP is applied to cell state ensembles (clusters) without the pseudo-order information. The dashed orange arrow shows that BioTIP may use pseudo-order information to focus cell states on the trajectory of interests.

![Fig 2. BioTIP Single-Cell Expression Data-Analytical Pipeline.](data:image/jpeg;base64...)

Fig 2. BioTIP Single-Cell Expression Data-Analytical Pipeline.

**Advanced Estimation for Pearson Correlation Coefficient Matrix**

Ic (Index of criticity) and DNB (dynamic network module which we renamed as MCI) are two existing tipping-point models applied to gene expression profiles (Mojtahedi M 2016, Chen 2012). These two modules have an intrinsic limit in the standard correlation calculation that is inappropriate for large-scale genomic data (Schafer 2005). This limit establishes a bias towards small-sized populations. Having differences in population sizes of 10-fold, ScRNAseq data is particularly vulnerable to this deficiency. We propose an advanced estimation of correlation matrices (Schafer 2005) to correct the bias of the existing mathematical models. The implication is the functions `ave.cor.shrink`. Using this shrinkage estimation strategy, we refined the tipping-point identification with Ic score, by calling the function `getIc` and setting the parameter fun=’BioTIP’. We also refined the CTS identification with MCI score, by calling the function `getMCI` and setting the parameter fun=’BioTIP’. Remember that when running corresponding functions for random scores (e.g., `simulation_Ic`, `simulation_Ic_sample`, and `simulationMCI`, also set the parameter fun=’BioTIP.’ Following is an example of applications to scRNA-seq data.

Go to top

**Data Preprocessing with Trajectory Building Tools**

A published dataset, GSE81682, is utilized for BioTIP application to scRNA-sequence data for demonstration purposes.

To apply BioTIP, the input data is the output of a pseudotime (the measure of how far a cell traveled in its process) construction approach. Currently, there are 459 scRNA-seq analytics tools developed by August 2019 (Zappiaet al. 2019). Three candidate tools were widely used for trajectory construction including Seurat, Monocle 3, and STREAM (Chen et al 2019). STREAM has been stated as the only trajectory inference method explicitly implementing a mapping procedure, using the old cells as a reference for new cells (Chen et al 2019). STREAM is available as an interactive website, a bioconda package using Python, and as a command-line with Docker. Ultimately, it has been determined that STREAM has good recall and precision for data with multi-branching structures of high precision.

This study collected and performed scRNA-seq using hematopoietic stem and progenitor cells (HSPCs) from ten female mice (Nestorowa 2016). For more detailed information on hematopoietic cell gating, please refer to <http://blood.stemcells.cam.ac.uk/data/>. The rows in these data represent genes while columns represent cells.The raw data has been adjusted with normalization of the library size and log2 transformation. For data that has not yet been log2 transformed please refer to the example of log2 transformation below.

Here, we demonstrated the utilization of the STREAM Python package to obtain trajectory outputs (Chen et al. 2019). Using STREAM, the expression profiles of approximate 4000 (10% of the originally measured genes) informative genes in 1656 single cells were pre-selected. We downloaded the data matrix from STREAM publication. The rows in the matrix represent genes while columns represent cells. The raw data has been adjusted with normalization of the library size and log2 transformation.

STREAM needs to be installed via bioconda. A detailed instruction for installing STREAM could be found at the STREAM github repository: <https://github.com/pinellolab/STREAM/blob/master/README.md>. A set of parameters can be adjusted for STREAM analysis. For the dataset from Nestorowa et al., we will use the set of parameters summarized by the following command line:

```
stream -m data_Nestorowa.tsv -l cell_label.tsv -c cell_color_label.tsv --norm --loess_frac 1 --pca_n_PC 30  --umap
```

`--norm` normalizes the data matrix; `--loess_frac` indicates the fraction of the data used in LOESS regression with a default value of 0.1 which needs to be increased if the dataset is relatively small; `--pca_n_PC` indicates the number of PC selected; `--umap` uses UMAP for visualization.

STREAM analysis on Nestorowa dataset yields the following output:

![](data:image/jpeg;base64...)

We will be focusing on the path S1-S0-S3-S4 in our analysis.

We begin by installing the ‘BioTIP’ package and other dependent packages, using Bioconductor.To avoid errors, it is recommended to use the latest version of R.

```
library(BioTIP)
```

Once BioTIP is installed we must load dependent R packages:

```
#Load stringr library
library(stringr)
#BioTIP dependent libraries
library(cluster)
library(psych)
library(stringr)
library(GenomicRanges)
# library(Hmisc)
library(MASS)
library(igraph)
# library(RCurl)
```

Once the required packages are installed we want to become familiar with the data using `read.delim` function. The `dim` function will show you the dimensions of your data.

```
## familiarize yourself with data
cell_info = read.delim("cell_info.tsv", head = T, sep = '\t', row.names=1)
dim(cell_info)
#> [1] 1645   13
## in case R automatically reformated characters in cell labels, match cell labels in the data and in the infor table
rownames(cell_info) = sub('LT-HSC', 'LT.HSC', rownames(cell_info))
## focus on one branch, e.g., S4-S3-S0-S1
## no filter because it was already 4k genes, 10% of the originally measured genes in the single cell experiment
cell_info <- subset(cell_info, branch_id_alias %in% c("('S4', 'S3')", "('S3', 'S0')", "('S1', 'S0')" ))
## check cell sub-population sizes along the STREAM outputs
(t = table(cell_info$label, cell_info$branch_id_alias))
#>
#>         ('S1', 'S0') ('S3', 'S0') ('S4', 'S3')
#>   CMP             29           68           92
#>   GMP              6           15           10
#>   LMPP           162           44            0
#>   LTHSC          219           14           28
#>   MEP              7           17          326
#>   MPP             99            0            2
#>   MPP1            60            0            0
#>   MPP2            12            5            5
#>   MPP3            91           31            0
## focus on sub-populations of cells with more than 10 cells
( idx = apply(t, 2, function(x) names(which(x>10))) )
#> $`('S1', 'S0')`
#> [1] "CMP"   "LMPP"  "LTHSC" "MPP"   "MPP1"  "MPP2"  "MPP3"
#>
#> $`('S3', 'S0')`
#> [1] "CMP"   "GMP"   "LMPP"  "LTHSC" "MEP"   "MPP3"
#>
#> $`('S4', 'S3')`
#> [1] "CMP"   "LTHSC" "MEP"
## generate a list of samples (cells) of interest
 samplesL  = sapply(names(idx),
                   function(x) sapply(idx[[x]], function(y)
                   rownames(subset(cell_info, branch_id_alias == x & label == y))))
## check the number of sub-populations along the pseudotime trajectory (generated by STREAM for example)
## recommend to focus on each branch, respectively
names(samplesL[[1]])
#> [1] "CMP"   "LMPP"  "LTHSC" "MPP"   "MPP1"  "MPP2"  "MPP3"
## merge sub-populations at each pseudo-time 'state'
samplesL = do.call(c, samplesL)
lengths(samplesL)
#>   ('S1', 'S0').CMP  ('S1', 'S0').LMPP ('S1', 'S0').LTHSC   ('S1', 'S0').MPP
#>                 29                162                219                 99
#>  ('S1', 'S0').MPP1  ('S1', 'S0').MPP2  ('S1', 'S0').MPP3   ('S3', 'S0').CMP
#>                 60                 12                 91                 68
#>   ('S3', 'S0').GMP  ('S3', 'S0').LMPP ('S3', 'S0').LTHSC   ('S3', 'S0').MEP
#>                 15                 44                 14                 17
#>  ('S3', 'S0').MPP3   ('S4', 'S3').CMP ('S4', 'S3').LTHSC   ('S4', 'S3').MEP
#>                 31                 92                 28                326

## load normalized gene expression matrix, refer to the example below if not yet normalized
## e.g, here is a STREAM-published data matrix of normalized gene expression matrix

## when analyzing SingleCellExperiment object SCE, translate to matrix using the following code
# counts <- logcounts(SCE)
## data matrix imported from our github repository due to large size
githuburl = "https://github.com/ysun98/BioTIPBigData/blob/master/data_Nestorowa.tsv?raw=true"
counts = read.table(url(githuburl), head=T, sep="\t", row.names=1)
dim(counts)
#> [1] 4768 1645
if (class(counts)=="data.frame") counts = as.matrix(counts)

all(colnames(counts) %in% as.character(rownames(cell_info)))
#> [1] FALSE
## log2 transformation example
if(max(counts)>20) counts = log2(counts)
## Check the overall distribution using histogram
# hist (counts, 100)
```

Go to top

**Predicting Tipping Point (Advanced Index of Critical Transition (IC))**

Before the identification of CTS, we first ask whether the tipping point could be inferred from the global transcriptome of this dataset by estimating IC score from random genes. For the theoretical details, please see the original publication of the IC score.

```
## First, estimate the random Ic-scores by permuting the expression values of genes
  RandomIc_g = list()
  set.seed(2020)
  C= 10 # for real data analysis C = at least 500
  i = 1
  n <- 200 # randomly pick up 200 genes
  RandomIc_g[[i]]  <- simulation_Ic(n, samplesL, counts,
                                    B=C,
                                    fun="BioTIP")
  names(RandomIc_g)[i] = paste0("Simulation",i,"gene")

  medianIc = apply(RandomIc_g[[i]],1,median)
  par(mfrow = c(1,1))
  plot_Ic_Simulation(medianIc, RandomIc_g[[i]], las = 2, ylab="BioTIP",
                       main= paste("Simulation using",n,"transcripts"),
                       fun="boxplot", ylim=c(0,0.3))
```

![](data:image/png;base64...)

Go to top

**Gene Pre-selection**

Log-transformed data are now ready for gene preselection. To this end, we have two functions: `sd_selection` and `optimize.sd_selection`. In both functions, the number of preselected genes are sensitive to two key parameters: ‘opt.cutoff’ and ‘opt.per’. For these two parameters, we recommend a range of 100-500 genes to be preselected per cell state. We use `optimize.sd_selection` for scRNA-seq data in contrast to `sd_selection` for limited sample sizes (demonstrated in ‘An Identification of Critical Tipping Point using Bulk RNA-seq’). This function `optimize.sd_selection` is an optimization of the function `sd_selection`, `optimize.sd_selection` selects highly oscillating transcriptsusing sub-sampling strategy repeatedly.

The amount of selected transcripts is based on your input of cutoff value arbitrary between 0.01 and 0.2 with a default value of 0.01. If each state contains more than 10 cells the default cutoff value is suggested.

```
## setup parameters for gene preselection
B=10 ##for demonstration purposes use 10, when running dataset we recommend at least 100
##optimize and one nonoptimize for single cell use optimize with B 100 or higher for demo purpose only we run
opt.cutoff = 0.2
opt.per = 0.8

## Commented out because of calculation expense, recommend to save the calculated data file after one calculation for future use
## set.seed(100)
## subcounts = optimize.sd_selection(counts, samplesL, cutoff = opt.cutoff, percent=opt.per, B)
## save( subcounts, file='BioTIP_Output_xy/subcounts.optimize_80per.rData')
data("subcounts.optimize_80per")
```

Go to top

**Network Partition**

The `getNetwork` function links any two preselected genesthat are co-expressed based onPearson correlation coefficient. An fdr smaller than the cutoff value indicates co-expression. This function’s output is an R ‘igraph’ object. The representation of genes of interest can be visualized using ‘igraphL’.

The `getCluster_methods` function clusters transcript nodes from the correlation network which was generated by `getNetwork`. We suggest each module to contain over 200 nodesfor downstream analysis.

```
## use 0.01-0.2 to ensure gene-gene co-expression is significant
## increase fdr cutoff to obtain larger gene sets
network.fdr = 0.1
min.size = 50
igraphL = getNetwork(subcounts, fdr=network.fdr)
#> ('S1', 'S0').CMP:400 nodes
#> ('S1', 'S0').LMPP:401 nodes
#> ('S1', 'S0').LTHSC:474 nodes
#> ('S1', 'S0').MPP:363 nodes
#> ('S1', 'S0').MPP1:398 nodes
#> ('S1', 'S0').MPP2:248 nodes
#> ('S1', 'S0').MPP3:366 nodes
#> ('S2', 'S0').LMPP:336 nodes
#> ('S2', 'S0').MPP3:498 nodes
#> ('S3', 'S0').CMP:390 nodes
#> ('S3', 'S0').GMP:444 nodes
#> ('S3', 'S0').LMPP:433 nodes
#> ('S3', 'S0').LTHSC:380 nodes
#> ('S3', 'S0').MEP:302 nodes
#> ('S3', 'S0').MPP3:331 nodes
#> ('S4', 'S3').CMP:399 nodes
#> ('S4', 'S3').LTHSC:463 nodes
#> ('S4', 'S3').MEP:671 nodes
#> ('S5', 'S3').CMP:376 nodes
#> ('S5', 'S3').GMP:407 nodes
#> ('S5', 'S3').MPP3:340 nodes
names(igraphL)
#>  [1] "('S1', 'S0').CMP"   "('S1', 'S0').LMPP"  "('S1', 'S0').LTHSC"
#>  [4] "('S1', 'S0').MPP"   "('S1', 'S0').MPP1"  "('S1', 'S0').MPP2"
#>  [7] "('S1', 'S0').MPP3"  "('S2', 'S0').LMPP"  "('S2', 'S0').MPP3"
#> [10] "('S3', 'S0').CMP"   "('S3', 'S0').GMP"   "('S3', 'S0').LMPP"
#> [13] "('S3', 'S0').LTHSC" "('S3', 'S0').MEP"   "('S3', 'S0').MPP3"
#> [16] "('S4', 'S3').CMP"   "('S4', 'S3').LTHSC" "('S4', 'S3').MEP"
#> [19] "('S5', 'S3').CMP"   "('S5', 'S3').GMP"   "('S5', 'S3').MPP3"

## Network partition using random walk
cluster = getCluster_methods(igraphL)

tmp = igraphL[["('S3', 'S0').CMP"]]
E(tmp)$width <- E(tmp)$weight*3
V(tmp)$community= cluster[["('S3', 'S0').CMP"]]$membership
mark.groups = table(cluster[["('S3', 'S0').CMP"]]$membership)
colrs = rainbow(length(mark.groups), alpha = 0.3)
V(tmp)$label <- NA
plot(tmp, vertex.color=colrs[V(tmp)$community],vertex.size = 5,
     mark.groups=cluster[["('S3', 'S0').CMP"]])
```

![](data:image/png;base64...)

Generated above is a graph view of network modulation determined by the random-walk approach for the preselected transcripts at the LIR state. Background colors represent different clusters.

Go to top

**Identifying putative Critical Transition Signals (CTS) using the DNB Module**

Each module is a cluster of network nodes (transcripts) that are linked by correlation in the previous step. Each cell state may have multiple modules identified. Biomodules are the modules with relatively higher MCI scores in the system that has discrete states, while empirically significant.

We have four steps to find the states of interest (i.e. tipping point candidates) and their CTS candidates. We first use the `getMCI` function to obtain MCI scores of the states. Then the user determines how many states may be of interest using function `getTopMCI` and parameter ‘n’. Another parameter ‘min’ is important for the output. It determines the minimum module size for calculating the top MCI scores. Third, we get state IDs and their MCI scores for the states of interest. Here, there are two steps to follow: Step a. for each state of interest we get maximum scores using `getMaxMCImember` and `getMaxStats`. Step b. we use parameter n to obtain modules with relatively high scores besides the top scores. The `getNextMaxStats` function will be applied, we demonstrate the application here (n=2). Next we obtain the CTS of each state of interest using `getCTS`.

The following code documents the four steps:

```
fun = 'BioTIP'

##  Commented out because of calculation expense, recommend to save the calculated data file after one calculation for future use
## membersL = getMCI(cluster, subcounts, adjust.size = F, fun)
## save(membersL, file="membersL.RData", compress=TRUE)
data("membersL")

par(mar=c(1,1,2,1))
plotBar_MCI(membersL, ylim=c(0,30), min=50)
```

![](data:image/png;base64...)

```
## Decide how many states of interest, here is 4
n.state.candidate <- 4
topMCI = getTopMCI(membersL[["members"]], membersL[["MCI"]], membersL[["MCI"]],
                   min=min.size,
                   n=n.state.candidate)
names(topMCI)
#> [1] "('S4', 'S3').CMP"   "('S1', 'S0').LTHSC" "('S4', 'S3').MEP"
#> [4] "('S2', 'S0').MPP3"

## Obtain state ID and MCI statistics for the n=3 leading MCI scores per state
maxMCIms = getMaxMCImember(membersL[["members"]], membersL[["MCI"]],
                           min =min.size,
                           n=3)
names(maxMCIms)
#> [1] "idx"             "members"         "2topest.members" "3topest.members"

## list the maximum MCI score per state, for all states
maxMCI = getMaxStats(membersL[['MCI']], maxMCIms[['idx']])
unlist(maxMCI)
#>  ('S1', 'S0').LMPP ('S1', 'S0').LTHSC   ('S1', 'S0').MPP  ('S1', 'S0').MPP1
#>           1.734805          22.807675           2.859558           6.068915
#>  ('S2', 'S0').MPP3  ('S3', 'S0').LMPP   ('S4', 'S3').CMP   ('S4', 'S3').MEP
#>           9.734967           7.637239          26.468265          12.167936
#>   ('S5', 'S3').CMP
#>           1.394558

#### extract biomodule candidates in the following steps: ####
## record the gene members per toppest module for each of these states of interest
CTS = getCTS(maxMCI[names(topMCI)], maxMCIms[["members"]][names(topMCI)])
#> Length: 58
#> Length: 63
#> Length: 474
#> Length: 98

## tmp calculates the number of bars within each named state
tmp = unlist(lapply(maxMCIms[['idx']][names(topMCI)], length))
## here returns all the groups with exactly 2 bars
(whoistop2nd = names(tmp[tmp==2]))
#> [1] "('S4', 'S3').CMP"   "('S1', 'S0').LTHSC" "('S4', 'S3').MEP"
## here returns all the groups with exactly 3 bars
(whoistop3rd = names(tmp[tmp==3]))
#> character(0)

## add the gene members of the 2nd toppest biomodue in the states with exactly 2 bars
if(length(whoistop2nd)>0)  CTS = append(CTS, maxMCIms[["2topest.members"]][whoistop2nd])
names(CTS)
#> [1] "('S4', 'S3').CMP"   "('S1', 'S0').LTHSC" "('S4', 'S3').MEP"
#> [4] "('S2', 'S0').MPP3"  "('S4', 'S3').CMP"   "('S1', 'S0').LTHSC"
#> [7] "('S4', 'S3').MEP"
## add the gene members of the 2nd toppest biomodue in the states with exactly 3 bars
if(length(whoistop3rd)>0)  CTS = append(CTS, maxMCIms[["2topest.members"]][whoistop3rd])
names(CTS)
#> [1] "('S4', 'S3').CMP"   "('S1', 'S0').LTHSC" "('S4', 'S3').MEP"
#> [4] "('S2', 'S0').MPP3"  "('S4', 'S3').CMP"   "('S1', 'S0').LTHSC"
#> [7] "('S4', 'S3').MEP"

## add the gene members of the 3rd toppest biomodue in the states with exactly 3 bars
if(length(whoistop3rd)>0)  CTS = append(CTS, maxMCIms[["3topest.members"]][whoistop3rd])
names(CTS)
#> [1] "('S4', 'S3').CMP"   "('S1', 'S0').LTHSC" "('S4', 'S3').MEP"
#> [4] "('S2', 'S0').MPP3"  "('S4', 'S3').CMP"   "('S1', 'S0').LTHSC"
#> [7] "('S4', 'S3').MEP"
```

Go to top

**Finding Tipping Point and Evaluating CTS**

To find the tipping point of the above-detected tipping point candidates we calculate the Index of Critical Transition or the Ic score using the `getIc` function. The `plotIc` function is used to obtain a line plot of the Ic score. The function `simulation_Ic` calculates random Ic scores by permutating transcript expression values. The function `simulation_Ic_sample` calculates random Ic scores by shuffling cell labels. Only the states with significant Ic scores are where the tipping points will be identified.

`plot_Ic_Simulation` function compares observed Ic scores with simulated Ic scores across states. The parameter ‘fun’ can be adjusted to produce either line plot or box plot.

`plot_SS_Simulation` function compares observed with simulated Ic scores across states, given p-value based on the delta scores. Given one biomodule, we calculate the Ic scores across states. Then the delta score calculates the distance between the first largest and second largest Ic scores among states. Similarly, in the simulation cases we have simulated delta scores. When the module presents a significant delta score it is the identified CTS.

```
#### extract CTS scores for each biomodule candidate in the following steps: ####
## first to record the max MCI for the n.state.candidate
maxMCI <- maxMCI[names(CTS)[1:n.state.candidate]]
maxMCI

## then applendix the 2nd highest MCI score (if existing) for the states with exactly 2 bars
if(length(whoistop2nd)>0) maxMCI <- c(maxMCI, getNextMaxStats(membersL[['MCI']], idL=maxMCIms[['idx']], whoistop2nd))
names(maxMCI)
## applendix the 2nd highest MCI score (if existing) for the states with exactly 3 bars
if(length(whoistop3rd)>0) maxMCI <- c(maxMCI, getNextMaxStats(membersL[['MCI']], idL=maxMCIms[['idx']], whoistop3rd))
names(maxMCI)

## then applendix the 3rd highest MCI score (if existing) for the states with exactly 3 bars
if(length(whoistop3rd)>0) maxMCI <- c(maxMCI, getNextMaxStats(membersL[['MCI']], idL=maxMCIms[['idx']], whoistop3rd, which.next=3))
maxMCI

## to ensure the same order between maxMCI  and CTS
all(names(CTS) == names(maxMCI))

##  estimate empritical significance from the MCI scores

## M is precalculated correlation matrix for large dataset (>2k genes), will be reused in the downstream simulation analysis
#counts = read.table("data_Nestorowa.tsv")
#if (class(counts)=="data.frame") counts = as.matrix(counts)
#M <- cor.shrink(counts, Y = NULL, MARGIN = 1, shrink = TRUE)
#save(M, file="cor.shrink_M.RData", compress=TRUE)
#dim(M)

## C is the runs of permutations to estimate random scores
#C = 10 # for real data analysis C = at least 200
#RandomMCI = list()
#n <- length(CTS)  # number of CTS candidates
#set.seed(2020)
#for (i in 1:n) #
#  i=1; par(mfrow=c(1,1))
#  x <- length(CTS[[i]])
#  RandomMCI[[i]] <- simulationMCI(x, samplesL, counts,  B=C, fun="BioTIP", M=M)
#  dim(RandomMCI)

#  plot_MCI_Simulation(maxMCI[i], RandomMCI[[i]], las=2,
#                      ylim=c(0, max(maxMCI[i], 2*RandomMCI[[i]])),
#                      main=paste(names(maxMCI)[i], length(CTS[[i]]), "genes",
#                                 "\n","vs. ",C, "times of gene-permutation"),
#                      which2point=names(maxMCI)[i])

######## Finding Tipping Point #################

  newIc_score = lapply(CTS, function(x) getIc(counts, samplesL, x, fun="BioTIP", PCC_sample.target = 'average'))
  names(newIc_score) <- names(CTS)
```

We provided the detail step for calculating the M matrix and plotting MCI simulation but skipped the calculation of M matrix for size and run time concerns. The result of the simulation is described in the plot below:

![](data:image/jpeg;base64...)

```
######## verify using IC score #################
## First, estimate the random Ic-scores by permuating the expresion values of genes
  RandomIc_g = list()
  set.seed(2020)
  C= 10 # for real data analysis C = at least 500
#  for(i in 1:length(CTS)){ Not to run the full loop B# }
  i = 1
  CTS <- CTS[[i]]
  n <- length(CTS)
  RandomIc_g[[i]]  <- simulation_Ic(n, samplesL, counts,
                                    B=C,
                                    fun="BioTIP")
  names(RandomIc_g)[i] = names(CTS)[i]

#  par(mfrow=c(1,length(int)))
#  for(i in 1:length(newIc_score)){ Not to run the full loop B plotting
    par(mfrow = c(1,1))
    n = length(CTS[[i]])
    plot_Ic_Simulation(newIc_score[[i]], RandomIc_g[[i]], las = 2, ylab="BioTIP",
                       main= paste(names(newIc_score)[i],"(",n," transcripts)"),
                       #fun="matplot", which2point=names(newIc_score)[i])
                       fun="boxplot", which2point=names(newIc_score)[i], ylim=c(0,0.5))
```

![](data:image/png;base64...)

```
    interesting = which(names(samplesL) == names(newIc_score[i]))
    p = length(which(RandomIc_g[[i]][interesting,] >= newIc_score[[i]][names(newIc_score)[i]]))
    p = p/ncol(RandomIc_g[[i]])
    # first p value (p1) calculated for exactly at tipping point
    p2 = length(which(RandomIc_g[[i]] >= newIc_score[[i]][names(newIc_score)[i]]))
    p2 = p2/ncol(RandomIc_g[[i]])
    p2 = p2/nrow(RandomIc_g[[i]])
    # second p value (p2) calculated across all statuses
    ## local Kernel Density Plot
    d <- density(RandomIc_g[[i]]) # returns the density data
    plot(d, xlim=range(c(newIc_score[[i]],RandomIc_g[[i]])),
         main=paste("Random genes: p.Local=",p)) # plots the results
    abline(v=newIc_score[[i]][names(newIc_score)[i]], col="green")
```

![](data:image/png;base64...)

```
    ## global Kernel Density Plot
    d <- density(unlist(RandomIc_g)) # returns the density data
    plot(d, xlim=range(c(newIc_score[[i]],unlist(RandomIc_g))),
         main=paste("Random genes: p.Global=",p2)) # plots the results
    abline(v=newIc_score[[i]][names(newIc_score)[i]], col="green")
```

![](data:image/png;base64...)

```
#  }  Not to run the full loop B plotting

    ## Second, estimate the random Ic-scores by randomly shulffing cell labels
    RandomIc_s = list()
    set.seed(2020)
    #  for(i in 1:length(CTS)){ Not to run the full loop C
    i = 1
    RandomIc_s[[i]] <- matrix(nrow=length(samplesL), ncol=C)
    rownames(RandomIc_s[[i]]) = names(samplesL)
    for(j in 1:length(samplesL)) {
      ns <- length(samplesL[[j]])  # of cells at the state of interest
      RandomIc_s[[i]][j,] <- simulation_Ic_sample(counts, ns,
                                                  Ic=BioTIP_score[x],
                                                  genes=CTS,
                                                  B=C,
                                                  fun="BioTIP")
    }
    names(RandomIc_s)[i] = names(CTS)[i]
    #  } Not to run the full loop C

    #  par(mfrow=c(1,length(int)))
    #  for(i in 1:length(newIc_score)){ Not to run the full loop C plotting
    n = length(CTS[[i]])
    plot_Ic_Simulation(newIc_score[[i]], RandomIc_s[[i]], las = 2, ylab="BioTIP",
                       main= paste(names(newIc_score)[i],"(",n," transcripts)"),
                       fun="boxplot", which2point=names(newIc_score)[i])
```

![](data:image/png;base64...)

```
    interesting = which(names(samplesL) == names(newIc_score[i]))
    p = length(which(RandomIc_s[[i]][interesting,] >= newIc_score[[i]][names(newIc_score)[i]]))
    p = p/ncol(RandomIc_s[[i]])
    # first p value (p1) calculated for exactly at tipping point
    p2 = length(which(RandomIc_s[[i]] >= newIc_score[[i]][names(newIc_score)[i]]))
    p2 = p2/ncol(RandomIc_s[[i]])
    p2 = p2/nrow(RandomIc_s[[i]])
    p
    p2
    #  }  Not to run the full loop C plotting

## Alternatively, p values is estimated from delta scores
P3 = plot_SS_Simulation(newIc_score[[i]], RandomIc_s[[i]],
                       xlim=c(0, max(newIc_score[[i]], RandomIc_s[[i]])),
                       las=2,
                       main=paste(names(CTS)[i], length(CTS[[i]]), "genes, ", "\n", C, "Shuffling labels"))
```

![](data:image/png;base64...)

```
P3
#> [1] 0.5
```

Note that in order to save running time in this vignette, we omitted the full loop and scaled down the runs of permutations when estimating random scores because the main goal of this document is to guide the users through the analysis pipeline and the related functions. In our full experiment, we estimated radom scores for all four of `('S4', 'S3').CMP`, `('S1', 'S0').LTHSC`, `('S4', 'S3').MEP`, and `('S2', 'S0').MPP3` with 200 runs of permutations. Our results can be summarized in the following charts:

![](data:image/jpeg;base64...)![](data:image/jpeg;base64...)

Go to Top

**Inferring Tipping Point-Driven Transcription Factors**

Characterizing the tipping point by CTS is a key to understanding biological systems that are non-stationary, high-dimensional, and noisy, being fascinating to study but hard to understand. Using BioTIP, one can identify non-random critical-transition-characteristic CTSs. To evaluate whether these gene features inform key factors of biological progression that were previously unexplored, motif enrichment analysis could be applied. We recommend the tools HOMER (<http://homer.ucsd.edu/homer/motif/>), MEME Suite (<http://meme-suite.org/>), and the Bioconductor package PWMEnrich (<https://www.bioconductor.org/packages/release/bioc/html/PWMEnrich.html>).

Go to Top

### Transcript Annotation and Biotype

**Quick Start**

The R function `getBiotype` is used to group transcripts of interest into 11 biotypes based on GENCODE annotation (Fig 2a). When a query transcript overlaps at least half with a GENCODE transcript on the same strand, this query transcript will inherit the biotype of the GENCODE transcript.

In the previous study conducted, five out of the 11 biotypes showed high protein-coding potential while the others did not (Fig 2b) [4]. We thus concluded these seven other biotypes, including protein-coding antisense RNAs, to be lncRNAs. The remaining coding biotypes in this study included canonic protein coding (CPC), ‘PC\_mixed’, and ‘PC\_intron’.

First start by loading the required libraries: “GenomeInfoDb,” “BioTIP,” “GenomicRanges,” “IRanges” and “BioTIP”. Next load the datasets: “gencode”, “ILEF”, “intron” and “cod”. Using these datasets, excute BioTIP functions getBiotypes and getReadthrough as follows. These steps assume you installed the “BioTIP” package. If you did not install the package, use the `install.packages("BioTIP")` to install in R.

![](data:image/jpeg;base64...)

Fig 2. A getBiotypes workflow and protein-coding potential in real data analysis [4]. (a) Workflow of an in-house R function (getBiotypes) to query transcripts of interests and classify into biotypes. (b) Pie-chart of eleven types of transcripts assembled from polyadenylated RNA(TARGET). (c) Empirical cumulative distribution plot comparing the transcripts across all 11 biotypes. The protein-coding potential was estimated with the Coding Potential Assessment Tool (CPAT). Line color codes biotypes. The more a line towards the right-bottom corner, the lower protein-coding potential it has.

```
library(BioTIP)
data(gencode)
head(gencode)
#> GRanges object with 6 ranges and 1 metadata column:
#>       seqnames          ranges strand |  biotype
#>          <Rle>       <IRanges>  <Rle> | <factor>
#>   [1]    chr21 9683191-9683272      + |    miRNA
#>   [2]    chr21 9683191-9683272      + |    miRNA
#>   [3]    chr21 9683191-9683272      + |    miRNA
#>   [4]    chr21 9825832-9826011      + |    miRNA
#>   [5]    chr21 9825832-9826011      + |    miRNA
#>   [6]    chr21 9825832-9826011      + |    miRNA
#>   -------
#>   seqinfo: 25 sequences from an unspecified genome; no seqlengths
```

These illustrations above assumes you have installed “BioTIP” package. If you did not install the package already, use the `install.packages("BioTIP")` to install in R.

Go to Top

**Genomic Data Source**

High quality human genome sequence data can be obtained from various sources. To demonstrate this package, we obtained a comprehensive gene annotation of human GRCh37 from [GENCODE](https://www.gencodegenes.org/human). For our illustrations, human GRCh37 data will be used. A standard file structure, similar to general transfer format (gtf) format, is required for this package. This gtf file organizes genomic data in rows and columns (fields). Each row contains information about specific samples. The columns are tab separated headers of the data frame. There are eight fixed columns with specific headers. An example of gtf format is shown below. For details of the gtf file format visit this [link](https://useast.ensembl.org/info/website/upload/gff.html#tracklines%20target=%22_blank%22).

![](data:image/jpeg;base64...)

Chromosome 21 of human GRCh37 gtf

The table above contains a chr21 dataset which was extracted from a full genome dataset. An extraction method for filtering chr21 from `gencode` file is described below.

Go to Top

**Extracting Summary Data**

Before any further analysis, we need to summarize the content of the raw gtf data. There are two ways to get genome biotypes: a) “transcript\_type” b) “gene\_type”. Due to our interst in coding and noncoding regions, the `transcript_type` method was used to extract the regions of interest using python script shown below. **Note** that the `"PATH_FILE"` refers to the path where the downloded gtf file is located. For instance, if the gtf file is located on your `desktop`, replace the `"PATH_FILE"` Cc `"Users/user/Desktop/gtf"`.

**Python codes:**

```
gtf = ("Your/PATH/TO/THE/FILE")
outF = open("gtf_summary_transbiotype.txt","w")

def getquote(str,f,target):
    targetLen = len(target)+2
    strInd = str.find(target)
    st = strInd + len(target)+2
    ed = st + str[st:].find("";")
    #print(st,ed)
    f.write("\t"+str[st:ed]) if strInd!= -1 else f.write("\t"+"NA.")

with open(gtf, "r") as f:
     for line in f:
        if line[0] != "#":
            chromosome = line.split("\t")[0]
            st = line.split("\t")[3]
            ed = line.split("\t")[4]
            strand = line.split("\t")[6]
            type = line.split("\t")[2]
            outF.write(chromosome+"\t"+st+"\t"+ed+"\t"+strand+"\t"+type)
            c = "transcript_id"
            g = "gene_name"
            t = "transcript_type"
            getquote(line,outF,c)
            getquote(line,outF,g)
            getquote(line,outF,t)
            outF.write("\n")
outF.close()
```

---

Go to Top

**Loading Data**

In order to load your data from a local drive, use the following format. **Note** that the `"PATH_FILE"` refers to the location of the summary data from the above section. For more details on how to load datasets click [here](https://support.rstudio.com/hc/en-us/articles/218611977-Importing-Data-with-RStudio).

##### loading data from local drive

> data <- read.delim(“PATH\_FILE”, comment.char = “#”)

Internal BioTIP package data is included in the data folder. The data can be loaded into R working console using `data()`function. Here we show an example of how to load a dataset `gencode` from the data directory. A quick view of the data can be achieved using `head(gencode)`.

```
library(BioTIP)
library(GenomicRanges)
data(gencode)
head(gencode)
#> GRanges object with 6 ranges and 1 metadata column:
#>       seqnames          ranges strand |  biotype
#>          <Rle>       <IRanges>  <Rle> | <factor>
#>   [1]    chr21 9683191-9683272      + |    miRNA
#>   [2]    chr21 9683191-9683272      + |    miRNA
#>   [3]    chr21 9683191-9683272      + |    miRNA
#>   [4]    chr21 9825832-9826011      + |    miRNA
#>   [5]    chr21 9825832-9826011      + |    miRNA
#>   [6]    chr21 9825832-9826011      + |    miRNA
#>   -------
#>   seqinfo: 25 sequences from an unspecified genome; no seqlengths
```

Go to Top

**Prepare GRanges Object**

Here we show an extraction of “gencode” dataset using R commands. Note to replace `PATH_FILE` with file direcotry path. `gtf` refers to the full genome file. A subset function was used to filter chr21 dataset as follows.

`chr21 <- subset(gencode, seqnames == "chr21")` #“genecode” = whole genome gtf

```
> gtf = read.table("PATH_FILE")
> gtf = subset(gtf, biotype == "transcript")
> colnames(gtf) = c("chr","start","end","strand","biotype")
> gr = GRanges(gtf)
```

Go to Top

##### Processing Query

---

```
query <- GRanges(c("chr1:2-10:+","chr1:6-10:-"), Row.names = c("trans1","trans2"), score = c(1,2))
head(query)
#> GRanges object with 2 ranges and 2 metadata columns:
#>       seqnames    ranges strand |   Row.names     score
#>          <Rle> <IRanges>  <Rle> | <character> <numeric>
#>   [1]     chr1      2-10      + |      trans1         1
#>   [2]     chr1      6-10      - |      trans2         2
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

##### Classifying Biotypes

---

```
library(BioTIP)
gr <- GRanges(c("chr1:1-5:+","chr1:2-3:+"),biotype = c("lincRNA","CPC"))
head(gr)
#> GRanges object with 2 ranges and 1 metadata column:
#>       seqnames    ranges strand |     biotype
#>          <Rle> <IRanges>  <Rle> | <character>
#>   [1]     chr1       1-5      + |     lincRNA
#>   [2]     chr1       2-3      + |         CPC
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

##### Extracting intron coordinates

---

```
  # Intron coordinates

   intron <- GRanges("chr1:6-8:+")
```

```
intron <- GRanges("chr1:6-8:+")
head(intron)
#> GRanges object with 1 range and 0 metadata columns:
#>       seqnames    ranges strand
#>          <Rle> <IRanges>  <Rle>
#>   [1]     chr1       6-8      +
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

##### Filtering coding transcripts

---

```
# Filtering non-coding regions using products from example 1, 2 and 3
```

```
intron_trncp <- getBiotypes(query, gr, intron)
intron_trncp
#>   seqnames start end width strand Row.names score type.fullOverlap
#> 1     chr1     2  10     9      +    trans1     1          de novo
#> 2     chr1     6  10     5      -    trans2     2          de novo
#>   type.partialOverlap type.50Overlap hasIntron type.toPlot
#> 1       lincRNA,  CPC  lincRNA,  CPC       yes     lincRNA
#> 2             de novo        de novo        no     de novo
```

```
# Filtering Intron and Exons
```

Here we show how to obtain protein coding and non-coding from our datasets. The coding transcripts are an expressed section of the genome that is responsible for protein formation. Meanwhile the non-coding transcripts are vital in the formation regulatory elements such promoters, enhancers and silencers.

```
library(BioTIP)
data("intron")
data("ILEF")
data("gencode")

gencode_gr = GRanges(gencode)
ILEF_gr = GRanges(ILEF)
cod_gr = GRanges(cod)
intron_gr = GRanges(intron)

non_coding <- getBiotypes(ILEF_gr, gencode_gr, intron_gr)
#> Warning in .merge_two_Seqinfo_objects(x, y): The 2 combined objects have no sequence levels in common. (Use
#>   suppressWarnings() to suppress this warning.)
dim(non_coding)
#> [1] 300  11
head(non_coding[,1:3])
#>   seqnames    start      end
#> 1    chr21 15608524 15710335
#> 2    chr21 43619799 43717938
#> 3    chr21 28208595 28217692
#> 4    chr21 28279059 28339668
#> 5    chr21 46493768 46646483
#> 6    chr21 45285030 45407475
```

```
coding <- getBiotypes(ILEF_gr, gencode_gr)
dim(coding)
#> [1] 300  11
head(coding[,1:3])
#>   seqnames    start      end
#> 1    chr21 15608524 15710335
#> 2    chr21 43619799 43717938
#> 3    chr21 28208595 28217692
#> 4    chr21 28279059 28339668
#> 5    chr21 46493768 46646483
#> 6    chr21 45285030 45407475
```

##### Finding overlapping transcripts

---

```
# Samples with overlapping coding regions.
```

```
library(BioTIP)

data(ILEF)
data(cod)
ILEF_gr = GRanges(ILEF)
cod_gr = GRanges(cod)

rdthrough <- getReadthrough(ILEF_gr, cod_gr)
head(rdthrough)
#>   seqnames    start      end  width strand Row.names readthrough
#> 1    chr21 15608524 15710335 101812      +    ABCC13           0
#> 2    chr21 43619799 43717938  98140      +     ABCG1           1
#> 3    chr21 28208595 28217692   9098      -   ADAMTS1           1
#> 4    chr21 28279059 28339668  60610      -   ADAMTS5           1
#> 5    chr21 46493768 46646483 152716      +    ADARB1           1
#> 6    chr21 45285030 45407475 122446      +    AGPAT3           1
```

Go to Top

**Acknowledgements**

The development of this package would not be possible without continuous help and feedback from individuals and institutions including: The Bioconductor Core Team, Biomedical Informatics Capstone Projects (Dr. Tzintzuni Garcia). We appreciate the support from National Institutes of Health R21LM012619 (XY, ZW) and the University Chicago, Micro-Metcalf Program Project (YS).

Go to Top

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
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] doParallel_1.0.17    iterators_1.0.14     foreach_1.5.2
#>  [4] igraph_2.2.1         psych_2.5.6          stringr_1.5.2
#>  [7] MASS_7.3-65          GenomicRanges_1.62.0 Seqinfo_1.0.0
#> [10] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
#> [13] generics_0.1.4       cluster_2.1.8.1      BioTIP_1.24.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Matrix_1.7-4      jsonlite_2.0.0    compiler_4.5.1    jquerylib_0.1.4
#>  [5] yaml_2.3.10       fastmap_1.2.0     lattice_0.22-7    R6_2.6.1
#>  [9] knitr_1.50        bslib_0.9.0       rlang_1.1.6       cachem_1.1.0
#> [13] stringi_1.8.7     xfun_0.53         sass_0.4.10       cli_3.6.5
#> [17] magrittr_2.0.4    digest_0.6.37     grid_4.5.1        lifecycle_1.0.4
#> [21] nlme_3.1-168      vctrs_0.6.5       mnormt_2.1.1      evaluate_1.0.5
#> [25] glue_1.8.0        codetools_0.2-20  rmarkdown_2.30    tools_4.5.1
#> [29] pkgconfig_2.0.3   htmltools_0.5.8.1
```

Go to Top

**References**

* Chen, H., Albergante, L., Hsu, J.Y. et al. Single-cell trajectories reconstruction, exploration and mapping of omics data with STREAM. Nat Commun 10, 1903 (2019).
* Chen L, Liu R, Liu ZP, Li M, Aihara K. Detecting early-warning signals for sudden deterioration of complex diseases by dynamical network biomarkers. Sci Rep. 2012;2:342. Epub 2012/03/31. doi: 10.1038/srep00342. PubMed PMID: 22461973; PubMed Central PMCID: PMC3314989.
* Lenburg, M. E., A. Sinha, D. V. Faller and G. V. Denis (2007). “Tumor-specific and proliferation-specific gene expression typifies murine transgenic B cell lymphomagenesis.” J Biol Chem 282(7): 4803-4811.PMC2819333
* Mojtahedi M, Skupin A, Zhou J, Castano IG, Leong-Quong RY, Chang H, et al. Cell Fate Decision as High-Dimensional Critical State Transition. PLoS Biol. 2016;14(12):e2000640. doi: 10.1371/journal.pbio.2000640. PubMed PMID: 28027308; PubMed Central PMCID: PMCPMC5189937.
* Moris, N., C. Pina and A. M. Arias (2016). “Transition states and cell fate decisions in epigenetic landscapes.” Nat Rev Genet 17(11): 693-703. PMID: 27616569.
* Sarkar, S., S. K. Sinha, H. Levine, M. K. Jolly and P. S. Dutta (2019). “Anticipating critical transitions in epithelial-hybrid-mesenchymal cell-fate determination.” Proc Natl Acad Sci U S A.
* Schafer, J. and Strimmer, K. (2005) A shrinkage approach to large-scale covariance matrix estimation and implications for functional genomics. Stat Appl Genet Mol Biol, 4, Article32.
* Scheffer M, Carpenter SR, Lenton TM, Bascompte J, Brock W, Dakos V, et al. Anticipating critical transitions. Science. 2012;338(6105):344-8. doi: 10.1126/science.1225244. PubMed PMID: 23087241.
* Wang, Z. Z., J. M. Cunningham and X. H. Yang (2018). “CisPi: a transcriptomic score for disclosing cis-acting disease-associated lincRNAs.” Bioinformatics34(17): 664-670"

Go to Top