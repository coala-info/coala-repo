# Vignette 2: A workflow for analysing differential localisation

Oliver M. Crook1 and Lisa M. Breckels2

1Department of Statistics, University of Oxford, UK
2Cambridge Centre for Proteomics, University of Cambridge, UK

#### 29 October 2025

#### Abstract

This vignette describes how to analyse mass-spectrometry based differential localisation experiments using the BANDLE method (Crook et al. [2022](#ref-bandle)). Data should be stored as lists of `MSnSet`s. There is also features for quality control and visualisation of results. Please see other vignettes for convergence and other methodology.

#### Package

bandle 1.14.0

# 1 Introduction

In this vignette we use a real-life biological use-case to demonstrate how to
analyse mass-spectrometry based proteomics data using the Bayesian ANalysis of
Differential Localisation Experiments (BANDLE) method.

# 2 The data

As mentioned in “Vignette 1: Getting Started with BANDLE” data from mass
spectrometry based proteomics methods most commonly yield a matrix of
measurements where we have proteins/peptides/peptide spectrum matches
(PSMs) along the rows, and samples/fractions along the columns. To use `bandle`
the data must be stored as a `MSnSet`, as implemented in the Bioconductor
*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* package. Please see the relevant vignettes in
*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* for constructing these data containers.

The data used in this vignette has been published in Mulvey et al. ([2021](#ref-thplopit)) and is currently
stored as `MSnSet` instances in the the *[pRolocdata](https://bioconductor.org/packages/3.22/pRolocdata)* package. We
will load it in the next section.

## 2.1 Spatialtemporal proteomic profiling of a THP-1 cell line

In this workflow we analyse the data produced by Mulvey et al. ([2021](#ref-thplopit)). In this experiment
triplicate hyperLOPIT experiments (Mulvey et al. [2017](#ref-Mulvey:2017)) were conducted on THP-1 human
leukaemia cells where the samples were analysed and collected (1) when cells
were unstimulated and then (2) following 12 hours stimulation with LPS
(12h-LPS).

In the following code chunk we load 4 of the datasets from the study: 2
replicates of the unstimulated and 2 replicates of the 12h-LPS stimulated
samples. Please note to adhere to Bioconductor vignette build times we only load
2 of the 3 replicates for each condition to demonstrate the BANDLE workflow.

```
library("pRolocdata")
data("thpLOPIT_unstimulated_rep1_mulvey2021")
data("thpLOPIT_unstimulated_rep3_mulvey2021")
data("thpLOPIT_lps_rep1_mulvey2021")
data("thpLOPIT_lps_rep3_mulvey2021")
```

By typing the names of the datasets we get a `MSnSet` data summary. For
example,

```
thpLOPIT_unstimulated_rep1_mulvey2021
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 5107 features, 20 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: unstim_rep1_set1_126_cyto unstim_rep1_set1_127N_F1.4 ...
##     unstim_rep1_set2_131_F24 (20 total)
##   varLabels: Tag Treatment ... Fraction (5 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: A0AVT1 A0FGR8-2 ... Q9Y6Y8 (5107 total)
##   fvarLabels: Checked_unst.r1.s1 Confidence_unst.r1.s1 ... markers (107
##     total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
## Loaded on Tue Jan 12 14:46:48 2021.
## Normalised to sum of intensities.
##  MSnbase version: 2.14.2
```

```
thpLOPIT_lps_rep1_mulvey2021
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 4879 features, 20 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: lps_rep1_set1_126_cyto lps_rep1_set1_127N_F1.4 ...
##     lps_rep1_set2_131_F25 (20 total)
##   varLabels: Tag Treatment ... Fraction (5 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: A0A0B4J2F0 A0AVT1 ... Q9Y6Y8 (4879 total)
##   fvarLabels: Checked_lps.r1.s1 Confidence_lps.r1.s1 ... markers (107
##     total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
## Loaded on Tue Jan 12 14:46:57 2021.
## Normalised to sum of intensities.
##  MSnbase version: 2.14.2
```

We see that the datasets `thpLOPIT_unstimulated_rep1_mulvey2021` and
`thpLOPIT_lps_rep1_mulvey2021` contain 5107 and 4879 proteins respectively,
across 20 TMT channels. The data is accessed through different slots of the
`MSnSet` (see `str(thpLOPIT_unstimulated_rep1_mulvey2021)` for all available
slots). The 3 main slots which are used most frequently are those that contain
the quantitation data, the features i.e. PSM/peptide/protein information and the
sample information, and these can be accessed using the functions `exprs`,
`fData`, and `pData`, respectively.

## 2.2 Preparing the data

First, let us load the `bandle` package along with some other R packages needed
for visualisation and data manipulation,

```
library("bandle")
library("pheatmap")
library("viridis")
library("dplyr")
library("ggplot2")
library("gridExtra")
```

To run `bandle` there are a few minimal requirements that the data must fulfill.

* the same number of channels across conditions and replicates
* the same proteins across conditions and replicates
* data must be a `list` of `MSnSet` instances

If we use the `dim` function we see that the datasets we have loaded have the
same number of channels but a different number of proteins per experiment.

```
dim(thpLOPIT_unstimulated_rep1_mulvey2021)
```

```
## [1] 5107   20
```

```
dim(thpLOPIT_unstimulated_rep3_mulvey2021)
```

```
## [1] 5733   20
```

```
dim(thpLOPIT_lps_rep1_mulvey2021)
```

```
## [1] 4879   20
```

```
dim(thpLOPIT_lps_rep3_mulvey2021)
```

```
## [1] 5848   20
```

We use the function `commonFeatureNames` to extract proteins that are common
across all replicates. This function has a nice side effect which is that it
also wraps the data into a `list`, ready for input into `bandle`.

```
thplopit <- commonFeatureNames(c(thpLOPIT_unstimulated_rep1_mulvey2021,  ## unstimulated rep
                                 thpLOPIT_unstimulated_rep3_mulvey2021,  ## unstimulated rep
                                 thpLOPIT_lps_rep1_mulvey2021,           ## 12h-LPS rep
                                 thpLOPIT_lps_rep3_mulvey2021))          ## 12h-LPS rep
```

```
## 3727 features in common
```

We now have our list of `MSnSet`s ready for `bandle` with 3727 proteins common
across all 4 replicates/conditions.

```
thplopit
```

```
## Instance of class 'MSnSetList' containig 4 objects.
```

We can visualise the data using the `plot2D` function from `pRoloc`

```
## create a character vector of title names for the plots
plot_id <- c("Unstimulated replicate 1", "Unstimulated replicate 2",
             "12h-LPS replicate 1", "12h-LPS replicate 2")

## Let's set the stock colours of the classes to plot to be transparent
setStockcol(NULL)
setStockcol(paste0(getStockcol(), "90"))

## plot the data
par(mfrow = c(2,2))
for (i in seq(thplopit))
    plot2D(thplopit[[i]], main = plot_id[i])
addLegend(thplopit[[4]], where = "topleft", cex = .75)
```

![](data:image/png;base64...)

By default the `plot2D` uses principal components analysis (PCA)
for the data transformation. Other options such as t-SNE, kernal
PCA etc. are also available, see `?plot2D` and the `method` argument.
PCA sometimes will randomly flip the axis, because the eigenvectors
only need to satisfy \(||v|| = 1\), which allows a sign flip. You will
notice this is the case for the 3rd plot. If desired you can flip
the axis/change the sign of the PCs by specifying any of the arguments
`mirrorX`, `mirrorY`, `axsSwitch` to TRUE when you call `plot2D`.

Data summary:

* LOPIT conducted on THP1 leukaemia cells
* 2 conditions: (1) unstimulated, (2) 12 hours stimulation with THP
* 20 TMT fractions yielded from 2 x 10plex TMT in an interleaved experimental design (see Mulvey et al. ([2017](#ref-Mulvey:2017)) for details and the associated app <http://proteome.shinyapps.io/thp-lopit/>)
* 2 replicates selected as a use-case from the original experiment
* 3727 proteins common across the 2 replicates

# 3 Preparing the bandle input parameters

As mentioned in the first vignette, `bandle` uses a complex model to analyse the
data. Markov-Chain Monte-Carlo (MCMC) is used to sample the posterior
distribution of parameters and latent variables from which statistics of
interest can be computed. Again, here we only run a few iterations for brevity
but typically one needs to run thousands of iterations to ensure convergence, as
well as multiple parallel chains.

## 3.1 Fitting Gaussian processes

First, we need to fit non-parametric regression functions to the markers
profiles. We use the function `fitGPmaternPC`. In general the default penalised
complexity priors on the hyperparameters (see `?fitGP`), of `fitGPmaternPC` work
well for correlation profiling data with <10 channels (as tested in Crook et al. ([2022](#ref-bandle))).
From looking at the help documentation (see, `?fitGPmaternPC`) we see the
default priors on the hyperparameters are
`hyppar = matrix(c(10, 60, 250), nrow = 1)`.

Different priors can be constructed and tested. For example, here, we found that
`matrix(c(1, 60, 100)` worked well. In this experiment we have with several
thousand proteins and many more subcellular classes and fractions (channels)
than tested in the Crook et al. ([2022](#ref-bandle)) paper.

In this example, we require a `11*3` matrix as we have 11 subcellular marker
classes and 3 columns to represent the hyperparameters length-scale, amplitude,
variance. Generally, (1) increasing the lengthscale parameter (the first column
of the `hyppar` matrix) increases the spread of the covariance i.e. the
similarity between points, (2) increasing the amplitude parameter (the second
column of the `hyppar` matrix) increases the maximum value of the covariance and
lastly (3) decreasing the variance (third column of the `hyppar` matrix) reduces
the smoothness of the function to allow for local variations. We strongly
recommend users start with the default parameters and change and assess them as
necessary for their dataset by visually evaluating the fit of the GPs using the
`plotGPmatern` function.

To see the subcellular marker classes in our data we use the
`getMarkerClasses` function from `pRoloc`.

```
(mrkCl <- getMarkerClasses(thplopit[[1]], fcol = "markers"))
```

```
##  [1] "40S/60S Ribosome"      "Chromatin"             "Cytosol"
##  [4] "Endoplasmic Reticulum" "Golgi Apparatus"       "Lysosome"
##  [7] "Mitochondria"          "Nucleolus"             "Nucleus"
## [10] "Peroxisome"            "Plasma Membrane"
```

For this use-case we have `K = 11` classes

```
K <- length(mrkCl)
```

We can construct our priors, which as mentioned above will be a `K*3` matrix i.e.
`11x3` matrix.

```
pc_prior <- matrix(NA, ncol = 3, K)
pc_prior[seq.int(1:K), ] <- matrix(rep(c(1, 60, 100),
                                       each = K), ncol = 3)
head(pc_prior)
```

```
##      [,1] [,2] [,3]
## [1,]    1   60  100
## [2,]    1   60  100
## [3,]    1   60  100
## [4,]    1   60  100
## [5,]    1   60  100
## [6,]    1   60  100
```

Now we have generated these complexity priors we can pass them as an
argument to the `fitGPmaternPC` function. For example,

```
gpParams <- lapply(thplopit,
                   function(x) fitGPmaternPC(x, hyppar = pc_prior))
```

By plotting the predictives using the `plotGPmatern` function we see that
the distributions and fit looks sensible for each class so we will proceed with
setting the prior on the weights.

```
par(mfrow = c(4, 3))
plotGPmatern(thplopit[[1]], gpParams[[1]])
```

![](data:image/png;base64...)

For the interest of keeping the vignette size small, in the above chunk we
plot only the first dataset and its respective predictive. To plot the
second dataset we would execute `plotGPmatern(thplopit[[i]], gpParams[[i]])`
where i = 2, and similarly for the third i = 3 and so on.

## 3.2 Setting the prior on the weights

The next step is to set up the matrix Dirichlet prior on the mixing weights.
If `dirPrior = NULL` a default Dirichlet prior is computed see `?bandle`. We
strongly advise you to set your own prior. In “Vignette 1: Getting Started with
BANDLE” we give some suggestions on how to set this and in the below code we try
a few different priors and assess the expectations.

As per Vignette 1, let’s try a `dirPrior` as follows,

```
set.seed(1)
dirPrior = diag(rep(1, K)) + matrix(0.001, nrow = K, ncol = K)
predDirPrior <- prior_pred_dir(object = thplopit[[1]],
                               dirPrior = dirPrior,
                               q = 15)
```

The mean number of relocalisations is

```
predDirPrior$meannotAlloc
```

```
## [1] 0.421633
```

The prior probability that more than `q` differential localisations are
expected is

```
predDirPrior$tailnotAlloc
```

```
## [1] 0.0016
```

```
hist(predDirPrior$priornotAlloc, col = getStockcol()[1])
```

![](data:image/png;base64...)

We see that the prior probability that proteins are allocated to different
components between datasets concentrates around 0. This is what we expect, we
expect subtle changes between conditions for this data. We may perhaps wish to
be a little stricter with the number of differential localisations output by
`bandle` and in this case we could make the off-diagonal elements of the
`dirPrior` smaller. In the below code chunk we test 0.0005 instead of 0.001,
which reduces the number of re-localisations.

```
set.seed(1)
dirPrior = diag(rep(1, K)) + matrix(0.0005, nrow = K, ncol = K)
predDirPrior <- prior_pred_dir(object = thplopit[[1]],
                               dirPrior = dirPrior,
                               q = 15)

predDirPrior$meannotAlloc
```

```
## [1] 0.2308647
```

```
predDirPrior$tailnotAlloc
```

```
## [1] 6e-04
```

```
hist(predDirPrior$priornotAlloc, col = getStockcol()[1])
```

![](data:image/png;base64...)

Again, we see that the prior probability that proteins are allocated to different
components between datasets concentrates around 0.

# 4 Running bandle

Now we have computed our `gpParams` and `pcPriors` we can run the main `bandle`
function.

Here for convenience of building the vignette we only run 2 of the triplicates
for each condition and run the `bandle` function for a small number of
iterations and chains to minimise the vignette build-time. Typically we’d
recommend you run the number of iterations (`numIter`) in the \(1000\)s and to
test a minimum of 4 chains.

We first subset our data into two objects called `control` and `treatment`
which we subsequently pass to `bandle` along with our priors.

```
control <- list(thplopit[[1]], thplopit[[2]])
treatment <- list(thplopit[[3]], thplopit[[4]])

params <- bandle(objectCond1 = control,
                 objectCond2 = treatment,
                 numIter = 10,       # usually 10,000
                 burnin = 5L,        # usually 5,000
                 thin = 1L,          # usually 20
                 gpParams = gpParams,
                 pcPrior = pc_prior,
                 numChains = 4,     # usually >=4
                 dirPrior = dirPrior,
                 seed = 1)
```

* `numIter` is the number of iterations of the MCMC algorithm. Default is 1000.
  Though usually much larger numbers are used we recommend 10000+.
* `burnin` is the number of samples to be discarded from the beginning of the
  chain. Here we use 5 in this example but the default is 100.
* `thin` is the thinning frequency to be applied to the MCMC chain. Default is

* `gpParams` parameters from prior fitting of GPs to each niche to accelerate
  inference
* `pcPrior` matrix with 3 columns indicating the lambda parameters for the
  penalised complexity prior.
* `numChains` defined the number of chains to run. We recommend at least 4.
* `dirPrior` as above a matrix generated by dirPrior function.
* `seed` a random seed for reproducibility

A `bandleParams` object is produced

```
params
```

```
## Object of class "bandleParams"
## Method: bandle
## Number of chains: 4
```

# 5 Processing and analysing the bandle results

## 5.1 Assessing convergence

The `bandle` method uses of Markov Chain Monte Carlo (MCMC) and therefore
before we can extract our classification and differential localisation
results we first need to check the algorithm for convergence of the MCMC chains.

As mentioned in Vignette 1 there are two main functions we can use to help us
assess convergence are: (1) `calculateGelman` which calculates the Gelman
diagnostics for all pairwise chain combinations and (2) `plotOutliers` which
generates trace and density plots for all chains.

Let’s start with the Gelman which allows us to compare the inter and intra chain
variances. If the chains have converged the ratio of these quantities should be
close to one.

```
calculateGelman(params)
```

```
## $Condition1
##            comb_12  comb_13  comb_14  comb_23  comb_24 comb_34
## Point_Est 1.659848 1.077255 1.092496 1.114202 1.743665 1.24289
## Upper_CI  3.906566 1.563386 1.640026 1.457182 6.086847 1.95166
##
## $Condition2
##            comb_12  comb_13  comb_14   comb_23 comb_24  comb_34
## Point_Est 1.200453 1.555385 2.123111 0.9425224 2.45744 2.728465
## Upper_CI  1.982583 3.051088 6.663316 1.0937279 5.95227 6.789906
```

In this example, to demonstrate how to use `bandle` we have only run 10 MCMC
iterations for each of the 4 chains. As
already mentioned in practice we suggest running a minimum of 1000 iterations
and a minimum of 4 chains.

We do not expect the algorithm to have converged with so little iterations and
this is highlighted in the Gelman diagnostics which are > 1. For convergence
we expect Gelman diagnostics < 1.2, as discuss in Crook et al. ([2019](#ref-Crook2019)) and general
Bayesian literature.

If we plot trace and density plots we can also very quickly see that (as
expected) the algorithm has **not** converged over the 20 test runs.

**Example with 5 iterations**

```
plotOutliers(params)
```

![](data:image/png;base64...)

We include a plot below of output from 500 iterations

**Example with 500 iterations**

![](data:image/png;base64...)

In this example where the data has been run for 500 iterations. We get a better
idea of what we expect convergence to look like. We would still recommend
running for 10000+ iterations for adequate sampling. For convergence we expect
trace plots to look like hairy caterpillars and the density plots should be
centered around the same number of outliers. For condition 1 we see the number
of outliers sits around 1620 proteins and in condition 2 it sits around 1440. If
we the number of outliers was wildly different for one of the chains, or if the
trace plot has a long period of burn-in (the beginning of the trace looks very
different from the rest of the plot), or high serial correlation (the chain is
very slow at exploring the sample space) we may wish to discard these chains. We
may need to run more chains.

Taboga ([2021](#ref-Taboga2021)) provides a nice online book explaining some of the main
problems users may encounter with MCMC at, see the chapter [“Markov-Chain-Monte-Carlo-diagnostics”](https://www.statlect.com/fundamentals-of-statistics/Markov-Chain-Monte-Carlo-diagnostics.)

## 5.2 Removing unconverged chains

Although we can clearly see all chains in the example with 5 iterations are bad
here as we have not sampled the space with sufficient number of iterations to
achieve convergence, let’s for sake of demonstration remove chains 1 and 4. In
practice, all of these chains would be discarded as (1) none of the trace and
density plots show convergence and additionally (2) the Gelman shows many chains
have values > 1. Note, when assessing convergence if a chain is bad in one
condition, the same chain must be discarded from the second condition too. They
are considered in pairs.

Let’s remove chains 1 and 4 as an example,

```
params_converged <- params[-c(1, 4)]
```

We have now removed chains 1 and 4 and we are left with 2 chains

```
params_converged
```

```
## Object of class "bandleParams"
## Method: bandle
## Number of chains: 2
```

## 5.3 Running `bandleProcess` and `bandleSummary`

Following Vignette 1 we populate the `bandleres` object by calling the
`bandleProcess` function. This may take a few seconds to process.

```
params_converged <- bandleProcess(params_converged)
```

The `bandleProcess` must be run to process the bandle output and populate the
`bandle` object.

The `summaries` function is a convenience function for accessing the output

```
bandle_out <- summaries(params_converged)
```

The output is a `list` of 2 `bandleSummary` objects.

```
length(bandle_out)
```

```
## [1] 2
```

```
class(bandle_out[[1]])
```

```
## [1] "bandleSummary"
## attr(,"package")
## [1] "bandle"
```

There are 3 slots:

* A `posteriorEstimates` slot containing the posterior quantities of interest for
  different proteins.
* A slot for convergence diagnostics
* The joint posterior distribution across organelles see `bandle.joint`

For the control we would access these as follows,

```
bandle_out[[1]]@posteriorEstimates
bandle_out[[1]]@diagnostics
bandle_out[[1]]@bandle.joint
```

Instead of examining these directly we are going to proceed with protein
localisation prediction and add these results to the datasets in the `fData`
slot of the `MSnSet`.

# 6 Predicting subcellular location

The `bandle` method performs both (1) protein subcellular localisation
prediction and (2) predicts the differential localisation of proteins. In this
section we will use the `bandlePredict` function to perform protein subcellular
localisation prediction and also append all the `bandle` results to the `MSnSet`
dataset.

We begin by using the `bandlePredict` function to append our results to the
original `MSnSet` datasets.

```
## Add the bandle results to a MSnSet
xx <- bandlePredict(control,
                    treatment,
                    params = params_converged,
                    fcol = "markers")
res_0h <- xx[[1]]
res_12h <- xx[[2]]
```

The BANDLE model combines replicate information within each condition to obtain
the localisation of proteins for each single experimental condition.

The results for each condition are appended to the *first* dataset in the list
of `MSnSets` (for each condition). It is important to familiarise yourself with
the `MSnSet` data structure. To further highlight this in the below code chunk
we look at the `fvarLabels` of each datasets, this shows the column header names
of the `fData` feature data. We see that the first replicate at 0h e.g.
`res_0h[[1]]` has 7 columns updated with the output of `bandle` e.g.
`bandle.probability`, `bandle.allocation`, `bandle.outlier` etc. appended to the
feature data (`fData(res_0h[[1]])`).

The second dataset at 0h i.e. `res_0h[[2]]` does not have this information
appended to the feature data as it is already in the first dataset. This is the
same for the second condition at 12h post LPS stimulation.

```
fvarLabels(res_0h[[1]])
fvarLabels(res_0h[[2]])

fvarLabels(res_12h[[1]])
fvarLabels(res_12h[[2]])
```

The `bandle` results are shown in the columns:

* `bandle.joint` which is the full joint probability distribution across all
  subcellular classes
* `bandle.allocation` which contains the the localisation predictions to one of the
  subcellular classes that appear in the training data.
* `bandle.probability` is the allocation probability, corresponding to the mean
  of the distribution probability.
* `bandle.outlier` is the probability of being an outlier. A high value
  indicates that the protein is unlikely to belong to any annotated class (and is
  hence considered an outlier).
* `bandle.probability.lowerquantile` and `bandle.probability.upperquantile` are
  the upper and lower quantiles of the allocation probability distribution.
* `bandle.mean.shannon` is the Shannon entropy, measuring the uncertainty in the
  allocations (a high value representing high uncertainty; the highest value is
  the natural logarithm of the number of classes).
* `bandle.differential.localisation` is the differential localisation probability.

## 6.1 Thresholding on the posterior probability

As mentioned in Vignette 1, it is also common to threshold allocation results
based on the posterior probability. Proteins that do not meet the threshold are
not assigned to a subcellular location and left unlabelled (here we use the
terminology “unknown” for consistency with the `pRoloc` package). It is
important not to force proteins to allocate to one of the niches defined here in
the training data, if they have low probability to reside there. We wish to
allow for greater subcellular diversity and to have multiple location, this is
captured essentially in leaving a protein “unlabelled” or “unknown”. We can also
extract the “unknown” proteins with high uncertainty and examine their
distribution over all organelles (see `bandle.joint`).

To obtain classification results we threshold using a 1% FDR based on the
`bandle.probability` and append the results to the data using the
`getPredictions` function from `MSnbase`.

```
## threshold results using 1% FDR
res_0h[[1]] <- getPredictions(res_0h[[1]],
                              fcol = "bandle.allocation",
                              scol = "bandle.probability",
                              mcol = "markers",
                              t = .99)
```

```
## ans
##      40S/60S Ribosome             Chromatin               Cytosol
##                   271                   202                   510
## Endoplasmic Reticulum       Golgi Apparatus              Lysosome
##                   218                   164                   340
##          Mitochondria             Nucleolus               Nucleus
##                   393                   120                   659
##            Peroxisome       Plasma Membrane               unknown
##                   174                   272                   404
```

```
res_12h[[1]] <- getPredictions(res_12h[[1]],
                               fcol = "bandle.allocation",
                               scol = "bandle.probability",
                               mcol = "markers",
                               t = .99)
```

```
## ans
##      40S/60S Ribosome             Chromatin               Cytosol
##                   152                   231                   462
## Endoplasmic Reticulum       Golgi Apparatus              Lysosome
##                   286                   310                   179
##          Mitochondria             Nucleolus               Nucleus
##                   360                   119                   751
##            Peroxisome       Plasma Membrane               unknown
##                   197                   358                   322
```

A table of predictions is printed to the screen as a side effect when running
`getPredictions` function.

In addition to thresholding on the `bandle.probability` we can threshold based
on the `bandle.outlier` i.e. the probability of being an outlier. A high value
indicates that the protein is unlikely to belong to any annotated class (and is
hence considered an outlier). We wish to assign proteins to a subcellular niche
if they have a high `bandle.probability` and also a low `bandle.outlier`
probability. This is a nice way to ensure we keep the most high confidence
localisations.

In the below code chunk we use first create a new column called
`bandle.outlier.t` in the feature data which is `1 - outlier probability`. This
allows us then to use `getPredictions` once again and keep only proteins which
meet both the 0.99 threshold on the `bandle.probability` and the
`bandle.outlier`.

Note, that running `getPredictions` appends the results to a new feature data
column called `fcol.pred`, please see `?getPredictions` for the documentation.
As we have run this function twice, our column of classification results are
found in `bandle.allocation.pred.pred`.

```
## add outlier probability
fData(res_0h[[1]])$bandle.outlier.t <- 1 -  fData(res_0h[[1]])$bandle.outlier
fData(res_12h[[1]])$bandle.outlier.t <- 1 -  fData(res_12h[[1]])$bandle.outlier

## threshold again, now on the outlier probability
res_0h[[1]] <- getPredictions(res_0h[[1]],
                              fcol = "bandle.allocation.pred",
                              scol = "bandle.outlier.t",
                              mcol = "markers",
                              t = .99)
```

```
## ans
##      40S/60S Ribosome             Chromatin               Cytosol
##                    91                   148                   339
## Endoplasmic Reticulum       Golgi Apparatus              Lysosome
##                   213                    90                   254
##          Mitochondria             Nucleolus               Nucleus
##                   355                    71                   108
##            Peroxisome       Plasma Membrane               unknown
##                   150                   243                  1665
```

```
res_12h[[1]] <- getPredictions(res_12h[[1]],
                               fcol = "bandle.allocation.pred",
                               scol = "bandle.outlier.t",
                               mcol = "markers",
                               t = .99)
```

```
## ans
##      40S/60S Ribosome             Chromatin               Cytosol
##                   117                   181                   295
## Endoplasmic Reticulum       Golgi Apparatus              Lysosome
##                   256                   227                   154
##          Mitochondria             Nucleolus               Nucleus
##                   345                    98                   138
##            Peroxisome       Plasma Membrane               unknown
##                   185                   311                  1420
```

**Appending the results to all replicates**

Let’s append the results to the second replicate (by default they are appended
to the first only, as already mentioned above). This allows us to plot each
dataset and the results using `plot2D`.

```
## Add results to second replicate at 0h
res_alloc_0hr <- fData(res_0h[[1]])$bandle.allocation.pred.pred
fData(res_0h[[2]])$bandle.allocation.pred.pred <- res_alloc_0hr

## Add results to second replicate at 12h
res_alloc_12hr <- fData(res_12h[[1]])$bandle.allocation.pred.pred
fData(res_12h[[2]])$bandle.allocation.pred.pred <- res_alloc_12hr
```

We can plot these results on a PCA plot and compare to the original subcellular
markers.

```
par(mfrow = c(5, 2))

plot2D(res_0h[[1]], main = "Unstimulated - replicate 1 \n subcellular markers",
       fcol = "markers")
plot2D(res_0h[[1]], main = "Unstimulated - replicate 1 \nprotein allocations (1% FDR)",
       fcol = "bandle.allocation.pred.pred")

plot2D(res_0h[[2]], main = "Unstimulated - replicate 2 \nsubcellular markers",
       fcol = "markers")
plot2D(res_0h[[2]], main = "Unstimulated - replicate 2 \nprotein allocations (1% FDR)",
       fcol = "bandle.allocation.pred.pred")

plot2D(res_0h[[1]], main = "12h LPS - replicate 1 \nsubcellular markers",
       fcol = "markers")
plot2D(res_0h[[1]], main = "12h LPS - replicate 1 \nprotein allocations (1% FDR)",
       fcol = "bandle.allocation.pred.pred")

plot2D(res_0h[[2]], main = "12h LPS - replicate 2 \nsubcellular markers",
       fcol = "markers")
plot2D(res_0h[[2]], main = "12h LPS - replicate 2 \nprotein allocations (1% FDR)",
       fcol = "bandle.allocation.pred.pred")

plot(NULL, xaxt='n',yaxt='n',bty='n',ylab='',xlab='', xlim=0:1, ylim=0:1)
addLegend(res_0h[[1]], where = "topleft", cex = .8)
```

![](data:image/png;base64...)

## 6.2 Distribution on allocations

We can examine the distribution of allocations that (1) have been assigned to a
single location with high confidence and, (2) those which did not meet the
threshold and thus have high uncertainty i.e. are labelled as “unknown”.

Before we can begin to examine the distribution of allocation we first need
to subset the data and remove the markers. This makes it easier to assess
new prediction.

We can use the function `unknownMSnSet` to subset as we did in Vignette 1,

```
## Remove the markers from the MSnSet
res0hr_unknowns <- unknownMSnSet(res_0h[[1]], fcol = "markers")
res12h_unknowns <- unknownMSnSet(res_12h[[1]], fcol = "markers")
```

### 6.2.1 Proteins assigned to one main location

In this example we have performed an extra round of filtering when predicting
the main protein subcellular localisation by taking into account outlier
probability in addition to the posterior. As such, the column containing the
predictions in the `fData` is called `bandle.allocation.pred.pred`.

Extract the predictions,

```
res1 <- fData(res0hr_unknowns)$bandle.allocation.pred.pred
res2 <- fData(res12h_unknowns)$bandle.allocation.pred.pred

res1_tbl <- table(res1)
res2_tbl <- table(res2)
```

We can visualise these results on a barplot,

```
par(mfrow = c(1, 2))
barplot(res1_tbl, las = 2, main = "Predicted location: 0hr",
        ylab = "Number of proteins")
barplot(res2_tbl, las = 2, main = "Predicted location: 12hr",
        ylab = "Number of proteins")
```

![](data:image/png;base64...)

The barplot tells us for this example that after thresholding with a 1% FDR on
the posterior probability `bandle` has allocated many new proteins to
subcellular classes in our training data but also many are still left with no
allocation i.e. they are labelled as “unknown”. As previously mentioned the
class label “unknown” is a historic term from the `pRoloc` package to describe
proteins that are left unassigned following thresholding and thus proteins which
exhibit uncertainty in their allocations and thus potential proteins of mixed
location.

The associated posterior estimates are located in the `bandle.probability`column
and we can construct a `boxplot` to examine these probabilities by class,

```
pe1 <- fData(res0hr_unknowns)$bandle.probability
pe2 <- fData(res12h_unknowns)$bandle.probability

par(mfrow = c(1, 2))
boxplot(pe1 ~ res1, las = 2, main = "Posterior: control",
        ylab = "Probability")
boxplot(pe2 ~ res2, las = 2, main = "Posterior: treatment",
        ylab = "Probability")
```

![](data:image/png;base64...)

We see proteins in the “unknown” “unlabelled” category with a range of different
probabilities. We still have several proteins in this category with a high
probability, it is likely that proteins classed in this category also have a
high outlier probability.

### 6.2.2 Proteins with uncertainty

We can use the `unknownMSnSet` function once again to extract proteins in the
“unknown” category.

```
res0hr_mixed <- unknownMSnSet(res0hr_unknowns, fcol = "bandle.allocation.pred.pred")
res12hr_mixed <- unknownMSnSet(res12h_unknowns, fcol = "bandle.allocation.pred.pred")
```

We see we have 1665 and 1420
proteins for the 0hr and 12hr conditions respectively, which do not get assigned
one main location. This is approximately 40% of the data.

```
nrow(res0hr_mixed)
```

```
## [1] 1665
```

```
nrow(res12hr_mixed)
```

```
## [1] 1420
```

Let’s extract the names of these proteins,

```
fn1 <- featureNames(res0hr_mixed)
fn2 <- featureNames(res12hr_mixed)
```

Let’s plot the the first 9 proteins that did not meet the thresholding criteria.
We can use the `mcmc_plot_probs` function to generate a violin plot of the
localisation distribution.

Let’s first look at these proteins in the control condition,

```
g <- vector("list", 9)
for (i in 1:9) g[[i]] <- mcmc_plot_probs(params_converged, fn1[i], cond = 1)
```

```
## Warning in fortify(data, ...): Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
```

```
do.call(grid.arrange, g)
```

![](data:image/png;base64...)

Now the treated,

```
g <- vector("list", 9)
for (i in 1:9) g[[i]] <- mcmc_plot_probs(params_converged, fn1[i], cond = 2)
```

```
## Warning in fortify(data, ...): Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
## Arguments in `...` must be used.
## ✖ Problematic argument:
## • width = Probability
## ℹ Did you misspell an argument name?
```

```
do.call(grid.arrange, g)
```

![](data:image/png;base64...)

We can also get a summary of the full probability distribution by looking at the
joint estimates stored in the `bandle.joint` slot of the `MSnSet`.

```
head(fData(res0hr_mixed)$bandle.joint)
```

```
##          40S/60S Ribosome     Chromatin       Cytosol Endoplasmic Reticulum
## A0FGR8-2     9.646157e-23  8.415631e-45  0.000000e+00          1.273592e-01
## A0JNW5       5.427639e-11  8.089554e-31 1.391961e-123         7.259520e-122
## A1L170-2     1.591927e-39 9.017723e-123 5.334195e-299         4.723120e-146
## A2RUS2       2.115186e-01  3.468505e-24 1.465931e-223         1.390413e-135
## A4D1P6       5.396309e-40 7.837751e-115  6.933762e-34         4.999559e-264
## A5YKK6       9.902917e-08  4.303047e-28  0.000000e+00         6.357580e-155
##          Golgi Apparatus      Lysosome  Mitochondria     Nucleolus      Nucleus
## A0FGR8-2    8.726408e-01  1.385677e-17  6.117813e-58 8.356252e-102 3.699505e-51
## A0JNW5      6.374464e-33  1.506449e-68 7.763227e-194  3.561031e-39 1.000000e+00
## A1L170-2    3.124441e-45  9.995787e-01  0.000000e+00  9.705976e-96 2.598703e-15
## A2RUS2      3.018838e-63  8.084753e-62 2.539106e-177  7.870134e-01 1.467956e-03
## A4D1P6     3.262104e-108 6.560123e-134  0.000000e+00  1.079645e-52 1.000000e+00
## A5YKK6      2.035232e-83  5.305804e-69 3.842312e-154  9.999999e-01 1.639855e-10
##             Peroxisome Plasma Membrane
## A0FGR8-2  3.190321e-23   4.150274e-128
## A0JNW5   1.961306e-290   2.803939e-161
## A1L170-2  0.000000e+00    4.213451e-04
## A2RUS2   1.123936e-287   5.532347e-116
## A4D1P6    0.000000e+00   7.252527e-224
## A5YKK6   2.204651e-124   2.694190e-125
```

Or visualise the joint posteriors on a heatmap

```
bjoint_0hr_mixed <- fData(res0hr_mixed)$bandle.joint
pheatmap(bjoint_0hr_mixed, cluster_cols = FALSE, color = viridis(n = 25),
         show_rownames = FALSE, main = "Joint posteriors for unlabelled proteins at 0hr")
```

![](data:image/png;base64...)

```
bjoint_12hr_mixed <- fData(res12hr_mixed)$bandle.joint
pheatmap(bjoint_12hr_mixed, cluster_cols = FALSE, color = viridis(n = 25),
         show_rownames = FALSE, main = "Joint posteriors for unlabelled proteins at 12hr")
```

![](data:image/png;base64...)

# 7 Differential localisation

The differential localisation probability tells us which proteins are most
likely to *differentially localise*, that exhibit a change in their steady-state
subcellular location. Quantifying changes in protein subcellular location
between experimental conditions is challenging and Crook et al (Crook et al. [2022](#ref-bandle)) have
used a Bayesian approach to compute the probability that a protein
differentially localises upon cellular perturbation, as well quantifying the
uncertainty in these estimates. The differential localisation probability is
found in the `bandle.differential.localisation` column of the `MSnSet` or can
be extracted directly with the `diffLocalisationProb` function.

```
dl <- diffLocalisationProb(params_converged)
head(dl)
```

```
##   A0AVT1 A0FGR8-2   A0JNW5 A0MZ66-3   A0PJW6   A1L0T0
##      0.0      0.8      0.0      0.0      0.6      0.0
```

If we take a 5% FDR and examine how many proteins get a differential probability
greater than 0.95 we find there are
892
proteins above this threshold.

```
length(which(dl[order(dl, decreasing = TRUE)] > 0.95))
```

```
## [1] 892
```

On a rank plot we can see the distribution of differential probabilities.

```
plot(dl[order(dl, decreasing = TRUE)],
     col = getStockcol()[2], pch = 19, ylab = "Probability",
     xlab = "Rank", main = "Differential localisation rank plot")
```

![](data:image/png;base64...)

This indicated that most proteins are not differentially localised and there are a
few hundred confident differentially localised proteins of interest.

```
candidates <- names(dl)
```

## 7.1 Visualising differential localisation

There are several different ways we can visualise the output of `bandle`. Now we
have our set of candidates we can subset `MSnSet` datasets and plot the the
results.

To subset the data,

```
msnset_cands <- list(res_0h[[1]][candidates, ],
                     res_12h[[1]][candidates, ])
```

We can visualise this as a `data.frame` too for ease,

```
# construct data.frame
df_cands <- data.frame(
    fData(msnset_cands[[1]])[, c("bandle.differential.localisation",
                                 "bandle.allocation.pred.pred")],
    fData(msnset_cands[[2]])[, "bandle.allocation.pred.pred"])

colnames(df_cands) <- c("differential.localisation",
                        "0hr_location", "12h_location")

# order by highest differential localisation estimate
df_cands <- df_cands %>% arrange(desc(differential.localisation))
head(df_cands)
```

```
##          differential.localisation          0hr_location    12h_location
## A1L170-2                         1               unknown         unknown
## A2RUS2                           1               unknown         unknown
## A2VDJ0-5                         1 Endoplasmic Reticulum Golgi Apparatus
## B2RUZ4                           1              Lysosome Plasma Membrane
## B7ZBB8                           1               unknown         unknown
## O00165-2                         1            Peroxisome    Mitochondria
```

### 7.1.1 Alluvial plots

We can now plot this on an alluvial plot to view the changes in subcellular
location. The class label is taken from the column called
`"bandle.allocation.pred.pred"` which was deduced above by thresholding on the
posterior and outlier probabilities before assigning BANDLE’s allocation
prediction.

```
## set colours for organelles and unknown
cols <- c(getStockcol()[seq(mrkCl)], "grey")
names(cols) <- c(mrkCl, "unknown")

## plot
alluvial <- plotTranslocations(msnset_cands,
                               fcol = "bandle.allocation.pred.pred",
                               col = cols)
```

```
## 2942 features in common
```

```
## ------------------------------------------------
## If length(fcol) == 1 it is assumed that the
## same fcol is to be used for both datasets
## setting fcol = c(bandle.allocation.pred.pred,bandle.allocation.pred.pred)
## ----------------------------------------------
```

```
alluvial + ggtitle("Differential localisations following 12h-LPS stimulation")
```

![](data:image/png;base64...)

To view a table of the translocations, we can call the function `plotTable`,

```
(tbl <- plotTable(msnset_cands, fcol = "bandle.allocation.pred.pred"))
```

```
## 2942 features in common
```

```
## ------------------------------------------------
## If length(fcol) == 1 it is assumed that the
## same fcol is to be used for both datasets
## setting fcol = c(bandle.allocation.pred.pred, bandle.allocation.pred.pred)
## ----------------------------------------------
```

```
##                Condition1            Condition2 value
## 11       40S/60S Ribosome               unknown     3
## 18              Chromatin             Nucleolus     2
## 20              Chromatin            Peroxisome     1
## 22              Chromatin               unknown     5
## 33                Cytosol               unknown    86
## 37  Endoplasmic Reticulum       Golgi Apparatus    35
## 44  Endoplasmic Reticulum               unknown    23
## 48        Golgi Apparatus Endoplasmic Reticulum    13
## 49        Golgi Apparatus              Lysosome     4
## 55        Golgi Apparatus               unknown    19
## 59               Lysosome Endoplasmic Reticulum     2
## 60               Lysosome       Golgi Apparatus    43
## 65               Lysosome       Plasma Membrane    47
## 66               Lysosome               unknown    48
## 75           Mitochondria            Peroxisome    31
## 77           Mitochondria               unknown    31
## 78              Nucleolus      40S/60S Ribosome     1
## 88              Nucleolus               unknown     9
## 96                Nucleus             Nucleolus     1
## 99                Nucleus               unknown     4
## 103            Peroxisome Endoplasmic Reticulum    15
## 104            Peroxisome       Golgi Apparatus     1
## 106            Peroxisome          Mitochondria    24
## 110            Peroxisome               unknown    24
## 116       Plasma Membrane              Lysosome     6
## 121       Plasma Membrane               unknown    34
## 122               unknown      40S/60S Ribosome    28
## 123               unknown             Chromatin    41
## 124               unknown               Cytosol    42
## 125               unknown Endoplasmic Reticulum    71
## 126               unknown       Golgi Apparatus    94
## 127               unknown              Lysosome    30
## 128               unknown          Mitochondria    28
## 129               unknown             Nucleolus    34
## 130               unknown               Nucleus    35
## 131               unknown            Peroxisome    67
## 132               unknown       Plasma Membrane    61
```

Although this example analysis is limited compared to that of Mulvey et al. ([2021](#ref-thplopit)), we do
see similar trends inline with the results seen in the paper. For examples, we
see a large number of proteins translocating between organelles that are
involved in the secretory pathway. We can further examine these cases by
subsetting the datasets once again and only plotting proteins that involve
localisation with these organelles. Several organelles are known to be involved
in this pathway, the main ones, the ER, Golgi (and plasma membrane).

Let’s subset for these proteins,

```
secretory_prots <- unlist(lapply(msnset_cands, function(z)
    c(which(fData(z)$bandle.allocation.pred.pred == "Golgi Apparatus"),
      which(fData(z)$bandle.allocation.pred.pred == "Endoplasmic Reticulum"),
      which(fData(z)$bandle.allocation.pred.pred == "Plasma Membrane"),
      which(fData(z)$bandle.allocation.pred.pred == "Lysosome"))))
secretory_prots <- unique(secretory_prots)

msnset_secret <- list(msnset_cands[[1]][secretory_prots, ],
                      msnset_cands[[2]][secretory_prots, ])

secretory_alluvial <- plotTranslocations(msnset_secret,
                                         fcol = "bandle.allocation.pred.pred",
                                         col = cols)
```

```
## 843 features in common
```

```
## ------------------------------------------------
## If length(fcol) == 1 it is assumed that the
## same fcol is to be used for both datasets
## setting fcol = c(bandle.allocation.pred.pred,bandle.allocation.pred.pred)
## ----------------------------------------------
```

```
secretory_alluvial + ggtitle("Movements of secretory proteins")
```

![](data:image/png;base64...)

### 7.1.2 Protein profiles

In the next section we see how to plot proteins of interest. Our differential
localisation candidates can be found in `df_cands`,

```
head(df_cands)
```

```
##          differential.localisation          0hr_location    12h_location
## A1L170-2                         1               unknown         unknown
## A2RUS2                           1               unknown         unknown
## A2VDJ0-5                         1 Endoplasmic Reticulum Golgi Apparatus
## B2RUZ4                           1              Lysosome Plasma Membrane
## B7ZBB8                           1               unknown         unknown
## O00165-2                         1            Peroxisome    Mitochondria
```

We can probe this `data.frame` by examining proteins with high differential
localisation probabilites. For example, protein with accession B2RUZ4. It
has a high differential localisation score and it’s steady state localisation in
the control is predicted to be lysosomal and in the treatment condition at 12
hours-LPS it is predicted to localise to the plasma membrane. This fits with the
information we see on Uniprot which tells us it is Small integral membrane
protein 1 (SMIM1).

In the below code chunk we plot the protein profiles of all proteins that were
identified as lysosomal from BANDLE in the control and then overlay SMIM1. We do
the same at 12hrs post LPS with all plasma membrane proteins.

```
par(mfrow = c(2, 1))

## plot lysosomal profiles
lyso <- which(fData(res_0h[[1]])$bandle.allocation.pred.pred == "Lysosome")
plotDist(res_0h[[1]][lyso], pcol = cols["Lysosome"], alpha = 0.04)
matlines(exprs(res_0h[[1]])["B2RUZ4", ], col = cols["Lysosome"], lwd = 3)
title("Protein SMIM1 (B2RUZ4) at 0hr (control)")

## plot plasma membrane profiles
pm <- which(fData(res_12h[[1]])$bandle.allocation.pred.pred == "Plasma Membrane")
plotDist(res_12h[[1]][pm], pcol = cols["Plasma Membrane"], alpha = 0.04)
matlines(exprs(res_12h[[1]])["B2RUZ4", ], col = cols["Plasma Membrane"], lwd = 3)
title("Protein SMIM1 (B2RUZ4) at 12hr-LPS (treatment)")
```

![](data:image/png;base64...)

We can also visualise there on a PCA or t-SNE plot.

```
par(mfrow = c(1, 2))
plot2D(res_0h[[1]], fcol = "bandle.allocation.pred.pred",
       main = "Unstimulated - replicate 1 \n predicted location")
highlightOnPlot(res_0h[[1]], foi = "B2RUZ4")

plot2D(res_12h[[1]], fcol = "bandle.allocation.pred.pred",
       main = "12h-LPS - replicate 1 \n predicted location")
highlightOnPlot(res_12h[[1]], foi = "B2RUZ4")
```

![](data:image/png;base64...)

# 8 Session information

All software and respective versions used to produce this document are listed below.

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
##  [1] pRolocdata_1.47.0    gridExtra_2.3        ggplot2_4.0.0
##  [4] dplyr_1.1.4          viridis_0.6.5        viridisLite_0.4.2
##  [7] pheatmap_1.0.13      bandle_1.14.0        pRoloc_1.50.0
## [10] BiocParallel_1.44.0  MLInterfaces_1.90.0  cluster_2.1.8.1
## [13] annotate_1.88.0      XML_3.99-0.19        AnnotationDbi_1.72.0
## [16] IRanges_2.44.0       MSnbase_2.36.0       ProtGenerics_1.42.0
## [19] mzR_2.44.0           Rcpp_1.1.0           Biobase_2.70.0
## [22] S4Vectors_0.48.0     BiocGenerics_0.56.0  generics_0.1.4
## [25] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1               filelock_1.0.3
##   [3] tibble_3.3.0                hardhat_1.4.2
##   [5] preprocessCore_1.72.0       pROC_1.19.0.1
##   [7] rpart_4.1.24                lifecycle_1.0.4
##   [9] httr2_1.2.1                 doParallel_1.0.17
##  [11] globals_0.18.0              lattice_0.22-7
##  [13] MASS_7.3-65                 MultiAssayExperiment_1.36.0
##  [15] dendextend_1.19.1           magrittr_2.0.4
##  [17] limma_3.66.0                plotly_4.11.0
##  [19] sass_0.4.10                 rmarkdown_2.30
##  [21] jquerylib_0.1.4             yaml_2.3.10
##  [23] MsCoreUtils_1.22.0          DBI_1.2.3
##  [25] RColorBrewer_1.1-3          lubridate_1.9.4
##  [27] abind_1.4-8                 GenomicRanges_1.62.0
##  [29] purrr_1.1.0                 mixtools_2.0.0.1
##  [31] AnnotationFilter_1.34.0     nnet_7.3-20
##  [33] rappdirs_0.3.3              ipred_0.9-15
##  [35] circlize_0.4.16             lava_1.8.1
##  [37] ggrepel_0.9.6               listenv_0.9.1
##  [39] gdata_3.0.1                 parallelly_1.45.1
##  [41] ncdf4_1.24                  codetools_0.2-20
##  [43] DelayedArray_0.36.0         shape_1.4.6.1
##  [45] tidyselect_1.2.1            Spectra_1.20.0
##  [47] farver_2.1.2                matrixStats_1.5.0
##  [49] BiocFileCache_3.0.0         Seqinfo_1.0.0
##  [51] jsonlite_2.0.0              caret_7.0-1
##  [53] e1071_1.7-16                ggalluvial_0.12.5
##  [55] survival_3.8-3              iterators_1.0.14
##  [57] foreach_1.5.2               segmented_2.1-4
##  [59] tools_4.5.1                 progress_1.2.3
##  [61] lbfgs_1.2.1.2               glue_1.8.0
##  [63] prodlim_2025.04.28          SparseArray_1.10.0
##  [65] BiocBaseUtils_1.12.0        xfun_0.53
##  [67] MatrixGenerics_1.22.0       withr_3.0.2
##  [69] BiocManager_1.30.26         fastmap_1.2.0
##  [71] digest_0.6.37               timechange_0.3.0
##  [73] R6_2.6.1                    colorspace_2.1-2
##  [75] gtools_3.9.5                lpSolve_5.6.23
##  [77] dichromat_2.0-0.1           biomaRt_2.66.0
##  [79] RSQLite_2.4.3               tidyr_1.3.1
##  [81] hexbin_1.28.5               data.table_1.17.8
##  [83] recipes_1.3.1               FNN_1.1.4.1
##  [85] class_7.3-23                prettyunits_1.2.0
##  [87] PSMatch_1.14.0              httr_1.4.7
##  [89] htmlwidgets_1.6.4           S4Arrays_1.10.0
##  [91] ModelMetrics_1.2.2.2        pkgconfig_2.0.3
##  [93] gtable_0.3.6                timeDate_4051.111
##  [95] blob_1.2.4                  S7_0.2.0
##  [97] impute_1.84.0               XVector_0.50.0
##  [99] htmltools_0.5.8.1           bookdown_0.45
## [101] MALDIquant_1.22.3           clue_0.3-66
## [103] scales_1.4.0                png_0.1-8
## [105] gower_1.0.2                 knitr_1.50
## [107] MetaboCoreUtils_1.18.0      reshape2_1.4.4
## [109] coda_0.19-4.1               nlme_3.1-168
## [111] curl_7.0.0                  GlobalOptions_0.1.2
## [113] proxy_0.4-27                cachem_1.1.0
## [115] stringr_1.5.2               parallel_4.5.1
## [117] mzID_1.48.0                 vsn_3.78.0
## [119] pillar_1.11.1               grid_4.5.1
## [121] vctrs_0.6.5                 pcaMethods_2.2.0
## [123] randomForest_4.7-1.2        dbplyr_2.5.1
## [125] xtable_1.8-4                evaluate_1.0.5
## [127] magick_2.9.0                tinytex_0.57
## [129] mvtnorm_1.3-3               cli_3.6.5
## [131] compiler_4.5.1              rlang_1.1.6
## [133] crayon_1.5.3                future.apply_1.20.0
## [135] labeling_0.4.3              LaplacesDemon_16.1.6
## [137] mclust_6.1.1                QFeatures_1.20.0
## [139] affy_1.88.0                 plyr_1.8.9
## [141] fs_1.6.6                    stringi_1.8.7
## [143] Biostrings_2.78.0           lazyeval_0.2.2
## [145] Matrix_1.7-4                hms_1.1.4
## [147] bit64_4.6.0-1               future_1.67.0
## [149] KEGGREST_1.50.0             statmod_1.5.1
## [151] SummarizedExperiment_1.40.0 kernlab_0.9-33
## [153] igraph_2.2.1                memoise_2.0.1
## [155] affyio_1.80.0               bslib_0.9.0
## [157] sampling_2.11               bit_4.6.0
```

# References

Crook, Oliver M., Lisa M. Breckels, Kathryn S. Lilley, Paul D. W. Kirk, and Laurent Gatto. 2019. “A Bioconductor Workflow for the Bayesian Analysis of Spatial Proteomics.” *F1000Research* 8 (April): 446. <https://doi.org/10.12688/f1000research.18636.1>.

Crook, Oliver M., Colin T. R. Davies, Lisa M. Breckels, Josie A. Christopher, Laurent Gatto, Paul D. W. Kirk, and Kathryn S. Lilley. 2022. “Inferring Differential Subcellular Localisation in Comparative Spatial Proteomics Using Bandle.” *Nature Communications* 13 (1). <https://doi.org/10.1038/s41467-022-33570-9>.

Mulvey, Claire M., Lisa M. Breckels, Oliver M. Crook, David J. Sanders, Andre L. R. Ribeiro, Aikaterini Geladaki, Andy Christoforou, et al. 2021. “Spatiotemporal Proteomic Profiling of the Pro-Inflammatory Response to Lipopolysaccharide in the THP-1 Human Leukaemia Cell Line.” *Nature Communications* 12 (1). <https://doi.org/10.1038/s41467-021-26000-9>.

Mulvey, Claire M, Lisa M Breckels, Aikaterini Geladaki, Nina Kočevar Britovšek, Daniel J H Nightingale, Andy Christoforou, Mohamed Elzek, Michael J Deery, Laurent Gatto, and Kathryn S Lilley. 2017. “Using hyperLOPIT to Perform High-Resolution Mapping of the Spatial Proteome.” *Nature Protocols* 12 (6): 1110–35. <https://doi.org/10.1038/nprot.2017.026>.

Taboga, Marco. 2021. *Markov Chain Monte Carlo (Mcmc) Diagnostics*. Lectures on probability theory; mathematical statistics, Kindle Direct Publishing. <https://www.statlect.com/fundamentals-of-statistics/Markov-Chain-Monte-Carlo-diagnostics>.