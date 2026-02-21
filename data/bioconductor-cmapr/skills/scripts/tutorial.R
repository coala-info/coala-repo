# Code example from 'tutorial' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("cmapR")

## -----------------------------------------------------------------------------
library(cmapR)

## -----------------------------------------------------------------------------
ds

## -----------------------------------------------------------------------------
# access the data matrix
m <- mat(ds)

# access the row and column metadata
rdesc <- meta(ds, dimension = "row")
cdesc <- meta(ds, dimension = "column")

# access the row and column ids
rid <- ids(ds, dimension = "row")
cid <- ids(ds, dimension = "column")

## -----------------------------------------------------------------------------
# update the matrix data to set some values to zero
# note that the updated matrix must be the of the same dimensions as 
# the current matrix
m[1:10, 1:10] <- 0
mat(ds) <- m

# replace row and column metadata
meta(ds, dimension = "row") <- data.frame(x=sample(letters, nrow(m),
                                                   replace=TRUE))
meta(ds, dimension = "column") <- data.frame(x=sample(letters, ncol(m),
                                                   replace=TRUE))

# replace row and column ids
ids(ds, dimension = "row") <- as.character(seq_len(nrow(m)))
ids(ds, dimension = "column") <- as.character(seq_len(ncol(m)))

# and let's look at the modified object
ds

## -----------------------------------------------------------------------------
# create a variable to store the path to the GCTX file
# here we'll use a file that's internal to the cmapR package, but
# in practice this could be any valid path to a GCT or GCTX file
ds_path <- system.file("extdata", "modzs_n25x50.gctx", package="cmapR")
my_ds <- parse_gctx(ds_path)

## -----------------------------------------------------------------------------
my_ds

## -----------------------------------------------------------------------------
# read just the first 10 columns, using numeric indices
(my_ds_10_columns <- parse_gctx(ds_path, cid=1:10))

## -----------------------------------------------------------------------------
# read the column metadata
col_meta <- read_gctx_meta(ds_path, dim="col")

# figure out which signatures correspond to vorinostat by searching the 'pert_iname' column
idx <- which(col_meta$pert_iname=="vemurafenib")

# read only those columns from the GCTX file by using the 'cid' parameter
vemurafenib_ds <- parse_gctx(ds_path, cid=idx)

## -----------------------------------------------------------------------------
# get a vector of character ids, using the id column in col_meta
col_ids <- col_meta$id[idx]
vemurafenib_ds2 <- parse_gctx(ds_path, cid=col_ids)
identical(vemurafenib_ds, vemurafenib_ds2)

## -----------------------------------------------------------------------------
# initialize a matrix object
# note that you either must assign values to the rownames and colnames
# of the matrix, or pass them,
# as the 'rid' and 'cid' arguments to GCT"
m <- matrix(stats::rnorm(100), ncol=10)
rownames(m) <- letters[1:10]
colnames(m) <- LETTERS[1:10]
(my_new_ds <- new("GCT", mat=m))

## -----------------------------------------------------------------------------
# we can also include the row/column annotations as data.frames
# note these are just arbitrary annotations used to illustrate the function call
rdesc <- data.frame(id=letters[1:10], type=rep(c(1, 2), each=5))
cdesc <- data.frame(id=LETTERS[1:10], type=rep(c(3, 4), each=5))
(my_new_ds <- new("GCT", mat=m, rdesc=rdesc, cdesc=cdesc))

## -----------------------------------------------------------------------------
# we'll use the matrix_only argument to extract just the matrix
(my_ds_no_meta <- parse_gctx(ds_path, matrix_only = TRUE))

## -----------------------------------------------------------------------------
# note we need to specifiy which dimension to annotate (dim)
# and which column in the annotations corresponds to the column
# ids in the matrix (keyfield)
(my_ds_no_meta <- annotate_gct(my_ds_no_meta, col_meta, dim="col",
                               keyfield="id"))

## -----------------------------------------------------------------------------
# in memory slice using the cid parameter
vemurafenib_ds3 <- subset_gct(my_ds,
                             cid=which(col_meta$pert_iname=="vemurafenib"))
identical(vemurafenib_ds, vemurafenib_ds3)

## -----------------------------------------------------------------------------
# melt to long form
vemurafenib_ds3_melted <- melt_gct(vemurafenib_ds3)

## -----------------------------------------------------------------------------
# plot the matrix values grouped by gene
grps <- with(vemurafenib_ds3_melted, split(value, pr_gene_symbol))
boxplot(grps)

## -----------------------------------------------------------------------------
# extract the data matrix from the my_ds object
m <- mat(my_ds)

## -----------------------------------------------------------------------------
# compute the row and column means
row_means <- rowMeans(m)
col_means <- colMeans(m)
message("means:")
head(row_means)
head(col_means)

# using 'apply', compute the max of each row and column
row_max <- apply(m, 1, max)
col_max <- apply(m, 2, max)
message("maxes:")
head(row_max)
head(col_max)

## -----------------------------------------------------------------------------
# transposing a GCT object - also swaps row and column annotations
(my_ds_transpose <- transpose_gct(my_ds))

# converting a GCT object's matrix to ranks
# the 'dim' option controls the direction along which the ranks are calculated
my_ds_rank_by_column <- rank_gct(my_ds, dim="col")

# plot z-score vs rank for the first 25 genes (rows)
ranked_m <- mat(my_ds_rank_by_column)
plot(ranked_m[1:25, ],
     m[1:25, ],
     xlab="rank",
     ylab="differential expression score",
     main="score vs. rank")

## -----------------------------------------------------------------------------
# write 'my_ds' in both GCT and GCTX format
write_gct(my_ds, "my_ds")
write_gctx(my_ds, "my_ds")

# write_gctx can also compress the dataset upon write,
# which can be controlled using the 'compression_level' option.
# the higher the value, the greater the compression, but the
# longer the read/write time
write_gctx(my_ds, "my_ds_compressed", compression_level = 9)

## -----------------------------------------------------------------------------
# ds is an object of class GCT
(se <- as(ds, "SummarizedExperiment"))

## -----------------------------------------------------------------------------
sessionInfo()

