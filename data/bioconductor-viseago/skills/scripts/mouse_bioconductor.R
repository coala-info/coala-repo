# Code example from 'mouse_bioconductor' vignette. See references/ for full tutorial.

## ----setup,include=FALSE------------------------------------------------------
# load ViSEAGO and mouse db package
library(ViSEAGO)

# knitr document options
knitr::opts_chunk$set(
    eval=FALSE,echo=TRUE,fig.pos = 'H',
    fig.width=6,message=FALSE,comment=NA,warning=FALSE
)

## ----vignette_data_used,eval=TRUE---------------------------------------------
# load vignette data
data(
    myGOs,
    package="ViSEAGO"
)

## ----geneList_input,eval=TRUE-------------------------------------------------
# load genes identifiants (GeneID,ENS...) background (expressed genes) 
background<-scan(
    system.file(
        "extdata/data/input",
        "background_L.txt",
        package = "ViSEAGO"
    ),
    quiet=TRUE,
    what=""
)

# load Differentialy Expressed (DE) gene identifiants from lists
PregnantvsLactateDE<-scan(
    system.file(
        "extdata/data/input",
        "pregnantvslactateDE.txt",
        package = "ViSEAGO"
    ),
    quiet=TRUE,
    what=""
)

VirginvsLactateDE<-scan(
    system.file(
        "extdata/data/input",
        "virginvslactateDE.txt",
        package = "ViSEAGO"
    ),
    quiet=TRUE,
    what=""
)

VirginvsPregnantDE<-scan(
    system.file(
        "extdata/data/input",
        "virginvspregnantDE.txt",
        package = "ViSEAGO"
    ),
    quiet=TRUE,
    what=""
)

## ----geneList_input-head,echo=FALSE-------------------------------------------
# # show the ten first lines of genes_DE (same as genes_ref)
# head(PregnantvsLactateDE)

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
# # create topGOdata for BP for each list of DE genes
# BP_PregnantvsLactate<-ViSEAGO::create_topGOdata(
#     geneSel=PregnantvsLactateDE,
#     allGenes=background,
#     gene2GO=myGENE2GO,
#     ont="BP",
#     nodeSize=5
# )
# 
# BP_VirginvsLactate<-ViSEAGO::create_topGOdata(
#     geneSel=VirginvsLactateDE,
#     allGenes=background,
#     gene2GO=myGENE2GO,
#     ont="BP",
#     nodeSize=5
# )
# 
# BP_VirginvsPregnant<-ViSEAGO::create_topGOdata(
#     geneSel=VirginvsPregnantDE,
#     allGenes=background,
#     gene2GO=myGENE2GO,
#     ont="BP",
#     nodeSize=5
# )

## ----Enrichment_data_tests----------------------------------------------------
# # perform topGO tests
# elim_BP_PregnantvsLactate<-topGO::runTest(
#     BP_PregnantvsLactate,
#     algorithm ="elim",
#     statistic = "fisher",
#     cutOff=0.01
# )
# 
# elim_BP_VirginvsLactate<-topGO::runTest(
#     BP_VirginvsLactate,
#     algorithm ="elim",
#     statistic = "fisher",
#     cutOff=0.01
# )
# 
# elim_BP_VirginvsPregnant<-topGO::runTest(
#     BP_VirginvsPregnant,
#     algorithm ="elim",
#     statistic = "fisher",
#     cutOff=0.01
# )

## ----Enrichment_merge---------------------------------------------------------
# # merge topGO results
# BP_sResults<-ViSEAGO::merge_enrich_terms(
#     cutoff=0.01,
#     Input=list(
#         PregnantvsLactate=c(
#             "BP_PregnantvsLactate",
#             "elim_BP_PregnantvsLactate"
#         ),
#         VirginvsLactate=c(
#             "BP_VirginvsLactate",
#             "elim_BP_VirginvsLactate"
#         ),
#         VirginvsPregnant=c(
#             "BP_VirginvsPregnant",
#             "elim_BP_VirginvsPregnant"
#         )
#     )
# )

## ----Enrichment_merge_show----------------------------------------------------
# # display a summary
# BP_sResults

## ----Enrichment_merge_display,echo=FALSE,eval=TRUE----------------------------
cat(
"- object class: enrich_GO_terms
- ontology: BP
- method: topGO
- summary:PregnantvsLactate
      BP_PregnantvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7699
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_PregnantvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10 
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 199
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        Nontrivial_nodes: 8433 
 VirginvsLactate
      BP_VirginvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 9583
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10 
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 152
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        Nontrivial_nodes: 8457 
 VirginvsPregnant
      BP_VirginvsPregnant 
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7302
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsPregnant 
        description: Bioconductor org.Mm.eg.db 2019-Jul10 
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 243
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        Nontrivial_nodes: 8413 
 
- enrichment pvalue cutoff:
        PregnantvsLactate : 0.01
        VirginvsLactate : 0.01
        VirginvsPregnant : 0.01
- enrich GOs (in at least one list): 521 GO terms of 3 conditions.
        PregnantvsLactate : 199 terms
        VirginvsLactate : 152 terms
        VirginvsPregnant : 243 terms"
)

## ----Enrichment_merge_table---------------------------------------------------
# # show table in interactive mode
# ViSEAGO::show_table(BP_sResults)

## ----Enrichment_merge_count---------------------------------------------------
# # barchart of significant (or not) GO terms by comparison
# ViSEAGO::GOcount(BP_sResults)

## ----Enrichment_merge_interactions--------------------------------------------
# # display intersections
# ViSEAGO::Upset(
#     BP_sResults,
#     file="upset.xls"
# )

## ----SS_build-----------------------------------------------------------------
# # create GO_SS-class object
# myGOs<-ViSEAGO::build_GO_SS(
#     gene2GO=myGENE2GO,
#     enrich_GO_terms=BP_sResults
# )

## ----SS_compute---------------------------------------------------------------
# # compute Semantic Similarity (SS)
# myGOs<-ViSEAGO::compute_SS_distances(
#     myGOs,
#     distance="Wang"
# )

## ----SS_build_compute_show----------------------------------------------------
# # display a summary
# myGOs

## ----SS_build_compute_display,echo=FALSE,eval=TRUE----------------------------
cat(
"- object class: GO_SS
- ontology: BP
- method: topGO
- summary:
PregnantvsLactate
      BP_PregnantvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7699
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_PregnantvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10 
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 199
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        Nontrivial_nodes: 8433 
 VirginvsLactate
      BP_VirginvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 9583
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10 
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 152
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        Nontrivial_nodes: 8457 
 VirginvsPregnant
      BP_VirginvsPregnant 
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7302
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsPregnant 
        description: Bioconductor org.Mm.eg.db 2019-Jul10 
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 243
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        Nontrivial_nodes: 8413 
 - enrichment pvalue cutoff:
        PregnantvsLactate : 0.01
        VirginvsLactate : 0.01
        VirginvsPregnant : 0.01
- enrich GOs (in at least one list): 521 GO terms of 3 conditions.
        PregnantvsLactate : 199 terms
        VirginvsLactate : 152 terms
        VirginvsPregnant : 243 terms
- terms distances:  Wang"
)

## ----SS_terms_mdsplot---------------------------------------------------------
# # MDSplot
# ViSEAGO::MDSplot(myGOs)

## ----SS_Wang-wardD2-----------------------------------------------------------
# # Create GOterms heatmap
# Wang_clusters_wardD2<-ViSEAGO::GOterms_heatmap(
#     myGOs,
#     showIC=FALSE,
#     showGOlabels =FALSE,
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

## ----SS_Wang-wardD2_heatmap_display-------------------------------------------
# # display the heatmap
# ViSEAGO::show_heatmap(
#     Wang_clusters_wardD2,
#     "GOterms"
# )

## ----SS_Wang-ward.D2_table----------------------------------------------------
# # display table
# ViSEAGO::show_table(
#     Wang_clusters_wardD2
# )

## ----SS_Wang-ward.D2_mdsplot--------------------------------------------------
# # colored MDSplot
# ViSEAGO::MDSplot(
#     Wang_clusters_wardD2,
#     "GOterms"
# )

## ----SS_Wang-wardD2_groups----------------------------------------------------
# # calculate semantic similarites between clusters of GO terms
# Wang_clusters_wardD2<-ViSEAGO::compute_SS_distances(
#     Wang_clusters_wardD2,
#     distance="BMA"
# )

## ----SS_Wang-ward.D2_groups_mdsplot-------------------------------------------
# # MDSplot
# ViSEAGO::MDSplot(
#     Wang_clusters_wardD2,
#     "GOclusters"
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
# # display the heatmap
# ViSEAGO::show_heatmap(
#     Wang_clusters_wardD2,
#     "GOclusters"
# )

## ----SS_Wang-wardD2_groups_show-----------------------------------------------
# # display a summary
# Wang_clusters_wardD2

## ----SS_Wang-wardD2_groups_display,echo=FALSE,eval=TRUE-----------------------
cat(
"- object class: GO_clusters
- ontology: BP
- method: topGO
- summary:
PregnantvsLactate
      BP_PregnantvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7699
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_PregnantvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10 
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 199
        feasible_genes: 14091
        feasible_genes_significant: 7044
        genes_nodeSize: 5
        Nontrivial_nodes: 8433 
 VirginvsLactate
      BP_VirginvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 9583
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsLactate 
        description: Bioconductor org.Mm.eg.db 2019-Jul10 
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 152
        feasible_genes: 14091
        feasible_genes_significant: 8734
        genes_nodeSize: 5
        Nontrivial_nodes: 8457 
 VirginvsPregnant
      BP_VirginvsPregnant 
        description: Bioconductor org.Mm.eg.db 2019-Jul10
        available_genes: 15804
        available_genes_significant: 7302
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        nodes_number: 8463
        edges_number: 19543
      elim_BP_VirginvsPregnant 
        description: Bioconductor org.Mm.eg.db 2019-Jul10 
        test_name: fisher p<0.01
        algorithm_name: elim
        GO_scored: 8463
        GO_significant: 243
        feasible_genes: 14091
        feasible_genes_significant: 6733
        genes_nodeSize: 5
        Nontrivial_nodes: 8413 
 - enrichment pvalue cutoff:
        PregnantvsLactate : 0.01
        VirginvsLactate : 0.01
        VirginvsPregnant : 0.01
- enrich GOs (in at least one list): 521 GO terms of 3 conditions.
        PregnantvsLactate : 199 terms
        VirginvsLactate : 152 terms
        VirginvsPregnant : 243 terms
- terms distances:  Wang
- clusters distances: BMA
- Heatmap:
          * GOterms: TRUE
                    - GO.tree:
                              tree.distance: Wang
                              tree.aggreg.method: ward.D2
                              cut.dynamic.pamStage: TRUE
                              cut.dynamic.pamRespectsDendro: TRUE
                              cut.dynamic.deepSplit: 2
                              cut.dynamic.minClusterSize: 2
                              number of clusters: 62
                              clusters min size: 2
                              clusters mean size: 8
                              clusters max size: 32
                   - sample.tree: FALSE
          * GOclusters: TRUE
                       - tree:
                              distance: BMA
                              aggreg.method: ward.D2"
)

## ----session,eval=TRUE,echo=FALSE---------------------------------------------
sessionInfo()

