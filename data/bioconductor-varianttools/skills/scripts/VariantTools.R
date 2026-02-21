# Code example from 'VariantTools' vignette. See references/ for full tutorial.

### R code from vignette source 'VariantTools.Rnw'

###################################################
### code chunk number 1: <options
###################################################
options(width=72)


###################################################
### code chunk number 2: callVariants
###################################################
library(VariantTools)
bams <- LungCancerLines::LungCancerBamFiles()
bam <- bams$H1993
if (requireNamespace("gmapR", quietly=TRUE)) {
    p53 <- gmapR:::exonsOnTP53Genome("TP53")
    tally.param <- TallyVariantsParam(gmapR::TP53Genome(), 
                                      high_base_quality = 23L,
                                      which = range(p53) + 5e4,
                                      indels = TRUE, read_length = 75L)
    called.variants <- callVariants(bam, tally.param)
} else {
    data(vignette)
    called.variants <- callVariants(tallies_H1993)
}


###################################################
### code chunk number 3: callVariants-postFilter
###################################################
pf.variants <- postFilterVariants(called.variants)


###################################################
### code chunk number 4: callVariants-exonic
###################################################
subsetByOverlaps(called.variants, p53, ignore.strand = TRUE)


###################################################
### code chunk number 5: tallyVariants
###################################################
if (requireNamespace("gmapR", quietly=TRUE)) {
    tallies_H1993 <- tallyVariants(bam, tally.param)
}


###################################################
### code chunk number 6: qaVariants
###################################################
qa.variants <- qaVariants(tallies_H1993)
summary(softFilterMatrix(qa.variants))


###################################################
### code chunk number 7: callVariants
###################################################
called.variants <- callVariants(qa.variants)


###################################################
### code chunk number 8: VariantQAFilters
###################################################
qa.filters <- VariantQAFilters()


###################################################
### code chunk number 9: VariantQAFilters-summary
###################################################
summary(qa.filters, tallies_H1993)


###################################################
### code chunk number 10: VariantQAFilters-subset
###################################################
qa.variants <- subsetByFilter(tallies_H1993, qa.filters)


###################################################
### code chunk number 11: VariantQAFilters-fisherStrandP
###################################################
qa.filters.custom <- VariantQAFilters(fisher.strand.p.value = 1e-4)
summary(qa.filters.custom, tallies_H1993)


###################################################
### code chunk number 12: VariantQAFilters-compare
###################################################
fs.original <- eval(qa.filters["fisherStrand"], tallies_H1993) 
fs.custom <- eval(qa.filters.custom["fisherStrand"], tallies_H1993)
tallies_H1993[fs.original != fs.custom]


###################################################
### code chunk number 13: VariantQAFilters-mask
###################################################
if (requireNamespace("gmapR", quietly=TRUE)) {
    tally.param@mask <- GRanges("TP53", IRanges(1010000, width=10000))
    tallies_masked <- tallyVariants(bam, tally.param)
}


###################################################
### code chunk number 14: VariantCallingFilters
###################################################
calling.filters <- VariantCallingFilters()
summary(calling.filters, qa.variants)


###################################################
### code chunk number 15: post-filter
###################################################
post.filters <- VariantPostFilters()
summary(post.filters, qa.variants)


###################################################
### code chunk number 16: post-filter-whitelist
###################################################
post.filters <- VariantPostFilters(whitelist = called.variants)
summary(post.filters, qa.variants)


###################################################
### code chunk number 17: callSomaticMutations
###################################################
if (requireNamespace("gmapR", quietly=TRUE)) {
    tally.param@bamTallyParam@indels <- FALSE
    somatic <- callSampleSpecificVariants(bams$H1993, bams$H2073,
                                          tally.param)
} else {
    somatic <- callSampleSpecificVariants(called.variants, tallies_H2073,
                                          coverage_H2073)
}


###################################################
### code chunk number 18: callSomaticMutations-readCount
###################################################
calling.filters <- VariantCallingFilters(read.count = 3L)
if (requireNamespace("gmapR", quietly=TRUE)) {
    somatic <- callSampleSpecificVariants(bams$H1993, bams$H2073, tally.param,
                                          calling.filters = calling.filters,
                                          power = 0.9, p.value = 0.001)
} else {
    called.variants <- callVariants(tallies_H1993, calling.filters)
    somatic <- callSampleSpecificVariants(called.variants, tallies_H2073,
                                          coverage_H2073,
                                          power = 0.9, p.value = 0.001)
}


###################################################
### code chunk number 19: variantGR2VCF
###################################################
sampleNames(called.variants) <- "H1993"
mcols(called.variants) <- NULL
vcf <- asVCF(called.variants)


###################################################
### code chunk number 20: writeVcf (eval = FALSE)
###################################################
## writeVcf(vcf, "H1993.vcf", index = TRUE)


###################################################
### code chunk number 21: callWildtype
###################################################
called.variants <- called.variants[!isIndel(called.variants)]
pos <- c(called.variants, shift(called.variants, 3))
wildtype <- callWildtype(bam, called.variants, VariantCallingFilters(), 
                         pos = pos, power = 0.85)


###################################################
### code chunk number 22: percentageCalled
###################################################
mean(!is.na(wildtype))


