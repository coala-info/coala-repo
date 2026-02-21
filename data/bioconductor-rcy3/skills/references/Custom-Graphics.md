# Custom Graphics and Labels

Kristina Hanspers, Alexander Pico

#### 2025-12-04

#### Package

RCy3 2.30.1

This vignette illustrates how Cytoscape’s Custom Graphics can be used to add graphs, charts and other graphics to node, and how to combine Custom Graphics with the enhancedGraphics app for specialized visualizations.

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

* **Cytoscape 3.7** or greater, which can be downloaded from <https://cytoscape.org/download.html>. Simply follow the installation instructions on screen.
* Complete installation wizard
* Launch Cytoscape

# 3 Open Sample

For this tutorial, we will be using the galFiltered sample session file, which includes a yeast network and associated data.

```
openSession()
```

## 3.1 Set style and node color

First, lets change the style to a simple default and the color of nodes to grey:

```
setVisualStyle('default')
setNodeColorDefault('#D8D8D8')
```

# 4 Custom Graphics

## 4.1 Bar chart

In this example, we will create a bar chart with the three expression values, gal1RGexp, gal4RGexp and gal80Rexp, available as attributes in the session file.

Create the Custom Graphic:

```
setNodeCustomBarChart(c("gal1RGexp","gal4RGexp","gal80Rexp"))
```

There are 4 types of Bar Charts and customizable parameters for colors, size, spacing and orientation.

Position the Bar Chart just below the node. This is an optional step that we are doing here just to make room for subsequent graphics. By specifying both anchors at opposite ends, we can get a lot of space between the node and the graphic.

```
setNodeCustomPosition(nodeAnchor = "S", graphicAnchor = "N")
```

## 4.2 Stripes

Next we are going to create stripes of gradient mappings using a horizontal “heatmap”" of the same three data columns and position the heatmap right above the node. For this vignette, we need to also specify the slot number to avoid overwriting the Bar Chart:

```
setNodeCustomHeatMapChart(c("gal1RGexp","gal4RGexp","gal80Rexp"), slot = 2)
setNodeCustomPosition(nodeAnchor = "N", graphicAnchor = "S", slot = 2)
```

## 4.3 Pie chart

Finally, we will create a pie chart with two columns, Radiality and Degree, and place it to the left of the node. Here we’ll use the *xOffset* parameter to be even more specific about where we want to place the graphic relative to the node.

```
setNodeCustomPieChart(c("Radiality", "Degree"), slot = 3)
setNodeCustomPosition(nodeAnchor = "W", xOffset = -20, slot = 3)
```

# 5 Enhanced Graphics

The nodes in the network are labeled with the corresponding protein names (yeast), but there is additional text information in the Node Table that could be useful to display as labels on the nodes. We are going to use the enhancedGraphics app to create a second node label for the common yeast gene name.

This involves a new step: Filling a new column with parameters for the enhancedGraphics App. This column is then mapped to a Custom Graphic slot and (optionally) positioned, like in the examples above.

## 5.1 Install enhancedGraphics

The enhancedGraphics app is available from the [Cytoscape App Store](http://apps.cytoscape.org/apps/enhancedgraphics). In Cytoscape 3.7 and above, you can install apps from R with the following function:

```
installApp("enhancedGraphics")
```

## 5.2 Define new label

The new column values have to follow a specific syntax to be recognized by the enhancedGraphics app. Here, for example, is how you set a **label** based on another attribute (e.g., the column called “COMMON”), specifying its size, color, outline and background:

```
"label: attribute=COMMON labelsize=10 color=red outline=false background=false""
```

*For more details on the enhancedGraphics format, [see the manual](http://www.cgl.ucsf.edu/cytoscape/utilities3/enhancedcg.shtml).*

First, we define a dataframe with two columns: node names (“name”) and the new label (“my second label”):

```
all.nodes<-getAllNodes()
label.df<-data.frame(all.nodes, "label: attribute=COMMON labelsize=10 color=red outline=false background=false")
colnames(label.df)<-c("name","my second label")
```

Next, we load this dataframe into the Node Table to create and fill a new column:

```
loadTableData(label.df, data.key.column = "name", table.key.column = "name")
```

## 5.3 Map and position label

We now have a new column, *my second label*, that we can use for the mapping. This mapping does not come with a custom helper function, se we are going to use two alternative functions to prepare the passthrough mapping property and then update our visual style with the new mapping:

```
label.map<-mapVisualProperty('node customgraphics 4','my second label','p')
updateStyleMapping('default', label.map)
```

*Note: the custom graphic slot number is actulally part of the property’s name.*

Finally, we position the new label in the upper right corner:

```
setNodeCustomPosition(nodeAnchor = "E", graphicAnchor = "C", xOffset = 10, slot = 4)
```