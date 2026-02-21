# Code example from 'RmiR' vignette. See references/ for full tutorial.

### R code from vignette source 'RmiR.Rnw'

###################################################
### code chunk number 1: callVign (eval = FALSE)
###################################################
## vignette("RmiR.Hs.miRNA")


###################################################
### code chunk number 2: createLists
###################################################
  genes <- data.frame(genes=c("A_23_P171258","A_23_P150053", "A_23_P150053",
			      "A_23_P150053", "A_23_P202435", "A_24_P90097",
			      "A_23_P127948"))
  genes$expr <- c(1.21, -1.50, -1.34, -1.45, -2.41, -2.32, -3.03)  

  mirna <- data.frame(mirna=c("hsa-miR-148b", "hsa-miR-27b", "hsa-miR-25",
			      "hsa-miR-181a", "hsa-miR-27a", "hsa-miR-7",
			      "hsa-miR-32", "hsa-miR-32", "hsa-miR-7"))
  mirna$expr <- c(1.23, 3.52, -2.42, 5.2, 2.2, -1.42, -1.23, -1.20, -1.37)


###################################################
### code chunk number 3: listGene
###################################################
genes


###################################################
### code chunk number 4: listmiRNA
###################################################
mirna


###################################################
### code chunk number 5: read.mir1
###################################################
library(RmiR)
read.mir(genes=genes, mirna=mirna, annotation="hgug4112a.db")


###################################################
### code chunk number 6: read.mir2
###################################################
read.mir(genes=genes, mirna=mirna, annotation="hgug4112a.db", at.least=1)


###################################################
### code chunk number 7: read.mir4
###################################################
genes.e <- genes
genes.e$gene_id <- c(22, 59, 59, 59, 120, 120, 133)
genes.e <- genes.e[, c("gene_id", "expr")]
genes.e
read.mir(genes = genes.e, mirna = mirna, annotation = "hgug4112a.db", 
	 id="genes")


###################################################
### code chunk number 8: read.mir4
###################################################
genes.a <- genes
genes.a$alias <- c("ABCB7", "ADD3", "ADDL", "ADD3", "AAT6", "ACTA2", "ADM")
genes.a <- genes.a[, c("alias", "expr")]
genes.a
read.mir(genes = genes.a, mirna = mirna, annotation = "hgug4112a.db",
	 id="alias")


###################################################
### code chunk number 9: read.mir3
###################################################
read.mir(genes=genes, mirna=mirna, annotation="hgug4112a.db", at.least=1,
	 id.out="probes")


###################################################
### code chunk number 10: RmiRtc
###################################################
data(RmiR)
res1<- read.mir(gene=gene1, mirna=mir1, annotation="hgug4112a.db",verbose=TRUE)
res2<- read.mir(gene=gene2, mirna=mir2, annotation="hgug4112a.db",verbose=TRUE)
res3<- read.mir(gene=gene3, mirna=mir3, annotation="hgug4112a.db",verbose=TRUE)
res_tc <- RmiRtc(timeline=c("res1", "res2", "res3"), 
		 timevalue=c(12, 24, 48))


###################################################
### code chunk number 11: readRmiRtc
###################################################
res_fil <- readRmiRtc(res_tc, correlation=-0.9, exprLev=1, 
		      annotation="hgug4112a.db")
res_fil$reps


###################################################
### code chunk number 12: printRmiRtc
###################################################
cbind	(res_fil$couples, res_fil$geneExpr, 
	res_fil$mirExpr)[res_fil$couples$gene_id==351 & res_fil$cor<=-0.9, ]


###################################################
### code chunk number 13: plotRmiR1 (eval = FALSE)
###################################################
## plotRmiRtc(res1[res1$gene_id==351,],svgname="res1_351.svg",svgTips=T)


###################################################
### code chunk number 14: plotRmiR2
###################################################
plotRmiRtc(res_fil,gene_id=351)


###################################################
### code chunk number 15: plotRmiR3
###################################################
plotRmiRtc(res_fil, gene_id=351, legend.y=0, legend.x=30)


###################################################
### code chunk number 16: plotRmiR4 (eval = FALSE)
###################################################
## plotRmiRtc(res_fil, gene_id=351, legend.y=0, legend.x=30, svgTips=T)


