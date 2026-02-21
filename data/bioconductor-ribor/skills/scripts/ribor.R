# Code example from 'ribor' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----pressure, echo=FALSE, fig.cap="Figure 1: .ribo File Internal Structure", out.width = '90%', fig.align="center"----
knitr::include_graphics("ribo_file_structure.jpg")

## ----install_bioconductor, eval=FALSE-----------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ribor")

## ----install_from_github, eval = FALSE----------------------------------------
# install.packages("devtools")
# library("devtools")
# install_github("ribosomeprofiling/ribor")

## ----import_lib, eval = TRUE--------------------------------------------------
library(ribor)

## ----createRibo---------------------------------------------------------------
#file path to the example ribo file 
file.path <- system.file("extdata", "HEK293_ingolia.ribo", package = "ribor")

#generates the 'ribo' class object 
original.ribo <- Ribo(file.path, rename = rename_default )

## -----------------------------------------------------------------------------
original.ribo

## ----plot_length_distribution ribo, fig.width = 7-----------------------------
plot_length_distribution(x           = original.ribo,
                         region      = "CDS",
                         range.lower = 28,
                         range.upper = 32,
                         fraction    = TRUE)

## ----plot_length_distribution_UTR5 ribo, fig.width = 7------------------------
plot_length_distribution(x           = original.ribo,
                         region      = "CDS",
                         range.lower = 28,
                         range.upper = 32,
                         fraction    = FALSE)

## ----get_length_dist_basic----------------------------------------------------
rc <- get_length_distribution(ribo.object      = original.ribo,
                                   region      = "CDS",
                                   range.lower = 28,
                                   range.upper = 32)
rc

## ----plot_length_distribution_from_dataframe, eval = FALSE--------------------
# # further DataFrame manipulation and filtering can ensue here
# # before calling the plot function
# 
# plot_length_distribution(rc, fraction = TRUE)

## ----learn_metagene_radius----------------------------------------------------
get_info(original.ribo)$attributes$metagene_radius

## ----plot_metagene ribo_start, fig.width = 7----------------------------------
plot_metagene(original.ribo,
              site        = "start",
              experiment  = c("GSM1606107"),
              range.lower = 28,
              range.upper = 32)

## ----plot_metagene ribo, fig.width = 7----------------------------------------
plot_metagene(original.ribo,
              site        = "stop",
              normalize   = TRUE,
              title       = "Stop Site Coverage",
              range.lower = 28,
              range.upper = 32)

## -----------------------------------------------------------------------------
#get the start site across read lengths 28 to 32
meta.start <- get_metagene(ribo.object = original.ribo, 
                           site        = "start",
                           range.lower = 28,
                           range.upper = 32,
                           length      = TRUE,
                           transcript  = TRUE)
#only print first ten columns 
print(meta.start[ , 1:10])

## -----------------------------------------------------------------------------
tidy.meta.start <- get_tidy_metagene(ribo.object = original.ribo,
                                     site        = "start",
                                     range.lower = 28,
                                     range.upper = 32,
                                     length      = TRUE)
head(tidy.meta.start, 2)

## -----------------------------------------------------------------------------
meta.start <- get_metagene(ribo.object = original.ribo, 
                           site        = "start",
                           range.lower = 30,
                           range.upper = 30,
                           experiment  = c("GSM1606108"),
                           length      = FALSE,
                           transcript  = TRUE)

print(meta.start[, 1:10])

## ----get_metagene_tr_F_len_T--------------------------------------------------
meta.start <- get_metagene(ribo.object = original.ribo, 
                           site        = "start",
                           range.lower = 28,
                           range.upper = 32,
                           length      = TRUE,
                           transcript  = FALSE,
                           alias       = TRUE)

print(meta.start[1:2, 1:10])

## ----plot_metagene_from_dt, fig.width = 7-------------------------------------
plot_metagene(tidy.meta.start, normalize = TRUE)

## ----region_definitions, echo=FALSE, fig.cap="Figure 2: Extended Region Definitions", out.width = '90%', fig.align="center"----
knitr::include_graphics("region_definition.jpg")

## ----plot_region_counts ribo, fig.width = 7-----------------------------------
plot_region_counts(x           = original.ribo,
                   range.lower = 28,
                   range.upper = 32)

## ----get_region_counts default------------------------------------------------
rc <- get_region_counts(original.ribo,
                        range.lower = 28,
                        range.upper = 32,
                        length      = TRUE,
                        transcript  = TRUE,
                        region      = c("CDS"))
rc

## ----get_region_counts transcript---------------------------------------------
rc <- get_region_counts(original.ribo,
                        range.lower = 28,
                        range.upper = 32,
                        length      = TRUE,
                        transcript  = FALSE,
                        alias       = TRUE,
                        region      = c("CDS"))
rc

## ----get_region_counts full---------------------------------------------------
rc <- get_region_counts(original.ribo,
                        range.lower = 28,
                        range.upper = 32,
                        length      = FALSE,
                        transcript  = FALSE,
                        alias       = TRUE,
                        region      = c("CDS"))
rc

## ----get_region_counts non-tidy-----------------------------------------------
rc <- get_region_counts(original.ribo,
                        range.lower = 28,
                        range.upper = 32,
                        tidy        = FALSE)
rc

## ----get_region_counts normalize----------------------------------------------
rc <- get_region_counts(original.ribo,
                        range.lower = 28,
                        range.upper = 32,
                        normalize   = TRUE,
                        region      = c("CDS"))
rc

## ----plot_region_counts dt, fig.width = 7-------------------------------------
rc.info <- get_region_counts(ribo.object = original.ribo,
                             region      = c("UTR5", "CDS", "UTR3"),
                             range.lower = 28,
                             range.upper = 32)

# further data frame manipulation and filtering can ensue here 
# before calling the plot function 

plot_region_counts(rc.info)

## ----memory_footprint_example-------------------------------------------------
# default return value with compact = TRUE
compact_rc <- get_region_counts(ribo.object = original.ribo, 
                                range.lower = 28,
                                range.upper = 32,
                                length      = TRUE,
                                transcript  = FALSE,
                                compact     = TRUE,
                                alias       = TRUE)
head(compact_rc)
class(compact_rc)
object.size(compact_rc)

# return value with compact = FALSE
# Note that in this example, it takes up twice as much memory
noncompact_rc <- get_region_counts(ribo.object = original.ribo, 
                                   range.lower = 28,
                                   range.upper = 32,
                                   length      = TRUE,
                                   transcript  = FALSE,
                                   compact     = FALSE,
                                   alias       = TRUE)
head(noncompact_rc)
class(noncompact_rc)
object.size(noncompact_rc)

## ----createRibo_revisited, eval = TRUE----------------------------------------
original.ribo <- Ribo(file.path, rename = rename_default )
original.ribo

## ----alias_highlight_in_metagene----------------------------------------------
meta.start <- get_metagene(ribo.object = original.ribo, 
                           site        = "start",
                           range.lower = 28,
                           range.upper = 32,
                           length      = FALSE,
                           transcript  = FALSE,
                           alias       = TRUE)
meta.start[1:2 , c(1,2,3,38,39,40)]

## ----cumbersome---------------------------------------------------------------
head(get_reference_names(original.ribo), 2)

## ----def_rename_default-------------------------------------------------------
rename_default <- function(names){
  return(unlist(strsplit(names, split = "[|]"))[5])
}

rename_default("ENST00000335137.4|ENSG00000186092.6|OTTHUMG00000001094.4|-|OR4F5-201|OR4F5|1054|protein_coding|") 

## ----alias--------------------------------------------------------------------
alias.ribo    <- Ribo(file.path, rename = rename_default)
alias.ribo

## ----noalias------------------------------------------------------------------
noalias.ribo    <- Ribo(file.path)
noalias.ribo

## ----set_aliases--------------------------------------------------------------
#create a ribo file 
alias.ribo    <- Ribo(file.path)

#generate the vector of aliases
aliases <- rename_transcripts(ribo = alias.ribo, rename = rename_default)

#add aliases
alias.ribo <- set_aliases(alias.ribo, aliases)

head(aliases, 3)

alias.ribo

## ----get_info-----------------------------------------------------------------
#retrieves the experiments
original.info <- get_info(ribo.object = original.ribo)
original.info

## ----get_internal_region_coordinates------------------------------------------
region_coord <- get_internal_region_coordinates(ribo.object = alias.ribo , alias = TRUE)
head(region_coord, 2)

## ----get_internal_region_lengths----------------------------------------------
region_lengths <- get_internal_region_lengths(ribo.object = alias.ribo, alias = TRUE)
head(region_lengths, 2)

## ----get_original_region_coordinates------------------------------------------
region_coord <- get_original_region_coordinates(ribo.object = alias.ribo , alias = TRUE)
head(region_coord, 2)

## ----get_original_region_lengths----------------------------------------------
region_lengths <- get_original_region_lengths(ribo.object = alias.ribo, alias = TRUE)
head(region_lengths, 2)

## ----define_multiple_file_reader----------------------------------------------
# helper function
read_multiple_files <- function(ribo_list, getter_function, ...) {
  df_list <- lapply(ribo_list, getter_function, ...)
  df_list <- mapply(cbind, df_list, "study" = names(df_list), SIMPLIFY=FALSE)
  df <- dplyr::bind_rows(df_list)
  return (df)
}

## ----create_named_ribo_list---------------------------------------------------
# create a named Ribo object list of length >= 1
ribo_file_list <- list(original.ribo)
names(ribo_file_list) <- c("GSE65778")

# try out a function
read_multiple_files(ribo_list = ribo_file_list, getter_function = get_region_counts, compact = FALSE, tidy = FALSE)

## ----check_info_for_optional_fields-------------------------------------------
original.ribo

## ----get_metadata file, eval = FALSE------------------------------------------
# get_metadata(ribo.object = original.ribo,
#              print = TRUE)
# #The output is omitted due to its length

## ----get_metadata shortened_meta, eval = FALSE--------------------------------
# info <- capture.output(get_metadata(ribo.object = original.ribo,
#                                     print = FALSE))
# info
# #The output is omitted due to its length

## ----get_metadata has.metadata------------------------------------------------
#obtain a list of experiments with metadata 
experiment.info <- get_info(ribo.object = original.ribo)[['experiment.info']]
has.metadata <- experiment.info[experiment.info$metadata == TRUE, "experiment"]
has.metadata

#store the name of the first experiment with metadata and gets its metadata
experiment <- has.metadata[1]

get_metadata(ribo.object = original.ribo,
             name        = experiment,
             print       = TRUE)

## ----get_list_of_exps_with_coverage-------------------------------------------
#get a list of experiments that have coverage data
experiment.info <- get_info(ribo.object = original.ribo)[['experiment.info']]
has.coverage <- experiment.info[experiment.info$coverage == TRUE, "experiment"]
has.coverage

## -----------------------------------------------------------------------------
cov <- get_coverage(ribo.object = original.ribo,
                    name        = "MYC-206",
                    range.lower = 28,
                    range.upper = 32,
                    length      = TRUE,
                    alias       = TRUE,
                    tidy        = TRUE,
                    experiment  = has.coverage)
cov

## -----------------------------------------------------------------------------
#only using one experiment for this 
exp.names <- has.coverage[1]

#length is FALSE, get coverage information
#at each read length
cov <- get_coverage(ribo.object = original.ribo,
                    name        = "MYC-206",
                    range.lower = 28,
                    range.upper = 32,
                    length      = FALSE,
                    alias       = TRUE,
                    tidy        = TRUE,
                    experiment  = exp.names)

cov

## -----------------------------------------------------------------------------
#get a list of experiments that have RNA-Seq data
experiment.info <- get_info(ribo.object = original.ribo)[['experiment.info']]
has.rnaseq <- experiment.info[experiment.info$rna.seq == TRUE, "experiment"]
has.rnaseq

## -----------------------------------------------------------------------------
#get a list of experiments that have RNA-Seq data
rnaseq <- get_rnaseq(ribo.object = original.ribo,
                     tidy        = FALSE,
                     alias       = TRUE,
                     experiment  = has.rnaseq)

#print out the first 2 rows of the DataFrame
head(rnaseq, 2)

## -----------------------------------------------------------------------------
experiment <- has.rnaseq[1]
rnaseq <- get_rnaseq(ribo.object = original.ribo,
                     tidy        = TRUE,
                     alias       = TRUE,
                     region     = c("UTR5J", "CDS", "UTR3J"),
                     experiment  = experiment)
head(rnaseq, 2)

## ----rc_rnaseq_sample---------------------------------------------------------
# obtain the rnaseq and ribosomal occupancy of the CDS region
rnaseq_CDS <- get_rnaseq(ribo.object = original.ribo,
                         tidy        = TRUE,
                         alias       = TRUE,
                         region      = "CDS",
                         compact     = FALSE,
                         experiment  = "GSM1606108")


rc_CDS <- get_region_counts(ribo.object    = original.ribo,
                                tidy       = TRUE,
                                alias      = TRUE,
                                transcript = FALSE,
                                region     = "CDS",
                                compact    = FALSE,
                                experiment = "GSM1606108")

# filter out the lowly expressed transcripts  
plot(density(log2(rnaseq_CDS$count)), xlab = "Log 2 of RNA-Seq Count", main = "RNA-Seq Density")

## ----filter_and_plot----------------------------------------------------------
# filter out transcripts with count value less than 2 for either ribosome profiling region counts or rnaseq
filtered_transcripts <- which(rnaseq_CDS$count > 2 & rc_CDS$count > 2)
rnaseq_CDS           <- rnaseq_CDS[filtered_transcripts, ]
rc_CDS               <- rc_CDS[filtered_transcripts, ]
plot(log2(rnaseq_CDS$count), log2(rc_CDS$count), xlab = "RNA-Seq", ylab = "Ribosome Profiling", main = "log2 CDS Read Counts", pch = 19, cex = 0.5)

## ----translational_efficiency-------------------------------------------------
# get the translational efficiency of CDS 
te_CDS    <- rc_CDS$count/rnaseq_CDS$count
plot(density(log2(te_CDS)), xlab = "Log 2 of Translation Efficiency", main = "")

## ----filter_te----------------------------------------------------------------
# filter for translational efficiency of the observed elbow at -2 (on the log2 scale, untransformed value of .25) 
high_te <- rc_CDS$transcript[which(te_CDS > .25)]

# found 229 transcripts, first 20 shown here 
head(high_te, n = 20)

