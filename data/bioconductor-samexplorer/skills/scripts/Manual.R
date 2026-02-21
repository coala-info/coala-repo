# Code example from 'Manual' vignette. See references/ for full tutorial.

### R code from vignette source 'Manual.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: preliminaries
###################################################
library(samExploreR)



###################################################
### code chunk number 3: install-library (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("samExploreR")


###################################################
### code chunk number 4: install-library (eval = FALSE)
###################################################
##  BiocManager::install(c("BiocCheck", "BiocGenerics", "RUnit"))


###################################################
### code chunk number 5: Run-samExplore
###################################################
  library(samExploreR)

 ## perform subsampling
inpf <- RNAseqData.HNRNPC.bam.chr14_BAMFILES

x <- samExplore(files=inpf,annot.inbuilt="hg19", subsample_d = 0.8)


###################################################
### code chunk number 6: Run-samExplore
###################################################
 # Loading library
 library(samExploreR)

 # Performing subsampling

 inpf <- RNAseqData.HNRNPC.bam.chr14_BAMFILES

 # Performing robustness analysis for f = 0.7, number of replicates 5, 
 #annotation entries 'gene', non-paired reads
 x <- samExplore(files=inpf,annot.inbuilt="hg19",GTF.featureType="exon",
 GTF.attrType="gene_id", subsample_d = 0.8, N_boot=5)

 # Performing robustness analysis for f = 0.1, number of replicates 10, 
 #annotation entries 'exon', paired reads
 x <- samExplore(files=inpf,annot.inbuilt="hg19",GTF.featureType="gene",
 GTF.attrType="gene_id", subsample_d = 0.8, N_boot=5)


###################################################
### code chunk number 7: Manual.Rnw:155-157
###################################################
data(df_sole)
head(df_sole)


###################################################
### code chunk number 8: Manual.Rnw:169-174
###################################################
#Loading library
library(samExploreR)
data("df_sole")
 #Performing robustness analysis
exploreRob(df_sole, lbl = 'New, Gene', f_vect = c(0.85, 0.9, 0.95))


###################################################
### code chunk number 9: Manual.Rnw:210-216
###################################################
#Loading library
library(samExploreR)
data("df_sole")
 #Performing robustness analysis
 t = exploreRep(df_sole, lbl_vect = c('New, Gene', 'Old, Gene', 'New, Exon'), f = 0.9)



###################################################
### code chunk number 10: plotunif
###################################################

require(samExploreR)
########## Loading the example data
data("df_sole")
data("df_intersect")
head(df_sole)
#head(df_intersect)


###################################################
### code chunk number 11: fig1
###################################################
### Generation of the plot:
require(samExploreR)
data("df_sole")
plotsamExplorer(df_sole,p.depth=.9,font.size=4, anova=FALSE,save=FALSE)


###################################################
### code chunk number 12: fig2
###################################################
###Generation of the plot:
require(samExploreR)
data("df_intersect")
plotsamExplorer(df_intersect,font.size=3, anova=FALSE,save=FALSE)


###################################################
### code chunk number 13: Manual.Rnw:277-278
###################################################
sessionInfo()


