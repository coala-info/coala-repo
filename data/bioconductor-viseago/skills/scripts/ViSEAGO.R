# Code example from 'ViSEAGO' vignette. See references/ for full tutorial.

## ----setup,include=FALSE------------------------------------------------------
# koad ViSEAGO
library(ViSEAGO)

# knitr document options
knitr::opts_chunk$set(
  eval=FALSE,echo=TRUE,fig.pos = 'H',
  fig.width=8,message=FALSE,comment=NA,warning=FALSE
)

## ----ViSEAGO_install----------------------------------------------------------
# # Install ViSEAGO package from Bioconductor
# BiocManager::install("ViSEAGO")

## ----geneList_input_topGO-----------------------------------------------------
# # load genes background
# background<-scan(
#     "background.txt",
#     quiet=TRUE,
#     what=""
# )
# 
# # load gene selection
# selection<-scan(
#     "selection.txt",
#     quiet=TRUE,
#     what=""
# )

## ----geneList_input_fgsea-----------------------------------------------------
# # load gene identifiers column 1) and corresponding statistical value (column 2)
# table<-data.table::fread("table.txt")
# 
# # rank gene identifiers according statistical value
# data.table::setorder(table,value)

## ----databases----------------------------------------------------------------
# # connect to Bioconductor
# Bioconductor<-ViSEAGO::Bioconductor2GO()
# 
# # connect to EntrezGene
# EntrezGene<-ViSEAGO::EntrezGene2GO()
# 
# # connect to Ensembl
# Ensembl<-ViSEAGO::Ensembl2GO()
# 
# # connect to Uniprot-GOA
# Uniprot<-ViSEAGO::Uniprot2GO()
# 
# # connect to Custom file
# Custom<-ViSEAGO::Custom2GO(system.file("extdata/customfile.txt",package = "ViSEAGO"))

## ----organisms----------------------------------------------------------------
# # Display table of available organisms with Bioconductor
# ViSEAGO::available_organisms(Bioconductor)
# 
# # Display table of available organisms with EntrezGene
# ViSEAGO::available_organisms(EntrezGene)
# 
# # Display table of available organisms with Ensembl
# ViSEAGO::available_organisms(Ensembl)
# 
# # Display table of available organisms with Uniprot
# ViSEAGO::available_organisms(Uniprot)
# 
# # Display table of available organisms with Custom
# ViSEAGO::available_organisms(Custom)

## ----annotate-----------------------------------------------------------------
# # load GO annotations from Bioconductor
# myGENE2GO<-ViSEAGO::annotate(
#     "bioconductor_id",
#     Bioconductor
# )
# 
# # load GO annotations from EntrezGene
# myGENE2GO<-ViSEAGO::annotate(
#     "EntrezGene_id",
#     EntrezGene
# )
# 
# # load GO annotations from EntrezGene
# # with the add of GO annotations from orthologs genes (see above)
# myGENE2GO<-ViSEAGO::annotate(
#     "EntrezGene_id",
#     EntrezGene,
#     ortholog = TRUE
# )
# 
# # load GO annotations from Ensembl
# myGENE2GO<-ViSEAGO::annotate(
#     "Ensembl_id",
#     Ensembl
# )
# 
# # load GO annotations from Uniprot
# myGENE2GO<-ViSEAGO::annotate(
#     "Uniprot_id",
#     Uniprot
# )
# 
# # load GO annotations from Custom
# myGENE2GO<-ViSEAGO::annotate(
#     "Custom_id",
#     Custom
# )

## ----Enrichment_data----------------------------------------------------------
# # create topGOdata for BP
# BP<-ViSEAGO::create_topGOdata(
#     geneSel=selection,
#     allGenes=background,
#     gene2GO=myGENE2GO,
#     ont="BP",
#     nodeSize=5
# )

## ----Enrichment_data_tests----------------------------------------------------
# # perform TopGO test using clasic algorithm
# classic<-topGO::runTest(
#     BP,
#     algorithm ="classic",
#     statistic = "fisher"
# )

## ----fgsea--------------------------------------------------------------------
# # perform fgseaMultilevel tests
# BP<-ViSEAGO::runfgsea(
#     geneSel=table,
#     ont="BP",
#     gene2GO=myGENE2GO,
#     method ="fgseaMultilevel",
#     params = list(
#         scoreType = "pos",
#          minSize=5
#     )
# )

## ----Enrichment_merge---------------------------------------------------------
# # merge results from topGO
# BP_sResults<-ViSEAGO::merge_enrich_terms(
#     Input=list(
#         condition=c("BP","classic")
#     )
# )
# 
# # merge results from fgsea
# BP_sResults<-ViSEAGO::merge_enrich_terms(
#     Input=list(
#         condition="BP"
#     )
# )

## ----Enrichment_merge_display-------------------------------------------------
# # display the merged table
# ViSEAGO::show_table(BP_sResults)
# 
# # print the merged table in a file
# ViSEAGO::show_table(
#     BP_sResults,
#     "BP_sResults.xls"
# )

## ----Enrichment_merge_count---------------------------------------------------
# # count significant (or not) pvalues by condition
# ViSEAGO::GOcount(BP_sResults)

## ----Enrichment_merge_interactions,fig.height=4-------------------------------
# # display interactions
# ViSEAGO::Upset(
#     BP_sResults,
#     file="OLexport.xls"
# )

## ----SS_build-----------------------------------------------------------------
# # initialyse
# myGOs<-ViSEAGO::build_GO_SS(
#     gene2GO=myGENE2GO,
#     enrich_GO_terms=BP_sResults
# )
# 
# # compute all available Semantic Similarity (SS) measures
# myGOs<-ViSEAGO::compute_SS_distances(
#     myGOs,
#     distance="Wang"
# )

## ----SS_terms_mdsplot,eval=FALSE----------------------------------------------
# # display MDSplot
# ViSEAGO::MDSplot(myGOs)
# 
# # print MDSplot
# ViSEAGO::MDSplot(
#     myGOs,
#     file="mdsplot1.png"
# )

## ----SS_Wang-wardD2-----------------------------------------------------------
# # GOterms heatmap with the default parameters
# Wang_clusters_wardD2<-ViSEAGO::GOterms_heatmap(
#     myGOs,
#     showIC=TRUE,
#     showGOlabels=TRUE,
#     GO.tree=list(
#         tree=list(
#             distance="Wang",
#             aggreg.method="ward.D2"
#         ),
#         cut=list(
#             dynamic=list(
#                 pamStage=TRUE,
#                 pamRespectsDendro=TRUE,
#                 deepSplit=2,
#                 minClusterSize =2
#             )
#         )
#     ),
#     samples.tree=NULL
# )

## ----SS_Wang-wardD2_clusters-heatmap------------------------------------------
# # Display the clusters-heatmap
# ViSEAGO::show_heatmap(
#     Wang_clusters_wardD2,
#     "GOterms"
# )
# 
# # print the clusters-heatmap
# ViSEAGO::show_heatmap(
#     Wang_clusters_wardD2,
#     "GOterms",
#     "cluster_heatmap_Wang_wardD2.png"
# )

## ----SS_Wang-ward.D2_clusters-heatmap_table-----------------------------------
# # Display the clusters-heatmap table
# ViSEAGO::show_table(Wang_clusters_wardD2)
# 
# # Print the clusters-heatmap table
# ViSEAGO::show_table(
#     Wang_clusters_wardD2,
#     "cluster_heatmap_Wang_wardD2.xls"
# )

## ----SS_Wang-ward.D2_mdsplot,eval=FALSE---------------------------------------
# # display colored MDSplot
# ViSEAGO::MDSplot(
#     Wang_clusters_wardD2,
#     "GOterms"
# )
# 
# # print colored MDSplot
# ViSEAGO::MDSplot(
#     Wang_clusters_wardD2,
#     "GOterms",
#     file="mdsplot2.png"
# )

## ----SS_Wang-wardD2_groups----------------------------------------------------
# # calculate semantic similarites between clusters of GO terms
# Wang_clusters_wardD2<-ViSEAGO::compute_SS_distances(
#     Wang_clusters_wardD2,
#     distance=c("max", "avg","rcmax", "BMA")
# )

## ----SS_Wang-ward.D2_groups_mdsplot-------------------------------------------
# # build and highlight in an interactive MDSplot grouped clusters for one distance object
# ViSEAGO::MDSplot(
#     Wang_clusters_wardD2,
#     "GOclusters"
# )
# 
# # build and highlight in MDSplot grouped clusters for one distance object
# ViSEAGO::MDSplot(
#     Wang_clusters_wardD2,
#     "GOclusters",
#     file="mdsplot3.png"
# )

## ----SS_Wang-wardD2_groups_heatmap--------------------------------------------
# # GOclusters heatmap
# Wang_clusters_wardD2<-ViSEAGO::GOclusters_heatmap(
#     Wang_clusters_wardD2,
#     tree=list(
#         distance="BMA",
#         aggreg.method="ward.D2"
#     )
# )

## ----SS_Wang-ward.D2_groups_heatmap_display-----------------------------------
# # sisplay the GOClusters heatmap
# ViSEAGO::show_heatmap(
#     Wang_clusters_wardD2,
#     "GOclusters"
# )
# 
# # print the GOClusters heatmap in a file
# ViSEAGO::show_heatmap(
#     Wang_clusters_wardD2,
#     "GOclusters",
#     "Wang_clusters_wardD2_heatmap_groups.png"
# )

## ----session,eval=TRUE,echo=FALSE---------------------------------------------
version

