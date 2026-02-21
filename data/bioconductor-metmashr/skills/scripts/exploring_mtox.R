# Code example from 'exploring_mtox' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    message = FALSE,
    warning = FALSE,
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
suppressWarnings(suppressPackageStartupMessages({
    # load the packages
    library(MetMashR)
    library(ggplot2)
    library(structToolbox)
    library(dplyr)
    library(DT)
    library(ggplotify)
}))

## ----eval=FALSE, include=TRUE-------------------------------------------------
# # load the packages
# library(MetMashR)
# library(ggplot2)
# library(structToolbox)
# library(dplyr)
# library(DT)
# library(ggplotify)

## -----------------------------------------------------------------------------
# prep object
MT <- MTox700plus_database(
    version = "latest",
    tag = "MTox700+"
)

# import
df <- read_database(MT)

# show contents
.DT(df)

## -----------------------------------------------------------------------------
# prepare workflow that uses MTox700+ as a source
M <-
    import_source() +
    trim_whitespace(
        column_name = ".all",
        which = "both",
        whitespace = "[\\h\\v]"
    )

# apply
M <- model_apply(M, MT)

## ----fig.height=5,fig.width=7.5-----------------------------------------------
# initialise chart object
C <- annotation_bar_chart(
    factor_name = "superclass",
    label_rotation = TRUE,
    label_location = "outside",
    label_type = "percent",
    legend = TRUE
)

# plot
g <- 
    chart_plot(C, predicted(M)) + 
    ylim(c(0, 600)) +
    guides(
        fill = guide_legend(ncol = 1, title = NULL),byrow=TRUE) +
    theme(
        legend.position = "right", 
        legend.margin = margin(),
        legend.key.size = unit(0.5, "cm"),   
        legend.text = element_text(size = 10)
    )

# layout
leg <- cowplot::get_legend(g)
cowplot::plot_grid(g + theme(legend.position = "none"), leg,
    nrow = 1,
    rel_widths = c(50, 50)
)

## ----fig.width=8,warning=FALSE------------------------------------------------
# object M already contains the MTox700+ database as a source

# prepare PathBank as a source
P <- PathBank_metabolite_database(
    version = "primary",
    tag = "PathBank"
)

# import
P <- read_source(P)

# prepare chart
C <- annotation_venn_chart(
    factor_name = c("inchikey", "InChI.Key"), legend = FALSE,
    fill_colour = ".group",
    line_colour = "white"
)

# plot
g1 <- chart_plot(C, predicted(M), P)

C <- annotation_upset_chart(
    factor_name = c("inchikey", "InChI.Key"),
)
g2 <- as.ggplot(chart_plot(C, predicted(M), P)) +
  theme(plot.margin = unit(c(1, 1, 1, 1), "cm"))
cowplot::plot_grid(g1, g2, nrow = 1, labels = c("Venn diagram", "UpSet plot"))

## -----------------------------------------------------------------------------
# prepare object
X <- database_lookup(
    query_column = "inchikey",
    database = P$data,
    database_column = "InChI.Key",
    include = c(
        "PathBank.ID", "Pathway.Name", "Pathway.Subject", "Species",
        "HMDB.ID", "KEGG.ID", "ChEBI.ID", "DrugBank.ID", "SMILES"
    ),
    suffix = ""
)

# apply
X <- model_apply(X, predicted(M))

## -----------------------------------------------------------------------------
C <- annotation_bar_chart(
    factor_name = "Pathway.Subject",
    label_rotation = TRUE,
    label_location = "outside",
    label_type = "percent",
    legend = TRUE
)

chart_plot(C, predicted(X)) + ylim(c(0, 17500))

## -----------------------------------------------------------------------------
# Number in MTox700+
nrow(predicted(M)$data)

## -----------------------------------------------------------------------------
# Number after PathBank lookup
nrow(predicted(X)$data)

## -----------------------------------------------------------------------------
# prepare object
X <- database_lookup(
    query_column = "inchikey",
    database = P$data,
    database_column = "InChI.Key",
    include = c(
        "PathBank.ID", "Pathway.Name", "Pathway.Subject", "Species",
        "HMDB.ID", "KEGG.ID", "ChEBI.ID", "DrugBank.ID", "SMILES"
    ),
    suffix = ""
) +
    combine_records(
        group_by = "inchikey",
        default_fcn = fuse_unique(" || ")
    )

# apply
X <- model_apply(X, predicted(M))

## -----------------------------------------------------------------------------
# get index of metabolite
w <- which(predicted(X)$data$metabolite_name == "Glycolic acid")

## -----------------------------------------------------------------------------
# print list of pathways
predicted(X)$data$Pathway.Name[w]

## -----------------------------------------------------------------------------
sessionInfo()

