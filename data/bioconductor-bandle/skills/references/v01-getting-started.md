# Vignette 1: Getting Started with BANDLE

Oliver M. Crook1 and Lisa M. Breckels2

1Department of Statistics, University of Oxford, UK
2Cambridge Centre for Proteomics, University of Cambridge, UK

#### 29 October 2025

#### Abstract

This vignette provides an introduction to the BANDLE package (Crook et al. [2022](#ref-bandle)) and follows a short theortical example of how to perform differential localisation analysis of quantitative proteomics data using the BANDLE model. Explanation and general recommendations of the input parameters are provided here. For a more comprehensive workflow which follows a real-life use case, please see the second vignette in this package.

#### Package

bandle 1.14.0

# 1 Introduction

Bayesian ANalysis of Differential Localisation Experiments (BANDLE) is an
integrative semi-supervised functional mixture model, developed by Crook et al
(Crook et al. [2022](#ref-bandle)), to obtain the probability of a protein being differentially localised
between two conditions.

In this vignette we walk users through how to install and use the R (R Development Core Team [2011](#ref-Rstat))
Bioconductor (Gentleman et al. [2004](#ref-Gentleman:2004)) [`bandle`package](https://github.com/ococrook/bandle)
by simulating a well-defined differential localisation experiment from spatial
proteomics data from the `pRolocdata` package (Gatto et al. [2014](#ref-pRoloc:2014)).

The BANDLE method uses posterior Bayesian computations performed using
Markov-chain Monte-Carlo (MCMC) and thus uncertainty estimates are available
(Gilks, Richardson, and Spiegelhalter [1995](#ref-Gilks:1995)). It is inspired by the T-augmented Gaussuan mixture model (TAGM)
by Crook et al. 2018 (Crook et al. [2018](#ref-Crook2018)) which was developed to allow interrogation of
multiply localised proteins through uncertainty estimation. Throughout this
vignette we use the term *differentially localised* to pertain to proteins which
are assigned to different sub-cellular localisations between two conditions.

The output of BANDLE provides users with:

1. **Protein subcellular localisation predictions**. For each protein the full
   probability distribution over all possible organelles/complexes is computed.
   Through uncertainty quantification users can gain insight into proteins that may
   localise to more than one location.
2. **Differential localisation predictions**. The full probability of a protein
   being differentially localised between two conditions is computed. Uncertainty
   estimates are available for the differential localisation probability to aid
   filtering of candidate movers for validation.

# 2 Installation

The package can be installed with the `BiocManager` package:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("bandle")
```

and then loaded,

```
library("bandle")
```

For visualisation we also load the packages,

```
library("pheatmap")
library("viridis")
library("dplyr")
library("ggplot2")
library("gridExtra")
```

# 3 The data

In this vignette and Crook et al. ([2022](#ref-bandle)), the main data source that we use to study
differential protein sub-cellular localisation are data from high-throughput
mass spectrometry-based experiments. The data from these types of experiments
traditionally yield a matrix of measurements wherein we have, for example, PSMs,
peptides or proteins along the rows, and samples/channels/fractions along the
columns. The `bandle` package uses the `MSnSet` class as implemented in the
Bioconductor *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* package and thus requires users to import
and store their data as a `MSnSet` instance. For more details on how to create a
`MSnSet` see the relevant vignettes in *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)*. The
*[pRolocdata](https://bioconductor.org/packages/3.22/pRolocdata)* experiment data package is a good starting place to
look for test data. This data package contains tens of quantitative proteomics
experiments, stored as `MSnSet`s.

## 3.1 A well-defined theoretical example

To get started with the basics of using `bandle` we begin by generating a simple
example dataset which simulates a differential localisation experiment (please
see the second vignette in this package for a full real-life biological use
case). In this example data, the key elements are replicates, and a perturbation
of interest. There is code within the *[bandle](https://bioconductor.org/packages/3.22/bandle)* package to simulate
an example experiment.

In the code chunk below we begin by loading the *[pRolocdata](https://bioconductor.org/packages/3.22/pRolocdata)*
package to obtain a spatial proteomics dataset. This will be the basis of our
simulation which will use boostrapping to generate new datasets. The dataset we
have chosen to load is a dataset from 2009 (`tan2009r1`). This is data from a
early LOPIT experiment performed on Drosophila embryos by Tan et al. ([2009](#ref-Tan:2009)). The aim of
this experiment was to apply LOPIT to an organism with heterogeneous cell types.
This experiment used four isotopes across four distinct fractions and thus
yielded four measurements (features) per protein profile. We visualise the
data by using principal components analysis.

```
library("pRolocdata")
data("tan2009r1")

## Let's set the stock colours of the classes to plot to be transparent
setStockcol(NULL)
setStockcol(paste0(getStockcol(), "90"))

## Plot the data using plot2D from pRoloc
plot2D(tan2009r1,
       main = "An example spatial proteomics datasets",
       grid = FALSE)
addLegend(tan2009r1, where = "topleft", cex = 0.7, ncol = 2)
```

![](data:image/png;base64...)

The following code chuck simulates a differential localisation experiment. It
will generate `numRep/2` of each a control and treatment condition. We will also
simulate relocalisations for `numDyn` proteins.

```
set.seed(1)
tansim <- sim_dynamic(object = tan2009r1,
                      numRep = 6L,
                      numDyn = 100L)
```

```
## [1] "markers"
```

The list of the 6 simulated experiments are found in `tansim$lopitrep`. Each one
is an `MSnSet` instance (the standard data container for proteomics experimental
data). The first 3 are the simulated control experiments (see
`tansim$lopitrep[1:3]`), and the following 3 in the list are the treatment
condition simulated experiments (see `tansim$lopitrep[4:6]`).

```
# To access the first replicate
tansim$lopitrep[[1]]
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 888 features, 4 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: X114 X115 X116 X117
##   varLabels: Fractions
##   varMetadata: labelDescription
## featureData
##   featureNames: P20353 P53501 ... P07909 (888 total)
##   fvarLabels: FBgn Protein.ID ... knn.scores (18 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
##   pubMedIds: 19317464
## Annotation:
## - - - Processing information - - -
## Added markers from  'mrk' marker vector. Thu Jul 16 22:53:44 2015
## Performed knn prediction (k=10) Wed Oct 29 22:37:46 2025
##  MSnbase version: 1.17.12
```

We can plot them using the `plot2D` function from `pRoloc`.

```
plot_title <- c(paste0("Replicate ", seq(3), " condition", " A"),
               paste0("Replicate ", seq(3), " condition", " B"))

par(mfrow = c(2, 3))
out <- lapply(seq(tansim$lopitrep), function(z)
    plot2D(tansim$lopitrep[[z]], grid = FALSE, main = plot_title[z]))
```

![](data:image/png;base64...)

For understanding, exploring and visualizing individual spatial proteomics
experiments, see the vignettes in `pRoloc` and `MSnbase` packages.

# 4 Preparing for `bandle` analysis

The main function of the package is `bandle`, this uses a complex model
to analyse the data. Markov-Chain Monte-Carlo (MCMC) is used to sample the
posterior distribution of parameters and latent variables. From which statistics
of interest can be computed. Here we only run a few iterations for brevity but
typically one needs to run thousands of iterations to ensure convergence, as
well as multiple parallel chains.

## 4.1 Fitting Gaussian processes

First, we need to fit non-parametric regression functions to the markers
profiles, upon which we place our analysis. This uses Gaussian processes. The
`fitGPmaternPC` function can be used and fits some default penalised complexity
priors (see `?fitGP`), which works well. However, these can be altered, which is
demonstrated in the next code chunk and also further in Vignette 2 of this
package.

```
par(mfrow = c(4, 3))
gpParams <- lapply(tansim$lopitrep, function(x)
  fitGPmaternPC(x, hyppar = matrix(c(10, 60, 250), nrow = 1)))
```

We apply the `fitGPmaternPC` function to each datasets by calling `lapply` over
the `tansim$lopitrep` list of datasets. The output of `fitGPmaternPC` returns a
list of posterior predictive means and standard deviations. As well as MAP
hyperparamters for the GP.

Note here we the use the default parameters for the `fitGPmaternPC` function are
`hyppar = matrix(c(10, 60, 250), nrow = 1)`. This is provided as a starting
point for fitting the GPs to the marker profile distributions. In the Crook et al. ([2022](#ref-bandle))
we found that these values worked well for smaller spatial
proteomics datasets and those with fewer channels/fractions. This was visually
assessed by passing these values and visualising the GP fit using the
`plotGPmatern` function.

The `plotGPmatern` function can be used to plot the profiles for each
class in each replicate condition with the posterior predictive distributions
overlayed with the markers protein profiles.

For example, to plot the predictive distributions of the first dataset,

```
par(mfrow = c(4, 3))
plotGPmatern(tansim$lopitrep[[1]], params = gpParams[[1]])
```

![](data:image/png;base64...)

In the next code chunk we set some priors on the data. The prior needs to form a
`K*3` matrix. `K` corresponds to the number of subcellular classes in the data,
and 3 columns for the prior; (1) length-scale, (2) amplitude and (3) variance
(see `hyppar` in `?fitGPmaternPC`). Increasing these values, increases the
shrinkage. For more details see the manuscript by Crook et al. ([2022](#ref-bandle)). We strongly recommend
users start with the recommended `hyppar` parameters and change and assess them
as necessary for their dataset by visually evaluating the fit of the GPs using
the `plotGPmatern` function.

```
K <- length(getMarkerClasses(tansim$lopitrep[[1]], fcol = "markers"))
pc_prior <- matrix(NA, ncol = 3, K)
pc_prior[seq.int(1:K), ] <- matrix(rep(c(10, 60, 250),
                                       each = K), ncol = 3)
```

Now we have generated these complexity priors we can pass them as an argument to
the `fitGPmaternPC` function. For example,

```
gpParams <- lapply(tansim$lopitrep,
                   function(x) fitGPmaternPC(x, hyppar = pc_prior))
```

By looking at the plot of posterior predictives using the `gpParams` we can see
the GP fit looks sensible.

## 4.2 Setting the prior on the weights

The next step is to set up the matrix Dirichlet prior on the mixing weights. These
weights are defined across datasets so these are slightly different to mixture
weights in usual mixture models. The \((i,j)^{th}\) entry is the prior probability
that a protein localises to organelle \(i\) in the control and \(j\) in the treatment.
This mean that off-diagonal terms have a different interpretation to diagonal terms.
Since we expect re-localisation to be rare, off-diagonal terms should be small.
The following functions help set up the priors and how to interpret them. The
parameter `q` allow us to check the prior probability that more than `q`
differential localisations are expected.

```
set.seed(1)
dirPrior = diag(rep(1, K)) + matrix(0.001, nrow = K, ncol = K)
predDirPrior <- prior_pred_dir(object = tansim$lopitrep[[1]],
                               dirPrior = dirPrior,
                               q = 15)
```

The mean number of re-localisations is small:

```
predDirPrior$meannotAlloc
```

```
## [1] 0.3457542
```

The prior probability that more than `q` differential localisations are
expected is small

```
predDirPrior$tailnotAlloc
```

```
## [1] 4e-04
```

The full prior predictive can be visualised as histogram. The prior probability
that proteins are allocated to different components between datasets concentrates
around 0.

```
hist(predDirPrior$priornotAlloc, col = getStockcol()[1])
```

![](data:image/png;base64...)

For most use-cases we indeed expect the number of differential
localisations to be small. However, there may be specific cases where one may
expect the either a smaller or larger number of differential localisations.
Users could try testing different values for the `dirPrior` for example,
replacing 0.001 with 0.0005 or smaller, for larger datasets to bring the number
of expected re-localisations inline with the biological expectation, and
visa-versa when we expect the number of proteins to have changed to be higher.

# 5 Running the `bandle` function

We are now ready to run the main `bandle` function. Remember to carefully
select the datasets and replicates that define the control and treatment.
As a reminder, in this introductory vignette we have used a small dataset
and generated theoretical triplicates of each theoretical condition. Please see
the second vignette in this package for a more detailed workflow and real
biological use-case. In the below code chunk we run `bandle` for only 100
iterations for the convenience of building the vignette, but typically we’d
recommend you run the number of iterations (`numIter`) in the 1000s.

Remember: the first 3 datasets are the first 3 elements of `tansim` and the
final 3 elements are the “treatment” triplicate datasets.

```
## Split the datasets into two separate lists, one for control and one for treatment
control <- tansim$lopitrep[1:3]
treatment <- tansim$lopitrep[4:6]

## Run bandle
bandleres <- bandle(objectCond1 = control,
                    objectCond2 = treatment,
                    numIter = 100,   # usually 10,000
                    burnin = 5L,    # usually 5,000
                    thin = 1L,      # usually 20
                    gpParams = gpParams,
                    pcPrior = pc_prior,
                    numChains = 3,  # usually >=4
                    dirPrior = dirPrior,
                    seed = 1)       # set a random seed for reproducibility)
```

The `bandle` function generates an object of class `bandleParams`. The `show`
method indicates the number of parallel chains that were run, this should
typically be greater than 4 (here we use 3 just as a demo).

```
bandleres
```

```
## Object of class "bandleParams"
## Method: bandle
## Number of chains: 3
```

# 6 Analysing `bandle` output

## 6.1 Assesing the model for convergence

The `bandle` method uses of Markov Chain Monte Carlo (MCMC) and therefore before
we can extract our classification and differential localisation results we first
need to check the algorithm for convergence of the MCMC chains. This is standard
practice in Bayesian inference and there are many ways to assess for convergence
as discussed in Crook et al. ([2019](#ref-Crook2019)).

The two main functions we can use to help us assess convergence are:

* `calculateGelman` which calculates the Gelman diagnostics for all pairwise
  chain combinations
* `plotOutliers` which generates trace and density plots for all chains

Let’s start with the `calculateGelman` which uses code the `coda` R package. It
allows us to compare the inter and intra chain variances. If the chains have
converged the ratio of these quantities should be < 1.2, ideally, close to 1, as
discuss in Crook et al. ([2019](#ref-Crook2019)) and general Bayesian literature.

```
calculateGelman(bandleres)
```

```
## $Condition1
##            comb_12  comb_13  comb_23
## Point_Est 1.141373 1.108632 1.002600
## Upper_CI  1.514882 1.415007 1.011233
##
## $Condition2
##            comb_12  comb_13  comb_23
## Point_Est 1.032026 1.053762 1.015716
## Upper_CI  1.077456 1.054345 1.065558
```

In this example, to demonstrate how to use `bandle` we have only run 100 MCMC
iterations for each chain. As already mentioned, in practice we suggest running
a minimum of 1000 iterations and a minimum of 4 chains.

In this toy example we see that the point estimate Gelman diagnostics are <1.2
which suggests convergence. The upper confidence intervals however are higher
than 1.2 for some pairs of chains. We may wish to consider removing some chains
which when paired with another chain exhibit values > 1. First let’s generate
trace and density plots for all chains using the `plotOutliers` function.

```
plotOutliers(bandleres)
```

![](data:image/png;base64...)

* Trace plots are subjective but can used to help visually
  assess the sample path of the chains. Textbooks on Bayesian inference often tell
  us that a good trace plots should look like a “hairy” or “fuzzy caterpillar”.
* The density plots generated from the `plotOutliers` function show the number
  of outliers for each iteration expressed as a probability density. For
  convergence we expect to see a normally distributed plot centered around roughly
  the same number of outliers in each chain.

As expected, as this is a toy theoretical example, only run for a few chains and
iterations, the trace and density plots do not show convergence i.e. over the
100 iterations they do not reach a stationary distribution.

In practice, we would do is remove bad chains i.e. those that have not
converged.

## 6.2 Removing unconverged chains

Chains which have not converged can be removed by standard subsetting. As an
example, let’s remove chain 2. We generate a new object called `bandlres_opt`,

```
bandleres_opt <- bandleres[-2]
```

We see the object `bandlres_opt` has now only 2 chains,

```
bandleres_opt
```

```
## Object of class "bandleParams"
## Method: bandle
## Number of chains: 2
```

In practice if we remove chains we would re-compute the Gelman and plot the
outliers as we did above to check again for convergence.

## 6.3 Populating a `bandleres` object

Currently, the summary slots of the `bandleres` object are empty. The
`summaries` function accesses them.

```
summaries(bandleres_opt)
```

```
## [[1]]
## An object of class "bandleSummary"
## Slot "posteriorEstimates":
## <S4 Type Object>
## attr(,"elementType")
## [1] "ANY"
## attr(,"elementMetadata")
## `\001NULL\001`
## attr(,"metadata")
## list()
##
## Slot "diagnostics":
## <0 x 0 matrix>
##
## Slot "bandle.joint":
## <0 x 0 matrix>
##
##
## [[2]]
## An object of class "bandleSummary"
## Slot "posteriorEstimates":
## <S4 Type Object>
## attr(,"elementType")
## [1] "ANY"
## attr(,"elementMetadata")
## `\001NULL\001`
## attr(,"metadata")
## list()
##
## Slot "diagnostics":
## <0 x 0 matrix>
##
## Slot "bandle.joint":
## <0 x 0 matrix>
```

These can be populated as follows,

```
bandleres_opt <- bandleProcess(bandleres_opt)
```

These slots have now been populated

```
summaries(bandleres_opt)
```

# 7 Predicting the subcellular location

We can append the results to our original `MSnSet` datasets using the
`bandlePredict` function.

```
xx <- bandlePredict(control,
                    treatment,
                    params = bandleres_opt,
                    fcol = "markers")
res_control <- xx[[1]]
res_treatment <- xx[[2]]
```

The output is a `list` of `MSnSets`. In this example,
we have 3 for the control and 3 for the treatment.

```
length(res_control)
```

```
## [1] 3
```

```
length(res_treatment)
```

```
## [1] 3
```

The results are appended to the **first** `MSnSet` feature data slot
for each condition.

```
fvarLabels(res_control[[1]])
```

```
##  [1] "FBgn"                             "Protein.ID"
##  [3] "Flybase.Symbol"                   "AccessionNo"
##  [5] "EntryName"                        "AccessionNoAll"
##  [7] "EntryNameAll"                     "No.peptide.IDs"
##  [9] "Mascot.score"                     "No.peptide.quantified"
## [11] "PLSDA"                            "pd.2013"
## [13] "pd.markers"                       "markers.orig"
## [15] "markers"                          "markers.tl"
## [17] "knn"                              "knn.scores"
## [19] "bandle.allocation"                "bandle.probability"
## [21] "bandle.probability.lowerquantile" "bandle.probability.upperquantile"
## [23] "bandle.mean.shannon"              "bandle.differential.localisation"
## [25] "bandle.outlier"                   "bandle.joint"
```

To access them use the `fData` function

```
fData(res_control[[1]])$bandle.probability
fData(res_control[[1]])$bandle.allocation
```

## 7.1 Thresholding on protein allocations

It is common practice in supervised machine learning to set a specific threshold
on which to define new assignments/allocations, below which classifications are
left unassigned/unknown. Indeed, we do not expect the whole subcellular
diversity to be represented by the 11 niches defined here, we expect there to be
many more, many of which will be multiply localised within the cell. It is
important to allow for the possibility of proteins to reside in multiple
locations, this information is available in the `bandle.joint` slot and also
can be extracted from the `bandleParams` object.

As we are using a Bayesian model the outputs of the classifier are
probabilities. This not only allows us to look at the distribution of
probabilities over all subcellular classes but also allows us to extract a
probability threshold on which we can define new assignments.

The subcellular allocations are located in the `bandle.allocation` column of the
`fData` slot and the posteriors are located in the `bandle.probability` slot. We
can use the `getPredictions` function from the `pRoloc` package to return a set
of predicted localisations according to if they meet a probability threshold.

For example, in the below code chunk we set a 1% FDR (`t = .99`) for assigning proteins a
subcellular niche, below which we leave them unlabelled termed “unknown” in the
`pRoloc` literature.

```
res_control[[1]] <- getPredictions(res_control[[1]],
                                   fcol = "bandle.allocation",
                                   scol = "bandle.probability",
                                   mcol = "markers",
                                   t = .99)
```

```
## ans
##  Cytoskeleton            ER         Golgi      Lysosome       Nucleus
##            13           218           136             9            39
##            PM    Peroxisome    Proteasome  Ribosome 40S  Ribosome 60S
##           135             8            41            72            49
## mitochondrion       unknown
##            81            87
```

```
res_treatment[[1]] <- getPredictions(res_treatment[[1]],
                                   fcol = "bandle.allocation",
                                   scol = "bandle.probability",
                                   mcol = "markers",
                                   t = .99)
```

```
## ans
##  Cytoskeleton            ER         Golgi      Lysosome       Nucleus
##            18           190           127            13            41
##            PM    Peroxisome    Proteasome  Ribosome 40S  Ribosome 60S
##           135            14            45            78            44
## mitochondrion       unknown
##            85            98
```

We see a new column has been appended to the `fData` slot, called,
`bandle.allocation.pred` which contains the subcellular predictions
after thresholding.

We can use the function `unknownMSnSet` to subset the data so that we only
examine proteins which were not included as markers in the analysis.

```
## Remove the markers from the MSnSet
res_control_unknowns <- unknownMSnSet(res_control[[1]], fcol = "markers")
res_treated_unknowns <- unknownMSnSet(res_treatment[[1]], fcol = "markers")
```

Now we can use the `getMarkers` function to summarise the new allocations by
class.

```
getMarkers(res_control_unknowns, "bandle.allocation.pred")
```

```
## organelleMarkers
##  Cytoskeleton            ER         Golgi      Lysosome       Nucleus
##             6           190           123             1            18
##            PM    Peroxisome    Proteasome  Ribosome 40S  Ribosome 60S
##           101             4            26            52            17
## mitochondrion       unknown
##            52            87
```

```
getMarkers(res_treated_unknowns, "bandle.allocation.pred")
```

```
## organelleMarkers
##  Cytoskeleton            ER         Golgi      Lysosome       Nucleus
##            11           162           114             5            20
##            PM    Peroxisome    Proteasome  Ribosome 40S  Ribosome 60S
##           101            10            30            58            12
## mitochondrion       unknown
##            56            98
```

Note: We may also wish to take into account the probability of the protein being an
outlier and thus use the results in the `bandle.outlier` column of the feature
data. We could calculate the product of the posterior and the outlier (as they
are both probabilities i.e. `bandle.outlier x bandle.outlier`) to obtain a
localisation score that takes into account the outlier model. More details on
this are found in the second vignette of this package.

## 7.2 Distribution on allocations

We can examine the distribution of allocations that:

1. have been assigned to a single location with high confidence and,
2. those which did not meet the threshold and thus have high uncertainty i.e.
   are labelled as “unknown”.

### 7.2.1 Proteins assigned to one main location

The column in the `fData` called `bandle.allocation.pred` contains the predicted
subcellular location for proteins. Let’s plot this,

Extract the predictions,

```
res1 <- fData(res_control_unknowns)$bandle.allocation.pred
res2 <- fData(res_treated_unknowns)$bandle.allocation.pred

res1_tbl <- table(res1)
res2_tbl <- table(res2)
```

Construct a quick barplot,

```
par(mfrow = c(1, 2))
barplot(res1_tbl, las = 2, main = "Predicted location: control",
        ylab = "Number of proteins")
barplot(res2_tbl, las = 2, main = "Predicted location: treatment",
        ylab = "Number of proteins")
```

![](data:image/png;base64...)

The barplot tells us for this example that after thresholding with a 1% FDR on
the posterior probability `bandle` has allocated the majority of unlabelled
proteins to the ER, followed by the Golgi. We also see many proteins have been
be unassigned and given the class label “unknown”. As previously mentioned
the class label “unknown” is a historic term from the `pRoloc` package to
describe proteins that are left unassigned following thresholding and thus
proteins which exhibit uncertainty in their allocations. In the section
after this one we examine these proteins and what their distributions may
mean.

The associated posterior estimates are located in the `bandle.probability`column
and we can construct a `boxplot` to examine these probabilities by class,

```
pe1 <- fData(res_control_unknowns)$bandle.probability
pe2 <- fData(res_treated_unknowns)$bandle.probability

par(mfrow = c(1, 2))
boxplot(pe1 ~ res1, las = 2, main = "Posterior: control",
        ylab = "Probability")
boxplot(pe2 ~ res2, las = 2, main = "Posterior: treatment",
        ylab = "Probability")
```

![](data:image/png;base64...)

### 7.2.2 Proteins with uncertainty

We can use the `unknownMSnSet` function once again to extract proteins which did
not get a main location when we performed thresholding i.e. those labelled
“unknown”.

```
res1_unlabelled <- unknownMSnSet(res_control_unknowns,
                                 fcol = "bandle.allocation.pred")
res2_unlabelled <- unknownMSnSet(res_treated_unknowns,
                                 fcol = "bandle.allocation.pred")
```

We see we have 91 and 99 proteins for the control and treatment respectively,
which do not get assigned one main location.

```
nrow(res1_unlabelled)
```

```
## [1] 87
```

```
nrow(res2_unlabelled)
```

```
## [1] 98
```

Let’s extract the names of these proteins,

```
fn1 <- featureNames(res1_unlabelled)
fn2 <- featureNames(res2_unlabelled)
```

Let’s plot the the first 9 proteins that did not meet the thresholding criteria.
We can use the `mcmc_plot_probs` function to generate a violin plot of the
localisation distribution. We need to recall the main `bandleParams` object we
created `bandleres_opt` to extract the full distribution and visualise the
uncertainty.

Let’s first look at these proteins in the control condition,

```
g <- vector("list", 9)
for (i in 1:9) g[[i]] <- mcmc_plot_probs(bandleres_opt, fn1[i], cond = 1)
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
for (i in 1:9) g[[i]] <- mcmc_plot_probs(bandleres_opt, fn1[i], cond = 2)
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

If we wanted to visualise one specific protein of interest e.g. `"Q24253"`

```
grid.arrange(
  mcmc_plot_probs(bandleres_opt, fname = "Q24253", cond = 1) +
  ggtitle("Distribution of Q24253 in control"),
  mcmc_plot_probs(bandleres_opt, fname = "Q24253", cond = 2) +
    ggtitle("Distribution of Q24253 in treated")
)
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
```

![](data:image/png;base64...)

We can also get a summary of the full probability distribution by looking at the
joint estimates stored in the `bandle.joint` slot of the `MSnSet`.

For example, again we can extract the joint posteriors for a specific protein,

```
fData(res_control_unknowns)$bandle.joint["Q24253", ]
```

```
##  Cytoskeleton            ER         Golgi      Lysosome       Nucleus
## 1.069832e-106  1.142331e-27  1.610264e-02  2.595543e-34  6.038006e-67
##            PM    Peroxisome    Proteasome  Ribosome 40S  Ribosome 60S
##  9.838974e-01  2.140434e-30  1.974257e-37  2.107385e-46  3.234912e-18
## mitochondrion
##  1.727432e-75
```

Or full a set of proteins we could visualise the joint posteriors on a heatmap.

```
bjoint_control <- fData(res_control_unknowns)$bandle.joint
pheatmap(bjoint_control, cluster_cols = FALSE, color = viridis(n = 25),
         show_rownames = FALSE, main = "Joint posteriors in the control")
```

![](data:image/png;base64...)

```
bjoint_treated <- fData(res_treated_unknowns)$bandle.joint
pheatmap(bjoint_treated, cluster_cols = FALSE, color = viridis(n = 25),
         show_rownames = FALSE, main = "Joint posteriors in the treated")
```

![](data:image/png;base64...)

# 8 Differential localisation probability

As previously mentioned the term “differentially localised” is used to pertain
to proteins which are assigned to different sub-cellular localisations between
two conditions. For the majority of users this is the main output they are keen
to extract using the BANDLE method. The differential localisation probability
can be found in either (1) the `bandle.differential.localisation` column of the
`MSnSet` that we generated following prediction, or (2) obtained directly from
the `bandleParams` object using the `diffLocalisationProb` function. The latter
is useful for users who are only interested in running bandle for obtaining
differential localisation information and not in using `bandle` as a method for
protein localisation prediction.

To obtain the differential localisation probability from a `bandleParams`
object,

```
dl <- diffLocalisationProb(bandleres_opt)
head(dl)
```

```
##     P20353     P53501     Q7KU78     P04412     Q7KJ73     Q9VM65
## 0.00000000 0.01052632 0.00000000 0.02105263 0.05263158 0.00000000
```

Or from the `MSnSet`,

```
dl <- fData(res_control_unknowns)$bandle.differential.localisation
names(dl) <- featureNames(res_control_unknowns)
head(dl)
```

```
##     P20353     P53501     Q7KU78     P04412     Q7KJ73     Q9VM65
## 0.00000000 0.01052632 0.00000000 0.02105263 0.05263158 0.00000000
```

The differential localisation probability tells us which proteins are most
likely to *differentially localise*. This can also be seen on a rank plot,

```
plot(dl[order(dl, decreasing = TRUE)],
     col = getStockcol()[3], pch = 19, ylab = "Probability",
     xlab = "Rank", main = "Differential localisation rank plot")
```

![](data:image/png;base64...)

In-line with our expectations, the rank plot indicates that most proteins are
**not** differentially localised.

We can for example, examine how many proteins get a differential probability
greater than 0.99 to look for the most confident differentially localised
candidates.

```
## Subset MSnSets for DL proteins > 0.99
ind <- which(dl > 0.99)
res_control_dl0.99 <- res_control_unknowns[ind, ]
res_treated_dl0.99 <- res_treated_unknowns[ind, ]

## Get DL results
dl0.99 <- fData(res_control_dl0.99)$bandle.differential.localisation
(names(dl0.99) <- featureNames(res_control_dl0.99))
```

```
##  [1] "P26308"   "Q9VP77"   "Q9VLJ6"   "Q9V496"   "Q9VU35"   "Q7KN81"
##  [7] "Q9VC06"   "Q9NJH0"   "Q8INP8"   "A8JNJ6"   "Q8SZ38"   "Q24276"
## [13] "Q9VKD3"   "Q9VI10"   "P42207"   "Q7KMM4"   "Q9VN21"   "P11584"
## [19] "Q9VUR0"   "Q9VJ46"   "Q9VZS3"   "O46111"   "P29310"   "Q05783"
## [25] "Q8MLV1"   "Q9VXE5"   "Q9VYT4"   "Q86PC7"   "Q9V4E0"   "Q9V4T5"
## [31] "P08879"   "O97066"   "Q9VN86"   "P18431"   "P08111"   "Q8SYR7"
## [37] "Q95TQ6"   "B7Z0X1"   "Q9VFP1"   "NO_ID_10" "A1Z7C4"   "E1JHT6"
## [43] "M9NF21"   "Q9VXI6"   "P22700"   "Q8IPU3"   "D5AEK7"   "Q9VRL2"
## [49] "M9PIC3"   "Q9VF87"   "Q7K3E2"   "Q8SWX8"   "Q9W1H1"   "Q9W1K0"
## [55] "P20240"   "Q9VPH7"   "O18335"   "Q24007"   "Q9V3R8"   "E1JHY0"
## [61] "Q9VVI2"   "Q9VJC7"   "M9PFY2"   "M9MSL3"   "Q7KVX1"   "B7Z0E0"
## [67] "Q9VVL7"   "Q9VVJ7"   "Q95SY0"   "B7Z0D3"   "P82295"   "Q9VLQ1"
## [73] "P32234"   "Q9VS57"   "Q94901"   "Q9VFV9"   "Q9U9Q4"   "O96051"
## [79] "Q9VFQ9"   "Q9VMD5"
```

We find there are 80 proteins above this threshold.

## 8.1 Visualising differential localisation

We can visualise the changes in localisation between conditions on an alluvial
plot using the `plotTranslocations` function

```
## Create an list of the two MSnSets
dl_msnsets <- list(res_control_dl0.99, res_treated_dl0.99)

## Set colours for organelles and unknown
mrkCl <- getMarkerClasses(res_control[[1]], fcol = "markers")
dl_cols <- c(getStockcol()[seq(mrkCl)], "grey")
names(dl_cols) <- c(mrkCl, "unknown")

## Now plot
plotTranslocations(dl_msnsets,
                   fcol = "bandle.allocation.pred",
                   col = dl_cols)
```

![](data:image/png;base64...)

Or alternatively, on a chord (circos) diagram

```
plotTranslocations(dl_msnsets,
                   fcol = "bandle.allocation.pred",
                   col = dl_cols,
                   type = "chord")
```

![](data:image/png;base64...)

A table summarising the differential localisations can be computed with the
`plotTable` function

```
plotTable(dl_msnsets, fcol = "bandle.allocation.pred")
```

```
## 80 features in common
```

```
## ------------------------------------------------
## If length(fcol) == 1 it is assumed that the
## same fcol is to be used for both datasets
## setting fcol = c(bandle.allocation.pred, bandle.allocation.pred)
## ----------------------------------------------
```

```
##        Condition1    Condition2 value
## 1              ER         Golgi     1
## 2              ER       Nucleus     1
## 3              ER            PM     3
## 4              ER    Peroxisome     7
## 5              ER    Proteasome     4
## 6              ER  Ribosome 40S     4
## 9              ER       unknown     6
## 10             ER  Cytoskeleton     2
## 11             ER      Lysosome     2
## 13          Golgi       Nucleus     3
## 19          Golgi mitochondrion     1
## 20          Golgi       unknown     3
## 25        Nucleus            PM     1
## 26        Nucleus    Peroxisome     1
## 35             PM         Golgi     1
## 38             PM    Proteasome     3
## 39             PM  Ribosome 40S     4
## 42             PM       unknown     2
## 46     Peroxisome         Golgi     1
## 59     Proteasome            PM     2
## 61     Proteasome  Ribosome 40S     2
## 63     Proteasome mitochondrion     2
## 64     Proteasome       unknown     1
## 68   Ribosome 40S         Golgi     1
## 69   Ribosome 40S       Nucleus     1
## 70   Ribosome 40S            PM     1
## 74   Ribosome 40S mitochondrion     1
## 75   Ribosome 40S       unknown     1
## 77   Ribosome 40S      Lysosome     2
## 83   Ribosome 60S    Proteasome     1
## 84   Ribosome 60S  Ribosome 40S     2
## 85   Ribosome 60S mitochondrion     1
## 97  mitochondrion       unknown     2
## 98  mitochondrion  Cytoskeleton     1
## 100       unknown            ER     2
## 103       unknown            PM     1
## 105       unknown    Proteasome     2
## 106       unknown  Ribosome 40S     1
## 107       unknown  Ribosome 60S     1
## 108       unknown mitochondrion     1
## 109       unknown  Cytoskeleton     1
```

# 9 Additional analysis

One advantage of using Bayesian methods over classic machine learning is the
ability to quantify the uncertainty in our estimates. This can be useful to help
pare down and select the proteins that are predicted to differentially localise.

## 9.1 Estimating uncertainty in differential localisation

There are several ways we can go about performing uncertainty quantification on
the differential localisation probability. Several functions are available in
the `bandle` package, namely, the `binomDiffLoc` function which allows users to
sample credible intervals from a binomial distribution, or the
`bootstrapdiffLocprob` which uses a non-parametric bootstrap on the Monte-Carlo
samples.

### 9.1.1 The `bootstrapdiffLocprob` function

We can examine the top `n` proteins (here we use an example of `top = 100`) and
produce bootstrap estimates of the uncertainty (note here the uncertainty is
likely to be underestimated as we did not produce many MCMC samples). These can
be visualised as ranked boxplots.

```
set.seed(1)
boot_t <- bootstrapdiffLocprob(params = bandleres, top = 100,
                               Bootsample = 5000, decreasing = TRUE)

boxplot(t(boot_t), col = getStockcol()[5],
        las = 2, ylab = "Probability", ylim = c(0, 1),
        main = "Differential localisation \nprobability plot (top 100 proteins)")
```

![](data:image/png;base64...)

### 9.1.2 The `binomDiffLoc` function

Instead of applying the `bootstrapdiffLocprob` we could use the `binomDiffLoc`
function to obtain credible intervals from the binomial distribution.

```
bin_t <- binomialDiffLocProb(params = bandleres, top = 100,
                             nsample = 5000, decreasing = TRUE)

boxplot(t(bin_t), col = getStockcol()[5],
        las = 2, ylab = "Probability", ylim = c(0, 1),
        main = "Differential localisation \nprobability plot (top 100 proteins)")
```

![](data:image/png;base64...)

### 9.1.3 Obtaining probability estimates

There are many ways we could obtain probability estimates from either of the
above methods. We could, for example, take the mean of each protein estimate, or
compute the cumulative error (there is not really a false discovery rate in
Bayesian statistics) or we could threshold on the interval to reduce the number
of differential localisations if you feel the model has been overconfident.

```
# more robust estimate of probabilities
dprobs <- rowMeans(bin_t)

# compute cumulative error, there is not really a false discovery rate in
# Bayesian statistics but you can look at the cumulative error rate
ce <- cumsum(1  - dprobs)

# you could threshold on the interval and this will reduce the number of
# differential localisations
qt <- apply(bin_t, 1, function(x) quantile(x, .025))
```

## 9.2 The expected false discovery rate

Instead of estimating the false discovery rate we can estimate the expected
false discovery rate from the posterior probabilities at a particular
threshold. This mean that for fixed threshold, we compute the expected proportion
of false discoveries. Here is an example below. We can see that setting
a probability threshold of 0.95 leads to an expected false discovery rate of
less than \(0.5\%\)

```
EFDR(dl, threshold = 0.95)
```

```
## [1] 0.00245614
```

(We remind users that this data is a simulated and uses very few iterations and
chains).

# 10 Description of `bandle` parameters

The `bandle` function has a significant number of parameters to allow flexible
and bespoke analysis. Here, we describe these parameters in more detail to
allow user to make decisions on the level of flexibility they wish to exploit.

1. `objectCond1`. This is a list of `MSnSets` containing the first condition.
2. `objectCond2`. This is a list of `MSnSets` containing the second condition.

   1. These object should have the same observations and features. These will
      be checked during bandle analysis.
3. `fcol` indicates the feature column in the `MSnSets` that indicated the
   markers. Proteins that are not markers should be labels `unknown`. The default
   is `markers`.
4. `hyperLearn` is the algorithm used to learn the hyperparameters of the
   Gaussian processes. For speed the default is an optimization algorithm called
   “LBFGS”, however is users want to perform uncertainty quantification on these
   parameters we can use Markov-chain Monte Carlo (MCMC) methods. This is implemented
   using the Metropolis-Hastings algorithm. Though this latter methodology provides
   more information, it is much more costly. The analysis is expected to take
   several days rather than hours.
5. `numIter` is the number of MCMC iterations for the algorithm. We typically
   suggest around 10,000 iterations is plenty for convergence. Though some cases
   may take longer. If resources are constrained, we suggest 4,000 iterations
   as acceptable. A minimum number of iterations is around 1,000 though at this
   level we expect the posterior estimates to suffer considerably. If possible
   more parallel chains should be run in this case by changing `numChains` to,
   say, 9. The more chains and iterations the more computationally expensive
   the algorithm. The time taken for the algorithm scales roughly linearly
   in the number of iterations
6. `burnin` is the number of samples that should be discarded from the
   beginning of the chain due to the bias induced by the starting point of the
   algorithm. We suggest sensible `burnin` values to be roughly \(10-50\%\) of the
   number of iterations
7. `thin` reduces auto-correlation in the MCMC samples. The default is \(5\),
   which means every 5th sample is taken. If memory requirements are an issue,
   we suggest to increase the thinning amount. Though above \(20\), you will see
   a decrease in performance.
8. `u` and `v` represent the prior hyperparameters of the proportion of outliers.
   This is modelled using a `Beta(u,v)` with `u = 2` and `v = 10` a default. This
   suggest that roughly \(\frac{u}{u = V} = 16%\) of proteins are believed to be
   outliers and that it is quite unlikely that more than \(50%\) of proteins
   are outliers. Users can examine the quantiles of the `Beta(u,v)` distribution
   if they wish to place a more bespoke prior. For example, increasing `u`
   will increase the number of a prior believed outliers.
9. `lambda` is a ridge parameter used for numerical stability and is set to
   \(0.01\). If you experience the algorithm fails due to numerical issue then you
   can set this value larger. If you require values above \(1\) it is likely that
   there are other issues with the analysis. We suggest checking the method
   is appropriate for your problem and opening issue detailing the problems.
10. `gpParams` results from fitting Gaussian proccess (Gaussian random fields).
    We refer the users to those functions. The default is `NULL` which will fit
    GPs internally but we recommend setting these outside the bandle function
    because it leads to more stable results.
11. `hyperIter` if the hyperparameters of the GP are learnt using MH algorithm
    then this is the frequency at which these are updated relative to the bandle
    algorithm. By default this is unused, but if `hyperLearn` is set to `MH` then
    this proceed at every 20 iterations.
12. `hyperMean` is the mean of the log normal prior used on the hyperparameters.
    Though by default this is not used unless `PC` is set to false
13. `hyperSd` is the standard deviation of the log normal prior used on the
    hyperparameters. The default is `c(1,1,1)` for the 3 hyperparameters, increasing
    these values increases the uncertainty in the prior values of the hyperparameters.
14. `seed` is the random-number seed.
15. `pg` indicates whether or not to use the Polya-Gamma (PG) prior. The default
    is false and a Dirichlet prior is used instead. If set to true the `pg` is used.
    In which case a default PG prior is used. This prior attempts to match the
    default Dirichlet prior that is used when PG prior is set to false. The PG
    prior is more computationally expensive but can provide prior information on
    correlations
16. `pgPrior` is by default NULL. We suggest using the `pg_prior` function
    to help set this parameter and the documentation therein. This function
    uses an empirical approach to compute a sensible default.
17. `tau` is a parameter used by the Polya-Gamma prior and we refer to
    BANDLE manuscript for details. By default it is only used if `pg` prior is true,
    when the default becomes `0.2`. At this value the `pg` prior is similar to the
    Dirichlet prior but with information on correlations.
18. `dirPrior` is the Dirichlet matrix prior on the correlations. This should
    be provided as a K by K matrix, where K is the number of subcellular niches.
    The diagonal component should represent the prior belief that organelles do
    not re-localise (same compartment), where as the off-diagonal terms represent
    the prior terms of re-localisation. The `prior_pred_dir` can be used to provide
    a prior predictive check based on the provided prior. It is recommended
    that the off-diagonal terms are at least two orders of magnitude smaller than the
    diagonal terms. An example is given in the vignette.
19. `maternCov` is this true the covariance function is the matern covariance,
    otherwise a Gaussian covariance is used.
20. `PC` indicates whether a penalised complexity (PC) is used. The default
    is true and otherwise log normal priors are used.
21. `pcPrior` is a numeric of length 3 indicating the parameters of the PC prior.
    The prior is placed on the parameters of length-scale, amplitude, and variance
    in that order. The default values are \(0.5,3,100\), and increasing the value
    increases the shrinkage towards straight-lines with zero variance.
22. `nu` which defaults to 2 is the smoothness of the matern covariance. By
    increasing `nu` you encourage smoother solutions. `nu` should be an integer,
    though for values of `nu` above 3, we have observed numerical instability.
23. `propSd` is the standard deviation of the random-walk update used in the MH
    algorithm. We do not recommend changing this unless you are familiar with
    Bayesian analysis. The default is `c(0.3,0.1,0.05)` for the 3 hyperparameters.
    Changing these will alter the efficiency of the underlying samplers.
24. `numChains` is the number of parrallel chains and defaults to 4. We recommend
    using as much processing resources as you have and frequently have used 9 in
    practise.
25. `BPPARAM` is the BiocParallel back-end which defaults to
    `BiocParallel::bpparam()`. We refer you to the *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)*
    package for details on setting this dependent on your computing system.

# 11 Session information

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

Crook, Oliver M., Claire M. Mulvey, Paul D. W. Kirk, Kathryn S. Lilley, and Laurent Gatto. 2018. “A Bayesian Mixture Modelling Approach for Spatial Proteomics.” Edited by Christine Vogel. *PLOS Computational Biology* 14 (11): e1006516. <https://doi.org/10.1371/journal.pcbi.1006516>.

Gatto, Laurent, Lisa M. Breckels, Samuel Wieczorek, Thomas Burger, and Kathryn S. Lilley. 2014. “Mass-Spectrometry Based Spatial Proteomics Data Analysis Using pRoloc and pRolocdata.” *Bioinformatics*.

Gentleman, Robert C., Vincent J. Carey, Douglas M. Bates, Ben Bolstad, Marcel Dettling, Sandrine Dudoit, Byron Ellis, et al. 2004. “Bioconductor: Open Software Development for Computational Biology and Bioinformatics.” *Genome Biol* 5 (10): –80. <https://doi.org/10.1186/gb-2004-5-10-r80>.

Gilks, Walter R, Sylvia Richardson, and David Spiegelhalter. 1995. *Markov Chain Monte Carlo in Practice*. CRC press.

R Development Core Team. 2011. *R: A Language and Environment for Statistical Computing*. Vienna, Austria: R Foundation for Statistical Computing. <http://www.R-project.org/>.

Tan, Denise JL, Heidi Dvinge, Andrew Christoforou, Paul Bertone, Alfonso Martinez Arias, and Kathryn S Lilley. 2009. “Mapping Organelle Proteins and Protein Complexes in Drosophila Melanogaster.” *Journal of Proteome Research* 8 (6): 2667–78.