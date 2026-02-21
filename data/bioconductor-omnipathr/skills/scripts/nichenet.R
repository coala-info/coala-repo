# Code example from 'nichenet' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------------------------------------
# library(OmnipathR)
# library(nichenetr)
# 
# nichenet_results <- nichenet_main(
#     expressed_genes_transmitter = expressed_genes_transmitter,
#     expressed_genes_receiver = expressed_genes_receiver,
#     genes_of_interest = genes_of_interest,
#     background_genes = background_genes,
#     signaling_network = list(
#         cpdb = NULL,
#         evex = list(min_confidence = 1.0)
#     ),
#     gr_network = list(only_omnipath = TRUE),
#     n_top_ligands = 20,
#     mlrmbo_optimization_param = list(ncores = 4)
# )

## ----eval=FALSE---------------------------------------------------------------------------------------------
# nichenet_model <- nichenet_main()

## ----eval=FALSE---------------------------------------------------------------------------------------------
# require(devtools)
# install_github('saeyslab/nichenetr')

## ----eval=FALSE---------------------------------------------------------------------------------------------
# library(nichenetr)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# nichenet_workarounds()

## ----eval=FALSE---------------------------------------------------------------------------------------------
# require(OmnipathR)
# nichenet_workarounds()
# nichenet_test()

## ----eval=FALSE---------------------------------------------------------------------------------------------
# networks <- nichenet_networks()

## ----eval=FALSE---------------------------------------------------------------------------------------------
# networks <- nichenet_networks(only_omnipath = TRUE)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# networks <- nichenet_networks(
#     only_omnipath = TRUE,
#     signaling_network = list(
#         omnipath = list(
#             resources = c('SIGNOR', 'PhosphoSite')
#         )
#     ),
#     lr_network = list(
#         omnipath = list(
#             transmitter_param = list(parent = c('ligand', 'secreted_enzyme')),
#             receiver_param = list(parent = c('receptor', 'transporter'))
#         )
#     ),
#     gr_network = list(
#         omnipath = list(
#             resources = 'DoRothEA',
#             dorothea_levels = 'A'
#         )
#     )
# )

## ----eval=FALSE---------------------------------------------------------------------------------------------
# signaling_network <- nichenet_signaling_network(
#     cpdb = list(
#         complex_max_size = 1,
#         min_score = .98
#     ),
#     evex = list(
#         min_confidence = 2
#     ),
#     pathwaycommons = NULL
# )

## ----eval=FALSE---------------------------------------------------------------------------------------------
# evex_signaling <- nichenet_signaling_network_evex(top_confidence = .9)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# evex <- evex_download(remove_negatives = FALSE)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# nichenet_results <- nichenet_main(
#     quality_filter_param = list(
#         min_curation_effort = 1,
#         consensus_percentile = 30
#     )
# )

## ----eval=FALSE---------------------------------------------------------------------------------------------
# nichenet_results <- nichenet_main(small = TRUE)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# expression <- nichenet_expression_data()

## ----eval=FALSE---------------------------------------------------------------------------------------------
# lr_network <- nichenet_lr_network()
# expression <- nichenet_remove_orphan_ligands(
#     expression = expression,
#     lr_network = lr_network
# )

## ----eval=FALSE---------------------------------------------------------------------------------------------
# optimization_results <- nichenet_optimization(
#     networks = networks,
#     expression = expression,
#     mlrmbo_optimization_param = list(ncores = 4)
# )

## ----eval=FALSE---------------------------------------------------------------------------------------------
# options(omnipath.nichenet_results_dir = 'my/nichenet/dir')
# nichenet_results_dir()
# # [1] "my/nichenet/dir"

## ----eval=FALSE---------------------------------------------------------------------------------------------
# nichenet_model <- nichenet_build_model(
#     optimization_results = optimization_results,
#     networks = networks,
# )

## ----eval=FALSE---------------------------------------------------------------------------------------------
# lt_matrix <- nichenet_ligand_target_matrix(
#     nichenet_model$weighted_networks,
#     networks$lr_network,
#     nichenet_model$optimized_parameters
# )

## ----eval=FALSE---------------------------------------------------------------------------------------------
# genes_of_interest <- sample(rownames(ligand_target_matrix), 50)
# background_genes <- setdiff(
#     rownames(ligand_target_matrix),
#     genes_of_interest
# )
# expressed_genes_transmitter <- union(
#     unlist(purrr::map(networks, 'from')),
#     unlist(purrr::map(networks, 'to'))
# )
# expressed_genes_receiver <- expressed_genes_transmitter
# 
# ligand_activities <- nichenet_ligand_activities(
#     ligand_target_matrix = lt_matrix,
#     lr_network = networks$lr_network,
#     expressed_genes_transmitter = expressed_genes_transmitter,
#     expressed_genes_receiver = expressed_genes_receiver,
#     genes_of_interest = genes_of_interest
# )

## ----eval=FALSE---------------------------------------------------------------------------------------------
# lt_links <- nichenet_ligand_target_links(
#     ligand_activities = ligand_activities,
#     ligand_target_matrix = lt_matrix,
#     genes_of_interest = genes_of_interest,
#     n_top_ligands = 20,
#     n_top_targets = 100
# )

## ----sessionInfo, echo=FALSE--------------------------------------------------------------------------------
sessionInfo()

