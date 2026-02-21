# Code example from 'DESeq2WithGlobalPerturbations' vignette. See references/ for full tutorial.

## ---- message = FALSE---------------------------------------------------------
library(BRGenomics)
data("PROseq")

## -----------------------------------------------------------------------------
ps_list <- lapply(1:6, function(i) PROseq[seq(i, length(PROseq), 6)])
names(ps_list) <- c("A_rep1", "A_rep2", 
                    "B_rep1", "B_rep2",
                    "C_rep1", "C_rep2")

## -----------------------------------------------------------------------------
ps_list[1:2]
names(ps_list)

## -----------------------------------------------------------------------------
data("txs_dm6_chr4")

## -----------------------------------------------------------------------------
dds <- getDESeqDataSet(ps_list, txs_dm6_chr4,
                       gene_names = txs_dm6_chr4$gene_id,
                       ncores = 1)
dds

## -----------------------------------------------------------------------------
getDESeqResults(dds, contrast.numer = "B", contrast.denom = "A",
                quiet = TRUE, ncores = 1)

## -----------------------------------------------------------------------------
comparison_list <- list(c("B", "A"), 
                        c("C", "A"),
                        c("C", "B"))
dsres <- getDESeqResults(dds, comparisons = comparison_list,
                         quiet = TRUE, ncores = 1)
names(dsres)
dsres$C_vs_B

