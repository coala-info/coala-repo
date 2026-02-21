# Supporting data for geneplast evolutionary analyses

Leonardo RS Campos, Danilo O Imparato, Mauro AA Castro, Rodrigo JS Dalmolin

#### 28 February 2024

#### Abstract

The package geneplast.data provides datasets from different sources via AnnotationHub to use in geneplast pipelines. The datasets have species, phylogenetic trees, and orthology relationships among eukaryotes from different orthologs databases.

#### Package

geneplast.data 0.99.9

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
* [3 Objects creation](#objects-creation)
* [4 Working with custom data](#working-with-custom-data)
* [5 Case studies: Transfer rooting information to a PPI network](#case-studies-transfer-rooting-information-to-a-ppi-network)
  + [5.1 STRING](#string)
  + [5.2 OMA](#oma)
  + [5.3 OrthoDB](#orthodb)
* [6 Estimated computing time](#estimated-computing-time)
* [7 Session Information](#session-information)

# 1 Overview

[Geneplast](https://www.bioconductor.org/packages/release/bioc/html/geneplast.html)
is designed for large-scale evolutionary plasticity and rooting analysis based on
orthologs groups (OG) distribution in a given species tree.
This supporting package provides datasets obtained and processed from different
orthologs databases for geneplast evolutionary analyses.

Currently, data from the following sources are available:

* STRING (<https://string-db.org/>)
* OMA Browser (<https://omabrowser.org/>)
* OrthoDB (<https://www.orthodb.org/>)

Each dataset consists of four objects used as input for geneplast:

* **cogdata**. A `data.frame` mapping identifiers from OG and species to proteins/genes.
* **phyloTree**. A `phylo` object representing a phylogenetic tree where the tips’ labels correspond to each species identifiers from `cogdata`.
* **cogids**. A `data.frame` containing OG identifiers from *cogdata*.
* **sspids**. A `data.frame` with species identifiers from *cogdata*.

# 2 Quick start

Create a new `AnnotationHub` connection and query for all geneplast resources.

```
library('AnnotationHub')
ah <- AnnotationHub()
meta <- query(ah, "geneplast")
head(meta)
```

Load the objects into the session using the ID of the chosen dataset.

```
# Dataset derived from STRING database v11.0
load(meta[["AH83116"]])
```

# 3 Objects creation

The general procedure for creating previously described objects starts by selecting only eukaryotes from the orthologs database with [NCBI taxonomy](https://www.ncbi.nlm.nih.gov/taxonomy) classification.

We build a graph from taxonomy nodes and locate the root of eukaryotes. Then, we traverse this sub-graph from root to leaves corresponding to the taxonomy identifiers of the species in the database. By selecting the leaves of the resulting sub-graph, we obtain the `sspids` object.

Once the species of interest are selected, the orthology information of corresponding proteins is filtered to obtain the `cogdata` object.
The `cogids` object consists of unique orthologs identifiers from `cogdata`.

Finally, the `phyloTree` object is built from [TimeTree](http://www.timetree.org/) full eukaryotes phylogenetic tree, which is pruned to show only our species of interest. The missing species are filled using strategies of matching genera and the closest species inferred from NCBI’s tree previously built.

# 4 Working with custom data

Users are encouraged to use preprocessed datasets from `AnnotationHUB` since they’ve already been validated for `geneplast` analysis. However, it is possible to build customized datasets from any source of orthology information, provided they follow some requirements. This section presents an example with mock data on how to build the input data objects for `geneplast` package.

The minimal input set for running `geneplast` are: 1) a `data.frame` object **cogdata**, and 2) a `phylo` object **phyloTree**.

The `cogdata` table maps proteins to OGs and species, and must have at least three columns: 1) a protein identifier column **protein\_id**, 2) an OG identifier column **cog\_id**, and a species identifier column **ssp\_id**.

Suppose the user have collected orthology information between proteins from the following species:

```
species <- data.frame (
    label = c("sp01", "sp02", "sp03", "sp04", "sp05", "sp06", "sp07", "sp08", "sp09", "sp10", "sp11", "sp12", "sp13", "sp14", "sp15"),
                scientific_name = c("Homo sapiens", "Pan troglodytes", "Gorilla gorilla gorilla", "Macaca mulatta", "Papio anubis", "Rattus norvegicus", "Mus musculus", "Canis lupus familiaris", "Marmosa mexicana", "Monodelphis domestica", "Gallus gallus", "Meleagris gallopavo", "Xenopus tropicalis", "Latimeria chalumnae", "Danio rerio"),
                taxon_id = c("9606", "9598", "9595", "9544", "9555", "10116", "10090", "9615", "225402", "13616", "9031", "9103", "8364", "7897", "7955")
)
species
#>    label         scientific_name taxon_id
#> 1   sp01            Homo sapiens     9606
#> 2   sp02         Pan troglodytes     9598
#> 3   sp03 Gorilla gorilla gorilla     9595
#> 4   sp04          Macaca mulatta     9544
#> 5   sp05            Papio anubis     9555
#> 6   sp06       Rattus norvegicus    10116
#> 7   sp07            Mus musculus    10090
#> 8   sp08  Canis lupus familiaris     9615
#> 9   sp09        Marmosa mexicana   225402
#> 10  sp10   Monodelphis domestica    13616
#> 11  sp11           Gallus gallus     9031
#> 12  sp12     Meleagris gallopavo     9103
#> 13  sp13      Xenopus tropicalis     8364
#> 14  sp14     Latimeria chalumnae     7897
#> 15  sp15             Danio rerio     7955
```

The user’s dataset have 3 orthologous groups identified as: *OG1*, *OG2*, and *OG3*. The proteins whithin each OG are identified by a combination of a species label plus a protein ID (ex.: *“spXX.protXx”*).

```
og1 <- expand.grid(cog_id = "OG1",
                   protein_id = c(
    "sp01.prot1a", "sp01.prot1b", "sp01.prot1c", "sp01.prot1d", "sp01.prot1e", "sp01.prot1f", "sp01.prot1g",
    "sp02.prot1a", "sp02.prot1b", "sp02.prot1c", "sp02.prot1d", "sp02.prot1e", "sp02.prot1f",
    "sp03.prot1a", "sp03.prot1b", "sp03.prot1c",
    "sp04.prot1a", "sp04.prot1b", "sp04.prot1c", "sp04.prot1d",
    "sp05.prot1a", "sp05.prot1b", "sp05.prot1c", "sp05.prot1d", "sp05.prot1e",
    "sp06.prot1a", "sp06.prot1b",
    "sp07.prot1a", "sp07.prot1b", "sp07.prot1c",
    "sp08.prot1a", "sp08.prot1b",
    "sp11.prot1a", "sp11.prot1b", "sp11.prot1c",
    "sp12.prot1a", "sp12.prot1b", "sp12.prot1c",
    "sp13.prot1a", "sp13.prot1b",
    "sp14.prot1",
    "sp15.prot1a", "sp15.prot1b"
    )
)
og2 <- expand.grid(cog_id = "OG2",
                   protein_id = c(
    "sp01.prot2a", "sp01.prot2b", "sp01.prot2c", "sp01.prot2d", "sp01.prot2e", "sp01.prot2f",
    "sp02.prot2a", "sp02.prot2b", "sp02.prot2c",
    "sp03.prot2a", "sp03.prot2b", "sp03.prot2c", "sp03.prot2d",
    "sp04.prot2a", "sp04.prot2b", "sp04.prot2c",
    "sp05.prot2a", "sp05.prot2b", "sp05.prot2c", "sp05.prot2d",
    "sp06.prot2",
    "sp08.prot2a", "sp08.prot2b"
    )
)
og3 <- expand.grid(cog_id = "OG3",
                   protein_id = c(
    "sp01.prot3a", "sp01.prot3b", "sp01.prot3c", "sp01.prot3d",
    "sp02.prot3a", "sp02.prot3b", "sp02.prot3c",
    "sp03.prot3",
    "sp10.prot3"
    )
)
```

To build the **cogdata** object, the user should bind the OGs in a single `data.frame`. Furthermore, the required column **ssp\_id** must be added to the data frame. In the current example, this is done by splitting the species label from the **protein\_id** column and replacing it with the corresponding **taxon\_id** value.

```
library(tibble)
library(stringi)
library(dplyr)
#>
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#>
#>     filter, lag
#> The following objects are masked from 'package:base':
#>
#>     intersect, setdiff, setequal, union
# Bind OGs into a single object
cogdata <- rbind(og1, og2, og3)
# Create a dictionary to map species labels to taxon IDs
species_taxid_lookup <- species |> dplyr::select(label, taxon_id) |> tibble::deframe()
species_name_lookup <- species |> dplyr::select(taxon_id, scientific_name) |> tibble::deframe()
# Add the required ssp_id column
cogdata[["ssp_id"]] <- species_taxid_lookup[stri_split_fixed(cogdata[["protein_id"]], pattern = ".", n = 2, simplify = T)[,1]]
head(cogdata)
#>   cog_id  protein_id ssp_id
#> 1    OG1 sp01.prot1a   9606
#> 2    OG1 sp01.prot1b   9606
#> 3    OG1 sp01.prot1c   9606
#> 4    OG1 sp01.prot1d   9606
#> 5    OG1 sp01.prot1e   9606
#> 6    OG1 sp01.prot1f   9606
```

For users having OGs from standard outputs from orthology inference methods like OrthoFinder, we provide the `make.cogdata()` function to parse a tabular-separated (.tsv) file directly into the **cogdata** object.

```
library(geneplast.data)
cogdata <- geneplast.data::make.cogdata(file = "path/to/orthogroups.tsv")
```

To create the **phyloTree** object, the user can use the `make.phyloTree()` function provided by `geneplast.data` package. This function has two optional arguments (`sspids` and `newick`) that define its behavior depending on which one is provided.

Given a list of species’ NCBI Taxonomy IDs `sspids`, it builds a phylogenetic tree by merging the TimeTree and NCBI Taxonomy databases:

```
library(geneplast.data)
phyloTree <- geneplast.data::make.phyloTree(sspids = species$taxon_id)
#> -Building eukaryotes tree from sspids...
#> Joining with `by = join_by(taxid)`
#> -Loading full TimeTree species tree...
#> -Searching for missing taxa...
#> -Mapping taxon IDs and scientific names...
#> -NCBI tree created.
#> 1 missing taxa. Looking for the closest available taxa up in the hierarchy. This might take a while...-Grafting missing vertices...
#> -Grafted tree created.
#> -Eukaryotes tree created.
phyloTree
#>
#> Phylogenetic tree with 15 tips and 241 internal nodes.
#>
#> Tip labels:
#>   7955, 8364, 225402, 13616, 9615, 10116, ...
#> Node labels:
#>   2759, 33154, fix_15415, fix_15418, 33208, 6072, ...
#>
#> Rooted; no branch lengths.
```

Alternatively, the user could provide a `newick` file describing the species phylogenetic tree.
*Note: the tips’ labels from the custom newick tree should be listed in ‘cogdata’ object to properly perform the analysis.*

```
# Create from a user's predefined newick file
phyloTree <- geneplast.data::make.phyloTree(newick = "path/to/newick_tree.nwk")
```

Plot the resulting phylogenetic tree:

```
library(geneplast)
phyloTree <- geneplast:::rotatePhyloTree(phyloTree, "9606")
phyloTree$edge.length <- NULL
phyloTree$tip.label <- species_name_lookup[phyloTree$tip.label]
plot(phyloTree, type = "cladogram")
```

![](data:image/png;base64...)

**Figure 1.** *Sample phylogenetic tree built with `make.phyloTree()` function*.

# 5 Case studies: Transfer rooting information to a PPI network

This section reproduces a case study using STRING, OMA, and OrthoDB annotated datasets.

The following scripts run geneplast rooting analysis and transfer its results to a graph model. For detailed step-by-step instructions, please check the [geneplast vignette](https://www.bioconductor.org/packages/release/bioc/vignettes/geneplast/inst/doc/geneplast.html#map-rooting-information-on-ppi-networks).

## 5.1 STRING

```
library(geneplast)
ogr <- groot.preprocess(cogdata=cogdata, phyloTree=phyloTree, spid="9606")
ogr <- groot(ogr, nPermutations=1, verbose=TRUE)

library(RedeR)
library(igraph)
library(RColorBrewer)
data(ppi.gs)
g <- ogr2igraph(ogr, cogdata, ppi.gs, idkey = "ENTREZ")
pal <- brewer.pal(9, "RdYlBu")
color_col <- colorRampPalette(pal)(37) #set a color for each root!
g <- att.setv(g=g, from="Root", to="nodeColor", cols=color_col, na.col = "grey80", breaks = seq(1,37))
g <- att.setv(g = g, from = "SYMBOL", to = "nodeAlias")
E(g)$edgeColor <- "grey80"
V(g)$nodeLineColor <- "grey80"
rdp <- RedPort()
calld(rdp)
resetd(rdp)
addGraph(rdp, g)
addLegend.color(rdp, colvec=g$legNodeColor$scale, size=15, labvec=g$legNodeColor$legend, title="Roots inferred from geneplast")
g1  <- induced_subgraph(g=g, V(g)$name[V(g)$Apoptosis==1])
g2  <- induced_subgraph(g=g, V(g)$name[V(g)$GenomeStability==1])
myTheme <- list(nestFontSize=25, zoom=80, isNest=TRUE, gscale=65, theme=2)
addGraph(rdp, g1, gcoord=c(25, 50), theme = c(myTheme, nestAlias="Apoptosis"))
addGraph(rdp, g2, gcoord=c(75, 50), theme = c(myTheme, nestAlias="Genome Stability"))
relax(rdp, p1=50, p2=50, p3=50, p4=50, p5= 50, ps = TRUE)
```

![title](data:image/png;base64...)
**Figure 2.** *Inferred evolutionary roots of a protein-protein interaction network*.

## 5.2 OMA

```
load(meta[["AH83117"]])
cogdata$cog_id <- paste0("OMA", cogdata$cog_id)
cogids$cog_id <- paste0("OMA", cogids$cog_id)

human_entrez_2_oma_Aug2020 <- read_delim("processed_human.entrez_2_OMA.Aug2020.tsv",
    delim = "\t", escape_double = FALSE,
    col_names = FALSE, trim_ws = TRUE)
names(human_entrez_2_oma_Aug2020) <- c("protein_id", "gene_id")
cogdata <- cogdata %>% left_join(human_entrez_2_oma_Aug2020)
ogr <- groot.preprocess(cogdata=cogdata, phyloTree=phyloTree, spid="9606")
ogr <- groot(ogr, nPermutations=1, verbose=TRUE)

g <- ogr2igraph(ogr, cogdata, ppi.gs, idkey = "ENTREZ")
pal <- brewer.pal(9, "RdYlBu")
color_col <- colorRampPalette(pal)(37) #set a color for each root!
g <- att.setv(g=g, from="Root", to="nodeColor", cols=color_col, na.col = "grey80", breaks = seq(1,37))
g <- att.setv(g = g, from = "SYMBOL", to = "nodeAlias")
E(g)$edgeColor <- "grey80"
V(g)$nodeLineColor <- "grey80"
# rdp <- RedPort()
# calld(rdp)
resetd(rdp)
addGraph(rdp, g)
addLegend.color(rdp, colvec=g$legNodeColor$scale, size=15, labvec=g$legNodeColor$legend, title="Roots inferred from geneplast")
g1  <- induced_subgraph(g=g, V(g)$name[V(g)$Apoptosis==1])
g2  <- induced_subgraph(g=g, V(g)$name[V(g)$GenomeStability==1])
myTheme <- list(nestFontSize=25, zoom=80, isNest=TRUE, gscale=65, theme=2)
addGraph(rdp, g1, gcoord=c(25, 50), theme = c(myTheme, nestAlias="Apoptosis"))
addGraph(rdp, g2, gcoord=c(75, 50), theme = c(myTheme, nestAlias="Genome Stability"))
relax(rdp, p1=50, p2=50, p3=50, p4=50, p5= 50, ps = TRUE)
```

![](data:image/png;base64...)

title

## 5.3 OrthoDB

```
load(meta[["AH83118"]])
cogdata$cog_id <- paste0("ODB", cogdata$cog_id)
cogids$cog_id <- paste0("ODB", cogids$cog_id)

human_entrez_2_odb <- read_delim("odb10v1_genes-human-entrez.tsv",
    delim = "\t", escape_double = FALSE,
    col_names = FALSE, trim_ws = TRUE)
names(human_entrez_2_odb) <- c("protein_id", "gene_id")
cogdata <- cogdata %>% left_join(human_entrez_2_odb)
ogr <- groot.preprocess(cogdata=cogdata, phyloTree=phyloTree, spid="9606")
ogr <- groot(ogr, nPermutations=1, verbose=TRUE)

g <- ogr2igraph(ogr, cogdata, ppi.gs, idkey = "ENTREZ")
pal <- brewer.pal(9, "RdYlBu")
color_col <- colorRampPalette(pal)(37) #set a color for each root!
g <- att.setv(g=g, from="Root", to="nodeColor", cols=color_col, na.col = "grey80", breaks = seq(1,37))
g <- att.setv(g = g, from = "SYMBOL", to = "nodeAlias")
E(g)$edgeColor <- "grey80"
V(g)$nodeLineColor <- "grey80"
rdp <- RedPort()
calld(rdp)
resetd(rdp)
addGraph(rdp, g)
addLegend.color(rdp, colvec=g$legNodeColor$scale, size=15, labvec=g$legNodeColor$legend, title="Roots inferred from geneplast")
g1  <- induced_subgraph(g=g, V(g)$name[V(g)$Apoptosis==1])
g2  <- induced_subgraph(g=g, V(g)$name[V(g)$GenomeStability==1])
myTheme <- list(nestFontSize=25, zoom=80, isNest=TRUE, gscale=65, theme=2)
addGraph(rdp, g1, gcoord=c(25, 50), theme = c(myTheme, nestAlias="Apoptosis"))
addGraph(rdp, g2, gcoord=c(75, 50), theme = c(myTheme, nestAlias="Genome Stability"))
relax(rdp, p1=50, p2=50, p3=50, p4=50, p5= 50, ps = TRUE)
```

![](data:image/png;base64...)

title

# 6 Estimated computing time

This section presents elapsed times (ET) for *geneplast* rooting analysis of all OG from *H. sapiens* within different datasets (STRING, OMA, and OrthoDB). We used default values when calling the functions `groot.preprocess` and `groot`. The elapsed times were calculated by the difference of timestamps using [tictoc](https://cran.r-project.org/web/packages/tictoc/index.html) library.

```
library(AnnotationHub)
library(dplyr)
library(geneplast)
library(tictoc)

ah <- AnnotationHub()
meta <- query(ah, "geneplast")
load(meta[["AH83116"]])
writeLines(paste("geneplast input data loaded from", meta["AH83116"]$title))

tic("total time")
tic("preprocessing")
ogr <- groot.preprocess(cogdata=cogdata, phyloTree=phyloTree, spid="9606")
toc()
tic("rooting")
ogr <- groot(ogr)
toc()
toc()
```

We performed all runs on a desktop computer with the following specification:

* CPU: Intel Core i7 @ 2.80GHz (7th gen.)
* RAM: 16 GB
* Disk: Samsung SSD 970 EVO (NVMe)

**Table 1.** *Elapsed times for preprocessing and rooting all human orthologs within different datasets*.

| Dataset ID | Source | Species count | OG count | ET (prep.) | ET (rooting) | ET (total) |
| --- | --- | --- | --- | --- | --- | --- |
| AH83116 | STRING | 476 | 7702 | 6 min 22 sec | 10 min 50 sec | 17 min 12 sec |
| AH83117 | OMA | 485 | 19614 | 7 min 46 sec | 26 min 58 sec | 34 min 45 sec |
| AH83118 | OrthoDB | 1271 | 10557 | 19 min 3 sec | 13 min 41 sec | 32 min 44 sec |

# 7 Session Information

```
sessionInfo()
#> R Under development (unstable) (2024-01-16 r85808)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 22.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.19-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] geneplast_1.29.0      geneplast.data_0.99.9 dplyr_1.1.4
#> [4] stringi_1.8.3         tibble_3.2.1          BiocStyle_2.31.0
#>
#> loaded via a namespace (and not attached):
#>  [1] xfun_0.42            bslib_0.6.1          lattice_0.22-5
#>  [4] tzdb_0.4.0           vctrs_0.6.5          tools_4.4.0
#>  [7] generics_0.1.3       yulab.utils_0.1.4    curl_5.2.0
#> [10] parallel_4.4.0       fansi_1.0.6          RSQLite_2.3.5
#> [13] highr_0.10           blob_1.2.4           pkgconfig_2.0.3
#> [16] data.table_1.15.0    dbplyr_2.4.0         lifecycle_1.0.4
#> [19] compiler_4.4.0       treeio_1.27.0        htmltools_0.5.7
#> [22] snow_0.4-4           sass_0.4.8           yaml_2.3.8
#> [25] lazyeval_0.2.2       pillar_1.9.0         crayon_1.5.2
#> [28] jquerylib_0.1.4      tidyr_1.3.1          cachem_1.0.8
#> [31] magick_2.8.3         nlme_3.1-164         tidyselect_1.2.0
#> [34] digest_0.6.34        purrr_1.0.2          bookdown_0.37
#> [37] fastmap_1.1.1        grid_4.4.0           archive_1.1.7
#> [40] cli_3.6.2            magrittr_2.0.3       utf8_1.2.4
#> [43] ape_5.7-1            readr_2.1.5          withr_3.0.0
#> [46] filelock_1.0.3       bit64_4.0.5          rmarkdown_2.25
#> [49] httr_1.4.7           igraph_2.0.2         bit_4.0.5
#> [52] hms_1.1.3            memoise_2.0.1        evaluate_0.23
#> [55] knitr_1.45           BiocFileCache_2.11.1 rlang_1.1.3
#> [58] Rcpp_1.0.12          glue_1.7.0           tidytree_0.4.6
#> [61] DBI_1.2.2            BiocManager_1.30.22  vroom_1.6.5
#> [64] jsonlite_1.8.8       R6_2.5.1             fs_1.6.3
```