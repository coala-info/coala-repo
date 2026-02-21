# Code example from 'EpiTxDb' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install(c("EpiTxDb","EpiTxDb.Hs.hg38"))

## ----results="hide", include=TRUE, message=FALSE, warning=FALSE---------------
library(EpiTxDb)
library(EpiTxDb.Hs.hg38)

## -----------------------------------------------------------------------------
etdb <- EpiTxDb.Hs.hg38.snoRNAdb()
etdb

## -----------------------------------------------------------------------------
keytypes(etdb)
columns(etdb)
head(keys(etdb, "MODID"))
select(etdb, keys = "1",
       columns = c("MODNAME","MODTYPE","MODSTART","MODSTRAND","SNNAME",
                   "RXGENENAME","SPECTYPE","SPECGENENAME"),
       keytype = "MODID")

## -----------------------------------------------------------------------------
species(etdb)
organism(etdb)
seqlevels(etdb)

## -----------------------------------------------------------------------------
modifications(etdb, columns = c("mod_id","mod_type","mod_name",
                                "rx_genename","spec_genename",
                                "ref_type","ref"),
              filter = list(mod_id = 1:3))

## -----------------------------------------------------------------------------
# split by sequence name, usually a transcipt identifier
modificationsBy(etdb, by = "seqnames")
# split modification type
modificationsBy(etdb, by = "modtype")

## ----echo = FALSE-------------------------------------------------------------
suppressPackageStartupMessages({
  library(TxDb.Hsapiens.UCSC.hg38.knownGene)
  library(BSgenome.Hsapiens.UCSC.hg38)
})

## ----eval = FALSE-------------------------------------------------------------
# library(TxDb.Hsapiens.UCSC.hg38.knownGene)
# library(BSgenome.Hsapiens.UCSC.hg38)

## -----------------------------------------------------------------------------
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
seqlevels(txdb) <- "chr1"
bs <- BSgenome.Hsapiens.UCSC.hg38

etdb <- EpiTxDb.Hs.hg38.RMBase()

tx <- exonsBy(txdb)
mod <- modifications(etdb, filter = list(sn_name = "chr1"))
length(mod)

## -----------------------------------------------------------------------------
mod_tx <- shiftGenomicToTranscript(mod, tx)
length(mod_tx)

## -----------------------------------------------------------------------------
mod_tx <- split(mod_tx,seqnames(mod_tx))
names <- Reduce(intersect,list(names(mod_tx),names(tx)))

# Getting the corresponding 5'-UTR and 3'-UTR annotations
fp <- fiveUTRsByTranscript(txdb)
tp <- threeUTRsByTranscript(txdb)
tx <- tx[names]
mod_tx <- mod_tx[names]
fp_m <- match(names,names(fp))
fp_m <- fp_m[!is.na(fp_m)]
tp_m <- match(names,names(tp))
tp_m <- tp_m[!is.na(tp_m)]
fp <- fp[fp_m]
tp <- tp[tp_m]

# Getting lengths of transcripts, 5'-UTR and 3'-UTR
tx_lengths <- sum(width(tx))
fp_lengths <- rep(0L,length(tx))
names(fp_lengths) <- names
fp_lengths[names(fp)] <- sum(width(fp))
tp_lengths <- rep(0L,length(tx))
names(tp_lengths) <- names
tp_lengths[names(tp)] <- sum(width(tp))

# Rescale modifications
# CDS start is at position 1L and cds end at position 1000L
from <- IRanges(fp_lengths+1L, tx_lengths - tp_lengths)
to <- IRanges(1L,1000L)
mod_rescale <- rescale(mod_tx, to, from)

# Construct result data.frame
rel_pos <- data.frame(mod_type = unlist(mcols(mod_rescale,level="within")[,"mod_type"]),
                      rel_pos = unlist(start(mod_rescale)))
rel_pos <- rel_pos[rel_pos$rel_pos < 1500 & rel_pos$rel_pos > -500,]

## -----------------------------------------------------------------------------
library(ggplot2)
ggplot(rel_pos[rel_pos$mod_type %in% c("m6A","m1A","Y"),],
       aes(x = rel_pos, colour = mod_type)) + 
  geom_density()

## -----------------------------------------------------------------------------
sessionInfo()

