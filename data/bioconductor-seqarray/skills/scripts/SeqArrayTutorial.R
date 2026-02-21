# Code example from 'SeqArrayTutorial' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------------------------------------
options(width=110L)

## -----------------------------------------------------------------------------------------------------------
# load the R package SeqArray
library(SeqArray)

library(Rcpp)

## -----------------------------------------------------------------------------------------------------------
gds.fn <- seqExampleFileName("gds")
# or gds.fn <- "C:/YourFolder/Your_GDS_File.gds"
gds.fn

seqSummary(gds.fn)

## -----------------------------------------------------------------------------------------------------------
# open a GDS file
genofile <- seqOpen(gds.fn)

# display the contents of the SeqArray file in a hierarchical structure
genofile

## -----------------------------------------------------------------------------------------------------------
# display all contents of the GDS file
print(genofile, all=TRUE, attribute=TRUE)

# close the GDS file
seqClose(genofile)

## -----------------------------------------------------------------------------------------------------------
# the VCF file, using the example in the SeqArray package
vcf.fn <- seqExampleFileName("vcf")
# or vcf.fn <- "C:/YourFolder/Your_VCF_File.vcf"
vcf.fn

# parse the header
seqVCF_Header(vcf.fn)

## -----------------------------------------------------------------------------------------------------------
# compress data with the zlib compression algorithm when random-access memory is limited
seqVCF2GDS(vcf.fn, "tmp.gds", storage.option="ZIP_RA")

seqSummary("tmp.gds")

## ----echo=FALSE---------------------------------------------------------------------------------------------
unlink("tmp.gds")

## -----------------------------------------------------------------------------------------------------------
# the file of GDS
gds.fn <- seqExampleFileName("gds")
# or gds.fn <- "C:/YourFolder/Your_GDS_File.gds"

# open a GDS file
genofile <- seqOpen(gds.fn)

# convert
seqGDS2VCF(genofile, "tmp.vcf.gz")
# read
s <- readLines("tmp.vcf.gz", n=22)
s[nchar(s) > 80] <- paste(substr(s[nchar(s) > 80], 1, 80), "...")
cat(s, sep="\n")

# output BN,GP,AA,HM2 in INFO (the variables are in this order), no FORMAT
seqGDS2VCF(genofile, "tmp2.vcf.gz", info.var=c("BN","GP","AA","HM2"),
    fmt.var=character())
# read
s <- readLines("tmp2.vcf.gz", n=16)
s[nchar(s) > 80] <- paste(substr(s[nchar(s) > 80], 1, 80), "...")
cat(s, sep="\n")

# close the GDS file
seqClose(genofile)

## -----------------------------------------------------------------------------------------------------------
# delete temporary files
unlink(c("tmp.vcf.gz", "tmp1.vcf.gz", "tmp2.vcf.gz"))

## -----------------------------------------------------------------------------------------------------------
# the file of VCF
vcf.fn <- seqExampleFileName("vcf")
# or vcf.fn <- "C:/YourFolder/Your_VCF_File.vcf"

# convert
seqVCF2GDS(vcf.fn, "tmp.gds", storage.option="ZIP_RA", verbose=FALSE)

# make sure that open with "readonly=FALSE"
genofile <- seqOpen("tmp.gds", readonly=FALSE)

# display the original structure
genofile

# delete "HM2", "HM3", "AA", "OR" and "DP"
seqDelete(genofile, info.var=c("HM2", "HM3", "AA", "OR"), fmt.var="DP")

# display
genofile

# close the GDS file
seqClose(genofile)

# clean up the fragments to reduce the file size
cleanup.gds("tmp.gds")

## ----echo=FALSE---------------------------------------------------------------------------------------------
unlink("tmp.gds")

## -----------------------------------------------------------------------------------------------------------
# open a GDS file
gds.fn <- seqExampleFileName("gds")
genofile <- seqOpen(gds.fn)

## -----------------------------------------------------------------------------------------------------------
# take out sample id
head(samp.id <- seqGetData(genofile, "sample.id"))

# take out variant id
head(variant.id <- seqGetData(genofile, "variant.id"))

# get "chromosome"
table(seqGetData(genofile, "chromosome"))

# get "allele"
head(seqGetData(genofile, "allele"))

# get "annotation/info/GP"
head(seqGetData(genofile, "annotation/info/GP"))

# get "sample.annotation/family"
head(seqGetData(genofile, "sample.annotation/family"))

## -----------------------------------------------------------------------------------------------------------
# set sample and variant filters
seqSetFilter(genofile, sample.id=samp.id[c(2,4,6)])
# or, seqSetFilter(genofile, sample.sel=c(2,4,6))
set.seed(100)
seqSetFilter(genofile, variant.id=sample(variant.id, 4))

# get "allele"
seqGetData(genofile, "allele")

## -----------------------------------------------------------------------------------------------------------
# get genotypic data
seqGetData(genofile, "genotype")

## -----------------------------------------------------------------------------------------------------------
# get the dosage of reference allele
seqGetData(genofile, "$dosage")

## -----------------------------------------------------------------------------------------------------------
# get "annotation/info/AA", a variable-length dataset
seqGetData(genofile, "annotation/info/AA")

## -----------------------------------------------------------------------------------------------------------
# get "annotation/format/DP", a variable-length dataset
seqGetData(genofile, "annotation/format/DP")

## -----------------------------------------------------------------------------------------------------------
# set sample and variant filters
set.seed(100)
seqSetFilter(genofile, sample.id=samp.id[c(2,4,6)], variant.id=sample(variant.id, 4))

# read multiple variables variant by variant
seqApply(genofile, c(geno="genotype", id="annotation/id"), FUN=print, margin="by.variant", as.is="none")

# read genotypes sample by sample
seqApply(genofile, "genotype", FUN=print, margin="by.sample", as.is="none")

seqApply(genofile, c(sample.id="sample.id", genotype="genotype"), FUN=print, margin="by.sample", as.is="none")

## -----------------------------------------------------------------------------------------------------------
# remove the sample and variant filters
seqResetFilter(genofile)

# get the numbers of alleles per variant
z <- seqApply(genofile, "allele",
    FUN=function(x) length(unlist(strsplit(x,","))), as.is="integer")
table(z)

## -----------------------------------------------------------------------------------------------------------
HM3 <- seqGetData(genofile, "annotation/info/HM3")

# Now HM3 is a global variable
# print out RS id if the frequency of reference allele is less than 0.5% and it is HM3
seqApply(genofile, c(geno="genotype", id="annotation/id"),
    FUN = function(index, x) {
        p <- mean(x$geno == 0, na.rm=TRUE)  # the frequency of reference allele
        if ((p < 0.005) & HM3[index]) print(x$id)
    }, as.is="none", var.index="relative", margin="by.variant")

## -----------------------------------------------------------------------------------------------------------
# calculate the frequency of reference allele,
afreq <- seqApply(genofile, "genotype", FUN=function(x) mean(x==0L, na.rm=TRUE),
    as.is="double", margin="by.variant")
length(afreq)
summary(afreq)

## -----------------------------------------------------------------------------------------------------------
# load the "parallel" package
library(parallel)

# choose an appropriate cluster size (or # of cores)
seqParallelSetup(2)

# run in parallel
afreq <- seqParallel(, genofile, FUN = function(f) {
        seqApply(f, "genotype", as.is="double", FUN=function(x) mean(x==0L, na.rm=TRUE))
    }, split = "by.variant")

length(afreq)
summary(afreq)

# Close the GDS file
seqClose(genofile)

## -----------------------------------------------------------------------------------------------------------
# open a GDS file
gds.fn <- seqExampleFileName("gds")
genofile <- seqOpen(gds.fn)

## -----------------------------------------------------------------------------------------------------------
# apply the function marginally
m.variant <- seqApply(genofile, "genotype", function(x) mean(is.na(x)),
    margin="by.variant", as.is="double", .progress=TRUE)
# output
length(m.variant); summary(m.variant)

## -----------------------------------------------------------------------------------------------------------
cppFunction("
    double mean_na(IntegerVector x)
    {
        int len=x.size(), n=0;
        for (int i=0; i < len; i++)
        {
            if (x[i] == NA_INTEGER) n++;
        }
        return double(n) / len;
    }")

summary(seqApply(genofile, "genotype", mean_na, margin="by.variant", as.is="double"))

## -----------------------------------------------------------------------------------------------------------
# apply the function marginally
m.variant <- seqBlockApply(genofile, "genotype", function(x) {
        colMeans(is.na(x), dims=2L)
    }, margin="by.variant", as.is="unlist")
# output
summary(m.variant)

## -----------------------------------------------------------------------------------------------------------
# apply the function marginally with two cores
m.variant <- seqBlockApply(genofile, "genotype", function(x) colMeans(is.na(x), dims=2L),
    margin="by.variant", as.is="unlist", parallel=2)
# output
summary(m.variant)

## -----------------------------------------------------------------------------------------------------------
# Or call the function in SeqArray
summary(seqMissing(genofile))

## -----------------------------------------------------------------------------------------------------------
# get ploidy, the number of samples and variants
# dm[1] -- ploidy, dm[2] -- # of selected samples, dm[3] -- # of selected variants
dm <- seqSummary(genofile, "genotype", verbose=FALSE)$seldim

# an initial value
n <- 0L

# apply the function marginally
seqApply(genofile, "genotype", function(x) {
        n <<- n + is.na(x)    # use "<<-" operator to update 'n' in the parent environment
    }, margin="by.variant", .progress=TRUE)

# output
m.samp <- colMeans(n) / dm[3L]
length(m.samp); summary(m.samp)

## -----------------------------------------------------------------------------------------------------------
cppFunction("
    void add_na_num(IntegerVector x, IntegerVector num)
    {
        int len=x.size();
        for (int i=0; i < len; i++)
        {
            if (x[i] == NA_INTEGER) num[i]++;
        }
    }")

n <- matrix(0L, nrow=dm[1L], ncol=dm[2L])
seqApply(genofile, "genotype", add_na_num, margin="by.variant", num=n)

summary(colMeans(n) / dm[3L])

## -----------------------------------------------------------------------------------------------------------
# an initial value
n <- 0L

# apply the function marginally
seqBlockApply(genofile, "genotype", function(x) {
        n <<- n + rowSums(is.na(x), dims=2L)    # use "<<-" operator to update 'n' in the parent environment
    }, margin="by.variant")

# output
m.samp <- colMeans(n) / dm[3L]
summary(m.samp)

## -----------------------------------------------------------------------------------------------------------
# the datasets are automatically split into two non-overlapping parts
n <- seqParallel(2, genofile, FUN = function(f)
    {
        n <- 0L    # an initial value
        seqBlockApply(f, "genotype", function(x) {
            n <<- n + rowSums(is.na(x), dims=2L)    # use "<<-" operator to update 'n' in the parent environment
        }, margin="by.variant")
        n    #output
    }, .combine = "+",     # sum "n" of different processes together
    split = "by.variant")

# output
m.samp <- colMeans(n) / dm[3L]
summary(m.samp)

## -----------------------------------------------------------------------------------------------------------
# Call the function in SeqArray
summary(seqMissing(genofile, per.variant=FALSE))

## -----------------------------------------------------------------------------------------------------------
# apply the function variant by variant
afreq <- seqApply(genofile, "genotype", FUN=function(x) mean(x==0L, na.rm=TRUE),
    as.is="double", margin="by.variant", .progress=TRUE)

length(afreq); summary(afreq)

## -----------------------------------------------------------------------------------------------------------
cppFunction("
    double calc_freq(IntegerVector x)
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

summary(seqApply(genofile, "genotype", FUN=calc_freq, as.is="double", margin="by.variant"))

## -----------------------------------------------------------------------------------------------------------
# apply the function variant by variant
afreq <- seqBlockApply(genofile, "genotype", FUN=function(x) {
        colMeans(x==0L, na.rm=TRUE, dims=2L)
    }, as.is="unlist", margin="by.variant")

summary(afreq)

## -----------------------------------------------------------------------------------------------------------
# apply the function over variants with two cores
afreq <- seqBlockApply(genofile, "genotype", FUN=function(x) {
        colMeans(x==0L, na.rm=TRUE, dims=2L)
    }, as.is="unlist", margin="by.variant", parallel=2)

summary(afreq)

## -----------------------------------------------------------------------------------------------------------
# Call the function in SeqArray
summary(seqAlleleFreq(genofile))

## -----------------------------------------------------------------------------------------------------------
# covariance variable with an initial value
s <- 0

seqApply(genofile, "$dosage", function(x)
    {
        p <- 0.5 * mean(x, na.rm=TRUE)    # allele frequency
        g <- (x - 2*p) / sqrt(p*(1-p))    # normalization
        g[is.na(g)] <- 0                  # missing values
        s <<- s + (g %o% g)               # update the cov matrix 's' in the parent environment
    }, margin="by.variant", .progress=TRUE)

# scaled by the number of samples over the trace
s <- s * (nrow(s) / sum(diag(s)))
# eigen-decomposition
eig <- eigen(s)

# eigenvalues
head(eig$value)

## ----fig.width=4, fig.height=4, fig.align='center'----------------------------------------------------------
# eigenvectors
plot(eig$vectors[,1], eig$vectors[,2], xlab="PC 1", ylab="PC 2")

## -----------------------------------------------------------------------------------------------------------
# covariance variable with an initial value
s <- 0

seqBlockApply(genofile, "$dosage", function(x)
    {
        p <- 0.5 * colMeans(x, na.rm=TRUE)     # allele frequencies (a vector)
        g <- (t(x) - 2*p) / sqrt(p*(1-p))      # normalized by allele frequencies
        g[is.na(g)] <- 0                       # correct missing values
        s <<- s + crossprod(g)                 # update the cov matrix 's' in the parent environment
    }, margin="by.variant", .progress=TRUE)

# scaled by the number of samples over the trace
s <- s * (nrow(s) / sum(diag(s)))
# eigen-decomposition
eig <- eigen(s)

# eigenvalues
head(eig$value)

## -----------------------------------------------------------------------------------------------------------
# the datasets are automatically split into two non-overlapping parts
genmat <- seqParallel(2, genofile, FUN = function(f)
    {
        s <- 0  # covariance variable with an initial value
        seqBlockApply(f, "$dosage", function(x)
            {
                p <- 0.5 * colMeans(x, na.rm=TRUE)     # allele frequencies (a vector)
                g <- (t(x) - 2*p) / sqrt(p*(1-p))      # normalized by allele frequency
                g[is.na(g)] <- 0                       # correct missing values
                s <<- s + crossprod(g)                 # update the cov matrix 's' in the parent environment
            }, margin="by.variant")
        s  # output
    }, .combine = "+",     # sum "s" of different processes together
    split = "by.variant")

# scaled by the number of samples over the trace
genmat <- genmat * (nrow(genmat) / sum(diag(genmat)))
# eigen-decomposition
eig <- eigen(genmat)

# eigenvalues
head(eig$value)

## -----------------------------------------------------------------------------------------------------------
# initial values
n <- 0; s <- 0

seqApply(genofile, "$dosage", function(g)
    {
        p <- 0.5 * mean(g, na.rm=TRUE)    # allele frequency
        d <- (g*g - g*(1 + 2*p) + 2*p*p) / (2*p*(1-p))
        n <<- n + is.finite(d)            # output to the global variable 'n'
        d[!is.finite(d)] <- 0
        s <<- s + d                       # output to the global variable 's'
    }, margin="by.variant", as.is="none", .progress=TRUE)

# output
coeff <- s / n
summary(coeff)

## -----------------------------------------------------------------------------------------------------------
# initial values
n <- 0; s <- 0

seqBlockApply(genofile, "$dosage", function(g)
    {
        p <- 0.5 * colMeans(g, na.rm=TRUE)     # allele frequencies (a vector)
        g <- t(g)
        d <- (g*g - g*(1 + 2*p) + 2*p*p) / (2*p*(1-p))
        n <<- n + colSums(is.finite(d))        # output to the global variable 'n'
        s <<- s + colSums(d, na.rm=TRUE)       # output to the global variable 's'
    }, margin="by.variant", as.is="none", .progress=TRUE)

# output
summary(coeff <- s / n)

## -----------------------------------------------------------------------------------------------------------
# the datasets are automatically split into two non-overlapping parts
coeff <- seqParallel(2, genofile, FUN = function(f)
    {
        # initial values
        n <- 0; s <- 0
        seqApply(f, "$dosage", function(g)
            {
                p <- 0.5 * mean(g, na.rm=TRUE)    # allele frequency
                d <- (g*g - g*(1 + 2*p) + 2*p*p) / (2*p*(1-p))
                n <<- n + is.finite(d)            # output to the global variable 'n'
                d[!is.finite(d)] <- 0
                s <<- s + d                       # output to the global variable 's'
            }, margin="by.variant")
        # output
        list(s=s, n=n)
    }, # sum all variables 's' and 'n' of different processes
    .combine = function(x1, x2) { list(s = x1$s + x2$s, n = x1$n + x2$n) },
    split = "by.variant")

# finally, average!
coeff <- coeff$s / coeff$n

summary(coeff)

## -----------------------------------------------------------------------------------------------------------
# close the GDS file
seqClose(genofile)

## -----------------------------------------------------------------------------------------------------------
sessionInfo()

