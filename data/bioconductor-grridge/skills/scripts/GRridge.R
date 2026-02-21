# Code example from 'GRridge' vignette. See references/ for full tutorial.

### R code from vignette source 'GRridge.Rnw'

###################################################
### code chunk number 1: GRridge.Rnw:89-90
###################################################
library(GRridge)


###################################################
### code chunk number 2: GRridge.Rnw:95-96
###################################################
data(dataFarkas)


###################################################
### code chunk number 3: GRridge.Rnw:111-112
###################################################
firstPartition <- CreatePartition(CpGannFarkas)


###################################################
### code chunk number 4: GRridge.Rnw:119-122
###################################################
sdsF <- apply(datcenFarkas,1,sd)
secondPartition <- CreatePartition(sdsF,decreasing=FALSE,
                                   uniform=TRUE,grsize=5000)


###################################################
### code chunk number 5: GRridge.Rnw:127-128
###################################################
partitionsFarkas <- list(cpg=firstPartition,sds=secondPartition)


###################################################
### code chunk number 6: GRridge.Rnw:133-134
###################################################
monotoneFarkas <- c(FALSE,TRUE)


###################################################
### code chunk number 7: GRridge.Rnw:144-146 (eval = FALSE)
###################################################
## grFarkas <- grridge(datcenFarkas, respFarkas, partitionsFarkas, 
##                    optl=5.680087, monotone= monotoneFarkas)


###################################################
### code chunk number 8: GRridge.Rnw:151-152 (eval = FALSE)
###################################################
## grFarkas$lambdamults


###################################################
### code chunk number 9: GRridge.Rnw:158-160 (eval = FALSE)
###################################################
## grFarkasCV <- grridgeCV(grFarkas, datcenFarkas, 
##                          respFarkas, outerfold=10)


###################################################
### code chunk number 10: GRridge.Rnw:165-175 (eval = FALSE)
###################################################
## cutoffs <- rev(seq(0,1,by=0.01))
## rocridgeF <- roc(probs=grFarkasCV[,2],
##                  true=grFarkasCV[,1],cutoffs=cutoffs)
## rocgrridgeF <- roc(probs=grFarkasCV[,3],
##                    true=grFarkasCV[,1],cutoffs=cutoffs)
## plot(rocridgeF[1,],rocridgeF[2,],type="l",lty=1,ann=FALSE,col="grey")
## points(rocgrridgeF[1,],rocgrridgeF[2,],type="l",lty=1,col="black")
## legend(0.6,0.3, legend=c("ridge","GRridge"),
##        lty=c(1,1), lwd=c(1,1),col=c("grey","black"))
## 


###################################################
### code chunk number 11: GRridge.Rnw:184-185
###################################################
library(GRridge)


###################################################
### code chunk number 12: GRridge.Rnw:190-191
###################################################
data(dataWurdinger)


###################################################
### code chunk number 13: GRridge.Rnw:209-219
###################################################

# Transform the data set to the square root scale
dataSqrtWurdinger <- sqrt(datWurdinger_BC)
#
#Standardize the transformed data
datStdWurdinger <- t(apply(dataSqrtWurdinger,1,
                           function(x){(x-mean(x))/sd(x)}))
#
# A list of gene names in the primary RNAseq data
genesWurdinger <- as.character(annotationWurdinger$geneSymbol)


###################################################
### code chunk number 14: GRridge.Rnw:231-232 (eval = FALSE)
###################################################
## gseTF <- matchGeneSets(genesWurdinger,TFsym,minlen=25,remain=TRUE)


###################################################
### code chunk number 15: GRridge.Rnw:244-246 (eval = FALSE)
###################################################
## gseTF_newGroups <- mergeGroups(highdimdata= datStdWurdinger, 
##                                initGroups=gseTF, maxGroups=5)


###################################################
### code chunk number 16: GRridge.Rnw:251-252 (eval = FALSE)
###################################################
## gseTF2 <- gseTF_newGroups$newGroups


###################################################
### code chunk number 17: GRridge.Rnw:260-261 (eval = FALSE)
###################################################
## newClustMembers <- gseTF_newGroups$newGroupMembers


###################################################
### code chunk number 18: GRridge.Rnw:273-275
###################################################
immunPathway <- coDataWurdinger$immunologicPathway
parImmun <- immunPathway$newClust


###################################################
### code chunk number 19: GRridge.Rnw:278-288
###################################################
plateletsExprGenes <- coDataWurdinger$plateletgenes
# Group genes in the primary data based on the list
# The genes are grouped into
# either "NormalGenes" or "Non-overlapGenes"
is <- intersect(plateletsExprGenes,genesWurdinger)
im <- match(is, genesWurdinger)
plateletsGenes <- replicate(length(genesWurdinger),"Non-overlapGenes")
plateletsGenes[im] <- "NormalGenes"
plateletsGenes <- as.factor(plateletsGenes)
parPlateletGenes <- CreatePartition(plateletsGenes)


###################################################
### code chunk number 20: GRridge.Rnw:291-298
###################################################
ChromosomeWur0 <- as.vector(annotationWurdinger$chromosome)
ChromosomeWur <- ChromosomeWur0
idC <- which(ChromosomeWur0=="MT" | ChromosomeWur0=="notBiomart" |
               ChromosomeWur0=="Un")
ChromosomeWur[idC] <- "notMapped"
table(ChromosomeWur)
parChromosome <- CreatePartition(as.factor(ChromosomeWur))


###################################################
### code chunk number 21: GRridge.Rnw:305-308
###################################################
partitionsWurdinger <- list(immunPathway=parImmun,
                            plateletsGenes=parPlateletGenes,
                            chromosome=parChromosome)


###################################################
### code chunk number 22: GRridge.Rnw:313-314
###################################################
monotoneWurdinger <- c(FALSE,FALSE,FALSE)


###################################################
### code chunk number 23: GRridge.Rnw:320-324 (eval = FALSE)
###################################################
## optPartitions <- PartitionsSelection(datStdWurdinger, respWurdinger, 
##                                      partitions=partitionsWurdinger,
##                                      monotoneFunctions=monotoneWurdinger,
##                                      optl=160.527)


###################################################
### code chunk number 24: GRridge.Rnw:333-345 (eval = FALSE)
###################################################
## # To reduce the computational time, we may use the optimum lambda2 
## # (global lambda penalty) in the GRridge predictive modeling, 
## # optl=optPartitions$optl
## # GRridge model by incorporating the selected partitions
## partitionsWurdinger_update = partitionsWurdinger[optPartitions$ordPar]
## monotoneWurdinger_update = monotoneWurdinger[optPartitions$ordPar]
## grWurdinger <- grridge(datStdWurdinger,respWurdinger,
##                        partitions=partitionsWurdinger_update, 
##                        monotone= monotoneWurdinger_update, 
##                        innfold = 3,comparelasso=TRUE, 
##                        optl=optPartitions$optl, selectionEN=TRUE, 
##                        maxsel=10)


###################################################
### code chunk number 25: GRridge.Rnw:353-355 (eval = FALSE)
###################################################
## grWurdingerCV <- grridgeCV(grWurdinger, datStdWurdinger, 
##                             respWurdinger, outerfold=10)


###################################################
### code chunk number 26: GRridge.Rnw:360-375 (eval = FALSE)
###################################################
## cutoffs <- rev(seq(0,1,by=0.01))
## rocridge <- roc(probs= grWurdingerCV[,2],
##                 true= grWurdingerCV[,1],cutoffs)
## rocGRridge <- roc(probs= grWurdingerCV[,3],
##                   true= grWurdingerCV[,1],cutoffs)
## rocLasso <- roc(probs= grWurdingerCV[,4],
##                 true= grWurdingerCV[,1],cutoffs)
## rocGRridgeEN <- roc(probs= grWurdingerCV[,5],
##                     true= grWurdingerCV[,1],cutoffs)
## plot(rocridge[1,],rocridge[2,],type="l",lty=2,ann=FALSE,col="grey")
## points(rocGRridge[1,],rocGRridge[2,],type="l",lty=1,col="black")
## points(rocLasso[1,],rocLasso[2,],type="l",lty=1,col="blue")
## points(rocGRridgeEN[1,],rocGRridgeEN[2,],type="l",lty=1,col="green")
## legend(0.6,0.35, legend=c("ridge","GRridge", "lasso","GRridge+varsel"),
##        lty=c(1,1), lwd=c(1,1),col=c("grey","black","blue","green"))


