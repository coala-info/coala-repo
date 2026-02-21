# Code example from 'biscuiteer' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("biscuiteer")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("trichelab/biscuiteerData")
# BiocManager::install("trichelab/biscuiteer")

## -----------------------------------------------------------------------------
library(biscuiteer)

orig_bed <- system.file("extdata", "MCF7_Cunha_chr11p15.bed.gz",
                        package="biscuiteer")
orig_vcf <- system.file("extdata", "MCF7_Cunha_header_only.vcf.gz",
                        package="biscuiteer")
bisc <- readBiscuit(BEDfile = orig_bed, VCFfile = orig_vcf,
                    merged = FALSE)

## -----------------------------------------------------------------------------
biscuitMetadata(bisc)

## -----------------------------------------------------------------------------
shuf_bed <- system.file("extdata", "MCF7_Cunha_chr11p15_shuffled.bed.gz",
                        package="biscuiteer")
shuf_vcf <- system.file("extdata",
                        "MCF7_Cunha_shuffled_header_only.vcf.gz",
                        package="biscuiteer")
bisc2 <- readBiscuit(BEDfile = shuf_bed, VCFfile = shuf_vcf,
                     merged = FALSE)

comb <- unionize(bisc, bisc2)

## -----------------------------------------------------------------------------
epibed.nome <- system.file("extdata", "hct116.nome.epibed.gz", package="biscuiteer")
epibed.bsseq <- system.file("extdata", "hct116.bsseq.epibed.gz", package="biscuiteer")
epibed.nome.gr <- readEpibed(epibed = epibed.nome, genome = "hg19", chr = "chr1")
epibed.bsseq.gr <- readEpibed(epibed = epibed.bsseq, genome = "hg19", chr = "chr1")

## -----------------------------------------------------------------------------
reg <- GRanges(seqnames = rep("chr11",5),
               strand = rep("*",5),
               ranges = IRanges(start = c(0,2.8e6,1.17e7,1.38e7,1.69e7),
                                end= c(2.8e6,1.17e7,1.38e7,1.69e7,2.2e7))
              )

frac <- getLogitFracMeth(bisc, minSamp = 1, r = reg)
frac

## -----------------------------------------------------------------------------
ages <- WGBSage(comb, "horvath")
ages

