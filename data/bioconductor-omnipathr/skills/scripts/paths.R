# Code example from 'paths' vignette. See references/ for full tutorial.

## ----tfcensus-op--------------------------------------------------------------------------------------------
library(OmnipathR)
library(magrittr)
library(dplyr)

tfcensus <-
    annotations(
        resources = 'TFcensus',
        entity_types = 'protein'
    ) %>%
    pull(genesymbol) %>%
    unique

## ----tfcensus-direct----------------------------------------------------------------------------------------
library(purrr)

tfcensus_direct <-
    tfcensus_download() %>%
    pull(`HGNC symbol`) %>%
    discard(is.na) %>%
    unique

## ----tfs-from-network---------------------------------------------------------------------------------------
tfs_from_network <-
    transcriptional(
        # confidence levels;
        # we use only the 3 levels with highest confidence
        dorothea_levels = c('A', 'B', 'C'),
        entity_types = 'protein'
    ) %>%
    pull(source_genesymbol) %>%
    unique

## ----tf-list------------------------------------------------------------------------------------------------
tfs <- union(tfcensus, tfs_from_network)

## ----localizations------------------------------------------------------------------------------------------
localizations <-
    annotations(
        resources = c(
            'Ramilowski_location',
            'UniProt_location',
            'HPA_subcellular'
        ),
        entity_types = 'protein',
        wide = TRUE
    )

## ----loc-coverage-------------------------------------------------------------------------------------------
localizations %>%
map(function(x){x %>% pull(genesymbol) %>% n_distinct})

## ----ligrec-------------------------------------------------------------------------------------------------
ligands <-
    OmnipathR::intercell(
        parent = 'ligand',
        topology = 'sec',
        consensus_percentile = 50,
        loc_consensus_percentile = 30,
        entity_types = 'protein'
    ) %>%
    pull(genesymbol) %>%
    unique %T>%
    length

receptors <-
    OmnipathR::intercell(
        parent = 'receptor',
        topology = 'pmtm',
        consensus_percentile = 50,
        loc_consensus_percentile = 30,
        entity_types = 'protein'
    ) %>%
    pull(genesymbol) %>%
    unique %T>%
    length

transmitters <-
    OmnipathR::intercell(
        causality = 'trans',
        topology = 'sec',
        consensus_percentile = 50,
        loc_consensus_percentile = 30,
        entity_types = 'protein'
    ) %>%
    pull(genesymbol) %>%
    unique %T>%
    length

receivers <-
    OmnipathR::intercell(
        causality = 'rec',
        topology = 'pmtm',
        consensus_percentile = 50,
        loc_consensus_percentile = 30,
        entity_types = 'protein'
    ) %>%
    pull(genesymbol) %>%
    unique %T>%
    length

## ----ppi----------------------------------------------------------------------------------------------------
ppi <-
    omnipath(
        datasets = 'omnipath',
        entity_types = 'protein'
    )

## ----signalink----------------------------------------------------------------------------------------------
signalink_pathways <-
    annotations(
        resources = 'SignaLink_pathway',
        entity_types = 'protein',
        wide = TRUE
    )

signalink_functions <-
    annotations(
        resources = 'SignaLink_function',
        entity_types = 'protein',
        wide = TRUE
    )

## ----lig-of-interest----------------------------------------------------------------------------------------
ligands_of_interest <-
    intersect(
        signalink_pathways %>%
            filter(pathway == 'TGF') %>%
            pull(genesymbol),
        signalink_functions %>%
            filter(`function` == 'Ligand') %>%
            pull(genesymbol)
    ) %T>%
    length

## ----ppi-graph----------------------------------------------------------------------------------------------
ppi_graph <-
    ppi %>%
    interaction_graph

## ----in-network---------------------------------------------------------------------------------------------
library(igraph)

ligands_of_interest__in_network <-
    ligands_of_interest %>%
    keep(. %in% V(ppi_graph)$name)

tfs__in_network <-
    tfs %>%
    keep(. %in% V(ppi_graph)$name)

## ----find-paths, eval = FALSE-------------------------------------------------------------------------------
# paths <-
#     ppi_graph %>%
#     find_all_paths(
#         start = ligands_of_interest__in_network,
#         end = tfs__in_network,
#         maxlen = 3,
#         attr = 'name'
#     )

## ----filter-paths, eval = FALSE-----------------------------------------------------------------------------
# # only selecting Cytoplasm, of course we could
# # consider other intracellular compartments
# in_cytoplasm <-
#     localizations$UniProt_location %>%
#     filter(location == 'Cytoplasm') %>%
#     pull(genesymbol) %>%
#     unique
# 
# in_nucleus <-
#     localizations$UniProt_location %>%
#     filter(location %in% c('Nucleus', 'Nucleolus')) %>%
#     pull(genesymbol) %>%
#     unique
# 
# paths_selected <-
#     paths %>%
#     # removing single node paths
#     discard(
#         function(p){
#             length(p) == 1
#         }
#     ) %>%
#     # receptors are plasma membrane transmembrane
#     # according to our query to OmniPath
#     keep(
#         function(p){
#             p[2] %in% receptors
#         }
#     ) %>%
#     # making sure all further mediators are
#     # in the cytoplasm
#     keep(
#         function(p){
#             all(p %>% tail(-2) %>% is_in(in_cytoplasm))
#         }
#     ) %>%
#     # the last nodes are all TFs, implying that they are in the nucleus
#     # but we can optionally filter foall(p %>% tail(-2)r this too:
#     keep(
#         function(p){
#             last(p) %in% in_nucleus
#         }
#     ) %>%
#     # finally, we can remove paths which contain TFs also as intermediate
#     # nodes as these are redundant
#     discard(
#         function(p){
#             !any(p %>% head(-1) %>% is_in(tfs))
#         }
#     )

## ----path-stats, eval = FALSE-------------------------------------------------------------------------------
# paths_selected %>% length
# 
# paths_selected %>% map_int(length) %>% table

## ----intercell-network--------------------------------------------------------------------------------------
ligand_receptor <-
    intercell_network(
        ligand_receptor = TRUE,
        high_confidence = TRUE,
        entity_types = 'protein'
    ) %>%
    simplify_intercell_network

## ----tf-target-network--------------------------------------------------------------------------------------
tf_target <-
    transcriptional(
        # confidence levels;
        # we use only the 2 levels with highest confidence
        dorothea_levels = c('A', 'B'),
        # I added this only to have less interactions so the
        # examples here run faster; feel free to remove it,
        # then you will have more gene regulatory interactions
        # from a variety of databases
        datasets = 'tf_target',
        entity_types = 'protein',
        # A workaround to mitigate a temporary issue (05/01/2022)
        resources = c('ORegAnno', 'PAZAR')
    )

## ----ppi-2, eval = FALSE------------------------------------------------------------------------------------
# ppi <-
#     omnipath(
#         datasets = 'omnipath',
#         entity_types = 'protein'
#     )

## ----annotate-networks--------------------------------------------------------------------------------------
ppi %<>%
    annotated_network('UniProt_location') %>%
    annotated_network('kinase.com') %>%
    # these columns define a unique interaction; 5 of them would be enough
    # for only the grouping, we include the rest only to keep them after
    # the summarize statement
    group_by(
        source,
        target,
        source_genesymbol,
        target_genesymbol,
        is_directed,
        is_stimulation,
        is_inhibition,
        sources,
        references,
        curation_effort,
        n_references,
        n_resources
    ) %>%
    summarize(
        location_source = list(unique(location_source)),
        location_target = list(unique(location_target)),
        family_source = list(unique(family_source)),
        family_target = list(unique(family_target)),
        subfamily_source = list(unique(subfamily_source)),
        subfamily_target = list(unique(subfamily_target))
    ) %>%
    ungroup

tf_target %<>%
    annotated_network('UniProt_location') %>%
    annotated_network('kinase.com') %>%
    group_by(
        source,
        target,
        source_genesymbol,
        target_genesymbol,
        is_directed,
        is_stimulation,
        is_inhibition,
        sources,
        references,
        curation_effort,
        # Workaround to mitigate a temporary issue with
        # DoRothEA data in OmniPath (05/01/2022)
        # dorothea_level,
        n_references,
        n_resources
    ) %>%
    summarize(
        location_source = list(unique(location_source)),
        location_target = list(unique(location_target)),
        family_source = list(unique(family_source)),
        family_target = list(unique(family_target)),
        subfamily_source = list(unique(subfamily_source)),
        subfamily_target = list(unique(subfamily_target))
    ) %>%
    ungroup

## ----tfs-2--------------------------------------------------------------------------------------------------
tfs <-
    tf_target %>%
    pull(source_genesymbol) %>%
    unique

## ----grow-paths-function------------------------------------------------------------------------------------
library(rlang)
library(tidyselect)

grow_paths <- function(paths, step, interactions, endpoints = NULL){

    right_target_col <- sprintf(
        'target_genesymbol_step%i',
        step
    )

    paths$growing %<>% one_step(step, interactions)

    # finished paths with their last node being an endpoint:
    paths[[sprintf('step%i', step)]] <-
        paths$growing %>%
        {`if`(
            is.null(endpoints),
            .,
            filter(., !!sym(right_target_col) %in% endpoints)
        )}

    # paths to be further extended:
    paths$growing %<>%
        {`if`(
            is.null(endpoints),
            NULL,
            filter(., !(!!sym(right_target_col) %in% endpoints))
        )}

    invisible(paths)

}


one_step <- function(paths, step, interactions){

    left_col <- sprintf('target_genesymbol_step%i', step - 1)
    right_col <- sprintf('source_genesymbol_step%i', step)
    by <- setNames(right_col, left_col)

    paths %>%
    # making sure even at the first step we have the suffix `_step1`
    {`if`(
        'target_genesymbol' %in% colnames(.),
        rename_with(
            .,
            function(x){sprintf('%s_step%i', x, step)}
        ),
        .
    )} %>%
    {`if`(
        step == 0,
        .,
        inner_join(
            .,
            # adding suffix for the next step
            interactions %>%
            rename_with(function(x){sprintf('%s_step%i', x, step)}),
            by = by
        )
    )} %>%
    # removing loops
    filter(
        select(., contains('_genesymbol')) %>%
        pmap_lgl(function(...){!any(duplicated(c(...)))})
    )

}

## ----build-paths, eval=FALSE--------------------------------------------------------------------------------
# library(stringr)
# 
# steps <- 2 # to avoid OOM
# 
# paths <-
#     seq(0, steps) %>%
#     head(-1) %>%
#     reduce(
#         grow_paths,
#         interactions = ppi,
#         endpoints = tfs,
#         .init = list(
#             growing = ligand_receptor
#         )
#     ) %>%
#     within(rm(growing)) %>%
#     map2(
#         names(.) %>% str_extract('\\d+$') %>% as.integer %>% add(1),
#         one_step,
#         interactions = tf_target
#     )

## ----packages, eval = FALSE---------------------------------------------------------------------------------
# library(OmnipathR)
# library(magrittr)
# library(dplyr)
# library(purrr)
# library(igraph)
# library(rlang)
# library(tidyselect)
# library(stringr)
# library(rmarkdown)

## ----install, eval = FALSE----------------------------------------------------------------------------------
# missing_packages <-
#     setdiff(
#         c(
#             'magrittr',
#             'dplyr',
#             'purrr',
#             'igraph',
#             'rlang',
#             'tidyselect',
#             'stringr',
#             'rmarkdown',
#             'devtools'
#         ),
#         installed.packages()
#     )
# 
# if(length(missing_packages)){
#     install.packages(missing_packages)
# }
# 
# if(!'OmnipathR' %in% installed.packages()){
#     library(devtools)
#     devtools::install_github('saezlab/OmnipathR')
# }

## ----render, eval = FALSE-----------------------------------------------------------------------------------
# library(rmarkdown)
# render('paths.Rmd', output_format = 'html_document')

## ----session------------------------------------------------------------------------------------------------
sessionInfo()

