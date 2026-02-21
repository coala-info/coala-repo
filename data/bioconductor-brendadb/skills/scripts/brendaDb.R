# Code example from 'brendaDb' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
collapse = TRUE,
comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("brendaDb", dependencies=TRUE)

## ----setup, message=FALSE-----------------------------------------------------
if(!requireNamespace("brendaDb")) {
  devtools::install_github("y1zhou/brendaDb")
}

## -----------------------------------------------------------------------------
library(brendaDb)

## ----eval=FALSE---------------------------------------------------------------
# brenda.filepath <- DownloadBrenda()
# #> Please read the license agreement in the link below.
# #>
# #> https://www.brenda-enzymes.org/download_brenda_without_registration.php
# #>
# #> Found zip file in cache.
# #> Extracting zip file...

## ----eval=FALSE---------------------------------------------------------------
# df <- ReadBrenda(brenda.filepath)
# #> Reading BRENDA text file...
# #> Converting text into a list. This might take a while...
# #> Converting list to tibble and removing duplicated entries...
# #> If you're going to use this data again, consider saving this table using data.table::fwrite().

## -----------------------------------------------------------------------------
brenda_txt <- system.file("extdata", "brenda_download_test.txt",
                          package = "brendaDb")
df <- ReadBrenda(brenda_txt)
res <- QueryBrenda(df, EC = c("1.1.1.1", "6.3.5.8"), n.core = 2)

res

res[["1.1.1.1"]]

## -----------------------------------------------------------------------------
ShowFields(df)

res <- QueryBrenda(df, EC = "1.1.1.1", fields = c("PROTEIN", "SUBSTRATE_PRODUCT"))
res[["1.1.1.1"]][["interactions"]][["substrate.product"]]

## -----------------------------------------------------------------------------
res <- QueryBrenda(df, EC = "1.1.1.1", organisms = "Homo sapiens")
res$`1.1.1.1`

## -----------------------------------------------------------------------------
res <- QueryBrenda(df, EC = c("1.1.1.1", "6.3.5.8"), n.core = 2)
ExtractField(res, field = "parameters$ph.optimum")

## -----------------------------------------------------------------------------
ID2Enzyme(brenda = df, ids = c("ADH4", "CD38", "pyruvate dehydrogenase"))

## ----eval=FALSE---------------------------------------------------------------
# EC.numbers <- head(unique(df$ID), 100)
# system.time(QueryBrenda(df, EC = EC.numbers, n.core = 0))  # default
# #  user  system elapsed
# # 4.528   7.856  34.567
# system.time(QueryBrenda(df, EC = EC.numbers, n.core = 1))
# #  user  system elapsed
# # 22.080   0.360  22.438
# system.time(QueryBrenda(df, EC = EC.numbers, n.core = 2))
# #  user  system elapsed
# # 0.552   0.400  13.597
# system.time(QueryBrenda(df, EC = EC.numbers, n.core = 4))
# #  user  system elapsed
# # 0.688   0.832   9.517
# system.time(QueryBrenda(df, EC = EC.numbers, n.core = 8))
# #  user  system elapsed
# # 1.112   1.476  10.000

## -----------------------------------------------------------------------------
sessionInfo()

