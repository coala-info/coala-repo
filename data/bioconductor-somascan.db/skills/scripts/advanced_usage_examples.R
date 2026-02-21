# Code example from 'advanced_usage_examples' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(BiocStyle)
library(GO.db)
library(KEGGREST)
library(org.Hs.eg.db)
library(SomaScan.db)
library(withr)

## ----load-pkgs, warning = FALSE, message = FALSE------------------------------
library(GO.db)
library(KEGGREST)
library(org.Hs.eg.db)
library(SomaScan.db)
library(withr)

## ----il31-select-df-----------------------------------------------------------
il31_go <- select(SomaScan.db, keys = "IL31", keytype = "SYMBOL", 
                  columns = c("PROBEID", "GO"))

il31_go

## ----go-term------------------------------------------------------------------
Term(il31_go$GO)

## ----go-definition------------------------------------------------------------
Definition(il31_go$GO)

## ----go-synonym---------------------------------------------------------------
Synonym(il31_go$GO)

## ----append-terms-------------------------------------------------------------
trms <- Term(il31_go$GO)
class(trms)
length(trms) == length(il31_go$GO)

il31_go$TERM <- trms
il31_go

## ----append-definitions-------------------------------------------------------
defs <- Definition(il31_go$GO)
class(defs)
length(defs) == length(il31_go$GO)

il31_go$DEFINITION <- defs
il31_go[ ,c("SYMBOL", "PROBEID", "GO", "TERM", "DEFINITION")]

## ----example-go-ids-----------------------------------------------------------
go_ids <- select(SomaScan.db, "IL3RA", keytype = "SYMBOL",
                 columns = c("GO", "SYMBOL"))

go_ids

## ----go-columns---------------------------------------------------------------
columns(GO.db)

go_defs <- select(GO.db, keys = go_ids$GO,
                  columns = c("GOID", "TERM", "DEFINITION"))

go_defs

## ----go-merge-----------------------------------------------------------------
merge(go_ids, go_defs, by.x = "GO", by.y = "GOID")

## ----select-kegg--------------------------------------------------------------
kegg_sel <- select(SomaScan.db, keys = "CD86", keytype = "SYMBOL", 
                   columns = c("PROBEID", "PATH"))

kegg_sel

## ----get-path-names-----------------------------------------------------------
# Add prefix indicating species (hsa = Homo sapiens)
hsa_names <- paste0("hsa", kegg_sel$PATH)

kegg_res <- keggGet(dbentries = hsa_names) |>
    setNames(hsa_names[1:10L]) # Setting names for results list

## ----str-kegg-path------------------------------------------------------------
str(kegg_res$hsa04514)

## ----path-names-vector--------------------------------------------------------
kegg_names <- vapply(kegg_res, `[[`, i = "NAME", "", USE.NAMES = FALSE)

kegg_names

## ----append-names-------------------------------------------------------------
kegg_sel$PATHNAME <- kegg_names

kegg_sel

## ----seqid-gene---------------------------------------------------------------
pos_sel <- select(SomaScan.db, "11138-16", columns = c("SYMBOL", "GENENAME", 
                                                       "ENTREZID", "ENSEMBL"))

pos_sel

## ----keys-ens75, eval = FALSE-------------------------------------------------
#  # Install package from Bioconductor, if not already installed
#  if (!require("EnsDb.Hsapiens.v75", quietly = TRUE)) {
#      BiocManager::install("EnsDb.Hsapiens.v75")
#  }
#  
#  # The central keys of the organism-level database are the Ensembl gene ID
#  keys(EnsDb.Hsapiens.v75)[1:10L]
#  
#  # Also contains the Ensembl gene ID, so this column can be used for merging
#  grep("ENSEMBL", columns(SomaScan.db), value = TRUE)
#  
#  # These columns will inform us as to what positional information we can
#  # retrieve from the organism-level database
#  columns(EnsDb.Hsapiens.v75)
#  
#  # Build a query to retrieve the prot IDs and start/stop pos of protein domains
#  pos_res <- select(EnsDb.Hsapiens.v75, keys = "ENSG00000020633",
#                    columns = c("GENEBIOTYPE", "SEQCOORDSYSTEM", "GENEID",
#                                "PROTEINID", "PROTDOMSTART", "PROTDOMEND"))
#  
#  # Merge back into `pos_sel` using the "GENEID" column
#  merge(pos_sel, pos_res, by.x = "ENSEMBL", by.y = "GENEID")

## ----kin-act-go---------------------------------------------------------------
select(GO.db, keys = "cell adhesion", keytype = "TERM", 
       columns = c("GOID", "TERM"))

## -----------------------------------------------------------------------------
cellAd_ids <- select(SomaScan.db, keys = "GO:0007155", keytype = "GO",
                     columns = "PROBEID", "UNIPROTID")

head(cellAd_ids, n = 10L)

# Total number of SeqIds associated with cell adhesion
unique(cellAd_ids$PROBEID) |> length()

## -----------------------------------------------------------------------------
cellAd_prots <- select(org.Hs.eg.db, 
                       keys = "GO:0007155", 
                       keytype = "GO", 
                       columns = "UNIPROT")

# Again, we take the unique set of proteins
length(unique(cellAd_prots$UNIPROT))

## -----------------------------------------------------------------------------
cellAd_covProts <- select(SomaScan.db, keys = unique(cellAd_prots$UNIPROT),
                          keytype = "UNIPROT", columns = "PROBEID")

head(cellAd_covProts, n = 20L)

## -----------------------------------------------------------------------------
cellAd_covProts <- cellAd_covProts[!is.na(cellAd_covProts$PROBEID),]

cellAd_covIDs <- unique(cellAd_covProts$UNIPROT)

length(cellAd_covIDs)

## ----kin-act-menu-diff--------------------------------------------------------
cellAd_menu <- lapply(c("5k", "7k"), function(x) {
    df <- select(SomaScan.db, keys = unique(cellAd_prots$UNIPROT),
                 keytype = "UNIPROT", columns = "PROBEID",
                 menu = x)
    
    # Again, removing probes that do not map to a cell adhesion protein
    df <- df[!is.na(df$PROBEID),]
}) |> setNames(c("somascan_5k", "somascan_7k"))

identical(cellAd_menu$somascan_5k, cellAd_menu$somascan_7k)

## ----keys-il17----------------------------------------------------------------
il17_family <- keys(SomaScan.db, keytype = "SYMBOL", pattern = "IL17")

## ----select-il17--------------------------------------------------------------
select(SomaScan.db, keys = il17_family, keytype = "SYMBOL",
       columns = c("PROBEID", "UNIPROT", "GENENAME"))

## ----combine-keys-select------------------------------------------------------
select(SomaScan.db, keys = "NOTCH|ZF", keytype = "SYMBOL", 
       columns = c("PROBEID", "SYMBOL", "GENENAME"), match = TRUE)

## ----homeobox-----------------------------------------------------------------
select(SomaScan.db, keys = "homeobox", keytype = "GENENAME", 
       columns = c("PROBEID", "SYMBOL"), match = TRUE)

## ----session-info-------------------------------------------------------------
sessionInfo()

