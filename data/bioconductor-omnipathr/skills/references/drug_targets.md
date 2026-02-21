# Building protein networks around drug-targets using OmnipathR

Attila Gabor\*, Alberto Valdeolivas and Julio Saez-Rodriguez1

1Institute for Computational Biomedicine, Heidelberg University

\*attila.gabor@bioquant.uni-heidelberg.de

#### 29 January 2026

#### Abstract

Many applications require to connect drugs to proteins in signaling
networks. OmnipathR provides easy access to curated pathway resources from
OmniPath. Here we use data from DrugBank to find direct protein targets of
drugs and to connect them to downstream signaling proteins using OmnipathR.

#### Package

OmnipathR 3.18.4

# Contents

* [1 Introduction](#introduction)
* [2 Initialise OmniPath database](#initialise-omnipath-database)
* [3 Querying drug targets](#querying-drug-targets)
  + [3.1 Quality control](#quality-control)
* [4 Downstream signaling nodes](#downstream-signaling-nodes)
  + [4.1 Quality control](#quality-control-1)
* [5 Build network between drug targets and POI](#build-network-between-drug-targets-and-poi)
* [6 Acknowledgements](#acknowledgements)
* [7 References](#references)
* **Appendix**
* [Session info](#session-info)

# 1 Introduction

In many applications we would like to understand how a specific drug interacts
with the protein signaling network through its targets.

```
library(dplyr)
library(ggplot2)
library(OmnipathR)
library(igraph)
library(ggraph)
library(magrittr)
```

# 2 Initialise OmniPath database

We query protein-protein interactions from the webservice of OmniPath [1,2] at
<https://omnipathdb.org/> using OmnipathR package:

```
# Download protein-protein interactions
interactions <- omnipath() %>% as_tibble()

# Convert to igraph objects:
OPI_g <- interaction_graph(interactions = interactions)
```

# 3 Querying drug targets

For direct drug targets we will use DrugBank [3] database accessed via the
*[dbparser](https://CRAN.R-project.org/package%3Ddbparser)* package.
Please note, that the following few chuncks of code is not evaluated.
DrugBank requires registrations to access the data, therefore we ask the
reader to register at DrugBank and download
the data from [here](https://www.drugbank.ca/releases/latest).

The next block of code is used to process the DrugBank dataset.

```
library(dbparser)
library(XML)

## parse data from XML and save it to memory
get_xml_db_rows("..path-to-DrugBank/full database.xml")

## load drugs data
drugs <- parse_drug() %>% select(primary_key, name)
drugs <- rename(drugs,drug_name = name)

## load drug target data
drug_targets <-
    parse_drug_targets() %>%
    select(id, name,organism,parent_key) %>%
    rename(target_name = name)

## load polypeptide data
drug_peptides <-
    parse_drug_targets_polypeptides()  %>%
    select(
        id,
        name,
        general_function,
        specific_function,
        gene_name,
        parent_id
    ) %>%
    rename(target_name = name, gene_id = id)

# join the 3 datasets
drug_targets_full <-
    inner_join(
        drug_targets,
        drug_peptides,
        by = c("id" = "parent_id", "target_name")
    ) %>%
    inner_join(drugs, by = c("parent_key" = "primary_key")) %>%
    select(-other_keys)
```

Here we declare the names of drugs of interest.

```
drug_names = c(
    "Valproat"         = "Valproic Acid",
    "Diclofenac"       = "Diclofenac",
    "Paracetamol"      = "Acetaminophen",
    "Ciproflaxin"      = "Ciprofloxacin",
    "Nitrofurantoin"   = "Nitrofurantoin",
    "Tolcapone",
    "Azathioprine",
    "Troglitazone",
    "Nefazodone",
    "Ketoconazole",
    "Omeprazole",
    "Phenytoin",
    "Amiodarone",
    "Cisplatin",
    "Cyclosporin A"    = "Cyclosporine",
    "Verapamil",
    "Buspirone",
    "Melatonin",
    "N-Acetylcysteine" = "Acetylcysteine",
    "Vitamin C"        = "Ascorbic acid",
    "Famotidine",
    "Vancomycin"
)
```

```
drug_target_data_sample <-
   drug_targets_full %>%
   filter(organism == "Humans", drug_name %in% drug_names)
```

We only use a small sample of the database:

```
drug_targets <-
   OmnipathR:::drug_target_data_sample %>%
   filter(organism == "Humans", drug_name %in% drug_names)
```

## 3.1 Quality control

Check which drug targets are in Omnipath:

```
drug_targets %<>%
   select(-target_name, -organism) %>%
   mutate(in_OP = gene_id %in% c(interactions$source))
   # not all drug-targets are in OP.
   print(all(drug_targets$in_OP))
```

```
## [1] FALSE
```

```
# But each drug has at least one target in OP.
drug_targets %>% group_by(drug_name) %>% summarise(any(in_OP))
```

```
## # A tibble: 19 × 2
##    drug_name      `any(in_OP)`
##    <chr>          <lgl>
##  1 Acetaminophen  TRUE
##  2 Acetylcysteine TRUE
##  3 Amiodarone     TRUE
##  4 Ascorbic acid  TRUE
##  5 Azathioprine   TRUE
##  6 Buspirone      TRUE
##  7 Ciprofloxacin  TRUE
##  8 Cisplatin      TRUE
##  9 Diclofenac     TRUE
## 10 Famotidine     TRUE
## 11 Ketoconazole   TRUE
## 12 Melatonin      TRUE
## 13 Nefazodone     TRUE
## 14 Omeprazole     FALSE
## 15 Phenytoin      TRUE
## 16 Tolcapone      FALSE
## 17 Troglitazone   TRUE
## 18 Valproic Acid  TRUE
## 19 Verapamil      TRUE
```

# 4 Downstream signaling nodes

We would like to investigate the effect of the drugs on some selected proteins.
For example, the activity of these proteins are measured upon the drug
perturbation. We’ll build a network from the drug targets to these selected
nodes.

First we declare protein of interest (POI):

```
POI <- tibble(
    protein = c(
        "NFE2L2", "HMOX1", "TP53",
        "CDKN1A", "BTG2", "NFKB1",
        "ICAM1", "HSPA5", "ATF4",
        "DDIT3", "XBP1"
    )
)
```

## 4.1 Quality control

Checking which POI are in Omnipath

```
POI <- POI %>% mutate(in_OP = protein %in% interactions$target_genesymbol)
# all POI is in Omnipath
print(all(POI$in_OP))
```

```
## [1] TRUE
```

# 5 Build network between drug targets and POI

First, we find paths between the drug targets and the POIs.
For the sake of this simplicity we focus on drug targets of one drug,
*Cisplatin*.

The paths are represented by a set of nodes:

```
source_nodes <-
    drug_targets %>%
    filter(in_OP, drug_name == "Cisplatin") %>%
    pull(gene_name)

target_nodes <- POI %>% filter(in_OP) %>% pull(protein)

collected_path_nodes <- list()

for(i_source in 1:length(source_nodes)){

    paths <- shortest_paths(
        OPI_g,
        from = source_nodes[[i_source]],
        to = target_nodes,
        output = "vpath"
    )
    path_nodes <- lapply(paths$vpath, names) %>% unlist() %>% unique()
    collected_path_nodes[[i_source]] <- path_nodes

}

collected_path_nodes %<>% unlist %>% unique
```

The direct drug targets, the POIs and the intermediate pathway members give
rise to the network.

```
cisplatin_nodes <-
    c(source_nodes,target_nodes, collected_path_nodes) %>%
    unique()

cisplatin_network <- induced_subgraph(graph = OPI_g, vids = cisplatin_nodes)
```

We annotate the nodes of the network and plot it.

```
V(cisplatin_network)$node_type <-
    ifelse(
        V(cisplatin_network)$name %in% source_nodes,
        "direct drug target",
        ifelse(
            V(cisplatin_network)$name %in% target_nodes,
            "POI",
            "intermediate node"
        )
    )

# temporary fix against segfault that happens pre-4.4 R devel builds
# only if the vignette is built within R CMD build and only on our
# Ubuntu 22.04 machine
# likely we can remove this conditional a few weeks later
if (Sys.info()["user"] != "omnipath") {

ggraph(
    cisplatin_network,
    layout = "lgl",
    area = vcount(cisplatin_network)^2.3,
    repulserad = vcount(cisplatin_network)^1.2,
    coolexp = 1.1
) +
geom_edge_link(
    aes(
        start_cap = label_rect(node1.name),
        end_cap = label_rect(node2.name)),
        arrow = arrow(length = unit(4, "mm")
    ),
    edge_width = .5,
    edge_alpha = .2
) +
geom_node_point() +
geom_node_label(aes(label = name, color = node_type)) +
scale_color_discrete(
    guide = guide_legend(title = "Node type")
) +
theme_bw() +
xlab("") +
ylab("") +
ggtitle("Cisplatin induced network")

}
```

![](data:image/png;base64...)

The above network represents a way how Cisplatin can influence the POIs. One
can for example filter out edges based on the number fo resources reporting the
edge or based on the number of papers mentioning it. However, this is already
covered by previous pypath tutorials.

# 6 Acknowledgements

The above pipeline was inspired by the post of Denes Turei available
[here](https://groups.google.com/forum/#!msg/omnipath/IAV5PEXRyMg/PvwOKkusBQAJ).

# 7 References

# Appendix

[1] D Turei, A Valdeolivas, L Gul, N Palacio-Escat, M Klein, O Ivanova,
M Olbei, A Gabor, F Theis, D Modos, T Korcsmaros and J Saez-Rodriguez (2021)
Integrated intra- and intercellular signaling knowledge for multicellular
omics analysis. *Molecular Systems Biology* 17:e9923

[2] D Turei, T Korcsmaros and J Saez-Rodriguez (2016) OmniPath: guidelines and
gateway for literature-curated signaling pathway resources. *Nature Methods*
13(12)

[3] Wishart DS, Feunang YD, Guo AC, Lo EJ, Marcu A, Grant JR, Sajed T,
Johnson D, Li C, Sayeeda Z, Assempour N, Iynkkaran I, Liu Y, Maciejewski A,
Gale N, Wilson A, Chin L, Cummings R, Le D, Pon A, Knox C, Wilson M.
DrugBank 5.0: a major update to the DrugBank database for 2018.
*Nucleic Acids Res.* 2017 Nov 8. doi: 10.1093/nar/gkx1037.

# Session info

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] magrittr_2.0.4   ggraph_2.2.2     igraph_2.2.1     ggplot2_4.0.1    dplyr_1.1.4      OmnipathR_3.18.4
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    viridisLite_0.4.2   farver_2.1.2        blob_1.3.0          viridis_0.6.5
##  [6] R.utils_2.13.0      S7_0.2.1            fastmap_1.2.0       tweenr_2.0.3        promises_1.5.0
## [11] XML_3.99-0.20       digest_0.6.39       timechange_0.3.0    lifecycle_1.0.5     processx_3.8.6
## [16] RSQLite_2.4.5       compiler_4.5.2      rlang_1.1.7         sass_0.4.10         progress_1.2.3
## [21] tools_4.5.2         utf8_1.2.6          yaml_2.3.12         knitr_1.51          labeling_0.4.3
## [26] graphlayouts_1.2.2  prettyunits_1.2.0   bit_4.6.0           curl_7.0.0          xml2_1.5.2
## [31] RColorBrewer_1.1-3  websocket_1.4.4     withr_3.0.2         purrr_1.2.1         R.oo_1.27.1
## [36] polyclip_1.10-7     grid_4.5.2          scales_1.4.0        MASS_7.3-65         tinytex_0.58
## [41] dichromat_2.0-0.1   cli_3.6.5           rmarkdown_2.30      crayon_1.5.3        generics_0.1.4
## [46] otel_0.2.0          httr_1.4.7          tzdb_0.5.0          sessioninfo_1.2.3   readxl_1.4.5
## [51] DBI_1.2.3           cachem_1.1.0        chromote_0.5.1      ggforce_0.5.0       stringr_1.6.0
## [56] rvest_1.0.5         parallel_4.5.2      BiocManager_1.30.27 selectr_0.5-1       cellranger_1.1.0
## [61] vctrs_0.7.1         jsonlite_2.0.0      bookdown_0.46       hms_1.1.4           ggrepel_0.9.6
## [66] bit64_4.6.0-1       magick_2.9.0        jquerylib_0.1.4     tidyr_1.3.2         glue_1.8.0
## [71] ps_1.9.1            lubridate_1.9.4     stringi_1.8.7       gtable_0.3.6        later_1.4.5
## [76] tibble_3.3.1        logger_0.4.1        pillar_1.11.1       rappdirs_0.3.4      htmltools_0.5.9
## [81] R6_2.6.1            httr2_1.2.2         tcltk_4.5.2         tidygraph_1.3.1     vroom_1.7.0
## [86] evaluate_1.0.5      readr_2.1.6         R.methodsS3_1.8.2   backports_1.5.0     memoise_2.0.1
## [91] bslib_0.10.0        Rcpp_1.1.1          zip_2.3.3           gridExtra_2.3       checkmate_2.3.3
## [96] xfun_0.56           fs_1.6.6            pkgconfig_2.0.3
```