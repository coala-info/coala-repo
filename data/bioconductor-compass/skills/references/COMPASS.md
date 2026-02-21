# COMPASS - Combinatorial Polyfunctionality Analysis of Single Cells

\*\*Kevin Ushey, Lynn Lin, and Greg Finak\*\*
\*\*2025-10-29\*\*

## Introduction

Rapid advances in flow cytometry and other single-cell technologies have
enabled high-dimensional, multi-parameter, high-throughput measurements of
individual cells. Numerous questions about cell population heterogeneity can
now be addressed, as these novel technologies permit single-cell analysis of
antigen-specific T-cells. Unfortunately, there is a lack of computational tools
to take full advantage of these complex data.
COMPASS is a statistical framework that enables unbiased analysis of
antigen-specific T-cell subsets. COMPASS uses a Bayesian hierarchical framework
to model all observed cell-subsets and select the most likely to be
antigen-specific while regularizing the small cell counts that often arise in
multi-parameter space. The model provides a posterior probability of
specificity for each cell subset and each sample, which can be used to profile
a subject’s immune response to external stimuli such as infection or
vaccination.

## Example

We will use a simulated dataset to illustrate the use of the `COMPASS` package.

First, we will outline the components used to construct the `COMPASSContainer`,
the data structure used to hold data from an ICS experiment. We will first
initialize some parameters used in generating the simulated data.

```
library(COMPASS)
set.seed(123)
n <- 100 ## number of samples
k <- 6 ## number of markers

sid_vec <- paste0("sid_", 1:n) ## sample ids; unique names used to denote samples
iid_vec <- rep_len( paste0("iid_", 1:(n/10) ), n ) ## individual ids
```

The `COMPASSContainer` is built out of three main components: the **data**,
the total **counts**, and the **metadata**. We will describe the R structure
of these components next.

### data

This is a list of matrices, with each matrix
representing a population of cells drawn from a particular sample. Each row is an
individual cell, each column is a marker (cytokine), and each matrix element is an intensity measure associated
with a particular cell and marker. Only cells that express at least one
marker are included.

```
data <- replicate(n, {
  nrow <- round(runif(1) * 1E4 + 1000)
  ncol <- k
  vals <- rexp( nrow * ncol, runif(1, 1E-5, 1E-3) )
  vals[ vals < 2000 ] <- 0
  output <- matrix(vals, nrow, ncol)
  output <- output[ apply(output, 1, sum) > 0, ]
  colnames(output) <- paste0("M", 1:k)
  return(output)
})
names(data) <- sid_vec
head( data[[1]] )
```

```
##            M1       M2       M3       M4       M5       M6
## [1,]    0.000 2989.978    0.000 2121.293    0.000 3119.056
## [2,]    0.000 2631.113    0.000 3423.290 3559.051    0.000
## [3,]    0.000 2970.300    0.000 3520.768    0.000 3351.278
## [4,]    0.000    0.000 3004.248    0.000    0.000    0.000
## [5,]    0.000    0.000 2364.512    0.000 5174.260 3715.566
## [6,] 3449.089    0.000    0.000    0.000    0.000    0.000
```

### counts

This is a named integer vector, denoting the total number of cells that were
recovered from each sample in `data`.

```
counts <- sapply(data, nrow) + round( rnorm(n, 1E4, 1E3) )
counts <- setNames( as.integer(counts), names(counts) )
head(counts)
```

```
## sid_1 sid_2 sid_3 sid_4 sid_5 sid_6
## 12911 15610 17694 17256 11453 12499
```

### metadata

This is a `data.frame` that associates metadata information with each sample
available in `data` / `counts`. We will suppose that each sample was
subject to one of two treatments named `Control` and `Treatment`.

```
meta <- data.frame(
  sid=sid_vec,
  iid=iid_vec,
  trt=sample( c("Control", "Treatment"), n, TRUE )
)
head(meta)
```

```
##     sid   iid       trt
## 1 sid_1 iid_1   Control
## 2 sid_2 iid_2   Control
## 3 sid_3 iid_3 Treatment
## 4 sid_4 iid_4 Treatment
## 5 sid_5 iid_5   Control
## 6 sid_6 iid_6 Treatment
```

Once we have these components, we can construct the `COMPASSContainer`:

```
CC <- COMPASSContainer(
  data=data,
  counts=counts,
  meta=meta,
  individual_id="iid",
  sample_id="sid"
)
```

We can see some basic information about our `COMPASSContainer`:

```
CC
```

```
## A COMPASSContainer with 100 samples from 10 individuals, containing data across 6 markers.
```

```
summary(CC)
```

```
## A COMPASSContainer with 100 samples from 10 individuals, containing data across 6 markers.
## The metadata describes 3 variables on 100 samples. The columns are:
##
## 	sid iid trt
```

![plot of chunk CC-basics](data:image/png;base64...)

Fitting the `COMPASS` model is very easy once the data has been inserted into
the `COMPASSContainer` object. To specify the model, the user needs to specify
the criteria that identify samples that received a positive stimulation, and
samples that received a negative stimulation. In our data, we can specify it
as follows. (Because MCMC is used to sample the posterior and that is a slow
process, we limit ourselves to a small number of iterations for the purposes
of this vignette.)

`COMPASS` is designed to give verbose output with the model fitting statement,
in order for users to compare expectations in their data to what the `COMPASS`
model fitting function is doing, in order to minimize potential errors.

```
fit <- COMPASS( CC,
  treatment=trt == "Treatment",
  control=trt == "Control",
  iterations=100
)
```

```
## There are a total of 57 samples from 10 individuals in the 'treatment' group.
```

```
## There are multiple samples per individual; these will be aggregated.
```

```
## There are a total of 43 samples from 10 individuals in the 'control' group.
```

```
## There are multiple samples per individual; these will be aggregated.
```

```
## The model will be run on 10 paired samples.
```

```
## The category filter did not remove any categories.
```

```
## There are a total of 64 categories to be tested.
```

```
## Initializing parameters...
```

```
## Computing initial parameter estimates...
```

```
## Keeping 100 iterations. We'll thin every 8 iterations.
```

```
## Burnin for 100 iterations...
```

```
## Sampling 800 iterations...
```

```
## Done!
```

```
## Computing the posterior difference in proportions, posterior log ratio...
```

```
## Done!
```

After fitting the `COMPASS` model, we can examine the output in many ways:

```
## Extract the functionality, polyfunctionality scores as described
## within the COMPASS paper -- these are measures of the overall level
## of 'functionality' of a cell, which has shown to be correlated with
## a cell's affinity in immune response
FS <- FunctionalityScore(fit)
PFS <- PolyfunctionalityScore(fit)

## Obtain the posterior difference, posterior log ratio from a COMPASSResult
post <- Posterior(fit)

## Plot a heatmap of the mean probability of response, to visualize differences
## in expression for each category
plot(fit)
```

```
## The 'threshold' filter has removed 10 categories:
## M1&!M2&!M3&!M4&M5&!M6, !M1&M2&!M3&!M4&M5&!M6, !M1&M2&!M3&!M4&!M5&M6, !M1&!M2&M3&!M4&!M5&M6, !M1&!M2&!M3&M4&!M5&M6, M1&M2&!M3&M4&!M5&!M6, !M1&M2&M3&!M4&M5&!M6, M1&!M2&M3&!M4&!M5&M6, M1&!M2&!M3&M4&!M5&M6, !M1&M2&M3&!M4&M5&M6
```

![plot of chunk COMPASS-examine](data:image/png;base64...)

```
## Visualize the posterior difference, log difference with a heatmap
plot(fit, measure=PosteriorDiff(fit), threshold=0)
```

```
## The 'threshold' filter has removed 10 categories:
## M1&!M2&!M3&!M4&M5&!M6, !M1&M2&!M3&!M4&M5&!M6, !M1&M2&!M3&!M4&!M5&M6, !M1&!M2&M3&!M4&!M5&M6, !M1&!M2&!M3&M4&!M5&M6, M1&M2&!M3&M4&!M5&!M6, !M1&M2&M3&!M4&M5&!M6, M1&!M2&M3&!M4&!M5&M6, M1&!M2&!M3&M4&!M5&M6, !M1&!M2&!M3&!M4&!M5&!M6
```

![plot of chunk COMPASS-examine](data:image/png;base64...)

```
plot(fit, measure=PosteriorLogDiff(fit), threshold=0)
```

```
## The 'threshold' filter has removed 10 categories:
## M1&!M2&!M3&!M4&M5&!M6, !M1&M2&!M3&!M4&M5&!M6, !M1&M2&!M3&!M4&!M5&M6, !M1&!M2&M3&!M4&!M5&M6, !M1&!M2&!M3&M4&!M5&M6, M1&M2&!M3&M4&!M5&!M6, !M1&M2&M3&!M4&M5&!M6, M1&!M2&M3&!M4&!M5&M6, M1&!M2&!M3&M4&!M5&M6, !M1&!M2&!M3&!M4&!M5&!M6
```

![plot of chunk COMPASS-examine](data:image/png;base64...)

`COMPASS` also packages a Shiny application for interactive visualization of
the fits generated by a `COMPASS` call. These can be easily generated through
a call to the `shinyCOMPASS` function.

```
shinyCOMPASS(fit, stimulated="Treatment", unstimulated="Control")
```

## Interoperation with flowWorkspace

`flowWorkspace` is a package used for managing and generating gates for data
obtained from flow cytometry experiments. Combined with `openCyto`, users are
able to automatically gate data through flexibly-defined gating templates.

`COMPASS` comes with a utility function for extracting data from a
`flowWorkspace` `GatingSet` object, providing a seamless workflow between
both data management and analysis for polyfunctionality cytokine data.
Data can be extracted using `COMPASSContainerFromGatingSet`, with appropriate
documentation available in `?COMPASSContainerFromGatingSet`. As an example,
a researcher might first gate his data in order to find `CD4+` cells, and then
gate a number of markers, or cytokines, for these `CD4+` cells, in order to
identify cells expressing different combinations of markers.

Users who have gated their data with `flowJo` and are interested in analyzing
their data with `COMPASS` can do so by first loading and parsing their
workspace with `flowWorkspace`, and next generating the `COMPASSContainer`
through `COMPASSContainerFromGatingSet`.

## Citations

Lin, L. Finak, G. Ushey, K. Seshadri C. et al. COMPASS identifies T-cell subsets correlated with clinical outcomes. Nature biotechnology (2015). doi:10.1038/nbt.3187

Greg Finak, Andrew McDavid, Pratip Chattopadhyay, Maria Dominguez, Steve De Rosa, Mario Roederer, Raphael Gottardo. Mixture models for single-cell assays with applications to vaccine studies. Biostatistics 2014 Jan;15(1):87-101

h