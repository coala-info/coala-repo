# Code example from 'vignette_01_inference_and_analysis_of_synteny_networks' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----installation, eval=FALSE-------------------------------------------------
# if(!requireNamespace('BiocManager', quietly = TRUE))
#   install.packages('BiocManager')
# 
# BiocManager::install("syntenet")

## ----load_package, message=FALSE----------------------------------------------
# Load package after installation
library(syntenet)

## ----data---------------------------------------------------------------------
# Protein sequences
data(proteomes)
head(proteomes)

# Annotation (ranges)
data(annotation)
head(annotation)

## ----fasta2AAStringSetlist----------------------------------------------------
# Path to directory containing FASTA files
fasta_dir <- system.file("extdata", "sequences", package = "syntenet")
fasta_dir

dir(fasta_dir) # see the contents of the directory

# Read all FASTA files in `fasta_dir`
aastringsetlist <- fasta2AAStringSetlist(fasta_dir)
aastringsetlist

## ----gff2GRangesList----------------------------------------------------------
# Path to directory containing FASTA files
gff_dir <- system.file("extdata", "annotation", package = "syntenet")
gff_dir

dir(gff_dir) # see the contents of the directory

# Read all FASTA files in `fasta_dir`
grangeslist <- gff2GRangesList(gff_dir)
grangeslist

## ----check_input--------------------------------------------------------------
check_input(proteomes, annotation)

## ----process_input------------------------------------------------------------
pdata <- process_input(proteomes, annotation)

# Looking at the processed data
pdata$seq
pdata$annotation

## ----run_diamond--------------------------------------------------------------
data(blast_list)
if(diamond_is_installed()) {
    blast_list <- run_diamond(seq = pdata$seq)
}

## ----blast_inspect------------------------------------------------------------
# List names
names(blast_list)

# Inspect first data frame
head(blast_list$Olucimarinus_Olucimarinus)

## ----infer_syntenet-----------------------------------------------------------
# Infer synteny network
net <- infer_syntenet(blast_list, pdata$annotation)

# Look at the output
head(net)

## ----create_species_id_table--------------------------------------------------
# Get a 2-column data frame of species IDs and names
id_table <- create_species_id_table(names(proteomes))

id_table

## ----cluster_network----------------------------------------------------------
# Load example data and take a look at it
data(network)
head(network)

# Cluster network
clusters <- cluster_network(network)
head(clusters)

## ----phylogenomic_profile-----------------------------------------------------
# Phylogenomic profiling
profiles <- phylogenomic_profile(clusters)

# Exploring the output
head(profiles)

## ----plot_profiles------------------------------------------------------------
# 1) Create a named vector of custom species order to plot
species_order <- setNames(
    # vector elements
    c(
        "vra", "van", "pvu", "gma", "cca", "tpr", "mtr", "adu", "lja",
        "Lang", "car", "pmu", "ppe", "pbr", "mdo", "roc", "fve",
        "Mnot", "Zjuj", "jcu", "mes", "rco", "lus", "ptr"
    ),
    # vector names
    c(
        "V. radiata", "V. angularis", "P. vulgaris", "G. max", "C. cajan",
        "T. pratense", "M. truncatula", "A. duranensis", "L. japonicus",
        "L. angustifolius", "C. arietinum", "P. mume", "P. persica",
        "P. bretschneideri", "M. domestica", "R. occidentalis", 
        "F. vesca", "M. notabilis", "Z. jujuba",
        "J. curcas", "M. esculenta", "R. communis", 
        "L. usitatissimum", "P. trichocarpa"
    )
)
species_order

# 2) Create a metadata data frame containing the family of each species
species_annotation <- data.frame(
    Species = species_order,
    Family = c(
        rep("Fabaceae", 11), rep("Rosaceae", 6),
        "Moraceae", "Ramnaceae", rep("Euphorbiaceae", 3), 
        "Linaceae", "Salicaceae"
    )
)
head(species_annotation)


# 3) Plot phylogenomic profiles, but using Ruzicka distances
plot_profiles(
    profiles, 
    species_annotation, 
    cluster_species = species_order, 
    dist_function = labdsv::dsvdis,
    dist_params = list(index = "ruzicka")
)

## ----find_GS_clusters---------------------------------------------------------
# Find group-specific clusters
gs_clusters <- find_GS_clusters(profiles, species_annotation)

head(gs_clusters)

# How many family-specific clusters are there?
nrow(gs_clusters)

## ----heatmap_filtered---------------------------------------------------------
# Filter profiles matrix to only include group-specific clusters
idx <- rownames(profiles) %in% gs_clusters$Cluster
p_gs <- profiles[idx, ]

# Plot heatmap
plot_profiles(
    p_gs, species_annotation, 
    cluster_species = species_order, 
    cluster_columns = TRUE
)

## ----plot_network-------------------------------------------------------------
# 1) Visualize a network of first 5 GS-clusters
id <- gs_clusters$Cluster[1:5]
plot_network(network, clusters, cluster_id = id)

# 2) Coloring nodes by family
genes <- unique(c(network$node1, network$node2))
gene_df <- data.frame(
    Gene = genes,
    Species = unlist(lapply(strsplit(genes, "_"), head, 1))
)
gene_df <- merge(gene_df, species_annotation)[, c("Gene", "Family")]
head(gene_df)

plot_network(network, clusters, cluster_id = id, color_by = gene_df)

# 3) Interactive visualization (zoom out and in to explore it)
plot_network(
    network, clusters, cluster_id = id, 
    interactive = TRUE, dim_interactive = c(500, 300)
)

## ----binarize-----------------------------------------------------------------
bt_mat <- binarize_and_transpose(profiles)

# Looking at the first 5 rows and 5 columns of the matrix
bt_mat[1:5, 1:5]

## ----infer_phylogeny----------------------------------------------------------
# Leave only 6 legume species and P. mume as an outgroup for testing purposes
included <- c("gma", "pvu", "vra", "van", "cca", "pmu")
bt_mat <- bt_mat[rownames(bt_mat) %in% included, ]

# Remove non-variable sites
bt_mat <- bt_mat[, colSums(bt_mat) != length(included)]

if(iqtree_is_installed()) {
    phylo <- infer_microsynteny_phylogeny(bt_mat, outgroup = "pmu", 
                                          threads = 1)
}

## ----vis_phylogeny, message = FALSE, warning = FALSE, fig.height = 12, fig.width = 7----
data(angiosperm_phylogeny)

# Plotting the tree
library(ggtree)
ggtree(angiosperm_phylogeny) +
    geom_tiplab(size = 3) +
    xlim(0, 0.3)

## ----faq1---------------------------------------------------------------------
# Add example directory /home/username/bioinfo_tools to PATH
Sys.setenv(
    PATH = paste(
        Sys.getenv("PATH"), "/home/username/bioinfo_tools", sep = ":"
    )
)

## ----faq3-p1------------------------------------------------------------------
# Path to directory containing data
data_dir <- system.file(
    "extdata", "RefSeq_parsing_example", package = "syntenet"
)
dir(data_dir)

# Reading the files to a format that syntenet understands
seqs <- fasta2AAStringSetlist(data_dir)
annot <- gff2GRangesList(data_dir)

# Taking a look at the data
seqs
head(names(seqs$Aalosa))

annot

## ----faq3-p2------------------------------------------------------------------
# Remove whitespace and everything after it
names(seqs$Aalosa) <- gsub(" .*", "", names(seqs$Aalosa))

# Taking a look at the new names
head(names(seqs$Aalosa))

## ----faq3-p3------------------------------------------------------------------
# Show only rows for which `type` is "CDS"
head(annot$Aalosa[annot$Aalosa$type == "CDS"])

## ----faq-p4-------------------------------------------------------------------
# Create a list of data frames containing protein-to-gene ID correspondences
protein2gene <- lapply(annot, function(x) {
    
    # Extract only CDS ranges
    cds_ranges <- x[x$type == "CDS"]
    
    # Create the ID correspondence data frame
    df <- data.frame(
        protein_id = cds_ranges$Name,
        gene_id = cds_ranges$gene
    )
    
    # Remove duplicate rows
    df <- df[!duplicated(df$protein_id), ]
    
    return(df)
})

# Taking a look at the list
protein2gene

## ----faq-p5-------------------------------------------------------------------
# Collapse protein IDs to gene IDs in list of sequences
new_seq <- collapse_protein_ids(seqs, protein2gene)

# Looking at the new sequences
new_seq

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

