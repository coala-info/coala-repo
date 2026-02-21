# Code example from 'npGSEA' vignette. See references/ for full tutorial.

### R code from vignette source 'npGSEA.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: loadLibrariesAndData
###################################################
library(ALL)
library(hgu95av2.db)
library(genefilter)
library(limma)
library(GSEABase)
library(npGSEA)

data(ALL)

ALL <- ALL[, ALL$mol.biol %in% c('NEG','BCR/ABL') &
     !is.na(ALL$sex)]
ALL$mol.biol <- factor(ALL$mol.biol, 
     levels = c('NEG', 'BCR/ABL'))
ALL <- featureFilter(ALL)


###################################################
### code chunk number 3: adjustNames
###################################################
featureNames(ALL) <- select(hgu95av2.db, featureNames(ALL), 
                            "ENTREZID", "PROBEID")$ENTREZID


###################################################
### code chunk number 4: MakeSets
###################################################
xData <- exprs(ALL)
geneEids <- rownames(xData)
set.seed(12345)
set1 <- GeneSet(geneIds=sample(geneEids,15, replace=FALSE), 
             setName="set1", 
             shortDescription="This is set1")
set2 <- GeneSet(geneIds=sample(geneEids,50, replace=FALSE), 
             setName="set2",  
             shortDescription="This is set2")
set3 <- GeneSet(geneIds=sample(geneEids,100, replace=FALSE), 
             setName="set3",  
             shortDescription="This is set3")
set4 <- GeneSet(geneIds=sample(geneEids,500, replace=FALSE), 
            setName="set4",  
            shortDescription="This is set4")


###################################################
### code chunk number 5: RunLimma2NewSets
###################################################
model <- model.matrix(~mol.biol, ALL)
fit  <-  eBayes(lmFit(ALL, model))
tt <- topTable(fit, coef=2, n=200)
ttUp <- tt[which(tt$logFC >0), ]
ttDown <- tt[which(tt$logFC <0), ]

set5 <- GeneSet(geneIds=rownames(ttUp)[1:20], 
        setName="set5",  
        shortDescription="This is a true set of the top 20 DE 
        genes with a positive fold change")
set6 <- GeneSet(geneIds=rownames(ttDown)[1:20], 
        setName="set6",  
        shortDescription="This is a true set of the top 20 DE genes 
        with a negative fold change")
set7 <- GeneSet(geneIds=c(rownames(ttUp)[1:10], rownames(ttDown)[1:10]), 
        setName="set7",  
        shortDescription="This is a true set of the top 10 DE genes 
        with a positive and a negative fold change")


###################################################
### code chunk number 6: GSC
###################################################
gsc <- GeneSetCollection( c(set1, set2, set3, set4, set5, set6, set7) )
gsc


###################################################
### code chunk number 7: runIt
###################################################
yFactor <- ALL$mol.biol
res1 <- npGSEA(x = ALL, y = yFactor, set = set1)  ##with the eset
res1

res2_exprs <- npGSEA(xData, ALL$mol.biol, gsc[[2]])  ##with the expression data
res2_exprs 


###################################################
### code chunk number 8: accessorFunctions
###################################################
res3 <- npGSEA(ALL, yFactor, set3)  
res3
geneSetName(res3)
stat(res3)
sigmaSq(res3)
zStat(res3)
pTwoSided(res3)
pLeft(res3)
pValues(res3)
dim(xSet(res3))


###################################################
### code chunk number 9: plot3
###################################################
npGSEAPlot(res3)


###################################################
### code chunk number 10: runItNorm
###################################################
res5_norm <- npGSEA(ALL, yFactor, set5, approx= "norm")  
res5_norm
betaHats(res5_norm)
npGSEAPlot(res5_norm)


###################################################
### code chunk number 11: runItBeta
###################################################
res5_beta <- npGSEA(ALL, yFactor, set5, approx= "beta")
res5_beta
betaHats(res5_beta)
npGSEAPlot(res5_beta)


###################################################
### code chunk number 12: runItChiSq
###################################################
res5_chiSq <- npGSEA(ALL, yFactor, set5, approx= "chiSq")  
res5_chiSq
betaHats(res5_chiSq)
chiSqStat(res5_chiSq)
stat(res5_chiSq)
stat(res5_chiSq)/sigmaSq(res5_chiSq)
npGSEAPlot(res5_chiSq)


###################################################
### code chunk number 13: runItwts
###################################################
res7_nowts <- npGSEA(x = ALL, y= yFactor, set = set7)  
res7_nowts

wts <- apply(exprs(ALL)[match(geneIds(set7), featureNames(ALL)), ], 
						1, var)	
wts <- 1/wts				
res7_wts <- npGSEA(x = ALL, y = yFactor, set = set7,  w = wts, approx= "norm")  
res7_wts						


###################################################
### code chunk number 14: addCovariates
###################################################
res3_age <- npGSEA(x = ALL, y = yFactor, set = set3, covars = ALL$age) 
res3_age

res3_agesex <- npGSEA(x = ALL, y = yFactor, set = set3, covars = cbind(ALL$age, ALL$sex)) 
res3_agesex


###################################################
### code chunk number 15: runMultiplenpGSEA
###################################################
resgsc_norm <- npGSEA(x = ALL, y = yFactor, set = gsc)  
unlist( pLeft(resgsc_norm) )
unlist( stat (resgsc_norm) )
unlist( zStat (resgsc_norm) )


###################################################
### code chunk number 16: publishMultiplenpGSEA (eval = FALSE)
###################################################
## pvals <- p.adjust( unlist(pTwoSided(resgsc_norm)), method= "BH" )
## library(ReportingTools)
## npgseaReport <- HTMLReport (shortName = "npGSEA",
##         title = "npGSEA Results", reportDirectory = "./reports")
## publish(gsc, npgseaReport, annotation.db = "org.Hs.eg",
##         setStats = unlist(zStat (resgsc_norm)), setPValues = pvals)
## finish(npgseaReport)


###################################################
### code chunk number 17: sessInfo
###################################################
toLatex(sessionInfo())


###################################################
### code chunk number 18: resetOptions
###################################################
options(prompt="> ", continue="+ ")


