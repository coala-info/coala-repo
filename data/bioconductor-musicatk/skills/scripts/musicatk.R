# Code example from 'musicatk' vignette. See references/ for full tutorial.

## ----setup, include=FALSE, results = "asis"-----------------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(echo = TRUE, dev = "png")

## ----eval= FALSE--------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("musicatk")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("devtools", quietly = TRUE)) {
#   install.packages("devtools")
# }
# 
# library(devtools)
# install_github("campbio/musicatk")

## ----eval = TRUE, message = FALSE---------------------------------------------
library(musicatk)

## ----extract_variants, message = FALSE----------------------------------------
# Extract variants from a MAF File
lusc_maf <- system.file("extdata", "public_TCGA.LUSC.maf", package = "musicatk")
lusc.variants <- extract_variants_from_maf_file(maf_file = lusc_maf)

# Extract variants from an individual VCF file
luad_vcf <- system.file("extdata", "public_LUAD_TCGA-97-7938.vcf",
  package = "musicatk"
)
luad.variants <- extract_variants_from_vcf_file(vcf_file = luad_vcf)

# Extract variants from multiple files and/or objects
melanoma_vcfs <- list.files(system.file("extdata", package = "musicatk"),
  pattern = glob2rx("*SKCM*vcf"), full.names = TRUE
)
variants <- extract_variants(c(lusc_maf, luad_vcf, melanoma_vcfs))

## ----select_genome------------------------------------------------------------
g <- select_genome("hg38")

## ----create_musica------------------------------------------------------------
musica <- create_musica_from_variants(x = variants, genome = g)

## ----build_tables-------------------------------------------------------------
build_standard_table(musica, g = g, table_name = "SBS96")

## ----combine_tables-----------------------------------------------------------
data(dbs_musica)
build_standard_table(dbs_musica, g, "SBS96", overwrite = TRUE)
build_standard_table(dbs_musica, g, "DBS78", overwrite = TRUE)

# Subset SBS table to DBS samples so they cam be combined
count_tables <- tables(dbs_musica)
overlap_samples <- which(colnames(count_tables$SBS96@count_table) %in%
                           colnames(count_tables$DBS78@count_table))
count_tables$SBS96@count_table <-
  count_tables$SBS96@count_table[, overlap_samples]
tables(dbs_musica) <- count_tables

combine_count_tables(
  musica = dbs_musica, to_comb = c("SBS96", "DBS78"),
  name = "sbs_dbs", description = "An example combined
                     table, combining SBS96 and DBS", overwrite = TRUE
)

## -----------------------------------------------------------------------------
annotate_transcript_strand(musica, "19", build_table = FALSE)
build_custom_table(
  musica = musica, variant_annotation = "Transcript_Strand",
  name = "Transcript_Strand",
  description = "A table of transcript strand of variants",
  data_factor = c("T", "U"), overwrite = TRUE
)

## ----create_musica_from_counts------------------------------------------------
luad_count_table_path <- system.file("extdata", "luad_tcga_count_table.csv",
  package = "musicatk"
)
luad_count_table <- as.matrix(read.csv(luad_count_table_path))

musica_from_counts <- create_musica_from_counts(luad_count_table, "SBS96")

## ----discover_sigs------------------------------------------------------------
discover_signatures(
  musica = musica, modality = "SBS96", num_signatures = 3,
  algorithm = "nmf", model_id = "ex_result", nstart = 10
)

## ----result_accessors---------------------------------------------------------
# Extract the exposure matrix
expos <- exposures(musica, "result", "SBS96", "ex_result")
expos[1:3, 1:3]

# Extract the signature matrix
sigs <- signatures(musica, "result", "SBS96", "ex_result")
sigs[1:3, 1:3]

## ----compare_k_vals-----------------------------------------------------------
k_comparison <- compare_k_vals(musica, "SBS96",
  reps = 5, min_k = 2, max_k = 4,
  algorithm = "nmf"
)

## ----plot_sigs----------------------------------------------------------------
plot_signatures(musica, model_id = "ex_result", modality = "SBS96")

## ----name_sigs----------------------------------------------------------------
name_signatures(musica, "ex_result", c("Smoking", "APOBEC", "UV"))
plot_signatures(musica, model_id = "ex_result", modality = "SBS96")

## ----exposures_raw------------------------------------------------------------
plot_exposures(musica, "ex_result", plot_type = "bar")

## ----exposures_prop-----------------------------------------------------------
plot_exposures(musica, "ex_result", plot_type = "bar", proportional = TRUE)

## ----sample_counts------------------------------------------------------------
samples <- sample_names(musica)
plot_sample_counts(musica, sample_names = samples[c(3, 4, 5)],
                   modality = "SBS96")

## ----compare_cosmic-----------------------------------------------------------
compare_cosmic_v2(musica, "ex_result", threshold = 0.75)

## ----predict_cosmic-----------------------------------------------------------
# Load COSMIC V2 data
data("cosmic_v2_sigs")

# Predict pre-existing exposures using the "lda" method
predict_exposure(
  musica = musica, modality = "SBS96",
  signature_res = cosmic_v2_sigs, model_id = "ex_pred_result",
  signatures_to_use = c(1, 4, 7, 13), algorithm = "lda"
)

# Plot exposures
plot_exposures(musica, "ex_pred_result", plot_type = "bar")

## ----subtype_map--------------------------------------------------------------
cosmic_v2_subtype_map("lung")

## ----predict_previous---------------------------------------------------------
model <- get_model(musica, "result", "SBS96", "ex_result")
predict_exposure(
  musica = musica, modality = "SBS96",
  signature_res = model, algorithm = "lda",
  model_id = "pred_our_sigs"
)

## ----predict_compare----------------------------------------------------------
compare_results(musica,
  model_id = "ex_pred_result",
  other_model_id = "pred_our_sigs", threshold = 0.60
)

## ----annotations--------------------------------------------------------------
annot <- read.table(system.file("extdata", "sample_annotations.txt",
                                package = "musicatk"),
                    sep = "\t", header = TRUE)
samp_annot(musica, "Tumor_Subtypes") <- annot$Tumor_Subtypes

## ----sample_names-------------------------------------------------------------
sample_names(musica)

## ----plot_exposures_by_subtype------------------------------------------------
plot_exposures(musica, "ex_result",
  plot_type = "bar", group_by = "annotation",
  annotation = "Tumor_Subtypes"
)

## ----plot_exposures_box_annot-------------------------------------------------
plot_exposures(musica, "ex_result", plot_type = "box", group_by = "annotation",
               annotation = "Tumor_Subtypes")

## ----plot_exposures_box_sig---------------------------------------------------
plot_exposures(musica, "ex_result",
  plot_type = "box", group_by = "signature",
  color_by = "annotation", annotation = "Tumor_Subtypes"
)

## ----umap_create--------------------------------------------------------------
create_umap(musica, "ex_result")

## ----umap_plot----------------------------------------------------------------
plot_umap(musica, "ex_result")

## ----umap_plot_same_scale-----------------------------------------------------
plot_umap(musica, "ex_result", same_scale = FALSE)

## ----umap_plot_annot----------------------------------------------------------
plot_umap(musica, "ex_result",
  color_by = "annotation",
  annotation = "Tumor_Subtypes", add_annotation_labels = TRUE
)

## ----plotly-------------------------------------------------------------------
plot_signatures(musica, "ex_result", plotly = TRUE)
plot_exposures(musica, "ex_result", plotly = TRUE)
plot_umap(musica, "ex_result", plotly = TRUE)

## ----reproducible_prediction--------------------------------------------------
seed <- 1
withr::with_seed(seed, predict_exposure(
  musica = musica, modality = "SBS96",
  signature_res = model, algorithm = "lda",
  model_id = "reproducible_ex"
))

## ----session------------------------------------------------------------------
sessionInfo()

