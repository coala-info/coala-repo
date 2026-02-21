# Genome wide annotation for Myxococcus xanthus DK 1622

Eduardo Illueca Fernandez\
Department of Informatic and Systems, University of Murcia

#### `2019-30-10`

#### Package

org.Mxanthus.db 1.0.27

# Contents

* [1 Introduction](#introduction)
* [2 API use](#api-use)
* [3 Queries with SQL](#queries-with-sql)
* [4 Use with `clusterProfiler`](#use-with-clusterprofiler)

# 1 Introduction

*Myxococcus xanthus* is a gram-negative, rod-shaped species of myxobacteria that exhibits various forms of self-organizing behavior as a response to environmental cues. Under normal conditions with abundant food, it exists as a predatory, saprophytic single-species biofilm called a swarm. Under starvation conditions, it undergoes a multicellular development cycle. In the recent years, it becomes so important due to its complex regulation networks and it is important its genomic study.
So, `org.Mxanthus.db` is a OrgDb package that uses `AnnotationHub` to store the data. The purpose of this package is to provide the user with a database to collect information about the organism *Myxococcus xanthus* DK 1622 and to use this information in other bioinformatics tasks, such as enrichment analysis. Therefore, this manual will show the use of this package as an API to map different identifiers in *Myxococcus xanthus* DK 1622 and its use combined with other packages such as `clusterProfiler`.

# 2 API use

The you can check all the keytypes that `org.Mxanthus.db` supports :

```
library(org.Mxanthus.db)
```

```
keytypes(org.Mxanthus.db)
```

```
##  [1] "CHROMOSOME"     "END"            "EVIDENCE"       "EVIDENCEALL"
##  [5] "GID"            "GO"             "GOALL"          "LOCUS_TAG"
##  [9] "NAME"           "OLD_MXAN"       "ONTOLOGY"       "ONTOLOGYALL"
## [13] "PARENT"         "REFSEQ_PROTEIN" "START"          "SYMBOL"
## [17] "UNIPROT"
```

It is equivalent to use the `columns` method

```
columns(org.Mxanthus.db)
```

```
##  [1] "CHROMOSOME"     "END"            "EVIDENCE"       "EVIDENCEALL"
##  [5] "GID"            "GO"             "GOALL"          "LOCUS_TAG"
##  [9] "NAME"           "OLD_MXAN"       "ONTOLOGY"       "ONTOLOGYALL"
## [13] "PARENT"         "REFSEQ_PROTEIN" "START"          "SYMBOL"
## [17] "UNIPROT"
```

You can also do some simple querys with `select` that could help you to match differents keytypes. For example, if you want to know the SYMBOL, the UNIPROT ID, and the gene NAME you could use something similar.

```
select(org.Mxanthus.db, keys="7179", columns=c("SYMBOL","UNIPROT","NAME"))
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##    GID       SYMBOL UNIPROT                          NAME
## 1 7179 MXAN_RS04930  Q1DDI6 glycosyl transferase family 1
```

Or more complex querys:

```
select(org.Mxanthus.db, keys="2000", columns=c("SYMBOL","GO"))
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
##    GID       SYMBOL         GO
## 1 2000 MXAN_RS14035 GO:0000166
## 2 2000 MXAN_RS14035 GO:0004222
## 3 2000 MXAN_RS14035 GO:0005524
## 4 2000 MXAN_RS14035 GO:0006508
## 5 2000 MXAN_RS14035 GO:0008233
## 6 2000 MXAN_RS14035 GO:0008237
```

An other important of `org.Mxanthus.db` is that it support the old locus tag (MXAN). All research that works with *Myxococcus xanthus* use this code to identify each gene, but in the new NCBI version this code has changed. So, `org.Mxanthus.db` could map the new code with the old code.

```
select(org.Mxanthus.db, keys="2000", columns=c("SYMBOL","OLD_MXAN"))
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##    GID       SYMBOL  OLD_MXAN
## 1 2000 MXAN_RS14035 MXAN_2898
```

# 3 Queries with SQL

The main disadvantage of the above methods is that they are based on the GID column. This represents an arbitrary number that is assigned to each gene and acts as the primary key. However, it has no biological significance. Another way to make more complex queries is to use the `DBI` package, which allows to perfor SQL queries. First, a connection with the SQL database stored in AnnotationHub is established. This connection is saved in the `connection` variable

```
library(DBI)

connection <- dbconn(org.Mxanthus.db)
```

The database is structured in three tables. The first is gene\_info table that links each gene with their corresponding SYMBOL, NAME (it is a description of the product), REFSEQ\_PROTEIN (the RefSeq id of the product), UNIPROT and OLD\_MXAN. The second table is go table and links each GO(GO\_Term and acts as primary key) with their corresponding EVIDENCE, ONTOLOGY and GID(this acts as foreign key). The third table is not so important because it links each gene with its chromosome, but *Myxococcus xanthus* DK 1622 has only one chromosome. You can see the three tables qith the following queries.

```
gene_info <- dbGetQuery(connection, "SELECT * FROM gene_info")
go <- dbGetQuery(connection, "SELECT * FROM go")
chromosome <- dbGetQuery(connection, "SELECT * FROM chromosome")
```

This first example retrieves all SYMBOL and NAME from *Myxococcus xanthus* DK 1622 (obviusly, registred in the database)

```
query <- dbGetQuery(connection, "SELECT SYMBOL,NAME FROM gene_info")
```

This second example counts the number of genes stored in the database

```
query_2 <- dbGetQuery(connection, "SELECT COUNT(*) FROM gene_info")
```

This is a more complex query. It returns the GO, EVIDENCE and ONTOLOGY for all GO\_terms that are part for the BP ontology.

```
query_3 <- dbGetQuery(connection, "SELECT GO,EVIDENCE,ONTOLOGY FROM go WHERE ONTOLOGY = 'BP'")
```

# 4 Use with `clusterProfiler`

A great adventage of this package (and for OrgDb packages in general) is that it could be used in combination with `clusterProfiler` to perform GO enrichment analysis. Also, othe interesting method in `clusterProfiler` is `bitr`. You could use the `bitr` function to map a set of genes, as it is showed in this example. There is a set of example genes obtained from de *Myxococcus xanthus* DK 1622 in the `exampleGene` object (loaded with the package)

```
library(clusterProfiler)

genes <- exampleGene

head(bitr(genes, fromType="SYMBOL", toType="OLD_MXAN", OrgDb=org.Mxanthus.db))
```

```
##         SYMBOL  OLD_MXAN
## 1 MXAN_RS17185 MXAN_3545
## 2 MXAN_RS24660 MXAN_5076
## 3 MXAN_RS14900 MXAN_3074
## 4 MXAN_RS22750 MXAN_4684
## 5 MXAN_RS11420 MXAN_2363
## 6 MXAN_RS16065 MXAN_3314
```

Prior to enrichment analysis, a gene count can be performed. That is, the groupGO method counts the number of genes associated with each GO\_term. You could plot your results.

```
ggo <- groupGO(gene     = genes,
               OrgDb    = org.Mxanthus.db,
               keyType = "SYMBOL",
               ont      = "MF",
               level    = 3)

barplot(ggo, drop=TRUE, showCategory=25)
```

![](data:image/png;base64...)

The enrichment analysis consist to determine whether in a group of genes, there is a subset of genes that is over-represented statistically associated with a GO term. To do this, it is necessary to define the universe that is the vector of all defined genes for *Myxococcus xanthus* DK 1622. You could this with a simple SQL query. Again, you could plot the results.

```
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
```

![](data:image/png;base64...)