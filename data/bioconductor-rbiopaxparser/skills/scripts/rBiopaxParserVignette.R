# Code example from 'rBiopaxParserVignette' vignette. See references/ for full tutorial.

### R code from vignette source 'rBiopaxParserVignette.Rnw'

###################################################
### code chunk number 1: no.nonsense
###################################################
rm(list=ls())


###################################################
### code chunk number 2: Load_package
###################################################
library(rBiopaxParser)


###################################################
### code chunk number 3: downloadbiopax (eval = FALSE)
###################################################
## file = downloadBiopaxData("NCI","biocarta")


###################################################
### code chunk number 4: parsebiopax (eval = FALSE)
###################################################
## biopax = readBiopax(file)
## print(biopax)


###################################################
### code chunk number 5: loaddata
###################################################
data(biopaxexample)


###################################################
### code chunk number 6: displaydataframe
###################################################
head(biopax$dt)


###################################################
### code chunk number 7: accessingbiopax
###################################################
pw_list = listInstances(biopax, class="pathway")
pw_complete = selectInstances(biopax, class="pathway")
pwid1 = "pid_p_100002_wntpathway"
pwid2 = "pid_p_100146_hespathway"
getInstanceProperty(biopax, pwid1, property="NAME")
getInstanceProperty(biopax, pwid2, property="NAME")
pw_1 = selectInstances(biopax, class="pathway", id=pwid1)
pw_1_component_list = listPathwayComponents(biopax,pwid1)
pw_1_components = selectInstances(biopax,id=pw_1_component_list$id)
pw_2 = selectInstances(biopax, class="pathway", id=pwid2)
pw_2_component_list = listPathwayComponents(biopax,pwid2)
pw_2_components = selectInstances(biopax,id=pw_2_component_list$id)


###################################################
### code chunk number 8: pathwaytoregulatorygraphs (eval = FALSE)
###################################################
## pw_1_adj = pathway2AdjacancyMatrix(biopax, pwid1, expandSubpathways=TRUE,
## splitComplexMolecules=TRUE, verbose=TRUE)
## pw_1_graph = pathway2RegulatoryGraph(biopax, pwid1,
## splitComplexMolecules=TRUE, verbose=TRUE)
## pw_2_adj = pathway2AdjacancyMatrix(biopax, pwid2, expandSubpathways=TRUE,
## splitComplexMolecules=TRUE, verbose=TRUE)
## pw_2_graph = pathway2RegulatoryGraph(biopax, pwid2,
## splitComplexMolecules=TRUE, verbose=TRUE)


###################################################
### code chunk number 9: layoutgraphs (eval = FALSE)
###################################################
## pw_1_graph_laidout = layoutRegulatoryGraph(pw_1_graph)
## pw_2_graph_laidout = layoutRegulatoryGraph(pw_2_graph)


###################################################
### code chunk number 10: plotgraphs (eval = FALSE)
###################################################
## plotRegulatoryGraph(pw_1_graph)
## plotRegulatoryGraph(pw_2_graph)


###################################################
### code chunk number 11: mergedgraph (eval = FALSE)
###################################################
## merged_graph = uniteGraphs(pw_1_graph_laidout,pw_2_graph_laidout)
## plotRegulatoryGraph(merged_graph, layoutGraph=FALSE)


###################################################
### code chunk number 12: beautifygraphs (eval = FALSE)
###################################################
## nodeRenderInfo(merged_graph)$cex = 1
## nodeRenderInfo(merged_graph)$textCol = "red"
## nodeRenderInfo(merged_graph)$fill = "green"
## plotRegulatoryGraph(merged_graph, layoutGraph=FALSE)


###################################################
### code chunk number 13: modifypathways (eval = FALSE)
###################################################
## biopax = mergePathways(biopax, pwid1, pwid2, NAME="mergedpw1", ID="mergedpwid1")
## mergedpw_graph = pathway2RegulatoryGraph(biopax, 
## 		"mergedpwid1", splitComplexMolecules=TRUE, verbose=TRUE)
## plotRegulatoryGraph(layoutRegulatoryGraph(mergedpw_graph))


###################################################
### code chunk number 14: createbiopax1
###################################################
biopax = createBiopax()
for(i in LETTERS[1:5]) {
	biopax = addPhysicalEntity(biopax, class="protein",
		NAME=paste("protein",i,sep="_"), 
		id=paste("proteinid",i,sep="_"))
	biopax = addPhysicalEntityParticipant(biopax,
		referencedPhysicalEntityID=paste("proteinid",i,sep="_"), 
		id=paste("PEPid",i,sep="_"))
	biopax = addBiochemicalReaction(biopax, LEFT=paste("PEPid",i,sep="_"),
		RIGHT=paste("PEPid",i,sep="_"),
		id=paste("BCRid",i,sep="_"))
}


###################################################
### code chunk number 15: createbiopax2
###################################################
biopax = addControl(biopax, CONTROL_TYPE="ACTIVATION",
	CONTROLLER="PEPid_A", CONTROLLED=c("BCRid_B"),id="control_1")
biopax = addControl(biopax, CONTROL_TYPE="INHIBITION",
	CONTROLLER="PEPid_A", CONTROLLED=c("BCRid_C"),id="control_2")
biopax = addControl(biopax, CONTROL_TYPE="ACTIVATION",
	CONTROLLER="PEPid_C", CONTROLLED=c("BCRid_D"),id="control_3")
biopax = addControl(biopax, CONTROL_TYPE="INHIBITION",
	CONTROLLER="PEPid_C", CONTROLLED=c("BCRid_E"), id="control_4")


###################################################
### code chunk number 16: createbiopax3
###################################################
biopax = addPathway(biopax, NAME="pw1",
	PATHWAY_COMPONENTS=c("control_1","control_2"), id="pwid1")
biopax = addPathway(biopax, NAME="pw2",
	PATHWAY_COMPONENTS=c("control_3","control_4"), id="pwid2")
biopax = mergePathways(biopax, "pwid1", "pwid2", NAME="pw3", id="pwid3")


###################################################
### code chunk number 17: createbiopax4 (eval = FALSE)
###################################################
## pw1_graph = pathway2RegulatoryGraph(biopax, "pwid1",
## 	splitComplexMolecules=TRUE, verbose=TRUE)
## pw2_graph = pathway2RegulatoryGraph(biopax, "pwid2",
## 	splitComplexMolecules=TRUE, verbose=TRUE)
## pw3_graph = pathway2RegulatoryGraph(biopax, "pwid3",
## 	splitComplexMolecules=TRUE, verbose=TRUE)


###################################################
### code chunk number 18: createbiopax5 (eval = FALSE)
###################################################
## plotRegulatoryGraph(layoutRegulatoryGraph(pw1_graph))
## plotRegulatoryGraph(layoutRegulatoryGraph(pw2_graph))
## plotRegulatoryGraph(layoutRegulatoryGraph(pw3_graph))


###################################################
### code chunk number 19: removebiopaxinstances (eval = FALSE)
###################################################
## temp = biopax
## temp = removeProperties(temp, id="newpwid2", properties="PATHWAY-COMPONENTS")
## temp = removeInstance(temp, id="newpwid3")


###################################################
### code chunk number 20: writeoutbiopax (eval = FALSE)
###################################################
## writeBiopax(biopax, file="test.writeBiopax.owl")


###################################################
### code chunk number 21: examplereactome1 (eval = FALSE)
###################################################
## file = downloadBiopaxData("reactome","reactome", version="biopax3")


###################################################
### code chunk number 22: examplereactome1 (eval = FALSE)
###################################################
## biopax = readBiopax(file)
## print(biopax)


###################################################
### code chunk number 23: rBiopaxParserVignette.Rnw:659-660
###################################################
toLatex(sessionInfo())


