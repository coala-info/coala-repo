# Code example from 'chromswitch_intro' vignette. See references/ for full tutorial.

## ----echo = FALSE, warning = FALSE, message = FALSE------------------------
library(BiocParallel)
register(bpstart(SerialParam()))

## ----setup, warning = FALSE, message = FALSE-------------------------------
library(chromswitch)

## ----message = FALSE, warning = FALSE--------------------------------------
library(rtracklayer)

## ----qs_query--------------------------------------------------------------
# Path to BED file in chromswitch installation
query_path <- system.file("extdata/query.bed", package = "chromswitch")

# Read in BED file, creating a GRanges object
query <- rtracklayer::import(con = query_path, format = "BED")
query

## ----qs_meta---------------------------------------------------------------
# Path to TSV in chromswitch
meta_path <- system.file("extdata/metadata.tsv", package = "chromswitch")

# Read in the table from a 2-column TSV file
metadata <- read.delim(meta_path, sep = "\t", header = TRUE)
metadata

## ----qs_pks----------------------------------------------------------------
# Paths to the BED files containing peak calls for each sample
peak_paths <- system.file("extdata", paste0(metadata$Sample, ".H3K4me3.bed"),
                     package = "chromswitch")

# Import BED files containing MACS2 narrow peak calls using rtracklayer
peaks <- readNarrowPeak(paths = peak_paths,  # Paths to files,
                        metadata = metadata) # Metadata dataframe

## ----quickstart_1, warning = FALSE-----------------------------------------
callSummary(query = query,       # Input 1: Query regions
            metadata = metadata, # Input 2: Metadata dataframe
            peaks = peaks,       # Input 3: Peaks
            mark = "H3K4me3")    # Arbitrary string describing the data type

## ----quickstart_2, warning = FALSE-----------------------------------------
callBinary(query = query,       # Input 1: Query regions
           metadata = metadata, # Input 2: Metadata dataframe
           peaks = peaks)       # Input 3: Peaks

## ----regions---------------------------------------------------------------
# Path to BED file in chromswitch installation
query_path <- system.file("extdata/query.bed", package = "chromswitch")

# Read in BED file, creating a GRanges object
query <- rtracklayer::import(con = query_path, format = "BED")
query

## ----meta------------------------------------------------------------------
# Path to TSV in chromswitch
meta_path <- system.file("extdata/metadata.tsv", package = "chromswitch")

# Read in the table from a 2-column TSV file
metadata <- read.delim(meta_path, sep = "\t", header = TRUE)
metadata

## ----paths-----------------------------------------------------------------
# Paths to the BED files containing peak calls for each sample
peak_paths <- system.file("extdata", paste0(metadata$Sample, ".H3K4me3.bed"),
                     package = "chromswitch")

# Import BED files containing MACS2 narrow peak calls using 
#  a helper function from chromswitch
peaks <- readNarrowPeak(paths = peak_paths,  # Paths to files,
                        metadata = metadata)

# Ensure the list is named by sample
names(peaks) <- metadata$Sample

## ----read------------------------------------------------------------------
extra_cols <- c("signalValue" = "numeric",
                "pValue" = "numeric",
                "qValue" = "numeric",
                "peak" = "numeric")

# Obtain a list of GRanges objects containing peak calls
peaks <- lapply(peak_paths, rtracklayer::import, format = "bed",
                   extraCols = extra_cols)

# Ensure the list is named by sample
names(peaks) <- metadata$Sample

## ----manual----------------------------------------------------------------
# Read in all files into dataframes
df <- lapply(peak_paths, read.delim, sep = "\t",
             header = FALSE,
             col.names = c("chr", "start", "end", "name", "score", 
                           "strand", "signalValue", "pValue",
                           "qValue", "peak"))

# Convert the dataframes into GRanges objects, retaining
# additional columns besides chr, start, end
peaks <- lapply(df, makeGRangesFromDataFrame, keep.extra.columns = TRUE)

# Ensure the list is named by sample
names(peaks) <- metadata$Sample

## ----summary_basic, warning = FALSE----------------------------------------

out <- callSummary(query = query, # Input 1: Query regions
            metadata = metadata,  # Input 2: Metadata dataframe
            peaks = peaks,        # Input 3: Peaks
            mark = "H3K4me3")     # Arbitrary string describing the data type

out


## ----threshold-------------------------------------------------------------
out[out$Consensus >= 0.75, ]

## ----summary2, warning = FALSE---------------------------------------------

out2 <- callSummary(
                # Standard arguments of the function
                query = query,
                metadata = metadata,
                peaks = peaks,
                
                # Arbitrary string describing data type
                mark = "H3K4me3",

                # For quality control, filter peaks based on associated stats
                # prior to constructing feature matrices
                filter = TRUE,
                # Provide column names and thresholds to use in the same order
                filter_columns = c("qValue", "signalValue"),
                filter_thresholds = c(10, 4),

                # Normalization options
                normalize = TRUE, # Strongly recommended
                # By default, set to equal summarize_columns, below
                normalize_columns = c("qValue", "signalValue"),

                # Columns to use for for feature matrix construction
                summarize_columns = c("qValue", "signalValue"),

                # In addition to summarizing peak statistics,
                # we can also optionally compute the
                # fraction of the region overlapped by peaks
                # and the number of peaks
                fraction = TRUE,
                n = FALSE,
                
                # TRUE by default, return the optimal number
                # of clusters, otherwise require k = 2
                optimal_clusters = TRUE,
                
                # Set this to TRUE to save a PDF of the heatmap
                # for each region to the current working directory
                heatmap = FALSE,
                
                # Chromswitch uses BiocParallel as a backend for
                # parallel computations. Analysis is parallelized at the
                # level of query regions.
                BPPARAM = BiocParallel::SerialParam())

out2


## ----binary_basic, warning = FALSE-----------------------------------------
out3 <- callBinary(
                # Standard arguments of the function
                query = query,
                metadata = metadata,
                peaks = peaks,
                
                # Logical, controls whether to
                # reduce gaps between peaks to eliminate noise
                reduce = TRUE,
                # Peaks in the same sample which are within this many bp
                # of each other will be merged
                gap = 300,
                
                # The fraction of reciprocal overlap required to define
                # two peaks as non unique, used to construct a binary ft matrix
                p = 0.4,
                
                # Include in output the number of features obtained in 
                # each query region
                n_features = TRUE)

out3

## ----threshold2------------------------------------------------------------

out3[out3$Consensus >= 0.75, ]


## ----pipe------------------------------------------------------------------
library(magrittr)

## ----dplyr, warning = FALSE, message = FALSE-------------------------------
library(dplyr)

## ----filter----------------------------------------------------------------
# Number of peaks in each sample prior to filtering
lapply(H3K4me3, length) %>% as.data.frame()

H3K4me3_filt <- filterPeaks(peaks = H3K4me3,
                            columns = c("qValue", "signalValue"),
                            thresholds = c(10, 4))

# Number of peaks in each sample after filtering
lapply(H3K4me3_filt, length) %>% as.data.frame()

## ----normalize-------------------------------------------------------------
# Summary of the two statistics we will use downstream in raw data in one sample
H3K4me3_filt %>% lapply(as.data.frame) %>%
    lapply(select, signalValue, qValue) %>%
    lapply(summary) %>% 
    `[`(1)

H3K4me3_norm <- normalizePeaks(H3K4me3_filt,
                               columns = c("qValue", "signalValue"),
                               tail = 0.005)

# Summary after normalization
H3K4me3_norm %>% lapply(as.data.frame) %>%
    lapply(select, signalValue, qValue) %>%
    lapply(summary) %>% 
    `[`(1)

## ----retrieve--------------------------------------------------------------
# TTYH1 
ttyh1 <- query[2]
ttyh1

ttyh1_pk <- retrievePeaks(peaks = H3K4me3_norm,
                          metadata = metadata,
                          region = ttyh1)

ttyh1_pk

## ----summarizePeaks--------------------------------------------------------
summary_mat <- summarizePeaks(localpeaks = ttyh1_pk,
                              mark = "H3K4me3",
                              cols = c("qValue", "signalValue"),
                              fraction = TRUE,
                              n = FALSE)

# The sample-by-feature matrix
summary_mat

## ----cluster---------------------------------------------------------------

cluster(ft_mat = summary_mat,
        query = ttyh1,
        metadata = metadata,
        heatmap = TRUE,
        title = "TTYH1 - summary",
        optimal_clusters = TRUE)


## ----reduce----------------------------------------------------------------

ttyh1_pk_red <- reducePeaks(localpeaks = ttyh1_pk,
                            gap = 300)


## ----binarizePeaks---------------------------------------------------------
binary_mat <- binarizePeaks(ttyh1_pk_red,
                            p = 0.4)

# Chromswitch finds a single unique peak in the region
binary_mat

## ----cluster2--------------------------------------------------------------

cluster(ft_mat = binary_mat,
        metadata = metadata,
        query = ttyh1,
        optimal_clusters = TRUE)


## ----session---------------------------------------------------------------
sessionInfo()

