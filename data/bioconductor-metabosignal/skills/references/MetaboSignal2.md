# Contents

* [1 Abstract](#abstract)
* [2 Introduction](#introduction)
* [3 Hands-on](#hands-on)
  + [3.1 Load data](#load-data)
  + [3.2 Build KEGG-based network](#build-kegg-based-network)
  + [3.3 Build regulatory network](#build-regulatory-network)
  + [3.4 Merge KEGG network and regulatory network](#merge-kegg-network-and-regulatory-network)
* [References](#references)

MetaboSignal 2: merging KEGG with
additional interaction resources

Andrea Rodriguez Martinez, Maryam Anwar, Rafael Ayala, Joram M. Posma, Ana L. Neves,
Marc-Emmanuel Dumas

May 22, 2017

# 1 Abstract

MetaboSignal is an R package designed to investigate the
genetic regulation of the metabolome, using KEGG as primary reference database.
The main goal of this vignette is to illustrate how KEGG interactions can be merged
with two large literature-curated resources of human regulatory interactions:
OmniPath and TRRUST.

# 2 Introduction

Metabolites are organized in biochemical pathways
regulated by signaling-transduction pathways, allowing the organism to adapt
to environmental changes and maintain homeostasis. We developed MetaboSignal
(Rodriguez-Martinez *et al.* [2017](#ref-Rodriguez-Martinez2017)) as a tool to explore the relationships between
genes (both enzymatic and signaling) and metabolites, using the Kyoto Encyclopedia
of Genes and Genomes (KEGG) (Kanehisa & Goto [2000](#ref-kanehisa2000)) as primary reference database.
In order to generate a more complete picture of the genetic regulation of the metabolome,
we have now updated and standarized the functionalities of MetaboSignal to facilitate its
integration with additional resources of molecular interactions. In this vignette we show how
KEGG interactions can be merged with human regulatory interactions from two large
literature-curated resources: OmniPath (Turei *et al.* [2016](#ref-turei2016)) and TRRUST(Hang *et al.* [2015](#ref-han2015)).

# 3 Hands-on

## 3.1 Load data

We begin by loading the MetaboSignal package:

```
## Load MetaboSignal
library(MetaboSignal)
```

We then load the “regulatory\_interactions” and “kegg\_pathways”
datasets, containing the following information:

- regulatory\_interactions: matrix containing a set of regulatory interactions
reported in OmniPath (directed protein-protein and signaling interactions) and TRRUST
(transcription factor-target interactions). For each interaction, both literature
reference(s) and primary database reference(s) are reported. Users are responsible
for respecting the terms of the licences of these databases and for citing them when
required. Notice that there are some inconsistencies between databases in terms
of direction and sign of the interactions. This is likely to be due to curation errors,
or also to the fact that some interactions might be bidirectional or have different
sign depending on the tissue. Users can update/edit this matrix as required.

- kegg\_pathways: matrix containing the identifiers (IDs) of relevant metabolic (n = 85)
and signaling (n = 126) human KEGG pathways. These IDs were retrieved using the function
“MS\_getPathIds( )”.

```
## Regulatory interactions
data("regulatory_interactions")
head(regulatory_interactions[, c(1, 3, 5)])
```

```
##      source_entrez target_entrez interaction_type
## [1,] "351"         "2"           "o_Unknown"
## [2,] "3576"        "2"           "o_Unknown"
## [3,] "7040"        "2"           "o_Unknown"
## [4,] "7042"        "2"           "o_Unknown"
## [5,] "2064"        "12"          "o_Unknown"
## [6,] "3817"        "12"          "o_Unknown"
```

```
## KEGG metabolic pathways
data("kegg_pathways")
head(kegg_pathways[, -2])
```

```
##      Path_id    Path_category                         Path_type
## [1,] "hsa00010" "Metabolism; Carbohydrate metabolism" "metabolic"
## [2,] "hsa00020" "Metabolism; Carbohydrate metabolism" "metabolic"
## [3,] "hsa00030" "Metabolism; Carbohydrate metabolism" "metabolic"
## [4,] "hsa00040" "Metabolism; Carbohydrate metabolism" "metabolic"
## [5,] "hsa00051" "Metabolism; Carbohydrate metabolism" "metabolic"
## [6,] "hsa00052" "Metabolism; Carbohydrate metabolism" "metabolic"
```

```
## KEGG signaling pathways
tail(kegg_pathways[, -2])
```

```
##        Path_id    Path_category                          Path_type
## [206,] "hsa04964" "Organismal Systems; Excretory system" "signaling"
## [207,] "hsa04966" "Organismal Systems; Excretory system" "signaling"
## [208,] "hsa04970" "Organismal Systems; Digestive system" "signaling"
## [209,] "hsa04971" "Organismal Systems; Digestive system" "signaling"
## [210,] "hsa04972" "Organismal Systems; Digestive system" "signaling"
## [211,] "hsa04976" "Organismal Systems; Digestive system" "signaling"
```

## 3.2 Build KEGG-based network

We use the function “MS\_getPathIds( )” to retrieve
the IDs of all human metabolic and signaling KEGG pathways.

```
## Get IDs of metabolic and signaling human pathways
hsa_paths <- MS_getPathIds(organism_code = "hsa")
```

This function generates a “.txt” file in the working
directory named “hsa\_pathways.txt”. We recommend that users take some time to inspect
this file and carefully select the metabolic and signaling pathways that will be
used to build the network. In this example, we selected the pathways stored in
the “kegg\_pathways” dataset.

Next, we use the function “MS\_keggNetwork( )” to build a
MetaboSignal network, by merging the selected metabolic and signaling KEGG pathways
stored in the “kegg\_pathways” dataset:

```
## Create metabo_paths and signaling_paths
## vectors
metabo_paths <- kegg_pathways[kegg_pathways[, "Path_type"] ==
    "metabolic", "Path_id"]

signaling_paths <- kegg_pathways[kegg_pathways[, "Path_type"] ==
    "signaling", "Path_id"]
```

```
## Build KEGG network (might take a while)
keggNet_example <- MS_keggNetwork(metabo_paths, signaling_paths,
    expand_genes = TRUE, convert_entrez = TRUE)
```

```
## See network format
head(keggNet_example)
```

```
##      source       target interaction_type
## [1,] "cpd:C00084" "217"  "k_compound:reversible"
## [2,] "cpd:C00084" "224"  "k_compound:reversible"
## [3,] "cpd:C00084" "221"  "k_compound:reversible"
## [4,] "cpd:C00084" "219"  "k_compound:reversible"
## [5,] "cpd:C00084" "222"  "k_compound:reversible"
## [6,] "cpd:C00084" "220"  "k_compound:reversible"
```

The network is formatted as a three-column matrix where
each row represents an edge between two nodes (from source to target). The nodes
represent the following molecular entities: chemical compounds (KEGG IDs), reactions
(KEGG IDs), signaling genes (Entrez IDs) and metabolic genes (Entrez IDs). The
type of interaction is reported in the “interaction\_type” column. Compound-gene
(or gene-compound) interactions are designated as: “k\_compound:reversible” or
“k\_compound:irreversible”, depending on the direction of the interaction. Other types
of interactions correspond to gene-gene interactions. When KEGG reports various
types of interaction for the same interactant pair, the “interaction\_type”
is collapsed using “/”.

Notice that when transforming KEGG signaling maps into
binary interactions, a number of indirect interactions are introduced, such as
interactions involving all members of a proteic complex or proteins interacting
*via* an intermediary compound (*e.g.* AC and PKA, *via* cAMP). We recommend excluding
these indirect interactions, as they might alter further topological analyses. In
this example, we remove interactions classified as: “unknown”, “indirect-compound”,
“indirect-effect”, “dissociation”, “state-change”, “binding”, “association”.

```
## Get all types of interaction
all_types <- unique(unlist(strsplit(keggNet_example[, "interaction_type"],
    "/")))
all_types <- gsub("k_", "", all_types)

## Select wanted interactions
wanted_types <- setdiff(all_types, c("unknown", "indirect-compound",
    "indirect-effect", "dissociation", "state-change", "binding",
    "association"))
print(wanted_types)  # interactions that will be retained
```

```
##  [1] "compound:reversible"   "compound:irreversible" "expression"
##  [4] "activation"            "phosphorylation"       "dephosphorylation"
##  [7] "inhibition"            "repression"            "ubiquitination"
## [10] "methylation"           "glycosylation"
```

```
## Filter keggNet_example to retain only wanted
## interactions
wanted_types <- paste(wanted_types, collapse = "|")
keggNet_clean <- keggNet_example[grep(wanted_types, keggNet_example[,
    3]), ]
```

## 3.3 Build regulatory network

We then use the function “MS2\_ppiNetwork( )” to generate
a regulatory network, by merging the signaling interactions from OmniPath and TRRUST,
or by selecting the interactions of only one of these databases. Some examples are
shown below:

```
## Build regulatory network of TRRUST interactions
trrustNet_example <- MS2_ppiNetwork(datasets = "trrust")

## Build regulatory network of OmniPath interactions
omnipathNet_example <- MS2_ppiNetwork(datasets = "omnipath")

## Build regulatory network by merging OmniPath and TRRUST interactions
ppiNet_example <- MS2_ppiNetwork(datasets = "all")

## See network format
head(ppiNet_example)
```

```
##      source target interaction_type
## [1,] "351"  "2"    "o_Unknown"
## [2,] "3576" "2"    "o_Unknown"
## [3,] "7040" "2"    "o_Unknown"
## [4,] "7042" "2"    "o_Unknown"
## [5,] "2064" "12"   "o_Unknown"
## [6,] "3817" "12"   "o_Unknown"
```

Each of these networks is formatted as a three-column
matrix where each row represents an edge between two nodes (from source to target).
The third column indicates the interaction type and the source of the interaction
(OmniPath: “o\_”, TRRUST: “t\_”). Notice that common interactions between both databases
are collapsed, and the interaction type is reported as: “o\_; t\_;”.

## 3.4 Merge KEGG network and regulatory network

Finally, we use the function “MS2\_mergeNetworks( )” to merge
the KEGG-based network with the regulatory network.

```
## Merge networks
mergedNet_example <- MS2_mergeNetworks(keggNet_clean, ppiNet_example)
```

```
## See network format
head(mergedNet_example)
```

```
##      source       target interaction_type
## [1,] "cpd:C00084" "217"  "k_compound:reversible"
## [2,] "cpd:C00084" "224"  "k_compound:reversible"
## [3,] "cpd:C00084" "221"  "k_compound:reversible"
## [4,] "cpd:C00084" "219"  "k_compound:reversible"
## [5,] "cpd:C00084" "222"  "k_compound:reversible"
## [6,] "cpd:C00084" "220"  "k_compound:reversible"
```

The network is formatted as a three-column matrix where
each row represents an edge between two nodes (from source to target). The third
column indicates the interaction type and the source of the interaction
(KEGG: “k\_”, OmniPath: “o\_”, TRRUST: “t\_”). Notice that common interactions
between both databases are collapsed, and the interaction type is reported
as: “k\_;o\_;t\_;”. This network can be further customized and subsequently used
to explore gene-metabolite associations as described in the introductory vignette
of the package.

# References

Hang, H., Shim, H., Shin, D., Shim, J.E., Ko, Y., Shin, J., H Kim, Cho, A., Kim, E., Lee, T., Kim, H., Kim, K., Yang, S., Bae, D., Yun, A., Kim, S., Kim, C.Y., Cho, H.J., Kang, B., Shin, S. & Lee, I. (2015). TRRUST: A reference database of human transcriptional regulatory interactions. *Scientific Reports*, **12**, 11432. Retrieved from <https://www.nature.com/articles/srep11432>

Kanehisa, M. & Goto, S. (2000). KEGG: Kyoto encyclopedia of genes and genomes. *Nucleic Acids Research*, **28**, 27–30. Retrieved from <http://nar.oxfordjournals.org/content/28/1/27>

Rodriguez-Martinez, A., Ayala, R., Posma, J.M., Neves, A.L., Gauguier, D., Nicholson, J.K. & Dumas, M.-E. (2017). MetaboSignal: A network-based approach for topological analysis of metabotype regulation via metabolic and signaling pathways. *Bioinformatics*, **33**, 773–775. Retrieved from <https://academic.oup.com/bioinformatics/article/33/5/773/2725552/>

Turei, D., Korcsmaros, T. & Saez-Rodriguez, J. (2016). OmniPath: Guidelines and gateway for literature-curated signaling pathway resources. *Nature Methods*, **13**, 966–967. Retrieved from <http://www.nature.com/nmeth/journal/v13/n12/full/nmeth.4077.html>