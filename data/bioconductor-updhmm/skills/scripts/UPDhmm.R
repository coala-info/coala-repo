# Code example from 'UPDhmm' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  comment = "",
  warning = FALSE,
  message = FALSE,
  cache = FALSE
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("UPDhmm")
# BiocManager::install("regioneR")
# BiocManager::install("karyoploteR")
# 

## -----------------------------------------------------------------------------
library(UPDhmm)
library(dplyr)

## -----------------------------------------------------------------------------
library(VariantAnnotation)
library(regioneR)
library(karyoploteR)

#Example files
files <- c(
  system.file(package = "UPDhmm", "extdata", "sample1.vcf.gz"),
  system.file(package = "UPDhmm", "extdata", "sample2.vcf.gz")
)


# Define the trio structure
trio_list <- list(
  list(
    proband = "NA19675",
    mother  = "NA19678",
    father  = "NA19679"
  ),
  list(
    proband = "NA19685",
    mother  = "NA19688",
    father  = "NA19689"
  )
)

# Read and preprocess each VCF
vcf_list <- mapply(function(file, trio) {
  vcf <- readVcf(file)
  vcfCheck(vcf,
           proband = trio$proband,
           mother  = trio$mother,
           father  = trio$father)
}, 
files, trio_list, SIMPLIFY = FALSE)



## -----------------------------------------------------------------------------
events_list <- lapply(vcf_list, calculateEvents)
head(events_list[[1]])


## ----eval=FALSE---------------------------------------------------------------
# 
# library(BiocParallel)
# BPPARAM <- MulticoreParam(workers = min(2, parallel::detectCores()))
# events_list <- lapply(vcf_list, calculateEvents, BPPARAM = BPPARAM)
# 

## -----------------------------------------------------------------------------
filtered_events_list <- lapply(events_list, function(df) {
  if (nrow(df) == 0) return(df)  # skip empty results
  
  df$size <- df$end - df$start
  
  dplyr::filter(
    df,
    n_mendelian_error > 2,
    size > 500000,
    ratio_proband >= 0.8 & ratio_proband <= 1.2,
    ratio_father  >= 0.8 & ratio_father  <= 1.2,
    ratio_mother  >= 0.8 & ratio_mother  <= 1.2
  )
})

## -----------------------------------------------------------------------------
collapsed_list <- lapply(filtered_events_list, collapseEvents)
collapsed_all <- do.call(rbind.data.frame, c(collapsed_list, make.row.names = FALSE))
head(collapsed_all)

## -----------------------------------------------------------------------------
recurrentRegions <- identifyRecurrentRegions(
  df = collapsed_all,
  ID_col = "ID",
  error_threshold = 100,
  min_support = 2
)

head(recurrentRegions)
annotatedEvents <- markRecurrentRegions(
  df = collapsed_all,
  recurrent_regions = recurrentRegions
)

head(annotatedEvents)

## -----------------------------------------------------------------------------

library(regioneR)
bed <- system.file(package = "UPDhmm", "extdata", "SFARI.bed")
bed_df <- read.table(
    bed,
    header = TRUE
)

bed_gr <- toGRanges(bed_df)

annotatedEvents <- markRecurrentRegions(
  df = collapsed_all,
  recurrent_regions = bed_gr
)

head(annotatedEvents)

## -----------------------------------------------------------------------------
library(karyoploteR)
library(regioneR)

# Function to visualize UPD events across the genome
plotUPDKp <- function(updEvents) {
  #--------------------------------------------------------------
  # 1. Detect coordinate columns
  #--------------------------------------------------------------
  if (all(c("start", "end") %in% colnames(updEvents))) {
    start_col <- "start"
    end_col <- "end"
  } else if (all(c("min_start", "max_end") %in% colnames(updEvents))) {
    start_col <- "min_start"
    end_col <- "max_end"
  } else {
    stop("Input must contain either (start, end) or (min_start, max_end) columns.")
  }

  #--------------------------------------------------------------
  # 2. Ensure chromosome naming format (e.g. "chr3")
  #--------------------------------------------------------------
  updEvents$seqnames <- ifelse(grepl("^chr", updEvents$seqnames),
                               updEvents$seqnames,
                               paste0("chr", updEvents$seqnames))

  #--------------------------------------------------------------
  # 3. Helper function to safely create GRanges only if events exist
  #--------------------------------------------------------------
  to_gr_safe <- function(df, grp) {
    subset_df <- subset(df, group == grp)
    if (nrow(subset_df) > 0) {
      toGRanges(subset_df[, c("seqnames", start_col, end_col)])
    } else {
      NULL
    }
  }

  #--------------------------------------------------------------
  # 4. Separate UPD event types
  #--------------------------------------------------------------
  het_fat <- to_gr_safe(updEvents, "het_fat")
  het_mat <- to_gr_safe(updEvents, "het_mat")
  iso_fat <- to_gr_safe(updEvents, "iso_fat")
  iso_mat <- to_gr_safe(updEvents, "iso_mat")

  #--------------------------------------------------------------
  # 5. Create the genome ideogram
  #--------------------------------------------------------------
  kp <- plotKaryotype(genome = "hg19")

  #--------------------------------------------------------------
  # 6. Plot regions by inheritance type (if any exist)
  #--------------------------------------------------------------
  if (!is.null(het_fat)) kpPlotRegions(kp, het_fat, col = "#AAF593")
  if (!is.null(het_mat)) kpPlotRegions(kp, het_mat, col = "#FFB6C1")
  if (!is.null(iso_fat)) kpPlotRegions(kp, iso_fat, col = "#A6E5FC")
  if (!is.null(iso_mat)) kpPlotRegions(kp, iso_mat, col = "#E9B864")

  #--------------------------------------------------------------
  # 7. Add legend
  #--------------------------------------------------------------
  legend("topright",
         legend = c("Het_Fat", "Het_Mat", "Iso_Fat", "Iso_Mat"),
         fill = c("#AAF593", "#FFB6C1", "#A6E5FC", "#E9B864"))
}
# Example: visualize UPD events for the first trio
plotUPDKp(annotatedEvents)


## -----------------------------------------------------------------------------
sessionInfo()

