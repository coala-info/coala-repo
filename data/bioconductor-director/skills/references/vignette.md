Director

Katherine Icay

October 30, 2017

Abstract
Director is an R package designed to streamline the visualization of multiple levels of interacting
RNA-seq data. It utilizes a modiﬁed Sankey plugin of the JavaScript library D3 to provide a fast
and easy, web-based solution to discovering potentially interesting downstream eﬀects of regulatory
and/or co-expressed molecules. The diagrams are dynamic, interactive, and packaged as HTML
ﬁles – making them highly portable and eliminating the need for third-party software. This
enables a straightforward approach for scientists to interpret the data produced, and bioinformatics
developers an alternative means to present relevant data.

Contents

1 Sankey diagram

1.1 What is it? . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.2 Limitations . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.3 Diagram features . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Standard workﬂow

2.1 Getting started . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
Input data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2

3 Data ﬁltering

3.1 What’s being visualized? . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Visual parameters

4.1.1

4.1 Nodes and paths . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Figure dimensions and properties . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2.1 Figure modiﬁcations . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

averagePath parameter

5 Saving data

1 Sankey diagram

1.1 What is it?

1
1
2
2

3
3
3

4
5

6
6
6
8
8

9

Sankey diagrams are types of ﬂow diagrams comprised of paths and nodes designed to represent
ﬂow measurements within a system of distinct events. They are particularly useful for identifying
the contributions of these events in a directional cascade, with larger downstream contributions
emphasized by making path widths proportional to input values. This package takes advantage of
this feature to visualize multiple levels of interacting molecules in a directional ﬂow; oﬀering novel

1

presentation of key ﬁndings from complex datasets and dynamic, visual analysis of downstream
regulatory eﬀects.

Dynamic visualization of data is achieved with the Sankey plugin of Mike Bostock’s JavaScript
library, D3. Compared to traditional Sankey diagrams, this package provides novel drawing capa-
bilities to better depict molecular interactions. By enabling input for both path and node values,
colours are meaningfully assigned according to a gradient scale rather than being assigned ran-
domly or uniformly. Furthermore, in molecular biology, both positive and negative measurement
values are of interest and thus both extremes are scaled for when drawing path widths.

1.2 Limitations

Sankey diagrams are strictly directional ﬂow diagrams and are not suitable for depicting feedback
loops (i.e. a path from one node that leads back to itself). Order of input is also important: all
upstream connections must precede downstream connections to successfully draw the diagram.
For example, a list must contain all miRNA-mRNA pairs ﬁrst, mRNA-gene pairs second. This
package will check input values and notify user if any feedback loops exist. While rendering an
actual loop is possible manually, it is currently not possible as an automatic process in this package.
The solution is thus to create a new node. An example is provided under subsection What’s being
visualized?

As with all data-driven diagrams, large datasets can be diﬃcult or impossible to visualize and
still be able to distinguish individual nodes and paths. While this package does not restrict the
amount of paths and nodes deﬁned, it will warn users that the diagram may not be rendered
In most cases, this means less connected paths and nodes may be too small to be
correctly.
rendered at all. In this situation, users have two options: (1) ﬁlter the data manually or using the
quantitative and qualitative ﬁlters of the package, and/or (2) manually deﬁne the diagram height
and width to be large enough to render all nodes and paths. Instructions on how to perform these
actions are described below.

1.3 Diagram features

One advantage of an HTML output is that it encourages user interaction with the data. Quantita-
tive and qualitative information about each node and path are easily referenced with mouseover.
Nodes are dynamic and can be moved around the space for optimal presentation. Furthermore,
entire pathways can be highlighted in the overall diagram by clicking on the node (or nodes) of
interest.

Figure 1: Sankey plot with mouseover information and connected paths to transc2 highlighted.

2

2 Standard workﬂow

2.1 Getting started

First, dependency ﬁles must be initialized with initSankey. This generates the template for dy-
namic HTML. Speciﬁcally, the D3 JavaScript library (currently, version 3.5.16) and Mike Bostock’s
D3 plugin for Sankey. The function requires no inputs but optional parameters can be used to
deﬁne alternate download links to necessary scripts and download methods, path opacity, font,
and font sizes of node labels.

This is necessary for functions makeSankey and drawSankey to work so it must always be
executed ﬁrst. The parameters deﬁned in initSankey will apply to all HTML ﬁles generated.
Rerunning this function with diﬀerent parameters will, therefore, alter the look of all HTML ﬁles
within the directory (see section 4.2.1 and Figure 5).

2.2 Input data

Director requires two types of quantitive information as input: values for nodes and values for
paths. The package assumes nodes are molecules of interest and that the quantitative value is the
feature which makes them interesting, e.g. expression fold-change, signiﬁcance value, or methy-
lation score. Similarly, paths represent a predictive or quantitative measure of the interaction
between molecules (e.g. correlation, aﬃnity score).
Node and path values can be input in two ways.

1. As a single table with each row deﬁning a source node, target node, relationship value, node

values, and (optional) descriptive information.

2. As two separate tables: one with each row deﬁning a source node, target node, relationship
value, and (optional) descriptive values; and another with two columns deﬁning all nodes
and corresponding node values.

Suppose we have the following information:

impact score
target
source
DrugX miR-B
0.6
DrugX miR-A 0.8
-0.7
miR-B
transc1
-0.4
miR-B
transc2
-0.34
transc3
miR-B
-0.8
miR-A transc2
-0.6
miR-A transc4
0.8
trasc1
0.9
transc2
0.88
transc3
0.6
transc4

gene1
gene2
gene2
gene3

source fold-change
1
1
1.5
1.5
1.5
2.6
2.6
-1.7
-2.6
-1.5
-1.2

target fold-change
1.5
2.6
-1.7
-2.6
-1.5
-2.6
-1.2
-0.6
-2.2
-2.2
-0.7

We deﬁne information for a Sankey diagram with the function createList which takes as input
either a single table:

"miR-A", "miR-A", "transc1", "transc2", "transc3", "transc4"),
target=c("miR-B", "miR-A", "transc1", "transc2", "transc3", "transc2",

> library(Director)
> table1 <- data.frame(source=c("DrugX", "DrugX", "miR-B", "miR-B", "miR-B",
+
+
+
+
+
+
+

value=c(0.6, 0.8, -0.7, -0.4, -0.34, -0.8, -0.6, 0.8, 0.9, 0.88, 0.6),
sourcefc=c(1,1,1.5,1.5,1.5, 2.6,2.6,-1.7,-2.6,-1.5,-1.2),
targetfc=c(1.5,2.6,-1.7,-2.6,-1.5,-2.6,-1.2,-0.6,-2.2,-2.2,-0.7),
stringsAsFactors=FALSE)

"transc4", "gene1", "gene2", "gene2", "gene3"),

3

> tempList <- createList(table1)

source target description value sourcefc targetfc
1.5
2.6
-1.7
-2.6
-1.5
-2.6
-1.2
-0.6
-2.2
-2.2
-0.7

miR-B
DrugX
DrugX
miR-A
miR-B transc1
miR-B transc2
miR-B transc3
miR-A transc2
miR-A transc4
gene1
gene2
gene2
gene3

1
2
3
4
5
6
7
8 transc1
9 transc2
10 transc3
11 transc4

0.60
0.80
-0.70
-0.40
-0.34
-0.80
-0.60
0.80
0.90
0.88
0.60

1.0
1.0
1.5
1.5
1.5
2.6
2.6
-1.7
-2.6
-1.5
-1.2

Or two separate tables:

"transc2", "transc4", "gene1", "gene2", "gene2", "gene3"),

target=c("miR-B", "miR-A", "transc1", "transc2", "transc3",

"miR-B", "miR-B", "miR-B", "miR-A", "miR-A", "transc1",
"transc2", "transc3", "transc4"),

> List <- data.frame(source=c("DrugX", "DrugX",
+
+
+
+
+
+
> ListFC <- data.frame(genes=c("DrugX", "miR-B", "miR-A", "transc1",
+
+
+

"transc2", "transc3", "transc4", "gene1", "gene2", "gene3"),
foldChange=c(1, 1.5, 2.6, -1.7, -2.6, -1.5, -1.2, -0.6, -2.2, -0.7),

value=c(0.6, 0.8, -0.7, -0.4, -0.34, -0.8, -0.6, 0.8, 0.9, 0.88, 0.6),

stringsAsFactors=FALSE)

stringsAsFactors=FALSE)

> tempList2 <- createList(List,ListFC)

source target description value sourcefc targetfc
1.5
2.6
-1.7
-2.6
-1.5
-2.6
-1.2
-0.6
-2.2
-2.2
-0.7

miR-B
DrugX
DrugX
miR-A
miR-B transc1
miR-B transc2
miR-B transc3
miR-A transc2
miR-A transc4
gene1
gene2
gene2
gene3

1
2
3
4
5
6
7
8 transc1
9 transc2
10 transc3
11 transc4

0.60
0.80
-0.70
-0.40
-0.34
-0.80
-0.60
0.80
0.90
0.88
0.60

1.0
1.0
1.5
1.5
1.5
2.6
2.6
-1.7
-2.6
-1.5
-1.2

Note that description is a required column to make and draw a Sankey diagram. If it is not deﬁned
in createList, an empty description column will be created. This column can be used, for example,
to provide the gene name of a target transcript or additional information about the source and
target interaction. Descriptive information can be written in HTML code and are accessed via
mouseover of the respective paths.

3 Data ﬁltering

Director has several functions that attempt to streamline the visualization process. For useful
and eﬃcient visualization, data should ﬁrst be ﬁltered for the most valuable, user-deﬁned set of
information.

4

3.1 What’s being visualized?

Hundreds and thousands of molecules can be detected in a single living cell at any given time.
Molecules that have mRNA content sequenced and quantiﬁed are considered ’expressed’, but are
not necessarily interesting. In fact, depending on the questions a user wishes to answer, most of
the expressed molecules are noise and the potentially interesting molecules diﬃcult to distinguish.
Basic functions are provided with Director to ﬁlter the list of source and target nodes for:

(cid:136) f ilterN umeric Minimum, maximum, or absolute numerical values.

(cid:136) f ilterSubset User-deﬁned qualitative values grep’d from up to two qualitative columns (e.g.

source and target).

(cid:136) f ilterRelation Positively correlated or inversely related source-target pair node or path

values.

Multiple lists can be created representing diﬀerent levels of source-target relationships and com-
bined with append2List. The package then visually organizes downstream eﬀects to several biolog-
ically functional levels. See the package manual for more details and examples for each function.
Additionally, Director has built-in checks to ensure the input data (1) contains unique nu-
merical values for each node and path regardless of the number of connections, and (2) does not
contain feedback loops. In both cases, a warning will be given to the user indicating a problem in
the rendering of the diagram. An example of the second case is given below:

data.frame(source=c("gene1", "gene2"),
target=c("transc1", "transc2"),
value=c(0.3, -0.8),
sourcefc=c(-0.6,-2.2),
targetfc=c(-1.7,-2.6),
stringsAsFactors=FALSE))

> table1_v2 <- rbind(table1, # add to the example two transcript->gene->transcript loops
+
+
+
+
+
+
> tempList_v2 <- createList(table1_v2)
> sankey_loop <- makeSankey(tempList_v2)

> sankey_loop$reference[,c(1:6)] # note the change in target names!

source
DrugX
1
DrugX
2
miR-B
3
miR-B
4
miR-B
5
miR-A
6
7
miR-A
8 transc1
9 transc2
10 transc3
11 transc4
12
13

miR-B
miR-A
transc1
transc2
transc3
transc2
transc4
gene1
gene2
gene2
gene3
gene1 Loop_transc1
gene2 Loop_transc2

target description value sourcefc targetfc
1.5
0.600
2.6
0.800
-1.7
0.292
-2.6
0.167
-1.5
0.142
-2.6
0.457
-1.2
0.343
-0.6
0.592
-2.2
1.424
-2.2
0.143
-0.7
0.344
-1.7
0.593
-2.6
1.566

1.0
1.0
1.5
1.5
1.5
2.6
2.6
-1.7
-2.6
-1.5
-1.2
-0.6
-2.2

The loops are identiﬁed as new destination nodes. Continuing with the data visualization will

thus produce the following Sankey diagram.

5

Figure 2: Sankey plot

4 Visual parameters

After ﬁltering, the ready list is input to makeSankey. This function calculates and assigns drawing
values for nodes, assigns colours to nodes, and assigns colours to paths. A red-blue palette is
used by default to render diagrams, but colour ranges for both nodes and paths can be deﬁned
separately. drawSankey then takes these values to create the HTML containing the interactive
Sankey diagram. The HTML ﬁle and dependencies can then be saved to a local folder with
writeSankey. The default is the R working directory obtained with getwd().

4.1 Nodes and paths

The primary function of the package is to render a custom Sankey diagram with paths and nodes
assigned colours based on quantitative measures.

Before drawing the diagram, colour scales must ﬁrst be assigned to the node and path values.

> initSankey()
> sankey <- makeSankey(tempList2)
> sankeyd <- drawSankey(sankey)

By default, this package assumes larger absolute values are stronger than smaller values. How-
ever, some values (e.g. signiﬁcance levels) are stronger with smaller values and weaker with larger
ones. In these cases, nought or zero values can be deﬁned for either paths or nodes such that
stronger colors are given to smaller values and weaker colors to larger values. This makes the
diagram robust to a wide range of data input and able to match almost any colour theme. Fur-
thermore, both names and hexidecimal codes can be input as colour values.

4.1.1 averagePath parameter

What if there is no unique path values after the ﬁrst level of interacting nodes? What if interest
is only in the downstream eﬀect of the ﬁrst level of interactions (e.g. drugs and their molecular
targets)? makeSankey has a Boolean parameter called averagePath that, when set to T RU E,
will replace the List$value of a source-target pair of molecules (say, miRNA-1 and target Gene
A) with an average value of the incoming paths to the source molecule (say, Drug X and Drug

6

Figure 3: Sankey plot

Y targeting miRNA-1). Assuming a uniform downstream eﬀect, this colours downstream paths
in the ﬁgure based on the average eﬀect of the initial level of source-target values. Consequently,
this gives more emphasis to the quantitative node values.

> initSankey()
> sankey2 <- makeSankey(tempList2, averagePath=TRUE)
> sankey2d <- drawSankey(sankey2)

Figure 4: Sankey plot with averagePath enabled.

Note the value diﬀerences with and without averagePath enabled.

> truevalue <- sankey$reference$truevalue

> cbind(sankey2$reference[,c("source", "target","averagePath_value")],truevalue)

7

source target averagePath_value truevalue
0.60
0.80
-0.70
-0.40
-0.34
-0.80
-0.60
0.80
0.90
0.88
0.60

miR-B
DrugX
DrugX
miR-A
miR-B transc1
miR-B transc2
miR-B transc3
miR-A transc2
miR-A transc4
gene1
gene2
gene2
gene3

1
2
3
4
5
6
7
8 transc1
9 transc2
10 transc3
11 transc4

0.6
0.8
0.6
0.6
0.6
0.8
0.8
0.6
0.7
0.6
0.8

4.2 Figure dimensions and properties

Each ﬁgure includes a legend containing the colour scales for node values and for path values.
drawSankey parameters allow customization of the legend font, font size, legend content, and
ﬁgure caption.

By default, ﬁgures are drawn with a 1000px width and height adjusted to the number of
nodes/unique molecules up to 1800px (or approximately 300 nodes). If the ﬁgure fails to appear
in the HTML ﬁle with drawSankey defaults, the options are either to

1. Deﬁne drawSankey parameters height > 1800px and width > 1000px.

2. Use Director ﬁlters to reduce the number of nodes to draw.

The goal of this package is to highlight key molecules and regulatory interactions. Having more

molecules than necessary makes the ﬁgure ’noisy’.

Fortunately, users can view quantitative and qualitative information, including optional de-
scriptions, directly from nodes and paths in the diagram via mouseover. This is useful to deter-
mine, for example, what quantitative thresholds to ﬁlter for to remove uninteresting paths from
the ﬁgure.

4.2.1 Figure modiﬁcations

When any part of the List information is modiﬁed, makeSankey needs to be rerun to update
colour assignments (quantitative values), nodes, and path connections. Changes to the general
appearance of the ﬁgure can be made with parameters in initSankey and drawSankey. Details are
available in the manual. To update the ﬁgure with the changes, simply rerun drawSankey. Figure
4 is drawn with the exact same List information as Figure 3 but using non-default parameters.

fontsizeProportion = FALSE, fontsize=20)

> # Makes the path colours darker by 10% and uses a single, uniform font size for the figure rather than font sizes proportional to node size.
> initSankey(pathOpacity = 0.3, pathHover = 0.6,
+
> # Changes the default colours used.
> sankey2 <- makeSankey(tempList2, averagePath=TRUE,
+
> # Changes to legend values and overall figure size
> sankey <- drawSankey(sankey2, caption = "Alternate figure",
+
+

nodeValue = "Node colour scale", pathValue = "Path colour scale",
legendsize = 14, height = 300)

nodeMin = "orange", nodeMax = "purple", pathMax = "#333333")

8

Figure 5: Sankey plot with averagePath enabled and non-default parameters.

5 Saving data

The relevant outputs generated are:

1. The List created with createList used as input for the main Sankey functions.

2. The Sankey diagram produced with drawSankey.

The former is a standard R data frame and can be saved with normal methods, e.g. write.table().
This simpliﬁes later usage as it is already in the appropriate List format and can immediately be
used with ﬁltering and Sankey functions.

The latter can be saved to a locally accessible folder and made portable using the function
writeSankey. It generates an HTML ﬁle and ’www’ folder containing the following dependency
ﬁles:

./www

|
+-- css

sankey.css

|
+-- js

d3.v3.js
LICENSE
sankey.js

HTML has the dual beneﬁt of preserving information dynamics of the diagram and vector graphics
quality. As a result, adjusting the ﬂow of the diagram and saving as a high-quality PDF (or .png)
in any dimension is simple.

9

