# Code example from 'DuplexDiscovereR' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c("custom.css"))

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "##",
    crop = FALSE
)

## ----install_chunk, eval=FALSE------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# 
# BiocManager::install("DuplexDiscovereR")
# 
# library(DuplexDiscovereR)
# ?DuplexDiscovereR

## ----install_chunk2, eval=FALSE-----------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# 
# library(devtools)
# devtools::install_github("Egors01/DuplexDiscovereR")

## ----dataload,echo=T,eval=T,message=FALSE-------------------------------------
library(DuplexDiscovereR)
data(RNADuplexesSampleData)

## ----dataload2----------------------------------------------------------------
system.file("extdata", "scripts", "DD_data_generation.R", package = "DuplexDiscovereR")

## ----run_workflow, echo=T,eval=T,message=FALSE--------------------------------
genome_fasta <- NULL
result <- DuplexDiscovereR::runDuplexDiscoverer(
    data = RNADuplexesRawChimSTAR,
    junctions_gr = SampleSpliceJncGR,
    anno_gr = SampleGeneAnnoGR,
    df_counts = RNADuplexesGeneCounts,
    sample_name = "example_run",
    lib_type = "SE",
    table_type = "STAR",
    fafile = genome_fasta,
)

## ----observe_results1,eval=TRUE-----------------------------------------------
result

## ----observe_results2,eval=TRUE-----------------------------------------------
gi_clusters <- dd_get_duplex_groups(result)
head(gi_clusters, 2)

## ----observe_results3,eval=TRUE-----------------------------------------------
gi_reads <- dd_get_chimeric_reads(result)
head(gi_reads, 2)

## ----observe_results4a,eval=TRUE----------------------------------------------
df_reads <- dd_get_reads_classes(result)
print(dim(df_reads))
print(dim(RNADuplexesRawChimSTAR))

## ----observe_results4b,eval=TRUE----------------------------------------------
table(df_reads$read_type)

## ----observe_results5,eval=TRUE-----------------------------------------------
table(gi_reads$junction_type)

## ----write_table, eval=TRUE---------------------------------------------------
clusters_dt <- makeDfFromGi(gi_clusters)
write.table(clusters_dt, file = tempfile(pattern = "dgs_out", fileext = ".tab"))

## ----write_sam, eval=TRUE, message = FALSE------------------------------------
writeGiToSAMfile(gi_clusters, file_out = tempfile(pattern = "dgs_out", fileext = ".sam"), genome = "hg38")

## ----vis_1, eval=TRUE,message=FALSE-------------------------------------------
library(Gviz)
# define plotting region
plotrange <- GRanges(
    seqnames = "chr22",
    ranges = IRanges(
        start = c(37877619),
        end = c(37878053)
    ),
    strand = "+"
)
# make genes track
anno_track <- Gviz::GeneRegionTrack(SampleGeneAnnoGR,
    name = "chr22 Genes",
    range = plotrange
)
# construct DuplexTrack
duplex_track <- DuplexTrack(
    gi = gi_clusters,
    gr_region = plotrange,
    labels.fontsize = 12,
    arcConstrain = 4,
    annotation.column1 = "gene_name.A",
    annotation.column2 = "gene_name.B"
)
plotTracks(list(anno_track, duplex_track),
    sizes = c(1, 3),
    from = start(plotrange) - 100,
    to = end(plotrange) + 100
)

## ----comp1, eval=TRUE---------------------------------------------------------
clust_reads <- gi_reads
clust_reads <- clust_reads[!is.na(clust_reads$dg_id)]

# Create separate pseudo-sample objects for each group
set.seed(123)
group_indices <- sample(rep(1:3, length.out = length(clust_reads)))

group1 <- clust_reads[group_indices == 1]
group2 <- clust_reads[group_indices == 2]
group3 <- clust_reads[group_indices == 3]

## ----comp2, eval=TRUE---------------------------------------------------------
group1 <- collapse_duplex_groups(group1)
group2 <- collapse_duplex_groups(group2)
group3 <- collapse_duplex_groups(group3)

## ----comp3, eval=TRUE, message=FALSE------------------------------------------
a <- list("sample1" = group1, "sample2" = group2, "sample3" = group3)
res_comp <- compareMultipleInteractions(a)
names(res_comp)

## ----comp4, eval=TRUE---------------------------------------------------------
# first, check if UpSetR is installed
if (!requireNamespace("UpSetR", quietly = TRUE)) {
    stop("Install 'UpSetR' to use this function.")
}
library(UpSetR)
upset(res_comp$dt_upset, text.scale = 1.5)

## ----preproc ex1, message=FALSE-----------------------------------------------
data("RNADuplexesSampleData")

new_star <- runDuplexDiscoPreproc(
    data = RNADuplexesRawChimSTAR,
    table_type = "STAR",
    library_type = "SE",
)

## ----preproc ex2, message=FALSE-----------------------------------------------
new_bedpe <- runDuplexDiscoPreproc(
    data = RNADuplexesRawBed,
    table_type = "bedpe",
    library_type = "SE", return_gi = TRUE
)

## ----preproc ex3, message=FALSE-----------------------------------------------
# keep only readname in metadata
mcols(RNADuplexSampleGI) <- mcols(RNADuplexSampleGI)["readname"]
new_gi <- runDuplexDiscoPreproc(data = RNADuplexSampleGI, return_gi = TRUE)
head(new_gi, 1)

## ----ex_classif1--------------------------------------------------------------
gi <- getChimericJunctionTypes(new_gi)
gi <- getSpliceJunctionChimeras(gi, sj_gr = SampleSpliceJncGR)

## ----ex_classif2--------------------------------------------------------------
table(gi$junction_type)

## ----ex_cassif3---------------------------------------------------------------
table(gi$splicejnc)

## -----------------------------------------------------------------------------
keep <- which((gi$junction_type == "2arm") & (gi$splicejnc == 0))
gi <- gi[keep]

## ----clust1, message=FALSE----------------------------------------------------
gi <- clusterDuplexGroups(gi)

## ----ex_clust2----------------------------------------------------------------
table(is.na(gi$dg_id))

## ----ex_clist3----------------------------------------------------------------
gi_dgs <- collapse_duplex_groups(gi)
head(gi_dgs, 1)
# number of DGs
length(gi_dgs)

## ----dupl1--------------------------------------------------------------------
res_collapse <- collapseIdenticalReads(gi)
# returns new object
gi_unique <- res_collapse$gi_collapsed

## ----dupl2--------------------------------------------------------------------
head(res_collapse$stats_df, 1)

## ----dupl3, message=FALSE-----------------------------------------------------
# cluster  gi_unqiue
gi_unique_dg <- collapse_duplex_groups(clusterDuplexGroups(gi_unique))
# check if the get the same amount of reads as in basic clustering
sum(gi_unique_dg$n_reads) == sum(gi_dgs$n_reads)

## ----cl1----------------------------------------------------------------------
graph_df <- computeGISelfOverlaps(gi_unique)
head(graph_df)

## ----cl2a---------------------------------------------------------------------
graph_df <- graph_df[graph_df$ratio.A > 0.5 & graph_df$ratio.B > 0.5, ]

## ----cl2b---------------------------------------------------------------------
rescale_vec <- function(x) {
    return((x - min(x)) / (max(x) - min(x)))
}

graph_df$weight_new <- graph_df$ratio.A + graph_df$ratio.B
graph_df$weight_new <- rescale_vec(graph_df$weight_new)
head(graph_df, 2)

## ----cl3, message=FALSE-------------------------------------------------------
gi_clust_adj <- clusterDuplexGroups(gi_unique, graphdf = graph_df, weight_column = "weight_new")
gi_clust_adj_dgs <- collapse_duplex_groups(gi_clust_adj)

## ----cl4----------------------------------------------------------------------
length(gi_clust_adj)

## ----session-info,cache = F,echo=T,message=T,warning=FALSE--------------------
sessionInfo()

