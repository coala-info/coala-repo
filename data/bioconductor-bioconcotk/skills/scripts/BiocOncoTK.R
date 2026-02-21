# Code example from 'BiocOncoTK' vignette. See references/ for full tutorial.

## ----setup,echo=FALSE,results="hide"---------------------------------------
suppressPackageStartupMessages({
suppressMessages({
library(BiocOncoTK)
library(BiocStyle)
library(dplyr)
library(DBI)
library(magrittr)
library(pogos)
library(org.Hs.eg.db)
library(restfulSE)
})
})

## ----lkgbm,fig=TRUE,message=FALSE------------------------------------------
library(ontoProc)
library(ontologyPlot)
oto = getOncotreeOnto()
glioTag = names(grep("Glioblastoma$", oto$name, value=TRUE))
st = siblings_TAG(glioTag, oto, justSibs=FALSE)
onto_plot(oto, slot(st, "ontoTags"), fontsize=50)

## ----lktata----------------------------------------------------------------
BiocOncoTK::pancan_sampTypeMap

## ----lkl, eval=FALSE-------------------------------------------------------
#  library(BiocOncoTK)
#  if (nchar(Sys.getenv("CGC_BILLING"))>0) {
#   pcbq = pancan_BQ() # basic connection
#   BRCA_mir = restfulSE::pancan_SE(pcbq)
#  }

## ----lknor,eval=FALSE------------------------------------------------------
#   BRCA_mir_nor = restfulSE::pancan_SE(pcbq, assaySampleTypeCode="NT")

## ----dotab, eval=FALSE-----------------------------------------------------
#  bqcon %>% tbl(pancan_longname("rnaseq")) %>% filter(Study=="GBM") %>%
#     group_by(SampleTypeLetterCode) %>% summarise(n=n())

## ----lkgbmr, eval=FALSE----------------------------------------------------
#  pancan_SE(bqcon, colDFilterValue="GBM", tumorFieldValue="GBM",
#    assayDataTableName=pancan_longname("rnaseq"),
#    assaySampleTypeCode="TR", assayFeatureName="Symbol",
#    assayValueFieldName="normalized_count")

## ----dose2, eval=FALSE-----------------------------------------------------
#  BRCA_mrna = pancan_SE(pcbq,
#     assayDataTableName = pancan_longname("rnaseq"),
#     assayFeatureName = "Entrez",
#     assayValueFieldName = "normalized_count")
#  BRCA_rppa = pancan_SE(pcbq,
#     assayDataTableName = pancan_longname("RPPA"),
#     assayFeatureName = "Protein",
#     assayValueFieldName = "Value")
#  BRCA_meth = pancan_SE(pcbq,
#     assayDataTableName = pancan_longname("27k")[2],
#     assayFeatureName = "ID",
#     assayValueFieldName = "Beta")

## ----dofig1,eval=FALSE-----------------------------------------------------
#  library(BiocOncoTK)
#  
#   infilGenes = c(`PD-L1`="CD274", `PD-L2`="PDCD1LG2", CD8A="CD8A")
#   tumcodes = c("COAD", "STAD", "UCEC")
#   combs = expand.grid(tumcode=tumcodes, ali=names(infilGenes),
#      stringsAsFactors=FALSE)
#   combs$sym = infilGenes[combs$ali]
#  
#   bq = pancan_BQ()
#   exprByMSI = function(bq, tumcode, genesym, alias) {
#    print(tumcode)
#    if (missing(alias)) alias=genesym
#    ex = bindMSI(buildPancanSE(bq, tumcode, assay="RNASeqv2"))
#    ex = replaceRownames(ex)
#    data.frame(
#     patient_barcode=colnames(ex),
#     acronym=tumcode,
#     symbol = genesym,
#     alias = alias,
#     log2ex=log2(as.numeric(SummarizedExperiment::assay(ex[genesym,]))+1),
#     msicode = ifelse(ex$msiTest >= 4, ">=4", "<4"))
#   }
#   allshow = lapply(1:nrow(combs), function(x) exprByMSI(bq, combs$tumcode[x],
#      combs$sym[x], combs$ali[x]))
#  
#   rr = do.call(rbind, allshow)
#  
#   library(ggplot2)
#   png(file="microsatpan2.png")
#   ggplot(rr,
#      aes(msicode, log2ex)) + geom_boxplot() +
#      facet_grid(acronym~alias) +
#      ylab("log2(normalized expr. + 1)") +
#      xlab("microsatellite instability score")
#   dev.off()

## ----lkapi-----------------------------------------------------------------
args(restfulSE::pancan_SE)

## ----lklo------------------------------------------------------------------
pancan_longname("rnaseq")

## ----lktarg, message=FALSE,eval=FALSE--------------------------------------
#  billco = Sys.getenv("CGC_BILLING")
#  if (nchar(billco)>0) {
#    con = DBI::dbConnect(bigrquery::bigquery(), project="isb-cgc",
#       dataset="TARGET_hg38_data_v0", billing=billco)
#    DBI::dbListTables(con)
#    con %>% tbl("RNAseq_Gene_Expression") %>% glimpse()
#    }

## ----lklk, message=FALSE, warning=FALSE,eval=FALSE-------------------------
#  if (nchar(billco)>0) {
#    con %>% tbl("RNAseq_Gene_Expression") %>%
#        select(project_short_name) %>%
#        group_by(project_short_name) %>%
#        summarise(n=n())
#  }

## ----lkccle2, message=FALSE, eval=FALSE------------------------------------
#  billco = Sys.getenv("CGC_BILLING")
#  if (nchar(billco)>0) {
#    con = DBI::dbConnect(bigrquery::bigquery(), project="isb-cgc",
#       dataset="ccle_201602_alpha", billing=billco)
#    DBI::dbListTables(con)
#  }

## ----lkmucc,eval=FALSE-----------------------------------------------------
#  muttab = con %>% tbl("Mutation_calls")
#  length(muttab %>% colnames())
#  muttab %>% select(Cell_line_primary_name, Hugo_Symbol,
#     Variant_Classification, cDNA_Change)%>% glimpse()

## ----lknras, warning=FALSE,eval=FALSE--------------------------------------
#  nrastab = muttab %>% select(Variant_Classification, Hugo_Symbol,
#      Cell_line_primary_name, CCLE_name) %>%
#       filter(Hugo_Symbol == "NRAS") %>% group_by(Hugo_Symbol)
#  nrastab %>% summarise(n=n())
#  nrasdf = nrastab %>% as.data.frame()

## ----dospl,eval=FALSE------------------------------------------------------
#  spl = function(x) {
#    z = strsplit(x, "_")
#    fir = vapply(z, function(x)x[1], character(1))
#    rest = vapply(z, function(x) paste(x[-1], collapse="_"), character(1))
#    list(fir, rest)
#  }
#  nrasdf$organ = spl(nrasdf$CCLE_name)[[2]]

## ----getmodnr,echo=FALSE---------------------------------------------------
nrasdf = load_nrasdf()

## ----illus-----------------------------------------------------------------
head(nrasdf)
table(nrasdf$organ)
prim_names = as.character(nrasdf$Cell_line_primary_name)

## ----lkccleex, message=FALSE, warning=FALSE, eval=FALSE--------------------
#  ccexp = con %>% tbl("AffyU133_RMA_expression")
#  ccexp %>% glimpse()
#  ccexp %>% select(Cell_line_primary_name, RMA_normalized_expression,
#      HGNC_gene_symbol) %>% filter(HGNC_gene_symbol == "AHR") %>%
#      filter(Cell_line_primary_name %in% nrasdf$Cell_line_primary_name) %>%
#      as.data.frame() -> NRAS_AHR
#  head(NRAS_AHR)

## ----domockahr,echo=FALSE--------------------------------------------------
NRAS_AHR = load_NRAS_AHR()
head(NRAS_AHR)

## ----dopog,eval=FALSE------------------------------------------------------
#  library(pogos)
#  ccleNRAS = DRTraceSet(NRAS_AHR[,1], drug="PD-0325901")
#  plot(ccleNRAS)

## ----dopogmock,echo=FALSE,results="hide",fig=TRUE--------------------------
ccleNRAS = load_ccleNRAS()
plot(ccleNRAS)

## ----drrr------------------------------------------------------------------
responsiveness = function (x, f) 
{
    r = sapply(slot(x, "traces"), function(x) f(slot(slot(x,"DRProfiles")[[1]],"responses")))
    data.frame(Cell_line_primary_name = slot(x,"cell_lines"), resp = r, 
        drug = slot(x,"drug"), dataset = x@dataset)
}

## ----lkaa------------------------------------------------------------------
AA = function(x) sum((pmax(0, x/100)))
head(rr <- responsiveness(ccleNRAS, AA))
summary(rr$resp)

## ----mrg-------------------------------------------------------------------
rexp = merge(rr, NRAS_AHR)
rexp[1:2,]

## ----lkda------------------------------------------------------------------
data(cell_70138)
names(cell_70138)
table(cell_70138$primary_site)
data(pert_70138)
dim(pert_70138)
names(pert_70138)

## ----lkdem-----------------------------------------------------------------
cd = clueDemos()
names(cd)
cd$sigs

## ----lkp1------------------------------------------------------------------
if (nchar(Sys.getenv("CLUE_KEY"))>0) {
lkbytarg = query_clue(service="perts", filter=list(where=list(target="EGFR")))
print(names(lkbytarg[[1]]))
sig1 = lkbytarg[[1]]$sig_id_gold[1]
}

## ----lkp2------------------------------------------------------------------
if (nchar(Sys.getenv("CLUE_KEY"))>0) {
sig1d = query_clue(service="sigs", filter=list(where=list(sig_id=sig1)))
print(names(sig1d[[1]]))
print(head(sig1d[[1]]$pert_iname)) # perturbagen
print(head(sig1d[[1]]$cell_id))  # cell type
print(head(sig1d[[1]]$dn50_lm))  # some downregulated genes among the landmark
print(head(sig1d[[1]]$up50_lm))  # some upregulated genes among the landmark
}

## ----lknpc, cache=TRUE-----------------------------------------------------
# use pertClasses() to get names of perturbagen classes in Clue
if (nchar(Sys.getenv("CLUE_KEY"))>0) {
tuinh = query_clue("perts", 
   filter=list(where=list(pcl_membership=list(inq=list("CP_HDAC_INHIBITOR"))))) 
inames_tu = sapply(tuinh, function(x)x$pert_iname)

npcSigs = query_clue(service="sigs", filter=list(where=list(cell_id="NPC")))
length(npcSigs)
gns = lapply(npcSigs, function(x) x$up50_lm)
perts = lapply(npcSigs, function(x) x$pert_iname)
touse = which(perts %in% inames_tu)
rec = names(tab <- sort(table(unlist(gns[touse])),decreasing=TRUE)[1:5])
cbind(select(org.Hs.eg.db, keys=rec, columns="SYMBOL"), n=as.numeric(tab))
}

## ----trylop----------------------------------------------------------------
if (interactive()) {
 patelSE = loadPatel() # uses BiocFileCache
 patelSE
 assay(patelSE[1:4,1:3]) # in memory
}

## ----lkdar-----------------------------------------------------------------
darmSE = BiocOncoTK::darmGBMcls  # count_lstpm from CONQUER
darmSE
assay(darmSE)  # out of memory

