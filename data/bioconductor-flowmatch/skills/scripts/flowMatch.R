# Code example from 'flowMatch' vignette. See references/ for full tutorial.

### R code from vignette source 'flowMatch.Rnw'

###################################################
### code chunk number 1: CompanionPkg (eval = FALSE)
###################################################
## 
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("healthyFlowData")


###################################################
### code chunk number 2: flowMatch.Rnw:159-161
###################################################
library(healthyFlowData)
library(flowMatch)


###################################################
### code chunk number 3: clustering
###################################################
## ------------------------------------------------
## load data and retrieve a sample
## ------------------------------------------------

data(hd)
sample = exprs(hd.flowSet[[1]])

## ------------------------------------------------
## cluster sample using kmeans algorithm
## ------------------------------------------------
km = kmeans(sample, centers=4, nstart=20)
cluster.labels = km$cluster

## ------------------------------------------------
## Create ClusteredSample object  (Option 1 )
## without specifying centers and covs
## we need to pass FC sample for paramter estimation
## ------------------------------------------------

clustSample = ClusteredSample(labels=cluster.labels, sample=sample)

## ------------------------------------------------
## Create ClusteredSample object  (Option 2)
## specifying centers and covs 
## no need to pass the sample
## ------------------------------------------------

centers = list()
covs = list()
num.clusters = nrow(km$centers)
for(i in 1:num.clusters)
{
  centers[[i]] = km$centers[i,]
  covs[[i]] = cov(sample[cluster.labels==i,])
}
# Now we do not need to pass sample
clustSample = ClusteredSample(labels=cluster.labels, centers=centers, covs=covs)

## ------------------------------------------------
## Show summary and plot a clustered sample
## ------------------------------------------------

summary(clustSample)
plot(sample, clustSample)



###################################################
### code chunk number 4: stage2
###################################################
## ------------------------------------------------
## load data and retrieve a sample
## ------------------------------------------------

data(hd)
sample = exprs(hd.flowSet[[1]])

## ------------------------------------------------
## cluster sample using kmeans algorithm
## ------------------------------------------------

km = kmeans(sample, centers=4, nstart=20)
cluster.labels = km$cluster

## ------------------------------------------------
## Create ClusteredSample object  
## and retrieve two clusters (cluster from different samples can be used as well)
## ------------------------------------------------

clustSample = ClusteredSample(labels=cluster.labels, sample=sample)
clust1 = get.clusters(clustSample)[[1]]
clust2 = get.clusters(clustSample)[[2]]

## ------------------------------------------------
## compute dissimilarity between the clusters
## ------------------------------------------------

dist.cluster(clust1, clust2, dist.type='Mahalanobis')
dist.cluster(clust1, clust2, dist.type='KL')
dist.cluster(clust1, clust2, dist.type='Euclidean')



###################################################
### code chunk number 5: stage3
###################################################
## ------------------------------------------------
## load data and retrieve two samples
## ------------------------------------------------

data(hd)
sample1 = exprs(hd.flowSet[[1]])
sample2 = exprs(hd.flowSet[[2]])

## ------------------------------------------------
## cluster samples using kmeans algorithm
## ------------------------------------------------

clust1 = kmeans(sample1, centers=4, nstart=20)
clust2 = kmeans(sample2, centers=4, nstart=20)
cluster.labels1 = clust1$cluster
cluster.labels2 = clust2$cluster

## ------------------------------------------------
## Create ClusteredSample objects  
## ------------------------------------------------

clustSample1 = ClusteredSample(labels=cluster.labels1, sample=sample1)
clustSample2 = ClusteredSample(labels=cluster.labels2, sample=sample2)

## ------------------------------------------------
## Computing matching of clusteres  
## An object of class "ClusterMatch" is returned 
## ------------------------------------------------

mec = match.clusters(clustSample1, clustSample2, dist.type="Mahalanobis", unmatch.penalty=99999)
class(mec)
summary(mec)


###################################################
### code chunk number 6: stage4
###################################################
## load data (20 samples in total)
## ------------------------------------------------

data(hd)

## ------------------------------------------------
## Retrieve each sample, clsuter it and store the
## clustered samples in a list
## ------------------------------------------------
set.seed(1234) # for reproducable clustering 
cat('Clustering samples: ')
clustSamples = list()
for(i in 1:length(hd.flowSet))
{
  cat(i, ' ')
  sample1 = exprs(hd.flowSet[[i]])
  clust1 = kmeans(sample1, centers=4, nstart=20)
  cluster.labels1 = clust1$cluster
  clustSample1 = ClusteredSample(labels=cluster.labels1, sample=sample1)
  clustSamples = c(clustSamples, clustSample1)
}

## ------------------------------------------------
## Create a template from the list of clustered samples
## the function returns an object of class "Template"
## ------------------------------------------------

template = create.template(clustSamples)
summary(template)


###################################################
### code chunk number 7: template-tree
###################################################
template.tree(template)


###################################################
### code chunk number 8: template-default
###################################################
plot(template)


###################################################
### code chunk number 9: template-color-mc
###################################################
plot(template, color.mc=c('blue','black','green3','red'))


###################################################
### code chunk number 10: template-mc
###################################################
plot(template, plot.mc=TRUE, color.mc=c('blue','black','green3','red'))


###################################################
### code chunk number 11: template-color-sample
###################################################
plot(template, colorbysample=TRUE)


###################################################
### code chunk number 12: mc-plot
###################################################
# retrieve a metacluster from a template
mc = get.metaClusters(template)[[1]]
summary(mc)
# plot all participating cluster in this meta-cluster
plot(mc) 



###################################################
### code chunk number 13: mc-plot1
###################################################
plot(mc, plot.mc=TRUE)


