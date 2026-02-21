# Code example from 'ModDNAString-alphabet' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c("custom.css"))

## ----alphabet, echo=FALSE-----------------------------------------------------
suppressPackageStartupMessages(library(Modstrings))
df <- as.data.frame(Modstrings:::additionalInfo(Modstrings:::MOD_DNA_STRING_CODEC))
df <- df[df$abbrev != "",]
colnames(df) <- c("modification",
                  "short name",
                  "nomenclature",
                  "orig. base",
                  "abbreviation")
knitr::kable(
  df, caption = 'List of DNA modifications supported by ModDNAString objects.'
)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

