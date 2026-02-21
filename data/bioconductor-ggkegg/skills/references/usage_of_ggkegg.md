# ggkegg

Noriaki Sato

#### 30 October 2025

# 1 ggkegg

This package aims to import, parse, and analyze KEGG data such as KEGG PATHWAY and KEGG MODULE. The package supports visualizing KEGG information using ggplot2 and ggraph through using the grammar of graphics. The package enables the direct visualization of the results from various omics analysis packages and the connection to the other tidy manipulation packages. In this documentation, the basic usage of `ggkegg` is presented. Please refer to [the documentation](https://noriakis.github.io/software/ggkegg) for the detailed usage.

## 1.1 Introduction

There are many great packages performing KEGG PATHWAY analysis in R. *[pathview](https://bioconductor.org/packages/3.22/pathview)* fetches KEGG PATHWAY information, enabling the output of images reflecting various user-defined values on the map. *[KEGGlincs](https://bioconductor.org/packages/3.22/KEGGlincs)* can overlay LINCS data to KEGG PATHWAY, and examine the map using Cytoscape. *[graphite](https://bioconductor.org/packages/3.22/graphite)* acquires pathways including KEGG and Reactome, convert them into graphNEL format, and provides an interface for topological analysis. *[KEGGgraph](https://bioconductor.org/packages/3.22/KEGGgraph)* also downloads KEGG PATHWAY information and converts it into a format analyzable in R. Extending to these packages, the purpose of developing this package, `ggkegg`, is to allow for tidy manipulation of KEGG information by the power of `tidygraph`, to plot the relevant information in flexible and customizable ways using grammar of graphics, to examine the global and overview maps consisting of compounds and reactions.

## 1.2 Pathway

The users can obtain a KEGG PATHWAY `tbl_graph` by `pathway` function. If you want to cache the file, please specify `use_cache=TRUE`, and if you already have the XML files of the pathway, please specify the directory of the file with `directory` argument. Here, we obtain `Cell cycle` pathway (`hsa04110`) using cache. `pathway_id` column is inserted to node and edge by default, which allows for the identification of the pathway ID in the other functions.

```
library(ggkegg)
library(tidygraph)
library(dplyr)
graph <- ggkegg::pathway("hsa04110", use_cache=TRUE)
graph
```

```
## # A tbl_graph: 134 nodes and 157 edges
## #
## # A directed acyclic multigraph with 40 components
## #
## # Node Data: 134 × 18 (active)
##    name    type  reaction graphics_name     x     y width height fgcolor bgcolor
##    <chr>   <chr> <chr>    <chr>         <dbl> <dbl> <dbl>  <dbl> <chr>   <chr>
##  1 hsa:10… gene  <NA>     CDKN2A, ARF,…   532  -218    46     17 #000000 #BFFFBF
##  2 hsa:51… gene  <NA>     FZR1, CDC20C…   981  -630    46     17 #000000 #BFFFBF
##  3 hsa:41… gene  <NA>     MCM2, BM28, …   553  -681    46     17 #000000 #BFFFBF
##  4 hsa:23… gene  <NA>     ORC6, ORC6L.…   494  -681    46     17 #000000 #BFFFBF
##  5 hsa:10… gene  <NA>     ANAPC10, APC…   981  -392    46     17 #000000 #BFFFBF
##  6 hsa:10… gene  <NA>     ANAPC10, APC…   981  -613    46     17 #000000 #BFFFBF
##  7 hsa:65… gene  <NA>     SKP1, EMC19,…   188  -613    46     17 #000000 #BFFFBF
##  8 hsa:65… gene  <NA>     SKP1, EMC19,…   432  -285    46     17 #000000 #BFFFBF
##  9 hsa:983 gene  <NA>     CDK1, CDC2, …   780  -562    46     17 #000000 #BFFFBF
## 10 hsa:701 gene  <NA>     BUB1B, BUB1b…   873  -392    46     17 #000000 #BFFFBF
## # ℹ 124 more rows
## # ℹ 8 more variables: graphics_type <chr>, coords <chr>, xmin <dbl>,
## #   xmax <dbl>, ymin <dbl>, ymax <dbl>, orig.id <chr>, pathway_id <chr>
## #
## # Edge Data: 157 × 6
##    from    to type  subtype_name    subtype_value pathway_id
##   <int> <int> <chr> <chr>           <chr>         <chr>
## 1   118    39 GErel expression      -->           hsa04110
## 2    50    61 PPrel inhibition      --|           hsa04110
## 3    50    61 PPrel phosphorylation +p            hsa04110
## # ℹ 154 more rows
```

The output can be analysed readily using `tidygraph` and `dplyr` verbs. For example, centrality calculations can be performed as follows.

```
graph |>
    mutate(degree=centrality_degree(mode="all"),
        betweenness=centrality_betweenness()) |>
    activate(nodes) |>
    filter(type=="gene") |>
    arrange(desc(degree)) |>
    as_tibble() |>
    relocate(degree, betweenness)
```

```
## # A tibble: 112 × 20
##    degree betweenness name        type  reaction graphics_name     x     y width
##     <dbl>       <dbl> <chr>       <chr> <chr>    <chr>         <dbl> <dbl> <dbl>
##  1     11       144   hsa:7157    gene  <NA>     TP53, BCC7, …   590  -337    46
##  2     10         8   hsa:993     gene  <NA>     CDC25A, CDC2…   614  -496    46
##  3      9         0   hsa:983     gene  <NA>     CDK1, CDC2, …   689  -562    46
##  4      9        78.7 hsa:5925    gene  <NA>     RB1, OSRC, P…   353  -630    46
##  5      8        15   hsa:5347    gene  <NA>     PLK1, PLK, S…   862  -562    46
##  6      8         7   hsa:1111 h… gene  <NA>     CHEK1, CHK1,…   696  -393    46
##  7      7         0   hsa:983     gene  <NA>     CDK1, CDC2, …   780  -562    46
##  8      7       161.  hsa:1026    gene  <NA>     CDKN1A, CAP2…   459  -407    46
##  9      7         5   hsa:994 hs… gene  <NA>     CDC25B...       830  -496    46
## 10      6         7   hsa:9088    gene  <NA>     PKMYT1, MYT1…   763  -622    46
## # ℹ 102 more rows
## # ℹ 11 more variables: height <dbl>, fgcolor <chr>, bgcolor <chr>,
## #   graphics_type <chr>, coords <chr>, xmin <dbl>, xmax <dbl>, ymin <dbl>,
## #   ymax <dbl>, orig.id <chr>, pathway_id <chr>
```

### 1.2.1 Plot the pathway using `ggraph`

The parsed `tbl_graph` can be used to plot the information by `ggraph` using the grammar of graphics. The components in the graph such as nodes, edges, and text can be plotted layer by layer.

```
graph <- graph |> mutate(showname=strsplit(graphics_name, ",") |>
                    vapply("[", 1, FUN.VALUE="a"))

ggraph(graph, layout="manual", x=x, y=y)+
    geom_edge_parallel(aes(color=subtype_name),
        arrow=arrow(length=unit(1,"mm"), type="closed"),
        end_cap=circle(1,"cm"),
        start_cap=circle(1,"cm"))+
    geom_node_rect(aes(fill=I(bgcolor),
                      filter=type == "gene"),
                  color="black")+
    geom_node_text(aes(label=showname,
                      filter=type == "gene"),
                  size=2)+
    theme_void()
```

![](data:image/png;base64...)

Besides the default ordering, various layout functions in `igraph` and `ggraph` can be used.

```
graph |> mutate(x=NULL, y=NULL) |>
ggraph(layout="nicely")+
    geom_edge_parallel(aes(color=subtype_name),
        arrow=arrow(length=unit(1,"mm"), type="closed"),
        end_cap=circle(0.1,"cm"),
        start_cap=circle(0.1,"cm"))+
    geom_node_point(aes(filter=type == "gene"),
                  color="black")+
    geom_node_point(aes(filter=type == "group"),
                  color="tomato")+
    geom_node_text(aes(label=showname,
                      filter=type == "gene"),
                  size=3, repel=TRUE, bg.colour="white")+
    scale_edge_color_viridis(discrete=TRUE)+
    theme_void()
```

![](data:image/png;base64...)

## 1.3 Converting identifiers

In the above example, `graphics_name` column in the node table were used, which are available in the default KGML file. Some of them are truncated, and the user can convert identifiers using `convert_id` function to be used in `mutate`. One can pipe the functions to convert `name` column consisting of `hsa` KEGG gene IDs in node table of `tbl_graph`.

```
graph |>
    activate(nodes) |>
    mutate(hsa=convert_id("hsa")) |>
    filter(type == "gene") |>
    as_tibble() |>
    relocate(hsa)
```

```
## # A tibble: 112 × 20
##    hsa     name    type  reaction graphics_name     x     y width height fgcolor
##    <chr>   <chr>   <chr> <chr>    <chr>         <dbl> <dbl> <dbl>  <dbl> <chr>
##  1 CDKN2A  hsa:10… gene  <NA>     CDKN2A, ARF,…   532  -218    46     17 #000000
##  2 FZR1    hsa:51… gene  <NA>     FZR1, CDC20C…   981  -630    46     17 #000000
##  3 MCM2    hsa:41… gene  <NA>     MCM2, BM28, …   553  -681    46     17 #000000
##  4 ORC6    hsa:23… gene  <NA>     ORC6, ORC6L.…   494  -681    46     17 #000000
##  5 ANAPC10 hsa:10… gene  <NA>     ANAPC10, APC…   981  -392    46     17 #000000
##  6 ANAPC10 hsa:10… gene  <NA>     ANAPC10, APC…   981  -613    46     17 #000000
##  7 SKP1    hsa:65… gene  <NA>     SKP1, EMC19,…   188  -613    46     17 #000000
##  8 SKP1    hsa:65… gene  <NA>     SKP1, EMC19,…   432  -285    46     17 #000000
##  9 CDK1    hsa:983 gene  <NA>     CDK1, CDC2, …   780  -562    46     17 #000000
## 10 BUB1B   hsa:701 gene  <NA>     BUB1B, BUB1b…   873  -392    46     17 #000000
## # ℹ 102 more rows
## # ℹ 10 more variables: bgcolor <chr>, graphics_type <chr>, coords <chr>,
## #   xmin <dbl>, xmax <dbl>, ymin <dbl>, ymax <dbl>, orig.id <chr>,
## #   pathway_id <chr>, showname <chr>
```

### 1.3.1 Highlighting set of nodes and edges

`highlight_set_nodes()` and `highlight_set_edges()` can be used to identify nodes that satisfy query IDs. Nodes often have multiple IDs, and user can choose `how="any"` (if one of identifiers in the nodes matches the query) or `how="all"` (if all of the identifiers in the nodes match the query) to highlight.

```
graph |>
    activate(nodes) |>
    mutate(highlight=highlight_set_nodes("hsa:7157")) |>
    ggraph(layout="manual", x=x, y=y)+
    geom_node_rect(aes(fill=I(bgcolor),
                      filter=type == "gene"), color="black")+
    geom_node_rect(aes(fill="tomato", filter=highlight), color="black")+
    geom_node_text(aes(label=showname,
                      filter=type == "gene"), size=2)+
    geom_edge_parallel(aes(color=subtype_name),
                   arrow=arrow(length=unit(1,"mm"),
                               type="closed"),
                   end_cap=circle(1,"cm"),
                   start_cap=circle(1,"cm"))+
    theme_void()
```

![](data:image/png;base64...)

### 1.3.2 Overlaying raw KEGG image

We can use `overlay_raw_map` to overlay the raw KEGG images on the created `ggraph`.
The node and text can be directly customized by using various geoms, effects such as `ggfx`, and scaling functions.
The code below creates nodes using default parsed background color and just overlay the image.

```
graph |>
    mutate(degree=centrality_degree(mode="all")) |>
    ggraph(graph, layout="manual", x=x, y=y)+
        geom_node_rect(aes(fill=degree,
                      filter=type == "gene"))+
        overlay_raw_map()+
        scale_fill_viridis_c()+
        theme_void()
```

![](data:image/png;base64...)

## 1.4 Module and Network

### 1.4.1 Parsing module

KEGG MODULE can be parsed and used in the analysis. The formula to obtain module is the same as pathway. Here, we use test pathway which contains two KEGG ORTHOLOGY, two compounds and one reaction.
This will create `kegg_module` class object storing definition and reactions.

```
mod <- module("M00002", use_cache=TRUE)
mod
```

```
## M00002
## Glycolysis, core module involving three-carbon compounds
```

### 1.4.2 Visualizing module

The module can be visualized by text-based or network-based, depicting how the KOs interact each other.
For text based visualization like the one shown in the original KEGG website, `module_text` can be used.

```
## Text-based
mod |>
    module_text() |> ## return data.frame
    plot_module_text()
```

![](data:image/png;base64...)

For network based visualization, `obtain_sequential_module_definition` can be used.

```
## Network-based
mod |>
    obtain_sequential_module_definition() |> ## return tbl_graph
    plot_module_blocks()
```

![](data:image/png;base64...)

We can assess module completeness, as well as user-defined module abundances. Please refer to [the module section of documentation](https://noriakis.github.io/software/ggkegg/module.html). The network can be created by the same way, and create `kegg_network` class object storing information.

### 1.4.3 Use with the other omics packages

The package supports direct importing and visualization, and investigation of the results of the other packages such as enrichment analysis results from `clusterProfiler` and differential expression analysis results from `DESeq2`. Pplease refer to [use cases](https://noriakis.github.io/software/ggkegg/usecases.html) in the documentation for more detailed use cases.

## 1.5 Wrapper function `ggkegg`

`ggkegg` function can be used with various input. For example, if the user provides pathway ID, the function automatically returns the `ggraph` with the original layout, which can be used directly for stacking geoms. The other supported IDs are module, network, and also the `enrichResult` object, and the other options such as converting IDs are available.

```
ggkegg("bpsp00270") |> class() ## Returns ggraph
```

```
## [1] "ggraph"          "ggplot2::ggplot" "ggplot"          "ggplot2::gg"
## [5] "S7_object"       "gg"
```

```
ggkegg("N00002") ## Returns the KEGG NETWORK plot
```

![](data:image/png;base64...)

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
## [1] dplyr_1.1.4      ggkegg_1.8.0     tidygraph_1.3.1  igraph_2.2.1
## [5] XML_3.99-0.19    ggraph_2.2.2     ggplot2_4.0.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6            xfun_0.53               bslib_0.9.0
##  [4] httr2_1.2.1             htmlwidgets_1.6.4       ggrepel_0.9.6
##  [7] vctrs_0.6.5             tools_4.5.1             generics_0.1.4
## [10] curl_7.0.0              tibble_3.3.0            RSQLite_2.4.3
## [13] blob_1.2.4              pkgconfig_2.0.3         data.table_1.17.8
## [16] dbplyr_2.5.1            RColorBrewer_1.1-3      S7_0.2.0
## [19] lifecycle_1.0.4         stringr_1.5.2           compiler_4.5.1
## [22] farver_2.1.2            tinytex_0.57            ggforce_0.5.0
## [25] graphlayouts_1.2.2      fontLiberation_0.1.0    fontquiver_0.2.1
## [28] htmltools_0.5.8.1       sass_0.4.10             yaml_2.3.10
## [31] pillar_1.11.1           jquerylib_0.1.4         tidyr_1.3.1
## [34] MASS_7.3-65             cachem_1.1.0            magick_2.9.0
## [37] viridis_0.6.5           fontBitstreamVera_0.1.1 tidyselect_1.2.1
## [40] digest_0.6.37           stringi_1.8.7           purrr_1.1.0
## [43] bookdown_0.45           labeling_0.4.3          shadowtext_0.1.6
## [46] polyclip_1.10-7         fastmap_1.2.0           grid_4.5.1
## [49] cli_3.6.5               magrittr_2.0.4          patchwork_1.3.2
## [52] utf8_1.2.6              dichromat_2.0-0.1       withr_3.0.2
## [55] gdtools_0.4.4           filelock_1.0.3          scales_1.4.0
## [58] rappdirs_0.3.3          bit64_4.6.0-1           rmarkdown_2.30
## [61] bit_4.6.0               gridExtra_2.3           memoise_2.0.1
## [64] evaluate_1.0.5          knitr_1.50              BiocFileCache_3.0.0
## [67] viridisLite_0.4.2       rlang_1.1.6             ggiraph_0.9.2
## [70] Rcpp_1.1.0              glue_1.8.0              DBI_1.2.3
## [73] tweenr_2.0.3            BiocManager_1.30.26     jsonlite_2.0.0
## [76] R6_2.6.1                systemfonts_1.3.1
```