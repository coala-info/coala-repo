# Code example from 'ukbb' vignette. See references/ for full tutorial.

## ----setup,message=FALSE, eval=FALSE------------------------------------------
# library(BiocHail)

## ----getukbb, eval=FALSE------------------------------------------------------
# hl = hail_init()
# ss = get_ukbb_sumstat_10kloci_mt(hl) # can take about a minute to unzip 5GB
# ss$count()   # but if a persistent MatrixTable is at the location given
#              # by env var HAIL_UKBB_SUMSTAT_10K_PATH it goes quickly

## ----lkba, eval=FALSE---------------------------------------------------------
# hl = bare_hail()
# hl$init(idempotent=TRUE, spark_conf=list(
#   'spark.hadoop.fs.gs.requester.pays.mode'= 'CUSTOM',
#   'spark.hadoop.fs.gs.requester.pays.buckets'= 'ukb-diverse-pops-public',
#   'spark.hadoop.fs.gs.requester.pays.project.id'= Sys.getenv("GOOGLE_PROJECT")))

## ----lkss, eval=FALSE---------------------------------------------------------
# sscol = ss$cols()$collect() # OK because we are just working over column metadata
# ss1 = sscol[[1]]
# names(ss1)
# ss1$get("phenocode")
# ss1$get("description")

## ----lkmul, eval=FALSE--------------------------------------------------------
# multipop_df(ss1)

## ----dodt, message=FALSE, eval=FALSE------------------------------------------
# library(DT)
# ndf = do.call(rbind, lapply(sscol[1:10], multipop_df))
# datatable(ndf)

## ----dotrim, eval=FALSE-------------------------------------------------------
# sss = ss$sample_rows(.01)$sample_cols(.01)
# sss$count()

## ----getrm, eval=FALSE--------------------------------------------------------
# rss = sss$rows()$collect()
# rss1 = rss[[1]]
# names(rss1)
# names(rss1$locus)
# rss1$locus$contig
# sapply(c("contig", "position"), function(x) rss1$locus[[x]])

## ----getent, eval=FALSE-------------------------------------------------------
# sse = sss$entries()$collect()
# length(sse)
# names(sse[[1]])
# sse1 = sse[[1]]

## ----lkss11, eval=FALSE-------------------------------------------------------
# length(sse1$summary_stats)
# names(sse1$summary_stats[[1]])
# sse1$summary_stats[[1]]$Pvalue

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("BiocHail")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

