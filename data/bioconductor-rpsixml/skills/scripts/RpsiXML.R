# Code example from 'RpsiXML' vignette. See references/ for full tutorial.

### R code from vignette source 'RpsiXML.Rnw'

###################################################
### code chunk number 1: loadlibs
###################################################
library(RpsiXML)


###################################################
### code chunk number 2: sampleFiles
###################################################
xmlDir <- system.file("/extdata/psi25files",package="RpsiXML")
gridxml <- file.path(xmlDir, "biogrid_200804_test.xml")


###################################################
### code chunk number 3: intactInteractionEX
###################################################
intactxml <- file.path(xmlDir, "intact_2008_test.xml")
intactComplexxml <- file.path(xmlDir,"intact_complexSample.xml")


###################################################
### code chunk number 4: parseInteraction
###################################################
intactSample <- parsePsimi25Interaction(intactxml, INTACT.PSIMI25,verbose=FALSE)
intactComplexSample <- parsePsimi25Complex(intactComplexxml, INTACT.PSIMI25,verbose=FALSE)


###################################################
### code chunk number 5: interactionInfo1
###################################################
interact <- interactions(intactSample)[1:3]
interact
organismName(intactSample)[1:3]
releaseDate(intactSample)


###################################################
### code chunk number 6: interactionInfo2
###################################################
lapply(interact, participant)[1:3]
sapply(interact, bait)[1:3]
sapply(interact, prey)[1:3]
sapply(interact, pubmedID)[1:3]


###################################################
### code chunk number 7: interactionInfo1
###################################################
comp <- complexes(intactComplexSample)[1:2]
sapply(comp, complexName)


###################################################
### code chunk number 8: intactGraph
###################################################
intactGraph <- psimi25XML2Graph(intactxml, INTACT.PSIMI25, 
                                type="interaction",verbose=FALSE)
nodes(intactGraph)
degree(intactGraph)


###################################################
### code chunk number 9: intactHyperGraph
###################################################
intactHG <- psimi25XML2Graph(intactxml, INTACT.PSIMI25, type="complex",verbose=FALSE)


###################################################
### code chunk number 10: separateXML
###################################################
graphs <- separateXMLDataByExpt(xmlFiles = intactxml, psimi25source=INTACT.PSIMI25, 
                                type="indirect", directed=TRUE, abstract=TRUE,
                                verbose=FALSE) 


###################################################
### code chunk number 11: showGraph
###################################################
graphs
abstract(graphs$`18296487`)


###################################################
### code chunk number 12: abst
###################################################
getAbstractByPMID(names(graphs))


###################################################
### code chunk number 13: translate
###################################################
graphs1 <- translateID(graphs[[1]], to="intact")
nodes(graphs1)


