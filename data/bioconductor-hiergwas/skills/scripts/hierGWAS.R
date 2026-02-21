# Code example from 'hierGWAS' vignette. See references/ for full tutorial.

### R code from vignette source 'hierGWAS.Rnw'

###################################################
### code chunk number 1: data
###################################################
library(hierGWAS)
data(simGWAS)
sim.geno <- data.matrix(simGWAS[,1:1000])
sim.pheno <- simGWAS$y
sim.covar <- cbind(simGWAS$sex,simGWAS$age)


###################################################
### code chunk number 2: cluster SNPs
###################################################
# cluster SNPs in chromosome 1
SNPindex.chrom1 <- seq(1,500)
dendr.chrom1 <- cluster.snp(sim.geno,SNP_index = SNPindex.chrom1)

# cluster SNPs in chromosome 2
SNPindex.chrom2 <- seq(501,1000)
dendr.chrom2 <- cluster.snp(sim.geno,SNP_index = SNPindex.chrom2)


###################################################
### code chunk number 3: multi split
###################################################
res.multisplit <- multisplit(sim.geno,sim.pheno,covar = sim.covar)
# the matrix of selected coefficients for each sample split
show(res.multisplit$sel.coeff[1:10,1:10])
# the samples which will be used for testing
show(res.multisplit$out.sample[1:10,1:10])


###################################################
### code chunk number 4: hierarchical testing
###################################################
result.chrom1 <- test.hierarchy(sim.geno, sim.pheno, dendr.chrom1, res.multisplit,
                                covar = sim.covar, SNP_index = SNPindex.chrom1)
result.chrom2 <- test.hierarchy(sim.geno, sim.pheno, dendr.chrom1, res.multisplit,
                                covar = sim.covar, SNP_index = SNPindex.chrom2,
                                global.test = FALSE, verbose = FALSE)
show(result.chrom2)


###################################################
### code chunk number 5: r2 computation
###################################################
SNP_index <- seq(991,1000)
res.r2 <- compute.r2(sim.geno, sim.pheno, res.multisplit, covar = sim.covar, SNP_index = SNP_index)
show(res.r2)


###################################################
### code chunk number 6: session info
###################################################
sessionInfo()


