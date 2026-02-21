# Code example from 'AshkenazimSonChr21' vignette. See references/ for full tutorial.

## ----mychunk1, cache=TRUE, eval=TRUE, hide=TRUE-------------------------------
## text file
library(AshkenazimSonChr21)
head(SonVariantsChr21)

## vcf file
library(VariantAnnotation)

fl <- system.file("extdata", "SonVariantsChr21.vcf.gz",
                  package="AshkenazimSonChr21")
vcf <- readVcf(fl, genome="hg19")
geno(vcf)
info(vcf)

