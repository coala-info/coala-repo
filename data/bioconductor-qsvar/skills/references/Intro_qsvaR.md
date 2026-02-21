Code

* Show All Code
* Hide All Code

# Introduction to qsvaR

Joshua M. Stolz1\*, Hedia Tnani1\*\* and Leonardo Collado-Torres1\*\*\*

1Lieber Institute for Brain Development

\*jstolz80@gmail.com
\*\*hediatnani0@gmail.com
\*\*\*lcolladotor@gmail.com

#### 30 October 2025

#### Package

qsvaR 1.14.0

# 1 Basics

## 1.1 Install `qsvaR`

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[qsvaR](https://bioconductor.org/packages/3.22/qsvaR)* is a `R` package available via the [Bioconductor](http://bioconductor.org) repository for packages. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[qsvaR](https://bioconductor.org/packages/3.22/qsvaR)* by using the following commands in your `R` session:

```
## To install Bioconductor packages
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("qsvaR")

## Check that you have a valid Bioconductor installation
BiocManager::valid()

## You can install the development version from GitHub with:
BiocManager::install("LieberInstitute/qsvaR")
```

## 1.2 Required knowledge

*[qsvaR](https://bioconductor.org/packages/3.22/qsvaR)* is based on many other packages and in particular in those that have implemented the infrastructure needed for dealing with RNA-seq data. That is, packages like *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*. Here it might be useful for you to check the qSVA framework manuscript ([Jaffe et al, PNAS, 2017](https://doi.org/10.1073/pnas.1617384114)).

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `qsvaR` tag and check [the older posts](https://support.bioconductor.org/t/qsvaR/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing `qsvaR`

We hope that *[qsvaR](https://bioconductor.org/packages/3.22/qsvaR)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("qsvaR")
#> To cite package 'qsvaR' in publications use:
#>
#>   Stolz JM, Tnani H, Collado-Torres L (2025). _qsvaR_.
#>   doi:10.18129/B9.bioc.qsvaR <https://doi.org/10.18129/B9.bioc.qsvaR>,
#>   https://github.com/LieberInstitute/qsvaR/qsvaR - R package version
#>   1.14.0, <http://www.bioconductor.org/packages/qsvaR>.
#>
#>   Stolz JM, Tnani H, Tao R, Jaffe AE, Collado-Torres L (2025). "qsvaR."
#>   _bioRxiv_. doi:10.1101/TODO <https://doi.org/10.1101/TODO>,
#>   <https://www.biorxiv.org/content/10.1101/TODO>.
#>
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

# 2 `qsvaR` Overview

```
library("qsvaR")
library("limma")
library("BiocFileCache")
```

## 2.1 Significant Transcripts

Differential expressions analysis requires the ability normalize complex datasets. In the case of postmortem brain tissue we are tasked with removing the effects of bench degradation. Our current work expands the scope of qSVA by generating degradation profiles (5 donors across 4 degradation time points: 0, 15, 30, and 60 minutes) from six human brain regions (n = 20 \* 6 = 120): dorsolateral prefrontal cortex (DLPFC), hippocampus (HPC), medial prefrontal cortex (mPFC), subgenual anterior cingulate cortex (sACC), caudate, amygdala (AMY). We identified an average of 80,258 transcripts associated (FDR < 5%) with degradation time across the six brain regions. Testing for an interaction between brain region and degradation time identified 45,712 transcripts (FDR < 5%). A comparison of regions showed a unique pattern of expression changes associated with degradation time particularly in the DLPFC, implying that this region may not be representative of the effects of degradation on gene expression in other tissues. Furthermore previous work was done by analyzing expressed regions ([Collado-Torres et al, NAR, 2017](https://doi.org/10.1093/nar/gkw852)), and while this is an effective method of analysis, expressed regions are not a common output for many pipelines and are computationally expensive to identify, thus creating a barrier for the use of any qSVA software. In our most recent work expression quantification was performed at the transcript level using Salmon ([Patro et al, Nat Methods, 2017](https://doi.org/10.1038/nmeth.4197)). The changes from past work on qSVs to now is illustrated in the below cartoon.

![The diagram on the right shows the 2016 experimental design for qSVA.The diagram on the right shows the 2022 experimental design for qSVA.](data:image/png;base64...)

Figure 1: The diagram on the right shows the 2016 experimental design for qSVA.The diagram on the right shows the 2022 experimental design for qSVA

The *[qsvaR](https://bioconductor.org/packages/3.22/qsvaR)* (Stolz, Tnani, and Collado-Torres, 2025) package combines an established method for removing the effects of degradation from RNA-seq data with easy to use functions. The first step in this workflow is to create an [`RangedSummarizedExperiment`](https://www.rdocumentation.org/packages/SummarizedExperiment/versions/1.2.3/topics/RangedSummarizedExperiment-class) object with the transcripts identified in our qSVA experiment. If you already have a [`RangedSummarizedExperiment`](https://www.rdocumentation.org/packages/SummarizedExperiment/versions/1.2.3/topics/RangedSummarizedExperiment-class) of transcripts we can do this with the `getDegTx()` function as shown below.If not this can be generated with the `SPEAQeasy` (a RNA-seq pipeline maintained by our lab) pipeline usinge the `--qsva` flag. If you already have a [`RangedSummarizedExperiment`](https://www.rdocumentation.org/packages/SummarizedExperiment/versions/1.2.3/topics/RangedSummarizedExperiment-class) object with transcripts then you do not need to run `SPEAQeasy`. This flag requires a full path to a text file, containing one Ensembl transcript ID per line for each transcript desired in the final transcripts R output object (called `rse_tx`). The `sig_transcripts` argument in this package should contain the same Ensembl transcript IDs as the text file for the `--qsva` flag. The goal of `qsvaR` is to provide software that can remove the effects of bench degradation from RNA-seq data.

```
bfc <- BiocFileCache::BiocFileCache()

## Download brainseq phase 2 ##
rse_file <- BiocFileCache::bfcrpath(
    "https://s3.us-east-2.amazonaws.com/libd-brainseq2/rse_tx_unfiltered.Rdata",
    x = bfc
)
load(rse_file, verbose = TRUE)
#> Loading objects:
#>   rse_tx
## keep only adult samples and apply minimum expression cutoff
rse_tx <- rse_tx[, rse_tx$Age > 17]
rse_tx <- rse_tx[rowMeans(assays(rse_tx)$tpm) > 0.3, ]
```

## 2.2 Get Degradation Matrix

In this next step we subset for the transcripts associated with degradation. These were determined by Joshua M. Stolz et al, 2022. We have provided three models to choose from. Here the names `"cell_component"`, `"top1500"`, and `"top1000"` refer to models that were determined to be effective in removing degradation effects. The `"top1000"` model involves taking the union of the top 1000 transcripts associated with degradation from the interaction model and the main effect model. The `"top1500"` model is the same as the `"top1000"` model except the union of the top 1500 genes associated with degradation is selected. The most effective of our models, `"cell_component"`, involved deconvolution of the degradation matrix to determine the proportion of cell types within our studied tissue. These proportions were then added to our `model.matrix()` and the union of the top 1000 transcripts in the interaction model, the main effect model, and the cell proportions model were used to generate this model of quality surrogate variables (qSVs). In this example we will choose `"cell_component"` when using the `getDegTx()` and `select_transcripts()` functions.

![The above venn diagram shows the overlap between transcripts in each of the previously mentioned models.](data:image/png;base64...)

Figure 2: The above venn diagram shows the overlap between transcripts in each of the previously mentioned models

```
# obtain transcripts with degradation signature
DegTx <- getDegTx(
  rse_tx, sig_transcripts = select_transcripts(cell_component = TRUE)
)
#> Using 2315 degradation-associated transcripts.
dim(DegTx)
#> [1] 2315  755
```

## 2.3 Generate principal components

The qSVs are derived from taking the principal components (PCs) of the selected transcript expression data. This can be done with the function `getPCs`. qSVs are essentially pricipal components from an rna-seq experiment designed to model bench degradation. For more on principal components you can read and introductory article [`here`](https://towardsdatascience.com/tidying-up-with-pca-an-introduction-to-principal-components-analysis-f876599af383). `rse_tx` specifies a [`RangedSummarizedExperiment`](https://www.rdocumentation.org/packages/SummarizedExperiment/versions/1.2.3/topics/RangedSummarizedExperiment-class) object that has the specified degraded transcripts. For us this is `DegTx`. Here `tpm` is the name of the assay we are using within the [`RangedSummarizedExperiment`](https://www.rdocumentation.org/packages/SummarizedExperiment/versions/1.2.3/topics/RangedSummarizedExperiment-class) object, where TPM stands for *transcripts per million*.

```
pcTx <- getPCs(rse_tx = DegTx, assayname = "tpm")
```

## 2.4 Calculate Number of PCs Needed

Next we use the `k_qsvs()` function to calculate how many PCs we will need to account for the variation. A model matrix accounting for relevant variables should be used. Common variables such as Age, Sex, Race and Religion are often included in the model. Again we are using our `RangedSummarizedExperiment` `DegTx` as the `rse_tx` option. Next we specify the `mod` with our `model.matrix()`. `model.matrix()` creates a design (or model) matrix, e.g., by expanding factors to a set of dummy variables (depending on the contrasts) and expanding interactions similarly. For more information on creating a design matrix for your experiment see the documentation [here](http://bioconductor.org/packages/release/workflows/vignettes/RNAseq123/inst/doc/designmatrices.html). Again we use the `assayname` option to specify that we are using the `tpm` assay.

```
# design a basic model matrix to model the number of pcs needed
mod <- model.matrix(~ Dx + Age + Sex + Race + Region,
    data = colData(rse_tx)
)

## To ensure that the results are reproducible, you will need to set a
## random seed with the set.seed() function. Internally, we are using
## sva::num.sv() which needs a random seed to ensure reproducibility of the
## results.
set.seed(20230621)

# use k qsvs function to return a integer of pcs needed
k <- k_qsvs(rse_tx = DegTx, mod = mod, assayname = "tpm")
print(k)
#> [1] 19
```

## 2.5 Return qSV Matrix

Finally we subset our data to the calculated number of PCs. The output of this function will be the qsvs for each sample. Here we use the `qsvPCs` argument to enter the principal components (`pcTx`). Here the argument k is the number of PCs we are going to include as calculated in the previous step.

```
# get_qsvs use k to subset our pca analysis
qsvs <- get_qsvs(qsvPCs = pcTx, k = k)
dim(qsvs)
#> [1] 755  19
```

This can be done in one step with our wrapper function `qSVA` which just combinds all the previous mentioned functions.

```
## To ensure that the results are reproducible, you will need to set a
## random seed with the set.seed() function. Internally, we are using
## sva::num.sv() which needs a random seed to ensure reproducibility of the
## results.
set.seed(20230621)

## Example use of the wrapper function qSVA()
qsvs_wrapper <- qSVA(
    rse_tx = rse_tx,
    sig_transcripts = select_transcripts(cell_component = TRUE),
    mod = mod,
    assayname = "tpm"
)
#> Using 2315 degradation-associated transcripts.
dim(qsvs_wrapper)
#> [1] 755  19
```

## 2.6 Differential Expression

Next we can use a standard limma package approach to do differential expression on the data. The key here is that we add our qsvs to the `model.matrix()`. Here we input our `RangedSummarizedExperiment` object and our `model.matrix()` with qSVs. Note here that the `RangedSummarizedExperiment` object is the original object loaded with the full list of transcripts, not the the one we subsetted for qSVs. This is because while PCs can be generated from a subset of genes, differential expression is best done on the full dataset. The expected output is a `sigTx` object that shows the results of differential expression.

```
# create a model.matrix with demographic info and qsvs
mod_qSVA <- cbind(mod, qsvs)

# log tranform transcript expression
txExprs <- log2(assays(rse_tx)$tpm + 1)

# linear model differential expression
fitTx <- lmFit(txExprs, mod_qSVA)

# generate empirical bayes for DE
eBTx <- eBayes(fitTx)

# get DE results table
sigTx <- topTable(eBTx,
    coef = 2,
    p.value = 1, number = nrow(rse_tx)
)
head(sigTx)
#>                         logFC  AveExpr         t      P.Value    adj.P.Val
#> ENST00000484223.1 -0.16801225 1.155197 -6.434391 2.241717e-10 2.253733e-05
#> ENST00000344423.9  0.08388265 1.823057  6.023398 2.705136e-09 1.359818e-04
#> ENST00000453370.1 -0.14813207 1.405052 -5.578121 3.424946e-08 1.060144e-03
#> ENST00000399808.4  0.24131361 4.393914  5.540228 4.217967e-08 1.060144e-03
#> ENST00000373510.8  0.03789957 1.274950  5.486733 5.647882e-08 1.135631e-03
#> ENST00000446193.1 -0.12094546 2.303149 -5.277337 1.729461e-07 2.663972e-03
#>                           B
#> ENST00000484223.1 13.199862
#> ENST00000344423.9 10.837738
#> ENST00000453370.1  8.437965
#> ENST00000399808.4  8.241509
#> ENST00000373510.8  7.966261
#> ENST00000446193.1  6.912510
```

If we look at a plot of our most significant transcript we can see that at this level we don’t have that much fold change in our data at any individual transcript. These transcripts are however significant and it might be valuable to repeat the analysis at gene level. At gene level the results can be used to do gene ontology enrichment with packages such as *[clusterProfiler](https://bioconductor.org/packages/3.22/clusterProfiler)*.

```
# get expression for most significant gene
yy <- txExprs[rownames(txExprs) == rownames(sigTx)[1], ]

## Visualize the expression of this gene using boxplots
p <- boxplot(yy ~ rse_tx$Dx,
    outline = FALSE,
    ylim = range(yy), ylab = "log2 Exprs", xlab = "",
    main = paste(rownames(sigTx)[1])
)
```

![](data:image/png;base64...)

We can assess the effectiveness of our analysis by first performing DE without qSVs

```
# log tranform transcript expression
txExprs_noqsv <- log2(assays(rse_tx)$tpm + 1)

# linear model differential expression with generic model
fitTx_noqsv <- lmFit(txExprs_noqsv, mod)

# generate empirical bayes for DE
eBTx_noqsv <- eBayes(fitTx_noqsv)

# get DE results table
sigTx_noqsv <- topTable(eBTx_noqsv,
    coef = 2,
    p.value = 1, number = nrow(rse_tx)
)

## Explore the top results
head(sigTx_noqsv)
#>                        logFC   AveExpr         t      P.Value    adj.P.Val
#> ENST00000550948.1 -0.3354760 1.4286901 -8.476210 1.225373e-16 6.726210e-12
#> ENST00000399220.2 -0.4971139 1.8855923 -8.456466 1.430341e-16 6.726210e-12
#> ENST00000302632.3 -0.5085661 2.7498973 -8.413088 2.007105e-16 6.726210e-12
#> ENST00000540372.5 -0.1841983 0.5557803 -8.048071 3.284430e-15 8.255086e-11
#> ENST00000412814.1 -0.2602673 0.6388824 -7.785603 2.302633e-14 4.629950e-10
#> ENST00000237612.7 -0.2891861 2.3009743 -7.558877 1.186468e-13 1.988046e-09
#>                          B
#> ENST00000550948.1 26.83858
#> ENST00000399220.2 26.69150
#> ENST00000302632.3 26.36938
#> ENST00000540372.5 23.71308
#> ENST00000412814.1 21.86396
#> ENST00000237612.7 20.30843
```

Next we should subset our differential expression output to just the t-statistic

```
## Subset the topTable() results to keep just the t-statistic
DE_noqsv <- data.frame(t = sigTx_noqsv$t, row.names = rownames(sigTx_noqsv))
DE <- data.frame(t = sigTx$t, row.names = rownames(sigTx))

## Explore this data.frame()
head(DE)
#>                           t
#> ENST00000484223.1 -6.434391
#> ENST00000344423.9  6.023398
#> ENST00000453370.1 -5.578121
#> ENST00000399808.4  5.540228
#> ENST00000373510.8  5.486733
#> ENST00000446193.1 -5.277337
```

Using our `DEqual` function we can make a plot comparing the t-statistics from degradation and our differential expression output. In the first model below there is a 0.5 correlation between degradation t-statistics and our differential expression. This means the data is likely confounded for degradation and will lead to many false positives.

```
## Generate a DEqual() plot using the model results without qSVs
DEqual(DE_noqsv)
```

![Result of Differential Expression without qSVA normalization.](data:image/png;base64...)

(#fig:Generate DEqual without qSVs)Result of Differential Expression without qSVA normalization.

In the plot below when we add qSVs to our model we reduce the association with degradation to -0.014, which is very close to 0.

```
## Generate a DEqual() plot using the model results with qSVs
DEqual(DE)
```

![Result of Differential Expression with qSVA normalization.](data:image/png;base64...)

(#fig:Generate DEqual with qSVs)Result of Differential Expression with qSVA normalization.

# 3 Conclusion

We have shown that this method is effective for removing the effects of degradation from RNA-seq data. We found that the *[qsvaR](https://bioconductor.org/packages/3.22/qsvaR)* is simpler to use than the previous version from 2016 that used expressed regions instead of transcripts making this software package preferable for users. I would encourage users to read how each set of degradation transcripts was selected as not all models may be appropriate for every experiment. Thank you for your interest and for using *[qsvaR](https://bioconductor.org/packages/3.22/qsvaR)* (Stolz, Tnani, and Collado-Torres, 2025)!

# 4 Acknowledgements

We would like to thank:

* [Heena Divecha](https://twitter.com/HeenaDivecha) for proofreading the documentation of *[qsvaR](https://bioconductor.org/packages/3.22/qsvaR)*
* [Louise A. Huuki-Myers](https://twitter.com/lahuuki) for guidance with understanding R code and editing *[qsvaR](https://bioconductor.org/packages/3.22/qsvaR)*
* [Nicholas J. Eagles](https://github.com/nick-eagles) for help processing RNA-seq data with [`SPEAQeasy`](https://doi.org/10.1186/s12859-021-04142-3)
* [Aja Hope](https://twitter.com/AjasBlaaahg) for proofreading the documentation of *[qsvaR](https://bioconductor.org/packages/3.22/qsvaR)*

# 5 Reproducibility

The *[qsvaR](https://bioconductor.org/packages/3.22/qsvaR)* package (Stolz, Tnani, and Collado-Torres, 2025) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* (Shepherd and Morgan, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[covr](https://CRAN.R-project.org/package%3Dcovr)* (Hester, 2023)
* *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* (Wickham, 2016)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[limma](https://bioconductor.org/packages/3.22/limma)* (Ritchie, Phipson, Wu, Hu, Law, Shi, and Smyth, 2015)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)
* *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* (Morgan, Obenchain, Hester, and Pagès, 2025)
* *[sva](https://bioconductor.org/packages/3.22/sva)* (Leek, Johnson, Parker, Fertig, Jaffe, Zhang, Storey, and Torres, 2025)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("Intro_qsvaR.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("Intro_qsvaR.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 01:59:26 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 6.18 mins
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version   date (UTC) lib source
#>  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  annotate               1.88.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationDbi          1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  backports              1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache        * 3.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel           1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr               * 2.5.1     2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  edgeR                  4.8.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3     2023-12-11 [2] CRAN (R 4.5.1)
#>  genefilter             1.92.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2                4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1     2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  limma                * 3.66.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  locfit                 1.5-9.12  2025-03-05 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  mgcv                   1.9-3     2025-04-04 [3] CRAN (R 4.5.1)
#>  nlme                   3.1-168   2025-03-31 [3] CRAN (R 4.5.1)
#>  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  qsvaR                * 1.14.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3     2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  RSQLite                2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo              * 1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  SparseArray            1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  statmod                1.5.1     2025-10-09 [2] CRAN (R 4.5.1)
#>  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  survival               3.8-3     2024-12-17 [3] CRAN (R 4.5.1)
#>  sva                    3.58.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  viridisLite            0.4.2     2023-05-02 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53      2025-08-19 [2] CRAN (R 4.5.1)
#>  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  xtable                 1.8-4     2019-04-21 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/Rtmpze76tP/Rinst27291b27cb8809
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 6 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-hester2023covr)
J. Hester.
*covr: Test Coverage for Packages*.
R package version 3.6.4.
2023.
DOI: [10.32614/CRAN.package.covr](https://doi.org/10.32614/CRAN.package.covr).
URL: [https://CRAN.R-project.org/package=covr](https://CRAN.R-project.org/package%3Dcovr).

[[3]](#cite-leek2025surrogate)
J. T. Leek, W. E. Johnson, H. S. Parker, et al.
*sva: Surrogate Variable Analysis*.
R package version 3.58.0.
2025.
DOI: [10.18129/B9.bioc.sva](https://doi.org/10.18129/B9.bioc.sva).
URL: <https://bioconductor.org/packages/sva>.

[[4]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[5]](#cite-morgan2025summarizedexperiment)
M. Morgan, V. Obenchain, J. Hester, et al.
*SummarizedExperiment: A container (S4 class) for matrix-like assays*.
R package version 1.40.0.
2025.
DOI: [10.18129/B9.bioc.SummarizedExperiment](https://doi.org/10.18129/B9.bioc.SummarizedExperiment).
URL: <https://bioconductor.org/packages/SummarizedExperiment>.

[[6]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[7]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[8]](#cite-ritchie2015limma)
M. E. Ritchie, B. Phipson, D. Wu, et al.
“limma powers differential expression analyses for RNA-sequencing and microarray studies”.
In: *Nucleic Acids Research* 43.7 (2015), p. e47.
DOI: [10.1093/nar/gkv007](https://doi.org/10.1093/nar/gkv007).

[[9]](#cite-shepherd2025biocfilecache)
L. Shepherd and M. Morgan.
*BiocFileCache: Manage Files Across Sessions*.
R package version 3.0.0.
2025.
DOI: [10.18129/B9.bioc.BiocFileCache](https://doi.org/10.18129/B9.bioc.BiocFileCache).
URL: <https://bioconductor.org/packages/BiocFileCache>.

[[10]](#cite-stolz2025qsvar)
J. M. Stolz, H. Tnani, and L. Collado-Torres.
*qsvaR*.
<https://github.com/LieberInstitute/qsvaR/qsvaR> - R package version 1.14.0.
2025.
DOI: [10.18129/B9.bioc.qsvaR](https://doi.org/10.18129/B9.bioc.qsvaR).
URL: <http://www.bioconductor.org/packages/qsvaR>.

[[11]](#cite-wickham2016ggplot2)
H. Wickham.
*ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York, 2016.
ISBN: 978-3-319-24277-4.
URL: <https://ggplot2.tidyverse.org>.

[[12]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[13]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[14]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.