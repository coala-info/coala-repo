# Code example from 'TrappingConditions' vignette. See references/ for full tutorial.

## ----echo = FALSE--------------------------------------------------------
options(markdown.HTML.options = "toc")

## ------------------------------------------------------------------------
e2 <- function(...)  stop(...)
e1 <- function(...)  e2(...)

w2 <- function(...)  warning(...)
w1 <- function(...)  w2(...)

m2 <- function(...)  message(...)
m1 <- function(...)  m2(...)

## ------------------------------------------------------------------------
library(AnalysisPageServer)
vwc <- tryKeepConditions({
  m1("first message")
  m1("second message")
  w1("a warning")
  42
})
vwcErr <- tryKeepConditions({
  w1("a warning before the error")
  e1("this is a bad error")
  42
})

## ------------------------------------------------------------------------
vwc.is.error(vwc)
vwc.is.error(vwcErr)
vwc.value(vwc)
vwc.value(vwcErr)

## ------------------------------------------------------------------------
vwc.messages.conditions(vwc)
vwc.messages.conditions(vwcErr)
vwc.warnings.conditions(vwc)
vwc.warnings.conditions(vwcErr)
vwc.error.condition(vwc)
vwc.error.condition(vwcErr)

## ------------------------------------------------------------------------
vwc.messages(vwc)
vwc.messages(vwcErr)
vwc.warnings(vwc)
vwc.warnings(vwcErr)
vwc.error(vwcErr)

## ------------------------------------------------------------------------
vwc.messages.tracebacks(vwc)
vwc.messages.tracebacks(vwcErr)
vwc.warnings.tracebacks(vwc)
vwc.warnings.tracebacks(vwcErr)
vwc.error.traceback(vwc)
vwc.error.traceback(vwcErr)

## ------------------------------------------------------------------------
sessionInfo()

