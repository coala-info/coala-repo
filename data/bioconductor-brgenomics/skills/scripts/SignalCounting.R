# Code example from 'SignalCounting' vignette. See references/ for full tutorial.

## ---- message = FALSE---------------------------------------------------------
library(BRGenomics)
data("PROseq")
data("txs_dm6_chr4")

## ---- collapse = TRUE---------------------------------------------------------
counts_txs <- getCountsByRegions(PROseq, txs_dm6_chr4)
counts_txs[1:5]
length(txs_dm6_chr4) == length(counts_txs)

## -----------------------------------------------------------------------------
# get first 100 bases of each transcript
txs_pr <- promoters(txs_dm6_chr4, 0, 100)
# get signal at each base within each promoter region
countmatrix_pr <- getCountsByPositions(PROseq, txs_pr)

## ---- collapse = TRUE---------------------------------------------------------
class(countmatrix_pr)
nrow(countmatrix_pr) == length(txs_pr)
ncol(countmatrix_pr) == width(txs_pr[1])

## -----------------------------------------------------------------------------
# get signal in 10 bp bins within each promoter region
countmatrix_pr_bin <- getCountsByPositions(PROseq, txs_pr, binsize = 10)
countmatrix_pr_bin[1:5, ]

## ---- collapse = TRUE---------------------------------------------------------
all(rowSums(countmatrix_pr_bin) == rowSums(countmatrix_pr))

## ---- error = TRUE------------------------------------------------------------
getCountsByPositions(PROseq, txs_dm6_chr4)

## ---- collapse = TRUE---------------------------------------------------------
idx <- which.max(rowSums(countmatrix_pr))
idx

plot(x = 1:ncol(countmatrix_pr), 
     y = countmatrix_pr[idx, ], 
     type = "h", 
     main = txs_pr$tx_name[idx],
     xlab = "Distance to TSS",
     ylab = "PRO-seq Signal")

## -----------------------------------------------------------------------------
cbp.df <- getCountsByPositions(PROseq, txs_pr, binsize = 10, 
                               melt = TRUE, ncores = 1)
head(cbp.df)

## -----------------------------------------------------------------------------
library(ggplot2)

## -----------------------------------------------------------------------------
ggplot(cbp.df, aes(x = 10*position - 5, y = region, fill = signal)) + 
  geom_raster() + 
  coord_cartesian(expand = FALSE) + 
  labs(x = "Distance from TSS", y = "Transcript", 
       title = "PRO-seq", fill = "Reads") + 
  theme_bw()

## -----------------------------------------------------------------------------
# take only rows decent signal
row_signal <- rowSums(countmatrix_pr)
idx_signal <- row_signal > median(row_signal)
cbp <- countmatrix_pr[idx_signal, ]

# row-normalize
cbp_rn <- 100 * cbp / rowSums(cbp)

# get row order (by max position)
row_order <- order(apply(cbp_rn, 1, which.max), decreasing = TRUE)

# melt into a dataframe
rn_cbp.df <- reshape2::melt(cbp_rn[row_order, ], 
                            varnames = c("region", "position"),
                            value.name = "signal")

## -----------------------------------------------------------------------------
ggplot(rn_cbp.df, 
       aes(x = position, y = region, fill = signal)) + 
    geom_raster() + 
    scale_fill_gradient(low = "white", high = "blue") +
    coord_cartesian(expand = FALSE) + 
    labs(x = "Distance from TSS", y = NULL, 
         title = "Row-Normalized PRO-seq", fill = "% Signal") + 
    theme_bw() + 
    theme(axis.ticks.y = element_blank(),
          axis.text.y = element_blank())

