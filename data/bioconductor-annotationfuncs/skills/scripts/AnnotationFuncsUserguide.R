# Code example from 'AnnotationFuncsUserguide' vignette. See references/ for full tutorial.

### R code from vignette source 'AnnotationFuncsUserguide.Rnw'

###################################################
### code chunk number 1: AnnotationFuncsUserguide.Rnw:38-42
###################################################
library(org.Bt.eg.db)
genes <- c('280705', '280706', '100327208')
symbols <- org.Bt.egSYMBOL[genes]
toTable(symbols)


###################################################
### code chunk number 2: AnnotationFuncsUserguide.Rnw:55-61
###################################################
symbols <- c('BCSE','TF','TG')
entrez <- org.Bt.egSYMBOL2EG[symbols]
entrez <- toTable(entrez)[,'gene_id']
entrez
refseq <- org.Bt.egREFSEQ[entrez]
toTable(refseq)


###################################################
### code chunk number 3: AnnotationFuncsUserguide.Rnw:71-74
###################################################
library(AnnotationFuncs)
translate(c(280705, 280706, 100327208, 123), org.Bt.egSYMBOL)
translate(c('BCSE','TF','TG'), from=org.Bt.egSYMBOL2EG, to=org.Bt.egREFSEQ)


###################################################
### code chunk number 4: AnnotationFuncsUserguide.Rnw:101-108
###################################################
library(AnnotationFuncs)
library(org.Bt.eg.db)
genes <- c(280705, 280706, 100327208)
translate(genes, org.Bt.egGENENAME)
translate(genes, org.Bt.egCHR)
translate(genes, org.Bt.egENSEMBL)
translate(genes, org.Bt.egREFSEQ, remove.missing=FALSE)


###################################################
### code chunk number 5: AnnotationFuncsUserguide.Rnw:115-118
###################################################
symbols <- c("SERPINA1","KERA","CD5")
translate(symbols, org.Bt.egSYMBOL2EG)
translate(symbols, revmap(org.Bt.egSYMBOL))


###################################################
### code chunk number 6: AnnotationFuncsUserguide.Rnw:124-129
###################################################
translate(symbols, from=org.Bt.egSYMBOL2EG, to=org.Bt.egGENENAME)
# As a curiosity, if you specify another organism, you are warned:
library(org.Hs.eg.db)
translate(symbols, from=org.Bt.egSYMBOL2EG, to=org.Hs.egGENENAME)
warnings()


###################################################
### code chunk number 7: AnnotationFuncsUserguide.Rnw:136-140
###################################################
symbols <- c("SERPINA1","KERA","CD5")
translate(symbols, org.Bt.egSYMBOL2EG, org.Bt.egREFSEQ)
translate(symbols, org.Bt.egSYMBOL2EG, org.Bt.egREFSEQ, reduce='first')
translate(symbols, org.Bt.egSYMBOL2EG, org.Bt.egREFSEQ, reduce='last')


###################################################
### code chunk number 8: AnnotationFuncsUserguide.Rnw:145-146
###################################################
translate(symbols, org.Bt.egSYMBOL2EG, org.Bt.egREFSEQ, return.list=FALSE)


###################################################
### code chunk number 9: AnnotationFuncsUserguide.Rnw:152-153
###################################################
groups <- list('a'=c('ACR','ASM','S','KERA'), 'IL'=c('IL1','IL2','IL3','IL10'), 'bwahh'=c('ACR','SERPINA1','IL1','IL10','CD5'))


###################################################
### code chunk number 10: AnnotationFuncsUserguide.Rnw:157-158
###################################################
lapply(groups, translate, from=org.Bt.egSYMBOL2EG, simplify=TRUE)


###################################################
### code chunk number 11: AnnotationFuncsUserguide.Rnw:163-167
###################################################
symbols <- unlist(groups, use.names=FALSE)
ent <- translate(symbols, org.Bt.egSYMBOL2EG)
ent
mapLists(groups, ent)


###################################################
### code chunk number 12: AnnotationFuncsUserguide.Rnw:187-193
###################################################
symbols <- c("SERPINA1","KERA","CD5")
refseq <- translate(symbols, from=org.Bt.egSYMBOL2EG, to=org.Bt.egREFSEQ)
mRNA <- pickRefSeq(refseq, priorities=c('NM','XM'))	# Equals pickRefSeq.mRNA
mRNA
proteins <- pickRefSeq(refseq, priorities=c('NP','XP')) # Equals pickRefSeq.Protein
proteins


###################################################
### code chunk number 13: AnnotationFuncsUserguide.Rnw:205-212 (eval = FALSE)
###################################################
## symbols <- c("SERPINA1","KERA","CD5")
## GOs <- translate(symbols, from=org.Bt.egSYMBOL2EG, to=org.Bt.egGO)
## # Pick biological process:
## pickGO(GOs, category='BP')
## # Pick only those biological processes for Entrez Gene ID 280730
## # which have been inferred from sequence similarity or electronic annotation:
## pickGO(translate(280730, org.Bt.egGO), category='BP', evidence=c('ISS','IEA'))


###################################################
### code chunk number 14: AnnotationFuncsUserguide.Rnw:232-235
###################################################
library(hom.Hs.inp.db)
submap <- hom.Hs.inpBOSTA[c('ENSP00000356224','ENSP00000384582','ENSP00000364403')]
toTable(submap)


###################################################
### code chunk number 15: AnnotationFuncsUserguide.Rnw:259-260
###################################################
getOrthologs(c('ENSP00000356224','ENSP00000384582','ENSP00000364403'), hom.Hs.inpBOSTA, 'BOSTA')


###################################################
### code chunk number 16: AnnotationFuncsUserguide.Rnw:268-270
###################################################
symbols <- c("SERPINA1","KERA","CD5")
getOrthologs(symbols, hom.Hs.inpBOSTA, 'BOSTA', pre.from=org.Hs.egSYMBOL2EG, pre.to=org.Hs.egENSEMBLPROT, post.from=org.Bt.egENSEMBLPROT2EG, post.to=org.Bt.egSYMBOL)


###################################################
### code chunk number 17: AnnotationFuncsUserguide.Rnw:287-288
###################################################
sessionInfo()


