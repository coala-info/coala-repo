# Code example from 'doubletrouble_vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
)

## ----installation, eval = FALSE-----------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("doubletrouble")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----load_package-------------------------------------------------------------
library(doubletrouble)

## ----eval=FALSE---------------------------------------------------------------
# # Checking if names of lists match
# setequal(names(seqs), names(annotation)) # should return TRUE

## ----eval=FALSE---------------------------------------------------------------
# species <- c("Saccharomyces cerevisiae", "Candida glabrata")
# 
# # Download data from Ensembl with {biomartr}
# ## Whole-genome protein sequences (.fa)
# fasta_dir <- file.path(tempdir(), "proteomes")
# fasta_files <- biomartr::getProteomeSet(
#     db = "ensembl", organisms = species, path = fasta_dir
# )
# 
# ## Gene annotation (.gff3)
# gff_dir <- file.path(tempdir(), "annotation")
# gff_files <- biomartr::getGFFSet(
#     db = "ensembl", organisms = species, path = gff_dir
# )
# 
# ## CDS (.fa)
# cds_dir <- file.path(tempdir(), "CDS")
# cds_files <- biomartr::getCDSSet(
#     db = "ensembl", organisms = species, path = cds_dir
# )
# 
# # Import data to the R session
# ## Read .fa files with proteomes as a list of AAStringSet + clean names
# seq <- syntenet::fasta2AAStringSetlist(fasta_dir)
# names(seq) <- gsub("\\..*", "", names(seq))
# 
# ## Read .gff3 files as a list of GRanges
# annot <- syntenet::gff2GRangesList(gff_dir)
# names(annot) <- gsub("\\..*", "", names(annot))
# 
# ## Read .fa files with CDS as a list of DNAStringSet objects
# cds <- lapply(cds_files, Biostrings::readDNAStringSet)
# names(cds) <- gsub("\\..*", "", basename(cds_files))
# 
# # Process data
# ## Keep ranges for protein-coding genes only
# yeast_annot <- lapply(annot, function(x) {
#     gene_ranges <- x[x$biotype == "protein_coding" & x$type == "gene"]
#     gene_ranges <- IRanges::subsetByOverlaps(x, gene_ranges)
#     return(gene_ranges)
# })
# 
# ## Keep only longest sequence for each protein-coding gene (no isoforms)
# yeast_seq <- lapply(seq, function(x) {
#     # Keep only protein-coding genes
#     x <- x[grep("protein_coding", names(x))]
# 
#     # Leave only gene IDs in sequence names
#     names(x) <- gsub(".*gene:| .*", "", names(x))
# 
#     # If isoforms are present (same gene ID multiple times), keep the longest
#     x <- x[order(Biostrings::width(x), decreasing = TRUE)]
#     x <- x[!duplicated(names(x))]
# 
#     return(x)
# })

## ----example_data-------------------------------------------------------------
# Load example data
data(yeast_seq)
data(yeast_annot)

yeast_seq
yeast_annot

## ----process_input------------------------------------------------------------
library(syntenet)

# Process input data
pdata <- process_input(yeast_seq, yeast_annot)

# Inspect the output
names(pdata)
pdata$seq
pdata$annotation

## ----run_diamond_intraspecies-------------------------------------------------
data(diamond_intra)

# Run DIAMOND in sensitive mode for S. cerevisiae only
if(diamond_is_installed()) {
    diamond_intra <- run_diamond(
        seq = pdata$seq["Scerevisiae"],
        compare = "intraspecies", 
        outdir = file.path(tempdir(), "diamond_intra"),
        ... = "--sensitive"
    )
}

# Inspect output
names(diamond_intra)
head(diamond_intra$Scerevisiae_Scerevisiae)

## ----binary_classification----------------------------------------------------
# Binary scheme
c_binary <- classify_gene_pairs(
    annotation = pdata$annotation,
    blast_list = diamond_intra,
    scheme = "binary"
)

# Inspecting the output
names(c_binary)
head(c_binary$Scerevisiae)

# How many pairs are there for each duplication mode?
table(c_binary$Scerevisiae$type)

## ----expanded_classification--------------------------------------------------
# Standard scheme
c_standard <- classify_gene_pairs(
    annotation = pdata$annotation,
    blast_list = diamond_intra,
    scheme = "standard"
)

# Inspecting the output
names(c_standard)
head(c_standard$Scerevisiae)

# How many pairs are there for each duplication mode?
table(c_standard$Scerevisiae$type)

## ----make_bidirectional_comparisons-------------------------------------------
# Create a data frame of species and outgroups for `syntenet::run_diamond()`
spp_outgroup <- data.frame(
    species = "Scerevisiae",
    outgroup = "Cglabrata"
)
spp_outgroup

# Expand the data frame to make bidirectional comparisons
comparisons <- syntenet::make_bidirectional(spp_outgroup)
comparisons

## ----blast_interspecies-------------------------------------------------------
data(diamond_inter) # load pre-computed output in case DIAMOND is not installed

# Run DIAMOND for the comparisons we specified
if(diamond_is_installed()) {
    diamond_inter <- run_diamond(
        seq = pdata$seq,
        compare = comparisons,
        outdir = file.path(tempdir(), "diamond_inter"),
        ... = "--sensitive"
    )
}

names(diamond_inter)
head(diamond_inter$Scerevisiae_Cglabrata)

## ----collapse_hits------------------------------------------------------------
# For each species-outgroup pair, collapse bidirectional hits in one data frame
diamond_inter <- syntenet::collapse_bidirectional_hits(
    diamond_inter, compare = spp_outgroup
)
names(diamond_inter)

## ----full_classification------------------------------------------------------
# Extended scheme
c_extended <- classify_gene_pairs(
    annotation = pdata$annotation,
    blast_list = diamond_intra,
    scheme = "extended",
    blast_inter = diamond_inter
)

# Inspecting the output
names(c_extended)
head(c_extended$Scerevisiae)

# How many pairs are there for each duplication mode?
table(c_extended$Scerevisiae$type)

## -----------------------------------------------------------------------------
# Example: multiple outgroups for the same species
spp_outgroup_many <- data.frame(
    species = rep("speciesA", 3),
    outgroup = c("speciesB", "speciesC", "speciesD")
)

comparisons_many <- syntenet::make_bidirectional(spp_outgroup_many)
comparisons_many

## ----message=FALSE------------------------------------------------------------
library(txdbmaker)

# Create a list of `TxDb` objects from a list of `GRanges` objects
txdb_list <- lapply(yeast_annot, txdbmaker::makeTxDbFromGRanges)
txdb_list

## -----------------------------------------------------------------------------
# Get a list of data frames with intron counts per gene for each species
intron_counts <- lapply(txdb_list, get_intron_counts)

# Inspecting the list
names(intron_counts)
head(intron_counts$Scerevisiae)

## -----------------------------------------------------------------------------
# Full scheme
c_full <- classify_gene_pairs(
    annotation = pdata$annotation,
    blast_list = diamond_intra,
    scheme = "full",
    blast_inter = diamond_inter,
    intron_counts = intron_counts
)

# Inspecting the output
names(c_full)
head(c_full$Scerevisiae)

# How many pairs are there for each duplication mode?
table(c_full$Scerevisiae$type)

## ----classify_genes-----------------------------------------------------------
# Classify genes into unique modes of duplication
c_genes <- classify_genes(c_full)

# Inspecting the output
names(c_genes)
head(c_genes$Scerevisiae)

# Number of genes per mode
table(c_genes$Scerevisiae$type)

## ----kaks_calculation---------------------------------------------------------
data(cds_scerevisiae)
head(cds_scerevisiae)

# Store DNAStringSet object in a list
cds_list <- list(Scerevisiae = cds_scerevisiae)

# Keep only top five TD-derived gene pairs for demonstration purposes
td_pairs <- c_full$Scerevisiae[c_full$Scerevisiae$type == "TD", ]
gene_pairs <- list(Scerevisiae = td_pairs[seq(1, 5, by = 1), ])

# Calculate Ka, Ks, and Ka/Ks
kaks <- pairs2kaks(gene_pairs, cds_list)

# Inspect the output
head(kaks)

## ----ks_eda-------------------------------------------------------------------
# Load data and inspect it
data(gmax_ks)
head(gmax_ks)

# Plot distribution
plot_ks_distro(gmax_ks)

## ----find_ks_peaks------------------------------------------------------------
# Find 2 and 3 peaks and test which one has more support
peaks <- find_ks_peaks(gmax_ks$Ks, npeaks = c(2, 3), verbose = TRUE)
names(peaks)
str(peaks)

# Visualize Ks distribution
plot_ks_peaks(peaks)

## ----find_peaks_explicit------------------------------------------------------
# Find 2 peaks ignoring Ks values > 1
peaks <- find_ks_peaks(gmax_ks$Ks, npeaks = 2, max_ks = 1)
plot_ks_peaks(peaks)

## ----sizer--------------------------------------------------------------------
# Get numeric vector of Ks values <= 1
ks <- gmax_ks$Ks[gmax_ks$Ks <= 1]

# Get SiZer map
feature::SiZer(ks)

## ----split_by_peak------------------------------------------------------------
# Gene pairs without age-based classification
head(gmax_ks)

# Classify gene pairs by age group
pairs_age_group <- split_pairs_by_peak(gmax_ks[, c(1,2,3)], peaks)

# Inspecting the output
names(pairs_age_group)

# Take a look at the classified gene pairs
head(pairs_age_group$pairs)

# Visualize Ks distro with age boundaries
pairs_age_group$plot

## -----------------------------------------------------------------------------
# Get all pairs in age group 2
pairs_ag2 <- pairs_age_group$pairs[pairs_age_group$pairs$peak == 2, c(1,2)]

# Get all SD pairs
sd_pairs <- gmax_ks[gmax_ks$type == "SD", c(1,2)]

# Merge tables
pairs_wgd_legumes <- merge(pairs_ag2, sd_pairs)

head(pairs_wgd_legumes)

## -----------------------------------------------------------------------------
# Load data set with pre-computed duplicates for 3 fungi species
data(fungi_kaks)
names(fungi_kaks)
head(fungi_kaks$saccharomyces_cerevisiae)

# Get a data frame of counts per mode in all species
counts_table <- duplicates2counts(fungi_kaks |> classify_genes())

counts_table

## -----------------------------------------------------------------------------
# A) Facets
p1 <- plot_duplicate_freqs(counts_table)

# B) Stacked barplot, absolute frequencies
p2 <- plot_duplicate_freqs(counts_table, plot_type = "stack")

# C) Stacked barplot, relative frequencies
p3 <- plot_duplicate_freqs(counts_table, plot_type = "stack_percent")

# Combine plots, one per row
patchwork::wrap_plots(p1, p2, p3, nrow = 3) + 
    patchwork::plot_annotation(tag_levels = "A")

## ----fig.height = 3, fig.width = 8--------------------------------------------
# Frequency of duplicated genes by mode
classify_genes(fungi_kaks) |>   # classify genes into unique duplication types
    duplicates2counts() |>      # get a data frame of counts (long format)
    plot_duplicate_freqs()      # plot frequencies

## ----fig.height=3, fig.width=9------------------------------------------------
ks_df <- fungi_kaks$saccharomyces_cerevisiae

# A) Histogram, whole paranome
p1 <- plot_ks_distro(ks_df, plot_type = "histogram")

# B) Density, whole paranome
p2 <- plot_ks_distro(ks_df, plot_type = "density") 

# C) Histogram with density lines, whole paranome
p3 <- plot_ks_distro(ks_df, plot_type = "density_histogram")

# Combine plots side by side
patchwork::wrap_plots(p1, p2, p3, nrow = 1) +
    patchwork::plot_annotation(tag_levels = "A")

## ----fig.width = 8, fig.height=4----------------------------------------------
# A) Duplicates by type, histogram
p1 <- plot_ks_distro(ks_df, bytype = TRUE, plot_type = "histogram")

# B) Duplicates by type, violin
p2 <- plot_ks_distro(ks_df, bytype = TRUE, plot_type = "violin")

# Combine plots side by side
patchwork::wrap_plots(p1, p2) +
    patchwork::plot_annotation(tag_levels = "A")

## ----fig.width = 6, fig.height = 4--------------------------------------------
# A) Ks for each species
p1 <- plot_rates_by_species(fungi_kaks)

# B) Ka/Ks by duplication type for each species
p2 <- plot_rates_by_species(fungi_kaks, rate_column = "Ka_Ks", bytype = TRUE)

# Combine plots - one per row
patchwork::wrap_plots(p1, p2, nrow = 2) +
    patchwork::plot_annotation(tag_levels = "A")

## ----session_info-------------------------------------------------------------
sessioninfo::session_info()

