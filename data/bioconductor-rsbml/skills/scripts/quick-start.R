# Code example from 'quick-start' vignette. See references/ for full tutorial.

### R code from vignette source 'quick-start.Rnw'

###################################################
### code chunk number 1: read
###################################################
library(rsbml)
doc <- rsbml_read(system.file("sbml", "GlycolysisLayout.xml", package = "rsbml"), dom = FALSE)


###################################################
### code chunk number 2: dom
###################################################
dom <- rsbml_dom(doc)


###################################################
### code chunk number 3: ids
###################################################
sapply(species(model(dom)), id)


###################################################
### code chunk number 4: graph
###################################################
g <- rsbml_graph(doc)
graph::nodes(g)


###################################################
### code chunk number 5: check
###################################################
rsbml_check(doc)


###################################################
### code chunk number 6: problems
###################################################
tryCatch(rsbml_read("non-existent-file.xml"), 
         error = function(err) err$msg)


###################################################
### code chunk number 7: xml
###################################################
xml <- rsbml_xml(doc)


