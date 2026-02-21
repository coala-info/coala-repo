# Building prior knowledge network (PKN) for COSMOS

Denes Turei1\*

1Institute for Computational Biomedicine, Heidelberg University

\*turei.denes@gmail.com

#### 29 January 2026

#### Abstract

The prior knowledge network (PKN) used by COSMOS is a network of
heterogenous causal interactions: it contains protein-protein,
reactant-enzyme and enzyme-product interactions. It is a combination of
multiple resources. Here we present the functions that load each component,
the options for customization, and the functions to build the complete PKN.

#### Package

OmnipathR 3.18.4

# Contents

* [1 Introduction](#introduction)
* [2 Chalmers Sysbio GEM](#chalmers-sysbio-gem)
* [3 STITCH enzyme-metabolite interactions](#stitch-enzyme-metabolite-interactions)
* [4 OmniPath signaling network](#omnipath-signaling-network)
* [5 Complete build](#complete-build)
* [6 Session information](#session-information)

1 Institute for Computational Biomedicine, Heidelberg University

# 1 Introduction

The COSMOS PKN is a combination of the following datasets:

* Genome-scale metabolic model (GEM) from Chalmers Sysbio (Wang et al., 2021.)
* Network of chemical-protein interactions from STITCH (<http://stitch.embl.de/>)
* Protein-protein interactions from Omnipath (Türei et al., 2021)

Building the PKN is possible in by calling the `cosmos_pkn()` function that we
present in the last section. First let’s take a closer look at each resource.

```
library(OmnipathR)
```

# 2 Chalmers Sysbio GEM

The Chalmers Sysbio group provides genome scale models of metabolism (GEMs) for
various organisms: human, mouse, rat, fish, fly and worm. These models are
available as Matlab files, which contain reaction data, stoichiometry matrix
and identifier translation data.

The raw contents of the Matlab file can be loaded by `chalmers_gem_raw()`. This
results in a convoluted structure of nested lists and arrays:

```
ch_raw <- chalmers_gem_raw()
```

Another function, `chalmers_gem()` processes the above structure into a data
frame of reactions, also keeping the stoichiometry matrix and including the
identifier translation data:

```
ch_processed <- chalmers_gem()
names(ch_processed)
```

```
## NULL
```

The identifier translation tables are available by separate functions,
`chalmers_gem_metabolites()` and `chalmers_gem_reactions()` for metabolite and
reaction (and enzyme) identifiers, respectively. These return simple data
frames.

```
ch_met <- chalmers_gem_metabolites()

ch_met
```

```
## NULL
```

The metabolite identifier translation available here is also integrated into
the package’s translation service, available by the `translate_ids` and other
functions.

```
translate_ids('MAM00001', 'metabolicatlas', 'recon3d', chalmers = TRUE)
```

Finally, the `chalmers_gem_network()` function uses all above data to compile a
network binary chemical-protein interactions. By default Metabolic Atlas
identifiers are used for the metabolites and Ensembl Gene IDs for the
enzymes. These can be tranlated to the desired identifiers using the
`metabolite_ids` and `protein_ids` arguments. Translation to multiple
identifers is possible. The `ri` or `record_id` column in case of the Chalmers
GEM represent the reaction ID, a unique identifier of the original reaction.
One reaction yields many binary interactions as it consists of a number of gene
products, reactants and products. The column `ci` means “complex ID”, it is a
unique identifier of groups of enzymes required together to carry out the
reaction. The column `reverse` indicates if the row is derived from the
reversed version of a reversible reaction. The column `transporter` signals
reactions where the same metabolite occures both on reactant and product side,
these are assumed to be transport reactions. In the Chalmers GEM the reactions
are also assigned to compartments, these are encoded by single letter codes in
the `comp` column. In the original data the compartment codes are postfixes of
the metabolite IDs, here we move them into a separate column, leaving the
Metabolic Atlas IDs clean and usable.

```
ch <- chalmers_gem_network()

ch
```

# 3 STITCH enzyme-metabolite interactions

STITCH is a large compendium of binary interactions between proteins and
chemicals. Some of these are derived from metabolic reactions. Various
attributes such as mode of action, effect sign and scores are assigned to each
link. The datasets are available by organism, stored in “actions” and “links”
tables, available by the `stitch_actions()` and `stitch_links()` functions,
respectively. STITCH supports a broad variety of organisms, please refer to
their website at (<https://stitch.embl.de/>).

```
sta <- stitch_actions()

sta
```

```
stl <- stitch_links()

stl
```

`stitch_network()` combines the actions and links data frames, filters by
confidence scores, removes the prefixes from identifiers and translates them to
the desired ID types. STITCH prefixes Ensembl Protein IDs with the NCBI Taxonomy
ID, while PubChem CIDs with CID plus a lowercase letter “s” or “m”, meaning
stereo specific or merged stereoisomers, respectively. These prefixes are
removed by default by the `stitch_remove_prefixes()` function. Effect signs (1
= activation, -1 = inhibition) and combined scores are aslo included in the
data frame. Similarly to Chalmers GEM, translation of chemical and protein
identifiers is available. The `record_id` column uniquely identifies the
original records. Multiple rows with the same `record_id` are due to
one-to-many identifier translation.

```
st <- stitch_network()

st
```

# 4 OmniPath signaling network

All parameters supported by the OmniPath web service
(`omnipath()`) can be passed to `omnipath_for_cosmos()`,
enabling precise control over the resources, interaction types and other
options when preparing the signaling network from OmniPath. By default the
“omnipath” dataset is included which contains high confidence, literature
curated, causal protein-protein interactions. For human, mouse and rat,
orthology translated data is retrieved from the web service, while for other
organisms translation by orthologous gene pairs is carried out client side.

```
op <- omnipath_for_cosmos()
```

```
## Warning: The `file` argument of `vroom()` must use `I()` for literal data as of vroom 1.5.0.
##
##   # Bad:
##   vroom("X,Y\n1.5,2.3\n")
##
##   # Good:
##   vroom(I("X,Y\n1.5,2.3\n"))
## ℹ The deprecated feature was likely used in the readr package.
##   Please report the issue at <https://github.com/tidyverse/readr/issues>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

```
## Warning: One or more parsing issues, call `problems()` on your data frame for details, e.g.:
##   dat <- vroom(...)
##   problems(dat)
```

```
op
```

```
## # A tibble: 145,749 × 8
##    source target  sign record_id uniprot_source uniprot_target genesymbol_source genesymbol_target
##    <chr>  <chr>  <dbl>     <int> <chr>          <chr>          <chr>             <chr>
##  1 P0DP25 P48995    -1         1 P0DP25         P48995         CALM3             TRPC1
##  2 P0DP23 P48995    -1         2 P0DP23         P48995         CALM1             TRPC1
##  3 P0DP24 P48995    -1         3 P0DP24         P48995         CALM2             TRPC1
##  4 Q03135 P48995     1         4 Q03135         P48995         CAV1              TRPC1
##  5 P14416 P48995     1         5 P14416         P48995         DRD2              TRPC1
##  6 Q99750 P48995    -1         6 Q99750         P48995         MDFI              TRPC1
##  7 Q14571 P48995     1         7 Q14571         P48995         ITPR2             TRPC1
##  8 P29966 P48995    -1         8 P29966         P48995         MARCKS            TRPC1
##  9 Q13255 P48995     1         9 Q13255         P48995         GRM1              TRPC1
## 10 Q13586 P48995     1        10 Q13586         P48995         STIM1             TRPC1
## # ℹ 145,739 more rows
```

# 5 Complete build

Building the complete COSMOS PKN is done by `cosmos_pkn()`. All the resources
above can be customized by arguments passed to this function. With all
downloads and processing the build might take 30-40 minutes. Data
is cached at various levels of processing, shortening processing times. With
all data downloaded and HMDB ID translation data preprocessed, the build
takes 3-4 minutes; the complete PKN is also saved in the cache, if this is
available, loading it takes only a few seconds.

```
pkn <- cosmos_pkn()

pkn
```

The `record_id` column identifies the original records within each
resource. If one `record_id` yields multiple records in the final data
frame, it is the result of one-to-many ID translation or other
processing steps. Before use, it is recommended to select one pair of ID
type columns (by combining the preferred ones) and perform `distinct`
by the identifier columns and sign. After the common columns, resource specific
columns are labeled with the resource name; after these columns, molecule type
and side specific identifer columns are named after the ID type and the side of
the interaction (“source” vs. “target”).

# 6 Session information

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] OmnipathR_3.18.4 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] xfun_0.56           bslib_0.10.0        httr2_1.2.2         websocket_1.4.4     processx_3.8.6
##  [6] tzdb_0.5.0          vctrs_0.7.1         tools_4.5.2         ps_1.9.1            generics_0.1.4
## [11] parallel_4.5.2      curl_7.0.0          tibble_3.3.1        RSQLite_2.4.5       blob_1.3.0
## [16] pkgconfig_2.0.3     R.oo_1.27.1         checkmate_2.3.3     readxl_1.4.5        lifecycle_1.0.5
## [21] compiler_4.5.2      stringr_1.6.0       progress_1.2.3      chromote_0.5.1      htmltools_0.5.9
## [26] sass_0.4.10         yaml_2.3.12         tidyr_1.3.2         later_1.4.5         pillar_1.11.1
## [31] crayon_1.5.3        jquerylib_0.1.4     R.utils_2.13.0      cachem_1.1.0        sessioninfo_1.2.3
## [36] zip_2.3.3           tidyselect_1.2.1    rvest_1.0.5         digest_0.6.39       stringi_1.8.7
## [41] dplyr_1.1.4         purrr_1.2.1         bookdown_0.46       fastmap_1.2.0       cli_3.6.5
## [46] logger_0.4.1        magrittr_2.0.4      utf8_1.2.6          XML_3.99-0.20       withr_3.0.2
## [51] readr_2.1.6         prettyunits_1.2.0   promises_1.5.0      backports_1.5.0     rappdirs_0.3.4
## [56] bit64_4.6.0-1       lubridate_1.9.4     timechange_0.3.0    rmarkdown_2.30      httr_1.4.7
## [61] igraph_2.2.1        bit_4.6.0           otel_0.2.0          cellranger_1.1.0    R.methodsS3_1.8.2
## [66] hms_1.1.4           memoise_2.0.1       evaluate_1.0.5      knitr_1.51          tcltk_4.5.2
## [71] rlang_1.1.7         Rcpp_1.1.1          glue_1.8.0          DBI_1.2.3           selectr_0.5-1
## [76] BiocManager_1.30.27 xml2_1.5.2          vroom_1.7.0         jsonlite_2.0.0      R6_2.6.1
## [81] fs_1.6.6
```