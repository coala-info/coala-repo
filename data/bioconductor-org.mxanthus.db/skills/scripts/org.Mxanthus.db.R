# Code example from 'org.Mxanthus.db' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, eval = TRUE)

## ----A, echo=TRUE, eval=TRUE, message=FALSE-----------------------------------

library(org.Mxanthus.db)


## ----1, echo=TRUE-------------------------------------------------------------

keytypes(org.Mxanthus.db)

## ----2, echo=TRUE-------------------------------------------------------------
columns(org.Mxanthus.db)

## ----3, echo=TRUE-------------------------------------------------------------
select(org.Mxanthus.db, keys="7179", columns=c("SYMBOL","UNIPROT","NAME"))

## ----4------------------------------------------------------------------------
select(org.Mxanthus.db, keys="2000", columns=c("SYMBOL","GO"))

## ----5------------------------------------------------------------------------
select(org.Mxanthus.db, keys="2000", columns=c("SYMBOL","OLD_MXAN"))

## ----6, echo=TRUE, message=FALSE----------------------------------------------
library(DBI)

connection <- dbconn(org.Mxanthus.db)

## ----7, echo=TRUE, message=FALSE----------------------------------------------

gene_info <- dbGetQuery(connection, "SELECT * FROM gene_info")
go <- dbGetQuery(connection, "SELECT * FROM go")
chromosome <- dbGetQuery(connection, "SELECT * FROM chromosome")

## ----8, echo=TRUE, message=FALSE----------------------------------------------

query <- dbGetQuery(connection, "SELECT SYMBOL,NAME FROM gene_info")

## ----9, echo=TRUE, message=FALSE----------------------------------------------

query_2 <- dbGetQuery(connection, "SELECT COUNT(*) FROM gene_info")

## ----10, echo=TRUE, message=FALSE---------------------------------------------

query_3 <- dbGetQuery(connection, "SELECT GO,EVIDENCE,ONTOLOGY FROM go WHERE ONTOLOGY = 'BP'")

## ----11, echo=TRUE, message=FALSE---------------------------------------------
library(clusterProfiler)

genes <- exampleGene

head(bitr(genes, fromType="SYMBOL", toType="OLD_MXAN", OrgDb=org.Mxanthus.db))

## ----12, echo=TRUE, eval = TRUE-----------------------------------------------
ggo <- groupGO(gene     = genes,
               OrgDb    = org.Mxanthus.db,
               keyType = "SYMBOL",
               ont      = "MF",
               level    = 3)

barplot(ggo, drop=TRUE, showCategory=25)

## ----13 , echo=TRUE, eval = TRUE----------------------------------------------
universe <- (dbGetQuery(connection, "SELECT SYMBOL FROM gene_info"))$SYMBOL
  
ego <- enrichGO(gene          = genes,
                universe      = universe,
                keyType       = "SYMBOL",
                OrgDb         = org.Mxanthus.db,
                ont           = "BP",
                pAdjustMethod = "BH",
                pvalueCutoff  = 0.01,
                qvalueCutoff  = 0.05)

dotplot(ego)

