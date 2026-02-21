# Code example from 'lfa' vignette. See references/ for full tutorial.

## ----preamble-----------------------------------------------------------------
library(lfa)
dim(hgdp_subset)

## ----lfa----------------------------------------------------------------------
LF <- lfa(hgdp_subset, 4)
dim(LF)
head(LF)

## ----lfa_plot, fig.width=5, fig.height=4.5------------------------------------
dat <- data.frame(LF[,1], LF[,2], colnames(hgdp_subset))
colnames(dat) = c("LF1", "LF2", "geo")
library(ggplot2)
ggplot(dat, aes(LF1, LF2, color=geo)) + geom_point() + theme_bw() +
    coord_fixed(ratio=(max(dat[,1])-min(dat[,1]))/(max(dat[,2])-min(dat[,2])))

## ----af1----------------------------------------------------------------------
allele_freqs <- af(hgdp_subset, LF)
allele_freqs[1:5, 1:5]

## ----af2----------------------------------------------------------------------
subset <- af(hgdp_subset[15:25,], LF)
subset[1:5,1:5]

## ----af3----------------------------------------------------------------------
ll <- function(snp, af){
    -sum(snp*log(af) + (2-snp)*log(1-af))
}
log_lik <- sapply(1:nrow(hgdp_subset), function(i) {ll(hgdp_subset[i,], 
    allele_freqs[i,])})
which(max(log_lik) == log_lik)

