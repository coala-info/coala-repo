# Code example from 'gCMAP' vignette. See references/ for full tutorial.

### R code from vignette source 'gCMAP.Rnw'

###################################################
### code chunk number 1: gCMAP.Rnw:38-39
###################################################
options(warn=-1)


###################################################
### code chunk number 2: gCMAPData
###################################################
library(gCMAP)
data( gCMAPData ) ## example NChannelSet

sampleNames( gCMAPData )
channelNames( gCMAPData )


###################################################
### code chunk number 3: induceCMAPCollection
###################################################
## select all genes with z-scores > 2 or < -2
cmap <- induceCMAPCollection( gCMAPData, element="z", lower=-2, higher=2)
cmap
pData( cmap )


###################################################
### code chunk number 4: membership
###################################################
head( members( cmap ) )


###################################################
### code chunk number 5: signs
###################################################
signed( cmap )


###################################################
### code chunk number 6: subsetting
###################################################
dim( cmap )
cmap[,1] ## the first gene set


###################################################
### code chunk number 7: fisher_test
###################################################
universe <- featureNames( gCMAPData )
results <- fisher_score(cmap[,1], cmap, universe)
results


###################################################
### code chunk number 8: cmapresults
###################################################
cmapTable( results )
labels( results )
pval( results )
zscores( results )


###################################################
### code chunk number 9: fisher_multiple
###################################################
result.list <- fisher_score( cmap, cmap, universe )
class( result.list )
length( result.list )
class( result.list[[1]] )

## all pairwise adjusted p-values
sapply(result.list, function( x ) {
       padj( x )[ sampleNames( cmap )]
       })


###################################################
### code chunk number 10: sampleexpressionset
###################################################
## random score matrix
y <- matrix(rnorm(1000*6),1000,6,
            dimnames=list( featureNames( gCMAPData ), 1:6 ))

predictor <- c( rep("Control", 3), rep("Case", 3))


###################################################
### code chunk number 11: sampleexpressionset
###################################################
m <-replicate(4, {
  s <- rep(0,1000)
  s[ sample(1:1000, 20)] <-  1
  s[ sample(1:1000, 20)] <- -1
  s
  })
dimnames(m) <- list(row.names( y ),
                     paste("set", 1:4, sep=""))

## Set1 is up-regulated
y[,c(4:6)] <- y[,c(4:6)] + m[,1]*2

## create CMAPCollection
cmap <- CMAPCollection(m, signed=rep(TRUE,4))


###################################################
### code chunk number 12: gsealmScoreExample
###################################################
gsealm_score(y, cmap, predictor=predictor, nPerm=100)


###################################################
### code chunk number 13: self_contained
###################################################
mroast_score(y, cmap, predictor=predictor)


###################################################
### code chunk number 14: competitive
###################################################
camera_score(y, cmap, predictor=predictor)
romer_score(y, cmap, predictor=predictor)


###################################################
### code chunk number 15: geneSet_to_profile
###################################################
profile <- assayDataElement(gCMAPData[,1], "z") ## extract first column
head(profile)
sampleNames(cmap) ## three gene sets

gsealm_jg_score(profile, cmap)


###################################################
### code chunk number 16: geneSet_to_profile_others
###################################################
wilcox_score(profile, cmap)
connectivity_score(profile, cmap)


###################################################
### code chunk number 17: plot_example
###################################################
## create random score profile
set.seed(123)
z <- rnorm(1000)
names(z) <- paste("g", 1:1000, sep="")

## generate random incidence matrix of gene sets
n <-replicate(1000, {
  s <- rep(0,1000)
  s[ sample(1:1000, 20)] <-  1
  s[ sample(1:1000, 20)] <- -1
  s
  })
dimnames(n) <- list(names(z), paste("set",
                                    1:1000,
                                    sep=""))

## Set1 is up-regulated
z <- z + n[,1]*2

## create CMAPCollection
cmap.2 <- CMAPCollection(n, signed=rep(TRUE,1000))


###################################################
### code chunk number 18: gsealm_score_plot
###################################################
## gene-set enrichment test
res <- gsealm_jg_score(z, cmap.2)
class(res)
res


###################################################
### code chunk number 19: Defaultplot
###################################################
plot(res)


###################################################
### code chunk number 20: CMAPplots1
###################################################
sets.down <- effect( res ) < -3
plot(res)


###################################################
### code chunk number 21: geneLevelScores
###################################################
res <- gsealm_score(y, cmap, predictor=predictor, nPerm=100, keep.scores=TRUE)
res
set1.expr <- geneScores(res)[["set1"]]
head(set1.expr)


###################################################
### code chunk number 22: geneScores
###################################################
heatmap(set1.expr, scale="none", Colv=NA, labCol=predictor,
        RowSideColors=ifelse( attr(set1.expr, "sign") == "up", "red", "blue"),
        margin=c(7,5))
legend(0.35,0,legend=c("up", "down"), 
       fill=c("red", "blue"), 
       title="Annotated sign", horiz=TRUE, xpd=TRUE)


###################################################
### code chunk number 23: featureScores
###################################################
res <- featureScores(cmap, y)
class(res)
names(res)
identical( res[["set1"]], set1.expr )


###################################################
### code chunk number 24: sessionInfo
###################################################
  sessionInfo()


