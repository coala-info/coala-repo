# Code example from 'hyperdraw' vignette. See references/ for full tutorial.

### R code from vignette source 'hyperdraw.Rnw'

###################################################
### code chunk number 1: hyperdraw.Rnw:76-78
###################################################
library(hyperdraw)



###################################################
### code chunk number 2: hyperdraw.Rnw:83-97
###################################################
nodes <- c(LETTERS[1:5], paste("R", 1:3, sep=""))
testgnel <- new("graphNEL",
                nodes=nodes,
                edgeL=list(
                  A=list(edges=c("R1", "R2")),
                  B=list(edges="R2"),
                  C=list(),
                  D=list(edges="R3"),
                  E=list(),
                  R1=list(edges="B"),
                  R2=list(edges=c("C", "D")),
                  R3=list(edges="E")),
                edgemode="directed")



###################################################
### code chunk number 3: gnel
###################################################
plot(testgnel)



###################################################
### code chunk number 4: hyperdraw.Rnw:118-120
###################################################
testbph <- graphBPH(testgnel, edgeNodePattern="^R")



###################################################
### code chunk number 5: hyperdraw.Rnw:137-138
###################################################
library(hypergraph)


###################################################
### code chunk number 6: hyperdraw.Rnw:140-145
###################################################
dh1 <- DirectedHyperedge("A", "B", "R1")
dh2 <- DirectedHyperedge(c("A", "B"), c("C", "D"), "R2")
dh3 <- DirectedHyperedge("D", "E", "R3")
hg <- Hypergraph(LETTERS[1:5], list(dh1, dh2, dh3))
hgbph <- graphBPH(hg)


###################################################
### code chunk number 7: bph
###################################################
plot(testbph)



###################################################
### code chunk number 8: hyperdraw.Rnw:166-168
###################################################
testrabph <- graphLayout(testbph)



###################################################
### code chunk number 9: rabph
###################################################
edgeDataDefaults(testrabph, "lwd") <- 1
edgeData(testrabph, c("A", "R1"), 
                    c("R1", "B"), "lwd") <- c("5", "3")
edgeDataDefaults(testrabph, "color") <- "black"
edgeData(testrabph, c("A", "R1"), 
                    c("R1", "B"), "color") <- "red"
nodeDataDefaults(testrabph, "margin") <- 'unit(3, "mm")'
nodeDataDefaults(testrabph, "shape") <- "box"
plot(testrabph)


