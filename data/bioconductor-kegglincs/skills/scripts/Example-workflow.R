# Code example from 'Example-workflow' vignette. See references/ for full tutorial.

## ----render_overview_png,eval=TRUE,echo=FALSE,out.width=800-------------------
knitr::include_graphics("image_files/KEGGlincs_overview.jpeg")

## ----initialize, message = FALSE, warning=FALSE-------------------------------
library(KEGGlincs)

## ----get_KGML, collapse=TRUE--------------------------------------------------
FoxO_KGML <- get_KGML("hsa04068")

#Information from KGML can be accessed using the following syntax:
slot(FoxO_KGML, "pathwayInfo")

## ----access_KGML, collapse=TRUE-----------------------------------------------
#Get address for pathway with active links:
slot(slot(FoxO_KGML, "pathwayInfo"), "image")

## ----get_png, eval = FALSE----------------------------------------------------
# #Download a static pathway image (png file) to working directory:
# image_link <- slot(slot(FoxO_KGML, "pathwayInfo"), "image")
# download.file(image_link, basename(image_link), mode = "wb")

## ----render_png,eval=TRUE,echo=FALSE,out.width=800----------------------------
knitr::include_graphics("image_files/hsa04068.png")

## ----speed_up_for_ex, echo=FALSE----------------------------------------------
FoxO_KEGG_mappings <- expand_KEGG_mappings(FoxO_KGML, convert_KEGG_IDs = FALSE)

## ----expand_mapping_for_show, eval=FALSE--------------------------------------
# FoxO_KEGG_mappings <- expand_KEGG_mappings(FoxO_KGML)

## ----expand_edges-------------------------------------------------------------
FoxO_edges <- expand_KEGG_edges(FoxO_KGML, FoxO_KEGG_mappings)

## ----compare_lengths, collapse=TRUE-------------------------------------------
length(graph::nodes(FoxO_KGML)) # 'Un-expanded' nodes
nrow(FoxO_KEGG_mappings)        # 'Expanded' nodes

length(graph::edges(FoxO_KGML)) # 'Un-expanded' edges
nrow(FoxO_edges)                # 'Expanded' edges

## ----mapping_info, collapse=TRUE----------------------------------------------
#Modify existing data sets; specify as nodes and edges
FoxO_node_mapping_info <- node_mapping_info(FoxO_KEGG_mappings)
FoxO_edge_mapping_info <- edge_mapping_info(FoxO_edges)

#Create an igraph object
GO <- get_graph_object(FoxO_node_mapping_info, FoxO_edge_mapping_info)
class(GO)

## ----cyto_vis, collapse=TRUE, eval=FALSE--------------------------------------
# cyto_vis(GO, "FoxO Pathway with Expanded Edges[no data added]")

## ----render_graph,eval=TRUE,echo=FALSE,out.width=800--------------------------
knitr::include_graphics("image_files/foxo_ID_conversion.jpeg")

## ----eval = FALSE-------------------------------------------------------------
# KEGG_lincs("hsa04068")

## ----eval = FALSE-------------------------------------------------------------
# FoxO_edges <- KEGG_lincs("hsa04068")

## ----eval = FALSE, echo = TRUE------------------------------------------------
# KEGG_lincs("hsa04068", convert_KEGG_IDs = FALSE)

## ----render_graph_fast,eval=TRUE,echo=FALSE,out.width=800---------------------
knitr::include_graphics("image_files/foxo_no_IDconversion.jpeg")

## ----show_KO_data, eval=TRUE,echo=FALSE,out.width=800-------------------------
knitr::include_graphics("image_files/random_KO_info.jpeg")

## ----default_p53, eval = FALSE, echo = TRUE-----------------------------------
# KEGG_lincs("hsa04115")

## ----show_p53_default, eval=TRUE,echo=FALSE,out.width=800---------------------
knitr::include_graphics("image_files/p53_default.jpeg")

## ----begin_workflow1----------------------------------------------------------
p53_KGML <- get_KGML("hsa04115")
p53_KEGG_mappings <- expand_KEGG_mappings(p53_KGML)
p53_edges <- expand_KEGG_edges(p53_KGML, p53_KEGG_mappings)

## ----show_pathway_genes, eval=FALSE-------------------------------------------
# path_genes_by_cell_type(p53_KEGG_mappings)

## ----render_barplot, eval=TRUE,echo=FALSE,out.width=500-----------------------
knitr::include_graphics("image_files/p53_coverage_graph.png")

## ----show_summary_for_ex, eval = FALSE----------------------------------------
# p53_L1000_summary <- path_genes_by_cell_type(p53_KEGG_mappings, get_KOs = TRUE)

## ----avoid_poor_map_render, echo=FALSE----------------------------------------
p53_L1000_summary <- path_genes_by_cell_type(p53_KEGG_mappings, get_KOs = TRUE,
                                                generate_plot = FALSE)

knitr::kable(tail(p53_L1000_summary))

## ----overlap_info, eval=TRUE, collapse=TRUE-----------------------------------
p53_PC3_data <- overlap_info(p53_KGML, p53_KEGG_mappings, "PC3")

p53_HA1E_data <- overlap_info(p53_KGML, p53_KEGG_mappings, "HA1E")

## ----show_overlap_data, echo = FALSE------------------------------------------
knitr::kable(head(p53_PC3_data[1:6]))

## ----overlap_info_plus_genes, eval=TRUE, collapse=TRUE------------------------
p53_PC3_data_with_gene_lists <- overlap_info(p53_KGML, p53_KEGG_mappings, 
                                            "PC3", keep_counts_only = FALSE)

## ----show_overlap_data_plus_genes_PC3, echo = FALSE---------------------------
knitr::kable(head(p53_PC3_data_with_gene_lists[c(1:2, 7:10)]))

## ----add_edges----------------------------------------------------------------
p53_PC3_edges <- add_edge_data(p53_edges, p53_KEGG_mappings,
                                    p53_PC3_data, only_mapped = TRUE,
                                    data_column_no = c(3,10,12))

p53_HA1E_edges <- add_edge_data(p53_edges, p53_KEGG_mappings,
                                p53_HA1E_data, only_mapped = TRUE,
                                data_column_no =  c(3,10,12))

## ----get_mapping_info, eval = FALSE-------------------------------------------
# p53_node_map <- node_mapping_info(p53_KEGG_mappings)
# 
# p53_edge_map_PC3 <- edge_mapping_info(p53_PC3_edges, data_added = TRUE,
#                                         significance_markup = TRUE)
# p53_edge_map_HA1E <- edge_mapping_info(p53_HA1E_edges, data_added = TRUE,
#                                         significance_markup = TRUE)
# 
# 
# PC3_GO <- get_graph_object(p53_node_map, p53_edge_map_PC3)
# HA1E_GO <- get_graph_object(p53_node_map, p53_edge_map_HA1E)
# 
# cyto_vis(PC3_GO, "Pathway = p53, Cell line = PC3")
# #Option: Save PC3 as .cys file and start a fresh session in Cytoscape
# cyto_vis(HA1E_GO, "Pathway = p53, Cell line = HA1E")

## ----render_graphs,eval=TRUE,echo=FALSE,out.width=800-------------------------
knitr::include_graphics("image_files/p53_PC3_vignette.jpeg")
knitr::include_graphics("image_files/p53_HA1E_vignette.jpeg")

## ----auto_map, eval = FALSE---------------------------------------------------
# KEGG_lincs("hsa04115", "PC3", refine_by_cell_line = FALSE)
# KEGG_lincs("hsa04115", "HA1E", refine_by_cell_line = FALSE)

## ----render_graphs_kegglincs,eval=TRUE,echo=FALSE,out.width=800---------------
knitr::include_graphics("image_files/p53_PC3.jpeg")
knitr::include_graphics("image_files/p53_HA1E.jpeg")

