# A systems biology tool for gene regulatory circuit simulation

Vivek Kohar1 and Aidan Tillman2

1The Jackson Laboratory, Bar Harbor, Maine, USA
2Department of Bioengineering, Northeastern University, Boston, Massachusetts, USA

#### 30 October 2025

#### Package

sRACIPE 2.2.0

# 1 Introduction

This document illustrates the use of sRACIPE to simulate any
circuit or network or topology (used interchangeably)
and analyze the generated data. sRACIPE implements a
randomization-based method for gene circuit modeling.
It allows us to study the effect of both the gene expression noise
and the parametric variation on any gene regulatory circuit (GRC)
using only its topology, and simulates an ensemble of models
with random kinetic parameters at multiple noise levels.
Statistical analysis of the generated gene expressions
reveals the basin of attraction and stability of various
phenotypic states and their changes associated with
intrinsic and extrinsic noises. sRACIPE provides a
holistic picture to evaluate the effects of both the
stochastic nature of cellular processes and the parametric variation.

## 1.1 Installation

1. Download the package from Bioconductor.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
BiocManager::install("sRACIPE")
```

Or install the development version of the package.

```
BiocManager::install(“lusystemsbio/sRACIPE”)
```

2. Load the package into R session.

```
library(sRACIPE)
```

For simplicity, we will start with the toggle switch
with mutual inhibition and
self activation of both genes as a test case. Additionally,
to keep the simulations fast, we will use fewer models,
small integration time and longer integration step size.
We recommend using the default settings for most
parameters for actual simulations.

# 2 Load the Circuit

One can use the topology stored in a text file or loaded
as a dataframe. The typical format of the topology
file is a 3 column file where the first column is name of the source gene,
second column is name of the target gene and last column is
the interaction type (1 - TF activation, 2- TF inhibition, 3- activation by
inhibiting degradation, 4- inhibition by activating degradation, 5- signalling
activation, 6- signaling inhibition).
The first line should contain the header (Source Target Interaction).
We will work with a demo circuit from the package.

```
suppressWarnings(suppressPackageStartupMessages(library(sRACIPE)))

# Load a demo circuit
data("demoCircuit")
demoCircuit
```

```
##   Source Target Type
## 1      A      B    2
## 2      B      A    2
## 3      A      A    1
## 4      B      B    1
```

# 3 Simulate the circuit

We will use a reduced number of models (using numModels) for demonstration.
By default, deterministic simulations are run with convergence testing, so we
alter the numConvergenceIter parameter to change how long a simulation lasts.
The simulations will return a RacipeSE object. Convergence data is stored in
the colData of the RacipseSE object and can be retrieved using the
sracipeConverge method.

```
rSet <- sRACIPE::sracipeSimulate(circuit = demoCircuit, numModels = 20,
                             plots = FALSE, integrateStepSize = 0.1,
                             numConvergenceIter = 5)
```

```
## circuit file successfully loaded
```

```
## Generating gene thresholds
```

```
## generating thresholds for uniform distribution1...
```

```
## Running with convergence tests
```

```
## Running the simulations
```

```
## ========================================
```

```
cd <- sracipeConverge(rSet)
```

# 4 Plotting the simulated data

We can plot the simulated data using the sracipePlotData
function or using plots=TRUE
in sracipeSimulate. The data can be normalized before plotting.
Otherwise it will be normalized by the plotting function. By default, two
clusters are identified and models colored according to hierarchical clustering.

```
rSet <- sRACIPE::sracipeNormalize(rSet)
rSet <- sRACIPE::sracipePlotData(rSet, plotToFile = FALSE)
```

![](data:image/png;base64...)

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the sRACIPE package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)![](data:image/png;base64...)

# 5 Multistability analysis

One workflow in deterministic analysis is to simulate multiple initial
conditions for each model and collect the unique steady states of each model
for multistability analysis. This is done in sRACIPE by the sracipeUniqueStates
method, which takes in a RacipeSE object and returns a list of the steady states
for each model. Since the method only considers converged expressions, the
following code may not produce any steady states, so consider trying it with larger
simulations

```
data("demoCircuit")

rSet <- SRACIPE::sracipeSimulate(circuit = demoCircuit, numModels = 10,
                             plots = FALSE, integrateStepSize = 0.1,
                             numConvergenceIter = 5, nIC = 2)
stateLst <- sracipeUniqueStates(rSet)
```

# 6 Knockdown Analysis

The simulations can be used to perform in-silico perturbation analysis.
For example, here we will limit a gene’s production rate to mimic its knockdown
and show how that changes the relative proportion of models in different
clusters.

```
data("demoCircuit")
rSet <- sRACIPE::sracipeSimulate(circuit = demoCircuit,
                             numModels = 50, plots = FALSE,
                             integrateStepSize = 0.1,
                             numConvergenceIter = 5)
```

```
## circuit file successfully loaded
```

```
## Generating gene thresholds
```

```
## generating thresholds for uniform distribution1...
```

```
## Running with convergence tests
```

```
## Running the simulations
```

```
## ========================================
```

```
kd <- sRACIPE::sracipeKnockDown(rSet, plotToFile = FALSE,
                                reduceProduction=50)
```

![](data:image/png;base64...)![](data:image/png;base64...)

# 7 Plot the network

The network can be plotted in an interactive viewer
or html file in the results folder.

```
 sRACIPE::sracipePlotCircuit(rSet, plotToFile = FALSE, physics = TRUE)
```

# 8 Limit Cycle Detection

For deterministic simulations, one can have the simulation check for limit
cycles in the results, although the simulation won’t do this by default. The
demoCircuit we were previously using can’t produce oscillations, so we will have
to call another circuit, the repressilator, which is a loop of 3 genes
inhibiting each other. Limit cycle results are stored in the metadata of the
results, just like the convergence data. Note that with the small number of
models simulated and low number of iterations, this code might not find any
limit cycles in one try. Use a large number of models to guarantee limit cycle
detection.

```
data("repressilator")
rSet <- sRACIPE::sracipeSimulate(circuit = repressilator,
                             numModels = 30, plots = FALSE,
                             integrateStepSize = 0.1,
                             numConvergenceIter = 5,
                             limitcycles = TRUE)
```

```
## circuit file successfully loaded
```

```
## Generating gene thresholds
```

```
## generating thresholds for uniform distribution1...
```

```
## Running with convergence tests
```

```
## Running the simulations
```

```
## ========================================
```

```
##
```

```
## Checking for limit cycles
```

# 9 Gene Clamping Simulations

Clamping a gene is to keep it at a constant value for the entire simulation,
regardless of interactions. This is done by supplying a data.frame to the
geneClamping parameter in sracipeSimulate(), where the columns are genes and
the rows are models. If the user supplies only one value for each clamped gene,
then the gene is clamped to that value for all models.

```
rSet <- sracipeSimulate(circuit = demoCircuit,
                        numConvergenceIter = 5,
                        numModels = 10,
                        integrateStepSize = 0.1,
                        geneClamping = data.frame(A = c(1))
                        )
```

```
## circuit file successfully loaded
```

```
## Generating gene thresholds
```

```
## generating thresholds for uniform distribution1...
```

```
## Running with convergence tests
```

```
## clamped genes: 1,0
```

```
## Running the simulations
```

```
## ========================================
```

# 10 Stochastic simulations

One can perform stochastic simulations similarly by specifying additional
parameters to the sracipeSimulate function, namely, nNoise (the number of noise
levels at which the stochastic simulations should be carried out), initialNoise
(the starting noise level) and noiseScalingFactor (the multiplicative factor by
which noise should be reduced for multiple noise levels).
For annealing, use anneal=TRUE alongwith the above mentioned parameters.
For simulations at one
noise level only, use nNoise = 1 and set initialNoise parameter to the specific
noise.
Since convergence testing is not possible for stochastic simulations, they are
not run and we use the simulationTime parameter to modulate simulation length

Now the returned object will contain additional elements in the
assays which correspond to the
simulations at different noise levels
(noise specified by the name of the element).

```
rSet <- sRACIPE::sracipeSimulate(circuit = demoCircuit, numModels = 20,
                             initialNoise = 15, noiseScalingFactor = 0.1,
                             nNoise = 2,
                             plots = TRUE, plotToFile = FALSE,
                             integrateStepSize = 0.1,
                             simulationTime = 30)
```

```
## circuit file successfully loaded
```

```
## Generating gene thresholds
```

```
## generating thresholds for uniform distribution1...
```

```
## Running the simulations
```

```
## ========================================
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

Here, calling the sracipeSimulate function simulated the circuit at zero noise level
as well as the two (nNoise) other noise levels 15 (initialNoise), 1.5
(initialNoise\*noiseScalingFactor). The first three plots (hierarchical
clustering heatmap, Umap, PCA) correspond to deterministic data and the last
two plots contain the data from stochastic simulations projected on the
principal components of the deterministic simulations.

Note that the rSet now contains stochastic simulations as well as
additional elements like umap, pca, assignedClusters. These are
added when the data is plotted. As mentioned previously,
the additional elements of the assays
are named “15” and “1.5” which correspond to noise levels.

For annealing simulations, one can set anneal=TRUE in the sracipeSimulate function.
With anneal=FALSE (constant noise), simulations at different noise levels are
independent of each other. These are useful if one is primarily interested in
the gene expressions at different noise levels and at zero noise
(used for normalizing the data). With annealing, the steady state solutions
at higher noise levels are used as the intial conditions for lower noise levels
such that each model converges to its most stable state when the noise is zero.

Using annealing, ideally the number of noise levels should be very large
and noiseScalingFactor close to 1 as we want to reduce the noise very slowly.
In practice, we found nNoise ~ 30 and
initialNoise ~50 divided by sqrt(number\_gene)
as good starting values. Constant noise and annealing noise simulations pca
plots can be used for better approximations of these parameters.
The initialNoise should be such that there is a single cluster at this
high noise level (essentially the gene expression values are random and circuit
topology has little effect). Next, noiseScalingFactor should be adjusted such
that there are sufficient noise levels when this single cluster splits into
multiple clusters observed in deterministic simulations.

With annealing,
the models converge to their most stable steady state
at zero noise. Thus, the number of models is more stable clusters
will increase and number in less
stable clusters will decrease. Note that for non zero noise, the stable states
can be different from the stable states at zero noise. In our illustrative
example shown abpve, the previous two stable states of a toggle circuit are no
longer stable at high noise (“15”) and instead the previously unstable high high
state is stable now. Briefly, noise can change the stable states and zero noise
simulations using annealing can

Further, one can modify the parameters and/or initial conditions
and simulate the circuit with
modified parameters and/or initial conditions using the parameters
genParams = FALSE and/or genIC = FALSE.

```
rSet <- sRACIPE::sracipeSimulate(circuit = demoCircuit, numModels = 20,
                             plots = FALSE, integrate = FALSE)
```

```
## circuit file successfully loaded
```

```
## Generating gene thresholds
```

```
## generating thresholds for uniform distribution1...
```

```
## Running with convergence tests
```

```
## Running the simulations
```

```
## ========================================
```

```
params <- sRACIPE::sracipeParams(rSet)
modifiedParams <- as.matrix(params)
modifiedParams[,1] <- 0.1*modifiedParams[,1]
sRACIPE::sracipeParams(rSet) <- DataFrame(modifiedParams)
rSet <- sRACIPE::sracipeSimulate(rSet, plots = FALSE, genParams = FALSE)
```

```
## Running with convergence tests
## Running the simulations
```

```
## ========================================
```

# 11 KnockOut Simulations

Knockout of a gene is implemented by changing the production rate and initial
condition of the gene to zero. The knockOut parameter in the function
sracipeSimulate can be used to perform these knockout simulations. If simulations
are to be carried out for knockouts of different genes, the genes should be
specified as a list where each list element will contain the names of the gene
to be knocked out. For example, knockout = list(“gene1”, “gene2”,
c(“gene3”, “gene4”), “gene5”) will knockout gene1, gene2, gene5 one by one
and knockout gene3 and gene4 simultaneously.
knockOut = “all”, each gene is knocked out one by one and the results are
returned as an element knockOutSimulations which, similar to
stochasticSimulations, is a list of dataframes containing the gene expressions
obtained by knockout one or more genes. Enabling plots=TRUE will plot the
results. As the expression of knockout gene is zero, we compute PCA with
unperturbed genes for both the unperturbed simulations as well as the
perturbed simulations. So for each knockout, we have two plots containing the
scatter plot of unperturbed simulations and perturbed simulations on the PCs of
unperturbed simulations (excluding the gene to be perturbed).

# 12 References

# Appendix

Kohar V, Lu M (2018). “Role of noise and parametric variation in the dynamics of gene regulatory circuits.” npj Systems Biology and Applications, 4, 40. <https://www.nature.com/articles/s41540-018-0076-x>.

# A Session Information

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
##  [1] sRACIPE_2.2.0               Rcpp_1.1.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    dplyr_1.1.4         farver_2.1.2
##  [4] S7_0.2.0            bitops_1.0-9        fastmap_1.2.0
##  [7] digest_0.6.37       lifecycle_1.0.4     magrittr_2.0.4
## [10] compiler_4.5.1      rlang_1.1.6         sass_0.4.10
## [13] rngtools_1.5.2      tools_4.5.1         yaml_2.3.10
## [16] knitr_1.50          labeling_0.4.3      askpass_1.2.1
## [19] S4Arrays_1.10.0     doRNG_1.8.6.2       htmlwidgets_1.6.4
## [22] reticulate_1.44.0   DelayedArray_0.36.0 plyr_1.8.9
## [25] RColorBrewer_1.1-3  abind_1.4-8         KernSmooth_2.23-26
## [28] withr_3.0.2         grid_4.5.1          caTools_1.18.3
## [31] future_1.67.0       ggplot2_4.0.0       globals_0.18.0
## [34] scales_1.4.0        gtools_3.9.5        iterators_1.0.14
## [37] MASS_7.3-65         tinytex_0.57        dichromat_2.0-0.1
## [40] cli_3.6.5           crayon_1.5.3        rmarkdown_2.30
## [43] umap_0.2.10.0       future.apply_1.20.0 RSpectra_0.16-2
## [46] reshape2_1.4.4      visNetwork_2.1.4    cachem_1.1.0
## [49] stringr_1.5.2       parallel_4.5.1      BiocManager_1.30.26
## [52] XVector_0.50.0      vctrs_0.6.5         Matrix_1.7-4
## [55] jsonlite_2.0.0      bookdown_0.45       listenv_0.9.1
## [58] magick_2.9.0        foreach_1.5.2       jquerylib_0.1.4
## [61] glue_1.8.0          parallelly_1.45.1   codetools_0.2-20
## [64] stringi_1.8.7       gtable_0.3.6        doFuture_1.1.2
## [67] tibble_3.3.0        pillar_1.11.1       htmltools_0.5.8.1
## [70] gplots_3.2.0        openssl_2.3.4       R6_2.6.1
## [73] evaluate_1.0.5      lattice_0.22-7      png_0.1-8
## [76] bslib_0.9.0         gridExtra_2.3       SparseArray_1.10.0
## [79] xfun_0.53           pkgconfig_2.0.3
```