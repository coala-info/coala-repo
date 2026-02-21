# Code example from 'annotate_mixtures' vignette. See references/ for full tutorial.

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
    library(ggplotify)
})

## ----eval=FALSE, include=TRUE-------------------------------------------------
# # load the packages
# library(MetMashR)
# library(ggplot2)
# library(structToolbox)
# library(dplyr)
# library(DT)
# library(ggplotify)

## -----------------------------------------------------------------------------
# prepare workflow
M <- import_source() +
    add_labels(
        labels = c(
            assay = "placeholder", # will be replaced later
            source_name = "CD"
        )
    ) +
    filter_labels(
        column_name = "compound_match",
        labels = "Full match",
        mode = "include"
    ) +
    filter_labels(
        column_name = "compound_match",
        labels = "Full match",
        mode = "include"
    ) +
    filter_range(
        column_name = "library_ppm_diff",
        upper_limit = 2,
        lower_limit = -2,
        equal_to = FALSE
    ) +
    combine_records(
        group_by = c("compound", "ion"),
        default_fcn = select_max(
            max_col = "mzcloud_score",
            keep_NA = FALSE,
            use_abs = TRUE
        )
    )

# place to store results
CD <- list()
for (assay in c("HILIC_NEG", "HILIC_POS", "LIPIDS_NEG", "LIPIDS_POS")) {
    # prepare source
    AT <- cd_source(
        source = c(
            system.file(
                paste0("extdata/MTox/CD/", assay, ".xlsx"),
                package = "MetMashR"
            ),
            system.file(
                paste0("extdata/MTox/CD/", assay, "_comp.xlsx"),
                package = "MetMashR"
            )
        ),
        tag = paste0("CD_", assay)
    )

    # update labels in workflow
    M[2]$labels$assay <- assay

    # apply workflow to source
    CD[[assay]] <- model_apply(M, AT)
}

## -----------------------------------------------------------------------------
predicted(CD$HILIC_NEG)

## ----echo=FALSE---------------------------------------------------------------
.DT(predicted(CD$HILIC_NEG)$data)

## -----------------------------------------------------------------------------
C <- annotation_pie_chart(
    factor_name = "compound_match",
    label_rotation = FALSE,
    label_location = "outside",
    legend = TRUE,
    label_type = "percent",
    centre_radius = 0.5,
    centre_label = ".total"
)

## -----------------------------------------------------------------------------
# plot individual charts
g1 <- chart_plot(C, predicted(CD$HILIC_NEG[3])) +
    ggtitle("Compound matches\nafter filtering") +
    theme(plot.title = element_text(hjust = 0.5))


g2 <- chart_plot(C, predicted(CD$HILIC_NEG[2])) +
    ggtitle("Compound matches\nbefore filtering") +
    theme(plot.title = element_text(hjust = 0.5))


# get legend
leg <- cowplot::get_legend(g2)

# layout
cowplot::plot_grid(
    g2 + theme(legend.position = "none"),
    g1 + theme(legend.position = "none"),
    leg,
    nrow = 1,
    rel_widths = c(1, 1, 0.5)
)

## -----------------------------------------------------------------------------
C <- annotation_histogram(
    factor_name = "library_ppm_diff", vline = c(-2, 2)
)
G <- list()
G$HILIC_NEG <- chart_plot(C, predicted(CD$HILIC_NEG[2]))
G$HILIC_POS <- chart_plot(C, predicted(CD$HILIC_POS[3]))

cowplot::plot_grid(plotlist = G, labels = c("HILIC_NEG", "HILIC_POS"))

## -----------------------------------------------------------------------------
# prepare workflow
M <- import_source() +
    add_labels(
        labels = c(
            assay = "placeholder", # will be replaced later
            source_name = "LS"
        )
    ) +
    filter_labels(
        column_name = "Grade",
        labels = c("A", "B"),
        mode = "include"
    ) +
    filter_labels(
        column_name = "Grade",
        labels = c("A", "B"),
        mode = "include"
    ) +
    combine_records(
        group_by = c("LipidIon"),
        default_fcn = select_min(
            min_col = "library_ppm_diff",
            keep_NA = FALSE,
            use_abs = TRUE
        )
    )

# place to store results
LS <- list()
for (assay in c("HILIC_NEG", "HILIC_POS", "LIPIDS_NEG", "LIPIDS_POS")) {
    # prepare source
    AT <- ls_source(
        source = system.file(
            paste0("extdata/MTox/LS/MTox_2023_", assay, ".txt"),
            package = "MetMashR"
        ),
        tag = paste0("LS_", assay)
    )

    # update labels in workflow
    M[2]$labels$assay <- assay

    # apply workflow to source
    LS[[assay]] <- model_apply(M, AT)
}

## -----------------------------------------------------------------------------
predicted(LS$LIPIDS_NEG)

## ----echo=FALSE---------------------------------------------------------------
.DT(predicted(LS$LIPIDS_NEG)$data)

## -----------------------------------------------------------------------------
C <- annotation_pie_chart(
    factor_name = "Grade",
    label_rotation = FALSE,
    label_location = "outside",
    label_type = "percent",
    legend = FALSE,
    centre_radius = 0.5,
    centre_label = ".total"
)
g1 <- chart_plot(C, predicted(LS$LIPIDS_NEG)) +
    ggtitle("Grades after filtering") +
    theme(plot.margin = unit(c(1, 1.5, 1, 1.5), "cm"))

g2 <- chart_plot(C, predicted(LS$LIPIDS_NEG[1])) +
    ggtitle("Grades before filtering") +
    theme(plot.margin = unit(c(1, 1.5, 1, 1.5), "cm"))


cowplot::plot_grid(g2, g1, nrow = 1, align = "v")

## -----------------------------------------------------------------------------
# prepare venn chart object
C <- annotation_venn_chart(
    factor_name = "compound",
    line_colour = "white",
    fill_colour = ".group",
    legend = TRUE,
    labels = FALSE
)

## plot
# get all CD tables
cd <- lapply(CD, predicted)
g1 <- chart_plot(C, cd) + ggtitle("Compounds in CD per assay")

# get all LS tables
C$factor_name <- "LipidName"
ls <- lapply(LS, predicted)
g2 <- chart_plot(C, ls) + ggtitle("Compounds in LS per assay")

# prepare upset object
C2 <- annotation_upset_chart(
    factor_name = "compound",
    nintersects = 10,
)
g3 <- chart_plot(C2, cd)
C2$factor_name <- "LipidName"
g4 <- chart_plot(C2, ls)

# layout
cowplot::plot_grid(g1, g2, as.ggplot(g3), as.ggplot(g4), nrow = 2)


## -----------------------------------------------------------------------------
# get all the cleaned annotation tables in one list
all_source_tables <- lapply(c(CD, LS), predicted)

# prepare to merge
combine_workflow <-
    combine_sources(
        source_list = all_source_tables,
        matching_columns = c(
            name = "LipidName",
            name = "compound",
            adduct = "ion",
            adduct = "LipidIon"
        ),
        keep_cols = ".all",
        source_col = "annotation_table",
        exclude_cols = NULL,
        tag = "combined"
    )

# merge
combine_workflow <- model_apply(combine_workflow, lcms_table())

# show
predicted(combine_workflow)

## -----------------------------------------------------------------------------
C <- annotation_pie_chart(
    factor_name = "assay",
    label_rotation = FALSE,
    label_location = "outside",
    label_type = "percent",
    legend = TRUE,
    centre_radius = 0.5,
    centre_label = ".total"
)

chart_plot(C, predicted(combine_workflow)) +
    ggtitle("Annotations per assay") +
    theme(plot.margin = unit(c(1, 1.5, 1, 1.5), "cm")) +
    guides(fill = guide_legend(title = "Assay"))

## -----------------------------------------------------------------------------
# change to plot source_name column
C$factor_name <- "source_name"
chart_plot(C, predicted(combine_workflow)) +
    ggtitle("Annotations per source") +
    theme(plot.margin = unit(c(1, 1.5, 1, 1.5), "cm")) +
    guides(fill = guide_legend(title = "Source"))

## -----------------------------------------------------------------------------
# import cached results
inchikey_cache <- rds_database(
    source = file.path(
        system.file("cached", package = "MetMashR"),
        "pubchem_inchikey_mtox_cache.rds"
    )
)

id_workflow <-
    pubchem_property_lookup(
        query_column = "name",
        search_by = "name",
        suffix = "",
        property = "InChIKey",
        records = "best",
        cache = inchikey_cache
    )

id_workflow <- model_apply(id_workflow, predicted(combine_workflow))

## -----------------------------------------------------------------------------
# prepare cached results for vignette
inchikey_cache2 <- rds_database(
    source = file.path(
        system.file("cached", package = "MetMashR"),
        "pubchem_inchikey_mtox_cache2.rds"
    )
)
inchikey_cache3 <- rds_database(
    source = file.path(
        system.file("cached", package = "MetMashR"),
        "pubchem_inchikey_mtox_cache3.rds"
    )
)

N <- normalise_strings(
    search_column = "name",
    output_column = "normalised_name",
    dictionary = c(
        # custom dictionary
        list(
            # replace "NP" with "Compound NP"
            list(pattern = "^NP-", replace = "Compound NP-"),
            # replace ? with NA, since this is ambiguous
            list(pattern = "?", replace = NA, fixed = TRUE),
            # remove terms in trailing brackets e.g." (ATP)"
            list(pattern = "\\ \\([^\\)]*\\)$", replace = ""),
            # replace known abbreviations
            list(
                pattern = "(+/-)9-HpODE",
                replace = "9-hydroperoxy-10E,12Z-octadecadienoic acid",
                fixed = TRUE
            ),
            list(
                pattern = "(+/-)19(20)-DiHDPA",
                replace =
                    "19,20-dihydroxy-4Z,7Z,10Z,13Z,16Z-docosapentaenoic acid",
                fixed = TRUE
            )
        ),
        # replace greek characters
        greek_dictionary,
        # remove racemic properties
        racemic_dictionary
    )
) +
    pubchem_property_lookup(
        query_column = "normalised_name",
        search_by = "name",
        suffix = "_norm",
        property = "InChIKey",
        records = "best",
        cache = inchikey_cache2
    ) +
    opsin_lookup(
        query_column = "normalised_name",
        suffix = "_opsin",
        output = "stdinchikey",
        cache = inchikey_cache3
    ) +
    prioritise_columns(
        column_names = c("stdinchikey_opsin", "InChIKey_norm", "InChIKey"),
        output_name = "inchikey",
        source_name = "inchikey_source",
        clean = TRUE
    )

N <- model_apply(N, predicted(id_workflow))

## -----------------------------------------------------------------------------
# venn inchikey columns
C <- annotation_venn_chart(
    factor_name = c("InChIKey", "InChIKey_norm", "stdinchikey_opsin"),
    line_colour = "white",
    fill_colour = ".group",
    legend = TRUE,
    labels = FALSE
)
chart_plot(C, predicted(N[3])) +
    guides(
        fill = guide_legend(title = "Source"),
        colour = guide_legend(title = "Source")
    ) +
    theme(plot.margin = unit(c(1, 1.5, 1, 1.5), "cm"))

## -----------------------------------------------------------------------------
# upset inchikey columns
C <- annotation_upset_chart(
    factor_name = c("InChIKey", "InChIKey_norm", "stdinchikey_opsin"),
    nintersects = 10
)
chart_plot(C, predicted(N[3]))

## -----------------------------------------------------------------------------
# pie source of inchikey
C <- annotation_pie_chart(
    factor_name = "inchikey_source",
    label_rotation = FALSE,
    label_location = "outside",
    label_type = "percent",
    legend = TRUE,
    centre_radius = 0.5,
    centre_label = ".total",
    count_na = TRUE
)
chart_plot(C, predicted(N)) +
    guides(
        fill = guide_legend(title = "Source"),
        colour = guide_legend(title = "Source")
    ) +
    theme(plot.margin = unit(c(1, 1.5, 1, 1.5), "cm"))

## -----------------------------------------------------------------------------
# prepare workflow
FL <- filter_labels(
    column_name = "inchikey_source",
    labels = "InChIKey",
    mode = "exclude"
)
# apply
FF <- model_apply(FL, predicted(N))

# print summary
predicted(FF)

## -----------------------------------------------------------------------------
# prepare object
R <- rds_database(
    source = file.path(
        system.file("extdata", package = "MetMashR"),
        "standard_mixtures.rds"
    ),
    .writable = FALSE
)

# read
R <- read_source(R)

## ----echo=FALSE---------------------------------------------------------------
.DT(R$data)

## -----------------------------------------------------------------------------
# convert standard mixtures to source, then get inchikey from MTox700+
SM <- import_source() +
    filter_na(
        column_name = "rt"
    ) +
    filter_na(
        column_name = "median_ms2_scans"
    ) +
    filter_na(
        column_name = "mzcloud_id"
    ) +
    filter_range(
        column_name = "median_ms2_scans",
        upper_limit = Inf,
        lower_limit = 0,
        equal_to = TRUE
    ) +
    database_lookup(
        query_column = "hmdb_id",
        database_column = "hmdb_id",
        database = MTox700plus_database(),
        include = "inchikey",
        suffix = "",
        not_found = NA
    ) +
    id_counts(
        id_column = "inchikey",
        count_column = "inchikey_count",
        count_na = FALSE
    )
# apply
SM <- model_apply(SM, R)

## -----------------------------------------------------------------------------
C <- annotation_venn_chart(
    factor_name = "inchikey",
    group_column = "ion_mode",
    line_colour = "white",
    fill_colour = ".group",
    legend = TRUE,
    labels = FALSE
)

## plot
chart_plot(C, predicted(SM))

## ----fig.width=4--------------------------------------------------------------
# get processed data
AN <- predicted(FF)
AN$tag <- "Annotations"
sM <- predicted(SM)
sM$tag <- "Standards"

# prepare chart
C <- annotation_venn_chart(
    factor_name = "inchikey",
    line_colour = "white",
    fill_colour = ".group"
)

# plot
chart_plot(C, sM, AN) + ggtitle("All assays, all sources")

## ----fig.height  = 10, fig.width = 8------------------------------------------
G <- list()
VV <- list()
for (k in c("HILIC_NEG", "HILIC_POS", "LIPIDS_NEG", "LIPIDS_POS")) {
    wf <- filter_labels(
        column_name = "assay",
        labels = k,
        mode = "include"
    )
    wf1 <- model_apply(wf, AN)
    wf$column_name <- "ion_mode"
    wf2 <- model_apply(wf, sM)
    G[[k]] <- chart_plot(C, predicted(wf2), predicted(wf1))

    V <- filter_venn(
        factor_name = "inchikey",
        tables = list(predicted(wf1)),
        mode = 'exclude'
    )
    V <- model_apply(V, predicted(wf2))
    VV[[k]] <- predicted(V)
    VV[[k]]$tag <- k
}
r1 <- cowplot::plot_grid(
    plotlist = G, nrow = 2,
    labels = c("HILIC_NEG", "HILIC_POS", "LIPIDS_NEG", "LIPIDS_POS")
)

cowplot::plot_grid(r1, chart_plot(C, VV), nrow = 2, rel_heights = c(1, 0.5))

## ----fig.height  = 3, fig.width = 8-------------------------------------------
G <- list()
for (k in c("CD", "LS")) {
    wf <- filter_labels(
        column_name = "source_name",
        labels = k,
        mode = "include"
    )
    wf1 <- model_apply(wf, AN)

    G[[k]] <- chart_plot(C, sM, predicted(wf1))
}
cowplot::plot_grid(plotlist = G, nrow = 1, labels = c("CD", "LS"))

## -----------------------------------------------------------------------------
sessionInfo()

