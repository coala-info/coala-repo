# Code example from 'yarn' vignette. See references/ for full tutorial.

## ----echo=FALSE,include=FALSE-------------------------------------------------
library(yarn)
data(skin)

## -----------------------------------------------------------------------------
skin

## ----checkMisAnnotation-------------------------------------------------------
checkMisAnnotation(skin,"GENDER",controlGenes="Y",legendPosition="topleft")

## ----checkTissuesToMerge------------------------------------------------------
checkTissuesToMerge(skin,"SMTS","SMTSD")

## ----filterGenes--------------------------------------------------------------
skin_filtered = filterLowGenes(skin,"SMTSD")
dim(skin)
dim(skin_filtered)

## ----filter-------------------------------------------------------------------
tmp = filterGenes(skin,labels=c("X","Y","MT"),featureName = "chromosome_name")
# Keep only the sex names
tmp = filterGenes(skin,labels=c("X","Y","MT"),featureName = "chromosome_name",keepOnly=TRUE)

## ----density------------------------------------------------------------------
plotDensity(skin_filtered,"SMTSD",main=expression('log'[2]*' raw expression'))
skin_filtered = normalizeTissueAware(skin_filtered,"SMTSD")
plotDensity(skin_filtered,"SMTSD",normalized=TRUE,main="Normalized")

## -----------------------------------------------------------------------------
data(skin)
res = plotCMDS(skin,pch=21,bg=factor(pData(skin)$SMTSD))

## -----------------------------------------------------------------------------
filtData = filterLowGenes(skin,"SMTSD")
plotDensity(filtData,groups="SMTSD",legendPos="topleft")

## -----------------------------------------------------------------------------
library(RColorBrewer)
tissues = pData(skin)$SMTSD
heatmapColColors=brewer.pal(12,"Set3")[as.integer(factor(tissues))]
heatmapCols = colorRampPalette(brewer.pal(9, "RdBu"))(50)
plotHeatmap(skin,normalized=FALSE,log=TRUE,trace="none",n=10,
 col = heatmapCols,ColSideColors = heatmapColColors,cexRow = 0.25,cexCol = 0.25)

## -----------------------------------------------------------------------------
sessionInfo()

