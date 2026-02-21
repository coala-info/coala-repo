# Exploring the MTox700+ library

Gavin Rhys Lloyd

#### 2025-12-22

# Getting Started
The latest versions of *[struct](https://bioconductor.org/packages/3.22/struct)* and `MetMashR` that are compatible
with your
current R version can be installed using BiocManager.

```
# install BiocManager if not present
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

# install MetMashR and dependencies
BiocManager::install("MetMashR")
```

Once installed you can activate the packages in the usual way:

```
# load the packages
library(MetMashR)
library(ggplot2)
library(structToolbox)
library(dplyr)
library(DT)
library(ggplotify)
```

# 1 Introduction

> MTox700+ is a list of toxicologically relevant metabolites derived from
> publications, public databases and relevant toxicological assays.

In this vignette we import the MTox700+ database and combine.merge and “mash” it
with other databases to explore its contents and its coverage of chemical,
biological and toxicological space.

# 2 Importing the MTox700+ database

The MTox700+ database can be imported using the `MTox700plus_database` object.
It can be imported to a data.frame using the `read_database` method.

```
# prep object
MT <- MTox700plus_database(
    version = "latest",
    tag = "MTox700+"
)

# import
df <- read_database(MT)

# show contents
.DT(df)
```

```
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
```

# 3 Exploring the chemical space

The chemical (or “metabolite”) space covered by the
MTox700+ database can be explored in several ways using the data included in
the database, which contains information about the structural
classification of the metabolites based on ChemOnt (a chemical taxonomy) and
ClassyFire (software to compute the taxonomy of a structure)
[10.1186/s13321-016-0174-y].

In this plot we show the number of metabolites in the MTox700+ database that
are assigned to a “superclass” of molecules.

```
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
```

![](data:image/png;base64...)

# 4 Exploring the biological space

To explore the biological space covered by the metabolites in MTox700+ we need
mash the database with additional information about the biological pathways that
the metabolites are part of.

We use the [PathBank](https://pathbank.org/) for this purpose. A
`struct_database` object for PathBank is already included in `MetMashR`.

## 4.1 Importing PathBank

`MetMashR` provides the `PathBank_metabolite_databse` object to import the
PathBank database. You can choose to import:

* The “primary” database. This is a smaller version of the database restricted
  to primary pathways.
* The “complete” database, which includes all pathways in the database.

The “complete” database is a >50mb download, and unzipped is >1Gb. Unzipping
and caching of the database is handled by [BiocFileCache].

For the vignette we restrict to the “primary” PathBank database to keep file
sizes and downloads to a minimum.

We can use the database in two ways:

1. convert it to a source and “mash” it with other sources
2. use it as a lookup table to add information to an existing source.

To explore the biological space covered by MetMashR we will do both.

## 4.2 Comparing PathBank and MTox700+

It is useful to visualise the overlap between PathBank and MTox700+. MTox700+
is a much smaller database due to it being a curated list of metabolites with
toxicologial relevance, and PathBank is more general.

In th example below we import PathBank as a source, and use a venn diagram to
compare the overlap between inchikey identifiers in PathBank and MTox700+.

```
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
```

![](data:image/png;base64...)

The charts show that less than half of the metabolites in MTox700+ are also
present in the PathBank database for primary pathways.

## 4.3 Combining MTox700+ with PathBank

To combine the pathway information in PathBank with the MTox700+ database we
can use PathBank as a lookup table based on inchikeys. To do this we use the
`database_lookup` object.

Note that PathBank is not downloaded a second time; it is automatically
retrieved from the cache.

We request a number of columns from PathBank, including pathway information and
additional identifiers such as HMBD ID and KEGG ID.

```
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
```

We can now visualise e.g. the subject of the pathways captured by the MTox700+
database.

```
C <- annotation_bar_chart(
    factor_name = "Pathway.Subject",
    label_rotation = TRUE,
    label_location = "outside",
    label_type = "percent",
    legend = TRUE
)

chart_plot(C, predicted(X)) + ylim(c(0, 17500))
```

![](data:image/png;base64...)

We can see that MTox700+ largely focuses on metabolites related to Disease
metabolism and general metabolism, which is concomitant with the database
being curated to contain metabolites relevant to toxicology in humans.

## 4.4 Combining records

Metabolites can appear in multiple pathways. The PathBank database therefore
contains multiple records for the same metabolite, and the relationship
between MTox700+ and PathBank is one-to-many.

After obtaining pathway information from PathBank the new table has many more
rows than the original MTox700+ database, as each MTox700+ record has been
replicated for each match in the PathBank database.

e.g. after importing MTox700+ the number of records was:

```
# Number in MTox700+
nrow(predicted(M)$data)
#> [1] 722
```

After combing with PathBank the number of records is:

```
# Number after PathBank lookup
nrow(predicted(X)$data)
#> [1] 25092
```

Sometimes it is useful to collapse this information into a single record per
metabolite. We can use the `combine_records` object and its helper functions to
do this in a `MetMashR` workflow.

```
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
```

We have used the `.unique` helper function so that records for each inchikey are
combined into a single record by only retaining unique values in each field
(column). If there are multiple unique values for a field then they are
combined into a single string using the " || " separator.

We can now extract the pathways associated with a particular metabolite. For
example Glycolic acid:

```
# get index of metabolite
w <- which(predicted(X)$data$metabolite_name == "Glycolic acid")
```

The pathways associated with Glycolic acid are:

```
# print list of pathways
predicted(X)$data$Pathway.Name[w]
#> [1] "Inner Membrane Transport || Glycolate and Glyoxylate Degradation || D-Arabinose Degradation I || Ethylene Glycol Degradation"
```

# 5 Session Info

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] ggplotify_0.1.3               DT_0.34.0
#> [3] dplyr_1.1.4                   structToolbox_1.22.0
#> [5] ggplot2_4.0.1                 metabolomicsWorkbenchR_1.20.0
#> [7] MetMashR_1.4.0                struct_1.22.1
#> [9] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DBI_1.2.3                   gridExtra_2.3
#>  [3] httr2_1.2.2                 rlang_1.1.6
#>  [5] magrittr_2.0.4              otel_0.2.0
#>  [7] matrixStats_1.5.0           compiler_4.5.2
#>  [9] RSQLite_2.4.5               vctrs_0.6.5
#> [11] stringr_1.6.0               pkgconfig_2.0.3
#> [13] fastmap_1.2.0               dbplyr_2.5.1
#> [15] magick_2.9.0                XVector_0.50.0
#> [17] labeling_0.4.3              rmarkdown_2.30
#> [19] tinytex_0.58                purrr_1.2.0
#> [21] bit_4.6.0                   xfun_0.55
#> [23] MultiAssayExperiment_1.36.1 cachem_1.1.0
#> [25] aplot_0.2.9                 jsonlite_2.0.0
#> [27] blob_1.2.4                  DelayedArray_0.36.0
#> [29] R6_2.6.1                    bslib_0.9.0
#> [31] stringi_1.8.7               RColorBrewer_1.1-3
#> [33] GenomicRanges_1.62.1        jquerylib_0.1.4
#> [35] Rcpp_1.1.0                  Seqinfo_1.0.0
#> [37] bookdown_0.46               SummarizedExperiment_1.40.0
#> [39] knitr_1.51                  IRanges_2.44.0
#> [41] BiocBaseUtils_1.12.0        Matrix_1.7-4
#> [43] tidyselect_1.2.1            dichromat_2.0-0.1
#> [45] abind_1.4-8                 yaml_2.3.12
#> [47] ggVennDiagram_1.5.4         curl_7.0.0
#> [49] lattice_0.22-7              tibble_3.3.0
#> [51] plyr_1.8.9                  Biobase_2.70.0
#> [53] withr_3.0.2                 S7_0.2.1
#> [55] evaluate_1.0.5              ontologyIndex_2.12
#> [57] gridGraphics_0.5-1          BiocFileCache_3.0.0
#> [59] zip_2.3.3                   pillar_1.11.1
#> [61] BiocManager_1.30.27         filelock_1.0.3
#> [63] MatrixGenerics_1.22.0       stats4_4.5.2
#> [65] ggfun_0.2.0                 generics_0.1.4
#> [67] sp_2.2-0                    S4Vectors_0.48.0
#> [69] scales_1.4.0                glue_1.8.0
#> [71] tools_4.5.2                 data.table_1.17.8
#> [73] openxlsx_4.2.8.1            forcats_1.0.1
#> [75] fs_1.6.6                    cowplot_1.2.0
#> [77] grid_4.5.2                  tidyr_1.3.2
#> [79] crosstalk_1.2.2             patchwork_1.3.2
#> [81] cli_3.6.5                   rappdirs_0.3.3
#> [83] ggthemes_5.2.0              S4Arrays_1.10.1
#> [85] gtable_0.3.6                yulab.utils_0.2.3
#> [87] sass_0.4.10                 digest_0.6.39
#> [89] BiocGenerics_0.56.0         SparseArray_1.10.8
#> [91] htmlwidgets_1.6.4           farver_2.1.2
#> [93] memoise_2.0.1               htmltools_0.5.9
#> [95] lifecycle_1.0.4             httr_1.4.7
#> [97] bit64_4.6.0-1
```