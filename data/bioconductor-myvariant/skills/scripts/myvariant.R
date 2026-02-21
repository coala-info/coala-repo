# Code example from 'myvariant' vignette. See references/ for full tutorial.

### R code from vignette source 'myvariant.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: myvariant.Rnw:32-34
###################################################
library(myvariant)
library(VariantAnnotation)


###################################################
### code chunk number 3: myvariant.Rnw:37-40
###################################################
file.path <- system.file("extdata", "dbsnp_mini.vcf", package="myvariant")
vcf <- readVcf(file.path, genome="hg19")
rowRanges(vcf)


###################################################
### code chunk number 4: myvariant.Rnw:46-48
###################################################
hgvs <- formatHgvs(vcf, variant_type="snp")
head(hgvs)


###################################################
### code chunk number 5: myvariant.Rnw:59-62
###################################################
variant <- getVariant("chr1:g.35367G>A")
variant[[1]]$dbnsfp$genename
variant[[1]]$cadd$phred


###################################################
### code chunk number 6: myvariant.Rnw:72-74
###################################################
getVariants(c("chr1:g.35367G>A", "chr16:g.28883241A>G"),
            fields="cadd.consequence")


###################################################
### code chunk number 7: myvariant.Rnw:88-89
###################################################
queryVariant(q="dbnsfp.genename:MLL2", fields=c("cadd.phred", "cadd.consequence"))


###################################################
### code chunk number 8: myvariant.Rnw:96-97
###################################################
queryVariant(q="rs58991260", fields="dbsnp.flags")$hits


###################################################
### code chunk number 9: myvariant.Rnw:107-110
###################################################
rsids <- paste("rs", info(vcf)$RS, sep="")
res <- queryVariants(q=rsids, scopes="dbsnp.rsid", fields="all")
subset(res, !is.na(wellderly.vartype))$query


