# Manual for the RCM pacakage

* [1 Introduction](#introduction)
* [2 Publication](#publication)
* [3 Installation](#installation)
* [4 Analysis](#analysis)
  + [4.1 Dataset](#dataset)
  + [4.2 Unconstrained RCM](#unconstrained-rcm)
    - [4.2.1 Fitting the unconstrained RCM](#fitting-the-unconstrained-rcm)
    - [4.2.2 Plotting the uconstrained RCM](#plotting-the-uconstrained-rcm)
    - [4.2.3 Assessing the goodness of fit](#assessing-the-goodness-of-fit)
    - [4.2.4 Testing significance of clusters using PERMANOVA](#testing-significance-of-clusters-using-permanova)
  + [4.3 Constrained RCM](#constrained-rcm)
    - [4.3.1 Fitting the constrained RCM model](#fitting-the-constrained-rcm-model)
    - [4.3.2 Plotting the constrained RCM model](#plotting-the-constrained-rcm-model)
    - [4.3.3 Assessing the goodness of fit](#assessing-the-goodness-of-fit-1)
    - [4.3.4 Identifying influential observations](#identifying-influential-observations)
  + [4.4 Importance of dimensions](#importance-of-dimensions)
    - [4.4.1 Importance parameters](#importance-parameters)
    - [4.4.2 Log-likelihoods](#log-likelihoods)
    - [4.4.3 Inertia](#inertia)
  + [4.5 Advanced plotting](#advanced-plotting)
    - [4.5.1 Extracting coodinates](#extracting-coodinates)
    - [4.5.2 Non-squared plots](#non-squared-plots)
* [5 FAQ](#faq)
  + [5.1 Why are not all my samples shown in the constrained ordination?](#why-are-not-all-my-samples-shown-in-the-constrained-ordination)
* [6 Session info](#session-info)

# 1 Introduction

The RCM package combines unconstrained and constrained ordination of microbiome read count data into a single package. The package functions allow fitting of the ordination model, plotting it and performing diagnostic checks.

# 2 Publication

The underlying method of the RCM package is described in detail in the following article: [“A unified framework for unconstrained and constrained ordination of microbiome read count data”](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0205474).

# 3 Installation

The package can be installed and loaded using the following commands:

```
library(BiocManager)
install("RCM", update = FALSE)
```

```
suppressPackageStartupMessages(library(RCM))
cat("RCM package version", as.character(packageVersion("RCM")), "\n")
```

```
## RCM package version 1.26.0
```

# 4 Analysis

## 4.1 Dataset

As example data we use a study on the microbiome of colorectal cancer patients “Potential of fecal microbiota for early-stage detection of colorectal cancer” (2014) by Zeller *et al.*.

```
data(Zeller)
library(phyloseq)
```

## 4.2 Unconstrained RCM

### 4.2.1 Fitting the unconstrained RCM

The unconstrained RC(M) method represents all variability present in the data, regardless of covariate information. It should be used as a first step in an exploratory analysis. The *RCM* function is the front end function for this purpose, behind it is the *RCM\_NB* function that does the hard work but requires numeric matrix imputs. We first fit a model with two dimensions,

```
ZellerRCM2 = RCM(Zeller, k = 2, round = TRUE)
```

which took 1.6 minutes. Here we supplied a phyloseq object to the RCM function which is preferable. Alternatively one can also provide a count matrix with samples in the rows and taxa in the columns, but then all plotting variables should be supplied manually as vectors.

#### 4.2.1.1 Adding dimensions

By default, only 2 dimensions are fitted, but more can be requested throught the *k* argument.

```
ZellerRCM3 = RCM(Zeller, k = 3, round = TRUE)
```

The total runtime for all dimensions combined was 4.4 minutes.

#### 4.2.1.2 Conditioning

In order to condition on certain variables, supply their names to the *confounders* argument. Here we condition on the *country* variable

```
ZellerRCM2cond = RCM(Zeller, k = 2, round = TRUE, confounders = c("Country"))
```

Conditioning can be applied for unconstrained as well as constrained RCM, the ensuing plots have exactly the same interpretation as before, only now the variability due to the confounding variable has been filtered out.

### 4.2.2 Plotting the uconstrained RCM

#### 4.2.2.1 Monoplots

To plot only samples or taxa, specify the *plotType* argument in the generic *plot* function.

```
plot(ZellerRCM2, plotType = "samples")
```

![](data:image/png;base64...)

No clear signal is present at first sight. Note also that the plot is rectangular according to the values of the importance parameters \(\psi\). In order to truthfully represent the distances between samples all axis must be on the same scale. We can add a colour code for the cancer diagnosis contained in the phyloseq object.

```
plot(ZellerRCM2, plotType = "samples", samColour = "Diagnosis")
```

![](data:image/png;base64...)

It is clear that some of the variability of the samples is explained by the cancer status of the patients.

We can also add a richness measure as a colur, see ?phyloseq::estimate\_richness for a list of available richness measures. Here we plot the Shannon diversity

```
plot(ZellerRCM2, plotType = "samples", samColour = "Shannon")
```

![](data:image/png;base64...)

In order to plot only the species, modify the *plotType* argument.

```
plot(ZellerRCM2, plotType = "species")
```

![](data:image/png;base64...)

The researchers found that species from the Fusobacteria genus are associated with cancer. We can plot only these species using a regular expression.

```
plot(ZellerRCM2, plotType = "species", taxRegExp = "Fusobacter", taxLabels = TRUE)
```

![](data:image/png;base64...)

It is clear that these Fusobacterium species behave very differently between the species. We can also colour the species plots by phylogenetic level, e.g. order level, if available in the dataset.

```
plot(ZellerRCM2, plotType = "species", taxLabels = TRUE, taxCol = "Order")
```

![](data:image/png;base64...)

#### 4.2.2.2 Biplots

Finally we can combine both plots into an interpretable biplot, which is the default for unconstrained RC(M). To avoid overplotting we only show the taxa with the 10 most important departures from independence.

```
plot(ZellerRCM2, taxNum = 10, samColour = "Diagnosis")
```

![](data:image/png;base64...)

Samples are represented by dots, taxa by arrows. Both represent vectors with the origin as starting point.

Valid interpretatations are the following:

* Samples (endpoints of sample vectors, the red dots) close together depart from independence in a similar way
* The orthogonal projection of the taxon arrows on the sample arrows are proportional to the departure from independence of that taxon in that sample on the log scale, in the first two dimensions. For example Fusobacterium mortiferum is more abundant than average in samples on the left side of the plot, and more abundant in samples on the right side.
* The importance parameters \(\psi\) shown for every axis reflect the relative importance of the dimensions

Distances between endpoints of taxon vectors are meaningless.

##### 4.2.2.2.1 Adding projections

We can also graphically highlight the departure from independence for a particular taxon and sample using the *addOrthProjection* function:

```
tmpPlot = plot(ZellerRCM2, taxNum = 10, samColour = "Diagnosis", returnCoords = TRUE)
addOrthProjection(tmpPlot, species = "Alloprevotella tannerae", sample = c(-1.2,
    1.5))
```

![](data:image/png;base64...)

The projection of the species vector is graphically shown here, the orange bar representing the extent of the departure from independence. Note that we providid the exact taxon name, and approximate sample coordinates visually derived from the graph, but any combination of both is possible.

We can then plot any combination of two dimensions we want, e.g. the first and the third.

```
plot(ZellerRCM3, Dim = c(1, 3), samColour = "Diagnosis", taxNum = 6)
```

![](data:image/png;base64...)

The third dimension also correlates with a separation of cancer patients vs.  healthy and small adenoma patients.

### 4.2.3 Assessing the goodness of fit

Some taxa (or samples) may not follow a negative binomial distribution, or their departures from independence may not be appropriately represented in low dimensions. We visualize these taxa and samples through their deviances, which are the squared sums of their deviance residuals. This allows us to graphically identify taxa and samples that are poorly represented in the current ordination.

The deviances per sample can be plotted by just supplying the argument “Deviance” to *samColour*

```
plot(ZellerRCM2, plotType = "samples", samColour = "Deviance", samSize = 2.5)
```

![](data:image/png;base64...)

Samples with the largest scores exhibit the poorest fit. This may indicate that samples with strong departures from independence acquire large scores, but still are not well represented in lower dimensions. Especially the one bottom right may be a problematic case.

The same principle can be applied to the taxa

```
plot(ZellerRCM3, plotType = "species", taxCol = "Deviance", samSize = 2.5, Dim = c(1,
    2), arrowSize = 0.5)
```

![](data:image/png;base64...)

For the taxa it appears to be the taxa with smaller scores are the more poorly fitted ones. Note that since the count table is not square, we cannot compare sample and taxon deviances. They have not been calculated based on the same number of taxa. Also, one cannot do chi-squared tests based on the deviances since this is not a classical regression model, but an overparametrized one.

### 4.2.4 Testing significance of clusters using PERMANOVA

One may want to test whether the samples in an unconstrained ordination cluster according to some predefined grouping factor. Since the model is overparametrized, classical statistical tests are invalid. Instead, PERMANOVA is a permutation-based analysis that looks for significant clustering of samples based on distances alone. The only assumption underlying it is exchangeability of the samples, meaning that under the null hypothesis of identical microbiome composition in all groups, the samples are randomly distributed across the ordination. A natural test statistic to detect clusters based on a multidimensional ordination is the pseudo F-statistic. The distribution of this test statistic under the null hypothesis is then emulated by permuting the grouping labels, and recalculating within-group distances and associated pseudo F-statistics for every permutation instances. This is done conditional on the ordination result, so without refitting the RC(M) model. The *permanova* function accepts variables present in the phyloseq object as groups, or user supplied grouping factors.

```
permanovaZeller = permanova(ZellerRCM2, "Diagnosis")
```

```
## Permutation 1 out of 10000
## Permutation 1001 out of 10000
## Permutation 2001 out of 10000
## Permutation 3001 out of 10000
## Permutation 4001 out of 10000
## Permutation 5001 out of 10000
## Permutation 6001 out of 10000
## Permutation 7001 out of 10000
## Permutation 8001 out of 10000
## Permutation 9001 out of 10000
```

```
permanovaZeller
```

```
## $statistic
## [1] 0.0009619337
##
## $p.value
## [1] 0
```

We see that the PERMANOVA analysis for diagnosis is significant with p-value 0, because of the shift of the cancer samples to the left compared to the other two groups. Next we also test for significance of gender:

```
permanovaZellerGender = permanova(ZellerRCM2, "Gender", verbose = FALSE)
```

As expected, this test is not significant (p-value=0.977). Note that this test is not designed for clusters identified *based on* the ordination, and is not recommended for testing a subset of grouping variables identified after looking at the ordination plots.

This PERMANOVA analysis was not run in the original paper, but is a later addition.

## 4.3 Constrained RCM

In this second step we look for the variability in the dataset explained by linear combinations of covariates that maximally separate the niches of the species. This should be done in a second step, and preferably only with variables that are believed to have an impact on the species’ abundances. Here we used the variables age, gender, BMI, country and diagnosis in the gradient. In this analysis all covariates values of a sample are projected onto a single scalar, the environmental score of this sample. The projection vector is called the environmental gradient, the magnitude of its components reveals the importance of each variable. The taxon-wise response functions then describe how the logged mean abundance depends on the environmental score.

### 4.3.1 Fitting the constrained RCM model

In order to request a constrained RCM fit it suffises to supply the names of the constraining variables to the *covariates* argument. The shape of the response function can be either “linear”, “quadratic” or “nonparametric” and must be provided to the *responseFun* argument. Here we illustrate the use of linear and nonparametric response functions. Linear response functions may be too simplistic, they have the advantage of being easy to interpret (and plot). Non-parametric ones (based on splines) are more flexible but are harder to plot.

```
# Linear
ZellerRCM2constr = RCM(Zeller, k = 2, round = TRUE, covariates = c("Age", "Gender",
    "BMI", "Country", "Diagnosis"), responseFun = "linear")
# Nonparametric
ZellerRCM2constrNonParam = RCM(Zeller, round = TRUE, k = 2, covariates = c("Age",
    "Gender", "BMI", "Country", "Diagnosis"), responseFun = "nonparametric")
```

### 4.3.2 Plotting the constrained RCM model

#### 4.3.2.1 Monoplots

As before we can make monoplots of only samples or taxa. Starting with the samples

```
plot(ZellerRCM2constr, plotType = c("samples"))
```

![](data:image/png;base64...)

we clearly see three groups of samples appearing.

```
plot(ZellerRCM2constr, plotType = c("samples"), samColour = "Diagnosis", samShape = "Country")
```

![](data:image/png;base64...)

One group are the healthy patients, the other two are cancer patients. The cancer patients are separated by country. Note that from Germany there are only cancer patients in this dataset. In case of non-parametric response functions, the samples mononoplot is not interpretable.

Unique to the constrained ordinations are monoplots of the variables. Do note however, that the axes have not been scaled, and trends on the x-and y-axis should be interpreted independently.

```
plot(ZellerRCM2constr, plotType = "variables")
```

![](data:image/png;base64...)

Variables far away from the origin have a strong role in shaping the environmental gradient.

```
plot(ZellerRCM2constrNonParam, plotType = "variables")
```

![](data:image/png;base64...)

The environmental gradients are quite different from the case with the linear response functions. Especially age is an important driver of the environmental gradient here. Still the results for cancer diagnosis, country and gender are similar to before.

#### 4.3.2.2 Biplots

In the constrained case two different biplots are meaningful: sample-taxon biplots and variable-taxon biplots.

##### 4.3.2.2.1 Sample-taxon biplot

```
plot(ZellerRCM2constr, plotType = c("species", "samples"))
```

![](data:image/png;base64...)

The interpretation is similar as before: the orthogonal projection of a taxon’s arrow on a sample represents the departure from independence for that taxon in that sample, *explained by environmental variables*. New is also that the taxa arrows do not start from the origin, but all have their own starting point. This starting point represents the environmental scores for which there is no departure from independence. The direction of the arrow then represents in which direction of the environmental gradient its expected abundance increases. Again we can show this projection visually:

```
tmpPlot2 = plot(ZellerRCM2constr, plotType = c("species", "samples"), returnCoords = TRUE)
addOrthProjection(tmpPlot2, species = "Pseudomonas fluorescens", sample = c(-12,
    7))
```

![](data:image/png;base64...)

Note that the projection bar does not start from the origin in this case either.

##### 4.3.2.2.2 Variable-taxon biplot

```
plot(ZellerRCM2constr, plotType = c("species", "variables"))
```

![](data:image/png;base64...)

The projection of species arrows on environmental variables (starting from the origin) represents the sensitivity of this taxon to changes in this variables. Note that the fact that the arrows of BMI and gender are of similar length indicates that one *standard deviation* in BMI has a similar effect to gender.

Also this interpretation we can show visually on the graph

```
tmpPlot3 = plot(ZellerRCM2constr, plotType = c("species", "variables"), returnCoords = TRUE)
addOrthProjection(tmpPlot3, species = "Pseudomonas fluorescens", variable = "DiagnosisSmall_adenoma")
```

![](data:image/png;base64...)

We observe that country and diagnosis are the main drivers of the environmental gradient. We also see that the healthy status has a very similar to the small adenoma status, but that they are very different from cancer patients.

#### 4.3.2.3 Triplot

Triplots combine all the three components in a single plot. This is the default behaviour of the *plot* function.

```
plot(ZellerRCM2constr)
```

![](data:image/png;base64...)

Note that the samples and the environmental variables cannot be related to each other, but the sample-taxon and variable-taxon relationships discussed before are still valid on the triplot.

For the non-parametric response functions we can only plot one dimensional triplots, whereby the shape of the response functions of the most strongly reacting taxa is shown. For this we use the *plotRespFun* function.

```
plotRespFun(ZellerRCM2constrNonParam, taxa = NULL, subdivisions = 50L, yLocVar = c(-30,
    -50, -75, -62.5, -30, -62.5, -70, -50, -30) * 0.225, Palette = "Set1", angle = 90,
    yLocSam = -20, axisTitleSize = 16, axisLabSize = 11, legendTitleSize = 18, legendLabSize = 12,
    samShape = "Diagnosis", labSize = 5)
```

![](data:image/png;base64...)

The first dimension is shown by default, the environmental scores of the samples are shown below as dots, the y-axis shows the response functions of the 8 most reacting species, whereby the x-axis represents the independence model.

Let us have a look at how *Fusobacterium* species react to this gradient, as the authors found them to be more abundant in cancer patients .

```
FusoSpecies = grep("Fusobacterium", value = TRUE, taxa_names(ZellerRCM2constrNonParam$physeq))
plotRespFun(ZellerRCM2constrNonParam, Dim = 1, taxa = FusoSpecies, samShape = "Diagnosis")
```

![](data:image/png;base64...)

### 4.3.3 Assessing the goodness of fit

Also for constrained ordination it can be interesting to use the deviance residuals. We can use them in the unconstrained case by summing over taxa or samples, or plot them versus the environmental gradient to detect lack of fit for the shape of the response function. For this latter goal we provide two procedures: a diagnostic plot of the taxa with the strongest response to the environmental gradient, or an automatic trend detection using the runs test statistic by Ward and Wolfowitz. Checking the linearity (or Gaussian) assumption of the response function is crucial: excessive departure invalidate the interpretation of the ordination plot.

A deviance residual plot for the strongest responders, made with the *residualPlot* function, specified through the *numTaxa* argument

```
residualPlot(ZellerRCM2constr, whichTaxa = "response", numTaxa = 6)
```

![](data:image/png;base64...)

The same taxa but with Pearson residuals

```
residualPlot(ZellerRCM2constr, whichTaxa = "response", resid = "Pearson", numTaxa = 6)
```

![](data:image/png;base64...)

Most species do not exhibit any obvious pattern, although departures seem to increase with environmental scores.

The runs test is a test that automatically attempts to detect non randomness in the sequence of positive and negative residuals. We plot the residual plots for the taxa with the largest run statistic (since the sample sizes and null distributions are equal this corresponds with the smallest p-values, but we do not do inference here because of the non-classical framework).

```
residualPlot(ZellerRCM2constr, whichTaxa = "runs", resid = "Deviance", numTaxa = 6)
```

![](data:image/png;base64...)

For these 6 taxa we see no signal at all.

### 4.3.4 Identifying influential observations

It can also be interesting to identify samples have the strongest influence on the environmental gradient. For this aim we can colour the samples by influence by providing the “inflVar” argument:

```
plot(ZellerRCM2constr, plotType = c("variables", "samples"), inflVar = "Age")
```

![](data:image/png;base64...)

Below we see a couple of very influential observations. They may be very young?

```
plot(ZellerRCM2constr, plotType = c("variables", "samples"), samColour = "Age")
```

![](data:image/png;base64...)

Indeed, a few young subjects affect the estimation of the age parameter most. One should always be wary of these kind of influential observations that strongly affect the ordination. The age coefficient is largest in the second dimension actually, let’s look at the influence on that component

```
plot(ZellerRCM2constr, plotType = c("variables", "samples"), inflVar = "Age", Influence = TRUE,
    inflDim = 2)
```

![](data:image/png;base64...)

When looking at categorical variable, one looks at one dummy at the time:

```
plot(ZellerRCM2constr, plotType = c("variables", "samples"), inflVar = "DiagnosisNormal",
    samShape = "Diagnosis")
```

![](data:image/png;base64...)

In the unconstrained case, the “psi” variables seems a logical, overall choice

```
plot(ZellerRCM2, plotType = "samples", samSize = 2.5, inflVar = "psi")
```

![](data:image/png;base64...)

although it is also possible in the constrained case:

```
plot(ZellerRCM2constr, plotType = "samples", samSize = 2.5, inflVar = "psi")
```

![](data:image/png;base64...)

## 4.4 Importance of dimensions

There are many quantities that reflect the (relative) importance of the different dimensions.

### 4.4.1 Importance parameters

The simplest axis labels are simply the importance parameters \(\psi\_m\) from the RC(M)-model. They directly reflect the impact on the mean counts in the respective dimension, as the factors to which they are multplied are normalized. Hence the \(\psi\_m\)’s are the only components that can grow in size to add more weight to a dimension.

On the other hand, the sample scores *have* already been scaled with respect to these parameters, and they do not add addtional information to the plot itself. Also, their order is often but not necessarily strictly decreasing. Only the ratios of the different \(\psi\_m\)’s are direclty interpretable. Still plotting the \(\psi\_m\)’s is the default option of the *RCM* package.

```
plot(ZellerRCM2cond, plotPsi = "psi")
```

![](data:image/png;base64...)

### 4.4.2 Log-likelihoods

Another way to quantify the importance of the dimensions is to compare their differences in log-likelihoods of model m (\(ll\_m\)) with respect to the saturated model (“deviances”). The log-likelihood saturared model (\(ll\_{sat}\)) is calculated using the Poisson density, setting mean and variance equal to the observed counts. These differences in log-likelihood are then normalized with respect to the difference in loglikelihood between the independence model (\(ll\_{independence}\)) and the saturated model. The terms obtained for dimension \(m\) is then:

\[\frac{ll\_{m}-ll^\*}{ll\_{sat}-ll\_{independence}}\]

, with \(ll^\*\) the log-likelihood of the lower dimension, which can be the independence model, the model after filtering on confounders or simply the lower dimension of the RC(M) model.

This approach has the advantages of also providing a measure of importance for the confounders. Also it uses the saturated model as a reference and thus provides a fraction of “total variability”.

Disadvantages are the difficulty in intepreting log-likelihoods, and the fact that in some corner case the log-likelihood drops with higher dimensions. This is because the estimation of the dispersions and environmental gradients is not full maximum likelihood.

```
plot(ZellerRCM2cond, plotPsi = "loglik")
```

![](data:image/png;base64...)

### 4.4.3 Inertia

As with correspondence analysis, the fraction of total inertia explained by the different dimensions can be plotted on the axes. The inertia is defined as the sum of squared Pearson residuals, or

\[\sum\_{i=1}^n\sum\_{j=1}^p \frac{(x\_{ij}-e\_{ijm})^2}{e\_{ijm}}\]

with \(x\_{ij}\) the observed count and \(e\_{ijm}\) the expected count under the model with \(m\) dimensions. The inertia has the advantage that also the variance explained by the filtering on confouders step can be plotted, and that there is a measure of residual variance.

On the other hand, as we argue in the manuscript, the inertia is not a good measure of variability for overdispersed data, as it implicitly assumes the mean to equal the variance. Hence this criterion of dimension importance should be interpreted with caution.

```
plot(ZellerRCM2cond, plotPsi = "inertia")
```

![](data:image/png;base64...)

## 4.5 Advanced plotting

### 4.5.1 Extracting coodinates

First of all it is important to note that the plotting coordinates can easily be extracted. This may be useful when making plots with third party software.

```
zellerCoords = extractCoord(ZellerRCM2)
str(zellerCoords)
```

```
## List of 3
##  $ samples  :'data.frame':   194 obs. of  2 variables:
##   ..$ Dim1: num [1:194] -0.035 -0.3993 0.6971 0.0788 0.6246 ...
##   ..$ Dim2: num [1:194] 0.4183 -0.6225 0.0705 -0.2835 0.1709 ...
##  $ species  :'data.frame':   347 obs. of  4 variables:
##   ..$ end1   : num [1:347] -0.508 -0.947 -0.866 0.363 0.903 ...
##   ..$ end2   : num [1:347] -1.466 -0.764 -0.907 0.289 0.515 ...
##   ..$ origin1: num [1:347] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ origin2: num [1:347] 0 0 0 0 0 0 0 0 0 0 ...
##  $ variables: NULL
```

Also, this can be used to obtain a list of taxa contributing to the separation of the samples, sorted from most to least important.

```
taxaSignals = rowSums(zellerCoords$species[, c("end1", "end2")]^2)
sortedTaxa = taxa_names(ZellerRCM2$physeq)[order(taxaSignals, decreasing = TRUE)]
sortedTaxa[1:10]
```

```
##  [1] "Lactobacillus reuteri"        "Fusobacterium gonidiaformans"
##  [3] "Lactobacillus crispatus"      "Fusobacterium mortiferum"
##  [5] "Lactobacillus johnsonii"      "Escherichia fergusonii"
##  [7] "Lactococcus garvieae"         "Lactobacillus acidophilus"
##  [9] "Pediococcus acidilactici"     "Streptococcus agalactiae"
```

These most important taxa are the ones that are plotted by default by the \(plot.RCM()\) function.

### 4.5.2 Non-squared plots

The \(RCM\) package provides the option to make plots with non squared axis. This may lead to better proportioned plots, but as it also misrepresents the ordination **WE DO NOT ADVOCATE NON-SQUARED PLOTS**!

```
plot(ZellerRCM2, axesFixed = FALSE)
```

![](data:image/png;base64...)

# 5 FAQ

## 5.1 Why are not all my samples shown in the constrained ordination?

Confusion often arises as to why less distinct sample dots are shown than there are samples in the constrained ordination. This occurs when few, categorical constraining variables are supplied as below.

```
# Linear with only 2 variables
ZellerRCM3constr = RCM(Zeller, k = 2, round = TRUE, covariates = c("Gender", "Diagnosis"),
    responseFun = "linear")
```

Every constrained sample score is a linear combination of constraining variables, and in this case there are only 3x2=6 distinct sample scores possible, leading to the sample dots from microbiomes from the same gender and diagnosis to be plotted on top of each other.

```
plot(ZellerRCM3constr, plotType = "samples", samColour = "Diagnosis", samShape = "Country")
```

![](data:image/png;base64...)

In general, it is best to include all measured sample variables in a constrained analysis, and let the RCM-algorithm find out which ones are the most important drivers of variability.

# 6 Session info

This vignette was generated with following version of R:

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] phyloseq_1.54.0 RCM_1.26.0
##
## loaded via a namespace (and not attached):
##  [1] ade4_1.7-23         tidyselect_1.2.1    dplyr_1.1.4
##  [4] farver_2.1.2        Biostrings_2.78.0   S7_0.2.0
##  [7] fastmap_1.2.0       digest_0.6.37       lifecycle_1.0.4
## [10] cluster_2.1.8.1     survival_3.8-3      magrittr_2.0.4
## [13] compiler_4.5.1      rlang_1.1.6         sass_0.4.10
## [16] tools_4.5.1         igraph_2.2.1        yaml_2.3.10
## [19] data.table_1.17.8   knitr_1.50          labeling_0.4.3
## [22] curl_7.0.0          alabama_2023.1.0    plyr_1.8.9
## [25] TTR_0.24.4          RColorBrewer_1.1-3  nleqslv_3.3.5
## [28] withr_3.0.2         numDeriv_2016.8-1.1 BiocGenerics_0.56.0
## [31] grid_4.5.1          stats4_4.5.1        xts_0.14.1
## [34] multtest_2.66.0     biomformat_1.38.0   Rhdf5lib_1.32.0
## [37] ggplot2_4.0.0       scales_1.4.0        iterators_1.0.14
## [40] MASS_7.3-65         dichromat_2.0-0.1   cli_3.6.5
## [43] rmarkdown_2.30      vegan_2.7-2         crayon_1.5.3
## [46] generics_0.1.4      reshape2_1.4.4      ape_5.8-1
## [49] cachem_1.1.0        rhdf5_2.54.0        stringr_1.5.2
## [52] splines_4.5.1       parallel_4.5.1      formatR_1.14
## [55] XVector_0.50.0      vctrs_0.6.5         Matrix_1.7-4
## [58] jsonlite_2.0.0      VGAM_1.1-13         IRanges_2.44.0
## [61] tseries_0.10-58     S4Vectors_0.48.0    tensor_1.5.1
## [64] foreach_1.5.2       jquerylib_0.1.4     quantmod_0.4.28
## [67] glue_1.8.0          codetools_0.2-20    stringi_1.8.7
## [70] gtable_0.3.6        quadprog_1.5-8      tibble_3.3.0
## [73] pillar_1.11.1       htmltools_0.5.8.1   Seqinfo_1.0.0
## [76] rhdf5filters_1.22.0 R6_2.6.1            evaluate_1.0.5
## [79] lattice_0.22-7      Biobase_2.70.0      bslib_0.9.0
## [82] Rcpp_1.1.0          nlme_3.1-168        permute_0.9-8
## [85] mgcv_1.9-3          xfun_0.53           zoo_1.8-14
## [88] pkgconfig_2.0.3
```