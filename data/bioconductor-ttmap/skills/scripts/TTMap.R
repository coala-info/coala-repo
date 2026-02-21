# Code example from 'TTMap' vignette. See references/ for full tutorial.

### R code from vignette source 'TTMap.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: loadLibAndData
###################################################
library(airway)
data(airway)
airway <- airway[rowSums(assay(airway))>80,]
assay(airway) <- log(assay(airway)+1,2)
experiment <- TTMap::make_matrices(airway,seq_len(4),seq_len(4)+4,
NAME = rownames(airway), CLID =rownames(airway))


###################################################
### code chunk number 3: part1
###################################################
E=1
Pw=1.1
Bw=0
TTMAP_part1prime <-TTMap::control_adjustment(normal.pcl = experiment$CTRL,
tumor.pcl = experiment$TEST, 
normalname = "The_healthy_controls", dataname = "The_effect_of_cancer", 
org.directory = getwd(), e=E,P=Pw,B=Bw);


###################################################
### code chunk number 4: part2
###################################################
TTMAP_part1_hda <- TTMap::hyperrectangle_deviation_assessment(x = 
TTMAP_part1prime,k=dim(TTMAP_part1prime$Normal.mat)[2],
dataname = "The_effect_of_cancer", normalname = "The_healthy_controls");
head(TTMAP_part1_hda$Dc.Dmat)


###################################################
### code chunk number 5: part3
###################################################
library(rgl)
ALPHA <- 1
annot <- c(paste(colnames(experiment$TEST[,-seq_len(3)]),"Dis",sep=".")
,paste(colnames(experiment$CTRL[,-seq_len(3)]),"Dis",sep="."))
annot <- cbind(annot,annot)
rownames(annot)<-annot[,1]
dd5_sgn_only <-TTMap::generate_mismatch_distance(TTMAP_part1_hda,
select=rownames(TTMAP_part1_hda$Dc.Dmat),alpha = ALPHA)
TTMAP_part2_gtlmap <- 
TTMap::ttmap(TTMAP_part1_hda,TTMAP_part1_hda$m,
select=rownames(TTMAP_part1_hda$Dc.Dmat),
annot,e= TTMap::calcul_e(dd5_sgn_only,0.95,TTMAP_part1prime,1), 
filename="first_comparison",
n=1,dd=dd5_sgn_only)
rgl.postscript("first_output.pdf","pdf")


###################################################
### code chunk number 6: part4
###################################################
TTMap::ttmap_sgn_genes(TTMAP_part2_gtlmap, 
TTMAP_part1_hda, TTMAP_part1prime, 
annot, n = 2, a = ALPHA,
filename = "first_trial", annot = TTMAP_part1prime$tag.pcl, col = "NAME",
path = getwd(), Relaxed = 0)


