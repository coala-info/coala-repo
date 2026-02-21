# Upgrading existing scripts

by Alexander Pico, Tanja Muetze, Paul Shannon

#### 2025-12-04

#### Package

RCy3 2.30.1

*Cytoscape* is a well-known bioinformatics tool for displaying and exploring biological networks.
**R** is a powerful programming language and environment for statistical and exploratory data analysis.
*RCy3* uses CyREST to communicate between **R** and Cytoscape, allowing any graphs (e.g., iGraph, graphNEL or dataframes) to be viewed, explored and manipulated with the Cytoscape point-and-click visual interface. Thus, via RCy3, these two quite different, quite useful bioinformatics software environments are connected, mutually enhancing each other, providing new possibilities for exploring biological data.

# 1 Installation

```
if(!"RCy3" %in% installed.packages()){
    install.packages("BiocManager")
    BiocManager::install("RCy3")
}
library(RCy3)
```

# 2 Prerequisites

In addition to this package (RCy3), you will need:

* **Cytoscape 3.6.1** or greater, which can be downloaded from <http://www.cytoscape.org/download.php>. Simply follow the installation instructions on screen.

# 3 Big changes for RCy3

Welcome to RCy3 v2.0! If you have been using prior versions of RCy3, then this is
a big step. The fundamental change is that CytoscapeConnection and CytoscapeWindow classes are no longer used. These were pervasive arguments throughout the package in prior versions, so practically every function signature has changed. However, this change simplifies functions and in 99% of cases the old cw and cc args can simply be deleted.

**Some summary stats regarding the changes:**

* 54 new functions (244 total)
* Other than function signatures,
  + 44 functions are otherwise unchanged
  + 37 functions have been annotated as deprecated
  + 69 functions have been renamed to match updated docs
    - 38 functions have been annotated as defunct

Going forward, this realignment will help us maintain the package in sync with changes to critical upstream resources such as Cytoscape’s CyREST API. It will also greatly simply script writing for users. We hope you’ll stay onboard.

# 4 Where to start

We documented this upgrade in a few different ways to help you update existing
scripts you don’t want to leave behind and to adopt the new conceptual model
for RCy3 going forward.

## 4.1 Upgrading Existing Scripts

Here’s a wiki page from the main RCy3 repo that we will keep updated with helpful
tips. I’d recommend starting there:

* <https://github.com/cytoscape/RCy3/wiki/Upgrading-Existing-Scripts>

## 4.2 NEWS

For a laundry list of changes made to the package in this transition to v2.0,
check out the NEWS from that release:

* <https://www.bioconductor.org/packages/3.7/bioc/news/RCy3/NEWS>

# 5 Example upgrades

It is always helpful to see examples. Here are a few of the most common chunks
of RCy3 usage, provided in *BEFORE* and *AFTER* versions. If you have code
similar to these in your pre-v2.0 scripts, then try these suggested swaps.

**Note: don’t run the *BEFORE* chunks with the latest RCy3 package. These chunks are NOT meant to be run as a sequence, but rather as isolated examples.**

## 5.1 Example: displayGraph

*BEFORE*

```
g <- new ('graphNEL', edgemode='directed')
g <- graph::addNode ('A', g)
g <- graph::addNode ('B', g)
g <- graph::addNode ('C', g)
g <- graph::addEdge ('A', 'B', g)
g <- graph::addEdge ('B', 'C', g)
cw <- CytoscapeWindow ('vignette', graph=g, overwrite=TRUE)
displayGraph (cw)
layoutNetwork (cw, layout.name='grid')
```

*AFTER*

```
g <- new ('graphNEL', edgemode='directed')
g <- graph::addNode ('A', g)
g <- graph::addNode ('B', g)
g <- graph::addNode ('C', g)
g <- graph::addEdge ('A', 'B', g)
g <- graph::addEdge ('B', 'C', g)
net.suid <- createNetworkFromGraph (g, 'vignette')
```

* Note: the network SUID is returned rather than an R object
* Note: display and layout are done automatically

## 5.2 Example: cyPlot

*BEFORE*

```
node.df <- data.frame(id=c("A","B","C","D"),
           stringsAsFactors=FALSE)
edge.df <- data.frame(source=c("A","A","A","C"),
           target=c("B","C","D","D"),
           interaction=c("inhibits","interacts","activates","interacts"),  # optional
           stringsAsFactors=FALSE)
g <- cyPlot(node.df, edge.df)
cw <- CytoscapeWindow("vignette2", g)
displayGraph(cw)
layoutNetwork(cw, "force-directed")
```

*AFTER*

```
node.df <- data.frame(id=c("A","B","C","D"),
           stringsAsFactors=FALSE)
edge.df <- data.frame(source=c("A","A","A","C"),
           target=c("B","C","D","D"),
           interaction=c("inhibits","interacts","activates","interacts"),  # optional
           stringsAsFactors=FALSE)
net.suid <- createNetworkFromDataFrames (node.df, edge.df, "vignette2")
```

* Note: Same node and edge dataframes, except rather than having the key columns being positionally defined (for cyPlot), they need to be semantically defined using “id”, “source”, “target” and “interaction” (for createNetworkFromDataFrames)
* Note: display and layout are done automatically

## 5.3 Example: loading nodeData

*BEFORE*

```
g <- initNodeAttribute (graph=g,  attribute.name='moleculeType',
                            attribute.type='char',
                            default.value='undefined')
g <- initNodeAttribute (graph=g,  'lfc', 'numeric', 0.0)
nodeData (g, 'A', 'moleculeType') <- 'kinase'
nodeData (g, 'B', 'moleculeType') <- 'TF'
nodeData (g, 'C', 'moleculeType') <- 'cytokine'
nodeData (g, 'D', 'moleculeType') <- 'cytokine'
nodeData (g, 'A', 'lfc') <- -1.2
nodeData (g, 'B', 'lfc') <- 1.8
nodeData (g, 'C', 'lfc') <- 3.2
nodeData (g, 'D', 'lfc') <- 2.2
cw = setGraph (cw, g)
displayGraph (cw)
```

*AFTER*

```
node.data <- data.frame(id=c('A','B','C','D'),
                        moleculeType=c('kinase','TF','cytokine','cytokine'),
                        lfc=c(-1.2, 1.8, 3.2, 2.2),
                        stringsAsFactors = FALSE)
loadTableData(node.data, 'id')
```

* Note: simply compose a data.frame and then load it! No need to initialize or alter local graphNEL object
* Note: stringsAsFactors = FALSE is important or else string values won’t load
* Note: set and display are no longer needed

## 5.4 Example: setDefaults

*BEFORE*

```
setDefaultNodeShape (cw, 'OCTAGON')
setDefaultNodeColor (cw, '#AAFF88')
setDefaultNodeSize  (cw, 80)
setDefaultNodeFontSize (cw, 40)
```

*AFTER*

```
setNodeShapeDefault ('OCTAGON')
setNodeColorDefault ('#AAFF88')
setNodeSizeDefault  (80)
setNodeFontSizeDefault (40)
```

* Note: no more cw!
* Note: subtley renamed functions for consistency across package (sorry!)

## 5.5 Example: Rule based mapping

*BEFORE*

```
attribute.values <- c ('kinase',  'TF',       'cytokine')
node.shapes      <- c ('DIAMOND', 'TRIANGLE', 'RECTANGLE')
setNodeShapeRule (cw, 'moleculeType', attribute.values, node.shapes)
setNodeColorRule (cw, 'lfc', c (-3.0, 0.0, 3.0),
                  c ('#00AA00', '#00FF00', '#FFFFFF', '#FF0000', '#AA0000'),
                  mode='interpolate')
control.points = c (-1.2, 2.0, 4.0)
node.sizes     = c (30, 40, 60, 80, 90)
setNodeSizeRule (cw, 'lfc', control.points, node.sizes, mode='interpolate')
```

*AFTER*

```
attribute.values <- c ('kinase',  'TF',       'cytokine')
node.shapes      <- c ('DIAMOND', 'TRIANGLE', 'RECTANGLE')
setNodeShapeMapping('moleculeType', attribute.values, node.shapes)
setNodeColorMapping('lfc', c(-3.0, 0.0, 3.0),
                    c('#00AA00', '#00FF00', '#FFFFFF', '#FF0000', '#AA0000'))
control.points = c (-1.2, 2.0, 4.0)
node.sizes     = c (30, 40, 60, 80, 90)
setNodeSizeMapping('lfc',control.points, node.sizes)
```

* Note: no more cw!
* Note: Rules are now Mappings (like they are called in Cytoscape)
* Note: “interpolate” (a.k.a. “continuous”) is the default, so you can leave it out

## 5.6 Example: Selecting nodes

*BEFORE*

```
selectNodes(cw, 'B')
nodes <- getSelectedNodes (cw)
selectFirstNeighborsOfSelectedNodes (cw)
```

*AFTER*

```
selectNodes('B', 'name') #or 'id'
nodes <- getSelectedNodes()
selectFirstNeighbors()
```

* Note: no more cw!
* Note: selectNodes is by node SUID by default, so you now have to specify if using node name (or other alternative columns). This protects against ambiguous selection.
* Note: selectNodes actually returns the selected nodes and edges after the operation, so you could just do:

```
nodes <- selectNodes('B', 'name')$nodes
```

## 5.7 Example: Saving and exporting

*BEFORE*

```
saveImage(cw, "sample_image", "png", h = 800)
saveNetwork(cw, "sample_session", format = "cys")
```

*AFTER*

```
exportImage("sample_image", "png", h= 800)
saveSession("sample_session")
```

* Note: no more cw!
* Note: subtle renames to match actual operations and outputs

# 6 Going forward

And the next time you start a script from scratch, consider reviewing the
vignettes and other RCy3 scripts available online.

```
browseVignettes('RCy3')
```

Repository of R scripts for Cytoscape, many using RCy3:

* <https://github.com/cytoscape/cytoscape-automation/tree/master/for-scripters/R>