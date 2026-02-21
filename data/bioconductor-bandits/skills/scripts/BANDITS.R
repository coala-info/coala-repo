# Code example from 'BANDITS' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy=FALSE, cache=TRUE,
dev="png",
message=TRUE, error=FALSE, warning=TRUE)

## ----vignettes, eval=FALSE----------------------------------------------------
# browseVignettes("BANDITS")

## ----citation-----------------------------------------------------------------
citation("BANDITS")

## ----Bioconductor_installation, eval=FALSE------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#   install.packages("BiocManager")
# BiocManager::install("BANDITS")

## ----github_installation, eval=FALSE------------------------------------------
# devtools::install_github("SimoneTiberi/BANDITS")

## ----github_installation_2, eval=FALSE----------------------------------------
# devtools::install_github("SimoneTiberi/BANDITS",
#                          build_opts = c("--no-resave-data", "--no-manual"))

## ----gene-transcript_from_gtf, eval=FALSE-------------------------------------
# suppressMessages(library(GenomicFeatures))
# gtf_file = system.file("extdata","GTF_files","Aedes_aegypti.partial.gtf",
#                        package="GenomicFeatures")
# tx = makeTxDbFromGFF(gtf_file)
# ss = unlist(transcriptsBy(tx, by="gene"))
# gene_tr_id_gtf = data.frame(gene_id = names(ss), transcript_id = ss$tx_name )
# # remove eventual NA's:
# gene_tr_id_gtf = gene_tr_id_gtf[ rowSums( is.na(gene_tr_id_gtf)) == 0, ]
# # remove eventual duplicated rows:
# gene_tr_id_gtf = unique(gene_tr_id_gtf)

## ----gene-transcript_from_fasta, eval=FALSE-----------------------------------
# suppressMessages(library(Biostrings))
# data_dir = system.file("extdata", package = "BANDITS")
# fasta = readDNAStringSet(file.path(data_dir, "Homo_sapiens.GRCh38.cdna.all.1.1.10M.fa.gz"))
# ss = strsplit(names(fasta), " ")
# gene_tr_id_fasta = data.frame(gene_id = gsub("gene:", "", sapply(ss, .subset, 4)),
#                               transcript_id = sapply(ss, .subset, 1))
# # remove eventual NA's
# gene_tr_id_fasta = gene_tr_id_fasta[ rowSums( is.na(gene_tr_id_fasta)) == 0, ]
# # remove eventual duplicated rows:
# gene_tr_id_fasta = unique(gene_tr_id_fasta)

## ----load_BANDITS, message=FALSE----------------------------------------------
library(BANDITS)

## ----specify_data-dir---------------------------------------------------------
data_dir = system.file("extdata", package = "BANDITS")

## ----load_gene-transcript-----------------------------------------------------
data("gene_tr_id", package = "BANDITS")
head(gene_tr_id)

## ----specify_quantification_path----------------------------------------------
sample_names = paste0("sample", seq_len(4))
quant_files = file.path(data_dir, "STAR-salmon", sample_names, "quant.sf")
file.exists(quant_files)

## ----load_counts--------------------------------------------------------------
library(tximport)
txi = tximport(files = quant_files, type = "salmon", txOut = TRUE)
counts = txi$counts
head(counts)

## ----specify_design-----------------------------------------------------------
samples_design = data.frame(sample_id = sample_names,
                            group = c("A", "A", "B", "B"))
samples_design

## ----groups-------------------------------------------------------------------
levels(samples_design$group)

## ----effective_transcript_length----------------------------------------------
eff_len = eff_len_compute(x_eff_len = txi$length)
head(eff_len)

## ----filter_lowly_abundant_transcripts----------------------------------------
transcripts_to_keep = filter_transcripts(gene_to_transcript = gene_tr_id,
                                         transcript_counts = counts, 
                                         min_transcript_proportion = 0.01,
                                         min_transcript_counts = 10, 
                                         min_gene_counts = 20)
head(transcripts_to_keep)

## ----specify_salmon_EC_path---------------------------------------------------
equiv_classes_files = file.path(data_dir, "STAR-salmon", sample_names, 
                                "aux_info", "eq_classes.txt")
file.exists(equiv_classes_files)

## ----check_same_order_salmon--------------------------------------------------
equiv_classes_files
samples_design$sample_id

## ----create_data_salmon-------------------------------------------------------
input_data = create_data(salmon_or_kallisto = "salmon",
                         gene_to_transcript = gene_tr_id,
                         salmon_path_to_eq_classes = equiv_classes_files,
                         eff_len = eff_len, 
                         n_cores = 2,
                         transcripts_to_keep = transcripts_to_keep)

## ----filter_genes_salmon------------------------------------------------------
input_data = filter_genes(input_data, min_counts_per_gene = 20)

## ----specify_kallisto_EC_path-------------------------------------------------
kallisto_equiv_classes = file.path(data_dir, "kallisto", sample_names, "pseudoalignments.ec")
kallisto_equiv_counts  = file.path(data_dir, "kallisto", sample_names, "pseudoalignments.tsv")
file.exists(kallisto_equiv_classes); file.exists(kallisto_equiv_counts)

## ----check_same_order_kallisto------------------------------------------------
kallisto_equiv_classes; kallisto_equiv_counts
samples_design$sample_id

## ----create_data_kallisto-----------------------------------------------------
input_data_2 = create_data(salmon_or_kallisto = "kallisto",
                           gene_to_transcript = gene_tr_id,
                           kallisto_equiv_classes = kallisto_equiv_classes,
                           kallisto_equiv_counts = kallisto_equiv_counts,
                           kallisto_counts = counts,
                           eff_len = eff_len, n_cores = 2,
                           transcripts_to_keep = transcripts_to_keep)
input_data_2

## ----filter_genes_kallisto----------------------------------------------------
input_data_2 = filter_genes(input_data_2, min_counts_per_gene = 20)

## ----prior_precision----------------------------------------------------------
set.seed(61217)
precision = prior_precision(gene_to_transcript = gene_tr_id,
                            transcript_counts = counts, n_cores = 2,
                            transcripts_to_keep = transcripts_to_keep)

## ----prior--------------------------------------------------------------------
precision$prior

## ----plot_precision-----------------------------------------------------------
plot_precision(precision)

## ----test_DTU-----------------------------------------------------------------
set.seed(61217)
results = test_DTU(BANDITS_data = input_data,
                   precision = precision$prior,
                   samples_design = samples_design,
                   group_col_name = "group",
                   R = 10^4, burn_in = 2*10^3, n_cores = 2,
                   gene_to_transcript = gene_tr_id)

## ----visualize_results--------------------------------------------------------
results

## ----top_genes----------------------------------------------------------------
head(top_genes(results))

## ----top_genes_by_DTU_measure-------------------------------------------------
head(top_genes(results, sort_by = "DTU_measure"))

## ----top_transcripts----------------------------------------------------------
head(top_transcripts(results, sort_by = "transcript"))

## ----convergence--------------------------------------------------------------
head(convergence(results))

## ----top_gene-----------------------------------------------------------------
top_gene = top_genes(results, n = 1)
gene(results, top_gene$Gene_id)

## ----top_transcript-----------------------------------------------------------
top_transcript = top_transcripts(results, n = 1)
transcript(results, top_transcript$Transcript_id)

## ----plot_proportions---------------------------------------------------------
plot_proportions(results, top_gene$Gene_id, CI = TRUE, CI_level = 0.95)

## ----specify_design_3_groups--------------------------------------------------
samples_design_3_groups = data.frame(sample_id = sample_names,
                            group = c("A", "B", "B", "C"))
samples_design_3_groups
levels(samples_design_3_groups$group)

## ----test_DTU_3_groups--------------------------------------------------------
set.seed(61217)
results_3_groups = test_DTU(BANDITS_data = input_data,
                   precision = precision$prior,
                   samples_design = samples_design_3_groups,
                   group_col_name = "group",
                   R = 10^4, burn_in = 2*10^3, n_cores = 2,
                   gene_to_transcript = gene_tr_id)
results_3_groups

## ----top_genes_3_groups-------------------------------------------------------
head(top_genes(results_3_groups))

head(top_transcripts(results_3_groups))

## ----top_gene_3_groups--------------------------------------------------------
gene(results_3_groups, top_genes(results_3_groups)$Gene_id[1])

transcript(results_3_groups, top_transcripts(results_3_groups)$Transcript_id[1])

## ----plot_proportions_3_groups------------------------------------------------
plot_proportions(results_3_groups, top_genes(results_3_groups)$Gene_id[1], CI = TRUE, CI_level = 0.95)

## ----specify_design_1_group---------------------------------------------------
samples_design_1_group = data.frame(sample_id = sample_names,
                            group = c("A", "A", "A", "A"))
samples_design_1_group
levels(samples_design_1_group$group)

## ----test_DTU_1_group---------------------------------------------------------
set.seed(61217)
results_1_group = test_DTU(BANDITS_data = input_data,
                   precision = precision$prior,
                   samples_design = samples_design_1_group,
                   group_col_name = "group",
                   R = 10^4, burn_in = 2*10^3, n_cores = 2,
                   gene_to_transcript = gene_tr_id)
results_1_group

## ----top_genes_1_group--------------------------------------------------------
head(top_genes(results_1_group))

head(top_transcripts(results_1_group))

## ----top_gene_1_group---------------------------------------------------------
gene(results_1_group, top_genes(results_1_group)$Gene_id[1])

transcript(results_1_group, top_transcripts(results_1_group)$Transcript_id[1])

## ----plot_proportions_1_group-------------------------------------------------
plot_proportions(results_1_group, top_genes(results)$Gene_id[1], CI = TRUE, CI_level = 0.95)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

