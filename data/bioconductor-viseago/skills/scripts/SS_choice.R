# Code example from 'SS_choice' vignette. See references/ for full tutorial.

## ----setup,include=FALSE------------------------------------------------------
# load
library(ViSEAGO)

# knitr document options
knitr::opts_chunk$set(
    eval=FALSE,fig.path='./data/output/',echo=TRUE,fig.pos = 'H',
    fig.width=8,message=FALSE,comment=NA,warning=FALSE
)

## ----vignette_data_used-------------------------------------------------------
# # load vignette data
# data(
#     myGOs,
#     package="ViSEAGO"
# )

## ----SS_build,eval=FALSE------------------------------------------------------
# # compute Semantic Similarity (SS)
# myGOs<-ViSEAGO::compute_SS_distances(
#     myGOs,
#     distance=c("Resnik","Lin","Rel","Jiang","Wang")
# )

## ----SS_terms_Resnik-wardD2---------------------------------------------------
# # GO terms heatmap
# Resnik_clusters_wardD2<-ViSEAGO::GOterms_heatmap(
#     myGOs,
#     showIC=TRUE,
#     showGOlabels=TRUE,
#     GO.tree=list(
#         tree=list(
#             distance="Resnik",
#             aggreg.method="ward.D2"
#         ),
#         cut=list(
#             dynamic=list(
#                 deepSplit=2,
#                 minClusterSize =2
#             )
#         )
#     ),
#     samples.tree=NULL
# )

## ----SS_Lin-wardD2------------------------------------------------------------
# # GO terms heatmap
# Lin_clusters_wardD2<-ViSEAGO::GOterms_heatmap(
#     myGOs,
#     showIC=TRUE,
#     showGOlabels=TRUE,
#     GO.tree=list(
#         tree=list(
#             distance="Lin",
#             aggreg.method="ward.D2"
#         ),
#         cut=list(
#             dynamic=list(
#                 deepSplit=2,
#                 minClusterSize =2
#             )
#         )
#     ),
#     samples.tree=NULL
# )

## ----SS_ Rel-wardD2-----------------------------------------------------------
# # GO terms heatmap
# Rel_clusters_wardD2<-ViSEAGO::GOterms_heatmap(
#     myGOs,
#     showIC=TRUE,
#     showGOlabels=TRUE,
#     GO.tree=list(
#         tree=list(
#             distance="Rel",
#             aggreg.method="ward.D2"
#         ),
#         cut=list(
#             dynamic=list(
#                 deepSplit=2,
#                 minClusterSize =2
#             )
#         )
#     ),
#     samples.tree=NULL
# )

## ----SS_Jiang-wardD2----------------------------------------------------------
# # GO terms heatmap
# Jiang_clusters_wardD2<-ViSEAGO::GOterms_heatmap(
#     myGOs,
#     showIC=TRUE,
#     showGOlabels=TRUE,
#     GO.tree=list(
#         tree=list(
#             distance="Jiang",
#             aggreg.method="ward.D2"
#         ),
#         cut=list(
#             dynamic=list(
#                 deepSplit=2,
#                 minClusterSize =2
#             )
#         )
#     ),
#     samples.tree=NULL
# )

## ----SS_Wang-wardD2-----------------------------------------------------------
# # GO terms heatmap
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
#                 deepSplit=2,
#                 minClusterSize =2
#             )
#         )
#     ),
#     samples.tree=NULL
# )

## ----parameters_dend_correlation----------------------------------------------
# # build the list of trees
# dend<- dendextend::dendlist(
#     "Resnik"=slot(Resnik_clusters_wardD2,"dendrograms")$GO,
#     "Lin"=slot(Lin_clusters_wardD2,"dendrograms")$GO,
#     "Rel"=slot(Rel_clusters_wardD2,"dendrograms")$GO,
#     "Jiang"=slot(Jiang_clusters_wardD2,"dendrograms")$GO,
#     "Wang"=slot(Wang_clusters_wardD2,"dendrograms")$GO
# )
# 
# # build the trees matrix correlation
# dend_cor<-dendextend::cor.dendlist(dend)

## ----parameters_dend_correlation_print----------------------------------------
# # corrplot
# corrplot::corrplot(
#     dend_cor,
#     "pie",
#     "lower",
#     is.corr=FALSEALSE,
#     cl.lim=c(0,1)
# )

## ----parameters_dend_comparison,fig.cap="dendrograms comparison"--------------
# # dendrogram list
# dl<-dendextend::dendlist(
#     slot(Resnik_clusters_wardD2,"dendrograms")$GO,
#     slot(Wang_clusters_wardD2,"dendrograms")$GO
# )
# 
# # untangle the trees (efficient but very highly time consuming)
# tangle<-dendextend::untangle(
#     dl,
#     "step2side"
# )
# 
# # display the entanglement
# dendextend::entanglement(tangle) # 0.08362968
# 
# # display the tanglegram
# dendextend::tanglegram(
#     tangle,
#     margin_inner=5,
#     edge.lwd=1,
#     lwd = 1,
#     lab.cex=0.8,
#     columns_width = c(5,2,5),
#     common_subtrees_color_lines=FALSE
# )

## ----parameters_clusters_correlation------------------------------------------
# # clusters to compare
# clusters=list(
#     Resnik="Resnik_clusters_wardD2",
#     Lin="Lin_clusters_wardD2",
#     Rel="Rel_clusters_wardD2",
#     Jiang="Jiang_clusters_wardD2",
#     Wang="Wang_clusters_wardD2"
# )
# 
# # global dendrogram partition correlation
# clust_cor<-ViSEAGO::clusters_cor(
#     clusters,
#     method="adjusted.rand"
# )

## ----parameters_clusters_correlation_print------------------------------------
# # global dendrogram partition correlation
# corrplot::corrplot(
#     clust_cor,
#     "pie",
#     "lower",
#     is.corr=FALSEALSE,
#     cl.lim=c(0,1)
# )

## ----parameters_clusters_comparison,fig.height=8------------------------------
# # clusters content comparisons
# ViSEAGO::compare_clusters(clusters)

