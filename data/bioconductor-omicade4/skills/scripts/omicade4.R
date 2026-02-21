# Code example from 'omicade4' vignette. See references/ for full tutorial.

### R code from vignette source 'omicade4.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(bibstyle="unsrt")


###################################################
### code chunk number 2: load_lib_data
###################################################
library(omicade4)
data(NCI60_4arrays)


###################################################
### code chunk number 3: check_col_number
###################################################
sapply(NCI60_4arrays, dim)


###################################################
### code chunk number 4: Check_col_order
###################################################
all(apply((x <- sapply(NCI60_4arrays, colnames))[,-1], 2, function(y)
identical(y, x[,1])))


###################################################
### code chunk number 5: cluster_data_separately
###################################################
layout(matrix(1:4, 1, 4))
par(mar=c(2, 1, 0.1, 6))
for (df in NCI60_4arrays) {
  d <- dist(t(df))
  hcl <- hclust(d)
  dend <- as.dendrogram(hcl)
  plot(dend, horiz=TRUE)
}


###################################################
### code chunk number 6: MCIA
###################################################
mcoin <- mcia(NCI60_4arrays, cia.nf=10)
class(mcoin)


###################################################
### code chunk number 7: get_cancertype
###################################################
cancer_type <- colnames(NCI60_4arrays$agilent)
cancer_type <- sapply(strsplit(cancer_type, split="\\."), function(x) x[1])
cancer_type


###################################################
### code chunk number 8: plot_mcia_cancertype
###################################################
plot(mcoin, axes=1:2, phenovec=cancer_type, sample.lab=FALSE, df.color=1:4)


###################################################
### code chunk number 9: selectvar_mcia_melan
###################################################
melan_gene <- selectVar(mcoin, a1.lim=c(2, Inf), a2.lim=c(-Inf, Inf))
melan_gene


###################################################
### code chunk number 10: plot_mcia_axes
###################################################
plot(mcoin, axes=c(1, 3), phenovec=cancer_type, sample.lab=FALSE, df.color=1:4)
plot(mcoin, axes=c(2, 3), phenovec=cancer_type, sample.lab=FALSE, df.color=1:4)


###################################################
### code chunk number 11: plotvar_mcia
###################################################
geneStat <- plotVar(mcoin, var=c("S100B", "S100A1"), var.lab=TRUE)


