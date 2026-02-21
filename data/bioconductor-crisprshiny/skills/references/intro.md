# Introduction to crisprShiny

Luke Hoberecht1\* and Jean-Philippe Fortin1\*\*

1Department of Data Science and Statistical Computing, gRED, Genentech

\*hoberecl@gene.com
\*\*fortinj2@gene.com

#### 29 October 2025

#### Package

crisprShiny 1.6.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Creating self-contained Shiny applications](#creating-self-contained-shiny-applications)
  + [3.1 Basic GuideSet (no additional annotations)](#basic-guideset-no-additional-annotations)
  + [3.2 Fully-annotated GuideSet](#fully-annotated-guideset)
    - [3.2.1 On-targets table](#on-targets-table)
    - [3.2.2 gRNA filters](#grna-filters)
    - [3.2.3 Visualizing on-targets](#visualizing-on-targets)
    - [3.2.4 gRNA-specific anntations/list columns](#grna-specific-anntationslist-columns)
* [4 Customized apps using Shiny modules](#customized-apps-using-shiny-modules)
* [5 Session Info](#session-info)

# 1 Introduction

The `crisprShiny` package allows users to interact with and visualize
CRISPR guide RNAs (gRNAs) stored in `GuideSet` objects via Shiny applications.
This is possible either directly with a self-contained app, or as a module
within a larger app. This vignette will demonstrate how to use this package to
build Shiny applications for `GuideSet` objects, and how to navigate gRNA
annotation within the app.

Shiny apps created using the `crisprShiny` package require `GuideSet` objects
be constructed and annotated using the `crisprDesign` package, however, custom
`mcols` may be added to the `GuideSet`, as shown below. For more information
about how to store and annotate CRISPR gRNAs with `GuideSet` objects, see our
[crisprVerse tutorials page](https://github.com/crisprVerse/Tutorials).

# 2 Installation

`crisprShiny` can be installed from from the Bioconductor devel branch
using the following commands in a fresh R session:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("crisprShiny", version="devel")
```

# 3 Creating self-contained Shiny applications

## 3.1 Basic GuideSet (no additional annotations)

The `GuideSet` object can include a great variety of gRNA annotation (see
`crisprDesign` package) that can be neatly displayed in a Shiny app by simply
passing it to the `crisprShiny` function. This function dynamically renders
components to display annotations that are present in the `GuideSet`. To
demonstrate, let’s first use it with a precomputed, non-annotated `GuideSet`
of gRNAs targeting the CDS of the human KRAS gene, which is stored in the
`crisprShiny` package. Note that the `crisprShiny` function returns an app
object, which can then be run using `shiny::runApp`.

```
if (interactive()){
    library(crisprShiny)
    data("guideSetExample_basic", package="crisprShiny")
    app <- crisprShiny(guideSetExample_basic)
    shiny::runApp(app)
}
```

![](figures/app_simple_1.png)

Passing this `GuideSet` returns a simple data table and a button to set
filtering criteria. The columns in the **Table of On-targets** reflect the
mcols present in the `GuideSet` (with an exception for certain list-column
annotations, such as `alignments`, shown below). We can add columns to the
`mcols` of the `GuideSet`, which then appear in the data table. (Note: adding
columns that share names with annotations added by functions in the
`crisprDesign` package can result in unexpected behaviors, and is therefore
not advised.)

```
if (interactive()){
    gs <- guideSetExample_basic[1:50]

    ## add custom data columns
    library <- c("lib1", "lib2", "lib3", "lib4")
    set.seed(1000)
    values <- round(rnorm(length(gs)), 4)
    mcols(gs)[["values"]] <- values
    library <- sample(library, length(gs), replace=TRUE)
    mcols(gs)[["library"]] <- library

    ## create and run app
    app <- crisprShiny(gs, geneModel=txdb_kras)
    shiny::runApp(app)
}
```

## 3.2 Fully-annotated GuideSet

For a more interesting app, we can pass a `GuideSet` containing gRNA
annotations to the `crisprShiny` function. This will include additional
components for each in-depth gRNA-level annotation, such as alignments, and
gene annotation. For our example we will use a fully-annotated version of the
`GuideSet` used above.

```
if (interactive()){
    data("guideSetExample_kras", package="crisprShiny")
    app <- crisprShiny(guideSetExample_kras)
    shiny::runApp(app)
}
```

Passing a fully-annotated `GuideSet` to the `crisprShiny` function creates what
can be thought of as a “fully-functional” app, in that all annotation features
are presented in the app. Each are described in the following sections.

### 3.2.1 On-targets table

All `mcols` in the `GuideSet` that are not list-columns (`alignments`, etc.)
are shown in this table, with `ID`, (names of the `GuideSet`) given in the
first column. Some columns added by `crisprDesign` functions (see
`crisprDesign` package) have special formatting:

* **scores** (columns prefixed by `score_` and supported by the `crisprScore`
  package) have blue bars that allow for quick comparison across gRNAs.
* **alignment summary** (`n0`, `n1_c`, etc.) are blank for values of `0`, and
  grayed out for `NA` values (see `?crisprDesign::addSpacerAlignments`).
* many flag columns (having `TRUE` or `FALSE` values, such as `inRepeats` and
  `polyT`) are highlighted when the flag is present and blank otherwise, to
  quickly identify potentially problematic gRNA features.

![](figures/full_app_on_targets_table.png)

There are several ways to interact with these data in the table:

* the data can be sorted on most columns by clicking on the column header.
* above the table is a button that displays filtering options (see [gRNA
  filters](#grna-filters)) and a dropdown menu controlling the number of gRNAs to display per
  datatable page.
* below the table are options to download the on-targets table (only visible
  columns), and to control which columns are visible.
* each row, which corresponds to unique gRNAs, can be selected and is used as
  input for the visualization component (see [Visualizing on-targets](#visualizing-on-targets)).

### 3.2.2 gRNA filters

Clicking on the **Filter on-targets** button opens the
menu to filter gRNAs in the on-targets table. Filters options depend on which
annotations are present in the `GuideSet` object (see `crisprDesign` package
for information on annotations), and are divided into separate gRNA-feature
categories, as described in the following sections. The default filter values
can be controlled with the `useFilterPresets` argument of the `crisprShiny`
function (see `?crisprShiny` for details).

#### Nucleotide content

This covers nucleotide-specific features, including

* whether gRNAs contain polyT sequences (four or more consecutive T bases)
* percent GC content of the gRNA sequence
* whether the protospacer is adjacent to a canonical PAM in the target DNA

#### Off-target count

These filters set the upper limits for number of on- and off-targets in the
host genome. Limits can be set for each off-target by mismatch count and
whether the off-target occurs in a gene CDS or promoter region. The `GuideSet`
must have alignment annotation for this section to be available.

#### Scores

This section sets the lower limits for on- and off-target scores, as well as
options for permitting `NA` scores (such as with non-targeting control
sequences). See the `crisprScores` package for available scoring methods.

#### Genomic Features

This section concerns the genomic context of protospacers: whether they overlap
repeat elements, SNPs, or Pfam domains.

#### Isoform-specific parameters

This section allows for narrowing gRNAs to those targeting specific isoforms,
a defined region within that isoform, and a minimum percent of isoform coverage
for the target gene.

#### Promoter targeting parameters

This section filters for gRNAs that target, and are within a certain distance
from, a specific TSS.

### 3.2.3 Visualizing on-targets

As stated in component, the user may select up to 20 gRNAs from same chromosome
in the table of on-targets to plot using the `crisprViz` package. In this
example, no value was passed to the `geneModel` argument, so no gene
information is available for the plot. If we rerun the function with a
`GRangesList` (see `crisprDesign` package), such as `txdb_kras`, the gene
transcripts are also plotted. There are additional options to set the viewing
range and how the gRNA track is organized.

![](figures/guide_browser.png)

Regardless of what value is passed to `geneModel`, this component is only
available if the `GuideSet` is annotated with `gene_symbol` and/or `gene_id`
column(s) in `mcols`.

### 3.2.4 gRNA-specific anntations/list columns

Additonal interactive components for detailed annotations present in the
`GuideSet` can be found at the bottom of the app. Annotations are presented one
gRNA at a time, selected using the dropdown menu, and are described below.

#### On- and Off-targets

![](figures/alignments.png)

This tab presents information about each on- and off-target. The putative
protospacers can be filtered by maximum number of mismatches, target genomic
context, and whether they are adjacent to canonical PAMs, as well as sorted by
CFD or MIT score (SpCas9 only).

Just below the filters is a quick summary of the on- and off-target count for
the gRNA, and details about each putative protospacer in a datatable, such as
where mismatches occur, off-target scores, and its genomic location with
gene-level context. Rows in the datatable can be selected to visualize the
protospacer target with respect to the target or nearby gene (up to 10kb).

#### Gene Annotation

Currently, this tab displays a datatable of gene annotation for the selected
gRNA, identical to the output of `crisprShiny::geneAnnotation(guideSet)`.

#### TSS Annotation

Currently, this tab displays a datatable of TSS annotation for the selected
gRNA, identical to the output of `crisprShiny::tssAnnotation(guideSet)`.

#### Restriction Enzyme

This tab includes a datatable of restriction enzymes whose motifs are found in
the gRNA. Restriction enzymes in the table and gRNA flanking sequences used to
determine presence of motifs depend on arguments passed to
`crisprDesign::addRestrictionEnzymes` in constructing the input `GuideSet`.

#### SNPs

Currently, this tab displays a datatable of SNPs annotation for the selected
gRNA, identical to the output of `crisprShiny::snps(guideSet)`.

# 4 Customized apps using Shiny modules

The UI and server components of `crisprShiny` are also available outside of
the `crisprShiny` function to be used as modules within a larger app that, for
instance, may allow the user to parse multiple `GuideSet` objects in a single
session. Below is a simple example that allows the user to explore both the
basic and fully-annotated `GuideSet`s used above in the same session.

```
if (interactive()){
    library(shiny)

    ui <- function(id){
        fluidPage(
            sidebarLayout(
                sidebarPanel(
                    selectInput(
                        inputId="guideSet_select",
                        label="Select GuideSet",
                        choices=c("simple", "full")
                    )
                ),
                mainPanel(
                    crisprUI(id)
                )
            )
        )
    }

    server <- function(id){
        function(input, output, session){
            guideSet_list <- list("simple"=guideSetExample_basic,
                                  "full"=guideSetExample_kras[1:50])
            gs <- reactive({
                req(input$guideSet_select)
                guideSet_list[[input$guideSet_select]]
            })
            observeEvent(gs(), {
                crisprServer(
                    id,
                    guideSet=gs(),
                    geneModel=txdb_kras,
                    useFilterPresets=TRUE
                )
            })
        }
    }

    myApp <- function(){
        id <- "id"
        shinyApp(ui=ui(id), server=server(id))
    }

    myApp()
}
```

# 5 Session Info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           otel_0.2.0          promises_1.4.0
##  [7] shiny_1.11.1        xtable_1.8-4        jsonlite_2.0.0
## [10] htmltools_0.5.8.1   httpuv_1.6.16       sass_0.4.10
## [13] rmarkdown_2.30      evaluate_1.0.5      jquerylib_0.1.4
## [16] fontawesome_0.5.3   fastmap_1.2.0       yaml_2.3.10
## [19] lifecycle_1.0.4     bookdown_0.45       BiocManager_1.30.26
## [22] compiler_4.5.1      Rcpp_1.1.0          later_1.4.4
## [25] digest_0.6.37       R6_2.6.1            magrittr_2.0.4
## [28] bslib_0.9.0         tools_4.5.1         mime_0.13
## [31] cachem_1.1.0
```