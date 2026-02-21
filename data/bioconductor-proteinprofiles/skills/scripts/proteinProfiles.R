# Code example from 'proteinProfiles' vignette. See references/ for full tutorial.

### R code from vignette source 'proteinProfiles.Rnw'

###################################################
### code chunk number 1: proteinProfiles.Rnw:15-16
###################################################
  if(exists(".orig.enc")) options(encoding = .orig.enc)


###################################################
### code chunk number 2: settings
###################################################
set.seed(1)
options(width=65)


###################################################
### code chunk number 3: load_package
###################################################
library(proteinProfiles)


###################################################
### code chunk number 4: install_package (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("proteinProfiles")


###################################################
### code chunk number 5: getting_help (eval = FALSE)
###################################################
## vignette(package="proteinProfiles")
## vignette("proteinProfiles")
## ?profileDistance


###################################################
### code chunk number 6: load_dataset
###################################################
data(ips_sample)
ls()


###################################################
### code chunk number 7: explore_ratios
###################################################
head(ratios)


###################################################
### code chunk number 8: explore_annotation
###################################################
colnames(annotation)


###################################################
### code chunk number 9: remove_na
###################################################
ratios_filtered <- filterFeatures(ratios, 0.3, verbose=TRUE)


###################################################
### code chunk number 10: grep_anno_protein_name
###################################################
names(annotation)
index_28S <- grepAnnotation(annotation, pattern="^28S", column="Protein.Name")
index_28S


###################################################
### code chunk number 11: grep_anno_ribosome_kegg
###################################################
index_ribosome <- grepAnnotation(annotation, "Ribosome", "KEGG")
index_ribosome


###################################################
### code chunk number 12: profile_1
###################################################
z1 <- profileDistance(ratios, index_28S)
z1$d0
z1$p.value
plotProfileDistance(z1)


###################################################
### code chunk number 13: profile_2
###################################################
z2 <- profileDistance(ratios, index_ribosome, nSample=2000)
plotProfileDistance(z2)


###################################################
### code chunk number 14: sessionInfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


