# Code example from 'disorderedMatrices-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
#BiocManager::install("idpr")

## -----------------------------------------------------------------------------
#devtools::install_github("wmm27/idpr")

## -----------------------------------------------------------------------------
library(idpr)

## -----------------------------------------------------------------------------
EDSSMat62

## -----------------------------------------------------------------------------
Disorder40

## -----------------------------------------------------------------------------
Disorder85

## -----------------------------------------------------------------------------
DUNMat

## -----------------------------------------------------------------------------
P53_MOUSE <- TP53Sequences[1]
print(P53_MOUSE)
P53_HUMAN <- TP53Sequences[2]
print(P53_HUMAN)
P53_GORILLA <- GorillaTP53
print(P53_GORILLA)

## -----------------------------------------------------------------------------
library(pwalign)
data("BLOSUM62") #loads the matrix from the Biostrings package
HUMAN_MOUSE_BLOSUM_PSA <- pairwiseAlignment(P53_MOUSE, P53_HUMAN,
                                            substitutionMatrix = BLOSUM62,
                                            gapOpening = 10,
                                            gapExtension = 0.5)
print(HUMAN_MOUSE_BLOSUM_PSA)

HUMAN_GORILLA_BLOSUM_PSA <- pairwiseAlignment(P53_GORILLA, P53_HUMAN,
                                             substitutionMatrix = BLOSUM62,
                                             gapOpening = 10,
                                             gapExtension = 0.5)
print(HUMAN_GORILLA_BLOSUM_PSA)


## -----------------------------------------------------------------------------
HUMAN_MOUSE_EDSS_PSA <- pairwiseAlignment(P53_MOUSE, P53_HUMAN,
                                            substitutionMatrix = EDSSMat62,
                                            gapOpening = 19,
                                            gapExtension = 2)
print(HUMAN_MOUSE_EDSS_PSA)

HUMAN_GORILLA_EDSS_PSA <- pairwiseAlignment(P53_GORILLA, P53_HUMAN,
                                             substitutionMatrix = EDSSMat62,
                                             gapOpening = 19,
                                             gapExtension = 2)
print(HUMAN_GORILLA_EDSS_PSA)

## -----------------------------------------------------------------------------
TP53_Sequences <- TP53Sequences
print(TP53_Sequences)

## -----------------------------------------------------------------------------
library(msa)
BLOSUM_MSA <- msa(TP53_Sequences,
                 type = "protein",
                 substitutionMatrix = BLOSUM62,
                 gapOpening = 10,
                 gapExtension = 0.5)

print(BLOSUM_MSA, show = "complete")

## -----------------------------------------------------------------------------
EDSS_MSA <- msa(TP53_Sequences,
                type = "protein",
                substitutionMatrix = EDSSMat62,
                gapOpening = 19,
                gapExtension = 2)

print(EDSS_MSA, show = "complete")

## ----fig1, fig.height = 4, fig.width = 6--------------------------------------
EDSS_MSA_Tree <- msa::msaConvert(EDSS_MSA, type = "seqinr::alignment")
d <- seqinr::dist.alignment(EDSS_MSA_Tree, "identity")
p53Tree <- ape::nj(d)
plot(p53Tree,
     main = "Phylogenetic Tree of p53 Sequences\nAligned with EDSSMat62")

## ----results="asis"-----------------------------------------------------------
citation("Biostrings")
citation("msa")
citation("ape")
citation("seqinr")

## -----------------------------------------------------------------------------
R.version.string

## -----------------------------------------------------------------------------
as.data.frame(Sys.info())

## ----results="asis"-----------------------------------------------------------
citation()

