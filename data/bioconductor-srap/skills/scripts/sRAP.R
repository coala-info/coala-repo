# Code example from 'sRAP' vignette. See references/ for full tutorial.

### R code from vignette source 'sRAP.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: inputVariables
###################################################
library("sRAP")

dir <- system.file("extdata", package="sRAP")
expression.table <- file.path(dir,"MiSeq_cufflinks_genes_truncate.txt")
sample.table <- file.path(dir,"MiSeq_Sample_Description.txt")
project.folder <- getwd()
project.name <- "MiSeq"


###################################################
### code chunk number 2: normalization
###################################################
expression.mat <- RNA.norm(expression.table, project.name, project.folder)


###################################################
### code chunk number 3: qc
###################################################
RNA.qc(sample.table, expression.mat, project.name,
		project.folder, plot.legend=F,
		color.palette=c("green","orange"))


###################################################
### code chunk number 4: diffExpression
###################################################
stat.table <- RNA.deg(sample.table, expression.mat,
			project.name, project.folder, box.plot=FALSE,
			ref.group=T, ref="scramble",
			method="aov", color.palette=c("green","orange"))


###################################################
### code chunk number 5: bdFunc
###################################################
#data(bdfunc.enrichment.human)
#data(bdfunc.enrichment.mouse)
RNA.bdfunc.fc(stat.table, plot.flag=FALSE,
		project.name, project.folder, species="human")

RNA.bdfunc.signal(expression.mat, sample.table, plot.flag=FALSE,
		project.name, project.folder, species="human")


