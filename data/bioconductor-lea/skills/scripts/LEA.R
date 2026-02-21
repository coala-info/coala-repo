# Code example from 'LEA' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance=TRUE,
cache=TRUE
)

## ----results='hide'-----------------------------------------------------------
# creation of a directory for LEA analyses
dir.create("LEA_analyses")
# set the created directory as the working directory
setwd("LEA_analyses")

## ----results='hide'-----------------------------------------------------------
library(LEA)
# Creation of a genotype matrix data file: "genotypes.lfmm"
# The data include 400 SNPs for 50 individuals.
data("tutorial")
# Write genotypes in the lfmm format
write.lfmm(tutorial.R, "genotypes.lfmm")
# Write genotypes in the geno format
write.geno(tutorial.R, "genotypes.geno")
# creation of an environment gradient file: gradient.env.
# The .env file contains a single ecological variable
# for each individual.
write.env(tutorial.C, "gradients.env")

## ----results='hide'-----------------------------------------------------------
# run of pca
# Available options, K (the number of PCs), 
#                    center and scale. 
# Create files: genotypes.eigenvalues - eigenvalues,        
#               genotypes.eigenvectors - eigenvectors,
#               genotypes.sdev - standard deviations,
#               genotypes.projections - projections,
# Create a pcaProject object: pc.
pc = pca("genotypes.lfmm", scale = TRUE)
tw = tracy.widom(pc)

## ----fig.width=4, fig.height=4, echo=TRUE-------------------------------------
# plot the percentage of variance explained by each component
plot(tw$percentage, pch = 19, col = "darkblue", cex = .8)

## ----results='hide'-----------------------------------------------------------
# main options
# K = number of ancestral populations
# entropy = TRUE computes the cross-entropy criterion, 
# CPU = 4 is the number of CPU used (hidden input)
project = NULL
project = snmf("genotypes.geno",
               K = 1:10, 
               entropy = TRUE, 
               repetitions = 10,
               project = "new")

## ----fig.width=4, fig.height=4, echo=TRUE-------------------------------------
# plot cross-entropy criterion for all runs in the snmf project
plot(project, col = "blue", pch = 19, cex = 1.2)

## ----fig.width=10, fig.height=4, echo=TRUE------------------------------------
# select the best run for K = 4 clusters
best = which.min(cross.entropy(project, K = 4))
my.colors <- c("tomato", "lightblue", 
               "olivedrab", "gold")
barchart(project, K = 4, run = best,
        border = NA, space = 0, 
        col = my.colors, 
        xlab = "Individuals",
        ylab = "Ancestry proportions",
        main = "Ancestry matrix") -> bp
axis(1, at = 1:length(bp$order), 
     labels = bp$order, las=1, 
     cex.axis = .4)

## ----fig.width=8, fig.height=6, echo=TRUE, results='hide'---------------------
# Genome scan for selection: opulation differentiation tests
p = snmf.pvalues(project, 
                 entropy = TRUE, 
                 ploidy = 2, 
                 K = 4)
pvalues = p$pvalues
par(mfrow = c(2,1))
hist(pvalues, col = "orange")
plot(-log10(pvalues), pch = 19, col = "blue", cex = .5)

## -----------------------------------------------------------------------------
# creation of a genotype matrix  with missing genotypes
dat = as.numeric(tutorial.R)
dat[sample(1:length(dat), 100)] <-  9
dat <- matrix(dat, nrow = 50, ncol = 400)
write.lfmm(dat, "genoM.lfmm")

## ----results='hide'-----------------------------------------------------------
project.missing = snmf("genoM.lfmm", K = 4, 
        entropy = TRUE, repetitions = 10,
        project = "new")

## -----------------------------------------------------------------------------
# select the run with the lowest cross-entropy value
best = which.min(cross.entropy(project.missing, K = 4))

# Impute the missing genotypes
impute(project.missing, "genoM.lfmm", 
       method = 'mode', K = 4, run = best)

# Proportion of correct imputation results
dat.imp = read.lfmm("genoM.lfmm_imputed.lfmm")
mean( tutorial.R[dat == 9] == dat.imp[dat == 9] )

## ----results='hide'-----------------------------------------------------------
# main options: 
# K = the number of latent factors
# Runs with K = 6 using 5 repetitions.
project = NULL
project = lfmm("genotypes.lfmm", 
               "gradients.env", 
                K = 6, 
                repetitions = 5, 
                project = "new")

## -----------------------------------------------------------------------------
# compute adjusted p-values
p = lfmm.pvalues(project, K = 6)
pvalues = p$pvalues

## ----fig.width=8, fig.height=6, echo=TRUE-------------------------------------
# GEA significance test
par(mfrow = c(2,1))
hist(pvalues, col = "lightblue")
plot(-log10(pvalues), pch = 19, col = "blue", cex = .7)

## -----------------------------------------------------------------------------
for (alpha in c(.05,.1,.15,.2)) {
    # expected FDR
    print(paste("Expected FDR:", alpha))
    L = length(pvalues)
 
    # return a list of candidates with expected FDR alpha.
    # Benjamini-Hochberg's algorithm:
    w = which(sort(pvalues) < alpha * (1:L) / L)
    candidates = order(pvalues)[w]

    # estimated FDR and True Positive Rate
    Lc = length(candidates)
    estimated.FDR = sum(candidates <= 350)/Lc
    print(paste("Observed FDR:", 
                round(estimated.FDR, digits = 2)))    
    estimated.TPR = sum(candidates > 350)/50
    print(paste("Estimated TPR:", 
                round(estimated.TPR, digits = 2)))  
}

## -----------------------------------------------------------------------------
# load simulated data 
data("offset_example")
# 200 diploid individuals genotyped at 510 SNP
Y <- offset_example$geno
# 4 environmental variables
X <- offset_example$env

mod.lfmm2 <- lfmm2(input = Y, env = X, K = 2)

## ----fig.width=8, fig.height=6, echo=TRUE-------------------------------------
# GEA significance test
# showing the K = 2 estimated factors 
plot(mod.lfmm2@U, col = "grey", pch = 19, 
     xlab = "Factor 1", 
     ylab = "Factor 2")

## ----fig.width=8, fig.height=6, echo=TRUE-------------------------------------
pv <- lfmm2.test(object = mod.lfmm2, 
                 input = Y, 
                 env = X, 
                 full = TRUE)
plot(-log10(pv$pvalues), col = "grey", cex = .5, pch = 19)
abline(h = -log10(0.1/510), lty = 2, col = "orange")  

## -----------------------------------------------------------------------------
# Simulate non-null effect sizes for 10 target loci 
#individuals
n = 100  
#loci
L = 1000 
# Environmental variable
X = as.matrix(rnorm(n)) 
# effect sizes
B = rep(0, L) 
target = sample(1:L, 10) 
B[target] = runif(10, -10, 10) 

## -----------------------------------------------------------------------------
# Create 3 hidden factors and their loadings
U = t(tcrossprod(as.matrix(c(-1,0.5,1.5)), X)) + 
    matrix(rnorm(3*n), ncol = 3)

V <- matrix(rnorm(3*L), ncol = 3)

## -----------------------------------------------------------------------------
# Simulate a matrix containing haploid genotypes 
Y <-  tcrossprod(as.matrix(X), B) + 
      tcrossprod(U, V) + 
      matrix(rnorm(n*L, sd = .5), nrow = n)

Y <- matrix(as.numeric(Y > 0), ncol = L)

## -----------------------------------------------------------------------------
# Fitting an LFMM with K = 3 factors
mod <- lfmm2(input = Y, env = X, K = 3)

## ----fig.width=8, fig.height=6, echo=TRUE, results='hide'---------------------
# Computing P-values and plotting their minus log10 values 
pv <- lfmm2.test(object = mod, 
                 input = Y, 
                 env = X, 
                 linear = TRUE)

plot(-log10(pv$pvalues), col = "grey", cex = .6, pch = 19)
points(target, -log10(pv$pvalues[target]), col = "red")

## -----------------------------------------------------------------------------
data("offset_example")
Y <- offset_example$geno
X <- offset_example$env
X.pred <- offset_example$env.pred

## -----------------------------------------------------------------------------
g.gap.scaled <- genetic.gap(input = Y, 
                           env = X, 
                           pred.env = X.pred,
                           scale = TRUE,
                           K = 2)

## -----------------------------------------------------------------------------
g.gap.scaled$vectors[,1:2]^2

## ----fig.width=12, fig.height=6, echo=TRUE, results='hide'--------------------
par(mfrow = c(1,2))

barplot(g.gap.scaled$eigenvalues,
        col = "orange", 
        xlab = "Axes", 
        ylab = "Eigenvalues")

Delta = X[,1:2] - X.pred[,1:2]
squared.env.dist = rowSums(Delta^2)  
plot(squared.env.dist, g.gap.scaled$offset,  cex = .6)


## ----echo=FALSE, results='hide'-----------------------------------------------
# Copy of the pdf figures in the previous directory 
# for the creation of the vignette.
file.copy(list.files(".", pattern = ".pdf"), "..")

