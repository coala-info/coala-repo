# Code example from 'shearwaterML' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(deepSNV)
regions <- GRanges("B.FR.83.HXB2_LAI_IIIB_BRU_K034", IRanges(start = 3120, end=3140))
files <- c(system.file("extdata", "test.bam", package="deepSNV"), system.file("extdata", "control.bam", package="deepSNV"))
counts <- loadAllData(files, regions, q=30)

## -----------------------------------------------------------------------------
pvals <- betabinLRT(counts, rho=1e-4, maxtruncate = 1)$pvals
qvals <- p.adjust(pvals, method="BH")
dim(qvals) = dim(pvals)
vcfML = qvals2Vcf(qvals, counts, regions, samples = files, mvcf = TRUE)

## -----------------------------------------------------------------------------
bf <- bbb(counts, model = "OR", rho=1e-4)
vcfBF <- bf2Vcf(bf, counts, regions, samples = files, prior = 0.5, mvcf = TRUE)

plot(pvals[1,,], bf[1,,]/(1+bf[1,,]), log="xy")

