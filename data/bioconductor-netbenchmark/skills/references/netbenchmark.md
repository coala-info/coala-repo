# Netbenchmark

#### *Pau Bellot, Catharina Olsen, Patrick Meyer*

#### *2018-10-30*

In the last decade, several methods have tackled the challenge of reconstructing gene regulatory networks from gene expression data. Several papers have compared and evaluated the different network inference methods relying on simulated data.

This is a new comparison that assesses different methods in a high-heterogeneity data scenario which could reveal the specialization of methods for the different network types and data.

This package allows repeating the comparison between different network inference algorithms with only one line of code.

This package allows replication this comparison between the different networks inference algorithms with only one line of code.

Toy example for main benchmark:

```
library(netbenchmark)
```

```
## Loading required package: grndata
```

```
top20.aupr <- netbenchmark(methods="all",datasources.names = "Toy",
local.noise=20,global.noise=10,
noiseType=c("normal","lognormal"),
datasets.num = 2,experiments = 40,
seed=1422976420,verbose=FALSE)
```

```
## Warning in netbenchmark(methods = "all", datasources.names = "Toy", local.noise = 20, : The specified number of experiments and
## datasets is bigger than the orginal number of experiments in the datasource:
## toy, sampling with replacement will be used
```

```
## Estimate (local) false discovery rates (partial correlations):
## Estimate (local) false discovery rates (partial correlations):
```

The first element of the returned list is the \(AUPR\_{20}\):

```
print(top20.aupr[[1]])
```

```
##   Origin experiments aracne.wrap c3net.wrap  clr.wrap GeneNet.wrap
## 1    toy          48  0.14848213 0.08245954 0.1714301   0.12114511
## 2    toy          35  0.09202273 0.06712657 0.1172456   0.07301737
##   Genie3.wrap mrnet.wrap mutrank.wrap mrnetb.wrap pcit.wrap zscore.wrap
## 1   0.1635415  0.1700919   0.11436468   0.1760170 0.1689174  0.03307668
## 2   0.1344815  0.1198149   0.07320087   0.1216965 0.1395012  0.01477506
##         rand
## 1 0.01215012
## 2 0.01737376
```

The package provides an easy way to compare new techniques with
state-of-the-art ones and to make new different benchmarks in the future.

First, define the wrapper functions:

```
Spearmancor <- function(data){
cor(data,method="spearman")
}

Pearsoncor <- function(data){
cor(data,method="pearson")
}
```

Note that the wrapper function returns a matrix which is the weighted adjacency matrix of the network inferred by the algorithm and that the columns and rows are named.

Evaluate five times these two simple inference methods with syntren300 datasource:

```
res <- netbenchmark(datasources.names="syntren300",
methods=c("Spearmancor","Pearsoncor"),verbose=FALSE)
aupr <- res[[1]][,-(1:2)]
```

Make a boxplot of the \(AUPR\_{20}\) results:

```
boxplot(aupr, main="Syntren300",ylab=expression('AUPR'[20]))
```

![](data:image/png;base64...)

Plot the mean Precision-Recall curves:

```
PR <- res[[5]][[1]]
col <- rainbow(3)
plot(PR$rec[,1],PR$pre[,1],type="l",lwd=3,col=col[1],xlab="Recall",
ylab="Precision",main="Syntren300",xlim=c(0,1),ylim=c(0,1))
lines(PR$rec[,2],PR$pre[,2],type="l",lwd=3,col=col[2])
lines(PR$rec[,3],PR$pre[,3],type="l",lwd=3,col=col[3])
legend("topright", inset=.05,title="Method",colnames(PR$rec),fill=col)
```

![](data:image/png;base64...)

We can also compare these two simple inference methods with the fast network inference algorithms using syntren300 datasource:

```
comp <- netbenchmark(datasources.names="syntren300",
methods=c("all.fast","Spearmancor","Pearsoncor"),verbose=FALSE)
```

```
## Estimate (local) false discovery rates (partial correlations):
## Estimate (local) false discovery rates (partial correlations):
## Estimate (local) false discovery rates (partial correlations):
## Estimate (local) false discovery rates (partial correlations):
## Estimate (local) false discovery rates (partial correlations):
```

```
aupr <- comp[[1]][,-(1:2)]
```

Make a boxplot the \(AUPR\_{20}\) results:

```
#make the name look prety
library("tools")
colnames(aupr) <- sapply(colnames(aupr),file_path_sans_ext)
boxplot(aupr, main="Syntren300", ylab=expression('AUPR'[20]))
```

![](data:image/png;base64...)