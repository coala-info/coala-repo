# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(GCSConnection)

## -----------------------------------------------------------------------------
gcs_get_cloud_auth()

## -----------------------------------------------------------------------------
file <- "gs://genomics-public-data/NA12878.chr20.sample.DeepVariant-0.7.2.vcf"
con <- gcs_connection(description = file, open = "r")
readLines(con, n = 2L)
close(con)

## -----------------------------------------------------------------------------
file_name <- "NA12878.chr20.sample.DeepVariant-0.7.2.vcf"
bucket_name <- "genomics-public-data"
con <- gcs_connection(
    description = file_name, open = "r", bucket = bucket_name
)
readLines(con, n = 2L)
close(con)

## -----------------------------------------------------------------------------
## These are equivalent
## x <- gcs_dir("gs://genomics-public-data/clinvar/")
## x <- gcs_dir("genomics-public-data/clinvar/")

x <- gcs_dir("gs://genomics-public-data/clinvar/")
x

## -----------------------------------------------------------------------------
## equivalent: x$README.txt
myfile <- x[["README.txt"]]
myfile

## -----------------------------------------------------------------------------
## equivalent: x$`..`
x[[".."]]
myfile[[".."]]

## -----------------------------------------------------------------------------
con <- myfile$get_connection(open = "r")
con
close(con)

## -----------------------------------------------------------------------------
## Get file name
myfile$file_name

## copy file
## For the destination, you can specify a path to the file, 
## or a path to a folder.
destination <-tempdir()
myfile$copy_to(destination)
file.exists(file.path(destination,myfile$file_name))

## Delete file, the function is excutable 
## only when you have the right to delete the file.
## Use `quiet = TRUE` to suppress the confirmation before deleting the file.
# x$README.txt$delete(quiet = FALSE)

## -----------------------------------------------------------------------------
gcs_get_read_buff()
gcs_get_write_buff()

