# Pathway construction

Denes Turei1\*

1Institute for Computational Biomedicine, Heidelberg University

\*turei.denes@gmail.com

#### 29 January 2026

#### Abstract

Constructing possible pathways according to certain biological constraints
is one popular use of pathway databases. Here we show how to create de
novo pathways using subcellular localization and molecular function
constraints. In this example, the pathways should start from extracellular
ligands, trigger intracellular cascades via a plasma membrane receptor,
and end on transcription factors. Just to have an example, we use a
pathway from SignaLink as genes of interest, and try to de novo reconstruct
this pathway from other resources in OmniPath.

#### Package

OmnipathR 3.18.4

# Contents

* [1 Preparing inputs](#preparing-inputs)
  + [1.1 Transcription factors](#transcription-factors)
  + [1.2 Protein localizations](#protein-localizations)
  + [1.3 Ligands and receptors](#ligands-and-receptors)
  + [1.4 Protein-protein interactions](#protein-protein-interactions)
  + [1.5 Example pathways from literature](#example-pathways-from-literature)
* [2 Pathway construction I.](#pathway-construction-i.)
  + [2.1 Genes of interest](#genes-of-interest)
  + [2.2 Creating a PPI graph](#creating-a-ppi-graph)
  + [2.3 Looking up the paths](#looking-up-the-paths)
  + [2.4 Applying constraints on the paths](#applying-constraints-on-the-paths)
* [3 Pathway construction II.](#pathway-construction-ii.)
  + [3.1 Networks](#networks)
  + [3.2 Annotations](#annotations)
  + [3.3 Building paths](#building-paths)
* [4 Technical information](#technical-information)
  + [4.1 Dependencies](#dependencies)
  + [4.2 How to compile](#how-to-compile)
  + [4.3 Session information](#session-information)

1 Institute for Computational Biomedicine, Heidelberg University

# 1 Preparing inputs

In this tutorial we use Gene Symbols (HGNC symbols) as primary identifiers
just to maintain better human readability across all intermediate steps,
however the same procedure can be done with UniProt IDs, and this latter
is more preferable.

## 1.1 Transcription factors

The endpoints of pathways are transcription factors (TFs). We obtain a list
of TFs from Vaquerizas et al. 2009, the so called TF census:

```
library(OmnipathR)
library(magrittr)
library(dplyr)

tfcensus <-
    annotations(
        resources = 'TFcensus',
        entity_types = 'protein'
    ) %>%
    pull(genesymbol) %>%
    unique
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

Alternatively we can directly download the same dataset, but retrieving
data from OmniPath is preferable most of the times:

```
library(purrr)
```

```
##
## Attaching package: 'purrr'
```

```
## The following object is masked from 'package:magrittr':
##
##     set_names
```

```
## The following objects are masked from 'package:igraph':
##
##     compose, simplify
```

```
tfcensus_direct <-
    tfcensus_download() %>%
    pull(`HGNC symbol`) %>%
    discard(is.na) %>%
    unique
```

```
## Warning: One or more parsing issues, call `problems()` on your data frame for details, e.g.:
##   dat <- vroom(...)
##   problems(dat)
```

Another way to obtain a list of TFs is to collect the proteins with known
regulons (target genes). We can download the TF-target interactions from
OmniPath and collect all proteins which are source of any of these
interactions.

```
tfs_from_network <-
    transcriptional(
        # confidence levels;
        # we use only the 3 levels with highest confidence
        dorothea_levels = c('A', 'B', 'C'),
        entity_types = 'protein'
    ) %>%
    pull(source_genesymbol) %>%
    unique
```

The latest method resulted only around 600 TFs, however 97 of these are
not in TF census. Maybe a good solution is to use the union of these and
TF census:

```
tfs <- union(tfcensus, tfs_from_network)
```

## 1.2 Protein localizations

OmniPath contains a few resources providing subcellular localization data.
We present here a three of them:

```
localizations <-
    annotations(
        resources = c(
            'Ramilowski_location',
            'UniProt_location',
            'HPA_subcellular'
        ),
        entity_types = 'protein',
        wide = TRUE
    )
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

Checking how many proteins are covered in each of these resources:

```
localizations %>%
map(function(x){x %>% pull(genesymbol) %>% n_distinct})
```

```
## $HPA_subcellular
## [1] 13304
##
## $Ramilowski_location
## [1] 18839
##
## $UniProt_location
## [1] 17198
```

## 1.3 Ligands and receptors

The *Intercell* database of OmniPath is a comprehensive resource of cell-cell
communication roles. We obtain a set of ligands, receptors, and as
alternatives we create a sets of transmitters and receivers, which are
broader categories, generalizations of the former two. After loading each
of these datasets, we print the number of unique proteins.

```
ligands <-
    OmnipathR::intercell(
        parent = 'ligand',
        topology = 'sec',
        consensus_percentile = 50,
        loc_consensus_percentile = 30,
        entity_types = 'protein'
    ) %>%
    pull(genesymbol) %>%
    unique %T>%
    length

receptors <-
    OmnipathR::intercell(
        parent = 'receptor',
        topology = 'pmtm',
        consensus_percentile = 50,
        loc_consensus_percentile = 30,
        entity_types = 'protein'
    ) %>%
    pull(genesymbol) %>%
    unique %T>%
    length

transmitters <-
    OmnipathR::intercell(
        causality = 'trans',
        topology = 'sec',
        consensus_percentile = 50,
        loc_consensus_percentile = 30,
        entity_types = 'protein'
    ) %>%
    pull(genesymbol) %>%
    unique %T>%
    length

receivers <-
    OmnipathR::intercell(
        causality = 'rec',
        topology = 'pmtm',
        consensus_percentile = 50,
        loc_consensus_percentile = 30,
        entity_types = 'protein'
    ) %>%
    pull(genesymbol) %>%
    unique %T>%
    length
```

## 1.4 Protein-protein interactions

The protein-protein interactions in OmniPath come from many resources and
are divided into 4 major datasets (`omnipath`, `pathwayextra`, `kinaseextra`
and `ligrecextra`). We can try our procedure with any combination of these,
or even select only some resources within them. Here, for the sake of
simplicity, we use only the core `omnipath` PPI dataset, which contains
only literature curated, causal interactions.

```
ppi <-
    omnipath(
        datasets = 'omnipath',
        entity_types = 'protein'
    )
```

## 1.5 Example pathways from literature

Many databases contains curated canonical pathways, such as SIGNOR, KEGG
or SignaLink. SignaLink pathways have been curated by experts from ligands
to TFs, and the proteins are annotated as ligands, receptors, mediators,
scaffolds, co-factors and TFs. For this reason, we use SignaLink pathways
in this demonstration.

```
signalink_pathways <-
    annotations(
        resources = 'SignaLink_pathway',
        entity_types = 'protein',
        wide = TRUE
    )
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
signalink_functions <-
    annotations(
        resources = 'SignaLink_function',
        entity_types = 'protein',
        wide = TRUE
    )
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

# 2 Pathway construction I.

## 2.1 Genes of interest

In this example, we use the ligands of the SignaLink TGF-beta pathway as
genes of interest, which will be the starting point of the paths:

```
ligands_of_interest <-
    intersect(
        signalink_pathways %>%
            filter(pathway == 'TGF') %>%
            pull(genesymbol),
        signalink_functions %>%
            filter(`function` == 'Ligand') %>%
            pull(genesymbol)
    ) %T>%
    length
```

## 2.2 Creating a PPI graph

The data frame of interactions has to be converted to an igraph graph
object, because the `find_all_paths` function works on this kind of
object.

```
ppi_graph <-
    ppi %>%
    interaction_graph
```

## 2.3 Looking up the paths

Searching paths in the graph, we have to define the source and target nodes
and the maximum length of the paths. The source nodes will be the ligands
of the TGF-beta pathway, the target nodes the TFs, and the maximum path
length I set to 3. This latter results paths of 3 edges, connecting 4
nodes. The more numerous are the source and target node sets, the longer
is the maximum length, the longer it takes to look up all the paths.

First we make sure we use only the ligands and TFs which are part of this
network:

```
library(igraph)

ligands_of_interest__in_network <-
    ligands_of_interest %>%
    keep(. %in% V(ppi_graph)$name)

tfs__in_network <-
    tfs %>%
    keep(. %in% V(ppi_graph)$name)
```

Then we look up the paths, this might take a few minutes:

```
paths <-
    ppi_graph %>%
    find_all_paths(
        start = ligands_of_interest__in_network,
        end = tfs__in_network,
        maxlen = 3,
        attr = 'name'
    )
```

A `maxlen` of 2 resulted around 600 paths, increasing the length only by 1
results 15,173 paths and takes ca. 10 min to run. A length of 4 probably
would be still feasible, but might result millions of paths and hours of
computation time.

## 2.4 Applying constraints on the paths

All the resulted paths start at a ligand and end on a TF, but we need to
make sure that the intermediate nodes meet the desired constraints: the
second node is a plasma membrane receptor, the mediators are located in
the cytoplasm, etc.

```
# only selecting Cytoplasm, of course we could
# consider other intracellular compartments
in_cytoplasm <-
    localizations$UniProt_location %>%
    filter(location == 'Cytoplasm') %>%
    pull(genesymbol) %>%
    unique

in_nucleus <-
    localizations$UniProt_location %>%
    filter(location %in% c('Nucleus', 'Nucleolus')) %>%
    pull(genesymbol) %>%
    unique

paths_selected <-
    paths %>%
    # removing single node paths
    discard(
        function(p){
            length(p) == 1
        }
    ) %>%
    # receptors are plasma membrane transmembrane
    # according to our query to OmniPath
    keep(
        function(p){
            p[2] %in% receptors
        }
    ) %>%
    # making sure all further mediators are
    # in the cytoplasm
    keep(
        function(p){
            all(p %>% tail(-2) %>% is_in(in_cytoplasm))
        }
    ) %>%
    # the last nodes are all TFs, implying that they are in the nucleus
    # but we can optionally filter foall(p %>% tail(-2)r this too:
    keep(
        function(p){
            last(p) %in% in_nucleus
        }
    ) %>%
    # finally, we can remove paths which contain TFs also as intermediate
    # nodes as these are redundant
    discard(
        function(p){
            !any(p %>% head(-1) %>% is_in(tfs))
        }
    )
```

Out of the 15,173 paths, 2,045 (~13%) meet these criteria. 43 of the
paths consist of 3 nodes (ligand->receptor->TF), while 2,002 of 4 nodes
(ligand->receptor->mediator->TF):

```
paths_selected %>% length

paths_selected %>% map_int(length) %>% table
```

# 3 Pathway construction II.

## 3.1 Networks

We have seen `find_all_paths` is limited in efficiency.
A more convenient method could be to use only data frames and `dplyr`’s
`join` methods to build the paths. This comes with the advantage that
even more efficient backends are available for `dplyr`, such as `dtplyr`
(`data.frame` backend) or `dbplyr` (relational DBMS backends), hence if
needed the performance can be easily improved.

In `OmnipathR` we have already a dedicated
function for creating ligand-receptor (or transmitter-receiver) interactions,
we can use this as a first step. For simplicity, here we limited the query to
ligand-receptor interactions and do a simple filtering to select high
confidence ones (mostly based on consensus across resources). Alternatively,
one can fine tune better the parameters to `intercell_network`, or
call it without any parameters, and use `filter_intercell_network` for
quality filtering. At the end we use `simplify_intercell_network` to get
rid of redundant columns.

```
ligand_receptor <-
    intercell_network(
        ligand_receptor = TRUE,
        high_confidence = TRUE,
        entity_types = 'protein'
    ) %>%
    simplify_intercell_network
```

We query the TF-target gene interactions into another data frame:

```
tf_target <-
    transcriptional(
        # confidence levels;
        # we use only the 2 levels with highest confidence
        dorothea_levels = c('A', 'B'),
        # I added this only to have less interactions so the
        # examples here run faster; feel free to remove it,
        # then you will have more gene regulatory interactions
        # from a variety of databases
        datasets = 'tf_target',
        entity_types = 'protein',
        # A workaround to mitigate a temporary issue (05/01/2022)
        resources = c('ORegAnno', 'PAZAR')
    )
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

The PPI network we already have in the `ppi` data frame, we loaded it in the
previous section. If you missed it, you can load it like this:

```
ppi <-
    omnipath(
        datasets = 'omnipath',
        entity_types = 'protein'
    )
```

## 3.2 Annotations

As a next step, we add *UniProt* localization annotations to the network data
frames, except the ligand-receptor data frame, as this is created in a way
that all ligands are extracellular and all receptors are plasma membrane
transmembrane. In addition, we also add kinase annotations from the
*kinase.com* resource, just to showcase working with multiple annotations.
One protein might have multiple localizations and belong to multiple kinase
families. We transform the localization and kinase family columns to list
columns, which means one field might contain more than one values.

```
ppi %<>%
    annotated_network('UniProt_location') %>%
    annotated_network('kinase.com') %>%
    # these columns define a unique interaction; 5 of them would be enough
    # for only the grouping, we include the rest only to keep them after
    # the summarize statement
    group_by(
        source,
        target,
        source_genesymbol,
        target_genesymbol,
        is_directed,
        is_stimulation,
        is_inhibition,
        sources,
        references,
        curation_effort,
        n_references,
        n_resources
    ) %>%
    summarize(
        location_source = list(unique(location_source)),
        location_target = list(unique(location_target)),
        family_source = list(unique(family_source)),
        family_target = list(unique(family_target)),
        subfamily_source = list(unique(subfamily_source)),
        subfamily_target = list(unique(subfamily_target))
    ) %>%
    ungroup
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
## `summarise()` has grouped output by 'source', 'target', 'source_genesymbol', 'target_genesymbol',
## 'is_directed', 'is_stimulation', 'is_inhibition', 'sources', 'references', 'curation_effort', 'n_references'.
## You can override using the `.groups` argument.
```

```
tf_target %<>%
    annotated_network('UniProt_location') %>%
    annotated_network('kinase.com') %>%
    group_by(
        source,
        target,
        source_genesymbol,
        target_genesymbol,
        is_directed,
        is_stimulation,
        is_inhibition,
        sources,
        references,
        curation_effort,
        # Workaround to mitigate a temporary issue with
        # DoRothEA data in OmniPath (05/01/2022)
        # dorothea_level,
        n_references,
        n_resources
    ) %>%
    summarize(
        location_source = list(unique(location_source)),
        location_target = list(unique(location_target)),
        family_source = list(unique(family_source)),
        family_target = list(unique(family_target)),
        subfamily_source = list(unique(subfamily_source)),
        subfamily_target = list(unique(subfamily_target))
    ) %>%
    ungroup
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
## `summarise()` has grouped output by 'source', 'target', 'source_genesymbol', 'target_genesymbol',
## 'is_directed', 'is_stimulation', 'is_inhibition', 'sources', 'references', 'curation_effort', 'n_references'.
## You can override using the `.groups` argument.
```

## 3.3 Building paths

We build the paths starting from the ligand-receptor interactions, joining
the PPI interactions repeatedly until we reach the desired path length.
After each step we throw away the paths which contain loops; set aside the
paths which end in a TF; and keep growing the rest of the paths. At the end,
we add the gene regulatory interactions to the end of each path, making all
paths start in an extracellular ligand and end in a TF target gene. In each
step we add suffixes to the column names: `_step1`, `_step2`, and so on, to
ensure the attributes of each step can be recognized. Each step will extend
the width of the data frame by around 20 columns. We could reduce this by
dropping certain variables. First, we define the set of TFs:

```
tfs <-
    tf_target %>%
    pull(source_genesymbol) %>%
    unique
```

For the repetitive task of growing paths we define a function:

```
library(rlang)
```

```
##
## Attaching package: 'rlang'
```

```
## The following objects are masked from 'package:purrr':
##
##     flatten, flatten_chr, flatten_dbl, flatten_int, flatten_lgl, flatten_raw, invoke, splice
```

```
## The following object is masked from 'package:magrittr':
##
##     set_names
```

```
## The following object is masked from 'package:igraph':
##
##     is_named
```

```
library(tidyselect)

grow_paths <- function(paths, step, interactions, endpoints = NULL){

    right_target_col <- sprintf(
        'target_genesymbol_step%i',
        step
    )

    paths$growing %<>% one_step(step, interactions)

    # finished paths with their last node being an endpoint:
    paths[[sprintf('step%i', step)]] <-
        paths$growing %>%
        {`if`(
            is.null(endpoints),
            .,
            filter(., !!sym(right_target_col) %in% endpoints)
        )}

    # paths to be further extended:
    paths$growing %<>%
        {`if`(
            is.null(endpoints),
            NULL,
            filter(., !(!!sym(right_target_col) %in% endpoints))
        )}

    invisible(paths)

}

one_step <- function(paths, step, interactions){

    left_col <- sprintf('target_genesymbol_step%i', step - 1)
    right_col <- sprintf('source_genesymbol_step%i', step)
    by <- setNames(right_col, left_col)

    paths %>%
    # making sure even at the first step we have the suffix `_step1`
    {`if`(
        'target_genesymbol' %in% colnames(.),
        rename_with(
            .,
            function(x){sprintf('%s_step%i', x, step)}
        ),
        .
    )} %>%
    {`if`(
        step == 0,
        .,
        inner_join(
            .,
            # adding suffix for the next step
            interactions %>%
            rename_with(function(x){sprintf('%s_step%i', x, step)}),
            by = by
        )
    )} %>%
    # removing loops
    filter(
        select(., contains('_genesymbol')) %>%
        pmap_lgl(function(...){!any(duplicated(c(...)))})
    )

}
```

This function seems to be useful, after some refactoring I will add it to
`OmnipathR`. But now let’s use it for building the paths. First, using
`reduce`, we call the previously defined function repeatedly according to
the desired number of steps. After, we go through the collections of paths
of various lengths, and add the last step, the TF-target interactions.
This procedure is extremely **memory intensive,** if you run it with 3 steps,
make sure you have at least 12G of free memory. Higher number of steps
(longer paths) require even more memory. Of course this can be mitigated
by removing some columns, adding less annotations, or using smaller networks
(more stringent queries or subsequent filtering).

```
library(stringr)

steps <- 2 # to avoid OOM

paths <-
    seq(0, steps) %>%
    head(-1) %>%
    reduce(
        grow_paths,
        interactions = ppi,
        endpoints = tfs,
        .init = list(
            growing = ligand_receptor
        )
    ) %>%
    within(rm(growing)) %>%
    map2(
        names(.) %>% str_extract('\\d+$') %>% as.integer %>% add(1),
        one_step,
        interactions = tf_target
    )
```

# 4 Technical information

## 4.1 Dependencies

Here is a list of all packages used in this vignette:

```
library(OmnipathR)
library(magrittr)
library(dplyr)
library(purrr)
library(igraph)
library(rlang)
library(tidyselect)
library(stringr)
library(rmarkdown)
```

This way you can make sure all these packages are installed:

```
missing_packages <-
    setdiff(
        c(
            'magrittr',
            'dplyr',
            'purrr',
            'igraph',
            'rlang',
            'tidyselect',
            'stringr',
            'rmarkdown',
            'devtools'
        ),
        installed.packages()
    )

if(length(missing_packages)){
    install.packages(missing_packages)
}

if(!'OmnipathR' %in% installed.packages()){
    library(devtools)
    devtools::install_github('saezlab/OmnipathR')
}
```

## 4.2 How to compile

This is an `Rmd` (R markdown) document, a popular reporting format for R.
You can generate various document formats from it, such as HTML or PDF,
using the `render` function from the `rmarkdown` package:

```
library(rmarkdown)
render('paths.Rmd', output_format = 'html_document')
```

## 4.3 Session information

Below you find information about the operating system, R version and all the
loaded packages and their versions from an R session where this vignette
run without errors. This can be useful for troubleshooting, as different
software versions are one possible cause of errors.

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
##  [1] tidyselect_1.2.1 rlang_1.1.7      purrr_1.2.1      gprofiler2_0.2.4 tidyr_1.3.2      knitr_1.51
##  [7] magrittr_2.0.4   ggraph_2.2.2     igraph_2.2.1     ggplot2_4.0.1    dplyr_1.1.4      OmnipathR_3.18.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] bitops_1.0-9        DBI_1.2.3           gridExtra_2.3       httr2_1.2.2         tcltk_4.5.2
##   [6] logger_0.4.1        readxl_1.4.5        otel_0.2.0          compiler_4.5.2      RSQLite_2.4.5
##  [11] png_0.1-8           vctrs_0.7.1         rvest_1.0.5         stringr_1.6.0       pkgconfig_2.0.3
##  [16] crayon_1.5.3        fastmap_1.2.0       backports_1.5.0     magick_2.9.0        labeling_0.4.3
##  [21] utf8_1.2.6          promises_1.5.0      rmarkdown_2.30      sessioninfo_1.2.3   tzdb_0.5.0
##  [26] ps_1.9.1            tinytex_0.58        bit_4.6.0           xfun_0.56           cachem_1.1.0
##  [31] jsonlite_2.0.0      progress_1.2.3      blob_1.3.0          later_1.4.5         tweenr_2.0.3
##  [36] parallel_4.5.2      prettyunits_1.2.0   R6_2.6.1            bslib_0.10.0        stringi_1.8.7
##  [41] RColorBrewer_1.1-3  lubridate_1.9.4     jquerylib_0.1.4     cellranger_1.1.0    Rcpp_1.1.1
##  [46] bookdown_0.46       R.utils_2.13.0      readr_2.1.6         timechange_0.3.0    dichromat_2.0-0.1
##  [51] yaml_2.3.12         viridis_0.6.5       websocket_1.4.4     curl_7.0.0          processx_3.8.6
##  [56] tibble_3.3.1        withr_3.0.2         S7_0.2.1            evaluate_1.0.5      polyclip_1.10-7
##  [61] zip_2.3.3           xml2_1.5.2          pillar_1.11.1       BiocManager_1.30.27 checkmate_2.3.3
##  [66] plotly_4.12.0       generics_0.1.4      RCurl_1.98-1.17     vroom_1.7.0         chromote_0.5.1
##  [71] hms_1.1.4           scales_1.4.0        glue_1.8.0          lazyeval_0.2.2      tools_4.5.2
##  [76] data.table_1.18.2.1 fs_1.6.6            graphlayouts_1.2.2  XML_3.99-0.20       tidygraph_1.3.1
##  [81] grid_4.5.2          ggforce_0.5.0       cli_3.6.5           rappdirs_0.3.4      viridisLite_0.4.2
##  [86] gtable_0.3.6        R.methodsS3_1.8.2   selectr_0.5-1       sass_0.4.10         digest_0.6.39
##  [91] ggrepel_0.9.6       htmlwidgets_1.6.4   farver_2.1.2        memoise_2.0.1       htmltools_0.5.9
##  [96] R.oo_1.27.1         lifecycle_1.0.5     httr_1.4.7          bit64_4.6.0-1       MASS_7.3-65
```