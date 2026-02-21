# Code example from 'Rarr' vignette. See references/ for full tutorial.

## ----local-examples, echo = TRUE, results = "hide"----------------------------
list.dirs(
  system.file("extdata", "zarr_examples", package = "Rarr"),
  recursive = TRUE
) |>
  grep(pattern = "zarr$", value = TRUE)

## ----installation, eval = FALSE-----------------------------------------------
# ## we need BiocManager to perform the installation
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# ## install Rarr
# BiocManager::install("Rarr")

## ----message=FALSE------------------------------------------------------------
library(Rarr)

## ----use-example--------------------------------------------------------------
zarr_example <- system.file(
  "extdata", "zarr_examples", "column-first", "int32.zarr",
  package = "Rarr"
)

## ----overview-1---------------------------------------------------------------
zarr_overview(zarr_example)

## -----------------------------------------------------------------------------
index <- list(1:4, 1:2, 1)

## ----extract-subset-----------------------------------------------------------
read_zarr_array(zarr_example, index = index)

## ----read-from-s3-shown, echo = TRUE, eval = FALSE----------------------------
# s3_address <- "https://uk1s3.embassy.ebi.ac.uk/idr/zarr/v0.4/idr0076A/10501752.zarr/0"
# zarr_overview(s3_address)

## ----read-from-s3, echo = FALSE, eval = TRUE----------------------------------
s3_address <- "https://uk1s3.embassy.ebi.ac.uk/idr/zarr/v0.4/idr0076A/10501752.zarr/0"
s3_client <- paws.storage::s3(config = list(
  credentials = list(anonymous = TRUE),
  region = "auto",
  endpoint = "https://uk1s3.embassy.ebi.ac.uk"))
zarr_overview(s3_address, s3_client = s3_client)

## ----get-slices-not-run, echo = TRUE, eval = FALSE----------------------------
# z2 <- read_zarr_array(s3_address, index = list(c(1, 10), NULL, NULL))

## ----get-slices, echo = FALSE, eval = TRUE------------------------------------
z2 <- read_zarr_array(s3_address, index = list(c(1, 10), NULL, NULL), s3_client = s3_client)

## ----plot-raster, echo = 2:9, cache = TRUE, out.width="30%", eval = TRUE------
par(mar = c(0, 0, 0, 0))
## plot the first slice in blue
image(log2(z2[1, , ]),
  col = hsv(h = 0.6, v = 1, s = 1, alpha = 0:100 / 100),
  asp = dim(z2)[2] / dim(z2)[3], axes = FALSE
)
## overlay the tenth slice in green
image(log2(z2[2, , ]),
  col = hsv(h = 0.3, v = 1, s = 1, alpha = 0:100 / 100),
  asp = dim(z2)[2] / dim(z2)[3], axes = FALSE, add = TRUE
)

## ----example-array------------------------------------------------------------
x <- array(1:600, dim = c(10, 10, 6))

## -----------------------------------------------------------------------------
path_to_new_zarr <- file.path(tempdir(), "new.zarr")
write_zarr_array(x = x, zarr_array_path = path_to_new_zarr, chunk_dim = c(10, 5, 1))

## ----check-written-array------------------------------------------------------
read_zarr_array(zarr_array_path = path_to_new_zarr, index = list(6:10, 10, 1))
identical(read_zarr_array(zarr_array_path = path_to_new_zarr), x)

## ----overview-2---------------------------------------------------------------
zarr_overview(zarr_example, as_data_frame = TRUE)

## ----s3-forbidden,  error=TRUE------------------------------------------------
try({
zarr_overview("https://s3.embl.de/rarr-testing/bzip2.zarr")
})

## ----eval = FALSE-------------------------------------------------------------
# Sys.setenv(
#   "AWS_ACCESS_KEY_ID" = "V352gmotks4ZyhfU",
#   "AWS_SECRET_ACCESS_KEY" = "2jveausI91c8P3c7OCRIOrxdLbp3LNW8"
# )
# zarr_overview("https://s3.embl.de/rarr-testing/bzip2.zarr")

## ----bad-s3, error = TRUE-----------------------------------------------------
try({
s3_address <- "https://uk1s3.embassy.ebi.ac.uk/idr/zarr/v0.4/idr0076A/10501752.zarr/0"
zarr_overview(s3_address)
})

## ----paws-s3-client, eval = TRUE, echo = TRUE---------------------------------
s3_client <- paws.storage::s3(
  config = list(
    credentials = list(anonymous = TRUE),
    region = "auto",
    endpoint = "https://uk1s3.embassy.ebi.ac.uk"
  )
)

## ----works-again, error = TRUE------------------------------------------------
try({
zarr_overview(s3_address, s3_client = s3_client)
})

## ----create-empty-array-------------------------------------------------------
path <- tempfile()
create_empty_zarr_array(
  zarr_array_path = path,
  dim = c(50, 20),
  chunk_dim = c(5, 10),
  data_type = "integer",
  fill_value = 7L
)

## ----check-empty-array--------------------------------------------------------
list.files(path, all.files = TRUE, no.. = TRUE)
table(read_zarr_array(path))

## ----update-array-------------------------------------------------------------
x <- 1:20
update_zarr_array(
  zarr_array_path = path,
  x = x,
  index = list(1, 1:20)
)

## ----check-update-------------------------------------------------------------
list.files(path, all.files = TRUE, no.. = TRUE)
read_zarr_array(path, index = list(1:2, 1:5))
table(read_zarr_array(path))

## ----loading-library, echo=FALSE----------------------------------------------
library(Rarr)

## ----use-example-2------------------------------------------------------------
zarr_example <- system.file(
  "extdata",
  "zarr_examples",
  "column-first",
  "int32.zarr",
  package = "Rarr"
)

## ----create-ZarrArray---------------------------------------------------------
zarr_array <- ZarrArray(zarr_example)

## ----show-ZarrArray-----------------------------------------------------------
zarr_array

## ----test-ZarrArray-----------------------------------------------------------
is(zarr_array)
dim(zarr_array)
chunkdim(zarr_array)

## -----------------------------------------------------------------------------
X <- matrix(rnorm(1000), ncol = 10)
zarr_path <- tempfile(fileext = ".zarr")
zarr_X <- writeZarrArray(X, zarr_array_path = zarr_path, chunk_dim = c(10, 10))
zarr_X

## ----session-info, echo = FALSE-----------------------------------------------
sessionInfo()

