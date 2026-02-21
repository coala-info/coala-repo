# RAREsim Vignette

#### 30 October 2025

# Contents

* [Overview of RAREsim](#overview-of-raresim)
  + [Step (1): Simulate an abundance of rare variants](#step-1-simulate-an-abundance-of-rare-variants)
  + [Step (2): Estimate the expected number of rare variants](#step-2-estimate-the-expected-number-of-rare-variants)
  + [Step (3): Probabilistically prune the rare variants](#step-3-probabilistically-prune-the-rare-variants)
* [Installing the RAREsim Package](#installing-the-raresim-package)
* [RAREsim R package: Estimate expected number of rare variants per MAC bin](#raresim-r-package-estimate-expected-number-of-rare-variants-per-mac-bin)
  + [The *Number of Variants* function](#the-number-of-variants-function)
    - [1) Fitting Target Data](#fitting-target-data)
    - [2) Using Default Parameters](#using-default-parameters)
    - [3) Directly Inputting Parameters](#directly-inputting-parameters)
    - [Total Number of Variants in the Region](#total-number-of-variants-in-the-region)
  + [The *Allele Frequency Spectrum (AFS)* Function](#the-allele-frequency-spectrum-afs-function)
    - [1) Fitting Target Data](#fitting-target-data-1)
    - [2) Using Default Parameters](#using-default-parameters-1)
    - [3) Directly Inputting Parameters](#directly-inputting-parameters-1)
  + [Combining Funcitons to Get Expected Variants](#combining-funcitons-to-get-expected-variants)
* [Session Info](#session-info)

# Overview of RAREsim

This vignette describes how to use the RAREsim R package to estimate the expected distribution of rare variants when simulating rare variant genetic data. The R functions within the package are described in more detail.

A complete simulation example with RAREsim can be found online at the [RAREsim Example Code GitHub page](https://github.com/meganmichelle/RAREsim_Example).

The example below simulates a one cM block on chromosome 19 to match target data from the African ancestry group from gnomAD v2.1 (Karczewski, et al., 2020).

RAREsim has three main steps. Within the RAREsim R package here, we address Step #2.

## Step (1): Simulate an abundance of rare variants

Simulate genetic data with an abundance of rare variants using [HAPGEN2](https://mathgen.stats.ox.ac.uk/genetics_software/hapgen/hapgen2.html) (Su, 2011). By simulating with HAPGEN2 default parameters and input haplotypes with information at all sequencing bases, including monomorphic sites, HAPGEN2 simulates an abundance of rare variants.

An example simulation with HAPGEN2 can be found on the [RAREsim Example Code GitHub page](https://github.com/meganmichelle/RAREsim_Example). The simulation is done using HAPGEN2 default parameters and haplotype files with information at every sequencing base within the region of interest.

After haplotypes are simulated with HAPGEN2, all the bases that are monomorphic in the simulated data will be removed in the haplotype and legend files (see the example code).

A MAC file will be created - a file with a single column counting the number of alternate alleles for that variant. The MAC file will be compared with the expected number of variants per MAC bin in the pruning step.

## Step (2): Estimate the expected number of rare variants

Estimate the expected number of variants in minor allele count (MAC) bins. Users may fit target data, manually enter parameters, or use default parameters to estimate the number of variants per MAC bin.

The number of variants is estimated by combining the *Number of Variants* function and the *Allele Frequency Spectrum (AFS)* function.

## Step (3): Probabilistically prune the rare variants

Probabilistically prune the rare variants to match the estimated number of variants in each MAC bin. RAREsim prunes the simulated variants by returning all or a subset of alternate alleles back to reference.

# Installing the RAREsim Package

To install RAREsim execute the following code or visit <https://bioconductor.org/install/> for instructions.

```
if (!require("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("RAREsim")
```

# RAREsim R package: Estimate expected number of rare variants per MAC bin

The R package here is used for step (2), to estimate the number of rare variants per MAC bin.

## The *Number of Variants* function

For a given region, the *Number of Variants* function estimates the number of variants per Kb, \(f\_{nvariant}(n)\), for a sample size \(n\). Estimating the number of variants can be achieved by 1) fitting target data to estimate parameters, 2) using default parameters, or 3) directly inputting parameters to the function. Additionally, a user may skip this function if they already have an estimate for the total number of variants expected in the region (e.g. 1000 variants).

### 1) Fitting Target Data

Target data is used to estimate \(\phi\) and \(\omega\) to optimize the function \(f\_{nvariant}(n)=\phi n^\omega\) to fit the target data.

The Number of Variants target data consists of various sample sizes (\(n\)) and the observed number of variants per Kb in the region of interest. Ancestry specific data is advised.
Data should be formatted with the first column as the number of individuals (\(n\)) and the second column as the observed number of variants per Kb in the region of interest (\(per\_{kb}\)).

Here we will fit the example target data for the African ancestry population.

```
library(RAREsim)
library(ggplot2)
```

```
# load the target data
data("nvariant_afr")
print(nvariant_afr, row.names  =  FALSE)
```

```
##     n     per_kb
##    10  0.2627568
##    20  0.6831678
##    50  1.5239897
##   100  2.7326712
##   200  4.3092123
##   500  7.6199485
##  1000 12.1919176
##  2000 19.3914551
##  3070 25.2246571
##  5000 33.4226707
##  5040 33.7905302
##  8128 45.1941773
```

The target data is used to estimate \(\phi\) and \(\omega\) within a least squares loss function, optimizing using sequential quadratic programming (SQP). This optimization is implemented via the *fit\_nvariant* function.

```
nvar <- fit_nvariant(nvariant_afr)
```

```
## Warning in slsqp(tune, fn = leastsquares, hin = hin.tune, control =
## list(xtol_rel <- 1e-12)): The old behavior for hin >= 0 has been deprecated.
## Please restate the inequality to be <=0. The ability to use the old behavior
## will be removed in a future release.
```

```
nvar
```

```
## $phi
## [1] 0.1638108
##
## $omega
## [1] 0.6248848
```

The output of the *fit\_nvariant* function are the parameters phi (\(\phi\)) and omega (\(\omega\)), respectively. The estimated parameters can then be used to determine the expected number of variants per Kb, given the number of individuals to be simulated, \(N\_{sim}\).

To visually check the fit of the function, we can plot the target data and the function.

```
plot(nvariant_afr$n, nvariant_afr$per_kb,
     xlab = 'Sample Size', ylab = 'Variants per Kb')
lines(nvariant_afr$n, (nvar$phi*(nvariant_afr$n^nvar$omega)))
```

![](data:image/png;base64...)

To simulate the sample size observed in the target data used here, (\(N\_{sim}=8128\)), we calculate \(\hat{f\_{nvariant}} (N\_{sim}) = \hat{\phi} N\_{sim}^{\hat{\omega}}\). This can be done with the *nvariant* function.

Parameter values estimated from the target data are used here, as well as the sample size.

```
nvariant(phi = nvar$phi, omega = nvar$omega, N = 8128)
```

```
## [1] 45.46027
```

### 2) Using Default Parameters

RAREsim also provides ancestry specific default parameters for phi (\(\phi\)) and omega (\(\omega\)). To use the default parameters, the ancestry must be specified: African (AFR), East Asian (EAS), Non-Finnish European (NFE), or South Asian (SAS).

```
nvariant(N=8128, pop = 'AFR')
```

```
## [1] 43.66395
```

### 3) Directly Inputting Parameters

Finally, parameters can be directly input into the *Number of Variants* function.

```
nvariant(phi = 0.1638108, omega = 0.6248848, N = 8128)
```

```
## [1] 45.46026
```

### Total Number of Variants in the Region

The example data here is a cM block with 19,029 bp. Thus, to calculate the total expected number of variants in the region, we multiple the expected number of variants per Kb by 19.029.

```
19.029*nvariant(nvar$phi, omega = nvar$omega, N = 8128)
```

```
## [1] 865.0634
```

## The *Allele Frequency Spectrum (AFS)* Function

The *AFS* function inputs a MAC (*z*) and outputs the proportion of variants at MAC = z, (\(f\_{afs}(z)\)). This is done by estimating \(\alpha\) and \(\beta\) to optimize the function \(f\_{afs}(z) = \frac{b}{(\beta+z)^{\alpha}}\). Here *b* ensures that the sum of the individual rare allele count proportions equals the total proportion of rare variants, \(p\_{rv}\).

The *AFS* function inputs a data frame with the upper and lower boundaries for each bin and proportion of variants within each respective bin. The default bins used here and within the evaluation of RAREsim are:

MAC = 1
MAC = 2
MAC = 3 - 5
MAC = 6 - 10
MAC = 11 - 20
MAC = 21 - MAF = 0.5%
MAF = 0.5% - MAF = 1%

These are the recommended bins when simulated sample sizes above 3,500.

When simulating sample sizes between 2000 and 3500, the recommended MAC bins are:

MAC = 1
MAC = 2
MAC = 3 - 5
MAC = 6 - MAF = 0.25%
MAF = 0.25% - MAF = 0.5%
MAF = 0.5% - MAF = 1%

If a sample size below 2000 is desired, we recommend simulating 2000 individuals and taking a random sample to reach the desired sample size.

Estimating the AFS can be achieved by 1) fitting target data to estimate parameters, 2) using default parameters, or 3) directly inputting parameters to the function. Additionally, a user may skip this function if they already have an estimate for the proportion of variants in each rare MAC bin.

### 1) Fitting Target Data

Here we will fit the example target data for the African ancestry population. The target data was obtained from the gnomAD v2.1 vcf files.

The first two columns in the target data identify the lower and upper boundaries of each MAC bin. The third column specifies the observed proportion of variants within each MAC bin in the target data.

```
# load the data
data("afs_afr")
print(afs_afr)
```

```
##   Lower Upper       Prop
## 1     1     1 0.50257998
## 2     2     2 0.16305470
## 3     3     5 0.08255934
## 4     6    10 0.05882353
## 5    11    20 0.03715170
## 6    21    81 0.05675955
## 7    82   162 0.01754386
```

The *fit\_afs* function estimates the parameters alpha (\(\alpha\)), beta (\(\beta\)), and \(b\).

```
af <- fit_afs(Observed_bin_props = afs_afr)
```

```
## Warning in slsqp(tune, fn = calc_prob_LS, hin = hin.tune): The old behavior for
## hin >= 0 has been deprecated. Please restate the inequality to be <=0. The
## ability to use the old behavior will be removed in a future release.
```

```
print(af)
```

```
## $alpha
## [1] 1.594622
##
## $beta
## [1] -0.2846474
##
## $b
## [1] 0.297495
##
## $Fitted_results
##   Lower Upper       Prop
## 1     1     1 0.50753380
## 2     2     2 0.12582725
## 3     3     5 0.12226962
## 4     6    10 0.06152310
## 5    11    20 0.04187244
## 6    21    81 0.04709594
## 7    82   162 0.01235050
```

The output includes the estimated parameters alpha (\(\alpha\)), beta (\(\beta\)), and b, as well as the estimated proportion of variants in each MAC bin (Fitted\_results).

To check how well the function is fitting, we can plot the target data with the fitted function.

```
# Label the target and  fitted data
afs_afr$Data <- 'Target Data'
af$Fitted_results$Data <- 'Fitted Function'

# Combine into one data frame
af_all<-rbind(afs_afr, af$Fitted_results)
af_all$Data <- as.factor(af_all$Data)

#plot
ggplot(data = af_all)+
  geom_point( mapping = aes(x= Lower, y= Prop, col = Data))+
  labs(x = 'Lower Limit of MAC Bin',
             y = 'Propoortion of Variants')
```

![](data:image/png;base64...)

### 2) Using Default Parameters

As with the *Number of Variants* function, default parameters can be used to estimate the parameters for the *AFS* function with the *afs* R function. As the default parameters are ancestry specific, the ancestry needs to be specified as pop = ‘AFR’, ‘EAS’, ‘NFE’, or ‘SAS’. The function requires a MAC bin dataframe with the bins specified.

The MAC data frame is the first two columns of the AFS target data.

```
mac <- afs_afr[,c(1:2)]
```

Using the MAC bins as input and specifying an African ancestry, the default parameters are used to estimate the proportion of variants within each bin.

```
afs(mac_bins = mac, pop = 'AFR')
```

```
##   Lower Upper       Prop
## 1     1     1 0.51575451
## 2     2     2 0.12460586
## 3     3     5 0.12032463
## 4     6    10 0.06046027
## 5    11    20 0.04121670
## 6    21    81 0.04656603
## 7    82   162 0.01228838
```

### 3) Directly Inputting Parameters

The *AFS* function can also directly input the parameters alpha, beta, and b.

```
afs(alpha = 1.594622, beta =  -0.2846474, b  = 0.297495, mac_bins = mac)
```

```
##   Lower Upper       Prop
## 1     1     1 0.50753386
## 2     2     2 0.12582721
## 3     3     5 0.12226954
## 4     6    10 0.06152304
## 5    11    20 0.04187238
## 6    21    81 0.04709586
## 7    82   162 0.01235047
```

## Combining Funcitons to Get Expected Variants

Once the total number of variants (*nvariant*) and proportion of variants per bin (*afs*) have been estimated, the expected number of variants per MAC bin can be estimated. An example using the total number of varants and estimated proportion of variants per MAC bin is shown below.

The MAC bin boundaries should be defined based on the sample size that will be simulated.

Continuing our example, we will input the total number of variants we expect in the region (Total\_num\_var = 865.0634) and the estimated proportion of variants per MAC bin (af$Fitted\_results).

```
bin_estimates <- expected_variants(Total_num_var = 865.0634, mac_bin_prop = af$Fitted_results)
print(bin_estimates)
```

```
##   Lower Upper            Data
## 1     1     1 Fitted Function
## 2     2     2 Fitted Function
## 3     3     5 Fitted Function
## 4     6    10 Fitted Function
## 5    11    20 Fitted Function
## 6    21    81 Fitted Function
## 7    82   162 Fitted Function
```

The output of the *expected\_variants* function is the exected number of variants in each MAC bin within the simulation region. This output is input for the pruning function.

The *Number of Variants* and *AFS* function can also be calculated within the *expected\_variants* function.

```
bin_estimates <- expected_variants(Total_num_var =
                                     19.029*nvariant(phi = 0.1638108,
                                                     omega = 0.6248848, N = 8128),
                                   mac_bin_prop = afs(mac_bins = mac, pop = 'AFR'))
print(bin_estimates)
```

```
##   Lower Upper Expected_var
## 1     1     1    446.16029
## 2     2     2    107.79195
## 3     3     5    104.08842
## 4     6    10     52.30196
## 5    11    20     35.65505
## 6    21    81     40.28256
## 7    82   162     10.63023
```

The output from the *expected\_variants* function will be used as input for simulations. See <https://github.com/ryanlayer/raresim> for more details.

# Session Info

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
## [1] ggplot2_4.0.0    RAREsim_1.14.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        jsonlite_2.0.0      dplyr_1.1.4
##  [4] compiler_4.5.1      BiocManager_1.30.26 tidyselect_1.2.1
##  [7] Rcpp_1.1.0          tinytex_0.57        magick_2.9.0
## [10] dichromat_2.0-0.1   jquerylib_0.1.4     scales_1.4.0
## [13] yaml_2.3.10         fastmap_1.2.0       R6_2.6.1
## [16] labeling_0.4.3      generics_0.1.4      knitr_1.50
## [19] tibble_3.3.0        nloptr_2.2.1        bookdown_0.45
## [22] bslib_0.9.0         pillar_1.11.1       RColorBrewer_1.1-3
## [25] rlang_1.1.6         cachem_1.1.0        xfun_0.53
## [28] sass_0.4.10         S7_0.2.0            cli_3.6.5
## [31] withr_3.0.2         magrittr_2.0.4      digest_0.6.37
## [34] grid_4.5.1          lifecycle_1.0.4     vctrs_0.6.5
## [37] evaluate_1.0.5      glue_1.8.0          farver_2.1.2
## [40] rmarkdown_2.30      tools_4.5.1         pkgconfig_2.0.3
## [43] htmltools_0.5.8.1
```