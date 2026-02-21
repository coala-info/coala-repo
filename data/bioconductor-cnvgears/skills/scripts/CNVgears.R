# Code example from 'CNVgears' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----bioc, eval = FALSE-------------------------------------------------------
#  if (!require("BiocManager"))
#      install.packages("BiocManager")
#  
#  BiocManager::install("CNVgears")

## ----bioc dev, eval = FALSE---------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  # The following initializes usage of Bioc devel
#  BiocManager::install(version='devel')
#  
#  BiocManager::install("CNVgears")

## ----install git hub, eval = FALSE--------------------------------------------
#  # not run
#  devtools::install_github("SinomeM/CNVgears")

## ----library------------------------------------------------------------------
library(CNVgears, quietly = TRUE)

## ---- message=TRUE, warning=TRUE----------------------------------------------
data.table::setDTthreads(percent=75)
data.table::setDTthreads(4)

## ---- include=FALSE-----------------------------------------------------------
data.table::setDTthreads(2)

## ----PED PFB------------------------------------------------------------------
# cohort data
cohort <- read_metadt(DT_path = system.file("extdata", "cohort.ped", 
                                            package = "CNVgears"),
                      sample_ID_col = "Individual ID", 
                      fam_ID_col = "Family ID",
                      sex_col = "Gender", role_col = "Role")
head(cohort)

# markers location
SNP_markers <- read_finalreport_snps(system.file("extdata", "SNP.pfb", 
                                                 package = "CNVgears"),
                                     mark_ID_col = "Name", chr_col = "Chr", 
                                     pos_col = "Position")
head(SNP_markers)

## ----results + raw, message=TRUE, warning=TRUE--------------------------------
# CNV calling results
penn <- read_results(DT_path = system.file("extdata", 
                                           "chrs_14_22_cnvs_penn.txt", 
                                           package = "CNVgears"), 
                     res_type = "file", DT_type = "TSV/CSV", 
                     chr_col = "chr", start_col = "posStart", 
                     end_col = "posEnd", CN_col = "CN", 
                     samp_ID_col = "Sample_ID", sample_list = cohort, 
                     markers = SNP_markers, method_ID = "P")
head(penn)

quanti <- read_results(DT_path = system.file("extdata", 
                                             "chrs_14_22_cnvs_quanti.txt", 
                                             package = "CNVgears"), 
                      res_type = "file", DT_type = "TSV/CSV", 
                      chr_col = "chr", start_col = "posStart", 
                      end_col = "posEnd", CN_col = "CN", 
                      samp_ID_col = "Sample_ID", sample_list = cohort, 
                      markers = SNP_markers, method_ID = "Q")

ipn <-  read_results(DT_path = system.file("extdata", 
                                           "chrs_14_22_cnvs_ipn.txt", 
                                           package = "CNVgears"), 
                     res_type = "file", DT_type = "TSV/CSV", 
                     chr_col = "chr", start_col = "posStart", 
                     end_col = "posEnd", CN_col = "CN", 
                     samp_ID_col = "Sample_ID", sample_list = cohort, 
                     markers = SNP_markers, method_ID = "I")

## ---- eval = FALSE------------------------------------------------------------
#  # raw data
#  # not run. This step needs the additional data
#  library("data.table", quietly = TRUE)
#  setDTthreads(4)
#  
#  read_finalreport_raw(DT_path = "PATH_TO_DOWNLOADED_DATA_DIRECTORY",
#                       pref = NA, suff = ".txt",
#                       rds_path = file.path("tmp_RDS"),
#                       markers = SNP_markers,
#                       sample_list = cohort[fam_ID == "1463", ])

## ---- eval= FALSE-------------------------------------------------------------
#  ## not run
#  library(cn.mops)
#  data(cn.mops)
#  resCNMOPS <- cn.mops(XRanges)
#  resCNMOPS <- calcIntegerCopyNumbers(resCNMOPS)
#  resCNMOPS_cnvs <- cnvs(resCNMOPS)
#  
#  sample_list <- read_metadt("path/to/PED_like_file")
#  intervals <- read_NGS_intervals("path/to/markers/file")
#  cnmops_calls <- cnmops_to_CNVresults(resCNMOPS_cnvs, sample_list, intervals)

## ----summary stats------------------------------------------------------------
sstatPenn <- summary(object = penn, sample_list = cohort,
                     markers = SNP_markers)

## ---- eval = FALSE------------------------------------------------------------
#  # not run
#  sstatPenn <- summary(object = penn, sample_list = cohort,
#                       markers = SNP_markers,
#                       plots_path = file.path("tmp","sstatPenn")) # plots are saved

## -----------------------------------------------------------------------------
head(sstatPenn)

## ----filtering----------------------------------------------------------------
penn_filtered <- cleaning_filter(results = penn, min_len = 10000, min_NP = 10)
quanti_filtered <- cleaning_filter(quanti)
ipn_filtered <- cleaning_filter(ipn)

## ----blacklists---------------------------------------------------------------
hg19telom <- telom_centrom(hg19_start_end_centromeres, centrom = FALSE)
hg19centrom <- telom_centrom(hg19_start_end_centromeres, telom = FALSE, 
                             region = 25000)

## ---- eval=FALSE--------------------------------------------------------------
#  ensembl37 <- biomaRt::useMart("ENSEMBL_MART_ENSEMBL",
#                                host = "grch37.ensembl.org",
#                                dataset="hsapiens_gene_ensembl")
#  hg19_immuno <- immuno_regions(n_genes = 10, mart = ensembl37)

## -----------------------------------------------------------------------------
head(hg19telom)

## ----inheritance, eval=FALSE--------------------------------------------------
#  # not run, needs the additional raw data
#  penn_inheritance <-
#    cnvs_inheritance(results = penn_filtered, sample_list =  cohort[fam_ID == "1463", ],
#                     markers = SNP_markers, raw_path = file.path("tmp_RDS"))
#  quanti_inheritance <-
#    cnvs_inheritance(results = quanti_filtered, sample_list =  cohort[fam_ID == "1463", ],
#                     markers = SNP_markers, raw_path = file.path("tmp_RDS"))
#  ipn_inheritance <-
#    cnvs_inheritance(results = ipn_filtered, sample_list =  cohort[fam_ID == "1463", ],
#                     markers = SNP_markers, raw_path = file.path("tmp_RDS"))
#  
#  penn_denovo <- penn_inheritance[inheritance == "denovo", ]
#  quanti_denovo <- quanti_inheritance[inheritance == "denovo", ]
#  ipn_denovo <- ipn_inheritance[inheritance == "denovo", ]

## ----inter merge, results="hide"----------------------------------------------
ipq_filtered <- 
  inter_res_merge(res_list = list(penn_filtered, quanti_filtered, ipn_filtered),
                  sample_list = cohort, chr_arms = hg19_chr_arms)

## ---- eval=FALSE--------------------------------------------------------------
#  # not run, it needs inheritance detection step
#  ipq_denovo <-
#    inter_res_merge(res_list = list(penn_denovo, quanti_denovo, ipn_denovo),
#                    sample_list = cohort, chr_arms = hg19_chr_arms)

## ----cnvrs, results="hide"----------------------------------------------------
cnvrs_chr22 <- cnvrs_create(cnvs = ipq_filtered[chr == 22,], 
                            chr_arms = hg19_chr_arms)

## -----------------------------------------------------------------------------
# define common CNVR as the one present in > 5% of the cohort 
# here the cohort is very small so it won't be a significative result
common_cnvrs_chr22 <- cnvrs_chr22[[1]][freq > nrow(cohort)*0.5, ]
rare_cvns_chr22 <- cnvrs_chr22[[2]][!cnvr %in% common_cnvrs_chr22$r_ID, ]

## ----denovo plot, eval=FALSE--------------------------------------------------
#  # not run, it needs inheritance detection step
#  lrr_trio_plot(cnv = ipq_denovo[1], raw_path =  file.path("tmp_RDS"),
#                sample_list = cohort, results = ipn_filtered)
#  lrr_trio_plot(cnv = ipq_denovo[2], raw_path =  file.path("tmp_RDS"),
#                sample_list = cohort, results = ipn_filtered)
#  lrr_trio_plot(cnv = ipq_denovo[3], raw_path =  file.path("tmp_RDS"),
#                sample_list = cohort, results = ipn_filtered)

## ----annotation, echo=c(-2,-4), eval = FALSE----------------------------------
#  # locus
#  ipq_denovo_locus <- genomic_locus(DT_in = ipq_filtered, keep_str_end = FALSE)
#  
#  # genes
#  ensembl37 <- biomaRt::useMart("ENSEMBL_MART_ENSEMBL",
#                                host = "grch37.ensembl.org",
#                                dataset="hsapiens_gene_ensembl")
#  
#  ipq_denovo_genes <- genic_load(DT_in = ipq_filtered, mart = ensembl37)
#  
#  rm(ensembl37)

## ---- eval=FALSE--------------------------------------------------------------
#  ## not run
#  
#  # Select a subset of columns using DT[, .(col1,col2,coln)]
#  tmp <- ipq_filtered[, .(sample_ID, chr, start, end, GT, meth_ID)]
#  head(tmp, 3)
#  
#  # Select a subset of rows (i.e. filter) using DT[condition, ]
#  tmp <- ipq_filtered[n_meth > 1, .(sample_ID, chr, start, end, GT, meth_ID)]
#  head(tmp, 3)
#  
#  # Export object as a TSV
#  fwrite(tmp, "example.tsv", sep = "\t")

## -----------------------------------------------------------------------------
tmp <- ipq_filtered[, .(chr, start, end, paste0(sample_ID, "-", GT))]
head(tmp)

## ---- eval=FALSE--------------------------------------------------------------
#  ## not run
#  fwrite(tmp, "example.bed", sep = "\t", col.names = FALSE)

## -----------------------------------------------------------------------------
ipq_filtered_GRanges <- CNVresults_to_GRanges(ipq_filtered)

## ---- eval=FALSE--------------------------------------------------------------
#  # only call with > 1 calling methods
#  tmp <- ipq_filtered[n_meth > 1, ]
#  
#  # de novo CNVs with a significant corrected p-value (note that the p-values are
#  # lost when combining more result-objects)
#  tmp <- penn_inheritance[adj_m_pval < 0.05 & adj_p_pval < 0.05, ]

