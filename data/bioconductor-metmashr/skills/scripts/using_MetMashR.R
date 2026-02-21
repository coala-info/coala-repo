# Code example from 'using_MetMashR' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.align = "center"
)

.DT <- function(x) {
    dt_options <- list(
        scrollX = TRUE,
        pageLength = 6,
        dom = "t",
        initComplete = DT::JS(
            "function(settings, json) {",
            "$(this.api().table().header()).css({'font-size':'10pt'});",
            "}"
        )
    )

    x %>%
        DT::datatable(options = dt_options, rownames = FALSE) %>%
        DT::formatStyle(
            columns = colnames(x),
            fontSize = "10pt"
        )
}

library(BiocStyle)

## ----eval = FALSE, include = TRUE---------------------------------------------
# # install BiocManager if not present
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# # install MetMashR and dependencies
# BiocManager::install("MetMashR")

## ----eval=TRUE, include=FALSE-------------------------------------------------
suppressPackageStartupMessages({
    # load the packages
    library(MetMashR)
    library(ggplot2)
    library(structToolbox)
    library(dplyr)
    library(DT)
})

## ----eval=FALSE, include=TRUE-------------------------------------------------
# # load the packages
# library(struct)
# library(MetMashR)
# library(metabolomicsWorkbenchR)
# library(ggplot2)

## -----------------------------------------------------------------------------
# prepare source object
AT <- ls_source(
    source = system.file(
        paste0("extdata/MTox/LS/MTox_2023_HILIC_POS.txt"),
        package = "MetMashR"
    )
)

# read source
AT <- read_source(AT)

# show info
AT

## -----------------------------------------------------------------------------
# prepare source object
MT <- MTox700plus_database()

# read
MT <- read_source(MT)

# show
MT

## -----------------------------------------------------------------------------
# prepare source object
MT <- MTox700plus_database()

# read to data.frame
df <- read_database(MT)

# show
.DT(df)

## -----------------------------------------------------------------------------
# prepare source object
AT <- ls_source(
    source = system.file(
        paste0("extdata/MTox/LS/MTox_2023_HILIC_POS.txt"),
        package = "MetMashR"
    )
)

# prepare workflow
WF <- import_source()

# apply workflow to annotation source
WF <- model_apply(WF, AT)

# show
predicted(WF)

## -----------------------------------------------------------------------------
# prepare source object
AT <- ls_source(
    source = system.file(
        paste0("extdata/MTox/LS/MTox_2023_HILIC_POS.txt"),
        package = "MetMashR"
    )
)

# prepare workflow
WF <-
    # step 1 import source from file
    import_source() +
    # step 2 filter the "Grade" column to only include "A" and "B"
    filter_labels(
        column_name = "Grade",
        labels = c("A", "B"),
        mode = "include"
    )

# apply workflow to annotation source
WF <- model_apply(WF, AT)

# show
predicted(WF)

## -----------------------------------------------------------------------------
# source after import and before filtering
predicted(WF[1])

## -----------------------------------------------------------------------------
# prepare source object
AT <- ls_source(
    source = system.file(
        paste0("extdata/MTox/LS/MTox_2023_HILIC_POS.txt"),
        package = "MetMashR"
    )
)

# prepare cache
TF <- rds_database(
    source = tempfile()
)

# prepare workflow
WF <-
    # step 1 import source from file
    import_source() +
    # step 2 filter the "Grade" column to only include "A" and "B"
    filter_labels(
        column_name = "Grade",
        labels = c("A", "B"),
        mode = "include"
    ) +
    # step 3 query lipidmaps api for inchikey
    lipidmaps_lookup(
        query_column = "LipidName",
        context = "compound",
        context_item = "abbrev",
        output_item = "inchi_key",
        cache = TF,
        suffix = ""
    )

# apply workflow to annotation source
WF <- model_apply(WF, AT)

# show
predicted(WF)

## -----------------------------------------------------------------------------
# retrieve cache
TF <- read_source(TF)

# filter records with no inchikey
FI <-
    filter_na(
        column_name = "inchi_key"
    )

# apply
FI <- model_apply(FI, TF)

# show
.DT(predicted(FI)$data)

## -----------------------------------------------------------------------------
custom_dict <- list(
    list(
        pattern = "AcCa",
        replace = "CAR",
        fixed = TRUE
    ),
    list(
        pattern = "AEA",
        replace = "NAE",
        fixed = TRUE
    ),
    list(
        pattern = "_",
        replace = "/",
        fixed = TRUE
    )
)

## -----------------------------------------------------------------------------
# prepare workflow
WF <-
    # step 1 import source from file
    import_source() +
    # step 2 filter the "Grade" column to only include "A" and "B"
    filter_labels(
        column_name = "Grade",
        labels = c("A", "B"),
        mode = "include"
    ) +
    # step 3 normalise lipid names using the custom dictionary:
    normalise_strings(
        search_column = "LipidName",
        output_column = "normalised_name",
        dictionary = custom_dict
    ) +
    # step 4 query lipidmaps api for inchikey using the names provided by
    # LipidSearch
    lipidmaps_lookup(
        query_column = "LipidName",
        context = "compound",
        context_item = "abbrev",
        output_item = "inchi_key",
        suffix = "_LipidName",
        cache = TF
    ) +
    # step 5 query lipidmaps api for inchikey using the names provided by
    # LipidSearch
    lipidmaps_lookup(
        query_column = "normalised_name",
        context = "compound",
        context_item = "abbrev",
        output_item = "inchi_key",
        suffix = "_normalised"
    )

# apply workflow to annotation source
WF <- model_apply(WF, AT)

#  show result table for relevant columns
.DT(predicted(WF)$data[, c(
    "LipidName", "normalised_name",
    "inchi_key_LipidName", "inchi_key_normalised"
)])

## -----------------------------------------------------------------------------
# prepare workflow
CR <- combine_records(
    group_by = "LipidName",
    default_fcn = fuse_unique(separator = "; "),
    fcns = list(
        count = count_records()
    )
)

# apply to previous output
CR <- model_apply(CR, predicted(WF))

# show output for relevant columns
.DT(predicted(CR)$data[, c(
    "LipidName", "normalised_name",
    "inchi_key_normalised", "count"
)])

## -----------------------------------------------------------------------------
sessionInfo()

