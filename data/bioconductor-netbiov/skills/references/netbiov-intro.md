Supplementary File:
NetBioV: An R package for visualizing large network data in biology
and medicine

Shailesh Tripathi1 and Matthias Dehmer2 and Frank Emmert-Streib1*
1 Computational Biology and Machine Learning Laboratory
Center for Cancer Research and Cell Biology
School of Medicine, Dentistry and Biomedical Sciences
Faculty of Medicine, Health and Life Sciences
Queen’s University Belfast
97 Lisburn Road, Belfast, BT9 7BL, UK
v@bio-complexity.com
2 Institute for Bioinformatics and Translational Research, UMIT
Eduard Wallnoefer Zentrum 1, 6060, Hall in Tyrol, Austria

Abstract

This is the supplementary ﬁle for our main manuscript containing instructions and various examples for
the visualization capabilities of NetBioV - an R based software package. Due to the ﬂexibility of NetBioV,
allowing to combine different layout, color and feature styles with each other, there is a vast number of
different network visualizations that can be realized.

*Corresponding author: Frank Emmert-Streib

1

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

Contents

1 Source code for Figure 1 A, B in the main manuscript

2 General guidelines for using NetBioV

3 Brief introduction of networks available as example networks in NetBioV

3.1 Plotting time for networks using NetBioV . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Loading example data
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 Interactive representation

4 Comparison of NetBioV with other network visualization software

4.1 yEd . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Cytoscape . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.3 visANT . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.4 Overview table . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

3

3

4
4
4
5

5
5
5
6
7

5 Network gallery and example code

8
8
5.1 Global layout style of artiﬁcial network 1 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
5.2 Global layout style of artiﬁcial network 2 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
10
5.3 Modular layout style of artiﬁcial network 1 . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
11
5.4 Multiroot-tree (hierarchical) layout style of artiﬁcial network 1 . . . . . . . . . . . . . . . . . .
12
5.5 Modular layout style of artiﬁcial network 2 . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
13
5.6 Abstract modular view of artiﬁcial network 2 . . . . . . . . . . . . . . . . . . . . . . . . . . . .
14
5.7 Global view of a component of the B-Cell network . . . . . . . . . . . . . . . . . . . . . . . . .
15
5.8 Information ﬂow layout of a component of the B-Cell network . . . . . . . . . . . . . . . . . . .
16
5.9 Modular view of a component of the B-Cell network . . . . . . . . . . . . . . . . . . . . . . . .
17
5.10 Information ﬂow layout of a component of the B-Cell network . . . . . . . . . . . . . . . . . . .
18
5.11 Abstract modular view of a component of the B-CELL network . . . . . . . . . . . . . . . . . .
19
5.12 Global layout style of the A. Thaliana network: Fruchterman-Reingold . . . . . . . . . . . . . .
20
5.13 Global layout style of the A. Thaliana network: Kamada-Kawai . . . . . . . . . . . . . . . . . .
21
5.14 Modular layout of the A. Thaliana network: Module highlighting . . . . . . . . . . . . . . . . .
22
5.15 Modular layout of the A. Thaliana network: Colorize modules . . . . . . . . . . . . . . . . . . .
23
5.16 Modular layout of the A. Thaliana network: Fruchterman-Reingold . . . . . . . . . . . . . . . .
24
. . . . . . . . . . . . . . . . . . . . . .
5.17 Modular layout of the A. Thaliana network: Star layout
25
5.18 Modular layout of the A. Thaliana network: Mixed layouts . . . . . . . . . . . . . . . . . . . . .
26
5.19 Modular layout of the A. Thaliana network: Node coloring . . . . . . . . . . . . . . . . . . . .
27
5.20 Modular layout of the A. Thaliana network: Node coloring . . . . . . . . . . . . . . . . . . . .
28
.
5.21 Modular layout of the A. Thaliana network highlighting gene expression in selected modules
29
5.22 Modular layout with hierarchical plots for the modules of the A. Thaliana network . . . . . . . .
30
5.23 Global view of the A. Thaliana network . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
31
5.24 A star-like global view of a scale free network starting with the ﬁve highest degree nodes . . .
32
5.25 A spiral-view of modules in a network . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
33
5.26 A spiral-view of modules in a network . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
34
5.27 Global layout: A spiral-view of the A. Thaliana network starting with the highest degree node .
35
5.28 Global layout: A spiral-view of the A. Thaliana network starting with the highest degree node .
5.29 Global layout: A spiral-view of the A. Thaliana, nodes are ranked using reingold-tilford algorithm 36
37
5.30 An abstract module view of the A. Thaliana network
. . . . . . . . . . . . . . . . . . . . . . .
38
5.31 An abstract module of the A. Thaliana network . . . . . . . . . . . . . . . . . . . . . . . . . .

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

5.32 A modular view of the A. Thaliana network . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.33 Information ﬂow layout: Level plot of the A. Thaliana network . . . . . . . . . . . . . . . . . . .

6 Algorithmic description of the main graph-layouts

6.1 Global view . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.2 Modular view . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.3 Multiroot Tree (Hierarchical) view . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.4 Information ﬂow view . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3

39
40

41
41
42
43
44

1 Source code for Figure 1 A, B in the main manuscript

The following code allows to reproduce Figure 1 A and B in the main manuscript.

> ############ Figure A #############
> library("igraph")
> library("netbiov")
> data("PPI_Athalina")
> gparm <- mst.plot.mod(g1, v.size=1.5,e.size=.25,
+ colors=c("red", "orange", "yellow", "green"),
+ mst.e.size=1.2,expression=abs(runif(vcount(g1),
+ max=5, min=1)), sf=-15, v.sf=5,
+ mst.edge.col="white", layout.function=layout.fruchterman.reingold)
> ############ Figure B #############
> library("igraph")
> library("netbiov")
> data("PPI_Athalina")
> data("color_list")
> gparm<- plot.abstract.nodes(g1, nodes.color=color.list$citynight,
+ lab.cex=1, lab.color="white", v.sf=-18,
+ layout.function=layout.fruchterman.reingold)

2 General guidelines for using NetBioV

In the following, we provide a gallery of networks demonstrating the usage of different layout styles, color schemes and
combinations of these provided by our R package NetBioV. Due to the fact that the functions we provide to visualize
networks are object oriented, there is a vast combination of different visual effects one can generate from the base
functions. Below, for every ﬁgure, the corresponding code is provided to reproduce the ﬁgures. We are including four
example networks with the NetBioV package, two artiﬁcially created networks with 10, 000 and 5, 000 nodes respectively,
and a total number of edges of 32, 761 and 23, 878 respectively. Furthermore, we provide two biological networks, a
gene regulatory network of B-Cell lymphoma inferred with BC3NET and the PPI network of Arabidopsis thaliana; see
Table 1 for details. In NetBioV the functions plot.modules, split.mst, plot.abstract.module and plot.abstract.nodes require
information about their modules for plotting the networks. For this reason there are two ways to specify this information.
(1) The user deﬁnes the modules in the network by specifying a list of objects, where each component of the list object is
a vector of vertex ids of a module. (2) If module information is not provided in this way our plotting functions automatically
predict modular information about the network using the fastgreedy algorithm.

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

4

Networks
Artiﬁcial Network 1
Artiﬁcial Network 2
B-Cell Network
A. Thaliana

number of vertices
10,000
5,000
2,498
1,212

number of edges
32,761
23,878
2,654
2,574

Table 1: Summary of the networks, we provide as part of the NetBioV package to demonstrate its visualization
capabilities.

3 Brief introduction of networks available as example networks in NetBioV

Artiﬁcial Network: First we generate a network of 10000 and 5000 nodes using barabasi.game function available
in igraph. In the second step we select ns nodes randomly of degree greater than 5. In the third step for each
node in ns, we select ne neighbors randomly of order 2 and 3 and draw edges between them.

B-Cell Network: This is a subnetwork of gene regulatory network of B-Cell inferred with BC3NET [1].

A. Thaliana Network: This is a subnetwork of PPI network of the main network [2].

3.1 Plotting time for networks using NetBioV

The plotting time of any network using NetBioV depends on the size of the network and its edge density. To
provide the user with some estimates of the expected plotting times, we compared two artiﬁcially generated
networks with two biological networks on an Apple computer with an intel i3 processor and 8GB RAM. The
estimated time of plotting these networks are given in the Table 2.

Networks \ Functions mst.plot.mod
5.50 minutes
Artiﬁcial Network 1

Artiﬁcial Network 2

1.44 minutes

B-Cell Network
A. Thaliana

6 seconds
3.30 seconds

sec-

19.35 seconds

plot.modules plot.abstract.nodes
25.6
onds
9.94
onds
2 seconds
1.2 seconds

1.1 seconds
1.1 seconds

4.31 seconds

sec-

Table 2: Comparison of estimated plotting times for four different networks using NetBioV.

3.2 Loading example data

> ########## Loading the artificial network with $10,000$ edges
> data("artificial1.graph")
> ########## Loading the artificial network with $5,000$ edges
> data("artificial2.graph")
> ########## Loading the B-Cell network and module information
> data("gnet_bcell")
> data("modules_bcell")
> ########## Loading the Arabidopsis Thaliana network and module information
> data("PPI_Athalina")
> data("modules_PPI_Athalina")

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

5

> ########## Loading a predefined list of colors
> data("color_list")

3.3 Interactive representation

In order to modify a network interactively one, ﬁrst, needs to plot a network with any of the functions we are
providing. Then, one uses the output of these function to call the function ’tkplot.netbiov’. Below is an example.

> data("artificial2.graph")
> xx<- plot.abstract.nodes(g1, layout.function=layout.fruchterman.reingold,
+ v.sf=-30, lab.color="green")
> #tkplot.netbiov(xx)

4 Comparison of NetBioV with other network visualization software

4.1 yEd

yEd is a multi-purpose graph visualization software that does not target any particular networks from application
domains. For this reason, it offers no functionality with respect to the ’modular structure’ in networks from
biology or medicine, as provided by NetBioV. For instance, NetBioV allows the automatic identiﬁcation of the
modules within a network.

yEd allows the visualization of 5 major graph layout styles:

• Hierarchical Layout
• Organic Layout
• Orthogonal Layout
• Tree Layout
• Circular Layout

All of these layouts are available in NetBioV, except ’orthogonal layout’. The reason for this is that the resulting
arrangement of the network, looks like a electronic circuit, which is for networks with more than 100 genes
difﬁcult to apply.

All of these layout styles can only be applied ’globally’ to the network as a whole, but not to selected parts of a
network, as possible with NetBioV. This limit the number of resulting graph layout styles to exactly 5.

Also, yEd does not provide information ﬂow layout styles, as available in NetBioV.

yEd does not allow to identify modules by selecting an algorithm, as is available in NetBioV.

4.2 Cytoscape

Cytoscape allows the usage of a set of commercial layouts provided by yWorks, on which yEd is based too
(see above for graph layout styles of yEd). In addition, Cytoscape provides the following layouts that have been
implemented by the Cytoscape develops:

• Grid Layout
• Spring-Embedded Layout
• Circle Layout
• Group Attributes Layout

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

6

All of these graph layouts, except Grid Layout, are also available from NetBioV. Grid Layout show a regular
arrangements of the nodes in a graph which is hard to apply to network from biology or medicine.

The Group Attributes Layout can be obtained by NetBioV if modules are deﬁned in the network, either by the
application of an algorithm or manually. In addition, NetBioV allows to specify any graph layout for each module
separately. Also, Cytoscape does not provide information ﬂow layout styles, as available in NetBioV.

4.3 visANT

visANT is a graph visualization software that has been speciﬁcally designed to visualize biological networks,
like NetBioV.

The graph layouts provided by visANT are similar to yEd and Cytoscape, and limited to global graph layouts,
meaning that one cannot select parts of a network and use different layout for these, as possible with NetBioV.
Also, visANT does not provide information ﬂow layout styles, as available in NetBioV.

visANT does not allow to identify modules by selecting an algorithm, as available in NetBioV.

visANT does not allow to save ﬁgures in the pdf format, as available in NetBioV. Instead, visANT allows the user
to save ﬁgures in a svg format. If a pdf format is required, e.g., for publications, an external converter software
needs to be used (not part of visANT).

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

7

NetBioV

igraph

Cytoscape VisANT yEd

RgraphViz

in

Yes

Yes (via tkplot
igraph)
Yes

Yes

Yes

R

Java

Java

Tab
delim,
graphml,
gml,
graphdb

BioPax,
XML,
XGMML,
GML,
GRAPHML,
Tab delim
Yes

Tab
delim,
BioPax,
XML

Yes

No

R ob-
ject of
igraph
class
No

No

No

Cys
format

Txt or
XML

No

No

No

No

No

No

Java
(yWorks)
YGF,
GML,
XGML,
excel,
TGF,
GED
Yes

R

Tab
delim

No

Yes

Yes

Graphml,
GML,
TGF,
XGML
No

No

No

R object
of graph
class

No

No

No

No

No

No

No

No

Force-
based

Force-
based

Force-
based

Force-
based

Force-
based

Visualization software⇒
Features ⇓
Application type

Input

Graphical user interface

as

image

Save
postscript or pdf
Save all graph features

a

Modular view with dif-
ferent layout options for
modules
Multiroot-tree visualiza-
tion (information ﬂow)
Information
ﬂow be-
tween sets of nodes or
modules
Abstract view of a net-
work (modular layout)
Global layout

on

(based

R
igraph)
Use formats as
igraph

Data frame (Tab
delim) or a R ob-
ject of netbiv class

Yes

Yes

Yes

Yes

Use
force-based
algorithm on min-
imum
spanning
tree of a network
nodes.
to
Then, add remain-
ing
and
edges
color, based on
distance.

plot

Table 3: Comparison of different network visualization software with NetBioV.

4.4 Overview table

The following table shows a comparison of features provided by NetBioV, yEd, Cytoscape and visANT.

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

8

5 Network gallery and example code

5.1 Global layout style of artiﬁcial network 1
> ###Generation of the network:
> require(netbiov)
> data("artificial1.graph")
> hc <- rgb(t(col2rgb(heat.colors(20)))/255,alpha=.2)
> cl <- rgb(r=0, b=.7, g=1, alpha=.05)
> xx <- mst.plot.mod(g1, vertex.color=cl, v.size=3, sf=-20,
+ colors=hc, e.size=.5, mst.e.size=.75,
+ layout.function=layout.fruchterman.reingold)

Figure 1: Global layout style of artiﬁcial network 1 (|V| = 10, 000, |E| = 32, 761). The positions of the nodes
in the MST (minimum spanning tree) are determined by Fruchterman-Reingold algorithm. Edges found by the
MST are white, other edges are shades of red to yellow.

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

9

5.2 Global layout style of artiﬁcial network 2

> require(netbiov)
> data("artificial2.graph")
> hc <- rgb(t(col2rgb(heat.colors(20)))/255,alpha=.2)
> cl <- rgb(r=1, b=.7, g=0, alpha=.1)
> fn <- function(x){layout.reingold.tilford(x, circular=TRUE,
+ root=which.max(degree(x)))}
> xx <- mst.plot.mod(g1, vertex.color=cl, v.size=1, sf=30,
+ colors=hc, e.size=.5, mst.e.size=.75,
+ layout.function=fn, layout.overall=layout.kamada.kawai)

Figure 2: Global layout style of artiﬁcial network 2 (|V| = 5, 000, |E| = 23, 878). Position of the nodes in the
MST are determined by combining the Reingold-Tilford and the Kamada-Kawai algorithm. Edges found by the
MST are white, other edges are shades of red to yellow.

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

10

5.3 Modular layout style of artiﬁcial network 1

> data("artificial1.graph")
> xx <- plot.modules(g1, v.size=.8,
+ modules.color=c("red", "yellow"),
+ mod.edge.col=c("green", "purple"), sf=30)

Figure 3: Modular layout style of artiﬁcial network 1 (|V| = 10, 000, |E| = 32, 761), modules are plotted using
Reingold-Tilford and Fruchterman-Reingold algorithm. Each module is colored in red or yellow color and
edges of modules are colored in purple and green, the edges connecting modules are colored in grey.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

11

5.4 Multiroot-tree (hierarchical) layout style of artiﬁcial network 1

c(rgb(r=.7, b=.7, g=.7, alpha=.2), rgb(r=.7, b=.7, g=.7, alpha=.2),

> data("artificial1.graph")
> cl <- c(rgb(r=1, b=1, g=0, alpha=.2))
> cl <- rep(cl, 3)
> ecl <-
+ rgb(r=0, b=0, g=1, alpha=.2), rgb(r=.7, b=.7, g=.7, alpha=.2))
> ns <- c(1581, 1699, 4180, 4843, 4931, 5182, 5447, 5822, 6001,
+ 6313, 6321, 6532, 7379, 8697, 8847, 9342)
> xx <- level.plot(g1, tkplot=FALSE, level.spread=TRUE, v.size=1,
+ vertex.colors=cl, edge.col=ecl, initial_nodes=ns, order_degree=NULL,
+ e.curve=.25)

Figure 4: Multiroot-tree (hierarchical) layout style of artiﬁcial network 1 (|V| = 10, 000, |E| = 32, 761). Edges
connecting nodes on different levels are in grey and edges connected nodes on same level are shown in
green.

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

12

5.5 Modular layout style of artiﬁcial network 2

> data("artificial2.graph")
> xx <- plot.modules(g1,mod.lab=TRUE, color.random=TRUE, mod.edge.col="grey",
+ ed.color="gold", sf=15, v.size=.5,layout.function=layout.fruchterman.reingold,
+ lab.color="grey", modules.name.num=FALSE, lab.cex=1, lab.dist=5)

Figure 5: Modular view of artiﬁcial network 2 (|V| = 5, 000, |E| = 23, 878), emphasizing the labels of each
module. The colors of the modules are selected randomly.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllmodule 25module 43module 40module 3module 32module 22module 19module 1module 26module 42module 17module 14module 44module 37module 45module 23module 34module 38module 28module 21module 2module 6module 4module 33module 29module 13module 27module 36module 31module 47module 7module 9module 11module 20module 41module 30module 46module 12module 39module 15module 48module 5module 24module 16module 8module 35module 18module 10Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

13

5.6 Abstract modular view of artiﬁcial network 2

> data("artificial2.graph")
> xx<- plot.abstract.nodes(g1, layout.function=layout.fruchterman.reingold,
+ v.sf=-30, lab.color="green")

Figure 6: Abstract modular view of artiﬁcial network 2 (|V| = 5, 000, |E| = 23, 878) emphasizing the labels
of each module, the size of each module and the total number of connections between modules. The size of
each node represents the number of nodes in that module and the edge-width is proportional to the number
of edges between two modules.

m1 total nodes: 41m2 total nodes: 15m3 total nodes: 107m4 total nodes: 46m5 total nodes: 91m6 total nodes: 198m7 total nodes: 64m8 total nodes: 23m9 total nodes: 53m10 total nodes: 49m11 total nodes: 11m12 total nodes: 96m13 total nodes: 346m14 total nodes: 85m15 total nodes: 235m16 total nodes: 34m17 total nodes: 185m18 total nodes: 112m19 total nodes: 91m20 total nodes: 67m21 total nodes: 51m22 total nodes: 140m23 total nodes: 287m24 total nodes: 39m25 total nodes: 191m26 total nodes: 16m27 total nodes: 452m28 total nodes: 41m29 total nodes: 124m30 total nodes: 17m31 total nodes: 191m32 total nodes: 188m33 total nodes: 77m34 total nodes: 54m35 total nodes: 99m36 total nodes: 61m37 total nodes: 14m38 total nodes: 32m39 total nodes: 48m40 total nodes: 154m41 total nodes: 41m42 total nodes: 80m43 total nodes: 57m44 total nodes: 44m45 total nodes: 188m46 total nodes: 271m47 total nodes: 12m48 total nodes: 82Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

14

5.7 Global view of a component of the B-Cell network

> data("gnet_bcell")
> ecl <- rgb(r=0, g=1, b=1, alpha=.6)
> ppx <- mst.plot.mod(gnet, v.size=degree(gnet),e.size=.5,
+ colors=ecl,mst.e.size=1.2,expression=degree(gnet),
+ mst.edge.col="white", sf=-10, v.sf=6)

Figure 7: Global view of a component of the B-Cell network (|V| = 2, 498, |E| = 2, 654) emphasizing the
expression of the genes. The size of each gene is proportional to the degree of the gene. The color of a gene
reﬂects the gene expression value. The minimum spanning tree edges in the network are shown in white and
all remaining edges are shown in green, in the background.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

15

5.8 Information ﬂow layout of a component of the B-Cell network

> data("gnet_bcell")
> cl <- rgb(r=.6, g=.6, b=.6, alpha=.5)
> xx <- level.plot(gnet, init_nodes=20,tkplot=FALSE, level.spread=TRUE,
+ order_degree=NULL, v.size=1, edge.col=c(cl, cl, "green", cl),
+ vertex.colors=c("red", "red", "red"), e.size=.5, e.curve=.25)
> data("gnet_bcell")
> cl <- rgb(r=.6, g=.6, b=.6, alpha=.5)
> xx <- level.plot(gnet, init_nodes=20,tkplot=FALSE, level.spread=TRUE,
+ order_degree=NULL, v.size=1, edge.col=c(cl, cl, "green", cl),
+ vertex.colors=c("red", "red", "red"), e.size=.5, e.curve=.25)
>

Figure 8: Multiroot-tree (hierarchical) view of a component of the B-Cell network (|V| = 2, 498, |E| = 2, 654).

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

16

5.9 Modular view of a component of the B-Cell network

> data("gnet_bcell")
> xx<-plot.modules(gnet, color.random=TRUE, v.size=1,
+ layout.function=layout.graphopt)
>

Figure 9: Modular view of a component of the B-Cell network (|V| = 2, 498, |E| = 2, 654). Each module is
randomly colored.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

17

5.10 Information ﬂow layout of a component of the B-Cell network

> data("gnet_bcell")
> xx <- plot.modules(gnet, modules.color=cl, mod.edge.col=cl,
+ sf=5, nodeset=c(2,5,44,34),
+ mod.lab=TRUE, v.size=.9,
+ path.col=c("blue", "purple", "green"),
+ col.s1 = c("yellow", "pink"),
+ col.s2 = c("orange", "white" ),
+ e.path.width=c(1.5,3.5), v.size.path=.9)
>

Figure 10: Information ﬂow view of a component of the B-Cell network (|V| = 2, 498, |E| = 2, 654). In this ﬁgure,
we emphasize the information ﬂow between two pairs of gene sets. We show the shortest paths between
modules 2, 5 and modules 34, 44. The shortest paths between modules is highlighted by a thick blue line and
internal paths within the modules are shown in purple and green colors.

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll1027333720114036241541266163314611773094721825413392312282234454219144344353229385821Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

18

5.11 Abstract modular view of a component of the B-CELL network

> data("gnet_bcell")
> xx<-plot.abstract.nodes(gnet, v.sf=-35,
+ layout.function=layout.fruchterman.reingold, lab.color="white",lab.cex=.75)

Figure 11: Abstract modular view of a component of the B-CELL network (|V| = 2, 498, |E| = 2, 654). Node-size
is proportional to the total number of genes in a module and the edge size is proportional to the total number
of connections between modules.

m1 total nodes: 36m2 total nodes: 72m3 total nodes: 19m4 total nodes: 57m5 total nodes: 41m6 total nodes: 41m7 total nodes: 32m8 total nodes: 37m9 total nodes: 23m10 total nodes: 28m11 total nodes: 58m12 total nodes: 82m13 total nodes: 39m14 total nodes: 69m15 total nodes: 69m16 total nodes: 49m17 total nodes: 52m18 total nodes: 48m19 total nodes: 41m20 total nodes: 54m21 total nodes: 51m22 total nodes: 69m23 total nodes: 24m24 total nodes: 44m25 total nodes: 48m26 total nodes: 90m27 total nodes: 45m28 total nodes: 66m29 total nodes: 51m30 total nodes: 42m31 total nodes: 47m32 total nodes: 53m33 total nodes: 82m34 total nodes: 58m35 total nodes: 57m36 total nodes: 54m37 total nodes: 41m38 total nodes: 54m39 total nodes: 118m40 total nodes: 19m41 total nodes: 52m42 total nodes: 78m43 total nodes: 60m44 total nodes: 56m45 total nodes: 60m46 total nodes: 71m47 total nodes: 61Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

19

5.12 Global layout style of the A. Thaliana network: Fruchterman-Reingold

> data("PPI_Athalina")
> data("color_list")
> id <- mst.plot(g1, colors=c("purple4","purple"),mst.edge.col="green",
+ vertex.color = "white",tkplot=FALSE,
+ layout.function=layout.fruchterman.reingold)
>

Figure 12: Global layout style of the A. Thaliana network. The position of the nodes in the MST are determined
by Fruchterman-Reingold, edges found by the MST are shown in green, other edges are shades of purple.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

20

5.13 Global layout style of the A. Thaliana network: Kamada-Kawai

> data("PPI_Athalina")
> data("color_list")
> id <- mst.plot(g1, colors=c("purple4","purple"),mst.edge.col="green",
+ vertex.color = "white",tkplot=FALSE, layout.function=layout.kamada.kawai)

Figure 13: Global layout style of the A. Thaliana network. Positions of the nodes in the MST are determined
by Kamada-Kawai, edges found by the MST are green, other edges are shades of purple.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

21

5.14 Modular layout of the A. Thaliana network: Module highlighting

> data("PPI_Athalina")
> data("color_list")
> data("modules_PPI_Athalina")
> cl <- rep("blue", length(lm))
> cl[1] <- "green"
> id <- plot.modules(g1, layout.function = layout.graphopt, modules.color = cl,
+ mod.edge.col=c("green","darkgreen") , tkplot=FALSE, ed.color = c("blue"),sf=-25)
>

Figure 14: Modular layout of the A. Thaliana network. Each module is plotted separately, by using a force-
based algorithm (layout.graphopt). The nodes in the modules are shown in blue, except for module 1 where
all vertices are shown in green. The edge color of the modules is shown in green.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

22

5.15 Modular layout of the A. Thaliana network: Colorize modules

> data("PPI_Athalina")
> data("color_list")
> data("modules_PPI_Athalina")
> cl <- rep("blue", length(lm))
> cl[1] <- "green"
> cl[2] <- "orange"
> cl[10] <- "red"
> id <- plot.modules(g1, mod.list = lm,
+ layout.function = layout.graphopt, modules.color = cl,
+ mod.edge.col=c("green","darkgreen") ,
+ tkplot=FALSE, ed.color = c("blue"),sf=-25)
>

Figure 15: Modular layout of the A. Thaliana network. Each module is separately plotted by using a force-
based algorithm (layout.graphopt). The nodes for the modules are shown in blue, except for module 1, 2 and
10 where the vertices are shown in green, orange and red. The edge color of the modules is shown in green.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

23

5.16 Modular layout of the A. Thaliana network: Fruchterman-Reingold

> data("PPI_Athalina")
> data("modules_PPI_Athalina")
> data("color_list")
> id<-plot.modules(g1,mod.list=lm,layout.function=c(layout.fruchterman.reingold),
+ modules.color="grey", mod.edge.col = sample(color.list$bright), tkplot=FALSE)

Figure 16: Modular layout style of the A. Thaliana network, the coordinates of the nodes in each module are
determined by Fruchterman-Reingold. The edge color in each module is given by ’mod.edge.col’, the edge
color between modules is grey. The modules are arranged by the number of nodes. The module with the
largest number of nodes is placed into the center, modules of smaller sizes are arranged in a circular manner.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

24

5.17 Modular layout of the A. Thaliana network: Star layout

> data("PPI_Athalina")
> data("color_list")
> id <- plot.modules(g1, layout.function = c(layout.fruchterman.reingold),
+ modules.color = sample(color.list$bright),layout.overall = layout.star,
+ sf=40, tkplot=FALSE)

Figure 17: Modular layout style of the A. Thaliana network, the coordinates of the nodes in each module are
determined by Fruchterman-Reingold. The module consisting of the largest number of nodes is placed in the
center. The other modules are arranged in a circular manner. The colors for the modules are chosen randomly
from a compiled list of bright colors.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

25

5.18 Modular layout of the A. Thaliana network: Mixed layouts

> data("PPI_Athalina")
> data("color_list")
> id <- plot.modules(g1, layout.function = c(layout.fruchterman.reingold,
+ layout.star,layout.reingold.tilford, layout.graphopt,layout.kamada.kawai),
+ modules.color = sample(color.list$bright), sf=40, tkplot=FALSE)

Figure 18: Modular layout style of the A. Thaliana network. The position of different modules is determined by
different layouts given as inputs to the function. Colors for the modules are chosen randomly from a compiled
list of bright colors.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

26

5.19 Modular layout of the A. Thaliana network: Node coloring

> data("PPI_Athalina")
> data("color_list")
> cl <- list(rainbow(40),
> id <- plot.modules(g1,
>

heat.colors(40) )

col.grad=cl , tkplot=FALSE)

Figure 19: Modular layout of the A. Thaliana network. The position of the nodes for each module is determined
by a circular tree view. Nodes in each modules are colored based on their degree according to a range of
colors provided as an input. For example, nodes in module 2 are colored by a range of heat-colors, where
dark colors indicate a high degree and light colors are indicating a low degree.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

27

5.20 Modular layout of the A. Thaliana network: Node coloring

> data("PPI_Athalina")
> data("color_list")
> exp <- rnorm(vcount(g1))
> id <- plot.modules(g1, expression
>

= exp,

tkplot=FALSE)

Figure 20: Modular layout of the A. Thaliana network. When an expression value is given for all nodes then the
nodes are colored based on their expression values from the range of colors (red to blue - smaller to higher
expression value).

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

28

5.21 Modular layout of the A. Thaliana network highlighting gene expression in selected

modules

> data("PPI_Athalina")
> data("color_list")
> exp <- rnorm(vcount(g1))
> id <- plot.modules(g1, modules.color="grey",
+ expression = exp, exp.by.module = c(1,2,5),
>

tkplot=FALSE)

Figure 21: Modular layout of the A. Thaliana network highlighting the variation of the expression values of
nodes in particular modules. In this example we are highlighting the variation in the modules 1, 2, 5 (from red
to blue - low to high).

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

29

5.22 Modular layout with hierarchical plots for the modules of the A. Thaliana network

> data("PPI_Athalina")
> data("color_list")
> id <- plot.modules(g1, layout.function = layout.reingold.tilford,
+ col.grad=list(color.list$citynight), tkplot=FALSE)

Figure 22: A multiroot-tree (hierarchical) plot of the modules of the A. Thaliana network. The nodes are colored
in each module based on their degree by providing a range of colors.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

30

5.23 Global view of the A. Thaliana network

> data("PPI_Athalina")
> data("color_list")
> n = vcount(g1)
> xx <- plot.NetworkSperical(g1, mo="in", v.lab=FALSE, tkplot = FALSE,v.size=1 )

Figure 23: A global view of the A. Thaliana network, starting with the node of the highest degree.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

31

5.24 A star-like global view of a scale free network starting with the ﬁve highest degree

nodes

> g <- barabasi.game(500)
> xx <- plot.NetworkSperical.startSet(g, mo = "in", nc = 5)

Figure 24: A star-like global view of a scale free network starting with the ﬁve highest degree nodes.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

32

5.25 A spiral-view of modules in a network

> g <- barabasi.game(3000, directed=FALSE)
> fn <- function(g)plot.spiral.graph(g,60)$layout
> xx <- plot.modules(g, layout.function=fn,
+ layout.overall=layout.fruchterman.reingold,sf=20, v.size=1, color.random=TRUE)

Figure 25: A spiral-view of modules in a network.

lllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

33

5.26 A spiral-view of modules in a network

> g <- barabasi.game(3000, directed=FALSE)
> fn <- function(g)plot.spiral.graph(g,12)$layout
> xx <- plot.modules(g, layout.function=fn,
+ layout.overall=layout.fruchterman.reingold,sf=20, v.size=1, color.random=TRUE)

Figure 26: A spiral-view of modules in a network.

llllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

34

5.27 Global layout: A spiral-view of the A. Thaliana network starting with the highest degree

node

> data("PPI_Athalina")
> data("color_list")
> xx <- plot.spiral.graph(g1, tp=179,vertex.color=sample(color.list$bright) )

Figure 27: A spiral-view of the A. Thaliana network starting with the highest degree node. Vertices are uniquely
colored according to their degree.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

35

5.28 Global layout: A spiral-view of the A. Thaliana network starting with the highest degree

node

> data("PPI_Athalina")
> data("color_list")
> xx <- plot.spiral.graph(g1, tp=60,vertex.color=sample(color.list$bright))

Figure 28: A spiral-view of the A. Thaliana network starting with the highest degree node. Vertices are
uniquely colored according to their degree.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

36

5.29 Global layout: A spiral-view of the A. Thaliana, nodes are ranked using reingold-tilford

algorithm

> data("PPI_Athalina")
> data("color_list")
> xx <- plot.spiral.graph(g1, tp=90,vertex.color="blue",e.col="gold",
+ rank.function=layout.reingold.tilford)

Figure 29: A spiral-view of the A. Thaliana. Nodes are ranked using reingold-tilford algorithm .

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

37

5.30 An abstract module view of the A. Thaliana network

> data("PPI_Athalina")
> data("color_list")
> xx <- plot.abstract.module(g1, tkplot = FALSE, layout.function=layout.star)
>
>

Figure 30: An abstract-view of the A. Thaliana network, the position of the nodes for each module is deter-
mined by a star-view layout. The edges between the modules are collapsed to single edge. The width of the
edges is proportional to the total number of connection between the modules. Nodes in a module are colored
by a range of heat-colors, where dark colors indicate a high degree and light colors are indicating a low degree
of the node.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

38

5.31 An abstract module of the A. Thaliana network

> data("PPI_Athalina")
> data("color_list")
> xx <- plot.abstract.nodes(g1,
+ edge.colors= sample(color.list$bright), tkplot =FALSE,lab.color = "red")

nodes.color ="grey",layout.function=layout.star,

Figure 31: An abstract view of the A. Thaliana network where the modules are replaced by single nodes
and the connections between the modules are collapsed to single edge. The size of a node is proportional to
the total umber of nodes in the module and the edge width is proportional to the total number of connection
between the modules. The module containing the largest number of nodes is placed in the center, the other
modules are arranged in a circular manner.

lm1 total nodes: 123m2 total nodes: 22m3 total nodes: 109m4 total nodes: 13m5 total nodes: 22m6 total nodes: 82m7 total nodes: 93m8 total nodes: 95m9 total nodes: 22m10 total nodes: 11m11 total nodes: 24m12 total nodes: 61m13 total nodes: 10m14 total nodes: 45m15 total nodes: 21m16 total nodes: 46m17 total nodes: 56m18 total nodes: 35m19 total nodes: 33m20 total nodes: 79m21 total nodes: 31m22 total nodes: 5m23 total nodes: 41m24 total nodes: 35m25 total nodes: 45m26 total nodes: 33m27 total nodes: 20Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

39

5.32 A modular view of the A. Thaliana network

> data("PPI_Athalina")
> data("color_list")
> xx <- splitg.mst(g1, vertex.color = sample(color.list$bright),
+ colors = color.list$warm[1:30], tkplot = FALSE)

Figure 32: A modular view of the A. Thaliana network where the coordinates of the nodes in a module are
determined by the Fruchterman-Reingold algorithm of the MST of the module. The MST edges of the modules
are plotted in white color and all other edges in the module are plotted with a range of warm color. The colors
for the modules are chosen randomly.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

40

5.33 Information ﬂow layout: Level plot of the A. Thaliana network

> data("PPI_Athalina")
> xx <- level.plot(g, tkplot=FALSE, level.spread=FALSE,
+ layout.function=layout.fruchterman.reingold)

Figure 33: Level plot of the A. Thaliana network. The initial nodes on level 1 are picked randomly and their
adjacent neighbors of these nodes are iteratively plotted on consequtive levels. The initial nodes are colored
in orange, all other nodes are shown in maroon. The edges connecting nodes on the same level are shown in
blue with a curved shape.

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSupplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

41

6 Algorithmic description of the main graph-layouts

6.1 Global view

Algorithm 1 Minimum spanning tree global graph layout

n := total no. of vertices.
E := total no. of edges of a graph G.
Gmst : minimum spanning tree of a graph G, with V vertices and Emst edges.
ecolmst := COLOR (assign a unique color to the edges (Emst) of the minimum spanning tree graph ).
coord := apply forced based algorithm (e.g. Fruchterman-Reingold) on Gmst, and get the position of nodes.
Erest := E − Emst.
color_vector:= a color vector with different shades of a color.
repeat

assign a color to Erest(i) from color_vector, based on the distance between their connecting nodes.

until all Erest are colored.
plot the graph G, with coord and their edge colors.

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

42

6.2 Modular view

Algorithm 2 Modular graph layout

E = total number of edges of the graph G.
M = a vector of modules of the graph G.
COORD := get coordinates for location of modules M (the location of modules can be identiﬁed by stan-
dard layout or user deﬁned algorithms on an abstract graph creating from modules where each modules is
replaced by a node and edges between modules by a single edge).
RANK := rank COORD depending on the features of modules (for example module with maximum no of
node will be plotted in a speciﬁc location).
repeat

Mk : pick kth module from M based on its RANK(k).
RANKMk : assign ranks to the nodes of the module Mk.
COORDMk := get coordinates for the nodes of kth module using any standard layout algorithm.
COORDMk := transform each coordinate of COORDMk to the coordinate location COORD(k) of module k
depending on its rank RANK(k).
VCOLMk := assign colors to the nodes of Mk(i) based on their ranks RANKMk (i).
ECOLMk := assign colors to the edges of Mk.
until all modules are assigned their properties.
ECOLrest:= assign colors to the edges of G which are joining two modules.
plot the graph G with the assigned color to the vertices and edges.

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

43

6.3 Multiroot Tree (Hierarchical) view

Algorithm 3 To visualize network with respect to the spread of information within the network

n = total no. of vertices of a graph G = (V, E)
Vk = Pick k vertices randomly from V
level = 0 (initial level)
plot Vk linearly at level
levelup = 1
leveldown = -1
V out
kup = outgoing nodes of Vk
V in
kdown = incoming nodes of Vk
V in
kup = NULL
V out
kdown = NULL
plot Vkup linearly at levelup
plot Vkdown linearly at leveldown
repeat
V out
kup = outgoing nodes of V out
kup
kup = incoming nodes of V out
V in
kup
V out
kdown = outgoing nodes of V in
V in
kdown = incoming nodes of V in
Assign levelup + 1 as Y coordinates to V out
kup
Assign levelup - 1 as Y coordinates to V in
kup
Assign leveldown - 1 as Y coordinates to V in
Assign leveldown - 1 as Y coordinates to leveldown + 1
levelup = levelup + 1
leveldown = leveldown -1
until Vkup = 0 AND Vkdown = 0
Obtain X coordinates of G by using any force-based algorithm.
Plot nodes of G to their corresponding X, Y locations.

kdown

kdown

kdown

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

44

6.4 Information ﬂow view

Algorithm 4 To visualize network with respect to the spread of information within the network

n = total no. of vertices of a graph G = (V, E)
ECOL = is a vector of colors of edges.
VCOL = is a vector of colors of nodes.
{}Vsource and Vdest are source and desination nodes between which the information ﬂow to be visualized.
Vsource = A vector of k1 nodes of G
Vdest = A vector of k2 nodes of G
Apply shortest path distance algorithm Fshortest(G, Vsource, Vdest) on G to ﬁnd shortest paths between Vsource
and Vdes
Esp := Fshortest(G, Vsource, Vdest) (A vector of edge objects of shortest path between Vsource and Vdes)
Vpath is a set of nodes which connectes Vsource and Vdes through Esp
ECOLEsp:= assign a color to the edges of Esp.
VCOLVpath:= assign a color to the nodes of Vpath.
COORD = Find coordinates of G using Algorihm 2 or 3
Plot nodes of G to their corresponding locations speciﬁed by COORD.

Supplementary File:
NetBioV: An R package for visualizing large network data in biology and medicine

45

> sessionInfo()

R version 3.4.0 (2017-04-21)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.2 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[4] LC_COLLATE=C
[7] LC_PAPER=en_US.UTF-8

[10] LC_TELEPHONE=C

LC_NUMERIC=C
LC_MONETARY=en_US.UTF-8
LC_NAME=C
LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_TIME=en_US.UTF-8
LC_MESSAGES=en_US.UTF-8
LC_ADDRESS=C

attached base packages:
[1] stats

graphics grDevices utils

datasets

methods

base

other attached packages:
[1] netbiov_1.10.0 igraph_1.0.1

loaded via a namespace (and not attached):

[1] Rcpp_0.12.10
[6] backports_1.0.5 magrittr_1.5

lattice_0.20-35 digest_0.6.12
evaluate_0.10

[11] rmarkdown_1.4
[16] compiler_3.4.0 htmltools_0.3.5 knitr_1.15.1

BiocStyle_2.4.0 tools_3.4.0

rprojroot_1.2
stringi_1.1.5
stringr_1.2.0

grid_3.4.0
Matrix_1.2-9
yaml_2.1.14

References

[1] Ricardo de Matos Simoes and Frank Emmert-Streib. Bagging statistical network inference from large-scale
gene expression data. PLoS ONE, 7(3):e33624, 03 2012. URL: http://dx.doi.org/10.1371%2Fjournal.pone.
0033624, doi:10.1371/journal.pone.0033624.

[2] Bobby-Joe Breitkreutz, Chris Stark, Teresa Reguly, Lorrie Boucher, Ashton Breitkreutz, Michael Livs-
tone, Rose Oughtred, Daniel H. Lackner, JÃ¼rg BÃ¤hler, Valerie Wood, Kara Dolinski, and Mike Tyers.
The biogrid interaction database: 2008 update. Nucleic Acids Research, 36(suppl 1):D637–D640, 2008.
URL: http://nar.oxfordjournals.org/content/36/suppl_1/D637.abstract, arXiv:http://nar.oxfordjournals.
org/content/36/suppl_1/D637.full.pdf+html, doi:10.1093/nar/gkm1001.

