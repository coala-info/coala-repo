# Code example from 'nethet' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----echo=FALSE, include=FALSE, warning=FALSE------------------------------
# Load package
library(nethet)

set.seed(1)

## ----echo=TRUE, include=TRUE-----------------------------------------------
# Specify number of simulated samples and dimensionality
n = 100
p = 25

# Specify number of components of the mixture model and mixture probabilities
n.comp = 4

mix.prob = c(0.1, 0.4, 0.3, 0.2)

# Specify sparsity in [0,1], indicating fraction of off-diagonal zero entries.
s = 0.9


# Generate networks with random means and covariances. Means will be drawn from 
# a standard Gaussian distribution, non-zero covariance values from a 
# Beta(1,1) distribution.
sim.result = sim_mix_networks(n, p, n.comp, s, mix.prob)

## ----echo=TRUE, include=TRUE, fig.width=5, fig.height=3, fig.align='center'----
print(table(sim.result$comp)/n)

component = as.factor(sim.result$comp)

library('ggplot2')
qplot(x=sim.result$data[,1], y=sim.result$data[,2], 
      colour=component) + 
  xlab('Dimension 1') +
  ylab('Dimension 2')
  

## ----echo=TRUE, include=TRUE, fig.width=5, fig.height=3, fig.align='center'----
# Generate new dataset with the same covariances, but different means
sim.result.new = sim_mix_networks(n, p, n.comp, s, mix.prob, Sig=sim.result$Sig)

component = as.factor(sim.result.new$comp)

qplot(x=sim.result.new$data[,1], y=sim.result.new$data[,2], 
      colour=component) + 
  xlab('Dimension 1') +
  ylab('Dimension 2')

## ----echo=TRUE, include=TRUE, fig.width=7, fig.height=3, fig.align='center'----
## Sample size and number of nodes
n <- 40
p <- 10

## Specify sparse inverse covariance matrices,
## with number of edges in common equal to ~ 0.8*p
gen.net <- generate_2networks(p,graph='random',n.nz=rep(p,2),
                              n.nz.common=ceiling(p*0.8))

invcov1 <- gen.net[[1]]
invcov2 <- gen.net[[2]]

plot_2networks(invcov1,invcov2,label.pos=0,label.cex=0.7)

## ----echo=TRUE, include=TRUE-----------------------------------------------
set.seed(10)

n = 100
p = 25

# Generate networks with random means and covariances. 
sim.result = sim_mix_networks(n, p, n.comp, s, mix.prob)

test.data = sim.result$data
test.labels = sim.result$comp

# Reconstruct networks for each component
networks = het_cv_glasso(data=test.data, grouping=test.labels)

## ----echo=TRUE, include=TRUE, fig.width=5, fig.height=3, fig.align='center'----
# Component labels for covariance values
components = as.factor(rep(1:n.comp, each=p^2))

qplot(x=c(networks$Sig), y=c(sim.result$Sig),
			colour=components) + 
  xlab('Reconstructed Covariances') +
  ylab('True Covariances')
  

## ----eval=TRUE, echo=TRUE, include=TRUE, warning=TRUE, results="asis"------
## Set seed
set.seed(1)
 
## Sample size and number of nodes
p <- 30
 
## Specify sparse inverse covariance matrices
gen.net <- generate_2networks(p,graph='random',n.nz=rep(p,2),                               
                             n.nz.common=ceiling(p*0.8))
invcov1 <- gen.net[[1]]
invcov2 <- gen.net[[2]] 

## Get corresponding correlation matrices
cor1 <- cov2cor(solve(invcov1))
cor2 <- cov2cor(solve(invcov2))

## ----echo=TRUE, include=TRUE, warning=TRUE, results="asis"-----------------
## Generate data under null hypothesis
library(mvtnorm) # To generate multivariate Gaussian random samples

## Sample size
n <- 70

x1 <- rmvnorm(n,mean = rep(0,dim(cor1)[1]), sigma = cor1)
x2 <- rmvnorm(n,mean = rep(0,dim(cor1)[1]), sigma = cor1)

## ----echo=TRUE, include=TRUE, warning=TRUE, results="asis"-----------------
## Run diffnet (under null hypothesis)
dn.null <- diffnet_multisplit(x1,x2,b.splits=1,verbose=FALSE)

## ----echo=TRUE, include=TRUE, warning=TRUE, results="asis"-----------------

## Generate data under alternative hypothesis (datasets have different networks)
x1 <- rmvnorm(n,mean = rep(0,dim(cor1)[1]), sigma = cor1)
x2 <- rmvnorm(n,mean = rep(0,dim(cor1)[2]), sigma = cor2)

## Run diffnet (under alternative)
dn.altn <- diffnet_multisplit(x1,x2,b.splits=1,verbose=FALSE)

## ----eval=TRUE, echo=TRUE, include=TRUE, warning=TRUE, fig.width=3.5, fig.height=3.5, fig.align='center'----
## Typically we would choose a larger number of splits
# Use parallel library (only available under Unix) for computational efficiency
if(.Platform$OS.type == "unix") {
	dn.altn <- diffnet_multisplit(x1,x2,b.splits=50,verbose=FALSE,mc.flag=TRUE)
} else {
  dn.altn <- diffnet_multisplit(x1,x2,b.splits=25,verbose=FALSE,mc.flag=FALSE)
}

par(cex=0.7)
plot(dn.altn, cex=0.5) # histogram over 50 p-values
cat('p-value:',dn.altn$medagg.pval,'\n') # median aggregated p-value

## ----echo=TRUE, include=TRUE, warning=TRUE, results="asis", fig.width=5, fig.height=2.5, fig.align='center'----
## Generate new networks
set.seed(1)
p <- 9 # network with p nodes
n <- 40
hub.net <- generate_2networks(p,graph='hub',n.hub=3,n.hub.diff=1)#generate hub networks
invcov1 <- hub.net[[1]]
invcov2 <- hub.net[[2]]
plot_2networks(invcov1,invcov2,label.pos=0,label.cex=0.7,
               main=c('network 1', 'network 2'),cex.main=0.7)

## Generate data
library('mvtnorm')
x1 <- rmvnorm(n,mean = rep(0,p), sigma = cov2cor(solve(invcov1)))
x2 <- rmvnorm(n,mean = rep(0,p), sigma = cov2cor(solve(invcov2)))

## ----eval=TRUE, echo=TRUE, include=TRUE, warning=TRUE, results="asis"------
## Identify groups with 'gene-sets'
gene.names <- paste('G',1:p,sep='')
gsets <- split(gene.names,rep(1:3,each=3))

## ----eval=TRUE, echo=TRUE, include=TRUE, warning=TRUE, results="asis"------
## Run GGM-GSA
fit.ggmgsa <- ggmgsa_multisplit(x1,x2,b.splits=1,gsets,gene.names,verbose=FALSE)

library(xtable)
print(xtable(summary(fit.ggmgsa),digits=6))

## ----echo=TRUE, include=TRUE, warning=TRUE, results="asis"-----------------
## Number of predictors and sample size
p <- 100
n <- 80

## Predictor matrices
x1 <- matrix(rnorm(n*p),n,p)
x2 <- matrix(rnorm(n*p),n,p)

## Active-sets and regression coefficients
act1 <- sample(1:p,5)
act2 <- c(act1[1:3],sample(setdiff(1:p,act1),2))
beta1 <- beta2 <- rep(0,p)
beta1[act1] <- 0.7
beta2[act2] <- 0.7

## ----echo=TRUE, include=TRUE, warning=TRUE, results="asis", fig.align='center', fig.width=3.5,fig.height=3.5----
## Response vectors under null-hypothesis
y1 <- x1%*%as.matrix(beta1)+rnorm(n,sd=1)
y2 <- x2%*%as.matrix(beta1)+rnorm(n,sd=1)

## Differential regression; b.splits=10
fit.null <- diffregr_multisplit(y1,y2,x1,x2,b.splits=10)
par(cex=0.7)
plot(fit.null,cex=0.5) # histogram of p-values from b.split data splits
cat('p-value: ',fit.null$medagg.pval,'\n') # median aggregated p-value

## ----echo=TRUE, include=TRUE, warning=TRUE, results="asis",fig.align='center',fig.width=3.5,fig.height=3.5----
## Response vectors under alternative-hypothesis
y1 <- x1%*%as.matrix(beta1)+rnorm(n,sd=1)
y2 <- x2%*%as.matrix(beta2)+rnorm(n,sd=1)

## Differential regression (asymptotic p-values)
fit.alt <- diffregr_multisplit(y1,y2,x1,x2,b.splits=10)
par(cex=0.7)
plot(fit.alt)
cat('p-value: ',fit.alt$medagg.pval,'\n')

## ----echo=TRUE, include=TRUE, warning=TRUE, results="asis",fig.align='center',fig.width=3.5,fig.height=3.5----
## Differential regression (permutation-based p-values; 100 permutations)
fit.alt.perm <- diffregr_multisplit(y1,y2,x1,x2,b.splits=5,n.perm=100)

## ----echo=TRUE, include=TRUE-----------------------------------------------
# Generate networks with random means and covariances. 
n = 1000
p = 10
s = 0.9
n.comp = 3

# Create different mean vectors
Mu = matrix(0,p,n.comp)

# Define non-zero means in each group (non-overlapping)
nonzero.mean = split(sample(1:p),rep(1:n.comp,length=p))

# Set non-zero means to fixed value
for(k in 1:n.comp){
  Mu[nonzero.mean[[k]],k] = -2/sqrt(ceiling(p/n.comp))
}

# Generate data
sim.result = sim_mix_networks(n, p, n.comp, s, Mu=Mu)

## ----echo=TRUE, include=TRUE-----------------------------------------------
# Run mixglasso
mixglasso.result = mixglasso(sim.result$data, n.comp=3)

# Calculate adjusted rand index to judge how accurate the clustering is
# Values > 0.7 indicate good agreement.
library(mclust, quietly=TRUE)
adj.rand = adjustedRandIndex(mixglasso.result$comp, sim.result$comp)
cat('Adjusted Rand Index', round(adj.rand, digits=2), '\n')

## ----echo=FALSE, include=TRUE, cache=FALSE, results='asis'-----------------
crosstab <- function(class1,class2){
  tab <- matrix(NA,length(levels(class1)),length(levels(class2)))
  colnames(tab) <- levels(class2)
  rownames(tab) <- levels(class1)
  for (i in levels(class1)){
    tab[i,] <- table(class2[which(class1==i)])
  }
  return(tab)
}

# Relabel true groupings to avoid confusion
sim.grouping = c('A', 'B', 'C')[sim.result$comp]

cross.table = crosstab(factor(mixglasso.result$comp), factor(sim.grouping))

# Generate table
library(xtable)
latex.table = xtable(cross.table, caption=
										 	paste('Cross-tabulation of mixglasso clusters (rows) with',
                    'true group assignments (columns).'),
										 label='table:crosstab')

print(latex.table)

## ----echo=TRUE, include=TRUE, fig.width=5, fig.height=3, fig.align='center'----

# Run mixglasso over a range of numbers of components
mixglasso.result = mixglasso(sim.result$data, n.comp=1:6)

# Repeat with lambda=0 and lambda=Inf for comparison
mixglasso.result.0 = mixglasso(sim.result$data, n.comp=1:6, lambda=0)
mixglasso.result.Inf = mixglasso(sim.result$data, n.comp=1:6, lambda=Inf)

# Aggregate BIC results for plotting
BIC.vals = c(mixglasso.result$bic, mixglasso.result.0$bic,
						 mixglasso.result.Inf$bic)

lambda.labels = rep(c('Default', 'Lambda = 0', 'Lambda = Inf'), each=6)

# Plot to verify that minimum BIC value corresponds with true 
library(ggplot2)
plotting.frame <- data.frame(BIC=BIC.vals, Num.Comps=rep(1:6, 3), Lambda=lambda.labels)

p <- ggplot(plotting.frame) + 
	geom_line(aes(x=Num.Comps, y=BIC, colour=Lambda)) + 
	geom_vline(xintercept=3, linetype='dotted')

print(p)

## ----echo=TRUE, include=TRUE, fig.width=3, fig.height=3, fig.align='center'----

# Retrieve best clustering and networks by BIC
mixglasso.clustering = mixglasso.result$models[[mixglasso.result$bic.opt]]

# Plot networks, omitting edges with absolute partial correlation < 0.5 in 
# every group.
# NOTE: Not displayed.
# plot(mixglasso.clustering, p.corrs.thresh=0.5)

## ----echo=TRUE, include=TRUE, fig.width=5, fig.height=3, fig.align='center'----

# Plot edges, omitting those with absolute partial correlation < 0.5 in every 
# group.
g = dot_plot(mixglasso.clustering, p.corrs.thresh=0.5, dot.size.range=c(1,5))

## ----echo=TRUE, include=TRUE, fig.width=7, fig.height=7, fig.align='center'----

# Specify edges
node.pairs = rbind(c(9,10), c(2,5),c(4,9))

# Create scatter plots of specified edges
g = scatter_plot(mixglasso.clustering, data=sim.result$data,
						node.pairs=node.pairs, cex=0.5)

## ----echo=TRUE, include=TRUE, eval=FALSE-----------------------------------
# 
# # Save network in CSV format, omitting edges with absolute partial correlation
# # less than 0.25.
# #export_network(mixglasso.clustering, file='nethet_network.csv',
# #							 p.corrs.thresh=0.25)

## ----echo=TRUE, include=TRUE, eval=FALSE-----------------------------------
# 
# # Save network in CSV format suitable for Cytoscape import
# #export_network(mixglasso.clustering, file='nethet_network.csv',
# #							 p.corrs.thresh=0.25, quote=FALSE)

## ----echo=TRUE, include=TRUE, eval=TRUE------------------------------------
sessionInfo()

