# Writing a book with reusable contents

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: March 13, 2021

#### Package

rebook 1.20.0

# Contents

* [1 Introduction](#introduction)
* [2 Creating a Bioconductor book](#creating-a-bioconductor-book)
* [3 Reusing objects between chapters](#reusing-objects-between-chapters)
* [4 Linking across books](#linking-across-books)
* [5 Reusing content across books](#reusing-content-across-books)
* [6 Pretty printing](#pretty-printing)

# 1 Introduction

This package implements utilities for an opinionated way of re-using content in *[bookdown](https://CRAN.R-project.org/package%3Dbookdown)* books.
The general idea is that you can take objects from a “donor” chapter and re-use them in another “acceptor” chapter, where the two chapters can be in different books altogether.
We can also generate links between books hosted by Bioconductor, allowing us to compartmentalize content without sacrificing integration of book contents.
Most of these ideas were developed in the process for the [Orchestrating single-cell analysis](https://osca.bioconductor.org) book,
but are hopefully applicable to other projects.

# 2 Creating a Bioconductor book

A Bioconductor book is implemented as an R package that contains *[bookdown](https://CRAN.R-project.org/package%3Dbookdown)* book in its `inst/book` directory.
That is to say, `inst/book` contains at least `index.Rmd` and `_bookdown.yml` such that `bookdown::render_book("inst/book/index.Rmd")` will compile the book.
We aim to support any *[bookdown](https://CRAN.R-project.org/package%3Dbookdown)*-compatible configuration within `inst/book`,
though the most well-tested configuration avoids using input Rmarkdown files from subdirectories and places the compilation output in a `docs/` subdirectory.

The `DESCRIPTION` file should contain, in its `Depends:`, all packages that are used within the book chapters.
This is somewhat tedious to extract manually so we provide the `updateDependencies()` function to automate the process.
We recommend setting up a CI/CD job (e.g., via GitHub Actions, see examples [here](https://github.com/OSCA-source/OSCA/blob/master/.github/workflows/rebuild.yaml)) to run this automatically.
This allows users to install the book package and automatically install all of the required dependencies.

The `vignettes/` directory should contain a Makefile that builds the book as part of the package build process.
This Makefile is created by running the `configureBook()` function, amongst other things that we will discuss later.

# 3 Reusing objects between chapters

Sometimes we generate objects in one “donor” chapter that we want to re-use in other “acceptor” chapters.
To do so, we compile potential donor chapters with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* caching turned on and retrieve arbitrary objects from the cache in acceptor chapters.
This avoids the need to (i) re-type the code required to generate the object and (ii) repeat the possibly time-consuming compilation process.

To demonstrate, we will use an example donor chapter included inside the *[rebook](https://bioconductor.org/packages/3.22/rebook)* package itself.
We copy the Rmarkdown file to a temporary location so as avoid modifying the contents of the installation directory.

```
example0 <- system.file("example", "test.Rmd", package="rebook")
example <- tempfile(fileext=".Rmd")
file.copy(example0, example)
```

```
## [1] TRUE
```

To perform this retrieval inside some acceptor chapter (in this case, this vignette), we call the `extractCached()` function.
We supply the path to the donor chapter, the object we want to extract, and the name of the latest chunk in which that object might appear.
The function will then search through the cache to identify the relevant version of the object and pull it out into the current R session.
For example:

```
extractCached(example, chunk="godzilla-1954", object="godzilla")
```

View set-up code (Chapter [**??**](#test-chapter))

```
#--- godzilla-1954 ---#
godzilla <- "RAWR!"
```

```
godzilla
```

```
## [1] "RAWR!"
```

The code leading up to and including the named chunk is also included in a collapsible box,
to unobtrusively provide users with the context in which the object was generated.
Note that proper functioning of the collapsible box depends on `chapterPreamble()` having been called, see below for details.
In a real book, a link is also created to the donor chapter in place of the `??` shown here.

Multiple objects can be retrieved in this manner:

```
extractCached(example, chunk="ghidorah-1964", object=c("godzilla", "ghidorah"))
```

View set-up code (Chapter [**??**](#test-chapter))

```
#--- godzilla-1954 ---#
godzilla <- "RAWR!"

#--- ghidorah-1964 ---#
godzilla <- "GAO GAO"
ghidorah <- "pew pew"
mothra = "Oh, I'm not in this one." # WRONG!
```

```
godzilla
```

```
## [1] "GAO GAO"
```

```
ghidorah
```

```
## [1] "pew pew"
```

Searching is done by chunk so as to disambiguate between objects with the same name across multiple chunks.
This includes objects that are repeatedly modified, allowing us to retrieve the object different states within the donor.
For example, we can pull out the same named variable but from a later chunk (and thus with a different value):

```
extractCached(example, chunk="godzilla-2014", object="godzilla")
```

View set-up code (Chapter [**??**](#test-chapter))

```
#--- godzilla-1954 ---#
godzilla <- "RAWR!"

#--- ghidorah-1964 ---#
godzilla <- "GAO GAO"
ghidorah <- "pew pew"
mothra = "Oh, I'm not in this one." # WRONG!

#--- godzilla-1978 ---#
godzilla <- "rawr rawr"
mechagodzilla <- "beep beep"

#--- godzilla-2014 ---#
godzilla <- "I'm back."
muto <- "Hi."
```

```
godzilla
```

```
## [1] "I'm back."
```

We can also pull out objects that are not actually referenced in the requested chunk,
as long as it was created in one of the preceding chunks:

```
extractCached(example, chunk="godzilla-2014", object=c("mechagodzilla", "godzilla"))
```

View set-up code (Chapter [**??**](#test-chapter))

```
#--- godzilla-1954 ---#
godzilla <- "RAWR!"

#--- ghidorah-1964 ---#
godzilla <- "GAO GAO"
ghidorah <- "pew pew"
mothra = "Oh, I'm not in this one." # WRONG!

#--- godzilla-1978 ---#
godzilla <- "rawr rawr"
mechagodzilla <- "beep beep"

#--- godzilla-2014 ---#
godzilla <- "I'm back."
muto <- "Hi."
```

```
godzilla
```

```
## [1] "I'm back."
```

```
mechagodzilla
```

```
## [1] "beep beep"
```

If the donor chapter has not yet been compiled, `extractCached()` will automatically compile it to create the cache from which to extract content.
This allows us to refer to donor chapters that *follow* the current acceptor chapter;
no extra time is used as the *[bookdown](https://CRAN.R-project.org/package%3Dbookdown)* compilation of the donor can simply use the newly cached content.

Note that this system imposes some restrictions on the formatting of the code chunks in the donor report.
This is mostly caused by the limitations of our custom Rmarkdown parser - see `?extractCached` for more details.

# 4 Linking across books

When writing a large book, we experience a tension between modularization and interconnectivity.
Ideally, we would break up a large book into multiple smaller components, reducing the fragility of the compilation process and simplifying development.
However, this would make it harder to create links between related parts of the book, given that *[bookdown](https://CRAN.R-project.org/package%3Dbookdown)*’s automatic link resolution is limited to references within the same book.
Without links, we lose the synergistic benefits of making a book in the first place.

To get around this, *[rebook](https://bioconductor.org/packages/3.22/rebook)* provides the `link()` function to easily link to references in other Bioconductor books.
If the destination book is installed as a package, we can simply use the following in inline code chunks:

```
link("installation", "OSCA.intro")
```

```
## [1] "[Introduction Chapter 1](http://bioconductor.org/books/3.22/OSCA.intro/installation.html#installation)"
```

```
link("some-comments-on-experimental-design", "OSCA.intro")
```

```
## [1] "[Introduction Section 3.2](http://bioconductor.org/books/3.22/OSCA.intro/getting-scrna-seq-datasets.html#some-comments-on-experimental-design)"
```

```
link("fig:sce-structure", "OSCA.intro")
```

```
## [1] "[Introduction Figure 4.1](http://bioconductor.org/books/3.22/OSCA.intro/the-singlecellexperiment-class.html#fig:sce-structure)"
```

This allows developers to create highly modular books while retaining the convenience of easily linking between books.
Note that, if we `link()` to another book, we should include the relevant book package as a `Suggests:` for our book.

Conversely, calling `configureBook()` will automatically ensure that our current book - once it builds on Bioconductor - can serve as a link destination for other books.
This is done by running through all the book chapters, extracting the references and building an index for re-use in other packages.

# 5 Reusing content across books

In much the same way that `extractCached()` works for sharing objects between chapters of the same book,
`extractFromPackage()` enables use to share objects between chapters of different books.
Namely:

```
extractFromPackage("lun-416b.Rmd", chunk="clustering",
    objects='sce.416b', package="OSCA.workflows")
```

View set-up code ([Workflow Chapter 1](http://bioconductor.org/books/3.22/OSCA.workflows/lun-416b-cell-line-smart-seq2.html#lun-416b-cell-line-smart-seq2))

```
#--- loading ---#
library(scRNAseq)
sce.416b <- LunSpikeInData(which="416b")
sce.416b$block <- factor(sce.416b$block)

#--- gene-annotation ---#
library(AnnotationHub)
ens.mm.v97 <- AnnotationHub()[["AH73905"]]
rowData(sce.416b)$ENSEMBL <- rownames(sce.416b)
rowData(sce.416b)$SYMBOL <- mapIds(ens.mm.v97, keys=rownames(sce.416b),
    keytype="GENEID", column="SYMBOL")
rowData(sce.416b)$SEQNAME <- mapIds(ens.mm.v97, keys=rownames(sce.416b),
    keytype="GENEID", column="SEQNAME")

library(scater)
rownames(sce.416b) <- uniquifyFeatureNames(rowData(sce.416b)$ENSEMBL,
    rowData(sce.416b)$SYMBOL)

#--- quality-control ---#
mito <- which(rowData(sce.416b)$SEQNAME=="MT")
stats <- perCellQCMetrics(sce.416b, subsets=list(Mt=mito))
qc <- quickPerCellQC(stats, percent_subsets=c("subsets_Mt_percent",
    "altexps_ERCC_percent"), batch=sce.416b$block)
sce.416b <- sce.416b[,!qc$discard]

#--- normalization ---#
library(scran)
sce.416b <- computeSumFactors(sce.416b)
sce.416b <- logNormCounts(sce.416b)

#--- variance-modelling ---#
dec.416b <- modelGeneVarWithSpikes(sce.416b, "ERCC", block=sce.416b$block)
chosen.hvgs <- getTopHVGs(dec.416b, prop=0.1)

#--- batch-correction ---#
library(limma)
assay(sce.416b, "corrected") <- removeBatchEffect(logcounts(sce.416b),
    design=model.matrix(~sce.416b$phenotype), batch=sce.416b$block)

#--- dimensionality-reduction ---#
sce.416b <- runPCA(sce.416b, ncomponents=10, subset_row=chosen.hvgs,
    exprs_values="corrected", BSPARAM=BiocSingular::ExactParam())

set.seed(1010)
sce.416b <- runTSNE(sce.416b, dimred="PCA", perplexity=10)

#--- clustering ---#
my.dist <- dist(reducedDim(sce.416b, "PCA"))
my.tree <- hclust(my.dist, method="ward.D2")

library(dynamicTreeCut)
my.clusters <- unname(cutreeDynamic(my.tree, distM=as.matrix(my.dist),
    minClusterSize=10, verbose=0))
colLabels(sce.416b) <- factor(my.clusters)
```

```
sce.416b
```

```
## class: SingleCellExperiment
## dim: 46604 185
## metadata(0):
## assays(3): counts logcounts corrected
## rownames(46604): 4933401J01Rik Gm26206 ... CAAA01147332.1
##   CBFB-MYH11-mcherry
## rowData names(4): Length ENSEMBL SYMBOL SEQNAME
## colnames(185): SLX-9555.N701_S502.C89V9ANXX.s_1.r_1
##   SLX-9555.N701_S503.C89V9ANXX.s_1.r_1 ...
##   SLX-11312.N712_S507.H5H5YBBXX.s_8.r_1
##   SLX-11312.N712_S517.H5H5YBBXX.s_8.r_1
## colData names(10): cell line cell type ... sizeFactor label
## reducedDimNames(2): PCA TSNE
## mainExpName: endogenous
## altExpNames(2): ERCC SIRV
```

This is achieved by exploiting the cache that is created when the donor book undergoes `R CMD build`.
However, if the donor has not yet been compiled, then `extractFromPackage()` will do so to make sure that the cache exists.
This allows for efficient yet robust re-use of objects across multiple books, at least for donor chapters that meet certain requirements.

If we use content from another book, we should include the donor package as a `Suggests:` for our book.
(Sometimes they are placed as `Imports:` to encourage the build system to use the most efficient compilation order.)
If we want our book to serve as a donor, we need to ensure that the book compilation generates the cache in an appropriate location - this is automatically handled by `configureBook()`’s Makefile.

# 6 Pretty printing

As one can see from the examples above,
`extractCached()` will create a collapsible HTML element containing the code used to generate the requested object(s).
This informs reader about the provenance of the object without overwhelming them.
This is also used to achieve pretty `sessionInfo()` printing, as shown below.

```
prettySessionInfo()
```

View session info

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
[1] rebook_1.20.0    BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] Matrix_1.7-4                jsonlite_2.0.0
 [3] compiler_4.5.1              BiocManager_1.30.26
 [5] filelock_1.0.3              SummarizedExperiment_1.40.0
 [7] Biobase_2.70.0              GenomicRanges_1.62.0
 [9] jquerylib_0.1.4             IRanges_2.44.0
[11] Seqinfo_1.0.0               yaml_2.3.10
[13] fastmap_1.2.0               lattice_0.22-7
[15] XVector_0.50.0              R6_2.6.1
[17] S4Arrays_1.10.0             generics_0.1.4
[19] knitr_1.50                  BiocGenerics_0.56.0
[21] graph_1.88.0                XML_3.99-0.19
[23] DelayedArray_0.36.0         bookdown_0.45
[25] MatrixGenerics_1.22.0       bslib_0.9.0
[27] rlang_1.1.6                 cachem_1.1.0
[29] dir.expiry_1.18.0           xfun_0.53
[31] sass_0.4.10                 SparseArray_1.10.0
[33] cli_3.6.5                   grid_4.5.1
[35] digest_0.6.37               rappdirs_0.3.3
[37] lifecycle_1.0.4             S4Vectors_0.48.0
[39] SingleCellExperiment_1.32.0 evaluate_1.0.5
[41] codetools_0.2-20            CodeDepends_0.6.6
[43] abind_1.4-8                 stats4_4.5.1
[45] rmarkdown_2.30              matrixStats_1.5.0
[47] tools_4.5.1                 htmltools_0.5.8.1
```

The collapsible element class is defined using code in `chapterPreamble()`,
which should be called at the top of every chapter with the `results="asis"` chunk option to set up the compilation environment.
We suggest calling `chapterPreamble()` *after* the chapter title is defined with `# Chapter Title`, as *[bookdown](https://CRAN.R-project.org/package%3Dbookdown)* seems to strip out all preceding content.