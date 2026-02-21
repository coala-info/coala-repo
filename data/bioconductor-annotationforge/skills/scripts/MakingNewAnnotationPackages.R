# Code example from 'MakingNewAnnotationPackages' vignette. See references/ for full tutorial.

## ----style, eval=TRUE, echo=FALSE, results='asis'--------------------------
BiocStyle::latex()

## ----include=FALSE---------------------------------------------------------
library(knitr)
opts_chunk$set(tidy=FALSE)

## ----Homo.sapiens----------------------------------------------------------
library(RSQLite)
library(Homo.sapiens)
columns(Homo.sapiens)

## ----Homo.sapiens2---------------------------------------------------------
keytypes(Homo.sapiens)

## ----Homo.sapiens3---------------------------------------------------------
k <- head(keys(Homo.sapiens,keytype="ENTREZID"))
k

## ----Homo.sapiens4---------------------------------------------------------
result <- select(Homo.sapiens, keys=k,
                 columns=c("TXNAME","TXSTART","TXSTRAND"),
                 keytype="ENTREZID")
head(result)

## ----BFC_manage,echo=FALSE-------------------------------------------------
.get_file <- function(fullUri) {
    bfc <- BiocFileCache::BiocFileCache()
    BiocFileCache::bfcrpath(
        bfc, rname = fullUri, exact = TRUE, download = TRUE, rtype = "web"
    )
}

## ----URI Example-----------------------------------------------------------
uri <- 'http://rest.uniprot.org/uniprotkb/search?query='
ids <- c('P13368', 'Q6GZX4')
idStr <- paste(ids, collapse=utils::URLencode(" OR "))
format <- '&format=tsv'
fullUri <- paste0(uri,idStr,format)
uquery <- .get_file(fullUri)
read.delim(uquery)

## ----web service code------------------------------------------------------
getUniprotGoodies  <- function(query, columns)
{
    ## query and columns start as a character vectors
    qstring <- paste(query, collapse="+or+")
    cstring <- paste(columns, collapse=",")
    uri <- 'http://www.uniprot.org/uniprot/?query='
    fullUri <- paste0(uri,qstring,'&format=tab&columns=',cstring)
    dat <- read.delim(fullUri)
    ## now remove things that were not in the specific original query...
    dat <- dat[dat[,1] %in% query,]
    dat
}

## ----xml_tree--------------------------------------------------------------
library(XML)
uri <- "http://rest.uniprot.org/uniprotkb/search?query=P13368%20OR%20Q6GZX4&format=xml"
fl <- tempfile()
download.file(uri, fl)
xml <- xmlTreeParse(fl, useInternalNodes=TRUE)

## ----xml_namespace---------------------------------------------------------
defs <- xmlNamespaceDefinitions(xml, recurisve=TRUE)
defs

## ----xml_namespace_struct--------------------------------------------------
ns <- structure(sapply(defs, function(x) x$uri), names=names(defs))

## ----xml_namespace2--------------------------------------------------------
entry <- getNodeSet(xml, "//ns:entry", "ns")
xmlSize(entry)

## ----xml_xmlAttrs----------------------------------------------------------
nms <- xpathSApply(xml, "//ns:entry/ns:name", xmlValue, namespaces="ns")
attrs <- xpathApply(xml, "//ns:entry", xmlAttrs, namespaces="ns")
names(attrs) <- nms
attrs

## ----xml_xmlChildren-------------------------------------------------------
fun1 <- function(elt) unique(names(xmlChildren(elt)))
xpathApply(xml, "//ns:entry", fun1, namespaces="ns")

## ----xml_feature_type------------------------------------------------------
Q6GZX4 <- "//ns:entry[ns:accession='Q6GZX4']/ns:feature"
xmlSize(getNodeSet(xml, Q6GZX4, namespaces="ns"))

P13368 <- "//ns:entry[ns:accession='P13368']/ns:feature"
xmlSize(getNodeSet(xml, P13368, namespaces="ns"))

## ----xml_feature_type2-----------------------------------------------------
path <- "//ns:feature"
unique(xpathSApply(xml, path, xmlGetAttr, "type", namespaces="ns"))

## ----xml_feature_type_P13368-----------------------------------------------
path <- "//ns:entry[ns:accession='P13368']/ns:feature[@type='sequence conflict']"
data.frame(t(xpathSApply(xml, path, xmlAttrs, namespaces="ns")))

## ----xml_sequence----------------------------------------------------------
library(Biostrings)
path <- "//ns:entry/ns:sequence"
seqs <- xpathSApply(xml, path, xmlValue, namespaces="ns")
aa <- AAStringSet(unlist(lapply(seqs, function(elt) gsub("\n", "", elt)),
    use.names=FALSE))
names(aa) <- nms
aa

## ----WebServiceObject------------------------------------------------------
setClass("uniprot", representation(name="character"),
         prototype(name="uniprot"))

## ----makeInstanceWebServiceObj---------------------------------------------
    uniprot <- new("uniprot")

## ----onLoad2,eval=FALSE----------------------------------------------------
# .onLoad <- function(libname, pkgname)
# {
#     ns <- asNamespace(pkgname)
#     uniprot <- new("uniprot")
#     assign("uniprot", uniprot, envir=ns)
#     namespaceExport(ns, "uniprot")
# }

## ----keytypeUniprot--------------------------------------------------------
setMethod("keytypes", "uniprot",function(x){return("UNIPROT")})
uniprot <- new("uniprot")
keytypes(uniprot)

## ----keytypeUniprot2-------------------------------------------------------
setMethod("columns", "uniprot",
          function(x){return(c("ID", "SEQUENCE", "ORGANISM"))})
columns(uniprot)

## ----webServiceSelect------------------------------------------------------
.select <- function(x, keys, columns){
    colsTranslate <- c(id='ID', sequence='SEQUENCE', organism='ORGANISM')
    columns <- names(colsTranslate)[colsTranslate %in% columns]
    getUniprotGoodies(query=keys, columns=columns)
}
setMethod("select", "uniprot",
    function(x, keys, columns, keytype)
{
    .select(keys=keys, columns=columns)
})

## ----webServiceSelect2, eval=FALSE-----------------------------------------
# select(uniprot, keys=c("P13368","P20806"), columns=c("ID","ORGANISM"))

## ----classicConn,results='hide'--------------------------------------------
drv <- SQLite()
library("org.Hs.eg.db")
con_hs <- dbConnect(drv, dbname=org.Hs.eg_dbfile())
con_hs

## ----ourConn2,eval=FALSE---------------------------------------------------
# org.Hs.eg.db$conn
# ## or better we can use a helper function to wrap this:
# AnnotationDbi::dbconn(org.Hs.eg.db)
# ## or we can just call the provided convenience function
# ## from when this package loads:
# org.Hs.eg_dbconn()

## ----dbListTables----------------------------------------------------------
head(dbListTables(con_hs))
dbListFields(con_hs, "alias")

## ----dbGetQuery------------------------------------------------------------
dbGetQuery(con_hs, "SELECT * FROM metadata")

## ----dbListTables2---------------------------------------------------------
head(dbListTables(con_hs))

## ----dbListFields2---------------------------------------------------------
dbListFields(con_hs, "chromosomes")

## ----dbGetQuery2-----------------------------------------------------------
head(dbGetQuery(con_hs, "SELECT * FROM chromosomes"))

## ----Anopheles,eval=FALSE--------------------------------------------------
# head(dbGetQuery(con_hs, "SELECT * FROM chromosome_locations"))
# ## Then only retrieve human records
# ## Query: SELECT * FROM Anopheles_gambiae WHERE species='HOMSA'
# head(dbGetQuery(con_hs, "SELECT * FROM chromosome_locations WHERE seqname='1'"))
# dbDisconnect(con_hs)

## ----getMetadata, echo=FALSE-----------------------------------------------
library(org.Hs.eg.db)
org.Hs.eg_dbInfo()

## ----OrgDbClass,eval=FALSE-------------------------------------------------
# showClass("OrgDb")

## ----onLoad,eval=FALSE-----------------------------------------------------
# sPkgname <- sub(".db$","",pkgname)
# db <- loadDb(system.file("extdata", paste(sPkgname,
#                ".sqlite",sep=""), package=pkgname, lib.loc=libname),
#                packageName=pkgname)
# dbNewname <- AnnotationDbi:::dbObjectName(pkgname,"OrgDb")
# ns <- asNamespace(pkgname)
# assign(dbNewname, db, envir=ns)
# namespaceExport(ns, dbNewname)

## ----columns,eval=FALSE----------------------------------------------------
# .cols <- function(x)
# {
#     con <- AnnotationDbi::dbconn(x)
#     list <- dbListTables(con)
#     ## drop unwanted tables
#     unwanted <- c("map_counts","map_metadata","metadata")
#     list <- list[!list %in% unwanted]
#     # use on.exit to disconnect
#     # on.exit(dbDisconnect(con))
#     ## Then just to format things in the usual way
#     toupper(list)
# }
# 
# ## Then make this into a method
# setMethod("columns", "OrgDb", .cols(x))
# ## Then we can call it
# columns(org.Hs.eg.db)

## ----keytypes,eval=FALSE---------------------------------------------------
# setMethod("keytypes", "OrgDb", function(x) .cols(x))
# ## Then we can call it
# keytypes(org.Hs.eg.db)
# 
# ## refactor of .cols
# .getLCcolnames <- function(x)
# {
#     con <- AnnotationDbi::dbconn(x)
#     list <- dbListTables(con)
#     ## drop unwanted tables
#     unwanted <- c("map_counts","map_metadata","metadata")
#     # use on.exit to disconnect
#     # on.exit(dbDisconnect(con))
#     list[!list %in% unwanted]
# }
# .cols <- function(x)
# {
#     list <- .getLCcolnames(x)
#     ## Then just to format things in the usual way
#     toupper(list)
# }
# ## Test:
# columns(org.Hs.eg.db)
# 
# ## new helper function:
# .getTableNames <- function(x)
# {
#     LC <- .getLCcolnames(x)
#     UC <- .cols(x)
#     names(UC) <- LC
#     UC
# }
# .getTableNames(org.Hs.eg.db)

## ----keys,eval=FALSE-------------------------------------------------------
# .keys <- function(x, keytype)
# {
#     ## translate keytype back to table name
#     tabNames <- .getTableNames(x)
#     lckeytype <- names(tabNames[tabNames %in% keytype])
#     ## get a connection
#     con <- AnnotationDbi::dbconn(x)
#     sql <- paste("SELECT _id FROM", lckeytype, "WHERE species != 'HOMSA'")
#     res <- dbGetQuery(con, sql)
#     res <- as.vector(t(res))
#     dbDisconnect(con)
#     res
# }
# 
# setMethod("keys", "ExampleDbClass", .keys)
# ## Then we would call it
# keys(example.db, "TRICHOPLAX_ADHAERENS")

## ----makeNewDb-------------------------------------------------------------
drv <- dbDriver("SQLite")
dbname <- file.path(tempdir(), "myNewDb.sqlite")
con <- dbConnect(drv, dbname=dbname)

## ----exampleFrame----------------------------------------------------------
data <- data.frame(id=c(22,7,15), string=c("Blue", "Red", "Green"))

## ----exercise2-------------------------------------------------------------
dbExecute(con, "CREATE Table genePheno (id INTEGER, string TEXT)")

## ----populate_SQL_table----------------------------------------------------
sql <- "INSERT INTO genePheno VALUES ($id, $string)"
dbExecute(con, sql, params=data)

## ----dbReadTable-----------------------------------------------------------
dbReadTable(con, "genePheno")

## ----ATTACH----------------------------------------------------------------
db <- system.file("extdata", "TxDb.Hsapiens.UCSC.hg19.knownGene.sqlite",
                  package="TxDb.Hsapiens.UCSC.hg19.knownGene")
dbExecute(con, sprintf("ATTACH '%s' AS db",db))

## ----ATTACHJoin------------------------------------------------------------
sql <- "SELECT * FROM db.gene AS dbg,
        genePheno AS gp WHERE dbg.gene_id=gp.id"
res <- dbGetQuery(con, sql)
res

## ----dbDisconnect----------------------------------------------------------
dbDisconnect(con)

## ----sessionInfo-----------------------------------------------------------
sessionInfo()

