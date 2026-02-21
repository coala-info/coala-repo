# Code example from 'rSWeeP' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(rSWeeP)
path = paste (system.file("examples/aaMitochondrial/",package = "rSWeeP"),'/', sep = '')
sw = SWeePlite(path,seqtype='AA',mask=c(4),psz=1000)

## -----------------------------------------------------------------------------
sw$info

## ----plot Tree1, fig.height=10,fig.width=10-----------------------------------
library(ape)

# get the distance matrix
mdist = dist(sw$proj,method='euclidean')

# use the NJ algorithm to build the tree
tr = nj(mdist)
# root the tree in the plant sample
tr = root(tr,outgroup='14_Rhazya_stricta')

# plot
plot(tr)

## -----------------------------------------------------------------------------
pathmetadata <- system.file(package = "rSWeeP" , "examples" , "metadata_mitochondrial.csv")
mt = read.csv(pathmetadata,header=TRUE)

## ----eval tree----------------------------------------------------------------
data = data.frame(sp=mt$fileName,family=mt$family) 

PCCI(tr,data) # PhyloTaxonomic Consistency Cophenetic Index
PMPG(tr,data) # Percentage of Mono or Paraphyletic Groups

## ----PCA, fig.height=7,fig.width=9--------------------------------------------
pca_output <- prcomp (sw$proj , scale = FALSE)
par(mfrow=c(1,2))
plot(pca_output$x[,1],pca_output$x[,2],xlab = 'PC-1' , ylab = 'PC-2' , pch =20 , col = mt$id)
legend("bottomright",unique(mt$family),col=as.character(c(1:length(unique(mt$family)))),pch=20)
plot(pca_output$x[,3],pca_output$x[,4],xlab = 'PC-3' , ylab = 'PC-4' , pch =20 , col = mt$id)

## ----label='Session information', eval=TRUE, echo=FALSE-----------------------
sessionInfo()

