# Code example from 'ThreeWayClassifier' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
#  suppressWarnings(suppressMessages(require(netDx)))
#  suppressWarnings(suppressMessages(library(curatedTCGAData)))
#  
#  # fetch RNA, methylation and proteomic data for TCGA BRCA set
#  brca <- suppressMessages(
#     curatedTCGAData("BRCA",
#                 c("mRNAArray","RPPA*","Methylation_methyl27*"),
#  	dry.run=FALSE))
#  
#  # process input variables
#  # prepare clinical variable - stage
#  staget <- sub("[abcd]","",sub("t","",colData(brca)$pathology_T_stage))
#  staget <- suppressWarnings(as.integer(staget))
#  colData(brca)$STAGE <- staget
#  # exclude normal, HER2 (small num samples)
#  pam50 <- colData(brca)$PAM50.mRNA
#  idx <- union(which(pam50 %in% c("Normal-like","HER2-enriched")),
#  	which(is.na(staget)))
#  idx <- union(idx, which(is.na(pam50)))
#  pID <- colData(brca)$patientID
#  tokeep <- setdiff(pID, pID[idx])
#  brca <- brca[,tokeep,]
#  pam50 <- colData(brca)$PAM50.mRNA
#  colData(brca)$pam_mod <- pam50
#  
#  # remove duplicate names
#  smp <- sampleMap(brca)
#  for (nm in names(brca)) {
#  	samps <- smp[which(smp$assay==nm),]
#  	notdup <- samps[which(!duplicated(samps$primary)),"colname"]
#  	brca[[nm]] <- suppressMessages(brca[[nm]][,notdup])
#  }
#  
#  # colData must have ID and STATUS columns
#  pID <- colData(brca)$patientID
#  colData(brca)$ID <- pID
#  colData(brca)$STATUS <- gsub(" ","_",colData(brca)$pam_mod)
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
#  # for methylation generate one feature containing all probes
#  # same for proteomics data
#  tmp <- list(rownames(experiments(brca)[[2]]));
#  names(tmp) <- names(brca)[2]
#  groupList[[names(brca)[2]]] <- tmp
#  
#  tmp <- list(rownames(experiments(brca)[[3]]));
#  names(tmp) <- names(brca)[3]
#  groupList[[names(brca)[3]]] <- tmp
#  
#  # create function to tell netDx how to build features
#  # (PSN) from your data
#  makeNets <- function(dataList, groupList, netDir,...) {
#  	netList <- c() # initialize before is.null() check
#  	# correlation-based similarity for mRNA, RPPA and methylation data
#  	# (Pearson correlation)
#  	for (nm in setdiff(names(groupList),"clinical")) {
#  	   # NOTE: the check for is.null() is important!
#  		if (!is.null(groupList[[nm]])) {
#  		netList <- makePSN_NamedMatrix(dataList[[nm]],
#  		             rownames(dataList[[nm]]),
#                     groupList[[nm]],netDir,verbose=FALSE,
#  		             writeProfiles=TRUE,...)
#  		}
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
#  outDir <- paste(tempdir(),randAlphanumString(),"pred_output",sep=getFileSep())
#  # To see all messages, remove suppressMessages()
#  # and set logging="default".
#  # To keep all intermediate data, set keepAllData=TRUE
#  numSplits <- 2L
#  out <- suppressMessages(
#     buildPredictor(dataList=brca,groupList=groupList,
#        makeNetFunc=makeNets,
#        outDir=outDir, ## netDx requires absolute path
#        numSplits=numSplits, featScoreMax=2L, featSelCutoff=1L,
#  	   numCores=1L)
#  )
#  
#  # collect results for accuracy
#  st <- unique(colData(brca)$STATUS)
#  acc <- matrix(NA,ncol=length(st),nrow=numSplits)  # accuracy by class
#  colnames(acc) <- st
#  for (k in 1:numSplits) {
#  	pred <- out[[sprintf("Split%i",k)]][["predictions"]];
#  	tmp <- pred[,c("ID","STATUS","TT_STATUS","PRED_CLASS",
#  	                 sprintf("%s_SCORE",st))]
#  	for (m in 1:length(st)) {
#  	   tmp2 <- subset(tmp, STATUS==st[m])
#  	   acc[k,m] <- sum(tmp2$PRED==tmp2$STATUS)/nrow(tmp2)
#  	}
#  }
#  
#  # accuracy by class
#  print(round(acc*100,2))
#  
#  # confusion matrix
#  res <- out$Split1$predictions
#  print(table(res[,c("STATUS","PRED_CLASS")]))
#  
#  sessionInfo()

## ----eval=TRUE----------------------------------------------------------------
suppressWarnings(suppressMessages(require(netDx)))

## ----eval=TRUE----------------------------------------------------------------
suppressMessages(library(curatedTCGAData))

## ----eval=TRUE----------------------------------------------------------------
curatedTCGAData(diseaseCode="BRCA", assays="*",dry.run=TRUE)

## ----eval=TRUE----------------------------------------------------------------
brca <- suppressMessages(
   curatedTCGAData("BRCA",
               c("mRNAArray","RPPA*","Methylation_methyl27*"),
	dry.run=FALSE))

## ----eval=TRUE----------------------------------------------------------------
# prepare clinical variable - stage
staget <- sub("[abcd]","",sub("t","",colData(brca)$pathology_T_stage))
staget <- suppressWarnings(as.integer(staget))
colData(brca)$STAGE <- staget

# exclude normal, HER2 (small num samples)
pam50 <- colData(brca)$PAM50.mRNA
idx <- union(which(pam50 %in% c("Normal-like","HER2-enriched")), 
	which(is.na(staget)))
idx <- union(idx, which(is.na(pam50)))
pID <- colData(brca)$patientID
tokeep <- setdiff(pID, pID[idx])
brca <- brca[,tokeep,]

pam50 <- colData(brca)$PAM50.mRNA
colData(brca)$pam_mod <- pam50

# remove duplicate names
smp <- sampleMap(brca)
for (nm in names(brca)) {
	samps <- smp[which(smp$assay==nm),]
	notdup <- samps[which(!duplicated(samps$primary)),"colname"]
	brca[[nm]] <- suppressMessages(brca[[nm]][,notdup])
}

## ----eval=TRUE----------------------------------------------------------------
pID <- colData(brca)$patientID
colData(brca)$ID <- pID
colData(brca)$STATUS <- gsub(" ","_",colData(brca)$pam_mod)

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
# for methylation generate one feature containing all probes
# same for proteomics data
tmp <- list(rownames(experiments(brca)[[2]]));
names(tmp) <- names(brca)[2]
groupList[[names(brca)[2]]] <- tmp

tmp <- list(rownames(experiments(brca)[[3]]));
names(tmp) <- names(brca)[3]
groupList[[names(brca)[3]]] <- tmp

## ----eval=FALSE---------------------------------------------------------------
#  makePSN_NamedMatrix(..., writeProfiles=TRUE,...)`

## ----eval=FALSE---------------------------------------------------------------
#     makePSN_NamedMatrix(,...,
#                         simMetric="custom", customFunc=normDiff,
#                         writeProfiles=FALSE)

## ----eval=TRUE----------------------------------------------------------------
makeNets <- function(dataList, groupList, netDir,...) {
	netList <- c() # initialize before is.null() check
	# correlation-based similarity for mRNA, RPPA and methylation data
	# (Pearson correlation)
	for (nm in setdiff(names(groupList),"clinical")) {
	   # NOTE: the check for is.null() is important!
		if (!is.null(groupList[[nm]])) {
		netList <- makePSN_NamedMatrix(dataList[[nm]],
		             rownames(dataList[[nm]]),
                   groupList[[nm]],netDir,verbose=FALSE,
		             writeProfiles=TRUE,...) 
		}
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

# location for intermediate work
# set keepAllData to TRUE to not delete at the end of the 
# predictor run.
# This can be useful for debugging.
outDir <- paste(tempdir(),"pred_output",sep=getFileSep()) # use absolute path
numSplits <- 2L
out <- suppressMessages(
   buildPredictor(dataList=brca,groupList=groupList,
      makeNetFunc=makeNets,
      outDir=outDir, ## netDx requires absolute path
      numSplits=numSplits, featScoreMax=2L, featSelCutoff=1L,
	   numCores=1L)
)

## ----eval=TRUE----------------------------------------------------------------
summary(out)
summary(out$Split1)

## ----eval=TRUE----------------------------------------------------------------
# Average accuracy
st <- unique(colData(brca)$STATUS) 
acc <- matrix(NA,ncol=length(st),nrow=numSplits) 
colnames(acc) <- st 
for (k in 1:numSplits) { 
	pred <- out[[sprintf("Split%i",k)]][["predictions"]];
	tmp <- pred[,c("ID","STATUS","TT_STATUS","PRED_CLASS",
	                 sprintf("%s_SCORE",st))]
	for (m in 1:length(st)) {
	   tmp2 <- subset(tmp, STATUS==st[m])
	   acc[k,m] <- sum(tmp2$PRED==tmp2$STATUS)/nrow(tmp2)
	}
}
print(round(acc*100,2))

## ---- eval=TRUE---------------------------------------------------------------
res <- out$Split1$predictions
print(table(res[,c("STATUS","PRED_CLASS")]))

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

