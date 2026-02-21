# Creating PanViz visualizations with PanVizGenerator

Thomas Lin Pedersen

#### *30 October 2018*

#### Abstract

PanViz is a new JavaScript based visualization tool for functionaly annotated pangenomes. PanVizGenerator is a companion package that facilitates the creation of PanViz visualizations, by taking care of all the dull data formatting and conversion work. It provides both standard R methods as well as a shiny web app to help you convert your data into PanViz.

#### Package

PanVizGenerator 1.10.0

# 1 Introduction

Pangenomes are data structures used in comparative microbial genomics. In
essence it is a grouping of genes across different genomes where each group
should consist of orthologue genes (i.e. sequence similarity is in itself not
enough). One of the standard representation of pangenomes is as a pangenome
matrix, which is a presence/absence matrix with rows defining gene groups and
columns defining genomes. This seemingly simple representation hides the fact
that investigating pangenomes and try to understand the biological implications
of the grouping can be a daunting task.
[PanViz](https://github.com/thomasp85/PanViz) is an interactive visualization
tool, build using html and Javascript (relying heavily on
[D3.js](http://d3js.org)), that empowers the user to investigate, query and
understand their pangenomes in a fluid, beautiful and easy manner.
PanViz visualizations are fully self-contained html files that can be shared
with coworkers and viewed offline if needed. PanVizGenerator is the intended
tool for creating PanViz visualizations from scratch using your own data. It
provides both an easy and informative GUI (based on *[shiny](https://CRAN.R-project.org/package%3Dshiny)*), as
well as a standard R interface. The GUI supports csv formatted pangenome
matrices, while the programmatic interface in addition supports standard R
matrix and data.frame representation as well as the class system provided by
*[FindMyFriends](https://bioconductor.org/packages/3.8/FindMyFriends)*.

# 2 Data requirements

PanViz relies on two different types of data for its visualization approach. The
first is the pangenome matrix as described in the [introduction](#intro) while
the second is a functional annotation of the gene groups in the pangenome based
on [gene ontology](http://geneontology.org) terms. In addition human readable
gene group names as well as E.C. numbers will augment the quality of the end
result.

How this data is supplied depends on the user. The standard Bioconductor
approach to creating and working with pangenomes is the class system defined by
*[FindMyFriends](https://bioconductor.org/packages/3.8/FindMyFriends)*. FindMyFriends provides functionality for adding
annotation to both the gene groups and genomes contained in a pangenome and if
these facilities are used a PanViz can be created directly from that. If you
wish to opt out of the FindMyFriends approach, or if the pangenome has been
provided for you, PanVizGenerator can also accept standard matrix data, along
with vector or list style annotation.

There is a third data source that is independent of the individual data sets but
required by PanViz none-the-less: The full gene ontology graph is embedded
within each PanViz file, allowing for visual navigation of the GO ontology as it
applies to your data. PanVizGenerator automatically fetches the gene ontology
when required and caches it for later use, so this is not something you, as a
user, should worry about. In order to force a fresh download of the gene
ontology for some reason, the `getGO()` function is provided.

```
library(PanVizGenerator)
getGO()
```

# 3 Creating PanViz visualizations

PanVizGenerator both supports a shiny-based GUI as well as the standard R based
approach. The GUI does not offer the same flexibility but is intended for people
less experience using R. Apart from the PanViz creation functionality it also
contains an example video of a pangenome as well as a rundown of the features
and thoughts in PanViz.

## 3.1 Using the shiny GUI

The GUI is started by using the eponymous `PanVizGenerator()` function, which
opens the GUI in the default browser:

```
PanVizGenerator()
```

Running the above will present you with a view much like what is shown in the
figure below.

![The main view of PanVizGenerators shiny app. Scrolling down will present the user with addition information regarding the functionality of PanViz.](data:image/png;base64...)

The main view of PanVizGenerators shiny app. Scrolling down will present the user with addition information regarding the functionality of PanViz.

The GUI is quite self-explanatory as it present limited functinality. The user
can select a csv file containing their pangenome data, make some standard
choices regarding the algorithms used for some of the data transformations, and
then press the generate button. Once the data processing step has run its course
a download button will appear for the user to click.

If the user is unsure about the formatting of the csv file an example file is
available for download as reference. Apart from this the GUI is also a
presentation of PanViz’ functionality, so even trained R users can benefit from
opening the GUI at least once and read through it.

## 3.2 Using the R interface

The most flexible approach to generating PanViz visualizations is to use the
`panviz` method. In order to mimick the functionality of the GUI pass in a
string with the location of a csv file.

```
csvFile <- system.file('extdata', 'exampleData.csv',
                       package = 'PanVizGenerator')
outputDir <- tempdir()

# Generate the visualization
panviz(csvFile, location = outputDir)
```

A more flexible approach is to have your pangenome data in R and pass it in
directly:

```
# Get data from csv
pangenome <- read.csv(csvFile, quote='', stringsAsFactors = FALSE)
name <- pangenome$name
go <- pangenome$go
ec <- pangenome$ec
pangenome <- pangenome[, !names(pangenome) %in% c('name', 'go', 'ec')]

# Annotation can come in many ways
# This is valid
head(go)
```

```
## [1] "GO:0017111; GO:0005524; GO:0006508; GO:0008233"
## [2] "GO:0006313; GO:0004803; GO:0003677; GO:0015074"
## [3] "GO:0006313; GO:0004803; GO:0003677"
## [4] "GO:0005215; GO:0006810"
## [5] "GO:0006261; GO:0003677; GO:0005524; GO:0003918; GO:0005694; GO:0006265; GO:0005737"
## [6] "GO:0006261; GO:0003677; GO:0005524; GO:0003918; GO:0000287; GO:0005694; GO:0006265; GO:0005737"
```

```
# And this is valid too
head(strsplit(go, '; '))
```

```
## [[1]]
## [1] "GO:0017111" "GO:0005524" "GO:0006508" "GO:0008233"
##
## [[2]]
## [1] "GO:0006313" "GO:0004803" "GO:0003677" "GO:0015074"
##
## [[3]]
## [1] "GO:0006313" "GO:0004803" "GO:0003677"
##
## [[4]]
## [1] "GO:0005215" "GO:0006810"
##
## [[5]]
## [1] "GO:0006261" "GO:0003677" "GO:0005524" "GO:0003918" "GO:0005694"
## [6] "GO:0006265" "GO:0005737"
##
## [[6]]
## [1] "GO:0006261" "GO:0003677" "GO:0005524" "GO:0003918" "GO:0000287"
## [6] "GO:0005694" "GO:0006265" "GO:0005737"
```

```
# Or another delimiter
head(gsub('; ', 'delimiter', go))
```

```
## [1] "GO:0017111delimiterGO:0005524delimiterGO:0006508delimiterGO:0008233"
## [2] "GO:0006313delimiterGO:0004803delimiterGO:0003677delimiterGO:0015074"
## [3] "GO:0006313delimiterGO:0004803delimiterGO:0003677"
## [4] "GO:0005215delimiterGO:0006810"
## [5] "GO:0006261delimiterGO:0003677delimiterGO:0005524delimiterGO:0003918delimiterGO:0005694delimiterGO:0006265delimiterGO:0005737"
## [6] "GO:0006261delimiterGO:0003677delimiterGO:0005524delimiterGO:0003918delimiterGO:0000287delimiterGO:0005694delimiterGO:0006265delimiterGO:0005737"
```

```
# Generate the visualization
panviz(pangenome, name=name, go=go, ec=ec, location=outputDir)
```

If you’re already working with your data in FindMyFriends it is even easier.
Just make sure that you use the correct columns in groupInfo to store the
annotation and PanVizGenerator takes care of the rest:

```
# Get an example pangenome with annotation
library(FindMyFriends)
pangenome <- .loadPgExample(withNeighborhoodSplit = TRUE)
annotation <- readAnnot(system.file('extdata',
                                    'examplePG',
                                    'example.annot',
                                    package = 'FindMyFriends'))
head(annotation)
```

```
##     name                             description
## 1    OG1                      ismhp1 transposase
## 2  OG100                         abc transporter
## 3 OG1000          2-oxoisovalerate dehydrogenase
## 4 OG1001 pyruvate dehydrogenase e1-alpha subunit
## 5 OG1002                     amino acid permease
## 6 OG1008              excinuclease abc subunit a
##                                                                                                                                   GO
## 1                                                                                                 GO:0003677, GO:0004803, GO:0006313
## 2                                                                                     GO:0005886, GO:0016021, GO:0005215, GO:0006810
## 3                                     GO:0004739, GO:0055114, GO:0006094, GO:0006096, GO:0009097, GO:0009098, GO:0009099, GO:0045254
## 4                                     GO:0004739, GO:0055114, GO:0006094, GO:0006096, GO:0009097, GO:0009098, GO:0009099, GO:0045254
## 5                                                                                                 GO:0016021, GO:0015171, GO:0003333
## 6 GO:0005737, GO:0009380, GO:0003677, GO:0005524, GO:0008270, GO:0009381, GO:0016887, GO:0006289, GO:0009432, GO:0090305, GO:0006308
##                                          EC
## 1
## 2
## 3                                EC:1.2.4.1
## 4                                EC:1.2.4.1
## 5
## 6 EC:3.6.1, EC:3.6.1.3, EC:3.1, EC:3.6.1.15
```

```
pangenome <- addGroupInfo(pangenome, annotation, key = 'name')
pangenome
```

```
## An object of class pgFullLoc
##
## The pangenome consists of 6802 genes from 5 organisms
## 3183 gene groups defined
##
##      Core|
## Accessory|========================================:
## Singleton|=========:
##
## Genes are translated
```

```
# Generate the visualization
panviz(pangenome, location = outputDir)
```

## 3.3 Some other bells and whistles

The above show just the standard behavior which should match the need for most
users. It is possible though to tailor the functionality a bit using some
addition parameters:

### 3.3.1 Don’t merge everything into one file

```
panviz(pangenome, location = outputDir, consolidate = FALSE)
```

This tells PanVizGenerator to not merge data and JavaScript code into the
PanViz.html file but instead keep it as separate files. This might be of
interest for debugging or just poking around in the inards of PanViz. For
regular use it is nice to have a single self-contained file though.

### 3.3.2 Open the result in a browser

```
panviz(pangenome, location = outputDir, showcase = TRUE)
```

If you wish to inspect the result right away, you can ask PanVizGenerator to
open the html file in your default browser using `browseURL()`. Setting
`location = tempdir()` and `showcase = TRUE` let you experiment with different
settings without getting a lot of PanViz.html files lying around (kind of like
using standard R plotting).

### 3.3.3 Modify data transformation

```
panviz(pangenome, location = outputDir, dist = 'binary', clust = 'complete',
       center = FALSE, scale = FALSE)
```

To modify the look of the scatterplot and dendrogram used for navigating the
genomes in the pangenome you can change the distance measure, clustering
algorithm and whether data should be centered and scaled, using the parameters
shown above. In general the defaults are set to produce a nice plot, but needs
may vary.

# 4 Example video

Being an interactive web-based visualization, the result of all of the above can
be difficult to showcase. Because of this a small video has been prepared -
depending on where you read this vignette it might not show up though.

In case nothing shows, see the video at its [Vimeo](https://vimeo.com/113594599)
page

# 5 Session info

```
## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] bindrcpp_0.2.2         FindMyFriends_1.12.0   PanVizGenerator_1.10.0
## [4] BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.19        lattice_0.20-35     class_7.3-14
##  [4] Biostrings_2.50.0   assertthat_0.2.0    rprojroot_1.3-2
##  [7] digest_0.6.18       mime_0.6            R6_2.3.0
## [10] plyr_1.8.4          backports_1.1.2     stats4_3.5.1
## [13] evaluate_0.12       e1071_1.7-0         ggplot2_3.1.0
## [16] pillar_1.3.0        zlibbioc_1.28.0     rlang_0.3.0.1
## [19] lazyeval_0.2.1      kernlab_0.9-27      S4Vectors_0.20.0
## [22] Matrix_1.2-14       rmarkdown_1.10      apcluster_1.4.7
## [25] BiocParallel_1.16.0 stringr_1.3.1       igraph_1.2.2
## [28] munsell_0.5.0       shiny_1.1.0         compiler_3.5.1
## [31] httpuv_1.4.5        xfun_0.4            pkgconfig_2.0.2
## [34] BiocGenerics_0.28.0 kebabs_1.16.0       pcaMethods_1.74.0
## [37] htmltools_0.3.6     tidyselect_0.2.5    tibble_1.4.2
## [40] bookdown_0.7        IRanges_2.16.0      crayon_1.3.4
## [43] dplyr_0.7.7         later_0.7.5         MASS_7.3-51
## [46] grid_3.5.1          xtable_1.8-3        jsonlite_1.5
## [49] gtable_0.2.0        magrittr_1.5        scales_1.0.0
## [52] stringi_1.2.4       XVector_0.22.0      reshape2_1.4.3
## [55] promises_1.0.1      ggdendro_0.1-20     tools_3.5.1
## [58] Biobase_2.42.0      glue_1.3.0          LiblineaR_2.10-8
## [61] purrr_0.2.5         parallel_3.5.1      yaml_2.2.0
## [64] colorspace_1.3-2    BiocManager_1.30.3  filehash_2.4-1
## [67] knitr_1.20          bindr_0.1.1
```