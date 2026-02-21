# Code example from 'nnSVG' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("nnSVG")

## ----message=FALSE------------------------------------------------------------
library(SpatialExperiment)
library(STexampleData)
library(scran)
library(nnSVG)
library(ggplot2)

## -----------------------------------------------------------------------------
# load example dataset from STexampleData package
# see '?Visium_humanDLPFC' for more details
spe <- Visium_humanDLPFC()

dim(spe)

## -----------------------------------------------------------------------------
# preprocessing steps

# keep only spots over tissue
spe <- spe[, colData(spe)$in_tissue == 1]
dim(spe)

# skip spot-level quality control, since this has been performed previously 
# on this dataset

# filter low-expressed and mitochondrial genes
# using default filtering parameters
spe <- filter_genes(spe)

# calculate logcounts (log-transformed normalized counts) using scran package
# using library size factors
spe <- computeLibraryFactors(spe)
spe <- logNormCounts(spe)

assayNames(spe)

## -----------------------------------------------------------------------------
# select small set of random genes and several known SVGs for 
# faster runtime in this example
set.seed(123)
ix_random <- sample(seq_len(nrow(spe)), 10)

known_genes <- c("MOBP", "PCP4", "SNAP25", "HBB", "IGKC", "NPY")
ix_known <- which(rowData(spe)$gene_name %in% known_genes)

ix <- c(ix_known, ix_random)

spe <- spe[ix, ]
dim(spe)

## -----------------------------------------------------------------------------
# run nnSVG

# set seed for reproducibility
set.seed(123)
# using a single thread in this example
spe <- nnSVG(spe)

# show results
rowData(spe)

## -----------------------------------------------------------------------------
# number of significant SVGs
table(rowData(spe)$padj <= 0.05)

## -----------------------------------------------------------------------------
# show results for top n SVGs
rowData(spe)[order(rowData(spe)$rank)[1:10], ]

## ----fig.small=TRUE-----------------------------------------------------------
# plot spatial expression of top-ranked SVG
ix <- which(rowData(spe)$rank == 1)
ix_name <- rowData(spe)$gene_name[ix]
ix_name

df <- as.data.frame(
  cbind(spatialCoords(spe), 
        expr = counts(spe)[ix, ]))

ggplot(df, aes(x = pxl_col_in_fullres, y = pxl_row_in_fullres, color = expr)) + 
  geom_point(size = 0.8) + 
  coord_fixed() + 
  scale_y_reverse() + 
  scale_color_gradient(low = "gray90", high = "blue", 
                       trans = "sqrt", breaks = range(df$expr), 
                       name = "counts") + 
  ggtitle(ix_name) + 
  theme_bw() + 
  theme(plot.title = element_text(face = "italic"), 
        panel.grid = element_blank(), 
        axis.title = element_blank(), 
        axis.text = element_blank(), 
        axis.ticks = element_blank())

## ----message=FALSE------------------------------------------------------------
library(SpatialExperiment)
library(STexampleData)
library(scran)
library(nnSVG)
library(ggplot2)

## -----------------------------------------------------------------------------
# load example dataset from STexampleData package
# see '?SlideSeqV2_mouseHPC' for more details
spe <- SlideSeqV2_mouseHPC()

dim(spe)

## -----------------------------------------------------------------------------
# preprocessing steps

# remove spots with NA cell type labels
spe <- spe[, !is.na(colData(spe)$celltype)]
dim(spe)

# check cell type labels
table(colData(spe)$celltype)

# filter low-expressed and mitochondrial genes
# using adjusted filtering parameters for this platform
spe <- filter_genes(
  spe, 
  filter_genes_ncounts = 1, 
  filter_genes_pcspots = 1, 
  filter_mito = TRUE
)

dim(spe)

# calculate log-transformed normalized counts using scran package
# using library size normalization
spe <- computeLibraryFactors(spe)
spe <- logNormCounts(spe)

assayNames(spe)

## -----------------------------------------------------------------------------
# select small set of random genes and several known SVGs for 
# faster runtime in this example
set.seed(123)
ix_random <- sample(seq_len(nrow(spe)), 10)

known_genes <- c("Cpne9", "Rgs14")
ix_known <- which(rowData(spe)$gene_name %in% known_genes)

ix <- c(ix_known, ix_random)

spe <- spe[ix, ]
dim(spe)

## -----------------------------------------------------------------------------
# run nnSVG with covariates

# create model matrix for cell type labels
X <- model.matrix(~ colData(spe)$celltype)
dim(X)
stopifnot(nrow(X) == ncol(spe))

# set seed for reproducibility
set.seed(123)
# using a single thread in this example
spe <- nnSVG(spe, X = X)

# show results
rowData(spe)

## -----------------------------------------------------------------------------
# create model matrix after dropping empty factor levels
X <- model.matrix(~ droplevels(as.factor(colData(spe)$celltype)))

## -----------------------------------------------------------------------------
# number of significant SVGs
table(rowData(spe)$padj <= 0.05)

## -----------------------------------------------------------------------------
# show results for top n SVGs
rowData(spe)[order(rowData(spe)$rank)[1:10], ]

## ----fig.small=TRUE-----------------------------------------------------------
# plot spatial expression of top-ranked SVG
ix <- which(rowData(spe)$rank == 1)
ix_name <- rowData(spe)$gene_name[ix]
ix_name

df <- as.data.frame(
  cbind(spatialCoords(spe), 
        expr = counts(spe)[ix, ]))

ggplot(df, aes(x = xcoord, y = ycoord, color = expr)) + 
  geom_point(size = 0.1) + 
  coord_fixed() + 
  scale_color_gradient(low = "gray90", high = "blue", 
                       trans = "sqrt", breaks = range(df$expr), 
                       name = "counts") + 
  ggtitle(ix_name) + 
  theme_bw() + 
  theme(plot.title = element_text(face = "italic"), 
        panel.grid = element_blank(), 
        axis.title = element_blank(), 
        axis.text = element_blank(), 
        axis.ticks = element_blank())

## ----message=FALSE------------------------------------------------------------
library(SpatialExperiment)
library(WeberDivechaLCdata)
library(nnSVG)

## -----------------------------------------------------------------------------
# load example dataset from WeberDivechaLCdata package
# see '?WeberDivechaLCdata_Visium' for more details
spe <- WeberDivechaLCdata_Visium()

dim(spe)

# check sample IDs
table(colData(spe)$sample_id)

## -----------------------------------------------------------------------------
# select sample IDs for example
samples_keep <- c("Br6522_LC_1_round1", "Br6522_LC_2_round1")

# subset SpatialExperiment object to keep only these samples
spe <- spe[, colData(spe)$sample_id %in% samples_keep]

# remove empty levels from factor of sample IDs
colData(spe)$sample_id <- droplevels(colData(spe)$sample_id)

# check
dim(spe)
table(colData(spe)$sample_id)

## -----------------------------------------------------------------------------
# preprocessing steps

# keep only spots over tissue
spe <- spe[, colData(spe)$in_tissue == 1]
dim(spe)

# skip spot-level quality control, since this has been performed previously 
# on this dataset

## -----------------------------------------------------------------------------
# filter low-expressed genes

# filter out genes with extremely low expression
# using simple threshold on total UMI counts summed across all spots

# approximate threshold of 10 UMI counts per sample
n_umis <- 20
ix_low_genes <- rowSums(counts(spe)) < n_umis
table(ix_low_genes)

spe <- spe[!ix_low_genes, ]
dim(spe)


# filter any new zeros created after filtering low-expressed genes

# remove genes with zero expression
ix_zero_genes <- rowSums(counts(spe)) == 0
table(ix_zero_genes)

if (sum(ix_zero_genes) > 0) {
  spe <- spe[!ix_zero_genes, ]
}

dim(spe)

# remove spots with zero expression
ix_zero_spots <- colSums(counts(spe)) == 0
table(ix_zero_spots)

if (sum(ix_zero_spots) > 0) {
  spe <- spe[, !ix_zero_spots]
}

dim(spe)

## -----------------------------------------------------------------------------
# run nnSVG once per sample and store lists of top SVGs

sample_ids <- levels(colData(spe)$sample_id)

res_list <- as.list(rep(NA, length(sample_ids)))
names(res_list) <- sample_ids

for (s in seq_along(sample_ids)) {
  
  # select sample
  ix <- colData(spe)$sample_id == sample_ids[s]
  spe_sub <- spe[, ix]
  
  dim(spe_sub)
  
  # run nnSVG filtering for mitochondrial genes and low-expressed genes
  # (note: set 'filter_mito = TRUE' in most datasets)
  spe_sub <- filter_genes(
    spe_sub, 
    filter_genes_ncounts = 3, 
    filter_genes_pcspots = 0.5, 
    filter_mito = FALSE
  )
  
  # remove any zeros introduced by filtering
  ix_zeros <- colSums(counts(spe_sub)) == 0
  if (sum(ix_zeros) > 0) {
    spe_sub <- spe_sub[, !ix_zeros]
  }
  
  dim(spe_sub)
  
  # re-calculate logcounts after filtering
  spe_sub <- computeLibraryFactors(spe_sub)
  spe_sub <- logNormCounts(spe_sub)
  
  # subsample small set of random genes for faster runtime in this example
  # (same genes for each sample)
  # (note: skip this step in a full analysis)
  if (s == 1) {
    set.seed(123)
    ix_random <- sample(seq_len(nrow(spe_sub)), 30)
    genes_random <- rownames(spe_sub)[ix_random]
  }
  spe_sub <- spe_sub[rownames(spe_sub) %in% genes_random, ]
  dim(spe_sub)
  
  # run nnSVG
  set.seed(123)
  spe_sub <- nnSVG(spe_sub)
  
  # store results for this sample
  res_list[[s]] <- rowData(spe_sub)
}

## -----------------------------------------------------------------------------
# combine results for multiple samples by averaging gene ranks 
# to generate an overall ranking

# number of genes that passed filtering (and subsampling) for each sample
sapply(res_list, nrow)


# match results from each sample and store in matching rows
res_ranks <- matrix(NA, nrow = nrow(spe), ncol = length(sample_ids))
rownames(res_ranks) <- rownames(spe)
colnames(res_ranks) <- sample_ids

for (s in seq_along(sample_ids)) {
  stopifnot(colnames(res_ranks)[s] == sample_ids[s])
  stopifnot(colnames(res_ranks)[s] == names(res_list)[s])
  
  rownames_s <- rownames(res_list[[s]])
  res_ranks[rownames_s, s] <- res_list[[s]][, "rank"]
}


# remove genes that were filtered out in all samples
ix_allna <- apply(res_ranks, 1, function(r) all(is.na(r)))
res_ranks <- res_ranks[!ix_allna, ]

dim(res_ranks)


# calculate average ranks
# note missing values due to filtering for samples
avg_ranks <- rowMeans(res_ranks, na.rm = TRUE)


# calculate number of samples where each gene is within top 100 ranked SVGs
# for that sample
n_withinTop100 <- apply(res_ranks, 1, function(r) sum(r <= 100, na.rm = TRUE))


# summary table
df_summary <- data.frame(
  gene_id = names(avg_ranks), 
  gene_name = rowData(spe)[names(avg_ranks), "gene_name"], 
  gene_type = rowData(spe)[names(avg_ranks), "gene_type"], 
  overall_rank = rank(avg_ranks), 
  average_rank = unname(avg_ranks), 
  n_withinTop100 = unname(n_withinTop100), 
  row.names = names(avg_ranks)
)

# sort by average rank
df_summary <- df_summary[order(df_summary$average_rank), ]
head(df_summary)

# top n genes
# (note: NAs in this example due to subsampling genes for faster runtime)
top100genes <- df_summary$gene_name[1:100]


# summary table of "replicated" SVGs (i.e. genes that are highly ranked in at
# least x samples)
df_summaryReplicated <- df_summary[df_summary$n_withinTop100 >= 2, ]

# re-calculate rank within this set
df_summaryReplicated$overall_rank <- rank(df_summaryReplicated$average_rank)

dim(df_summaryReplicated)
head(df_summaryReplicated)

# top "replicated" SVGs
topSVGsReplicated <- df_summaryReplicated$gene_name

## -----------------------------------------------------------------------------
# plot one of the top SVGs

head(df_summary, 5)

ix_gene <- which(rowData(spe)$gene_name == df_summary[2, "gene_name"])

df <- as.data.frame(cbind(
  colData(spe), 
  spatialCoords(spe), 
  gene = counts(spe)[ix_gene, ]
))

ggplot(df, aes(x = pxl_col_in_fullres, y = pxl_row_in_fullres, color = gene)) + 
  facet_wrap(~ sample_id, nrow = 1, scales = "free") + 
  geom_point(size = 0.6) + 
  scale_color_gradient(low = "gray80", high = "red", trans = "sqrt", 
                       name = "counts", breaks = range(df$gene)) + 
  scale_y_reverse() + 
  ggtitle(paste0(rowData(spe)$gene_name[ix_gene], " expression")) + 
  theme_bw() + 
  theme(aspect.ratio = 1, 
        panel.grid = element_blank(), 
        plot.title = element_text(face = "italic"), 
        axis.title = element_blank(), 
        axis.text = element_blank(), 
        axis.ticks = element_blank())

## ----eval=FALSE---------------------------------------------------------------
# # filter any new zeros created after filtering low-expressed genes
# 
# # remove genes with zero expression
# ix_zero_genes <- rowSums(counts(spe)) == 0
# table(ix_zero_genes)
# 
# if (sum(ix_zero_genes) > 0) {
#   spe <- spe[!ix_zero_genes, ]
# }
# 
# dim(spe)
# 
# # remove spots with zero expression
# ix_zero_spots <- colSums(counts(spe)) == 0
# table(ix_zero_spots)
# 
# if (sum(ix_zero_spots) > 0) {
#   spe <- spe[, !ix_zero_spots]
# }
# 
# dim(spe)

## -----------------------------------------------------------------------------
sessionInfo()

