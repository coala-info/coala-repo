# Code example from 'AnnotatingVariants' vignette. See references/ for full tutorial.

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
library(GoogleGenomics)
# This vignette is authenticated on package load from the env variable GOOGLE_API_KEY.
# When running interactively, call the authenticate method.
# ?authenticate

## --------------------------------------------------------------------------
variants <- getVariants()
length(variants)

## --------------------------------------------------------------------------
class(variants)
mode(variants)

## --------------------------------------------------------------------------
names(variants[[1]])

## --------------------------------------------------------------------------
length(variants[[1]]$calls)

## --------------------------------------------------------------------------
names(variants[[1]]$calls[[1]])

## --------------------------------------------------------------------------
variants[[1]]$referenceName
variants[[1]]$start
variants[[1]]$alternateBases
variants[[1]]$calls[[1]]

## --------------------------------------------------------------------------
variantsToVRanges(variants)

## ----message=FALSE---------------------------------------------------------
library(VariantAnnotation)

## --------------------------------------------------------------------------
granges <- getVariants(variantSetId="10473108253681171589",
                       chromosome="22",
                       start=50300077,
                       end=50303000,
                       converter=variantsToGRanges)

## ----message=FALSE---------------------------------------------------------
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

## --------------------------------------------------------------------------
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
granges_locations <- locateVariants(granges, txdb, CodingVariants())
granges_locations

## ----message=FALSE---------------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg19)

## --------------------------------------------------------------------------
granges_coding <- predictCoding(rep(granges, elementNROWS(granges$ALT)),
                                txdb,
                                seqSource=Hsapiens,
                                varAllele=unlist(granges$ALT, use.names=FALSE))

granges_coding

## ----message=FALSE---------------------------------------------------------
library(org.Hs.eg.db)

## --------------------------------------------------------------------------
annots <- select(org.Hs.eg.db,
                 keys=granges_coding$GENEID,
                 keytype="ENTREZID",
                 columns=c("SYMBOL", "GENENAME","ENSEMBL"))
cbind(elementMetadata(granges_coding), annots)

## --------------------------------------------------------------------------
sessionInfo()

