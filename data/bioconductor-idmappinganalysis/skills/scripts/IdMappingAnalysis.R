# Code example from 'IdMappingAnalysis' vignette. See references/ for full tutorial.

### R code from vignette source 'IdMappingAnalysis.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: chunk1
###################################################
library(IdMappingAnalysis);


###################################################
### code chunk number 2: chunk1
###################################################
options(width=110)


###################################################
### code chunk number 3: chunk2 (eval = FALSE)
###################################################
## # Initialize the ID mapping retrieval system
## library(IdMappingRetrieval); 
## Annotation$init(); 
## AnnotationAffx$setCredentials(user=MY_AFFY_USERNAME,
##       password=MY_AFFY_PASSWORD,verbose=FALSE);
## # Create a service manage object encapsulating default ID retrieval services.
## svm <- ServiceManager(ServiceManager$getDefaultServices());
## # Retrieve the ID Map list for selected array type and services.
## identDfList <- getIdMapList(svm,arrayType="HG-U133_Plus_2", 
##       selection=names(svm$getServices()),verbose=TRUE); 
## class(identDfList)
## class(identDfList)[[1]]


###################################################
### code chunk number 4: chunk3
###################################################
# A list of ID maps to be analysed.
names(examples$identDfList)
head(examples$identDfList[[1]], 5)

# Define the primary and secondary IDs to work with. 
primaryIDs <- IdMapBase$primaryIDs(examples$msmsExperimentSet)
head(primaryIDs)   ### UniProt IDs for proteins.
secondaryIDs <- IdMapBase$primaryIDs(examples$mrnaExperimentSet);
head(secondaryIDs)  ### Affymetrix probeset IDs.

# Construct a JointIdMap object which combines 
# the various ID maps, aligned by the union of the primary ID vectors.
jointIdMap <- JointIdMap(examples$identDfList,primaryIDs,verbose=FALSE);
names(getMethods.Class(JointIdMap)[["JointIdMap"]])  ### Methods specific to JointIDMap
str(jointIdMap$as.data.frame())  ##  Structure of the data field of JointIdMap


###################################################
### code chunk number 5: chunkSwapKeys
###################################################
identDfListReversed <- lapply(examples$identDfList, function(identDf)
    IdMap$swapKeys(IdMap(identDf)))
jointIdMapReversed <- JointIdMap(identDfListReversed, secondaryIDs, verbose=FALSE)


###################################################
### code chunk number 6: chunk4
###################################################
# Assemble secondary ID counts object for a given set of DB's
mapCounts <- getCounts(jointIdMap,
          idMapNames=c("NetAffx_Q","NetAffx_F","DAVID_Q","DAVID_F","EnVision_Q"),
          verbose=FALSE);
#  This shows the structure of the contents of an IdMapCounts object.
str(mapCounts$as.data.frame()) 
names(getMethods.Class(mapCounts)[["IdMapCounts"]])

#  Tabulating the number of returned secondary IDs per primary ID, aligned across services.
statsByMatchCount <- mapCounts$getStats(summary=FALSE,verbose=FALSE); 
statsByMatchCount[1:6,1:10];
#  ...and the same results with a simplified summary.
mapCounts$getStats(summary=TRUE,cutoff=3,verbose=FALSE);

#  A plot of empirical cdf's of the secondary ID counts
par(mfrow = c(1, 2));
mapCounts$plot();  ### Or alternatice syntax:  plot(mapCounts)


###################################################
### code chunk number 7: chunk5
###################################################
diffsBetweenMap <- jointIdMap$getDiff("DAVID_Q","EnVision_Q",verbose=FALSE);
class(diffsBetweenMap)
diffCounts <- IdMapDiffCounts(diffsBetweenMap,verbose=FALSE); 
names(getMethods(IdMapDiffCounts)[["IdMapDiffCounts"]])

###  We characterize the differences betwen the two ID maps.
diffCounts$summary(verbose);
par(mfrow = c(1, 2));
diffCounts$plot(adj=0.1,sides=1);

# The same result is achieved more succinctly (for a different pair of ID mapping resources in this example) in this way: 
# summary(jointIdMap$diffCounts.plot(c("DAVID_Q", "EnVision_Q"),
#                                           adj=0.1,sides=1,verbose=FALSE));
# We can also characterize the reverse  mapping created above.
summary(jointIdMapReversed$diffCounts.plot(c("DAVID_Q", "EnVision_Q"),
                                           adj=0.1,sides=1,verbose=FALSE));


###################################################
### code chunk number 8: chunk6 (eval = FALSE)
###################################################
## jointIdMap$diffCounts.plot("loop",adj=0.1,sides=1,verbose=FALSE);


###################################################
### code chunk number 9: chunk7
###################################################
msmsExperimentSet <- DataFilter$do.apply(examples$msmsExperimentSet,
     byRows=TRUE,filterFun=DataFilter$minAvgCountConstraint,filtParams=0.52,verbose=FALSE);
dim(examples$msmsExperimentSet)
dim(msmsExperimentSet)
msmsExperimentSet <- DataFilter$removeNASeries(msmsExperimentSet,byRows=TRUE,verbose=FALSE); 
dim(msmsExperimentSet)

mrnaExperimentSet <- examples$mrnaExperimentSet
# We log10-transform the mRNA signal data.
mrnaExperimentSet[,-1] <- log10(mrnaExperimentSet[,-1]);

#  The primary IDs are now defined by the experiment.
primaryIDs_from_dataset <- IdMapBase$primaryIDs(msmsExperimentSet);
secondaryIDs <- IdMapBase$primaryIDs(mrnaExperimentSet);
#  The method name primaryIDs() is unfortunate! This will be changed.

# Create a JointIdMap object as before, 
# but with a  primary ID vector reduced by the filtering step above.
jointIdMap_from_dataset <- JointIdMap(examples$identDfList, primaryIDs_from_dataset, verbose=FALSE);


###################################################
### code chunk number 10: chunk8
###################################################
uniquePairs <- as.UniquePairs(
    getUnionIdMap(jointIdMap_from_dataset,verbose=FALSE),secondaryIDs);
str(uniquePairs$as.data.frame())

corrData <- CorrData(uniquePairs, 
    examples$msmsExperimentSet,examples$mrnaExperimentSet,verbose=FALSE);
str(corrData)
names(getMethods(CorrData)[["CorrData"]])
# (The method as.MultiSet() is deprecated.)


###################################################
### code chunk number 11: chunkJointUniquePairs
###################################################
# create pairs match object from unique pairs and joint ID map object 
jointUniquePairs <- JointUniquePairs(uniquePairs, 
    getIdMapList(jointIdMap_from_dataset,verbose=FALSE),verbose=FALSE);
str(jointUniquePairs$as.data.frame())


###################################################
### code chunk number 12: chunkIndividualScatterplot
###################################################

# cross-correlation matrix of the  expression signals for probesets mapped with UniprotAcc="P07355"

idMatchInfo <- jointIdMap_from_dataset$
                      getMatchInfo(IDs="P07355", 
                               idMapNames=c("NetAffx_Q", "DAVID_Q", "EnVision_Q"))[[1]] 
print(idMatchInfo)
data_Uniprot = corrData$getExperimentSet(modality="Uniprot",
      IDs="P07355")
data_Affy <- corrData$getExperimentSet(modality="Affy",
      IDs=colnames(idMatchInfo)); 
data <- cbind(t(data_Uniprot[,-1]), t(data_Affy[,-1]))
cor(data,method="spearman");

# Scatterplot  for Uniprot="P07355" (annexin 2), probe set ID="1568126_at".  
# Patient outcomes guide symbols and colors.
par(mfrow = c(1, 2));
corrData$plot(input=list(c("P07355","1568126_at")),
 	outcomePairs=examples$outcomeMap,proteinNames="ANXA2",
     cex=1.2,cex.main=1.2,cex.lab=1.2,cols=c("green","red","darkblue"));

# scatterplot with outcome for Uniprot="P07384" (annexin 2)
# for all matching probesets without outcome
corrData$plot(input="P07384",proteinNames="ANXA2",
     cex=1.2,cex.main=1.2,cex.lab=1.2,cols=c("green","red","darkblue"));


###################################################
### code chunk number 13: chunk10 (eval = FALSE)
###################################################
## # interactive scatterplot with a single primary ID (uniprot) and outcomes
## corrData$interactive.plot(c("P07355"),
##       outcomePairs=examples$outcomeMap,proteinNames="ANXA2");
## 
## # interactive scatterplot with a single primary ID (uniprot) and without outcomes
##  corrData$interactive.plot(c("P07355"),proteinNames="ANXA2");
## 
## # interactive scatterplot with multiple probeset IDs (uniprot) and without outcomes
## corrData$interactive.plot(c("P07355","P07384","P09382"));
## 
## # interactive scatterplot with all available probeset 
## #IDs (uniprot) and without outcomes 
## corrData$interactive.plot();


###################################################
### code chunk number 14: chunkDensityFit
###################################################
par(mfrow = c(1, 3));
corr <- Corr(corrData,method="pearson",verbose=FALSE); 
corr[1:6, ]

## Left-hand plot: density estimate for all correlations.
corr$plot(cex=1.2,cex.main=1.4,cex.lab=1.2,cex.legend=1.2);

## Center plot: individual density estimates for selected Id mapping resources.
corrSet <- getCorr(jointUniquePairs,corr,
      groups=c("union","EnVision_Q","NetAffx_Q","DAVID_Q","DAVID_F"),
      full.group=TRUE,verbose=FALSE); 
names(corrSet)
Corr$plot(corrSet,cex=1.2,cex.main=1.4,cex.lab=1.2,cex.legend=1.2);

## Right-hand plot: individual density estimates for selected Id mapping resources.
corrSet <- jointUniquePairs$corr.plot(corr,
      idMapNames=c("NetAffx_Q","DAVID_Q","EnVision_Q"), 
      plot.Union=FALSE, subsetting=TRUE, verbose=FALSE,
      cex=1.2, cex.main=1.4 ,cex.lab=1.2, cex.legend=1.2);
names(corrSet)


###################################################
### code chunk number 15: chunk13 (eval = FALSE)
###################################################
## jointUniquePairs$interactive.corr.plot(corr,verbose=FALSE);


###################################################
### code chunk number 16: chunkMIXTURE
###################################################

# create and plot the mixture model for number of components = 2 
mixture <- Mixture(corr,G=2,verbose=FALSE); 
par(mfrow=c(1, 2));
mixture$plot(); 
mixture$getStats();


###################################################
### code chunk number 17: chunkPlotMixtureNotEvaluated (eval = FALSE)
###################################################
## # Create and plot the mixture model determining 
## #the optimal number of components) 
## # for a given DB subset treating the subset as a full group
## mixture.subset <- jointUniquePairs$getMixture(corr, groups=c("NetAffx_Q","DAVID_Q","EnVision_Q"),
##       full.group=TRUE,G=c(1:5),verbose); 
## 
## mixture.subset <- jointUniquePairs$mixture.plot(corr,
##       idMapNames=c("NetAffx_Q","DAVID_Q","EnVision_Q"),
##       subsetting=TRUE,G=c(1:5),verbose=FALSE);


###################################################
### code chunk number 18: chunk17
###################################################
# retrieve the mixture parameters 
mixture$getStats();


###################################################
### code chunk number 19: chunkBOXPLOTS
###################################################
par(mfrow = c(1, 2));

# Choose the mapping services, and define the corresponding short names to use in the figure.
mappingServicesToPlot <- list("NetAffx_Q"="AffQ","DAVID_Q"="DQ","EnVision_Q"="EnV");
# Plot correlation probability distributions by match group
boxplotResult_correlation = jointUniquePairs$corr.boxplot(
  corr, idMapNames=mappingServicesToPlot, subsetting=TRUE,
  srt=35, col.points="green");
# The following extracts the correlations for the group of ID pairs 
# reported by DQ and EnV but not by AffQ.
boxplotResult_correlation$response.grouped$`!AffQ & DQ & EnV`

# Plot posterior second component probability distributions by match group
boxplotResult_mixtureProb = jointUniquePairs$mixture.boxplot(
  corr, idMapNames=mappingServicesToPlot, subsetting=TRUE, 
  plot.G=2, srt=35, col.points="green");
# invisible by default.
boxplotResult_mixtureProb$response.grouped$`!AffQ & DQ & EnV`


###################################################
### code chunk number 20: chunk18 (eval = FALSE)
###################################################
## # plot the results of mixture fit interactively choosing the DB subset
##  interactive.mixture.plot(jointUniquePairs,corr,verbose=FALSE);


###################################################
### code chunk number 21: chunkCOMPARE
###################################################
# Perform regression analysis relating which mapping services predict good correlations.

fit<-jointUniquePairs$do.glm(corr$getData(),
       idMapNames=c("DAVID_Q","EnVision_Q","NetAffx_Q"));
coefficients(summary(fit));

# Perform regression analysis using the second mixture component as the outcome variable.
qualityMeasure <- mixture$getData(G=2) ## 2nd component posterior probability
fitLinear <- jointUniquePairs$do.glm(qualityMeasure,
      idMapNames=c("DAVID_Q","EnVision_Q","NetAffx_Q")); 
coefficients(summary(fitLinear));
#To do this directly:
fitLinear <- with(as.data.frame(jointUniquePairs),
      glm(qualityMeasure ~ DAVID_Q + EnVision_Q + NetAffx_Q))
coefficients(summary(fitLinear));
# Another variation:
fitHitCount <- with(as.data.frame(jointUniquePairs),
      glm(qualityMeasure ~ I(DAVID_Q + EnVision_Q + NetAffx_Q)))
coefficients(summary(fitHitCount));
fitHitCount$dev - fitLinear$dev


###################################################
### code chunk number 22: chunkBootstrap
###################################################

bootstrap<-Bootstrap(corrData,Fisher=TRUE,verbose=FALSE);
str(as.data.frame(bootstrap))
# Scatterplot of the estimated standard deviation versus the observed correlation.
bootstrap$plot(new.plot=TRUE,file.copy=TRUE,copy.zoom=2,bg="white");
# One can use these estimates as weights. 
fitLinear <- with(as.data.frame(jointUniquePairs),
      glm(qualityMeasure ~ DAVID_Q + EnVision_Q + NetAffx_Q,
         weights=(as.data.frame(bootstrap)$sd) ^ (-2))
)
coefficients(summary(fitLinear));
# Another variation:
fitHitCount <- with(as.data.frame(jointUniquePairs),
      glm(qualityMeasure ~ I(DAVID_Q + EnVision_Q + NetAffx_Q),
         weights=(as.data.frame(bootstrap)$sd) ^ (-2))
)
coefficients(summary(fitHitCount));
fitHitCount$dev - fitLinear$dev


###################################################
### code chunk number 23: chunkTWOSAMPLE
###################################################
affyOnly = boxplotResult_mixtureProb$response.grouped$`AffQ & !DQ & !EnV`
envOnly = boxplotResult_mixtureProb$response.grouped$`!AffQ & !DQ & EnV`
davidOnly = boxplotResult_mixtureProb$response.grouped$`!AffQ & DQ & !EnV`
allThree = boxplotResult_mixtureProb$response.grouped$`AffQ & DQ & EnV`
t.test(affyOnly, envOnly)
wilcox.test(affyOnly, envOnly)
t.test(affyOnly, davidOnly)
wilcox.test(affyOnly, envOnly)
t.test(affyOnly, allThree)
wilcox.test(affyOnly, allThree)


###################################################
### code chunk number 24: chunkDeleteMe
###################################################
head(jointUniquePairs$as.data.frame() )
pairs <- jointUniquePairs$as.data.frame()
pairsNotReportedByNetAffx = pairs[
  (!pairs$NetAffx_Q & (pairs$DAVID_Q | pairs$EnVision_Q))  
  , c("Uniprot", "Affy")]
head(pairsNotReportedByNetAffx)


###################################################
### code chunk number 25: sessionInfo
###################################################
toLatex(sessionInfo())


