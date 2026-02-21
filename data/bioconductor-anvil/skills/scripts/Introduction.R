# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----include = FALSE-----------------------------------------------------
has_gcloud <- AnVILBase::has_avworkspace(
    strict = TRUE, platform = AnVILGCP::gcp()
)
knitr::opts_chunk$set(
    eval = has_gcloud, collapse = TRUE, cache = TRUE
)
options(width=75)

## ----eval = FALSE--------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager", repos = "https://cran.r-project.org")
# BiocManager::install("AnVIL")

## ----message =FALSE, eval = TRUE, cache = FALSE--------------------------
library(AnVILGCP)
library(AnVIL)

## ----eval = FALSE--------------------------------------------------------
# dir(file.path(Sys.getenv("GCLOUD_SDK_PATH"), "bin"), "^(gcloud|gsutil)$")
# ## [1] "gcloud" "gsutil"

## ----eval = TRUE---------------------------------------------------------
## the code chunks in this vignette are fully evaluated when
## gcloud_exists() returns TRUE
GCPtools::gcloud_exists()

## ----eval = FALSE--------------------------------------------------------
# BiocManager::install("GenomicFeatures")

## ----eval = FALSE--------------------------------------------------------
# add_libpaths("~/my/project")

## ----eval = has_gcloud---------------------------------------------------
# gcloud_account() # authentication account
# gcloud_project() # billing project information

## ----eval = has_gcloud---------------------------------------------------
# gcloud_cmd("projects", "list") %>%
#     readr::read_table() %>%
#     filter(startsWith(PROJECT_ID, "anvil"))

## ----eval = FALSE--------------------------------------------------------
# gcloud_help("projects")

## ------------------------------------------------------------------------
# src <- "gs://genomics-public-data/1000-genomes/"

## ----eval = has_gcloud---------------------------------------------------
# gsutil_ls(src)
# 
# other <- paste0(src, "other")
# gsutil_ls(other, recursive = TRUE)
# 
# sample_info <- paste0(src, "other/sample_info/sample_info.csv")
# gsutil_stat(sample_info)

## ----eval = has_gcloud---------------------------------------------------
# fl <- tempfile()
# gsutil_cp(sample_info, fl)
# 
# csv <- readr::read_csv(fl, guess_max = 5000L, col_types = readr::cols())
# csv

## ----eval = has_gcloud---------------------------------------------------
# pipe <- gsutil_pipe(fl, "rb")
# readr::read_csv(pipe, guess_max = 5000L, col_types = readr::cols()) %>%
#     dplyr::select("Sample", "Family_ID", "Population", "Gender")

## ----eval = has_gcloud---------------------------------------------------
# destination <- tempfile()
# stopifnot(dir.create(destination))
# source <- paste0(src, "other/sample_info")
# 
# ## dry run
# gsutil_rsync(source, destination)
# 
# gsutil_rsync(source, destination, dry = FALSE)
# dir(destination, recursive = TRUE)
# 
# ## nothing to synchronize
# gsutil_rsync(source, destination, dry = FALSE)
# 
# ## one file requires synchronization
# unlink(file.path(destination, "README"))
# gsutil_rsync(source, destination, dry = FALSE)

## ----echo = FALSE, cache = FALSE-----------------------------------------
# knitr::include_graphics('images/AnVIL-Workspace-Data.png')

## ----include = FALSE, cache = FALSE, eval = has_gcloud-------------------
# avworkspace_namespace("pathogen-genomic-surveillance")
# avworkspace_name("COVID-19")

## ----eval = has_gcloud---------------------------------------------------
# avworkspace_namespace()
# avworkspace_name()

## ----eval = has_gcloud---------------------------------------------------
# ## N.B.: IT MAY NOT BE NECESSARY TO SET THESE WHEN ON ANVIL
# avworkspace_namespace("pathogen-genomic-surveillance")
# avworkspace_name("COVID-19")

## ----eval = has_gcloud---------------------------------------------------
# avtables()
# sample <- avtable("sample")
# sample

## ----eval = has_gcloud---------------------------------------------------
# sample %>%
#     select("sample_id", contains("fasta")) %>%
#     filter(!is.na(final_assembly_fasta))

## ----eval = FALSE--------------------------------------------------------
# my_cars <-
#     mtcars |>
#     as_tibble(rownames = "model") |>
#     mutate(model = gsub(" ", "_", model))
# job_status <- avtable_import(my_cars)

## ----eval = FALSE--------------------------------------------------------
# avtable_import_status(job_status)

## ----eval = FALSE--------------------------------------------------------
# (job_status <- avtable_import(my_cars, pageSize = 10))
# ## pageSize = 10 rows (4 pages)
# ##   |===================================================================| 100%
# ## # A tibble: 4 × 5
# ##    page from_row to_row job_id                               status
# ##   <int>    <int>  <int> <chr>                                <chr>
# ## 1     1        1     10 a32e9706-f63c-49ed-9620-b214746b9392 Uploaded
# ## 2     2       11     20 f2910ac2-0954-4fb9-b36c-970845a266b7 Uploaded
# ## 3     3       21     30 e18adc5b-d26f-4a8a-a0d7-a232e17ac8d2 Uploaded
# ## 4     4       31     32 d14efb89-e2dd-4937-b80a-169520b5f563 Uploaded
# (job_status <- avtable_import_status(job_status))
# ## checking status of 4 avtable import jobs
# ##   |===================================================================| 100%
# ## # A tibble: 4 × 5
# ##    page from_row to_row job_id                               status
# ##   <int>    <int>  <int> <chr>                                <chr>
# ## 1     1        1     10 a32e9706-f63c-49ed-9620-b214746b9392 Done
# ## 2     2       11     20 f2910ac2-0954-4fb9-b36c-970845a266b7 Done
# ## 3     3       21     30 e18adc5b-d26f-4a8a-a0d7-a232e17ac8d2 ReadyForUpsert
# ## 4     4       31     32 d14efb89-e2dd-4937-b80a-169520b5f563 ReadyForUpsert
# (job_status <- avtable_import_status(job_status))
# ## checking status of 4 avtable import jobs
# ##   |===================================================================| 100%
# ## # A tibble: 4 × 5
# ##    page from_row to_row job_id                               status
# ##   <int>    <int>  <int> <chr>                                <chr>
# ## 1     1        1     10 a32e9706-f63c-49ed-9620-b214746b9392 Done
# ## 2     2       11     20 f2910ac2-0954-4fb9-b36c-970845a266b7 Done
# ## 3     3       21     30 e18adc5b-d26f-4a8a-a0d7-a232e17ac8d2 Done
# ## 4     4       31     32 d14efb89-e2dd-4937-b80a-169520b5f563 Done

## ----eval = FALSE--------------------------------------------------------
# ## editable copy of '1000G-high-coverage-2019' workspace
# avworkspace("anvil-datastorage/1000G-high-coverage-2019")
# sample <-
#     avtable("sample") %>%                               # existing table
#     mutate(set = sample(head(LETTERS), nrow(.), TRUE))  # arbitrary groups
# sample %>%                                   # new 'participant_set' table
#     avtable_import_set("participant", "set", "participant")
# sample %>%                                   # new 'sample_set' table
#     avtable_import_set("sample", "set", "name")

## ----eval = has_gcloud---------------------------------------------------
# avdata()

## ----eval = has_gcloud---------------------------------------------------
# bucket <- avbucket()
# bucket

## ----eval = has_gcloud---------------------------------------------------
# avfiles_ls()

## ----eval = FALSE--------------------------------------------------------
# ## requires workspace ownership
# uri <- avbucket()                             # discover bucket
# bucket <- file.path(uri, "mtcars.tab")
# write.table(mtcars, gsutil_pipe(bucket, "w")) # write to bucket

## ----eval = FALSE--------------------------------------------------------
# ## backup all files and folders in the current working directory
# avfiles_backup(getwd(), recursive = TRUE)
# 
# ## backup all files in the current directory
# avfiles_backup(dir())
# 
# ## backup all files to gs://<avbucket()>/scratch/
# avfiles_backup(dir, paste0(avbucket(), "/scratch"))

## ----eval = has_gcloud---------------------------------------------------
# uri <- c(
#     vcf = "drs://dg.ANV0/6f633518-f2de-4460-aaa4-a27ee6138ab5",
#     tbi = "drs://dg.ANV0/4fb9e77f-c92a-4deb-ac90-db007dc633aa"
# )

## ----eval = FALSE--------------------------------------------------------
# tbl <- drs_stat(uri)
# ## # A tibble: 2 × 9
# ##   drs      fileName   size gsUri accessUrl timeUpdated hashes       bucket name
# ##   <chr>    <chr>     <dbl> <chr> <chr>     <chr>       <list>       <chr>  <chr>
# ## 1 drs://d… NA21144… 7.06e9 gs:/… NA        2020-07-08… <named list> fc-56… CCDG…
# ## 2 drs://d… NA21144… 4.08e6 gs:/… NA        2020-07-08… <named list> fc-56… CCDG…

## ----eval = FALSE--------------------------------------------------------
# drs_cp(uri, "/tmp")     # local temporary directory
# drs_cp(uri, avbucket()) # workspace bucket

## ----eval = FALSE--------------------------------------------------------
# suppressPackageStartupMessages({
#     library(VariantAnnotation)
# })
# https <- drs_access_url(uri)
# vcffile <- VcfFile(https[["vcf"]], https[["tbi"]])
# scanVcfHeader(vcffile)
# ## class: VCFHeader
# ## samples(1): NA21144
# ## meta(3): fileformat reference contig
# ## fixed(2): FILTER ALT
# ## info(16): BaseQRankSum ClippingRankSum ... ReadPosRankSum VariantType
# ## geno(11): GT AB ... PL SB
# 
# variants <- readVcf(vcffile, param = GRanges("chr1:1-1000000"))
# nrow(variants)
# ## [1] 123077

## ----eval = has_gcloud---------------------------------------------------
# terra <- Terra()

## ----eval = has_gcloud---------------------------------------------------
# terra

## ----eval = has_gcloud---------------------------------------------------
# terra %>% tags("Status")

## ----eval = has_gcloud---------------------------------------------------
# terra$status
# terra$status()

## ----eval = has_gcloud---------------------------------------------------
# args(terra$createBillingProjectFull)

## ----eval = has_gcloud---------------------------------------------------
# args(terra$overwriteWorkspaceMethodConfig)

## ----eval = has_gcloud---------------------------------------------------
# status <- terra$status()
# class(status)

## ----eval = has_gcloud---------------------------------------------------
# str(status)

## ----eval = has_gcloud---------------------------------------------------
# lst <- status %>% as.list()
# lengths(lst)
# lengths(lst$systems)
# str(lst$systems)

## ------------------------------------------------------------------------
# .MyService <- setClass("MyService", contains = "Service")
# 
# MyService <-
#     function()
# {
#     .MyService(Service(
#         "myservice",
#         host = "api.firecloud.org",
#         api_url = "https://api.firecloud.org/api-docs.yaml",
#         authenticate = FALSE
#     ))
# }

## ----sessionInfo, echo=FALSE---------------------------------------------
# sessionInfo()

