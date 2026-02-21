# SummarizedBenchmark

Patrick K. Kimes, Alejandro Reyes

#### *20 January 2019*

#### Abstract

“When performing a data analysis in R, users are often presented with multiple packages and methods for accomplishing the same task. Benchmarking the performance of these different methods on real and simulated data sets is a common way of learning the relative strengths and weaknesses of each approach. However, as the number of tools and parameters increases, keeping track of output and how it was generated can quickly becomes messy. The `SummarizedBenchmark` package provides a framework for organizing benchmark comparisons, making it easier to both reproduce the original benchmark and replicate the comparison with new data. This vignette introduces the general approach and features of the package using two examples. SummarizedBenchmark package version: 2.0.1”

#### Package

SummarizedBenchmark 2.0.1

# Contents

* [1 Introduction](#introduction)
  + [1.1 Related Work](#related-work)
* [2 Quickstart Case Study](#quickstart-case-study)
* [3 Class Details](#class-details)
  + [3.1 BenchDesign](#benchdesign)
  + [3.2 SummarizedBenchmark](#summarizedbenchmark)
  + [3.3 Reproducibility and Replicability](#reproducibility-and-replicability)
* [4 Differential Expression Case Study](#differential-expression-case-study)
  + [4.1 Benchmark Set-Up and Execution](#benchmark-set-up-and-execution)
  + [4.2 Benchmark Evaluation](#benchmark-evaluation)
* [5 Additional Features](#additional-features)
  + [5.1 Reusing a BenchDesign Across Data Sets](#reusing-a-benchdesign-across-data-sets)
  + [5.2 Storing Multiple Outputs](#storing-multiple-outputs)
  + [5.3 Parallelizing with BiocParallel](#parallelizing-with-biocparallel)
    - [5.3.1 Across Methods](#across-methods)
    - [5.3.2 Across Datasets](#across-datasets)
  + [5.4 Updating Analyses](#updating-analyses)
  + [5.5 Error Handling](#error-handling)
  + [5.6 Specifying Method Metadata](#specifying-method-metadata)
  + [5.7 Specifying Version Metadata](#specifying-version-metadata)
  + [5.8 Modifying Methods in a BenchDesign](#modifying-methods-in-a-benchdesign)
  + [5.9 Duplicating Methods in a BenchDesign](#duplicating-methods-in-a-benchdesign)
* [References](#references)

# 1 Introduction

With `SummarizedBenchmark`, a complete benchmarking workflow is comprised of three primary components:

1. data,
2. methods, and
3. performance metrics.

The first two (*data* and *methods*) are necessary for carrying out the benchmark experiment, and the last (*performance metrics*) is essential for evaluating the results of the experiment. Following this approach, the `SummarizedBenchmark` package defines two primary types of objects: *BenchDesign* objects and *SummarizedBenchmark* objects. *BenchDesign* objects contain only the design of the benchmark experiment, namely the *data* and *methods*, where a *method* is defined as the combination of a function or algorithm and parameter settings. After constructing a *BenchDesign*, the experiment is executed to create a *SummarizedBenchmark* containing the results of applying the methods to the data. *SummarizedBenchmark* objects extend the Bioconductor `SummarizedExperiment` class, with the additional capability of working with *performance metrics*.

The basic framework is illustrated in the figure below. A *BenchDesign* is created with *methods* and combined with *data* to create a *SummarizedBenchmark*, which contains the output of applying the methods to the data. This output is then paired with *performance metrics* specified by the user. Note that the same *BenchDesign* can be combined with several data sets to produce several *SummarizedBenchmark* objects with the corresponding outputs. For convenience, several default *performance metrics* are implemented in the package, and can be added to *SummarizedBenchmark* objects using simple commands.

![basic benchmarking class relationship](data:image/png;base64...)

basic benchmarking class relationship

In this vignette, we first illustrate the basic use of both the *BenchDesign* and *SummarizedBenchmark* classes with a simple comparison of methods for p-value correction in the context of multiple hypothesis testing. Then, we describe more advanced features of the package with a case study comparing three methods for differential expression analysis.

## 1.1 Related Work

Other frameworks for benchmarking methods include *[iCOBRA](https://bioconductor.org/packages/3.8/iCOBRA)* (a package for comparing results of *“binary classification and ranking methods”* with a Shiny web application for interactive analyses), *[rnaseqcomp](https://bioconductor.org/packages/3.8/rnaseqcomp)* (a package for comparing results of RNA-seq quantification pipelines), and *[dsc](https://github.com/stephenslab/dsc)* (a framework for *“managing computational benchmarking experiments that compare several competing methods”* written in Python but capable of running methods implemented in both Python and R).

# 2 Quickstart Case Study

```
library("SummarizedBenchmark")
library("magrittr")
```

To illustrate the basic use of the *BenchDesign* class, we use the `tdat` data set included with this package.

```
data(tdat)
```

The data set is a *data.frame* containing the results of 50 two-sample t-tests. The tests were performed using independently simulated sets of 20 observations drawn from a single standard Normal distribution (when `H = 0`) or two mean-shifted Normal distributions (when `H = 1`).

```
head(tdat)
```

```
##   H test_statistic effect_size         pval        SE
## 1 1     -3.2083437 -1.17151466 4.872282e-03 0.3651463
## 2 0      0.1692236  0.07321912 8.675080e-01 0.4326768
## 3 1     -5.7077940 -1.81715381 2.061521e-05 0.3183636
## 4 1     -1.9805856 -1.09107836 6.313031e-02 0.5508867
## 5 1     -1.0014358 -0.37726058 3.298895e-01 0.3767197
## 6 1     -0.9190433 -0.47583669 3.702252e-01 0.5177522
```

Several approaches have been proposed and implemented to compute *adjusted p-values* and *q-values* with the goal of controlling the total number of false discoveries across a collection of tests. In this example, we compare three such methods:

1. Bonferroni correction (`p.adjust` w/ `method = "bonferroni"`) (Dunn 1961),
2. Benjamini-Hochberg (`p.adjust` w/ `method = "BH"`) (Benjamini and Hochberg 1995), and
3. Storey’s FDR q-value (`qvalue::qvalue`) (Storey 2002).

First, consider how benchmarking the three methods might look without the *SummarizedBenchmark* framework.

To compare methods, each is applied to `tdat`, and the results are stored in separate variables.

```
adj_bonf <- p.adjust(p = tdat$pval, method = "bonferroni")

adj_bh <- p.adjust(p = tdat$pval, method = "BH")

qv <- qvalue::qvalue(p = tdat$pval)
adj_qv <- qv$qvalues
```

Since the values of interest are available from the ouput of each method as a vector of length 50 (the number of hypotheses tested), to keep things clean, they can be combined into a single *data.frame*.

```
adj <- cbind.data.frame(adj_bonf, adj_bh, adj_qv)
head(adj)
```

```
##     adj_bonf     adj_bh       adj_qv
## 1 0.24361409 0.02191765 0.0079813228
## 2 1.00000000 0.90365415 0.3290660527
## 3 0.00103076 0.00103076 0.0003753518
## 4 1.00000000 0.12140444 0.0442094809
## 5 1.00000000 0.47127065 0.1716134119
## 6 1.00000000 0.48250104 0.1757029652
```

The *data.frame* of adjusted p-values and q-values can be used to compare the methods, either by directly parsing the table or using a framework like *[iCOBRA](https://bioconductor.org/packages/3.8/iCOBRA)*. Additionally, the *data.frame* can be saved as a `RDS` or `Rdata` object for future reference, eliminating the need for recomputing on the original data.

While this approach can work well for smaller comparisons, it can quickly become overwhelming and unweildy as the number of methods and parameters increases. Furthermore, once each method is applied and the final *data.frame* (`adj`) is constructed, there is no way to determine *how* each value was calculated. While an informative name can be used to “label” each method (as done above), this does not capture the full complexity, e.g. parameters and context, where the function was evaluated. One solution might involve manually recording function calls and parameters in a separate *data.frame* with the hope of maintaining synchrony with the output *data.frame*. However, this is prone to errors, e.g. during fast “copy and paste” operations or additions and deletions of parameter combinations. An alternative (and hopefully better) solution, is to use the framework of the *SummarizedBenchmark* package.

In the *SummarizedBenchmark* approach, a *BenchDesign* is constructed with the data and any number of methods. Optionally, a *BenchDesign* can also be constructed without any data or method inputs. Methods and data can be added or removed from the object modularly in a few different ways, as will be described in the following section. For simplicity, we first show how to construct the *BenchDesign* with just the data set as input. The data object, here `tdat`, must be passed explicitly to the `data =` parameter.

```
b <- BenchDesign(data = tdat)
```

Then, each method of interest can be added to the *BenchDesign* using `addMethod()`.

```
b <- addMethod(bd = b, label = "bonf", func = p.adjust,
               params = rlang::quos(p = pval, method = "bonferroni"))
```

At a minimum, `addMethod()` requires three parameters:

1. `bd`: the *BenchDesign* object to modify,
2. `label`: a character name for the method, and
3. `func`: the function to be called.

After the minimum parameters are specified, any parameters needed by the `func` method should be passed as named parameters, e.g. `p = pval, method = "bonferroni"`, to `params =` as a list of [*quosures*](http://rlang.tidyverse.org/reference/quosure.html) using `rlang::quos(..)`. Notice here that the `pval` wrapped in `rlang::quos(..)` **does not** need to be specified as `tdat$pval` for the function to access the column in the data.frame. For readers familiar with the *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* package, the use of `params = rlang::quos(..)` here should be viewed similar to the use of `aes = aes(..)` in `ggplot2` for mapping between the data and plotting (or benchmarking) parameters.

The process of adding methods can be written more concisely using the pipe operators from the *[magrittr](https://CRAN.R-project.org/package%3Dmagrittr)* package.

```
b <- b %>%
    addMethod(label = "BH",
              func = p.adjust,
              params = rlang::quos(p = pval, method = "BH")) %>%
    addMethod(label = "qv",
              func = qvalue::qvalue,
              params = rlang::quos(p = pval),
              post = function(x) { x$qvalues })
```

For some methods, such as the q-value approach above, it may be necessary to call a “post-processing” function on the primary method to extract the desired output (here, the q-values). This should be specified using the optional `post =` parameter.

Now, the *BenchDesign* object contains three methods. This can be verified either by calling on the object.

```
b
```

```
## BenchDesign ------------------------------------------------
##   benchmark data:
##     type: data
##     names: H, test_statistic, effect_size, pval, SE
##   benchmark methods:
##     method:  bonf; func: p.adjust
##     method:    BH; func: p.adjust
##     method:    qv; func: qvalue::qvalue
```

More details about each method can be seen by using the `printMethods()` function.

```
printMethods(b)
```

```
## bonf -------------------------------------------------------
## BenchDesign Method (BDMethod) ------------------------------
##   method: p.adjust
##     function (p, method = p.adjust.methods, n = length(p)...
##   parameters:
##     p : pval
##     method : "bonferroni"
##   post:
##     none
##   meta:
##     none
## BH ---------------------------------------------------------
## BenchDesign Method (BDMethod) ------------------------------
##   method: p.adjust
##     function (p, method = p.adjust.methods, n = length(p)...
##   parameters:
##     p : pval
##     method : "BH"
##   post:
##     none
##   meta:
##     none
## qv ---------------------------------------------------------
## BenchDesign Method (BDMethod) ------------------------------
##   method: qvalue::qvalue
##     function (p, fdr.level = NULL, pfdr = FALSE, lfdr.out...
##   parameters:
##     p : pval
##   post:
##     default : function (x) { ...
##   meta:
##     none
```

While the bench now includes all the information necessary for performing the benchmarking study, the actual adjusted p-values and q-values have not yet been calculated. To do this, we simply call `buildBench()`. While `buildBench()` does not require any inputs other than the *BenchDesign* object, when the corresponding ground truth is known, the `truthCols =` parameter should be specified. In this example, the `H` column of the `tdat` *data.frame* contains the true null or alternative status of each simulated hypothesis test. Note that if any of the methods are defined in a separate package, they must be installed and loaded *before* running the experiment.

```
sb <- buildBench(b, truthCols = "H")
```

The returned object is a *SummarizedBenchmark* class. The *SummarizedBenchmark* object is an extension of a *SummarizedExperiment* object. The table of adjusted p-values and q-values is contained in a single “assay” of the object with each method added using `addMethod()` as a column with the corresponding `label` as the name.

```
head(assay(sb))
```

```
##            bonf         BH           qv
## [1,] 0.24361409 0.02191765 0.0079813228
## [2,] 1.00000000 0.90365415 0.3290660527
## [3,] 0.00103076 0.00103076 0.0003753518
## [4,] 1.00000000 0.12140444 0.0442094809
## [5,] 1.00000000 0.47127065 0.1716134119
## [6,] 1.00000000 0.48250104 0.1757029652
```

Metadata for the methods is contained in the `colData()` of the same object, with each row corresponding to one method in the comparison.

```
colData(sb)
```

```
## DataFrame with 3 rows and 6 columns
##         func.pkg func.pkg.vers func.pkg.manual     param.p param.method
##      <character>   <character>       <logical> <character>  <character>
## bonf       stats         3.5.2           FALSE        pval "bonferroni"
## BH         stats         3.5.2           FALSE        pval         "BH"
## qv        qvalue        2.14.1           FALSE        pval           NA
##      session.idx
##        <numeric>
## bonf           1
## BH             1
## qv             1
```

In addition to columns for the functions and parameters specified with `addMethod()` (`func, post, label, param.*`), the `colData()` includes several other columns added during the `buildBench()` process. Most notably, columns for the package name and version of `func` if available (`func.pkg`, `func.pkg.vers`).

When available, ground truth data is contained in the `rowData()` of the *SummarizedBenchmark* object.

```
rowData(sb)
```

```
## DataFrame with 50 rows and 1 column
##             H
##     <numeric>
## 1           1
## 2           0
## 3           1
## 4           1
## 5           1
## ...       ...
## 46          0
## 47          1
## 48          0
## 49          1
## 50          1
```

In addition, the *SummarizedBenchmark* class contains an additional slot where users can define performance metrics to evaluate the different methods. Since different benchmarking experiments may require the use of different metrics to evaluate the performance of the methods, the *SummarizedBenchmark* class provides a flexible way to define performance metrics. We can define performance metrics using the function `addPerformanceMetric()` by providing a *SummarizedBenchmark* object, a name of the metric, an assay name, and the function that defines it. Importantly, the function must contain the following two arguments: query (referring to a vector of values being evaluated, i.e. the output of one method) and truth (referring to the vector of ground truths). If further arguments are provided to the performance function, these must contain default values.

For our example, we define the performance metric “TPR” (True Positive Rate) that calculates the fraction of true positives recovered given an alpha value. This performance metric uses the `H` assay of our *SummarizedBenchmark* example object.

```
sb <- addPerformanceMetric(
  object = sb,
  assay = "H",
  evalMetric = "TPR",
  evalFunction = function(query, truth, alpha = 0.1) {
    goodHits <- sum((query < alpha) & truth == 1)
    goodHits / sum(truth == 1)
    }
)

performanceMetrics(sb)[["H"]]
```

```
## $TPR
## function (query, truth, alpha = 0.1)
## {
##     goodHits <- sum((query < alpha) & truth == 1)
##     goodHits/sum(truth == 1)
## }
```

Having defined all the desired performance metrics, the function `estimatePerformanceMetrics()` calculates these for each method. Parameters for the performance functions can be passed here. In the case below, we specify several `alpha =` values to be used for calculating the performance metrics with each function.

```
resWide <- estimatePerformanceMetrics(sb, alpha = c(0.05, 0.1, 0.2))
resWide
```

```
## DataFrame with 3 rows and 9 columns
##         func.pkg func.pkg.vers func.pkg.manual     param.p param.method
##      <character>   <character>       <logical> <character>  <character>
## bonf       stats         3.5.2           FALSE        pval "bonferroni"
## BH         stats         3.5.2           FALSE        pval         "BH"
## qv        qvalue        2.14.1           FALSE        pval           NA
##      session.idx     TPR.1     TPR.2     TPR.3
##        <numeric> <numeric> <numeric> <numeric>
## bonf           1     0.125       0.2     0.225
## BH             1     0.375      0.55     0.625
## qv             1       0.6       0.7       0.9
```

By default, the function above returns a *DataFrame*, where the parameters of the performance function are stored in its `elementMetadata()`.

```
elementMetadata(resWide)
```

```
## DataFrame with 9 rows and 4 columns
##                           colType       assay performanceMetric     alpha
##                       <character> <character>       <character> <numeric>
## func.pkg        methodInformation          NA                NA        NA
## func.pkg.vers   methodInformation          NA                NA        NA
## func.pkg.manual methodInformation          NA                NA        NA
## param.p         methodInformation          NA                NA        NA
## param.method    methodInformation          NA                NA        NA
## session.idx     methodInformation          NA                NA        NA
## TPR.1           performanceMetric           H               TPR      0.05
## TPR.2           performanceMetric           H               TPR       0.1
## TPR.3           performanceMetric           H               TPR       0.2
```

A second possibility is to set the parameter `addColData = TRUE` for these results to be stored in the `colData()` of the *SummarizedBenchmark* object.

```
sb <- estimatePerformanceMetrics(sb,
                                 alpha = c(0.05, 0.1, 0.2),
                                 addColData = TRUE)
colData(sb)
```

```
## DataFrame with 3 rows and 10 columns
##         func.pkg func.pkg.vers func.pkg.manual     param.p param.method
##      <character>   <character>       <logical> <character>  <character>
## bonf       stats         3.5.2           FALSE        pval "bonferroni"
## BH         stats         3.5.2           FALSE        pval         "BH"
## qv        qvalue        2.14.1           FALSE        pval           NA
##      session.idx     TPR.1     TPR.2     TPR.3 pm.session
##        <numeric> <numeric> <numeric> <numeric>  <numeric>
## bonf           1     0.125       0.2     0.225          1
## BH             1     0.375      0.55     0.625          1
## qv             1       0.6       0.7       0.9          1
```

```
elementMetadata(colData(sb))
```

```
## DataFrame with 10 rows and 4 columns
##                                  colType       assay performanceMetric
##                              <character> <character>       <character>
## func.pkg               methodInformation          NA                NA
## func.pkg.vers          methodInformation          NA                NA
## func.pkg.manual        methodInformation          NA                NA
## param.p                methodInformation          NA                NA
## param.method           methodInformation          NA                NA
## session.idx            methodInformation          NA                NA
## TPR.1                  performanceMetric           H               TPR
## TPR.2                  performanceMetric           H               TPR
## TPR.3                  performanceMetric           H               TPR
## pm.session      performanceMetricSession          NA                NA
##                     alpha
##                 <numeric>
## func.pkg               NA
## func.pkg.vers          NA
## func.pkg.manual        NA
## param.p                NA
## param.method           NA
## session.idx            NA
## TPR.1                0.05
## TPR.2                 0.1
## TPR.3                 0.2
## pm.session             NA
```

Finally, if the user prefers tidier formats, by setting the parameter `tidy = TRUE` the function returns a long-formated version of the results.

```
estimatePerformanceMetrics(sb,
                           alpha = c(0.05, 0.1, 0.2),
                           tidy = TRUE)
```

```
##   func.pkg func.pkg.vers func.pkg.manual param.p param.method session.idx
## 1    stats         3.5.2           FALSE    pval "bonferroni"           1
## 2    stats         3.5.2           FALSE    pval         "BH"           1
## 3   qvalue        2.14.1           FALSE    pval         <NA>           1
## 4    stats         3.5.2           FALSE    pval "bonferroni"           1
## 5    stats         3.5.2           FALSE    pval         "BH"           1
## 6   qvalue        2.14.1           FALSE    pval         <NA>           1
## 7    stats         3.5.2           FALSE    pval "bonferroni"           1
## 8    stats         3.5.2           FALSE    pval         "BH"           1
## 9   qvalue        2.14.1           FALSE    pval         <NA>           1
##   pm.session label   key value assay performanceMetric alpha
## 1          1  bonf TPR.1 0.125     H               TPR  0.05
## 2          1    BH TPR.1 0.375     H               TPR  0.05
## 3          1    qv TPR.1 0.600     H               TPR  0.05
## 4          1  bonf TPR.2 0.200     H               TPR  0.10
## 5          1    BH TPR.2 0.550     H               TPR  0.10
## 6          1    qv TPR.2 0.700     H               TPR  0.10
## 7          1  bonf TPR.3 0.225     H               TPR  0.20
## 8          1    BH TPR.3 0.625     H               TPR  0.20
## 9          1    qv TPR.3 0.900     H               TPR  0.20
```

As an alternative to get the same *data.frame* as the previous chunk, we can call the function `tidyUpMetrics()` on the saved results from a *SummarizedBenchmark* object.

```
head(tidyUpMetrics(sb))
```

```
##   func.pkg func.pkg.vers func.pkg.manual param.p param.method session.idx
## 1    stats         3.5.2           FALSE    pval "bonferroni"           1
## 2    stats         3.5.2           FALSE    pval         "BH"           1
## 3   qvalue        2.14.1           FALSE    pval         <NA>           1
## 4    stats         3.5.2           FALSE    pval "bonferroni"           1
## 5    stats         3.5.2           FALSE    pval         "BH"           1
## 6   qvalue        2.14.1           FALSE    pval         <NA>           1
##   pm.session label   key value assay performanceMetric alpha
## 1          1  bonf TPR.1 0.125     H               TPR  0.05
## 2          1    BH TPR.1 0.375     H               TPR  0.05
## 3          1    qv TPR.1 0.600     H               TPR  0.05
## 4          1  bonf TPR.2 0.200     H               TPR  0.10
## 5          1    BH TPR.2 0.550     H               TPR  0.10
## 6          1    qv TPR.2 0.700     H               TPR  0.10
```

For example, the code below extracts the TPR for an alpha of 0.1 for the Bonferroni method.

```
tidyUpMetrics(sb) %>%
  dplyr:::filter(label == "bonf", alpha == 0.1, performanceMetric == "TPR") %>%
  dplyr:::select(value)
```

```
##   value
## 1   0.2
```

# 3 Class Details

Before moving to the second case study, we describe the anatomy of the *BenchDesign* and *SummarizedBenchmark* classes in a little more detail.

## 3.1 BenchDesign

As noted in the previous section, *BenchDesign* objects are composed of a data set and methods. Formally, the methods are stored in the *BenchDesign* as a *BDMethodList* and the data as a *BDData* object. As would be expected, the *BDMethodList* is a list (`List`) of *BDMethod* objects, each containing the definition of a method to be compared in the benchmark experiment. The general structure is illustrated in the figure below.

![BenchDesign class structure](data:image/png;base64...)

BenchDesign class structure

Continuing with the *BenchDesign* constructed in the example above, we can access the list of methods and the data set stored in the object using the `BDMethodList()` and `BDData()` functions.

```
BDMethodList(b)
```

```
## BenchDesign Method List (BDMethodList) ---------------------
## list of 3 methods
##   method:  bonf; func: p.adjust
##   method:    BH; func: p.adjust
##   method:    qv; func: qvalue::qvalue
```

```
BDData(b)
```

```
## BenchDesign Data (BDData) ----------------------------------
##   type: data
##   data:
##    H test_statistic effect_size         pval        SE
## 1  1     -3.2083437 -1.17151466 4.872282e-03 0.3651463
## 2  0      0.1692236  0.07321912 8.675080e-01 0.4326768
## 3  1     -5.7077940 -1.81715381 2.061521e-05 0.3183636
## 4  1     -1.9805856 -1.09107836 6.313031e-02 0.5508867
## 5  1     -1.0014358 -0.37726058 3.298895e-01 0.3767197
## 6  1     -0.9190433 -0.47583669 3.702252e-01 0.5177522
## 7  1     -1.3184486 -0.72750221 2.038846e-01 0.5517866
## 8  1     -3.8492346 -1.47787871 1.175116e-03 0.3839409
## 9  1     -3.4836213 -1.35474550 2.651401e-03 0.3888900
## 10 0      0.6238195  0.25470364 5.405719e-01 0.4082970
##  ... with 30 more rows.
```

The list of methods inherits from the *SimpleList* class, and supports several useful accessor and setter features.

```
BDMethodList(b)[["bonf"]]
```

```
## BenchDesign Method (BDMethod) ------------------------------
##   method: p.adjust
##     function (p, method = p.adjust.methods, n = length(p)...
##   parameters:
##     p : pval
##     method : "bonferroni"
##   post:
##     none
##   meta:
##     none
```

This interface allows for adding new methods by creating a new named entry in the *BDMethodList* of the *BenchDesign* object.

```
BDMethodList(b)[["bonf2"]] <- BDMethodList(b)[["bonf"]]
b
```

```
## BenchDesign ------------------------------------------------
##   benchmark data:
##     type: data
##     names: H, test_statistic, effect_size, pval, SE
##   benchmark methods:
##     method:   bonf; func: p.adjust
##     method:     BH; func: p.adjust
##     method:     qv; func: qvalue::qvalue
##     method:  bonf2; func: p.adjust
```

Methods can also be removed by setting the list value to NULL. An equivalent convenience function, `dropMethod()` also exists for removing methods using syntax similar to `addMethod()`.

```
BDMethodList(b)[["bonf"]] <- NULL
b
```

```
## BenchDesign ------------------------------------------------
##   benchmark data:
##     type: data
##     names: H, test_statistic, effect_size, pval, SE
##   benchmark methods:
##     method:     BH; func: p.adjust
##     method:     qv; func: qvalue::qvalue
##     method:  bonf2; func: p.adjust
```

Each *BDMethod* object in a *BDMethodList* encapsulates a method to be benchmarked. The contents of the object are all of the arguments passed through the `addMethod()` convenience function used in the example above. New *BDMethod* objects can be constructed with the `BDMethod()` constructor, which takes the same input parameters as `addMethod()`.

```
bdm_bonf <- BDMethod(x = p.adjust,
                     params = rlang::quos(p = pval,
                                          method = "bonferroni"))
bdm_bonf
```

```
## BenchDesign Method (BDMethod) ------------------------------
##   method: p.adjust
##     function (p, method = p.adjust.methods, n = length(p)...
##   parameters:
##     p : pval
##     method : "bonferroni"
##   post:
##     none
##   meta:
##     none
```

Directly modifying the *BDMethodList* object provides an alternative approach (aside form using `addMethod()`) to adding methods to a *BenchDesign* object.

```
BDMethodList(b)[["bonf"]] <- bdm_bonf
b
```

```
## BenchDesign ------------------------------------------------
##   benchmark data:
##     type: data
##     names: H, test_statistic, effect_size, pval, SE
##   benchmark methods:
##     method:     BH; func: p.adjust
##     method:     qv; func: qvalue::qvalue
##     method:  bonf2; func: p.adjust
##     method:   bonf; func: p.adjust
```

The *BDData* object is a simple object which only contains two slots, `@type` and `@data`. The `@type` of a *BDData* object can be either `data` or `hash`. If the `@type` is `data`, the `@data` slot is a standard list or data.frame object of raw data. However, if the `@type` is `hash`, then the `@data` slot is just a MD5 hash of some raw data object computed using `digest::digest()`. As described next in Section [3.2](#summarizedbenchmark), *SummarizedBenchmark* objects also contain the *BenchDesign* object used to generate the benchmark results. Often, the original raw data can be large, and saving the full data set as part of the *SummarizedBenchmark* object can be undesirable and unnecessary. While the raw data set is needed during the benchmark experiment, by default, the *BDData* is converted to a MD5 hash beforing stored the *BenchDesign* as part of a *SummarizedBenchmark* object. Using this approach, it is still possible to confirm whether a certain data set was used for a benchmarking experiment without having to store copies of the raw data with every *SummarizedBenchmark*.

Returning to the *BenchDesign* example from above, the *BDData* object of a *BenchDesign* can also be similarly extracted and modified. As with *BDMethod* objects, the data set may be removed by setting the value to NULL.

```
BDData(b) <- NULL
b
```

```
## BenchDesign ------------------------------------------------
##   benchmark data:
##     NULL
##   benchmark methods:
##     method:     BH; func: p.adjust
##     method:     qv; func: qvalue::qvalue
##     method:  bonf2; func: p.adjust
##     method:   bonf; func: p.adjust
```

A new data set can be constructed using the `BDData()` function and used to replace the data set in a *BenchDesign* object.

```
bdd <- BDData(data = tdat)
BDData(b) <- bdd
b
```

```
## BenchDesign ------------------------------------------------
##   benchmark data:
##     type: data
##     names: H, test_statistic, effect_size, pval, SE
##   benchmark methods:
##     method:     BH; func: p.adjust
##     method:     qv; func: qvalue::qvalue
##     method:  bonf2; func: p.adjust
##     method:   bonf; func: p.adjust
```

The helper function `hashBDData()` can be called on either *BDData* or *BenchDesign* objects to convert the data to a MD5 hash. By default, this function is called on the *BenchDesign* object during `buildBench()` before storing the object in the resulting *SummarizedBenchmark*.

```
b <- hashBDData(b)
b
```

```
## BenchDesign ------------------------------------------------
##   benchmark data:
##     type: md5hash
##     MD5 hash: 09867f2696d3178a8f3bc038917042e1
##   benchmark methods:
##     method:     BH; func: p.adjust
##     method:     qv; func: qvalue::qvalue
##     method:  bonf2; func: p.adjust
##     method:   bonf; func: p.adjust
```

We drop the `"bonf2"` method from the object to return to the same set of methods used to generate the *SummarizedBenchmark* object.

```
BDMethodList(b)[["bonf2"]] <- NULL
```

## 3.2 SummarizedBenchmark

As described above, the *SummarizedBenchmark* class builds on the existing *SummarizedExperiment* class and Bioconductor infrastructure. By doing so, saved results are tightly linked to metadata. Thus, it is possible, for example, to easily subset the results without losing references to the respective metadata. For example, the code below extracts the data for only the first two methods.

```
sbSub <- sb[, 1:2]
colData(sbSub)
```

```
## DataFrame with 2 rows and 10 columns
##         func.pkg func.pkg.vers func.pkg.manual     param.p param.method
##      <character>   <character>       <logical> <character>  <character>
## bonf       stats         3.5.2           FALSE        pval "bonferroni"
## BH         stats         3.5.2           FALSE        pval         "BH"
##      session.idx     TPR.1     TPR.2     TPR.3 pm.session
##        <numeric> <numeric> <numeric> <numeric>  <numeric>
## bonf           1     0.125       0.2     0.225          1
## BH             1     0.375      0.55     0.625          1
```

Building on the *SummarizedExperiment* class, in addition to the slot for `performanceMetrics` described above, the *SummarizedBenchmark* class also includes a slot which stores a copy of the *BenchDesign* object used to generate the results with `buildBench()`. The *BenchDesign* can be accessed by simply passing the object to `BenchDesign()`.

```
BenchDesign(sb)
```

```
## BenchDesign ------------------------------------------------
##   benchmark data:
##     type: md5hash
##     MD5 hash: 09867f2696d3178a8f3bc038917042e1
##   benchmark methods:
##     method:  bonf; func: p.adjust
##     method:    BH; func: p.adjust
##     method:    qv; func: qvalue::qvalue
```

Notice, however, unlike the original *BenchDesign* above, the data is stored as a MD5 hash. To prevent bloat when the data set is large, by default, only a MD5 hash computed using `digest::digest()` is stored with the benchmarking results. This behavior can be changed by setting `keepData = TRUE` when calling `buildBench()`, in which case, the complete data set will be stored as part of the *BenchDesign* and *SummarizedBenchmark* objects. A simple helper function, `compareBDData()`, can be used to verify that while the data *type* may be different between the data originally used to construct the *SummarizedBenchmark* and the data stored with the *SummarizedBenchmark*, the referenced data sets are the same (i.e. have matching MD5 hash values).

```
compareBDData(BDData(tdat), BenchDesign(sb))
```

```
## $data
## [1] TRUE
##
## $type
## [1] FALSE
```

Finally, information about the R session where the methods were executed is stored in the metadata of the *SummarizedBenchmark* as an entry in a list called `sessions`. The package supports rerunning benchmark experiments, and for this purpose, each new session is stored as a new entry in the `sessions` list. Since this experiment has only been executed once, the list only has a single entry in the `sessions` list. In addition to storing the session info and list of methods evaluated during the session, the list also keeps track of all parameters in the `buildBench()` call, i.e. `truthCols = "H"`.

```
metadata(sb)$sessions[[1]]
```

```
## $methods
## [1] "bonf" "BH"   "qv"
##
## $results
## $results$bonf
## $results$bonf$default
## [1] "success"
##
##
## $results$BH
## $results$BH$default
## [1] "success"
##
##
## $results$qv
## $results$qv$default
## [1] "success"
##
##
##
## $parameters
## $parameters$truthCols
## [1] "H"
##
## $parameters$ftCols
## NULL
##
## $parameters$sortIDs
## [1] FALSE
##
## $parameters$keepData
## [1] FALSE
##
## $parameters$catchErrors
## [1] TRUE
##
## $parameters$parallel
## [1] FALSE
##
## $parameters$BPPARAM
## class: MulticoreParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bptimeout: 2592000; bpprogressbar: FALSE; bpexportglobals: TRUE
##   bpRNGseed:
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: FORK
##
##
## $sessionInfo
## ─ Session info ────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 3.5.2 (2018-12-20)
##  os       Ubuntu 16.04.5 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2019-01-20
##
## ─ Packages ────────────────────────────────────────────────────────────────
##  package              * version   date       lib source
##  AnnotationDbi          1.44.0    2019-01-20 [2] Bioconductor
##  assertthat             0.2.0     2017-04-11 [2] CRAN (R 3.5.2)
##  backports              1.1.3     2018-12-14 [2] CRAN (R 3.5.2)
##  beeswarm               0.2.3     2016-04-25 [2] CRAN (R 3.5.2)
##  bindr                  0.1.1     2018-03-13 [2] CRAN (R 3.5.2)
##  bindrcpp             * 0.2.2     2018-03-29 [2] CRAN (R 3.5.2)
##  Biobase              * 2.42.0    2019-01-20 [2] Bioconductor
##  BiocGenerics         * 0.28.0    2019-01-20 [2] Bioconductor
##  BiocManager            1.30.4    2018-11-13 [2] CRAN (R 3.5.2)
##  BiocParallel         * 1.16.5    2019-01-20 [2] Bioconductor
##  BiocStyle            * 2.10.0    2019-01-20 [2] Bioconductor
##  biomaRt              * 2.38.0    2019-01-20 [2] Bioconductor
##  bit                    1.1-14    2018-05-29 [2] CRAN (R 3.5.2)
##  bit64                  0.9-7     2017-05-08 [2] CRAN (R 3.5.2)
##  bitops                 1.0-6     2013-08-17 [2] CRAN (R 3.5.2)
##  blob                   1.1.1     2018-03-25 [2] CRAN (R 3.5.2)
##  bookdown               0.9       2018-12-21 [2] CRAN (R 3.5.2)
##  caTools                1.17.1.1  2018-07-20 [2] CRAN (R 3.5.2)
##  checkmate              1.9.1     2019-01-15 [2] CRAN (R 3.5.2)
##  cli                    1.0.1     2018-09-25 [2] CRAN (R 3.5.2)
##  codetools              0.2-16    2018-12-24 [2] CRAN (R 3.5.2)
##  colorspace             1.4-0     2019-01-13 [2] CRAN (R 3.5.2)
##  crayon               * 1.3.4     2017-09-16 [2] CRAN (R 3.5.2)
##  curl                   3.3       2019-01-10 [2] CRAN (R 3.5.2)
##  DBI                    1.0.0     2018-05-02 [2] CRAN (R 3.5.2)
##  DelayedArray         * 0.8.0     2019-01-20 [2] Bioconductor
##  DelayedMatrixStats     1.4.0     2019-01-20 [2] Bioconductor
##  digest               * 0.6.18    2018-10-10 [2] CRAN (R 3.5.2)
##  dplyr                * 0.7.8     2018-11-10 [2] CRAN (R 3.5.2)
##  DT                     0.5       2018-11-05 [2] CRAN (R 3.5.2)
##  edgeR                  3.24.3    2019-01-20 [2] Bioconductor
##  evaluate               0.12      2018-10-09 [2] CRAN (R 3.5.2)
##  fitdistrplus           1.0-11    2018-09-10 [2] CRAN (R 3.5.2)
##  gdata                  2.18.0    2017-06-06 [2] CRAN (R 3.5.2)
##  GenomeInfoDb         * 1.18.1    2019-01-20 [2] Bioconductor
##  GenomeInfoDbData       1.2.0     2018-12-21 [2] Bioconductor
##  GenomicRanges        * 1.34.0    2019-01-20 [2] Bioconductor
##  ggbeeswarm             0.6.0     2017-08-07 [2] CRAN (R 3.5.2)
##  ggplot2              * 3.1.0     2018-10-25 [2] CRAN (R 3.5.2)
##  glue                   1.3.0     2018-07-17 [2] CRAN (R 3.5.2)
##  gplots                 3.0.1     2016-03-30 [2] CRAN (R 3.5.2)
##  gridExtra              2.3       2017-09-09 [2] CRAN (R 3.5.2)
##  gtable                 0.2.0     2016-02-26 [2] CRAN (R 3.5.2)
##  gtools                 3.8.1     2018-06-26 [2] CRAN (R 3.5.2)
##  HDF5Array              1.10.1    2019-01-20 [2] Bioconductor
##  hms                    0.4.2     2018-03-10 [2] CRAN (R 3.5.2)
##  htmltools              0.3.6     2017-04-28 [2] CRAN (R 3.5.2)
##  htmlwidgets            1.3       2018-09-30 [2] CRAN (R 3.5.2)
##  httpuv                 1.4.5.1   2018-12-18 [2] CRAN (R 3.5.2)
##  httr                   1.4.0     2018-12-11 [2] CRAN (R 3.5.2)
##  iCOBRA               * 1.10.0    2019-01-20 [2] Bioconductor
##  IRanges              * 2.16.0    2019-01-20 [2] Bioconductor
##  KernSmooth             2.23-15   2015-06-29 [2] CRAN (R 3.5.2)
##  knitr                  1.21      2018-12-10 [2] CRAN (R 3.5.2)
##  labeling               0.3       2014-08-23 [2] CRAN (R 3.5.2)
##  later                  0.7.5     2018-09-18 [2] CRAN (R 3.5.2)
##  lattice                0.20-38   2018-11-04 [2] CRAN (R 3.5.2)
##  lazyeval               0.2.1     2017-10-29 [2] CRAN (R 3.5.2)
##  limma                  3.38.3    2019-01-20 [2] Bioconductor
##  locfit                 1.5-9.1   2013-04-20 [2] CRAN (R 3.5.2)
##  lsei                   1.2-0     2017-10-23 [2] CRAN (R 3.5.2)
##  magrittr             * 1.5       2014-11-22 [2] CRAN (R 3.5.2)
##  MASS                   7.3-51.1  2018-11-01 [2] CRAN (R 3.5.2)
##  Matrix                 1.2-15    2018-11-01 [2] CRAN (R 3.5.2)
##  matrixStats          * 0.54.0    2018-07-23 [2] CRAN (R 3.5.2)
##  mclust               * 5.4.2     2018-11-17 [2] CRAN (R 3.5.2)
##  memoise                1.1.0     2017-04-21 [2] CRAN (R 3.5.2)
##  mgcv                   1.8-26    2018-11-21 [2] CRAN (R 3.5.2)
##  mime                   0.6       2018-10-05 [2] CRAN (R 3.5.2)
##  munsell                0.5.0     2018-06-12 [2] CRAN (R 3.5.2)
##  nlme                   3.1-137   2018-04-07 [2] CRAN (R 3.5.2)
##  npsurv                 0.4-0     2017-10-14 [2] CRAN (R 3.5.2)
##  pillar                 1.3.1     2018-12-15 [2] CRAN (R 3.5.2)
##  pkgconfig              2.0.2     2018-08-16 [2] CRAN (R 3.5.2)
##  plyr                   1.8.4     2016-06-08 [2] CRAN (R 3.5.2)
##  prettyunits            1.0.2     2015-07-13 [2] CRAN (R 3.5.2)
##  progress               1.2.0     2018-06-14 [2] CRAN (R 3.5.2)
##  promises               1.0.1     2018-04-13 [2] CRAN (R 3.5.2)
##  purrr                  0.2.5     2018-05-29 [2] CRAN (R 3.5.2)
##  qvalue                 2.14.1    2019-01-20 [2] Bioconductor
##  R6                     2.3.0     2018-10-04 [2] CRAN (R 3.5.2)
##  RColorBrewer           1.1-2     2014-12-07 [2] CRAN (R 3.5.2)
##  Rcpp                   1.0.0     2018-11-07 [2] CRAN (R 3.5.2)
##  RCurl                  1.95-4.11 2018-07-15 [2] CRAN (R 3.5.2)
##  readr                * 1.3.1     2018-12-21 [2] CRAN (R 3.5.2)
##  reshape2               1.4.3     2017-12-11 [2] CRAN (R 3.5.2)
##  rhdf5                  2.26.2    2019-01-20 [2] Bioconductor
##  Rhdf5lib               1.4.2     2019-01-20 [2] Bioconductor
##  rlang                * 0.3.1     2019-01-08 [2] CRAN (R 3.5.2)
##  rmarkdown              1.11      2018-12-08 [2] CRAN (R 3.5.2)
##  rnaseqcomp           * 1.12.0    2019-01-20 [2] Bioconductor
##  ROCR                   1.0-7     2015-03-26 [2] CRAN (R 3.5.2)
##  RSQLite                2.1.1     2018-05-06 [2] CRAN (R 3.5.2)
##  S4Vectors            * 0.20.1    2019-01-20 [2] Bioconductor
##  scales                 1.0.0     2018-08-09 [2] CRAN (R 3.5.2)
##  scater                 1.10.1    2019-01-20 [2] Bioconductor
##  scRNAseq             * 1.8.0     2019-01-20 [2] Bioconductor
##  sessioninfo          * 1.1.1     2018-11-05 [2] CRAN (R 3.5.2)
##  shiny                  1.2.0     2018-11-02 [2] CRAN (R 3.5.2)
##  shinyBS                0.61      2015-03-31 [2] CRAN (R 3.5.2)
##  shinydashboard         0.7.1     2018-10-17 [2] CRAN (R 3.5.2)
##  SingleCellExperiment * 1.4.1     2019-01-20 [2] Bioconductor
##  splatter             * 1.6.1     2019-01-20 [2] Bioconductor
##  stringi                1.2.4     2018-07-20 [2] CRAN (R 3.5.2)
##  stringr              * 1.3.1     2018-05-10 [2] CRAN (R 3.5.2)
##  SummarizedBenchmark  * 2.0.1     2019-01-20 [1] Bioconductor
##  SummarizedExperiment * 1.12.0    2019-01-20 [2] Bioconductor
##  survival               2.43-3    2018-11-26 [2] CRAN (R 3.5.2)
##  tibble               * 2.0.1     2019-01-12 [2] CRAN (R 3.5.2)
##  tidyr                * 0.8.2     2018-10-28 [2] CRAN (R 3.5.2)
##  tidyselect             0.2.5     2018-10-11 [2] CRAN (R 3.5.2)
##  tximport             * 1.10.1    2019-01-20 [2] Bioconductor
##  UpSetR               * 1.3.3     2017-03-21 [2] CRAN (R 3.5.2)
##  vipor                  0.4.5     2017-03-22 [2] CRAN (R 3.5.2)
##  viridis                0.5.1     2018-03-29 [2] CRAN (R 3.5.2)
##  viridisLite            0.3.0     2018-02-01 [2] CRAN (R 3.5.2)
##  withr                  2.1.2     2018-03-15 [2] CRAN (R 3.5.2)
##  xfun                   0.4       2018-10-23 [2] CRAN (R 3.5.2)
##  XML                    3.98-1.16 2018-08-19 [2] CRAN (R 3.5.2)
##  xtable                 1.8-3     2018-08-29 [2] CRAN (R 3.5.2)
##  XVector                0.22.0    2019-01-20 [2] Bioconductor
##  yaml                   2.2.0     2018-07-25 [2] CRAN (R 3.5.2)
##  zlibbioc               1.28.0    2019-01-20 [2] Bioconductor
##
## [1] /tmp/RtmpOoxjDr/Rinst70d1733f4579
## [2] /home/biocbuild/bbs-3.8-bioc/R/library
```

## 3.3 Reproducibility and Replicability

While the *BenchDesign* and *SummarizedBenchmark* classes are designed to enable easier reproduction and replication of benchmark experiments, they are not meant to completely replace properly written and documented analyses. If any functions or packages are needed for the methods defined in the *BenchDesign*, they must be available and sourced or loaded when running (or re-running) the analyses. As an example, suppose we have the following locally defined method, `mymethod()`, which depends on another locally defined, but unavailable, function, `mysubmethod()`.

```
mymethod <- function(x) {
    mysubmethod(x)
}
mybd <- BenchDesign(data = list(vals = 1:5))
mybd <- addMethod(mybd, "method1", mymethod,
                  params = rlang::quos(x = vals))
```

The top level `mymethod()` is captured in the corresponding *BDMethod* and *BenchDesign*. No errors are thrown since including `mymethod()` in a *BenchDesign* object does not require evaluating the function.

```
BDMethod(mybd, "method1")@f
```

```
## function(x) {
##     mysubmethod(x)
## }
```

However, when `buildBench()` is called, the method naturally fails because the necessary `mysubmethod()` is not available in the current session.

```
tryCatch({ buildBench(mybd) }, error = function(e) print(e))
```

```
## !! error caught in buildBench !!
## !! error in main function of method: 'method1'
```

```
## !!  original message:
## !!  could not find function "mysubmethod"
```

```
## <simpleError in buildBench(mybd):
## No method returned valid values for any assays!
## >
```

Therefore, if any locally defined functions are necessary for a method, they should be available along with the *BenchDesign* object or defined at the top level. Additionally, for reproducibility and clarity, we generally recommend keeping functions as “self-contained” as possible, and *never* relying on variables defined externally, e.g. in the global enviroment. Scoping with functions can be confusing, and it may not always be clear where constants are being evaluated. As an example, consider the following simple multiplying function.

```
m <- 5
mymult <- function(x) {
    m * x
}
m <- 2

mybd <- BenchDesign(data = list(vals = 1:5, m = 10))
mybd <- addMethod(mybd, "methodr", mymult,
                  params = rlang::quos(x = vals))
```

While experienced R programmers may know which value of `m` (5, 2 or 10) will be used when `buildBench()` is called, for many users, this is less obvious.

```
assay(buildBench(mybd))
```

```
##      methodr
## [1,]       2
## [2,]       4
## [3,]       6
## [4,]       8
## [5,]      10
```

The answer is the value assigned most recently in the environment where `mymult()` was defined, `R_GlobalEnv`, the global environment (`m = 2`). Note, however, that if the *BenchDesign* is saved and reloaded in a new session, whatever value of `m` is defined in the global environment of the new session will be used. If `m` is not defined in the new session, an error will be thrown. In this case, `m` should either be explicitly defined within the function or passed as a second input variable of `mymult()` and defined with `params =` in the *BDMethod*.

While it may be possible to aggressively capture all code and environment variables defined with each method in a *BenchDesign*, it is not within the scope of this package, and furthermore, may not be the best appraoch to constructing a reproducible benchmark. While redundant, for emphasis, we reiterate that the *SummarizedBenchmark* framework is a solution for structuring benchmark experiments which complements, but does not replace, well documented and organized code.

# 4 Differential Expression Case Study

```
library("limma")
library("edgeR")
library("DESeq2")
library("tximport")
```

In this more advanced case study, we use a simulated data set from (Soneson and Robinson 2016) to demonstrate how the *SummarizedBenchmark* package can be used to benchmark methods for differential expression analysis. Namely, we compare the methods implemented in the *[DESeq2](https://bioconductor.org/packages/3.8/DESeq2)*, *[edgeR](https://bioconductor.org/packages/3.8/edgeR)*, and *[limma](https://bioconductor.org/packages/3.8/limma)* packages. The simulated data set includes 6 samples of three replicates each from two conditions. For each sample, transcript-level expression is provided as transcripts per-million (TPM) values for 15,677 transcripts from human chromosome 1 (Ensembl GRCh37.71). A more complete description of the data, including code for how the data ws generated, is available in the Supplementary Materials of (Soneson and Robinson 2016) [here](http://dx.doi.org/10.5256/f1000research.7563.d114722). We provide precomputed objects containing these count and ground truth data.

```
data("soneson2016")
head(txi$counts)
```

```
##                         A1          A2         A3         B1        B2
## ENST00000367770   1.670571   0.8064829   5.472561  58.700418  32.89297
## ENST00000367771 558.834722 458.8887676 662.352695   5.299743  20.73813
## ENST00000367772 155.881534 110.6033685 183.417201   0.000000   0.00000
## ENST00000423670  11.809207  16.4752934  10.426669  20.392491   1.26733
## ENST00000470238  96.489863  34.2755231  32.489730 785.514128 614.71261
## ENST00000286031  12.442872  13.4797855   4.781290   1.152118  20.50770
##                         B3
## ENST00000367770  16.648100
## ENST00000367771  14.862318
## ENST00000367772   0.000000
## ENST00000423670   7.546371
## ENST00000470238 815.123229
## ENST00000286031   5.760588
```

```
head(truthdat)
```

```
## # A tibble: 6 x 13
##   transcript status logFC_cat   logFC avetpm length eff_length   tpm1  tpm2
##   <chr>       <int> <chr>       <dbl>  <dbl>  <int>      <dbl>  <dbl> <dbl>
## 1 ENST00000…      1 [ 3.38,3…   4.17   0.225   2916      2771. 0.0237 0.427
## 2 ENST00000…      1 [ 3.38,3…   5.25   3.20    2921      2776. 6.23   0.164
## 3 ENST00000…      1 Inf       Inf      0.817   3477      3332. 1.63   0
## 4 ENST00000…      1 [ 0.00, …   0.322  0.203   2077      1932. 0.181  0.226
## 5 ENST00000…      1 [ 3.38,3…   4.07   4.08    1538      1393. 0.460  7.71
## 6 ENST00000…      0 [ 0.00, …   0      0.154   4355      4210. 0.154  0.154
## # … with 4 more variables: isopct1 <dbl>, isopct2 <dbl>, gene <chr>,
## #   avetpm_cat <chr>
```

## 4.1 Benchmark Set-Up and Execution

We begin the benchmarking process by creating our *BenchDesign* object with the data set. The *BenchDesign* can be initialized with a *data.frame* (as in the case study above), or more generally, with a list object. In this case study, since methods for differential expression require more than just the expression counts, e.g. the experimental design, we construct a list containing each of these inputs as a named entry.

The scaled TPM values are rounded before passing to the differential expression methods.

```
mycounts <- round(txi$counts)
```

Here, we simply use the the conditions for each sample to define the experimental design. The design matrix is stored as a *data.frame*, `mycoldat`.

```
mycoldat <- data.frame(condition = factor(rep(c(1, 2), each = 3)))
rownames(mycoldat) <- colnames(mycounts)
```

The data object for the benchmark experiment is now constructed with both the counts and the design matrix, along with some ground truth information (“status”: the true presence or absence of differential expression between conditions, and “lfc”: the expected log-fold change between conditions).

```
mydat <- list(coldat = mycoldat,
              cntdat = mycounts,
              status = truthdat$status,
              lfc = truthdat$logFC)
```

As before, the *BenchDesign* is constructed with the data as the sole input.

```
bd <- BenchDesign(data = mydat)
```

For simplicity, we focus on comparing only the p-values returned by each method after testing for differential expression between the two conditions. However, later in this vignette, we also show how multiple metrics (p-values and log-fold change) can be compared in a single *BenchDesign* object.

Since each method requires running multiple steps, we write wrapper functions which return only the vector of p-values for each method.

```
deseq2_pvals <- function(countData, colData, design, contrast) {
    dds <- DESeqDataSetFromMatrix(countData,
                                  colData = colData,
                                  design = design)
    dds <- DESeq(dds)
    res <- results(dds, contrast = contrast)
    res$pvalue
}

edgeR_pvals <- function(countData, group, design) {
    y <- DGEList(countData, group = group)
    y <- calcNormFactors(y)
    des <- model.matrix(design)
    y <- estimateDisp(y, des)
    fit <- glmFit(y, des)
    lrt <- glmLRT(fit, coef=2)
    lrt$table$PValue
}

voom_pvals <- function(countData, group, design) {
    y <- DGEList(countData, group = group)
    y <- calcNormFactors(y)
    des <- model.matrix(design)
    y <- voom(y, des)
    eb <- eBayes(lmFit(y, des))
    eb$p.value[, 2]
}
```

Next, each method is added to the *BenchDesign* using `addMethod()`, and the corresponding wrapper function passed as `func`. (For a review of the basic usage of `addMethod()`, revisit Section [2](#quickstart-case-study).) We again use the pipe notation for compactness.

```
bd <- bd %>%
    addMethod(label = "deseq2",
              func = deseq2_pvals,
              params = rlang::quos(countData = cntdat,
                                   colData = coldat,
                                   design = ~condition,
                                   contrast = c("condition", "2", "1"))
              ) %>%
    addMethod(label = "edgeR",
              func = edgeR_pvals,
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              ) %>%
    addMethod(label = "voom",
              func = voom_pvals,
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              )
```

So far, none of the methods have been executed. The *BenchDesign* object simply serves as a container describing *how* the methods should be executed. The methods are applied by a simple call to `buildBench()`. Since the ground truth is known and available in `mydat$status`, this is specified to `truthCols=`.

```
sb <- buildBench(bd, truthCols = "status")
```

We can inspect the results.

```
sb
```

```
## class: SummarizedBenchmark
## dim: 15677 3
## metadata(1): sessions
## assays(1): status
## rownames: NULL
## rowData names(1): status
## colnames(3): deseq2 edgeR voom
## colData names(9): func.pkg func.pkg.vers ... param.group session.idx
```

## 4.2 Benchmark Evaluation

By running the code above, the results of three differential expression methods (*[edgeR](https://bioconductor.org/packages/3.8/edgeR)*, *[limma](https://bioconductor.org/packages/3.8/limma)*-voom and *[DESeq2](https://bioconductor.org/packages/3.8/DESeq2)* will be stored in a `SummarizedBenchmark` container. The next step is to define metrics to evaluate the performance of these three methods. This can be done by using the function `addPerformanceMetric()`, as described before in Section [2](#quickstart-case-study). However, in this package there are implementations for several ‘default’ metrics that are commonly used to evaluate methods. The function `availableMetrics()` returns a *data.frame* of these metrics.

```
availableMetrics()
```

```
##            functions                                   description
## 1         rejections                          Number of rejections
## 2                TPR                            True Positive Rate
## 3                TNR                            True Negative Rate
## 4                FDR              False Discovery Rate (estimated)
## 5                FNR                           False Negative Rate
## 6        correlation                           Pearson correlation
## 7               sdad Standard Deviation of the Absolute Difference
## 8            hamming                              Hamming distance
## 9             LPnorm                                    L_{p} norm
## 10 adjustedRandIndex                           Adjusted Rand Index
##    requiresTruth
## 1          FALSE
## 2           TRUE
## 3           TRUE
## 4           TRUE
## 5           TRUE
## 6           TRUE
## 7           TRUE
## 8           TRUE
## 9           TRUE
## 10          TRUE
```

For example, the predefined metrics `rejections`, `TPR`, `TNR`, `FDR` and `FNR` can be added to the assay `H` of our object using the following code,

```
sb <- addPerformanceMetric( sb,
                            evalMetric=c("rejections", "TPR", "TNR", "FDR", "FNR"),
                            assay="status" )
names(performanceMetrics(sb)[["status"]])
```

```
## [1] "rejections" "TPR"        "TNR"        "FDR"        "FNR"
```

Having defined the desired performance metrics, the function `estimatePerformanceMetrics()` will calculate these metrics for each of the three methods.

```
estimatePerformanceMetrics(
  sb,
  alpha = c(0.01, 0.05, 0.1, 0.2),
  tidy = TRUE) %>%
  dplyr:::select(label, value, performanceMetric, alpha) %>%
  tail()
```

```
##     label      value performanceMetric alpha
## 55 deseq2 0.10949477               FNR   0.1
## 56  edgeR 0.09381113               FNR   0.1
## 57   voom 0.11381970               FNR   0.1
## 58 deseq2 0.09181118               FNR   0.2
## 59  edgeR 0.07986767               FNR   0.2
## 60   voom 0.08741018               FNR   0.2
```

Furthermore, the functions `plotMethodsOverlap()` and `plotROC()` are helpful to visualize the performance of the different methods, in case these methods output q-values.

`plotMethodsOverlap()` is a wrapper for the function `upset()` from the *[UpSetR](https://CRAN.R-project.org/package%3DUpSetR)* package that is helpful to visualize the overlaps between hits of different methods for a given alpha value.

```
plotMethodsOverlap( sb, assay="status", alpha=0.1, order.by="freq")
```

![](data:image/png;base64...)

From the plot above, it is evident that there is a large number of transcripts that are detected to be differentially expressed by all three methods. There are also smallers sets of transcripts that are detected uniquely by a single method or subsets of methods. Another typical way to compare the performance of different methods are Receiver Operating Characteristic (ROC) curves. The function `plotROC()` inputs a *SummarizeBenchmark* object and draws the ROC curves for all methods contained in it.

```
SummarizedBenchmark::plotROC(sb, assay="status")
```

![](data:image/png;base64...)

# 5 Additional Features

Here, we describe several additional features implemented in *SummarizedBenchmark* for building on the standard workflow described in the previous sections. The features are illustrated using the same differential expression example from above.

## 5.1 Reusing a BenchDesign Across Data Sets

When benchmarking several methods, it is generally considered good practice to apply the methods to more than just a single data set. Under the SummarizedBenchmark framework, this naturally translates to recycling the same set of methods defined in a single *BenchDesign* object across multiple data sets. As mentioned early on, a *BenchDesign* can be intialized without any methods or data set.

```
bdnull <- BenchDesign()
bdnull
```

```
## BenchDesign ------------------------------------------------
##   benchmark data:
##     NULL
##   benchmark methods:
##     none
```

As before, methods can be added to the *BenchDesign* with `addMethod()`, and the benchmark experiment run using `buildBench()`.

```
bdnull <- bdnull %>%
    addMethod(label = "bonf",
              func = p.adjust,
              params = rlang::quos(p = pval,
                                   method = "bonferroni")) %>%
    addMethod(label = "BH",
              func = p.adjust,
              params = rlang::quos(p = pval,
                                   method = "BH"))
```

The `buildBench()` method accepts an optional `data =` parameter. When specified, this data set is used to run the experiment, taking precedence over the data set specified in (or missing from) the *BenchDesign* object.

```
buildBench(bdnull, data = tdat)
```

```
## class: SummarizedBenchmark
## dim: 50 2
## metadata(1): sessions
## assays(1): default
## rownames: NULL
## rowData names(1): default
## colnames(2): bonf BH
## colData names(6): func.pkg func.pkg.vers ... param.method
##   session.idx
```

By specifying data during the `buildBench()` step, the exact same benchmark comparison, as defined in the common *BenchDesign* object, can be carried out consistently across multiple data sets. While this approach works even if the common *BenchDesign* object contains a default data set, it is recommended that the *BenchDesign* be created without any data to avoid errors if the design is going to be reused across data sets.

## 5.2 Storing Multiple Outputs

The differential expression case study described above has assumed that we are interested in a single numeric vector for each method, namely, a vector of p-values. These p-values are stored as the sole `assay` in the *SummarizedBenchmark* object returned by `buildBench()`. However, in many cases, there are multiple values of interest to be compared across methods. For example, looking at the estimated log-fold changes in addition to p-values may be informative when comparing methods for differential expression.

The *BenchDesign* framework supports multiple assays with the `post =` parameter of the `addMethod()` call. When zero or one function is specified to `post =` for all methods, as in the examples above, the results are stored as a single `assay`. However, if `post =` is passed a named list of functions, separate `assay`s will be created using the names and functions in each list. Since the `assay` names are taken from `post =`, all entries in the list must be named. Furthermore, since results are matched across methods using the assay names, if a method is missing a `post =` function for a given assay name, the corresponding column in the `assay`s will be set to `NA`.

To track both p-values and log-fold change values for each method, we write new wrapper functions. Separate wrapper functions are written for first returning the primary analysis results, and separate accessor functions for extracting p-values and log-fold changes from the results.

```
deseq2_run <- function(countData, colData, design, contrast) {
    dds <- DESeqDataSetFromMatrix(countData,
                                  colData = colData,
                                  design = design)
    dds <- DESeq(dds)
    results(dds, contrast = contrast)
}
deseq2_pv <- function(x) {
    x$pvalue
}
deseq2_lfc <- function(x) {
    x$log2FoldChange
}

edgeR_run <- function(countData, group, design) {
    y <- DGEList(countData, group = group)
    y <- calcNormFactors(y)
    des <- model.matrix(design)
    y <- estimateDisp(y, des)
    fit <- glmFit(y, des)
    glmLRT(fit, coef=2)
}
edgeR_pv <- function(x) {
    x$table$PValue
}
edgeR_lfc <- function(x) {
    x$table$logFC
}

voom_run <- function(countData, group, design) {
    y <- DGEList(countData, group = group)
    y <- calcNormFactors(y)
    des <- model.matrix(design)
    y <- voom(y, des)
    eBayes(lmFit(y, des))
}
voom_pv <- function(x) {
    x$p.value[, 2]
}
voom_lfc <- function(x) {
    x$coefficients[, 2]
}
```

The primary wrapper function and a list of accessor functions are passed to `func =` and `post =` respectively.

```
bd <- BenchDesign(data = mydat) %>%
    addMethod(label = "deseq2",
              func = deseq2_run,
              post = list(pv = deseq2_pv,
                          lfc = deseq2_lfc),
              params = rlang::quos(countData = cntdat,
                                   colData = coldat,
                                   design = ~condition,
                                   contrast = c("condition", "2", "1"))
              ) %>%
    addMethod(label = "edgeR",
              func = edgeR_run,
              post = list(pv = edgeR_pv,
                          lfc = edgeR_lfc),
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              ) %>%
    addMethod(label = "voom",
              func = voom_run,
              post = list(pv = voom_pv,
                          lfc = voom_lfc),
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              )
```

When the *BenchDesign* is evaluated using `buildBench()`, the resulting *SummarizedBenchmark* will be generated with two assays: `"pv"` and `"lfc"`. As before, the ground truth can be specified using the `truthCols =` parameter. When multiple assays are used, `truthCols =` expects a named vector of `assay-name = "column-name"` pairs.

```
sb <- buildBench(bd = bd, truthCols = c(pv = "status", lfc = "lfc"))
sb
```

```
## class: SummarizedBenchmark
## dim: 15677 3
## metadata(1): sessions
## assays(2): pv lfc
## rownames: NULL
## rowData names(2): pv lfc
## colnames(3): deseq2 edgeR voom
## colData names(9): func.pkg func.pkg.vers ... param.group session.idx
```

We can verify that the two assays contain the expected values.

```
head(assay(sb, "pv"))
```

```
##            deseq2        edgeR         voom
## [1,] 2.875541e-04 2.074073e-04 6.103023e-03
## [2,] 2.799371e-23 2.121422e-16 1.239445e-04
## [3,] 8.450676e-14 3.109331e-18 5.221157e-06
## [4,] 6.930834e-01 6.621236e-01 3.357040e-01
## [5,] 2.479616e-11 2.468951e-09 3.978989e-04
## [6,] 9.057130e-01 8.947438e-01 5.199404e-01
```

```
head(assay(sb, "lfc"))
```

```
##          deseq2       edgeR       voom
## [1,]  3.7329019   3.6767779  3.5232524
## [2,] -5.3905346  -5.3773940 -5.5543949
## [3,] -9.7125453 -10.2467488 -8.2533275
## [4,] -0.4706410  -0.4547095 -1.0510456
## [5,]  3.7048724   3.7024426  3.9084940
## [6,] -0.1554938  -0.1504299 -0.7607029
```

## 5.3 Parallelizing with BiocParallel

The simple examples considered in this vignette were constructed to be computational manageable with only one core. However, when working with larger data sets, running each method in serial with a single machine is often undesirable. Similarly, when replicating benchmark experiments across multiple data sets, running each experiment in serial may be inefficent. In this section, we describe how to use the `BiocStyle::Biocpkg("BiocParallel")` package to parallelize benchmarking across methods and data sets. More details on how to specify the parallelization back-end can be found in the *Introduction to BiocParallel* vignette for the *[BiocParallel](https://bioconductor.org/packages/3.8/BiocParallel)* package.

### 5.3.1 Across Methods

Since constructing a *BenchDesign* object requires no computation, the bottleneck only appears at the `buildBench()` step of the process. Parallelization of this step is enabled using the *[BiocParallel](https://bioconductor.org/packages/3.8/BiocParallel)* package. By default, parallel evaluation is disabled, but can easily be enabled by setting `parallel = TRUE` and optionally specifying the `BPPARAM =` parameter. If `BPPARAM =` is not specified, the default back-end will be used. The default back-end can be checked with `bpparam()`.

Parallelization of `buildBench()` is carried out across the set of methods specified with `addMethod()`. Thus, there is no benefit to specifying more cores than the number of methods.

```
bpparam()
```

```
## class: MulticoreParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bptimeout: 2592000; bpprogressbar: FALSE; bpexportglobals: TRUE
##   bpRNGseed:
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: FORK
```

```
sbp <- buildBench(bd, parallel = TRUE,
                  BPPARAM = BiocParallel::SerialParam())
sbp
```

```
## class: SummarizedBenchmark
## dim: 15677 3
## metadata(1): sessions
## assays(2): pv lfc
## rownames: NULL
## rowData names(2): pv lfc
## colnames(3): deseq2 edgeR voom
## colData names(9): func.pkg func.pkg.vers ... param.group session.idx
```

The results, as expected, are the same as when `buildBench()` was called without parallelization.

```
all(assay(sbp) == assay(sb), na.rm = TRUE)
```

```
## [1] TRUE
```

### 5.3.2 Across Datasets

Typically, benchmark studies have more than a single dataset. For this cases, users can create a *BenchDesign* object and execute this design on many datasets. Again, running the step of executing the benchmark design on every dataset using a single core might take to long. However, parallelization across datasets is possible using the *[BiocParallel](https://bioconductor.org/packages/3.8/BiocParallel)* package.

To demonstrate this, we split the count data and ground truths of the (Soneson and Robinson 2016) dataset, as if they were three different datasets.

```
#mydat <- as.list( bd@data@data )
ndat <- length(mydat$status)
spIndexes <- split( seq_len( ndat ), rep( 1:3, length.out=ndat ) )

datasetList <- lapply( spIndexes, function(x){
  list( coldat=mydat$coldat,
        cntdat=mydat$cntdat[x,],
        status=mydat$status[x],
        lfc=mydat$lfc[x] )
} )
names( datasetList ) <-
  c("dataset1", "dataset2", "dataset3")
```

Then, using a call to `bplapply()` function, we can execute the *BenchDesign* object for each dataset. Note that with the `BPPARAM =` parameter, the execution of the *BenchDesign* is done across many computing instances. In the example below, we use 3 cores.

```
sbL <- bplapply( datasetList, function( x ){
  buildBench( bd, data=x )
}, BPPARAM = MulticoreParam( 3 ) )
sbL
```

```
## $dataset1
## class: SummarizedBenchmark
## dim: 5226 3
## metadata(1): sessions
## assays(2): pv lfc
## rownames: NULL
## rowData names(2): pv lfc
## colnames(3): deseq2 edgeR voom
## colData names(9): func.pkg func.pkg.vers ... param.group session.idx
##
## $dataset2
## class: SummarizedBenchmark
## dim: 5226 3
## metadata(1): sessions
## assays(2): pv lfc
## rownames: NULL
## rowData names(2): pv lfc
## colnames(3): deseq2 edgeR voom
## colData names(9): func.pkg func.pkg.vers ... param.group session.idx
##
## $dataset3
## class: SummarizedBenchmark
## dim: 5225 3
## metadata(1): sessions
## assays(2): pv lfc
## rownames: NULL
## rowData names(2): pv lfc
## colnames(3): deseq2 edgeR voom
## colData names(9): func.pkg func.pkg.vers ... param.group session.idx
```

## 5.4 Updating Analyses

Often, benchmarking analyses are performed in multiple steps, iteratively, with methods added or updated based on previous results. Additionally, over the course of a benchmarking study, developers may update methods to improve the implementation or add new features. Ideally, whenever a methods are updated or added, the benchmark results should also be updated. Naively, all methods in the benchmark could be re-computed by calling `buildBench()` on the original *BenchDesign* whenever the benchmarker notices that a method has been changed. However, not only is this computational inefficient, but requires the benchmarker to manually check if any methods have been verified.

To make this process easier, the package includes the `updateBench()` function which can be used to both check if any results in a *SummarizedBenchmark* object need to be updated, and to update these results with a call to `buildBench()`.

To demonstrate the use of `updateBench()`, we continue with the example of comparing methods for differential expression. First, the function can be called with just a single *SummarizedBenchmark* object to see if any of the methods have become outdated. By default, the function will not actually run any methods.

```
updateBench(sb = sb)
```

```
## Update SummarizedBenchmark (dryrun) ----------------------------------
##   benchmark data: unchanged (full data missing)
##     MD5 hash: 3f41eeab0a157bf127e2b7ffb98ab685
##     names: ??
##   benchmark methods:
##     |              | Need to  |           Outdated            |
##     | Method       | (Re)Run  |  Func Param  Meta  Post  Vers |
##     | deseq2       |       N  |     N     N     N     N     N |
##     | edgeR        |       N  |     N     N     N     N     N |
##     | voom         |       N  |     N     N     N     N     N |
```

The output is a table showing whether any methods need to be re-evaluated, as well as which components of the methods are now outdated. Here, the headings correspond to:

* `Func`: the main method function,
* `Param`: the method parameters,
* `Meta`: the manually specified method metadata,
* `Post`: the post-processing functions,
* `Vers`: the corresponding package version for the main method.

As can be seen by the `N`s under `Need to (Re)Run`, all results in the *SummarizedBenchmark* are still valid, and no method needs to be re-run. Also note that the benchmark data is listed as `full data missing`. This is because the *SummarizedBenchmark* object only contains the data set as a MD5 hash. If any of the methods needed to be updated, the original data would have to be specified to `updateBench()` using the `data =` parameter.

```
BDData(BenchDesign(sb))
```

```
## BenchDesign Data (BDData) ----------------------------------
##   type: md5hash
##   MD5 hash: 3f41eeab0a157bf127e2b7ffb98ab685
```

The second way to call `updateBench()` is to specify both a *SummarizedBenchmark* object and a *BenchDesign* object. Intuitively, this will result in updating the results of the *SummarizedBenchmark* object to include any new or modified methods in the *BenchDesign*. Methods between the two objects are matched by the method label, e.g. `deseq2`. As an example, suppose we modify one of the methods in the *BenchDesign* object and want to rerun the benchmarking experiment. We first create a modified *BenchDesign* object, where we modify a single method’s manually specified meta data. Note that this is just a trivial update and normally would not warrant updating the results.

```
bd2 <- modifyMethod(bd, "deseq2", rlang::quos(bd.meta = list(note = "minor update")))
```

Next, we pass the object to `updateBench()` along with the original *SummarizedBenchmark* object.

```
updateBench(sb = sb, bd = bd2)
```

```
## Update SummarizedBenchmark (dryrun) ----------------------------------
##   benchmark data: unchanged
##     MD5 hash: 3f41eeab0a157bf127e2b7ffb98ab685
##     names: coldat cntdat status lfc
##   benchmark methods:
##     |              | Need to  |           Outdated            |
##     | Method       | (Re)Run  |  Func Param  Meta  Post  Vers |
##     | deseq2       |       Y  |     N     N     Y     N     N |
##     | edgeR        |       N  |     N     N     N     N     N |
##     | voom         |       N  |     N     N     N     N     N |
```

Notice that now the `Need to (Re)Run` and `Meta` columns are now set to `Y` for the `deseq2` method, indicating that the metadata of the method has been updated, and the method now needs to be rerun. Next, suppose we also decide to add a new method to our comparison. Here, we add an alternate version of DESeq2 to the comparison based on adaptive shrinkage (ASH) (Stephens 2017).

```
deseq2_ashr <- function(countData, colData, design, contrast) {
    dds <- DESeqDataSetFromMatrix(countData,
                                  colData = colData,
                                  design = design)
    dds <- DESeq(dds)
    lfcShrink(dds, contrast = contrast, type = "ashr")
}

bd2 <- addMethod(bd2, "deseq2_ashr",
                 deseq2_ashr,
                 post = list(pv = deseq2_pv,
                             lfc = deseq2_lfc),
                 params = rlang::quos(countData = cntdat,
                                      colData = coldat,
                                      design = ~condition,
                                      contrast = c("condition", "2", "1")))
```

Now we see that bo the modified `deseq2` and `deseq2_ashr` methods are listed as needing to be rerun.

```
updateBench(sb = sb, bd = bd2)
```

```
## Update SummarizedBenchmark (dryrun) ----------------------------------
##   benchmark data: unchanged
##     MD5 hash: 3f41eeab0a157bf127e2b7ffb98ab685
##     names: coldat cntdat status lfc
##   benchmark methods:
##     |              | Need to  |           Outdated            |
##     | Method       | (Re)Run  |  Func Param  Meta  Post  Vers |
##     | deseq2       |       Y  |     N     N     Y     N     N |
##     | edgeR        |       N  |     N     N     N     N     N |
##     | voom         |       N  |     N     N     N     N     N |
##     | deseq2_ashr  |       Y  |     -     -     -     -     - |
```

To run the update, we simply modify the call to `updateBench()` with `dryrun = FALSE`. When we do this, only the two methods needing to be rerun are evaluated.

```
sb2 <- updateBench(sb = sb, bd = bd2, dryrun = FALSE)
sb2
```

```
## class: SummarizedBenchmark
## dim: 15677 4
## metadata(1): sessions
## assays(2): pv lfc
## rownames: NULL
## rowData names(2): pv lfc
## colnames(4): edgeR voom deseq2_ashr deseq2
## colData names(10): func.pkg func.pkg.vers ... session.idx meta.note
```

We can check the output to see that the results of the `deseq2_ashr` method have been added along with the updated `deseq2` results.

```
head(assay(sb2, "lfc"))
```

```
##            edgeR       voom deseq2_ashr     deseq2
## [1,]   3.6767779  3.5232524  3.40956564  3.7329019
## [2,]  -5.3773940 -5.5543949 -5.32293234 -5.3905346
## [3,] -10.2467488 -8.2533275 -9.20816345 -9.7125453
## [4,]  -0.4547095 -1.0510456 -0.08956318 -0.4706410
## [5,]   3.7024426  3.9084940  3.61844615  3.7048724
## [6,]  -0.1504299 -0.7607029 -0.02921228 -0.1554938
```

Additionally, notice that a session index is also stored in the column data of each method. This can be used to map methods quickly to the corresponding entry of the `sessions` list stored in the object metadata.

```
colData(sb2)[, "session.idx", drop = FALSE]
```

```
## DataFrame with 4 rows and 1 column
##             session.idx
##               <numeric>
## edgeR                 1
## voom                  1
## deseq2_ashr           2
## deseq2                2
```

Recall, `sessions` is a list of session information stored in the metadata of the *SummarizedBenchmark* object. Each entry of the `sessions` list includes the names of methods for which the results were generated during that session, the corresponding method results, the run parameters, and the session info. We can check the list of methods for each session and see that it matches the `session.idx` values above.

```
lapply(metadata(sb2)$sessions, `[[`, "methods")
```

```
## [[1]]
## [1] "edgeR" "voom"
##
## [[2]]
## [1] "deseq2_ashr" "deseq2"
```

As another example, we can also compare the new *SummarizedBenchmark* object against the original *BenchDesign*. By default, `updateBench()` will keep all methods in the *SummarizedBenchmark* object even if a corresponding method is not found in the new *BenchDesign* object. To avoid this behavior, we can specify `keepAll = FALSE`.

```
updateBench(sb2, bd, keepAll = FALSE)
```

```
## Update SummarizedBenchmark (dryrun) ----------------------------------
##   benchmark data: unchanged
##     MD5 hash: 3f41eeab0a157bf127e2b7ffb98ab685
##     names: coldat cntdat status lfc
##   benchmark methods:
##     |              | Need to  |           Outdated            |
##     | Method       | (Re)Run  |  Func Param  Meta  Post  Vers |
##     | deseq2       |       Y  |     N     N     Y     N     N |
##     | edgeR        |       N  |     N     N     N     N     N |
##     | voom         |       N  |     N     N     N     N     N |
##     | deseq2_ashr  |    Drop  |     -     -     -     -     - |
```

As expected, the `deseq2` method must again be updated to return to match the original method definition, and the newer `deseq2_ashr` method must be dropped.

If users update the *BenchDesign*, it is possible to calculate the performance metrics only for methods that have been added or modified. This feature is useful, for example, when performance metrics are computationally expensive to calculate. In the example below, we calculate the number of rejections at a FDR of 10%.

```
sb <- addPerformanceMetric( sb,
                      assay="pv",
                      evalMetric="rejections",
                      evalFunction=function( query, truth  ){
                        sum( p.adjust( query, method="BH" ) < 0.1, na.rm=TRUE)
                        } )
sb <- estimatePerformanceMetrics(sb, addColData=TRUE)
```

Then, we update the *BenchDesign* and rerun the function `estimatePerformanceMetrics()` with the parameter `rerun=FALSE`. Setting this parameter to `FALSE` will detect which performance metrics have been calculated before and will only recalculate metrics for methods that have been added or modified.

```
sb2 <- updateBench( sb, bd2, dryrun=FALSE )
estimatePerformanceMetrics( sb2, rerun=FALSE, addColData=TRUE )
```

```
##
## Option rerun is set to `FALSE`:
## Rerunning performance metrics only for the following methods: deseq2_ashr, deseq2
```

```
## class: SummarizedBenchmark
## dim: 15677 4
## metadata(1): sessions
## assays(2): pv lfc
## rownames: NULL
## rowData names(2): pv lfc
## colnames(4): edgeR voom deseq2_ashr deseq2
## colData names(12): func.pkg func.pkg.vers ... pm.session meta.note
```

## 5.5 Error Handling

When running a large benchmark study, not uncommonly, a single or a small subset of methods may fail during execution. This may be the result of misspecified parameters, an underlying bug in the software, or any number of other reasons. By default, errors thrown by methods which fail during `buildBench()` or `updateBench()` are caught and handled in a user-friendly way. As long as a single method executes without any errors, a *SummarizedBenchmark* object is returned as usual, with the assay columns of failed methods set to `NA`. Additionally, the corresponding error messages are stored in the metadata of the object for reference.

As an example, consider the following example where we run case where we benchmark two simple methods. The first, `slowMethod` draws 5 random normal samples after waiting 5 seconds, and the second, `fastMethod` draws 5 random normal samples immediately. Each method is then passed through two post-processing functions, `keepSlow` and `makeSlower`, and `keepFast` and `makeSlower`, respectively. This results in three partially overlapping assays, `keepSlow`, `keepFast` and `makeSlower`. With this example, we also demonstrate how mismatched assays are handled across methods.

```
bdslow <- BenchDesign(data = tdat) %>%
    addMethod("slowMethod", function() { Sys.sleep(5); rnorm(5) },
              post = list(keepSlow = identity,
                          makeSlower = function(x) { Sys.sleep(5); x })) %>%
    addMethod("fastMethod", function() { rnorm(5) },
              post = list(keepFast = identity,
                          makeSlower = function(x) { Sys.sleep(5); x }))
```

We run these methods in parallel using `parallel = TRUE` and specify a timeout limit of 1 second for the `BPPARAM`. Naturally, `slowMethod` will fail, and `fastMethod` will fail during the `makeSlower` post-processing function.

```
bpp <- SerialParam()
bptimeout(bpp) <- 1

sbep <- buildBench(bdslow, parallel = TRUE, BPPARAM = bpp)
```

```
## !! error caught in buildBench !!
## !! error in main function of method: 'slowMethod'
```

```
## !!  original message:
## !!  reached elapsed time limit
```

```
## !! error caught in buildBench !!
## !! error in method: 'fastMethod', post: 'makeSlower'
```

```
## !!  original message:
## !!  reached elapsed time limit
```

Notice that during the execution process, errors caught by `buildBench()` are printed to the console along with the name of the failed method and post-processing function when appropriate.

We can verify that a valid *SummarizedBenchmark* object is still returned with the the remaining results.

```
sbep
```

```
## class: SummarizedBenchmark
## dim: 5 2
## metadata(1): sessions
## assays(3): keepFast keepSlow makeSlower
## rownames: NULL
## rowData names(3): keepFast keepSlow makeSlower
## colnames(2): slowMethod fastMethod
## colData names(4): func.pkg func.pkg.vers func.pkg.manual session.idx
```

We can also check the values of the assays.

```
sapply(assayNames(sbep), assay, x = sbep, simplify = FALSE)
```

```
## $keepFast
##      slowMethod fastMethod
## [1,]         NA -1.4920954
## [2,]         NA -0.5808546
## [3,]         NA -1.4016588
## [4,]         NA -0.6005302
## [5,]         NA -0.2767537
##
## $keepSlow
##      slowMethod fastMethod
## [1,]         NA         NA
## [2,]         NA         NA
## [3,]         NA         NA
## [4,]         NA         NA
## [5,]         NA         NA
##
## $makeSlower
##      slowMethod fastMethod
## [1,]         NA         NA
## [2,]         NA         NA
## [3,]         NA         NA
## [4,]         NA         NA
## [5,]         NA         NA
```

Notice that most columns contain only `NA` values. These columns correspond to both methods which returned errors, as well as methods missing post-processing functions, e.g. no `keepSlow` function was defined for the `fastMethod` method. While the `NA` values cannot be used to distinguish the sources of the `NA` values, this is documented in the `sessions` list of the *SummarizedBenchmark* metadata. While the `sessions` object is a list containing information for all previous sessions, we are only interested in the current, first session. (For more details on why multiple sessions may be run, see Section [5.4](#updating-analyses).)

```
names(metadata(sbep)$sessions[[1]])
```

```
## [1] "methods"     "results"     "parameters"  "sessionInfo"
```

In `sessions`, there is a `"results"` entry which includes a summary of the results for each combination of method and post-processing function (assay). The entries of `results` can take one of three values: `"success"`, `"missing"`, or an error message of class `buildbench-error`. The easiest way to view these resultsis by passing the `results` to the base R function, `simplify2array()`.

```
sess1res <- metadata(sbep)$sessions[[1]]$results
simplify2array(sess1res)
```

```
##            slowMethod                   fastMethod
## keepSlow   "reached elapsed time limit" "reached elapsed time limit"
## makeSlower "reached elapsed time limit" "missing"
## keepFast   "missing"                    "success"
```

In the returned table, columns correspond to methods, and rows correspond to assays. We clearly see that many of the methods failed due to exceeding the specified time limit. If we check one of these entries more closesly, we see that it is indeed a `buildbench-error` object that occurred (`"origin"`) during the `"main"` function.

```
sess1res$slowMethod$keepSlow
```

```
## [1] "reached elapsed time limit"
## attr(,"class")
## [1] "buildbench-error"
## attr(,"origin")
## [1] "main"
```

If this error handling is not wanted, and the user would like the benchmark experiment to terminate when an error is thrown, then the option `catchErrors = FALSE` can be specified to eiher `buildBench()` or `updateBench()`.

## 5.6 Specifying Method Metadata

Metadata for methods are stored in the `colData()` of *SummarizedBenchmark* objects. As metioned above, several default metadata columns are populated in the `colData()` of the *SummarizedBenchmark* object generated by a call to `buildBench()`. Sometimes it may be useful to include additional metadata columns beyond just the default columns. While this can be accomplished manually by modifying the `colData()` of the *SummarizedBenchmark* object post hoc, method metadata can also be specified at the `addMethod()` step using the `meta =` optional parameter. The `meta =` parameter accepts a named list of metadata information. Each list entry will be added to the `colData()` as a new column. To avoid collisions between metadata columns specified with `meta =` and the default set of columns, metadata specified using `meta =` will be added to `colData()` with `meta.` prefixed to the column name.

As an example, we construct a *BenchDesign* object again using the differential expression example. The *BenchDesign* is created with two methods, *[DESeq2](https://bioconductor.org/packages/3.8/DESeq2)* and *[edgeR](https://bioconductor.org/packages/3.8/edgeR)*. Each method is specified with the optional `meta =` parameter. We can verify that the manually defined metadata column (`meta.reason`) is available in the `colData()` of the generated *SummarizedBenchmark*.

```
tempbd <- BenchDesign(data = mydat) %>%
    addMethod(label = "deseq2",
              func = deseq2_pvals,
              meta = list(reason = "recommended by friend X"),
              params = rlang::quos(countData = cntdat,
                                   colData = coldat,
                                   design = ~condition,
                                   contrast = c("condition", "2", "1"))
              ) %>%
    addMethod(label = "edgeR",
              func = edgeR_pvals,
              meta = list(reason = "recommended by friend Y"),
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              )
buildBench(tempbd) %>%
    colData()
```

```
## DataFrame with 2 rows and 10 columns
##           func.pkg func.pkg.vers func.pkg.manual param.countData
##        <character>   <character>       <logical>     <character>
## deseq2          NA            NA           FALSE          cntdat
## edgeR           NA            NA           FALSE          cntdat
##        param.colData      param.design           param.contrast
##          <character>       <character>              <character>
## deseq2        coldat        ~condition c("condition", "2", "1")
## edgeR             NA ~coldat$condition                       NA
##                    meta.reason      param.group session.idx
##                    <character>      <character>   <numeric>
## deseq2 recommended by friend X               NA           1
## edgeR  recommended by friend Y coldat$condition           1
```

While all methods in this example had the `meta =` option specified, this is not necessary. It is completely acceptable to specify the `meta =` parameter for only a subset of methods.

## 5.7 Specifying Version Metadata

Arguably, two of the most important pieces of metadata stored in the `colData()` of the *SummarizedBenchmark* returned by `buildBench()` are the relevant package name and version (`pkg_name`, `pkg_vers`). Determining the package name and version requires the primary “workhorse” function of the method be directly specified as `func =` in the `addMethod()` call. In some cases, this may not be possible, e.g. if the “workhorse” function is a wrapper as in the differential expression example above. However, there still might exist an important function for which we would like to track the package name and version. The `meta` parameter can help.

The `meta =` parameter will handle the following named list entries as special values: `pkg_name`, `pkg_vers`, `pkg_func`. First, if values are specified for `pkg_name` and `pkg_vers` in `meta =`, these will overwrite the values determined from `func =`. To trace the source of `pkg_name` and `pkg_vers` information, the `vers_src` column of the `colData` will be set to `"meta_manual"` (the default value is `"func"`). Alternatively, a function can be passed to `meta =` as `pkg_func`. This function will be used to determine both `pkg_name` and `pkg_vers`, and will take precendence over manually specified `pkg_name` and `pkg_vers` values. If `pkg_func` is specified, it will be included in the `colData()` as a new column with the same name, and the `vers_src` column will be set to `"meta_func"`. \*\*Note: the function should be wrapped in `rlang::quo` to be properly parsed.

The following example illustrates the behavior when using either `pkg_func` or `pkg_name` and `pkg_vers` with the `meta` optional parameter.

```
tempbd <- BenchDesign(data = mydat) %>%
    addMethod(label = "deseq2",
              func = deseq2_pvals,
              meta = list(pkg_func = rlang::quo(DESeq2::DESeq)),
              params = rlang::quos(countData = cntdat,
                                   colData = coldat,
                                   design = ~condition,
                                   contrast = c("condition", "2", "1"))
              ) %>%
    addMethod(label = "edgeR",
              func = edgeR_pvals,
              meta = list(pkg_name = "edgeR",
                          pkg_vers = as.character(packageVersion("edgeR"))),
              params = rlang::quos(countData = cntdat,
                                   group = coldat$condition,
                                   design = ~coldat$condition)
              )
buildBench(tempbd) %>%
    colData()
```

```
## DataFrame with 2 rows and 9 columns
##           func.pkg func.pkg.vers func.pkg.manual param.countData
##        <character>   <character>       <logical>     <character>
## deseq2      DESeq2        1.22.2            TRUE          cntdat
## edgeR        edgeR        3.24.3            TRUE          cntdat
##        param.colData      param.design           param.contrast
##          <character>       <character>              <character>
## deseq2        coldat        ~condition c("condition", "2", "1")
## edgeR             NA ~coldat$condition                       NA
##             param.group session.idx
##             <character>   <numeric>
## deseq2               NA           1
## edgeR  coldat$condition           1
```

## 5.8 Modifying Methods in a BenchDesign

Modifying the defintion of a method after it has been added to a *BenchDesign* is supported by the `modifyMethod()` function. The *BenchDesign* object created in the differential expression above includes a method called *[DESeq2](https://bioconductor.org/packages/3.8/DESeq2)*. We can check the definition of this method using `printMethod()`.

```
printMethod(bd, "deseq2")
```

```
## deseq2 -----------------------------------------------------
## BenchDesign Method (BDMethod) ------------------------------
##   method: deseq2_run
##     function (countData, colData, design, contrast) { ...
##   parameters:
##     countData : cntdat
##     colData : coldat
##     design : ~condition
##     contrast : c("condition", "2", "1")
##   post:
##     pv : function (x) { ...
##     lfc : function (x) { ...
##   meta:
##     none
```

Suppose we wish to both flip the order of the contrast, and add a metadata tag. This can be easily accomplished by passing both new parameters to `modifyMethod()` as a `rlang::quos(..)` list, similar to how they would be passed to `addMethod()`. If the `func`, `post`, or `meta` valuesshould be modified, they should be included in the list using the special keywords, `bd.func =`, `bd.post =`, or `bd.meta =`, as shown in the example below.

```
modifyMethod(bd, label = "deseq2",
             params = rlang::quos(contrast = c("condition", "1", "2"),
                                  bd.meta = list(note = "modified post hoc"))
             ) %>%
    printMethod("deseq2")
```

```
## deseq2 -----------------------------------------------------
## BenchDesign Method (BDMethod) ------------------------------
##   method: deseq2_run
##     function (countData, colData, design, contrast) { ...
##   parameters:
##     countData : cntdat
##     colData : coldat
##     design : ~condition
##     contrast : c("condition", "1", "2")
##   post:
##     pv : function (x) { ...
##     lfc : function (x) { ...
##   meta:
##     note : "modified post hoc"
```

Sometimes it may be desirable to completely overwrite all function parameters for a method, e.g. `countData`, `colData`, `design`, and `contrast` in the case of *[DESeq2](https://bioconductor.org/packages/3.8/DESeq2)*. This may occur if some parameters were optional and originally specified, but no longer necessary. All function parameters can be overwritten by specifying `.overwrite = TRUE`.

```
modifyMethod(bd, label = "deseq2",
             params = rlang::quos(contrast = c("condition", "1", "2"),
                                  bd.meta = list(note = "modified post hoc")),
             .overwrite = TRUE) %>%
    printMethod("deseq2")
```

```
## deseq2 -----------------------------------------------------
## BenchDesign Method (BDMethod) ------------------------------
##   method: deseq2_run
##     function (countData, colData, design, contrast) { ...
##   parameters:
##     contrast : c("condition", "1", "2")
##   post:
##     pv : function (x) { ...
##     lfc : function (x) { ...
##   meta:
##     note : "modified post hoc"
```

Notice that all parameters other than `contrast = c("condition", "1", "2")` have been dropped.

## 5.9 Duplicating Methods in a BenchDesign

In addition to comparing multiple methods, a benchmark study may also involve comparing a single method across several parameter settings. The `expandMethod()` function provides the capability to take a method already defined in the *BenchDesign*, and *expand* it to multiple methods with differing parameter values in the *BenchDesign* object. In the following example, `expandMethod()` is used to duplicate the *[DESeq2](https://bioconductor.org/packages/3.8/DESeq2)* method with only the `"contrast"` parameter modified.

```
bde <- expandMethod(bd, label = "deseq2",
                    onlyone = "contrast",
                    params = rlang::quos(deseq2_v1 = c("condition", "1", "2"),
                                         deseq2_v2 = c("condition", "2", "2"))
                    )
printMethod(bde, "deseq2_v1")
```

```
## deseq2_v1 --------------------------------------------------
## BenchDesign Method (BDMethod) ------------------------------
##   method: deseq2_run
##     function (countData, colData, design, contrast) { ...
##   parameters:
##     countData : cntdat
##     colData : coldat
##     design : ~condition
##     contrast : c("condition", "1", "2")
##   post:
##     pv : function (x) { ...
##     lfc : function (x) { ...
##   meta:
##     none
```

```
printMethod(bde, "deseq2_v2")
```

```
## deseq2_v2 --------------------------------------------------
## BenchDesign Method (BDMethod) ------------------------------
##   method: deseq2_run
##     function (countData, colData, design, contrast) { ...
##   parameters:
##     countData : cntdat
##     colData : coldat
##     design : ~condition
##     contrast : c("condition", "2", "2")
##   post:
##     pv : function (x) { ...
##     lfc : function (x) { ...
##   meta:
##     none
```

Notice that the parameter to be modified is specified with `onlyone =` (denoting “only one” parameter will be changed), and that method names are taken from names of the quosure list passed to `params =` in the `expandMethod()` call. To modify more than a single parameter in the duplicated methods, the `onlyone =` parameter can be ignored, and the new parameter values specified to `params =` as a list of quosure lists. Below, both the `"contrast"` and `meta` parameters are modified in the expanded methods.

```
bde <- expandMethod(bd, label = "deseq2",
                    params = list(deseq2_v1 = rlang::quos(contrast = c("condition", "1", "2"),
                                                          meta = list(note = "filp order")),
                                  deseq2_v2 = rlang::quos(contrast = c("condition", "2", "2"),
                                                          meta = list(note = "nonsensical order"))
                                  )
                    )
printMethod(bde, "deseq2_v1")
```

```
## deseq2_v1 --------------------------------------------------
## BenchDesign Method (BDMethod) ------------------------------
##   method: deseq2_run
##     function (countData, colData, design, contrast) { ...
##   parameters:
##     countData : cntdat
##     colData : coldat
##     design : ~condition
##     contrast : c("condition", "1", "2")
##     meta : list(note = "filp order")
##   post:
##     pv : function (x) { ...
##     lfc : function (x) { ...
##   meta:
##     none
```

```
printMethod(bde, "deseq2_v2")
```

```
## deseq2_v2 --------------------------------------------------
## BenchDesign Method (BDMethod) ------------------------------
##   method: deseq2_run
##     function (countData, colData, design, contrast) { ...
##   parameters:
##     countData : cntdat
##     colData : coldat
##     design : ~condition
##     contrast : c("condition", "2", "2")
##     meta : list(note = "nonsensical order")
##   post:
##     pv : function (x) { ...
##     lfc : function (x) { ...
##   meta:
##     none
```

# References

Benjamini, Yoav, and Yosef Hochberg. 1995. “Controlling the False Discovery Rate: A Practical and Powerful Approach to Multiple Testing.” *Journal of the Royal Statistical Society. Series B (Methodological)*, 289–300.

Dunn, Olive Jean. 1961. “Multiple Comparisons Among Means.” *Journal of the American Statistical Association* 56 (293):52–64.

Soneson, Charlotte, and Mark D Robinson. 2016. “iCOBRA: Open, Reproducible, Standardized and Live Method Benchmarking.” *Nature Methods* 13 (4):283–83. <https://doi.org/10.1038/nmeth.3805>.

Stephens, Matthew. 2017. “False discovery rates: a new deal.” *Biostatistics* 18 (2):275–94. <https://doi.org/10.1093/biostatistics/kxw041>.

Storey, John D. 2002. “A Direct Approach to False Discovery Rates.” *Journal of the Royal Statistical Society: Series B (Statistical Methodology)* 64 (3):479–98.