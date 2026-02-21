RCytoscape

Paul Shannon

July 20, 2017

Cytoscape is a well-known bioinformatics tool for displaying and exploring biological
networks. R is a powerful programming language and environment for statistical and
exploratory data analysis. RCytoscape uses XMLRPC to communicate between R and
Cytoscape, allowing Bioconductor graphs to be viewed, explored and manipulated with
the Cytoscape point-and-click visual interface. Thus these two quite diﬀerent, quite
useful bioinformatics software environments are connected, mutually enhancing each
other, providing new possibilities for exploring biological data.

1 Prerequisites

In addition to this package (RCytoscape), you will need:

(cid:136) XMLRPC, an R package which provides the communication layer for your R

session. It can be downloaded from http://www.omegahat.org/XMLRPC/

(cid:136) Cytoscape version 2.8.1, which can be downloaded from http://cytoscape.org.

(cid:136) CytoscapeRPC, version 1.7 or later, a Cytoscape plugin which provides the Cy-
toscape end of the communication layer, can be downloaded from the Cytoscape
plugins website: http://cytoscape.org/plugins.html.

2 Getting Started

Install the CytoscapeRPC plugin. This process is explained at

http://cytoscape.org/manual/Cytoscape2_8Manual.html#PluginsandthePluginManager

but brieﬂy (and, for many readers, more simply), installation consists of copying the
plugin’s jar ﬁle to the ’Plugins’ directory of your installed Cytoscape application, and
then restarting Cytoscape. You should see CytoscapeRPC in Cytoscape’s Plugins

1

menu; click to activate the plugin, which starts the XMLRPC server, and which listens
for commands from R (or elsewhere). The default and usual choice is to communi-
cate over port 9000 on localhost. You can choose a diﬀerent port from the Plugins-
>CytoscapeRPC activate menu item. If you choose a diﬀerent port, be sure to use that
port number when you call the RCytoscape constructor – the default value on in the
constructor argument list is also 9000. You probably want to set ’Auto Start’ on for the
plugin, which can be done from its ’Settings’ menu.

3 A minimal example

Here we create a 3-node graph in R, send it to Cytoscape for display and layout. For the
sake of simplicity, no node attributes, no edges, and no vizmapping is included; those
topics are covered in subsequent examples.

’

’

library(RCytoscape)
graphNEL
g <- new (
g <- graph::addNode (
g <- graph::addNode (
g <- graph::addNode (
cw <- new.CytoscapeWindow (
displayGraph (cw)

, edgemode=
, g)
, g)
, g)
’

A
B
C

’
’
’

’
’
’

>
>
>
>
>
>
>
>

’

directed

)

’

vignette

, graph=g)

’

You should now see a single red dot in the middle of a small Cytoscape window titled
’simple’, contained along with possibly other windows within the Cytoscape Desktop.
This graph needs layout. You can accomplish this in two ways: by function call (see
below), or interactively from the Cytoscape ’Layout’ menu, where a reasonable choice is
’JGraph Layouts’ -> ’GEM Layout’, or ’yFiles Organic’.

After layout, you will see the structure of this graph: 3 unconnected nodes, unlabeled,
small and colored red, and thus not very informative. Fortunately, Cytoscape has some
built-in rendering rules in which (and unless instructed otherwise) nodes are rendered
round in shape, pale red in color, and labeled with the names supplied when they were
added to the graph; edges (if any) are simple blue lines. To get this default rendering,
simply type

>
>

layoutNetwork (cw, layout.name=
redraw (cw)

’

4 Add node attributes

’

grid

)

We often know quite a lot about the nodes and edges in our graphs. By conveying this
information visually, the graph will be easier to explore. For instance, we may know that

2

protein A phosphorylates protein B, that A is a kinase and B a transcription factor, and
that their mRNA expression (compared to a control) is a log fold change, base 2, of
1.8 and 3.2 respectively. One of the core features of Cytoscape, the ’vizmapper’, allows
you to specify how data values (e.g., ’kinase’, ’transcription factor’; expression ratios)
should control the visual attributes of the graph (node shape, node color or size). Here
(Note: edge attributes behave just like node attributes. They
is a simple example.
can be assigned, communicated along with their graph to R, and used to control visual
attributes of the graph. In the current exercise, however, to keep things simple, only
node attributes are discussed. Edges and edge attributes are discussed below.)

We continue with the small 3-node graph created in the previous code example,
adding two kinds data attributes (’moleculeType’ and ’lfc’). Note, however, that adding
the attributes does not in itself cause the appearance of the graph to change. Such
a change requires that you specify and apply the visual mapping rules, which will be
explained in the next section.

You can, however, examine these attributes in Cytoscape, using Cytoscape’s the
’Data Panel’ to display attribute values of all nodes currently selected in the Cytoscape
window:

(cid:136) Select a node or nodes with your mouse (or programmatically, from R, using the

’selectNodes’ function)

(cid:136) Open up Cytoscape’s Data Panel (from the View menu)

(cid:136) The attributes are displayed in a spreadsheet-like format in the Data Panel

You will encounter one obscurity in the code chunk just below: the explicit initializa-
tion of node (and edge) attributes for a graph. This is similar to, but goes a bit further
than, calls to nodeDataDefaults required for Bioconductor graph objects. In fact, such
calls are executed within the RCytocape initNodeAttribute and initEdgeAttribute meth-
ods. An additional bit of information is required here: the ’class’ or data type of the
attribute you are initializing. It can be ’char’, ’integer’ or ’numeric’.

For instance, the node attribute ’moleculeType’ has values which are character
strings. The node attribute ’lfc’ (log fold change) is declared to be numeric. This
extra fuss is unavoidable:
if you do not stipulate the class of each node and edge at-
tribute, as is demonstrated below, then RCytoscape will report an error. We require this
because it is only by way of such explicit assignment that RCytoscape can resolve the
diﬀerence between integer and ﬂoating point values – necessary in the statically typed
Java language (in which Cytoscape is written) though not in R.

Here is the code for adding attributes to the nodes of the 3-node graph whose creation
is demonstrated above. Note that one usually creates the structure of a graph – specify
its nodes and edges – initializes node and edge attributes, speciﬁes values for those
attributes, and only then displays the graph. For tutorial purposes here, the already-
displayed graph is modiﬁed and redisplayed.

3

g <- cw@graph
g <- initNodeAttribute (graph=g, attribute.name=

# created above, in the section

’
’

A minimal example
moleculeType

,

’

’

’
’
’
’
’
’

’
’
’
’
’
’

g <- initNodeAttribute (graph=g,
’
’
moleculeType
,
nodeData (g,
’
’
moleculeType
,
nodeData (g,
’
’
moleculeType
,
nodeData (g,
’
lfc
,
nodeData (g,
’
lfc
,
nodeData (g,
’
nodeData (g,
lfc
,
cw = setGraph (cw, g)
displayGraph (cw)
redraw (cw)

) <- -1.2
) <- 1.8
) <- 3.2

A
B
C
A
B
C

# cw

’
’
’

’

’

attribute.type=
’
default.value=
’
lfc
’
’
’

) <-
) <-
) <-

’

’

char

,

’

undefined
,

numeric

’

)
’

’

kinase
’
TF
cytokine

’

, 0.0)

s graph is sent to Cytoscape

>
>
+
+
>
>
>
>
>
>
>
>
>
>
>

You can now explore these simple node attribute values in Cytoscape, selecting nodes,
and navigating around inside the Cytoscape ’Data Panel’ – which is designed for exactly
that purpose.

5 Modifying the display: default values and map-

ping rules

By default, Cytoscape displays nodes as pale red circles circles, and edges as blue undec-
orated lines. RCytoscape provides an easy way to change these defaults. More interest-
ingly, RCytoscape provides easy programmatic access to the vizmapper, by means of
which the size, shape and color of nodes and edges is determined by the data attributes
you have attached to those nodes and edges.

First, let’s change the the defaults. Note that ’redraw’ must be called on the Cy-
toscapeWindow to force an update of the display. Cytoscape is a little inconsistent about
this: setting defauls, like you see below, requires the redraw, but setting rules (about
which more below) does not. We hope to get more consistency of Cytoscape soon. In
the meantime, if you are rendering a larg graph, you may want to call this only when
you are sure you need to.

>
>
>
>
>

’
’

setDefaultNodeShape (cw,
setDefaultNodeColor (cw,
setDefaultNodeSize (cw, 80)
setDefaultNodeFontSize (cw, 40)
redraw (cw)

octagon
#AAFF88

’
’

)
)

Now we will add some visual mapping – (vizmap) – rules. These rules connect data
attributes to visual attributes, thereby giving the eye with additional information about

4

the network. In our ﬁrst mapping, we use map from the data attribute ’moleculeType’
to node shapes to. To begin, ask Cytoscape for the node shape names it recognizes.
Then query the graph for a list of the data attributes, establishing that ’moleculeType’
is indeed a current data attribute of all nodes. Then ﬁnd out what distinct values are
deﬁned for moleculeType across the nodes of the graph. Finally, deﬁne and set the rule.

>
>
>
>
>
>
+
>

# diamond, ellipse, trapezoid, triangle, etc.

getNodeShapes (cw)
print (noa.names (getGraph (cw))) # what data attributes are defined?
print (noa (getGraph (cw),
,
TF
attribute.values <- c (
’
triangle
node.shapes
<- c (
’
setNodeShapeRule (cw, node.attribute.name=

cytokine
’
,
rect
moleculeType

moleculeType
’
’

kinase
diamond

’
’

’
’

))

,
’

,

)

)

,

’

’

’

’

’

’

redraw (cw)

attribute.values, node.shapes)

The node shape rule, just above, is an example of a ’lookup’ rule, which is sometimes
called a ’discrete’ rule. The network has three nodes, each of them a gene, and each
of them has a ’moleculeType’ attribute. In this case, the values are ’kinase’, ’TF’ (for
transcription factor) and ’cytokine’. These are the discrete values taken on by the
moleculeType node attribute. For each, we specify the shape we wish to use in rendering
that type of molecule. Thus, there is a discrete set of values, and we map from those
values to shapes by a simple ’lookup’ process.

(Note (14 November 2011): Cytoscape 2.8 apparently has some bugs in handling
default values in vizmap rules. For the time being, in creating a lookup rule, it is best to
specify a complete mapping between data values and, i.e., node shape. That is, specify
all possible discrete data values, and provide an explicit mapping for all of them.)
A second class of rules – in contrast to lookup rules – uses interpolation.

In the
classic example, every node (every gene) has a mRNA expression value, expressed as a
log fold change (’lfc’) ratio, experiment vs. control. Nodes with negative lfc are rendered
in shades of green; nodes with positive lfc are rendered in shades of red. Nodes with
lfc == 0 are rendered in white. All intermediate values are rendered in appropriately
interpolated shades of either green or red.

setNodeColorRule and setNodeSizeRule are commonly interpolation rules: use mode=’interpolate’.

But they may also be called as lookup rules: use parameter mode=’lookup’ to accom-
plish this, and provide as many data points and sizes (or colors) needed to cover all
possible values of the attribute you are mapping.

>
+
+

setNodeColorRule (cw,
c (
mode=

’

’

#00AA00

,

’

’

interpolate

#00FF00
)

’

lfc

, c (-3.0, 0.0, 3.0),

’

’

’

’

,

#FFFFFF

,

’

’

#FF0000

’

,

’

#AA0000

),

’

Note that there ﬁve colors, but only three control.points. The two additional colors
tell the interpolated mapper which colors to use if the stated data attribute (lfc) has a

5

value less than the smallest control point (paint it a darkish green, #00AA00) or larger
than the largets control point (paint it a darkish red, #AA0000). These extreme (or
out-of-bounds) colors may be omitted:

setNodeColorRule (cw,
c (
mode=

’

’

#00FF00

,

’

’

interpolate

#FFFFFF
)

’

lfc

, c (-3.0, 0.0, 3.0),

’

’

,

#FF0000

),

’

’

’

in which case RCytoscape will resuse the ﬁrst and last values (green and red) for

out-of-bounds values, and issue a warning to the console.

Now, add a node size rule, using ’lfc’ again as the controlling node attribute.

control.points = c (-1.2, 2.0, 4.0)
node.sizes
setNodeSizeRule (cw,

= c (10, 20, 50, 200, 205)

’

’

lfc
’

mode=

interpolate

)

’

, control.points, node.sizes,

6 Add some edges, edge attributes, and some rules

for their rendering.

g <- cw@graph
g <- initEdgeAttribute (graph=g, attribute.name=

’

edgeType

,

’

’
’
’

’
’
’

attribute.type=
’
default.value=
B
, g)
,
C
, g)
,
, g)
,
A
’
edgeType
’
edgeType
’
edgeType

) <-
) <-
) <-

’
’
’

’
’
’

’
A
’
B
’
C
’
’
’

’

’

char

,

unspecified

)

’

’

phosphorylates
promotes
indirectly activates

’

’

’
’
’

g <- graph::addEdge (
g <- graph::addEdge (
g <- graph::addEdge (
’
,
edgeData (g,
’
,
edgeData (g,
’
edgeData (g,
,
cw@graph <- g
displayGraph (cw)
DOT
line.styles = c (
edgeType.values = c (

A
B
C

B
C
A

,
,
,

’
’
’

’
’
’

’

’
’
’

’

’

’

,

SOLID

,
phosphorylates
indirectly activates

SINEWAVE
,

)
promotes
)

’

’

’

’

,

’

’

’

setEdgeLineStyleRule (cw,

edgeType

, edgeType.values,

line.styles)

redraw (cw)
arrow.styles = c (
setEdgeTargetArrowRule (cw,

Arrow

,

’

’

’

Delta
’

’

’

,

’

)

Circle
’

edgeType
arrow.styles)

, edgeType.values,

6

>
+
+

>
>
>
+
>

>
>
+
+
>
>
>
>
>
>
>
>
>
>
+
>
+
>
>
>
+

7 Hide, Show, and Float Cytoscape Panels

If you want to have more of the Cytoscape Desktop devoted to displaying your graph,
you can hide the panels which normally occupy the left and bottom proting of that
Desktop. There are related panels for ’docking’ and ’ﬂoating’ those panels. To save
on typing, your arguments to these functions (see below) can be very terse, and are
case-independent.

>
>
>
>
>
>

hidePanel (cw,
floatPanel (cw,
dockPanel (cw,
hidePanel (cw,
floatPanel (cw,
dockPanel (cw,

’

’
’

’

Data Panel
’

’

’

)

)

D
’

)

d
Control Panel
’

’

control
’

)

c

)

’

)

8 Selecting Nodes

Let us now try some simple back-and-forth between Cytoscape and R. In Cytoscape,
click the ’B’ node. In R:

getSelectedNodes (cw)

>
>

Now we wish to extend the selected nodes to include the ﬁrst neighbors of the already-
selected node ’B’. This is a common operation: for instance, after selecting one or more
nodes based on experimental data or annotation, you may want to explore these in the
context of interaction partners (in a protein-protein network) or in relation to upstream
and downstream partners in a signaling or metabolic network. Type:

>

selectFirstNeighborsOfSelectedNodes (cw)

You will see that all three nodes are now selected. Get their identifers back to R:

>

nodes <- getSelectedNodes (cw)

9 Positioning nodes (and possibilities for data-driven

graph layout)

Despite its simplicity, RCytoscape’s setNodePosition method provides the means to
create custom layout algorithms and animations. Here is a rather nonsensical example,
in which the ’A’ node orbits around a ﬁxed center, with the ’B’ and ’C’ nodes left
unchanged.

7

cwe <- new.CytoscapeWindow (

vignette.setNodePosition

,

’

’

graph=RCytoscape::makeSimpleGraph ())

jgraph-spring

)

’

’

displayGraph (cwe)
layoutNetwork (cwe,
redraw (cwe)
center.x <- 200
center.y <- 200
radius <- 200

# sweep through full revoltion 3 times, 5 degrees at a time

angles <- rep (seq (0, 360, 5), 3)
for (angle in angles) {

angle.in.radians <- angle * pi / 180
x <- center.x + (radius * cos (angle.in.radians))
y <- center.y + (radius * sin (angle.in.radians))
’
setNodePosition (cwe,
}
# RCy will not create windows with duplicate names, so clear the decks for a subsequent possible run

, x, y)

A

’

>
+
>
>
>
>
>
>
>
>
>
+
+
+
+
+
>
>

10 Movies: explore time course data by animating

node color and size

Timecourse microarray expression experiments are commonplace in molecular biology
research. Once reduced, the expression data is often summarized as a lfc (log fold
change, experiment vs control) and a p-value for each gene at each time point. Many
Bioconductor packages can be used to ﬁnd biologically interesting patterns in such data,
but visualization – as one aspect of exploratory data analysis – should not be overlooked.
Here is a toy problem, a small example illustrating how this can be accomplished with
RCytoscape.

We begin with the small sample graph just like that created in the ’setNodePosition’
example above. We add some made-up statistical signﬁcicance data into a new node
attribute, ’pval’.

g <- RCytoscape::makeSimpleGraph ()
’
g <- initNodeAttribute (g,
cwm <- new.CytoscapeWindow (
displayGraph (cwm)
layoutNetwork (cwm,
redraw (cwm)

jgraph-spring

,
movie

pval
’

’

’

’

’

’

)

numeric

’

, 1.0)

, graph =g)

>
>
>
>
>
>
>

Now deﬁne the node size and node color rules we will use in the animation:

8

>
>
>
+
>
>
>
+
>

>
>
>
>
>
>
>
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+

lfc.control.points <- c (-3.0, 0.0, 3.0)
’
lfc.colors <- c (
setNodeColorRule (cwm,

#00FF00

#00AA00

,

’

’

’

’

’

’
’

,
lfc
interpolate

’

)

mode=

#FFFFFF

,

’

’

#FF0000

’

,

’

#AA0000

)

’

, lfc.control.points, lfc.colors,

pval.control.points <- c (0.1, 0.05, 0.01, 0.0001)
pval.sizes
setNodeSizeRule (cwm,

<- c (30, 50, 70, 100)

’

, pval.control.points, pval.sizes,

’
’

pval
interpolate

’

)

mode=

Once the rules are in eﬀect, node color and size will always be a function of each nodes’
lfc and pval numeric attributes. Animation is accomplished easily: all you have to do is
to update these two attributes for each node at each time point, and asking Cytoscape
to render the nodes following the rules it already has been instructed to follow. Note
that a message is written to the Cytoscape status message bar – found at the lower left
corner of the Cytoscape desktop – to help keep track of what the current timepoint is.

pval.timepoint.1 <- c (0.01, 0.3, 0.05)
pval.timepoint.2 <- c (0.05, 0.01, 0.01)
pval.timepoint.3 <- c (0.0001, 0.005, 0.1)
lfc.timepoint.1 <- c (-1.0, 1.0, 0.0)
lfc.timepoint.2 <- c (2.0, 3.0, -2.0)
lfc.timepoint.3 <- c (2.5, 2.0, 0.0)
for (i in 1:5) { # run this loop 5 times
’

setNodeAttributesDirect (cwm,

,

’

’

setNodeAttributesDirect (cwm,

redraw (cwm)
msg (cwm,
’
system (

’

timepoint 1
’

sleep 1

)

’

)

lfc
lfc.timepoint.1)
pval
pval.timepoint.1)

,

’

’

’

numeric

, c (

A

’

’

’

’

B

,

,

numeric

, c (

A

,

’

’

setNodeAttributesDirect (cwm,

numeric

, c (

A

,

’

’

’

,

lfc
lfc.timepoint.2)
pval
pval.timepoint.2)

,

’

’

’

’

’

’

’

setNodeAttributesDirect (cwm,

numeric

, c (

A

,

redraw (cwm)
msg (cwm,
’
system (

’

timepoint 2
’

sleep 1

)

’

)

setNodeAttributesDirect (cwm,
setNodeAttributesDirect (cwm,
redraw (cwm)

’
’

9

’

lfc
pval

,
’

,

’
’

numeric
numeric

, c (
, c (

’
’

’
’

’
’

A
A

,
,

’

’

’

’

’

’

C

),

’

’

C

),

’

’

C

),

’

’

C

),

’
’

’
’

C
C

), lfc.timepoint.3)
), pval.timepoint.3)

’

’

B

,

’

’

’

B

,

’

B

,

’
’

’
’

B
B

,
,

’

timepoint 3
’

sleep 1

)

’

)

msg (cwm,
’
system (
}

+
+
+
>

Though this example is very simple and quite without biologcal meaning, we hope that
it adequately illustrates the technique. We commonly use just this approach to explore
large scale timecourse expression data experiments in the context of curated, biologically
relevant pathways, such as those provided by KEGG, and selected by packages such as
SPIA or Category.

Finally, delete all the windows from this vignette:

cy <- CytoscapeConnection ()
vignette
window.names <- c (
for (window.name in window.names)

,

’

’

’

vignette.setNodePosition

,

movie

)

’

’

’

if (window.name %in% as.character (getWindowList (cy)))

deleteWindow (cy, window.name)

>
>
>
+
+
>

11 Online Documentation

http://db.systemsbiology.net:8080/cytoscape/RCytoscape/versions/current/index.
html

12 Future Work

(cid:136) All vizmap rules are currently added to the ’default’ vizmap. It is not yet possible
to delete rules from this map, either selectively or as a clean sweep. More ﬂexible
use of vizmaps is high on the to-do list.

13 Credits

(cid:136) RCytoscape would not be possible without the generosity and skill of Jan Bot,
whose Cytoscape plugin ’CytoscapeRPC’ is the indispensable link in commuication
between R and Cytoscape.

(cid:136) Duncan Temple Lang’s XMLRPC R package is also indispensable, providing the R
end of the communication link. Like Jan, Duncan has cheerfully provided excellent
support during the development of RCytoscape.

(cid:136) Nishant Gopalakrishnan kindly saw me through the Bioconductor package app-

proval process.

10

(cid:136) Dan Tenenbaum and Herve Pages, also of Bioconductor, have oﬀered steadfast

assistance and skill in creating the testing framework for RCytoscape.

I am very grateful to all of these computer scientists, to the Cytoscape project,
and to my colleagues at the Institute for Systems Biology.

14 References

(cid:136) Shannon P, Markiel A, Ozier O, Baliga NS, Wang JT, Ramage D, Amin N,
Schwikowski B, Ideker T. 2003. Cytoscape: a software environment for integrated
models of biomolecular interaction networks. Genome Res. Nov;13(11):2498-504

(cid:136) Huber W, Carey VJ, Long L, Falcon S, Gentleman R. 2007. Graphs in molecular

biology. BMC Bioinformatics. 2007 Sep 27;8.

11

