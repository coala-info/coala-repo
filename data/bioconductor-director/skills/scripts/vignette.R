# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: vignette.Rnw:85-94
###################################################
library(Director)
table1 <- data.frame(source=c("DrugX", "DrugX", "miR-B", "miR-B", "miR-B",
        "miR-A", "miR-A", "transc1", "transc2", "transc3", "transc4"),
    target=c("miR-B", "miR-A", "transc1", "transc2", "transc3", "transc2",
        "transc4", "gene1", "gene2", "gene2", "gene3"),
    value=c(0.6, 0.8, -0.7, -0.4, -0.34, -0.8, -0.6, 0.8, 0.9, 0.88, 0.6),
    sourcefc=c(1,1,1.5,1.5,1.5, 2.6,2.6,-1.7,-2.6,-1.5,-1.2),
    targetfc=c(1.5,2.6,-1.7,-2.6,-1.5,-2.6,-1.2,-0.6,-2.2,-2.2,-0.7),
    stringsAsFactors=FALSE)


###################################################
### code chunk number 2: vignette.Rnw:96-97
###################################################
tempList <- createList(table1)


###################################################
### code chunk number 3: vignette.Rnw:101-112
###################################################
List <- data.frame(source=c("DrugX", "DrugX",
        "miR-B", "miR-B", "miR-B", "miR-A", "miR-A", "transc1",
        "transc2", "transc3", "transc4"),
    target=c("miR-B", "miR-A", "transc1", "transc2", "transc3",
        "transc2", "transc4", "gene1", "gene2", "gene2", "gene3"),
    value=c(0.6, 0.8, -0.7, -0.4, -0.34, -0.8, -0.6, 0.8, 0.9, 0.88, 0.6),
    	    stringsAsFactors=FALSE)
ListFC <- data.frame(genes=c("DrugX", "miR-B", "miR-A", "transc1",
    "transc2", "transc3", "transc4", "gene1", "gene2", "gene3"),
    foldChange=c(1, 1.5, 2.6, -1.7, -2.6, -1.5, -1.2, -0.6, -2.2, -0.7),
        stringsAsFactors=FALSE)


###################################################
### code chunk number 4: vignette.Rnw:114-115
###################################################
tempList2 <- createList(List,ListFC)


###################################################
### code chunk number 5: vignette.Rnw:136-145
###################################################
table1_v2 <- rbind(table1, # add to the example two transcript->gene->transcript loops
    data.frame(source=c("gene1", "gene2"),
    target=c("transc1", "transc2"),
    value=c(0.3, -0.8),
    sourcefc=c(-0.6,-2.2),
    targetfc=c(-1.7,-2.6),
    stringsAsFactors=FALSE))
tempList_v2 <- createList(table1_v2)
sankey_loop <- makeSankey(tempList_v2)


###################################################
### code chunk number 6: vignette.Rnw:147-148
###################################################
sankey_loop$reference[,c(1:6)] # note the change in target names!


###################################################
### code chunk number 7: vignette.Rnw:173-176
###################################################
initSankey()
sankey <- makeSankey(tempList2)
sankeyd <- drawSankey(sankey)


###################################################
### code chunk number 8: vignette.Rnw:184-187
###################################################
initSankey()
sankey2 <- makeSankey(tempList2, averagePath=TRUE)
sankey2d <- drawSankey(sankey2)


###################################################
### code chunk number 9: vignette.Rnw:200-201
###################################################
colnames(sankey2$reference)[7] <- "averagePath_value"


###################################################
### code chunk number 10: vignette.Rnw:202-203
###################################################
truevalue <-  sankey$reference$truevalue


###################################################
### code chunk number 11: vignette.Rnw:205-206
###################################################
cbind(sankey2$reference[,c("source", "target","averagePath_value")],truevalue)


###################################################
### code chunk number 12: vignette.Rnw:226-238
###################################################
# Makes the path colours darker by 10%  and uses a single, uniform font size for the figure rather than font sizes proportional to node size.
initSankey(pathOpacity = 0.3, pathHover = 0.6,
    fontsizeProportion = FALSE, fontsize=20)

# Changes the default colours used.
sankey2 <- makeSankey(tempList2, averagePath=TRUE,
    nodeMin = "orange", nodeMax = "purple", pathMax = "#333333")

# Changes to legend values and overall figure size
sankey <- drawSankey(sankey2, caption = "Alternate figure",
    nodeValue = "Node colour scale", pathValue = "Path colour scale",
    legendsize = 14, height = 300)


