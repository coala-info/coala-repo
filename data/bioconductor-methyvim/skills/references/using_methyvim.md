# Targeted Data-Adaptive Estimation and Inference for Differential Methylation Analysis

Nima Hejazi

#### *2018-10-30*

#### Abstract

We present a general algorithm for the nonparametric estimation of effects of
DNA methylation at CpG sites scattered across the genome, complete with honest
statistical inference for such estimates. This approach leverages variable
importance measures, a class of parameters that arise in the study of causal
inference. The parameters we present are defined in such a manner that they
provide targeted estimates of the relative importance of CpG sites in the
case of binary exposures/treatments assigned at the level of subjects. Such
parameters come equipped with rich scientific interpretations, providing an
avenue to move beyond linear models, applying modern developments in machine
learning to estimating quantities of scientific interest in computational
biology.

# Contents

* [0.1 Introduction](#introduction)
* [0.2 Methodology](#methodology)
* [0.3 Parameters of Interest](#parameters-of-interest)
* [0.4 Preliminaries: Setting up the Data](#preliminaries-setting-up-the-data)
* [0.5 Differential Methylation Based on a Binary Treatment or Exposure](#differential-methylation-based-on-a-binary-treatment-or-exposure)
  + [0.5.1 The Average Treatment Effect as Variable Importance Measure](#the-average-treatment-effect-as-variable-importance-measure)
  + [0.5.2 The Risk Ratio as Variable Importance Measure](#the-risk-ratio-as-variable-importance-measure)
* [0.6 Data Analysis with `methyvim`](#data-analysis-with-methyvim)
  + [0.6.1 Visualization of Results](#visualization-of-results)
* [0.7 Session Information](#session-information)
* [References](#references)

## 0.1 Introduction

DNA methylation is a fundamental epigenetic process known to play an important
role in the regulation of gene expression. DNA CpG methylation involves the
addition of a methyl group (\(\text{CH}\_3\)) to the fifth carbon of the cytosine
ring structure to form 5-methylcytosine. Numerous biological and medical studies
have implicated DNA CpG methylation as playing a role in disease and
development (Robertson 2005). Perhaps unsurprisingly then, biotechnologies
have been developed to study the molecular mechanisms of this epigenetic
process. Modern assays, like the Illumina *Infinium* Methylation assay,
allow for quantitative interrogation of DNA methylation of CpG sites scattered
across the genome at single-nucleotide resolution; moreover, much effort
has been invested, by the bioinformatics community, in the development of
tools for properly removing technological effects that may contaminate
biological signatures measured by such assays. Despite these advances in both
biological and bioninformatical techniques, most statistical methods available
for the analysis of data produced by such assays rely on over-simplified (often
generalized linear) models.

Here, we present an alternative to such statistical analysis approaches, in the
form of nonparametric estimation procedures inspired by machine learning and
causal inference. Specifically, we provide a technique for obtaining estimates
of nonparametric *variable importance measures* (**VIM**), parameters with rich
scientific interpretations under the standard (untestable) assumptions used in
statistical causal inference, defining a limited set of VIMs specifically with
respect to the type of data commonly produced by DNA methylation assays.
For VIMs defined in such a manner, targeted minimum loss-based estimates may be
readily computed based on the data made available by DNA methylation assays.
Our contribution, `methyvim` is an R package that provides facilities for
performing differential methylation analyses within exactly this scope.

As the substantive contribution of our work is an estimation procedure, we focus
on data produced by 450k and 850k (EPIC) arrays made by Illumina and assume that
data has been subjected to proper quality control and normalizaton procedures,
as outlined by others in the computational biology community
(Fortin et al. 2014, Dedeurwaerder et al. (2013)). For a general
discussion of the framework of targeted minimum loss-based estimation and the
role this approach plays in statistical causal inference, the interested reader
is invited to consult van der Laan and Rose (2011) and van der Laan and Rose (2018). For a more general
introduction to statistical causal inference, Pearl (2009) serves well.

---

## 0.2 Methodology

The core functionality of this package is made available via the eponymous
`methyvim` function, which implements a statistical algorithm designed to
compute targeted estimates of VIMs, defined in such a way that the VIMs
represent parameters of scientific interest in computational biology
experiments; moreover, these VIMs are defined such that they may be estimated in
a manner that is very nearly assumption-free, that is, within a *fully
nonparametric statistical model*. **The statistical algorithm consists in
several major steps:**

1. Pre-screening of genomic sites is used to isolate a subset of sites for
   which there is cursory evidence of differential methylation. For the sake of
   computational feasibility, targeted minimum loss-based estimates of VIMs are
   computed only for this subset of sites. Currently, the available screening
   approach adapts core routines from the
   [`limma`](http://bioconductor.org/packages/limma) R package. Future releases
   will support functionality from other packages (e.g.,
   [`randomForest`](https://CRAN.R-project.org/package%3DrandomForest),
   [`tmle.npvi`](https://CRAN.R-project.org/package%3Dtmle.npvi)). Following the
   style of the function for performing screening via `limma`, users may write
   their own screening functions and are invited to contribute such functions to
   the core software package by opening pull requests at the GitHub repository.
2. Nonparametric estimates of VIMs, for the specified target parameter, are
   computed at each of the CpG sites passing the screening step. The VIMs are
   defined in such a way that the estimated effects is of an exposure/treatment
   on the methylation status of a target CpG site, controlling for the observed
   methylation status of the neighbors of that site. Currently, routines are
   adapted from the [`tmle`](https://CRAN.R-project.org/package%3Dtmle) R package.
   Future releases will support doubly-robust estimates of these VIMs (via the
   [`drtmle`](https://CRAN.R-project.org/package%3Ddrtmle) package) and add
   parameters for continuous treatments/exposures (via the
   [`tmle.npvi`](https://CRAN.R-project.org/package%3Dtmle.npvi) package).
3. Since pre-screening is performed prior to estimating VIMs, we make use of a
   multiple testing correction uniquely suited to such settings. Due to the
   multiple testing nature of the estimation problem, a variant of the Benjamini
   & Hochberg procedure for controlling the False Discovery Rate (FDR) is
   applied (Benjamini and Hochberg 1995). Specifically, we apply the “modified
   marginal Benjamini & Hochberg step-up False Discovery Rate controlling
   procedure for multi-stage analyses” (FDR-MSA), which is guaranteed to
   control the FDR as if all sites were tested (i.e., without screening)
   (Tuglus and van der Laan 2009).

---

## 0.3 Parameters of Interest

For discrete-valued treatments or exposures:

* The *average treatment effect* (ATE): The effect of a binary exposure or
  treatment on the observed methylation at a target CpG site is estimated,
  controlling for the observed methylation at all other CpG sites in the same
  neighborhood as the target site, based on an additive form. In particular, the
  parameter estimate represents the **additive difference** in methylation that
  would have been observed at the target site had all observations received the
  treatment versus the counterfactual under which none received the treatment.
* The *relative risk* (RR): The effect of a binary exposure or treatment on the
  observed methylation at a target CpG site is estimated, controlling for the
  observed methylation at all other CpG sites in the same neighborhood as the
  target site, based on a geometric form. In particular, the parameter estimate
  represents the **multiplicative difference** in methylation that would have
  been observed at the target site had all observations received the treatment
  versus the counterfactual under which none received the treatment.

Support for continuous-valued treatments or exposures is *planned but not yet
available*, though work is underway to incorporate into our methodology the
following

* A *nonparametric variable importance measure* (NPVI) (Chambaz, Neuvial, and van der Laan 2012):
  The effect of continuous-valued exposure or treatment (the observed
  methylation at a target CpG site) on an outcome of interest is estimated,
  controlling for the observed methylation at all other CpG sites in the same
  neighborhood as the target (treatment) site, based on a parameter that
  compares values of the treatment against a reference value taken to be the
  null. In particular, the implementation provided is designed to assess the
  effect of differential methylation at the target CpG site on a (typically)
  phenotype-level outcome of interest (e.g., survival), in effect providing an
  nonparametric evaluation of the impact of methylation at the target site on
  said outcome.

*As previously noted, in all cases, an estimator of the target parameter is
constructed via targeted minimum loss-based estimation.*

Having now discussed the foundational principles of the estimation procedure
employed and the statistical algorithm implemented, it is best to proceed by
examining `methyvim` by example.

---

## 0.4 Preliminaries: Setting up the Data

First, we’ll load the `methyvim` package and the example data contained in the
`methyvimData` package that accompanies it:

```
library(methyvim)
```

```
## methyvim v1.4.0: Targeted, Robust, and Model-free Differential Methylation Analysis
```

```
library(methyvimData)
```

Now, let’s load the data set and seed the RNG:

```
set.seed(479253)
data(grsExample)
grsExample
```

```
## class: GenomicRatioSet
## dim: 400 210
## metadata(0):
## assays(2): Beta M
## rownames(400): cg23578515 cg06747907 ... cg01715842 cg09895959
## rowData names(0):
## colnames(210): V2 V3 ... V397 V398
## colData names(2): exp outcome
## Annotation
##   array: IlluminaHumanMethylationEPIC
## Preprocessing
##   Method: NA
##   minfi version: NA
##   Manifest version: NA
```

```
var_int <- as.numeric(colData(grsExample)[, 1])
table(var_int)
```

```
## var_int
##   0   1
## 105 105
```

The example data object is of class `GenomicRatioSet`, provided by the `minfi`
package. The summary provided by the `print` method gives a wealth of
information on the experiment that generated the data – since we are working
with a simulated data set, we need not concern ourselves with much of this
information.

We can create an object of class `methytmle` from any `GenomicRatioSet` object
simply invoking the S4 class constructor:

```
mtmle <- .methytmle(grsExample)
```

Since the `methytmle` class builds upon the `GenomicRatioSet` class, it contains
all of the slots of `GenomicRatioSet`. The new class introduced in the
`methyvim` package includes several new slots:

* `call` - the form of the original call to the `methyvim` function.
* `screen_ind` - indices identifying CpG sites that pass the screening process.
* `clusters` - non-unique IDs corresponding to the manner in wich sites are
  treated as neighbors. These are assigned by genomic distance (bp) and respect
  chromosome boundaries (produced via a call to `bumphunter::clusterMaker`).
* `var_int` - the treatment/exposure status for each subject. Currently, these
  must be binary, due to the definition of the supported targeted parameters.
* `param` - the name of the target parameter from which the estimated VIMs are
  defined.
* `vim` - a table of statistical results obtained from estimating VIMs for each
  of the CpG sites that pass the screening procedure.
* `ic` - the measured array values for each of the CpG sites passing the
  screening, transformed into influence curve space based on the chosen target
  parameter.

The interested analyst might consider consulting the documentation of the
`minfi` package for an in-depth description of all of the other slots that
appear in this class (Aryee et al. 2014). Having examined the core structure of
the package, it is time now to discuss the analytic capabilities implemented.

---

## 0.5 Differential Methylation Based on a Binary Treatment or Exposure

### 0.5.1 The Average Treatment Effect as Variable Importance Measure

The average treatment effect (ATE) is a canonical parameter that arises in
statistical causal inference, often denoted \(\psi\_0 = \psi\_0(1) - \psi\_0(0)\),
representing the difference in an outcome between the counterfactuals under
which all subjects received the treatment/exposure and under which none received
such treatment/exposure. Under additional (untestable) assumptions, this
parameter has a richer interpretation as a mean counterfactual outcome, wherein
the counterfactuals used in this definition define causal effects. When causal
assumptions remain unfulfilled or untested, this parameter may still be
estimated in the form of a nonparametric VIM.

Estimating such the VIM corresponding to such a parameter requires two separate
regression steps: one for the treatment mechanism (propensity score) and one for
the outcome regression. Technical details on the nature of these regressions are
discussed in Hernan and Robins (2018, forthcoming), and details for estimating these regressions in
the framework of targeted minimum loss-based estimation are discussed in
van der Laan and Rose (2011).

#### 0.5.1.1 Super Learning for nonparametric parameter estimation

Nonparametric and data-adaptive regressions (i.e., machine learning) may be used
in the two regression steps outlined above. This is implemented using the super
learner algorithm, which produces optimal combinations of such regression
functions (a variant of stacked regressions) using cross-validation
(van der Laan, Polley, and Hubbard 2007, Breiman (1996), Wolpert (1992)).

`methyvim` makes performing such estimation for CpG sites using a given VIM
essentially trivial:

```
suppressMessages(
  methyvim_ate_sl <- methyvim(data_grs = grsExample, sites_comp = 25,
                              var_int = var_int, vim = "ate", type = "Mval",
                              filter = "limma", filter_cutoff = 0.10,
                              parallel = FALSE, tmle_type = "sl"
                             )
)
```

```
## Warning in set_parallel(parallel = parallel, future_param = future_param, : Sequential evaluation is strongly discouraged.
##  Proceed with caution.
```

As is clear from examining the object `methyvim_ate_sl`, the output resembles
exactly that returned when examining objects of class `GenomicRatioSet` from the
`minfi` R package. In particular, the returned `methytmle` object is merely a
modified form (in particular, a subclass) of the input `GenomicRatioSet` object
– thus, it contains all of the original slots, with all of the experimental
data intact. Several extra pieces of information are contained within the output
object as well\_.

We can take a look at the results produced from the estimation procedure (stored
in the `vim` `slot` of the `methytmle` object) simply by invoking the custom S4
accessor function `vim` (note that the `show` method of the resultant object
also displays this same information, amongst other things):

```
vim(methyvim_ate_sl)
```

```
##                lwr_ci      est_ate       upr_ci     var_ate         pval
## cg22913481 -0.3790600 -0.102050802  0.174958388 0.019974514 4.702524e-01
## cg15131207 -0.3121142 -0.104168904  0.103776420 0.011256054 3.261739e-01
## cg10613282 -0.4272500 -0.163156791  0.100936380 0.018155249 2.259382e-01
## cg15857610 -0.3081995 -0.077723671  0.152752142 0.013827338 5.086293e-01
## cg24775884 -0.4712986  0.035341861  0.541982301 0.066817091 8.912487e-01
## cg22954484 -0.3294027  0.076574124  0.482550976 0.042903271 7.116140e-01
## cg23076894 -0.6253973 -0.055111119  0.515175074 0.084659085 8.497716e-01
## cg07697276 -0.4611105 -0.125247124  0.210616236 0.029363858 4.648369e-01
## cg01674119 -0.3403720 -0.137437512  0.065496970 0.010720118 1.843727e-01
## cg02749733 -0.3890318 -0.179951471  0.029128901 0.011379270 9.161596e-02
## cg12742764 -1.0690474 -0.569045499 -0.069043564 0.065077555 2.570434e-02
## cg15396367 -1.0294253 -0.475933539  0.077558175 0.079746220 9.192020e-02
## cg18233010 -0.9797684 -0.498173254 -0.016578081 0.060374300 4.261441e-02
## cg01532849 -0.7949280 -0.361927027  0.071073959 0.048805147 1.013632e-01
## cg24268444 -0.9281752 -0.477179070 -0.026182968 0.052946034 3.809887e-02
## cg10560245 -0.7075712 -0.333216292  0.041138625 0.036480009 8.105250e-02
## cg20185936 -0.8658523 -0.433535810 -0.001219316 0.048650966 4.935315e-02
## cg06714180 -0.5331987 -0.356545044 -0.179891391 0.008123311 7.623965e-05
## cg15817960 -0.1934982 -0.008499774  0.176498621 0.008908894 9.282455e-01
## cg15611151 -0.3421095 -0.130544326  0.081020869 0.011651351 2.265093e-01
## cg00567703 -0.3581702 -0.151566456  0.055037273 0.011111282 1.504696e-01
## cg01609275 -0.3128125 -0.117347712  0.078117085 0.009945462 2.393192e-01
## cg00058576 -0.3097275  0.108216157  0.526159804 0.045469828 6.118086e-01
## cg26992600 -0.4319234 -0.060939665  0.310044025 0.035825931 7.474833e-01
## cg12172984 -0.2606551  0.153970593  0.568596298 0.044750748 4.667098e-01
##            n_neighbors n_neighbors_control max_cor_neighbors
## cg22913481           0                   0                NA
## cg15131207           0                   0                NA
## cg10613282           0                   0                NA
## cg15857610           5                   4        0.77207047
## cg24775884           5                   2        0.88975664
## cg22954484           5                   2        0.86439358
## cg23076894           5                   1        0.88975664
## cg07697276           5                   2        0.84238389
## cg01674119           5                   5        0.61874408
## cg02749733           0                   0                NA
## cg12742764           8                   2        0.90569752
## cg15396367           8                   2        0.90569752
## cg18233010           8                   2        0.88601655
## cg01532849           8                   2        0.89423768
## cg24268444           8                   2        0.89690199
## cg10560245           8                   2        0.86644061
## cg20185936           8                   2        0.87376499
## cg06714180           8                   8       -0.09301902
## cg15817960           8                   8        0.40419875
## cg15611151           7                   7        0.13851867
## cg00567703           7                   7        0.13851867
## cg01609275           7                   7        0.20795189
## cg00058576           7                   4        0.88568207
## cg26992600           7                   4        0.85605741
## cg12172984           7                   4        0.87356095
```

From the table displayed, we note that we have access to point estimates of the
ATE (“est\_ate”) as well as lower and upper confidence interval bounds for each
estimate (“lwr\_ci” and “upr\_ci”, respectively). Additional statistical
information we have access to include the variance (“var\_ate”) of the estimate
as well as the p-value (“pval”) associated with each point estimate (based on
Wald-style testing procedures). Beyond these, key bioinformatical quantities,
with respect to the algorithm outlined above, are also returned; these include
the total number of neighbors of the target site (“n\_neighbors”), the number of
neighboring sites controlled for when estimating the effect of exposure on DNA
methylation (“n\_neighbors\_control”), and, the maximum correlation between the
target site and any given site in its full set of neighbors
(“max\_cor\_neighbors”).

#### 0.5.1.2 Generalized linear models for parameter estimation

In cases where nonparametric regressions may not be preferred (e.g., where time
constraints are of concern), generalized linear models (GLMs) may be used to fit
the two regression steps required for estimating VIMs for the ATE.

`methyvim` makes performing such estimation for CpG sites using a given VIM
essentially trivial:

```
suppressMessages(
  methyvim_ate_glm <- methyvim(data_grs = grsExample, sites_comp = 25,
                               var_int = var_int, vim = "ate", type = "Mval",
                               filter = "limma", filter_cutoff = 0.10,
                               parallel = FALSE, tmle_type = "glm"
                              )
)
```

```
## Warning in set_parallel(parallel = parallel, future_param = future_param, : Sequential evaluation is strongly discouraged.
##  Proceed with caution.
```

Just as before, we can take a look at the results produced from the estimation
procedure (stored in the `vim` `slot` of the `methytmle` object) simply by
invoking the custom S4 accessor function `vim` (note that the `show` method of
the resultant object also displays this same information, amongst other things):

```
vim(methyvim_ate_glm)
```

```
##                lwr_ci      est_ate       upr_ci     var_ate         pval
## cg22913481 -0.3790600 -0.102050802  0.174958388 0.019974514 4.702524e-01
## cg15131207 -0.3121142 -0.104168904  0.103776420 0.011256054 3.261739e-01
## cg10613282 -0.4272500 -0.163156791  0.100936380 0.018155249 2.259382e-01
## cg15857610 -0.3541861 -0.078688231  0.196809668 0.019757157 5.756030e-01
## cg24775884 -0.4144441  0.107379272  0.629202623 0.070881822 6.867106e-01
## cg22954484 -0.2827173  0.136268270  0.555253815 0.045696816 5.238264e-01
## cg23076894 -0.6269660 -0.056254365  0.514457291 0.084785452 8.468064e-01
## cg07697276 -0.4208625 -0.073033345  0.274795854 0.031493428 6.806772e-01
## cg01674119 -0.3363838 -0.118685187  0.099013381 0.012336700 2.852701e-01
## cg02749733 -0.3890318 -0.179951471  0.029128901 0.011379270 9.161596e-02
## cg12742764 -1.0591258 -0.556294357 -0.053462906 0.065816188 3.012869e-02
## cg15396367 -1.0129034 -0.451488856  0.109925708 0.082045583 1.149729e-01
## cg18233010 -0.9799338 -0.486185873  0.007562009 0.063459749 5.360912e-02
## cg01532849 -0.8005220 -0.353647735  0.093226576 0.051982677 1.208762e-01
## cg24268444 -0.9216143 -0.478308651 -0.035003029 0.051155736 3.445042e-02
## cg10560245 -0.7024726 -0.315264225  0.071944196 0.039028103 1.105273e-01
## cg20185936 -0.8652697 -0.423854358  0.017560943 0.050720395 5.983265e-02
## cg06714180 -0.5321808 -0.355612453 -0.179044136 0.008115465 7.897716e-05
## cg15817960 -0.2149655 -0.024191659  0.166582186 0.009473829 8.037137e-01
## cg15611151 -0.3480774 -0.130958674  0.086160037 0.012271068 2.371241e-01
## cg00567703 -0.3626823 -0.155651985  0.051378363 0.011157217 1.405920e-01
## cg01609275 -0.3108800 -0.118362334  0.074155326 0.009647816 2.281905e-01
## cg00058576 -0.4428739  0.004898647  0.452671151 0.052191851 9.828927e-01
## cg26992600 -0.5452319 -0.145856546  0.253518852 0.041519343 4.741057e-01
## cg12172984 -0.4147385  0.050479518  0.515697569 0.056337941 8.315811e-01
##            n_neighbors n_neighbors_control max_cor_neighbors
## cg22913481           0                   0                NA
## cg15131207           0                   0                NA
## cg10613282           0                   0                NA
## cg15857610           5                   4        0.77207047
## cg24775884           5                   2        0.88975664
## cg22954484           5                   2        0.86439358
## cg23076894           5                   1        0.88975664
## cg07697276           5                   2        0.84238389
## cg01674119           5                   5        0.61874408
## cg02749733           0                   0                NA
## cg12742764           8                   2        0.90569752
## cg15396367           8                   2        0.90569752
## cg18233010           8                   2        0.88601655
## cg01532849           8                   2        0.89423768
## cg24268444           8                   2        0.89690199
## cg10560245           8                   2        0.86644061
## cg20185936           8                   2        0.87376499
## cg06714180           8                   8       -0.09301902
## cg15817960           8                   8        0.40419875
## cg15611151           7                   7        0.13851867
## cg00567703           7                   7        0.13851867
## cg01609275           7                   7        0.20795189
## cg00058576           7                   4        0.88568207
## cg26992600           7                   4        0.85605741
## cg12172984           7                   4        0.87356095
```

*Remark:* Here, the estimates are obtained via GLMs, making each of the
regression steps less robust than if nonparametric regressions were used. It is
expected that these estimates differ from those obtained previously.

---

### 0.5.2 The Risk Ratio as Variable Importance Measure

The risk ratio (RR) is another popular parameter that arises in statistical
causal inference, denoted \(\psi\_0 = \frac{\psi\_0(1)}{\psi\_0(0)}\), representing
the multiplicative contrast of an outcome between the counterfactuals under
which all subjects received the treatment/exposure and under which none received
such treatment/exposure. Under additional (untestable) assumptions, this
parameter has a richer interpretation as a mean counterfactual outcome, wherein
the counterfactuals used in this definition define causal effects. When causal
assumptions remain unfulfilled or untested, this parameter may still be
estimated in the form of a nonparametric VIM.

Just as before (in the case of the ATE), there are two regression steps required
for estimating VIMs based on this parameter. We do so in a manner analogous to
that described previously.

#### 0.5.2.1 Super Learning for nonparametric parameter estimation

Nonparametric and data-adaptive regressions (i.e., machine learning) may be used
in the two regression steps required for estimating a VIM based on the RR. This
is implemented using the Super Learner algorithm.

`methyvim` makes performing such estimation for CpG sites using a given VIM
essentially trivial:

```
methyvim_rr_sl <- methyvim(data_grs = grsExample, sites_comp = 25,
                            var_int = var_int, vim = "rr", type = "Mval",
                            filter = "limma", filter_cutoff = 0.10,
                            parallel = FALSE, tmle_type = "sl"
                           )
```

```
## Warning in set_parallel(parallel = parallel, future_param = future_param, : Sequential evaluation is strongly discouraged.
##  Proceed with caution.
```

Just as before, we can take a look at the results produced from the estimation
procedure (stored in the `vim` `slot` of the `methytmle` object) simply by
invoking the custom S4 accessor function `vim` (note that the `show` method of
the resultant object also displays this same information, amongst other things):

```
vim(methyvim_rr_sl)
```

```
##                 lwr_ci    est_logrr       upr_ci   var_logrr         pval
## cg22913481 -0.15978435 -0.042980967  0.073822421 0.003551393 4.707649e-01
## cg15131207 -0.10832796 -0.036151215  0.036025531 0.001356071 3.262445e-01
## cg10613282 -0.18349779 -0.069866731  0.043764333 0.003361104 2.281579e-01
## cg15857610 -0.07072078 -0.018851353  0.033018075 0.000700343 4.762545e-01
## cg24775884 -0.07964599  0.005904915  0.091455817 0.001905184 8.923876e-01
## cg22954484 -0.06687059  0.015440680  0.097751946 0.001763626 7.131161e-01
## cg23076894 -0.08915380 -0.007928282  0.073297232 0.001717405 8.482810e-01
## cg07697276 -0.09792191 -0.025334810  0.047252295 0.001371535 4.939173e-01
## cg01674119 -0.07253463 -0.029016095  0.014502439 0.000492988 1.912687e-01
## cg02749733 -0.15979514 -0.073782061  0.012231016 0.001925825 9.270679e-02
## cg12742764 -0.18033556 -0.096778868 -0.013222174 0.001817399 2.319823e-02
## cg15396367 -0.16335135 -0.076191969  0.010967407 0.001977498 8.664449e-02
## cg18233010 -0.16970937 -0.086432545 -0.003155720 0.001805245 4.192409e-02
## cg01532849 -0.15258453 -0.066350967  0.019882594 0.001935711 1.315317e-01
## cg24268444 -0.17580066 -0.092796769 -0.009792882 0.001793431 2.843423e-02
## cg10560245 -0.17018707 -0.081609215  0.006968642 0.002042388 7.094929e-02
## cg20185936 -0.17672175 -0.088877395 -0.001033044 0.002008702 4.736190e-02
## cg06714180 -0.26283676 -0.175415223 -0.087993683 0.001989412 8.395248e-05
## cg15817960 -0.08338329 -0.007252719  0.068877855 0.001508711 8.518778e-01
## cg15611151 -0.18232822 -0.065633093  0.051062029 0.003544812 2.703021e-01
## cg00567703 -0.19017322 -0.081207194  0.027758836 0.003090794 1.440992e-01
## cg01609275 -0.15164582 -0.059325414  0.032994990 0.002218622 2.078488e-01
## cg00058576 -0.05479188  0.020569200  0.095930280 0.001478366 5.926732e-01
## cg26992600 -0.09111919 -0.018843102  0.053432984 0.001359807 6.093569e-01
## cg12172984 -0.04119094  0.035575704  0.112342351 0.001534027 3.637112e-01
##            n_neighbors n_neighbors_control max_cor_neighbors
## cg22913481           0                   0                NA
## cg15131207           0                   0                NA
## cg10613282           0                   0                NA
## cg15857610           5                   4        0.77207047
## cg24775884           5                   2        0.88975664
## cg22954484           5                   2        0.86439358
## cg23076894           5                   1        0.88975664
## cg07697276           5                   2        0.84238389
## cg01674119           5                   5        0.61874408
## cg02749733           0                   0                NA
## cg12742764           8                   2        0.90569752
## cg15396367           8                   2        0.90569752
## cg18233010           8                   2        0.88601655
## cg01532849           8                   2        0.89423768
## cg24268444           8                   2        0.89690199
## cg10560245           8                   2        0.86644061
## cg20185936           8                   2        0.87376499
## cg06714180           8                   8       -0.09301902
## cg15817960           8                   8        0.40419875
## cg15611151           7                   7        0.13851867
## cg00567703           7                   7        0.13851867
## cg01609275           7                   7        0.20795189
## cg00058576           7                   4        0.88568207
## cg26992600           7                   4        0.85605741
## cg12172984           7                   4        0.87356095
```

#### 0.5.2.2 Generalized linear models for parameter estimation

In cases where nonparametric regressions may not be preferred (e.g., where time
constraints are of concern), generalized linear models (GLMs) may be used to fit
the two regression steps required for estimating a VIMs for the ATE.

`methyvim` makes performing such estimation for CpG sites using a given VIM
essentially trivial:

```
methyvim_rr_glm <- methyvim(data_grs = grsExample, sites_comp = 25,
                            var_int = var_int, vim = "rr", type = "Mval",
                            filter = "limma", filter_cutoff = 0.10,
                            parallel = FALSE, tmle_type = "glm"
                           )
```

```
## Warning in set_parallel(parallel = parallel, future_param = future_param, : Sequential evaluation is strongly discouraged.
##  Proceed with caution.
```

Just as before, we can take a look at the results produced from the estimation
procedure (stored in the `vim` `slot` of the `methytmle` object) simply by
invoking the custom S4 accessor function `vim` (note that the `show` method of
the resultant object also displays this same information, amongst other things):

```
vim(methyvim_rr_glm)
```

```
##                 lwr_ci     est_logrr        upr_ci    var_logrr         pval
## cg22913481 -0.15978435 -0.0429809669  0.0738224210 0.0035513930 4.707649e-01
## cg15131207 -0.10832796 -0.0361512145  0.0360255312 0.0013560711 3.262445e-01
## cg10613282 -0.18349779 -0.0698667309  0.0437643326 0.0033611044 2.281579e-01
## cg15857610 -0.07911751 -0.0177593357  0.0435988406 0.0009800150 5.705125e-01
## cg24775884 -0.06870763  0.0199990005  0.1087056340 0.0020483306 6.585732e-01
## cg22954484 -0.05578040  0.0290331283  0.1138466604 0.0018724842 5.022577e-01
## cg23076894 -0.08907714 -0.0083968710  0.0722833986 0.0016944257 8.383623e-01
## cg07697276 -0.08978452 -0.0153038315  0.0591768594 0.0014440268 6.871478e-01
## cg01674119 -0.07169845 -0.0249806747  0.0217371020 0.0005681358 2.946199e-01
## cg02749733 -0.15979514 -0.0737820611  0.0122310157 0.0019258250 9.270679e-02
## cg12742764 -0.17836617 -0.0924638601 -0.0065615550 0.0019208679 3.488313e-02
## cg15396367 -0.16007739 -0.0708724035  0.0183325871 0.0020714104 1.194233e-01
## cg18233010 -0.16880181 -0.0841624468  0.0004769165 0.0018648016 5.130068e-02
## cg01532849 -0.15214619 -0.0666736430  0.0187988997 0.0019016961 1.262853e-01
## cg24268444 -0.17745640 -0.0911978399 -0.0049392839 0.0019368332 3.824378e-02
## cg10560245 -0.16929336 -0.0750400566  0.0192132488 0.0023124962 1.186512e-01
## cg20185936 -0.17370190 -0.0853986827  0.0029045344 0.0020297423 5.802219e-02
## cg06714180 -0.26532832 -0.1781895028 -0.0910506832 0.0019765655 6.123799e-05
## cg15817960 -0.08321845 -0.0074833915  0.0682516622 0.0014930754 8.464359e-01
## cg15611151 -0.19533075 -0.0736757551  0.0479792414 0.0038525453 2.352276e-01
## cg00567703 -0.19433204 -0.0841513234  0.0260293977 0.0031600873 1.344026e-01
## cg01609275 -0.14940014 -0.0569154420  0.0355692543 0.0022265252 2.277436e-01
## cg00058576 -0.08013384  0.0006234314  0.0813806986 0.0016976614 9.879278e-01
## cg26992600 -0.10562036 -0.0290683178  0.0474837264 0.0015254622 4.567249e-01
## cg12172984 -0.07449088  0.0095809190  0.0936527146 0.0018398758 8.232523e-01
##            n_neighbors n_neighbors_control max_cor_neighbors
## cg22913481           0                   0                NA
## cg15131207           0                   0                NA
## cg10613282           0                   0                NA
## cg15857610           5                   4        0.77207047
## cg24775884           5                   2        0.88975664
## cg22954484           5                   2        0.86439358
## cg23076894           5                   1        0.88975664
## cg07697276           5                   2        0.84238389
## cg01674119           5                   5        0.61874408
## cg02749733           0                   0                NA
## cg12742764           8                   2        0.90569752
## cg15396367           8                   2        0.90569752
## cg18233010           8                   2        0.88601655
## cg01532849           8                   2        0.89423768
## cg24268444           8                   2        0.89690199
## cg10560245           8                   2        0.86644061
## cg20185936           8                   2        0.87376499
## cg06714180           8                   8       -0.09301902
## cg15817960           8                   8        0.40419875
## cg15611151           7                   7        0.13851867
## cg00567703           7                   7        0.13851867
## cg01609275           7                   7        0.20795189
## cg00058576           7                   4        0.88568207
## cg26992600           7                   4        0.85605741
## cg12172984           7                   4        0.87356095
```

*Remark:* Here, the estimates are obtained via GLMs, making each of the
regression steps less robust than if nonparametric regressions were used. It is
expected that these estimates differ from those obtained previously.

---

## 0.6 Data Analysis with `methyvim`

In order to explore practical applications of the `methyvim` package, as well as
the full set of utilities it provides, our toy example (of just \(10\) CpG sites)
is unfortunately insufficient. To proceed, we will use a publicly available
example data set produced by the Illumina 450K array, from the `minfiData` R
package. Now, let’s load the package and data set, and take a look

```
suppressMessages(library(minfiData))
data(MsetEx)
mset <- mapToGenome(MsetEx)
grs <- ratioConvert(mset)
grs
```

```
## class: GenomicRatioSet
## dim: 485512 6
## metadata(0):
## assays(2): Beta CN
## rownames(485512): cg13869341 cg14008030 ... cg08265308 cg14273923
## rowData names(0):
## colnames(6): 5723646052_R02C02 5723646052_R04C01 ...
##   5723646053_R05C02 5723646053_R06C02
## colData names(13): Sample_Name Sample_Well ... Basename filenames
## Annotation
##   array: IlluminaHumanMethylation450k
##   annotation: ilmn12.hg19
## Preprocessing
##   Method: Raw (no normalization or bg correction)
##   minfi version: 1.21.2
##   Manifest version: 0.4.0
```

After loading the data, which comes in the form of a raw `MethylSet` object, we
perform some further processing by mapping to the genome (with `mapToGenome`)
and converting the values from the methylated and unmethylated channels to
Beta-values (via `ratioConvert`). These two steps together produce an object of
class `GenomicRatioSet`, like what we had worked with previously.

For this example analysis, we’ll treat the condition of the patients as the
exposure/treatment variable of interest. The `methyvim` function requires that
this variable either be `numeric` or easily coercible to `numeric`. To
facilitate this, we’ll simply convert the covariate (currently a `character`):

```
var_int <- (as.numeric(as.factor(colData(grs)$status)) - 1)
table(var_int)
```

```
## var_int
## 0 1
## 3 3
```

**n.b.**, the re-coding process results in “normal” patients being assigned a
value of 1 and cancer patients a 0.

Now, we are ready to analyze the effects of cancer status on DNA methylation
using this data set. To do this with a targeted minimum loss-based estimate of
the Average Treatment Effect, we may proceed as follows:

```
suppressMessages(
  methyvim_cancer_ate <- methyvim(data_grs = grs, var_int = var_int,
                                  vim = "ate", type = "Beta", filter = "limma",
                                  filter_cutoff = 0.20, obs_per_covar = 2,
                                  parallel = FALSE, sites_comp = 125,
                                  tmle_type = "glm"
                                 )
)
```

```
## Warning in set_parallel(parallel = parallel, future_param = future_param, : Sequential evaluation is strongly discouraged.
##  Proceed with caution.
```

Note that we set the `obs_per_covar` argument to a relatively low value (2,
where the recommended default is 20) for the purposes of this example as the
sample size is only 10. We do this only to exemplify the estimation procedure
and it is important to point out that such low values for `obs_per_covar` will
compromise the quality of inference obtained because this setting directly
affects the definition of the target parameter.

Further, note that here we apply the `glm` flavor of the `tmle_type` argument,
which produces faster results by fitting models for the propensity score and
outcome regressions using a limited number of parametric models. By contrast,
the `sl` (for “Super Learning”) flavor fits these two regressions using highly
nonparametric and data-adaptive procedures (i.e., via machine learning).

Let’s examine the table of results by examining the `methytmle` object that was
produced by our call to the `methyvim` wrapper function:

```
methyvim_cancer_ate
```

```
## class: methytmle
## dim: 485512 6
## metadata(0):
## assays(2): Beta CN
## rownames(485512): cg13869341 cg14008030 ... cg08265308 cg14273923
## rowData names(0):
## colnames(6): 5723646052_R02C02 5723646052_R04C01 ...
##   5723646053_R05C02 5723646053_R06C02
## colData names(13): Sample_Name Sample_Well ... Basename filenames
## Annotation
##   array: IlluminaHumanMethylation450k
##   annotation: ilmn12.hg19
## Preprocessing
##   Method: Raw (no normalization or bg correction)
##   minfi version: 1.21.2
##   Manifest version: 0.4.0
## Target Parameter: Average Treatment Effect
## Results:
##                   lwr_ci       est_ate        upr_ci      var_ate
## cg14008030 -1.195660e-01 -3.141596e-02  0.0567340489 2.022705e-03
## cg20253340 -8.850637e-02 -5.886614e-02 -0.0292259165 2.286919e-04
## cg21870274 -9.499057e-02 -2.911898e-02  0.0367526091 1.129495e-03
## cg17308840 -4.439729e-02 -6.326623e-03  0.0317440446 3.772844e-04
## cg00645010 -2.677328e-02 -1.346555e-02 -0.0001578256 4.609945e-05
## cg27534567  6.745648e-02  1.157119e-01  0.1639672225 6.061486e-04
## cg08258224  1.365045e-01  3.050885e-01  0.4736724770 7.398105e-03
## cg20275697 -3.021026e-01 -1.231300e-01  0.0558427144 8.337989e-03
## cg24373735 -4.283533e-02  7.666697e-03  0.0581687266 6.639043e-04
## cg12445832 -6.082411e-02  1.503956e-02  0.0909032203 1.498151e-03
## cg01097950 -4.392159e-02  6.583238e-02  0.1755863507 3.135656e-03
## cg01782097 -1.082072e-02  1.023290e-03  0.0128672954 3.651615e-05
## cg20825023 -7.234531e-02 -2.082353e-02  0.0306982409 6.909863e-04
## cg11851804  3.003538e-02  8.179842e-02  0.1335614630 6.974731e-04
## cg22226438 -7.042069e-02 -2.109141e-02  0.0282378620 6.334281e-04
## cg22699361  9.021931e-05  1.899397e-02  0.0378977123 9.302156e-05
## cg13176867 -3.063632e-02  1.146613e-02  0.0535685820 4.614266e-04
## cg11407801  1.750562e-02  7.148545e-02  0.1254652772 7.584918e-04
## cg02896266 -3.293606e-02 -5.293529e-04  0.0318773586 2.733744e-04
## cg23225454  3.075572e-02  4.654083e-02  0.0623259380 6.486090e-05
## cg00976181 -3.716156e-02 -2.399777e-02 -0.0108339863 4.510759e-05
## cg10711230 -7.052353e-02 -2.977613e-02  0.0109712700 4.322029e-04
## cg06624358 -1.723776e-03  2.678676e-02  0.0552972917 2.115917e-04
## cg22485363 -1.272149e-02  1.126387e-02  0.0352492284 1.497546e-04
## cg03269716 -5.925021e-02 -1.610646e-02  0.0270372891 4.845333e-04
## cg21830050  1.248703e-03  1.399132e-02  0.0267339373 4.226736e-05
## cg20453388 -1.013392e-01 -4.738860e-02  0.0065620090 7.576709e-04
## cg12663811  5.682932e-02  1.050502e-01  0.1532710178 6.052817e-04
## cg23207077 -1.220050e-01 -6.013531e-02  0.0017343926 9.964232e-04
## cg22381068 -2.562184e-02 -4.311566e-03  0.0169987034 1.182131e-04
## cg22481263 -4.349972e-03  1.052455e-02  0.0253990758 5.759357e-05
## cg07195057 -2.028669e-02  2.760543e-02  0.0754975481 5.970573e-04
## cg16352072 -3.229915e-02  1.325619e-02  0.0588115294 5.402148e-04
## cg18166741 -7.438801e-02 -3.182643e-02  0.0107351567 4.715453e-04
## cg22699004 -1.897471e-02 -3.071442e-03  0.0128318226 6.583554e-05
## cg22599150 -2.363882e-02  1.022573e-02  0.0440902801 2.985235e-04
## cg16349774 -2.108597e-02 -2.437309e-03  0.0162113571 9.052810e-05
## cg18439833 -7.206755e-03 -2.512309e-03  0.0021821378 5.736627e-06
## cg10201533 -1.160602e-02 -9.364598e-05  0.0114187311 3.449990e-05
## cg11235921 -7.061486e-03  2.418952e-03  0.0118993903 2.339616e-05
## cg26003967 -2.389433e-02  2.718633e-02  0.0782669813 6.792049e-04
## cg18977839 -3.255295e-02 -1.652075e-02 -0.0004885465 6.690739e-05
## cg25350899 -4.071724e-02  1.000589e-02  0.0607290284 6.697304e-04
## cg13219080 -1.571638e-01 -5.795819e-02  0.0412474416 2.561890e-03
## cg09364122 -1.135209e-01  2.239182e-02  0.1583045280 4.808482e-03
## cg17142931 -3.093822e-02 -1.854020e-02 -0.0061421837 4.001219e-05
## cg20064006 -1.232526e-02  1.072821e-02  0.0337816772 1.383440e-04
## cg17006413 -2.371768e-02 -3.261416e-03  0.0171948504 1.089283e-04
## cg21472517 -3.686919e-02 -1.559031e-02  0.0056885739 1.178652e-04
## cg18019572 -1.124763e-02 -8.468389e-03 -0.0056891497 2.010666e-06
## cg22673826 -1.902462e-02 -4.327885e-04  0.0181590443 8.997716e-05
## cg10625579 -1.369898e-02  9.749442e-04  0.0156488714 5.605064e-05
## cg01922485 -9.218835e-03  3.252457e-04  0.0098693264 2.371134e-05
## cg12763038 -4.097995e-02 -2.504388e-02 -0.0091078146 6.610741e-05
## cg24004483 -2.729151e-02 -1.679740e-02 -0.0063032954 2.866677e-05
## cg23281018 -4.953736e-02 -2.839798e-02 -0.0072585896 1.163249e-04
## cg25552017 -8.994374e-02  3.015588e-02  0.1502554936 3.754664e-03
## cg10984178 -2.525855e-02  2.568993e-03  0.0303965347 2.015754e-04
## cg26837773  1.966447e-02  1.049289e-01  0.1901933649 1.892447e-03
## cg18272461 -8.100315e-02 -3.744012e-02  0.0061229197 4.939968e-04
## cg02288964 -1.497629e-01  3.705728e-02  0.2238774289 9.085216e-03
## cg02341264 -2.677992e-02  6.471956e-02  0.1562190417 2.179341e-03
## cg06712559 -2.876953e-03  4.701613e-03  0.0122801799 1.495072e-05
## cg14663984 -7.959552e-02 -2.749652e-02  0.0246024806 7.065560e-04
## cg16318112  2.704654e-02  5.024431e-02  0.0734420733 1.400813e-04
## cg09248054 -1.280138e-02  1.046188e-01  0.2220388840 3.588996e-03
## cg15840462  1.800713e-02  6.453717e-02  0.1110671971 5.635787e-04
## cg25759916  1.389667e-01  2.839114e-01  0.4288561425 5.468809e-03
## cg08387293 -5.385090e-04  8.284873e-02  0.1662359773 1.810035e-03
## cg23801338 -1.879002e-02  4.336634e-02  0.1055227033 1.005678e-03
## cg13244315 -6.739108e-02  2.172938e-02  0.1108498301 2.067486e-03
## cg08480609  8.428031e-03  3.212333e-02  0.0558186210 1.461545e-04
## cg03120284 -1.954136e-03  6.157069e-02  0.1250955067 1.050448e-03
## cg22627753 -1.516261e-02  4.328232e-02  0.1017272487 8.891632e-04
## cg11405655  5.914546e-02  1.236616e-01  0.1881778055 1.083490e-03
## cg24475622 -6.208175e-03  1.249813e-01  0.2561707692 4.480081e-03
## cg26702212 -1.112004e-03  1.489429e-01  0.2989978829 5.861226e-03
## cg24517686 -1.007508e-01  6.521264e-02  0.2311760835 7.169894e-03
## cg14964771  2.582693e-02  1.042392e-01  0.1826514976 1.600501e-03
## cg11200797 -3.497005e-02  1.095205e-01  0.2540111056 5.434591e-03
## cg19999567  2.625519e-02  5.414643e-02  0.0820376670 2.024993e-04
## cg20961824 -7.794454e-02  1.950800e-01  0.4681044518 1.940399e-02
## cg10126324  4.633413e-02  1.511566e-01  0.2559791511 2.860204e-03
## cg06036677 -5.953444e-02  1.550205e-01  0.3695755194 1.198299e-02
## cg19626656 -7.676209e-02  1.033910e-02  0.0974402930 1.974859e-03
## cg10113217 -6.134220e-03  1.917915e-02  0.0444925235 1.667969e-04
## cg20619296 -1.447535e-01  9.308798e-03  0.1633711131 6.178466e-03
## cg18329352 -1.480740e-02  4.511615e-02  0.1050396945 9.347230e-04
## cg25973293  1.024177e-01  2.042465e-01  0.3060753463 2.699164e-03
## cg05655247  8.285487e-03  6.310267e-02  0.1179198526 7.822063e-04
## cg01776299  5.697140e-03  1.003091e-02  0.0143646728 4.888987e-06
## cg15688253 -1.682025e-02 -6.684404e-03  0.0034514384 2.674284e-05
## cg22864340 -9.446841e-02 -4.806492e-02 -0.0016614328 5.605174e-04
## cg22521151  2.563668e-02  8.060159e-02  0.1355664986 7.864279e-04
## cg00207921 -1.327917e-01 -1.479643e-02  0.1031988321 3.624240e-03
## cg20544808 -1.708357e-02  1.239178e-02  0.0418671327 2.261548e-04
## cg18792131 -1.418299e-02  3.083043e-02  0.0758438468 5.274385e-04
## cg21475076 -1.216235e-01 -9.596713e-03  0.1024301030 3.266870e-03
## cg00152708 -1.196320e-01 -6.884330e-02 -0.0180546287 6.714623e-04
## cg23651812  1.289091e-02  6.303543e-02  0.1131799474 6.545379e-04
## cg18348086 -3.018517e-02  3.699231e-02  0.1041697894 1.174722e-03
## cg26578072 -8.912739e-02  2.766874e-02  0.1444648733 3.550952e-03
## cg14786652  5.568945e-02  1.229412e-01  0.1901928910 1.177320e-03
## cg07841371  2.713567e-02  7.192685e-02  0.1167180325 5.222433e-04
## cg14220262  7.133497e-02  1.723107e-01  0.2732865101 2.654130e-03
## cg14008593  2.260122e-02  4.980476e-02  0.0770082947 1.926365e-04
## cg18976046 -1.905164e-02  8.697049e-02  0.1929926087 2.926044e-03
## cg09021712  1.967709e-02  1.181822e-01  0.2166872322 2.525835e-03
## cg24807889 -7.073158e-03 -3.297135e-03  0.0004788871 3.711565e-06
## cg12810734 -1.200324e-02  7.720688e-02  0.1664169944 2.071649e-03
## cg08090128 -8.455936e-02  9.965715e-03  0.1044907870 2.325851e-03
## cg14886269 -7.686011e-02  4.650289e-02  0.1698658859 3.961482e-03
## cg15706223  5.925646e-02  1.984617e-01  0.3376669568 5.044279e-03
## cg25725823 -8.006845e-02 -5.918753e-03  0.0682309488 1.431221e-03
## cg00086243 -1.415478e-01  5.926840e-03  0.1534014615 5.661382e-03
## cg02709725  2.396843e-02  6.033929e-02  0.0967101419 3.443459e-04
## cg10583942 -9.283937e-03  2.501918e-02  0.0593222946 3.063056e-04
## cg20996124  7.473944e-02  1.077310e-01  0.1407225691 2.833307e-04
## cg15993652 -5.744097e-02 -6.994376e-03  0.0434522159 6.624476e-04
## cg25625296  2.644761e-02  7.782470e-02  0.1292017913 6.871110e-04
## cg09503311  7.044834e-02  1.083774e-01  0.1463064499 3.744828e-04
## cg20544186 -2.872034e-03  5.533757e-02  0.1135471828 8.820175e-04
## cg23166857  1.765430e-02  6.327125e-02  0.1088881907 5.416768e-04
## cg23867494 -3.877795e-02  1.294836e-02  0.0646746747 6.964836e-04
## cg21815220 -1.438951e-02  1.026287e-03  0.0164420829 6.186140e-05
##                    pval n_neighbors n_neighbors_control max_cor_neighbors
## cg14008030 4.848468e-01           0                   0                NA
## cg20253340 9.917426e-05           0                   0                NA
## cg21870274 3.862537e-01           2                   1         0.9443580
## cg17308840 7.446401e-01           2                   1         0.9443580
## cg00645010 4.734007e-02           2                   2         0.5236810
## cg27534567 2.602936e-06           1                   0         0.9362968
## cg08258224 3.895914e-04           1                   0         0.9362968
## cg20275697 1.775155e-01           0                   0                NA
## cg24373735 7.660489e-01           0                   0                NA
## cg12445832 6.976022e-01           0                   0                NA
## cg01097950 2.397377e-01           0                   0                NA
## cg01782097 8.655302e-01           1                   1        -0.3941083
## cg20825023 4.282602e-01           1                   1        -0.3941083
## cg11851804 1.953020e-03           0                   0                NA
## cg22226438 4.020166e-01           0                   0                NA
## cg22699361 4.891243e-02           0                   0                NA
## cg13176867 5.934910e-01          14                   3         0.7204513
## cg11407801 9.441863e-03          14                   3         0.8400298
## cg02896266 9.744593e-01          14                   3         0.9572872
## cg23225454 7.520572e-09          14                   3         0.8400298
## cg00976181 3.527691e-04          14                   3         0.8307222
## cg10711230 1.520670e-01          14                   3         0.9489030
## cg06624358 6.554885e-02          14                   3         0.9579203
## cg22485363 3.573406e-01          14                   3         0.9044341
## cg03269716 4.643463e-01          14                   3         0.4837353
## cg21830050 3.139194e-02          14                   3         0.7454396
## cg20453388 8.514103e-02          14                   3         0.9943918
## cg12663811 1.955584e-05          14                   3         0.9061372
## cg23207077 5.677288e-02          14                   3         0.9943918
## cg22381068 6.916965e-01          14                   3         0.9572872
## cg22481263 1.655001e-01          14                   3         0.9579203
## cg07195057 2.585770e-01           0                   0                NA
## cg16352072 5.684457e-01           0                   0                NA
## cg18166741 1.427474e-01           0                   0                NA
## cg22699004 7.050293e-01           7                   3         0.7304732
## cg22599150 5.539571e-01           7                   3         0.9229552
## cg16349774 7.978239e-01           7                   3         0.9334052
## cg18439833 2.942124e-01           7                   3         0.7823498
## cg10201533 9.872796e-01           7                   3         0.8858650
## cg11235921 6.170062e-01           7                   3         0.9512559
## cg26003967 2.968751e-01           7                   3         0.9512559
## cg18977839 4.341174e-02           7                   3         0.9510524
## cg25350899 6.990233e-01           0                   0                NA
## cg13219080 2.521774e-01           0                   0                NA
## cg09364122 7.467612e-01           0                   0                NA
## cg17142931 3.378548e-03          10                   3         0.8320771
## cg20064006 3.617112e-01          10                   1         0.8861739
## cg17006413 7.546683e-01          10                   2         0.5155767
## cg21472517 1.509952e-01          10                   2         0.5878401
## cg18019572 2.341433e-09          10                   3         0.9068319
## cg22673826 9.636086e-01          10                   1         0.9194307
## cg10625579 8.963896e-01          10                   1         0.9194307
## cg01922485 9.467462e-01          10                   1         0.4378177
## cg12763038 2.068732e-03          10                   2         0.8739741
## cg24004483 1.705256e-03          10                   3         0.8739741
## cg23281018 8.463401e-03          10                   3         0.9068319
## cg25552017 6.226222e-01           1                   1        -0.5522566
## cg10984178 8.564116e-01           1                   1        -0.5522566
## cg26837773 1.586384e-02           0                   0                NA
## cg18272461 9.208200e-02           0                   0                NA
## cg02288964 6.974376e-01           1                   0         0.7988483
## cg02341264 1.656399e-01           1                   0         0.7988483
## cg06712559 2.240038e-01           0                   0                NA
## cg14663984 3.009315e-01           1                   1         0.2563707
## cg16318112 2.184116e-05           1                   1         0.2563707
## cg09248054 8.075592e-02           0                   0                NA
## cg15840462 6.557459e-03           1                   0         0.9390294
## cg25759916 1.234549e-04           1                   0         0.9390294
## cg08387293 5.149369e-02           0                   0                NA
## cg23801338 1.714726e-01           4                   3         0.8102542
## cg13244315 6.327301e-01           4                   2         0.8930951
## cg08480609 7.880669e-03           4                   3         0.5124892
## cg03120284 5.747159e-02           4                   2         0.9442837
## cg22627753 1.466381e-01           4                   1         0.9442837
## cg11405655 1.720740e-04           0                   0                NA
## cg24475622 6.186690e-02           4                   2         0.8817194
## cg26702212 5.171782e-02           4                   3         0.8817194
## cg24517686 4.412108e-01           4                   3         0.7972397
## cg14964771 9.172098e-03           4                   3         0.7972397
## cg11200797 1.373757e-01           4                   3         0.8282292
## cg19999567 1.417871e-04           3                   0         0.9706586
## cg20961824 1.613791e-01           3                   0         0.9986763
## cg10126324 4.707910e-03           3                   0         0.9706586
## cg06036677 1.567340e-01           3                   0         0.9986763
## cg19626656 8.160284e-01           8                   3         0.8918280
## cg10113217 1.375357e-01           8                   3         0.8012101
## cg20619296 9.057288e-01           8                   3         0.9031718
## cg18329352 1.400313e-01           8                   2         0.6979246
## cg25973293 8.447567e-05           8                   3         0.8918280
## cg05655247 2.405502e-02           8                   3         0.7042553
## cg01776299 5.716767e-06           8                   3         0.7042553
## cg15688253 1.961548e-01           8                   2         0.3537765
## cg22864340 4.233866e-02           8                   3         0.9031718
## cg22521151 4.050764e-03          10                   3         0.9583885
## cg00207921 8.058517e-01          10                   2         0.9021920
## cg20544808 4.099357e-01          10                   3         0.6248466
## cg18792131 1.794546e-01          10                   3         0.6248466
## cg21475076 8.666602e-01          10                   3         0.8419439
## cg00152708 7.889764e-03          10                   3         0.8419439
## cg23651812 1.374469e-02          10                   3         0.9583885
## cg18348086 2.804522e-01          10                   2         0.9154635
## cg26578072 6.424188e-01          10                   2         0.9021920
## cg14786652 3.396360e-04          10                   3         0.9550230
## cg07841371 1.647185e-03          10                   3         0.9565353
## cg14220262 8.238514e-04           5                   2         0.4894003
## cg14008593 3.327063e-04           5                   3         0.7569997
## cg18976046 1.078794e-01           5                   1         0.8517718
## cg09021712 1.869668e-02           5                   2         0.8517718
## cg24807889 8.700239e-02           5                   2         0.6747690
## cg12810734 8.983258e-02           5                   2         0.8147859
## cg08090128 8.362899e-01          33                   2         0.7266892
## cg14886269 4.600034e-01          33                   2         0.6649734
## cg15706223 5.200789e-03          33                   3         0.8231806
## cg25725823 8.756780e-01          33                   2         0.8232178
## cg00086243 9.372154e-01          33                   2         0.9537928
## cg02709725 1.147404e-03          33                   3         0.8231806
## cg10583942 1.528498e-01          33                   3         0.7696489
## cg20996124 1.551684e-10          33                   3         0.9110564
## cg15993652 7.858125e-01          33                   2         0.8232178
## cg25625296 2.988119e-03          33                   2         0.8234000
## cg09503311 2.137988e-08          33                   3         0.8793982
## cg20544186 6.242084e-02          33                   2         0.9867328
## cg23166857 6.557004e-03          33                   2         0.9867328
## cg23867494 6.236839e-01          33                   2         0.9426473
## cg21815220 8.961831e-01          33                   3         0.9221804
```

Finally, we may compute FDR-corrected p-values, by applying a modified procedure
for controlling the False Discovery Rate for multi-stage analyses (FDR-MSA)
(Tuglus and van der Laan 2009). We do this by simply applying the `fdr_msa` function:

```
fdr_p <- fdr_msa(pvals = vim(methyvim_cancer_ate)$pval,
                 total_obs = nrow(methyvim_cancer_ate))
```

Having explored the results of our analysis numerically, we now proceed to use
the visualization tools provided with the `methyvim` R package to further
enhance our understanding of the results.

### 0.6.1 Visualization of Results

While making allowance for users to explore the full set of results produced by
the estimation procedure (by way of exposing these directly to the user), the
`methyvim` package also provides *three* (3) visualization utilities that
produce plots commonly used in examining the results of differential methylation
analyses.

A simple call to `plot` produces side-by-side histograms of the raw p-values
computed as part of the estimation process and the corrected p-values obtained
from using the FDR-MSA procedure.

```
plot(methyvim_cancer_ate)
```

![](data:image/png;base64...)

**Remark:** The plots displayed above may also be generated separately by
explicitly setting the argument “type” to `plot.methytmle`. For a plot of the
raw p-values, specify `type = "raw_pvals"`, and for a plot of the FDR-corrected
p-values, specify `type = "fdr_pvals"`.

While histograms of the p-values may be generally useful in inspecting the
results of the estimation procedure, a more common plot used in examining the
results of differential methylation procedures is the volcano plot, which plots
the parameter estimate along the x-axis and \(-\text{log}\_{10}(\text{p-value})\)
along the y-axis. We implement such a plot in the `methyvolc` function:

```
methyvolc(methyvim_cancer_ate)
```

![](data:image/png;base64...)

The purpose of such a plot is to ensure that very low (possibly statistically
significant) p-values do not arise from cases of low variance. This appears to
be the case in the plot above (notice that most parameter estimates are *near
zero*, even in cases where the raw p-values are quite low).

Yet another popular plot for visualizing effects in such settings is the
heatmap, which plots estimates of the raw methylation effects (as measured by
the assay) across subjects using a heat gradient. We implement this in the
`methyheat` function:

```
methyheat(methyvim_cancer_ate)
```

![](data:image/png;base64...)

Invoking `methyheat` in this manner produces a plot of the top sites (\(25\), by
default) based on the raw p-value, using the raw methylation measures in the
plot. This uses the exceptional `superheat` R package (Barter and Yu 2017).

---

## 0.7 Session Information

```
## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
##  [1] splines   stats4    parallel  stats     graphics  grDevices utils
##  [8] datasets  methods   base
##
## other attached packages:
##  [1] bindrcpp_0.2.2
##  [2] minfiData_0.27.0
##  [3] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.0
##  [4] IlluminaHumanMethylation450kmanifest_0.4.0
##  [5] arm_1.10-1
##  [6] lme4_1.1-18-1
##  [7] Matrix_1.2-14
##  [8] MASS_7.3-51
##  [9] earth_4.6.3
## [10] plotmo_3.5.0
## [11] TeachingDemos_2.10
## [12] plotrix_3.7-4
## [13] gam_1.16
## [14] methyvimData_1.3.0
## [15] methyvim_1.4.0
## [16] minfi_1.28.0
## [17] bumphunter_1.24.0
## [18] locfit_1.5-9.1
## [19] iterators_1.0.10
## [20] foreach_1.4.4
## [21] Biostrings_2.50.0
## [22] XVector_0.22.0
## [23] SummarizedExperiment_1.12.0
## [24] DelayedArray_0.8.0
## [25] BiocParallel_1.16.0
## [26] matrixStats_0.54.0
## [27] Biobase_2.42.0
## [28] GenomicRanges_1.34.0
## [29] GenomeInfoDb_1.18.0
## [30] IRanges_2.16.0
## [31] S4Vectors_0.20.0
## [32] BiocGenerics_0.28.0
## [33] tmle_1.3.0-1
## [34] SuperLearner_2.0-24
## [35] nnls_1.4
## [36] BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##   [1] backports_1.1.2          plyr_1.8.4
##   [3] lazyeval_0.2.1           listenv_0.7.0
##   [5] ggplot2_3.1.0            digest_0.6.18
##   [7] htmltools_0.3.6          magrittr_1.5
##   [9] memoise_1.1.0            cluster_2.0.7-1
##  [11] limma_3.38.0             globals_0.12.4
##  [13] readr_1.1.1              annotate_1.60.0
##  [15] doFuture_0.6.0           siggenes_1.56.0
##  [17] prettyunits_1.0.2        colorspace_1.3-2
##  [19] blob_1.1.1               xfun_0.4
##  [21] dplyr_0.7.7              crayon_1.3.4
##  [23] RCurl_1.95-4.11          genefilter_1.64.0
##  [25] bindr_0.1.1              GEOquery_2.50.0
##  [27] survival_2.43-1          glue_1.3.0
##  [29] registry_0.5             gtable_0.2.0
##  [31] zlibbioc_1.28.0          superheat_0.1.0
##  [33] Rhdf5lib_1.4.0           HDF5Array_1.10.0
##  [35] abind_1.4-5              scales_1.0.0
##  [37] DBI_1.0.0                rngtools_1.3.1
##  [39] bibtex_0.4.2             Rcpp_0.12.19
##  [41] xtable_1.8-3             progress_1.2.0
##  [43] bit_1.1-14               mclust_5.4.1
##  [45] preprocessCore_1.44.0    httr_1.3.1
##  [47] RColorBrewer_1.1-2       pkgconfig_2.0.2
##  [49] reshape_0.8.8            XML_3.98-1.16
##  [51] labeling_0.3             tidyselect_0.2.5
##  [53] rlang_0.3.0.1            AnnotationDbi_1.44.0
##  [55] munsell_0.5.0            tools_3.5.1
##  [57] RSQLite_2.1.1            ggdendro_0.1-20
##  [59] evaluate_0.12            stringr_1.3.1
##  [61] yaml_2.2.0               knitr_1.20
##  [63] bit64_0.9-7              beanplot_1.2
##  [65] purrr_0.2.5              future_1.10.0
##  [67] nlme_3.1-137             doRNG_1.7.1
##  [69] nor1mix_1.2-3            xml2_1.2.0
##  [71] biomaRt_2.38.0           compiler_3.5.1
##  [73] tibble_1.4.2             stringi_1.2.4
##  [75] GenomicFeatures_1.34.0   lattice_0.20-35
##  [77] nloptr_1.2.1             ggsci_2.9
##  [79] multtest_2.38.0          pillar_1.3.0
##  [81] BiocManager_1.30.3       data.table_1.11.8
##  [83] bitops_1.0-6             rtracklayer_1.42.0
##  [85] R6_2.3.0                 bookdown_0.7
##  [87] gridExtra_2.3            codetools_0.2-15
##  [89] gtools_3.8.1             assertthat_0.2.0
##  [91] rhdf5_2.26.0             openssl_1.0.2
##  [93] pkgmaker_0.27            rprojroot_1.3-2
##  [95] withr_2.1.2              GenomicAlignments_1.18.0
##  [97] Rsamtools_1.34.0         GenomeInfoDbData_1.2.0
##  [99] hms_0.4.2                quadprog_1.5-5
## [101] grid_3.5.1               coda_0.19-2
## [103] minqa_1.2.4              tidyr_0.8.2
## [105] base64_2.0               rmarkdown_1.10
## [107] DelayedMatrixStats_1.4.0 illuminaio_0.24.0
```

---

## References

Aryee, Martin J, Andrew E Jaffe, Hector Corrada-Bravo, Christine Ladd-Acosta, Andrew P Feinberg, Kasper D Hansen, and Rafael A Irizarry. 2014. “Minfi: A Flexible and Comprehensive Bioconductor Package for the Analysis of Infinium DNA Methylation Microarrays.” *Bioinformatics* 30 (10). Oxford University Press (OUP):1363–9. <https://doi.org/10.1093/bioinformatics/btu049>.

Barter, Rebecca L, and Bin Yu. 2017. “Superheat: An R Package for Creating Beautiful and Extendable Heatmaps for Visualizing Complex Data.”

Benjamini, Yoav, and Yosef Hochberg. 1995. “Controlling the False Discovery Rate: A Practical and Powerful Approach to Multiple Testing.” *Journal of the Royal Statistical Society. Series B (Methodological)*. JSTOR, 289–300.

Breiman, Leo. 1996. “Stacked Regressions.” *Machine Learning* 24 (1). Springer:49–64.

Chambaz, Antoine, Pierre Neuvial, and Mark J van der Laan. 2012. “Estimation of a Non-Parametric Variable Importance Measure of a Continuous Exposure.” *Electronic Journal of Statistics* 6. NIH Public Access:1059.

Dedeurwaerder, Sarah, Matthieu Defrance, Martin Bizet, Emilie Calonne, Gianluca Bontempi, and François Fuks. 2013. “A Comprehensive Overview of Infinium Humanmethylation450 Data Processing.” *Briefings in Bioinformatics*. Oxford Univ Press, bbt054.

Fortin, Jean-Philippe, Aurelie Labbe, Mathieu Lemire, Brent W Zanke, Thomas J Hudson, Elana J Fertig, Celia MT Greenwood, and Kasper D Hansen. 2014. “Functional Normalization of 450k Methylation Array Data Improves Replication in Large Cancer Studies.” *bioRxiv*. Cold Spring Harbor Labs Journals.

Hernan, Miguel A, and James M Robins. 2018, forthcoming. *Causal Inference*. Chapman & Hall/Crc Texts in Statistical Science. Taylor & Francis.

Pearl, Judea. 2009. *Causality: Models, Reasoning, and Inference*. Cambridge University Press.

Robertson, Keith D. 2005. “DNA Methylation and Human Disease.” *Nature Reviews. Genetics* 6 (8). Nature Publishing Group:597.

Tuglus, Catherine, and Mark J. van der Laan. 2009. “Modified FDR Controlling Procedure for Multi-Stage Analyses.” *Statistical Applications in Genetics and Molecular Biology* 8 (1). Walter de Gruyter:1–15. <https://doi.org/10.2202/1544-6115.1397>.

van der Laan, Mark J, Eric C Polley, and Alan E Hubbard. 2007. “Super Learner.” *Statistical Applications in Genetics and Molecular Biology* 6 (1).

van der Laan, Mark J, and Sherri Rose. 2011. *Targeted Learning: Causal Inference for Observational and Experimental Data*. Springer Science & Business Media.

———. 2018. *Targeted Learning in Data Science: Causal Inference for Complex Longitudinal Studies*. Springer Science & Business Media.

Wolpert, David H. 1992. “Stacked Generalization.” *Neural Networks* 5 (2). Springer:241–59.