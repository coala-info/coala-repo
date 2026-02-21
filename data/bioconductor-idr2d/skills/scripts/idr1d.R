# Code example from 'idr1d' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(fig.width = 7, fig.height = 7, echo = FALSE,
                      warning = FALSE, message = FALSE, dev = 'png',
                      out.extra = 'style="border-width: 0;"')

## ----echo = TRUE--------------------------------------------------------------
rep1_df <- idr2d:::chipseq$rep1_df
rep2_df <- idr2d:::chipseq$rep2_df

## -----------------------------------------------------------------------------
library(DT)
header <- htmltools::withTags(table(
  class = 'display',
  thead(
    tr(
      th("chromosome"),
      th("start coordinate"),
      th("end coordinate"),
      th("score")
    )
  )
))
datatable(rep1_df[seq_len(min(nrow(rep1_df), 1000)), ],
          container = header, rownames = FALSE,
          options = list(searching = FALSE)) %>%
  formatRound("value", 3)

## -----------------------------------------------------------------------------
datatable(rep2_df[seq_len(min(nrow(rep2_df), 1000)), ], container = header,
          rownames = FALSE, options = list(searching = FALSE)) %>%
  formatRound("value", 3)

## ----echo = TRUE--------------------------------------------------------------
library(idr2d)

## ----echo = TRUE--------------------------------------------------------------
idr_results <- estimate_idr1d(rep1_df, rep2_df, 
                              value_transformation = "log")
rep1_idr_df <- idr_results$rep1_df

## -----------------------------------------------------------------------------
chr <- start <- end <- rank <- rep_rank <- value <- rep_value <- idr <- NULL
header <- htmltools::withTags(table(
  class = 'display',
  thead(
    tr(
      th("chr."),
      th("start coordinate"),
      th("end coordinate"),
      th("rank in R1"),
      th("rank in R2"),
      th("transformed value in R1"),
      th("transformed value in R2"),
      th("IDR")
    )
  )
))

df <- dplyr::select(rep1_idr_df, chr, start, end,
                    rank, rep_rank, value, rep_value, idr)
datatable(df[seq_len(min(nrow(df), 1000)), ], 
          rownames = FALSE,
          options = list(searching = FALSE),
          container = header) %>%
  formatRound(c("value", "rep_value", "idr"), 3)

## ----echo = TRUE--------------------------------------------------------------
summary(idr_results)

## ----echo = TRUE--------------------------------------------------------------
draw_idr_distribution_histogram(rep1_idr_df)

## ----echo = TRUE--------------------------------------------------------------
draw_rank_idr_scatterplot(rep1_idr_df)

## ----echo = TRUE--------------------------------------------------------------
draw_value_idr_scatterplot(rep1_idr_df)

