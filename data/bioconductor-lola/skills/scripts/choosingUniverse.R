# Code example from 'choosingUniverse' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# activeDHS = unlist(regionDB$regionGRL[which(regionDB$regionAnno$collection == "sheffield_dnase")])
# activeDHS = disjoin(activeDHS)
# activeDHS

## ----eval = FALSE-------------------------------------------------------------
# restrictedUniverse = unlist(userSets)

## ----eval = FALSE-------------------------------------------------------------
# locResults = runLOLA(userSets, activeDHS, regionDB, cores=1)
# locResultsRestricted = runLOLA(userSets, restrictedUniverse, regionDB, cores=1)

## ----eval = FALSE-------------------------------------------------------------
# locResults[userSet==2,][order(maxRnk, decreasing=FALSE),][1:10,]
# locResultsRestricted[userSet==2,][order(maxRnk, decreasing=FALSE),][1:10,]
# 
# locResults[userSet==3,][order(maxRnk, decreasing=FALSE),][1:10,]
# locResultsRestricted[userSet==3,][order(maxRnk, decreasing=FALSE),][1:10,]

