# Code example from 'scsR' vignette. See references/ for full tutorial.

### R code from vignette source 'scsR.Rnw'

###################################################
### code chunk number 1: initialization
###################################################
library(scsR)


###################################################
### code chunk number 2: scsR.Rnw:51-53
###################################################
options(SweaveHooks=list(fig=function()
par(oma=c(0,3,0,0))))


###################################################
### code chunk number 3: load_data
###################################################
data(uuk_screen)
data(uuk_screen_dh)
data(miRBase_20)


###################################################
### code chunk number 4: headdata>
###################################################
head(uuk_screen)


###################################################
### code chunk number 5: check_consistency
###################################################
uuk_screen <- check_consistency(uuk_screen)


###################################################
### code chunk number 6: median_replicates
###################################################
uuk_screen <- median_replicates(uuk_screen)


###################################################
### code chunk number 7: add_seed1
###################################################
uuk_screen <- add_seed(uuk_screen)


###################################################
### code chunk number 8: add_seed2
###################################################
uuk_screen_dh <- add_seed(uuk_screen_dh)


###################################################
### code chunk number 9: seed_analysis
###################################################
seeds <- seeds_analysis(uuk_screen, miRBase = miRBase_20 )


###################################################
### code chunk number 10: scsR.Rnw:123-124
###################################################
seeds=seeds[,c(1,2,3,4,5,6,7,9)]


###################################################
### code chunk number 11: head3
###################################################
head(seeds)


###################################################
### code chunk number 12: plotsh1 (eval = FALSE)
###################################################
## plot_screen_hits(arrange(add_rank_col(uuk_screen), median))


###################################################
### code chunk number 13: plotsh3 (eval = FALSE)
###################################################
## plot_effective_seeds_head(uuk_screen)


###################################################
### code chunk number 14: plotseo1 (eval = FALSE)
###################################################
## plot_seeds_oligo_count(uuk_screen)


###################################################
### code chunk number 15: plotssc1 (eval = FALSE)
###################################################
## plot_screen_seeds_count(uuk_screen)


###################################################
### code chunk number 16: seed_correction (eval = FALSE)
###################################################
## screen_corrected <- seed_correction(uuk_screen)
## screen_corrected_dh <- seed_correction_pooled(uuk_screen_dh)


###################################################
### code chunk number 17: plot_screen_hits3 (eval = FALSE)
###################################################
## plot_screen_hits(arrange(add_rank_col(screen_corrected), median))


###################################################
### code chunk number 18: plot_seed_score_sd (eval = FALSE)
###################################################
## plot_seed_score_sd(uuk_screen)


###################################################
### code chunk number 19: seed_removal (eval = FALSE)
###################################################
## screen_corrected2 <- seed_removal(uuk_screen)


###################################################
### code chunk number 20: plot_screen_hits4 (eval = FALSE)
###################################################
## plot_screen_hits(arrange(add_rank_col(screen_corrected2), median))


###################################################
### code chunk number 21: benchmark_shared_hits1 (eval = FALSE)
###################################################
## benchmark_shared_hits(
##   glA=list(
##           arrange(add_rank_col(uuk_screen), median)$GeneID, 
##           arrange(add_rank_col(uuk_screen), log_pval_rsa)$GeneID,
##           arrange(add_rank_col(screen_corrected), median)$GeneID
##   ),
##   glB=list(arrange(add_rank_col(uuk_screen_dh), median)$GeneID),
##   col=c("black", "blue", "green"),
##   title="UUKUNIEMI Infection Inhibitors"
## )


###################################################
### code chunk number 22: benchmark_shared_hits2 (eval = FALSE)
###################################################
## benchmark_shared_hits(
##   glA=list(
##           arrange(add_rank_col(uuk_screen_dh), median)$GeneID, 
##           arrange(add_rank_col(screen_corrected_dh), median)$GeneID
##   ),
##   glB=list(arrange(add_rank_col(uuk_screen), median)$GeneID),
##   col=c("black", "green"),
##   title="UUKUNIEMI Infection Inhibitors (pooled)"
## )


###################################################
### code chunk number 23: enrichment_heatmap1 (eval = FALSE)
###################################################
## em = enrichment_heatmap( list(arrange(add_rank_col(uuk_screen), median)$GeneID,
##                               arrange(add_rank_col(uuk_screen), log_pval_rsa)$GeneID,
##                               arrange(add_rank_col(screen_corrected), median)$GeneID
## ),
##                          list("No Correction", "RSA", "scsR"),
##                          enrichmentType="Process", output_file=NULL,
##                          title="UUKUNIEMI Infection Inhibitors", fdr_threshold=0.01,
##                          limit=400
## )


###################################################
### code chunk number 24: enrichment_heatmap1 (eval = FALSE)
###################################################
## em_dh = enrichment_heatmap( list(arrange(add_rank_col(uuk_screen_dh), median)$GeneID,
##                               arrange(add_rank_col(screen_corrected_dh), median)$GeneID
## ),
##         list("No Correction", "scsR"), enrichmentType="Process", fdr_threshold=0.01,
##         title="UUKUNIEMI Infection Inhibitors (pooled)", 
## )


