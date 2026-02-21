# Code example from 'bioc_workshop' vignette. See references/ for full tutorial.

## ----set-options, echo=FALSE, cache=FALSE-------------------------------------------------------------------
options(width = 110)

## ----installation, eval=FALSE-------------------------------------------------------------------------------
# library(devtools)
# install_github('saezlab/OmnipathR')

## ----library------------------------------------------------------------------------------------------------
library(OmnipathR)

## ----network------------------------------------------------------------------------------------------------
gri <- transcriptional()
gri

## ----network-igraph-----------------------------------------------------------------------------------------
gr_graph <- interaction_graph(gri)
gr_graph

## ----paths--------------------------------------------------------------------------------------------------
paths <- find_all_paths(
    graph = gr_graph,
    start = c('EGFR', 'STAT3'),
    end = c('AKT1', 'ULK1'),
    attr = 'name'
)

## ----enzsub-------------------------------------------------------------------------------------------------
enz_sub <- enzyme_substrate()
enz_sub

## ----enzsub-igraph------------------------------------------------------------------------------------------
es_graph <- enzsub_graph(enz_sub)
es_graph

## ----enzsub-signs-------------------------------------------------------------------------------------------
es_signed <- signed_ptms(enz_sub)

## ----complexes----------------------------------------------------------------------------------------------
cplx <- complexes()
cplx

## ----uniprot-loc--------------------------------------------------------------------------------------------
uniprot_loc <- annotations(
    resources = 'UniProt_location',
    wide = TRUE
)
uniprot_loc

## ----uniprot-loc-1------------------------------------------------------------------------------------------
uniprot_loc <- annotations(
    resources = 'Uniprot_location',
    wide = TRUE
)

## ----uniprot-loc-2, error = TRUE----------------------------------------------------------------------------
try({
uniprot_loc <- annotations(
    resuorces = 'UniProt_location',
    wide = TRUE
)
})

## ----uniprot-loc-3------------------------------------------------------------------------------------------
uniprot_loc <- annotations(
    resource = 'UniProt_location',
    wide = TRUE
)

## ----hpa-tissue---------------------------------------------------------------------------------------------
hpa_tissue <- annotations(
    resources = 'HPA_tissue',
    wide = TRUE,
    # Limiting to a handful of proteins for a faster vignette build:
    proteins = c('DLL1', 'MEIS2', 'PHOX2A', 'BACH1', 'KLF11', 'FOXO3', 'MEFV')
)
hpa_tissue

## ----slk-pathway--------------------------------------------------------------------------------------------
slk_pathw <- annotations(
    resources = 'SignaLink_pathway',
    wide = TRUE
)
slk_pathw

## ----annotate-network---------------------------------------------------------------------------------------
network <- omnipath()

network_slk_pw <- annotated_network(network, 'SignaLink_pathway')
network_slk_pw

## ----intercell----------------------------------------------------------------------------------------------
ic <- intercell()
ic

## ----intercell-network--------------------------------------------------------------------------------------
icn <- intercell_network(high_confidence = TRUE)
icn

## ----intercell-filter---------------------------------------------------------------------------------------
icn <- intercell_network()
icn_hc <- filter_intercell_network(
    icn,
    ligand_receptor = TRUE,
    consensus_percentile = 30,
    loc_consensus_percentile = 50,
    simplify = TRUE
)

## ----annot-res----------------------------------------------------------------------------------------------
annotation_resources()

## ----intercell-cat------------------------------------------------------------------------------------------
intercell_generic_categories()
# intercell_categories() # this would show also the specific categories

## ----id-translate-vector------------------------------------------------------------------------------------
d <- data.frame(uniprot_id = c('P00533', 'Q9ULV1', 'P43897', 'Q9Y2P5'))
d <- translate_ids(
    d,
    uniprot_id = uniprot, # the source ID type and column name
    genesymbol # the target ID type using OmniPath's notation
)
d

## ----id-translate-df, eval = FALSE--------------------------------------------------------------------------
# network <- omnipath()
# network <- translate_ids(
#     network,
#     source = uniprot_id,
#     source_entrez = entrez
# )
# network <- translate_ids(
#     network,
#     target = uniprot_id,
#     target_entrez = entrez
# )

## ----go-----------------------------------------------------------------------------------------------------
go <- go_ontology_download()
go$rel_tbl_c2p

## ----go-graph-----------------------------------------------------------------------------------------------
go_graph <- relations_table_to_graph(go$rel_tbl_c2p)
go_graph

## ----go-name------------------------------------------------------------------------------------------------
ontology_ensure_name('GO:0000022')

## ----cache--------------------------------------------------------------------------------------------------
omnipath_cache_search('dorothea')

## ----license, eval = FALSE----------------------------------------------------------------------------------
# options(omnipath.license = 'commercial')

## ----sessionInfo, echo=FALSE--------------------------------------------------------------------------------
sessionInfo()

