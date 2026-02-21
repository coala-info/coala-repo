# Code example from 'ApacheDeployment' vignette. See references/ for full tutorial.

## ----echo = FALSE--------------------------------------------------------
options(markdown.HTML.options = "toc")

## ----echo = FALSE--------------------------------------------------------
app.basedir <- "rapache-example"
if(file.exists(app.basedir))
  unlink(app.basedir, recursive = TRUE)

## ----message = FALSE-----------------------------------------------------
library(AnalysisPageServer)
app.basedir <- "rapache-example"
dir.create(app.basedir)
app.basedir <- normalizePath(app.basedir)
app.basedir

## ----eval = FALSE--------------------------------------------------------
#  library(AnalysisPageServer)
#  reg <- AnalysisPageServer:::trig.registry()
#  app <- rapache.app.from.registry(reg,
#                                   tmpdir = tempdir())
#  app$add.handlers.to.global()

## ----echo = FALSE--------------------------------------------------------
writeLines("library(AnalysisPageServer)
reg <- AnalysisPageServer:::trig.registry()
app <- rapache.app.from.registry(reg,
                                 tmpdir = tempdir())
app$add.handlers.to.global()", file.path(app.basedir, "driver.R"))

## ------------------------------------------------------------------------
app.prefix <- "/myapp"
config.lines <- config.js(app.prefix = app.prefix)
config.js.path <- file.path(app.basedir, "config.js")
writeLines(config.lines, file.path(app.basedir, "config.js"))

## ----eval = FALSE--------------------------------------------------------
#  driver.path <- file.path(app.basedir, "driver.R")
#  app.location <- "/myapp"
#  
#  conf.lines <- apache.httpd.conf(driver.path = driver.path,
#    app.location = app.prefix,
#    config.js.path = config.js.path,
#    mod.R.path = "/usr/libexec/apache2/mod_R.so")
#  
#  httpd.conf.path <- file.path(app.basedir, "myapp-httpd.conf")
#  
#  writeLines(conf.lines, httpd.conf.path)

