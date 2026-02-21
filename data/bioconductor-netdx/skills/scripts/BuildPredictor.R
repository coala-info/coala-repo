# Code example from 'BuildPredictor' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
#  suppressWarnings(suppressMessages(require(netDx)))
#  suppressWarnings(suppressMessages(library(curatedTCGAData)))
#  
#  # fetch data remotely
#  brca <- suppressMessages(curatedTCGAData("BRCA",c("mRNAArray"),FALSE))
#  
#  # process input variables
#  staget <- sub("[abcd]","",sub("t","",colData(brca)$pathology_T_stage))
#  staget <- suppressWarnings(as.integer(staget))
#  colData(brca)$STAGE <- staget
#  
#  pam50 <- colData(brca)$PAM50.mRNA
#  pam50[which(!pam50 %in% "Luminal A")] <- "notLumA"
#  pam50[which(pam50 %in% "Luminal A")] <- "LumA"
#  colData(brca)$pam_mod <- pam50
#  
#  tmp <- colData(brca)$PAM50.mRNA
#  idx <- union(which(tmp %in% c("Normal-like","Luminal B","HER2-enriched")),
#               		which(is.na(staget)))
#  pID <- colData(brca)$patientID
#  tokeep <- setdiff(pID, pID[idx])
#  brca <- brca[,tokeep,]
#  
#  smp <- sampleMap(brca)
#  samps <- smp[which(smp$assay=="BRCA_mRNAArray-20160128"),]
#  # remove duplicate assays mapped to the same sample
#  notdup <- samps[which(!duplicated(samps$primary)),"colname"]
#  brca[[1]] <- suppressMessages(brca[[1]][,notdup])
#  
#  # colData must have ID and STATUS columns
#  pID <- colData(brca)$patientID
#  colData(brca)$ID <- pID
#  colData(brca)$STATUS <- colData(brca)$pam_mod
#  
#  # create grouping rules
#  groupList <- list()
#  # genes in mRNA data are grouped by pathways
#  pathList <- readPathways(fetchPathwayDefinitions("January",2018))
#  groupList[["BRCA_mRNAArray-20160128"]] <- pathList[1:3]
#  # clinical data is not grouped; each variable is its own feature
#  groupList[["clinical"]] <- list(
#        age="patient.age_at_initial_pathologic_diagnosis",
#  	   stage="STAGE"
#  )
#  
#  # create function to tell netDx how to build features (PSN) from your data
#  makeNets <- function(dataList, groupList, netDir,...) {
#  	netList <- c() # initialize before is.null() check
#  	# make RNA nets (NOTE: the check for is.null() is important!)
#  	# (Pearson correlation)
#  	if (!is.null(groupList[["BRCA_mRNAArray-20160128"]])) {
#  	netList <- makePSN_NamedMatrix(dataList[["BRCA_mRNAArray-20160128"]],
#  				rownames(dataList[["BRCA_mRNAArray-20160128"]]),
#  			   	groupList[["BRCA_mRNAArray-20160128"]],
#  				netDir,verbose=FALSE,
#  			  	writeProfiles=TRUE,...)
#  	}
#  	
#  	# make clinical nets (normalized difference)
#  	netList2 <- c()
#  	if (!is.null(groupList[["clinical"]])) {
#  	netList2 <- makePSN_NamedMatrix(dataList$clinical,
#  		rownames(dataList$clinical),
#  		groupList[["clinical"]],netDir,
#  		simMetric="custom",customFunc=normDiff, # custom function
#  		writeProfiles=FALSE,
#  		sparsify=TRUE,verbose=TRUE,...)
#  	}
#  	netList <- c(unlist(netList),unlist(netList2))
#  	return(netList)
#  }
#  
#  # run predictor
#  set.seed(42) # make results reproducible
#  outDir <- paste(tempdir(),randAlphanumString(),
#  	"pred_output",sep=getFileSep())
#  # To see all messages, remove suppressMessages() and set logging="default".
#  # To keep all intermediate data, set keepAllData=TRUE
#  out <- buildPredictor(
#        dataList=brca,groupList=groupList,
#        makeNetFunc=makeNets,
#        outDir=outDir, ## netDx requires absolute path
#        numSplits=2L,featScoreMax=2L, featSelCutoff=1L,
#        numCores=1L,logging="none",
#        keepAllData=FALSE,debugMode=TRUE
#     )
#  
#  # collect results
#  numSplits <- 2
#  st <- unique(colData(brca)$STATUS)
#  acc <- c()         # accuracy
#  predList <- list() # prediction tables
#  featScores <- list() # feature scores per class
#  for (cur in unique(st)) featScores[[cur]] <- list()
#  
#  for (k in 1:numSplits) {
#  	pred <- out[[sprintf("Split%i",k)]][["predictions"]];
#  	# predictions table
#  	tmp <- pred[,c("ID","STATUS","TT_STATUS","PRED_CLASS",
#  	                 sprintf("%s_SCORE",st))]
#  	predList[[k]] <- tmp
#  	# accuracy
#  	acc <- c(acc, sum(tmp$PRED==tmp$STATUS)/nrow(tmp))
#  	# feature scores
#  	for (cur in unique(st)) {
#  	   tmp <- out[[sprintf("Split%i",k)]][["featureScores"]][[cur]]
#  	   colnames(tmp) <- c("PATHWAY_NAME","SCORE")
#  	   featScores[[cur]][[sprintf("Split%i",k)]] <- tmp
#  	}
#  }
#  
#  # plot ROC and PR curve, compute AUROC, AUPR
#  predPerf <- plotPerf(predList, predClasses=st)
#  # get table of feature scores for each split and patient label
#  featScores2 <- lapply(featScores, getNetConsensus)
#  # identify features that consistently perform well
#  featSelNet <- lapply(featScores2, function(x) {
#      callFeatSel(x, fsCutoff=1, fsPctPass=0)
#  })
#  
#  # prepare data for EnrichmentMap plotting of top-scoring features
#  Emap_res <- getEMapInput_many(featScores2,pathList,
#      minScore=1,maxScore=2,pctPass=0,out$inputNets,verbose=FALSE)
#  gmtFiles <- list()
#  nodeAttrFiles <- list()
#  
#  for (g in names(Emap_res)) {
#      outFile <- paste(outDir,sprintf("%s_nodeAttrs.txt",g),sep=getFileSep())
#      write.table(Emap_res[[g]][["nodeAttrs"]],file=outFile,
#          sep="\t",col=TRUE,row=FALSE,quote=FALSE)
#      nodeAttrFiles[[g]] <- outFile
#  
#      outFile <- paste(outDir,sprintf("%s.gmt",g),sep=getFileSep())
#      conn <- suppressWarnings(
#           suppressMessages(base::file(outFile,"w")))
#      tmp <- Emap_res[[g]][["featureSets"]]
#      gmtFiles[[g]] <- outFile
#  
#      for (cur in names(tmp)) {
#          curr <- sprintf("%s\t%s\t%s", cur,cur,
#              paste(tmp[[cur]],collapse="\t"))
#          writeLines(curr,con=conn)
#      }
#  close(conn)
#  }
#  
#  # This step requires Cytoscape to be installed and running.
#  ###plotEmap(gmtFiles[[1]],nodeAttrFiles[[1]],
#  ###         groupClusters=TRUE, hideNodeLabels=TRUE)
#  
#  # collect data for integrated PSN
#  featScores2 <- lapply(featScores, getNetConsensus)
#  featSelNet <- lapply(featScores2, function(x) {
#      callFeatSel(x, fsCutoff=2, fsPctPass=1)
#  })
#  topPath <- gsub(".profile","",
#  		unique(unlist(featSelNet)))
#  topPath <- gsub("_cont.txt","",topPath)
#  # create groupList limited to top features
#  g2 <- list();
#  for (nm in names(groupList)) {
#  	cur <- groupList[[nm]]
#  	idx <- which(names(cur) %in% topPath)
#  	message(sprintf("%s: %i pathways", nm, length(idx)))
#  	if (length(idx)>0) g2[[nm]] <- cur[idx]
#  }
#  
#  # calculates integrated PSN, calculates grouping statistics,
#  # and plots integrates PSN. Set plotCytoscape=TRUE if Cytoscape is running.
#  psn <- suppressMessages(
#     plotIntegratedPatientNetwork(brca,
#    groupList=g2, makeNetFunc=makeNets,
#    aggFun="MEAN",prune_X=0.30,prune_useTop=TRUE,
#    numCores=1L,calcShortestPath=TRUE,
#    showStats=FALSE,
#    verbose=FALSE, plotCytoscape=FALSE)
#  )
#  
#  # Visualize integrated patient similarity network as a tSNE plot
#  tsne <- plot_tSNE(psn$patientSimNetwork_unpruned,colData(brca))

## ----eval=FALSE---------------------------------------------------------------
#  numSplits <- 100     # num times to split data into train/blind test samples
#  featScoreMax <- 10   # num folds for cross-validation, also max score for a network
#  featSelCutoff <- 9
#  netScores <- list()  # collect <numSplits> set of netScores
#  perf <- list()       # collect <numSplits> set of test evaluations
#  
#  for k in 1:numSplits
#   [train, test] <- splitData(80:20) # split data using RNG seed
#    featScores[[k]] <- scoreFeatures(train, featScoreMax)
#   topFeat[[k]] <- applyFeatCutoff(featScores[[k]])
#   perf[[k]] <- collectPerformance(topFeat[[k]], test)
#  end

## ----eval=TRUE----------------------------------------------------------------
suppressWarnings(suppressMessages(require(netDx)))

## ----eval=TRUE----------------------------------------------------------------
suppressMessages(library(curatedTCGAData))

## ----eval=TRUE----------------------------------------------------------------
curatedTCGAData(diseaseCode="BRCA", assays="*",dry.run=TRUE)

## ----eval=TRUE----------------------------------------------------------------
brca <- suppressMessages(curatedTCGAData("BRCA",c("mRNAArray"),FALSE))

## ----eval=TRUE----------------------------------------------------------------
staget <- sub("[abcd]","",sub("t","",colData(brca)$pathology_T_stage))
staget <- suppressWarnings(as.integer(staget))
colData(brca)$STAGE <- staget

pam50 <- colData(brca)$PAM50.mRNA
pam50[which(!pam50 %in% "Luminal A")] <- "notLumA"
pam50[which(pam50 %in% "Luminal A")] <- "LumA"
colData(brca)$pam_mod <- pam50

tmp <- colData(brca)$PAM50.mRNA
idx <- union(which(tmp %in% c("Normal-like","Luminal B","HER2-enriched")),
             		which(is.na(staget)))
pID <- colData(brca)$patientID
tokeep <- setdiff(pID, pID[idx])
brca <- brca[,tokeep,]

# remove duplicate assays mapped to the same sample
smp <- sampleMap(brca)
samps <- smp[which(smp$assay=="BRCA_mRNAArray-20160128"),]
notdup <- samps[which(!duplicated(samps$primary)),"colname"]
brca[[1]] <- suppressMessages(brca[[1]][,notdup])

## ----eval=TRUE----------------------------------------------------------------
pID <- colData(brca)$patientID
colData(brca)$ID <- pID
colData(brca)$STATUS <- colData(brca)$pam_mod

## ----eval=TRUE----------------------------------------------------------------
summary(brca)

## ----eval=TRUE----------------------------------------------------------------
groupList <- list()

# genes in mRNA data are grouped by pathways
pathList <- readPathways(fetchPathwayDefinitions("January",2018))
groupList[["BRCA_mRNAArray-20160128"]] <- pathList[1:3]
# clinical data is not grouped; each variable is its own feature
groupList[["clinical"]] <- list(
      age="patient.age_at_initial_pathologic_diagnosis",
	   stage="STAGE"
)

## ----eval=TRUE----------------------------------------------------------------
summary(groupList)

## ----eval=TRUE----------------------------------------------------------------
groupList[["BRCA_mRNAArray-20160128"]][1:3]

## ----eval=TRUE----------------------------------------------------------------
head(groupList[["clinical"]])

## -----------------------------------------------------------------------------
makeNets <- function(dataList, groupList, netDir,...) {
	netList <- c() # initialize before is.null() check
	# make RNA nets (NOTE: the check for is.null() is important!)
	# (Pearson correlation)
	if (!is.null(groupList[["BRCA_mRNAArray-20160128"]])) { 
	netList <- makePSN_NamedMatrix(dataList[["BRCA_mRNAArray-20160128"]],
				rownames(dataList[["BRCA_mRNAArray-20160128"]]),
			   	groupList[["BRCA_mRNAArray-20160128"]],
				netDir,verbose=FALSE, 
			  	writeProfiles=TRUE,...) 
	}
	
	# make clinical nets (normalized difference)
	netList2 <- c()
	if (!is.null(groupList[["clinical"]])) {
	netList2 <- makePSN_NamedMatrix(dataList$clinical, 
		rownames(dataList$clinical),
		groupList[["clinical"]],netDir,
		simMetric="custom",customFunc=normDiff, # custom function
		writeProfiles=FALSE,
		sparsify=TRUE,verbose=TRUE,...)
	}
	netList <- c(unlist(netList),unlist(netList2))
	return(netList)
}


## ----eval=TRUE----------------------------------------------------------------
set.seed(42) # make results reproducible
outDir <- paste(tempdir(),randAlphanumString(),
	"pred_output",sep=getFileSep())
# set keepAllData=TRUE to not delete at the end of the predictor run.
# This can be useful for debugging.
out <- buildPredictor(
      dataList=brca,groupList=groupList,
      makeNetFunc=makeNets,
      outDir=outDir, ## netDx requires absolute path
      numSplits=2L,featScoreMax=2L,
      featSelCutoff=1L,
      numCores=1L,debugMode=TRUE,
      logging="none")

## ----eval=TRUE----------------------------------------------------------------
summary(out)
summary(out$Split1)

## ----eval=TRUE----------------------------------------------------------------
numSplits <- 2
st <- unique(colData(brca)$STATUS)
acc <- c()         # accuracy
predList <- list() # prediction tables

featScores <- list() # feature scores per class
for (cur in unique(st)) featScores[[cur]] <- list()

for (k in 1:numSplits) { 
	pred <- out[[sprintf("Split%i",k)]][["predictions"]];
	# predictions table
	tmp <- pred[,c("ID","STATUS","TT_STATUS","PRED_CLASS",
	                 sprintf("%s_SCORE",st))]
	predList[[k]] <- tmp 
	# accuracy
	acc <- c(acc, sum(tmp$PRED==tmp$STATUS)/nrow(tmp))
	# feature scores
	for (cur in unique(st)) {
	   tmp <- out[[sprintf("Split%i",k)]][["featureScores"]][[cur]]
	   colnames(tmp) <- c("PATHWAY_NAME","SCORE")
	   featScores[[cur]][[sprintf("Split%i",k)]] <- tmp
	}
}

## ----eval=TRUE----------------------------------------------------------------
print(acc)

## ----eval=TRUE,fig.width=8,fig.height=10--------------------------------------
predPerf <- plotPerf(predList, predClasses=st)

## ----eval=TRUE----------------------------------------------------------------
featScores2 <- lapply(featScores, getNetConsensus)
summary(featScores2)
head(featScores2[["LumA"]])

## ----eval=TRUE----------------------------------------------------------------
featSelNet <- lapply(featScores2, function(x) {
    callFeatSel(x, fsCutoff=1, fsPctPass=0)
})
print(head(featScores2[["LumA"]]))

## ----eval=TRUE----------------------------------------------------------------
Emap_res <- getEMapInput_many(featScores2,pathList,
    minScore=1,maxScore=2,pctPass=0,out$inputNets,verbose=FALSE)

## ----eval=TRUE----------------------------------------------------------------
gmtFiles <- list()
nodeAttrFiles <- list()

for (g in names(Emap_res)) {
    outFile <- paste(outDir,sprintf("%s_nodeAttrs.txt",g),sep=getFileSep())
    write.table(Emap_res[[g]][["nodeAttrs"]],file=outFile,
        sep="\t",col=TRUE,row=FALSE,quote=FALSE)
    nodeAttrFiles[[g]] <- outFile

    outFile <- paste(outDir,sprintf("%s.gmt",g),sep=getFileSep())
    conn <- suppressWarnings(
         suppressMessages(base::file(outFile,"w")))
    tmp <- Emap_res[[g]][["featureSets"]]
    gmtFiles[[g]] <- outFile

    for (cur in names(tmp)) {
        curr <- sprintf("%s\t%s\t%s", cur,cur,
            paste(tmp[[cur]],collapse="\t"))
        writeLines(curr,con=conn)
    }
close(conn)
}

## ----eval=TRUE----------------------------------------------------------------
###plotEmap(gmtFiles[[1]],nodeAttrFiles[[1]],
###         groupClusters=TRUE, hideNodeLabels=TRUE)


## ----eval=TRUE----------------------------------------------------------------
featScores2 <- lapply(featScores, getNetConsensus)
featSelNet <- lapply(featScores2, function(x) {
    callFeatSel(x, fsCutoff=2, fsPctPass=1)
})

## ----eval=TRUE----------------------------------------------------------------
print(featSelNet)

## ----eval=TRUE----------------------------------------------------------------
topPath <- gsub(".profile","",
		unique(unlist(featSelNet)))
topPath <- gsub("_cont.txt","",topPath)
# create groupList limited to top features
g2 <- list();
for (nm in names(groupList)) {
	cur <- groupList[[nm]]
	idx <- which(names(cur) %in% topPath)
	message(sprintf("%s: %i pathways", nm, length(idx)))
	if (length(idx)>0) g2[[nm]] <- cur[idx]
}

## ----eval=TRUE----------------------------------------------------------------
psn <- suppressMessages(
   plotIntegratedPatientNetwork(brca,
  groupList=g2, makeNetFunc=makeNets,
  aggFun="MEAN",prune_pctX=0.30,prune_useTop=TRUE,
  numCores=1L,calcShortestPath=TRUE,
  showStats=FALSE,
  verbose=FALSE, plotCytoscape=FALSE)
)

## ----fig.width=8,fig.height=8-------------------------------------------------
tsne <- plot_tSNE(psn$patientSimNetwork_unpruned,colData(brca))
summary(tsne)
class(tsne)

## -----------------------------------------------------------------------------
sessionInfo()

