# *TreeAndLeaf*: A graph layout strategy for binary trees with focus on the leaves

Milena A Cardoso, Luis E A Rizzardi, Leonardo W Kume, Sheyla Trefflich, Clarice Groeneveld, Mauro A A Castro

#### 30 October 2025

#### Abstract

The **TreeAndLeaf** package combines tree and force-directed layout algorithms for drawing binary trees, aiming to represent multiple layers of information onto the leaves.

#### Package

TreeAndLeaf 1.22.0

# Contents

* [1 Overview](#overview)
* [2 Quick Start](#quick-start)
  + [2.1 Package and data requirements](#package-and-data-requirements)
  + [2.2 Building a dendrogram example](#building-a-dendrogram-example)
  + [2.3 Converting the *hclust* object into a *tree-and-leaf* object](#converting-the-hclust-object-into-a-tree-and-leaf-object)
  + [2.4 Setting graph attributes](#setting-graph-attributes)
  + [2.5 Plotting a *tree-and-leaf* diagram](#plotting-a-tree-and-leaf-diagram)
* [3 Setting the initial *tree-and-leaf* state with *ggtree* layouts](#setting-the-initial-tree-and-leaf-state-with-ggtree-layouts)
  + [3.1 Package and data requirements](#package-and-data-requirements-1)
  + [3.2 Building and plotting a *phylo* tree with *ggtree* layouts](#building-and-plotting-a-phylo-tree-with-ggtree-layouts)
  + [3.3 Applying *tree-and-leaf* transformation to *ggtree* layouts](#applying-tree-and-leaf-transformation-to-ggtree-layouts)
* [4 Case Study 1: visualizing a large dendrogram](#case-study-1-visualizing-a-large-dendrogram)
  + [4.1 Context](#context)
  + [4.2 Package and data requirements](#package-and-data-requirements-2)
  + [4.3 Building and plotting a large *tree-and-leaf* diagram](#building-and-plotting-a-large-tree-and-leaf-diagram)
* [5 Case Study 2: visualizing a phylogenetic tree](#case-study-2-visualizing-a-phylogenetic-tree)
  + [5.1 Context](#context-1)
  + [5.2 Package and data requirements](#package-and-data-requirements-3)
  + [5.3 Building and plotting a *tree-and-leaf* from a phylogenetic tree](#building-and-plotting-a-tree-and-leaf-from-a-phylogenetic-tree)
* [6 Case Study 3: visualizing a non-binary tree](#case-study-3-visualizing-a-non-binary-tree)
  + [6.1 Context](#context-2)
  + [6.2 Package and data requirements](#package-and-data-requirements-4)
  + [6.3 Building and plotting a *tree-and-leaf* for a non-binary tree](#building-and-plotting-a-tree-and-leaf-for-a-non-binary-tree)
* [7 Session information](#session-information)

# 1 Overview

A dendrogram diagram displays binary trees focused on representing
hierarchical relations between the tree elements. A dendrogram contains
nodes, branches (edges), a root, and leaves (**Figure 1A**). The root is where
the branches and nodes come from, indicating the direction to the leaves,
*i.e.*, the terminal nodes.

Most of the space of a dendrogram layout is used to arrange branches and inner
nodes, with limited space to the leaves. For large dendrograms, the leaf
labels are often squeezed to fit into small slots. Therefore, a dendrogram
may not provide the best layout when the information to be displayed should
highlight the leaves.

The **TreeAndLeaf** package aims to improve the visualization of the dendrogram
leaves by combining tree and force-directed layout algorithms, shifting the
focus of analysis to the leaves (**Figure 1B**). The package’s workflow is
summarized in **Figure 1C**.

![](data:image/png;base64...)

**Figure 1**. **TreeAndLeaf** workflow summary. **(A,B)** The dendrogram in A
is used to construct the graph in B. **(C)** The main input for the **TreeAndLeaf**
package consists of a dendrogram, and then the package transforms the dendrogram
into a graph representation. The finest graph layout is achieved by a two-steps
process, starting with an unrooted tree diagram, which is subsequently relaxed
by a force-directed algorithm applied to the terminal nodes of the tree. The
final *tree-and-leaf* layout varies depending on the initial state, which can be
obtained by other tree layout algorithms (see *section 3* for examples using
*ggtree* layouts to setup the initial state).

# 2 Quick Start

This section provides a basic example using the R built-in `USArrests` dataset.
The `USArrests` is a dataframe available in the user’s workspace. To know more
about this dataframe, please query `?USArrests` in the R console. We will build
a dendrogram from the `USArrests` dataset, then transform the dendrogram into
a *tree-and-leaf* diagram, and the result will be visualized in the **RedeR**
application.

## 2.1 Package and data requirements

```
#-- Libraries required in this section:
#-- TreeAndLeaf(>=1.4.2), RedeR(>=1.40.4), Bioconductor >= 3.13 (R >= 4.0)
# BiocManager::install(c("TreeAndLeaf","RedeR"))
# install.packages(c("igraph","RColorBrewer"))

#-- Load packages
library("TreeAndLeaf")
library("RedeR")
library("igraph")
library("RColorBrewer")
```

```
#-- Check data
dim(USArrests)
#> [1] 50  4
head(USArrests)
#>            Murder Assault UrbanPop Rape
#> Alabama      13.2     236       58 21.2
#> Alaska       10.0     263       48 44.5
#> Arizona       8.1     294       80 31.0
#> Arkansas      8.8     190       50 19.5
#> California    9.0     276       91 40.6
#> Colorado      7.9     204       78 38.7
```

## 2.2 Building a dendrogram example

In order to build a dendrogram from the `USArrests` dataset, we need a distance
matrix. We will use the default “euclidean distance” method from the `dist()`
function, and then the “average” method from `hclust()` function to create the
dendrogram.

```
hc <- hclust(dist(USArrests), "ave")
plot(hc, main="Dendrogram for the 'USArrests' dataset",
     xlab="", sub="")
```

![](data:image/png;base64...)

## 2.3 Converting the *hclust* object into a *tree-and-leaf* object

The `treeAndLeaf` function will transform the *hclust* into an *igraph* object,
including some basic graph attributes to display in the **RedeR** application.

```
#-- Convert the 'hclust' object into a 'tree-and-leaf' object
tal <- treeAndLeaf(hc)
```

## 2.4 Setting graph attributes

The `att.mapv()` function can be used to add external annotations to an *igraph*
object, for example, mapping new variables to the graph vertices. We will add
all `USArrests` variables to the `tal` object. To map one object to another
it is essential to use the same mapping IDs, set by the `refcol` parameter,
which points to a column in the input annotation dataset. In this example,
`refcol = 0` indicates that the `USArrests` rownames will be used as
mapping IDs. To check the IDs in the *igraph* vertices, please type
`V(tal)$name` in the R console.

```
#--- Map attributes to the tree-and-leaf
#Note: 'refcol = 0' indicates that 'dat' rownames will be used as mapping IDs
tal <- att.mapv(g = tal, dat = USArrests, refcol = 0)
```

Now we use the `att.setv()` wrapper function to set attributes in the
*tree-and-leaf* diagram. To see all attributes available to display in the
**RedeR** application, please type `?addGraph` in the R console. The graph
attributes can also be customized following **igraph** syntax rules.

```
#--- Set graph attributes using the 'att.setv' wrapper function
pal <- brewer.pal(9, "Reds")
tal <- att.setv(g = tal, from = "Murder", to = "nodeColor",
                cols = pal, nquant = 5)
tal <- att.setv(g = tal, from = "UrbanPop", to = "nodeSize",
                xlim = c(10, 50, 5), nquant = 5)

#--- Set graph attributes using 'att.addv' and 'att.adde' functions
tal <- att.addv(tal, "nodeFontSize", value = 15, index = V(tal)$isLeaf)
tal <- att.adde(tal, "edgeWidth", value = 3)
```

## 2.5 Plotting a *tree-and-leaf* diagram

The next steps will call the **RedeR** application, and then display the
*tree-and-leaf* diagram in an interactive R/Java interface. The initial layout
will show an unrooted tree diagram, which will be subsequently relaxed by a
force-directed algorithm applied to the terminal nodes of the tree.

```
#--- Call RedeR application
rdp <- RedPort()
calld(rdp)
resetd(rdp)
```

```
#--- Send the tree-and-leaf to the interactive R/Java interface
addGraph(obj = rdp, g = tal, gzoom=75)

#--- Call 'relax' to fine-tune the leaf nodes
relax(rdp, p1=25, p2=200, p3=5, p5=5, ps=TRUE)
```

At this point, the user can interact with the layout process to achieve the
best or desired layout; we suggest fine-tuning the force-directed algorithm
parameters, either through the R/Java interface or the command line relaxation
function. Note that the unroot tree diagram represents the initial state; then
a relaxing process should start until the finest graph layout is achieved.
The final layout varies depending on the initial state, which can also be
adjusted by providing more or less room for the spatial configuration
(*e.g.* via `gzoom` parameter).

```
#--- Add legends
addLegend.color(obj = rdp, tal, title = "Murder Rate",
                position = "topright")
addLegend.size(obj = rdp, tal, title = "Urban Population Size",
               position = "bottomright")
```

![](data:image/png;base64...)

# 3 Setting the initial *tree-and-leaf* state with *ggtree* layouts

The tree diagram represents the initial state of a *tree-and-leaf*, which is then
relaxed by a force-directed algorithm applied to the terminal nodes. Therefore,
the final *tree-and-leaf* layout varies depending on the initial state. The
**treeAndLeaf** package also accepts `ggtree` layouts to setup the initial state.
For example, next we show a tree diagram generated by the **ggtree** package,
and then we apply the *tree-and-leaf* transformation.

## 3.1 Package and data requirements

```
#-- Libraries required in this section:
#-- TreeAndLeaf(>=1.4.2), RedeR(>=1.40.4), Bioconductor >= 3.13 (R >= 4.0)
# BiocManager::install(c("TreeAndLeaf","RedeR","ggtree))
# install.packages(c("igraph","ape", "dendextend", "dplyr",
#                    "ggplot2", "RColorBrewer"))

#-- Load packages
library("TreeAndLeaf")
library("RedeR")
library("igraph")
library("ape")
library("ggtree")
library("dendextend")
library("dplyr")
library("ggplot2")
library("RColorBrewer")
```

## 3.2 Building and plotting a *phylo* tree with *ggtree* layouts

```
#--- Generate a random phylo tree
phylo_tree <- rcoal(300)

#--- Set groups and node sizes
group <- size <- dendextend::cutree(phylo_tree, 10)
group[] <- LETTERS[1:10][group]
size[] <- sample(size)
group.df <- data.frame(label=names(group), group=group, size=size)
phylo_tree <- dplyr::full_join(phylo_tree, group.df, by='label')

#--- Generate a ggtree with 'daylight' layout
pal <- brewer.pal(10, "Set3")
ggt <- ggtree(phylo_tree, layout = 'daylight', branch.length='none')

#--- Plot the ggtree
ggt + geom_tippoint(aes(color=group, size=size)) +
  scale_color_manual(values=pal) + scale_y_reverse()
```

## 3.3 Applying *tree-and-leaf* transformation to *ggtree* layouts

```
#-- Convert the 'ggtree' object into a 'tree-and-leaf' object
tal <- treeAndLeaf(ggt)

#--- Map attributes to the tree-and-leaf
#Note: 'refcol = 1' indicates that 'dat' col 1 will be used as mapping IDs
tal <- att.mapv(g = tal, dat = group.df, refcol = 1)

#--- Set graph attributes using the 'att.setv' wrapper function
tal <- att.setv(g = tal, from = "group", to = "nodeColor",
                cols = pal)
tal <- att.setv(g = tal, from = "size", to = "nodeSize",
                xlim = c(10, 50, 5))

#--- Set graph attributes using 'att.addv' and 'att.adde' functions
tal <- att.addv(tal, "nodeFontSize", value = 1)
tal <- att.addv(tal, "nodeLineWidth", value = 0)
tal <- att.addv(tal, "nodeColor", value = "black", index=!V(tal)$isLeaf)
tal <- att.adde(tal, "edgeWidth", value = 3)
tal <- att.adde(tal, "edgeColor", value = "black")
```

```
#--- Call RedeR application
rdp <- RedPort()
calld(rdp)
resetd(rdp)
```

```
#--- Send the tree-and-leaf to the interactive R/Java interface
addGraph(obj = rdp, g = tal, gzoom=50)

#--- Select inner nodes, preventing them from relaxing
selectNodes(rdp, V(tal)$name[!V(tal)$isLeaf], anchor=TRUE)

#--- Call 'relax' to fine-tune the leaf nodes
relax(rdp, p1=25, p2=100, p3=5, p5=1, p8=5, ps=TRUE)

#--- Add legends
addLegend.color(obj = rdp, tal, title = "Group",
                position = "topright",vertical=T)
addLegend.size(obj = rdp, tal, title = "Size",
               position = "topleft",
               vertical=T, dxtitle=10)
```

![](data:image/png;base64...)

# 4 Case Study 1: visualizing a large dendrogram

## 4.1 Context

This section follows the same steps described in the *Quick Start*, but
using a larger dendrogram derived from the R built-in `quakes` dataset.
The `quakes` is a dataframe available in the user’s workspace. To know more
about this dataframe, please query `?quakes` in the R console.
We will build a dendrogram from the `quakes` dataset, then transform the
dendrogram into a *tree-and-leaf* diagram, and the result will be visualized
in the **RedeR** application.

## 4.2 Package and data requirements

```
#-- Libraries required in this section:
#-- TreeAndLeaf(>=1.4.2), RedeR(>=1.40.4), Bioconductor >= 3.13 (R >= 4.0)
# BiocManager::install(c("TreeAndLeaf","RedeR"))
# install.packages(c("igraph", "RColorBrewer"))

#-- Load packages
library(TreeAndLeaf)
library(RedeR)
library(igraph)
library(RColorBrewer)
```

```
#-- Check data
dim(quakes)
#> [1] 1000    5
head(quakes)
#>      lat   long depth mag stations
#> 1 -20.42 181.62   562 4.8       41
#> 2 -20.62 181.03   650 4.2       15
#> 3 -26.00 184.10    42 5.4       43
#> 4 -17.97 181.66   626 4.1       19
#> 5 -20.42 181.96   649 4.0       11
#> 6 -19.68 184.31   195 4.0       12
```

```
#-- Building a large dendrogram
hc <- hclust(dist(quakes), "ave")
plot(hc, main="Dendrogram for the 'quakes' dataset",
     xlab="", sub="")
```

![](data:image/png;base64...)

## 4.3 Building and plotting a large *tree-and-leaf* diagram

```
#-- Convert the 'hclust' object into a 'tree-and-leaf' object
tal <- treeAndLeaf(hc)
```

```
#--- Map attributes to the tree-and-leaf
#Note: 'refcol = 0' indicates that 'dat' rownames will be used as mapping IDs
tal <- att.mapv(tal, quakes, refcol = 0)

#--- Set graph attributes using the 'att.setv' wrapper function
pal <- brewer.pal(9, "Greens")
tal <- att.setv(g = tal, from = "mag", to = "nodeColor",
                cols = pal, nquant = 10)
tal <- att.setv(g = tal, from = "depth", to = "nodeSize",
                xlim = c(40, 120, 20), nquant = 5)

#--- Set graph attributes using 'att.addv' and 'att.adde' functions
tal <- att.addv(tal, "nodeFontSize", value = 1)
tal <- att.adde(tal, "edgeWidth", value = 10)
```

The next steps will call the **RedeR** application, and then display the
*tree-and-leaf* diagram in an interactive R/Java interface. The initial layout
will show an unrooted tree diagram, which will be subsequently relaxed by a
force-directed algorithm applied to the terminal nodes of the tree.

```
#--- Call RedeR application
rdp <- RedPort()
calld(rdp)
resetd(rdp)
```

```
#--- Send the tree-and-leaf to the interactive R/Java interface
addGraph(obj = rdp, g = tal, gzoom=10)

#--- Call 'relax' to fine-tune the leaf nodes
relax(rdp, p1=25, p2=200, p3=10, p4=100, p5=10, ps=TRUE)
```

```
#--- Add legends
addLegend.color(obj = rdp, tal, title = "Richter Magnitude",
                position = "bottomright")
addLegend.size(obj = rdp, tal, title = "Depth (km)")
```

![](data:image/png;base64...)

# 5 Case Study 2: visualizing a phylogenetic tree

## 5.1 Context

This section generates a *tree-and-leaf* diagram from a pre-computed `phylo`
tree object. We will use a phylogenetic tree listing 121 eukaryotes, available
from the **geneplast** package.

## 5.2 Package and data requirements

```
#-- Libraries required in this section:
#-- TreeAndLeaf(>=1.4.2), RedeR(>=1.40.4), Bioconductor >= 3.13 (R >= 4.0)
# BiocManager::install(c("TreeAndLeaf","RedeR","geneplast))
# install.packages(c("igraph","ape", "RColorBrewer"))

#-- Load packages
library(TreeAndLeaf)
library(RedeR)
library(igraph)
library(ape)
library(geneplast)
library(RColorBrewer)
```

```
#-- Load data and plot the phylogenetic tree
data("spdata")
data("gpdata.gs")
plot(phyloTree)
```

![](data:image/png;base64...)

## 5.3 Building and plotting a *tree-and-leaf* from a phylogenetic tree

```
#--- Drop organisms not listed in the 'spdata' annotation
phyloTree$tip.label <- as.character(phyloTree$tip.label)
tokeep <- phyloTree$tip.label %in% spdata$tax_id
pruned.phylo <- drop.tip(phyloTree, phyloTree$tip.label[!tokeep])
```

```
#-- Convert the phylogenetic tree into a 'tree-and-leaf' object
tal <- treeAndLeaf(pruned.phylo)

#--- Map attributes to the tree-and-leaf
#Note: 'refcol = 1' indicates that 'dat' col 1 will be used as mapping IDs
tal <- att.mapv(g = tal, dat = spdata, refcol = 1)

#--- Set graph attributes using the 'att.setv' wrapper function
pal <- brewer.pal(9, "Purples")
tal <- att.setv(g = tal, from = "genome_size_Mb",
                to = "nodeSize", xlim = c(120, 250, 1), nquant = 5)
tal <- att.setv (g = tal, from = "proteins",
                 to = "nodeColor", nquant = 5,
                 cols = pal, na.col = "black")
```

```
#--- Add graph attributes using 'att.adde' and 'att.addv' functions
tal <- att.addv(tal, "nodeFontSize", value = 10)
tal <- att.adde(tal, "edgeWidth", value = 20)

# Set species names to 'nodeAlias' attribute
tal <- att.setv(tal, from = "sp_name", to = "nodeAlias")

# Select a few names to highlight in the graph
tal <- att.addv(tal, "nodeFontSize", value = 100,
       filter=list('name'=sample(pruned.phylo$tip.label,30)))
tal <- att.addv(tal, "nodeFontSize", value = 100,
                filter=list('name'="9606")) #Homo sapiens
```

```
# Call RedeR
rdp <- RedPort()
calld(rdp)
resetd(rdp)

#--- Send the tree-and-leaf to the interactive R/Java interface
addGraph(obj = rdp, g = tal, gzoom=10)

#--- Call 'relax' to fine-tune the leaf nodes
relax(rdp, ps=TRUE)
```

```
#--- Add legends
addLegend.color(rdp, tal, title = "Proteome Size (n)")
addLegend.size(rdp, tal, title = "Genome Size (Mb)")
```

![](data:image/png;base64...)

# 6 Case Study 3: visualizing a non-binary tree

## 6.1 Context

The **TreeAndLeaf** package is designed to layout binary trees, but it can also
layout other graph configurations. To exemplify this case, we will use a
larger phylogenetic tree available from the **geneplast** package, and for
which some inner nodes have more than two children, or non-binary nodes.

## 6.2 Package and data requirements

```
#-- Libraries required in this section:
#-- TreeAndLeaf(>=1.4.2), RedeR(>=1.40.4), Bioconductor >= 3.13 (R >= 4.0)
# BiocManager::install(c("TreeAndLeaf","RedeR","geneplast))
# install.packages(c("igraph","ape", "RColorBrewer"))

#-- Load packages
library(TreeAndLeaf)
library(RedeR)
library(igraph)
library(ape)
library(geneplast)
library(RColorBrewer)
```

```
#-- Load data
data("spdata")
data("phylo_tree")
```

```
#--- Drop organisms not listed in the 'spdata' annotation
tokeep <- phylo_tree$tip.label %in% spdata$tax_id
pruned.phylo <- drop.tip(phylo_tree, phylo_tree$tip.label[!tokeep])
```

## 6.3 Building and plotting a *tree-and-leaf* for a non-binary tree

```
#-- Convert the phylogenetic tree into a 'tree-and-leaf' object
tal <- treeAndLeaf(pruned.phylo)
```

```
#--- Map attributes to the tree-and-leaf using "%>%" operator
tal <- tal %>%
  att.mapv(dat = spdata, refcol = 1) %>%
  att.setv(from = "genome_size_Mb", to = "nodeSize",
           xlim = c(120, 250, 1), nquant = 5) %>%
  att.setv(from = "proteins", to = "nodeColor", nquant = 5,
           cols = brewer.pal(9, "Blues"), na.col = "black") %>%
  att.setv(from = "sp_name", to = "nodeAlias") %>%
  att.adde(to = "edgeWidth", value = 20) %>%
  att.addv(to = "nodeFontSize", value = 10) %>%
  att.addv(to = "nodeFontSize", value = 100,
      filter = list("name" = sample(pruned.phylo$tip.label, 30))) %>%
  att.addv(to = "nodeFontSize", value = 100,
           filter = list("name" = "9606"))
```

```
# Call RedeR
rdp <- RedPort()
calld(rdp)
resetd(rdp)

#--- Send the tree-and-leaf to the interactive R/Java interface
addGraph(obj = rdp, g = tal, gzoom=5)

#--- Call 'relax' to fine-tune the leaf nodes
relax(rdp, ps=TRUE)
```

```
#--- Add legends
addLegend.color(rdp, tal, title = "Proteome Size (n)")
addLegend.size(rdp, tal, title = "Genome size (Mb)")
```

![](data:image/png;base64...)

# 7 Session information

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
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
#> [1] geneplast_1.36.0   ape_5.8-1          RColorBrewer_1.1-3 igraph_2.2.1
#> [5] RedeR_3.6.0        TreeAndLeaf_1.22.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] nlme_3.1-168        cli_3.6.5           knitr_1.50
#>  [4] magick_2.9.0        rlang_1.1.6         xfun_0.53
#>  [7] data.table_1.17.8   jsonlite_2.0.0      glue_1.8.0
#> [10] htmltools_0.5.8.1   tinytex_0.57        snow_0.4-4
#> [13] sass_0.4.10         scales_1.4.0        rmarkdown_2.30
#> [16] grid_4.5.1          evaluate_1.0.5      jquerylib_0.1.4
#> [19] fastmap_1.2.0       yaml_2.3.10         lifecycle_1.0.4
#> [22] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
#> [25] Rcpp_1.1.0          pkgconfig_2.0.3     lattice_0.22-7
#> [28] farver_2.1.2        digest_0.6.37       R6_2.6.1
#> [31] dichromat_2.0-0.1   parallel_4.5.1      magrittr_2.0.4
#> [34] bslib_0.9.0         tools_4.5.1         cachem_1.1.0
```