RamiGO: an R interface for AmiGO

Markus S. Schr¨oder1,2, Daniel Gusenleitner1, Aed´ın C. Culhane1, Benjamin
Haibe-Kains1, and John Quackenbush1

1Biostatistics and Computational Biology, Dana-Farber Cancer Institute, Harvard School of Public
Health, Boston, USA
2Computational Genomics, Center for Biotechnology, Bielefeld University, Germany

April 24, 2017

Contents

1 Introduction

2 Getting started

3 A usefull extension to GSEA

4 View and edit GO trees in Cytoscape

5 Misc

6 Session Info

1

Introduction

1

2

4

5

5

6

Please cite RamiGo as follows: Markus S. Schr¨oder, Daniel Gusenleitner, John Quackenbush,
Aed´ın C. Culhane and Benjamin Haibe-Kains (2013): RamiGO: an R/Bioconductor package
providing an AmiGO Visualize interface. Bioinformatics 29(5):666-668.

A common task in recent gene set or gene signature analyses is testing for up- and down-
regulation of these gene sets or gene signatures in Gene Ontology (GO) terms. Or having a
gene or set of genes of interest and looking at the GO terms that include that gene or gene
set. For a closer look at the distribution of the GO terms in the diﬀerent tree structures of the
three GO categories one has to either rebuild the GO tree himself with the help of published
R packages, or copy and paste the GO terms of interest into existing web services to display
the GO tree. One of these web services is AmiGO visualize:

AmiGO visualize: http://amigo.geneontology.org/cgi-bin/amigo/amigo?mode=visualize

The RamiGO package is providing functions to interact with the AmiGO visualize web
server and retrieves GO (Gene Ontology) trees in various formats. The most common requests

1

would be as png or svg, but a ﬁle representation of the tree in the GraphViz DOT format is
also possible. RamiGO also provides a parser for the GraphViz DOT format that returns a
graph object and meta data in R.

2 Getting started

At ﬁrst we load the RamiGO package into the current workspace:

> library(RamiGO)

The RamiGO package currently provides two functions that enable the user to retrieve
directed acyclic trees from AmiGO and parse the GraphViz DOT format. An example on how
to use the functions is given below.

To retrieve a tree from AmiGO, the user has to provide a vector of GO ID’s. For exam-
ple GO:0051130, GO:0019912, GO:0005783, GO:0043229 and GO:0050789. These GO ID’s
represent entries from the three GO categories: Biological Process, Molecular Function and
Cellular Component. The given GO ID’s can be highlighted with diﬀerent colors within the
tree, therefor the user has to provide a vector of colors for each GO ID. A request could look
like this:

> goIDs <- c("GO:0051130","GO:0019912","GO:0005783","GO:0043229","GO:0050789")
> color <- c("lightblue","red","yellow","green","pink")
> pngRes <- getAmigoTree(goIDs=goIDs, color=color, filename="example", picType="png", saveResult=TRUE)

Figure 1: Example PNG returned from AmiGO.

The GO tree representing the given GO ID’s is dowloaded to the ﬁle ”example.png” (see
Figure 1); the ﬁle extension is created automatically according to picType. The request for a
svg ﬁle is similar:

> svgRes <- getAmigoTree(goIDs=goIDs, color=color, filename="example", picType="svg", saveResult=TRUE)

svgRes is a vector with the svg picture in xml format.

In order to further analyze the
tree, RamiGO provides the possibility to retrieve the tree in the GraphViz DOT format. The
function readAmigoDot parses these DOT format ﬁles and returns a AmigoDot S4 object.
This S4 object includes an igraph object (agraph()), an adjacency matrix representing the
graph (adjMAtrix()), a data.frame with the annotation for each node (annot()), the relations
(edges) between the nodes (relations()) and a data.frame with the leaves of the tree and
their annotation (leaves()). An example could look like this:

> dotRes <- getAmigoTree(goIDs=goIDs, color=color, filename="example", picType="dot", saveResult=TRUE)
> tt <- readAmigoDot(object=dotRes)
> ## reading the file would also work!
> ## tt <- readAmigoDot(filename="example.dot")
> show(tt)

2

class: AmigoDot
Class

igraph.es

’

’

atomic [1:255] 1 2 3 4 5 6 7 8 9 10 ...

..- attr(*, "vnames")= chr [1:255] "node1|node2" "node1|node38" "node2|node10" "node2|node58" ...
..- attr(*, "env")=<weakref>
..- attr(*, "graph")= chr "36c684bf-71d1-415b-a9c0-9b9b20010a03"

nodes:
Class

’

igraph.vs

’

atomic [1:97] 1 2 3 4 5 6 7 8 9 10 ...

..- attr(*, "env")=<weakref>
..- attr(*, "graph")= chr "36c684bf-71d1-415b-a9c0-9b9b20010a03"

edges:
’

’

:

3 obs. of 6 variables:

: chr "node72" "node78" "node97"
: chr "GO:0005783" "GO:0051130" "GO:0019912"

data.frame
$ node
$ GO_ID
$ description: chr "endoplasmic reticulum" "positive regulation of cellular component organization" "cyclin-dependent protein kinase activating kinase activity"
$ color
$ fillcolor : chr "yellow" "lightblue" "red"
$ fontcolor : chr "#000000" "#000000" "#000000"

: chr "#000000" "#000000" "#000000"

leaves:
’

’

:

97 obs. of 6 variables:

: chr "node1" "node2" "node3" "node4" ...
: chr "GO:0060255" "GO:0051246" "GO:0045860" "GO:0032147" ...

data.frame
$ node
$ GO_ID
$ description: chr "regulation of macromolecule metabolic process" "regulation of protein metabolic process" "positive regulation of protein kinase activity" "activation of protein kinase activity" ...
$ color
: chr "#000000" "#000000" "#000000" "#000000" ...
$ fillcolor : chr "#ffffff" "#ffffff" "#ffffff" "#ffffff" ...
$ fontcolor : chr "#000000" "#000000" "#000000" "#000000" ...

annot:
’

’

:
258 obs. of 6 variables:
: chr "node1" "node1" "node2" "node2" ...
: chr "node2" "node38" "node10" "node58" ...

data.frame
$ parent
$ child
$ arrowhead: chr "none" "none" "none" "none" ...
$ arrowtail: chr "normal" "normal" "normal" "normal" ...
$ color
$ style
relations:

: chr "\"#000000\"" "\"#000000\"" "\"#000000\"" "\"#000000\"" ...
: chr "bold" "bold" "bold" "bold" ...

The leaves of the tree are returned in leaves(tt):

> leavesTT <- leaves(tt)
> leavesTT[,c("node","GO_ID","description")]

node

GO_ID
72 node72 GO:0005783
78 node78 GO:0051130
97 node97 GO:0019912

72

description
endoplasmic reticulum

3

78
positive regulation of cellular component organization
97 cyclin-dependent protein kinase activating kinase activity

In order to export the tree to an GML ﬁle that is readable by Cytoscape, you have to
call the adjM2gml with some of the results from the readAmigoDot function. The following
example creates a GML ﬁle by internally calling the exportCytoGML:

> gg <- adjM2gml(adjMatrix(tt),relations(tt)$color,annot(tt)$fillcolor,annot(tt)$GO_ID,annot(tt)$description,"example")

The result is a GML ﬁle named example.gml that can be imported into Cytoscape as a

network ﬁle.

3 A usefull extension to GSEA

The RamiGO package provides an extremely helpful extension to the GSEA software, in java
as well as in R, if run with genesets from GO (C5 in MSigDB). RamiGO provides a mapping
from GO terms returned from GSEA to oﬃcial GO ID’s. The mapping is stored in the data
object c5.go.mapping.

> data(c5.go.mapping)
> head(c5.go.mapping)

goid
description
1
NUCLEOPLASM GO:0005654
2 EXTRINSIC_TO_PLASMA_MEMBRANE GO:0019897
ORGANELLE_PART GO:0044422
3
4
CELL_PROJECTION_PART GO:0044463
5 CYTOPLASMIC_VESICLE_MEMBRANE GO:0030659
GOLGI_MEMBRANE GO:0000139
6

One of the ways to avoid running GSEA in R is to call the java application of GSEA from

R with the system() function. An example for a preranked GSEA would be:

> ## paths to gsea jar and gmt file
> exe.path <- exe.path.string
> gmt.path <- gmt.path.string
> gsea.collapse <- "false"
> ## number of permutations
> nperm <- 10000
> gsea.seed <- 54321
> gsea.out <- "out-folder"
> ## build GSEA command
> gsea.report <- "report-file"
> rnk.path <- "rank-file"
> gsea.cmd <- sprintf("java -Xmx4g -cp %s xtools.gsea.GseaPreranked -gmx %s -collapse %s -nperm %i -rnk %s -scoring_scheme weighted -rpt_label %s -include_only_symbols true -make_sets true -plot_top_x 75 -rnd_seed %i -set_max 500 -set_min 15 -zip_report true -out %s -gui false", exe.path, gmt.path, gsea.collapse, nperm, rnk.path, gsea.report, gsea.seed, gsea.out)
> ## execute command on the system
> system(gsea.cmd)

4

The results are stored in a folder with the name speciﬁed in gsea.out. The subfolder
gsea.report has the detailed results in comma separated ﬁles and html pages. In the gsea.cmd
string above we speciﬁed a few parameters which can be changed according to the type of
analysis.

(cid:136) plot top x: the number of results that should have an individual result page linked to

the main index.html.

(cid:136) set max and set min:

than 500 genes.

limits the analysis to genesets that have more than 15 and less

Once the GSEA analysis is ﬁnished, the important result ﬁles are xls ﬁles in the gsea.report
folder. Named gsea report for na pos <some number>.xls and gsea report for na neg <some
number>.xls. We can read them into R with the following command:

> resn <- "xxx" ## number generated by GSEA that you can get with grep(), strsplit() and dir()
> tt <- rbind(read.table(sprintf("%s/%s/gsea_report_for_na_pos_%s.xls", gsea.out, gsea.report,resn), stringsAsFactors=FALSE, sep="\t", header=TRUE), read.table(sprintf("%s/%s/gsea_report_for_na_neg_%s.xls", gsea.out, gsea.report, restn), stringsAsFactors=FALSE, sep="\t", header=TRUE))

With all results from the GSEA analysis stored in tt, you can extract information from

the results and call the getAmigoTree mentioned in the example section.

4 View and edit GO trees in Cytoscape

The adjM2gml function in RamiGO creates a Cytoscape speciﬁc GML ﬁle (see example section
above) that can be imported into Cytoscape and further edited (for example for publication
purposes). The GO tree from the example above, parsed with the readAmigoDot function,
exported with the adjM2gml and imported into Cytoscape as a network, looks like Figure 2.

5 Misc

strapply enables perl-like regular expression in R, as do grep, sub or gsub. In particular,
it enables the use of the perl variables $1, $2, ...
for extracting information from within a
regular expression. The code below shows an example of the use of strapply. The string
within brackets (...) is returned in a list by strapply.

> strapply(c("node25 -> node30"), "node([\\d]+) -> node([\\d]+)", c, backref = -2)

[[1]]
[1] "25" "30"

The RCurl package is useful for communicating with a web server and sending GET or
POST requests. RamiGO uses the postForm() function to communicate with the AmiGO web
server. The png package is used to convert the web server response for a png request into an
actual png ﬁle. The igraph package is used to build a graph object representing the tree that
was parsed from an DOT format ﬁle.

5

Figure 2: Example GML imported in Cytoscape.

6 Session Info

(cid:136) R version 3.4.0 (2017-04-21), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8,
LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.2 LTS

6

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, methods, stats, utils

(cid:136) Other packages: RamiGO 1.22.0, gsubfn 0.6-6, proto 1.0.0

(cid:136) Loaded via a namespace (and not attached): BiocGenerics 0.22.0, RCurl 1.95-4.8,
RCytoscape 1.26.0, XML 3.98-1.6, XMLRPC 0.3-0, bitops 1.0-6, compiler 3.4.0,
graph 1.54.0, igraph 1.0.1, magrittr 1.5, parallel 3.4.0, png 0.1-7, stats4 3.4.0,
tcltk 3.4.0, tools 3.4.0

7

