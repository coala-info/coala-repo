# Code example from 'BAGS' vignette. See references/ for full tutorial.

### R code from vignette source 'BAGS.Rnw'

###################################################
### code chunk number 1: install-pkg (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("BAGS")


###################################################
### code chunk number 2: BAGS.Rnw:89-90 (eval = FALSE)
###################################################
## library(BAGS)


###################################################
### code chunk number 3: BAGS.Rnw:97-98 (eval = FALSE)
###################################################
## library(help=BAGS)


###################################################
### code chunk number 4: BAGS.Rnw:125-166
###################################################
library(BAGS)
library(breastCancerVDX)
library(Biobase)
 
data(vdx)
gene.expr=exprs(vdx)   # Gene expression of the package
vdx.annot=fData(vdx)   # Annotation associated to the dataset
vdx.clinc=pData(vdx)   # Clinical information associated to the dataset 
 
# Identifying the sample identifiers associated to ER+ and ER- breast cancer
er.pos=which(vdx.clinc$er==1)
er.neg=which(vdx.clinc$er==0)
 
# Only keep columns 1 and 3, probeset identifiers and Gene symbols respectively
vdx.annot=vdx.annot[,c(1,3)]

# Checking if the probeset are ordered with respect to the dataset
all(rownames(gene.expr)==as.character(vdx.annot[,1]))  
# Checking if the sample identifiers are order with respect to the dataset
all(colnames(gene.expr)==as.character(vdx.clinc[,1]))  
# Changing the row identifiers to the gene identifiers of interest
rownames(gene.expr)=as.character(vdx.annot[,2])        
 
#= Because we have several measurements for a gene, we filter the genes
# Function to obtain the genes with highest variabilty among phenotypes
gene.nms.u=unique(rownames(gene.expr))
gene.nms=rownames(gene.expr)
indices=NULL
for(i in 1:length(gene.nms.u))
{
	aux=which(gene.nms==gene.nms.u[i])
 	if(length(aux)>1){
 		var.r = apply(cbind(apply(gene.expr[aux,er.pos],1,mean),
                         apply(gene.expr[aux,er.neg],1,mean)),1,var)
		aux=aux[which.max(var.r)]
  	}
  indices=c(indices,aux)
}
#===== Only keep the genes with most variability among the phenotypes of interest
gene.expr=gene.expr[indices,]
gene.nams=rownames(gene.expr)     # The gene symbols of interest are stored here


###################################################
### code chunk number 5: BAGS.Rnw:171-175
###################################################
data(AnnotationMFGO,package="BAGS")
data.gene.grps=DataGeneSets(AnnotationMFGO,gene.nams,5)
phntp.list=list(er.pos,er.neg)
data.mcmc=MCMCDataSet(gene.expr,data.gene.grps$DataGeneSetsIds,phntp.list)


###################################################
### code chunk number 6: BAGS.Rnw:184-200
###################################################
noRow=dim(data.mcmc$y.mu)[1]
noCol=unlist(lapply(phntp.list,length))
iter=10000
GrpSzs=data.gene.grps$Size
YMu=data.mcmc$y.mu
L0=rep(2,2)
V0=rep(4,2)
L0A=rep(3,1)
V0A=rep(3,1)
MM=0.55
AAPi=10
ApriDiffExp=floor(dim(data.mcmc$y.mu)[1]*0.03)
results=matrix(0,noRow,iter)
 		
mcmc.chains=Gibbs2(noRow,noCol,iter,GrpSzs,YMu,L0,V0,L0A,V0A,MM,AAPi,ApriDiffExp,
                   results)


###################################################
### code chunk number 7: BAGS.Rnw:202-211
###################################################
burn.in=2000
alfa.pi=apply(mcmc.chains[[1]][,burn.in:iter],1,function(x){
 	                        y=length(which(x!=0))/length(burn.in:iter);return(y)})

plot(alfa.pi,type="h",main="Probabilities of MF differentially expressed
     between ER status")                                   
cut.off=0.9
abline(h=cut.off,col="red")
differential.processes=names(data.gene.grps$Size)[which(alfa.pi>cut.off)]


###################################################
### code chunk number 8: sessionInfo
###################################################
toLatex(sessionInfo())


