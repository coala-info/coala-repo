# biobroom Vignette

#### Andrew J. Bass, Emily Nelson, David Robinson and John D. Storey

#### 2025-10-29

# About biobroom

The `biobroom` package contains methods for converting standard objects in Bioconductor into a “tidy format”. It serves as a complement to the popular [broom](https://github.com/dgrtwo/broom) package, and follows the same division (`tidy`/`augment`/`glance`) of tidying methods.

“Tidy data” is a data analysis paradigm that focuses on keeping data formatted as a single observation per row of a data table. For further information, please see [Hadley Wickham’s seminal paper](http://vita.had.co.nz/papers/tidy-data.pdf) on the subject. “Tidy” is not a normative statement about the quality of an object’s structure. Rather, it is a technical specification about the choice of rows and columns. A tidied data frame is not “better” than an S4 object; it simply allows analysis with a different set of tools.

Tidying data makes it easy to recombine, reshape and visualize bioinformatics analyses. Objects that can be tidied include

* `ExpressionSet` object,
* `GRanges` and `GRangesList` objects,
* `RangedSummarizedExperiment` object,
* `MSnSet` object,
* per-gene differential expression tests from `limma`, `edgeR`, and `DESeq2`,
* `qvalue` object for multiple hypothesis testing.

We are currently working on adding more methods to existing Bioconductor objects. If any bugs are found please contact the authors or visit our [github page](https://github.com/StoreyLab/biobroom). Otherwise, any questions can be answered on the [Bioconductor support site](https://support.bioconductor.org/).

# Installation

The `biobroom` package can be installed by typing in a R terminal:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("biobroom")
```

To find out more about the provided objects:

```
library(biobroom)
?edgeR_tidiers
?DESeq2_tidiers
?limma_tidiers
?ExpressionSet_tidiers
?MSnSet_tidiers
?qvalue_tidiers
```

# Examples

## qvalue object

The [qvalue package](https://www.bioconductor.org/packages/release/bioc/html/qvalue.html) is a popular package to estimate q-values and local false discovery rates. To get started, we can load the `hedenfalk` dataset included in the `qvalue` package:

```
library(qvalue)
data(hedenfalk)

qobj <- qvalue(hedenfalk$p)
names(qobj)
```

```
## [1] "call"       "pi0"        "qvalues"    "pvalues"    "lfdr"
## [6] "pi0.lambda" "lambda"     "pi0.smooth"
```

`qobj` is a `qvalue` object, generated from the p-values contained in the `hedenfalk` dataset. If we wanted to use a package such as `dplyr` or `ggplot`, we would need to convert the results into a data frame. The `biobroom` package makes this conversion easy by using the `tidy`, `augment` and `glance` functions:

* `tidy` returns one row for each choice of the tuning parameter lambda.
* `augment` returns one row for each provided p-value, including the computed q-value and local false discovery rate.
* `glance` returns a single row containing the estimated `pi0`.

Applying these functions to `qobj`:

```
library(biobroom)
# use tidy/augment/glance to restructure the qvalue object
head(tidy(qobj))
```

```
## # A tibble: 6 × 3
##   lambda smoothed   pi0
##    <dbl> <lgl>    <dbl>
## 1   0.05 FALSE    0.852
## 2   0.1  FALSE    0.807
## 3   0.15 FALSE    0.782
## 4   0.2  FALSE    0.756
## 5   0.25 FALSE    0.731
## 6   0.3  FALSE    0.714
```

```
head(augment(qobj))
```

```
## # A tibble: 6 × 3
##   p.value q.value  lfdr
##     <dbl>   <dbl> <dbl>
## 1  0.0121  0.0882 0.168
## 2  0.0750  0.209  0.413
## 3  0.995   0.668  1
## 4  0.0418  0.162  0.309
## 5  0.846   0.632  1
## 6  0.252   0.372  0.693
```

```
head(glance(qobj))
```

```
## # A tibble: 1 × 2
##     pi0 lambda
##   <dbl>  <dbl>
## 1 0.670   0.95
```

The original data, or in this example the gene names, can be inputted into `augment` using the `data` argument:

```
# create sample names
df <- data.frame(gene = 1:length(hedenfalk$p))
head(augment(qobj, data = df))
```

```
## # A tibble: 6 × 4
##    gene p.value q.value  lfdr
##   <int>   <dbl>   <dbl> <dbl>
## 1     1  0.0121  0.0882 0.168
## 2     2  0.0750  0.209  0.413
## 3     3  0.995   0.668  1
## 4     4  0.0418  0.162  0.309
## 5     5  0.846   0.632  1
## 6     6  0.252   0.372  0.693
```

The tidied data can be used to easily create plots:

```
library(ggplot2)
# use augmented data to compare p-values to q-values
ggplot(augment(qobj), aes(p.value, q.value)) + geom_point() +
  ggtitle("Simulated P-values versus Computed Q-values") + theme_bw()
```

![](data:image/png;base64...)

Additionally, we can extract out important information such as significant genes under a false discovery rate threshold:

```
library(dplyr)

# Find significant genes under 0.05 threshold
sig.genes <- augment(qobj) %>% filter(q.value < 0.05)
head(sig.genes)
```

```
## # A tibble: 6 × 3
##    p.value q.value   lfdr
##      <dbl>   <dbl>  <dbl>
## 1 0.000713  0.0232 0.0366
## 2 0.00175   0.0365 0.0597
## 3 0.00265   0.0429 0.0752
## 4 0.00116   0.0301 0.0476
## 5 0.00298   0.0448 0.0803
## 6 0.00235   0.0397 0.0704
```

## DESeq2 objects

To demonstrate tidying on `DESeq2` objects we have used the published `airway` RNA-Seq experiment, available as a package from *Bioconductor*:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("airway")
```

Import the `airway` dataset:

```
library(DESeq2)
library(airway)

data(airway)
airway_se <- airway
```

`airway_se` is a `SummarizedExperiment` object, which is a type of object used by the `DESeq2` package. Next, we create a `DESeqDataSet` object and show the output of tidying this object:

```
airway_dds <- DESeqDataSet(airway_se, design = ~cell + dex)

head(tidy(airway_dds))
```

```
## # A tibble: 6 × 3
##   gene            sample     count
##   <chr>           <chr>      <int>
## 1 ENSG00000000003 SRR1039508   679
## 2 ENSG00000000005 SRR1039508     0
## 3 ENSG00000000419 SRR1039508   467
## 4 ENSG00000000457 SRR1039508   260
## 5 ENSG00000000460 SRR1039508    60
## 6 ENSG00000000938 SRR1039508     0
```

Only the gene counts are outputted since there has been no analysis performed. We perform an analysis on the data and then `tidy` the resulting object:

```
# differential expression analysis
deseq <- DESeq(airway_dds)
results <- results(deseq)
# tidy results
tidy_results <- tidy(results)
head(tidy_results)
```

```
## # A tibble: 6 × 7
##   gene            baseMean estimate stderror statistic   p.value p.adjusted
##   <chr>              <dbl>    <dbl>    <dbl>     <dbl>     <dbl>      <dbl>
## 1 ENSG00000000003  709.      0.381     0.101     3.79   0.000152    0.00128
## 2 ENSG00000000005    0      NA        NA        NA     NA          NA
## 3 ENSG00000000419  520.     -0.207     0.112    -1.84   0.0653      0.196
## 4 ENSG00000000457  237.     -0.0379    0.143    -0.264  0.792       0.911
## 5 ENSG00000000460   57.9     0.0882    0.287     0.307  0.759       0.895
## 6 ENSG00000000938    0.318   1.38      3.50      0.394  0.694      NA
```

As an example to show how easy it is to manipulate the resulting object, `tidy_results`, we can use `ggplot2` to create a volcano plot of the p-values:

```
ggplot(tidy_results, aes(x=estimate, y=log(p.value),
                         color=log(baseMean))) + geom_point(alpha=0.5) +
  ggtitle("Volcano Plot For Airway Data via DESeq2") + theme_bw()
```

![](data:image/png;base64...)

##edgeR objects

Here we use the `hammer` dataset included in `biobroom` package. `edgeR` can be used to perform differential expression analysis as follows:

```
library(edgeR)
data(hammer)

hammer.counts <- Biobase::exprs(hammer)[, 1:4]
hammer.treatment <- Biobase::phenoData(hammer)$protocol[1:4]

y <- DGEList(counts=hammer.counts,group=hammer.treatment)
y <- calcNormFactors(y)
y <- estimateCommonDisp(y)
y <- estimateTagwiseDisp(y)
et <- exactTest(y)
```

The results of the analysis are stored in `et`, which is an `DGEExact` object. We can `tidy` this object using `biobroom`:

```
head(tidy(et))
```

```
## # A tibble: 6 × 4
##   gene               estimate  logCPM    p.value
##   <chr>                 <dbl>   <dbl>      <dbl>
## 1 ENSRNOG00000000001   2.65    1.49   0.00000131
## 2 ENSRNOG00000000007  -0.409  -0.226  1
## 3 ENSRNOG00000000008   2.22   -0.407  0.129
## 4 ENSRNOG00000000009   0      -1.31   1
## 5 ENSRNOG00000000010   0.0331  1.79   1
## 6 ENSRNOG00000000012  -3.39    0.0794 0.00375
```

`glance` shows a summary of the experiment: the number of genes found significant (at a specified `alpha`), and which contrasts were compared to get the results.

```
glance(et, alpha = 0.05)
```

```
##   significant     comparison
## 1        6341 control/L5 SNL
```

Additionally, we can can easily manipulate the resulting object and create a volcano plot of the p-values using `ggplot2`:

```
ggplot(tidy(et), aes(x=estimate, y=log(p.value), color=logCPM)) +
  geom_point(alpha=0.5) + ggtitle("Volcano Plot for Hammer Data via EdgeR") +
  theme_bw()
```

![](data:image/png;base64...)

##limma objects

To demonstrate how `biobroom` works with `limma` objects, we generate some simulated data to test the tidier for `limma` objects.

```
# create random data and design
dat <- matrix(rnorm(1000), ncol=4)
dat[, 1:2] <- dat[, 1:2] + .5  # add an effect
rownames(dat) <- paste0("g", 1:nrow(dat))
des <- data.frame(treatment = c("a", "a", "b", "b"),
                  confounding = rnorm(4))
```

We then use `lmFit` and `eBayes` (functions included in `limma`) to fit a linear model and use `tidy` to convert the resulting object into tidy format:

```
lfit <- lmFit(dat, model.matrix(~ treatment + confounding, des))
eb <- eBayes(lfit)

head(tidy(lfit))
```

```
## # A tibble: 6 × 3
##   gene  term       estimate
##   <chr> <fct>         <dbl>
## 1 g1    treatmentb    1.53
## 2 g2    treatmentb   -0.250
## 3 g3    treatmentb   -0.267
## 4 g4    treatmentb   -1.49
## 5 g5    treatmentb   -0.746
## 6 g6    treatmentb   -1.01
```

```
head(tidy(eb))
```

```
## # A tibble: 6 × 6
##   gene  term       estimate statistic p.value   lod
##   <chr> <fct>         <dbl>     <dbl>   <dbl> <dbl>
## 1 g1    treatmentb    1.53      1.23    0.265 -4.63
## 2 g2    treatmentb   -0.250    -0.299   0.775 -5.10
## 3 g3    treatmentb   -0.267    -0.321   0.760 -5.09
## 4 g4    treatmentb   -1.49     -1.67    0.148 -4.32
## 5 g5    treatmentb   -0.746    -0.845   0.431 -4.88
## 6 g6    treatmentb   -1.01     -1.19    0.281 -4.66
```

Analysis can easily be performed from the tidied data. The package `ggplot2` can be used to make a volcano plot of the p-values:

```
ggplot(tidy(eb), aes(x=estimate, y=log(p.value), color=statistic)) +
  geom_point() + ggtitle("Nested Volcano Plots for Simulated Data Processed with limma") +
  theme_bw()
```

![](data:image/png;base64...)

##ExpressionSet objects

`tidy` can also be run directly on `ExpressionSet` objects, as described in another popular `Bioconductor` package `Biobase.` The `hammer` dataset we used above (which is included in the `biobroom` package) is an `ExpressionSet` object, so we’ll use that to demonstrate.

```
library(Biobase)

head(tidy(hammer))
```

```
## # A tibble: 6 × 3
##   gene               sample    value
##   <chr>              <chr>     <int>
## 1 ENSRNOG00000000001 SRX020102     2
## 2 ENSRNOG00000000007 SRX020102     4
## 3 ENSRNOG00000000008 SRX020102     0
## 4 ENSRNOG00000000009 SRX020102     0
## 5 ENSRNOG00000000010 SRX020102    19
## 6 ENSRNOG00000000012 SRX020102     7
```

We can add the phenotype information by using the argument `addPheno`:

```
head(tidy(hammer, addPheno = TRUE))
```

```
## # A tibble: 6 × 8
##   gene               sample  sample.id num.tech.reps protocol strain Time  value
##   <chr>              <chr>   <fct>             <dbl> <fct>    <fct>  <fct> <int>
## 1 ENSRNOG00000000001 SRX020… SRX020102             1 control  Sprag… 2 mo…     2
## 2 ENSRNOG00000000007 SRX020… SRX020102             1 control  Sprag… 2 mo…     4
## 3 ENSRNOG00000000008 SRX020… SRX020102             1 control  Sprag… 2 mo…     0
## 4 ENSRNOG00000000009 SRX020… SRX020102             1 control  Sprag… 2 mo…     0
## 5 ENSRNOG00000000010 SRX020… SRX020102             1 control  Sprag… 2 mo…    19
## 6 ENSRNOG00000000012 SRX020… SRX020102             1 control  Sprag… 2 mo…     7
```

Now we can easily visualize the distribution of counts for each protocol by using `ggplot2`:

```
ggplot(tidy(hammer, addPheno=TRUE), aes(x=protocol, y=log(value))) +
  geom_boxplot() + ggtitle("Boxplot Showing Effect of Protocol on Expression")
```

![](data:image/png;base64...)

##MSnSet Objects

`tidy` can also be run directly on `MSnSet` objects from `MSnbase`, which as specialised containers for quantitative proteomics data.

```
library(MSnbase)
data(msnset)

head(tidy(msnset))
```

```
## # A tibble: 6 × 3
##   protein sample.id   value
##   <chr>   <chr>       <dbl>
## 1 X1      iTRAQ4.114  1348.
## 2 X10     iTRAQ4.114   740.
## 3 X11     iTRAQ4.114 27638.
## 4 X12     iTRAQ4.114 31893.
## 5 X13     iTRAQ4.114 26144.
## 6 X14     iTRAQ4.114  6448.
```

```
head(tidy(msnset, addPheno = TRUE))
```

```
## # A tibble: 6 × 5
##   protein sample        mz reporters  value
##   <chr>   <chr>      <dbl> <fct>      <dbl>
## 1 X1      iTRAQ4.114  114. iTRAQ4     1348.
## 2 X10     iTRAQ4.114  114. iTRAQ4      740.
## 3 X11     iTRAQ4.114  114. iTRAQ4    27638.
## 4 X12     iTRAQ4.114  114. iTRAQ4    31893.
## 5 X13     iTRAQ4.114  114. iTRAQ4    26144.
## 6 X14     iTRAQ4.114  114. iTRAQ4     6448.
```

# Note on returned values

All *biobroom* `tidy` and `augment` methods return a `tbl_df` by default (this prevents them from printing many rows at once, while still acting like a traditional `data.frame`). To change this to a `data.frame` or `data.table`, you can set the `biobroom.return` option:

```
options(biobroom.return = "data.frame")
options(biobroom.return = "data.table")
```