# Detecting and correcting batch effects with BEclear

Livia Rasp1\* and Markus Merl

1Center for Bioinformatics, Saarland University, Saarbruecken, Germany

\*Livia.Rasp@gmail.com

#### 2025-10-29

#### Abstract

We show in this tutorial how to use the BEclear package (Akulenko, Merl, and Helms [2016](#ref-Akulenko2016)) to detect and correct
batch effects in methylation data. Even though BEclear was developed for
the use on methylation data, it can also be used to find and correct batch
effects in other kinds of data.
The central method of BEclear is based on Latent Factor Models (Candès and Recht [2009](#ref-Candes2009)), which can in
theory be used on every matrix containing real numbers to predict missing values.

#### Package

BEclear 2.26.0

# 1 Introduction

We guide you through the individual steps of the *[BEclear](https://bioconductor.org/packages/3.22/BEclear)*
package in their own chapters. They will follow in the logical order of an
example of correcting some batch affected DNA methylation data.
This article should only give a small tutorial,
more details about the individual methods can always be found in the help
sections of the *[BEclear](https://bioconductor.org/packages/3.22/BEclear)* package, e.g. through typing
`calcBatchEffects` in the R environment with the package loaded.
To work with the methods contained in the BEclear package, a matrix or
data.frame with genes as row-names and samples as column names as well as a
samples data.frame with the first column named “sample\_id” and the second
column named “batch\_id” is needed as input.

# 2 Installation

*[BEclear](https://bioconductor.org/packages/3.22/BEclear)* is available on Bioconductor. To install it
you can therefore use the *[BiocManager](https://bioconductor.org/packages/3.22/BiocManager)*:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("BEclear")
```

Otherwise you can also install *[BEclear](https://github.com/uds-helms/BEclear)*
from its Github repository by the following command:

```
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
devtools::install_github("uds-helms/BEclear")
```

We however recommend installing it through Bioconductor, as this takes care of
installing the dependencies and furthermore you can refer to the release of
Bioconductor, when using our package, which enables you to reproduce the exact
conditions of your run.

During the compilation of the code, many parts of the software will be automatically
tested for correct execution and reproduction of expected results. This is implemented
in form of unit tests with the help of the *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* package.

When done with the installation you can simply load the package by typing:

```
library(BEclear)
#> Loading required package: BiocParallel
```

# 3 Data

The beta values stored in the ex.data matrix were obtained from level 3 BRCA
data from the TCGA portal (Cancer Genome Atlas Research Network et al. [2013](#ref-TCGA)). Generally, beta values are calculated by
dividing the methylated signal by the sum of the unmethylated and methylated
signals from a DNA methylation microrarray. In the level 3 TCGA data, this
calculation has already been done. The sample data used here contains averaged
beta values of probes that belong to promoter regions of single genes. Another
possibility would be to use beta values of single probes, whereby the probe
names should then be used instead of the gene names as rownames of the matrix.

You can load our sample data via the following command:

```
data("BEclearData")
```

It contains one matrix with the beta values:

```
knitr::kable(ex.data[1:10,1:5], caption = 'Some entries from the example data-set')
```

Table 1: Some entries from the example data-set

|  | s20 | s21 | s22 | s23 | s24 |
| --- | --- | --- | --- | --- | --- |
| ACSM3 | 0.2297873 | 0.2162873 | 0.2071987 | 0.2329269 | 0.2120593 |
| ADAM28 | 0.3435064 | 0.4579607 | 0.3749625 | 0.4205235 | 0.3933762 |
| ADCK1 | 0.2176142 | 0.2120385 | 0.2130803 | 0.2171312 | 0.2143814 |
| AFTPH | 0.0314942 | 0.0306752 | 0.0303586 | 0.0293008 | 0.0236312 |
| AKAP7 | 0.1265222 | 0.0898430 | 0.1638099 | 0.1087261 | 0.1150119 |
| ANKRD24 | 0.0516417 | 0.0427307 | 0.0371261 | 0.0434301 | 0.0430231 |
| ANKRD44 | 0.3431776 | 0.3256014 | 0.2781775 | 0.3132249 | 0.2984070 |
| ANKS4B | 0.5712550 | 0.5467739 | 0.5209191 | 0.6075328 | 0.5419098 |
| APCDD1 | 0.4861491 | 0.4201033 | 0.4405887 | 0.5275998 | 0.4438821 |
| APOBEC3G | 0.3636649 | 0.3301716 | 0.3749334 | 0.3509543 | 0.4406087 |

And one data.frame containing the assignment of samples to batches:

```
knitr::kable(ex.samples[1:10,], caption = 'Some entries from the example sample annotation')
```

Table 2: Some entries from the example sample annotation

| sample\_id | batch\_id |
| --- | --- |
| s20 | b109 |
| s21 | b109 |
| s22 | b109 |
| s23 | b109 |
| s24 | b117 |
| s25 | b117 |
| s26 | b117 |
| s27 | b117 |
| s28 | b117 |
| s29 | b117 |

# 4 Detection of batch effects

For the detection of batch effects we calculate the median difference between the
beta values of a gene in a batch and the values of this gene in all other batches.
Furthermore we use a non-parametric Kolmogorov-Smirnov test (`ks.test`) to compare the
distribution of the beta value for this gene in the batch and the other batches.

If one gene in a batch has a p-value determined by the `ks.test` of less or equal
0.01 and a median difference of greater or equal 0.05 it is considered batch effected.

## 4.1 Detection

For the calculation of the batch effects you just use the `calcBatchEffects` function.
It calculates both median difference and p-value. By default we correct the p-values
by the false discovery rate developed by Benjamini and Hochberg ([1995](#ref-BH)), but you can use all adjustment
methods covered by `p.adjust.methods`.

```
batchEffect <- calcBatchEffects(
  data = ex.data, samples = ex.samples,
  adjusted = TRUE, method = "fdr"
)
#> INFO [2025-10-29 22:42:58] Transforming matrix to data.table
#> INFO [2025-10-29 22:42:58] Calculate the batch effects for 10 batches
#> INFO [2025-10-29 22:42:59] Adjusting p-values
mdifs <- batchEffect$med
pvals <- batchEffect$pval
```

## 4.2 Summary

To see which genes in which batches are effected you use the `calcSummary` function
as follows:

```
summary <- calcSummary(medians = mdifs, pvalues = pvals)
#> INFO [2025-10-29 22:42:59] Generating a summary table
knitr::kable(head(summary), caption = 'Summary over the batch affected gene-sample combination of the example data set')
```

Table 3: Summary over the batch affected gene-sample combination of the example data set

| gene | batch\_id | median | pvalue |
| --- | --- | --- | --- |
| ADAM28 | b136 | 0.2539018 | 0.0003223 |
| AKAP7 | b136 | 0.2236255 | 0.0000298 |
| ANKRD44 | b136 | 0.2578482 | 0.0024103 |
| APCDD1 | b136 | 0.2078392 | 0.0000016 |
| AREG | b136 | 0.3659073 | 0.0001033 |
| BCL2L14 | b136 | 0.2356189 | 0.0058860 |

## 4.3 Scoring

Furthermore you can calculate a batch score for a whole batch to determine the
severity how it is affected.

```
score <- calcScore(ex.data, ex.samples, summary, dir = getwd())
#> INFO [2025-10-29 22:42:59] Calculating the scores for 10 batches
knitr::kable(score, caption = 'Batch scores of the example data-set')
```

Table 4: Batch scores of the example data-set

| batch\_id | count05 | count1 | count2 | count3 | count4 | count5 | count6 | count7 | count8 | count9 | BEscore | dixonPval |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| b109 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0.000 | NA |
| b117 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0.000 | NA |
| b120 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0.000 | NA |
| b124 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0.000 | NA |
| b136 | 10 | 2 | 31 | 7 | 1 | 0 | 0 | 0 | 0 | 0 | 0.752 | 1e-07 |
| b142 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0.000 | NA |
| b155 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0.000 | NA |
| b72 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0.000 | NA |
| b185 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0.000 | NA |
| b61 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0.000 | NA |

# 5 Imputation of missing values

For the imputation of missing values we use a slightly modified version of the
stochastic gradient descent method described by Koren, Bell, and Volinsky ([2009](#ref-Koren2009)).
In this section we will describe our implementation of this method and how to
use it.

We assume that our complete data matrix \(D\_{ij}\) can be described by the effects of
a matrix \(L\_i\), which represents the effect of the features (genes in our case)
and a matrix \(R\_j\) describing the effect of the samples in the following way:

\[\begin{equation}
D\_{ij} = L\_{i}^{T} \times R\_{j} .
\tag{1}
\end{equation}\]

The method can either be run on the complete data set or the data set can be
divided into blocks on which the method is applied.
This division into blocks allows for parallelisation of the method, which can be
useful to speed up the process. We have found that a block-size of 60x60 works
well(Akulenko, Merl, and Helms [2016](#ref-Akulenko2016)).

The error for each block is calculated in the following way:

\[\begin{equation}
errorMatrix\_{ij} = Block\_{ij} - L\_{i}^{T} \times R\_{j} .
\tag{2}
\end{equation}\]

We try to minimize the following loss function through a gradient descent:

\[\begin{equation}
min\_{L, R} \sum\_{ij \in K}(errorMatrix\_{ij}^2) + \lambda \times
(\left\lVert L\_{i}\right\rVert\_{F}^{2} +
\left\lVert R\_{j}\right\rVert\_{F}^{2} ).
\tag{3}
\end{equation}\]
Where \(K\) is the set of tuples \((i,j)\) for which the value is present.
\(\lambda\) is the penalty coefficient, which controls how restrictive the
selection of variables should be. The default of \(\lambda\) is 1.

Another coefficient \(\gamma\) controls the size of the step by which the
two matrices \(L\_i\) and \(R\_j\) are modified. It is initialized
by default with 0.01 and its value changes during the iterations (epochs).

For the first iteration the matrices \(L\_i\) and \(R\_j\) are filled with random values
generated by the `rnorm` function from the *stats*
package and the initial loss and error matrix are calculated.

Then for each iteration the following is done:

* \(L\_i\) and \(R\_j\) are modified proportional by \(\gamma\) through the following
  calculation:

  + \[\begin{equation}
    L\_i = L\_i + 2 \times \gamma \times (errorMatrix\_{ij} \times R\_j - \lambda \times L\_i).
    (\#eq:Lmod)
    \end{equation}\]
  + \[\begin{equation}
    R\_j = R\_j + 2 \times \gamma \times (errorMatrix\_{ij} \times L\_i - \lambda \times R\_j).
    (\#eq:Rmod)
    \end{equation}\]
* Then the new error matrix and loss are calculated.
* If the old loss is smaller than the new one:

  + \(\gamma = \gamma \div 2.\)
* Else:

  + \(\gamma = \gamma \times 1.05.\)

The \(L\_i\) and \(R\_j\) matrices at the end of the last iteration are then used to
impute the missing data. The default number of iterations is 50.

## 5.1 Usage

First you have to set the found batch effect values to NAs. You can do this
by using the `clearBEgenes` function:

```
cleared.data <- clearBEgenes(ex.data, ex.samples, summary)
#> INFO [2025-10-29 22:42:59] Removing values with batch effect:
#> INFO [2025-10-29 22:42:59] 510 values ( 5.1 % of the data) set to NA
```

In case you’re using *[BEclear](https://bioconductor.org/packages/3.22/BEclear)* not for correcting batch
effects, but just for the data imputation, you would have to set the values you
want to impute to NA, if they not already are.

For the data imputation you use the `imputeMissingData` function:

```
library(ids)
corrected.data <- imputeMissingData(cleared.data,
  rowBlockSize = 60,
  colBlockSize = 60, epochs = 50,
  outputFormat = "", dir = getwd()
)
#> INFO [2025-10-29 22:42:59] Starting the imputation of missing values.
#> INFO [2025-10-29 22:42:59] This might take a while.
#> INFO [2025-10-29 22:42:59] BEclear imputation is started:
#> INFO [2025-10-29 22:42:59] block size: 60  x  60
#> INFO [2025-10-29 22:42:59] Impute missing data for block 1 of 4
#> INFO [2025-10-29 22:42:59] Impute missing data for block 2 of 4
#> INFO [2025-10-29 22:42:59] Impute missing data for block 3 of 4
#> INFO [2025-10-29 22:42:59] Impute missing data for block 4 of 4
```

If you set rowBlockSize and colBlockSize to 0 the matrix will not be divided into
block and the gradient descent will be applied to the matrix as a whole.

## 5.2 Replacing values outside the boundaries

Note that sometimes during the prediction, it can happen that values beyond the
boundaries of beta values are returned, that means values smaller than zero or
greater than one. `findWrongValues` simply returns a list of these values,
together with the position in the output matrix, `replaceOutsideValues` corrects
these by simply setting the wrong values to zero or one, respectively. Note that
these methods are especially designed for the prediction of beta values from
DNA methylation data, which only take on values between 0 and 1.

```
corrected.data.valid<-replaceOutsideValues(corrected.data)
#> INFO [2025-10-29 22:42:59] Replacing values below 0 or above 1:
#> INFO [2025-10-29 22:42:59] 0 values replaced
```

In this case there were no values to be replaced.

# 6 Overall correction

Besides the individual methods BEclear also offers an overall method, which
executes all the described previous steps in one call. It also applies some
preprocessing to your data set if necessary.

```
result <- correctBatchEffect(data = ex.data, samples = ex.samples)
#> INFO [2025-10-29 22:42:59] Transforming matrix to data.table
#> INFO [2025-10-29 22:42:59] Calculate the batch effects for 10 batches
#> INFO [2025-10-29 22:43:01] Adjusting p-values
#> INFO [2025-10-29 22:43:01] Generating a summary table
#> INFO [2025-10-29 22:43:01] Calculating the scores for 10 batches
#> INFO [2025-10-29 22:43:01] Removing values with batch effect:
#> INFO [2025-10-29 22:43:01] 510 values ( 5.1 % of the data) set to NA
#> INFO [2025-10-29 22:43:01] Starting the imputation of missing values.
#> INFO [2025-10-29 22:43:01] This might take a while.
#> INFO [2025-10-29 22:43:01] BEclear imputation is started:
#> INFO [2025-10-29 22:43:01] block size: 60  x  60
#> INFO [2025-10-29 22:43:01] Impute missing data for block 1 of 4
#> INFO [2025-10-29 22:43:01] Impute missing data for block 2 of 4
#> INFO [2025-10-29 22:43:01] Impute missing data for block 3 of 4
#> INFO [2025-10-29 22:43:01] Impute missing data for block 4 of 4
#> INFO [2025-10-29 22:43:01] Replacing values below 0 or above 1:
#> INFO [2025-10-29 22:43:01] 0 values replaced
```

Returned is a list containing all results from the executed functions.

# 7 Parallelization

For parallelization we use the *[BiocParellel](https://bioconductor.org/packages/3.22/BiocParellel)* package.
However by default all methods are executed in serial mode.
The methods `CalcBatchEffect`, `imputeMissingData` and `correctBatchEffect`
support parallelization through there parameter `BPPARAM`, which takes a `BiocParallel::BiocParallelParam` class as an argument.

Type the following to get an overview over the supported evaluation environments:

```
?BiocParallel::BiocParallelParam
```

# 8 Plotting

Additionally *[BEclear](https://bioconductor.org/packages/3.22/BEclear)* also includes a method for
plotting the batch effects.
Let us now use the `makeBoxplot` to compare the distributions of the values
in the different samples before and after the batch effect correction:

```
makeBoxplot(ex.data, ex.samples, score,
  bySamples = TRUE,
  col = "standard", main = "Example data", xlab = "Batch",
  ylab = "Beta value", scoreCol = TRUE)
```

![Distribution of the example beta values grouped by sample](data:image/png;base64...)

Figure 1: Distribution of the example beta values grouped by sample

```
makeBoxplot(corrected.data, ex.samples, score,
  bySamples = TRUE,
  col = "standard", main = "Corrected example data",
  xlab = "Batch", ylab = "Beta value", scoreCol = FALSE)
```

![Distribution of the corrected beta values grouped by sample](data:image/png;base64...)

Figure 2: Distribution of the corrected beta values grouped by sample

# Session info

Here is the output of `sessionInfo()` on the system on which this document
was compiled running pandoc 2.7.3:

**R version 4.5.1 Patched (2025-08-23 r88802)**

**Platform:** x86\_64-pc-linux-gnu

**locale:**
*LC\_CTYPE=en\_US.UTF-8*, *LC\_NUMERIC=C*, *LC\_TIME=en\_GB*, *LC\_COLLATE=C*, *LC\_MONETARY=en\_US.UTF-8*, *LC\_MESSAGES=en\_US.UTF-8*, *LC\_PAPER=en\_US.UTF-8*, *LC\_NAME=C*, *LC\_ADDRESS=C*, *LC\_TELEPHONE=C*, *LC\_MEASUREMENT=en\_US.UTF-8* and *LC\_IDENTIFICATION=C*

**attached base packages:**
*stats*, *graphics*, *grDevices*, *utils*, *datasets*, *methods* and *base*

**other attached packages:**
*ids(v.1.0.1)*, *BEclear(v.2.26.0)*, *BiocParallel(v.1.44.0)*, *pander(v.0.6.6)* and *BiocStyle(v.2.38.0)*

**loaded via a namespace (and not attached):**
*Matrix(v.1.7-4)*, *jsonlite(v.2.0.0)*, *futile.logger(v.1.4.3)*, *compiler(v.4.5.1)*, *BiocManager(v.1.30.26)*, *tinytex(v.0.57)*, *Rcpp(v.1.1.0)*, *magick(v.2.9.0)*, *parallel(v.4.5.1)*, *jquerylib(v.0.1.4)*, *uuid(v.1.2-1)*, *yaml(v.2.3.10)*, *fastmap(v.1.2.0)*, *lattice(v.0.22-7)*, *R6(v.2.6.1)*, *knitr(v.1.50)*, *rbibutils(v.2.3)*, *bookdown(v.0.45)*, *openssl(v.2.3.4)*, *bslib(v.0.9.0)*, *rlang(v.1.1.6)*, *cachem(v.1.1.0)*, *xfun(v.0.53)*, *sass(v.0.4.10)*, *cli(v.3.6.5)*, *magrittr(v.2.0.4)*, *formatR(v.1.14)*, *Rdpack(v.2.6.4)*, *futile.options(v.1.0.1)*, *digest(v.0.6.37)*, *grid(v.4.5.1)*, *askpass(v.1.2.1)*, *lifecycle(v.1.0.4)*, *dixonTest(v.1.0.4)*, *evaluate(v.1.0.5)*, *data.table(v.1.17.8)*, *lambda.r(v.1.2.4)*, *codetools(v.0.2-20)*, *abind(v.1.4-8)*, *rmarkdown(v.2.30)*, *tools(v.4.5.1)* and *htmltools(v.0.5.8.1)*

# References

Akulenko, Ruslan, Markus Merl, and Volkhard Helms. 2016. “BEclear: Batch effect detection and adjustment in DNA methylation data.” *PLoS ONE* 11 (8): 1–17. <https://doi.org/10.1371/journal.pone.0159921>.

Benjamini, Yoav, and Yosef Hochberg. 1995. “Controlling the False Discovery Rate: A Practical and Powerful Approach to Multiple Testing.” *Journal of the Royal Statistical Society. Series B (Methodological)* 57 (1): 289–300. <http://www.jstor.org/stable/2346101>.

Cancer Genome Atlas Research Network, John N Weinstein, Eric A Collisson, Gordon B Mills, Kenna R Mills Shaw, Brad A Ozenberger, Kyle Ellrott, Ilya Shmulevich, Chris Sander, and Joshua M Stuart. 2013. “The Cancer Genome Atlas Pan-Cancer analysis project.” *Nature Genetics* 45 (10): 1113–20. <https://doi.org/10.1038/ng.2764>.

Candès, Emmanuel J., and Benjamin Recht. 2009. “Exact Matrix Completion via Convex Optimization.” *Foundations of Computational Mathematics* 9 (6): 717–72. <https://doi.org/10.1007/s10208-009-9045-5>.

Koren, Yehuda, Robert Bell, and Chris Volinsky. 2009. “Matrix Factorization Techniques for Recommender Systems.” *Computer* 42 (8): 30–37. <https://doi.org/10.1109/MC.2009.263>.