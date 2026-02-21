# Cytoscape and graphNEL

by Alexander Pico

#### 2025-12-04

#### Package

RCy3 2.30.1

This vignette will show you how to convert networks between graphNEL and Cytoscape.

# 1 Installation

```
if(!"RCy3" %in% installed.packages()){
    install.packages("BiocManager")
    BiocManager::install("RCy3")
}
library(RCy3)
```

# 2 Required Software

The whole point of RCy3 is to connect with Cytoscape. You will need to install and launch Cytoscape:

* Download the latest Cytoscape from <http://www.cytoscape.org/download.php>
* Complete installation wizard
* Launch Cytoscape

```
cytoscapePing()
```

# 3 From graphNEL to Cytoscape

The graph package is a popular network tool among R users. With RCy3, you can easily translate graphNEL networks to Cytoscape networks!

Create a simple GraphNEL object

```
g <- makeSimpleGraph()
```

Now pass it along to Cytoscape:

```
createNetworkFromGraph(g,"myGraph")
```

# 4 From Cytoscape to GraphNEL

Inversely, you can use createGraphFromNetwork() in RCy3 to retreive vertex (node) and edge data.frames to construct a GraphNEL object.

```
g2 <- createGraphFromNetwork("myGraph")
```

Compare the round-trip result for yourself…

```
g
g2
```