# Linking information between FHIR resources

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 29, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Examining sample data, again](#examining-sample-data-again)
* [3 A graph relating patients to conditions](#a-graph-relating-patients-to-conditions)
* [4 Adding procedures to the graph](#adding-procedures-to-the-graph)
* [5 Interactive visualization of the graph](#interactive-visualization-of-the-graph)
* [6 Conclusions](#conclusions)
* [7 Session information](#session-information)

# 1 Introduction

The purpose of this vignette is to provide
details on how FHIR documents are
transformed to graphs in BiocFHIR.

This text uses R commands that will work for an R (version 4.2 or greater) in which
BiocFHIR (version 0.0.14 or greater) has been installed. The source codes are
always available at [github](https://github.com/vjcitn/BiocFHIR) and may
be available for installation by other means.

# 2 Examining sample data, again

In the “Upper level FHIR concepts” vignette, we used the
following code to get a peek at the information
structure in a single document representing a Bundle
associated with a patient.

```
tfile = dir(system.file("json", package="BiocFHIR"), full=TRUE)
peek = jsonlite::fromJSON(tfile)
names(peek)
```

```
## [1] "resourceType" "type"         "entry"
```

```
peek$resourceType
```

```
## [1] "Bundle"
```

```
names(peek$entry)
```

```
## [1] "fullUrl"  "resource" "request"
```

```
length(names(peek$entry$resource))
```

```
## [1] 72
```

```
class(peek$entry$resource)
```

```
## [1] "data.frame"
```

```
dim(peek$entry$resource)
```

```
## [1] 301  72
```

```
head(names(peek$entry$resource))
```

```
## [1] "resourceType" "id"           "text"         "extension"    "identifier"
## [6] "name"
```

We perform a first stage of transformation with `process_fhir_bundle`:

```
bu = process_fhir_bundle(tfile)
bu
```

```
## BiocFHIR FHIR.bundle instance.
##   resource types are:
##    AllergyIntolerance CarePlan ... Patient Procedure
```

# 3 A graph relating patients to conditions

```
data(allin)
g = make_condition_graph(allin)
g
```

```
## BiocFHIR.FHIRgraph instance.
## A graphNEL graph with directed edges
## Number of Nodes = 120
## Number of Edges = 348
##  50 patients, 70 conditions
```

```
names(g)
```

```
## [1] "graph"      "patients"   "conditions"
```

We made a new S3 class to hold the graph with some convenient metadata.
Ultimately that metadata should be bound into the graph itself as nodeData
and edgeData components.

Because basic identifying information is decomposed into components
in FHIR, we have a utility to acquire the patient name for a given bundle.

```
getHumanName(allin[[1]]$Patient)
```

```
## [1] "Ankunding277D'Amore443"
```

The edges emanating from the node corresponding to this patient are conditions that have
been recorded. Edges are retrieved using the `edgeL` method.

```
library(graph)
nodes(g$graph)[edgeL(g$graph)[["Ankunding277D'Amore443"]]$edges]
```

```
## [1] "Chronic sinusitis (disorder)"
## [2] "Normal pregnancy"
## [3] "Miscarriage in first trimester"
## [4] "Blighted ovum"
## [5] "Viral sinusitis (disorder)"
## [6] "Acute viral pharyngitis (disorder)"
## [7] "Body mass index 30+ - obesity (finding)"
## [8] "Sprain of wrist"
## [9] "Hyperlipidemia"
```

# 4 Adding procedures to the graph

We have been unable so far to see how procedures
can be linked directly to conditions, except by
association with a given patient. We
add the procedure information as follows:

```
g = add_procedures(g, allin)
```

```
## ...some bundles had no Procedure component
```

```
g
```

```
## BiocFHIR.FHIRgraph instance.
## A graphNEL graph with directed edges
## Number of Nodes = 214
## Number of Edges = 864
##  50 patients, 70 conditions
```

Data on additional resources can be added using
the methods of `add_procedures`. This
will be carried out in future
releases.

# 5 Interactive visualization of the graph

A visNetwork widget can be produced directly
from a list of ingested bundles. This display can
be zoomed and dragged. Procedures are green, patients
are blue, conditions are red.

```
display_proccond_igraph( build_proccond_igraph( allin ))
```

```
## ...some bundles had no Procedure component
```

# 6 Conclusions

This collection of vignettes shows some approaches to
working with FHIR R4 JSON using R. It is very likely that
a new collection of bundles obtained from a different source
would not be properly ingested or transformed by the code
present in this version of BiocFHIR. Future extensions of
the package will employ direct analysis of JSON structures
to identify data values and relationships, that should be more
adaptable to diverse collections of documents.

Relationships among resources may be represented in many
different ways. This survey of the resources in the synthea
bundles is surely limited, perhaps even with respect to the
information available in the bundles. FHIR experts are invited
to identify gaps in this implementation. We anticipate
considerable additional work needed to deal with other contexts
such as research studies.

# 7 Session information

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
## [1] igraph_2.2.1        graph_1.88.0        BiocGenerics_0.56.0
## [4] generics_0.1.4      rjsoncons_1.3.2     jsonlite_2.0.0
## [7] DT_0.34.0           BiocFHIR_1.12.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] dplyr_1.1.4          compiler_4.5.1       BiocManager_1.30.26
##  [4] BiocBaseUtils_1.12.0 promises_1.4.0       tidyselect_1.2.1
##  [7] Rcpp_1.1.0           tidyr_1.3.1          later_1.4.4
## [10] jquerylib_0.1.4      yaml_2.3.10          fastmap_1.2.0
## [13] mime_0.13            R6_2.6.1             knitr_1.50
## [16] htmlwidgets_1.6.4    visNetwork_2.1.4     tibble_3.3.0
## [19] bookdown_0.45        shiny_1.11.1         bslib_0.9.0
## [22] pillar_1.11.1        rlang_1.1.6          cachem_1.1.0
## [25] httpuv_1.6.16        xfun_0.53            sass_0.4.10
## [28] otel_0.2.0           cli_3.6.5            magrittr_2.0.4
## [31] crosstalk_1.2.2      digest_0.6.37        xtable_1.8-4
## [34] lifecycle_1.0.4      vctrs_0.6.5          evaluate_1.0.5
## [37] glue_1.8.0           stats4_4.5.1         purrr_1.1.0
## [40] rmarkdown_2.30       tools_4.5.1          pkgconfig_2.0.3
## [43] htmltools_0.5.8.1
```