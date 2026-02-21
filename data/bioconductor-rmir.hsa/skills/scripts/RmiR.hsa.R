# Code example from 'RmiR.hsa' vignette. See references/ for full tutorial.

### R code from vignette source 'RmiR.hsa.Rnw'

###################################################
### code chunk number 1: Setup
###################################################
library(RmiR.hsa)
dbListTables(RmiR.hsa_dbconn())


###################################################
### code chunk number 2: SQL
###################################################
dbGetQuery(
RmiR.hsa_dbconn(), "SELECT * FROM tarbase WHERE mature_miRNA='hsa-miR-21'")


###################################################
### code chunk number 3: mult_tarbase (eval = FALSE)
###################################################
## tarbase <-dbReadTable(RmiR.hsa_dbconn(), "tarbase")[, 1:2]
## tarb_mir <- sort(table(tarbase$mature_miRNA), decreasing=T)
## plot(x=log2(c(1:length(tarb_mir))), y=tarb_mir,
##      ylab="miRNA targets", xlab="log2 (rank of miRNA)")


###################################################
### code chunk number 4: coop_tarbase (eval = FALSE)
###################################################
## tarb_gene <- sort(table(tarbase$gene_id), decreasing=T)
## plot(x=log2(c(1:length(tarb_gene))), y=tarb_gene,
##      ylab="target sites", xlab="log2 (rank of genes)")


###################################################
### code chunk number 5: plot1 (eval = FALSE)
###################################################
## tarbase <-dbReadTable(RmiR.hsa_dbconn(), "tarbase")[, 1:2]
## tarb_mir <- sort(table(tarbase$mature_miRNA), decreasing=T)
## plot(x=log2(c(1:length(tarb_mir))), y=tarb_mir,
##      ylab="miRNA targets", xlab="log2 (rank of miRNA)")
## tarb_gene <- sort(table(tarbase$gene_id), decreasing=T)
## plot(x=log2(c(1:length(tarb_gene))), y=tarb_gene,
##      ylab="target sites", xlab="log2 (rank of genes)")


###################################################
### code chunk number 6: mult_targetscan (eval = FALSE)
###################################################
## targetscan <-dbReadTable(RmiR.hsa_dbconn(), "targetscan")[, 1:2]
## targ_mir <- sort(table(targetscan$mature_miRNA), decreasing=T)
## plot(x=log2(c(1:length(targ_mir))), y=targ_mir,
##      ylab="miRNA targets", xlab="log2 (rank of miRNA)")


###################################################
### code chunk number 7: coop_targetscan (eval = FALSE)
###################################################
## targ_gene <- sort(table(targetscan$gene_id), decreasing=T)
## plot(x=log2(c(1:length(targ_gene))), y=targ_gene,
## ylab="target sites", xlab="log2 (rank of genes)")


###################################################
### code chunk number 8: plot2 (eval = FALSE)
###################################################
## targetscan <-dbReadTable(RmiR.hsa_dbconn(), "targetscan")[, 1:2]
## targ_mir <- sort(table(targetscan$mature_miRNA), decreasing=T)
## plot(x=log2(c(1:length(targ_mir))), y=targ_mir,
##      ylab="miRNA targets", xlab="log2 (rank of miRNA)")
## targ_gene <- sort(table(targetscan$gene_id), decreasing=T)
## plot(x=log2(c(1:length(targ_gene))), y=targ_gene,
## ylab="target sites", xlab="log2 (rank of genes)")


###################################################
### code chunk number 9: lists
###################################################
mirna <- c("hsa-miR-148b", "hsa-miR-27b", "hsa-miR-25","hsa-miR-181a",
	   "hsa-miR-27a", "hsa-miR-7", "hsa-miR-32", "hsa-miR-32",
	   "hsa-miR-7")
genes <- c("A_23_P171258", "A_23_P150053", "A_23_P150053", "A_23_P150053",
	   "A_23_P202435", "A_24_P90097", "A_23_P127948")


###################################################
### code chunk number 10: evalDBs
###################################################
targetscan <-dbReadTable(RmiR.hsa_dbconn(), "targetscan")[, 1:2]


###################################################
### code chunk number 11: simpleList
###################################################
mirs <-  targetscan[targetscan$mature_miRNA%in%mirna, ]
nrow(mirs)
mirs[1:10,]
library(hgug4112a.db)
targs <- targetscan[targetscan$gene_id%in%mget(genes, hgug4112aENTREZID), ]
nrow(targs)
targs[1:10, ]


