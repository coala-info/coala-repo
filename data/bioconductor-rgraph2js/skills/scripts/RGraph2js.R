# Code example from 'RGraph2js' vignette. See references/ for full tutorial.

### R code from vignette source 'RGraph2js.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: adjmatExample
###################################################
v <- c(0, 4, 1,
       1, 0, 0,
       -1, 0, 0,
       0, -2, 0,
       0, 1, 0)
a35 <- matrix(v, 3, 5)
colnames(a35) <- LETTERS[1:5]
rownames(a35) <- LETTERS[1:3]


###################################################
### code chunk number 3: tab1
###################################################
library(xtable)
print(
    xtable(
        a35,
        caption="3x5 Signed Weighted Adjacency Matrix", 
        label="tab:one",
        display=c("d", "d", "d", "d", "d", "d")
    ),
    caption.placement="bottom"
)


###################################################
### code chunk number 4: simpleExample
###################################################
library(RGraph2js)
v <- c(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,
       1,1,0,1,1,1,0,0,0,0,0,0,0,0,0,
       1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,1,0,1,1,0,0,0,0,0,1,0,0,0,0,
       0,1,0,1,1,0,0,0,1,0,0,0,0,0,0,
       0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,
       0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,
       0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,
       0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,
       0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,
       0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,
       0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,
       0,0,0,0,0,0,0,0,0,0,0,0,0,1,1
      )
a1515 <- matrix(v, 15, 15)
colnames(a1515) <- LETTERS[1:15]
rownames(a1515) <- LETTERS[1:15]


###################################################
### code chunk number 5: tab2
###################################################
library(xtable)
print(
    xtable(
        a1515,
        caption="15x15 Adjacency matrix", 
        label="tab:two",
        display=c("d", "d", "d", "d", "d",
                  "d", "d", "d", "d", "d",
                  "d", "d", "d", "d", "d", 
                  "d")
    ),
    caption.placement="bottom"
)


###################################################
### code chunk number 6: <simpleExample
###################################################
outputDir <- file.path(tempdir(), "RGraph2js_simpleExample")
g <- graph2js(a1515, outputDir=outputDir)


###################################################
### code chunk number 7: visualAppearanceExample
###################################################
edgesGlobal <- list(width=2, color="#0000ff")
edgesProp <- data.frame(from=c("D", "D", "B"), 
                        to=c("E", "B", "E"),
                        width=c(5, 5, 5))


###################################################
### code chunk number 8: visualAppearanceExample
###################################################
getEdgesDataFrame(a1515)


###################################################
### code chunk number 9: visualAppearanceExample
###################################################
nodesGlobal <- list(color="#ebebeb")
nodesProp <- data.frame(shape=c("triangle", "lozenge", "rect"),
                        color=c("#ff0000", "#0000ff", "#ffff00"))
rownames(nodesProp) <- c("C", "E", "G")


###################################################
### code chunk number 10: visualAppearanceExample
###################################################
getNodesDataFrame(A=a1515, nGlobal=nodesGlobal, nProp=nodesProp)


###################################################
### code chunk number 11: <visualAppearanceExample
###################################################
outputDir <- file.path(tempdir(), "RGraph2js_visualAppearance")
g <- graph2js(a1515,
              nodesGlobal=nodesGlobal, edgesGlobal=edgesGlobal,
              nodesProp=nodesProp, edgesProp=edgesProp,
              outputDir=outputDir, file="index.html")


###################################################
### code chunk number 12: fixedNodes1
###################################################
v <- c(0, 0, 1,
       1, 0, 0,
       0, 0, 0,
       0, -1, 0,
       0, 1, 0)
a35 <- matrix(v, 3, 5)
colnames(a35) <- LETTERS[1:5]
rownames(a35) <- LETTERS[1:3]


###################################################
### code chunk number 13: fixedNodes2
###################################################
r <- 100
sector <- 2*pi/5
n.prop <- data.frame(
    x=c(r*cos(1*sector), r*cos(2*sector), r*cos(3*sector),
        r*cos(4*sector), r*cos(5*sector)),
    y=c(r*sin(1*sector), r*sin(2*sector), r*sin(3*sector),
        r*sin(4*sector), r*sin(5*sector)),
    fixed=c(TRUE,TRUE,TRUE,TRUE,TRUE)
)
rownames(n.prop) <- c("A","B","C","D","E")


###################################################
### code chunk number 14: fixedNodes3
###################################################
outputDir <- file.path(tempdir(), "RGraph2js_fixedNodes")
g <- graph2js(a35, nodesProp=n.prop, outputDir=outputDir)


###################################################
### code chunk number 15: categories1
###################################################
v <- c(0, 0, 1,
       1, 0, 0,
       0, 0, 0,
       0, -1, 0,
       0, 1, 0)
a35 <- matrix(v, 3, 5)
colnames(a35) <- LETTERS[1:5]
rownames(a35) <- LETTERS[1:3]


###################################################
### code chunk number 16: categories2
###################################################
numnodes <- 5
nodesProp <- data.frame(leading.nodes.1=rbinom(numnodes, 1, 1/2),
                        leading.nodes.2=rbinom(numnodes, 1, 1/2),
                        leading.nodes.3=rbinom(numnodes, 1, 1/2),
                        leading.nodes.4=rbinom(numnodes, 1, 1/2),
                        highlight.1=rainbow(numnodes),
                        highlight.2=rainbow(numnodes),
                        highlight.3=rainbow(numnodes),
                        highlight.4=rainbow(numnodes))
rownames(nodesProp) <- LETTERS[1:5]


###################################################
### code chunk number 17: categories3
###################################################
outputDir <- file.path(tempdir(), "RGraph2js_timeData")
g <- graph2js(a35,
              nodesProp=nodesProp,
              outputDir=outputDir)


###################################################
### code chunk number 18: barplot1
###################################################
v <- c(0, 0, 1,
       1, 0, 0,
       0, 0, 0,
       0, -1, 0,
       0, 1, 0)
a35 <- matrix(v, 3, 5)
colnames(a35) <- LETTERS[1:5]
rownames(a35) <- LETTERS[1:3]


###################################################
### code chunk number 19: barplot2
###################################################
numnodes <- 5
innerValues <- matrix(runif(numnodes * 8), numnodes, 8)
rownames(innerValues) <- LETTERS[1:5]

innerColors <- matrix(rainbow(numnodes * 8), numnodes, 8)
rownames(innerColors) <- LETTERS[1:5]


###################################################
### code chunk number 20: barplot3
###################################################
outputDir <- file.path(tempdir(), "RGraph2js_barplots")
g <- graph2js(a35,
              innerValues=innerValues,
              innerColors=innerColors,
              outputDir=outputDir)


###################################################
### code chunk number 21: barplots4
###################################################
opts <- getDefaultOptions()
opts$displayBarPlotsInsideNodes <- FALSE
opts$barplotInNodeTooltips <- TRUE
g <- graph2js(a35,
              opts=opts,
              innerValues=innerValues,
              innerColors=innerColors,
              outputDir=outputDir)


###################################################
### code chunk number 22: starplots1
###################################################
v <- c(0, 0, 1,
       1, 0, 0,
       0, 0, 0,
       0, -1, 0,
       0, 1, 0)
a35 <- matrix(v, 3, 5)
colnames(a35) <- LETTERS[1:5]
rownames(a35) <- LETTERS[1:3]


###################################################
### code chunk number 23: starplots2
###################################################
numnodes <- 5

starplotValues <- matrix(runif(numnodes * 8), numnodes, 8)
rownames(starplotValues) <- LETTERS[1:5]

starplotColors <- matrix(rainbow(numnodes * 8), numnodes, 8)
rownames(starplotColors) <- LETTERS[1:5]

labels <- c("Sector1", "Sector2", "Sector3", "Sector4",
            "Sector5", "Sector6", "Sector7", "Sector8")

starplotLabels <- matrix(labels, numnodes, 8)
rownames(starplotLabels) <- LETTERS[1:5]

starplotTooltips <- matrix(labels, numnodes, 8)
rownames(starplotTooltips) <- LETTERS[1:5]

# add a url link for each sector
urls <- c("http://d3js.org/", "http://jquery.com/",
          "http://jqueryui.com/", "http://qtip2.com/",
          "http://raphaeljs.com/", "http://www.bioconductor.org/",
          "http://cran.r-project.org", "http://journal.r-project.org")

starplotUrlLinks <- matrix(urls, numnodes, 8)
rownames(starplotUrlLinks) <- LETTERS[1:5]

starplotCircleFillColor <- matrix(rainbow(numnodes), numnodes, 1)
rownames(starplotCircleFillColor) <- LETTERS[1:5]

starplotCircleFillOpacity <- matrix(runif(numnodes,0,1), numnodes, 1)
rownames(starplotCircleFillOpacity) <- LETTERS[1:5]


###################################################
### code chunk number 24: starplots3
###################################################
outputDir <- file.path(tempdir(), "RGraph2js_starplots")
output.filename <- "test.html"
g <- graph2js(A=a35,
              starplotColors=starplotColors,
              starplotLabels=starplotLabels,
              starplotValues=starplotValues,
              starplotTooltips=starplotTooltips,
              starplotUrlLinks=starplotUrlLinks,
              starplotCircleFillColor=starplotCircleFillColor,
              starplotCircleFillOpacity=starplotCircleFillOpacity,
              outputDir=outputDir,
              filename=output.filename)


###################################################
### code chunk number 25: tooltipContent1
###################################################
v <- c(0, 0, 1,
       1, 0, 0,
       0, 0, 0,
       0, -1, 0,
       0, 1, 0)
a35 <- matrix(v, 3, 5)
colnames(a35) <- LETTERS[1:5]
rownames(a35) <- LETTERS[1:3]


###################################################
### code chunk number 26: tooltipContent2
###################################################
numnodes <- 5
someHtmlContent <- c(paste0("<table class=\"gridtable\">",
                            "<tr><th>Header 1</th><th>Header 2</th><th>",
                            "Header 3</th></tr><tr><td>Text 1,1</td><td>",
                            "Text 1,2</td><td>Text 1,3</td></tr><tr><td>",
                            "Text 2,1</td><td>Text 2,2</td><td>Text 2,3",
                            "</td></tr></table>"),
                     "This is another <i>content</i>",
                     "Yet another <font style=\"color:#00ff00;\">one</font>",
                     paste0("<table>",
                            "<tr><th>Header 1</th><th>Header 2</th><th>",
                            "Header 3</th></tr><tr><td>Text 1,1</td><td>",
                            "Text 1,2</td><td>Text 1,3</td></tr><tr><td>",
                            "Text 2,1</td><td>Text 2,2</td><td>Text 2,3",
                            "</td></tr></table>"),
                     "<h1>Header 1</h1><h2>Header 2</h2>")
n.prop <- data.frame(tooltip=someHtmlContent)
rownames(n.prop) <- LETTERS[1:5]


###################################################
### code chunk number 27: tooltipContent3
###################################################
userCssStyles <- "
<style type=\"text/css\">
table.gridtable {
    font-family: verdana,arial,sans-serif;
    font-size:11px;
    color:#333333;
    border-width: 1px;
    border-color: #666666;
    border-collapse: collapse;
}
table.gridtable th {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #666666;
    background-color: #dedede;
}
table.gridtable td {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #666666;
    background-color: #ffffff;
}
</style>
"


###################################################
### code chunk number 28: tooltipContent4
###################################################
outputDir <- file.path(tempdir(), "RGraph2js_tooltipContent")
g <- graph2js(a35,
              opts=opts,
              nodesProp=n.prop,
              userCssStyles=userCssStyles,
              outputDir=outputDir)


###################################################
### code chunk number 29: dot1 (eval = FALSE)
###################################################
## library(sna)
## 
## extdata.path <- file.path(path.package(package="RGraph2js"), "extdata")
## dot.file.path <- file.path(extdata.path, "nohosts.dot")
## adj.mat <- read.dot(dot.file.path)


###################################################
### code chunk number 30: dot2 (eval = FALSE)
###################################################
## opts <- getDefaultOptions()
## opts$displayNetworkEveryNLayoutIterations <- 100
## opts$displayNodeLabels <- FALSE
## opts$layout_forceCharge <- -2400
## nodesGlobal <- list(color="#5544ff")
## outputDir <- file.path(tempdir(), "RGraph2js_dot")
## g <- graph2js(A=adj.mat,
##               nodesGlobal=nodesGlobal,
##               opts=opts,
##               outputDir=outputDir)


###################################################
### code chunk number 31: graphNELExample
###################################################
library(graph)
nodes <- c("A", "B", "C", "D", "E")
edges <- list(
    A=list(edges=c("A", "B"), weights=c(2, 2)),
    B=list(edges=c("A", "E"), weights=c(0.25, 0.25)),
    C=list(edges=c("A", "D"), weights=c(4, 4)),
    D=list(edges=c("E"), weights=c(6)),
    E=list(edges=c("A", "B"), weights=c(1, 1))
)
gnel <- new("graphNEL", nodes=nodes, edgeL=edges, edgemode="directed")


###################################################
### code chunk number 32: graphNELExampleRgraphviz (eval = FALSE)
###################################################
## ew <- as.character(unlist(edgeWeights(gnel)))
## ew <- ew[setdiff(seq(along = ew), removedEdges(gnel))]
## names(ew) <- edgeNames(gnel)
## eAttrs <- list()
## eAttrs$label <- ew
## plot(gnel,
##      attrs=list(
##          edge=list(arrowsize=0.5)
##      ),
##      edgeAttrs=eAttrs)


###################################################
### code chunk number 33: graphNELExampleRGraph2js
###################################################
outputDir <- file.path(tempdir(), "RGraph2js_graphNELExample")
g <- graph2js(A=gnel, outputDir=outputDir)


