# Code example from 'usingLOLACore' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# library("LOLA")
# 
# regionDB = loadRegionDB("LOLACore/hg19")
# 
# regionSetA = readBed("lola_vignette_data/setA_100.bed")
# regionSetB = readBed("lola_vignette_data/setB_100.bed")
# regionSetC = readBed("lola_vignette_data/setC_100.bed")
# activeDHS = readBed("lola_vignette_data/activeDHS_universe.bed")

## ----eval = FALSE-------------------------------------------------------------
# userSets = GRangesList(regionSetA, regionSetB, regionSetC)
# locResults = runLOLA(userSets, activeDHS, regionDB, cores=1)

## ----eval = FALSE-------------------------------------------------------------
# locResults[1:10,]

## ----eval = FALSE-------------------------------------------------------------
# locResults[order(meanRnk, decreasing=FALSE),][1:20,]
# locResults[order(maxRnk, decreasing=FALSE),][1:20,]
# locResults[collection=="sheffield_dnase", ][order(maxRnk, decreasing=FALSE),]
# 
# locResults[userSet==2,][order(maxRnk, decreasing=FALSE),][1:10,]
# locResults[userSet==3,][order(maxRnk, decreasing=FALSE),][1:10,]
# 
# locResults[userSet==1,][collection=="sheffield_dnase", ][1:15,]
# locResults[userSet==2,][collection=="sheffield_dnase", ][1:15,]
# locResults[userSet==3,][collection=="sheffield_dnase", ][1:15,]

## ----eval = FALSE-------------------------------------------------------------
# writeCombinedEnrichment(locResults, outFolder= "lolaResults", includeSplits=TRUE)

