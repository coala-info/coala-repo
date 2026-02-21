# Code example from 'geneAnswers' vignette. See references/ for full tutorial.

### R code from vignette source 'geneAnswers.Rnw'

###################################################
### code chunk number 1: load library
###################################################
library(GeneAnswers)


###################################################
### code chunk number 2: build GeneAnswers
###################################################
data('humanGeneInput')
data('humanExpr')
## build a GeneAnswers instance with statistical test based on biological process of GO and saved example data.
x <- geneAnswersBuilder(humanGeneInput, 'org.Hs.eg.db', categoryType='GO.BP', testType='hyperG',  pvalueT=0.1, FDR.correction=TRUE, geneExpressionProfile=humanExpr)
class(x)
## build a GeneAnswers instance with statistical test based on KEGG and saved example data. 
y <- geneAnswersBuilder(humanGeneInput, 'org.Hs.eg.db', categoryType='KEGG', testType='hyperG', pvalueT=0.1, geneExpressionProfile=humanExpr, verbose=FALSE)
## build a GeneAnswers instance with statistical test based on DOLite and saved example data.
z <- geneAnswersBuilder(humanGeneInput, 'org.Hs.eg.db', categoryType='DOLITE', testType='hyperG', pvalueT=0.1, geneExpressionProfile=humanExpr, verbose=FALSE)
w <- geneAnswersBuilder(humanGeneInput, 'org.Hs.eg.db', categoryType='GO.BP', testType='hyperG', pvalueT=0.1, FDR.correction=TRUE, geneExpressionProfile=humanExpr, level=2, verbose=FALSE) 


###################################################
### code chunk number 3: build customized GeneAnswers
###################################################
## before running the following codes, make sure that you can connect the internet.
##keywordsList <- list(Apoptosis=c('apoptosis'), CellAdhesion=c('cell adhesion'))
##entrezIDList <- searchEntrez(keywordsList) 
##q <- geneAnswersBuilder(humanGeneInput, entrezIDList, testType='hyperG', totalGeneNumber = 45384, pvalueT=0.1, geneExpressionProfile=humanExpr, verbose=FALSE)
##class(q)
##getAnnLib(q)
##getCategoryType(q)


###################################################
### code chunk number 4: make GeneAnswers readable and generate concept-gene network
###################################################
## mapping gene IDs and category IDs to gene symbols and category terms
xx <- geneAnswersReadable(x)
yy <- geneAnswersReadable(y, verbose=FALSE)
zz <- geneAnswersReadable(z, verbose=FALSE)
ww <- geneAnswersReadable(w, verbose=FALSE)
## before running the following codes, make sure that you can connect the internet.
##q <- setAnnLib(q, 'org.Hs.eg.db')
##qq <- geneAnswersReadable(q, catTerm=FALSE) 


###################################################
### code chunk number 5: plot barplot and / or piechart (eval = FALSE)
###################################################
## ## plot barplot and / or piechart
## geneAnswersChartPlots(xx, chartType='all')


###################################################
### code chunk number 6: plot interactive  concept-gene network (eval = FALSE)
###################################################
## ## plot interactive concept-gene network
## geneAnswersConceptNet(xx, colorValueColumn='foldChange', centroidSize='pvalue', output='interactive')


###################################################
### code chunk number 7: plot interactive  go structure network (eval = FALSE)
###################################################
## ## plot interactive go structure network
## geneAnswersConceptRelation(x, direction='both', netMode='connection', catTerm=TRUE, catID=TRUE, nameLength=15) 


###################################################
### code chunk number 8: plot interactive  concept-gene network with gene interaction (eval = FALSE)
###################################################
## ## plot interactive concept-gene network
## geneAnswersConceptNet(x, color='foldChange', geneLayer=5, output='interactive', showCats=c("GO:0009611", "GO:0043933", "GO:0045622"), catTerm=TRUE, geneSymbol=TRUE, catID=TRUE)


###################################################
### code chunk number 9: plot Gene interaction (eval = FALSE)
###################################################
## ## plot the given gene interaction
## buildNet(c('444','3638', '5087','55835'), idType='GeneInteraction', layers=2, filterGraphIDs=getGeneInput(x)[,1], filterLayer=2, netMode='connection')


###################################################
### code chunk number 10: plot Gene interaction with expression information (eval = FALSE)
###################################################
## ## plot the given gene interaction
## buildNet(c('444','3638', '5087','55835'), idType='GeneInteraction', layers=2, filterGraphIDs=getGeneInput(x)[,1:2], filterLayer=2, netMode='connection')


###################################################
### code chunk number 11: plot Gene interaction with pvalues (eval = FALSE)
###################################################
## ## plot the given gene interaction
## buildNet(c('444','3638', '5087','55835'), idType='GeneInteraction', layers=2, filterGraphIDs=cbind(getGeneInput(x)[,1], -log2(getGeneInput(x)[,3])), filterLayer=2, netMode='connection')


###################################################
### code chunk number 12: plot Gene interaction for all of given genes (eval = FALSE)
###################################################
## ## plot the given gene interaction
## buildNet(getGeneInput(x)[,1], idType='GeneInteraction', layers=2, filterGraphIDs=getGeneInput(x)[,1:2], filterLayer=2, netMode='connection')


###################################################
### code chunk number 13: plot Go-concept network for 2 level nodes removal (eval = FALSE)
###################################################
## ## plot Go-concept network for 2 level nodes removal
## geneAnswersConceptNet(ww, colorValueColumn='foldChange', centroidSize='pvalue', output='fixed')


###################################################
### code chunk number 14: sort GeneAnswers
###################################################
## sort enrichmentInfo dataframe by fdr adjusted p value
xxx <- geneAnswersSort(xx, sortBy='correctedPvalue')
yyy <- geneAnswersSort(yy, sortBy='pvalue') 
zzz <- geneAnswersSort(zz, sortBy='geneNum')


###################################################
### code chunk number 15: plot concept-gene networks (eval = FALSE)
###################################################
## geneAnswersConceptNet(yyy, colorValueColumn='foldChange', centroidSize='geneNum', output='fixed')
## geneAnswersConceptNet(zzz, colorValueColumn='foldChange', centroidSize='pvalue', output='fixed', showCats=c(10:16))


###################################################
### code chunk number 16: generate GO-gene cross tabulation (eval = FALSE)
###################################################
## ## generate GO-gene cross tabulation
## geneAnswersHeatmap(x, catTerm=TRUE, geneSymbol=TRUE)


###################################################
### code chunk number 17: geneAnswers.Rnw:335-337
###################################################
## generate GO-gene cross tabulation
geneAnswersHeatmap(x, catTerm=TRUE, geneSymbol=TRUE)


###################################################
### code chunk number 18: geneAnswers.Rnw:343-344 (eval = FALSE)
###################################################
## geneAnswersHeatmap(yyy)


###################################################
### code chunk number 19: geneAnswers.Rnw:349-350
###################################################
geneAnswersHeatmap(yyy)


###################################################
### code chunk number 20: generate DOLite-gene cross tabulation (eval = FALSE)
###################################################
## geneAnswersHeatmap(zzz, mapType='heatmap')


###################################################
### code chunk number 21: geneAnswers.Rnw:364-365
###################################################
geneAnswersHeatmap(zzz, mapType='heatmap')


###################################################
### code chunk number 22: plot customized concept-gene cross tabulation
###################################################
GOBPIDs <- c("GO:0043627", "GO:0042493", "GO:0006259", "GO:0007243")
GOBPTerms <- c("response to estrogen stimulus", "response to drug", "protein kinase cascade", "DNA metabolic process")


###################################################
### code chunk number 23: generate concept-gene cross tabulation (eval = FALSE)
###################################################
## ## generate concept-gene cross tabulation
## geneAnswersConceptNet(x, colorValueColumn='foldChange', centroidSize='pvalue', output='fixed', showCats=GOBPIDs, catTerm=TRUE, geneSymbol=TRUE) 


###################################################
### code chunk number 24: generate customized concept-gene cross tabulation (eval = FALSE)
###################################################
## geneAnswersHeatmap(x, showCats=GOBPIDs, catTerm=TRUE, geneSymbol=TRUE)


###################################################
### code chunk number 25: geneAnswers.Rnw:398-399
###################################################
geneAnswersHeatmap(x, showCats=GOBPIDs, catTerm=TRUE, geneSymbol=TRUE)


###################################################
### code chunk number 26: generate concept-gene cross tabulation (eval = FALSE)
###################################################
## ## generate concept-gene cross tabulation
## geneAnswersConcepts(xxx, centroidSize='geneNum', output='fixed', showCats=GOBPTerms) 


###################################################
### code chunk number 27: print top categories and genes
###################################################
## print top GO categories sorted by hypergeometric test p value
topGOGenes(x,  orderby='pvalue')
## print top KEGG categories sorted by gene numbers and sort genes by fold changes 
topPATHGenes(y, orderby='geneNum', top=4, topGenes=8, genesOrderBy='foldChange')
## print and save top 10 DOLites information 
topDOLITEGenes(z, orderby='pvalue', top=5, topGenes='ALL', genesOrderBy='pValue', file=TRUE)


###################################################
### code chunk number 28: multigroup gene analysis
###################################################
##load multigroup genes sample data
data(sampleGroupsData)
##Build a GeneAnswers List
gAKEGGL <- lapply(sampleGroupsData, geneAnswersBuilder, 'org.Hs.eg.db', categoryType='KEGG', pvalueT=0.01, verbose=FALSE)
##Output integrated text table
output<- getConceptTable(gAKEGGL, items='geneNum')


###################################################
### code chunk number 29: multigroup genes KEGG analysis (eval = FALSE)
###################################################
## drawTable(output[[1]], matrixOfHeatmap=output[[2]], mar=c(2,28,3,2), clusterTable=NULL) 


###################################################
### code chunk number 30: homogene conversation
###################################################
 ## load mouse example data
data('mouseExpr')
data('mouseGeneInput') 
mouseExpr[1:10,]
mouseGeneInput[1:10,]
 ## only keep first one for one to more mapping
pickHomo <- function(element, inputV) {return(names(inputV[inputV == element])[1])}
 ## mapping geneInput to homo entrez IDs.
homoLL <- getHomoGeneIDs(mouseGeneInput[,1], species='mouse', speciesL='human', mappingMethod='direct')
newGeneInput <- mouseGeneInput[mouseGeneInput[,1] %in% unlist(lapply(unique(homoLL), pickHomo, homoLL)),]
dim(mouseGeneInput)
dim(newGeneInput)
newGeneInput[,1] <- homoLL[newGeneInput[,1]]
## mapping geneExpr to homo entrez IDs.
homoLLExpr <- getHomoGeneIDs(as.character(mouseExpr[,1]), species='mouse', speciesL='human', mappingMethod='direct')
newExpr <- mouseExpr[as.character(mouseExpr[,1]) %in% unlist(lapply(unique(homoLLExpr) , pickHomo, homoLLExpr)),]
newExpr[,1] <- homoLLExpr[as.character(newExpr[,1])]
dim(mouseExpr)
dim(newExpr)
## build a GeneAnswers instance based on mapped data
v <- geneAnswersBuilder(newGeneInput, 'org.Hs.eg.db', categoryType='DOLITE', testType='hyperG', pvalueT=0.1, FDR.correct=TRUE, geneExpressionProfile=newExpr)
## make the GeneAnswers instance readable, only map DOLite IDs to terms
vv <- geneAnswersReadable(v, geneSymbol=F)
getAnnLib(vv)
## mapping back to mouse genes
uu <- geneAnswersHomoMapping(vv, species='human', speciesL='mouse', mappingMethod='direct')
getAnnLib(uu)
## make mapped genes readable, DOLite terms are not mapped
u <- geneAnswersReadable(uu, catTerm=FALSE)
## sort new GeneAnswers instance
u1 <- geneAnswersSort(u, sortBy='pvalue')


###################################################
### code chunk number 31: plot concept-gene network (eval = FALSE)
###################################################
## ## plot concept-gene network
## geneAnswersConceptNet(u, colorValueColumn='foldChange', centroidSize='pvalue', output='fixed')


###################################################
### code chunk number 32: generate homogene DOLite-gene cross tabulation (eval = FALSE)
###################################################
## ## plot homogene DOLite-gene cross tabulation
## geneAnswersHeatmap(u1)


###################################################
### code chunk number 33: geneAnswers.Rnw:515-517
###################################################
## plot homogene DOLite-gene cross tabulation
geneAnswersHeatmap(u1)


###################################################
### code chunk number 34: homogene conversation
###################################################
## output top information
topDOLITEGenes(u, geneSymbol=FALSE, catTerm=FALSE, orderby='pvalue', top=6, topGenes='ALL', genesOrderBy='pValue', file=TRUE)  


###################################################
### code chunk number 35: sessionInfo
###################################################
toLatex(sessionInfo())


