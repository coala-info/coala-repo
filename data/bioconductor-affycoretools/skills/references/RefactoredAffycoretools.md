# Creating annotated output with and ReportingTools

James W. MacDonald

#### 29 October 2025

# 1 Overview

The package is intended to help people easily create
useful output from various analyses. While affycoretools was
originally intended for those using Affymetrix microarrays, this is no
longer the case. While some functions remain Affy-centric, most are
now much more general, and can be used for any microarray or RNA-Seq
experiment.

# 2 Introduction

This package has evolved from my work as a service core
biostatistician. I routinely analyze very similar experiments, and
wanted to create a way to minimize all the cutting and pasting of code
that I found myself doing. In addition, I wanted to come up with a
good way to make an analysis reproducible, in the sense that I (or
somebody else) could easily re-create the results.

In the past this package relied on the package, and
was intended to be used in concert with a ‘Sweave’ document that
contained both the code that was used to analyze the data, as well as
explanatory text that would end up in a pdf (or HTML page) that could
be given to a client. In the intervening period, people have developed
other, better packages such as and
that make it much easier to create the sort
of output I like to present to my clients.

This document was generated using an Rmarkdown document (it’s the file
called RefactoredAffycoretools.Rmd that you can find in your R library
directory in the affycoretools/doc folder). Part of using Rmarkdown is
generating .Rmd files that contain R code, and for each code block
there are some arguments that define how the results for that code
block are returned. A good resource for the code options
is [here](https://yihui.name/knitr/options/).

# 3 Using affycoretools

For this section we will be using the
data set that comes with the package. Remember that
you can always run this code at home by doing this:

```
library(knitr)
purl(system.file("doc/RefactoredAffycoretools.Rmd", package="affycoretools"))
```

And then you will have a file called RefactoredAffycoretools.R in your
working directory that you can either or open with
or , and run by chunk or line
by line.

We first load and rename the data:

```
suppressMessages(library(affycoretools))
data(sample.ExpressionSet)
eset <- sample.ExpressionSet
eset
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 500 features, 26 samples
##   element names: exprs, se.exprs
## protocolData: none
## phenoData
##   sampleNames: A B ... Z (26 total)
##   varLabels: sex type score
##   varMetadata: labelDescription
## featureData: none
## experimentData: use 'experimentData(object)'
## Annotation: hgu95av2
```

This object is a truncated data set, based on
an Affymetrix HG-U95av2 array. There are 26 samples and 500
probesets. We will use the to fit a linear model
using .

Note that the limma package will retain annotation data that is in the
, so we add those data in using

```
suppressMessages(library(hgu95av2.db))
eset <- annotateEset(eset, hgu95av2.db)
```

```
## 'select()' returned 1:many mapping between keys and columns
## 'select()' returned 1:many mapping between keys and columns
## 'select()' returned 1:many mapping between keys and columns
```

```
suppressMessages(library(limma))
pd <- pData(phenoData(eset))
design <- model.matrix(~0+type+sex, pd)
colnames(design) <- gsub("type|sex", "", colnames(design))
contrast <- matrix(c(1,-1,0))
colnames(contrast) <- "Case vs control"
fit <- lmFit(eset, design)
fit2 <- contrasts.fit(fit, contrast)
fit2 <- eBayes(fit)
topTable(fit2, 1)[,1:4]
```

```
##                                         PROBEID ENTREZID   SYMBOL
## 31667_r_at                           31667_r_at    10002    NR2E3
## AFFX-HSAC07_X00351_M_st AFFX-HSAC07_X00351_M_st     <NA>     <NA>
## 31375_at                               31375_at     <NA>     <NA>
## 31466_at                               31466_at     3128 HLA-DRB6
## 31597_r_at                           31597_r_at     1978 EIF4EBP1
## 31440_at                               31440_at     6932     TCF7
## 31396_r_at                           31396_r_at     4440     MSI1
## AFFX-hum_alu_at                 AFFX-hum_alu_at     <NA>     <NA>
## 31391_at                               31391_at     9001     HAP1
## AFFX-HSAC07_X00351_3_at AFFX-HSAC07_X00351_3_at     <NA>     <NA>
##                                                                                   GENENAME
## 31667_r_at                                   nuclear receptor subfamily 2 group E member 3
## AFFX-HSAC07_X00351_M_st                                                               <NA>
## 31375_at                                                                              <NA>
## 31466_at                major histocompatibility complex, class II, DR beta 6 (pseudogene)
## 31597_r_at                   eukaryotic translation initiation factor 4E binding protein 1
## 31440_at                                                            transcription factor 7
## 31396_r_at                                                   musashi RNA binding protein 1
## AFFX-hum_alu_at                                                                       <NA>
## 31391_at                                                   huntingtin associated protein 1
## AFFX-HSAC07_X00351_3_at                                                               <NA>
```

After adding the annotation data to the object, the
output now contains the appropriate annotation
data for each probeset. At this point we can output an HTML table that
contains these data.

```
suppressMessages(library(ReportingTools))
htab <- HTMLReport("afile", "My cool results")
publish(topTable(fit2, 1), htab)
finish(htab)
```

```
## [1] "./afile.html"
```

If you run the code yourself, you will have an HTML file ‘afile.html’
in the working directory, that contains the data for our top 10
genes. This table is not particularly interesting, and the
package already has functionality to just do
something like

```
htab <- HTMLReport("afile2", "My cool results, ReportingTools style")
publish(fit2, htab, eset, factor = pd$type, coef = 1, n = 10)
finish(htab)
```

```
## [1] "./afile2.html"
```

and it will automatically generate another HTML file, ‘afile2.html’,
with some extra plots that show the different groups, and we didn’t
even have to use directly. However, the default
plots in the HTML table are a combination of dotplot and boxplot,
which I find weird. Since is easily
extensible, we can make changes that are more pleasing.

```
d.f <- topTable(fit2, 2)
out <- makeImages(df = d.f, eset = eset, grp.factor = pd$type, design = design,
                  contrast = contrast, colind = 1, repdir = ".")
htab <- HTMLReport("afile3", "My cool results, affycoretools style")
publish(out$df, htab, .mofifyDF = list(entrezLinks, affyLinks))
finish(htab)
```

```
## [1] "./afile3.html"
```

Note that there are two differences in the way we did things. First,
we create a , and then decorate it with the plots
using the function. This will by default create
dotplots (or you can specify boxplots). For the plots to fit in an
HTML table, there are no axis labels. However, each plot is also a
link, and if you click on it, a larger plot with axis labels will be
presented. If you are running the code yourself, see ‘afile3.html’.

All the little files that get created can get pretty messy, so the
default is to put everything into a ‘reports’ subdirectory, so your
working directory stays clean. For this example we over-ride the
defaults so we do not have to go searching in subdirectories for our
tables.

For HTML output the better idea is to generate a table using e.g., the
xtable package, with links to the tables that we have generated.

An alternative parameterization that probably makes more sense is to
fit coefficients for each sex/treatment combination.

```
grps <- factor(apply(pd[,1:2], 1, paste, collapse = "_"))
design <- model.matrix(~0+grps)
colnames(design) <- gsub("grps", "", colnames(design))
contrast <- matrix(c(1,-1,0,0,
                     0,0,1,-1,
                     1,-1,-1,1),
                   ncol = 3)
colnames(contrast) <- c("Female_Case vs Female_Control",
                        "Male_Case vs Male_Control",
                        "Interaction")
fit <- lmFit(eset, design)
fit2 <- contrasts.fit(fit, contrast)
fit2 <- eBayes(fit2)
```

With this parameterization we can look at intra-sex differences, as
well as the interaction (looking for sex-specific changes). This now
means that we have a total of three HTML tables to output, which makes
things a bit more complex to present. Luckily, this is pretty simple
to accomplish. For this step we will now use the default ‘reports’
subdirectory to keep everything straight. In addition, we will trim
down the output a bit.

```
## get a list containing the output for each comparison
out <- lapply(1:3, function(x) topTable(fit2, x))
## process the output to add images
htab <- lapply(1:3, function(x){
    tmp <- HTMLReport(gsub("_", " ", colnames(contrast)[x]), colnames(contrast)[x], "./reports")
    tmp2 <- makeImages(out[[x]], eset, grps, design, contrast, x)
    publish(tmp2$df, tmp, .modifyDF = list(affyLinks, entrezLinks))
    finish(tmp)
    return(tmp)
})
```

A reasonable thing to do would be to add a table to this document that
lists all the different comparisons we made, with a count of the genes
and links to the HTML tables we have generated. To do this we use the
xtable package (you could also use as well), and add
results = “asis” to the R code chunk in our Rmarkdown document.

```
d.f <- data.frame(Comparison =  sapply(htab, function(x) XML::saveXML(Link(x))),
                  "Number significant" = sapply(out, nrow), check.names = FALSE)
kable(d.f, caption = "Number of significant genes.",
      format = "html", row.names = FALSE)
```

Table 1: Number of significant genes.

| Comparison | Number significant |
| --- | --- |
| <a href=“./reports/Female Case vs Female Control.html”>Female\_Case vs Female\_Control</a> | 10 |
| <a href=“./reports/Male Case vs Male Control.html”>Male\_Case vs Male\_Control</a> | 10 |
| <a href=“./reports/Interaction.html”>Interaction</a> | 10 |

We are often asked to create a Venn diagram showing overlap between
groups. This is pretty simple to do, but it would be nicer to have an
HTML version with clickable links, so your PI or end user can see what
genes are in each cell of the Venn diagram. As an example, we can
generate a Venn diagram comparing overlapping genes between the male
and female comparisons.

```
collist <- list(1:2)
venn <- makeVenn(fit2, contrast, design, collist = collist, adj.meth = "none")
## generate a list of captions for each Venn.
## we only have one, so it's a list of length 1.
## we are using the BiocStyle package to control formatting,
## so the first sentence will be bolded and in blue.
cap <- list(paste("A Venn diagram. Note that the first sentence is bolded",
                  "and blue, whereas the rest is normal type and black. Usually",
                  "one would use a more useful caption than this one."))
vennInLine(venn, cap)
```

![./venns/venn1.png](data:image/png;base64...)

Figure 1: A Venn diagram
Note that the first sentence is bolded and blue, whereas the rest is normal type and black. Usually one would use a more useful caption than this one.

There is similar functionality for presenting the results of a GO
hypergeometric analysis (), and GSEA analysis,
based on the function in
( and ).

# 4 Session information

The version of R and packages loaded when creating this vignette were:

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
##  [1] ReportingTools_2.50.0 knitr_1.50            limma_3.66.0
##  [4] hgu95av2.db_3.13.0    org.Hs.eg.db_3.22.0   AnnotationDbi_1.72.0
##  [7] IRanges_2.44.0        S4Vectors_0.48.0      affycoretools_1.82.0
## [10] Biobase_2.70.0        BiocGenerics_0.56.0   generics_0.1.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1               BiocIO_1.20.0
##   [3] bitops_1.0-9                tibble_3.3.0
##   [5] R.oo_1.27.1                 preprocessCore_1.72.0
##   [7] graph_1.88.0                XML_3.99-0.19
##   [9] rpart_4.1.24                lifecycle_1.0.4
##  [11] edgeR_4.8.0                 lattice_0.22-7
##  [13] ensembldb_2.34.0            OrganismDbi_1.52.0
##  [15] backports_1.5.0             magrittr_2.0.4
##  [17] Hmisc_5.2-4                 sass_0.4.10
##  [19] rmarkdown_2.30              jquerylib_0.1.4
##  [21] yaml_2.3.10                 gcrma_2.82.0
##  [23] ggbio_1.58.0                DBI_1.2.3
##  [25] RColorBrewer_1.1-3          abind_1.4-8
##  [27] GenomicRanges_1.62.0        R.utils_2.13.0
##  [29] AnnotationFilter_1.34.0     biovizBase_1.58.0
##  [31] RCurl_1.98-1.17             nnet_7.3-20
##  [33] VariantAnnotation_1.56.0    AnnotationForge_1.52.0
##  [35] genefilter_1.92.0           annotate_1.88.0
##  [37] codetools_0.2-20            DelayedArray_0.36.0
##  [39] tidyselect_1.2.1            GOstats_2.76.0
##  [41] UCSC.utils_1.6.0            farver_2.1.2
##  [43] matrixStats_1.5.0           base64enc_0.1-3
##  [45] Seqinfo_1.0.0               GenomicAlignments_1.46.0
##  [47] jsonlite_2.0.0              Formula_1.2-5
##  [49] survival_3.8-3              iterators_1.0.14
##  [51] foreach_1.5.2               tools_4.5.1
##  [53] PFAM.db_3.22.0              Rcpp_1.1.0
##  [55] glue_1.8.0                  gridExtra_2.3
##  [57] SparseArray_1.10.0          xfun_0.53
##  [59] DESeq2_1.50.0               MatrixGenerics_1.22.0
##  [61] GenomeInfoDb_1.46.0         dplyr_1.1.4
##  [63] withr_3.0.2                 BiocManager_1.30.26
##  [65] Category_2.76.0             fastmap_1.2.0
##  [67] caTools_1.18.3              digest_0.6.37
##  [69] R6_2.6.1                    colorspace_2.1-2
##  [71] GO.db_3.22.0                gtools_3.9.5
##  [73] dichromat_2.0-0.1           RSQLite_2.4.3
##  [75] cigarillo_1.0.0             R.methodsS3_1.8.2
##  [77] data.table_1.17.8           rtracklayer_1.70.0
##  [79] httr_1.4.7                  htmlwidgets_1.6.4
##  [81] S4Arrays_1.10.0             pkgconfig_2.0.3
##  [83] gtable_0.3.6                blob_1.2.4
##  [85] S7_0.2.0                    hwriter_1.3.2.1
##  [87] XVector_0.50.0              Glimma_2.20.0
##  [89] htmltools_0.5.8.1           bookdown_0.45
##  [91] RBGL_1.86.0                 GSEABase_1.72.0
##  [93] ProtGenerics_1.42.0         oligoClasses_1.72.0
##  [95] scales_1.4.0                png_0.1-8
##  [97] rstudioapi_0.17.1           reshape2_1.4.4
##  [99] rjson_0.2.23                checkmate_2.3.3
## [101] curl_7.0.0                  cachem_1.1.0
## [103] stringr_1.5.2               KernSmooth_2.23-26
## [105] parallel_4.5.1              foreign_0.8-90
## [107] restfulr_0.0.16             pillar_1.11.1
## [109] grid_4.5.1                  vctrs_0.6.5
## [111] gplots_3.2.0                ff_4.5.2
## [113] xtable_1.8-4                cluster_2.1.8.1
## [115] htmlTable_2.4.3             Rgraphviz_2.54.0
## [117] evaluate_1.0.5              GenomicFeatures_1.62.0
## [119] cli_3.6.5                   locfit_1.5-9.12
## [121] compiler_4.5.1              Rsamtools_2.26.0
## [123] rlang_1.1.6                 crayon_1.5.3
## [125] labeling_0.4.3              affy_1.88.0
## [127] plyr_1.8.9                  stringi_1.8.7
## [129] BiocParallel_1.44.0         Biostrings_2.78.0
## [131] lazyeval_0.2.2              Matrix_1.7-4
## [133] BSgenome_1.78.0             bit64_4.6.0-1
## [135] ggplot2_4.0.0               KEGGREST_1.50.0
## [137] statmod_1.5.1               SummarizedExperiment_1.40.0
## [139] memoise_2.0.1               affyio_1.80.0
## [141] bslib_0.9.0                 bit_4.6.0
```