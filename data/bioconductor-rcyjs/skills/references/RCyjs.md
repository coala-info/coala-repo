# RCyjs: interactive network visualization using cytoscape.js

Paul Shannon

#### 2025-10-30

#### Package

RCyjs 2.32.0

# Contents

* [1 Introduction](#introduction)
* [2 Overview](#overview)
* [3 Load the RCyjs package and its dependencies](#load-the-rcyjs-package-and-its-dependencies)
* [4 Create the graph: two nodes, one edge between them](#create-the-graph-two-nodes-one-edge-between-them)
* [5 Set up default node and edge attributes on the graph](#set-up-default-node-and-edge-attributes-on-the-graph)
* [6 Add the actual initial attributes](#add-the-actual-initial-attributes)
* [7 Controlling Visual Attributes](#controlling-visual-attributes)
  + [7.1 Methods for mapping data attributes to visual attributes](#methods-for-mapping-data-attributes-to-visual-attributes)
  + [7.2 Builtin shapes](#builtin-shapes)
  + [7.3 Change some of the default styling](#change-some-of-the-default-styling)
  + [7.4 Assign visual properties directly to specific nodes](#assign-visual-properties-directly-to-specific-nodes)
  + [7.5 Reset to the default style](#reset-to-the-default-style)
  + [7.6 Motivating visual mapping rules](#motivating-visual-mapping-rules)
* [8 Node positioning](#node-positioning)
  + [8.1 Layout by algorithm](#layout-by-algorithm)
  + [8.2 Layout by ad hoc calculation](#layout-by-ad-hoc-calculation)
  + [8.3 Interactive placement on the cytoscape.js canvas](#interactive-placement-on-the-cytoscape.js-canvas)
  + [8.4 Programmitc layout assists](#programmitc-layout-assists)
* [9 Convenience functions for edge and node attributes](#convenience-functions-for-edge-and-node-attributes)
* [10 A two node Activator-Target example: data-driven node size, color, position](#a-two-node-activator-target-example-data-driven-node-size-color-position)

# 1 Introduction

Network (graph) visualization is useful for exploring relationships among entities, in biology as in other disciplines. cytoscape.js - part of the “Cytoscape ecosystem” of network vizualization and analysis tools - runs in all web browsers; RCyjs uses JSON messages over websockets to communicate between cytoscape.js and R, and all operations are provided as R function calls supplemented by interactive (mouse) operations in the browser.

This web-based implementation is related to, and can exchange data with the
desktop version of Cytoscape: , which has its own Bioconductor package, RCy3. RCyjs requires no external software beyond your web browser. RCy3, in contrast, and in order to provide access to the broad capabilities of desktop Cytoscape, requires its installation on your computer. Both approaches are useful.

Following standard Bioconductor practice, full support is offered here for the core Bioconductor representation of network data: the graphNEL (node edge list) class. graphNELs support an number of node and edge attributes on a graph, along with easy conversion from graphAM (adjacency matrix) objects. Two alternative representations of graphs are indirectly supported at present, with direct support coming with the next release of RCyjs in autumn 2018: that of the popular igraph package, and the new data.frame representation used by the Cytoscape Consortium in their updates to the RCy3 package. But at present, users of these representations must transform their data into graphNELs: see igraph.to.graphNEL in the igraph package.

One weakness of the graphNEL class, reflecting its origins in graph theory, is that at most one edge can exist between any two nodes. In common biological practice - and in the cytoscape ecosystem - multiple edges between a pair of nodes, in the same direction, can be useful. This weakness will be addressed in the next release of the package.

# 2 Overview

Though a graph is fundamentally a static data structure, it can be used - and RCyjs encourages its use - as a represention of dynamic processes. A few techniuqes enable this:

* assigning and subsequently modifying node and edge attribute data
* flexible mapping of these attributes to various visual representations
* positioning nodes using supplied layout algorithms, by manual placement, by calculations (over time series data, for instance), or by a combination of these methods

Relations implicit in your data are thus made visible. We demonstrate these techniques with a small two-node example.

# 3 Load the RCyjs package and its dependencies

# 4 Create the graph: two nodes, one edge between them

The names you choose for nodes become their reference identifiers - their id. These character strings are the names by which they are subsequently manipulated and queried. Visual mapping rules, however, allow you to use other names for display purposes. Here “A” and “T” is compact, easy to use, but we later set a “label” attribute on the nodes (“Activator” and “Target”) and optionally use that in the display.

```
nodes <- c("A", "T")
g <- graphNEL(nodes, edgemode="directed")
g <- graph::addEdge("A", "T", g)
```

# 5 Set up default node and edge attributes on the graph

Attributes are universal: every node has all the node attributes, every edge has all the edge attributes. This requirement is easily met by setting defaults:

```
nodeDataDefaults(g, attr="label") <- "undefined"
nodeDataDefaults(g, attr="type") <- "undefined"
nodeDataDefaults(g, attr="flux") <- 0
edgeDataDefaults(g, attr="edgeType") <- "undefined"
```

# 6 Add the actual initial attributes

These attributes will remain fixed. Node flux will change.

```
nodeData(g, nodes, attr="label") <- c("Activator", "Target")
nodeData(g, nodes, attr="type") <- c("ligand", "receptor")
edgeData(g, "A", "T", attr="edgeType") <- "binds"
```

# 7 Controlling Visual Attributes

## 7.1 Methods for mapping data attributes to visual attributes

We provide three methods to control the visual appearance of nodes and edges in the graph:

1. programmatically assign defaults which then apply to all nodes and all edges
2. programmatically assign specific visual attributes to specific nodes
3. load “style” files containing data-to-appearnce rules of arbitrary complexity

RCyjs provides a minimal style via the function *setDefaultStyle* which we use to get started. We now create an RCyjs instance, load the graph, and create a minimal display, after which the three mapping methods are presented.

```
rcy <- RCyjs(title="RCyjs vignette")
setGraph(rcy, g)
layout(rcy, "grid")
fit(rcy, padding=200)
setDefaultStyle(rcy)
```

## 7.2 Builtin shapes

cytoscape.js ships with seventeen node shapes, and ten “edge decorators” - the small symbols (arrows, tee) which can be placed at the ends of edges connecting the nodes. Edges may be “solid”, “dotted” or “dashed”.

```
getSupportedNodeShapes(rcy)
getSupportedEdgeDecoratorShapes(rcy)
```

## 7.3 Change some of the default styling

These setting then apply equally to all nodes and all edges.
For an exhaustive inventory and examples of these methods, see \_test\_setDefaultStyleElements() in
system.file(package=“RCyjs”, “unitTests”, “test\_RCyjs.R”)

```
setDefaultNodeShape(rcy, "roundrectangle")
setDefaultNodeSize(rcy, 50)
setDefaultNodeColor(rcy, "lightgreen")
setDefaultNodeFontSize(rcy, 8)
setDefaultNodeFontColor(rcy, "darkgreen")
setDefaultEdgeLineStyle(rcy, "dotted")
setDefaultEdgeWidth(rcy, 1)
setDefaultEdgeLineColor(rcy, "black")
setDefaultNodeBorderWidth(rcy, 2)
setDefaultNodeBorderColor(rcy, "white")
setBackgroundColor(rcy, "#F0F0F0")
setDefaultEdgeTargetArrowShape(rcy, "arrow")
redraw(rcy)
```

## 7.4 Assign visual properties directly to specific nodes

Similar operations upon specific edges are not yet available - but are easily controlled via a style file as explained in the next section.

```
setNodeColor(rcy, "A", "lightblue")
setNodeSize(rcy, "T", 80)
setNodeShape(rcy, "A", "hexagon")
setNodeBorderWidth(rcy, "A", 3)
redraw(rcy)
```

## 7.5 Reset to the default style

```
setDefaultStyle(rcy)
```

## 7.6 Motivating visual mapping rules

In the two-node example given below we animate the display by successively updating the *flux* parameter on each node, simulating (in the most basic form) the activity of the target based upon the activity of the activator. We begin by specifying rules which map node color and node size to the current value of *flux*. These rules are contained in the *extdata/vignetteStyle.js* file included in the package, whose nature we introduce here by quoting the node style rules.

Note that rules for ALL nodes are presented first, followed by specialized color and shape rules for nodes of different types (activator nodes and target nodes). Note especially the *mapData* functions: they calculate visual attributes from the current value of the specified data attributes. Both nodes share the same size (width and height) rule, and different color rules.

These rules are invoked and applied by RCyjs every time you call the *redraw* method.

```
    {selector: "node", css: {
        "width": "mapData(flux, 0, 1000, 20, 100)",
        "height": "mapData(flux, 0, 1000, 20, 100)",
        "shape": "ellipse",
        "text-halign": "center",
        "text-valign": "center",
        "background-color": "lightblue",
        "color": "black",
        "font-size": 12,
        "border-width": 1,
        "border-color": "lightgray",
        "content": "data(id)"
        }},

   {selector:"node[type='activator']", css: {
       "shape": "diamond",
       "background-color": "mapData(flux, 0, 1000, white, red)",
       }},

   {selector:"node[type='target']", css: {
       "shape": "roundrectangle",
       "background-color":"mapData(flux, 0, 1000, white, darkgreen)",
       }},

    {selector:"node:selected", css: {
       "overlay-opacity": 0.5,
       }},

    {selector: 'edge:selected', css: {
       "overlay-opacity": 0.2,
        }},
```

# 8 Node positioning

Before running the example code, let’s discuss the several options RCyjs provides for node placement
- arguably the most important aspect of graph visualization:

1. layout by algorithm
2. layout by ad hoc calculation
3. interactive placement on the cytoscape.js canvas
4. programmatic layout “assists”, typically of selected nodes

## 8.1 Layout by algorithm

For the currently displayed graph, these layout strategies are always available, written into the cytoscape.js code. Their use here is not visually interesting: our graph is too small. We conclude be resetting the basic grid layout which sets us up for subsequence code chunks later in this vignette.

```
for(layout.name in getLayoutStrategies(rcy)){
  layout(rcy, layout.name)
  Sys.sleep(1)
}
layout(rcy, "grid")
fit(rcy, padding=150)
```

## 8.2 Layout by ad hoc calculation

RCyjs provides two methods: *getLayout* and *setLayout*. These return and consume, respectively, a data.frame with an id, x and y column. Their use is demonstrated in the example below to perform a simple animation. They can also be used if you wish to create your own layout algorithm.

## 8.3 Interactive placement on the cytoscape.js canvas

This traditional direct manipulation of nodes needs little introduction: simply click on a node, or drag a box around multiple nodes, then drag them to their new location. You can use this approach for all the nodes in a graph but more plausibly you will find it useful following your use of an algorithmic layout, to fine-tune or correct its deficiencies. Once you have a layout you like and wish to keep, these two methods will be useful:

```
saveLayout(rcy, filename)
restoreLayout(rcy, filename)
```

RCyjs saves the layout as a data.frame in a compact RData format ready to be reused again later.

## 8.4 Programmitc layout assists

1. vAlign: align currently selected nodes vertically at their average x coordinate, preserving their y coordinates
2. hAlign: currently selected nodes horizontally at their average y coordinate, preserving x
3. layoutSelectionInGrid(rcy, x, y, w, h): anchor at x,y, grid is w x h
4. layoutSelectionInGridInferAnchor(rcy, w, h): infer anchor from top-most, left-most node

# 9 Convenience functions for edge and node attributes

RCyjs provides a utility function which creates a small 3-node, 3-edge graphNEL with several node and edge attributes. We use this example to introduce simple attribute inspection:

```
library(RCyjs)
gDemo <- simpleDemoGraph()
noaNames(gDemo)
edaNames(gDemo)
noa(gDemo, "type")
noa(gDemo, "lfc")
eda(gDemo, "edgeType")
eda(gDemo, "score")
```

# 10 A two node Activator-Target example: data-driven node size, color, position

This toy 2-node network illustrates all the principles and operations explained above - all of which scale easily to more realistic networks and their visualization.

```
sessionInfo()
```