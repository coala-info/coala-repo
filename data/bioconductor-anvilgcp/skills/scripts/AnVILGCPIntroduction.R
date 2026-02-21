# Code example from 'AnVILGCPIntroduction' vignette. See references/ for full tutorial.

## ----setup, include=FALSE------------------------------------------------
has_gcloud <- AnVILBase::has_avworkspace(
    strict = TRUE, platform = AnVILGCP::gcp()
)
knitr::opts_chunk$set(
    eval = has_gcloud, collapse = TRUE, cache = TRUE
)
options(width = 75)

## ----eval = FALSE--------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("AnVILGCP")

## ----message =FALSE, eval = TRUE, cache = FALSE--------------------------
library(AnVILGCP)

## ----eval = FALSE--------------------------------------------------------
# add_libpaths("~/my/project")

## ----eval = FALSE--------------------------------------------------------
# dir(file.path(Sys.getenv("GCLOUD_SDK_PATH"), "bin"), "^(gcloud|gsutil)$")
# ## [1] "gcloud" "gsutil"

## ----eval = TRUE---------------------------------------------------------
## the code chunks in this vignette are fully evaluated when
## gcloud_exists() returns TRUE
gcloud_exists()

## ----eval=has_gcloud-----------------------------------------------------
# gcloud_account() # authentication account
# gcloud_project() # billing project information

## ----eval = FALSE--------------------------------------------------------
# gcloud_cmd("projects", "list") |>
#     readr::read_table() |>
#     filter(startsWith(PROJECT_ID, "anvil"))

## ----eval = FALSE--------------------------------------------------------
# gcloud_help("projects")

## ----eval=has_gcloud-----------------------------------------------------
# src <- "gs://genomics-public-data/1000-genomes/"

## ----eval=has_gcloud-----------------------------------------------------
# avlist(src)
# 
# other <- paste0(src, "other")
# avlist(other, recursive = TRUE)
# 
# sample_info <- paste0(src, "other/sample_info/sample_info.csv")
# gsutil_stat(sample_info)

## ----eval=has_gcloud-----------------------------------------------------
# fl <- tempfile()
# avcopy(sample_info, fl)
# 
# csv <- readr::read_csv(fl, guess_max = 5000L, col_types = readr::cols())
# csv

## ----eval=has_gcloud-----------------------------------------------------
# pipe <- gsutil_pipe(fl, "rb")
# readr::read_csv(pipe, guess_max = 5000L, col_types = readr::cols()) |>
#     dplyr::select("Sample", "Family_ID", "Population", "Gender")

## ----eval=has_gcloud-----------------------------------------------------
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
# knitr::include_graphics('AnVIL-Workspace-Data.png')

## ----include=FALSE, cache=FALSE, eval=has_gcloud-------------------------
# avworkspace_namespace("pathogen-genomic-surveillance")
# avworkspace_name("COVID-19")

## ----eval=has_gcloud-----------------------------------------------------
# avworkspace_namespace()
# avworkspace_name()

## ----eval=FALSE----------------------------------------------------------
# ## N.B.: IT MAY NOT BE NECESSARY TO SET THESE WHEN ON ANVIL
# avworkspace_namespace("pathogen-genomic-surveillance")
# avworkspace_name("COVID-19")

## ----eval=has_gcloud-----------------------------------------------------
# avtables()
# sample <- avtable("sample_set")
# sample

## ----eval=has_gcloud-----------------------------------------------------
# sample |>
#     dplyr::select("sample_set_id", contains("fasta")) |>
#     dplyr::filter(!is.na("Successful_Assembly_group"))

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
# ##   |======================================================================| 100%
# ## # A tibble: 4 × 5
# ##    page from_row to_row job_id                               status
# ##   <int>    <int>  <int> <chr>                                <chr>
# ## 1     1        1     10 a32e9706-f63c-49ed-9620-b214746b9392 Uploaded
# ## 2     2       11     20 f2910ac2-0954-4fb9-b36c-970845a266b7 Uploaded
# ## 3     3       21     30 e18adc5b-d26f-4a8a-a0d7-a232e17ac8d2 Uploaded
# ## 4     4       31     32 d14efb89-e2dd-4937-b80a-169520b5f563 Uploaded
# (job_status <- avtable_import_status(job_status))
# ## checking status of 4 avtable import jobs
# ##   |======================================================================| 100%
# ## # A tibble: 4 × 5
# ##    page from_row to_row job_id                               status
# ##   <int>    <int>  <int> <chr>                                <chr>
# ## 1     1        1     10 a32e9706-f63c-49ed-9620-b214746b9392 Done
# ## 2     2       11     20 f2910ac2-0954-4fb9-b36c-970845a266b7 Done
# ## 3     3       21     30 e18adc5b-d26f-4a8a-a0d7-a232e17ac8d2 ReadyForUpsert
# ## 4     4       31     32 d14efb89-e2dd-4937-b80a-169520b5f563 ReadyForUpsert
# (job_status <- avtable_import_status(job_status))
# ## checking status of 4 avtable import jobs
# ##   |======================================================================| 100%
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
#     avtable("sample") |>                               # existing table
#     mutate(set = sample(head(LETTERS), nrow(.), TRUE))  # arbitrary groups
# sample |>                                   # new 'participant_set' table
#     avtable_import_set("participant", "set", "participant")
# sample |>                                   # new 'sample_set' table
#     avtable_import_set("sample", "set", "name")

## ----eval=has_gcloud-----------------------------------------------------
# avdata()

## ----eval=has_gcloud-----------------------------------------------------
# bucket <- avstorage()
# bucket

## ----eval=FALSE----------------------------------------------------------
# avlist()

## ----eval = FALSE--------------------------------------------------------
# ## requires workspace ownership
# uri <- avstorage()                             # discover bucket
# bucket <- file.path(uri, "mtcars.tab")
# write.table(mtcars, gsutil_pipe(bucket, "w")) # write to bucket

## ----eval = FALSE--------------------------------------------------------
# ## backup all files and folders in the current working directory
# avbackup(getwd(), recursive = TRUE)
# 
# ## backup all files in the current directory
# avbackup(dir())
# 
# ## backup all files to gs://<avstorage()>/scratch/
# avbackup(dir, paste0(avstorage(), "/scratch"))

## ----eval=TRUE-----------------------------------------------------------
sessionInfo()

