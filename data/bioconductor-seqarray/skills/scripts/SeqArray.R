# Code example from 'SeqArray' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------------------------------------
options(width=110)

## -----------------------------------------------------------------------------------------------------------
library(SeqArray)

# open a SeqArray file in the package (1000 Genomes Phase1, chromosome 22)
file <- seqOpen(seqExampleFileName("KG_Phase1"))

seqSummary(file)

## -----------------------------------------------------------------------------------------------------------
af <- seqApply(file, "genotype", as.is="double", margin="by.variant",
    FUN=function(x) { mean(x==0L, na.rm=TRUE) })
head(af)

## -----------------------------------------------------------------------------------------------------------
library(Rcpp)

cppFunction("
    double CalcAlleleFreq(IntegerVector x)
    {
        int len=x.size(), n=0, n0=0;
        for (int i=0; i < len; i++)
        {
            int g = x[i];
            if (g != NA_INTEGER)
            {
                n++;
                if (g == 0) n0++;
            }
        }
        return double(n0) / n;
    }")

## -----------------------------------------------------------------------------------------------------------
af <- seqApply(file, "genotype", as.is="double", margin="by.variant", FUN=CalcAlleleFreq)
head(af)

## -----------------------------------------------------------------------------------------------------------
af <- seqApply(file, "genotype", as.is="double",
    margin="by.variant", FUN=function(x) { mean(x==0L, na.rm=TRUE) }, parallel=2)
head(af)

## -----------------------------------------------------------------------------------------------------------
# covariance variable with an initial value
s <- 0

seqBlockApply(file, "$dosage", function(x)
    {
        p <- 0.5 * colMeans(x, na.rm=TRUE)     # allele frequencies (a vector)
        g <- (t(x) - 2*p) / sqrt(p*(1-p))      # normalized by allele frequency
        g[is.na(g)] <- 0                       # correct missing values
        s <<- s + crossprod(g)                 # update the cov matrix s in the parent environment
    }, margin="by.variant", .progress=TRUE)

# scaled by the number of samples over the trace
s <- s * (nrow(s) / sum(diag(s)))

# eigen-decomposition
eig <- eigen(s, symmetric=TRUE)

## ----fig.width=5, fig.height=5, fig.align='center'----------------------------------------------------------
# figure
plot(eig$vectors[,1], eig$vectors[,2], xlab="PC 1", ylab="PC 2")

## -----------------------------------------------------------------------------------------------------------
# use 2 cores for demonstration
seqParallelSetup(2)

# numbers of distinct alleles per site
table(seqNumAllele(file))

# reference allele frequencies
summary(seqAlleleFreq(file, ref.allele=0L))

# close the cluster environment
seqParallelSetup(FALSE)

## ----message=FALSE------------------------------------------------------------------------------------------
library(VariantAnnotation)

## -----------------------------------------------------------------------------------------------------------
# select a region [10Mb, 30Mb] on chromosome 22
seqSetFilterChrom(file, 22, from.bp=10000000, to.bp=30000000)

vcf <- seqAsVCF(file, chr.prefix="chr")
vcf

## ----echo=FALSE---------------------------------------------------------------------------------------------
unlink("exons.vcf.gz", force=TRUE)

## ----message=FALSE------------------------------------------------------------------------------------------
library(Biobase)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# library(SeqVarTools)

## -----------------------------------------------------------------------------------------------------------
data(KG_P1_SampData)
KG_P1_SampData

head(pData(KG_P1_SampData))  # show KG_P1_SampData

## ----eval=FALSE---------------------------------------------------------------------------------------------
# # link sample data to SeqArray file
# seqData <- SeqVarData(file, sample.data)
# 
# # set sample and variant filters
# female <- sampleData(seqData)$sex == "female"
# seqSetFilter(seqData, sample.sel=female)
# 
# # run linear regression
# res <- regression(seqData, outcome="phenotype", covar="age")
# head(res)

## -----------------------------------------------------------------------------------------------------------
library(SNPRelate)

set.seed(1000)

# may try different LD thresholds for sensitivity analysis
snpset <- snpgdsLDpruning(file, ld.threshold=0.2, maf=0.01)
names(snpset)
head(snpset$chr22)  # variant.id

# get all selected variant id
snpset.id <- unlist(snpset)

## -----------------------------------------------------------------------------------------------------------
# Run PCA
pca <- snpgdsPCA(file, snp.id=snpset.id, num.thread=2)

# variance proportion (%)
pc.percent <- pca$varprop*100
head(round(pc.percent, 2))

## ----fig.width=5, fig.height=5, fig.align='center'----------------------------------------------------------
# plot the first 4 eigenvectors with character=20 and size=0.5
plot(pca, eig=1:4, pch=20, cex=0.5)

## -----------------------------------------------------------------------------------------------------------
pop.code <- factor(seqGetData(file, "sample.annotation/Population"))
head(pop.code)

popgroup <- list(
    EastAsia = c("CHB", "JPT", "CHS", "CDX", "KHV", "CHD"),
	European = c("CEU", "TSI", "GBR", "FIN", "IBS"),
	African  = c("ASW", "ACB", "YRI", "LWK", "GWD", "MSL", "ESN"),
	SouthAmerica = c("MXL", "PUR", "CLM", "PEL"),
	India = c("GIH", "PJL", "BEB", "STU", "ITU"))

colors <- sapply(levels(pop.code), function(x) {
	for (i in 1:length(popgroup)) {
		if (x %in% popgroup[[i]])
			return(names(popgroup)[i])
	}
	NA
	})
colors <- as.factor(colors)
legend.text <- sapply(levels(colors), function(x) paste(levels(pop.code)[colors==x], collapse=","))
legend.text

## ----fig.width=5, fig.height=5, fig.align='center'----------------------------------------------------------
# make a data.frame
tab <- data.frame(sample.id = pca$sample.id,
    EV1 = pca$eigenvect[,1],    # the first eigenvector
    EV2 = pca$eigenvect[,2],    # the second eigenvector
    Population = pop.code, stringsAsFactors = FALSE)
head(tab)

# draw
plot(pca, pch=20, cex=0.75, main="1KG Phase 1, chromosome 22", col=colors[tab$Population])
legend("topright", legend=legend.text, col=1:length(legend.text), pch=19, cex=0.75)

## -----------------------------------------------------------------------------------------------------------
# YRI samples
sample.id <- seqGetData(file, "sample.id")
CEU.id <- sample.id[pop.code == "CEU"]

## ----fig.width=5, fig.height=5, fig.align='center'----------------------------------------------------------
# Estimate IBD coefficients
ibd <- snpgdsIBDMoM(file, sample.id=CEU.id, snp.id=snpset.id, num.thread=2)

# Make a data.frame
ibd.coeff <- snpgdsIBDSelection(ibd)
head(ibd.coeff)

plot(ibd.coeff$k0, ibd.coeff$k1, xlim=c(0,1), ylim=c(0,1), xlab="k0", ylab="k1", main="CEU samples (MoM)")
lines(c(0,1), c(1,0), col="red", lty=2)

## -----------------------------------------------------------------------------------------------------------
set.seed(1000)
ibs.hc <- snpgdsHCluster(snpgdsIBS(file, snp.id=snpset.id, num.thread=2))

## ----fig.width=10, fig.height=5, fig.align='center'---------------------------------------------------------
# Determine groups of individuals by population information
rv <- snpgdsCutTree(ibs.hc, samp.group=as.factor(colors[pop.code]))

plot(rv$dendrogram, leaflab="none", main="1KG Phase 1, chromosome 22",
    edgePar=list(col=rgb(0.5,0.5,0.5,0.75), t.col="black"))
legend("bottomleft", legend=legend.text, col=1:length(legend.text), pch=19, cex=0.75, ncol=4)

## ----fig.width=10, fig.height=5, fig.align='center'---------------------------------------------------------
# sliding windows (window size: 500kb)
sw <- snpgdsSlidingWindow(file, winsize=500000, shift=100000,
    FUN="snpgdsFst", as.is="numeric", population=pop.code)

plot(sw$chr22.pos/1000, sw$chr22.val, xlab="genome coordinate (kb)", ylab="population-average Fst",
    main="1KG Phase 1, chromosome 22")
abline(h=mean(sw$chr22.val), lty=3, col="red", lwd=2)

## -----------------------------------------------------------------------------------------------------------
seqClose(file)

## -----------------------------------------------------------------------------------------------------------
sessionInfo()

