# Code example from 'ModRNAString-alphabet' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c("custom.css"))

## ----alphabet, echo=FALSE-----------------------------------------------------
suppressPackageStartupMessages(library(Modstrings))
df <- as.data.frame(Modstrings:::additionalInfo(Modstrings:::MOD_RNA_STRING_CODEC))
df <- df[df$abbrev != "",]
colnames(df) <- c("modification",
                  "short name",
                  "nomenclature",
                  "orig. base",
                  "abbreviation")
knitr::kable(
  df, caption = 'List of RNA modifications supported by ModRNAString objects.'
)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

