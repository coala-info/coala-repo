# Code example from 'SigsPack' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----Load, message=FALSE------------------------------------------------------
library(SigsPack)

## -----------------------------------------------------------------------------
if (require(BSgenome.Hsapiens.UCSC.hg19)) {
  sample <- vcf2mut_cat(
    system.file("extdata", "example.vcf.gz", package="SigsPack"),
    BSgenome.Hsapiens.UCSC.hg19
  )
}

## -----------------------------------------------------------------------------
data("cosmicSigs")

cats <- create_mut_catalogues(10, 500, P=cosmicSigs, sig_set = c(2,6,15,27))
knitr::kable(head(cats[['catalogues']]))


## -----------------------------------------------------------------------------

reps <- bootstrap_mut_catalogues(n = 1000, original = cats[["catalogues"]][,1])

# using only signatures 4, 17, 23 and 30 for signature estimation
sigs <- signature_exposure(reps, sig_set = c(4,17,23,30))

print(sigs$exposures[,1])

## ----fig.show='hold', fig.height=7, fig.width=7-------------------------------

report <- summarize_exposures(reps[,1])

knitr::kable(
  head(report)
  )


## -----------------------------------------------------------------------------
if (require(BSgenome.Hsapiens.UCSC.hg19)){
  genome_contexts <- get_context_freq(BSgenome.Hsapiens.UCSC.hg19)
  exome_contexts <- get_context_freq(
    BSgenome.Hsapiens.UCSC.hg19,
    system.file("extdata", "example.bed.gz", package="SigsPack")
  )
  normalized_mut_cat <- SigsPack::normalize(sample, exome_contexts, hg19context_freq)
}

## ----fig.show='hold', fig.height=7, fig.width=7-------------------------------
if (require(BSgenome.Hsapiens.UCSC.hg19)) {
  sigs_norm <- signature_exposure(sum(sample) * normalized_mut_cat)
  report_norm <- summarize_exposures(normalized_mut_cat, m=sum(sample))
  reps_norm <- bootstrap_mut_catalogues(
      n=1000,
      original=normalized_mut_cat, 
      m=sum(sample)
  )
}

## -----------------------------------------------------------------------------
sessionInfo()

