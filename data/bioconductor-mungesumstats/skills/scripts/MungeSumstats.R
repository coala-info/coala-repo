# Code example from 'MungeSumstats' vignette. See references/ for full tutorial.

## ----setup--------------------------------------------------------------------
library(MungeSumstats)

## ----eval=FALSE, message=TRUE-------------------------------------------------
# eduAttainOkbayPth <- system.file("extdata","eduAttainOkbay.txt",
#                                   package="MungeSumstats")
# reformatted <-
#   MungeSumstats::format_sumstats(path=eduAttainOkbayPth,
#                                  ref_genome="GRCh37")

## ----echo=FALSE---------------------------------------------------------------
#don't run time intensive checks
eduAttainOkbayPth <- system.file("extdata","eduAttainOkbay.txt",
                                  package="MungeSumstats")
reformatted <- 
  MungeSumstats::format_sumstats(path=eduAttainOkbayPth,
                                 on_ref_genome = FALSE,
                                 strand_ambig_filter = FALSE,
                                 bi_allelic_filter = FALSE,
                                 allele_flip_check = FALSE,
                                 ref_genome="GRCh37")

## ----message=TRUE-------------------------------------------------------------
#save ALS GWAS from the ieu open GWAS project to a temp directory
ALSvcfPth <- system.file("extdata","ALSvcf.vcf", package="MungeSumstats")

## ----eval=FALSE---------------------------------------------------------------
# reformatted_vcf <-
#   MungeSumstats::format_sumstats(path=ALSvcfPth,
#                                  ref_genome="GRCh37")

## ----eval=FALSE, message=FALSE------------------------------------------------
# #set
# reformatted_vcf_2 <-
#   MungeSumstats::format_sumstats(path=ALSvcfPth,
#                                  ref_genome="GRCh37",
#                                  log_folder_ind=TRUE,
#                                  imputation_ind=TRUE,
#                                  log_mungesumstats_msgs=TRUE)

## ----echo=FALSE,message=FALSE-------------------------------------------------
#don't run time intensive checks
reformatted_vcf_2 <- 
  MungeSumstats::format_sumstats(path=ALSvcfPth,
                                 ref_genome="GRCh37",
                                 log_folder_ind=TRUE,
                                 imputation_ind=TRUE,
                                 log_mungesumstats_msgs=TRUE,
                                 on_ref_genome = FALSE,
                                 strand_ambig_filter = FALSE,
                                 bi_allelic_filter = FALSE,
                                 allele_flip_check = FALSE)

## ----message=TRUE-------------------------------------------------------------
names(reformatted_vcf_2)

## ----message=TRUE-------------------------------------------------------------
print(reformatted_vcf_2$log_files$snp_bi_allelic)

## ----message=FALSE,eval=FALSE-------------------------------------------------
# #set
# reformatted_vcf_2 <-
#   MungeSumstats::format_sumstats(path=ALSvcfPth,
#                                  ref_genome="GRCh37",
#                                  log_folder_ind=TRUE,
#                                  imputation_ind=TRUE,
#                                  log_mungesumstats_msgs=TRUE,
#                                  return_data=TRUE,
#                                  return_format="GRanges")

## ----message=FALSE,eval=FALSE-------------------------------------------------
# #set
# reformatted_vcf_2 <-
#   MungeSumstats::format_sumstats(path=ALSvcfPth,
#                                  ref_genome="GRCh37",
#                                  write_vcf=TRUE,
#                                  save_format ="openGWAS")

## ----message=FALSE,eval=FALSE-------------------------------------------------
# # Pass path to Educational Attainment Okbay sumstat file to a temp directory
# eduAttainOkbayPth <- system.file("extdata", "eduAttainOkbay.txt",
#                                   package = "MungeSumstats")
# ALSvcfPth <- system.file("extdata","ALSvcf.vcf", package="MungeSumstats")
# sumstats_list <- list(ss1 = eduAttainOkbayPth, ss2 = ALSvcfPth)
# 
# ref_genomes <- MungeSumstats::get_genome_builds(sumstats_list = sumstats_list)
# 

## -----------------------------------------------------------------------------
sumstats_dt <- MungeSumstats::formatted_example()
sumstats_dt_hg38 <- MungeSumstats::liftover(sumstats_dt = sumstats_dt, 
                                            ref_genome = "hg19",
                                            convert_ref_genome = "hg38")
knitr::kable(head(sumstats_dt_hg38))

## -----------------------------------------------------------------------------
eduAttainOkbayPth <- system.file("extdata", "eduAttainOkbay.txt",
                                  package = "MungeSumstats")
formatted_path <- tempfile(fileext = "_eduAttainOkbay_standardised.tsv.gz")


#### 1. Read in the data and standardise header names ####
dat <- MungeSumstats::read_sumstats(path = eduAttainOkbayPth, 
                                    standardise_headers = TRUE)
knitr::kable(head(dat))
#### 2. Write to disk as a compressed, tab-delimited, tabix-indexed file ####
formatted_path <- MungeSumstats::write_sumstats(sumstats_dt = dat,
                                                save_path = formatted_path,
                                                tabix_index = TRUE,
                                                write_vcf = FALSE,
                                                return_path = TRUE)   

## -----------------------------------------------------------------------------
#### Mess up some column names ####
dat_raw <- data.table::copy(dat)
data.table::setnames(dat_raw, c("SNP","CHR"), c("rsID","Seqnames"))
#### Add a non-standard column that I want to keep the casing for ####
dat_raw$Support <- runif(nrow(dat_raw))

dat2 <- MungeSumstats::standardise_header(sumstats_dt = dat_raw,
                                          uppercase_unmapped = FALSE, 
                                          return_list = FALSE )
knitr::kable(head(dat2))

## ----message=TRUE, echo=FALSE-------------------------------------------------
utils::sessionInfo()

