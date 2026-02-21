# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="asis"-----------------------------------------------
library(rebook)
chapterPreamble()

## -----------------------------------------------------------------------------
example0 <- system.file("example", "test.Rmd", package="rebook")
example <- tempfile(fileext=".Rmd")
file.copy(example0, example)

## ----results="asis"-----------------------------------------------------------
extractCached(example, chunk="godzilla-1954", object="godzilla")

## -----------------------------------------------------------------------------
godzilla

## ----results="asis"-----------------------------------------------------------
extractCached(example, chunk="ghidorah-1964", object=c("godzilla", "ghidorah"))

## -----------------------------------------------------------------------------
godzilla
ghidorah

## ----results="asis"-----------------------------------------------------------
extractCached(example, chunk="godzilla-2014", object="godzilla")

## -----------------------------------------------------------------------------
godzilla

## ----results="asis"-----------------------------------------------------------
extractCached(example, chunk="godzilla-2014", object=c("mechagodzilla", "godzilla"))

## -----------------------------------------------------------------------------
godzilla
mechagodzilla

## -----------------------------------------------------------------------------
link("installation", "OSCA.intro")
link("some-comments-on-experimental-design", "OSCA.intro")
link("fig:sce-structure", "OSCA.intro")

## ----results="asis"-----------------------------------------------------------
extractFromPackage("lun-416b.Rmd", chunk="clustering", 
    objects='sce.416b', package="OSCA.workflows")

## -----------------------------------------------------------------------------
sce.416b

## ----results="asis"-----------------------------------------------------------
prettySessionInfo()

