# Code example from 'HDF5Array_performance' vignette. See references/ for full tutorial.

## ----install, eval=FALSE------------------------------------------------------
# if (!require("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# 
# pkgs <- c("HDF5Array", "ExperimentHub", "DelayedMatrixStats", "RSpectra")
# BiocManager::install(pkgs)

## ----load, message=FALSE------------------------------------------------------
library(HDF5Array)
library(ExperimentHub)
library(DelayedMatrixStats)
library(RSpectra)

## ----source_make_timings_table_R, echo=FALSE, results='hide'------------------
## Needed for the make_timings_table() function.
path <- system.file(package="HDF5Array",
                    "scripts", "make_timings_table.R", mustWork=TRUE)
source(path, verbose=FALSE)

## ----ExperimentHub------------------------------------------------------------
hub <- ExperimentHub()
hub["EH1039"]$description  # sparse representation
hub["EH1040"]$description  # dense representation

## ----get_EH1039_and_EH1040, message=FALSE-------------------------------------
## Note that this will be quick if the HDF5 files are already in the
## local ExperimentHub cache. Otherwise, it will take a while!
brain_s_path <- hub[["EH1039"]]
brain_D_path <- hub[["EH1040"]]

## ----brain_s------------------------------------------------------------------
## Use 'h5ls(brain_s_path)' to find out the group.
brain_s <- TENxMatrix(brain_s_path, group="mm10")

## ----brain_s_class_and_dim----------------------------------------------------
class(brain_s)
dim(brain_s)
is_sparse(brain_s)

## ----brain_D------------------------------------------------------------------
## Use 'h5ls(brain_D_path)' to find out the name of the dataset.
brain_D <- HDF5Array(brain_D_path, name="counts")

## ----brain_D_class_and_dim----------------------------------------------------
class(brain_D)
dim(brain_D)
chunkdim(brain_D)
is_sparse(brain_D)

## ----brain_Ds-----------------------------------------------------------------
brain_Ds <- HDF5Array(brain_D_path, name="counts", as.sparse=TRUE)

## ----brain_Ds_class_and_dim---------------------------------------------------
class(brain_Ds)
dim(brain_Ds)
chunkdim(brain_Ds)
is_sparse(brain_Ds)

## ----set_brain_D_and_brain_Ds_dimnames----------------------------------------
dimnames(brain_Ds) <- dimnames(brain_D) <- dimnames(brain_s)

## ----create_test_datasets-----------------------------------------------------
brain1_s  <- brain_s[  , 1:12500]
brain1_D  <- brain_D[  , 1:12500]
brain1_Ds <- brain_Ds[ , 1:12500]

brain2_s  <- brain_s[  , 1:25000]
brain2_D  <- brain_D[  , 1:25000]
brain2_Ds <- brain_Ds[ , 1:25000]

brain3_s  <- brain_s[  , 1:50000]
brain3_D  <- brain_D[  , 1:50000]
brain3_Ds <- brain_Ds[ , 1:50000]

brain4_s  <- brain_s[  , 1:100000]
brain4_D  <- brain_D[  , 1:100000]
brain4_Ds <- brain_Ds[ , 1:100000]

brain5_s  <- brain_s[  , 1:200000]
brain5_D  <- brain_D[  , 1:200000]
brain5_Ds <- brain_Ds[ , 1:200000]

## ----simple_normalize_function------------------------------------------------
## Also selects the most variable genes (1000 by default).
simple_normalize <- function(mat, num_var_genes=1000)
{
    stopifnot(length(dim(mat)) == 2, !is.null(rownames(mat)))
    mat <- mat[rowSums(mat) > 0, ]
    col_sums <- colSums(mat) / 10000
    mat <- t(t(mat) / col_sums)
    row_vars <- rowVars(mat)
    row_vars_order <- order(row_vars, decreasing=TRUE)
    variable_idx <- head(row_vars_order, n=num_var_genes)
    mat <- log1p(mat[variable_idx, ])
    mat / rowSds(mat)
}

## ----simple_PCA_function------------------------------------------------------
simple_PCA <- function(mat, k=25)
{
    stopifnot(length(dim(mat)) == 2)
    row_means <- rowMeans(mat)
    Ax <- function(x, args)
        (as.numeric(mat %*% x) - row_means * sum(x))
    Atx <- function(x, args)
        (as.numeric(x %*% mat) - as.vector(row_means %*% x))
    RSpectra::svds(Ax, Atrans=Atx, k=k, dim=dim(mat))
}

## ----norm_brain1_s------------------------------------------------------------
dim(brain1_s)
DelayedArray::setAutoBlockSize(250e6)  # set block size to 250 Mb
system.time(norm_brain1_s <- simple_normalize(brain1_s))
dim(norm_brain1_s)

## ----norm_brain1_D------------------------------------------------------------
dim(brain1_D)
DelayedArray::setAutoBlockSize(16e6)   # set block size to 16 Mb
system.time(norm_brain1_D <- simple_normalize(brain1_D))
dim(norm_brain1_D)

## ----norm_brain1_Ds-----------------------------------------------------------
dim(brain1_Ds)
DelayedArray::setAutoBlockSize(250e6)  # set block size to 250 Mb
system.time(norm_brain1_Ds <- simple_normalize(brain1_Ds))
dim(norm_brain1_Ds)

## ----show_norm_brain1_s_delayed_ops-------------------------------------------
class(norm_brain1_s)
showtree(norm_brain1_s)

## ----set_realization_block_size-----------------------------------------------
DelayedArray::setAutoBlockSize(1e8)

## ----writeTENxMatrix_norm_brain1_s--------------------------------------------
dim(norm_brain1_s)
system.time(norm_brain1_s <- writeTENxMatrix(norm_brain1_s, level=0))

## ----show_pristine_norm_brain1_s----------------------------------------------
class(norm_brain1_s)
showtree(norm_brain1_s)  # "pristine" object (i.e. no more delayed operations)

## ----writeHDF5Array_norm_brain1_D---------------------------------------------
dim(norm_brain1_D)
system.time(norm_brain1_D <- writeHDF5Array(norm_brain1_D, level=0))

## ----show_pristine_norm_brain1_D----------------------------------------------
class(norm_brain1_D)
showtree(norm_brain1_D)  # "pristine" object (i.e. no more delayed operations)

## ----writeHDF5Array_norm_brain1_Ds--------------------------------------------
dim(norm_brain1_Ds)
system.time(norm_brain1_Ds <- writeHDF5Array(norm_brain1_Ds, level=0))

## ----show_pristine_norm_brain1_Ds---------------------------------------------
class(norm_brain1_Ds)
showtree(norm_brain1_Ds)  # "pristine" object (i.e. no more delayed operations)

## ----PCA_norm_brain1_s--------------------------------------------------------
DelayedArray::setAutoBlockSize(40e6)   # set block size to 40 Mb
dim(norm_brain1_s)
system.time(pca1s <- simple_PCA(norm_brain1_s))

## ----PCA_norm_brain1_D--------------------------------------------------------
DelayedArray::setAutoBlockSize(1e8)    # set block size to 100 Mb
dim(norm_brain1_D)
system.time(pca1D <- simple_PCA(norm_brain1_D))

## ----sanity_check1d-----------------------------------------------------------
stopifnot(all.equal(pca1D, pca1s))

## ----PCA_norm_brain1_Ds-------------------------------------------------------
DelayedArray::setAutoBlockSize(40e6)   # set block size to 40 Mb
dim(norm_brain1_Ds)
system.time(pca1Ds <- simple_PCA(norm_brain1_Ds))

## ----sanity_check1ds----------------------------------------------------------
stopifnot(all.equal(pca1Ds, pca1s))

## ----xps15_specs, echo=FALSE, results='asis'----------------------------------
hdparm1 <- "Output of <code>sudo hdparm -Tt &lt;device&gt;</code>:"
hdparm1 <- sprintf("<span style=\"font-style: italic\">%s</span>", hdparm1)
hdparm2 <- c(
    "Timing cached reads:   35188 MB in  2.00 seconds = 17620.75 MB/sec",
    "Timing buffered disk reads: 7842 MB in  3.00 seconds = 2613.57 MB/sec"
)
hdparm2 <- sprintf("<code>%s</code>", paste(hdparm2, collapse="<br />"))
disk_perf <- paste0(hdparm1, "<br />", hdparm2)
make_machine_specs_table("Specs for DELL XPS 15 laptop (model 9520)",
    specs=c(`OS`="Linux Ubuntu 24.04",
            `RAM`="32GB",
            `Disk`="1TB SSD"),
    disk_perf=disk_perf)

## ----xps15_timings, echo=FALSE, results='asis'--------------------------------
caption <- "Table 1: Timings for DELL XPS 15 laptop"
make_timings_table("xps15", caption=caption)

## ----rex3_specs, echo=FALSE, results='asis'-----------------------------------
hdparm1 <- "Output of <code>sudo hdparm -Tt &lt;device&gt;</code>:"
hdparm1 <- sprintf("<span style=\"font-style: italic\">%s</span>", hdparm1)
hdparm2 <- c(
    "Timing cached reads:   20592 MB in  1.99 seconds = 10361.41 MB/sec",
    "Timing buffered disk reads: 1440 MB in  3.00 seconds = 479.66 MB/sec"
)
hdparm2 <- sprintf("<code>%s</code>", paste(hdparm2, collapse="<br />"))
disk_perf <- paste0(hdparm1, "<br />", hdparm2)
make_machine_specs_table("Specs for Supermicro SuperServer 1029GQ-TRT",
    specs=c(`OS`="Linux Ubuntu 22.04",
            `RAM`="384GB",
            `Disk`="1.3TB ATA Disk"),
    disk_perf=disk_perf)

## ----rex3_timings, echo=FALSE, results='asis'---------------------------------
caption <- "Table 2: Timings for Supermicro SuperServer 1029GQ-TRT"
make_timings_table("rex3", caption=caption)

## ----kjohnson3_specs, echo=FALSE, results='asis'------------------------------
make_machine_specs_table("Specs for Apple Silicon Mac Pro (Apple M2 Ultra)",
    specs=c(`OS`="macOS 13.7.1",
            `RAM`="192GB",
            `Disk`="2TB SSD"),
    disk_perf="N/A")

## ----kjohnson3_timings, echo=FALSE, results='asis'----------------------------
caption <- "Table 3: Timings for Apple Silicon Mac Pro"
make_timings_table("kjohnson3", caption=caption)

## ----lconway_specs, echo=FALSE, results='asis'--------------------------------
make_machine_specs_table("Specs for Intel Mac Pro (24-Core Intel Xeon W)",
    specs=c(`OS`="macOS 12.7.6",
            `RAM`="96GB",
            `Disk`="1TB SSD"),
    disk_perf="N/A")

## ----lconway_timings, echo=FALSE, results='asis'------------------------------
caption <- "Table 4: Timings for Intel Mac Pro"
make_timings_table("lconway", caption=caption)

## ----summarize_machine_times, echo=FALSE, results='asis'----------------------
machine_names <- c(
    `DELL XPS 15 laptop`="xps15",
    `Supermicro SuperServer 1029GQ-TRT`="rex3",
    `Apple Silicon Mac Pro`="kjohnson3",
    `Intel Mac Pro`="lconway"
)
summarize_machine_times(machine_names)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

