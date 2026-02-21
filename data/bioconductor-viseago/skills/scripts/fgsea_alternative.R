# Code example from 'fgsea_alternative' vignette. See references/ for full tutorial.

## ----setup,include=FALSE------------------------------------------------------
# load ViSEAGO and mouse db package
library(ViSEAGO)

# knitr document options
knitr::opts_chunk$set(
    eval=FALSE,echo=TRUE,fig.pos = 'H',
    fig.width=6,message=FALSE,comment=NA,warning=FALSE
)

## ----geneList_input,eval=TRUE-------------------------------------------------
# load gene identifiants and padj test results from Differential Analysis complete tables
PregnantvsLactate<-data.table::fread(
    system.file(
        "extdata/data/input",
        "pregnantvslactate.complete.txt",
        package = "ViSEAGO"
    ),
    select = c("Id","padj")
)

VirginvsLactate<-data.table::fread(
     system.file(
        "extdata/data/input",
        "virginvslactate.complete.txt",
        package = "ViSEAGO"
    ),
    select = c("Id","padj")
)

VirginvsPregnant<-data.table::fread(
    system.file(
        "extdata/data/input",
        "virginvspregnant.complete.txt",
        package = "ViSEAGO"
    ),
    select = c("Id","padj")
)

# rank Id based on statistical value (BH padj in this example)
data.table::setorder(PregnantvsLactate,padj)
data.table::setorder(VirginvsLactate,padj)
data.table::setorder(VirginvsPregnant,padj)

## ----geneList_input-head,echo=FALSE,eval=TRUE---------------------------------
# show the ten first lines of genes_DE (same as genes_ref)
PregnantvsLactate

## ----Genomic-ressources-------------------------------------------------------
# # connect to Bioconductor
# Bioconductor<-ViSEAGO::Bioconductor2GO()
# 
# # load GO annotations from Bioconductor
# myGENE2GO<-ViSEAGO::annotate(
#     "org.Mm.eg.db",
#     Bioconductor
# )

## ----Genomic-ressources_show--------------------------------------------------
# # display summary
# myGENE2GO

## ----Genomic-ressources_display,echo=FALSE,eval=TRUE--------------------------
cat(
"- object class: gene2GO
- database: Bioconductor
- stamp/version: 2019-Jul10
- organism id: org.Mm.eg.db

GO annotations:
- Molecular Function (MF): 22707 annotated genes with 91986 terms (4121 unique terms)
- Biological Process (BP): 23210 annotated genes with 164825 terms (12224 unique terms)
- Cellular Component (CC): 23436 annotated genes with 107852 terms (1723 unique terms)"
)

## ----Enrichment_data----------------------------------------------------------
# # perform fgseaMultilevel tests
# BP_PregnantvsLactate<-ViSEAGO::runfgsea(
#     geneSel=PregnantvsLactate,
#     ont="BP",
#     gene2GO=myGENE2GO,
#     method ="fgseaMultilevel",
#     params = list(
#         scoreType = "pos",
#          minSize=5
#     )
# )
# 
# BP_VirginvsLactate<-ViSEAGO::runfgsea(
#     geneSel=VirginvsLactate,
#     gene2GO=myGENE2GO,
#     ont="BP",
#     method ="fgseaMultilevel",
#     params = list(
#         scoreType = "pos",
#          minSize=5
#     )
# )
# 
# BP_VirginvsPregnant<-ViSEAGO::runfgsea(
#     geneSel=VirginvsPregnant,
#     gene2GO=myGENE2GO,
#     ont="BP",
#     method ="fgseaMultilevel",
#     params = list(
#         scoreType = "pos",
#          minSize=5
#     )
# )

## ----Enrichment_merge---------------------------------------------------------
# # merge fgsea results
# BP_sResults<-ViSEAGO::merge_enrich_terms(
#     cutoff=0.01,
#     Input=list(
#         PregnantvsLactate="BP_PregnantvsLactate",
#         VirginvsLactate="BP_VirginvsLactate",
#         VirginvsPregnant="BP_VirginvsPregnant"
#     )
# )

## ----Enrichment_merge_show----------------------------------------------------
# # display a summary
# BP_sResults

## ----Enrichment_merge_display,echo=FALSE,eval=TRUE----------------------------
cat(
"- object class: enrich_GO_terms
- ontology: BP
- method: fgsea
- summary:
 PregnantvsLactate
    method : fgseaMultilevel
    sampleSize : 101
    minSize : 5
    maxSize : Inf
    eps : 0
    scoreType : pos
    nproc : 0
    gseaParam : 1
    BPPARAM : fgseaMultilevel
    absEps : 101
 VirginvsLactate
    method : fgseaMultilevel
    sampleSize : 101
    minSize : 5
    maxSize : Inf
    eps : 0
    scoreType : pos
    nproc : 0
    gseaParam : 1
    BPPARAM : fgseaMultilevel
    absEps : 101
 VirginvsPregnant
    method : fgseaMultilevel
    sampleSize : 101
    minSize : 5
    maxSize : Inf
    eps : 0
    scoreType : pos
    nproc : 0
    gseaParam : 1
    BPPARAM : fgseaMultilevel
    absEps : 101- enrichment pvalue cutoff:
        PregnantvsLactate : 0.01
        VirginvsLactate : 0.01
        VirginvsPregnant : 0.01
- enrich GOs (in at least one list): 184 GO terms of 3 conditions.
        PregnantvsLactate : 67 terms
        VirginvsLactate : 58 terms
        VirginvsPregnant : 64 terms"
)

