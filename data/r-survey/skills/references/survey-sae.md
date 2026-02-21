# Area level and unit level models for estimating small area means

In this vignette, we demonstrate the use of basic area level models for small area estimation, as originally implemented in `SUMMER` and adapted for use in `survey`. The models implemented in `survey` include common small area estimation models, as outlined below. A in-depth review of our approach to model-based small area estimation is provided by Wakefield, Okonek, and Pedersen (2020).

# Preliminary

First, we load the necessary packages and data. The required package `INLA` is not available via a standard repository, so we include code for installation if it is not found. The `survey` package will be used to generate direct estimates, while `dplyr` and `tidyr` will be used for data manipulation.

```
library(survey)
if (!isTRUE(requireNamespace("INLA", quietly = TRUE))) {
  install.packages("INLA", repos=c(getOption("repos"),
                                   INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)
}
```

# Area level models

## Artificial poverty rate example

In their vignette for the `sae` package, Molina and Marhuenda (2015) generate an artificial dataset on income and other related variables to illustrate the use of area level models. In this example, the objective is to estimate prevalence of poverty in Spanish counties.

```
data("incomedata", package="sae")
data("sizeprov", package="sae")
data("sizeprovedu", package="sae")
povertyline <- 0.6 * median(incomedata$income) # 6557.143
incomedata$in_poverty <- as.integer(incomedata$income < povertyline)
```

The `incomedata` data frame contains information on 17199 observations of individuals in 52 Spanish provinces. Income values and sampling weights are provided for each individual along with covariate information including age group and education level. Molina and Marhuenda (2015) define the poverty line and calculate an indicator variable (which we name `in_poverty`) with value 1 if the corresponding income value is below the poverty line and 0 otherwise.

### Direct estimation with `sae`

Before considering model-based methods for small area estimation, we compute direct weighted estimators for the desired small area means. The Horvitz-Thompson estimator of domain means is given by

(1/*N**i*)∑*j* ∈ *S**i**w**j**y**j*

where *N**i* is the population size of domain *i*, *S**i* is the set of sampled observations in domain *i*, *w**j* is the sampling weight for unit *j*, and *y**j* is the observation for unit *j*, for all *j* ∈ *S**i*. The `sae::direct` function also estimates standard deviation and coefficient of variation for each domain. Note that *N**i* is assumed known and is provided in the data frame `sizeprov`. The domains of interest are identified via the `provlab` variable.

We can use the `survey::svyby` function to compute the Horvitz-Thompson estimates:

```
incomedata$pop <- sum(sizeprov$Nd[match(incomedata$provlab, sizeprov$provlab)])
design <- survey::svydesign(ids = ~1, weights = ~weight,
                            data = incomedata, fpc = ~pop)

# estimate area totals
svy.DIR <- survey::svyby(~in_poverty, ~provlab, design, svytotal)

# calculate corresponding area mean estimates
svy.DIR$prov_pop <- sizeprov$Nd[match(svy.DIR$provlab, sizeprov$provlab)]
svy.DIR$Domain <-svy.DIR$provlab
svy.DIR$Direct = svy.DIR$in_poverty/svy.DIR$prov_pop
svy.DIR$SD= svy.DIR$se/svy.DIR$prov_pop
```

### Basic area level model

The basic area level model, also called the Fay-Herriot model, treats direct estimates of small area quantities as response data and explicitly models differences between areas using covariate information and random effects (Fay and Herriot 1979). The Fay-Herriot model can be viewed as a two-stage model: in the first stage, a *sampling model* represents the sampling variability of a direct estimator and in the second stage, a *linking model* describes the between area differences in small area quantities.

**Sampling model**:

Let *θ̂**i*DIR be a direct estimator of an area level mean or total *θ**i*. The sampling model treats *θ̂**i*DIR as a noisy observation of the true finite population quantity *θ**i*:

*θ̂**i*DIR = *θ**i* + *ϵ**i*;   *ϵ**i*  ∼*i**n**d*  *N*(0,*V**i*),   *i* = 1, …, *M*

where *V**i* is the **known sampling variance** of the direct estimator *θ̂**i*DIR.

**Linking model**:

*θ**i* = **x***i**T***β** + *u**i*,   *u**i*  ∼*i**n**d*  *N*(0,*σ**u*2)   *i* = 1, …, *M*,

where *σ**u*2 (between-area residual variance) is estimated. In this basic Fay-Herriot model, the area-specific random effects *u**i* are assumed to be independent and identically distributed (IID) between areas.

Below, we provide a quantile-quantile plot comparing the direct estimates to a Gaussian distribution. Here the observed quantiles align well with those from a Gaussian distribution, which lends some support to the basic IID model.

```
par(pty = "s")
mu.DIR <- mean(svy.DIR$Direct)
sd.DIR <- sd(svy.DIR$Direct)
qqnorm((svy.DIR$Direct - mu.DIR) / sd.DIR, main = "")
abline(0, 1, col = "red")
```

![](data:image/png;base64...)

The `svysmoothArea` function adopts a Bayesian approach to inference using models such as the basic area level model, carrying out computation via the `INLA` package. The `svysmoothArea` function computes direct estimates and then produces smoothed estimates using a Bayesian Fay-Herriot model. The main arguments of interest are:

* `formula`: Describing the response variable and any area-level covariates
* `domain` A one-sided formula with the variable containing domain labels on the right. The domain labels variable should be contained in the dataset used to generate the design.
* `design`: A `survey.design` object containing survey data and specifying the survey design.

In addition, other commonly used optional arguments include:

* `adj.mat`: Optional adjacency matrix if a spatial smoothing model is desired.
* `transform`: If `"logit"` is specified, a logit transform will be applied to the direct estimates and an appropriate transformation will be applied to the estimated sampling variances before smoothing.
* `direct.est`: The direct estimates may be specified directly and smoothing will be applied directly to these user-provided estimates.
* `X.domain`: Data frame of area level covariates.
* `domain.size`: Data frame of domain sizes used for computing direct estimates if domain sizes are known.

Other optional arguments can be specified to change the priors and are described further in the documentation.

For the artificial poverty rate example, we fit the Fay-Herriot model and obtain the following smoothed estimates.

```
# specify known domain sizes
domain.size <- sizeprov[, c("provlab", "Nd")]
colnames(domain.size)[2] <- "size"

# fit model and obtain svysae object
svy.FH <- svysmoothArea(formula = in_poverty~1,
                     domain = ~provlab,
                     design = design,
                     domain.size = domain.size,
                     return.samples = T)
svy.FH.table <- data.frame(
  Domain = svy.DIR$Domain,
  Median = svy.FH$iid.model.est$median,
  SE = sqrt(svy.FH$iid.model.est$var)
)
head(svy.FH.table)
##     Domain     Median         SE
## 1    Alava 0.23394447 0.03989036
## 2 Albacete 0.15516988 0.02843149
## 3 Alicante 0.20488000 0.02071508
## 4  Almeria 0.23808371 0.03515380
## 5    Avila 0.07854126 0.02392518
## 6  Badajoz 0.20805100 0.02200545
```

Using the `plot()` method, we can obtain a comparison of the direct estimates (with corresponding frequentist 95% confidence intervals) and smoothed estimates (with Bayesian 95% credible intervals).

```
# plot comparison of direct and smoothed estimates
plot(svy.FH)
```

![](data:image/png;base64...)

![](data:image/png;base64...)

The `SUMMER` package includes functions to generate additional diagnostic plots based on samples from the model posterior. The `SUMMER::compareEstimates()` function generates a heatmap of the posterior pairwise probabilities of one area’s mean exceeding another’s mean.

## Spatial area level model

The `svysmoothArea` function also allows the use of a model with spatially correlated area effects, where the default implementation assumes a BYM2 model for **u** (Riebler et al. 2016).

In particular, under the BYM2 model, we assume **u** is composed of an unstructured term **u**1′ and a spatially structured term **u**2\*′:

Here, **u**1′ ∼ *N*(**0**,**I**) is a vector of iid Gaussian random area effects and assume an intrinsic conditional autoregressive (ICAR) Gaussian prior for **u**2\*′. Under this parameterization, *σ**u*2 represents the marginal variance of **u** and *ϕ* represents the proportion of variation assigned to the spatial term.

## BRFSS diabetes rates

Below, we provide an example using data from the Behavioral Risk Factor Surveillance System (BRFSS).

```
data(BRFSS)
data(KingCounty)
BRFSS <- subset(BRFSS, !is.na(BRFSS$diab2))
BRFSS <- subset(BRFSS, !is.na(BRFSS$hracode))
head(BRFSS)
##   age pracex       educau zipcode    sex street1 street2      seqno year
## 1  30  White college grad   98001   male      NA      NA 2009000041 2009
## 2  26  White college grad   98107 female      NA      NA 2009000309 2009
## 3  33  Black college grad   98133   male      NA      NA 2009000404 2009
## 4  25  White some college   98058   male      NA      NA 2009000531 2009
## 5  23  White some college   98102   male      NA      NA 2009000675 2009
## 6  19  Asian some college   98106   male      NA      NA 2009000694 2009
##   hispanic mracex strata             hracode tract rwt_llcp genhlth2 fmd obese
## 1 non-Hisp  White  53019        Auburn-North    NA 2107.463        0   0     0
## 2 non-Hisp  White  53019             Ballard    NA 2197.322        0   1     0
## 3 non-Hisp  Black  53019          NW Seattle    NA 3086.511        0   0     0
## 4 non-Hisp  White  53019        Renton-South    NA 3184.740        1   1     1
## 5 non-Hisp  White  53019 Capitol Hill/E.lake    NA 3184.740        0   0     0
## 6 non-Hisp  Asian  53019      North Highline    NA 4391.304        0   0     0
##   smoker1 diab2 aceindx2 zipout streetx ethn age4 ctmiss
## 1       0     0       NA  98001       0    1    3      1
## 2       0     0       NA  98107       0    1    3      1
## 3       0     0       NA  98133       0    2    3      1
## 4       0     0       NA  98058       0    1    3      1
## 5       0     0       NA  98102       0    1    4      1
## 6       0     0       NA  98106       0    3    4      1
mat <- SUMMER::getAmat(KingCounty, KingCounty$HRA2010v2_)
design <- svydesign(ids = ~1, weights = ~rwt_llcp,
                    strata = ~strata, data = BRFSS)
direct <- svyby(~diab2, ~hracode, design, svymean)
```

Below, we fit two versions of the spatial area level model in `SUMMER`. For this example, we apply the area level model to the logit-transformed direct estimates (as specified via the `transform = "logit"` argument). In other words, we use the following model:

logit(*θ̂**i*DIR) = logit(*θ**i*) + *ϵ**i*;   *ϵ**i*  ∼*i**n**d*  *N*(0, *V*(logit(*θ**i*)),   *i* = 1, …, *M* where *V*(logit(*θ**i*)) ≈ *V**i*/*θ**i*2 is the sampling variance of *θ̂**i*DIR. The linking model is then logit(*θ**i*) = **x***i**T***β** + *u**i*,   *u**i*  ∼*i**n**d*  *N*(0,*σ**u*2)   *i* = 1, …, *M*,

If we change `pc.u` and `pc.alpha` from the default value *u* = 1, *α* = 0.01 to *u* = 0.1, *α* = 0.01, we assign more prior mass on smaller variance of the random effects, inducing more smoothing. Note that in this example, we include no covariates to avoid having to introduce additional data.

```
svy.brfss <- svysmoothArea(diab2~1, domain= ~hracode,
                        design = design,
                        transform = "logit",
                        adj.mat = mat, level = 0.95,
                        pc.u = 0.1, pc.alpha = 0.01)
```

The `SUMMER::mapPlot()` function can be used to visualize the posterior median estimates and uncertainty estimates.

# Unit level models

The nested error model, introduced by Battese, Harter, and Fuller (1988), uses auxiliary data at the unit level.

**Nested error model:** *y**i**j* = **x***i**j**T***β** + *u**i* + *ϵ**i**j*,  *u**i*  ∼*i**n**d*  *N*(0,*σ**u*2),  *ϵ**i**j*  ∼*i**n**d*  *N*(0,*σ**ϵ*2)

Here *u**i* are area random effects and *ϵ**i**j* are unit level errors.

This model assumes there is **no sample selection bias**.

## Corn and Soy Production

The `cornsoybean` and `cornsoybeanmeans` datasets contain info on corn and soy beans production in 12 Iowa counties (Battese, Harter, and Fuller 1988). The objective here is use satellite imagery of the number of pixels assigned to corn and soy to estimate the hectares grown of corn.

* `SampSegments`: sample size.
* `PopnSegments`: population size.
* `MeanCornPixPerSeg`: county mean of the number of corn pixels (satellite imagery).
* `MeanSoyBeansPixPerSeg` county mean of the number of soy beans (satellite imagery) pixels.

The variables `MeanCornPixPerSeg` and `MeanSoyBeansPixPerSeg` provide the known county means of the auxiliary variables.

We load the sample data:

```
data("cornsoybean", package="sae")
```

Next, we load the population auxiliary information:

```
data("cornsoybeanmeans", package="sae")
Xmean <-
  data.frame(cornsoybeanmeans[, c("CountyIndex",
                                  "MeanCornPixPerSeg",
                                  "MeanSoyBeansPixPerSeg")])
Popn <-
  data.frame(cornsoybeanmeans[, c("CountyIndex",
                                  "PopnSegments")])
```

The `smoothUnit` function provides the ability to fit unit level models with unit level covariates for Gaussian and binomial response variables. Below we use the `is.unit` argument to specify a unit level model and then provide the column names of the unit level covariates in `X.unit`. Finally, the `X` argument provides the area level means of each covariate for use when generating predictions. Note that we specify a relatively flat prior on the variance of the area-specific random effect (the arguments `pc.u = 100, pc.alpha = 0.01` specify a penalized complexity prior such that *P*(*σ**u*>100) = 0.01 where *σ**u* is the standard deviation of the area-specific random effects).

```
cornsoybean$id <- 1:dim(cornsoybean)[1]
Xsummer <- Xmean
colnames(Xsummer) = c("County", "CornPix", "SoyBeansPix")
des0 <- svydesign(ids = ~1, data = cornsoybean)
svy.bhf.unit <- smoothUnit(formula = CornHec ~ CornPix + SoyBeansPix,
                           family = "gaussian",
                           domain = ~County,
                           design = des0, X.pop = Xsummer,
                           pc.u = 1000, pc.alpha = 0.01, level = 0.95)
summary(svy.bhf.unit)
## Call:
## smoothUnit(formula = CornHec ~ CornPix + SoyBeansPix, domain = ~County,
##     design = des0, family = "gaussian", X.pop = Xsummer, pc.u = 1000,
##     pc.alpha = 0.01, level = 0.95)
##
## Methods used: direct.est, iid.model.est
##
## direct.est
##    domain     mean   median        var     lower    upper method
## 1       1 165.7600 165.7600   0.000000 165.76000 165.7600 Direct
## 2       2  96.3200  96.3200   0.000000  96.32000  96.3200 Direct
## 3       3  76.0800  76.0800   0.000000  76.08000  76.0800 Direct
## 4       4 150.8900 150.8900 610.238739 102.47299 199.3070 Direct
## 5       5 158.6233 158.6233   7.430247 153.28077 163.9659 Direct
## 6       6 102.5233 102.5233 430.314438  61.86580 143.1809 Direct
## 7       7 112.7733 112.7733 213.115805  84.16083 141.3858 Direct
## 8       8 144.2967 144.2967 665.975547  93.71685 194.8765 Direct
## 9       9 117.5950 117.5950  87.414716  99.27015 135.9198 Direct
## 10     10 109.3820 109.3820  40.331533  96.93483 121.8292 Direct
## 11     11 110.2520 110.2520  24.148695 100.62048 119.8835 Direct
## 12     12 114.8100 114.8100 178.260890  88.64166 140.9783 Direct
##
## iid.model.est
##    domain     mean   median       var     lower    upper                method
## 1       1 123.7876 123.2013  86.06266 108.32013 142.2333 Unit level model: IID
## 2       2 124.2452 124.7868  97.86504 104.93144 142.9875 Unit level model: IID
## 3       3 110.3233 111.5757 102.53029  88.20383 126.9989 Unit level model: IID
## 4       4 113.6742 114.1331  71.81986  96.38425 127.9440 Unit level model: IID
## 5       5 140.1470 139.9905  75.00325 123.76649 155.1843 Unit level model: IID
## 6       6 110.0132 109.4203  57.25731  95.71681 124.7636 Unit level model: IID
## 7       7 115.9491 116.0076  57.80478 101.21077 129.8307 Unit level model: IID
## 8       8 122.6541 122.4973  55.39583 108.86131 138.6098 Unit level model: IID
## 9       9 112.6702 112.1757  48.62457  98.12156 127.7731 Unit level model: IID
## 10     10 123.8395 123.8251  36.20162 111.43605 135.8105 Unit level model: IID
## 11     11 111.2287 111.9254  44.52737  96.51444 123.5814 Unit level model: IID
## 12     12 131.3522 131.1526  35.26051 120.12848 142.9651 Unit level model: IID
```

# References

Battese, George E., Rachel M. Harter, and Wayne A. Fuller. 1988. “An Error-Components Model for Prediction of County Crop Areas Using Survey and Satellite Data.” *Journal of the American Statistical Association* 83 (401): 28–36. <https://doi.org/10.2307/2288915>.

Fay, Robert E., and Roger A. Herriot. 1979. “Estimates of Income for Small Places: An Application of James-Stein Procedures to Census Data.” *Journal of the American Statistical Association* 74 (366a): 269–77. <https://doi.org/10.1080/01621459.1979.10482505>.

Molina, Isabel, and Yolanda Marhuenda. 2015. “Sae: An R Package for Small Area Estimation.” *The R Journal* 7 (1): 81–98. <https://journal.r-project.org/archive/2015/RJ-2015-007/index.html>.

Riebler, Andrea, Sigrunn H Sørbye, Daniel Simpson, and Håvard Rue. 2016. “An Intuitive Bayesian Spatial Model for Disease Mapping That Accounts for Scaling.” *Statistical Methods in Medical Research* 25 (4): 1145–65. <https://doi.org/10.1177/0962280216660421>.

Wakefield, Jonathan, Taylor Okonek, and Jon Pedersen. 2020. “Small Area Estimation for Disease Prevalence Mapping.” *International Statistical Review* 88 (2): 398–418. <https://doi.org/10.1111/insr.12400>.