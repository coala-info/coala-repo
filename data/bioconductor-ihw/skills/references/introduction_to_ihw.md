# Introduction to Independent Hypothesis Weighting with the IHW Package

Nikos Ignatiadis, Wolfgang Huber

#### 30 October 2025

#### Package

IHW 1.38.0

# Contents

* [1 Introduction](#introduction)
* [2 An example: RNA-Seq differential expression](#an-example-rna-seq-differential-expression)
  + [2.1 FDR control](#fdr-control)
  + [2.2 Diagnostic plots](#diagnostic-plots)
    - [2.2.1 Estimated weights](#estimated-weights)
    - [2.2.2 Decision boundary](#decision-boundary)
    - [2.2.3 Raw versus adjusted p-values](#raw-versus-adjusted-p-values)
  + [2.3 FWER control with IHW](#fwer-control-with-ihw)
* [3 Other data types, and how to choose the covariate](#other-data-types-and-how-to-choose-the-covariate)
  + [3.1 Criteria for choosing a covariate](#criteria-for-choosing-a-covariate)
  + [3.2 Examples](#examples)
  + [3.3 Why are the different covariate criteria necessary?](#why-are-the-different-covariate-criteria-necessary)
  + [3.4 Diagnostic plots for the covariate](#diagnostic-plots-for-the-covariate)
    - [3.4.1 Scatter plots](#scatter-plots)
    - [3.4.2 Stratified p-value histograms](#stratified-p-value-histograms)
  + [3.5 Further reading about appropriate covariates](#further-reading-about-appropriate-covariates)
* [4 Advanced usage: Working with incomplete p-value lists](#advanced-usage-working-with-incomplete-p-value-lists)
* [References](#references)

# 1 Introduction

You will probably be familiar with multiple testing procedures that take a set of p-values and then calculate adjusted p-values. Given a significance level \(\alpha\), one can then declare the rejected hypotheses. In R this is most commonly done with the `p.adjust` function in the *[stats](https://CRAN.R-project.org/package%3Dstats)* package, and a popular choice is controlling the false discovery rate (FDR) with the method of (Benjamini and Hochberg [1995](#ref-benjamini1995controlling)), provided by the choice `method="BH"` in `p.adjust`. A characteristic feature of this and other methods –responsible both for their versatility and limitations– is that they do not use anything else beyond the p-values: no other potential information that might set the tests apart, such as different signal quality, power, prior probability.

IHW (Independent Hypothesis Weighting) is also a multiple testing procedure, but in addition to the p-values it allows you to specify a covariate for each test. The covariate should be informative of the power or prior probability of each individual test, but is chosen such that the p-values for those hypotheses that are truly null do not depend on the covariate (Ignatiadis et al. [2016](#ref-ignatiadis2016natmeth)). Therefore the input of IHW is the following:

* a vector of p-values (of length \(m\)),
* a matching vector of covariates,
* the significance level \(\alpha \in (0,1)\) at which the FDR should be controlled.

IHW then calculates weights for each p-value (non-negative numbers \(w\_i \geq 0\) such that they average to 1, \(\sum\_{i=1}^m w\_i = m\)). IHW also returns a vector of adjusted p-values by applying the procedure of Benjamini Hochberg (BH) to the weighted p-values \(P^\text{weighted}\_i = \frac{P\_i}{w\_i}\).

The weights allow different prioritization of the individual hypotheses, based on their covariate. This means that the ranking of hypotheses with p-value weighting is in general different than without. Two hypotheses with the same p-value can have different weighted p-values: the one with the higher weight will then have a smaller value of \(P^\text{weighted}\_i\), and consequently it can even happen that one but not the other gets rejected by the subsequent BH procedure.

As an example, let’s see how to use the IHW package in analysing for RNA-Seq differential gene expression. and then also look at some other examples where the method is applicable.

# 2 An example: RNA-Seq differential expression

We analyze the *[airway](https://bioconductor.org/packages/3.22/airway)* RNA-Seq dataset using *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* (Love, Huber, and Anders [2014](#ref-love2014moderated)).

```
library("DESeq2")
library("dplyr")
data("airway", package = "airway")
dds <- DESeqDataSet(se = airway, design = ~ cell + dex) %>% DESeq
deRes <- as.data.frame(results(dds))
```

The output is a dataframe with the following columns, and one row for each tested hypothesis (i.e., for each gene):

```
colnames(deRes)
```

```
## [1] "baseMean"       "log2FoldChange" "lfcSE"          "stat"
## [5] "pvalue"         "padj"
```

In particular, we have p-values and baseMean (i.e., the mean of normalized counts) for each gene. As argued in the *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* paper, these two statistics are approximately independent under the null hypothesis. Thus we have all the ingredient necessary for a *[IHW](https://bioconductor.org/packages/3.22/IHW)* analysis (p-values and covariates), which we will apply at a significance level 0.1.

## 2.1 FDR control

First load IHW:

```
library("IHW")
ihwRes <- ihw(pvalue ~ baseMean,  data = deRes, alpha = 0.1)
```

This returns an object of the class ihwResult. We can get, e.g., the total number of rejections.

```
rejections(ihwRes)
```

```
## [1] 4892
```

And we can also extract the adjusted p-values:

```
head(adj_pvalues(ihwRes))
```

```
## [1] 0.00102074         NA 0.16260848 0.86124686 1.00000000 1.00000000
```

```
sum(adj_pvalues(ihwRes) <= 0.1, na.rm = TRUE) == rejections(ihwRes)
```

```
## [1] TRUE
```

We can compare this to the result of applying the method of Benjamini and Hochberg to the p-values only:

```
padjBH <- p.adjust(deRes$pvalue, method = "BH")
sum(padjBH <= 0.1, na.rm = TRUE)
```

```
## [1] 4099
```

*[IHW](https://bioconductor.org/packages/3.22/IHW)* produced quite a bit more rejections than that.
How did we get this power? Essentially it was possible by assigning appropriate weights to each hypothesis. We can retrieve the weights as follows:

```
head(weights(ihwRes))
```

```
## [1] 2.366789       NA 2.366789 2.366789 1.263387 0.000000
```

Internally, what happened was the following: We split the hypotheses into \(n\) different strata (here \(n=22\)) based on increasing value of `baseMean` and we also randomly split them into \(k\) folds (here \(k=5\)). Then, for each combination of fold and stratum, we learned the weights. The discretization into strata facilitates the estimation of the distribution function conditionally on the covariate and the optimization of the weights. The division into random folds helps us to avoid overfitting the data, something which could otherwise result in loss of control of the FDR (Ignatiadis et al. [2016](#ref-ignatiadis2016natmeth)).

The values of \(n\) and \(k\) can be accessed through

```
c(nbins(ihwRes), nfolds(ihwRes))
```

```
## [1] 22  5
```

In particular, each hypothesis test gets assigned a weight depending on the combination of its assigned fold and stratum.

We can also see this internal representation of the weights as a (\(n\) X \(k\)) matrix:

```
weights(ihwRes, levels_only = TRUE)
```

```
##            [,1]      [,2]       [,3]      [,4]      [,5]
##  [1,] 0.0000000 0.0000000 0.00000000 0.0000000 0.0000000
##  [2,] 0.0000000 0.0000000 0.00000000 0.0000000 0.0000000
##  [3,] 0.0000000 0.0000000 0.00000000 0.0000000 0.0000000
##  [4,] 0.0000000 0.0000000 0.00000000 0.0000000 0.0000000
##  [5,] 0.0000000 0.0000000 0.00000000 0.0000000 0.0000000
##  [6,] 0.0000000 0.0000000 0.00000000 0.0000000 0.0000000
##  [7,] 0.0000000 0.0000000 0.00000000 0.0000000 0.0000000
##  [8,] 0.0000000 0.0000000 0.00000000 0.0000000 0.0000000
##  [9,] 0.0000000 0.0000000 0.00000000 0.0000000 0.0000000
## [10,] 0.0000000 0.0000000 0.00000000 0.0000000 0.0000000
## [11,] 0.2109405 0.2081831 0.03842498 0.2571217 0.2597236
## [12,] 0.9162309 0.7947122 0.21091412 0.8534397 0.8345059
## [13,] 0.9254299 0.7947122 0.92276703 0.8534397 0.9075388
## [14,] 1.2633867 1.0511555 1.25975138 1.2265498 1.2389620
## [15,] 2.8869427 2.4482091 2.52720882 2.8097858 2.3857529
## [16,] 2.8869427 2.4482091 2.52720882 2.8097858 2.3857529
## [17,] 2.0875843 2.3667885 3.19833627 2.8097858 2.3503772
## [18,] 2.3930928 2.3667885 2.88745672 2.3268306 2.3503772
## [19,] 2.1950851 2.3667885 2.38786536 1.9327308 2.2688409
## [20,] 2.4675513 2.4159384 2.38786536 2.3956042 2.3637281
## [21,] 1.8521421 2.2447180 1.58228861 1.5405863 2.3335436
## [22,] 2.2744492 2.2447180 2.26790467 2.0358541 2.2112801
```

## 2.2 Diagnostic plots

### 2.2.1 Estimated weights

```
plot(ihwRes)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the IHW package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

We see that the general trend is driven by the covariate (stratum) and is the same across the different folds. As expected, the weight functions calculated on different random subsets of the data behave similarly. For the data at hand, genes with very low `baseMean` count get assigned a weight of 0, while genes with high baseMean count get prioritized.

### 2.2.2 Decision boundary

```
plot(ihwRes, what = "decisionboundary")
```

![](data:image/png;base64...)
The plot shows the implied decision boundaries for the unweighted p-values, as a function of the covariate.

### 2.2.3 Raw versus adjusted p-values

```
library("ggplot2")
gg <- ggplot(as.data.frame(ihwRes), aes(x = pvalue, y = adj_pvalue, col = group)) +
  geom_point(size = 0.25) + scale_colour_hue(l = 70, c = 150, drop = FALSE)
gg
```

![](data:image/png;base64...)

```
gg %+% subset(as.data.frame(ihwRes), adj_pvalue <= 0.2)
```

![](data:image/png;base64...)

The ihwResult object `ihwRes` can be converted to a dataframe that contains the following columns:

```
ihwResDf <- as.data.frame(ihwRes)
colnames(ihwResDf)
```

```
## [1] "pvalue"          "adj_pvalue"      "weight"          "weighted_pvalue"
## [5] "group"           "covariate"       "fold"
```

## 2.3 FWER control with IHW

The standard IHW method presented above controls the FDR by using a weighted Benjamini-Hochberg procedure with data-driven weights. The same principle can be applied for FWER control by using a weighted Bonferroni procedure. Everything works exactly as above, just use the argument `adjustment_type`. For example:

```
ihwBonferroni <- ihw(pvalue ~ baseMean, data = deRes, alpha = 0.1, adjustment_type = "bonferroni")
```

# 3 Other data types, and how to choose the covariate

## 3.1 Criteria for choosing a covariate

In which cases is IHW applicable? Whenever we have a covariate that is:

1. informative of power or prior probability
2. independent of the p-values under the null hypothesis
3. not notably related to the dependence structure -if there is any- of the joint test statistics.

## 3.2 Examples

* For \(t\)-tests we can use the overall variance (Bourgon, Gentleman, and Huber [2010](#ref-bourgon2010independent)).
* For rank-based tests (e.g., Wilcoxon) we can use any function that does not depend on the order of arguments (Bourgon, Gentleman, and Huber [2010](#ref-bourgon2010independent)).
* In DESeq2, we can use `baseMean`, as illustrated above (Love, Huber, and Anders [2014](#ref-love2014moderated)).
* In eQTL analysis we can use SNP-gene distance, DNAse sensitivity, a HiC-derived measure for proximity, etc. (Ignatiadis et al. [2016](#ref-ignatiadis2016natmeth)).
* In genome-wide association (GWAS), the allele frequency.
* In quantitative proteomics with mass spectrometry, the number of peptides (Ignatiadis et al. [2016](#ref-ignatiadis2016natmeth)).

## 3.3 Why are the different covariate criteria necessary?

The power gains of IHW are related to property 1, while its statistical validity relies on properties 2 and 3. For many practically useful combinations of covariates with test statistics, property 2 is easy to prove (e.g. through Basu’s theorem as in the \(t\)-test / variance example), while for others it follows by the use of deterministic covariates and well calibrated p-values (as in the SNP-gene distance example). Property 3 is more complicated from a theoretical perspective, but rarely presents a problem in practice – in particular, when the covariate is well thought out, and when the test statistics is such that it is suitable for the Benjamini Hochberg method without weighting.

If one expects strong correlations among the tests, then one should take care to use a covariate that is not a driving force behind these correlations. For example, in genome-wide association studies, the genomic coordinate of each SNP tested is not a valid covariate, because the position is related to linkage disequilibrium (LD) and thus correlation among tests. On the other hand, in eQTL, the distance between SNPs and phenotype (i.e. transcribed gene) is not directly related to (i.e. does not notably increase or decrease) any potential correlations between test statistics, and thus is a valid covariate.

## 3.4 Diagnostic plots for the covariate

Below we describe a few useful diagnostics to check whether the criteria for the covariates are applicable. If any of these are violated, one should not use IHW with the given covariate.

### 3.4.1 Scatter plots

To check whether the covariate is informative about power under the alternative (property 1), plot the p-values (or usually better, \(-\log\_{10}(\text{p-values})\)) against the ranks of the covariate:

```
deRes <- na.omit(deRes)
deRes$geneid <- as.numeric(gsub("ENSG[+]*", "", rownames(deRes)))

# set up data frame for ggplotting
rbind(data.frame(pvalue = deRes$pvalue, covariate = rank(deRes$baseMean)/nrow(deRes),
                 covariate_type="base mean"),
      data.frame(pvalue = deRes$pvalue, covariate = rank(deRes$geneid)/nrow(deRes),
                 covariate_type="gene id")) %>%
ggplot(aes(x = covariate, y = -log10(pvalue))) + geom_hex(bins = 100) +
   facet_grid( . ~ covariate_type) + ylab(expression(-log[10]~p))
```

![](data:image/png;base64...)

On the left, we plotted \(-\log\_{10}(\text{p-value})\) agains the (normalized) ranks of the base mean of normalized counts. This was the covariate we used in our *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* example above. We see the trend: low p-values are enriched at high covariate values. For very low covariate values, there are almost no small p-values. This indicates that the base mean covariate is correlated with power under the alternative.

On the other hand, the right plot uses a less useful statistic; the gene identifiers interpreted as numbers. Here, there is no obvious trend to be detected.

### 3.4.2 Stratified p-value histograms

One of the most useful diagnostic plots is the p-value histogram (before applying any multiple testing procedure). We first do this for our *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* p-values:

```
ggplot(deRes, aes(x = pvalue)) + geom_histogram(binwidth = 0.025, boundary = 0)
```

![](data:image/png;base64...)

This is a well calibrated histogram. As expected, for large p-values (e.g., for p-values \(\geq 0.5\)) the distribution looks uniform. This part of the histogram corresponds mainly to null p-values. On the other hand, there is a peak close to 0. This is due to the alternative hypotheses and can be observed whenever the tests have enough power to detect the alternative. In particular, in the *[airway](https://bioconductor.org/packages/3.22/airway)* dataset, as analyzed with DESeq2, we have a lot of power to detect differentially expressed genes. If you are not familiar with these concepts and more generally with interpreting p-value histograms, we recommend reading [David Robinson’s blog post](http://varianceexplained.org/statistics/interpreting-pvalue-histogram/).

Now, when applying IHW with covariates, it is instrumental to not only check the histogram over all p-values, but also to check histograms stratified by the covariate.

Here we split the hypotheses by the base mean of normalized counts into a few strata and then visualize the conditional histograms:

```
deRes$baseMeanGroup <- groups_by_filter(deRes$baseMean, 8)

ggplot(deRes, aes(x=pvalue)) +
  geom_histogram(binwidth = 0.025, boundary = 0) +
  facet_wrap( ~ baseMeanGroup, nrow = 2)
```

![](data:image/png;base64...)

Note that all of these histograms are well calibrated, since all of them show a uniform distribution at large p-values. In many realistic examples, if this is the case, then IHW will control the FDR. Thus, this is a good check of whether properties 2 and 3 hold. In addition, these conditional histograms also illustrate whether property 1 holds: as we move to strata with higher mean counts, the peak close to 0 becomes taller and the height of the uniform tail becomes lower. This means that the covariate is associated with power under the alternative.

The empirical cumulative distribution functions (ECDF) offer a variation of this visualisation. Here, one should check whether the curves can be easily distinguished and whether they are almost linear for high p-values.

```
ggplot(deRes, aes(x = pvalue, col = baseMeanGroup)) + stat_ecdf(geom = "step")
```

![](data:image/png;base64...)

Finally, as an example of an invalid covariate, we use the estimated log fold change. Of course, this is not independent of the p-values under the null hypothesis. We confirm this by plotting conditional histograms / ECDFs, which are not well calibrated:

```
deRes$lfcGroup <- groups_by_filter(abs(deRes$log2FoldChange),8)

ggplot(deRes, aes(x = pvalue)) +
  geom_histogram(binwidth = 0.025, boundary = 0) +
  facet_wrap( ~ lfcGroup, nrow=2)
```

![](data:image/png;base64...)

```
ggplot(deRes, aes(x = pvalue, col = lfcGroup)) + stat_ecdf(geom = "step")
```

![](data:image/png;base64...)

## 3.5 Further reading about appropriate covariates

For more details regarding choice and diagnostics of covariates, please also consult the Independent Filtering paper (Bourgon, Gentleman, and Huber [2010](#ref-bourgon2010independent)), as well as the *[genefilter](https://bioconductor.org/packages/3.22/genefilter)* vignettes.

# 4 Advanced usage: Working with incomplete p-value lists

So far, we have assumed that a complete list of p-values is available, i.e. for each test that was performed we know the resulting p-value. However, this information is not always available or practical.

* Some software tools simply do not calculate or report all p-values. For example, as noted by (Ochoa et al. [2015](#ref-ochoa2015beyond)), HMMER only returns the lowest p-values. Similarly, MatrixEQTL (Shabalin [2012](#ref-shabalin2012matrix)) by default only returns p-values below a pre-specified threshold, for example all p-values below \(10^{-5}\). In the case of HMMER, this is done because higher p-values are not reliable, while for MatrixEQTL it reduces storage requirements.
* Generally for very large multiple testing problems, it can be practical to only explicitly compute and store small enough p-values, and for the larger ones only record that they they were large, but not the precise value. This can greatly reduce the needed computing resources (in particular, working memory).

Since rejections take place at the low end of the p-value distribution, we do not lose a lot of information by discarding the exact values of the higher p-values, as long as we keep track of how many of them there are. Thus, the above situations can be easily handled.

Before proceeding with the walkthrough for handling such cases with IHW, we quickly review how this is handled by `p.adjust`. We first simulate some data, where the power under the alternative depends on a covariate `X`. p-values are calculated by a simple one-sided z-test.

```
sim <- tibble(
  X = runif(100000, min = 0, max = 2.5),         # covariate
  H = rbinom(length(X), size = 1, prob = 0.1),   # hypothesis true or false
  Z = rnorm(length(X), mean = H * X),            # Z-score
  p = 1 - pnorm(Z))                              # pvalue
```

We can apply the Benjamini-Hochberg procedure to these p-values:

```
sim <- mutate(sim, padj = p.adjust(p, method="BH"))
sum(sim$padj <= 0.1)
```

```
## [1] 466
```

Now assume we only have access to the p-values \(\leq 0.1\):

```
reporting_threshold <- 0.1
sim <- mutate(sim, reported = (p <= reporting_threshold))
simSub <- filter(sim, reported)
```

Then we can still use `p.adjust` on `simSub`, as long as we inform it of how many hypotheses were originally. We specify this by setting the `n` function argument.

```
simSub = mutate(simSub, padj2 = p.adjust(p, method = "BH", n = nrow(sim)))
ggplot(simSub, aes(x = padj, y = padj2)) + geom_point(cex = 0.2)
```

![](data:image/png;base64...)
The plot shows the BH-adjusted p-values computed from all p-values and then subset (x-axis) versus the BH-adjusted p-values computed from the subset of `reported` p-values only, using the `n` argument of `p.adjust` (y-axis).

```
stopifnot(with(simSub, max(abs(padj - padj2)) <= 0.001))
```

We see that the results agree. Now, the same approach can be used with IHW, but is slighly more complicated. In particular, we need to provide information about how many hypotheses were tested at each given value of the covariate. This means that there are two modifications to the standard IHW workflow:

* If a numeric covariate is provided, IHW internally discretizes it and in this way bins the hypotheses into groups (strata). For the advanced functionality, this discretization has to be done beforehand by the user. In other words, the covariate provided by the user has to be a factor. For this, the convenience function `groups_by_filter` is provided, which returns a factor that stratifies a numeric covariate into a given number of groups with approximately the same number of hypotheses in each of the groups. This is a very simple function, largely equivalent to `cut(., quantile(., probs = seq(0, 1, length.out = nbins))`.
* For the algorithm to work correctly, it is necessary to know the total number of hypotheses in each of the bins. However, if only a subset of p-values are reported, IHW obviously cannot know the number of hypotheses per bin automatically. Therefore, the user has to specify this information manually via the `m_groups` argument. (When there is only 1 bin, IHW reduces to BH and `m_groups` would be equivalent to the `n` argument of `p.adjust`.)

For example, if the whole grouping factor is available (e.g., when it was generated by using `groups_by_filter` on the full vector of covariates), then one can apply the `table` function to it to calculate the number of hypotheses per bin. This is then used as an input for the `m_groups` argument. More elaborate strategies are needed in more complicated cases, e.g., when the full vector of covariates does not fit into memory.

```
nbins <- 20
sim <- mutate(sim, group = groups_by_filter(X, nbins))
m_groups  <- table(sim$group)
```

Now we can apply IHW to the data subset that results from only keeping low p-values (`reported` is `TRUE`), with the manually specified `m_groups`.

```
ihwS <- ihw(p ~ group, alpha = 0.1, data = filter(sim, reported), m_groups = m_groups)
ihwS
```

```
## ihwResult object with 13805 hypothesis tests
## Nominal FDR control level: 0.1
## Split into 20 bins, based on an ordinal covariate
```

For comparison, let’s also call IHW on the full dataset (in a real application, this would normally not be available).

```
ihwF <- ihw(p ~ group, alpha = 0.1, data = sim)
```

Now we can compare `ihwS` and `ihwF`. This is a little bit more subtle than above for the BH method, because

1. unlike BH, IHW also uses the information available in higher p-values to determine the weights (i.e. the Grenander estimator of the p-value distribution will be slighly different if you only use a subset of small p-values), and more importantly
2. because IHW involves “random” data splitting, which pans out differently when the set of hypotheses is different.

Modulo these two aspects, the results should be approximately the same, in terms of the weights curves and the final number of rejections.

```
gridExtra::grid.arrange(
  plot(ihwS),
  plot(ihwF),
  ncol = 2)
```

![](data:image/png;base64...)

```
c(rejections(ihwS),
  rejections(ihwF))
```

```
## [1] 875 874
```

We can also plot the weighted, BH-adjusted p-values against each other:

```
qplot(adj_pvalues(ihwF)[sim$reported], adj_pvalues(ihwS), cex = I(0.2),
      xlim = c(0, 0.1), ylim = c(0, 0.1)) + coord_fixed()
```

![](data:image/png;base64...)

# References

Benjamini, Yoav, and Yosef Hochberg. 1995. “Controlling the False Discovery Rate: A Practical and Powerful Approach to Multiple Testing.” *Journal of the Royal Statistical Society. Series B (Statistical Methodology)*, 289–300.

Bourgon, Richard, Robert Gentleman, and Wolfgang Huber. 2010. “Independent Filtering Increases Detection Power for High-Throughput Experiments.” *Proceedings of the National Academy of Sciences (PNAS)* 107 (21): 9546–51.

Ignatiadis, Nikolaos, Bernd Klaus, Judith B Zaugg, and Wolfgang Huber. 2016. “Data-Driven Hypothesis Weighting Increases Detection Power in Genome-Scale Multiple Testing.” *Nature Methods*. <https://doi.org/10.1038/nmeth.3885>.

Love, Michael I, Wolfgang Huber, and Simon Anders. 2014. “Moderated Estimation of Fold Change and Dispersion for RNA-Seq Data with DESeq2.” *Gnome Biology* 15 (12): 550.

Ochoa, Alejandro, John D Storey, Manuel Llinás, and Mona Singh. 2015. “Beyond the E-Value: Stratified Statistics for Protein Domain Prediction.” *PLoS Computational Biology* 11 (11): e1004509.

Shabalin, Andrey A. 2012. “Matrix eQTL: Ultra Fast eQTL Analysis via Large Matrix Operations.” *Bioinformatics* 28 (10): 1353–8.