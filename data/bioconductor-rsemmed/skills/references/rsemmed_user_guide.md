Code

* Show All Code
* Hide All Code

# The rsemmed User’s Guide

Leslie Myint

#### 30 October 2025

#### Abstract

A comprehensive guide to using the rsemmed package for exploring the Semantic MEDLINE database.

# 1 Introduction

The *[rsemmed](https://bioconductor.org/packages/3.22/rsemmed)* package provides a way for users to explore connections between the biological concepts present in the Semantic MEDLINE database (Kilicoglu et al. [2011](#ref-Kilicoglu:2011)) in a programmatic way.

## 1.1 Overview of Semantic MEDLINE

The Semantic MEDLINE database (SemMedDB) is a collection of annotations of sentences from the abstracts of articles indexed in PubMed. These annotations take the form of subject-predicate-object triples of information. These triples are also called **predications**.

An example predication is “Interleukin-12 INTERACTS\_WITH IFNA1”. Here, the subject is “Interleukin-12”, the object is “IFNA1” (interferon alpha-1), and the predicate linking the subject and object is “INTERACTS\_WITH”. The Semantic MEDLINE database consists of tens of millions of these predications.

Semantic MEDLINE also provides information on the broad categories into which biological concepts (predication subjects and objects) fall. This information is called the **semantic type** of a concept. The databases assigns 4-letter codes to semantic types. For example, “gngm” represents “Gene or Genome”. Every concept in the database has one or more semantic types (abbreviated as “semtypes”).

Note: The information in Semantic MEDLINE is primarily computationally-derived. Thus, some information will seem nonsensical. For example, the reported semantic types of concepts might not quite match. The Semantic MEDLINE resource and this package are meant to facilitate an *initial* window of exploration into the literature. The hope is that this package helps guide more streamlined manual investigations of the literature.

## 1.2 Graph representation of SemMedDB

The predications in SemMedDB can be represented in graph form. Nodes represent concepts, and directed edges represent predicates (concept linkers). In particular, the Semantic MEDLINE graph is a directed **multigraph** because multiple predicates are often present between pairs of nodes (e.g., “A ASSOCIATED\_WITH B” and “A INTERACTS\_WITH B”). *[rsemmed](https://bioconductor.org/packages/3.22/rsemmed)* relies on the *[igraph](https://CRAN.R-project.org/package%3Digraph)* package for efficient graph operations.

### 1.2.1 Full data availability

The full data underlying the complete Semantic MEDLINE database is available from from this [National Library of Medicine site](https://ii.nlm.nih.gov/SemRep_SemMedDB_SKR/SemMedDB/SemMedDB_download.shtml) as SQL dump files. In particular, the PREDICATION table is the primary file that is needed to construct the database. More information about the Semantic MEDLINE database is available [here](https://skr3.nlm.nih.gov/SemMed/index.html).

See the `inst/script` folder for scripts to perform the following processing of these raw files:

* Conversion of the original SQL dump files to a CSV file
* Generation of the graph representation from the CSV file

The next section describes details about the processing that occurs in these scripts to generate the graph representation.

In this vignette, we will explore a much smaller subset of the full graph that suffices to show the full functionality of *[rsemmed](https://bioconductor.org/packages/3.22/rsemmed)*.

### 1.2.2 Note about processed data

The graph representation of SemMedDB contains a processed and summarized form of the raw database. The toy example below illustrates the summarization performed.

| Subject | Subject semtype | Predicate | Object | Object semtype |
| --- | --- | --- | --- | --- |
| A | aapp | INHIBITS | B | gngm |
| A | gngm | INHIBITS | B | aapp |

The two rows show two predications that are treated as different predications because the semantic types (“semtypes”) of the subject and object vary. In the processed data, such instances have been collapsed as shown below.

| Subject | Subject semtype | Predicate | Object | Object semtype | # instances |
| --- | --- | --- | --- | --- | --- |
| A | aapp,gngm | INHIBITS | B | aapp,gngm | 2 |

The different semantic types for a particular concept are collapsed into a single comma-separated string that is available via `igraph::vertex_attr(g, "semtype")`.

The “# instances” column indicates that the “A INHIBITS B” predication was observed twice in the database. This piece of information is available as an edge attribute via `igraph::edge_attr(g, "num_instances")`. Similarly, predicate information is also an edge attribute accessible via `igraph::edge_attr(g, "predicate")`.

A note of caution: Be careful when working with edge attributes in the Semantic MEDLINE graph manually. These operations can be very slow because there are over 18 million edges. Working with node/vertex attributes is much faster, but there are still a very large number of nodes (roughly 290,000).

The rest of this vignette will showcase how to use *[rsemmed](https://bioconductor.org/packages/3.22/rsemmed)* functions to explore this graph.

# 2 Installation

To install *[rsemmed](https://bioconductor.org/packages/3.22/rsemmed)*, start R and enter the following:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rsemmed")
```

# 3 Example workflow

## 3.1 Loading packages and data

Load the *[rsemmed](https://bioconductor.org/packages/3.22/rsemmed)* package and the `g_small` object which contains a smaller version of the Semantic MEDLINE database.

```
library(rsemmed)
```

```
## Loading required package: igraph
```

```
##
## Attaching package: 'igraph'
```

```
## The following objects are masked from 'package:stats':
##
##     decompose, spectrum
```

```
## The following object is masked from 'package:base':
##
##     union
```

```
data(g_small)
```

This loads an object of class `igraph` named `g_small` into the workspace. The SemMedDB graph object is a necessary input for most of *[rsemmed](https://bioconductor.org/packages/3.22/rsemmed)*’s functions.

(The full processed graph representation linked above contains an object of class `igraph` named `g`.)

## 3.2 Finding nodes

The starting point for an *[rsemmed](https://bioconductor.org/packages/3.22/rsemmed)* exploration is to find nodes related to the initial ideas of interest. For example, we may wish to find connections between the ideas “sickle cell trait” and “malaria”.

The `rsemmed::find_nodes()` function allows you to search for nodes by name. We supply the graph and a regular expression to use in searching through the `name` attribute of the nodes. Finding the most relevant nodes will generally involve iteration.

To find nodes related to the sickle cell trait, we can start by searching for nodes containing the word “sickle”. (Note: searches ignore capitalization.)

```
nodes_sickle <- find_nodes(g_small, pattern = "sickle")
```

```
## This graph was created by an old(er) igraph version.
## ℹ Call `igraph::upgrade_graph()` on it to use with the current igraph version.
## For now we convert it on the fly...
```

```
nodes_sickle
```

```
## + 5/1038 vertices, named, from f0c97f6:
## [1] Sickle Cell Anemia      Sickle Hemoglobin       Sickle Cell Trait
## [4] Sickle cell retinopathy sickle trait
```

We may decide that only **sickle cell anemia** and the **sickle trait** are important. Conventional R subsetting allows us to keep the 3 related nodes:

```
nodes_sickle <- nodes_sickle[c(1,3,5)]
nodes_sickle
```

```
## + 3/1038 vertices, named, from f0c97f6:
## [1] Sickle Cell Anemia Sickle Cell Trait  sickle trait
```

We can also search for nodes related to “malaria”:

```
nodes_malaria <- find_nodes(g_small, pattern = "malaria")
nodes_malaria
```

```
## + 32/1038 vertices, named, from f0c97f6:
##  [1] Malaria
##  [2] Malaria, Falciparum
##  [3] Malaria, Cerebral
##  [4] Malaria Vaccines
##  [5] Antimalarials
##  [6] Malaria, Vivax
##  [7] Simian malaria
##  [8] Malaria, Avian
##  [9] Malarial parasites
## [10] Mixed malaria
## + ... omitted several vertices
```

There are 32 results, not all of which are printed, so we can display all results by accessing the `name` attribute of the returned nodes:

```
nodes_malaria$name
```

```
##  [1] "Malaria"
##  [2] "Malaria, Falciparum"
##  [3] "Malaria, Cerebral"
##  [4] "Malaria Vaccines"
##  [5] "Antimalarials"
##  [6] "Malaria, Vivax"
##  [7] "Simian malaria"
##  [8] "Malaria, Avian"
##  [9] "Malarial parasites"
## [10] "Mixed malaria"
## [11] "Plasmodium malariae infection"
## [12] "Malaria antigen"
## [13] "Prescription of prophylactic anti-malarial"
## [14] "Induced malaria"
## [15] "Malaria serology"
## [16] "Algid malaria"
## [17] "Aminoquinoline antimalarial"
## [18] "Plasmodium malariae"
## [19] "Malaria antibody"
## [20] "Malaria screening"
## [21] "Congenital malaria"
## [22] "Ovale malaria"
## [23] "Quartan malaria"
## [24] "Malaria Antibodies Test"
## [25] "Biguanide antimalarial"
## [26] "MALARIA RELAPSE"
## [27] "KIT, TEST, MALARIA"
## [28] "Malarial hepatitis"
## [29] "Malarial pigmentation"
## [30] "Malaria antigen test"
## [31] "Malarial nephrosis"
## [32] "Malaria smear"
```

Perhaps we only want to keep the nodes that relate to disease. We could use direct subsetting, but another option is to use `find_nodes()` again with `nodes_malaria` as the input. Using the `match` argument set to `FALSE` allows us to prune unwanted matches from our results.

Below we iteratively prune matches to only keep disease-related results. Though this is not as condense as direct subsetting, it is more transparent about what was removed.

```
nodes_malaria <- nodes_malaria %>%
    find_nodes(pattern = "anti", match = FALSE) %>%
    find_nodes(pattern = "test", match = FALSE) %>%
    find_nodes(pattern = "screening", match = FALSE) %>%
    find_nodes(pattern = "pigment", match = FALSE) %>%
    find_nodes(pattern = "smear", match = FALSE) %>%
    find_nodes(pattern = "parasite", match = FALSE) %>%
    find_nodes(pattern = "serology", match = FALSE) %>%
    find_nodes(pattern = "vaccine", match = FALSE)
nodes_malaria
```

```
## + 17/1038 vertices, named, from f0c97f6:
##  [1] Malaria                       Malaria, Falciparum
##  [3] Malaria, Cerebral             Malaria, Vivax
##  [5] Simian malaria                Malaria, Avian
##  [7] Mixed malaria                 Plasmodium malariae infection
##  [9] Induced malaria               Algid malaria
## [11] Plasmodium malariae           Congenital malaria
## [13] Ovale malaria                 Quartan malaria
## [15] MALARIA RELAPSE               Malarial hepatitis
## [17] Malarial nephrosis
```

The `find_nodes()` function can also be used with the `semtypes` argument which allows you to specify a character vector of semantic types to search for. If both `pattern` and `semtypes` are provided, they are combined with an `OR` operation. If you would like them to be combined with an `AND` operation, nest the calls in sequence.

```
## malaria OR disease (dsyn)
find_nodes(g_small, pattern = "malaria", semtypes = "dsyn")
```

```
## + 317/1038 vertices, named, from f0c97f6:
##   [1] Obstruction
##   [2] Depressed mood
##   [3] Carcinoma
##   [4] HIV-1
##   [5] Infection
##   [6] leukemia
##   [7] Neoplasm
##   [8] Renal tubular disorder
##   [9] Toxic effect
##  [10] Vesicle
## + ... omitted several vertices
```

```
## malaria AND disease (dsyn)
find_nodes(g_small, pattern = "malaria") %>%
    find_nodes(semtypes = "dsyn")
```

```
## + 16/1038 vertices, named, from f0c97f6:
##  [1] Malaria                       Malaria, Falciparum
##  [3] Malaria, Cerebral             Malaria, Vivax
##  [5] Simian malaria                Malaria, Avian
##  [7] Mixed malaria                 Plasmodium malariae infection
##  [9] Induced malaria               Algid malaria
## [11] Congenital malaria            Ovale malaria
## [13] Quartan malaria               MALARIA RELAPSE
## [15] Malarial hepatitis            Malarial nephrosis
```

Finally, you can also select nodes by exact name with the `names` argument. (Capitalization is ignored.)

```
find_nodes(g_small, names = "sickle trait")
```

```
## + 1/1038 vertex, named, from f0c97f6:
## [1] sickle trait
```

```
find_nodes(g_small, names = "SICKLE trait")
```

```
## + 1/1038 vertex, named, from f0c97f6:
## [1] sickle trait
```

## 3.3 Growing understanding by connecting nodes

Now that we have nodes related to the ideas of interest, we can develop further understanding by asking the following questions:

* How are these node sets connected to each other? (Aim 1)
* What ideas (nodes) are connected to these nodes? (Aim 2)

### 3.3.1 Aim 1: Connecting different node sets

To further Aim 1, we can use the `rsemmed::find_paths()` function. This function takes two sets of nodes `from` and `to` (corresponding to the two different ideas of interest) and returns all shortest paths between nodes in `from` (“source” nodes) and nodes in `to` (“target” nodes). That is, for every possible combination of a single node in `from` and a single node in `to`, all shortest *undirected* paths between those nodes are found.

```
paths <- find_paths(graph = g_small, from = nodes_sickle, to = nodes_malaria)
```

#### 3.3.1.1 Information from `find_paths()`

The result of `find_paths()` is a list with one element for each of the nodes in `from`. Each element is itself a list of paths between `from` and `to`. In *[igraph](https://CRAN.R-project.org/package%3Digraph)*, paths are represented as vertex sequences (class `igraph.vs`).

Recall that `nodes_sickle` contains the nodes below:

```
nodes_sickle
```

```
## + 3/1038 vertices, named, from f0c97f6:
## [1] Sickle Cell Anemia Sickle Cell Trait  sickle trait
```

Thus, `paths` is structured as follows:

* `paths[[1]]` is a list of paths originating from Sickle Cell Anemia.
* `paths[[2]]` is a list of paths originating from Sickle Cell Trait.
* `paths[[3]]` is a list of paths originating from sickle trait.

With `lengths()` we can show the number of shortest paths starting at each of the three source (“from”) nodes:

```
lengths(paths)
```

```
## [1]  956  268 1601
```

#### 3.3.1.2 Displaying paths

There are two ways to display the information contained in these paths: `rsemmed::text_path()` and `rsemmed::plot_path()`.

* `text_path()` displays a text version of a path
* `plot_path()` displays a graphical version of the path

For example, to show the 100th of the shortest paths originating from the first of the sickle trait nodes (`paths[[1]][[100]]`), we can use `text_path()` and `plot_path()` as below:

```
this_path <- paths[[1]][[100]]
tp <- text_path(g_small, this_path)
```

```
## Sickle Cell Anemia --- pulmonary complications :
## # A tibble: 4 × 5
##   from_semtype from                    via              to            to_semtype
##   <chr>        <chr>                   <chr>            <chr>         <chr>
## 1 dsyn         Sickle Cell Anemia      CAUSES           pulmonary co… patf
## 2 patf         pulmonary complications CAUSES           Sickle Cell … dsyn
## 3 patf         pulmonary complications COEXISTS_WITH    Sickle Cell … dsyn
## 4 patf         pulmonary complications MANIFESTATION_OF Sickle Cell … dsyn
##
## pulmonary complications --- Malaria, Falciparum :
## # A tibble: 1 × 5
##   from_semtype from                    via           to               to_semtype
##   <chr>        <chr>                   <chr>         <chr>            <chr>
## 1 patf         pulmonary complications COEXISTS_WITH Malaria, Falcip… dsyn
```

```
tp
```

```
## [[1]]
## # A tibble: 4 × 5
##   from_semtype from                    via              to            to_semtype
##   <chr>        <chr>                   <chr>            <chr>         <chr>
## 1 dsyn         Sickle Cell Anemia      CAUSES           pulmonary co… patf
## 2 patf         pulmonary complications CAUSES           Sickle Cell … dsyn
## 3 patf         pulmonary complications COEXISTS_WITH    Sickle Cell … dsyn
## 4 patf         pulmonary complications MANIFESTATION_OF Sickle Cell … dsyn
##
## [[2]]
## # A tibble: 1 × 5
##   from_semtype from                    via           to               to_semtype
##   <chr>        <chr>                   <chr>         <chr>            <chr>
## 1 patf         pulmonary complications COEXISTS_WITH Malaria, Falcip… dsyn
```

```
plot_path(g_small, this_path)
```

![](data:image/png;base64...)

`plot_path()` plots the subgraph defined by the nodes on the path.

`text_path()` sequentially shows detailed information about semantic types and predicates for the pairs of nodes on the path. It also invisibly returns a list of `tibble`’s containing the displayed information, where each list element corresponds to a pair of nodes on the path.

#### 3.3.1.3 Refining paths with weights

Finding paths between node sets necessarily uses shortest path algorithms for computational tractability. However, when these algorithms are run without modification, the shortest paths tend to be less useful than desired.

For example, one of the shortest paths from “sickle trait” to “Malaria, Cerebral” goes through the node “Infant”:

```
this_path <- paths[[3]][[32]]
plot_path(g_small, this_path)
```

![](data:image/png;base64...)

This likely isn’t the type of path we were hoping for. Why does such a path arise? For some insight, we can use the `degree()` function within the *[igraph](https://CRAN.R-project.org/package%3Digraph)* package to look at the degree distribution for all nodes in the Semantic MEDLINE graph. We also show the degree of the “Infant” node in red.

```
plot(density(degree(g_small), from = 0),
    xlab = "Degree", main = "Degree distribution")
## The second node in the path is "Infant" --> this_path[2]
abline(v = degree(g_small, v = this_path[2]), col = "red", lwd = 2)
```

![](data:image/png;base64...)

We can see why “Infant” would be on a shortest path connecting “sickle trait” and “Malaria, Cerebral”. “Infant” has a very large degree, and most of its connections are likely of the uninteresting form “PROCESS\_OF” (a predicate indicating that the subject node is a biological process that occurs in the organism represented by the object node).

We can discourage such paths from consideration by modifying edge weights. By default, all edges have a weight of 1 in the shortest path search, but we can effectively block off certain edges by giving them a high enough weight. For example, in `rsemmed::make_edge_weights()`, this weight is chosen to equal the number of nodes in the entire graph. (Note that if **all** paths from the source node to the target node contain a given undesired edge, the process of edge reweighting will not prevent paths from containing that edge.)

The process of modifying edge weights starts by obtaining characteristics for all of the edges in the Semantic MEDLINE graph. This is achieved with the `rsemmed::get_edge_features()` function:

```
e_feat <- get_edge_features(g_small)
head(e_feat)
```

```
## # A tibble: 6 × 5
##   node_subj_name node_subj_semtypes node_obj_name    node_obj_semtypes edge_pred
##   <chr>          <chr>              <chr>            <chr>             <chr>
## 1 infant         aggp,humn          control groups   grup,humn,patf    interact…
## 2 infant         aggp,humn          antibodies       aapp,bpoc,gngm,i… neg_loca…
## 3 infant         aggp,humn          antibodies       aapp,bpoc,gngm,i… location…
## 4 infant         aggp,humn          glutathione      aapp,bacs,gngm,p… location…
## 5 infant         aggp,humn          glycoproteins    aapp,carb,chvs,g… location…
## 6 infant         aggp,humn          granulocyte col… aapp,gngm,imft    neg_loca…
```

For every edge in the graph, the following information is returned in a `tibble`:

* The name and semantic type (`semtype`) of the subject and object node
* The predicate for the edge

You can directly use the information from `get_edge_features()` to manually construct custom weights for edges. This could include giving certain edges maximal weights as described above or encouraging certain edges by giving them lower weights.

The `get_edge_features()` function also has arguments `include_degree`, `include_node_ids`, and `include_num_instances` which can be set to `TRUE` to include additional edge features in the output.

* `include_degree`: Adds information on the degree of the subject and object nodes and the degree percentile in the entire graph. (100th percentile = highest degree)
* `include_node_ids`: Adds the integer IDs for the subject and object nodes. This IDs can be useful with *[igraph](https://CRAN.R-project.org/package%3Digraph)* functions that compute various node/vertex metrics (e.g., centrality measures with `igraph::closeness()`, `igraph::edge_betweenness()`).
* `include_num_instances`: Adds information on the number of times a particular edge (predication) was seen in the Semantic MEDLINE database. This might be useful if you want to weight edges based on how commonly the relationship was reported.

#### 3.3.1.4 Weighting option: `make_edge_weights()`

The `rsemmed::make_edge_weights()` function provides a way to create weights that encourage and/or discourage certain features. It allows you to specify the node names, node semantic types, and edge predicates that you would like to include in and/or exclude from paths.

* The first two arguments `g` and `e_feat` supply required graph metadata.
* “Out” arguments: `node_semtypes_out`, `node_names_out`, `edge_preds_out` are supplied as character vectors of node semantic types, names, and edge predicates that you wish to **exclude** from shortest path results. These three features are combined with an OR operation. An edge that meets any one of these criteria is given the highest weight possible to discourage paths from including this edge.
* “In” arguments: `node_semtypes_in`, `node_names_in`, `edge_preds_in` are analogous to the “out” arguments but indicate types of edges you wish to **include** within shortest path results. Like with the “out arguments”, these three features are combined with an OR operation. An edge that meets any one of these criteria is given a lower weight to encourage paths to include this edge.

As an example of the impact of reweighting, let’s examine the connections between “sickle trait” and “Malaria, Cerebral”. In order to clearly see the effects of edge reweighting, below we obtain the paths from “sickle trait” to “Malaria, Cerebral”:

```
paths_subset <- find_paths(
    graph = g_small,
    from = find_nodes(g_small, names = "sickle trait"),
    to = find_nodes(g_small, names = "Malaria, Cerebral")
)
paths_subset <- paths_subset[[1]]
par(mfrow = c(1,2), mar = c(3,0,1,0))
for (i in seq_along(paths_subset)) {
    cat("Path", i, ": ==============================================\n")
    text_path(g_small, paths_subset[[i]])
    cat("\n")
    plot_path(g_small, paths_subset[[i]])
}
```

```
## Path 1 : ==============================================
## sickle trait --- Prophylactic treatment :
## # A tibble: 1 × 5
##   from_semtype from                   via    to           to_semtype
##   <chr>        <chr>                  <chr>  <chr>        <chr>
## 1 hlca,topp    Prophylactic treatment TREATS sickle trait fndg
##
## Prophylactic treatment --- Malaria, Cerebral :
## # A tibble: 2 × 5
##   from_semtype from                   via      to                to_semtype
##   <chr>        <chr>                  <chr>    <chr>             <chr>
## 1 hlca,topp    Prophylactic treatment PREVENTS Malaria, Cerebral dsyn
## 2 hlca,topp    Prophylactic treatment TREATS   Malaria, Cerebral dsyn
```

```
## Path 2 : ==============================================
## sickle trait --- Malaria, Falciparum :
## # A tibble: 1 × 5
##   from_semtype from                via           to           to_semtype
##   <chr>        <chr>               <chr>         <chr>        <chr>
## 1 dsyn         Malaria, Falciparum COEXISTS_WITH sickle trait fndg
##
## Malaria, Falciparum --- Malaria, Cerebral :
## # A tibble: 7 × 5
##   from_semtype from                via           to                  to_semtype
##   <chr>        <chr>               <chr>         <chr>               <chr>
## 1 dsyn         Malaria, Cerebral   CAUSES        Malaria, Falciparum dsyn
## 2 dsyn         Malaria, Cerebral   COEXISTS_WITH Malaria, Falciparum dsyn
## 3 dsyn         Malaria, Cerebral   COMPLICATES   Malaria, Falciparum dsyn
## 4 dsyn         Malaria, Cerebral   ISA           Malaria, Falciparum dsyn
## 5 dsyn         Malaria, Cerebral   PRECEDES      Malaria, Falciparum dsyn
## 6 dsyn         Malaria, Falciparum CAUSES        Malaria, Cerebral   dsyn
## 7 dsyn         Malaria, Falciparum NEG_OCCURS_IN Malaria, Cerebral   dsyn
```

![](data:image/png;base64...)

```
## Path 3 : ==============================================
## sickle trait --- Death, Sudden :
## # A tibble: 1 × 5
##   from_semtype from          via           to           to_semtype
##   <chr>        <chr>         <chr>         <chr>        <chr>
## 1 fndg,patf    Death, Sudden COEXISTS_WITH sickle trait fndg
##
## Death, Sudden --- Malaria, Cerebral :
## # A tibble: 1 × 5
##   from_semtype from              via    to            to_semtype
##   <chr>        <chr>             <chr>  <chr>         <chr>
## 1 dsyn         Malaria, Cerebral CAUSES Death, Sudden fndg,patf
```

```
## Path 4 : ==============================================
## sickle trait --- Retinal Diseases :
## # A tibble: 1 × 5
##   from_semtype from             via           to           to_semtype
##   <chr>        <chr>            <chr>         <chr>        <chr>
## 1 dsyn         Retinal Diseases COEXISTS_WITH sickle trait fndg
##
## Retinal Diseases --- Malaria, Cerebral :
## # A tibble: 4 × 5
##   from_semtype from              via           to                to_semtype
##   <chr>        <chr>             <chr>         <chr>             <chr>
## 1 dsyn         Malaria, Cerebral COEXISTS_WITH Retinal Diseases  dsyn
## 2 dsyn         Retinal Diseases  AFFECTS       Malaria, Cerebral dsyn
## 3 dsyn         Retinal Diseases  COEXISTS_WITH Malaria, Cerebral dsyn
## 4 dsyn         Retinal Diseases  PREDISPOSES   Malaria, Cerebral dsyn
```

![](data:image/png;base64...)

```
## Path 5 : ==============================================
## sickle trait --- Child :
## # A tibble: 1 × 5
##   from_semtype from         via        to    to_semtype
##   <chr>        <chr>        <chr>      <chr> <chr>
## 1 fndg         sickle trait PROCESS_OF Child aggp,humn,inpr,popg
##
## Child --- Malaria, Cerebral :
## # A tibble: 4 × 5
##   from_semtype from              via            to    to_semtype
##   <chr>        <chr>             <chr>          <chr> <chr>
## 1 dsyn         Malaria, Cerebral AFFECTS        Child aggp,humn,inpr,popg
## 2 dsyn         Malaria, Cerebral NEG_PROCESS_OF Child aggp,humn,inpr,popg
## 3 dsyn         Malaria, Cerebral OCCURS_IN      Child aggp,humn,inpr,popg
## 4 dsyn         Malaria, Cerebral PROCESS_OF     Child aggp,humn,inpr,popg
```

```
## Path 6 : ==============================================
## sickle trait --- Woman :
## # A tibble: 1 × 5
##   from_semtype from         via        to    to_semtype
##   <chr>        <chr>        <chr>      <chr> <chr>
## 1 fndg         sickle trait PROCESS_OF Woman anim,humn,popg
##
## Woman --- Malaria, Cerebral :
## # A tibble: 1 × 5
##   from_semtype from              via        to    to_semtype
##   <chr>        <chr>             <chr>      <chr> <chr>
## 1 dsyn         Malaria, Cerebral PROCESS_OF Woman anim,humn,popg
```

![](data:image/png;base64...)

```
## Path 7 : ==============================================
## sickle trait --- Infant :
## # A tibble: 1 × 5
##   from_semtype from         via        to     to_semtype
##   <chr>        <chr>        <chr>      <chr>  <chr>
## 1 fndg         sickle trait PROCESS_OF Infant aggp,humn
##
## Infant --- Malaria, Cerebral :
## # A tibble: 1 × 5
##   from_semtype from              via        to     to_semtype
##   <chr>        <chr>             <chr>      <chr>  <chr>
## 1 dsyn         Malaria, Cerebral PROCESS_OF Infant aggp,humn
```

![](data:image/png;base64...)

The “Child”, “Woman”, and “Infant” connections do not provide particularly useful biological insight. We could discourage paths from containing these nodes by specifically targeting those node names in the reweighting:

```
w <- make_edge_weights(g, e_feat,
    node_names_out = c("Child", "Woman", "Infant")
)
```

However, in case there are other similar nodes (like “Teens”), we might want to discourage this group of nodes by specifying the semantic type corresponding to this group. We can see the semantic types of the nodes on the shortest paths as follows:

```
lapply(paths_subset, function(vs) {
    vs$semtype
})
```

```
## [[1]]
## [1] "fndg"      "hlca,topp" "dsyn"
##
## [[2]]
## [1] "fndg" "dsyn" "dsyn"
##
## [[3]]
## [1] "fndg"      "fndg,patf" "dsyn"
##
## [[4]]
## [1] "fndg" "dsyn" "dsyn"
##
## [[5]]
## [1] "fndg"                "aggp,humn,inpr,popg" "dsyn"
##
## [[6]]
## [1] "fndg"           "anim,humn,popg" "dsyn"
##
## [[7]]
## [1] "fndg"      "aggp,humn" "dsyn"
```

We can see that the “humn” and “popg” semantic types correspond to the class of nodes we would like to discourage. We supply them in the `node_semtypes_out` argument and repeat the path search with these weights:

```
w <- make_edge_weights(g_small, e_feat, node_semtypes_out = c("humn", "popg"))

paths_subset_reweight <- find_paths(
    graph = g_small,
    from = find_nodes(g_small, names = "sickle trait"),
    to = find_nodes(g_small, names = "Malaria, Cerebral"),
    weights = w
)
paths_subset_reweight
```

```
## [[1]]
## [[1]][[1]]
## + 3/1038 vertices, named, from f0c97f6:
## [1] sickle trait      Retinal Diseases  Malaria, Cerebral
##
## [[1]][[2]]
## + 3/1038 vertices, named, from f0c97f6:
## [1] sickle trait      Death, Sudden     Malaria, Cerebral
##
## [[1]][[3]]
## + 3/1038 vertices, named, from f0c97f6:
## [1] sickle trait        Malaria, Falciparum Malaria, Cerebral
##
## [[1]][[4]]
## + 3/1038 vertices, named, from f0c97f6:
## [1] sickle trait           Prophylactic treatment Malaria, Cerebral
```

The effect of that reweighting was likely not quite what we wanted. The discouraging of “humn” and “popg” nodes only served to filter down the 7 original paths to 4 shortest paths. Because the first 4 of the 7 original paths were not explicitly removed through the reweighting, they remained the shortest paths from source to target. If we would like to see different types of paths (longer paths), we should indicate that we would like to remove all of the original paths’ middle nodes. We can use the `rsemmed::get_middle_nodes()` function to obtain a character vector of names of middle nodes in a path set.

```
## Obtain the middle nodes (2nd node on the path)
out_names <- get_middle_nodes(g_small, paths_subset)
```

```
## Joining with `by = join_by(name)`
## Joining with `by = join_by(path_group, path_id)`
```

```
## Readjust weights
w <- make_edge_weights(g_small, e_feat,
    node_names_out = out_names, node_semtypes_out = c("humn", "popg")
)

## Find paths with new weights
paths_subset_reweight <- find_paths(
    graph = g_small,
    from = find_nodes(g_small, pattern = "sickle trait"),
    to = find_nodes(g_small, pattern = "Malaria, Cerebral"),
    weights = w
)
paths_subset_reweight <- paths_subset_reweight[[1]]

## How many paths?
length(paths_subset_reweight)
```

```
## [1] 1550
```

There is clearly a much greater diversity of paths resulting from this search.

```
par(mfrow = c(1,2), mar = c(2,1.5,1,1.5))
plot_path(g_small, paths_subset_reweight[[1]])
plot_path(g_small, paths_subset_reweight[[2]])
```

![](data:image/png;base64...)

```
plot_path(g_small, paths_subset_reweight[[1548]])
plot_path(g_small, paths_subset_reweight[[1549]])
```

![](data:image/png;base64...)

When dealing with paths from several source and target nodes, it can be helpful to obtain the middle nodes on paths for specific source-target pairs. By default `get_midddle_nodes()` returns a single character vector of middle node names across *all* of the paths supplied. By using `collapse = FALSE`, the names of middle nodes can be returned for every source-target pair. When `collapse = FALSE`, this function enumerates all source-target pairs in `tibble` form. For every pair of source and target nodes in the paths object supplied, the final column (called `middle_nodes`) provides the names of the middle nodes as a character vector. (`middle_nodes` is a list-column.)

```
get_middle_nodes(g_small, paths, collapse = FALSE)
```

```
## Joining with `by = join_by(name)`
## Joining with `by = join_by(path_group, path_id)`
```

```
## # A tibble: 51 × 3
## # Groups:   from [3]
##    from               to                  middle_nodes
##    <chr>              <chr>               <list>
##  1 Sickle Cell Anemia Algid malaria       <chr [2]>
##  2 Sickle Cell Anemia Congenital malaria  <chr [33]>
##  3 Sickle Cell Anemia Induced malaria     <chr [19]>
##  4 Sickle Cell Anemia MALARIA RELAPSE     <chr [4]>
##  5 Sickle Cell Anemia Malaria             <chr [0]>
##  6 Sickle Cell Anemia Malaria, Avian      <chr [21]>
##  7 Sickle Cell Anemia Malaria, Cerebral   <chr [323]>
##  8 Sickle Cell Anemia Malaria, Falciparum <chr [422]>
##  9 Sickle Cell Anemia Malaria, Vivax      <chr [0]>
## 10 Sickle Cell Anemia Malarial hepatitis  <chr [5]>
## # ℹ 41 more rows
```

The `make_edge_weights` function can also encourage certain features. Below we simultaneously discourage the `"humn"` and `"popg"` semantic types and encourage the `"gngm"` and `"aapp"` semantic types.

```
w <- make_edge_weights(g_small, e_feat,
    node_semtypes_out = c("humn", "popg"),
    node_semtypes_in = c("gngm", "aapp")
)

paths_subset_reweight <- find_paths(
    graph = g_small,
    from = find_nodes(g_small, pattern = "sickle trait"),
    to = find_nodes(g_small, pattern = "Malaria, Cerebral"),
    weights = w
)
paths_subset_reweight <- paths_subset_reweight[[1]]
length(paths_subset_reweight)
```

```
## [1] 19
```

#### 3.3.1.5 Summarizing information in paths

When there are many shortest paths, it can be useful to get a high-level summary of the nodes and edges on those paths. The `rsemmed::summarize_semtypes()` function tabulates the semantic types of nodes on paths, and the `rsemmed::summarize_predicates()` functions tabulates the predicates of the edges.

`summarize_semtypes()` removes the first and last node from the paths by default because that information is generally easily accessible by using `nodes_from$semtype` and `nodes_to$semtype`. Further, if the start and end nodes are not removed, they would be duplicated in the tabulation a number of times equal to the number of paths, which likely is not desirable.

`summarize_semtypes()` invisibly returns a `tibble` where each row corresponds to a pair of source (`from`) and target (`to`) nodes in the paths object supplied, and the final `semtypes` column is a list-column containing a `table` of semantic type information. It automatically prints the semantic type tabulations for each `from`-`to` pair, but if you would like to turn off printing, use `print = FALSE`.

```
## Reweighted paths from "sickle trait" to "Malaria, Cerebral"
semtype_summary <- summarize_semtypes(g_small, paths_subset_reweight)
```

```
## Joining with `by = join_by(name)`
## Joining with `by = join_by(path_group, path_id)`
```

```
## sickle trait ----------> Malaria, Cerebral
## semtypes
## aapp gngm bacs phsu imft topp horm lbpr orch bodm bdsu bpoc diap elii enzy genf
##   38   36   26    8    6    6    4    4    3    2    1    1    1    1    1    1
## hlca inch mbrt nusq strd virs
##    1    1    1    1    1    1
```

```
semtype_summary
```

```
## # A tibble: 1 × 3
## # Groups:   from [1]
##   from         to                semtypes
##   <chr>        <chr>             <list>
## 1 sickle trait Malaria, Cerebral <table [22]>
```

```
semtype_summary$semtypes[[1]]
```

```
## semtypes
## aapp gngm bacs phsu imft topp horm lbpr orch bodm bdsu bpoc diap elii enzy genf
##   38   36   26    8    6    6    4    4    3    2    1    1    1    1    1    1
## hlca inch mbrt nusq strd virs
##    1    1    1    1    1    1
```

```
## Original paths from "sickle" to "malaria"-related notes
summarize_semtypes(g_small, paths)
```

```
## Joining with `by = join_by(name)`
## Joining with `by = join_by(path_group, path_id)`
```

```
## Sickle Cell Anemia ----------> Algid malaria
## semtypes
## dsyn orch patf
##    2    1    1
##
## Sickle Cell Anemia ----------> Congenital malaria
## semtypes
## dsyn humn popg anim mamm patf phsu aggp famg emst fndg orch aapp bacs bact bdsu
##   12   11    7    5    4    4    4    3    3    2    2    2    1    1    1    1
## celc cell diap elii gngm hlca imft inpr invt lbpr neop orgf orgm sosy tisu
##    1    1    1    1    1    1    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Anemia ----------> Induced malaria
## semtypes
## gngm aapp phsu imft bpoc topp dsyn humn bacs horm mamm popg aggp anim carb chvs
##    9    8    7    6    4    4    3    3    2    2    2    2    1    1    1    1
## hlca inch inpr lbpr nsba orch ortf prog
##    1    1    1    1    1    1    1    1
##
## Sickle Cell Anemia ----------> MALARIA RELAPSE
## semtypes
## hlca humn invt mamm popg resa topp
##    1    1    1    1    1    1    1
##
## Sickle Cell Anemia ----------> Malaria
## integer(0)
##
## Sickle Cell Anemia ----------> Malaria, Avian
## semtypes
## dsyn phsu aapp gngm orch bpoc elii fndg genf lbpr topp bacs bdsu celc chvf enzy
##    9    5    3    3    3    2    2    2    2    2    2    1    1    1    1    1
## hlca imft inch mbrt medd neop nusq orga orgf patf sosy tisu
##    1    1    1    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Anemia ----------> Malaria, Cerebral
## semtypes
## dsyn aapp gngm phsu topp bacs patf fndg hlca imft orch humn sosy bpoc lbpr popg
##   91   73   69   68   51   48   37   27   27   27   25   24   19   18   13    9
## horm inpo anim diap enzy mobd orgf comd aggp carb eico mamm medd prog acab elii
##    8    8    7    7    7    7    7    6    5    5    5    5    5    5    4    4
## lipd ortf chvf famg genf hops inch mbrt neop npop orga orgm podg tisu virs vita
##    4    4    3    3    3    3    3    3    3    3    3    3    3    3    3    3
## antb celc celf chem chvs inpr irda nnon rcpt resa resd strd bdsu biof blor bodm
##    2    2    2    2    2    2    2    2    2    2    2    2    1    1    1    1
## emod emst grup idcn invt lbtr menp nusq phsf
##    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Anemia ----------> Malaria, Falciparum
## semtypes
## dsyn aapp gngm phsu bacs humn topp hlca patf fndg imft popg orch lbpr sosy bpoc
##  113   90   85   71   56   56   54   43   40   32   30   30   26   22   15   13
## orgf diap elii horm aggp orga prog virs chvf enzy famg genf inpo anim inch mbrt
##   13    9    9    9    8    7    7    7    6    6    6    6    6    5    5    5
## neop ortf acab carb hops mobd orgm podg vita celc cell chem comd grup lipd medd
##    5    5    4    4    4    4    4    4    4    3    3    3    3    3    3    3
## nnon bodm celf chvs eico mamm mnob phsf rcpt resa tisu antb bact bdsu blor clna
##    3    2    2    2    2    2    2    2    2    2    2    1    1    1    1    1
## dora emst inpr invt lbtr npop nsba nusq resd strd
##    1    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Anemia ----------> Malaria, Vivax
## integer(0)
##
## Sickle Cell Anemia ----------> Malarial hepatitis
## semtypes
## dsyn comd diap hlca humn inpo patf popg
##    3    1    1    1    1    1    1    1
##
## Sickle Cell Anemia ----------> Malarial nephrosis
## semtypes
## aggp humn inpr popg
##    1    1    1    1
##
## Sickle Cell Anemia ----------> Mixed malaria
## semtypes
## dsyn humn phsu popg aggp bacs bird chvs hlca inch inpr invt orch orgf patf
##    4    2    2    2    1    1    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Anemia ----------> Ovale malaria
## semtypes
## humn popg dsyn aapp gngm aggp phsu topp anim bacs enzy horm imft inpr medd patf
##    8    6    4    3    3    2    2    2    1    1    1    1    1    1    1    1
## prog
##    1
##
## Sickle Cell Anemia ----------> Plasmodium malariae
## semtypes
## dsyn patf invt
##    9    3    1
##
## Sickle Cell Anemia ----------> Plasmodium malariae infection
## semtypes
## dsyn humn gngm popg aapp lbpr phsu hlca topp aggp orch patf bpoc bacs cell elii
##   16   12    8    8    7    7    7    6    6    5    5    5    3    2    2    2
## fndg imft mbrt sosy virs anim bdsu celc clna comd diap enzy genf inpo inpr invt
##    2    2    2    2    2    1    1    1    1    1    1    1    1    1    1    1
## lbtr medd mnob mobd neop tisu
##    1    1    1    1    1    1
##
## Sickle Cell Anemia ----------> Quartan malaria
## semtypes
## dsyn humn popg hlca aggp anim grup inpr invt lbpr mamm orch patf phsu topp
##    5    5    4    2    1    1    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Anemia ----------> Simian malaria
## semtypes
## gngm aapp imft phsu humn bacs dsyn orch topp bpoc celc neop popg anim bird carb
##    6    5    5    5    4    3    3    3    3    2    2    2    2    1    1    1
## chem chvs elii emst grup hlca lbpr mamm patf prog
##    1    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Trait ----------> Algid malaria
## semtypes
## dsyn orch patf
##    2    1    1
##
## Sickle Cell Trait ----------> Congenital malaria
## semtypes
## humn dsyn popg anim aggp famg fndg orgm patf bacs imft inpr invt mamm orgf phsu
##    9    6    6    4    3    2    2    2    2    1    1    1    1    1    1    1
## sosy
##    1
##
## Sickle Cell Trait ----------> Induced malaria
## semtypes
## humn bpoc gngm popg aapp aggp anim bacs dsyn inpr mamm ortf prog
##    3    2    2    2    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Trait ----------> MALARIA RELAPSE
## semtypes
## humn popg
##    1    1
##
## Sickle Cell Trait ----------> Malaria
## integer(0)
##
## Sickle Cell Trait ----------> Malaria, Avian
## semtypes
## dsyn fndg bpoc celc chvf genf humn invt neop orgf orgm popg sosy
##    3    2    1    1    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Trait ----------> Malaria, Cerebral
## semtypes
## dsyn humn patf fndg bacs gngm topp aapp bpoc phsu popg sosy aggp hlca imft orch
##   33   16   14   12   10    9    9    8    8    8    8    6    5    5    4    4
## orgf anim comd famg inpo medd orgm acab chvf lbpr mobd npop carb celc genf inch
##    4    3    3    3    3    3    3    2    2    2    2    2    1    1    1    1
## inpr invt lipd mamm neop ortf prog resd vita
##    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Trait ----------> Malaria, Falciparum
## integer(0)
##
## Sickle Cell Trait ----------> Malaria, Vivax
## semtypes
## dsyn humn popg patf hlca aggp bacs fndg gngm orgf topp phsu aapp anim bpoc imft
##   25   25   16   11    7    5    5    5    5    5    5    4    3    3    3    3
## inpo sosy comd famg orch orgm prog bird blor celc chvf clna diap edac genf grup
##    3    3    2    2    2    2    2    1    1    1    1    1    1    1    1    1
## inch inpr invt lbpr lbtr mbrt mnob mobd neop npop ortf podg virs
##    1    1    1    1    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Trait ----------> Malarial hepatitis
## semtypes
## dsyn comd humn inpo patf popg
##    3    1    1    1    1    1
##
## Sickle Cell Trait ----------> Malarial nephrosis
## semtypes
## aggp humn inpr popg
##    1    1    1    1
##
## Sickle Cell Trait ----------> Mixed malaria
## semtypes
## humn popg aggp bird dsyn inpr orgf
##    2    2    1    1    1    1    1
##
## Sickle Cell Trait ----------> Ovale malaria
## semtypes
## humn popg dsyn aggp anim inpr invt orgm patf prog
##    7    5    4    2    1    1    1    1    1    1
##
## Sickle Cell Trait ----------> Plasmodium malariae
## semtypes
## dsyn invt orgm
##    6    1    1
##
## Sickle Cell Trait ----------> Plasmodium malariae infection
## semtypes
## humn dsyn popg patf aggp topp gngm hlca aapp anim bacs bpoc celc clna comd fndg
##    9    8    7    4    3    3    2    2    1    1    1    1    1    1    1    1
## genf inpo inpr invt lbpr lbtr mbrt mnob neop orch orgm phsu sosy virs
##    1    1    1    1    1    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Trait ----------> Quartan malaria
## semtypes
## humn popg dsyn aggp anim grup hlca inpr invt mamm orgm topp
##    5    4    3    1    1    1    1    1    1    1    1    1
##
## Sickle Cell Trait ----------> Simian malaria
## semtypes
## humn popg bird bpoc celc dsyn gngm invt neop orgm prog topp
##    3    2    1    1    1    1    1    1    1    1    1    1
##
## sickle trait ----------> Algid malaria
## semtypes
## dsyn humn topp patf orch popg aggp anim famg hlca fndg inpr orgm grup medd prog
##   66   45   34   26   23   22   15   14   12   11    5    5    5    3    2    2
## aapp bacs gngm neop
##    1    1    1    1
##
## sickle trait ----------> Congenital malaria
## semtypes
## humn aggp anim popg dsyn famg inpr orgm
##    5    3    3    3    2    1    1    1
##
## sickle trait ----------> Induced malaria
## semtypes
## aggp humn inpr popg
##    1    1    1    1
##
## sickle trait ----------> MALARIA RELAPSE
## semtypes
## hlca humn phsu orch popg dsyn topp resa aggp anim mamm famg imft fndg inpr grup
##   58   58   47   40   36   34   34   26   18   16   14   12    9    8    8    4
## orgm patf invt neop diap aapp bacs bdsu gngm prog tisu
##    4    4    3    3    2    1    1    1    1    1    1
##
## sickle trait ----------> Malaria
## semtypes
## humn dsyn popg famg aggp anim hlca fndg aapp bacs gngm grup inpr orgm patf topp
##   13    7    7    4    3    3    3    2    1    1    1    1    1    1    1    1
##
## sickle trait ----------> Malaria, Avian
## semtypes
## dsyn humn popg phsu aapp gngm famg fndg aggp anim hlca topp orch lbpr elii bpoc
##  416  367  188  121  120  112  100   97   94   94   74   68   61   56   54   47
## genf tisu neop inch inpr enzy orgm bdsu orgf patf bacs celc imft grup mbrt nusq
##   46   44   41   37   36   34   34   33   33   32   31   29   28   26   23   23
## sosy prog cell chvf medd invt orga bird npop
##   19   16   15   11   11   10   10    8    6
##
## sickle trait ----------> Malaria, Cerebral
## semtypes
## humn aggp dsyn popg anim fndg hlca inpr patf topp
##    3    2    2    2    1    1    1    1    1    1
##
## sickle trait ----------> Malaria, Falciparum
## integer(0)
##
## sickle trait ----------> Malaria, Vivax
## semtypes
## humn dsyn popg aggp anim famg hlca inpr orgm topp
##    6    4    4    3    3    1    1    1    1    1
##
## sickle trait ----------> Malarial hepatitis
## semtypes
## dsyn humn popg hlca patf comd inpo diap aggp anim famg fndg inpr topp grup orgm
##  112   80   52   32   30   27   27   20   17   17   16    7    6    6    5    5
## neop aapp bacs bdsu gngm medd prog tisu
##    3    2    2    2    2    2    2    2
##
## sickle trait ----------> Malarial nephrosis
## semtypes
## aggp humn inpr popg
##    1    1    1    1
##
## sickle trait ----------> Mixed malaria
## semtypes
## aggp humn inpr popg
##    1    1    1    1
##
## sickle trait ----------> Ovale malaria
## semtypes
## humn popg aggp anim dsyn inpr
##    2    2    1    1    1    1
##
## sickle trait ----------> Plasmodium malariae
## semtypes
## dsyn humn popg patf aggp anim famg hlca orgm inpr invt fndg topp grup neop prog
##  252  114   61   44   38   37   28   20   20   14   12   11   11   10    6    3
## aapp bacs gngm
##    1    1    1
##
## sickle trait ----------> Plasmodium malariae infection
## semtypes
## humn aggp popg anim inpr
##    3    2    2    1    1
##
## sickle trait ----------> Quartan malaria
## semtypes
## humn aggp grup hlca inpr popg topp
##    2    1    1    1    1    1    1
##
## sickle trait ----------> Simian malaria
## semtypes
## humn dsyn gngm popg aapp phsu imft anim topp hlca aggp bacs orch famg bpoc neop
##  290  264  147  144  118  108  102   97   78   74   65   65   65   63   57   47
## patf fndg mamm celc grup prog lbpr inpr orgm carb elii bdsu emst tisu cell orgt
##   41   38   38   34   32   31   29   24   23   19   19   13   13   13   10    9
## invt bird orgf chem chvs medd
##    8    6    6    2    2    2
```

The `summarize_predicates()` function works similarly to give information on predicate counts.

```
edge_summary <- summarize_predicates(g_small, paths)
```

```
## Joining with `by = join_by(name)`
## Joining with `by = join_by(path_group, path_id)`
## Joining with `by = join_by(from, to, grand_path_id, name1, name2)`
```

```
## Sickle Cell Anemia ----------> Algid malaria
## .
##        CAUSES COEXISTS_WITH       AFFECTS   COMPLICATES           ISA
##             4             3             1             1             1
##   PREDISPOSES
##             1
##
## Sickle Cell Anemia ----------> Congenital malaria
## .
##        PROCESS_OF     COEXISTS_WITH           AFFECTS         OCCURS_IN
##                28                23                20                15
##            CAUSES       PREDISPOSES       LOCATION_OF   ASSOCIATED_WITH
##                 8                 7                 6                 4
##       COMPLICATES               ISA     NEG_OCCURS_IN    NEG_PROCESS_OF
##                 3                 3                 3                 3
##         DIAGNOSES  MANIFESTATION_OF NEG_COEXISTS_WITH          PRODUCES
##                 2                 1                 1                 1
##
## Sickle Cell Anemia ----------> Induced malaria
## .
##   ASSOCIATED_WITH        PROCESS_OF           AFFECTS            TREATS
##                12                10                 8                 5
##     COEXISTS_WITH          PREVENTS       LOCATION_OF         OCCURS_IN
##                 4                 3                 2                 2
##       PREDISPOSES            CAUSES               ISA NEG_COEXISTS_WITH
##                 2                 1                 1                 1
##     NEG_OCCURS_IN    NEG_PROCESS_OF
##                 1                 1
##
## Sickle Cell Anemia ----------> MALARIA RELAPSE
## .
## PROCESS_OF     CAUSES NEG_TREATS   PREVENTS     TREATS
##          4          2          1          1          1
##
## Sickle Cell Anemia ----------> Malaria
## .
##        CAUSES COEXISTS_WITH       AFFECTS   PREDISPOSES
##             2             2             1             1
##
## Sickle Cell Anemia ----------> Malaria, Avian
## .
##     COEXISTS_WITH           AFFECTS   ASSOCIATED_WITH            CAUSES
##                15                10                 9                 8
##            TREATS       LOCATION_OF       PREDISPOSES               ISA
##                 8                 7                 3                 2
##         OCCURS_IN       COMPLICATES  MANIFESTATION_OF NEG_COEXISTS_WITH
##                 2                 1                 1                 1
##          PRODUCES
##                 1
##
## Sickle Cell Anemia ----------> Malaria, Cerebral
## .
##       COEXISTS_WITH     ASSOCIATED_WITH              TREATS             AFFECTS
##                 243                 164                 150                 136
##              CAUSES          PROCESS_OF         PREDISPOSES            PREVENTS
##                 132                  67                  51                  36
##           OCCURS_IN         LOCATION_OF           DIAGNOSES            AUGMENTS
##                  32                  31                  29                  24
##         COMPLICATES                 ISA    MANIFESTATION_OF            PRODUCES
##                  23                  23                  19                  17
##            DISRUPTS      NEG_PROCESS_OF          NEG_TREATS   NEG_COEXISTS_WITH
##                  15                  10                   7                   6
## NEG_ASSOCIATED_WITH            PRECEDES          NEG_CAUSES         NEG_AFFECTS
##                   5                   5                   4                   3
##     NEG_PREDISPOSES       NEG_DIAGNOSES     NEG_LOCATION_OF       NEG_OCCURS_IN
##                   2                   1                   1                   1
##             PART_OF
##                   1
##
## Sickle Cell Anemia ----------> Malaria, Falciparum
## .
##       COEXISTS_WITH     ASSOCIATED_WITH              TREATS             AFFECTS
##                 296                 216                 194                 142
##          PROCESS_OF              CAUSES           OCCURS_IN           DIAGNOSES
##                 125                 119                  52                  51
##         PREDISPOSES         COMPLICATES         LOCATION_OF            AUGMENTS
##                  49                  33                  30                  28
##            PREVENTS                 ISA    MANIFESTATION_OF            PRODUCES
##                  19                  15                  14                  14
##          NEG_TREATS            DISRUPTS            PRECEDES      NEG_PROCESS_OF
##                  13                  12                   8                   7
## NEG_ASSOCIATED_WITH   NEG_COEXISTS_WITH      INTERACTS_WITH         NEG_AFFECTS
##                   5                   4                   2                   2
##       NEG_DIAGNOSES       NEG_OCCURS_IN        NEG_PREVENTS          NEG_CAUSES
##                   2                   2                   2                   1
##        NEG_DISRUPTS     NEG_LOCATION_OF     NEG_PREDISPOSES        NEG_PRODUCES
##                   1                   1                   1                   1
##
## Sickle Cell Anemia ----------> Malaria, Vivax
## COEXISTS_WITH
##             1
##
## Sickle Cell Anemia ----------> Malarial hepatitis
## .
## COEXISTS_WITH        CAUSES       AFFECTS     DIAGNOSES           ISA
##             5             4             2             2             2
##    PROCESS_OF   PREDISPOSES
##             2             1
##
## Sickle Cell Anemia ----------> Malarial nephrosis
## .
##     PROCESS_OF        AFFECTS  NEG_OCCURS_IN NEG_PROCESS_OF      OCCURS_IN
##              2              1              1              1              1
##
## Sickle Cell Anemia ----------> Mixed malaria
## .
##     COEXISTS_WITH           AFFECTS        PROCESS_OF            CAUSES
##                 7                 6                 6                 5
##   ASSOCIATED_WITH         OCCURS_IN       PREDISPOSES            TREATS
##                 4                 2                 2                 2
##       COMPLICATES               ISA  MANIFESTATION_OF NEG_COEXISTS_WITH
##                 1                 1                 1                 1
##     NEG_OCCURS_IN    NEG_PROCESS_OF
##                 1                 1
##
## Sickle Cell Anemia ----------> Ovale malaria
## .
##        PROCESS_OF           AFFECTS     COEXISTS_WITH   ASSOCIATED_WITH
##                16                 8                 8                 6
##            CAUSES         OCCURS_IN    NEG_PROCESS_OF            TREATS
##                 5                 5                 4                 4
##       PREDISPOSES     NEG_OCCURS_IN       COMPLICATES NEG_COEXISTS_WITH
##                 3                 2                 1                 1
##
## Sickle Cell Anemia ----------> Plasmodium malariae
## .
##    COEXISTS_WITH           CAUSES          AFFECTS       PROCESS_OF
##               13               12                5                5
##      PREDISPOSES      COMPLICATES   INTERACTS_WITH MANIFESTATION_OF
##                3                2                1                1
##        OCCURS_IN
##                1
##
## Sickle Cell Anemia ----------> Plasmodium malariae infection
## .
##     COEXISTS_WITH        PROCESS_OF           AFFECTS            TREATS
##                37                25                19                18
##            CAUSES         DIAGNOSES         OCCURS_IN   ASSOCIATED_WITH
##                16                10                10                 8
##       LOCATION_OF       PREDISPOSES    NEG_PROCESS_OF       COMPLICATES
##                 8                 7                 4                 3
##          AUGMENTS  MANIFESTATION_OF     NEG_DIAGNOSES        NEG_TREATS
##                 2                 2                 2                 2
##               ISA NEG_COEXISTS_WITH     NEG_OCCURS_IN          PRODUCES
##                 1                 1                 1                 1
##
## Sickle Cell Anemia ----------> Quartan malaria
## .
##     COEXISTS_WITH        PROCESS_OF           AFFECTS            CAUSES
##                13                12                 8                 7
##         OCCURS_IN       PREDISPOSES            TREATS         DIAGNOSES
##                 5                 4                 3                 2
##               ISA          PRECEDES          PREVENTS       COMPLICATES
##                 2                 2                 2                 1
## NEG_COEXISTS_WITH     NEG_OCCURS_IN    NEG_PROCESS_OF
##                 1                 1                 1
##
## Sickle Cell Anemia ----------> Simian malaria
## .
## ASSOCIATED_WITH      PROCESS_OF          TREATS   COEXISTS_WITH         AFFECTS
##              12              11              10               8               5
##          CAUSES     LOCATION_OF     PREDISPOSES        DISRUPTS             ISA
##               2               2               2               1               1
##         PART_OF
##               1
##
## Sickle Cell Trait ----------> Algid malaria
## .
##     COEXISTS_WITH            CAUSES       COMPLICATES               ISA
##                 4                 3                 1                 1
##       NEG_AFFECTS NEG_COEXISTS_WITH       PREDISPOSES
##                 1                 1                 1
##
## Sickle Cell Trait ----------> Congenital malaria
## .
##        PROCESS_OF           AFFECTS     COEXISTS_WITH         OCCURS_IN
##                18                11                 8                 8
##       PREDISPOSES            CAUSES   ASSOCIATED_WITH               ISA
##                 6                 5                 2                 2
## NEG_COEXISTS_WITH          AUGMENTS       NEG_AFFECTS     NEG_OCCURS_IN
##                 2                 1                 1                 1
##    NEG_PROCESS_OF
##                 1
##
## Sickle Cell Trait ----------> Induced malaria
## .
##      PROCESS_OF         AFFECTS ASSOCIATED_WITH     LOCATION_OF
##               8               2               2               2
##
## Sickle Cell Trait ----------> MALARIA RELAPSE
## PROCESS_OF
##          2
##
## Sickle Cell Trait ----------> Malaria
## .
##     COEXISTS_WITH            CAUSES       NEG_AFFECTS NEG_COEXISTS_WITH
##                 2                 1                 1                 1
##       PREDISPOSES
##                 1
##
## Sickle Cell Trait ----------> Malaria, Avian
## .
##     COEXISTS_WITH            CAUSES           AFFECTS       LOCATION_OF
##                 8                 6                 4                 4
##        PROCESS_OF   ASSOCIATED_WITH       NEG_AFFECTS NEG_COEXISTS_WITH
##                 3                 2                 2                 1
##         OCCURS_IN       PREDISPOSES            TREATS
##                 1                 1                 1
##
## Sickle Cell Trait ----------> Malaria, Cerebral
## .
##       COEXISTS_WITH          PROCESS_OF              CAUSES             AFFECTS
##                  69                  39                  35                  27
##     ASSOCIATED_WITH              TREATS         COMPLICATES         PREDISPOSES
##                  27                  15                  12                  11
##         LOCATION_OF           OCCURS_IN                 ISA            AUGMENTS
##                  10                  10                   8                   5
##         NEG_AFFECTS   NEG_COEXISTS_WITH      NEG_PROCESS_OF           DIAGNOSES
##                   5                   4                   4                   3
##          NEG_CAUSES            PRECEDES            PREVENTS            PRODUCES
##                   3                   3                   3                   3
##    MANIFESTATION_OF       NEG_OCCURS_IN            DISRUPTS NEG_ASSOCIATED_WITH
##                   2                   2                   1                   1
##     NEG_PREDISPOSES
##                   1
##
## Sickle Cell Trait ----------> Malaria, Falciparum
## PREDISPOSES
##           1
##
## Sickle Cell Trait ----------> Malaria, Vivax
## .
##     COEXISTS_WITH        PROCESS_OF            CAUSES           AFFECTS
##                59                53                26                22
##   ASSOCIATED_WITH         OCCURS_IN       PREDISPOSES       COMPLICATES
##                12                 9                 8                 7
##               ISA       LOCATION_OF            TREATS         DIAGNOSES
##                 6                 6                 6                 4
##       NEG_AFFECTS          AUGMENTS  MANIFESTATION_OF          DISRUPTS
##                 4                 2                 2                 1
## NEG_COEXISTS_WITH     NEG_OCCURS_IN   NEG_PREDISPOSES    NEG_PROCESS_OF
##                 1                 1                 1                 1
##          PRECEDES          PREVENTS
##                 1                 1
##
## Sickle Cell Trait ----------> Malarial hepatitis
## .
##     COEXISTS_WITH            CAUSES               ISA        PROCESS_OF
##                 3                 2                 2                 2
##          AUGMENTS       NEG_AFFECTS NEG_COEXISTS_WITH       PREDISPOSES
##                 1                 1                 1                 1
##
## Sickle Cell Trait ----------> Malarial nephrosis
## .
## PROCESS_OF    AFFECTS
##          2          1
##
## Sickle Cell Trait ----------> Mixed malaria
## .
##        PROCESS_OF           AFFECTS   ASSOCIATED_WITH            CAUSES
##                 6                 2                 2                 2
##     COEXISTS_WITH       NEG_AFFECTS NEG_COEXISTS_WITH       PREDISPOSES
##                 2                 1                 1                 1
##
## Sickle Cell Trait ----------> Ovale malaria
## .
##        PROCESS_OF     COEXISTS_WITH           AFFECTS            CAUSES
##                15                 7                 4                 3
##         OCCURS_IN       PREDISPOSES          AUGMENTS       COMPLICATES
##                 3                 2                 1                 1
##       NEG_AFFECTS NEG_COEXISTS_WITH    NEG_PROCESS_OF
##                 1                 1                 1
##
## Sickle Cell Trait ----------> Plasmodium malariae
## .
##            CAUSES     COEXISTS_WITH        PROCESS_OF           AFFECTS
##                 7                 5                 3                 2
## NEG_COEXISTS_WITH          AUGMENTS    INTERACTS_WITH               ISA
##                 2                 1                 1                 1
##       NEG_AFFECTS       PREDISPOSES
##                 1                 1
##
## Sickle Cell Trait ----------> Plasmodium malariae infection
## .
##        PROCESS_OF     COEXISTS_WITH            CAUSES           AFFECTS
##                19                15                 8                 7
##         OCCURS_IN          AUGMENTS         DIAGNOSES       LOCATION_OF
##                 6                 2                 2                 2
## NEG_COEXISTS_WITH       PREDISPOSES            TREATS               ISA
##                 2                 2                 2                 1
##  MANIFESTATION_OF       NEG_AFFECTS    NEG_PROCESS_OF
##                 1                 1                 1
##
## Sickle Cell Trait ----------> Quartan malaria
## .
##        PROCESS_OF     COEXISTS_WITH            CAUSES           AFFECTS
##                13                 5                 4                 2
## NEG_COEXISTS_WITH       PREDISPOSES               ISA       NEG_AFFECTS
##                 2                 2                 1                 1
##         OCCURS_IN          PRECEDES          PREVENTS
##                 1                 1                 1
##
## Sickle Cell Trait ----------> Simian malaria
## .
##        PROCESS_OF     COEXISTS_WITH           AFFECTS            CAUSES
##                 9                 4                 2                 2
##       LOCATION_OF       NEG_AFFECTS            TREATS               ISA
##                 2                 2                 2                 1
## NEG_COEXISTS_WITH       PREDISPOSES
##                 1                 1
##
## sickle trait ----------> Algid malaria
## .
##          PROCESS_OF              TREATS              CAUSES       COEXISTS_WITH
##                  69                  69                  42                  29
##                 ISA         COMPLICATES             AFFECTS           OCCURS_IN
##                  27                  24                  23                  14
##     ADMINISTERED_TO         PREDISPOSES      NEG_PROCESS_OF            PREVENTS
##                  10                  10                   9                   7
##           METHOD_OF     ASSOCIATED_WITH NEG_ADMINISTERED_TO         NEG_AFFECTS
##                   6                   4                   4                   3
##          NEG_TREATS            AUGMENTS       NEG_OCCURS_IN        NEG_PREVENTS
##                   3                   2                   2                   2
##           DIAGNOSES    MANIFESTATION_OF   NEG_COEXISTS_WITH     NEG_PREDISPOSES
##                   1                   1                   1                   1
##            PRECEDES                USES
##                   1                   1
##
## sickle trait ----------> Congenital malaria
## .
##    PROCESS_OF     OCCURS_IN       AFFECTS COEXISTS_WITH NEG_OCCURS_IN
##             9             4             3             2             1
##
## sickle trait ----------> Induced malaria
## PROCESS_OF
##          2
##
## sickle trait ----------> MALARIA RELAPSE
## .
##          PROCESS_OF              TREATS            PREVENTS     ADMINISTERED_TO
##                  85                  79                  53                  37
##       COEXISTS_WITH              CAUSES         PREDISPOSES            DISRUPTS
##                  30                  27                  11                  10
## NEG_ADMINISTERED_TO                USES          NEG_TREATS             AFFECTS
##                   9                   9                   8                   7
##                 ISA             PART_OF       compared_with           METHOD_OF
##                   6                   6                   5                   4
##            PRECEDES         higher_than          lower_than             same_as
##                   2                   2                   2                   2
##     ASSOCIATED_WITH            AUGMENTS      INTERACTS_WITH         LOCATION_OF
##                   1                   1                   1                   1
##       NEG_METHOD_OF      NEG_PROCESS_OF            NEG_USES      NEG_lower_than
##                   1                   1                   1                   1
##           OCCURS_IN
##                   1
##
## sickle trait ----------> Malaria
## .
##      PROCESS_OF   COEXISTS_WITH         AFFECTS       OCCURS_IN          CAUSES
##              26              14              12              10               8
##  NEG_PROCESS_OF     PREDISPOSES          TREATS ASSOCIATED_WITH        PREVENTS
##               6               6               6               4               3
##        AUGMENTS     NEG_AFFECTS   NEG_OCCURS_IN      NEG_TREATS             ISA
##               2               2               2               2               1
## NEG_PREDISPOSES    NEG_PREVENTS
##               1               1
##
## sickle trait ----------> Malaria, Avian
## .
##          PROCESS_OF       COEXISTS_WITH              TREATS         LOCATION_OF
##                 544                 312                 229                 208
##             AFFECTS     ASSOCIATED_WITH              CAUSES             PART_OF
##                 168                 148                 142                 140
##         PREDISPOSES                 ISA           OCCURS_IN      NEG_PROCESS_OF
##                 104                  88                  79                  68
##     ADMINISTERED_TO     NEG_LOCATION_OF            PREVENTS         NEG_PART_OF
##                  46                  20                  20                  17
##                USES         NEG_AFFECTS          NEG_TREATS           DIAGNOSES
##                  16                  15                  15                   9
##           METHOD_OF            PRODUCES NEG_ASSOCIATED_WITH            AUGMENTS
##                   8                   8                   7                   6
##      INTERACTS_WITH       NEG_OCCURS_IN       compared_with         COMPLICATES
##                   5                   5                   5                   4
##     NEG_PREDISPOSES    MANIFESTATION_OF NEG_ADMINISTERED_TO   NEG_COEXISTS_WITH
##                   4                   3                   3                   3
##          STIMULATES        NEG_PREVENTS         higher_than            DISRUPTS
##                   3                   2                   2                   1
##          NEG_CAUSES            PRECEDES          lower_than             same_as
##                   1                   1                   1                   1
##
## sickle trait ----------> Malaria, Cerebral
## .
##  COEXISTS_WITH     PROCESS_OF         CAUSES        AFFECTS         TREATS
##              6              6              3              2              2
##    COMPLICATES            ISA  NEG_OCCURS_IN NEG_PROCESS_OF      OCCURS_IN
##              1              1              1              1              1
##       PRECEDES    PREDISPOSES       PREVENTS
##              1              1              1
##
## sickle trait ----------> Malaria, Falciparum
## COEXISTS_WITH
##             1
##
## sickle trait ----------> Malaria, Vivax
## .
##     PROCESS_OF  COEXISTS_WITH         TREATS        AFFECTS         CAUSES
##             12              6              2              1              1
## NEG_PROCESS_OF      OCCURS_IN       PRECEDES    PREDISPOSES       PREVENTS
##              1              1              1              1              1
##
## sickle trait ----------> Malarial hepatitis
## .
##          PROCESS_OF       COEXISTS_WITH              CAUSES                 ISA
##                 133                  68                  56                  29
##              TREATS           DIAGNOSES           OCCURS_IN             AFFECTS
##                  28                  27                  26                  22
##         PREDISPOSES      NEG_PROCESS_OF     ADMINISTERED_TO      INTERACTS_WITH
##                  19                  17                  12                  11
##     ASSOCIATED_WITH            PREVENTS NEG_ADMINISTERED_TO       NEG_OCCURS_IN
##                   6                   6                   5                   5
##          NEG_TREATS            AUGMENTS         COMPLICATES         NEG_AFFECTS
##                   4                   3                   3                   3
##                USES    MANIFESTATION_OF           METHOD_OF  NEG_INTERACTS_WITH
##                   3                   2                   2                   2
##        NEG_PREVENTS             PART_OF            PRECEDES         LOCATION_OF
##                   2                   2                   2                   1
##   NEG_COEXISTS_WITH     NEG_PREDISPOSES            NEG_USES
##                   1                   1                   1
##
## sickle trait ----------> Malarial nephrosis
## PROCESS_OF
##          2
##
## sickle trait ----------> Mixed malaria
## PROCESS_OF
##          2
##
## sickle trait ----------> Ovale malaria
## .
##    PROCESS_OF COEXISTS_WITH
##             4             2
##
## sickle trait ----------> Plasmodium malariae
## .
##        PROCESS_OF            CAUSES     COEXISTS_WITH           AFFECTS
##               329               205               117                66
##         OCCURS_IN            TREATS       PREDISPOSES    NEG_PROCESS_OF
##                53                39                34                32
##          PREVENTS       COMPLICATES    INTERACTS_WITH               ISA
##                13                11                10                 9
##       NEG_AFFECTS          PRECEDES   ASSOCIATED_WITH          AUGMENTS
##                 6                 5                 4                 4
##     NEG_OCCURS_IN  MANIFESTATION_OF        NEG_CAUSES        NEG_TREATS
##                 4                 3                 3                 3
##   NEG_PREDISPOSES      NEG_PREVENTS NEG_COEXISTS_WITH
##                 2                 2                 1
##
## sickle trait ----------> Plasmodium malariae infection
## .
## PROCESS_OF  OCCURS_IN
##          6          2
##
## sickle trait ----------> Quartan malaria
## .
## PROCESS_OF  OCCURS_IN   PREVENTS     TREATS
##          4          1          1          1
##
## sickle trait ----------> Simian malaria
## .
##          PROCESS_OF       COEXISTS_WITH              TREATS     ASSOCIATED_WITH
##                 470                 247                 217                 190
##         LOCATION_OF             AFFECTS             PART_OF     ADMINISTERED_TO
##                 112                  88                  80                  64
##         PREDISPOSES                 ISA              CAUSES      INTERACTS_WITH
##                  62                  44                  42                  42
##      NEG_PROCESS_OF           OCCURS_IN            DISRUPTS            PREVENTS
##                  33                  29                  19                  16
##                USES NEG_ADMINISTERED_TO     NEG_LOCATION_OF          NEG_TREATS
##                  13                  11                  11                  11
##         NEG_PART_OF            AUGMENTS           METHOD_OF  NEG_INTERACTS_WITH
##                   8                   6                   5                   5
##            PRODUCES         NEG_AFFECTS NEG_ASSOCIATED_WITH       compared_with
##                   5                   4                   4                   4
##           DIAGNOSES       NEG_OCCURS_IN        NEG_PREVENTS            PRECEDES
##                   2                   2                   2                   2
##          STIMULATES             same_as         COMPLICATES       NEG_METHOD_OF
##                   2                   2                   1                   1
##     NEG_PREDISPOSES        NEG_PRODUCES            NEG_USES         higher_than
##                   1                   1                   1                   1
##          lower_than
##                   1
```

```
edge_summary
```

```
## # A tibble: 51 × 3
## # Groups:   from [3]
##    from               to                  predicates
##    <chr>              <chr>               <list>
##  1 Sickle Cell Anemia Algid malaria       <table [6]>
##  2 Sickle Cell Anemia Congenital malaria  <table [16]>
##  3 Sickle Cell Anemia Induced malaria     <table [14]>
##  4 Sickle Cell Anemia MALARIA RELAPSE     <table [5]>
##  5 Sickle Cell Anemia Malaria             <table [4]>
##  6 Sickle Cell Anemia Malaria, Avian      <table [13]>
##  7 Sickle Cell Anemia Malaria, Cerebral   <table [29]>
##  8 Sickle Cell Anemia Malaria, Falciparum <table [32]>
##  9 Sickle Cell Anemia Malaria, Vivax      <int [1]>
## 10 Sickle Cell Anemia Malarial hepatitis  <table [7]>
## # ℹ 41 more rows
```

```
edge_summary$predicates[[1]]
```

```
## .
##        CAUSES COEXISTS_WITH       AFFECTS   COMPLICATES           ISA
##             4             3             1             1             1
##   PREDISPOSES
##             1
```

### 3.3.2 Aim 2: Expanding a single node set

Another way in which we can explore relations between ideas is to slowly expand a single set of ideas to see what other ideas are connected. We can do this with the `grow_nodes()` function. The `grow_nodes()` function takes a set of nodes and obtains the nodes that are directly connected to any of these nodes. That is, it obtains the set of nodes that are distance 1 away from the supplied nodes. We can call this set of nodes the “1-neighborhood” of the supplied nodes.

```
nodes_sickle_trait <- nodes_sickle[2:3]
nodes_sickle_trait
```

```
## + 2/1038 vertices, named, from f0c97f6:
## [1] Sickle Cell Trait sickle trait
```

```
nbrs_sickle_trait <- grow_nodes(g_small, nodes_sickle_trait)
nbrs_sickle_trait
```

```
## + 476/1038 vertices, named, from f0c97f6:
##   [1] Infant
##   [2] Control Groups
##   [3] Mus
##   [4] Diabetic
##   [5] Obstruction
##   [6] Carcinoma
##   [7] Neoplasm
##   [8] Nitric Oxide
##   [9] Renal tubular disorder
##  [10] Brain
## + ... omitted several vertices
```

Not all nodes in the 1-neighborhood will be useful, and we may wish to remove them with `find_nodes(..., match = FALSE)`. We can use `summarize_semtypes()` to begin to identify such nodes. Using the argument `is_path = FALSE` will change the format of the display and output to better suit this situation.

```
nbrs_sickle_trait_summ <- summarize_semtypes(g_small, nbrs_sickle_trait, is_path = FALSE)
```

```
## Joining with `by = join_by(name)`
## Joining with `by = join_by(name)`
## Adding missing grouping variables: `semtype`
```

```
## bacs --------------------
## # A tibble: 32 × 4
## # Groups:   semtype [1]
##    semtype name                         node_degree node_degree_perc
##    <chr>   <chr>                              <dbl>            <dbl>
##  1 bacs    Glucose                             3165             99.7
##  2 bacs    Nitric Oxide                        2961             99.4
##  3 bacs    Antigens                            2450             98.3
##  4 bacs    Hemoglobin                          2197             97.4
##  5 bacs    Insulin-Like Growth Factor I        1782             93.6
##  6 bacs    Lipoproteins                        1415             88.2
##  7 bacs    Phospholipids                       1346             86.4
##  8 bacs    Cell Adhesion Molecules             1306             85.3
##  9 bacs    Family                              1299             85.1
## 10 bacs    Vitamin A                           1023             79.1
## # ℹ 22 more rows
```

```
## Adding missing grouping variables: `semtype`
```

```
## bpoc --------------------
## # A tibble: 11 × 4
## # Groups:   semtype [1]
##    semtype name                                     node_degree node_degree_perc
##    <chr>   <chr>                                          <dbl>            <dbl>
##  1 bpoc    Glucose                                         3165            99.7
##  2 bpoc    Male population group                           1466            89.3
##  3 bpoc    Brain                                           1422            88.4
##  4 bpoc    Heart                                           1189            83.0
##  5 bpoc    Spleen                                           940            77.0
##  6 bpoc    Eye                                              877            75.0
##  7 bpoc    Renal tubular disorder                           814            72.5
##  8 bpoc    Chamber                                          431            52.7
##  9 bpoc    Splenomegaly                                     341            46.1
## 10 bpoc    High pressure liquid chromatography pro…         262            38.5
## 11 bpoc    Anterior chamber of eye structure                 20             4.24
```

```
## Adding missing grouping variables: `semtype`
```

```
## carb --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name    node_degree node_degree_perc
##   <chr>   <chr>         <dbl>            <dbl>
## 1 carb    Glucose        3165             99.7
```

```
## Adding missing grouping variables: `semtype`
```

```
## hlca --------------------
## # A tibble: 31 × 4
## # Groups:   semtype [1]
##    semtype name                          node_degree node_degree_perc
##    <chr>   <chr>                               <dbl>            <dbl>
##  1 hlca    Glucose                              3165             99.7
##  2 hlca    Operative Surgical Procedures        2379             98.1
##  3 hlca    Hemoglobin                           2197             97.4
##  4 hlca    Prophylactic treatment               1671             92.4
##  5 hlca    Detection                            1587             91.4
##  6 hlca    Epinephrine                          1451             89.1
##  7 hlca    FAVOR                                1383             87.0
##  8 hlca    Anesthetics                           870             75.0
##  9 hlca    follow-up                             865             74.7
## 10 hlca    Screening procedure                   828             73.0
## # ℹ 21 more rows
```

```
## Adding missing grouping variables: `semtype`
```

```
## phsu --------------------
## # A tibble: 16 × 4
## # Groups:   semtype [1]
##    semtype name                                     node_degree node_degree_perc
##    <chr>   <chr>                                          <dbl>            <dbl>
##  1 phsu    Glucose                                         3165             99.7
##  2 phsu    Antigens                                        2450             98.3
##  3 phsu    Hemoglobin                                      2197             97.4
##  4 phsu    Immunoglobulins                                 1509             90.0
##  5 phsu    Epinephrine                                     1451             89.1
##  6 phsu    Lipoproteins                                    1415             88.2
##  7 phsu    FAVOR                                           1383             87.0
##  8 phsu    Vitamin A                                       1023             79.1
##  9 phsu    Anesthetics                                      870             75.0
## 10 phsu    Protective Agents                                692             67.5
## 11 phsu    Phosphorus                                       593             62.1
## 12 phsu    Thioctic Acid                                    555             59.8
## 13 phsu    PTPN11 gene|PTPN11                               512             57.8
## 14 phsu    Polymerase Chain Reaction                        479             56.3
## 15 phsu    Hepatitis B Surface Antigens                     463             55.5
## 16 phsu    High pressure liquid chromatography pro…         262             38.5
```

```
## Adding missing grouping variables: `semtype`
```

```
## dsyn --------------------
## # A tibble: 173 × 4
## # Groups:   semtype [1]
##    semtype name                          node_degree node_degree_perc
##    <chr>   <chr>                               <dbl>            <dbl>
##  1 dsyn    Neoplasm                             3141             99.6
##  2 dsyn    Hypertensive disease                 2989             99.5
##  3 dsyn    Diabetes                             2925             99.3
##  4 dsyn    Injury                               2765             98.9
##  5 dsyn    Cerebrovascular accident             2399             98.2
##  6 dsyn    Operative Surgical Procedures        2379             98.1
##  7 dsyn    Septicemia                           2197             97.4
##  8 dsyn    Atherosclerosis                      2153             96.9
##  9 dsyn    Oxidative Stress                     2120             96.7
## 10 dsyn    Obstruction                          2074             96.5
## # ℹ 163 more rows
```

```
## Adding missing grouping variables: `semtype`
```

```
## fndg --------------------
## # A tibble: 57 × 4
## # Groups:   semtype [1]
##    semtype name                         node_degree node_degree_perc
##    <chr>   <chr>                              <dbl>            <dbl>
##  1 fndg    "Neoplasm"                          3141             99.6
##  2 fndg    "Hypertensive disease"              2989             99.5
##  3 fndg    "Growth"                            2162             97.1
##  4 fndg    "Lesion"                            1690             92.5
##  5 fndg    "Pre-Eclampsia"                     1549             90.8
##  6 fndg    "Pain"                              1378             86.8
##  7 fndg    "Little\\s Disease"                 1337             86.0
##  8 fndg    "Neoplasm Metastasis"               1303             85.2
##  9 fndg    "Systemic arterial pressure"        1235             84.1
## 10 fndg    "Carcinoma"                         1123             81.4
## # ℹ 47 more rows
```

```
## Adding missing grouping variables: `semtype`
```

```
## lbpr --------------------
## # A tibble: 19 × 4
## # Groups:   semtype [1]
##    semtype name                                     node_degree node_degree_perc
##    <chr>   <chr>                                          <dbl>            <dbl>
##  1 lbpr    Neoplasm                                        3141           99.6
##  2 lbpr    Immunoglobulins                                 1509           90.0
##  3 lbpr    Racial group                                     611           63.1
##  4 lbpr    PTPN11 gene|PTPN11                               512           57.8
##  5 lbpr    Polymerase Chain Reaction                        479           56.3
##  6 lbpr    CALCULATION                                      291           41.7
##  7 lbpr    High pressure liquid chromatography pro…         262           38.5
##  8 lbpr    Chromatography                                   170           28.2
##  9 lbpr    Fractionation                                    157           26.2
## 10 lbpr    Genetic screening method                         131           23.7
## 11 lbpr    Isoelectric Focusing                              94           18.3
## 12 lbpr    Serum iron                                        73           14.4
## 13 lbpr    Blood Cell Count                                  63           13.1
## 14 lbpr    Hemoglobin electrophoresis                        31            6.17
## 15 lbpr    Blood investigation                               27            5.39
## 16 lbpr    Hemoglobin A2 measurement                         24            5.01
## 17 lbpr    SOLUBILITY TEST                                   12            2.89
## 18 lbpr    Urine drug screening                               8            2.02
## 19 lbpr    Sickling test                                      4            0.771
```

```
## Adding missing grouping variables: `semtype`
```

```
## neop --------------------
## # A tibble: 14 × 4
## # Groups:   semtype [1]
##    semtype name                                 node_degree node_degree_perc
##    <chr>   <chr>                                      <dbl>            <dbl>
##  1 neop    "Neoplasm"                                  3141            99.6
##  2 neop    "Neoplasm Metastasis"                       1303            85.2
##  3 neop    "Carcinoma"                                 1123            81.4
##  4 neop    "host"                                       877            75.0
##  5 neop    "Multiple Myeloma"                           868            74.8
##  6 neop    "Renal Cell Carcinoma"                       830            73.3
##  7 neop    "Osteogenesis"                               588            61.7
##  8 neop    "Retinoblastoma"                             338            45.8
##  9 neop    "Burkitt Lymphoma"                           246            36.5
## 10 neop    "Medullary carcinoma"                        184            29.0
## 11 neop    "Histiocytoma, Malignant Fibrous"            156            25.9
## 12 neop    "[M]Neoplasm morphology NOS"                  59            11.9
## 13 neop    "African Burkitt\\s lymphoma"                 56            11.2
## 14 neop    "Collecting Duct Carcinoma (Kidney)"          44             8.77
```

```
## Adding missing grouping variables: `semtype`
```

```
## sosy --------------------
## # A tibble: 24 × 4
## # Groups:   semtype [1]
##    semtype name                 node_degree node_degree_perc
##    <chr>   <chr>                      <dbl>            <dbl>
##  1 sosy    Neoplasm                    3141             99.6
##  2 sosy    Hypertensive disease        2989             99.5
##  3 sosy    Asthma                      2036             96.0
##  4 sosy    Ischemia                    2034             95.9
##  5 sosy    Heart failure               1859             94.7
##  6 sosy    Ischemic stroke             1406             87.9
##  7 sosy    Pain                        1378             86.8
##  8 sosy    Thrombus                    1352             86.5
##  9 sosy    Neoplasm Metastasis         1303             85.2
## 10 sosy    Fever                       1087             80.6
## # ℹ 14 more rows
```

```
## Adding missing grouping variables: `semtype`
```

```
## inch --------------------
## # A tibble: 3 × 4
## # Groups:   semtype [1]
##   semtype name            node_degree node_degree_perc
##   <chr>   <chr>                 <dbl>            <dbl>
## 1 inch    Nitric Oxide           2961             99.4
## 2 inch    Bicarbonates            629             64.5
## 3 inch    WATER,DISTILLED         213             33.0
```

```
## Adding missing grouping variables: `semtype`
```

```
## topp --------------------
## # A tibble: 35 × 4
## # Groups:   semtype [1]
##    semtype name                          node_degree node_degree_perc
##    <chr>   <chr>                               <dbl>            <dbl>
##  1 topp    Nitric Oxide                         2961             99.4
##  2 topp    Interleukin-1 beta                   2718             98.8
##  3 topp    Operative Surgical Procedures        2379             98.1
##  4 topp    Hemoglobin                           2197             97.4
##  5 topp    Insulin-Like Growth Factor I         1782             93.6
##  6 topp    Prophylactic treatment               1671             92.4
##  7 topp    Detection                            1587             91.4
##  8 topp    Immunoglobulins                      1509             90.0
##  9 topp    Epinephrine                          1451             89.1
## 10 topp    Heart                                1189             83.0
## # ℹ 25 more rows
```

```
## Adding missing grouping variables: `semtype`
```

```
## comd --------------------
## # A tibble: 3 × 4
## # Groups:   semtype [1]
##   semtype name             node_degree node_degree_perc
##   <chr>   <chr>                  <dbl>            <dbl>
## 1 comd    Injury                  2765             98.9
## 2 comd    Oxidative Stress        2120             96.7
## 3 comd    Necrosis                1532             90.4
```

```
## Adding missing grouping variables: `semtype`
```

```
## inpo --------------------
## # A tibble: 14 × 4
## # Groups:   semtype [1]
##    semtype name                  node_degree node_degree_perc
##    <chr>   <chr>                       <dbl>            <dbl>
##  1 inpo    Injury                       2765            98.9
##  2 inpo    Oxidative Stress             2120            96.7
##  3 inpo    Necrosis                     1532            90.4
##  4 inpo    Wounds and Injuries          1114            81.3
##  5 inpo    Ulcer                         987            78.7
##  6 inpo    Suicide                       338            45.8
##  7 inpo    Compartment syndromes         255            38.0
##  8 inpo    Thermal injury                249            37.2
##  9 inpo    Heat Stroke                   212            32.9
## 10 inpo    Laceration                    193            30.2
## 11 inpo    Splenic Rupture                85            16.6
## 12 inpo    Heat exposure                  60            12.5
## 13 inpo    Heat Illness                   40             8.19
## 14 inpo    Traumatic hyphema              27             5.39
```

```
## Adding missing grouping variables: `semtype`
```

```
## patf --------------------
## # A tibble: 51 × 4
## # Groups:   semtype [1]
##    semtype name                    node_degree node_degree_perc
##    <chr>   <chr>                         <dbl>            <dbl>
##  1 patf    Injury                         2765             98.9
##  2 patf    Septicemia                     2197             97.4
##  3 patf    Oxidative Stress               2120             96.7
##  4 patf    Obstruction                    2074             96.5
##  5 patf    Asthma                         2036             96.0
##  6 patf    Hypoxia                        1935             95.4
##  7 patf    Kidney Failure, Chronic        1738             93.1
##  8 patf    Tuberculosis                   1602             91.8
##  9 patf    Shock                          1570             91.1
## 10 patf    Necrosis                       1532             90.4
## # ℹ 41 more rows
```

```
## Adding missing grouping variables: `semtype`
```

```
## aapp --------------------
## # A tibble: 40 × 4
## # Groups:   semtype [1]
##    semtype name                         node_degree node_degree_perc
##    <chr>   <chr>                              <dbl>            <dbl>
##  1 aapp    Interleukin-1 beta                  2718             98.8
##  2 aapp    Hemoglobin                          2197             97.4
##  3 aapp    Lipids                              2175             97.3
##  4 aapp    Insulin-Like Growth Factor I        1782             93.6
##  5 aapp    Immunoglobulins                     1509             90.0
##  6 aapp    Lipoproteins                        1415             88.2
##  7 aapp    Cell Adhesion Molecules             1306             85.3
##  8 aapp    Neoplasm Metastasis                 1303             85.2
##  9 aapp    Family                              1299             85.1
## 10 aapp    End stage renal failure             1112             81.1
## # ℹ 30 more rows
```

```
## Adding missing grouping variables: `semtype`
```

```
## gngm --------------------
## # A tibble: 41 × 4
## # Groups:   semtype [1]
##    semtype name                         node_degree node_degree_perc
##    <chr>   <chr>                              <dbl>            <dbl>
##  1 gngm    Interleukin-1 beta                  2718             98.8
##  2 gngm    Hemoglobin                          2197             97.4
##  3 gngm    Insulin-Like Growth Factor I        1782             93.6
##  4 gngm    Immunoglobulins                     1509             90.0
##  5 gngm    Male population group               1466             89.3
##  6 gngm    Lipoproteins                        1415             88.2
##  7 gngm    Cell Adhesion Molecules             1306             85.3
##  8 gngm    Family                              1299             85.1
##  9 gngm    End stage renal failure             1112             81.1
## 10 gngm    Serum Proteins                       789             71.6
## # ℹ 31 more rows
```

```
## Adding missing grouping variables: `semtype`
```

```
## imft --------------------
## # A tibble: 8 × 4
## # Groups:   semtype [1]
##   semtype name                                      node_degree node_degree_perc
##   <chr>   <chr>                                           <dbl>            <dbl>
## 1 imft    Interleukin-1 beta                               2718            98.8
## 2 imft    Antigens                                         2450            98.3
## 3 imft    Immunoglobulins                                  1509            90.0
## 4 imft    Protective Agents                                 692            67.5
## 5 imft    Hepatitis B Surface Antigens                      463            55.5
## 6 imft    L-Selectin                                        427            52.5
## 7 imft    Soluble antigen                                   270            39.0
## 8 imft    Merozoite Surface Protein 1|MSMB|MST1|TM…          44             8.77
```

```
## Adding missing grouping variables: `semtype`
```

```
## aggp --------------------
## # A tibble: 8 × 4
## # Groups:   semtype [1]
##   semtype name                node_degree node_degree_perc
##   <chr>   <chr>                     <dbl>            <dbl>
## 1 aggp    Child                      2336             98.0
## 2 aggp    Adult                      1708             92.7
## 3 aggp    Infant                     1567             91.0
## 4 aggp    Infant, Newborn            1336             85.9
## 5 aggp    Adolescent                 1160             82.3
## 6 aggp    Young adult                 846             73.8
## 7 aggp    School child                398             50.5
## 8 aggp    Adolescents, Female         305             42.9
```

```
## Adding missing grouping variables: `semtype`
```

```
## humn --------------------
## # A tibble: 79 × 4
## # Groups:   semtype [1]
##    semtype name                  node_degree node_degree_perc
##    <chr>   <chr>                       <dbl>            <dbl>
##  1 humn    Child                        2336             98.0
##  2 humn    Woman                        1984             95.6
##  3 humn    Adult                        1708             92.7
##  4 humn    Infant                       1567             91.0
##  5 humn    Control Groups               1474             89.5
##  6 humn    Male population group        1466             89.3
##  7 humn    cohort                       1383             87.0
##  8 humn    Mothers                      1362             86.6
##  9 humn    Infant, Newborn              1336             85.9
## 10 humn    Family                       1299             85.1
## # ℹ 69 more rows
```

```
## Adding missing grouping variables: `semtype`
```

```
## inpr --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name  node_degree node_degree_perc
##   <chr>   <chr>       <dbl>            <dbl>
## 1 inpr    Child        2336             98.0
```

```
## Adding missing grouping variables: `semtype`
```

```
## popg --------------------
## # A tibble: 41 × 4
## # Groups:   semtype [1]
##    semtype name                  node_degree node_degree_perc
##    <chr>   <chr>                       <dbl>            <dbl>
##  1 popg    Child                        2336             98.0
##  2 popg    Woman                        1984             95.6
##  3 popg    Male population group        1466             89.3
##  4 popg    cohort                       1383             87.0
##  5 popg    Mothers                      1362             86.6
##  6 popg    Participant                  1293             84.9
##  7 popg    Pregnant Women               1082             80.4
##  8 popg    Boys                          908             76.4
##  9 popg    Girls                         901             76.0
## 10 popg    Caucasoid Race                786             71.3
## # ℹ 31 more rows
```

```
## Adding missing grouping variables: `semtype`
```

```
## lipd --------------------
## # A tibble: 3 × 4
## # Groups:   semtype [1]
##   semtype name                                 node_degree node_degree_perc
##   <chr>   <chr>                                      <dbl>            <dbl>
## 1 lipd    Lipids                                      2175             97.3
## 2 lipd    Phospholipids                               1346             86.4
## 3 lipd    High Density Lipoprotein Cholesterol         829             73.1
```

```
## Adding missing grouping variables: `semtype`
```

```
## npop --------------------
## # A tibble: 8 × 4
## # Groups:   semtype [1]
##   semtype name                                      node_degree node_degree_perc
##   <chr>   <chr>                                           <dbl>            <dbl>
## 1 npop    Growth                                           2162             97.1
## 2 npop    Radiation                                         478             56.2
## 3 npop    density                                           419             51.9
## 4 npop    High pressure liquid chromatography proc…         262             38.5
## 5 npop    Male gender                                       248             37.0
## 6 npop    Humidity                                           95             18.5
## 7 npop    Weather                                            92             17.8
## 8 npop    Physical Development                               50             10.4
```

```
## Adding missing grouping variables: `semtype`
```

```
## orgf --------------------
## # A tibble: 8 × 4
## # Groups:   semtype [1]
##   semtype name                  node_degree node_degree_perc
##   <chr>   <chr>                       <dbl>            <dbl>
## 1 orgf    Growth                       2162             97.1
## 2 orgf    Cessation of life            1781             93.5
## 3 orgf    Pregnancy                    1422             88.4
## 4 orgf    Recovery                     1234             84.0
## 5 orgf    Premature Birth              1015             79.0
## 6 orgf    Question of pregnancy         761             70.4
## 7 orgf    Fertility                     673             67.1
## 8 orgf    Osteogenesis                  588             61.7
```

```
## Adding missing grouping variables: `semtype`
```

```
## acab --------------------
## # A tibble: 6 × 4
## # Groups:   semtype [1]
##   semtype name                               node_degree node_degree_perc
##   <chr>   <chr>                                    <dbl>            <dbl>
## 1 acab    Atherosclerosis                           2153            96.9
## 2 acab    Lesion                                    1690            92.5
## 3 acab    Reconstructive Surgical Procedures         759            70.3
## 4 acab    Vascular occlusion                         380            49.4
## 5 acab    Aneurysm, Dissecting                       272            39.1
## 6 acab    Cilioretinal artery occlusion                6             1.45
```

```
## Adding missing grouping variables: `semtype`
```

```
## anim --------------------
## # A tibble: 6 × 4
## # Groups:   semtype [1]
##   semtype name             node_degree node_degree_perc
##   <chr>   <chr>                  <dbl>            <dbl>
## 1 anim    Woman                   1984             95.6
## 2 anim    Mus                     1423             88.6
## 3 anim    Mothers                 1362             86.6
## 4 anim    Infant, Newborn         1336             85.9
## 5 anim    Animal Model             712             68.7
## 6 anim    Mice, Transgenic         565             60.7
```

```
## Adding missing grouping variables: `semtype`
```

```
## orch --------------------
## # A tibble: 8 × 4
## # Groups:   semtype [1]
##   semtype name                                      node_degree node_degree_perc
##   <chr>   <chr>                                           <dbl>            <dbl>
## 1 orch    Shock                                            1570             91.1
## 2 orch    Epinephrine                                      1451             89.1
## 3 orch    FAVOR                                            1383             87.0
## 4 orch    Vitamin A                                        1023             79.1
## 5 orch    Heme                                              754             70.0
## 6 orch    Thioctic Acid                                     555             59.8
## 7 orch    Polymerase Chain Reaction                         479             56.3
## 8 orch    High pressure liquid chromatography proc…         262             38.5
```

```
## Adding missing grouping variables: `semtype`
```

```
## grup --------------------
## # A tibble: 3 × 4
## # Groups:   semtype [1]
##   semtype name           node_degree node_degree_perc
##   <chr>   <chr>                <dbl>            <dbl>
## 1 grup    Control Groups        1474             89.5
## 2 grup    Donor person           854             74.1
## 3 grup    Focus Groups           147             25.0
```

```
## Adding missing grouping variables: `semtype`
```

```
## horm --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name        node_degree node_degree_perc
##   <chr>   <chr>             <dbl>            <dbl>
## 1 horm    Epinephrine        1451             89.1
```

```
## Adding missing grouping variables: `semtype`
```

```
## nsba --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name        node_degree node_degree_perc
##   <chr>   <chr>             <dbl>            <dbl>
## 1 nsba    Epinephrine        1451             89.1
```

```
## Adding missing grouping variables: `semtype`
```

```
## mamm --------------------
## # A tibble: 2 × 4
## # Groups:   semtype [1]
##   semtype name             node_degree node_degree_perc
##   <chr>   <chr>                  <dbl>            <dbl>
## 1 mamm    Mus                     1423             88.6
## 2 mamm    Mice, Transgenic         565             60.7
```

```
## Adding missing grouping variables: `semtype`
```

```
## ortf --------------------
## # A tibble: 7 × 4
## # Groups:   semtype [1]
##   semtype name                      node_degree node_degree_perc
##   <chr>   <chr>                           <dbl>            <dbl>
## 1 ortf    Brain                            1422             88.4
## 2 ortf    Baresthesia                       951             77.5
## 3 ortf    Osteogenesis                      588             61.7
## 4 ortf    Urinary concentration             254             37.9
## 5 ortf    Nervous System Physiology         232             35.5
## 6 ortf    Lung volume                       186             29.3
## 7 ortf    testicular function               125             23.0
```

```
## Adding missing grouping variables: `semtype`
```

```
## vita --------------------
## # A tibble: 3 × 4
## # Groups:   semtype [1]
##   semtype name          node_degree node_degree_perc
##   <chr>   <chr>               <dbl>            <dbl>
## 1 vita    FAVOR                1383             87.0
## 2 vita    Vitamin A            1023             79.1
## 3 vita    Thioctic Acid         555             59.8
```

```
## Adding missing grouping variables: `semtype`
```

```
## mobd --------------------
## # A tibble: 4 × 4
## # Groups:   semtype [1]
##   semtype name                node_degree node_degree_perc
##   <chr>   <chr>                     <dbl>            <dbl>
## 1 mobd    Pain                       1378             86.8
## 2 mobd    Mental disorders            923             76.8
## 3 mobd    Psychotic Disorders         577             61.3
## 4 mobd    Abdominal Pain              365             47.7
```

```
## Adding missing grouping variables: `semtype`
```

```
## famg --------------------
## # A tibble: 14 × 4
## # Groups:   semtype [1]
##    semtype name                      node_degree node_degree_perc
##    <chr>   <chr>                           <dbl>            <dbl>
##  1 famg    Mothers                          1362            86.6
##  2 famg    Family                           1299            85.1
##  3 famg    parent                            897            75.8
##  4 famg    sibling                           697            68.1
##  5 famg    Family member                     632            64.8
##  6 famg    Couples                           508            57.6
##  7 famg    Relative (related person)         464            55.7
##  8 famg    father                            438            53.1
##  9 famg    Brothers                          326            44.9
## 10 famg    Daughter                          305            42.9
## 11 famg    son                               276            39.6
## 12 famg    Monozygotic twins                 227            34.7
## 13 famg    descent                           207            32.5
## 14 famg    Expectant Parents                   6             1.45
```

```
## Adding missing grouping variables: `semtype`
```

```
## orgm --------------------
## # A tibble: 5 × 4
## # Groups:   semtype [1]
##   semtype name            node_degree node_degree_perc
##   <chr>   <chr>                 <dbl>            <dbl>
## 1 orgm    Infant, Newborn        1336             85.9
## 2 orgm    Animal Model            712             68.7
## 3 orgm    Parasites               317             44.2
## 4 orgm    Heterozygote            286             41.1
## 5 orgm    Homozygote              252             37.6
```

```
## Adding missing grouping variables: `semtype`
```

```
## celf --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name     node_degree node_degree_perc
##   <chr>   <chr>          <dbl>            <dbl>
## 1 celf    Mutation        1318             85.5
```

```
## Adding missing grouping variables: `semtype`
```

```
## genf --------------------
## # A tibble: 3 × 4
## # Groups:   semtype [1]
##   semtype name                      node_degree node_degree_perc
##   <chr>   <chr>                           <dbl>            <dbl>
## 1 genf    Mutation                         1318             85.5
## 2 genf    Polymorphism, Genetic             956             77.6
## 3 genf    Polymerase Chain Reaction         479             56.3
```

```
## Adding missing grouping variables: `semtype`
```

```
## phsf --------------------
## # A tibble: 3 × 4
## # Groups:   semtype [1]
##   semtype name              node_degree node_degree_perc
##   <chr>   <chr>                   <dbl>            <dbl>
## 1 phsf    Mutation                 1318             85.5
## 2 phsf    Fertility                 673             67.1
## 3 phsf    Energy Metabolism         660             66.3
```

```
## Adding missing grouping variables: `semtype`
```

```
## medd --------------------
## # A tibble: 9 × 4
## # Groups:   semtype [1]
##   semtype name                                      node_degree node_degree_perc
##   <chr>   <chr>                                           <dbl>            <dbl>
## 1 medd    Heart                                            1189            83.0
## 2 medd    Baresthesia                                       951            77.5
## 3 medd    Probes                                            556            60.0
## 4 medd    Chamber                                           431            52.7
## 5 medd    Prosthesis                                        322            44.7
## 6 medd    Frame                                             281            40.1
## 7 medd    High pressure liquid chromatography proc…         262            38.5
## 8 medd    Tourniquets                                       122            22.8
## 9 medd    COMPONENTS, EXERCISE                               11             2.70
```

```
## Adding missing grouping variables: `semtype`
```

```
## chvf --------------------
## # A tibble: 2 × 4
## # Groups:   semtype [1]
##   semtype name              node_degree node_degree_perc
##   <chr>   <chr>                   <dbl>            <dbl>
## 1 chvf    Agent                    1066             80.2
## 2 chvf    Protective Agents         692             67.5
```

```
## Adding missing grouping variables: `semtype`
```

```
## anab --------------------
## # A tibble: 2 × 4
## # Groups:   semtype [1]
##   semtype name                   node_degree node_degree_perc
##   <chr>   <chr>                        <dbl>            <dbl>
## 1 anab    Congenital Abnormality        1044             79.7
## 2 anab    Abnormal shape                 346             46.4
```

```
## Adding missing grouping variables: `semtype`
```

```
## cgab --------------------
## # A tibble: 2 × 4
## # Groups:   semtype [1]
##   semtype name                                  node_degree node_degree_perc
##   <chr>   <chr>                                       <dbl>            <dbl>
## 1 cgab    Congenital Abnormality                       1044             79.7
## 2 cgab    Polycystic Kidney, Autosomal Dominant         378             49.1
```

```
## Adding missing grouping variables: `semtype`
```

```
## prog --------------------
## # A tibble: 13 × 4
## # Groups:   semtype [1]
##    semtype name                  node_degree node_degree_perc
##    <chr>   <chr>                       <dbl>            <dbl>
##  1 prog    Voluntary Workers             987             78.7
##  2 prog    Physicians                    950             77.3
##  3 prog    student                       654             65.9
##  4 prog    athlete                       648             65.5
##  5 prog    Health Personnel              623             64.1
##  6 prog    Nurses                        554             59.7
##  7 prog    General Practitioners         408             51.4
##  8 prog    Soldiers                      310             43.6
##  9 prog    Pilot                         290             41.5
## 10 prog    Counsel - legal               180             28.8
## 11 prog    Provider                      162             26.6
## 12 prog    Policy Makers                 132             23.9
## 13 prog    Artist                         60             12.5
```

```
## Adding missing grouping variables: `semtype`
```

```
## orga --------------------
## # A tibble: 14 × 4
## # Groups:   semtype [1]
##    semtype name                     node_degree node_degree_perc
##    <chr>   <chr>                          <dbl>            <dbl>
##  1 orga    Baresthesia                      951            77.5
##  2 orga    Streptococcus pneumoniae         360            46.9
##  3 orga    Salmonella                       288            41.3
##  4 orga    Male gender                      248            37.0
##  5 orga    Ability                          232            35.5
##  6 orga    Gender                           153            25.8
##  7 orga    Sex Characteristics              117            22.1
##  8 orga    sex                              115            21.8
##  9 orga    heart rate                       114            21.5
## 10 orga    Birth Weight                      87            17.1
## 11 orga    CROSS SECTION                     59            11.9
## 12 orga    Body Temperature                  50            10.4
## 13 orga    DIFFUSION CAPACITY                14             3.37
## 14 orga    Propositus                         6             1.45
```

```
## Adding missing grouping variables: `semtype`
```

```
## celc --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name  node_degree node_degree_perc
##   <chr>   <chr>       <dbl>            <dbl>
## 1 celc    host          877             75.0
```

```
## Adding missing grouping variables: `semtype`
```

```
## podg --------------------
## # A tibble: 2 × 4
## # Groups:   semtype [1]
##   semtype name                  node_degree node_degree_perc
##   <chr>   <chr>                       <dbl>            <dbl>
## 1 podg    Cancer Patient                869             74.9
## 2 podg    Hospitalized Patients         596             62.2
```

```
## Adding missing grouping variables: `semtype`
```

```
## strd --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name                                 node_degree node_degree_perc
##   <chr>   <chr>                                      <dbl>            <dbl>
## 1 strd    High Density Lipoprotein Cholesterol         829             73.1
```

```
## Adding missing grouping variables: `semtype`
```

```
## resd --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name         node_degree node_degree_perc
##   <chr>   <chr>              <dbl>            <dbl>
## 1 resd    Animal Model         712             68.7
```

```
## Adding missing grouping variables: `semtype`
```

```
## diap --------------------
## # A tibble: 7 × 4
## # Groups:   semtype [1]
##   semtype name                              node_degree node_degree_perc
##   <chr>   <chr>                                   <dbl>            <dbl>
## 1 diap    Biopsy                                    650             65.6
## 2 diap    tomography                                619             63.6
## 3 diap    Differential Diagnosis                    425             52.1
## 4 diap    Electrocardiogram                         375             48.9
## 5 diap    Echocardiography, Transesophageal         173             28.4
## 6 diap    Intravenous pyelogram                     111             21.2
## 7 diap    Velocity measurement                       56             11.2
```

```
## Adding missing grouping variables: `semtype`
```

```
## mbrt --------------------
## # A tibble: 2 × 4
## # Groups:   semtype [1]
##   semtype name                      node_degree node_degree_perc
##   <chr>   <chr>                           <dbl>            <dbl>
## 1 mbrt    Racial group                      611             63.1
## 2 mbrt    Polymerase Chain Reaction         479             56.3
```

```
## Adding missing grouping variables: `semtype`
```

```
## elii --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name       node_degree node_degree_perc
##   <chr>   <chr>            <dbl>            <dbl>
## 1 elii    Phosphorus         593             62.1
```

```
## Adding missing grouping variables: `semtype`
```

```
## enzy --------------------
## # A tibble: 3 × 4
## # Groups:   semtype [1]
##   semtype name            node_degree node_degree_perc
##   <chr>   <chr>                 <dbl>            <dbl>
## 1 enzy    Thioctic Acid           555             59.8
## 2 enzy    Hydrolase               365             47.7
## 3 enzy    Pyruvate Kinase         324             44.8
```

```
## Adding missing grouping variables: `semtype`
```

```
## dora --------------------
## # A tibble: 4 × 4
## # Groups:   semtype [1]
##   semtype name               node_degree node_degree_perc
##   <chr>   <chr>                    <dbl>            <dbl>
## 1 dora    Exercise                   506            57.2
## 2 dora    Sports                     164            27.2
## 3 dora    Strenuous Exercise          58            11.7
## 4 dora    Athletics                   39             8.00
```

```
## Adding missing grouping variables: `semtype`
```

```
## clna --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name                      node_degree node_degree_perc
##   <chr>   <chr>                           <dbl>            <dbl>
## 1 clna    Polymerase Chain Reaction         479             56.3
```

```
## Adding missing grouping variables: `semtype`
```

```
## lbtr --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name                      node_degree node_degree_perc
##   <chr>   <chr>                           <dbl>            <dbl>
## 1 lbtr    Polymerase Chain Reaction         479             56.3
```

```
## Adding missing grouping variables: `semtype`
```

```
## mnob --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name                      node_degree node_degree_perc
##   <chr>   <chr>                           <dbl>            <dbl>
## 1 mnob    Polymerase Chain Reaction         479             56.3
```

```
## Adding missing grouping variables: `semtype`
```

```
## virs --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name                      node_degree node_degree_perc
##   <chr>   <chr>                           <dbl>            <dbl>
## 1 virs    Polymerase Chain Reaction         479             56.3
```

```
## Adding missing grouping variables: `semtype`
```

```
## cell --------------------
## # A tibble: 2 × 4
## # Groups:   semtype [1]
##   semtype name        node_degree node_degree_perc
##   <chr>   <chr>             <dbl>            <dbl>
## 1 cell    Phagocytes          469             55.9
## 2 cell    Drepanocyte         162             26.6
```

```
## Adding missing grouping variables: `semtype`
```

```
## blor --------------------
## # A tibble: 2 × 4
## # Groups:   semtype [1]
##   semtype name           node_degree node_degree_perc
##   <chr>   <chr>                <dbl>            <dbl>
## 1 blor    Abdominal Pain         365             47.7
## 2 blor    Fingers                111             21.2
```

```
## Adding missing grouping variables: `semtype`
```

```
## bact --------------------
## # A tibble: 2 × 4
## # Groups:   semtype [1]
##   semtype name                     node_degree node_degree_perc
##   <chr>   <chr>                          <dbl>            <dbl>
## 1 bact    Streptococcus pneumoniae         360             46.9
## 2 bact    Salmonella                       288             41.3
```

```
## Adding missing grouping variables: `semtype`
```

```
## bdsu --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name             node_degree node_degree_perc
##   <chr>   <chr>                  <dbl>            <dbl>
## 1 bdsu    peripheral blood         358             46.8
```

```
## Adding missing grouping variables: `semtype`
```

```
## tisu --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name             node_degree node_degree_perc
##   <chr>   <chr>                  <dbl>            <dbl>
## 1 tisu    peripheral blood         358             46.8
```

```
## Adding missing grouping variables: `semtype`
```

```
## invt --------------------
## # A tibble: 2 × 4
## # Groups:   semtype [1]
##   semtype name       node_degree node_degree_perc
##   <chr>   <chr>            <dbl>            <dbl>
## 1 invt    Parasites          317            44.2
## 2 invt    Tetrameres          33             6.55
```

```
## Adding missing grouping variables: `semtype`
```

```
## nusq --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name  node_degree node_degree_perc
##   <chr>   <chr>       <dbl>            <dbl>
## 1 nusq    Frame         281             40.1
```

```
## Adding missing grouping variables: `semtype`
```

```
## eico --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name                       node_degree node_degree_perc
##   <chr>   <chr>                            <dbl>            <dbl>
## 1 eico    8-isoprostaglandin F2alpha         214             33.2
```

```
## Adding missing grouping variables: `semtype`
```

```
## irda --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name                       node_degree node_degree_perc
##   <chr>   <chr>                            <dbl>            <dbl>
## 1 irda    8-isoprostaglandin F2alpha         214             33.2
```

```
## Adding missing grouping variables: `semtype`
```

```
## food --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name  node_degree node_degree_perc
##   <chr>   <chr>       <dbl>            <dbl>
## 1 food    Fruit         141             24.7
```

```
## Adding missing grouping variables: `semtype`
```

```
## edac --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name     node_degree node_degree_perc
##   <chr>   <chr>          <dbl>            <dbl>
## 1 edac    Training         127             23.2
```

```
## Adding missing grouping variables: `semtype`
```

```
## bird --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name                node_degree node_degree_perc
##   <chr>   <chr>                     <dbl>            <dbl>
## 1 bird    Meleagris gallopavo         107             20.4
```

```
## Adding missing grouping variables: `semtype`
```

```
## moft --------------------
## # A tibble: 2 × 4
## # Groups:   semtype [1]
##   semtype name                          node_degree node_degree_perc
##   <chr>   <chr>                               <dbl>            <dbl>
## 1 moft    Metabolic Control                      91            17.5
## 2 moft    cytochrome c oxidase activity          27             5.39
```

```
## Adding missing grouping variables: `semtype`
```

```
## fish --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name        node_degree node_degree_perc
##   <chr>   <chr>             <dbl>            <dbl>
## 1 fish    Lethrinidae          65             13.6
```

```
## Adding missing grouping variables: `semtype`
```

```
## plnt --------------------
## # A tibble: 1 × 4
## # Groups:   semtype [1]
##   semtype name  node_degree node_degree_perc
##   <chr>   <chr>       <dbl>            <dbl>
## 1 plnt    Bahia          20             4.24
```

The printed summary displays nodes grouped by semantic type. The semantic types are ordered such that the semantic type with the highest degree node is shown first. Often, these high degree nodes are less interesting because they represent fairly broad concepts.

* The `node_degree` column shows the degree of the node in the Semantic MEDLINE graph.
* The `node_degree_perc` column gives the percentile of the node degree relative to all nodes in the Semantic MEDLINE graph.

The resulting `tibble` (`nbrs_sickle_trait_summ`) contains the same information that is printed and provides another way to mine for nodes to remove.

After inspection of the summary, we can remove nodes based on semantic type and/or name. We can achieve this with `find_nodes(..., match = FALSE)`. The `...` can be any combination of the `pattern`, `names`, or `semtypes` arguments. If a node matches any of these pieces, it will be excluded with `match = FALSE`.

```
length(nbrs_sickle_trait)
```

```
## [1] 476
```

```
nbrs_sickle_trait2 <- nbrs_sickle_trait %>%
    find_nodes(
        pattern = "^Mice",
        semtypes = c("humn", "popg", "plnt",
            "fish", "food", "edac", "dora", "aggp"),
        names = c("Polymerase Chain Reaction", "Mus"),
        match = FALSE
    )
length(nbrs_sickle_trait2)
```

```
## [1] 386
```

It is natural to consider a chaining like below as a strategy to iteratively explore outward from a seed idea.

```
seed_nodes %>% grow_nodes() %>% find_nodes() %>% grow_nodes() %>% find_nodes()
```

Be careful when implementing this strategy because the `grow_nodes()` step has the potential to return far more nodes than is manageable very quickly. Often after just two sequential uses of `grow_nodes()`, the number of nodes returned can be too large to efficiently sift through unless you conduct substantial filtering with `find_nodes()` between uses of `grow_nodes()`.

# 4 Summary

In summary, the *[rsemmed](https://bioconductor.org/packages/3.22/rsemmed)* package provides tools for finding and connecting biomedical concepts.

* The key function for finding (and pruning) concepts (graph nodes) is the `find_nodes()` function.
* The key function for finding connections between concepts is `find_paths()`.
  + The `make_edge_weights()` function will allow you to tailor path-finding by creating custom weights. It requires metadata provided by `get_edge_features()`.
  + The `get_middle_nodes()`, `summarize_semtypes()`, and `summarize_predicates()` functions all help explore paths/node collections to inform reweighting.
* The key function for finding directly related concepts is `grow_nodes()`.

Your workflow will likely involve iteration between all of these different components.

# 5 Session Info

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
## [1] rsemmed_1.20.0   igraph_2.2.1     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5         cli_3.6.5           knitr_1.50
##  [4] magick_2.9.0        rlang_1.1.6         xfun_0.53
##  [7] stringi_1.8.7       generics_0.1.4      jsonlite_2.0.0
## [10] glue_1.8.0          htmltools_0.5.8.1   tinytex_0.57
## [13] sass_0.4.10         rmarkdown_2.30      tibble_3.3.0
## [16] evaluate_1.0.5      jquerylib_0.1.4     fastmap_1.2.0
## [19] yaml_2.3.10         lifecycle_1.0.4     bookdown_0.45
## [22] stringr_1.5.2       BiocManager_1.30.26 compiler_4.5.1
## [25] dplyr_1.1.4         Rcpp_1.1.0          pkgconfig_2.0.3
## [28] digest_0.6.37       R6_2.6.1            utf8_1.2.6
## [31] tidyselect_1.2.1    pillar_1.11.1       magrittr_2.0.4
## [34] bslib_0.9.0         withr_3.0.2         tools_4.5.1
## [37] cachem_1.1.0
```

# References

Kilicoglu, Halil, Graciela Rosemblat, Marcelo Fiszman, and Thomas C Rindflesch. 2011. “Constructing a Semantic Predication Gold Standard from the Biomedical Literature.” *BMC Bioinformatics* 12 (December): 486. <https://doi.org/10.1186/1471-2105-12-486>.