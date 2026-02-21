# Code example from 'vulcan' vignette. See references/ for full tutorial.

### R code from vignette source 'vulcan.Rnw'

###################################################
### code chunk number 1: vulcan.Rnw:65-66
###################################################
set.seed(1)


###################################################
### code chunk number 2: vulcan.Rnw:69-73 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("vulcandata")
## BiocManager::install("vulcan")


###################################################
### code chunk number 3: vulcan.Rnw:79-80
###################################################
library(vulcan)


###################################################
### code chunk number 4: vulcan.Rnw:84-85
###################################################
library(vulcandata)


###################################################
### code chunk number 5: vulcan.Rnw:92-95
###################################################
# Generate an annotation file from the dummy ChIP-Seq dataset
vfile<-tempfile()
vulcandata::vulcansheet(vfile)


###################################################
### code chunk number 6: vulcan.Rnw:99-103
###################################################
# Import BAM and BED information into a list object
# vobj<-vulcan.import(vfile)
vobj<-vulcandata::vulcanexample()
unlink(vfile)


###################################################
### code chunk number 7: vulcan.Rnw:107-109
###################################################
# Annotate peaks to gene names
vobj<-vulcan.annotate(vobj,lborder=-10000,rborder=10000,method="sum")


###################################################
### code chunk number 8: vulcan.Rnw:113-117
###################################################
# Normalize data for VULCAN analysis
vobj<-vulcan.normalize(vobj)
# Detect which conditions are present in our imported object
names(vobj$samples)


###################################################
### code chunk number 9: vulcan.Rnw:123-124
###################################################
load(system.file("extdata","network.rda",package="vulcandata",mustWork=TRUE))


###################################################
### code chunk number 10: vulcan.Rnw:133-135
###################################################
vobj_analysis<-vulcan(vobj,network=network,contrast=c("t90","t0"),minsize=5)
plot(vobj_analysis$msviper,mrs=7)


###################################################
### code chunk number 11: vulcan.Rnw:148-152
###################################################
reflist<-setNames(-sort(rnorm(1000)),paste0("gene",1:1000))
set<-paste0("gene",sample(1:200,50))
obj<-gsea(reflist,set,method="pareto")
obj$p.value


###################################################
### code chunk number 12: vulcan.Rnw:155-156
###################################################
plot_gsea(obj)


###################################################
### code chunk number 13: vulcan.Rnw:163-169
###################################################
signatures<-setNames(-sort(rnorm(1000)),paste0("gene",1:1000))
set1<-paste0("gene",sample(1:200,50))
set2<-paste0("gene",sample(1:1000,50))
groups<-list(set1=set1,set2=set2)
obj<-rea(signatures=signatures,groups=groups)
obj


###################################################
### code chunk number 14: vulcan.Rnw:177-191
###################################################
par(mfrow=c(1,2))
# Thousands
set.seed(1)
a<-runif(1000,0,1e4)
plot(a,yaxt="n")
kmg<-kmgformat(pretty(a))
axis(2,at=pretty(a),labels=kmg)

# Millions to Billions
set.seed(1)
a<-runif(1000,0,1e9)
plot(a,yaxt="n",pch=20,col=val2col(a))
kmg<-kmgformat(pretty(a))
axis(2,at=pretty(a),labels=kmg)


