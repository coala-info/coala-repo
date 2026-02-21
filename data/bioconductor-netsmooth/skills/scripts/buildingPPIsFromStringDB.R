# Code example from 'buildingPPIsFromStringDB' vignette. See references/ for full tutorial.

## ----echo=TRUE,eval=FALSE-----------------------------------------------------
# require(STRINGdb)
# require(igraph)
# require(biomaRt)
# 
# # 1. getSTRINGdb for human
# string_db <- STRINGdb$new(species=9606)
# human_graph <- string_db$get_graph()
# 
# # 2. get edges with high confidence score
# edge.scores <- E(human_graph)$combined_score
# ninetyth.percentile <- quantile(edge.scores, 0.9)
# thresh <- data.frame(name='90th percentile',
#                      val=ninetyth.percentile)
# human_graph <- subgraph.edges(human_graph,
#                               E(human_graph)[combined_score > ninetyth.percentile])
# 
# # 3. create adjacency matrix
# adj_matrix <- as_adjacency_matrix(human_graph)
# 
# 
# # 4. map gene ids to protein ids
# 
# ### get gene/protein ids via Biomart
# mart=useMart(host = 'grch37.ensembl.org',
#              biomart='ENSEMBL_MART_ENSEMBL',
#              dataset='hsapiens_gene_ensembl')
# 
# ### extract protein ids from the human network
# protein_ids <- sapply(strsplit(rownames(adj_matrix), '\\.'),
#                       function(x) x[2])
# 
# ### get protein to gene id mappings
# mart_results <- getBM(attributes = c("ensembl_gene_id",
#                                      "ensembl_peptide_id"),
#                       filters = "ensembl_peptide_id", values = protein_ids,
#                       mart = mart)
# 
# ### replace protein ids with gene ids
# ix <- match(protein_ids, mart_results$ensembl_peptide_id)
# ix <- ix[!is.na(ix)]
# 
# newnames <- protein_ids
# newnames[match(mart_results[ix,'ensembl_peptide_id'], newnames)] <-
#     mart_results[ix, 'ensembl_gene_id']
# rownames(adj_matrix) <- newnames
# colnames(adj_matrix) <- newnames
# 
# ppi <- adj_matrix[!duplicated(newnames), !duplicated(newnames)]
# nullrows <- Matrix::rowSums(ppi)==0
# ppi <- ppi[!nullrows,!nullrows] ## ppi is the network with gene ids

## -----------------------------------------------------------------------------
sessionInfo()

