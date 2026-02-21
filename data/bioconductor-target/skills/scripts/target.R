# Code example from 'target' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message = FALSE,
  warning = FALSE
)

## ----load_libraries-----------------------------------------------------------
# load reguired libraries
library(target)
library(GenomicRanges)

## ----load_data----------------------------------------------------------------
# load peaks and transcripts data
data("real_peaks")
data("real_transcripts")

## ----associated_peaks---------------------------------------------------------
# get associated peaks
ap <- associated_peaks(real_peaks, real_transcripts, 'ID')
ap

## ----direct_tragets-----------------------------------------------------------
# get direct targets
dt <- direct_targets(real_peaks, real_transcripts, 'ID', 't')
dt

## ----show_relation,fig.align='center',fig.width=7,fig.height=3----------------
par(mfrow = c(1, 3))

# show peak distance vs score
plot(ap$distance, ap$peak_score,
     pch = 19, cex = .5, 
     xlab = 'Peak Distance', ylab = 'Peak Score')
abline(v = 0, lty = 2, col = 'gray')

# show gene stat vs score
plot(dt$stat, dt$score,
     pch = 19, cex = .5, 
     xlim = c(-35, 35),
     xlab = 'Gene t-stats', ylab = 'Gene Score')
abline(v = 0, lty = 2, col = 'gray')

# show gene regulatory potential ecdf
groups <- c('Down', 'None', 'Up')
colors <- c('darkgreen', 'gray', 'darkred')

fold_change <- cut(dt$logFC,
                   breaks = c(min(dt$logFC), -.5, .5, max(dt$logFC)),
                   labels = groups)

plot_predictions(dt$score_rank,
                 fold_change,
                 colors,
                 groups,
                 xlab = 'Gene Regulatory Potential Rank',
                 ylab = 'ECDF')

## ----test_groups--------------------------------------------------------------
# test up-regulated transcripts are not random
test_predictions(dt$score_rank,
                 group = fold_change,
                 compare = c('Up', 'None'),
                 alternative = 'greater')

# test down-regulated transcripts are not random
test_predictions(dt$score_rank,
                 group = fold_change,
                 compare = c('Down', 'None'),
                 alternative = 'greater')

## ----top_gene_transcript------------------------------------------------------
# show the top regulated transcript, gene name and its associated peaks
top_trans <- unique(dt$ID[dt$rank == min(dt$rank)])
top_trans

unique(dt$name2[dt$ID == top_trans])
unique(ap$peak_name[ap$assigned_region == top_trans])

## ----session_info-------------------------------------------------------------
sessionInfo()

