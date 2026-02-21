# Code example from 'ibh' vignette. See references/ for full tutorial.

### R code from vignette source 'ibh.Rnw'

###################################################
### code chunk number 1: ibhExample
###################################################
 library(ibh)
 data(ArabidopsisBioGRIDInteractionEntrezId)
 geneList <- list(839226, 817241, 824340, 832179, 818561, 831145, 
     838782, 826404)
 ibh(ArabidopsisBioGRIDInteractionEntrezId, geneList)


###################################################
### code chunk number 2: ibhBioGRIDExample1
###################################################
 geneList <- list(839226, 817241, 824340, 832179, 818561, 831145, 
   838782, 826404)
ibhBioGRID(geneList, organism = "arabidopsis", idType = "EntrezId")


###################################################
### code chunk number 3: ibhBioGRIDExample2
###################################################
 geneList <- list("YJR151C", "YBL032W", "YAL040C", "YBL072C", 
     "YCL050C", "YCR009C")
 ibhBioGRID(geneList, organism = "yeast", idType = "UniqueId")


###################################################
### code chunk number 4: ibhForMultipleGeneListsExample
###################################################
 data(ArabidopsisBioGRIDInteractionEntrezId)
 listofGeneList <- list(list(839226, 817241, 824340, 832179, 818561, 
     831145, 838782, 826404), list(832018, 839226, 838824))
 ibhForMultipleGeneLists(ArabidopsisBioGRIDInteractionEntrezId, 
     listofGeneList)


###################################################
### code chunk number 5: ibhForMultipleGeneListsBioGRIDExample
###################################################
 listofGeneList <- list(list("YJR151C", "YBL032W", "YAL040C", 
     "YBL072C", "YCL050C", "YCR009C"), list("YDR063W", "YDR074W", 
     "YDR080W", "YDR247W", "YGR183C", "YHL033C"), list("YOL068C", 
     "YOL015W", "YOL009C", "YOL004W", "YOR065W"))
 ibhForMultipleGeneListsBioGRID(listofGeneList, organism = "yeast", 
     idType = "UniqueId")


###################################################
### code chunk number 6: ibhClusterEvalExample
###################################################
 require(yeastCC)
 require(stats)
 data(yeastCC)
 require(simpIntLists)
 data(YeastBioGRIDInteractionUniqueId)
 subset <- exprs(yeastCC)[1:50, ]
 d <- dist(subset, method = "euclidean")
 k <- kmeans(d, 3)
 ibhClusterEval(k$cluster, rownames(subset), YeastBioGRIDInteractionUniqueId)


###################################################
### code chunk number 7: ibhClusterEvalBioGRIDExample
###################################################
 ibhClusterEvalBioGRID(k$cluster, rownames(subset), organism = "yeast", 
     idType = "UniqueId")


