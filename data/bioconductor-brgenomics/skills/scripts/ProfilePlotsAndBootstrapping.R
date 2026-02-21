# Code example from 'ProfilePlotsAndBootstrapping' vignette. See references/ for full tutorial.

## ---- message = FALSE---------------------------------------------------------
library(BRGenomics)
data("PROseq")
data("txs_dm6_chr4")
txs_pr <- promoters(txs_dm6_chr4, 0, 100)

## ---- collapse = TRUE---------------------------------------------------------
countmatrix_pr <- getCountsByPositions(PROseq, txs_pr, ncores = 1)
dim(countmatrix_pr)
dim(countmatrix_pr) == c(length(txs_pr), unique(width(txs_pr)))

## -----------------------------------------------------------------------------
plot(x = 1:ncol(countmatrix_pr),
     y = colMeans(countmatrix_pr),
     type = "l", 
     xlab = "Distance to TSS (bp)",
     ylab = "Mean PRO-seq Reads")

## ---- fig.height=7, fig.width=6-----------------------------------------------
plot_meds <- function(sig_thresh) {
  idx <- which(rowSums(countmatrix_pr) > sig_thresh)
  plot(x = 1:ncol(countmatrix_pr),
       y = apply(countmatrix_pr[idx, ], 2, median),
       type = "l", 
       main = sprintf("Regions with >%s reads", sig_thresh),
       xlab = "Distance to TSS (bp)",
       ylab = "Median PRO-seq Reads")
}

par(mfrow = c(3, 2))

for (i in c(0, 30*2^(0:4))) {
  plot_meds(i)
}

## -----------------------------------------------------------------------------
bootmeans.df <- metaSubsample(PROseq, txs_pr, binsize = 5, 
                              lower = 0.35, upper = 0.65, ncores = 1)
head(bootmeans.df)

## -----------------------------------------------------------------------------
plot(mean ~ x, data = bootmeans.df, type = "l", 
     main = "PRO-seq Signal", ylim = c(0, 1.4),
     xlab = "Distance from TSS",
     ylab = "Mean Signal + 30% CI")

# draw a polygon to add confidence bands,
# and use adjustcolor() to add transparency
polygon(c(bootmeans.df$x, rev(bootmeans.df$x)), 
        c(bootmeans.df$lower, rev(bootmeans.df$upper)),
        col = adjustcolor("black", 0.1), border = FALSE)

## -----------------------------------------------------------------------------
require(ggplot2)
ggplot(bootmeans.df, aes(x, mean)) + 
  geom_line() + 
  geom_ribbon(aes(x, ymin = lower, ymax = upper),
              alpha = 0.1) + 
  labs(title = "PRO-seq Signal", 
       x = "Distance from TSS", 
       y = "Mean Signal + 30% CI") + 
  theme_bw()

## -----------------------------------------------------------------------------
# make 3 datasets
ps_list <- list(ps1 = PROseq[seq(1, length(PROseq), 3)], 
                ps2 = PROseq[seq(2, length(PROseq), 3)], 
                ps3 = PROseq[seq(3, length(PROseq), 3)])

## -----------------------------------------------------------------------------
bm_list.df <- metaSubsample(ps_list, txs_pr, binsize = 5, 
                            lower = 0.35, upper = 0.65, ncores = 1)
head(bm_list.df)

## -----------------------------------------------------------------------------
require(ggplot2)
ggplot(bm_list.df, aes(x, mean, color = sample.name)) + 
  geom_line() + 
  geom_ribbon(aes(x, ymin = lower, ymax = upper,
                  color = NULL, fill = sample.name),
              alpha = 0.2) + 
  labs(title = "PRO-seq Signal", 
       x = "Distance from TSS", 
       y = "Mean Signal + 30% CI") + 
  theme_bw()

