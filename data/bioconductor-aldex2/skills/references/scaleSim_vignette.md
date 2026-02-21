# Incorporating Scale Uncertainty into ALDEx2

Michelle Nixon1\*

1College of IST, Penn State

\*pistner@psu.edu

#### 29 October 2025

#### Abstract

In this vignette, we discuss the updates made to the `ALDEx2` package that makes it easy to incorporate scale uncertainty into analyses. We discuss these updates from a mathematical perspective, giving the relevant details to understand the core methods. Then, we show how to incorporate scale uncertainty into `ALDEx2` via a default scale model and how to create more complex scale models. Going further, we show how the package updates make it easy to assess how results change as a function of uncertainty using sensitivity analyses.

#### Package

ALDEx2 1.42.0

# 1 Introduction to Scale Simulation using `ALDEx2`

`ALDEx2` is software for fitting linear models on sequence count data developed by Fernandes et al. ([2013](#ref-fernandes:2013)). It attempts to model how the abundance (or expression) of entities changes between different biological conditions. As a special case, `ALDEx2` is a method for differential expression or differential abundance when the covariate of interest is binary.

In short, the method works by testing Centered log-ratio (CLR)-transformed Dirichlet samples. Succinctly, for each entity (e.g., gene or taxa) \(j\), it proceeds by:

1. Adding a small prior count to the observed counts for taxa \(j\) across all samples.
2. Drawing Monte Carlo samples using the Dirichlet distribution.
3. Transforming the samples using the Centered log ratio (CLR) transform.
4. Fitting a model using the covariates of interest and testing a hypothesis (e.g., t-tests in the case of differential expression/abundance).
5. Averaging across test statistics and p-values to test significance for each entity.

The average test statistic and p-value111 Corrected p-values using either the Benjamini-Hochberg or Holm procedure are also returned. for each entity is returned and typically used by the end user to judge the significance of certain covariates on each taxa.

Step 3 of `ALDEx2` relies on transforming the Dirichlet samples, which necessarily sum to one, to CLR coordinates. As noted by Nixon et al. ([2023](#ref-nixon:2022)), the CLR can introduce a mismatch between the research question and the actual analysis that is carried out. To see this concretely, consider the case where we have access to a sequence count data set \(Y\), which is a \(D \times N\) matrix where \(D\) is the number of entities and \(N\) is the number of samples. \(Y\) is a sample of some underlying system \(W\). For example, in a study of the human gut, \(Y\) denotes the sequenced microbes obtained from a fecal sample whereas \(W\) represents the actual microbes that occupy the gut.

The scale of \(Y\) does not match the scale of \(W\) but rather is more reflective of the measurement process (Props et al. ([2017](#ref-Props:2017)), Vandeputte et al. ([2017](#ref-Vandeputte:2017))). This is problematic when the research question depends on the scale of \(W\) but is inferred from \(Y\) alone. For example, consider the case where the analyst wants to estimate log-fold changes between two conditions:

\[\theta\_d = \text{mean}\_{x\_i\text{ in group 1}} \log W\_{di} - \text{mean}\_{x\_i \text{ in group 2}} \log W\_{di}.\]
However, when using CLR coordinates, something different is estimated:

\[\tilde{\theta}\_d = \text{mean}\_{x\_i\text{ in group 1}} \text{CLR}( Y\_{di}) - \text{mean}\_{x\_i \text{ in group 2}} \text{CLR}( Y\_{di}).\]

Note that \(\tilde{\theta}\_d\) is not necessarily an estimate of \(\theta\_d\) but something different: it is an estimate of the change in CLR coordinates of entity \(d\) between conditions *not* an estimate in the change of the absolute abundances of entity \(d\) between conditions. In fact, if \(\tilde{\theta\_d}\) is used as an estimate of \(\theta\_d\), a very specific assumption is being made equating the scale of the system to a function of the geometric mean of the observed data. Furthermore, this is being assumed with complete certainty which may skew analysis results. Importantly, all normalizations make assumptions of scale, see Nixon et al. ([2023](#ref-nixon:2022)) for complete details.

While other normalizations are available within the ALDEx2 software, they similarly impose certain assumptions about the scales between conditions. In this vignette, we show how to step away from normalizations and instead rely on scale models for analysis.

## 1.1 From Normalizations to Scale Models

Introduced and developed in Nixon et al. ([2023](#ref-nixon:2022)), scale simulation argues that many different types of analyses (including differential expression) are *scale reliant*, meaning that they inherently rely on the scale (e.g., total) of the system under study. Ignoring the scale can lead to incorrect inference or results that might not answer the right question.

To circumvent this, Nixon et al. ([2023](#ref-nixon:2022)) develops *scale simulation random variables* (SSRVs) which, in essence, provides the framework to directly incorporate scale uncertainty in the modeling process and, in doing so, can greatly improve inference (i.e., control Type-I error). In addition, they developed the methodology to incorporate scale simulation within the context of ALDEx2.

In brief, SSRVs replace normalizations with draws from a scale model. To see this concretely, lets consider the case of log fold changes. That is, we want to estimate \(\theta\_d\) from the previous section. As discussed, this quantity depends on the scale of the system \(W\). We can decompose \(W\) into both a compositional (denoted by the superscript \(\parallel\)) and total (denoted by the superscript \(\perp\)) component:

\[W\_{dn} = W\_{dn}^{\parallel}W^{\perp}\_{n}\]

where we can define each component as:

\[\begin{align}
W^{\perp}\_{n} &= \sum\_{d=1}^{D}W\_{dn} \nonumber\\
W^{\parallel}\_{dn} &= \frac{W\_{dn}}{W^{\perp}\_{n}}.
\end{align}\]

SSRVs rely on two models: a (which models \(W^\parallel\)) and a (which models \(W^\perp\)). That is, we take draws from the measurement model based on the available data \(Y\) to get samples of \(W^\parallel\) and draws from the scale model \(W^\perp\) and combine them together to get draws for \(W\).

Scale simulation subtly (but importantly) changes ALDEx2 in Step 3 above. After drawing Monte Carlo samples from the Dirichlet distribution (which denotes the measurement model for \(W^\parallel\)), scale simulation augments these samples with samples drawn from the scale model (as opposed to apply the CLR). This results in samples that better represent the scaled samples. See Nixon et al. ([2023](#ref-nixon:2022)) for complete details.

![](data:image/png;base64...)

How do we define and draw from a scale model? There are many options including:

1. Creating a scale model based on biological knowledge (e.g., bounds on the total number of microbes in the gut).
2. Creating a scale model based on outside measurements (e.g., flow cytometry or qPCR).
3. Creating a scale model that relaxes existing normalizations.

In this vignette, we show how to create each type of scale model. For convenience, we have included a default scale model based on the CLR normalization that requires only the input of a single number. For a single binary covariate, this scale model has the form:

\[\begin{align\*}
\log \hat{W}\_{n}^{\perp(s)} &= - \log \phi \left(\hat{W}^{\parallel (s)}\_{\cdot n}\right) + \Lambda^{\perp (s)} X\_{n}^\*\\
\Lambda^{\perp (s)} & \sim \ N(0, \gamma^2).
\end{align\*}\]

where \(X\_n^\*\) is re-coded to have levels zero and one. Note that if \(\gamma \rightarrow 0\), this scale model defaults to the CLR assumption. As \(\gamma\) increases, more uncertainty is added. This can be incorporated by setting by updating the `gamma` parameter in the `aldex` and `aldex.clr` functions. For example, to set \(\gamma\) equal to one, we would specify `gamma = 1`.

As we will show, \(\gamma\) can also be set to a \(N \times S\) matrix where \(N\) is the number of samples and \(S\) is the number of Monte Carlo replicates. This approach assumes that each row of the matrix represents draws from the total model for a given sample. These draws are internally log transformed and combined with the Multinomial Dirichlet draws to obtain samples for \(W\).

# 2 Using Scale Simulation in `ALDEx2`

## 2.1 Installing `ALDEx2` with Scale Simulation

Currently, scale simulation within ALDEx2 is implemented in the `ALDEx_bioc` development branch on Github which can be installed using the `devtools` package if needed.

```
##If needed, install devtools
##install.packages("devtools")
# devtools::load_all("~/Documents/0_git/ALDEx_bioc")
library(ALDEx2)
set.seed(1234)
```

## 2.2 Simulation Setup

For this vignette, we are going to use a simulated data set. We consider a hypothetical scenario where a researcher is interested in how administering an antibiotic changes the abundance of taxa in the gut. To this end, they collected 100 samples both before and after antibiotic administration. Each sample contained the counts for 20 taxa.

In this simulation, we assume four of the 20 taxa are truly changing. Of the four taxa that are changing, they are all decreasing after antibiotic administration.

We are going to use Poisson sampling to sample the true abundances given a mean vector. First, writing a helper function to sample for the true abundances.

```
library(tidyverse)
##Function to create the true abundances via Poisson resampling
create_true_abundances <- function(d, n){
  dd <- length(d)/2
  dat <- d %>%
    sapply(function(x) rpois(n, lambda=x)) %>%
    t() %>%
    as.data.frame() %>%
    split(rep(1:2, each=dd)) %>%
    purrr::map(~`rownames<-`(.x, paste0("Taxa", 1:dd))) %>%
    purrr::map(t) %>%
    do.call(rbind, .) %>%
    as.data.frame() %>%
    cbind(Condition=factor(rep(c("Pre", "Post"), each=n),
      levels = c("Pre", "Post")), .) %>% `rownames<-`(., NULL)
  return(dat)
}
```

Second, to reflect the loss of scale information, we use multinomial sampling to resample the data to an arbitrary sequencing depth. Again, writing a helper function.

```
##Function to resample data to an arbitrary size
resample_data <- function(dat, seq.depth){
  ddat <- as.matrix(dat[,-1])/rowSums(as.matrix(dat[,-1]))
  for (i in 1:nrow(dat)){
    dat[i,-1] <- rmultinom(1, size=seq.depth, prob=ddat[i,])
  }
  return(dat)
}
```

Now, we will use these functions to simulate data. Note that `dat` is analogous to \(W\), and `rdat` is analogous to \(Y\). To be clear, only four elements of `d` are chaning between conditions

```
###Setting the data parameters for the simulation
##Denotes the mean for the 20 taxa
##Note only taxa 3, 4, 15, and 20 change
d.pre <- c(4000, 4000, 4000, 4000, 4000,
  400,400,400,400,4000,400,500,500,500,
  400,400,400,400,400,400)
d.post <- d.pre
d.post[c(3,4,15,20)] <- c(3000, 2000, 200, 100)

#Combining together
d <- c(d.pre, d.post)

##Create scale abundances
dat <- create_true_abundances(d, n=100)
##Create resampled data
rdat <- resample_data(dat, seq.depth=5000)
```

Now, we need one more piece of information: the totals for each sample. We are going to use this to create mock flow cytometry data.

```
## Finding sample totals
totals <- rowSums(dat[,-1])

flow_cytometry <- function(totals, samp.names, replicates = 3){
  samp.names <- rep(samp.names, each = replicates)
  flow_vals <- sapply(totals, FUN = function(totals,
    replicates){rnorm(replicates,totals,3e2)},
    replicates = replicates, simplify = TRUE)
  flow_data <- data.frame("sample" = samp.names, "flow" = c(flow_vals))
  return(flow_data)
}

flow_data <- flow_cytometry(totals, rownames(dat))
```

Now, we have all the necessary pieces to run our models. Inspecting the data elements:

```
##Inspecting elements
Y <- t(rdat[,-1])
Y[1:5,1:5]
```

```
##       [,1] [,2] [,3] [,4] [,5]
## Taxa1  646  711  669  692  690
## Taxa2  692  629  682  637  666
## Taxa3  674  651  686  642  668
## Taxa4  677  688  652  694  649
## Taxa5  673  656  641  678  649
```

```
conds <- as.character(rdat[,1])
conds
```

```
##   [1] "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"
##  [11] "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"
##  [21] "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"
##  [31] "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"
##  [41] "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"
##  [51] "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"
##  [61] "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"
##  [71] "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"
##  [81] "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"
##  [91] "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"  "Pre"
## [101] "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post"
## [111] "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post"
## [121] "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post"
## [131] "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post"
## [141] "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post"
## [151] "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post"
## [161] "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post"
## [171] "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post"
## [181] "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post"
## [191] "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post" "Post"
```

```
head(flow_data)
```

```
##   sample     flow
## 1      1 29936.10
## 2      1 30014.64
## 3      1 30058.02
## 4      2 29948.05
## 5      2 29989.47
## 6      2 29903.99
```

## 2.3 Incorporating Scale in `ALDEx2`

With all these pieces in hand, we are ready to show how scale can be added to `ALDEx2`. We are going to walk through three different types of total models:

1. The default scale model
2. A measurement-based scale model
3. A knowledge-based scale model

Recall that we know which taxa are truly changing: taxa 3, 4, 15, and 20 and all decrease post-treatmetn. We can use this to understand the performance of the different methods.

### 2.3.1 Default Scale Model

First, we are going to run ALDEx2 as it was originally implemented. This can be achieved by setting `gamma = NULL`.

```
## Original ALDEx2
mod.base <- aldex(Y, conds, gamma = NULL)
mod.base %>% filter(we.eBH < 0.05)
```

```
##           rab.all rab.win.Post rab.win.Pre   diff.btw  diff.win     effect
## Taxa1   2.3912755    2.5108591   2.2775618 -0.2302984 0.1299033 -1.7033698
## Taxa2   2.3883716    2.4994195   2.2793228 -0.2183733 0.1356912 -1.5615886
## Taxa3   2.1949313    2.0953752   2.2845144  0.1872448 0.1387624  1.2898089
## Taxa4   1.9079202    1.5013226   2.2814706  0.7804823 0.1542992  5.0483993
## Taxa5   2.3964038    2.5168518   2.2679577 -0.2496888 0.1342815 -1.7881700
## Taxa6  -0.9332543   -0.8247188  -1.0361052 -0.2107178 0.3799118 -0.5232976
## Taxa7  -0.9170607   -0.7877586  -1.0544415 -0.2762364 0.3648842 -0.7097969
## Taxa8  -0.9161536   -0.8086231  -1.0190018 -0.2060966 0.3435445 -0.5592210
## Taxa9  -0.9416995   -0.8504685  -1.0362113 -0.1831299 0.3727279 -0.4525618
## Taxa10  2.3967732    2.5132308   2.2853830 -0.2284652 0.1307700 -1.6711731
## Taxa11 -0.9278645   -0.8173833  -1.0339064 -0.2165101 0.3698739 -0.5402088
## Taxa12 -0.6026557   -0.5020174  -0.6990276 -0.1971352 0.3224787 -0.5534660
## Taxa13 -0.5814765   -0.4803418  -0.6761836 -0.1993360 0.3166219 -0.5864736
## Taxa14 -0.6298398   -0.5022530  -0.7473381 -0.2409752 0.3384821 -0.6725113
## Taxa15 -1.3665048   -1.8035550  -1.0227525  0.7774025 0.4338860  1.7160990
## Taxa16 -0.9420240   -0.8168634  -1.0614128 -0.2479358 0.3621140 -0.6447765
## Taxa17 -0.9305425   -0.8238628  -1.0381754 -0.2019465 0.3689685 -0.5192989
## Taxa18 -0.9267334   -0.8428131  -1.0111477 -0.1670451 0.3805974 -0.4039469
## Taxa19 -0.9081928   -0.8021613  -1.0137758 -0.2073922 0.3633551 -0.5311980
## Taxa20 -1.8229205   -2.8129815  -1.0719111  1.7387885 0.5226683  3.2865547
##             overlap         we.ep        we.eBH        wi.ep       wi.eBH
## Taxa1  2.959409e-02  0.000000e+00  0.000000e+00 0.000000e+00 0.000000e+00
## Taxa2  4.179165e-02  0.000000e+00  0.000000e+00 0.000000e+00 0.000000e+00
## Taxa3  7.858429e-02  3.023327e-26  1.511663e-25 1.940938e-22 9.704691e-22
## Taxa4  1.403629e-05 1.619157e-105 3.238314e-104 2.523939e-34 2.597396e-33
## Taxa5  2.340002e-02  0.000000e+00  0.000000e+00 0.000000e+00 0.000000e+00
## Taxa6  2.756000e-01  4.436497e-06  5.620445e-06 5.561698e-06 7.076636e-06
## Taxa7  2.131574e-01  1.786623e-10  3.259966e-10 3.964811e-09 6.139630e-09
## Taxa8  2.632000e-01  1.376084e-06  1.770964e-06 4.001917e-07 5.415652e-07
## Taxa9  3.019396e-01  1.239543e-05  1.557504e-05 2.888945e-05 3.634188e-05
## Taxa10 3.659269e-02  0.000000e+00  0.000000e+00 0.000000e+00 0.000000e+00
## Taxa11 2.672000e-01  1.061264e-06  1.337237e-06 1.353834e-06 1.718145e-06
## Taxa12 2.637473e-01  7.235392e-08  9.914199e-08 2.167745e-07 2.997848e-07
## Taxa13 2.532000e-01  7.103181e-08  1.013120e-07 1.384073e-07 1.961405e-07
## Taxa14 2.323535e-01  3.993416e-09  6.489771e-09 7.923991e-09 1.296183e-08
## Taxa15 2.920001e-02  1.017396e-38  6.782637e-38 7.514796e-30 5.009864e-29
## Taxa16 2.313537e-01  5.447004e-09  8.459896e-09 3.274168e-08 4.693197e-08
## Taxa17 2.687463e-01  1.169339e-06  1.479212e-06 2.102545e-06 2.668183e-06
## Taxa18 3.186000e-01  9.883789e-05  1.236069e-04 2.021484e-04 2.528311e-04
## Taxa19 2.679464e-01  1.046769e-06  1.349255e-06 1.339768e-06 1.762261e-06
## Taxa20 2.019711e-04  2.707744e-60  2.707744e-59 2.597396e-34 2.597396e-33
```

Note that all of the taxa are returned as significant. This leads to an elevated false discovery rate (FDR) of 80%!

Next, we are going to recreate these results using the default scale model; this shows that the default scale model behaves as base `ALDEx2` when no appreciable uncertainty is added. To do this, we are going to set \(\gamma\) to some arbitrarily small value. This represents a very minimal level of uncertainty in the CLR assumption. To do this, we set `gamma = 1e-3`.

```
## Recreating ALDEx2
mod.clr <- aldex(Y, conds, gamma = 1e-3)
mod.clr %>% filter(we.eBH < 0.05)
```

```
##           rab.all rab.win.Post rab.win.Pre   diff.btw  diff.win     effect
## Taxa1   2.3927334    2.5094216   2.2778288 -0.2319240 0.1337560 -1.6534397
## Taxa2   2.3887269    2.5006574   2.2801044 -0.2226659 0.1353590 -1.5636425
## Taxa3   2.1952147    2.0943883   2.2842998  0.1877567 0.1403010  1.2795123
## Taxa4   1.8992888    1.5042051   2.2814987  0.7783212 0.1555837  4.9491034
## Taxa5   2.3960455    2.5163713   2.2670419 -0.2492837 0.1323598 -1.8062274
## Taxa6  -0.9305127   -0.8238824  -1.0356374 -0.2054094 0.3724812 -0.5058988
## Taxa7  -0.9212402   -0.7913793  -1.0562570 -0.2755117 0.3706235 -0.6967498
## Taxa8  -0.9169107   -0.8097850  -1.0153291 -0.2024811 0.3540665 -0.5492706
## Taxa9  -0.9428288   -0.8495190  -1.0364631 -0.1951853 0.3773171 -0.4836195
## Taxa10  2.3960734    2.5135181   2.2866072 -0.2278680 0.1306854 -1.6635205
## Taxa11 -0.9251347   -0.8141380  -1.0311344 -0.2265320 0.3622587 -0.5754730
## Taxa12 -0.6039003   -0.5060462  -0.7043970 -0.2028297 0.3230936 -0.5795992
## Taxa13 -0.5828664   -0.4791003  -0.6786755 -0.1959191 0.3150460 -0.5742759
## Taxa14 -0.6265314   -0.5029868  -0.7456939 -0.2400853 0.3448935 -0.6571493
## Taxa15 -1.3720407   -1.8039300  -1.0199915  0.7797116 0.4328234  1.7374273
## Taxa16 -0.9401931   -0.8162312  -1.0618894 -0.2449300 0.3663389 -0.6477525
## Taxa17 -0.9317496   -0.8260698  -1.0376824 -0.2102375 0.3642067 -0.5363647
## Taxa18 -0.9266031   -0.8473545  -1.0100704 -0.1739854 0.3836396 -0.4411311
## Taxa19 -0.9078983   -0.8009619  -1.0187244 -0.2181549 0.3670160 -0.5672829
## Taxa20 -1.8218312   -2.8045691  -1.0692865  1.7268751 0.5175975  3.3136375
##             overlap         we.ep        we.eBH        wi.ep       wi.eBH
## Taxa1  3.180001e-02  0.000000e+00  0.000000e+00 0.000000e+00 0.000000e+00
## Taxa2  4.839033e-02  0.000000e+00  0.000000e+00 0.000000e+00 0.000000e+00
## Taxa3  8.560000e-02  1.060118e-25  5.300588e-25 9.191850e-22 4.595925e-21
## Taxa4  1.403629e-05 3.733108e-103 7.466215e-102 2.523939e-34 2.583502e-33
## Taxa5  2.340002e-02  0.000000e+00  0.000000e+00 0.000000e+00 0.000000e+00
## Taxa6  2.877425e-01  1.749292e-06  2.249413e-06 4.085431e-06 5.185635e-06
## Taxa7  2.148000e-01  6.523621e-11  1.459566e-10 5.214416e-10 1.089771e-09
## Taxa8  2.720000e-01  4.759887e-07  6.179397e-07 5.765662e-07 7.632493e-07
## Taxa9  2.876000e-01  1.522894e-05  1.911011e-05 3.385284e-05 4.246184e-05
## Taxa10 3.700001e-02  0.000000e+00  0.000000e+00 0.000000e+00 0.000000e+00
## Taxa11 2.548000e-01  5.059131e-07  6.484294e-07 8.905462e-07 1.150884e-06
## Taxa12 2.582000e-01  4.342884e-08  6.194524e-08 1.418593e-07 1.978733e-07
## Taxa13 2.544000e-01  8.859288e-08  1.219735e-07 1.498616e-07 2.042649e-07
## Taxa14 2.325535e-01  2.908237e-09  4.632827e-09 6.965760e-09 1.162947e-08
## Taxa15 2.659470e-02  3.066018e-37  2.044012e-36 1.566690e-29 1.044460e-28
## Taxa16 2.329534e-01  1.174744e-09  2.045457e-09 2.972531e-09 5.661660e-09
## Taxa17 2.693461e-01  7.600631e-07  1.006204e-06 8.476663e-07 1.137072e-06
## Taxa18 3.096000e-01  5.922465e-05  7.416751e-05 1.218933e-04 1.530011e-04
## Taxa19 2.640000e-01  7.661076e-07  9.718052e-07 8.112548e-07 1.050211e-06
## Taxa20 2.019711e-04  7.784680e-63  7.784680e-62 2.583502e-34 2.583502e-33
```

To show that the effect sizes are identical, we will plot them from each of the two models above. Note how they fall on a straight line. Any small differences are due to Monte Carlo sampling error.

```
plot(mod.base$effect, mod.clr$effect, xlab = "Original ALDEx2
  Effect Size", ylab = "Minimal Noise Effect Size")
abline(a=0,b=1, col = "red", lty = "dashed")
```

![](data:image/png;base64...)

Next, we will show how adding some noise can greatly improve inference. Let’s set `gamma = .25`.

```
## Adding noise
mod.ss <- aldex(Y, conds, gamma = .25)
mod.ss %>% filter(we.eBH < 0.05)
```

```
##          rab.all rab.win.Post rab.win.Pre  diff.btw  diff.win   effect
## Taxa4   1.665915     1.501595    2.244349 0.7474572 0.3819468 1.811290
## Taxa15 -1.494402    -1.805016   -1.062411 0.7394083 0.5878546 1.203423
## Taxa20 -2.026131    -2.810775   -1.106365 1.7171394 0.6735066 2.512969
##            overlap        we.ep       we.eBH        wi.ep       wi.eBH
## Taxa4  0.027994416 2.343750e-02 2.343750e-02 2.343750e-02 2.343750e-02
## Taxa15 0.086982608 2.446641e-02 3.029690e-02 2.451538e-02 3.062334e-02
## Taxa20 0.001799871 2.925654e-39 5.851307e-38 1.035195e-32 2.044996e-31
```

Remarkably, all false positives are gone! Three of the true positives are still retained.
Note that as \(\gamma \rightarrow \infty\), all taxa will drop out as significant. Basically, if we are unwilling to entertain any statement about the scales, we cannot make any conclusion as to how the absolute abundances are changing between conditions.

```
## Adding more noise
mod.coda <- aldex(Y, conds, gamma = 1)
mod.coda %>% filter(we.eBH < 0.05)
```

```
##  [1] rab.all      rab.win.Post rab.win.Pre  diff.btw     diff.win
##  [6] effect       overlap      we.ep        we.eBH       wi.ep
## [11] wi.eBH
## <0 rows> (or 0-length row.names)
```

### 2.3.2 Measurement-Based Scale Model

Next, we are going to show how we can use outside measurements to create scale models. Here, we will rely on the simulated flow cytometry data. If we let \(z\_{1n}, z\_{2n}, z\_{3n}\) denote the three cytometry measurements from each sample, we are going to specify a scale model of the form:

\[\hat{W}^{\perp (s)}\_{n} \sim N(\text{mean}(z\_{1n}, z\_{2n}, z\_{3n}),\text{var}(z\_{1n}, z\_{2n}, z\_{3n})).\]

First, we need to extract the mean and standard deviation of the measurements for each sample.

```
flow_data_collapse <- flow_data %>%
  group_by(sample) %>%
  mutate(mean = mean(flow)) %>%
  mutate(stdev = sd(flow)) %>%
  select(-flow) %>%
  ungroup() %>%
  unique()
```

Second, we will simulate draws from the scale model for each sample. This generates a matrix with the same number of rows as the number of samples, and the same number of columns as the number of Monte-Carlo samples used by the `aldex()` or `aldex.clr()` functions.

```
scale_samps <- matrix(NA, nrow = 200, ncol = 128)
for(i in 1:nrow(scale_samps)){
  scale_samps[i,] <- rnorm(128, flow_data_collapse$mean[i], flow_data_collapse$stdev[i])
}
```

Finally, we will feed these into the `aldex()` function.

```
mod.flow <- aldex(Y, conds, gamma = scale_samps)
mod.flow %>% filter(we.eBH < 0.05)
```

```
##          rab.all rab.win.Post rab.win.Pre  diff.btw  diff.win   effect
## Taxa3  11.755328    11.549791   11.964213 0.4140175 0.1217297 3.374190
## Taxa4  11.472863    10.957485   11.960633 1.0037117 0.1350277 7.420151
## Taxa15  8.205180     7.651791    8.655887 0.9948794 0.4511426 2.154261
## Taxa20  7.727653     6.654820    8.616480 1.9554390 0.5437673 3.603661
##             overlap         we.ep        we.eBH        wi.ep       wi.eBH
## Taxa3  2.019711e-04  2.352081e-82  2.001973e-81 2.644905e-34 1.762864e-33
## Taxa4  1.403629e-05 6.155416e-128 1.231083e-126 2.523939e-34 1.761338e-33
## Taxa15 8.400049e-03  2.752862e-48  1.376431e-47 5.030757e-33 2.515378e-32
## Taxa20 1.403629e-05  3.022445e-69  2.014963e-68 2.532526e-34 1.761338e-33
```

Here, there are no false positives whereas all true positives are returned as significant.

### 2.3.3 Knowledge-Based Scale Model

For our final scale model, suppose that we do not have access to our flow cytometry measurements, but previous literature and researcher intuition lead us to believe that there is a 10% decrease in the scale after antibiotic administration. We assume that there is also some latent uncertainty and we use the a gamma value that gives the same dispersion as for the relaxed scale model. We can encode this in a full scale model. For this, we can use the `aldex.makeScaleMatrix()` function where we supply a vector of scales and the gamma parameter:

```
# make a per-sample vector of scales
scales <- c(rep(1, 100), rep(0.9, 100))
scale_samps <- aldex.makeScaleMatrix(.15, scales, conds, log=FALSE)
# note 10% difference is about 2^.13
# can exactly replicate the above in log space with:
# scales <- c(rep(.13, 100), rep(0, 100))
# scale_samps <- aldex.makeScaleMatrix(.15,scales, conds, log=TRUE)
```

Passing these samples to the `aldex` function:

```
mod.know <- aldex(Y, conds, gamma = scale_samps)
mod.know %>% filter(we.eBH < 0.05)
```

```
##          rab.all rab.win.Post rab.win.Pre  diff.btw  diff.win   effect
## Taxa3  -2.602811    -2.828928   -2.372456 0.4556672 0.3447155 1.254353
## Taxa4  -2.881775    -3.423988   -2.373754 1.0526871 0.3515972 2.949553
## Taxa15 -6.168570    -6.729135   -5.683971 1.0545158 0.5572115 1.839250
## Taxa20 -6.623337    -7.729156   -5.725843 2.0085129 0.6386044 3.081077
##             overlap        we.ep       we.eBH        wi.ep       wi.eBH
## Taxa3  0.0796000048 6.079872e-26 3.039936e-25 6.400338e-22 3.200169e-21
## Taxa4  0.0010004156 2.589210e-71 5.160949e-70 3.230951e-34 3.283260e-33
## Taxa15 0.0218000187 9.809607e-41 6.539738e-40 2.432288e-30 1.621525e-29
## Taxa20 0.0002020115 2.778496e-66 2.778496e-65 2.715068e-34 3.249969e-33
```

Here we see that even without the outside measurements but knowledge of the difference in scale, there are no false positives whereas all true positives are returned as significant.

### 2.3.4 Comparing the Models

Now, to summarize the results. The original ALDEx2 model can be replicated by including minimal uncertainty in the default scale model. In this simulation, they have an elevated false positive rate due to the lack of uncertainty in their underlying assumptions.

The different methods of addressing scale have different effects on the data. In the base ALDEx2 or the CLR adjustment, we see that *all* the data points are off the midline of no difference in the effect plots. This asymmetry is a major issue when dealing with datasets of different scales. In both the flow and the knowledge-based models the asymmetry in location has been corrected, removing the false positives. We see that even with the increased dispersion in the knowledge-based model relative to the flow model that the true positives are still identified as such.

![](data:image/png;base64...)

Adding a small amount of noise, as seen in the Relaxed model, greatly improves inference at the expense of one false negative. Both the knowledge-based model that assumed a 10% difference and the flow-based model using outside measurements retain the correct results when compared to the ground truth.

```
##
## Attaching package: 'cowplot'
```

```
## The following object is masked from 'package:lubridate':
##
##     stamp
```

![](data:image/png;base64...)

## 2.4 Sensitivity Analyses

Finally, while we believe the default scale model is useful in many situations, it naturally presents the question of how to choose \(\gamma\). While in many situations, we believe that setting \(\gamma = 1\) is appropriate, we realize that many researchers may want to see how their results change as a function of scale uncertainty. To this end, we have included two new functions `aldex.senAnalysis` and `plotGamma` to aid in this task.

First, sensitivity analyses are easy to run using `aldex.senAnalysis`. This function takes two inputs: an `aldex.clr` object and a vector of desired levels of \(\gamma\) to test.

```
gamma_to_test <- c(1e-3, .1, .25, .5, .75, 1, 2, 3, 4, 5)

##Run the CLR function
clr <- aldex.clr(Y, conds)

##Run sensitivity analysis function
sen_res <- aldex.senAnalysis(clr, gamma = gamma_to_test)
```

The output is a list where the elements of the list correspond to the `aldex` output for each value of `gamma` passed. That is, the length of the returned list will equal the length of the vector \(\gamma\).

```
length(sen_res)
```

```
## [1] 10
```

```
length(gamma_to_test)
```

```
## [1] 10
```

```
head(sen_res[[1]])
```

```
##          rab.all rab.win.Post rab.win.Pre   diff.btw  diff.win     effect
## Taxa1  2.3891143    2.5107139    2.278027 -0.2302015 0.1314454 -1.7044343
## Taxa2  2.3895408    2.5004917    2.280654 -0.2197983 0.1340754 -1.5683781
## Taxa3  2.1939318    2.0948622    2.284560  0.1872237 0.1397111  1.3032521
## Taxa4  1.8914067    1.5025529    2.280896  0.7786476 0.1549685  5.0221353
## Taxa5  2.3958850    2.5157566    2.268440 -0.2494649 0.1341125 -1.7969545
## Taxa6 -0.9347604   -0.8239712   -1.036035 -0.2066938 0.3810856 -0.5166913
##            overlap         we.ep        we.eBH        wi.ep       wi.eBH
## Taxa1 2.800001e-02  0.000000e+00  0.000000e+00 0.000000e+00 0.000000e+00
## Taxa2 4.500001e-02  0.000000e+00  0.000000e+00 0.000000e+00 0.000000e+00
## Taxa3 7.600001e-02  2.040875e-27  1.020437e-26 8.347806e-23 4.173903e-22
## Taxa4 1.403629e-05 2.687604e-104 5.375209e-103 2.523939e-34 2.557831e-33
## Taxa5 2.380002e-02  0.000000e+00  0.000000e+00 0.000000e+00 0.000000e+00
## Taxa6 2.804000e-01  1.392023e-06  1.798187e-06 2.699181e-06 3.506958e-06
```

These results can be inspected by the researcher independently or easily be summarized using the `plotGamma` function. For simplicity, we have two returned plots. First, a plot of the percent of significant entities as a function of \(\gamma\). We think that researchers will find this useful to see the drop-out rate across entities. Second, a plot of the effect size by gamma. A separate line is plotted for each entity. The line remains grey if that entity is non-significant based on the corrected p-values at a particular value of \(\gamma\), and is colored if it is significant. The default significance cutoff is `0.05` but can be changed by modifying the `thresh` input.

```
##Plotting
plotGamma(sen_res, thresh = .1)
```

```
## [[1]]
```

![](data:image/png;base64...)

```
##
## [[2]]
```

![](data:image/png;base64...)

## 2.5 Session Info

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
##  [1] cowplot_1.2.0         ggpattern_1.2.1       lubridate_1.9.4
##  [4] forcats_1.0.1         stringr_1.5.2         dplyr_1.1.4
##  [7] purrr_1.1.0           readr_2.1.5           tidyr_1.3.1
## [10] tibble_3.3.0          ggplot2_4.0.0         tidyverse_2.0.0
## [13] ALDEx2_1.42.0         latticeExtra_0.6-31   lattice_0.22-7
## [16] zCompositions_1.5.0-5 survival_3.8-3        truncnorm_1.0-9
## [19] MASS_7.3-65           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                   deldir_2.0-4
##  [3] rlang_1.1.6                 magrittr_2.0.4
##  [5] matrixStats_1.5.0           e1071_1.7-16
##  [7] compiler_4.5.1              png_0.1-8
##  [9] vctrs_0.6.5                 quadprog_1.5-8
## [11] pkgconfig_2.0.3             fastmap_1.2.0
## [13] magick_2.9.0                XVector_0.50.0
## [15] rmarkdown_2.30              tzdb_0.5.0
## [17] tinytex_0.57                xfun_0.53
## [19] Rfast_2.1.5.2               cachem_1.1.0
## [21] jsonlite_2.0.0              DelayedArray_0.36.0
## [23] BiocParallel_1.44.0         jpeg_0.1-11
## [25] parallel_4.5.1              R6_2.6.1
## [27] bslib_0.9.0                 stringi_1.8.7
## [29] RColorBrewer_1.1-3          GenomicRanges_1.62.0
## [31] jquerylib_0.1.4             Rcpp_1.1.0
## [33] Seqinfo_1.0.0               bookdown_0.45
## [35] SummarizedExperiment_1.40.0 knitr_1.50
## [37] directlabels_2025.6.24      IRanges_2.44.0
## [39] Matrix_1.7-4                splines_4.5.1
## [41] timechange_0.3.0            tidyselect_1.2.1
## [43] dichromat_2.0-0.1           abind_1.4-8
## [45] yaml_2.3.10                 codetools_0.2-20
## [47] Biobase_2.70.0              withr_3.0.2
## [49] S7_0.2.0                    evaluate_1.0.5
## [51] sf_1.0-21                   units_1.0-0
## [53] proxy_0.4-27                RcppParallel_5.1.11-1
## [55] pillar_1.11.1               BiocManager_1.30.26
## [57] MatrixGenerics_1.22.0       KernSmooth_2.23-26
## [59] stats4_4.5.1                generics_0.1.4
## [61] S4Vectors_0.48.0            hms_1.1.4
## [63] scales_1.4.0                class_7.3-23
## [65] glue_1.8.0                  tools_4.5.1
## [67] interp_1.1-6                gridpattern_1.3.1
## [69] grid_4.5.1                  cli_3.6.5
## [71] zigg_0.0.2                  S4Arrays_1.10.0
## [73] gtable_0.3.6                sass_0.4.10
## [75] digest_0.6.37               BiocGenerics_0.56.0
## [77] classInt_0.4-11             SparseArray_1.10.0
## [79] farver_2.1.2                memoise_2.0.1
## [81] htmltools_0.5.8.1           multtest_2.66.0
## [83] lifecycle_1.0.4
```

## References

Fernandes, Andrew D, Jean M Macklaim, Thomas G Linn, Gregor Reid, and Gregory B Gloor. 2013. “ANOVA-Like Differential Expression (Aldex) Analysis for Mixed Population Rna-Seq.” *PLoS One* 8 (7): e67019. <https://doi.org/10.1371/journal.pone.0067019>.

Nixon, Michelle P., Jeffrey Letourneau, Lawrence A. David, Nicole A. Lazar, Sayan and Mukherjee, and Justin D. Silverman. 2023. “Scale Reliant Inference.” *ArVix Preprint: 2201.03616*.

Props, Ruben, Frederiek Maarten Kerckhof, Peter Rubbens, Jo De Vrieze, Emma Hernandez Sanabria, Willem Waegeman, Pieter Monsieurs, Frederik Hammes, and Nico Boon. 2017. “Absolute quantification of microbial taxon abundances.” *ISME J.* 11 (2): 584–87. <https://doi.org/10.1038/ismej.2016.117>.

Vandeputte, Doris, Gunter Kathagen, Kevin D’Hoe, Sara Vieira-Silva, Mireia Valles-Colomer, Joaõ Sabino, Jun Wang, et al. 2017. “Quantitative microbiome profiling links gut community variation to microbial load.” *Nature* 551 (7681): 507–11. <https://doi.org/10.1038/nature24460>.