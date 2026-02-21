# Code example from 'RVS' vignette. See references/ for full tutorial.

## ----include=FALSE, cache=FALSE-----------------------------------------------
suppressMessages(library(RVS))
suppressMessages(library(kinship2))
suppressMessages(library(snpStats))

## -----------------------------------------------------------------------------
data(samplePedigrees)

# store the pedigrees
fam_type_A <- samplePedigrees$firstCousinPair
fam_type_B <- samplePedigrees$secondCousinPair
fam_type_C <- samplePedigrees$firstCousinTriple
fam_type_D <- samplePedigrees$secondCousinTriple

# re-label the family ids for this example
fam_type_A$famid <- rep('SF_A', length(fam_type_A$id))
fam_type_B$famid <- rep('SF_B', length(fam_type_B$id))
fam_type_C$famid <- rep('SF_C', length(fam_type_C$id))
fam_type_D$famid <- rep('SF_D', length(fam_type_D$id))

## -----------------------------------------------------------------------------
plot(fam_type_D)

## -----------------------------------------------------------------------------
p <- RVsharing(fam_type_D)

## -----------------------------------------------------------------------------
# compute the sharing probabilities for all families
fams <- list(fam_type_A, fam_type_B, fam_type_C, fam_type_D)
sharing_probs <- suppressMessages(RVsharing(fams))
signif(sharing_probs, 3)

# compute p-value for this sharing pattern
sharing_pattern <- c(TRUE, TRUE, FALSE, FALSE)
names(sharing_pattern) <- names(sharing_probs)
multipleFamilyPValue(sharing_probs, sharing_pattern)

## -----------------------------------------------------------------------------
pedfile <- system.file("extdata/sample.ped.gz", package="RVS")
sample <- snpStats::read.pedfile(pedfile, snps=paste('variant', LETTERS[1:20], sep='_'))

## -----------------------------------------------------------------------------
A_fams <- lapply(1:3, function(i) samplePedigrees$firstCousinPair)
B_fams <- lapply(1:3, function(i) samplePedigrees$secondCousinPair)
C_fams <- lapply(1:3, function(i) samplePedigrees$firstCousinTriple)
D_fams <- lapply(1:3, function(i) samplePedigrees$secondCousinTriple)
fams <- c(A_fams, B_fams, C_fams, D_fams)
famids <- unique(sample$fam$pedigree)
for (i in 1:12)
{
    fams[[i]]$famid <- rep(famids[i], length(fams[[i]]$id))
}
sharingProbs <- suppressMessages(RVsharing(fams))
signif(sharingProbs, 3)

## -----------------------------------------------------------------------------
result <- multipleVariantPValue(sample$genotypes, sample$fam, sharingProbs)
signif(result$pvalues, 3)

## -----------------------------------------------------------------------------
result <- multipleVariantPValue(sample$genotypes, sample$fam, sharingProbs, filter='bonferroni', alpha=0.05)

## -----------------------------------------------------------------------------
pvals <- result$pvalues
ppvals <- result$potential_pvalues
ppvals_sub <- ppvals[names(pvals)] # subset potential p-values

plot(-log10(ppvals[order(ppvals)]), ylab="-log10 p-value", col="blue", type="l", xaxt="n", xlab="variants", ylim=c(0,8))
xlabel <- sapply(names(ppvals)[order(ppvals)], function(str) substr(str, nchar(str), nchar(str)))
axis(1, at=1:length(ppvals), labels=xlabel)
points(-log10(pvals[order(ppvals_sub)]), pch=20, cex=1.3)
bcut <- 0.05/(1:20)
lines(1:20,-log10(bcut),col="red",type="b",pch=20)

## -----------------------------------------------------------------------------
# calculate p-values for each MAF
freq <- seq(0,0.05,0.005)
variants <- names(sort(result$pvalues))[1:3]
pvals <- matrix(nrow=length(freq), ncol=length(variants))
pvals[1,] = sort(result$pvalues)[1:3]
for (i in 2:length(freq))
{
    sharingProbs <- suppressMessages(RVsharing(fams, alleleFreq=freq[i]))
    pvals[i,] <- multipleVariantPValue(sample$genotypes[,variants], sample$fam, sharingProbs)$pvalues
}
colnames(pvals) <- variants

# plot p-values as a function of MAF
plot(NULL, xlim=c(min(freq),max(freq)), ylim=c(0,max(pvals)), type='l',
    xlab="minor allele frequency", ylab="p-value",
    main="sensitivity of p-value to allele frequency in three variants")
lines(freq, pvals[,1], col="black")
lines(freq, pvals[,2], col="red")
lines(freq, pvals[,3], col="blue")
legend(min(freq), max(pvals), legend=colnames(pvals), col=c("black", "red", "blue"), lty=1)

## -----------------------------------------------------------------------------
# calculate p-values for each kinship coefficient
kin_coef <- seq(0, 0.05, length=6)
variants <- names(sort(result$pvalues))[1:3]
pvals <- matrix(nrow=length(kin_coef), ncol=length(variants))
pvals[1,] = sort(result$pvalues)[1:3]
for (i in 2:length(kin_coef))
{
    sharingProbs <- suppressMessages(RVsharing(fams, kinshipCoeff=kin_coef[i]))
    pvals[i,] <- multipleVariantPValue(sample$genotypes[,variants], sample$fam, sharingProbs)$pvalues
}
colnames(pvals) <- variants

# plot p-values as a function of kinship
plot(NULL, xlim=c(min(kin_coef), max(kin_coef)), ylim=c(0,max(pvals)), type='l',
    xlab="kinship coefficient", ylab="p-value",
    main="sensitivity of p-value to kinship in three variants")
lines(kin_coef, pvals[,1], col="black")
lines(kin_coef, pvals[,2], col="red")
lines(kin_coef, pvals[,3], col="blue")
legend(min(kin_coef), max(pvals), legend=colnames(pvals), col=c("black", "red", "blue"), lty=1)

## -----------------------------------------------------------------------------
enrichmentPValue(sample$genotypes, sample$fam, sharingProbs, 0.001)

## -----------------------------------------------------------------------------
carriers = c(15,16,17)
carrier.sets = list()
for (i in length(carriers):1)
carrier.sets = c(carrier.sets, combn(carriers,i,simplify=FALSE))
fam15157.pattern.prob = sapply(carrier.sets,function (vec) RVsharing(samplePedigrees$secondCousinTriple,carriers=vec))
fam15157.N = sapply(carrier.sets,length)

## -----------------------------------------------------------------------------
fam15157.pattern.prob = RVsharing(samplePedigrees$secondCousinTriple,splitPed=TRUE)

## -----------------------------------------------------------------------------
fam15157.pattern.prob = c(RVsharing(samplePedigrees$secondCousinTriple,carriers=c(15,16,17)),
    RVsharing(samplePedigrees$secondCousinTriple,carriers=c(15,16)),
    RVsharing(samplePedigrees$secondCousinTriple,carriers=c(15)))
fam15157.N = 3:1
fam15157.nequiv = c(1,3,3)

## -----------------------------------------------------------------------------
sum(fam15157.pattern.prob*fam15157.nequiv)

## -----------------------------------------------------------------------------
fam15157 <- samplePedigrees$secondCousinTriple
fam15157$affected[3] = 1
plot(fam15157)

## -----------------------------------------------------------------------------
carriers = c(3,15,16,17)
carrier.sets = list()
for (i in length(carriers):1)
carrier.sets = c(carrier.sets, combn(carriers,i,simplify=FALSE))
carrier.sets
carrier.sets = carrier.sets[-c(5,9,10)]
fam15157.pattern.prob = sapply(carrier.sets,function (vec) RVsharing(fam15157,carriers=vec,useAffected=TRUE))
fam15157.N = sapply(carrier.sets,length)

## -----------------------------------------------------------------------------
sum(fam15157.pattern.prob)

## -----------------------------------------------------------------------------
pobs = RVsharing(fam15157,carriers=c(3,16,17),useAffected=TRUE)

## -----------------------------------------------------------------------------
sum(fam15157.pattern.prob[fam15157.pattern.prob<=pobs & fam15157.N >= 3])

## -----------------------------------------------------------------------------
fam15157.pattern.prob = c(RVsharing(samplePedigrees$secondCousinTriple,carriers=c(15,16,17)),
    RVsharing(samplePedigrees$secondCousinTriple,carriers=c(15,16)),
    RVsharing(samplePedigrees$secondCousinTriple,carriers=c(15)))
fam15157.N = 3:1
fam15157.nequiv = c(1,3,3)

fam28003.pattern.prob = c(RVsharing(samplePedigrees$firstAndSecondCousinsTriple,carriers=c(36,104,110)),
RVsharing(samplePedigrees$firstAndSecondCousinsTriple,carriers=c(36,104)),
RVsharing(samplePedigrees$firstAndSecondCousinsTriple,carriers=c(104,110)),
RVsharing(samplePedigrees$firstAndSecondCousinsTriple,carriers=c(36)),
RVsharing(samplePedigrees$firstAndSecondCousinsTriple,carriers=c(104)))
fam28003.N = c(3,2,2,1,1)
fam28003.nequiv = c(1,2,1,1,2)

ex.pattern.prob.list = list("15157"=fam15157.pattern.prob,"28003"=fam28003.pattern.prob)
ex.nequiv.list = list("15157"=fam15157.nequiv,"28003"=fam28003.nequiv)
ex.N.list = list("15157"=fam15157.N,"28003"=fam28003.N)

## -----------------------------------------------------------------------------
data(famVCF)
fam15157.snp = VariantAnnotation::genotypeToSnpMatrix(fam15157.vcf)
fam28003.snp = VariantAnnotation::genotypeToSnpMatrix(fam28003.vcf)

## -----------------------------------------------------------------------------
ex.SnpMatrix.list = list(fam15157=fam15157.snp$genotypes,fam28003=fam28003.snp$genotypes)
ex.ped.obj = list(fam15157=samplePedigrees$secondCousinTriple,fam28003=samplePedigrees$firstAndSecondCousinsTriple)

## -----------------------------------------------------------------------------
sites = c(92,119)
ex.SnpMatrix.list[["fam15157"]][,sites[1]]@.Data
ex.SnpMatrix.list[["fam28003"]][,sites[2]]@.Data

## -----------------------------------------------------------------------------
RVgene(ex.SnpMatrix.list,ex.ped.obj,sites,pattern.prob.list=ex.pattern.prob.list,nequiv.list=ex.nequiv.list,N.list=ex.N.list,type="count")

## -----------------------------------------------------------------------------
ped <- samplePedigrees$firstCousinTriple
ped$affected[9] <- 0
plot(ped)

p <- RVsharing(ped)
p <- RVsharing(ped, useAffected=TRUE)
p <- RVsharing(ped, carriers=c(7,9,10))
p <- RVsharing(ped, carriers=c(10,11), useAffected=TRUE)

## -----------------------------------------------------------------------------
p <- RVsharing(samplePedigrees$firstCousinPair, alleleFreq=0.01)
p <- RVsharing(samplePedigrees$firstCousinPair, alleleFreq=0.01, nSim=1e5)

## -----------------------------------------------------------------------------
# assumption that 1 founder introduces variant
fDist <- function(N) sample(c(rep(0,N-1), 1))
p <- RVsharing(samplePedigrees$firstCousinPair, nSim=1e5, founderDist=fDist)
p <- RVsharing(samplePedigrees$firstCousinPair)

## -----------------------------------------------------------------------------
plot(samplePedigrees$twoGenerationsInbreeding)
ComputeKinshipPropCoef(samplePedigrees$twoGenerationsInbreeding)

