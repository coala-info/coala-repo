# Code example from 'interactiveDisplayBase' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
suppressWarnings(suppressPackageStartupMessages(library(knitr)))
options(width=80)

## ----wrap-hook, echo=FALSE----------------------------------------------------
hook_output = knit_hooks$get('output')
knit_hooks$set(output = function(x, options) {
  # this hook is used only when the linewidth option is not NULL
  if (!is.null(n <- options$linewidth)) {
    x = knitr:::split_lines(x)
    # any lines wider than n should be wrapped
    if (any(nchar(x) > n)) x = strwrap(x, width = n)
    x = paste(x, collapse = '\n')
  }
  hook_output(x, options)
})

## ----interactiveDisplayBase-load,include=TRUE,results="hide",message=FALSE,warning=FALSE----
library(interactiveDisplayBase)

## ----dataframe_demo, eval=FALSE-----------------------------------------------
# mtcars2 <- display(mtcars)

