# Code example from 'OrganismDbi' vignette. See references/ for full tutorial.

## ----figure, fig.cap = "Relationships between Annotation packages", echo = FALSE----
knitr::include_graphics("relationships-between-annotation-packages.png")

## ----columns, message = FALSE, warning = FALSE--------------------------------
library(Homo.sapiens)
columns(Homo.sapiens)

## ----keys1, message = FALSE, warning = FALSE----------------------------------
keytypes(Homo.sapiens)

## ----keys2, message = FALSE, warning = FALSE----------------------------------
head(keys(Homo.sapiens, keytype = "ENTREZID"))

## ----select, message = FALSE, warning = FALSE---------------------------------
k <- head(keys(Homo.sapiens, keytype = "ENTREZID"), n = 3)
select(
  Homo.sapiens,
  keys = k,
  columns = c("TXNAME", "SYMBOL"),
  keytype = "ENTREZID"
)

## ----transcripts, message = FALSE, warning = FALSE----------------------------
transcripts(Homo.sapiens, columns = c("TXNAME", "SYMBOL"))

## ----transcriptsBy, message = FALSE, warning = FALSE--------------------------
transcriptsBy(Homo.sapiens,
              by = "gene",
              columns = c("TXNAME", "SYMBOL"))

## ----setupColData, message = FALSE, warning = FALSE---------------------------
gd <- list(
  join1 = c(GO.db = "GOID", org.Hs.eg.db = "GO"),
  join2 = c(
    org.Hs.eg.db = "ENTREZID",
    TxDb.Hsapiens.UCSC.hg19.knownGene = "GENEID"
  )
)

## ----makeOrganismPackage, eval = FALSE----------------------------------------
# destination <- tempfile()
# dir.create(destination)
# makeOrganismPackage(
#   pkgname = "Homo.sapiens",
#   graphData = gd,
#   organism = "Homo sapiens",
#   version = "1.0.0",
#   maintainer = "Package Maintainer<maintainer@somewhere.org>",
#   author = "Some Body",
#   destDir = destination,
#   license = "Artistic-2.0"
# )

