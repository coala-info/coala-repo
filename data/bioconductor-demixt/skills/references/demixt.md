# A Vignette for DeMixT

#### Last updated: 2025-10-29

# 1. Introduction

Transcriptomic deconvolution in cancer and other heterogeneous tissues remains challenging. Available methods lack the ability to estimate both component-specific proportions and expression profiles for individual samples. We develop a three-component deconvolution model, DeMixT, for expression data from a mixture of cancerous tissues, infiltrating immune cells and tumor microenvironment. DeMixT is a software package that performs deconvolution on transcriptome data from a mixture of two or three components.

DeMixT is a frequentist-based method and fast in yielding accurate estimates of cell proportions and compart-ment-specific expression profiles for two-component three-component deconvolution problem. Our method promises to provide deeper insight into cancer biomarkers and assist in the development of novel prognostic markers and therapeutic strategies.

The function DeMixT is designed to finish the whole pipeline of deconvolution for two or three components. The newly added DeMixT\_GS function is designed to estimates the proportions of mixed samples for each mixing component based on a new approach to select genes more effectively that utilizes profile likelihood. DeMixT\_DE function is designed to estimate the proportions of all mixed samples for each mixing component based on the gene differential expressions to select genes. DeMixT\_S2 function is designed to estimate the component-specific deconvolved expressions of individual mixed samples for a given set of genes.

# 2 Feature Description

The DeMixT R-package builds the transcriptomic deconvolution with a couple of novel features into R-based standard analysis pipeline through Bioconductor. DeMixT showed high accuracy and efficiency from our designed experiment. Hence, DeMixT can be considered as an important step towards linking tumor transcriptomic data with clinical outcomes.

Different from most previous computational deconvolution methods, DeMixT has integrated new features for the deconvolution with more than 2 components.

**Joint estimation**: jointly estimate component proportions and expression profiles for individual samples by requiring reference samples instead of reference genes; For the three-component deconvolution considering immune infiltration, it provides a comprehensive view of tumor-stroma-immune transcriptional dynamics, as compared to methods that address only immune subtypes within the immune component, in each tumor sample.

**Efficient estimation**: DeMixT adopts an approach of iterated conditional modes (ICM) to guarantee a rapid convergence to a local maximum. We also design a novel gene-set-based component merging approach to reduce the bias of proportion estimation for three-component deconvolutionthe.

**Parallel computing**: OpenMP enable parallel computing on single computer by taking advantage of the multiple cores shipped on modern CPUs. The ICM framework further enables parallel computing, which helps compensate for the expensive computing time used in the repeated numerical double integrations.

# 3. Installation

The DeMixT package is compatible with Windows, Linux and MacOS. The user can install it from `Bioconductor`:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DeMixT")
```

For Linux and MacOS, the user can also install the latest DeMixT from GitHub:

```
if (!require("devtools", quietly = TRUE))
    install.packages('devtools')

devtools::install_github("wwylab/DeMixT")
```

Check if DeMixT is installed successfully:

```
# load package
library(DeMixT)
```

**Note**: DeMixT relies on OpenMP for parallel computing. Starting from R 4.00, R no longer supports OpenMP on MacOS, meaning the user can only run DeMixT with one core on MacOS. We therefore recommend the users to mainly use Linux system for running DeMixT to take advantage of the multi-core parallel computation.

# 4. Functions

The following table shows the functions included in DeMixT.

| Table Header | Second Header |
| --- | --- |
| DeMixT | Deconvolution of tumor samples with two or three components. |
| DeMixT\_GS | Estimates the proportions of mixed samples for each mixing component based on a new approach to select genes that utilizes profile likelihood. |
| DeMixT\_DE | Estimates the proportions of mixed samples for each mixing component. |
| DeMixT\_S2 | Deconvolves expressions of each sample for unknown component. |
| Optimum\_KernelC | Call the C function used for parameter estimation in DeMixT. |
| DeMixT\_Preprocessing | Preprocessing functions before running DeMixT. |

# 5. Methods

## 5.1 Model

Let \(Y\_{ig}\) be the observed expression levels of the raw measured data from clinically derived malignant tumor samples for gene \(g, g = 1, \cdots, G\) and sample \(i, i = 1, \cdots, My\). \(G\) denotes the total number of probes/genes and \(My\) denotes the number of samples. The observed expression levels for solid tumors can be modeled as a linear combination of raw expression levels from three components: \[ {Y\_{ig}} = \pi \_{1,i}N\_{1,ig} + \pi \_{2,i}N\_{2,ig} +
(1 - \pi\_{1,i} - \pi \_{2,i}){T\_{ig}} \label{eq:1} \]

Here \(N\_{1,ig}\), \(N\_{2,ig}\) and \({T\_{ig}}\) are the unobserved raw expression levels from each of the three components. We call the two components for which we require reference samples the \(N\_1\)-component and the \(N\_2\)-component. We call the unknown component the T-component. We let \(\pi\_{1,i}\) denote the proportion of the \(N\_1\)-component, \(\pi\_{2,i}\) denote the proportion of the \(N\_2\)-component, and \(1 - \pi\_{1,i}-\pi\_{2,i}\) denote the proportion of the T-component. We assume that the mixing proportions of one specific sample remain the same across all genes.

Our model allows for one component to be unknown, and therefore does not require reference profiles from all components. A set of samples for \(N\_{1,ig}\) and \(N\_{2,ig}\), respectively, needs to be provided as input data. This three-component deconvolution model is applicable to the linear combination of any three components in any type of material. It can also be simplified to a two-component model, assuming there is just one \(N\)-component. For application in this paper, we consider tumor (\(T\)), stromal (\(N\_1\)) and immune components (\(N\_2\)) in an admixed sample (\(Y\)).

Following the convention that \(\log\_2\)-transformed microarray gene expression data follow a normal distribution, we assume that the raw measures \(N\_{1,ig} \sim LN({\mu \_{{N\_1}g}},\sigma \_{{N\_1}g}^2)\), \(N\_{2,ig} \sim LN({\mu \_{{N\_2}g}},\sigma \_{{N\_2}g}^2)\) and \({T\_{ig}} \sim LN({\mu \_{Tg}}, \sigma \_{Tg}^2)\), where LN denotes a \(\log\_2\)-normal distribution and \(\sigma \_{{N\_1}g}^2\),\(\sigma \_{{N\_2}g}^2\), \(\sigma \_{Tg}^2\) reflect the variations under \(\log\_2\)-transformed data. Consequently, our model can be expressed as the convolution of the density function for three \(\log\_2\)-normal distributions. Because there is no closed form of this convolution, we use numerical integration to evaluate the complete likelihood function (see the full likelihood in the Supplementary Materials in [1]).

## 5.2 The DeMixT algorithm for deconvolution

DeMixT estimates all distribution parameters and cellular proportions and reconstitutes the expression profiles for all three components for each gene and each sample. The estimation procedure (summarized in Figure 1b) has two main steps as follows.

1. Obtain a set of parameters \(\{\pi\_{1,i}, \pi\_{2,i}\}\_{i=1}^{My}\), \(\{\mu\_T, \sigma\_T\}\_{g=1}^G\) to maximize the complete likelihood function, for which \(\{\mu\_{N\_{1,g}}, \sigma\_{N\_{1,g}}, \mu\_{N\_{2,g}}, \sigma\_{N\_{2,g}}\}\_{g=1}^G\) were already estimated from the available unmatched samples of the \(N\_1\) and \(N\_2\) component tissues. (See further details in our paper.)
2. Reconstitute the expression profiles by searching each set of \(\{n\_{1,ig}, n\_{2,ig}\}\) that maximizes the joint density of \(N\_{1,ig}\), \(N\_{2,ig}\) and \(T\_{ig}\). The value of \(t\_{ig}\) is solved as \({y\_{ig}} - {{\hat \pi }\_{1,i}}{n\_{1,ig}} - {{\hat \pi }\_{2,i}}{n\_{2,ig}}\).

These two steps can be separately implemented using the function DeMixT\_DE or DeMixT\_GS for the first step and DeMixT\_S2 for the second, which are combined in the function DeMixT(Note: DeMixT\_GS is the default function for first step).

Since version 1.8.2, DeMixT added simulated normal reference samples, i.e., spike-in, based on the observed normal reference samples. It has been shown to improve accuracy in proportion estimation for the scenario where a dataset consists of samples where true tumor proportions are skewed to the high end.

![](data:image/png;base64...)

# 6. Examples

## 6.1 Simulated two-component data

```
data("test.data.2comp")
# res.GS = DeMixT_GS(data.Y = test.data.2comp$data.Y,
#                     data.N1 = test.data.2comp$data.N1,
#                     niter = 30, nbin = 50, nspikein = 50,
#                     if.filter = TRUE, ngene.Profile.selected = 150,
#                     mean.diff.in.CM = 0.25, ngene.selected.for.pi = 150,
#                     tol = 10^(-5))
load('Res_2comp/res.GS.RData')
```

```
head(t(res.GS$pi))
```

```
##               PiN1       PiT
## Sample 1 0.5955120 0.4044880
## Sample 2 0.2759014 0.7240986
## Sample 3 0.5401655 0.4598345
## Sample 4 0.4497041 0.5502959
## Sample 5 0.6516980 0.3483020
## Sample 6 0.4365191 0.5634809
```

```
head(res.GS$gene.name)
```

```
## [1] "Gene 418" "Gene 452" "Gene 421" "Gene 112" "Gene 154" "Gene 143"
```

```
data("test.data.2comp")
# res.S2 <- DeMixT_S2(data.Y = test.data.2comp$data.Y,
#                     data.N1 = test.data.2comp$data.N1,
#                     data.N2 = NULL,
#                     givenpi = c(t(res.S1$pi[-nrow(res.GS$pi),])), nbin = 50)
load('Res_2comp/res.S2.RData')
```

```
head(res.S2$decovExprT[,1:5],3)
```

```
##         Sample 1   Sample 2   Sample 3  Sample 4   Sample 5
## Gene 1 18.857446  60.727041 159.878946 92.031635  40.873852
## Gene 2  2.322481   3.390938   2.406093  2.558962   2.438189
## Gene 3 48.843631 208.166410  66.986239 38.107580 460.556751
```

```
head(res.S2$decovExprN1[,1:5],3)
```

```
##         Sample 1  Sample 2 Sample 3  Sample 4  Sample 5
## Gene 1  59.37087  71.80492  74.1755  73.55878  72.96267
## Gene 2 107.66874 131.20005 113.6376 120.35924 125.28224
## Gene 3 513.43184 669.79145 613.3042 491.09308 741.76507
```

```
head(res.S2$decovMu,3)
```

```
##            MuN1      MuT
## Gene 1 6.166484 5.924321
## Gene 2 6.677594 2.974551
## Gene 3 9.329628 7.396647
```

```
head(res.S2$decovSigma,3)
```

```
##           SigmaN   SigmaT
## Gene 1 0.2222914 1.127726
## Gene 2 0.2319681 1.614169
## Gene 3 0.1881647 1.320477
```

## 6.2 Simulated two-component data

In the simulation,

```
## Simulate MuN and MuT for each gene
  MuN <- rnorm(G, 7, 1.5)
  MuT <- rnorm(G, 7, 1.5)
  Mu <- cbind(MuN, MuT)
## Simulate SigmaN and SigmaT for each gene
  SigmaN <- runif(n = G, min = 0.1, max = 0.8)
  SigmaT <- runif(n = G, min = 0.1, max = 0.8)
## Simulate Tumor Proportion
  PiT = truncdist::rtrunc(n = My,
                          spec = 'norm',
                          mean = 0.55,
                          sd = 0.2,
                          a = 0.25,
                          b = 0.95)

## Simulate Data
  for(k in 1:G){

    data.N1[k,] <- 2^rnorm(M1, MuN[k], SigmaN[k]); # normal reference

    True.data.T[k,] <- 2^rnorm(My, MuT[k], SigmaT[k]);  # True Tumor

    True.data.N1[k,] <- 2^rnorm(My, MuN[k], SigmaN[k]);  # True Normal

    data.Y[k,] <- pi[1,]*True.data.N1[k,] + pi[2,]*True.data.T[k,] # Mixture Tumor

  }
```

where \(\pi\_i \in (0.25, 0.95)\) is from truncated normal distribution. In general, the true distribution of tumor proportion does not follow a uniform distribution between \([0,1]\), but instead skewed to the upper part of the interval.

```
# ## DeMixT_DE without Spike-in Normal
# res.S1 = DeMixT_DE(data.Y = test.data.2comp$data.Y,
#                    data.N1 = test.data.2comp$data.N1,
#                    niter = 30, nbin = 50, nspikein = 0,
#                    if.filter = TRUE,
#                    mean.diff.in.CM = 0.25, ngene.selected.for.pi = 150,
#                    tol = 10^(-5))
# ## DeMixT_DE with Spike-in Normal
# res.S1.SP = DeMixT_DE(data.Y = test.data.2comp$data.Y,
#                      data.N1 = test.data.2comp$data.N1,
#                      niter = 30, nbin = 50, nspikein = 50,
#                      if.filter = TRUE,
#                      mean.diff.in.CM = 0.25, ngene.selected.for.pi = 150,
#                      tol = 10^(-5))
# ## DeMixT_GS with Spike-in Normal
# res.GS.SP = DeMixT_GS(data.Y = test.data.2comp$data.Y,
#                      data.N1 = test.data.2comp$data.N1,
#                      niter = 30, nbin = 50, nspikein = 50,
#                      if.filter = TRUE, ngene.Profile.selected = 150,
#                      mean.diff.in.CM = 0.25, ngene.selected.for.pi = 150,
#                      tol = 10^(-5))
load('Res_2comp/res.S1.RData'); load('Res_2comp/res.S1.SP.RData');
load('Res_2comp/res.GS.RData'); load('Res_2comp/res.GS.SP.RData');
```

This simulation was designed to compare previous DeMixT resutls with DeMixT spike-in results under both gene selection method.

```
res.2comp = as.data.frame(cbind(round(rep(t(test.data.2comp$pi[2,]),3),2),
                                round(c(t(res.S1$pi[2,]),t(res.S1.SP$pi[2,]), t(res.GS.SP$pi[2,])),2),
                                rep(c('DE','DE-SP','GS-SP'), each = 100)), num = 1:2)
res.2comp$V1 <- as.numeric(as.character(res.2comp$V1))
res.2comp$V2 <- as.numeric(as.character(res.2comp$V2))
res.2comp$V3 = as.factor(res.2comp$V3)
names(res.2comp) = c('True.Proportion', 'Estimated.Proportion', 'Method')
## Plot
ggplot(res.2comp, aes(x=True.Proportion, y=Estimated.Proportion, group = Method, color=Method, shape=Method)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "black", lwd = 0.5) +
  xlim(0,1) + ylim(0,1)  +
  scale_shape_manual(values=c(seq(1:3))) +
  labs(x = 'True Proportion', y = 'Estimated Proportion')
```

![](data:image/png;base64...)

## 6.3 Simulated three-component data

In this simulation,

```
G <- G1 + G2
## Simulate MuN1, MuN2 and MuT for each gene
  MuN1 <- rnorm(G, 7, 1.5)
  MuN2_1st <- MuN1[1:G1] + truncdist::rtrunc(n = 1,
                                             spec = 'norm',
                                             mean = 0,
                                             sd = 1.5,
                                             a = -0.1,
                                             b = 0.1)
  MuN2_2nd <- c()
  for(l in (G1+1):G){
    tmp <- MuN1[l] + truncdist::rtrunc(n = 1,
                                       spec = 'norm',
                                       mean = 0,
                                       sd = 1.5,
                                       a = 0.1,
                                       b = 3)^rbinom(1, size=1, prob=0.5)
    while(tmp <= 0) tmp <- MuN1[l] + truncdist::rtrunc(n = 1,
                                                       spec = 'norm',
                                                       mean = 0,
                                                       sd = 1.5,
                                                       a = 0.1,
                                                       b = 3)^rbinom(1, size=1, prob=0.5)
    MuN2_2nd <- c(MuN2_2nd, tmp)
  }
## Simulate SigmaN1, SigmaN2 and SigmaT for each gene
  SigmaN1 <- runif(n = G, min = 0.1, max = 0.8)
  SigmaN2 <- runif(n = G, min = 0.1, max = 0.8)
  SigmaT <- runif(n = G, min = 0.1, max = 0.8)
## Simulate Tumor Proportion
  pi <- matrix(0, 3, My)
  pi[1,] <- runif(n = My, min = 0.01, max = 0.97)
  for(j in 1:My){
    pi[2, j] <- runif(n = 1, min = 0.01, max = 0.98 - pi[1,j])
    pi[3, j] <- 1 - sum(pi[,j])
  }
## Simulate Data
  for(k in 1:G){

    data.N1[k,] <- 2^rnorm(M1, MuN1[k], SigmaN1[k]); # normal reference 1

    data.N2[k,] <- 2^rnorm(M2, MuN2[k], SigmaN2[k]); # normal reference 1

    True.data.T[k,] <- 2^rnorm(My, MuT[k], SigmaT[k]);  # True Tumor

    True.data.N1[k,] <- 2^rnorm(My, MuN1[k], SigmaN1[k]);  # True Normal 1

    True.data.N2[k,] <- 2^rnorm(My, MuN2[k], SigmaN2[k]);  # True Normal 1

    data.Y[k,] <- pi[1,]*True.data.N1[k,] + pi[2,]*True.data.N2[k,] +
      pi[3,]*True.data.T[k,] # Mixture Tumor

  }
```

where \(G1\) is the number of genes that \(\mu\_{N1}\) is close to \(\mu\_{N2}\).

```
data("test.data.3comp")
# res.S1 <- DeMixT_DE(data.Y = test.data.3comp$data.Y, data.N1 = test.data.3comp$data.N1,
#                    data.N2 = test.data.3comp$data.N2, if.filter = TRUE)
load('Res_3comp/res.S1.RData');
```

```
res.3comp= as.data.frame(cbind(round(t(matrix(t(test.data.3comp$pi), nrow = 1)),2),
                                round(t(matrix(t(res.S1$pi), nrow = 1)),2),
                                rep(c('N1','N2','T'), each = 20)))
res.3comp$V1 <- as.numeric(as.character(res.3comp$V1))
res.3comp$V2 <- as.numeric(as.character(res.3comp$V2))
res.3comp$V3 = as.factor(res.3comp$V3)
names(res.3comp) = c('True.Proportion', 'Estimated.Proportion', 'Component')
## Plot
ggplot(res.3comp, aes(x=True.Proportion, y=Estimated.Proportion, group = Component, color=Component, shape=Component)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "black", lwd = 0.5) +
  xlim(0,1) + ylim(0,1)  +
  scale_shape_manual(values=c(seq(1:3))) +
  labs(x = 'True Proportion', y = 'Estimated Proportion')
```

![](data:image/png;base64...)

## 6.4 Real data: PRAD in TCGA dataset

Here, we use a subset of the bulk RNAseq data of prostate adenocarcinoma (PRAD) from TCGA (<https://portal.gdc.cancer.gov/>) as an example. The analysis pipeline consists of the following steps:

* Obtaining raw read counts for the tumor and normal RNAseq data
* Loading libraries and data
* Data preprocessing
* Deconvolution using DeMixT

### 6.4.1 Obtain raw read counts for the tumor and normal RNAseq data

The raw read counts for the tumor and normal samples from TCGA PRAD are downloaded from [TCGA data portal](https://portal.gdc.cancer.gov/). One can also generate the raw read counts from fastq or bam files by following the [GDC mRNA Analysis Pipeline](https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/).

### 6.4.2 Obtain raw read counts for the tumor and normal RNAseq data

Load input data (available at [PRAD.RData](https://wwylab.github.io/DeMixT/etc/PRAD.RData))

```
load(url("https://wwylab.github.io/DeMixT/etc/PRAD.RData"))
```

Three data are included in the `PRAD.RData` file.

* `PRAD`: Read counts matrix (gene x sample) with genes as row names and sample ids as column names.
* `Normal.id`: TCGA ids of PRAD normal samples.
* `Tumor.id` TCGA ids of PRAD tumor samples.

A glimpse of `PRAD`:

```
head(PRAD[,1:5])
```

```
##          TCGA-CH-5761-11A TCGA-CH-5767-11B TCGA-EJ-7115-11A TCGA-EJ-7123-11A
## TSPAN6               3876             7095             5542             2747
## TNMD                   14               51               13               24
## DPM1                 1162             2665             1544             1974
## SCYL3                 777             1517             1096             1231
## C1orf112              136              343              214              280
## FGR                   230              511              263              755
##          TCGA-EJ-7125-11A
## TSPAN6               8465
## TNMD                   63
## DPM1                 2984
## SCYL3                1514
## C1orf112              339
## FGR                   262
```

```
cat('Number of genes: ', dim(PRAD)[1], '\n')
```

```
## Number of genes:  59427
```

```
cat('Number of normal sample: ', length(Normal.id), '\n')
```

```
## Number of normal sample:  20
```

```
cat('Number of tumor sample: ', length(Tumor.id), '\n')
```

```
## Number of tumor sample:  30
```

### 6.4.3 Data preprocessing

Conduct data cleaning and normalization before running DeMixT.

```
PRAD = PRAD[, c(Normal.id, Tumor.id)]
selected.genes = 9000
cutoff_normal_range = c(0.1, 1.0)
cutoff_tumor_range = c(0, 2.5)
cutoff_step = 0.1

preprocessed_data = DeMixT_preprocessing(PRAD,
                                         Normal.id,
                                         Tumor.id,
                                         selected.genes,
                                         cutoff_normal_range,
                                         cutoff_tumor_range,
                                         cutoff_step)
PRAD_filter = preprocessed_data$count.matrix
sd_cutoff_normal = preprocessed_data$sd_cutoff_normal
sd_cutoff_tumor = preprocessed_data$sd_cutoff_tumor

cat("Normal sd cutoff:", preprocessed_data$sd_cutoff_normal, "\n")
cat("Tumor sd cutoff:", preprocessed_data$sd_cutoff_tumor, "\n")
cat('Number of genes after filtering: ', dim(PRAD_filter)[1], '\n')
```

The function `DeMixT_preprocessing` identifies two intervals based on the standard deviation of the log-transformed gene expression for normal and tumor samples, respectively, within the pre-defined ranges (`cutoff_normal_range` and `cutoff_tumor_range`). In this example, we choose to select about 9000 genes before running DeMixT with the GS (Gene Selection) method to ensure that our model-based gene selection maintains good statistical properties.

`DeMixT_preprocessing` outputs a list object called `preprocessed_data` which contains:

* `preprocessed_data$count.matrix`: Preprocesssed count matrix
* `preprocessed_data$sd_cutoff_normal`: Actual cut-off value when desired number of genes are selected for normal samples
* `preprocessed_data$sd_cutoff_tumor`: Actual cut-off value when desired number of genes are selected for tumor samples

### 6.4.4 Deconvolution using DeMixT

To optimize the parameters in `DeMixT` for input data, we recommend testing an array of combinations of number of spike-ins and number of selected genes.

The number of CPU cores used by the `DeMixT` function for parallel computing is specified by the parameter `nthread`. By default, `nthread = total_number_of_cores_on_the_machine - 1`. Users can adjust `nthread` to any number between 0 and the total number of cores available on the machine. For reference, `DeMixT` takes approximately 3-4 minutes to process the PRAD data in this tutorial for each parameter combination when `nthread` is set to 55.

```
# Due to the random initial values and the spike-in samples used in the DeMixT function,
# we recommand that users set seeds to ensure reproducibility.
# This seed setting will be incorporated internally in DeMixT in the next update.

set.seed(1234)

data.Y = SummarizedExperiment(assays = list(counts = PRAD_filter[, Tumor.id]))
data.N1 <- SummarizedExperiment(assays = list(counts = PRAD_filter[, Normal.id]))

# In practice, we set the maximum number of spike-in as min(n/3, 200),
# where n is the number of samples.
nspikesin_list = c(0, 5, 10)
# One may set a wider range than provided below for studies other than TCGA.
ngene.selected_list = c(500, 1000, 1500, 2500)

for(nspikesin in nspikesin_list){
    for(ngene.selected in ngene.selected_list){
        name = paste("PRAD_demixt_GS_res_nspikesin", nspikesin, "ngene.selected",
                      ngene.selected,  sep = "_");
        name = paste(name, ".RData", sep = "");
        res = DeMixT(data.Y = data.Y,
                     data.N1 = data.N1,
                     ngene.selected.for.pi = ngene.selected,
                     ngene.Profile.selected = ngene.selected,
                     filter.sd = 0.7, # We recommand to use upper bound of gene expression standard deviation
                     # for normal reference. i.e., preprocessed_data$sd_cutoff_normal[2]
                     gene.selection.method = "GS",
                     nspikein = nspikesin)
        save(res, file = name)
    }
}
```

**Note:** We use a profiling likelihood-based method to select genes, during which we calculate confidence intervals for the model parameters using the inverse of the Hessian matrix. When the input data (e.g., gene expression levels from spatial transcriptomic data) is sparse, the Hessian matrix will contain infinite values, hence those confidence intervals can’t be calculated. In this case, gene selection will be performed through differential expression analysis (identical to `DeMix_DE`). This alternative is automatically performed inside `DeMix_GS` when the above situation happens.

```
PiT_GS_PRAD <- c()
row_names <- c()

for(nspikesin in nspikesin_list){
    for(ngene.selected in ngene.selected_list){
        name_simplify <- paste(nspikesin, ngene.selected,  sep = "_")
        row_names <- c(row_names, name_simplify)

        name = paste("PRAD_demixt_GS_res_nspikesin", nspikesin,
                      "ngene.selected", ngene.selected,  sep = "_");
        name = paste(name, ".RData", sep = "")
        load(name)
        PiT_GS_PRAD <- cbind(PiT_GS_PRAD, res$pi[2, ])
    }
}
colnames(PiT_GS_PRAD) <- row_names
```

This step saves the deconvolution results (PiT) into a dataframe with columns named after the combination of the number of spike-ins and number of genes selected. Then one can calculate and plot the pairwise correlations of estimated tumor proportions across different parameter combinations as shown below.

```
pairs.panels(PiT_GS_PRAD,
            method = "spearman", # correlation method
            hist.col = "#00AFBB",
            density = TRUE,  # show density plots
            ellipses = TRUE, # show correlation ellipses
            main = 'Correlations of Tumor Proportions with GS between Different Parameter
            Combination',
            xlim = c(0,1),
            ylim = c(0,1))
```

![](data:image/png;base64...)

Print out the average pairwise correlation of tumor proportions across different parameter combinations.

```
PiT_GS_PRAD <- as.data.frame(PiT_GS_PRAD)
Spearman_correlations <- list()

for(entry_1 in colnames(PiT_GS_PRAD)) {
  cor.values <- c()
  for (entry_2 in colnames(PiT_GS_PRAD)) {
    if (entry_1 == entry_2)
      next

    cor.values <- c(cor.values,
                    cor(PiT_GS_PRAD[, entry_1],
                    PiT_GS_PRAD[, entry_2],
                    method = "spearman"))
  }

  Spearman_correlations[[entry_1]] <- mean(cor.values)
}

Spearman_correlations <- unlist(Spearman_correlations)
Spearman_correlations <- data.frame(num.spikein_num.selected.gene=names(Spearman_correlations), mean.correlation=Spearman_correlations)

Spearman_correlations
```

The average correlation coefficient coefficients are listed below.

```
num.spikein_num.selected.gene   mean.correlation
0_500   0.8641319
0_1000  0.9453534
0_1500  0.9401355
0_2500  0.9375468
5_500   0.9207604
5_1000  0.9542926
5_1500  0.9460006
5_2500  0.8992011
10_500  0.9237941
10_1000 0.9357266
10_1500 0.9249267
10_2500 0.9002124
```

We suggest selecting the optimal parameter combination that produces the highest average correlation of estimated tumor proportions. Additionally, users are encouraged to evaluate the skewness of the PiT estimation distribution compared to a normal distribution centered around 0.5, as significant skewness may indicate biased estimation.

Based on these criteria, `spike-ins = 5` and `number of selected genes = 1000` are identified as the optimal parameter combination. Using these parameters, we can obtain the corresponding tumor proportions for each sample.

```
data.frame(sample.id=Tumor.id, PiT=PiT_GS_PRAD[['5_1000']])

sample.id               PiT
TCGA-2A-A8VL-01A    0.7596888
TCGA-2A-A8VO-01A    0.8421716
TCGA-2A-A8VT-01A    0.8662378
TCGA-2A-A8VV-01A    0.7616749
TCGA-2A-A8W1-01A    0.8291091
TCGA-2A-A8W3-01A    0.8159406
TCGA-CH-5737-01A    0.7314935
TCGA-CH-5738-01A    0.4614545
TCGA-CH-5739-01A    0.6349423
TCGA-CH-5740-01A    0.7095117
```

List the tumor specific expression

```
## Load the corresponding deconvolved gene expression
load("PRAD_demixt_GS_res_nspikesin_5_ngene.selected_1000.RData")
res$ExprT[1:5, 1:5]

      TCGA-2A-A8VL-01A TCGA-2A-A8VO-01A TCGA-2A-A8VT-01A TCGA-2A-A8VV-01A TCGA-2A-A8W1-01A
DPM1          1710.194         1466.484        1680.4562         1644.944         1812.600
FUCA2         3782.990         4083.382         961.0578         4165.612         1896.901
GCLC          2382.106         1826.957        1527.4895         1409.707         1913.784
LAS1L         3329.766         2758.414        3520.9410         2834.415         2530.621
ENPP4         2099.591         3123.365        3173.3516         2856.371         7413.330
```

Instead of selecting using the parameter combination with the highest correlation, one can also select the parameter combination that produces estimated tumor proportions that are most biologically meaningful.

The estimated tumor-specific proportions (PiT) can be used to calculate TmS. See our [TmS tutorial](https://wwylab.github.io/TmS/articles/TmS.html).

## 6.5 Deconvolution using normal reference samples from GTEx

We conducted experiments across cancer types to evaluate the impact of technical artifacts such as batch effects to the proportion estimation when using a different cohort. We applied GTEx expression data from normal prostate samples as the normal reference to deconvolute the TCGA prostate cancer samples, where normal tissues were selected without significant pathology. The estimated proportions showed a reasonable correlation (Spearman correlation coefficient = 0.65) with those generated using TCGA normal prostate samples as the normal reference.

```
## Deconvolute TCGA prostate cancer samples from GTEx normal samples
res.GS.GTEx = DeMixT_GS(data.Y = TCGA_PRAD_Tumor,
                        data.N1 = GTEx_PRAD_Normal,
                        niter = 50, nbin = 50, nspikein = 49, filter.sd = 0.6,
                        if.filter = TRUE, ngene.Profile.selected = 1500,
                        mean.diff.in.CM = 0.25, ngene.selected.for.pi = 1500,
                        tol = 10^(-5))
## Deconvolute TCGA prostate cancer samples from TCGA normal samples
res.GS.TCGA = DeMixT_GS(data.Y = TCGA_PRAD_Tumor,
                        data.N1 = TCGA_PRAD_Normal,
                        niter = 50, nbin = 50, nspikein = 49, filter.sd = 0.6,
                        if.filter = TRUE, ngene.Profile.selected = 1500,
                        mean.diff.in.CM = 0.25, ngene.selected.for.pi = 1500,
                        tol = 10^(-5))
```

![](data:image/png;base64...)

# 7. Reference

[1]. Wang, Z. et al. Transcriptome Deconvolution of Heterogeneous Tumor Samples with Immune Infiltration. iScience 9, 451–460 (2018).

# 8. Session Info

```
sessionInfo(package = "DeMixT")
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
## character(0)
##
## other attached packages:
## [1] DeMixT_1.26.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   mnormt_2.1.1
##   [3] bitops_1.0-9                gridExtra_2.3
##   [5] bsseq_1.46.0                permute_0.9-8
##   [7] rlang_1.1.6                 magrittr_2.0.4
##   [9] matrixStats_1.5.0           compiler_4.5.1
##  [11] RSQLite_2.4.3               mgcv_1.9-3
##  [13] DelayedMatrixStats_1.32.0   png_0.1-8
##  [15] vctrs_0.6.5                 sva_3.58.0
##  [17] pkgconfig_2.0.3             crayon_1.5.3
##  [19] fastmap_1.2.0               XVector_0.50.0
##  [21] labeling_0.4.3              Rsamtools_2.26.0
##  [23] rmarkdown_2.30              grDevices_4.5.1
##  [25] bit_4.6.0                   xfun_0.53
##  [27] cachem_1.1.0                beachmat_2.26.0
##  [29] cigarillo_1.0.0             graphics_4.5.1
##  [31] jsonlite_2.0.0              blob_1.2.4
##  [33] rhdf5filters_1.22.0         DelayedArray_0.36.0
##  [35] Rhdf5lib_1.32.0             BiocParallel_1.44.0
##  [37] psych_2.5.6                 parallel_4.5.1
##  [39] R6_2.6.1                    bslib_0.9.0
##  [41] RColorBrewer_1.1-3          limma_3.66.0
##  [43] rtracklayer_1.70.0          genefilter_1.92.0
##  [45] GenomicRanges_1.62.0        jquerylib_0.1.4
##  [47] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [49] SummarizedExperiment_1.40.0 knitr_1.50
##  [51] base64enc_0.1-3             R.utils_2.13.0
##  [53] IRanges_2.44.0              Matrix_1.7-4
##  [55] splines_4.5.1               tidyselect_1.2.1
##  [57] dichromat_2.0-0.1           abind_1.4-8
##  [59] yaml_2.3.10                 viridis_0.6.5
##  [61] codetools_0.2-20            curl_7.0.0
##  [63] lattice_0.22-7              tibble_3.3.0
##  [65] KEGGREST_1.50.0             Biobase_2.70.0
##  [67] withr_3.0.2                 S7_0.2.0
##  [69] evaluate_1.0.5              base_4.5.1
##  [71] survival_3.8-3              Biostrings_2.78.0
##  [73] pillar_1.11.1               MatrixGenerics_1.22.0
##  [75] DSS_2.58.0                  KernSmooth_2.23-26
##  [77] stats4_4.5.1                generics_0.1.4
##  [79] RCurl_1.98-1.17             S4Vectors_0.48.0
##  [81] ggplot2_4.0.0               sparseMatrixStats_1.22.0
##  [83] scales_1.4.0                stats_4.5.1
##  [85] gtools_3.9.5                xtable_1.8-4
##  [87] glue_1.8.0                  tools_4.5.1
##  [89] dendextend_1.19.1           datasets_4.5.1
##  [91] BiocIO_1.20.0               data.table_1.17.8
##  [93] BSgenome_1.78.0             annotate_1.88.0
##  [95] locfit_1.5-9.12             GenomicAlignments_1.46.0
##  [97] XML_3.99-0.19               rhdf5_2.54.0
##  [99] grid_4.5.1                  utils_4.5.1
## [101] matrixcalc_1.0-6            methods_4.5.1
## [103] edgeR_4.8.0                 AnnotationDbi_1.72.0
## [105] nlme_3.1-168                HDF5Array_1.38.0
## [107] restfulr_0.0.16             cli_3.6.5
## [109] S4Arrays_1.10.0             viridisLite_0.4.2
## [111] dplyr_1.1.4                 gtable_0.3.6
## [113] R.methodsS3_1.8.2           sass_0.4.10
## [115] digest_0.6.37               BiocGenerics_0.56.0
## [117] SparseArray_1.10.0          rjson_0.2.23
## [119] farver_2.1.2                memoise_2.0.1
## [121] htmltools_0.5.8.1           R.oo_1.27.1
## [123] lifecycle_1.0.4             h5mread_1.2.0
## [125] httr_1.4.7                  statmod_1.5.1
## [127] bit64_4.6.0-1
```