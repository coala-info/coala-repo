# Overview of BiocPkgTools

Shian Su1, Vince Carey2, Marcel Ramos3, Lori Shepherd4, Martin Morgan4 and Sean Davis5\*

1Walter and Eliza Hall Institute, Melbourne, Australia
2Channing Lab, Brigham and Womens Hospital, Harvard University, Boston, MA USA
3CUNY School of Public Health, New York, NY USA
4Roswell Park Comprehensive Cancer Center, Buffalo, NY USA
5National Cancer Institute, National Institutes of Health, Bethesda, MD USA

\*seandavi@gmail.com

#### 5 February 2026

#### Abstract

Bioconductor has a rich ecosystem of metadata around packages, usage, and build status. This package is a simple collection of functions to access that metadata from R in a tidy data format. The goal is to expose metadata for data mining and value-added functionality such as package searching, text mining, and analytics on packages.

#### Package

BiocPkgTools 1.28.3

# 1 Introduction

Bioconductor has a rich ecosystem of metadata around packages, usage, and build
status. This package is a simple collection of functions to access that metadata
from R in a tidy data format. The goal is to expose metadata for data mining and
value-added functionality such as package searching, text mining, and analytics
on packages.

Functionality includes access to :

* Download statistics
* General package listing
* Build reports
* Package dependency graphs
* Vignettes

# 2 Build reports

The Bioconductor build reports are available online as HTML pages.
However, they are not very computable.
The `biocBuildReport` function does some heroic parsing of the HTML
to produce a *tidy* data.frame for further processing in R.

```
library(BiocPkgTools)
head(biocBuildReport())
```

```
## # A tibble: 6 × 12
##   pkg     author version git_last_commit git_last_commit_date pkgType Deprecated
##   <chr>   <chr>  <chr>   <chr>           <dttm>               <chr>   <lgl>
## 1 ABSSeq  Wenta… 1.64.0  f6fb00c         2025-10-29 10:18:51  bioc    FALSE
## 2 ABSSeq  Wenta… 1.64.0  f6fb00c         2025-10-29 10:18:51  bioc    FALSE
## 3 ABSSeq  Wenta… 1.64.0  f6fb00c         2025-10-29 10:18:51  bioc    FALSE
## 4 ABarray Yongm… 1.78.0  60b191e         2025-10-29 09:58:09  bioc    FALSE
## 5 ABarray Yongm… 1.78.0  60b191e         2025-10-29 09:58:09  bioc    FALSE
## 6 ABarray Yongm… 1.78.0  60b191e         2025-10-29 09:58:09  bioc    FALSE
## # ℹ 5 more variables: PackageStatus <chr>, node <chr>, stage <chr>,
## #   result <chr>, bioc_version <chr>
```

## 2.1 Personal build report

Because developers may be interested in a quick view of their own packages,
there is a simple function, `problemPage`, to produce an HTML report of the
build status of packages matching a given author *regex* supplied to the
`authorPattern` argument. The default is to report only “problem” build statuses
(ERROR, WARNING).

```
problemPage(authorPattern = "V.*Carey")
```

In similar fashion, maintainers of packages that have many downstream packages
that depend on them may wish to check that a change they introduced hasn’t
suddenly broken a large number of these. You can use the `dependsOn` argument
to produce the summary report of those packages that “depend on” the given
package.

```
problemPage(dependsOn = "limma")
```

When run in an interactive environment, the `problemPage` function
will open a browser window for user interaction. Note that if you want
to include all your package results, not just the broken ones, simply
specify `includeOK = TRUE`.

# 3 Download statistics

Bioconductor supplies download stats for all packages. The `biocDownloadStats`
function grabs all available download stats for all packages in all
Experiment Data, Annotation Data, and Software packages. The results
are returned as a tidy data.frame for further analysis.

```
head(biocDownloadStats())
```

```
## # A tibble: 6 × 7
##   pkgType  Package  Year Month Nb_of_distinct_IPs Nb_of_downloads Date
##   <chr>    <chr>   <int> <chr>              <int>           <int> <date>
## 1 software a4       2026 Jan                  196             353 2026-01-01
## 2 software a4       2026 Feb                   37              83 2026-02-01
## 3 software a4       2026 Mar                    0               0 2026-03-01
## 4 software a4       2026 Apr                    0               0 2026-04-01
## 5 software a4       2026 May                    0               0 2026-05-01
## 6 software a4       2026 Jun                    0               0 2026-06-01
```

The download statistics reported are for ***all available versions*** of a
package. There are no separate, publicly available statistics broken down by
version.
The majority of Bioconductor Software packages are also available through other
channels such as Anaconda, who also provided download statistics for packages
installed from their repositories. Access to these counts is provided by the
`anacondaDownloadStats` function:

```
head(anacondaDownloadStats())
```

```
## # A tibble: 6 × 7
##   Package Year  Month Nb_of_distinct_IPs Nb_of_downloads repo     Date
##   <chr>   <chr> <chr>              <int>           <dbl> <chr>    <date>
## 1 ABAData 2018  Apr                   NA               8 Anaconda 2018-04-01
## 2 ABAData 2018  Aug                   NA               5 Anaconda 2018-08-01
## 3 ABAData 2018  Dec                   NA             133 Anaconda 2018-12-01
## 4 ABAData 2018  Jul                   NA               6 Anaconda 2018-07-01
## 5 ABAData 2018  Jun                   NA              18 Anaconda 2018-06-01
## 6 ABAData 2018  Mar                   NA              13 Anaconda 2018-03-01
```

Note that Anaconda do not provide counts for distinct IP addresses, but this
column is included for compatibility with the Bioconductor count tables.

# 4 Package details

The R `DESCRIPTION` file contains a plethora of information regarding package
authors, dependencies, versions, etc. In a repository such as Bioconductor,
these details are available in bulk for all included packages. The `biocPkgList`
returns a data.frame with a row for each package. Tons of information are
available, as evidenced by the column names of the results.

```
bpi = biocPkgList()
colnames(bpi)
```

```
##  [1] "Package"                       "Version"
##  [3] "Depends"                       "Suggests"
##  [5] "License"                       "MD5sum"
##  [7] "NeedsCompilation"              "Title"
##  [9] "Description"                   "biocViews"
## [11] "Author"                        "Maintainer"
## [13] "git_url"                       "git_branch"
## [15] "git_last_commit"               "git_last_commit_date"
## [17] "Date/Publication"              "source.ver"
## [19] "win.binary.ver"                "mac.binary.big-sur-x86_64.ver"
## [21] "mac.binary.big-sur-arm64.ver"  "vignettes"
## [23] "vignetteTitles"                "hasREADME"
## [25] "hasNEWS"                       "hasINSTALL"
## [27] "hasLICENSE"                    "Rfiles"
## [29] "dependencyCount"               "Imports"
## [31] "Enhances"                      "dependsOnMe"
## [33] "suggestsMe"                    "VignetteBuilder"
## [35] "URL"                           "SystemRequirements"
## [37] "BugReports"                    "importsMe"
## [39] "Archs"                         "LinkingTo"
## [41] "Video"                         "linksToMe"
## [43] "OS_type"                       "License_restricts_use"
## [45] "PackageStatus"                 "organism"
## [47] "License_is_FOSS"
```

Some of the variables are parsed to produce `list` columns.

```
head(bpi)
```

```
## # A tibble: 6 × 47
##   Package     Version Depends   Suggests  License MD5sum  NeedsCompilation Title
##   <chr>       <chr>   <list>    <list>    <chr>   <chr>   <chr>            <chr>
## 1 a4          1.58.0  <chr [5]> <chr [7]> GPL-3   56d24e… no               Auto…
## 2 a4Base      1.58.0  <chr [2]> <chr [4]> GPL-3   5efa15… no               Auto…
## 3 a4Classif   1.58.0  <chr [2]> <chr [4]> GPL-3   20d28c… no               Auto…
## 4 a4Core      1.58.0  <chr [1]> <chr [2]> GPL-3   bd94b4… no               Auto…
## 5 a4Preproc   1.58.0  <chr [1]> <chr [4]> GPL-3   2c56d3… no               Auto…
## 6 a4Reporting 1.58.0  <chr [1]> <chr [2]> GPL-3   9d31fe… no               Auto…
## # ℹ 39 more variables: Description <chr>, biocViews <list>, Author <list>,
## #   Maintainer <list>, git_url <chr>, git_branch <chr>, git_last_commit <chr>,
## #   git_last_commit_date <chr>, `Date/Publication` <chr>, source.ver <chr>,
## #   win.binary.ver <chr>, `mac.binary.big-sur-x86_64.ver` <chr>,
## #   `mac.binary.big-sur-arm64.ver` <chr>, vignettes <list>,
## #   vignetteTitles <list>, hasREADME <chr>, hasNEWS <chr>, hasINSTALL <chr>,
## #   hasLICENSE <chr>, Rfiles <list>, dependencyCount <chr>, Imports <list>, …
```

As a simple example of how these columns can be used, extracting
the `importsMe` column to find the packages that import the
*[GEOquery](https://bioconductor.org/packages/3.22/GEOquery)* package.

```
require(dplyr)
bpi = biocPkgList()
bpi |>
    filter(Package=="GEOquery") |>
    pull(importsMe) |>
    unlist()
```

```
##  [1] "bigmelon"                       "ChIPXpress"
##  [3] "DExMA"                          "EGAD"
##  [5] "minfi"                          "Moonlight2R"
##  [7] "MoonlightR"                     "phantasus"
##  [9] "recount"                        "BeadArrayUseCases"
## [11] "BioPlex"                        "GSE13015"
## [13] "healthyControlsPresenceChecker" "geneExpressionFromGEO"
## [15] "RCPA"
```

# 5 Package Explorer

For the end user of Bioconductor, an analysis often starts with finding a
package or set of packages that perform required tasks or are tailored
to a specific operation or data type. The `biocExplore()` function
implements an interactive bubble visualization with filtering based on
biocViews terms. Bubbles are sized based on download statistics. Tooltip
and detail-on-click capabilities are included. To start a local session:

```
biocExplore()
```

# 6 Dependency graphs

The Bioconductor ecosystem is built around the concept of interoperability
and dependencies. These interdependencies are available as part of the
`biocPkgList()` output. The `BiocPkgTools` provides some convenience
functions to convert package dependencies to R graphs. A modular approach leads
to the following workflow.

1. Create a `data.frame` of dependencies using `buildPkgDependencyDataFrame`.
2. Create an `igraph` object from the dependency data frame using
   `buildPkgDependencyIgraph`
3. Use native `igraph` functionality to perform arbitrary network operations.
   Convenience functions, `inducedSubgraphByPkgs` and `subgraphByDegree` are
   available.
4. Visualize with packages such as *[visNetwork](https://CRAN.R-project.org/package%3DvisNetwork)*.

## 6.1 Working with dependency graphs

A dependency graph for all of Bioconductor is a starting place.

```
dep_df = buildPkgDependencyDataFrame()
g = buildPkgDependencyIgraph(dep_df)
g
```

```
## IGRAPH 7769e3c DN-- 3752 30627 --
## + attr: name (v/c), edgetype (e/c)
## + edges from 7769e3c (vertex names):
##  [1] a4       ->a4Base       a4       ->a4Preproc    a4       ->a4Classif
##  [4] a4       ->a4Core       a4       ->a4Reporting  a4Base   ->a4Preproc
##  [7] a4Base   ->a4Core       a4Classif->a4Core       a4Classif->a4Preproc
## [10] ABSSeq   ->methods      acde     ->boot         aCGH     ->cluster
## [13] aCGH     ->survival     aCGH     ->multtest     ACME     ->Biobase
## [16] ACME     ->methods      ACME     ->BiocGenerics ADaCGH2  ->parallel
## [19] ADaCGH2  ->ff           ADAM     ->stats        ADAM     ->utils
## [22] ADAM     ->methods      ADAMgui  ->stats        ADAMgui  ->utils
## + ... omitted several edges
```

```
library(igraph)
head(V(g))
```

```
## + 6/3752 vertices, named, from 7769e3c:
## [1] a4        a4Base    a4Classif ABSSeq    acde      aCGH
```

```
head(E(g))
```

```
## + 6/30627 edges from 7769e3c (vertex names):
## [1] a4    ->a4Base      a4    ->a4Preproc   a4    ->a4Classif
## [4] a4    ->a4Core      a4    ->a4Reporting a4Base->a4Preproc
```

See `inducedSubgraphByPkgs` and `subgraphByDegree` to produce
subgraphs based on a subset of packages.

See the igraph documentation for more detail on graph analytics, setting
vertex and edge attributes, and advanced subsetting.

## 6.2 Graph visualization

The visNetwork package is a nice interactive visualization tool
that implements graph plotting in a browser. It can be integrated
into shiny applications. Interactive graphs can also be included in
Rmarkdown documents (see vignette)

```
igraph_network = buildPkgDependencyIgraph(buildPkgDependencyDataFrame())
```

The full dependency graph is really not that informative to look at, though
doing so is possible. A common use case is to visualize the graph of
dependencies “centered” on a package of interest. In this case, I will
focus on the *[GEOquery](https://bioconductor.org/packages/3.22/GEOquery)* package.

```
igraph_geoquery_network = subgraphByDegree(igraph_network, "GEOquery")
```

The `subgraphByDegree()` function returns all nodes and connections within
`degree` of the named package; the default `degree` is `1`.

The visNework package can plot `igraph` objects directly, but more flexibility
is offered by first converting the graph to visNetwork form.

```
library(visNetwork)
data <- toVisNetworkData(igraph_geoquery_network)
```

The next few code chunks highlight just a few examples of the visNetwork
capabilities, starting with a basic plot.

```
visNetwork(nodes = data$nodes, edges = data$edges, height = "500px")
```

For fun, we can watch the graph stabilize during drawing, best viewed
interactively.

```
visNetwork(nodes = data$nodes, edges = data$edges, height = "500px") |>
    visPhysics(stabilization=FALSE)
```

Add arrows and colors to better capture dependencies.

```
data$edges$color='lightblue'
data$edges[data$edges$edgetype=='Imports','color']= 'red'
data$edges[data$edges$edgetype=='Depends','color']= 'green'

visNetwork(nodes = data$nodes, edges = data$edges, height = "500px") |>
    visEdges(arrows='from')
```

Add a legend.

```
ledges <- data.frame(color = c("green", "lightblue", "red"),
  label = c("Depends", "Suggests", "Imports"), arrows =c("from", "from", "from"))
visNetwork(nodes = data$nodes, edges = data$edges, height = "500px") |>
  visEdges(arrows='from') |>
  visLegend(addEdges=ledges)
```

## 6.3 Integration with *[BiocViews](https://bioconductor.org/packages/3.22/BiocViews)*

[Work in progress]

The *[biocViews](https://bioconductor.org/packages/3.22/biocViews)* package is a small ontology of terms describing
Bioconductor packages. This is a work-in-progress section, but here is a small
example of plotting the biocViews graph.

```
library(biocViews)
data(biocViewsVocab)
biocViewsVocab
```

```
## A graphNEL graph with directed edges
## Number of Nodes = 500
## Number of Edges = 499
```

```
library(igraph)
g = graph_from_graphnel(biocViewsVocab)
library(visNetwork)
gv <- toVisNetworkData(g)
visNetwork(gv$nodes, gv$edges, width="100%") |>
    visIgraphLayout(layout = "layout_as_tree", circular=TRUE) |>
    visNodes(size=20) |>
    visPhysics(stabilization=FALSE)
```

# 7 Dependency burden

The dependency burden of a package, namely the amount of functionality that
a given package is importing, is an important parameter to take into account
during package development. A package may break because one or more of its
dependencies have changed the part of the API our package is importing or
this part has even broken. For this reason, it may be useful for package
developers to quantify the dependency burden of a given package. To do that
we should first gather all dependency information using the function
`buildPkgDependencyDataFrame()` but setting the arguments to work with
packages in Bioconductor and CRAN and dependencies categorised as `Depends`
or `Imports`, which are the ones installed by default for a given package.

```
depdf <- buildPkgDependencyDataFrame(repo=c("BioCsoft", "CRAN"),
                                     dependencies=c("Depends", "Imports"))
dim(depdf)
```

```
## [1] 159513      3
```

```
head(depdf)  # too big to show all
```

```
##   Package  dependency edgetype
## 1      a4      a4Base  Depends
## 2      a4   a4Preproc  Depends
## 3      a4   a4Classif  Depends
## 4      a4      a4Core  Depends
## 5      a4 a4Reporting  Depends
## 6  a4Base   a4Preproc  Depends
```

Finally, we call the function `pkgDepMetrics()` to obtain different metrics
on the dependency burden of a package we want to analyze, in the case below,
the package `BiocPkgTools` itself:

```
pkgDepMetrics("BiocPkgTools", depdf)
```

```
##               ImportedAndUsed Exported Usage DepOverlap DepGainIfExcluded
## stats                       1      454  0.22       0.01                 0
## lubridate                   1      162  0.62       0.03                 2
## graph                       1      116  0.86       0.07                 0
## utils                       2      228  0.88       0.01                 0
## rlang                       4      439  0.91       0.02                 0
## purrr                       2      184  1.09       0.08                 0
## igraph                      9      819  1.10       0.15                 4
## RBGL                        1       77  1.30       0.08                 0
## htmltools                   1       77  1.30       0.07                 0
## tools                       2      135  1.48       0.01                 0
## xml2                        1       67  1.49       0.04                 0
## stringr                     1       63  1.59       0.11                 0
## tibble                      1       45  2.22       0.11                 0
## DT                          1       42  2.38       0.39                 7
## rvest                       1       42  2.38       0.27                 2
## tidyr                       2       70  2.86       0.25                 0
## dplyr                       9      283  3.18       0.19                 0
## curl                        2       44  4.55       0.01                 0
## glue                        1       16  6.25       0.01                 0
## httr2                      10      152  6.58       0.18                 0
## httr                        6       91  6.59       0.09                 0
## htmlwidgets                 1       14  7.14       0.31                 0
## gh                          1       12  8.33       0.22                 3
## jsonlite                    2       23  8.70       0.01                 0
## BiocFileCache               4       29 13.79       0.42                 6
## yaml                        1        6 16.67       0.01                 0
## BiocManager                 3        6 50.00       0.02                 0
## biocViews                  NA       35    NA       0.16                 6
## readr                      NA      115    NA       0.26                 6
```

In this resulting table, rows correspond to dependencies and columns provide
the following information:

* `ImportedAndUsed`: number of functionality calls imported and used in
  the package.
* `Exported`: number of functionality calls exported by the dependency.
* `Usage`: (`ImportedAndUsed`x 100) / `Exported`. This value provides an
  estimate of what fraction of the functionality of the dependency is
  actually used in the given package.
* `DepOverlap`: Similarity between the dependency graph structure of the
  given package and the one of the dependency in the corresponding row,
  estimated as the
  [Jaccard index](https://en.wikipedia.org/wiki/Jaccard_index)
  between the two sets of vertices of the corresponding graphs. Its values
  goes between 0 and 1, where 0 indicates that no dependency is shared, while
  1 indicates that the given package and the corresponding dependency depend
  on an identical subset of packages.
* `DepGainIfExcluded`: The ‘dependency gain’ (decrease in the total number
  of dependencies) that would be obtained if this package was excluded
  from the list of direct dependencies.

The reported information is ordered by the `Usage` column to facilitate the
identification of dependencies for which the analyzed package is using a small
fraction of their functionality and therefore, it could be easier remove them.
To aid in that decision, the column `DepOverlap` reports the overlap of the
dependency graph of each dependency with the one of the analyzed package. Here
a value above, e.g., 0.5, could, albeit not necessarily, imply that removing
that dependency could substantially lighten the dependency burden of the
analyzed package.

An `NA` value in the `ImportedAndUsed` column indicates that the function
`pkgDepMetrics()` could not identify what functionality calls in the analyzed
package are made to the dependency. This may happen because `pkgDepMetrics()`
has failed to identify the corresponding calls, as it happens with imported
built-in constants such as `DNA_BASES` from `Biostrings`, or that although the
given package is importing that dependency, none of its functionality is
actually being used. In such a case, this dependency could be safely removed
without any further change in the analyzed package.

We can find out what actually functionality calls are we importing as follows:

```
imp <- pkgDepImports("BiocPkgTools")
imp |> filter(pkg == "DT")
```

```
## # A tibble: 1 × 2
##   pkg   fun
##   <chr> <chr>
## 1 DT    datatable
```

# 8 Identities of maintainers

It is important to be able to identify the maintainer of a package in
a reliable way. The DESCRIPTION file for a package can include an `Authors@R`
field. This field can capture metadata about maintainers and contributors
in a programmatically accessible way. Each element of the role
field of a `person` (see `?person`) in the `Authors@R` field comes
from a subset of the
[relations vocabulary of the Library of Congress](https://www.loc.gov/marc/relators/relaterm.html).

Metadata about maintainers can be extracted from DESCRIPTION in various ways.
As of October 2022, we focus on the use of the ORCID field which is
an optional `comment` component in a `person` element. For example,
in the DESCRIPTION for the AnVIL package we have

```
Authors@R:
    c(person(
        "Martin", "Morgan", role = c("aut", "cre"),
        email = "mtmorgan.bioc@gmail.com",
        comment = c(ORCID = "0000-0002-5874-8148")
     ),
```

This convention is used for a fair number of Bioconductor and CRAN packages.

We’ll demonstrate the use of `get_cre_orcids` with some packages.

```
inst = rownames(installed.packages())
cands = c("devtools", "evaluate", "ggplot2", "GEOquery", "gert", "utils")
totry = intersect(cands, inst)
oids = get_cre_orcids(totry)
oids
```

```
##              devtools              evaluate               ggplot2
## "0000-0002-6983-2759"                    NA "0000-0002-5147-4711"
##              GEOquery                  gert                 utils
## "0000-0002-8991-6458" "0000-0002-4035-0289"                    NA
```

We use the ORCID API to tabulate metadata about the holders of these IDs.
We’ll avoid evaluating this because a token must be refreshed for the query
to succeed.

```
orcid_table(oids)
```

In October 2022 the result is

```
> orcid_table(.Last.value)
                        name                                            org
devtools      Jennifer Bryan                                        RStudio
evaluate           Yihui Xie                                  RStudio, Inc.
ggplot2  Thomas Lin Pedersen                                        RStudio
GEOquery          Sean Davis University of Colorado Anschutz Medical Campus
gert             Jeroen Ooms            Berkeley Institute for Data Science
utils                   <NA>                                           <NA>
               city   region country               orcid
devtools     Boston       MA      US 0000-0002-6983-2759
evaluate    Elkhorn       NE      US 0000-0003-0645-5666
ggplot2  Copenhagen     <NA>      DK 0000-0002-5147-4711
GEOquery     Aurora Colorado      US 0000-0002-8991-6458
gert       Berkeley       CA      US 0000-0002-4035-0289
utils          <NA>     <NA>    <NA>                <NA>
```

# 9 Provenance

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] biocViews_1.78.0    visNetwork_2.1.4    igraph_2.2.1
## [4] dplyr_1.2.0         BiocPkgTools_1.28.3 htmlwidgets_1.6.4
## [7] knitr_1.51          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] xfun_0.56           bslib_0.10.0        httr2_1.2.2
##  [4] websocket_1.4.4     processx_3.8.6      gh_1.5.0
##  [7] Biobase_2.70.0      tzdb_0.5.0          ps_1.9.1
## [10] vctrs_0.7.1         tools_4.5.2         bitops_1.0-9
## [13] generics_0.1.4      stats4_4.5.2        curl_7.0.0
## [16] RUnit_0.4.33.1      tibble_3.3.1        RSQLite_2.4.5
## [19] blob_1.3.0          pkgconfig_2.0.3     dbplyr_2.5.1
## [22] graph_1.88.1        lifecycle_1.0.5     stringr_1.6.0
## [25] compiler_4.5.2      chromote_0.5.1      htmltools_0.5.9
## [28] sass_0.4.10         RCurl_1.98-1.17     yaml_2.3.12
## [31] tidyr_1.3.2         pillar_1.11.1       later_1.4.5
## [34] jquerylib_0.1.4     DT_0.34.0           cachem_1.1.0
## [37] tidyselect_1.2.1    rvest_1.0.5         digest_0.6.39
## [40] stringi_1.8.7       purrr_1.2.1         bookdown_0.46
## [43] fastmap_1.2.0       cli_3.6.5           magrittr_2.0.4
## [46] utf8_1.2.6          RBGL_1.86.0         XML_3.99-0.20
## [49] withr_3.0.2         readr_2.1.6         promises_1.5.0
## [52] filelock_1.0.3      rappdirs_0.3.4      bit64_4.6.0-1
## [55] lubridate_1.9.5     timechange_0.4.0    rmarkdown_2.30
## [58] httr_1.4.7          bit_4.6.0           otel_0.2.0
## [61] hms_1.1.4           memoise_2.0.1       evaluate_1.0.5
## [64] BiocFileCache_3.0.0 rlang_1.1.7         Rcpp_1.1.1
## [67] glue_1.8.0          DBI_1.2.3           BiocManager_1.30.27
## [70] xml2_1.5.2          BiocGenerics_0.56.0 jsonlite_2.0.0
## [73] R6_2.6.1
```