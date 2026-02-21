# Introduction to the tidysbml package

#### Veronica Paparozzi

#### 2025-10-30

Abstract

The Systems Biology Markup Language (SBML) is a format based on XML (eXtensible Markup Language) used to describe biological pathways in a sherable and detailed standard form. This vignette aims to introduce and show the functions workflow to be used to convert an SBML file into a list of R dataframes through the *tidysbml* package. The package provides conversion for all SBML levels and versions available so far, in particular it is designed and tested to work with level 3 version 2 SBML or earlier. By means of its functions, the package can provide either a complete extraction, resulting in a list of at most 4 dataframes (i.e. one for listOfCompartments, one for listOfSpecies and two for the listOfReactions content), or a partial extraction, where the user may choose which of the four dataframes has to be exported.

The aim of this package is to supply easy extraction and manipulation of SBML information by insertion in tabular data structures. Because of descriptive nature of SBML documents, the dataframe format is particularly suitable for easily access data and be able to perform subsequent analysis. Specially, this type of conversion enables easy data interrogation by means of tidyverse verbs in order to facilitate, for instance, usage of `biomaRt` and `igraph`-like packages. The involvement in the Bioconductor project establishes a direct and consistent connection with bioinformatics community while providing cooperation of tools useful also within the frame of systems biology and, in general, for the analysis of biological data.

In order to illustrate the package functioning, we used as examples an SBML file (Hucka et al. 2019) extracted from Reactome (Milacic et al. 2023), an open-source, open-access and peer-reviewed biological pathway database. Namely, the pathway is the “Aryl hydrocarbon receptor signalling” (R-HSA-8937144 (Jassal 2016)).

After providing installation instructions, the first section describes the dataframes structure, in the subsequent two sections are described the tidysbml steps to follow for pursuing the SBML conversion, while in the last one are shown some examples to integrate tidysbml dataframes with other Bioconductor packages (i.e. biomaRt and RCy3). In the following, it is useful to distinguish the SBML tags names using *italic* and the R commands with `teletype` fonts, respectively. Also, the terms ‘tag’ and ‘component’ are used interchangeably.

## Installation

To install *tidysbml* from Bioconductor, run

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("tidysbml")
```

## General dataframes structure

The SBML components of main interest for this package are *listOfCompartments*, *listOfSpecies* and *listOfReactions*. Due to the underlying SBML format, these dataframes may generally consist of the following three sets of columns: (i) Attributes, involving tags such as *id*, *metaid*, *name*, etc., (ii) Notes, consisting only of *notes* tag and (iii) Annotation, whose qualifiers are tags like *bqmodel:is*, *bqbiol:is*, *bqbiol:hasPart*, etc. Each tag is exported in one separate column. Columns for tags in the Attributes set are named as the tag name, notes column is named ‘notes’, while Annotation columns are prefixed by ‘annotation\_’ followed by tag name after colon symbol (‘:’), for instance column with *bqbiol:is* tag content is labelled ‘annotation\_is’. If one entity possesses multiple tags with the same name, the repeated column name is accompanied by a number (from the second copy it starts from ’\_1’). Whether more values are contained in one tag (e.g. as happens for Annotation tags such as *bqbiol:hasPart*, *bqbiol:isDescribedBy*, or also Notes column) they are separated by delimiters like " " (i.e. single space character) for Annotation values and “|” (i.e. pipe character) for Notes. Also, based on the selected component, the respective dataframe may contain other columns, depending on the xml structure of the underlying component’s class. See for instance the `df_species_in_reactions` dataframe described in the following.

## Converting SBML into a R list

The first step to convert an SBML file into R dataframes is to convert the SBML document into an R list object, by means of the `sbml_as_list()` function. In fact, all the other functions in this package require a list as input. The sole exception is given by `as_dfs()` which incorporates this conversion function and therefore may also receive directly an SBML file as first argument (and not exclusively an SBML converted into a list object).

The `sbml_as_list()` function exploits functions for reading and converting xml files from the `xml2` R package (Wickham, Hester, and Ooms 2023) and outputs an appropriate type of list. In the following a such list is referred as SBML-converted list. The first argument reads the file path where the SBML file is located, the second one sets the information about which is the SBML component the user wants to look at (i.e. among the *listOfSpecies*, *listOfCompartments* and *listOfReactions*), if any (the default option gets ‘all’ components). Examples for both options are given below.

After running

```
library(tidysbml)
```

example of default option is

```
filepath <- system.file("extdata", "R-HSA-8937144.sbml", package = "tidysbml")
sbml_list <- sbml_as_list(filepath)
```

that returns a full SBML model, starting from the *sbml* tag, converted into a list of lists nested accordingly to the xml nesting rules.

Instead, an example of SBML-list conversion for only the list of species is given by

```
list_species <- sbml_as_list(filepath, component = "species")
```

which yields an SBML-converted list of lists starting from the *listOfSpecies* tag, that is contained inside the *sbml* and *model* tags. This last output is required in case the user is interested in the extraction of only one dataframe, e.g., using the `as_df()` function, as described in the following section.

## Converting SBML into dataframes

The main function of this package is `as_dfs()`, which is able to provide the SBML information about Compartments, Species and Reactions in a tabular format. It returns a list of at most 4 dataframes, depending on the components reported inside the SBML selected.

The dataframe for *listOfCompartments* (*listOfSpecies*) component, named `df_compartments` (`df_species`), has one row for each Compartment (Species) and one column for each Attributes, Notes and Annotation value. Similarly, the first dataframe about Reactions (i.e. `df_reactions`) contains one row for each Reaction with their Attributes, Notes and Annotation values as columns, while the second one (i.e. `df_species_in_reactions`) has one row for each Species involved in each Reaction, here with the addition of two more columns: the `reaction_id` column, with information about the corresponding Reaction identificator reported in the SBML document, and the `container_list` column, with the name of the listOf element containing that Species (i.e. *listOfReactants*, *listOfProducts*, *listOfModifiers*). It is possible to use as first argument the SBML file path

```
list_of_dfs <- as_dfs(filepath, type = "file")
#> Empty notes' column for 'compartment' elements
```

or directly the SBML-converted list after using `sbml_as_list()` as described above

```
list_of_dfs <- as_dfs(sbml_list, type = "list")
#> Empty notes' column for 'compartment' elements
```

both returning the same output, that is the list with all the dataframes available from extraction. After the list has been extracted once, this second way is preferable, in order to avoid repeated sbml-list conversions.

Another function, namely `as_df()`, enables the conversion of only one dataframe at a time, depending on the SBML component of interest. Here a SBML-converted list starting from *listOfCompartments*/*listOfSpecies*/*listOfReactions* component is a mandatory input. For instance, converting first the SBML file into a list focusing at the *listOfSpecies* component

```
list_species <- sbml_as_list(filepath, component = "species")
df_species <- as_df(list_species)
```

returns one dataframe containing all information about species. Just for *listOfReactions* component is possible to obtain two dataframes. Here `dfs_about_reactions` is a list of 2 dataframes obtained by

```
list_react <- sbml_as_list(filepath, component = "reactions")
dfs_about_reactions <- as_df(list_react)
```

whose first component, containing information about reactions, returns 15 columns for the 5 reactions of our example

```
dfs_about_reactions[[1]]
```

While `df_species_in_reactions`, with information about the 14 species involved in the 5 reactions described above, is obtained by taking the second component

```
dfs_about_reactions[[2]]
```

Each function described in this section performs a control on the input format correctness. In particular, it returns errors if the input object is an empty list or not a list object, and also if its format is not suitable for extraction (i.e. SBML tags are not properly named or nested). In particular, the SBML file is accepted by `as_df()` if it contains only one type of tag within the first level of ‘listOf’ components. For instance, if the SBML is restricted to *listOfSpecies*/*listOfCompartments*/*listOfReactions* tag, the only type of tag within the list should be *species*/*compartment*/*reaction*. One more condition, given only in the `as_dfs()` function, is that the first two tags in the xml hierarchy should be *sbml* and *model*, where the former contains the latter. If any one of these conditions does not hold, the respective functions are not executed.

## Integration with Bioconductor packages

This section provides R code to incorporate tidysbml dataframes with other Bioconductor packages. Here are shown examples of integration for RCy3 (Gustavsen et al. 2019) and biomaRt (Durinck et al. 2005) packages.

RCy3 package permits communication between R and Cytoscape softwares. After launching Cytoscape, it is possible to import graph in form of edgelist (i.e. dataframe with source and target columns) by simple (or heavier) data manipulation through dataframes as

```
library(dplyr)
edgelist <- df_species_in_reactions %>% select("reaction_id", "species") %>% `colnames<-`(c("source", "target"))
RCy3::createNetworkFromDataFrames(edges = edgelist) # while running Cytoscape
```

BiomaRt, instead, is an annotation package providing access to external public databases. One possible usage, for instance, is to visualize information about Uniprot ids reported in SBML for Species, here considering only those composed by multiple entities (i.e. multiple ids). First, extract URIs data about species from Annotation column with *bqbiol:hasPart* content

```
vec_uri <- na.omit( unlist(
  lapply(X = list_of_dfs[[2]]$annotation_hasPart, FUN = function(x){
    unlist(strsplit(x, "||", fixed = TRUE))
  })
))
```

filter only Uniprot URIs

```
vec_uniprot <- na.omit( unlist(
  lapply( X = vec_uri, FUN = function(x){
    if( all(unlist(gregexpr("uniprot", x)) > -1) ){
      x
    } else {
      NA
    }
  })
))
```

and extract Uniprot ids

```
vec_ids <- vapply(vec_uniprot, function(x){
  chr <- "/"
  first <- max(unlist(gregexpr(chr, x)))
  substr(x, first + 1, nchar(x))
}, FUN.VALUE = character(1))
```

Then, using biomaRt commands, user can set attributes information to look at

```
library(biomaRt)
mart <- useEnsembl(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
df_mart_uniprot <- getBM( attributes = c("uniprot_gn_id", "uniprot_gn_symbol",   "description"),
                          filters = "uniprot_gn_id",
                          values = vec_ids,
                          mart = mart)
df_mart_uniprot
```

### Session info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
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
#> [1] biomaRt_2.66.0 tidysbml_1.4.0
#>
#> loaded via a namespace (and not attached):
#>  [1] rappdirs_0.3.3       sass_0.4.10          generics_0.1.4
#>  [4] xml2_1.4.1           RSQLite_2.4.3        stringi_1.8.7
#>  [7] hms_1.1.4            digest_0.6.37        magrittr_2.0.4
#> [10] evaluate_1.0.5       fastmap_1.2.0        blob_1.2.4
#> [13] jsonlite_2.0.0       progress_1.2.3       AnnotationDbi_1.72.0
#> [16] DBI_1.2.3            httr_1.4.7           purrr_1.1.0
#> [19] Biostrings_2.78.0    httr2_1.2.1          jquerylib_0.1.4
#> [22] cli_3.6.5            rlang_1.1.6          crayon_1.5.3
#> [25] XVector_0.50.0       dbplyr_2.5.1         Biobase_2.70.0
#> [28] bit64_4.6.0-1        withr_3.0.2          cachem_1.1.0
#> [31] yaml_2.3.10          tools_4.5.1          memoise_2.0.1
#> [34] dplyr_1.1.4          filelock_1.0.3       BiocGenerics_0.56.0
#> [37] curl_7.0.0           vctrs_0.6.5          R6_2.6.1
#> [40] png_0.1-8            stats4_4.5.1         BiocFileCache_3.0.0
#> [43] lifecycle_1.0.4      Seqinfo_1.0.0        KEGGREST_1.50.0
#> [46] stringr_1.5.2        S4Vectors_0.48.0     IRanges_2.44.0
#> [49] bit_4.6.0            pkgconfig_2.0.3      pillar_1.11.1
#> [52] bslib_0.9.0          glue_1.8.0           xfun_0.53
#> [55] tibble_3.3.0         tidyselect_1.2.1     knitr_1.50
#> [58] htmltools_0.5.8.1    rmarkdown_2.30       compiler_4.5.1
#> [61] prettyunits_1.2.0
```

### References

Durinck, Steffen, Yves Moreau, Arek Kasprzyk, Sean Davis, Bart De Moor, Alvis Brazma, and Wolfgang Huber. 2005. “BioMart and Bioconductor: A Powerful Link Between Biological Databases and Microarray Data Analysis.” *Bioinformatics* 21 (16): 3439–40. <https://doi.org/10.1093/bioinformatics/bti525>.

Gustavsen, Julia A., Shraddha Pai, Ruth Isserlin, Barry Demchak, and Alexander R. Pico. 2019. “RCy3: Network Biology Using Cytoscape from Within R.” F1000Research. <https://doi.org/10.12688/f1000research.20887.3>.

Hucka, Michael, Frank T. Bergmann, Claudine Chaouiya, Andreas Dräger, Stefan Hoops, Sarah M. Keating, Matthias König, et al. 2019. “The Systems Biology Markup Language (SBML): Language Specification for Level 3 Version 2 Core Release 2.” *Journal of Integrative Bioinformatics* 16 (2): 20190021. [https://doi.org/doi:10.1515/jib-2019-0021](https://doi.org/doi%3A10.1515/jib-2019-0021).

Jassal, Bijay. 2016. “Aryl Hydrocarbon Receptor Signalling.” <https://reactome.org/content/detail/R-HSA-8937144>.

Milacic, Marija, Deidre Beavers, Patrick Conley, Chuqiao Gong, Marc Gillespie, Johannes Griss, Robin Haw, et al. 2023. “The Reactome Pathway Knowledgebase 2024.” *Nucleic Acids Research* 52 (D1): D672–D678. <https://doi.org/10.1093/nar/gkad1025>.

Wickham, Hadley, Jim Hester, and Jeroen Ooms. 2023. *Xml2: Parse XML*. <https://xml2.r-lib.org/>.