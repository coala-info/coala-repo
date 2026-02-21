# Code example from 'BiocSet' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----bioconductor, eval = FALSE-----------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("BiocSet")

## ----github, eval = FALSE-----------------------------------------------------
# BiocManager::install("Kayla-Morrell/BiocSet")

## ----load, message = FALSE----------------------------------------------------
library(BiocSet)

## ----constructor--------------------------------------------------------------
tbl <- BiocSet(set1 = letters, set2 = LETTERS)
tbl

## ----gmt----------------------------------------------------------------------
gmtFile <- system.file(package = "BiocSet",
                        "extdata",
                        "hallmark.gene.symbol.gmt")
tbl2 <- import(gmtFile)
tbl2

## ----export, tidy = TRUE------------------------------------------------------
fl <- tempfile(fileext = ".gmt")
gmt <- export(tbl2, fl)
gmt

## ----obo, eval = FALSE--------------------------------------------------------
# download.file("http://current.geneontology.org/ontology/go.obo", "obo_file.obo")
# 
# foo <- import("obo_file.obo", extract_tag = "everything")
# 
# small_tst <- es_element(foo)[1,] %>%
#     unnest("ancestors") %>%
#     select("element", "ancestors") %>%
#     unlist() %>%
#     unique()
# 
# small_oboset <- foo %>% filter_elementset(element %in% small_tst)
# 
# fl <- tempfile(fileext = ".obo")
# export(small_oboset, fl)

## ----small_obo----------------------------------------------------------------
oboFile <- system.file(package = "BiocSet",
                        "extdata",
                        "sample_go.obo")
obo <- import(oboFile)
obo

## ----activate-----------------------------------------------------------------
tbl <- BiocSet(set1 = letters, set2 = LETTERS)
tbl
tbl %>% filter_element(element == "a" | element == "A")
tbl %>% mutate_set(pval = rnorm(1:2))
tbl %>% arrange_elementset(desc(element))

## ----set_ops------------------------------------------------------------------
# union of two BiocSet objects
es1 <- BiocSet(set1 = letters[c(1:3)], set2 = LETTERS[c(1:3)])
es2 <- BiocSet(set1 = letters[c(2:4)], set2 = LETTERS[c(2:4)])
union(es1, es2)

# union within a single BiocSet object
es3 <- BiocSet(set1 = letters[c(1:10)], set2 = letters[c(4:20)])
union_single(es3)

## ----airway, message = FALSE--------------------------------------------------
library(airway)
data("airway")
se <- airway

## ----go_sets, message = FALSE-------------------------------------------------
library(org.Hs.eg.db)
go <- go_sets(org.Hs.eg.db, "ENSEMBL")
go

# an example of subsetting by evidence type
go_sets(org.Hs.eg.db, "ENSEMBL", evidence = c("IPI", "TAS"))

## ----drop_assays--------------------------------------------------------------
se1 = se[rowSums(assay(se)) != 0,]
go %>% filter_element(element %in% rownames(se1))

## ----count--------------------------------------------------------------------
go %>% group_by(set) %>% dplyr::count()

## ----empty--------------------------------------------------------------------
drop <- es_activate(go, elementset) %>% group_by(set) %>%
    dplyr::count() %>% filter(n == 0) %>% pull(set)
go %>% filter_set(!(set %in% drop))

## ----map_unique---------------------------------------------------------------
go %>% map_unique(org.Hs.eg.db, "ENSEMBL", "SYMBOL")

## ----adding, message = FALSE--------------------------------------------------
library(GO.db)
map <- map_add_set(go, GO.db, "GOID", "DEFINITION")
go %>% mutate_set(definition = map)

## ----file_cache, message = FALSE----------------------------------------------
library(BiocFileCache)
rname <- "kegg_hsa"
exists <- NROW(bfcquery(query=rname, field="rname")) != 0L
if (!exists)
{
    kegg <- kegg_sets("hsa")
    fl <- bfcnew(rname = rname, ext = ".gmt")
    export(kegg_sets("hsa"), fl)
}
kegg <- import(bfcrpath(rname=rname))

## ----kegg_filter--------------------------------------------------------------
map <- map_add_element(kegg, org.Hs.eg.db, "ENTREZID", "ENSEMBL")
kegg <- kegg %>% mutate_element(ensembl = map)

## ----subset-------------------------------------------------------------------
asthma <- kegg %>% filter_set(set == "hsa05310")

se <- se[rownames(se) %in% es_element(asthma)$ensembl,]

se

## ----multiple-----------------------------------------------------------------
pathways <- c("hsa05310", "hsa04110", "hsa05224", "hsa04970")
multipaths <- kegg %>% filter_set(set %in% pathways)

multipaths

## ----airway2, message = FALSE-------------------------------------------------
data("airway")
airway$dex <- relevel(airway$dex, "untrt")

## ----DE-----------------------------------------------------------------------
library(DESeq2)
library(tibble)
des <- DESeqDataSet(airway, design = ~ cell + dex)
des <- DESeq(des)
res <- results(des)

tbl <- res %>% 
    as.data.frame() %>%
    as_tibble(rownames = "ENSEMBL") 

## ----ENTREZ-------------------------------------------------------------------
tbl <- tbl %>% 
    mutate(
        ENTREZID = mapIds(
            org.Hs.eg.db, ENSEMBL, "ENTREZID", "ENSEMBL"
        ) %>% unname()
    )

tbl <- tbl %>% filter(!is.na(padj), !is.na(ENTREZID))
tbl

## ----goana--------------------------------------------------------------------
library(limma)
go_ids <- goana(tbl$ENTREZID[tbl$padj < 0.05], tbl$ENTREZID, "Hs") %>%
    as.data.frame() %>%
    as_tibble(rownames = "GOALL")
go_ids

## ----final_tibble-------------------------------------------------------------
foo <- AnnotationDbi::select(
    org.Hs.eg.db,
    tbl$ENTREZID,
    "GOALL",
    "ENTREZID") %>% as_tibble()
foo <- foo %>% dplyr::select(-EVIDENCEALL) %>% distinct()
foo <- foo %>% filter(ONTOLOGYALL == "BP") %>% dplyr::select(-ONTOLOGYALL)
foo

## ----BiocSet_from_elementset--------------------------------------------------
foo <- foo %>% dplyr::rename(element = ENTREZID, set = GOALL)
tbl <- tbl %>% dplyr::rename(element = ENTREZID)
go_ids <- go_ids %>% dplyr::rename(set = GOALL)
es <- BiocSet_from_elementset(foo, tbl, go_ids)
es

## ----tibble_or_data.frame-----------------------------------------------------
tibble_from_element(es)

head(data.frame_from_elementset(es))

## ----url----------------------------------------------------------------------
url_ref(go)

## -----------------------------------------------------------------------------
sessionInfo()

