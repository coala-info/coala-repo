# netOmics

Antoine Bodein1\*, Marie-Pier Scott-Boyer1, Olivier Perin2, Kim-Anh Lê Cao3 and Arnaud Droit1

1CHU de Québec Research Center, Université Laval, Molecular Medicine department, Québec, QC, Canada
2Digital Sciences Department, L’Oréal Advanced Research, Aulnay-sous-bois, France
3Melbourne Integrative Genomics, School of Mathematics and Statistics, University of Melbourne, Melbourne, VIC, Australia

\*antoine.bodein.1@ulaval.ca

#### 26 October 2021

#### Package

netOmics 1.0.0

# Contents

* [1 Requirements](#requirements)
* [2 Case Study: Human Microbiome Project T2D](#case-study-human-microbiome-project-t2d)
* [3 (optional: *timeOmics* analysis)](#optional-timeomics-analysis)
* [4 Network building](#network-building)
  + [4.1 Inference Network](#inference-network)
  + [4.2 Interaction from databases](#interaction-from-databases)
  + [4.3 Other inference methods](#other-inference-methods)
  + [4.4 Other examples](#other-examples)
* [5 Layer merging](#layer-merging)
  + [5.1 Merging with interactions](#merging-with-interactions)
  + [5.2 Merging with correlations](#merging-with-correlations)
* [6 Addition of supplemental layers](#addition-of-supplemental-layers)
  + [6.1 Over Representation Analysis](#over-representation-analysis)
  + [6.2 External knowledge](#external-knowledge)
* [7 Network exploration](#network-exploration)
  + [7.1 Basics network exploration](#basics-network-exploration)
  + [7.2 Random walk with restart](#random-walk-with-restart)
    - [7.2.1 Find vertices with specific attributes](#find-vertices-with-specific-attributes)
    - [7.2.2 Function prediction](#function-prediction)
* [References](#references)

The emergence of multi-omics data enabled the development of
integration methods.

With netOmics, we go beyond integration by introducing an interpretation tool.
netOmics is a package for the creation and exploration of multi-omics networks.

Depending on the provided dataset, it allows to create inference networks from
expression data but also interaction networks from knowledge databases.
After merging the sub-networks to obtain a global multi-omics network,
we propose network exploration methods using propoagation techniques to perform
functional prediction or identification of molecular mechanisms.

Furthermore, the package has been developed for longitudinal multi-omics data
and can be used in conjunction with our previously published package timeOmics.

![Overview](data:image/png;base64...)

Overview

For more informnation about the method, please check (Bodein et al. [2020](#ref-bodein2020interpretation))

In this vignette, we introduced a case study which depict the main steps to
create and explore multi-omics networks from multi-omics time-course data.

# 1 Requirements

```
# install the package via BioConductor
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("netOmics")
```

```
# install the package via github
library(devtools)
install_github("abodein/netOmics")
```

```
# load the package
library(netOmics)
```

```
# usefull packages to build this vignette
library(timeOmics)
library(tidyverse)
library(igraph)
```

# 2 Case Study: Human Microbiome Project T2D

The package will be illustrated on longitudinal MO dataset to study
the seasonality of MO expression in patients with diabetes (Sailani et al. [2020](#ref-sailani2020deep)).

The data used in this vignette is a subset of the data available at:
<https://github.com/aametwally/ipop_seasonal>

We focused on a single individual with 7 timepoints.
6 different omics were sampled
(RNA, proteins, cytokines, gut microbiome, metabolites and clinical variables).

```
# load data
data("hmp_T2D")
```

# 3 (optional: *timeOmics* analysis)

The first step of the analysis is the preprocessing and longitudinal clustering.
This step is carried out with timeOmics and should be reserved for longitudinal
data.

It ensures that the time profiles are classified into groups of similar profiles
so each MO molecule is labbeled with its cluster.

In addition, timeOmics can identify a multi-omics signature of the clusters.
These molecules can be, for example, the starting points of the propogation
analysis.

For more informations about *timeOmics*, please
check <http://www.bioconductor.org/packages/release/bioc/html/timeOmics.html>

As illustrated in the R chunk below the timeOmics step includes:

* omic-specific preprocessing and longitudinal fold-change filtering
* modelling of expression profiles
* clustering of MO expression profiles
* signature identification by cluster

```
# not evaluated in this vignette

#1 filter fold-change
remove.low.cv <- function(X, cutoff = 0.5){
    # var.coef
    cv <- unlist(lapply(as.data.frame(X),
                    function(x) abs(sd(x, na.rm = TRUE)/mean(x, na.rm= TRUE))))
    return(X[,cv > cutoff])
}
fc.threshold <- list("RNA"= 1.5, "CLINICAL"=0.2, "GUT"=1.5, "METAB"=1.5,
                     "PROT" = 1.5, "CYTO" = 1)

# --> hmp_T2D$raw
data.filter <- imap(raw, ~{remove.low.cv(.x, cutoff = fc.threshold[[.y]])})

#2 scale
data <- lapply(data.filter, function(x) log(x+1))
# --> hmp_T2D$data

#3 modelling
lmms.func <- function(X){
    time <- rownames(X) %>% str_split("_") %>%
      map_chr(~.x[[2]]) %>% as.numeric()
    lmms.output <- lmms::lmmSpline(data = X, time = time,
                                   sampleID = rownames(X), deri = FALSE,
                                   basis = "p-spline", numCores = 4,
                                   keepModels = TRUE)
    return(lmms.output)
}
data.modelled <- lapply(data, function(x) lmms.func(x))

# 4 clustering
block.res <- block.pls(data.modelled, indY = 1, ncomp = 1)
getCluster.res <- getCluster(block.res)
# --> hmp_T2D$getCluster.res

# 5 signature
list.keepX <- list("CLINICAL" = 4, "CYTO" = 3, "GUT" = 10, "METAB" = 3,
                   "PROT" = 2,"RNA" = 34)
sparse.block.res  <- block.spls(data.modelled, indY = 1, ncomp = 1, scale =TRUE,
                                keepX =list.keepX)
getCluster.sparse.res <- getCluster(sparse.block.res)
# --> hmp_T2D$getCluster.sparse.res
```

timeOmics resulted in 2 clusters, labelled `1` and `-1`

```
# clustering results
cluster.info <- hmp_T2D$getCluster.res
```

# 4 Network building

Each layer of the network is built sequentially and then assembled
in a second section.

All the functions in the package can be used on one element or a list of
elements.
In the longitudinal context of the data, kinetic cluster sub-networks are built
plus a global network
(`1`, `-1` and `All`).

## 4.1 Inference Network

Multi-omics network building starts with a first layer of gene.
Currently, the ARACNe algorithm handles the inference but we will include more
algorithms in the future.

The function `get_grn` return a Gene Regulatory Network from gene expression
data.
Optionally, the user can provide a timeOmics clustering result (`?getCluster`)
to get cluster specific sub-networks. In this case study, this will
automatically build the networks (`1`, `-1` and `All`), as indicated previously.

The `get_graph_stats` function provides basic graph statistics such as the
number of vertices and edges.
If the vertices have different attributes, it also includes a summary of these.

```
cluster.info.RNA <- timeOmics::getCluster(cluster.info, user.block = "RNA")
graph.rna <- get_grn(X = hmp_T2D$data$RNA, cluster = cluster.info.RNA)

# to get info about the network
get_graph_stats(graph.rna)
```

```
##     node.c node.i  edge edge.density type:gene mode:core cluster:-1 cluster:1
## All    759     16 70539    0.2351888       775       775        610       165
## 1      155     10  2922    0.2159645       165       165         NA       165
## -1     595     15 61000    0.3284072       610       610        610        NA
```

## 4.2 Interaction from databases

As for the genes, the second layer is a protein layer (Protein-Protein
Interaction).
This time, no inference is performed. Instead, known interactions are extracted
from a database of interaction (BIOGRID).

The function `get_interaction_from_database` will fetch the interactions from a
database provided as a `data.frame` (with columns `from` and `to`) or a graph
(`igraph` object).
In addition to the interactions between the indicated molecules, the first
degree neighbors can also be collected (option `user.ego = TRUE`)

```
# Utility function to get the molecules by cluster
get_list_mol_cluster <- function(cluster.info, user.block){
  require(timeOmics)
    tmp <- timeOmics::getCluster(cluster.info, user.block)
    res <- tmp %>% split(.$cluster) %>%
        lapply(function(x) x$molecule)
    res[["All"]] <- tmp$molecule
    return(res)
}

cluster.info.prot <- get_list_mol_cluster(cluster.info, user.block = 'PROT')
graph.prot <-  get_interaction_from_database(X = cluster.info.prot,
                                             db = hmp_T2D$interaction.biogrid,
                                             type = "PROT", user.ego = TRUE)
# get_graph_stats(graph.prot)
```

In this example, only a subset of the Biogrid database is used
(matching elements).

## 4.3 Other inference methods

Another way to compute networks from expression data is to use other inference
methods.
In the following chunk, we intend to illustrate the use of the SparCC algorithm
(Friedman and Alm [2012](#ref-friedman2012inferring)) on the gut data and how it can be integrate into the
pipeline.
(sparcc is not included in this package)

```
# not evaluated in this vignette
library(SpiecEasi)

get_sparcc_graph <- function(X, threshold = 0.3){
    res.sparcc <- sparcc(data = X)
    sparcc.graph <- abs(res.sparcc$Cor) >= threshold
    colnames(sparcc.graph) <-  colnames(X)
    rownames(sparcc.graph) <-  colnames(X)
    res.graph <- graph_from_adjacency_matrix(sparcc.graph,
                                             mode = "undirected") %>% simplify
    return(res.graph)
}

gut_list <- get_list_mol_cluster(cluster.info, user.block = 'GUT')

graph.gut <- list()
graph.gut[["All"]] <- get_sparcc_graph(hmp_T2D$raw$GUT, threshold = 0.3)
graph.gut[["1"]] <- get_sparcc_graph(hmp_T2D$raw$GUT %>%
                                       dplyr::select(gut_list[["1"]]),
                                     threshold = 0.3)
graph.gut[["-1"]] <- get_sparcc_graph(hmp_T2D$raw$GUT %>%
                                        dplyr::select(gut_list[["-1"]]),
                                      threshold = 0.3)
class(graph.gut) <- "list.igraph"
```

```
graph.gut <- hmp_T2D$graph.gut
# get_graph_stats(graph.gut)
```

## 4.4 Other examples

For this case study, we complete this first step of network building with the
missing layers.

```
# CYTO -> from database (biogrid)
cyto_list = get_list_mol_cluster(cluster.info = cluster.info,
                                 user.block = "CYTO")
graph.cyto <-  get_interaction_from_database(X = cyto_list,
                                             db = hmp_T2D$interaction.biogrid,
                                             type = "CYTO", user.ego = TRUE)
# get_graph_stats(graph.cyto)

# METAB -> inference
cluster.info.metab <-  timeOmics::getCluster(X = cluster.info,
                                             user.block = "METAB")
graph.metab <-  get_grn(X = hmp_T2D$data$METAB,
                        cluster = cluster.info.metab)
# get_graph_stats(graph.metab)

# CLINICAL -> inference
cluster.info.clinical <- timeOmics::getCluster(X = cluster.info,
                                               user.block = 'CLINICAL')
graph.clinical <- get_grn(X = hmp_T2D$data$CLINICAL,
                          cluster = cluster.info.clinical)
# get_graph_stats(graph.clinical)
```

# 5 Layer merging

We included 2 types of layer merging:

* *merging with interactions* uses the shared elements between 2 graphs to build
  a larger network.
* *merging with correlations* uses the spearman correlation from expression
  profiles between 2 layers when any interaction is known.

## 5.1 Merging with interactions

The function `combine_layers` enables the fusion of different network layers.
It combines the network (or list of network) in `graph1` with the network
(or list of network) in `graph2`, based on the shared vertices between
the networks.

Additionally, the user can provide an interaction table `interaction.df`
(in the form of a data.frame or igraph object).

In the following chunk, we sequentially merge RNA, PROT and CYTO layers and uses
the TFome information (TF protein -> Target Gene) to connect these layers.

```
full.graph <- combine_layers(graph1 = graph.rna, graph2 = graph.prot)
full.graph <- combine_layers(graph1 = full.graph, graph2 = graph.cyto)

full.graph <- combine_layers(graph1 = full.graph,
                             graph2 = hmp_T2D$interaction.TF)
# get_graph_stats(full.graph)
```

## 5.2 Merging with correlations

To connect omics layers for which no interaction information is available,
we propose to use a threshold on the correlation between the expression profiles
of two or more omics data.

The strategy is as follows: we isolate the omics from the data and calculate
the correlations between this omics and the other data.

```
all_data <- reduce(hmp_T2D$data, cbind)

# omic = gut
gut_list <- get_list_mol_cluster(cluster.info, user.block = "GUT")
omic_data <- lapply(gut_list, function(x)dplyr::select(hmp_T2D$data$GUT, x))
```

```
## Note: Using an external vector in selections is ambiguous.
## ℹ Use `all_of(x)` instead of `x` to silence this message.
## ℹ See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
## This message is displayed once per session.
```

```
# other data = "RNA", "PROT", "CYTO"
other_data_list <- get_list_mol_cluster(cluster.info,
                                        user.block = c("RNA", "PROT", "CYTO"))
other_data <- lapply(other_data_list, function(x)dplyr::select(all_data, x))

# get interaction between gut data and other data
interaction_df_gut <- get_interaction_from_correlation(X = omic_data,
                                                       Y = other_data,
                                                       threshold = 0.99)

# and merge with full graph
full.graph <- combine_layers(graph1 = full.graph,
                             graph2 = graph.gut,
                             interaction.df = interaction_df_gut$All)
```

```
# omic =  Clinical
clinical_list <- get_list_mol_cluster(cluster.info, user.block = "CLINICAL")
omic_data <- lapply(clinical_list,
                    function(x)dplyr::select(hmp_T2D$data$CLINICAL, x))

# other data = "RNA", "PROT", "CYTO", "GUT"
other_data_list <- get_list_mol_cluster(cluster.info,
                                        user.block = c("RNA", "PROT",
                                                       "CYTO", "GUT"))
other_data <- lapply(other_data_list, function(x)dplyr::select(all_data, x))

# get interaction between gut data and other data
interaction_df_clinical <- get_interaction_from_correlation(X = omic_data
                                                            , Y = other_data,
                                                            threshold = 0.99)

# and merge with full graph
full.graph <- combine_layers(graph1 = full.graph,
                             graph2 = graph.clinical,
                             interaction.df = interaction_df_clinical$All)
```

```
# omic =  Metab
metab_list <- get_list_mol_cluster(cluster.info, user.block = "METAB")
omic_data <- lapply(metab_list, function(x)dplyr::select(hmp_T2D$data$METAB, x))

# other data = "RNA", "PROT", "CYTO", "GUT", "CLINICAL"
other_data_list <- get_list_mol_cluster(cluster.info,
                                        user.block = c("RNA", "PROT", "CYTO",
                                                       "GUT", "CLINICAL"))
other_data <- lapply(other_data_list, function(x)dplyr::select(all_data, x))

# get interaction between gut data and other data
interaction_df_metab <- get_interaction_from_correlation(X = omic_data,
                                                         Y = other_data,
                                                         threshold = 0.99)

# and merge with full graph
full.graph <- combine_layers(graph1 = full.graph,
                             graph2 = graph.metab,
                             interaction.df = interaction_df_metab$All)
```

# 6 Addition of supplemental layers

For the interpretation of the MO integration results, the use of additional
information layers or molecules can be useful to enrich the network.

## 6.1 Over Representation Analysis

ORA is a common step to include knowledge.
The function `get_interaction_from_ORA` perform the ORA analysis from the
desired molecules and return an interaction graph with the enriched terms and
the corresponding molecules.

Then, the interaction graph with the new vertices can be linked to the network
as illustrated in the previous step.

Here, ORA was performed with RNA, PROT, and CYTO against the Gene Ontology.

```
# ORA by cluster/All
mol_ora <- get_list_mol_cluster(cluster.info,
                                user.block = c("RNA", "PROT", "CYTO"))

# get ORA interaction graph by cluster
graph.go <- get_interaction_from_ORA(query = mol_ora,
                                     sources = "GO",
                                     organism = "hsapiens",
                                     signif.value = TRUE)

# merge
full.graph <- combine_layers(graph1 = full.graph, graph2 = graph.go)
```

## 6.2 External knowledge

Additionally, knowledge from external sources can be included in the network.

In the following chunk, we performed disease-related gene enrichment analysis
from *medlineRanker* (<http://cbdm-01.zdv.uni-mainz.de/~jfontain/cms/?page_id=4>).
We converted the results into a data.frame (with the columns `from` and `to`)
and this acted as an interaction database.

```
# medlineRanker -> database
medlineranker.res.df <- hmp_T2D$medlineranker.res.df %>%
  dplyr::select(Disease, symbol) %>%
  set_names(c("from", "to"))

mol_list <-  get_list_mol_cluster(cluster.info = cluster.info,
                                  user.block = c("RNA", "PROT", "CYTO"))
graph.medlineranker <-  get_interaction_from_database(X = mol_list,
                                                      db = medlineranker.res.df,
                                                      type = "Disease",
                                                      user.ego = TRUE)
# get_graph_stats(graph.medlineranker)

# merging
full.graph <- combine_layers(graph1 = full.graph, graph2 = graph.medlineranker)
```

We complete the MO network preparation with attribute cleaning and addition of
several attributes such as:

* mode = “core” if the vertex was originally present in the data; “extended”
  otherwise
* sparse = TRUE if the vertex was present in kinetic cluster signature; FALSE
  otherwise
* type = type of omics (“RNA”,“PROT”,“CLINICAL”,“CYTO”,“GUT”,“METAB”,“GO”,
  “Disease”)
* cluster = ‘1’, ‘-1’ or ‘NA’ (for vertices not originally present in the
  original data)

```
# graph cleaning
graph_cleaning <- function(X, cluster.info){
    # no reusability
    X <- igraph::simplify(X)
    va <- vertex_attr(X)
    viewed_mol <- c()
    for(omic in unique(cluster.info$block)){
        mol <- intersect(cluster.info %>% dplyr::filter(.$block == omic) %>%
                           pull(molecule), V(X)$name)
        viewed_mol <- c(viewed_mol, mol)
        X <- set_vertex_attr(graph = X,
                             name = "type",
                             index = mol,
                             value = omic)
        X <- set_vertex_attr(graph = X,
                             name = "mode",
                             index = mol,
                             value = "core")
    }
    # add medline ranker and go
    mol <- intersect(map(graph.go, ~ as_data_frame(.x)$to) %>%
                       unlist %>% unique(), V(X)$name) # only GO terms
    viewed_mol <- c(viewed_mol, mol)
    X <- set_vertex_attr(graph = X, name = "type", index = mol, value = "GO")
    X <- set_vertex_attr(graph = X, name = "mode",
                         index = mol, value = "extended")

    mol <- intersect(as.character(medlineranker.res.df$from), V(X)$name)
    viewed_mol <- c(viewed_mol, mol)
    X <- set_vertex_attr(graph = X, name = "type",
                         index = mol, value = "Disease")
    X <- set_vertex_attr(graph = X, name = "mode",
                         index = mol, value = "extended")

    other_mol <- setdiff(V(X), viewed_mol)
    if(!is_empty(other_mol)){
        X <- set_vertex_attr(graph = X, name = "mode",
                             index = other_mol, value = "extended")
    }
    X <- set_vertex_attr(graph = X, name = "mode",
                         index = intersect(cluster.info$molecule, V(X)$name),
                         value = "core")

    # signature
    mol <-  intersect(V(X)$name, hmp_T2D$getCluster.sparse.res$molecule)
    X <- set_vertex_attr(graph = X, name = "sparse", index = mol, value = TRUE)
    mol <-  setdiff(V(X)$name, hmp_T2D$getCluster.sparse.res$molecule)
    X <- set_vertex_attr(graph = X, name = "sparse", index = mol, value = FALSE)

    return(X)
}
```

```
FULL <- lapply(full.graph, function(x) graph_cleaning(x, cluster.info))
get_graph_stats(FULL)
```

```
##     node.c node.i  edge edge.density cluster:-1 cluster:1 type:CLINICAL
## All   2036    123 88166   0.03784662        681       238            39
## 1      493     76  5448   0.03371371         NA       238            18
## -1    1667     69 61475   0.04082060        681        NA            22
##     type:CYTO type:Disease type:GO type:GUT type:METAB type:PROT type:RNA
## All        37          178      96       58        105       871      775
## 1          14          110      20       33         56       149      169
## -1         24          174      63       25         49       758      621
##     mode:core mode:extended sparse:FALSE sparse:TRUE
## All      1008          1151         2055         104
## 1         290           279          525          44
## -1        738           998         1676          60
```

# 7 Network exploration

## 7.1 Basics network exploration

We can use basic graph statistics to explore the network such as degree
distribution, modularity, and short path.

```
# degree analysis
d <- degree(FULL$All)
hist(d)
d[max(d)]

# modularity # Warnings: can take several minutes
res.mod <- walktrap.community(FULL$All)
# ...

# modularity
sp <- shortest.paths(FULL$All)
```

## 7.2 Random walk with restart

RWR is a powerful tool to explore the MO networks which simulates a particle
that randomly walk on the network.
From a starting point (`seed`) it ranks the other vertices based on their
proximity with the seed and the network structure.

We use RWR for function prediction and molecular mechanism identification.

In the example below, the seeds were the GO terms vertices.

```
# seeds = all vertices -> takes 5 minutes to run on regular computer
# seeds <- V(FULL$All)$name
# rwr_res <- random_walk_restart(FULL, seeds)

# seed = some GO terms
seeds <- head(V(FULL$All)$name[V(FULL$All)$type == "GO"])
rwr_res <- random_walk_restart(FULL, seeds)
```

### 7.2.1 Find vertices with specific attributes

After the RWR analysis, we implemented several functions to extract valuable
information.

To identify MO molecular functions, the seed can be a GO term and we are
interested to identify vertices with different omics type within the
closest nodes.

The function `rwr_find_seeds_between_attributes` can identify which seeds were
able to reach vertices with different attributes (ex: `type`) within the
closest `k` (ex: `15`) vertices.

The function `summary_plot_rwr_attributes` displays the number of different
values for a seed attribute as a bar graph.

```
rwr_type_k15 <- rwr_find_seeds_between_attributes(X = rwr_res,
                                                  attribute = "type", k = 15)

# a summary plot function
summary_plot_rwr_attributes(rwr_type_k15)
```

![](data:image/png;base64...)

```
summary_plot_rwr_attributes(rwr_type_k15$All)
```

![](data:image/png;base64...)

Alternatively, we can be interested to find functions or molecules which
link different kinetic cluster (to find regulatory mechanisms).

```
rwr_type_k15 <- rwr_find_seeds_between_attributes(X = rwr_res$All,
                                                  attribute = "cluster", k = 15)
summary_plot_rwr_attributes(rwr_type_k15)
```

![](data:image/png;base64...)

A RWR subnetworks can also be displayed with `plot_rwr_subnetwork`
from a specific seed.

```
sub_res <- rwr_type_k15$`GO:0005737`
sub <- plot_rwr_subnetwork(sub_res, legend = TRUE, plot = TRUE)
```

![](data:image/png;base64...)

### 7.2.2 Function prediction

Finally, RWR can also be used for function prediction.
From an annotated genes, the predicted function can be the closest vertex of the
type “GO”.

We generalized this principle to identify, from a seed of interest, the closest
node (or `top` closest nodes) with specific attributes and value.

In the example below, the gene “ZNF263” is linked to the 5 closest nodes of
type = ‘GO’ and type = ‘Disease’.

```
rwr_res <- random_walk_restart(FULL$All, seed = "ZNF263")

# closest GO term
rwr_find_closest_type(rwr_res, seed = "ZNF263", attribute = "type",
                      value = "GO", top = 5)
```

```
## $ZNF263
## # A tibble: 5 × 7
##   NodeNames        Score SeedName cluster type  mode     sparse
##   <chr>            <dbl> <chr>    <chr>   <chr> <chr>    <lgl>
## 1 GO:0050790 0.00000991  ZNF263   <NA>    GO    extended FALSE
## 2 GO:0061024 0.00000965  ZNF263   <NA>    GO    extended FALSE
## 3 GO:0043197 0.00000915  ZNF263   <NA>    GO    extended FALSE
## 4 GO:0006614 0.00000888  ZNF263   <NA>    GO    extended FALSE
## 5 GO:0019222 0.000000938 ZNF263   <NA>    GO    extended FALSE
##
## attr(,"class")
## [1] "rwr.closest"
```

```
# closest Disease
rwr_find_closest_type(rwr_res, seed = "ZNF263", attribute = "type",
                      value = "Disease", top = 5)
```

```
## $ZNF263
## # A tibble: 5 × 7
##   NodeNames                      Score SeedName cluster type    mode     sparse
##   <chr>                          <dbl> <chr>    <chr>   <chr>   <chr>    <lgl>
## 1 Metaplasia               0.000000995 ZNF263   <NA>    Disease extended FALSE
## 2 Necrosis                 0.000000992 ZNF263   <NA>    Disease extended FALSE
## 3 Nasopharyngeal Neoplasms 0.000000982 ZNF263   <NA>    Disease extended FALSE
## 4 Hypogonadism             0.000000973 ZNF263   <NA>    Disease extended FALSE
## 5 Adenocarcinoma, Mucinous 0.000000970 ZNF263   <NA>    Disease extended FALSE
##
## attr(,"class")
## [1] "rwr.closest"
```

```
# closest nodes with an attribute "cluster" and the value "-1"
rwr_find_closest_type(rwr_res, seed = "ZNF263", attribute = "cluster",
                      value = "-1", top = 5)
```

```
## $ZNF263
## # A tibble: 5 × 7
##   NodeNames       Score SeedName cluster type  mode  sparse
##   <chr>           <dbl> <chr>    <chr>   <chr> <chr> <lgl>
## 1 ATF7      0.000887    ZNF263   -1      RNA   core  FALSE
## 2 TET1      0.000830    ZNF263   -1      RNA   core  FALSE
## 3 LOC642943 0.00000957  ZNF263   -1      RNA   core  FALSE
## 4 LOC284801 0.00000513  ZNF263   -1      RNA   core  FALSE
## 5 ROR1.AS1  0.000000822 ZNF263   -1      RNA   core  FALSE
##
## attr(,"class")
## [1] "rwr.closest"
```

```
seeds <- V(FULL$All)$name[V(FULL$All)$type %in% c("GO", "Disease")]
```

```
sessionInfo()
```

```
## R version 4.1.1 (2021-08-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.14-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.14-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] igraph_1.2.7     forcats_0.5.1    stringr_1.4.0    dplyr_1.0.7
##  [5] purrr_0.3.4      readr_2.0.2      tidyr_1.1.4      tibble_3.1.5
##  [9] tidyverse_1.3.1  timeOmics_1.6.0  mixOmics_6.18.0  ggplot2_3.3.5
## [13] lattice_0.20-45  MASS_7.3-54      netOmics_1.0.0   BiocStyle_2.22.0
##
## loaded via a namespace (and not attached):
##   [1] colorspace_2.0-2           ellipsis_0.3.2
##   [3] corpcor_1.6.10             XVector_0.34.0
##   [5] fs_1.5.0                   rstudioapi_0.13
##   [7] farver_2.1.0               hexbin_1.28.2
##   [9] ggrepel_0.9.1              bit64_4.0.5
##  [11] AnnotationDbi_1.56.0       RSpectra_0.16-0
##  [13] fansi_0.5.0                lubridate_1.8.0
##  [15] xml2_1.3.2                 cachem_1.0.6
##  [17] knitr_1.36                 jsonlite_1.7.2
##  [19] broom_0.7.9                GO.db_3.14.0
##  [21] dbplyr_2.1.1               png_0.1-7
##  [23] supraHex_1.32.0            graph_1.72.0
##  [25] BiocManager_1.30.16        compiler_4.1.1
##  [27] httr_1.4.2                 backports_1.2.1
##  [29] assertthat_0.2.1           Matrix_1.3-4
##  [31] fastmap_1.1.0              lazyeval_0.2.2
##  [33] cli_3.0.1                  htmltools_0.5.2
##  [35] tools_4.1.1                gtable_0.3.0
##  [37] glue_1.4.2                 GenomeInfoDbData_1.2.7
##  [39] reshape2_1.4.4             Rcpp_1.0.7
##  [41] Biobase_2.54.0             cellranger_1.1.0
##  [43] jquerylib_0.1.4            vctrs_0.3.8
##  [45] Biostrings_2.62.0          ape_5.5
##  [47] nlme_3.1-153               lmtest_0.9-38
##  [49] xfun_0.27                  rvest_1.0.2
##  [51] lifecycle_1.0.1            zlibbioc_1.40.0
##  [53] zoo_1.8-9                  scales_1.1.1
##  [55] minet_3.52.0               hms_1.1.1
##  [57] RandomWalkRestartMH_1.14.0 parallel_4.1.1
##  [59] gprofiler2_0.2.1           RColorBrewer_1.1-2
##  [61] yaml_2.2.1                 memoise_2.0.0
##  [63] gridExtra_2.3              sass_0.4.0
##  [65] stringi_1.7.5              RSQLite_2.2.8
##  [67] highr_0.9                  S4Vectors_0.32.0
##  [69] BiocGenerics_0.40.0        BiocParallel_1.28.0
##  [71] GenomeInfoDb_1.30.0        rlang_0.4.12
##  [73] pkgconfig_2.0.3            bitops_1.0-7
##  [75] matrixStats_0.61.0         dnet_1.1.7
##  [77] evaluate_0.14              labeling_0.4.2
##  [79] htmlwidgets_1.5.4          bit_4.0.4
##  [81] tidyselect_1.1.1           plyr_1.8.6
##  [83] magrittr_2.0.1             bookdown_0.24
##  [85] R6_2.5.1                   magick_2.7.3
##  [87] IRanges_2.28.0             generics_0.1.1
##  [89] DBI_1.1.1                  pillar_1.6.4
##  [91] haven_2.4.3                withr_2.4.2
##  [93] KEGGREST_1.34.0            RCurl_1.98-1.5
##  [95] modelr_0.1.8               crayon_1.4.1
##  [97] rARPACK_0.11-0             utf8_1.2.2
##  [99] ellipse_0.4.2              plotly_4.10.0
## [101] tzdb_0.1.2                 rmarkdown_2.11
## [103] grid_4.1.1                 readxl_1.3.1
## [105] data.table_1.14.2          propr_4.2.6
## [107] blob_1.2.2                 Rgraphviz_2.38.0
## [109] reprex_2.0.1               digest_0.6.28
## [111] stats4_4.1.1               munsell_0.5.0
## [113] viridisLite_0.4.0          bslib_0.3.1
```

# References

Bodein, Antoine, Marie-Pier Scott-Boyer, Olivier Perin, Kim-Anh Le Cao, and Arnaud Droit. 2020. “Interpretation of Network-Based Integration from Multi-Omics Longitudinal Data.” *bioRxiv*.

Friedman, Jonathan, and Eric J Alm. 2012. “Inferring Correlation Networks from Genomic Survey Data.”

Sailani, M Reza, Ahmed A Metwally, Wenyu Zhou, Sophia Miryam Schüssler-Fiorenza Rose, Sara Ahadi, Kevin Contrepois, Tejaswini Mishra, et al. 2020. “Deep Longitudinal Multiomics Profiling Reveals Two Biological Seasonal Patterns in California.” *Nature Communications* 11 (1): 1–12.