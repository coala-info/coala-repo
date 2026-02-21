# Code example from 'UsingSynExtend' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager",
#                       quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("SynExtend")

## ----build_synteny_object-----------------------------------------------------
library(SynExtend)

DBPATH <- system.file("extdata",
                      "Endosymbionts_v05a.sqlite",
                      package = "SynExtend")

Syn <- FindSynteny(dbFile = DBPATH)

## ----synplots01---------------------------------------------------------------
Syn
pairs(Syn)

## ----synplots02---------------------------------------------------------------
print(head(Syn[[1, 2]]))
print(head(Syn[[2, 1]]))

## ----generate_genecalls-------------------------------------------------------
# generating genecalls with local data:
GC <- gffToDataFrame(GFF = system.file("extdata",
                                       "GCF_023585825.1_ASM2358582v1_genomic.gff.gz",
                                       package = "SynExtend"),
                     Verbose = TRUE)

# in an effort to be space conscious, not all original gffs are kept within this package
GeneCalls <- get(data("Endosymbionts_GeneCalls", package = "SynExtend"))

## ----print_gene_calls---------------------------------------------------------
print(head(GeneCalls[[1]]))

## ----show_rtracklayer, eval = FALSE-------------------------------------------
# X01 <- rtracklayer::import(system.file("extdata",
#                                        "GCF_023585825.1_ASM2358582v1_genomic.gff.gz",
#                                        package = "SynExtend"))
# class(X01)
# print(X01)

## ----generate_initial_links---------------------------------------------------
Links <- NucleotideOverlap(SyntenyObject = Syn,
                           GeneCalls = GeneCalls,
                           Verbose = TRUE)

## ----link_printing------------------------------------------------------------
class(Links)
print(Links)

## ----describe_links-----------------------------------------------------------
LinkedPairs1 <- PairSummaries(SyntenyLinks = Links,
                              DBPATH = DBPATH,
                              PIDs = FALSE,
                              Verbose = TRUE)

## ----describe_more_links_again------------------------------------------------
print(head(LinkedPairs1))

## ----pairsummariesoperations--------------------------------------------------
SingleLinkageClusters <- DisjointSet(Pairs = LinkedPairs1,
                                     Verbose = TRUE)

## ----clusters-----------------------------------------------------------------
# extract the first 10 clusters
Sets <- ExtractBy(x = LinkedPairs1,
                  y = DBPATH,
                  z = SingleLinkageClusters[1:10],
                  Verbose = TRUE)

head(Sets)

## -----------------------------------------------------------------------------
sessionInfo()

