# Code example from 'custom_SVGs' vignette. See references/ for full tutorial.

## ----setup0, eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE, include=FALSE----
## ThG: chunk added to enable global knitr options. The below turns on
## caching for faster vignette re-build during text editing.
library(knitr); opts_chunk$set(cache=TRUE, message=FALSE, warning=FALSE)

## ----css, echo = FALSE, results = 'asis'--------------------------------------
BiocStyle::markdown(css.files=c('file/custom.css'))

