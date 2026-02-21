# Code example from 'VariantAnnotation-comparison-test' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'---------------------------------
BiocStyle::markdown()

## ---- echo=FALSE, results="hide"-------------------------------------------
# Ensure that any errors cause the Vignette build to fail.
library(knitr)
opts_chunk$set(error=FALSE)

## ---- echo = FALSE---------------------------------------------------------
apiKey <- Sys.getenv("GOOGLE_API_KEY")
if (nchar(apiKey) == 0) {
  warning(paste("To build this vignette, please setup the environment variable",
                "GOOGLE_API_KEY with the public API key from your Google",
                "Developer Console before loading the GoogleGenomics package,",
                "or run GoogleGenomics::authenticate."))
  knitr::knit_exit()
}

## ----message=FALSE---------------------------------------------------------
library(VariantAnnotation)

## --------------------------------------------------------------------------
fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
vcf <- readVcf(fl, "hg19")
vcf <- renameSeqlevels(vcf, c("22"="chr22"))
vcf

## ----message=FALSE---------------------------------------------------------
library(GoogleGenomics)
# This vignette is authenticated on package load from the env variable GOOGLE_API_KEY.
# When running interactively, call the authenticate method.
# ?authenticate

## --------------------------------------------------------------------------
# We're just getting the first few variants so that this runs quickly.
# If we wanted to get them all, we sould set end=50999964.
granges <- getVariants(variantSetId="10473108253681171589",
                       chromosome="22",
                       start=50300077,
                       end=50303000,
                       converter=variantsToGRanges)

## --------------------------------------------------------------------------
vcf <- vcf[1:length(granges)] # Truncate the VCF data so that it is the same 
                              # set as what was retrieved from the API.

## ----message=FALSE---------------------------------------------------------
library(testthat)

## --------------------------------------------------------------------------
expect_equal(start(granges), start(vcf))
expect_equal(end(granges), end(vcf))
expect_equal(as.character(granges$REF), as.character(ref(vcf)))
expect_equal(as.character(unlist(granges$ALT)), as.character(unlist(alt(vcf))))
expect_equal(granges$QUAL, qual(vcf))
expect_equal(granges$FILTER, filt(vcf))

## ----message=FALSE---------------------------------------------------------
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

## --------------------------------------------------------------------------
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

rd <- rowRanges(vcf)
vcf_locations <- locateVariants(rd, txdb, CodingVariants())
vcf_locations

granges_locations <- locateVariants(granges, txdb, CodingVariants())
granges_locations

expect_equal(granges_locations, vcf_locations)

## ----message=FALSE---------------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg19)

## --------------------------------------------------------------------------
vcf_coding <- predictCoding(vcf, txdb, seqSource=Hsapiens)
vcf_coding

granges_coding <- predictCoding(rep(granges, elementNROWS(granges$ALT)),
                                txdb,
                                seqSource=Hsapiens,
                                varAllele=unlist(granges$ALT, use.names=FALSE))

granges_coding

expect_equal(as.matrix(granges_coding$REFCODON), as.matrix(vcf_coding$REFCODON))
expect_equal(as.matrix(granges_coding$VARCODON), as.matrix(vcf_coding$VARCODON))
expect_equal(granges_coding$GENEID, vcf_coding$GENEID)
expect_equal(granges_coding$CONSEQUENCE, vcf_coding$CONSEQUENCE)


## --------------------------------------------------------------------------
sessionInfo()

