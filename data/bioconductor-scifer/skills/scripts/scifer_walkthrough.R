# Code example from 'scifer_walkthrough' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    warning = FALSE,
    crop = NULL
)

## ----'install', eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("scifer")

## ----setup--------------------------------------------------------------------
library(ggplot2)
library(scifer)

## ----check_fcs, message=FALSE-------------------------------------------------
fcs_data <- fcs_processing(
    folder_path = system.file("/extdata/fcs_index_sorting", package = "scifer"),
    compensation = FALSE, plate_wells = 96,
    probe1 = "FSC.A", probe2 = "SSC.A",
    posvalue_probe1 = 600, posvalue_probe2 = 400
)

fcs_plot(fcs_data)

## ----channels-----------------------------------------------------------------
colnames(fcs_data)

## ----check_fcs_noprobe, message=FALSE, warning=FALSE--------------------------
fcs_data <- fcs_processing(
    folder_path = system.file("/extdata/fcs_index_sorting", package = "scifer"),
    compensation = FALSE, plate_wells = 96,
    probe1 = "FSC.A", probe2 = "SSC.A",
    posvalue_probe1 = 0, posvalue_probe2 = 0
)

fcs_plot(fcs_data)

## ----check_fcs_probe, message=FALSE, warning=FALSE----------------------------
fcs_data <- fcs_processing(
    folder_path = system.file("/extdata/fcs_index_sorting", package = "scifer"),
    compensation = FALSE, plate_wells = 96,
    probe1 = "Pre.F", probe2 = "Post.F",
    posvalue_probe1 = 600, posvalue_probe2 = 400
)

fcs_plot(fcs_data)

## ----check_fcs_probe_compensated, message=FALSE, warning=FALSE----------------
fcs_data <- fcs_processing(
    folder_path = system.file("/extdata/fcs_index_sorting", package = "scifer"),
    compensation = TRUE, plate_wells = 96,
    probe1 = "Pre.F", probe2 = "Post.F",
    posvalue_probe1 = 600, posvalue_probe2 = 400
)

fcs_plot(fcs_data)

## ----specificity, message=FALSE, warning=FALSE--------------------------------
unique(fcs_data$specificity)

## ----bcr_sequence, warning=FALSE----------------------------------------------
## Read abif using sangerseqR package
abi_seq <- sangerseqR::read.abif(
    system.file("/extdata/sorted_sangerseq/E18_C1/A1_3_IgG_Inner.ab1",
        package = "scifer"
    )
)
## Summarise using summarise_abi_file()
summarised <- summarise_abi_file(abi_seq)
head(summarised[["summary"]])
head(summarised[["quality_score"]])

## ----bcr_sequences, warning=FALSE---------------------------------------------
sf <- summarise_quality(
    folder_sequences = system.file("extdata/sorted_sangerseq", package = "scifer"),
    secondary.peak.ratio = 0.33, trim.cutoff = 0.01, processor = 1
)

## ----bcr_seq_columns, warning=FALSE-------------------------------------------
## Print names of all the variables
colnames(sf[["summaries"]])

## ----bcr_seq_table, warning=FALSE---------------------------------------------
## Print table
head(sf[["summaries"]][4:10])

## ----eval=FALSE---------------------------------------------------------------
# quality_report(
#     folder_sequences = system.file("extdata/sorted_sangerseq", package = "scifer"),
#     outputfile = "QC_report.html", output_dir = "~/full/path/to/your/location",
#     folder_path_fcs = system.file("extdata/fcs_index_sorting",
#         package = "scifer"
#     ),
#     probe1 = "Pre.F", probe2 = "Post.F",
#     posvalue_probe1 = 600, posvalue_probe2 = 400
# )

## ----os_condition, warning=FALSE, include=FALSE-------------------------------

if(basilisk::isWindows() == TRUE){
  os_chunk <- FALSE
} else if(basilisk::isMacOSXArm() == TRUE){
  os_chunk <- FALSE
} else if(Sys.info()[["sysname"]] == "Linux" && Sys.info()[["machine"]] == "aarch64"){
  os_chunk <- FALSE
} else {
  os_chunk <- TRUE
}



## ----eval=os_chunk------------------------------------------------------------
ighv_res <- igblast(
        database = system.file("/extdata/test_fasta/KIMDB_rm", package = "scifer"),
        fasta = system.file("/extdata/test_fasta/test_igblast.txt", package = "scifer"),
        threads = 1 #For parallel processing. Default = 1
)

head(ighv_res, 2)

## ----session_info-------------------------------------------------------------
sessionInfo()

