# Code example from 'workflow_start' vignette. See references/ for full tutorial.

## ----GenSetup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
    ## Related to
    ## https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    ISAnalytics = citation("ISAnalytics")[1],
    VISPA2 = BibEntry(
        bibtype = "Article",
        title = paste(
            "VISPA2: a scalable pipeline for",
            "high-throughput identification and",
            "annotation of vector integration sites"
        ),
        author = "Giulio Spinozzi, Andrea Calabria, Stefano Brasca",
        journaltitle = "BMC Bioinformatics",
        date = "2017-11-25",
        doi = "10.1186/s12859-017-1937-9"
    ),
    eulerr = citation("eulerr")[1]
)

library(ISAnalytics)
library(BiocStyle)
library(DT)
main_fig <- fs::path("../man", "figures", "dyn_vars_general.png")

## -----------------------------------------------------------------------------
inspect_tags("chromosome")

## ----echo=FALSE---------------------------------------------------------------
all_tags <- available_tags()
all_tags <- all_tags |>
    dplyr::mutate(needed_in = purrr::map_chr(
        .data$needed_in,
        ~ paste0(.x, collapse = ", ")
    ))
mand_tags <- all_tags |>
    dplyr::filter(.data$dyn_vars_tbl == "mand_vars") |>
    dplyr::select(dplyr::all_of(c("tag", "needed_in", "description")))
annot_tags <- all_tags |>
    dplyr::filter(.data$dyn_vars_tbl == "annot_vars") |>
    dplyr::select(dplyr::all_of(c("tag", "needed_in", "description")))
af_tags <- all_tags |>
    dplyr::filter(.data$dyn_vars_tbl == "af_vars") |>
    dplyr::select(dplyr::all_of(c("tag", "needed_in", "description")))
iss_tags <- all_tags |>
    dplyr::filter(.data$dyn_vars_tbl == "iss_vars") |>
    dplyr::select(dplyr::all_of(c("tag", "needed_in", "description")))

## ----echo=FALSE---------------------------------------------------------------
datatable(
    mand_tags,
    class = "stripe",
    options = list(dom = "t"),
    rownames = FALSE
)

## ----echo=FALSE---------------------------------------------------------------
datatable(
    annot_tags,
    class = "stripe",
    options = list(dom = "t"),
    rownames = FALSE
)

## ----echo=FALSE---------------------------------------------------------------
datatable(
    af_tags,
    class = "stripe",
    options = list(dom = "t"),
    rownames = FALSE
)

## ----echo=FALSE---------------------------------------------------------------
datatable(
    iss_tags,
    class = "stripe",
    options = list(dom = "t"),
    rownames = FALSE
)

## -----------------------------------------------------------------------------
mandatory_IS_vars(TRUE)

## -----------------------------------------------------------------------------
new_mand_vars <- tibble::tribble(
    ~names, ~types, ~transform, ~flag, ~tag,
    "chrom", "char", ~ stringr::str_replace_all(.x, "chr", ""), "required",
    "chromosome",
    "position", "int", NULL, "required", "locus",
    "strand", "char", NULL, "required", "is_strand",
    "gap", "int", NULL, "required", NA_character_,
    "junction", "int", NULL, "required", NA_character_
)

## -----------------------------------------------------------------------------
set_mandatory_IS_vars(new_mand_vars)
mandatory_IS_vars(TRUE)

## -----------------------------------------------------------------------------
new_mand_vars[1, ]$tag <- NA_character_
set_mandatory_IS_vars(new_mand_vars)
mandatory_IS_vars(TRUE)

## -----------------------------------------------------------------------------
reset_mandatory_IS_vars()
mandatory_IS_vars(TRUE)

## -----------------------------------------------------------------------------
matrix_file_suffixes()

## ----eval=FALSE---------------------------------------------------------------
# enable_progress_bars()

## ----echo=FALSE---------------------------------------------------------------
sample_sparse_matrix <- tibble::tribble(
    ~chr, ~integration_locus, ~strand, ~GeneName, ~GeneStrand,
    ~exp1, ~exp2, ~exp3,
    "1", 12324, "+", "NFATC3", "+", 4553, 5345, NA_integer_,
    "6", 657532, "+", "LOC100507487", "+", 76, 545, 5,
    "7", 657532, "+", "EDIL3", "-", NA_integer_, 56, NA_integer_,
)
print(sample_sparse_matrix, width = Inf)

## -----------------------------------------------------------------------------
fs_path <- generate_default_folder_structure()
withr::with_options(list(ISAnalytics.reports = FALSE), code = {
    af <- import_association_file(fs_path$af, root = fs_path$root)
})

## ----echo=FALSE---------------------------------------------------------------
print(head(af))

## ----results='hide'-----------------------------------------------------------
vispa_stats <- import_Vispa2_stats(
    association_file = af,
    join_with_af = FALSE,
    report_path = NULL
)

## ----echo=FALSE---------------------------------------------------------------
print(head(vispa_stats))

## ----message=FALSE, results='hide'--------------------------------------------
matrix_path <- fs::path(
    fs_path$root,
    "PJ01",
    "quantification",
    "POOL01-1",
    "PJ01_POOL01-1_seqCount_matrix.no0.annotated.tsv.gz"
)
matrix <- import_single_Vispa2Matrix(matrix_path)

## ----echo=FALSE---------------------------------------------------------------
matrix

## -----------------------------------------------------------------------------
withr::with_options(list(ISAnalytics.reports = FALSE), {
    matrices <- import_parallel_Vispa2Matrices(af,
        c("seqCount", "fragmentEstimate"),
        mode = "AUTO"
    )
})

## ----echo=FALSE---------------------------------------------------------------
print(head(matrices))

## ----echo=FALSE---------------------------------------------------------------
library(ISAnalytics)
ex_coll <- tibble::tribble(
    ~chr, ~integration_locus, ~strand, ~seqCount, ~CompleteAmplificationID,
    ~SubjectID, ~ProjectID,
    "1", 123454, "+", 653, "SAMPLE1", "SUBJ01", "PJ01",
    "1", 123454, "+", 456, "SAMPLE2", "SUBJ02", "PJ01"
)
knitr::kable(ex_coll, caption = paste(
    "Example of collisions: the same",
    "integration (1, 123454, +) is found",
    "in 2 different independent samples",
    "((SUBJ01, PJ01) & (SUBJ02, PJ01))"
))

## -----------------------------------------------------------------------------
data("integration_matrices", package = "ISAnalytics")
data("association_file", package = "ISAnalytics")
## Multi quantification matrix
no_coll <- remove_collisions(
    x = integration_matrices,
    association_file = association_file,
    report_path = NULL
)
## Matrix list
separated <- separate_quant_matrices(integration_matrices)
no_coll_list <- remove_collisions(
    x = separated,
    association_file = association_file,
    report_path = NULL
)
## Only sequence count
no_coll_single <- remove_collisions(
    x = separated$seqCount,
    association_file = association_file,
    quant_cols = c(seqCount = "Value"),
    report_path = NULL
)

## ----realign------------------------------------------------------------------
other_realigned <- realign_after_collisions(
    sc_matrix = no_coll_single,
    other_matrices = list(fragmentEstimate = separated$fragmentEstimate)
)

## ----echo=FALSE---------------------------------------------------------------
library(ISAnalytics)
print(default_meta_agg(), width = Inf)

## -----------------------------------------------------------------------------
data("association_file", package = "ISAnalytics")
aggregated_meta <- aggregate_metadata(association_file = association_file)

## ----echo=FALSE---------------------------------------------------------------
print(aggregated_meta)

## -----------------------------------------------------------------------------
data("integration_matrices", package = "ISAnalytics")
data("association_file", package = "ISAnalytics")
aggreg <- aggregate_values_by_key(
    x = integration_matrices,
    association_file = association_file,
    value_cols = c("seqCount", "fragmentEstimate")
)

## ----echo=FALSE---------------------------------------------------------------
print(aggreg, width = Inf)

## -----------------------------------------------------------------------------
agg1 <- aggregate_values_by_key(
    x = integration_matrices,
    association_file = association_file,
    key = c("SubjectID", "ProjectID"),
    value_cols = c("seqCount", "fragmentEstimate")
)

## ----echo=FALSE---------------------------------------------------------------
print(agg1, width = Inf)

## -----------------------------------------------------------------------------
agg2 <- aggregate_values_by_key(
    x = integration_matrices,
    association_file = association_file,
    key = "SubjectID",
    lambda = list(mean = ~ mean(.x, na.rm = TRUE)),
    value_cols = c("seqCount", "fragmentEstimate")
)

## ----echo=FALSE---------------------------------------------------------------
print(agg2, width = Inf)

## -----------------------------------------------------------------------------
agg3 <- aggregate_values_by_key(
    x = integration_matrices,
    association_file = association_file,
    key = "SubjectID",
    lambda = list(describe = ~ list(psych::describe(.x))),
    value_cols = c("seqCount", "fragmentEstimate")
)

## ----echo=FALSE---------------------------------------------------------------
print(agg3, width = Inf)

## -----------------------------------------------------------------------------
agg4 <- aggregate_values_by_key(
    x = integration_matrices,
    association_file = association_file,
    key = "SubjectID",
    lambda = list(sum = sum, mean = mean),
    value_cols = c("seqCount", "fragmentEstimate")
)

## ----echo=FALSE---------------------------------------------------------------
print(agg4, width = Inf)

## -----------------------------------------------------------------------------
agg5 <- aggregate_values_by_key(
    x = integration_matrices,
    association_file = association_file,
    key = "SubjectID",
    lambda = list(sum = sum, mean = mean),
    group = c(mandatory_IS_vars()),
    value_cols = c("seqCount", "fragmentEstimate")
)

## ----echo=FALSE---------------------------------------------------------------
print(agg5, width = Inf)

## -----------------------------------------------------------------------------
## Aggregation by standard key
agg <- aggregate_values_by_key(integration_matrices,
    association_file,
    value_cols = c("seqCount", "fragmentEstimate")
)
agg <- agg |> dplyr::filter(TimePoint %in% c("0030", "0060"))

## ----echo=FALSE---------------------------------------------------------------
print(agg, width = Inf)

## -----------------------------------------------------------------------------
sharing_1 <- is_sharing(agg,
    group_key = c(
        "SubjectID", "CellMarker",
        "Tissue", "TimePoint"
    ),
    n_comp = 2,
    is_count = TRUE,
    relative_is_sharing = TRUE,
    minimal = TRUE,
    include_self_comp = FALSE,
    keep_genomic_coord = TRUE
)
sharing_1

## -----------------------------------------------------------------------------
sharing_1_a <- is_sharing(agg,
    group_key = c(
        "SubjectID", "CellMarker",
        "Tissue", "TimePoint"
    ),
    n_comp = 3,
    is_count = TRUE,
    relative_is_sharing = TRUE,
    minimal = TRUE,
    include_self_comp = FALSE,
    keep_genomic_coord = TRUE
)
sharing_1_a

## -----------------------------------------------------------------------------
sharing_1_b <- is_sharing(agg,
    group_key = c(
        "SubjectID", "CellMarker",
        "Tissue", "TimePoint"
    ),
    n_comp = 2,
    is_count = TRUE,
    relative_is_sharing = TRUE,
    minimal = FALSE,
    include_self_comp = TRUE
)
sharing_1_b
heatmaps <- sharing_heatmap(sharing_1_b)

## -----------------------------------------------------------------------------
heatmaps$absolute
heatmaps$on_g1
heatmaps$on_union

## -----------------------------------------------------------------------------
sharing_2 <- is_sharing(agg,
    group_keys = list(
        g1 = c(
            "SubjectID", "CellMarker",
            "Tissue", "TimePoint"
        ),
        g2 = c("SubjectID", "CellMarker"),
        g3 = c("CellMarker", "Tissue")
    )
)
sharing_2

## -----------------------------------------------------------------------------
first_sample <- agg |>
    dplyr::filter(
        SubjectID == "PT001", CellMarker == "MNC", Tissue == "BM",
        TimePoint == "0030"
    )
second_sample <- agg |>
    dplyr::filter(
        SubjectID == "PT001", CellMarker == "MNC", Tissue == "BM",
        TimePoint == "0060"
    )
sharing_3 <- is_sharing(first_sample, second_sample,
    group_key = c(
        "SubjectID", "CellMarker",
        "Tissue", "TimePoint"
    ),
    is_count = TRUE,
    relative_is_sharing = TRUE,
    minimal = TRUE
)
sharing_3

## -----------------------------------------------------------------------------
sharing_3_a <- is_sharing(
    first_sample, second_sample,
    group_key = c(
        "CellMarker", "Tissue"
    ),
    is_count = TRUE,
    relative_is_sharing = TRUE,
    minimal = FALSE
)
sharing_3_a

## -----------------------------------------------------------------------------
df1 <- agg |>
    dplyr::filter(TimePoint == "0030")
df2 <- agg |>
    dplyr::filter(TimePoint == "0060")
df3 <- agg |>
    dplyr::filter(Tissue == "BM")

keys <- list(
    g1 = c("SubjectID", "CellMarker", "Tissue"),
    g2 = c("SubjectID", "Tissue"),
    g3 = c("SubjectID", "CellMarker", "Tissue")
)

sharing_4 <- is_sharing(df1, df2, df3, group_keys = keys)
sharing_4

## -----------------------------------------------------------------------------
sharing_5 <- is_sharing(agg,
    group_keys = list(
        g1 = c(
            "SubjectID", "CellMarker",
            "Tissue", "TimePoint"
        ),
        g2 = c("SubjectID", "CellMarker"),
        g3 = c("CellMarker", "Tissue")
    ), table_for_venn = TRUE
)
sharing_5

## -----------------------------------------------------------------------------
sharing_plots1 <- sharing_venn(sharing_5, row_range = 1, euler = TRUE)
sharing_plots2 <- sharing_venn(sharing_5, row_range = 1, euler = FALSE)

## -----------------------------------------------------------------------------
plot(sharing_plots1[[1]])
plot(sharing_plots2[[1]])

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

