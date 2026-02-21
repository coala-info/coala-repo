# Code example from 'AnalyzingMultipleDatasets' vignette. See references/ for full tutorial.

## ---- message = FALSE---------------------------------------------------------
library(BRGenomics)
data("PROseq")
data("txs_dm6_chr4")

## -----------------------------------------------------------------------------
# make 3 datasets
ps1 <- PROseq[seq(1, length(PROseq), 3)]
ps2 <- PROseq[seq(2, length(PROseq), 3)]
ps3 <- PROseq[seq(3, length(PROseq), 3)]

# use the "=" assignment in list() to give names to the list elements
ps_list <- list(ps1 = ps1, ps2 = ps2, ps3 = ps3)
names(ps_list)
ps_list

## -----------------------------------------------------------------------------
getCountsByRegions(ps_list, txs_dm6_chr4[1:5], ncores = 1)

## -----------------------------------------------------------------------------
# melt, and use the optional region_names argument
txs_counts <- getCountsByRegions(ps_list, txs_dm6_chr4, melt = TRUE,
                                 region_names = txs_dm6_chr4$tx_name,
                                 ncores = 1)
head(txs_counts)

## -----------------------------------------------------------------------------
library(ggplot2)
ggplot(txs_counts, aes(x = sample, y = signal, fill = sample)) + 
  geom_violin() + 
  theme_bw()

## -----------------------------------------------------------------------------
cbp_maxtx <- getCountsByPositions(ps_list, txs_dm6_chr4[135], 
                                  melt = TRUE, ncores = 1)
head(cbp_maxtx)

## ---- fig.height=4, fig.width=6-----------------------------------------------
ggplot(cbp_maxtx, aes(x = position, y = signal)) + 
    facet_wrap(~sample, ncol = 1, strip.position = "right") + 
    geom_col(size = 0.5, color = "darkgray") +
    coord_cartesian(expand = FALSE) +
    labs(title = txs_dm6_chr4$tx_name[135],
         x = "Distance from TSS", y = "PRO-seq Signal") + 
    theme_classic() + 
    theme(strip.text.y = element_text(angle = 0),
          strip.background = element_blank(),
          axis.line.x = element_blank(),
          axis.ticks.x = element_blank())

## -----------------------------------------------------------------------------
ps_multi <- mergeGRangesData(ps1, ps2, ps3, multiplex = TRUE, ncores = 1)
ps_multi

## -----------------------------------------------------------------------------
mcols(ps_multi)

## ---- collapse = TRUE---------------------------------------------------------
ps_multi$ps1[1:5]

## -----------------------------------------------------------------------------
# for all datasets (all fields), get counts in the first 5 transcripts
getCountsByRegions(ps_multi, txs_dm6_chr4[1:5], 
                   field = names(mcols(ps_multi)),
                   ncores = 1)

# get counts for ps2 dataset only
getCountsByRegions(ps_multi, txs_dm6_chr4[1:5], 
                   field = "ps2", ncores = 1)

# if no field is given, most functions will default to using all fields
getCountsByRegions(ps_multi, txs_dm6_chr4[1:5], 
                   ncores = 1)

## ---- eval = FALSE------------------------------------------------------------
#  # save the PRO-seq GRanges for later import
#  saveRDS(PROseq, file = "~/PROseq.RData")
#  
#  # save a list of GRanges
#  saveRDS(ps_list, file = "~/ps_list.RData")
#  
#  # re-import
#  ps_list <- readRDS("~/ps_list.RData")

