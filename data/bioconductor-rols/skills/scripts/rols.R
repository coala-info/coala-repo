# Code example from 'rols' vignette. See references/ for full tutorial.

## ----env, echo=FALSE, message=FALSE-------------------------------------------
suppressPackageStartupMessages(library("GO.db"))
suppressPackageStartupMessages(library("BiocStyle"))
suppressPackageStartupMessages(library("rols"))
suppressPackageStartupMessages(library("DT"))
suppressMessages(nonto <- length(ol <- olsOntologies()))

## ----install, eval=FALSE------------------------------------------------------
# ## try http:// if https:// URLs are not supported
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("rols")

## ----ontTable, echo = FALSE---------------------------------------------------
DT::datatable(as(ol, "data.frame"))

## -----------------------------------------------------------------------------
library("rols")

## ----ol-----------------------------------------------------------------------
ol <- olsOntologies()
ol

## -----------------------------------------------------------------------------
head(olsNamespace(ol))
ol[["bspo"]]

## -----------------------------------------------------------------------------
bspo <- olsOntology("bspo")
bspo

## -----------------------------------------------------------------------------
bspotrms <- olsTerms(bspo) ## or olsTerms("bspo")
bspotrms
bspotrms[1:10]
bspotrms[["BSPO:0000092"]]

## -----------------------------------------------------------------------------
trm <- olsTerm(bspo, "BSPO:0000092")
termId(trm)
termLabel(trm)

## -----------------------------------------------------------------------------
parents(trm)
children(trm)

## ----propex-------------------------------------------------------------------
trm <- olsTerm("uberon", "UBERON:0002107")
trm
p <- olsProperties(trm)
p
p[[1]]
termLabel(p[[1]])

## ----echo=FALSE---------------------------------------------------------------
alltgns <- OlsSearch(q = "trans-golgi network")

## ----tgnquery, eval = TRUE----------------------------------------------------
OlsSearch(q = "trans-golgi network")

## ----tgnquery1, eval = TRUE---------------------------------------------------
OlsSearch(q = "trans-golgi network", exact = TRUE)
OlsSearch(q = "trans-golgi network", ontology = "GO")
OlsSearch(q = "trans-golgi network", ontology = "GO", exact = TRUE)

## ----tgnquery2----------------------------------------------------------------
OlsSearch(q = "trans-golgi network", ontology = "GO", rows = 200)

## ----tgnsear4, echo=FALSE-----------------------------------------------------
qry <- OlsSearch(q = "trans-golgi network", exact = TRUE)

## ----tgnquery5----------------------------------------------------------------
qry <- OlsSearch(q = "trans-golgi network", exact = TRUE)
(qry <- olsSearch(qry))

## ----tgnres-------------------------------------------------------------------
(qtrms <- as(qry, "olsTerms"))
str(qdrf <- as(qry, "data.frame"))

## ----uterms-------------------------------------------------------------------
qtrms <- unique(qtrms)
termOntology(qtrms)
termNamespace(qtrms)

## ----go.db, message=FALSE-----------------------------------------------------
library("GO.db")
GOTERM[["GO:0005802"]]

## -----------------------------------------------------------------------------
CVParam(name = "A user param", value = "the value")

## -----------------------------------------------------------------------------
CVParam(label = "GO", accession = "GO:0035145")

## ----si, echo=FALSE-----------------------------------------------------------
print(sessionInfo(), locale = FALSE)

