# Code example from 'Extending_MetMashR' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
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
    library(struct)
    library(MetMashR)
    library(metabolomicsWorkbenchR)
    library(ggplot2)
})

## ----eval=FALSE, include=TRUE-------------------------------------------------
# # load the packages
# library(struct)
# library(MetMashR)
# library(metabolomicsWorkbenchR)
# library(ggplot2)

## ----example-get-data,eval=FALSE,include=TRUE---------------------------------
# # get annotations
# AN <- do_query(
#     context = "study",
#     input_item = "analysis_id",
#     input_value = "AN000465",
#     output_item = "metabolites"
# )

## ----include=FALSE,eval=TRUE--------------------------------------------------
AN <- readRDS(
    system.file("extdata/AN000465_subset.rds", package = "MetMashR")
)

## -----------------------------------------------------------------------------
AT <- annotation_table(data = AN, id_column = NULL)

## -----------------------------------------------------------------------------
.mwb_source <- setClass(
    "mwb_source",
    contains = c("annotation_database"),
    prototype = list(
        name = "Import from Metabolomics Workbench",
        libraries = "metabolomicsWorkbenchR"
    )
)

## -----------------------------------------------------------------------------
mwb_source <- function(...) {
    # new object
    out <- new_struct(
        "mwb_source",
        ...
    )
    return(out)
}

## ----eval=TRUE,include=TRUE---------------------------------------------------
setMethod(
    f = "read_database",
    signature = c("mwb_source"),
    definition = function(obj) {
        ## get annotations using metabolomicsWorkbenchR
        # AN = do_query(
        #    context = "study",
        #    input_item = "analysis_id",
        #    input_value = M$analysis_id,
        #    output_item = "metabolites")

        ## for vignette use locally cached subset
        AN <- readRDS(
            system.file("extdata/AN000465_subset.rds", package = "MetMashR")
        )

        return(AN)
    }
)

## -----------------------------------------------------------------------------
# initialise source
SRC <- mwb_source(
    source = "AN000465"
)

# import
AT <- read_source(SRC)

## ----new-empty-removal-obj----------------------------------------------------
set_struct_obj(
    class_name = "drop_empty_columns",
    struct_obj = "model",
    params = character(0),
    outputs = c(updated = "annotation_source"),
    private = character(0),
    prototype = list(
        name = "Drop empty columns",
        description = paste0(
            "A workflow step that removes columns from an annotation table ",
            "where all rows are NA."
        ),
        predicted = "updated"
    )
)

## -----------------------------------------------------------------------------
M <- drop_empty_columns()
show(M)

## -----------------------------------------------------------------------------
set_obj_method(
    class_name = "drop_empty_columns",
    method_name = "model_apply",
    signature = c("drop_empty_columns", "annotation_source"),
    definition = function(M, D) {
        # search for columns of NA
        W <- lapply( # for each column
            D$data, # in the annotation table
            function(x) {
                all(is.na(x)) # return TRUE if all rows are NA
            }
        )

        # get index of columns with all rows NA
        idx <- which(unlist(W))

        # if any found, remove from annotation table
        if (length(idx) > 0) {
            D$data[, idx] <- NULL
        }

        # update model object
        M$updated <- D

        # return object
        return(M)
    }
)

## -----------------------------------------------------------------------------
M <- model_apply(M, AT)

## -----------------------------------------------------------------------------
ncol(AT$data)

## -----------------------------------------------------------------------------
ncol(M$updated$data)

## -----------------------------------------------------------------------------
# define new model object
set_struct_obj(
    class_name = "remove_suffix",
    struct_obj = "model",
    params = c(clean = "logical", column_name = "character"),
    outputs = c(updated = "annotation_source"),
    prototype = list(
        name = "Remove suffix",
        description = paste0(
            "A workflow step that removes suffixes from molecule names by ",
            "splitting a string at the last underscore an retaining the part",
            "of the string before the underscore."
        ),
        predicted = "updated",
        clean = FALSE,
        column_name = "V1"
    )
)

# define method for new object
set_obj_method(
    class_name = "remove_suffix",
    method_name = "model_apply",
    signature = c("remove_suffix", "annotation_source"),
    definition = function(M, D) {
        # get list of molecule names
        x <- D$data[[M$column_name]]

        # split string at last underscore
        s <- strsplit(x, "_(?!.*_)", perl = TRUE)

        # get left hand side
        s <- lapply(s, "[", 1)

        # if clean replace existing column, otherwise new column
        if (M$clean) {
            D$data[[M$column_name]] <- unlist(s)
        } else {
            D$data$name.fixed <- unlist(x)
        }

        # update model object
        M$updated <- D

        # return object
        return(M)
    }
)

## ----eval=FALSE,include = TRUE------------------------------------------------
# # refmet
# refmet <- mwb_refmet_database()
# 
# # pubchem caches
# pubchem_cid_cache <- rds_database(
#     source = system.file("cached/pubchem_cid_cache.rds",
#         package = "MetMashR"
#     )
# )
# pubchem_smile_cache <- rds_database(
#     source = system.file("cached/pubchem_smiles_cache.rds",
#         package = "MetMashR"
#     )
# )

## ----eval=TRUE,include=FALSE--------------------------------------------------
refmet <- mwb_refmet_database()

pubchem_cid_cache <- rds_database(
    source = file.path(
        system.file("cached", package = "MetMashR"),
        "pubchem_cid_cache.rds"
    )
)
pubchem_smile_cache <- rds_database(
    source = file.path(
        system.file("cached", package = "MetMashR"),
        "pubchem_smiles_cache.rds"
    )
)

## ----message=FALSE, include=TRUE, eval=TRUE-----------------------------------
# prepare sequence
M <- import_source() +
    drop_empty_columns() +
    remove_suffix(
        clean = TRUE,
        column_name = "metabolite_name"
    ) +
    database_lookup(
        query_column = "refmet_name",
        database_column = "name",
        database = refmet,
        suffix = "_mwb",
        include = "pubchem_cid"
    ) +
    pubchem_compound_lookup(
        query_column = "metabolite_name",
        search_by = "name",
        suffix = "_pc",
        output = "cids",
        records = "best",
        delay = 0.2,
        cache = pubchem_cid_cache
    ) +
    prioritise_columns(
        column_names = c("pubchem_cid_mwb", "CID_pc"),
        output_name = "pubchem_cid",
        source_name = "pubchem_cid_source",
        source_tags = c("mwb", "pc"),
        clean = TRUE
    ) +
    pubchem_property_lookup(
        query_column = "pubchem_cid",
        search_by = "cid",
        suffix = "",
        property = "CanonicalSMILES",
        delay = 0.2,
        cache = pubchem_smile_cache
    )

# apply sequence
M <- model_apply(M, mwb_source(source = "AN000465"))

## -----------------------------------------------------------------------------
sessionInfo()

