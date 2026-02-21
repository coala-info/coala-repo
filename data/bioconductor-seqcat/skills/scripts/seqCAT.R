# Code example from 'seqCAT' vignette. See references/ for full tutorial.

## ----Options, echo = FALSE----------------------------------------------------
knitr::opts_chunk$set(fig.align = "center", message = FALSE)

## ----Installation, eval = FALSE-----------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("seqCAT")

## ----GitHub installation, eval = FALSE----------------------------------------
# install.packages("devtools")
# devtools::install_github("fasterius/seqCAT")

## ----Create an SNV profile----------------------------------------------------
# Load the package
library("seqCAT")

# List the example VCF file
vcf <- system.file("extdata", "example.vcf.gz", package = "seqCAT")

# Create two SNV profiles
hct116 <- create_profile(vcf, "HCT116")
head(hct116)

## ----Create a filtered SNV profile--------------------------------------------
rko <- create_profile(vcf, "RKO", min_depth = 15, filter_gd = FALSE)

## ----Filter an SNV profile----------------------------------------------------
# Filter on sequencing depth
rko_filtered <- filter_variants(rko, min_depth = 20)

# Filter position-level variants duplicates
rko_deduplicated <- filter_duplicates(rko, filter_pd = TRUE)

## ----Create multiple profiles, messages = FALSE-------------------------------
# Directory with VCF files
vcf_dir <- system.file("extdata", package = "seqCAT")

# Create profiles for each VCF with "sample1" in its name
profiles <- create_profiles(vcf_dir, pattern = "sample1")

## ----List COSMIC--------------------------------------------------------------
file <- system.file("extdata", "subset_CosmicCLP_MutantExport.tsv.gz",
                    package = "seqCAT")
cell_lines <- list_cosmic(file)
head(cell_lines)

## ----Search COSMIC------------------------------------------------------------
any(grepl("HCT116", cell_lines))

## ----Read COSMIC--------------------------------------------------------------
cosmic <- read_cosmic(file, "HCT116")
head(cosmic)

## ----Count COSMIC-------------------------------------------------------------
nrow(cosmic)

## ----Write profile to disk----------------------------------------------------
write_profile(hct116, "hct116.profile.txt")

## ----Write profile to disk (BED)----------------------------------------------
write_profile(hct116, "hct116.profile.bed")

## ----Write multiple profiles to disk (GTF)------------------------------------
write_profiles(profiles, format = "GTF", directory = "./")

## ----Read profile from disk---------------------------------------------------
hct116 <- read_profile("hct116.profile.txt")

## ----Read multiple profiles (GTF)---------------------------------------------
profile_list <- read_profiles(profile_dir = "./", pattern = ".gtf")
head(profile_list[[1]])

## ----Compare profiles---------------------------------------------------------
hct116_rko <- compare_profiles(hct116, rko)
head(hct116_rko)

## ----Compare profiles (union)-------------------------------------------------
hct116_rko_union <- compare_profiles(hct116, rko, mode = "union")
head(hct116_rko_union)

## ----Compare with COSMIC------------------------------------------------------
hct116_cosmic <- compare_profiles(hct116, cosmic)
head(hct116_cosmic)

## ----Calculate similarities---------------------------------------------------
similarity <- calculate_similarity(hct116_rko)
similarity

## ----Calculate similarities iteratively---------------------------------------
# Create and read HKE3 profile
hke3 <- create_profile(vcf, "HKE3")

# Compare HCT116 and HKE3
hct116_hke3 <- compare_profiles(hct116, hke3)

# Add HCT116/HKE3 similarities to HCT116/RKO similarities
similarities <- calculate_similarity(hct116_hke3, similarity, b = 10)
similarities

## ----Impact distributions-----------------------------------------------------
impacts <- plot_impacts(hct116_rko)
impacts

## ----Subset impacts-----------------------------------------------------------
hct116_rko_hm <- hct116_rko[hct116_rko$impact == "HIGH" |
                            hct116_rko$impact == "MODERATE", ]
nrow(hct116_rko_hm)

## ----Subset chromosome or region----------------------------------------------
hct116_rko_region <- hct116_rko[hct116_rko$chr == 12 &
                                hct116_rko$pos >= 25000000 &
                                hct116_rko$pos <= 30000000, ]
head(hct116_rko_region)

## ----Subset gene or transcript------------------------------------------------
hct116_rko_eps8_t <- hct116_rko[hct116_rko$ENSTID == "ENST00000281172", ]
hct116_rko_vamp1 <- hct116_rko[hct116_rko$ENSGID == "ENSG00000139190", ]
hct116_rko_ldhb <- hct116_rko[hct116_rko$gene == "LDHB", ]
head(hct116_rko_ldhb)

## ----Subset KRAS--------------------------------------------------------------
hct116_rko_kras <- hct116_rko[hct116_rko$rsID == "rs112445441", ]
hct116_rko_kras <- hct116_rko[hct116_rko$chr == 12 &
                              hct116_rko$pos == 25398281, ]
nrow(hct116_rko_kras)

## ----Create known variants list-----------------------------------------------
known_variants <- data.frame(chr  = c(12, 12, 12, 12),
                             pos  = c(25358650, 21788465, 21797029, 25398281),
                             gene = c("LYRM5", "LDHB", "LDHB", "KRAS"),
                             stringsAsFactors = FALSE)
known_variants

## ----List variants------------------------------------------------------------
variant_list <- list_variants(list(hct116, rko), known_variants)
variant_list

## ----Plot variant list--------------------------------------------------------
# Set row names to "chr: pos (gene)"
row.names(variant_list) <- paste0(variant_list$chr, ":", variant_list$pos,
                                  " (", variant_list$gene, ")")

# Remove "chr", "pos" and "gene" columns
to_remove <- c("chr", "pos", "gene")
variant_list <- variant_list[, !names(variant_list) %in% to_remove]

# Plot the genotypes in a grid
genotype_grid <- plot_variant_list(variant_list)
genotype_grid

## ----Many-to-many comparisons-------------------------------------------------
# Create list of SNV profiles
profiles <- list(hct116, hke3, rko)

# Perform many-to-many comparisons
many <- compare_many(profiles)
many[[1]]

## ----HKE3 self-comparisons----------------------------------------------------
hke3_hke3 <- many[[2]][[4]]
head(hke3_hke3)

## ----COSMIC-to-many comparisons-----------------------------------------------
many_cosmic <- compare_many(profiles, one = cosmic)
many_cosmic[[1]]

## ----Plot heatmap, out.width = "60 %"-----------------------------------------
heatmap <- plot_heatmap(many[[1]])
heatmap

## ----Remove temporary files, echo = FALSE, results = "hide"-------------------
file.remove("hct116.profile.txt")

## ----Session info, echo = FALSE-----------------------------------------------
sessionInfo()

