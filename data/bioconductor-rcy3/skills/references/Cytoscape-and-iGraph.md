# Cytoscape and igraph

by Alexander Pico

#### 2025-12-04

#### Package

RCy3 2.30.1

This vignette will show you how to convert networks between igraph and Cytoscape.

# 1 Installation

```
if(!"RCy3" %in% installed.packages()){
    install.packages("BiocManager")
    BiocManager::install("RCy3")
}
library(RCy3)
library(igraph)
```

# 2 Required Software

The whole point of RCy3 is to connect with Cytoscape. You will need to install and launch Cytoscape:

* Download the latest Cytoscape from <http://www.cytoscape.org/download.php>
* Complete installation wizard
* Launch Cytoscape

```
cytoscapePing()
```

# 3 From igraph to Cytoscape

The igraph package is a popular network tool among R users. With RCy3, you can easily translate igraph networks to Cytoscape networks!

Here is a basic igraph network construction from the graph\_from\_data\_frame docs, <http://igraph.org/r/doc/graph_from_data_frame.html>:

```
actors <- data.frame(name=c("Alice", "Bob", "Cecil", "David",
                            "Esmeralda"),
                     age=c(48,33,45,34,21),
                     gender=c("F","M","F","M","F"))
relations <- data.frame(from=c("Bob", "Cecil", "Cecil", "David",
                               "David", "Esmeralda"),
                        to=c("Alice", "Bob", "Alice", "Alice", "Bob", "Alice"),
                        same.dept=c(FALSE,FALSE,TRUE,FALSE,FALSE,TRUE),
                        friendship=c(4,5,5,2,1,1), advice=c(4,5,5,4,2,3))
ig <- graph_from_data_frame(relations, directed=TRUE, vertices=actors)

# if function not found, then you need to install igraph. Try library(igraph)
```

You now have an igraph network, g. In order to translate the network together with all vertex (node) and edge attributes over to Cytoscape, simply use:

```
createNetworkFromIgraph(ig,"myIgraph")
```

# 4 From Cytoscape to igraph

Inversely, you can use createIgraphFromNetwork() in RCy3 to retrieve vertex (node) and edge data.frames to construct an igraph network.

```
ig2 <- createIgraphFromNetwork("myIgraph")
```

Compare the round-trip result for yourself…

```
ig
ig2
```

Note that a few additional attributes are present which are used by Cytoscape to
support node/edge selection and network collections.

**Also note: All networks in Cytoscape are implicitly modeled as *directed*. This means that if you start with an *undirected* network in igraph and then convert it round-trip (like described above), then you will end up with a *directed* network.**