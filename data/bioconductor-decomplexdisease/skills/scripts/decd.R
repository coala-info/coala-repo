# Code example from 'decd' vignette. See references/ for full tutorial.

## ------------------------------------------------------------------------
rm(list=ls())

## ------------------------------------------------------------------------
library("DEComplexDisease")
#load RNA-seq counts matrix
data(exp)
#load sample annotation vector
data(cl)
#load sample ER status annotation
data(ann.er)
exp[1:5,1:5]
head(cl, 4)

## ------------------------------------------------------------------------
deg=bi.deg(exp, cl, method="edger", cutoff=0.05, cores=4)

## ------------------------------------------------------------------------
Plot(deg, ann=ann.er, show.genes=row.names(deg)[1:5])

## ------------------------------------------------------------------------
res.deg=deg.specific(deg, min.genes=30, min.patients=5, cores=4)


## ------------------------------------------------------------------------
res.deg.test=deg.specific(deg, test.patients=colnames(deg)[1:10], min.genes=50,  
            min.patients=8, cores=4)


## ------------------------------------------------------------------------
Plot(res.deg, ann=ann.er, max.n=5 )

## ------------------------------------------------------------------------
Plot(res.deg.test, ann=ann.er, max.n=5)

## ------------------------------------------------------------------------
seed.mod1 = seed.module(deg, res.deg=res.deg, min.genes=50, min.patients=20, 
                        overlap=0.85, cores=4)

## ------------------------------------------------------------------------
seed.mod2 = seed.module(deg, test.patients=colnames(deg)[1:10], min.genes=50, 
                        min.patients=20, overlap=0.85,  cores=4)

## ------------------------------------------------------------------------
Plot(seed.mod1, ann=ann.er, type="model", max.n=5)

## ------------------------------------------------------------------------
cluster.mod1 <- cluster.module(seed.mod1, cores=4)

## ------------------------------------------------------------------------
cluster.mod2 <- cluster.module(seed.mod1, vote.seed=TRUE, cores=4)

## ------------------------------------------------------------------------
sort(names(cluster.mod1), decreasing=TRUE)
names(cluster.mod1[["decd.input"]])
names(cluster.mod1[["decd.clustering"]])
names(cluster.mod1[["M1"]])

## ------------------------------------------------------------------------
Plot(cluster.mod1, ann=ann.er, type="model", max.n=5)

## ------------------------------------------------------------------------
module.overlap(cluster.mod1, max.n=5)

## ------------------------------------------------------------------------
res.mod1 <- seed.module(deg[,1:26],  min.genes=50, min.patients=10, overlap=0.85, cores=4)
res.mod1 <- cluster.module(res.mod1)
res.mod2 <- seed.module(deg[,27:52], min.genes=50, min.patients=10, overlap=0.85, cores=4)
res.mod2 <- cluster.module(res.mod2)

## ------------------------------------------------------------------------
module.compare(res.mod1, res.mod2, max.n1=5, max.n2=5)

## ------------------------------------------------------------------------
names(cluster.mod1[["M1"]][["curve"]])
head(cluster.mod1[["M1"]][["curve"]][["no.gene"]])
head(cluster.mod1[["M1"]][["curve"]][["no.patient"]])

## ------------------------------------------------------------------------
module.curve(cluster.mod1, "M1")

## ------------------------------------------------------------------------
x=c(50,40)
names(x)<-c("M1","M3")
new.cluster.mod1=module.modeling(cluster.mod1, keep.gene.num = x, model.method='slope.clustering',
                                cores=4) 
#here, only "M1" and "M3" are modified
new.cluster.mod1=module.modeling(cluster.mod1, keep.gene.num = 50) 
# here, all the modules are modified
module.curve(new.cluster.mod1, "M1")

## ------------------------------------------------------------------------
module.screen(cluster.mod1, feature.patients=sample(colnames(deg),10))
#search modules

module.screen(seed.mod1, feature.patients=sample(colnames(deg),10),
              method="fisher.test")

