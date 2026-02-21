# OmnipathR: an R client for the OmniPath web service

#### Alberto Valdeolivas

alvaldeolivas@gmail.com

#### Attila Gabor

attila.gabor@bioquant.uni-heidelberg.de

#### Denes Turei

turei.denes@gmail.com

#### Julio Saez-Rodriguez

Institute for Computational Biomedicine, Heidelberg University

Abstract

This vignette describes how to use the *[OmnipathR](https://bioconductor.org/packages/3.22/OmnipathR)*
package to retrieve information from the OmniPath database:
<https://omnipathdb.org/>.
In addition, it includes some utility functions to filter
analyse and visualize the data.

* [Introduction](#introduction)
  + [Query types](#query-types)
  + [Mouse and rat](#mouse-and-rat)
* [Installation of the *OmnipathR* package](#installation-of-the-omnipathr-package)
* [Usage Examples](#usage-examples)
  + [Interactions](#interactions)
  + [Other interaction datasets](#other-interaction-datasets)
  + [Post-translational modifications (PTMs)](#post-translational-modifications-ptms)
  + [Complexes](#complexes)
  + [Annotations](#annotations)
  + [Intercell](#intercell)
* [Conclusion](#conclusion)
* [Session info](#session-info)
* [References](#references)

# Introduction

*[OmnipathR](https://bioconductor.org/packages/3.22/OmnipathR)* is an *R* package built to provide easy access to
the data stored in the OmniPath webservice (Türei, Korcsmáros, and Saez-Rodriguez 2016):

<http://omnipathdb.org/>

The webservice implements a very simple REST style API. This package make
requests by the HTTP protocol to retreive the data. Hence, fast Internet
access is required for a proper use of *[OmnipathR](https://bioconductor.org/packages/3.22/OmnipathR)*.

## Query types

*[OmnipathR](https://bioconductor.org/packages/3.22/OmnipathR)* can retrieve five different types of data:

* **Interactions**: protein-protein interactions organized in different
  datasets:

  + **omnipath**: the OmniPath data as defined in the original
    publication (Türei, Korcsmáros, and Saez-Rodriguez 2016) and collected from different databases.
  + **pathwayextra**: activity flow interactions without literature
    reference.
  + **kinaseextra**: enzyme-substrate interactions without literature
    reference.
  + **ligrecextra**: ligand-receptor interactions without literature
    reference.
  + **tfregulons**: transcription factor (TF)-target interactions from
    **DoRothEA** (Garcia-Alonso et al. 2019).
  + **tf-miRNA**: transcription factor-miRNA interactions
  + **miRNA-target**: miRNA-mRNA interactions.
  + **lncRNA-mRNA**: lncRNA-mRNA interactions.
  + **small molecule-protein**: interactions between small molecules
    (metabolites, intrinsic ligands, drug compounds) and proteins.
* **Post-translational modifications (PTMs)**: It provides
  enzyme-substrate reactions in a very similar way to the aforementioned
  interactions. Some of the biological databases related to PTMs integrated
  in OmniPath are Phospho.ELM (Dinkel et al. 2010) and PhosphoSitePlus
  [Hornbeck et al. (2014)}.
* **Complexes**: it provides access to a comprehensive database of more than
  22000 protein complexes. This data comes from different resources
  such as: CORUM (Giurgiu et al. 2018) or Hu.map (Drew et al. 2017).
* **Annotations**: it provides a large variety of data regarding
  different annotations about proteins and complexes. These data come from
  dozens of databases covering different topics such as: The Topology Data Bank
  of Transmembrane Proteins (TOPDB) (Dobson et al. 2014) or ExoCarta
  (Keerthikumar et al. 2016), a database collecting the proteins that were identified
  in exosomes in multiple organisms.
* **Intercell**: it provides information on the roles in
  inter-cellular signaling. For instance. if a protein is a ligand, a receptor,
  an extracellular matrix (ECM) component, etc. The data does not come from
  original sources but combined from several databases by us. The source
  databases, such as CellPhoneDB (Vento-Tormo et al. 2018) or Receptome
  (Ben-Shlomo et al. 2003), are also referred for each reacord.

Figure [1](#fig:fig1) shows an overview of the resources featured in
**OmniPath**. For more detailed information about the original data sources
integrated in Omnipath, please visit:

* <http://omnipathdb.org/>
* <http://omnipathdb.org/info>

![Overview of the resources featured in OmniPath. Causal resources (including activity-flow and enzyme-substrate resources) can provide direction (*) or sign and direction (+) of interactions.](data:image/png;base64...)

Figure 1: Overview of the resources featured in OmniPath. Causal resources (including activity-flow and enzyme-substrate resources) can provide direction (\*) or sign and direction (+) of interactions.

## Mouse and rat

Excluding the miRNA interactions, all interactions and PTMs are available for
human, mouse and rat. The rodent data has been translated from human using the
NCBI Homologene database. Many human proteins do not have known homolog in
rodents, hence rodent datasets are smaller than their human counterparts.

In case you work with mouse omics data you might do better to translate your
dataset to human (for example using the pypath.homology module,
<https://github.com/saezlab/pypath/>) and use human interaction data.

# Installation of the *[OmnipathR](https://bioconductor.org/packages/3.22/OmnipathR)* package

First of all, you need a current version of *R*. *[OmnipathR](https://bioconductor.org/packages/3.22/OmnipathR)*
is a freely available package deposited on *Bioconductor* and
[GitHub](https://github.com/saezlab/OmnipathR). You can install it by running
the following commands on an *R* console:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("OmnipathR")
```

We also load here the required packages to run the code in this vignette.

```
library(OmnipathR)
library(igraph)
library(tidyr)
library(gprofiler2)
```

# Usage Examples

In the following paragraphs, we provide some examples to describe how to use
the *[OmnipathR](https://bioconductor.org/packages/3.22/OmnipathR)* package to retrieve different types of
information from **Omnipath** webserver. In addition, we play around with the
data aiming at obtaining some biological relevant information.

Noteworthy, the sections **complexes**, **annotations** and **intercell** are
linked. We explore the annotations and roles in inter-cellular communications
of the proteins involved in a given complex. This basic example shows the
usefulness of integrating the information available in the different
**Omnipath** resources.

## Interactions

Proteins interact among them and with other biological molecules to perform
cellular functions. Proteins also participates in pathways, linked series of
reactions occurring inter/intra cells to transform products or to transmit
signals inducing specific cellular responses. Protein interactions are
therefore a very valuable source of information to understand cellular
functioning.

We here download the original **OmniPath** human interactions (Türei, Korcsmáros, and Saez-Rodriguez 2016).
To do so, we first check the different source databases and select some of
them. Then, we print some of the downloaded interactions (“+” means
activation, “-” means inhibition and “?” means undirected interactions or
inconclusive data).

```
## We check some of the different interaction databases
interaction_resources()
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
##   [1] "ACSN"                        "ACSN_SignaLink3"             "ARACNe-GTEx_DoRothEA"
##   [4] "ARN"                         "Adhesome"                    "AlzPathway"
##   [7] "BEL-Large-Corpus_ProtMapper" "Baccin2019"                  "BioGRID"
##  [10] "CA1"                         "CancerCellMap"               "CancerDrugsDB"
##  [13] "CellCall"                    "CellChatDB"                  "CellChatDB-cofactors"
##  [16] "CellPhoneDB"                 "CellPhoneDB_Cellinker"       "CellTalkDB"
##  [19] "Cellinker"                   "CollecTRI"                   "Cui2007"
##  [22] "CytReg_CollecTRI"            "DEPOD"                       "DIP"
##  [25] "DLRP_Cellinker"              "DLRP_talklr"                 "DOMINO"
##  [28] "DeathDomain"                 "DoRothEA"                    "DoRothEA-A_CollecTRI"
##  [31] "DoRothEA-reviews_DoRothEA"   "ELM"                         "EMBRACE"
##  [34] "ENCODE-distal"               "ENCODE-proximal"             "ENCODE_tf-mirna"
##  [37] "ExTRI_CollecTRI"             "FANTOM4_DoRothEA"            "Fantom5_LRdb"
##  [40] "GEREDB_CollecTRI"            "GOA_CollecTRI"               "Guide2Pharma"
##  [43] "Guide2Pharma_Cellinker"      "Guide2Pharma_LRdb"           "Guide2Pharma_talklr"
##  [46] "HINT"                        "HOCOMOCO_DoRothEA"           "HPMR"
##  [49] "HPMR_Cellinker"              "HPMR_LRdb"                   "HPMR_talklr"
##  [52] "HPRD"                        "HPRD-phos"                   "HPRD_KEA"
##  [55] "HPRD_LRdb"                   "HPRD_MIMP"                   "HPRD_talklr"
##  [58] "HTRI_CollecTRI"              "HTRIdb"                      "HTRIdb_DoRothEA"
##  [61] "HuRI"                        "ICELLNET"                    "InnateDB"
##  [64] "InnateDB_SignaLink3"         "IntAct"                      "IntAct_CollecTRI"
##  [67] "IntAct_DoRothEA"             "JASPAR_DoRothEA"             "KEA"
##  [70] "KEGG-MEDICUS"                "Kinexus_KEA"                 "Kirouac2010"
##  [73] "LMPID"                       "LRdb"                        "Li2012"
##  [76] "Lit-BM-17"                   "LncRNADisease"               "MIMP"
##  [79] "MPPI"                        "Macrophage"                  "NCI-PID_ProtMapper"
##  [82] "NFIRegulomeDB_DoRothEA"      "NRF2ome"                     "NTNU.Curated_CollecTRI"
##  [85] "NetPath"                     "NetworKIN_KEA"               "ORegAnno"
##  [88] "ORegAnno_DoRothEA"           "PAZAR"                       "PAZAR_DoRothEA"
##  [91] "PDZBase"                     "Pavlidis2021_CollecTRI"      "PhosphoNetworks"
##  [94] "PhosphoPoint"                "PhosphoSite"                 "PhosphoSite_KEA"
##  [97] "PhosphoSite_MIMP"            "PhosphoSite_ProtMapper"      "PhosphoSite_noref"
## [100] "ProtMapper"                  "REACH_ProtMapper"            "RLIMS-P_ProtMapper"
## [103] "Ramilowski2015"              "Ramilowski2015_Baccin2019"   "ReMap_DoRothEA"
## [106] "Reactome_LRdb"               "Reactome_ProtMapper"         "Reactome_SignaLink3"
## [109] "RegNetwork_DoRothEA"         "SIGNOR"                      "SIGNOR_CollecTRI"
## [112] "SIGNOR_ProtMapper"           "SPIKE"                       "SPIKE_LC"
## [115] "STRING_talklr"               "SignaLink3"                  "Sparser_ProtMapper"
## [118] "TCRcuration_SignaLink3"      "TFactS_CollecTRI"            "TFactS_DoRothEA"
## [121] "TFe_DoRothEA"                "TRED_DoRothEA"               "TRIP"
## [124] "TRRD_DoRothEA"               "TRRUST"                      "TRRUST_CollecTRI"
## [127] "TRRUST_DoRothEA"             "TransmiR"                    "UniProt_LRdb"
## [130] "Wang"                        "Wojtowicz2020"               "connectomeDB2020"
## [133] "dbPTM"                       "hprd_ProtMapper"             "iPTMnet"
## [136] "iTALK"                       "lncrnadb"                    "miR2Disease"
## [139] "miRDeathDB"                  "miRTarBase"                  "miRecords"
## [142] "ncRDeathDB"                  "phosphoELM"                  "phosphoELM_KEA"
## [145] "phosphoELM_MIMP"             "scConnect"                   "talklr"
```

```
## The interactions are stored into a data frame.
pathways <- omnipath(resources = c("SignaLink3", "PhosphoSite", "SIGNOR"))
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
## We visualize the first interactions in the data frame.
print_interactions(head(pathways))
```

```
## # A tibble: 6 × 5
##   source          interaction target         n_resources n_references
##   <chr>           <chr>       <chr>                <int>        <int>
## 1 PRKG1 (Q13976)  ==( - )==>  TRPC6 (Q9Y210)           5            4
## 2 FYN (P06241)    ==( + )==>  TRPC6 (Q9Y210)           4            3
## 3 PRKACA (P17612) ==( ? )==>  TRPC6 (Q9Y210)           3            3
## 4 PRKG1 (Q13976)  ==( - )==>  TRPC3 (Q13507)           8            2
## 5 SRC (P12931)    ==( + )==>  TRPC6 (Q9Y210)           5            2
## 6 PRKG1 (Q13976)  ==( + )==>  TRPC7 (Q9HCX4)           4            1
```

### Protein-protein interaction networks

Protein-protein interactions are usually converted into networks. Describing
protein interactions as networks not only provides a convenient format for
visualization, but also allows applying graph theory methods to mine the
biological information they contain.

We convert here our set of interactions to a network/graph
(*[igraph](https://CRAN.R-project.org/package%3Digraph)*object). Then, we apply two very common approaches to
extract information from a biological network:

* **Shortest Paths**: finding a path between two nodes (proteins) going
  through the minimum number of edges. This can be very useful to track
  consecutive reactions within a given pathway. We display below the shortest
  path between two given proteins and all the possible shortests paths between
  two other proteins. It is to note that the functions `print_path\_es` and
  `print_path\_vs` display very similar results, but the first one takes as an
  input an edge sequence and the second one a node sequence.

```
## We transform the interactions data frame into a graph
pathways_g <- interaction_graph(pathways)

## Find and print shortest paths on the directed network between proteins
## of interest:
print_path_es(
    igraph::shortest_paths(
        pathways_g,
        from = "TYRO3",
        to = "STAT3",
        output = "epath"
    )$epath[[1]],
    pathways_g
)
```

```
##           source interaction         target n_resources n_references
## 1 TYRO3 (Q06418)  ==( + )==>  CBLB (Q13191)           2            1
## 2  CBLB (Q13191)  ==(+/-)==>  EGFR (P00533)          10           11
## 3  EGFR (P00533)  ==( + )==> STAT3 (P40763)          14           33
```

```
## Find and print all shortest paths between proteins of interest:
print_path_vs(
    igraph::all_shortest_paths(
        pathways_g,
        from = "DYRK2",
        to = "MAPKAPK2"
    )$res,
    pathways_g
)
```

```
## Pathway 1: DYRK2 -> CDC25A -> MAPK3 -> MAPKAPK2
```

* **Clustering**: grouping nodes (proteins) in such a way that nodes belonging
  to the same group (called cluster) are more connected in the network to each
  other than to those in other groups (clusters). Since proteins interact to
  perform their functions, proteins within the same cluster are likely to be
  implicated in similar biological tasks. Figure [2](#fig:fig2) shows the
  subgraph containing the proteins and interactions of a specifc protein, ERBB2
  The *[igraph](https://CRAN.R-project.org/package%3Digraph)* package contains functions to apply sevaral
  different cluster methods on graphs (visit <https://igraph.org/r/doc/> for
  detailed information.)

```
## We apply a clustering algorithm (Louvain) to group proteins in
## our network. We apply here Louvain which is fast but can only run
## on undirected graphs. Other clustering algorithms can deal with
## directed networks but with longer computational times,
## such as cluster_edge_betweenness. These cluster methods are directly
## available in the igraph package.
pathways_g_u <- igraph::as.undirected(pathways_g, mode = "mutual")
```

```
## Warning: `as.undirected()` was deprecated in igraph 2.1.0.
## ℹ Please use `as_undirected()` instead.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

```
pathways_g_u <- igraph::simplify(pathways_g_u)
clusters <- igraph::cluster_fast_greedy(pathways_g_u)
## We extract the cluster where a protein of interest is contained
erbb2_cluster_id <- clusters$membership[which(clusters$names == "ERBB2")]
erbb2_cluster_g <- igraph::induced_subgraph(
    pathways_g_u,
    igraph::V(pathways_g)$name[which(clusters$membership == erbb2_cluster_id)]
)
```

![ERBB2 associated cluser. Subnetwork extracted from the interactions graph representing the cluster where we can find the gene *ERBB2* (yellow node)](data:image/png;base64...)

Figure 2: ERBB2 associated cluser. Subnetwork extracted from the interactions graph representing the cluster where we can find the gene *ERBB2* (yellow node)

## Other interaction datasets

We used above the interactions from the dataset described in the original
**OmniPath** publication (Türei, Korcsmáros, and Saez-Rodriguez 2016). In this section, we provide
examples on how to retry and deal with interactions from the remaining
datasets. The same functions can been applied to every interaction dataset.

### Pathway Extra

In the first example, we are going to get the interactions from the
**pathwayextra** dataset, which contains activity flow interactions
without literature reference. We are going to focus on the mouse interactions
for a given gene in this particular case.

```
## We query and store the interactions into a dataframe
iactions <-
    pathwayextra(
        resources = c("Wang", "Lit-BM-17"),
        organism = 10090  # mouse
    )
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
## We select all the interactions in which Amfr gene is involved
iactions_amfr <- dplyr::filter(
    iactions,
    source_genesymbol == "Amfr" |
    target_genesymbol == "Amfr"
)

## We print these interactions:
print_interactions(iactions_amfr)
```

```
## # A tibble: 3 × 5
##   source        interaction target        n_resources n_references
##   <chr>         <chr>       <chr>               <int>        <dbl>
## 1 Amfr (Q9R049) ==( + )==>  Vcp (Q01853)            8           20
## 2 Gpi (P06745)  ==( + )==>  Amfr (Q9R049)          14            4
## 3 Amfr (Q9R049) ==( - )==>  Sod1 (P08228)           1            0
```

### Kinase Extra

Next, we download the interactions from the **kinaseextra** dataset, which
contains enzyme-substrate interactions without literature reference. We are
going to focus on rat reactions targeting a particular gene.

```
## We query and store the interactions into a dataframe
phosphonetw <-
    kinaseextra(
        resources = c("PhosphoPoint", "PhosphoSite"),
        organism = 10116  # rat
    )
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
## We select the interactions in which Dpysl2 gene is a target
upstream_dpysl2 <- dplyr::filter(
    phosphonetw,
    target_genesymbol == "Dpysl2"
)

## We print these interactions:
print_interactions(upstream_dpysl2)
```

```
## No interactions
```

### Ligand-receptor Extra

In the following example we are going to work with the **ligrecextra**
dataset, which contains ligand-receptor interactions without literature
reference. Our goal is to find the potential receptors associated to a given
ligand, CDH1 (Figure [3](#fig:fig3)).

```
## We query and store the interactions into a dataframe
ligrec_netw <- ligrecextra(
    resources = c("iTALK", "Baccin2019"),
    organism = 9606  # human
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
## Receptors of the CDH1 ligand.
downstream_cdh1 <- dplyr::filter(
    ligrec_netw,
    source_genesymbol == "CDH1"
)

## We transform the interactions data frame into a graph
downstream_cdh1_g <- interaction_graph(downstream_cdh1)

## We induce a network with these genes
downstream_cdh1_g <- igraph::induced_subgraph(
    interaction_graph(omnipath()),
    igraph::V(downstream_cdh1_g)$name
)
```

![Ligand-receptor interactions for the ADM2 ligand.](data:image/png;base64...)

Figure 3: Ligand-receptor interactions for the ADM2 ligand.

### DoRothEA Regulons

Another very interesting interaction dataset also available in OmniPath is
**DoRothEA** (Garcia-Alonso et al. 2019). It contains transcription
factor (TF)-target interactions with confidence score, ranging from A-E,
being A the most confident interactions. In the code chunk shown below, we
select and print the most confident interactions for a given TF.

```
## We query and store the interactions into a dataframe
dorothea_netw <- dorothea(
    dorothea_levels = "A",
    organism = 9606
)

## We select the most confident interactions for a given TF and we print
## the interactions to check the way it regulates its different targets
downstream_gli1  <- dplyr::filter(
    dorothea_netw,
    source_genesymbol == "GLI1"
)

print_interactions(downstream_gli1)
```

```
## # A tibble: 7 × 5
##   source        interaction target          n_resources n_references
##   <chr>         <chr>       <chr>                 <int>        <dbl>
## 1 GLI1 (P08151) ==(+/-)==>  BCL2 (P10415)             3            7
## 2 GLI1 (P08151) ==( + )==>  PTCH1 (Q13635)            3            5
## 3 GLI1 (P08151) ==( + )==>  SFRP1 (Q8N474)            3            3
## 4 GLI1 (P08151) ==( + )==>  IGFBP6 (P24592)           2            3
## 5 GLI1 (P08151) ==( - )==>  EGR2 (P11161)             3            1
## 6 GLI1 (P08151) ==( + )==>  CCND2 (P30279)            2            1
## 7 GLI1 (P08151) ==( - )==>  SLIT2 (O94813)            2            1
```

### miRNA-target dataset

The last dataset describing interactions is **mirnatarget**. It stores
miRNA-mRNA and TF-miRNA interactions. These interactions are only available
for human so far. We next select the miRNA interacting with the TF selected in
the previous code chunk, *GLI1*. The main function of miRNAs seems to
be related with gene regulation. It is therefore interesting to see how some
miRNA can regulate the expression of a TF which in turn regulates the
expression of other genes. Figure [4](#fig:fig4) shows a schematic network of
the miRNA targeting *GLI1* and the genes regulated by this TF.

```
## We query and store the interactions into a dataframe
mirna_targets <- mirna_target(
    resources = c("miR2Disease", "miRDeathDB")
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
## We select the interactions where a miRNA is interacting with the TF
## used in the previous code chunk and we print these interactions.
upstream_gli1 <- dplyr::filter(
    mirna_targets,
    target_genesymbol == "GLI1"
)

print_interactions(upstream_gli1)
```

```
## # A tibble: 3 × 5
##   source                        interaction target        n_resources n_references
##   <chr>                         <chr>       <chr>               <int>        <dbl>
## 1 hsa-miR-324-5p (MIMAT0000761) ==( ? )==>  GLI1 (P08151)           3            2
## 2 hsa-miR-125b (MIMAT0000423)   ==( ? )==>  GLI1 (P08151)           2            1
## 3 hsa-miR-326 (MIMAT0000756)    ==( ? )==>  GLI1 (P08151)           2            1
```

```
## We transform the previous selections to graphs (igraph objects)
downstream_gli1_g <- interaction_graph(downstream_gli1)
upstream_gli1_g <- interaction_graph(upstream_gli1)
```

![miRNA-TF-target network. Schematic network of the miRNA (red square nodes) targeting    extit{GLI1} (yellow node) and the genes regulated by this TF (blue round nodes).](data:image/png;base64...)

Figure 4: miRNA-TF-target network. Schematic network of the miRNA (red square nodes) targeting extit{GLI1} (yellow node) and the genes regulated by this TF (blue round nodes).

### Small molecule-protein dataset

This new dataset has been first added to OmniPath in January 2022. It is still
quite small: 3.5k interactions from three resources (SIGNOR, CancerDrugsDB
and Cellinker), but has prospects of a great growth in the future. As an
example, lets look for targets of a cancer drug, the MEK inhibitor Trametinib:

```
trametinib_targets <- small_molecule(sources = "TRAMETINIB")
print_interactions(trametinib_targets)
```

```
## No interactions
```

Note, the human readable compound names are not reliable, use PubChem CIDs
instead.

## Post-translational modifications (PTMs)

Another query type available is PTMs which provides enzyme-substrate reactions
in a very similar way to the aforementioned interactions. PTMs refer
generally to enzymatic modification of proteins after their synthesis in the
ribosomes. PTMs can be highly context-specific and they play a main role
in the activation/inhibition of biological pathways.

In the next code chunk, we download the **PTMs** for human. We first check
the different available source databases, even though we do not perform any
filter. Then, we select and print the reactions involving a specific
enzyme-substrate pair. Those reactions lack information about activation or
inhibition. To obtain that information, we match the data with
**OmniPath** interactions. Finally, we show that it is also possible to
build a graph using this information, and to retrieve PTMs from mouse or rat.

```
## We check the different PTMs databases
enzsub_resources()
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
##  [1] "BEL-Large-Corpus_ProtMapper" "DEPOD"                       "HPRD"
##  [4] "HPRD_MIMP"                   "KEA"                         "Li2012"
##  [7] "MIMP"                        "NCI-PID_ProtMapper"          "PhosphoNetworks"
## [10] "PhosphoSite"                 "PhosphoSite_MIMP"            "PhosphoSite_ProtMapper"
## [13] "ProtMapper"                  "REACH_ProtMapper"            "RLIMS-P_ProtMapper"
## [16] "Reactome_ProtMapper"         "SIGNOR"                      "SIGNOR_ProtMapper"
## [19] "Sparser_ProtMapper"          "dbPTM"                       "hprd_ProtMapper"
## [22] "phosphoELM"                  "phosphoELM_MIMP"
```

```
## We query and store the enzyme-PTM interactions into a dataframe.
## No filtering by databases in this case.
enzsub <- enzyme_substrate()

## We can select and print the reactions between a specific kinase and
## a specific substrate
print_interactions(dplyr::filter(
    enzsub,
    enzyme_genesymbol == "MAP2K1",
    substrate_genesymbol == "MAPK3"
))
```

```
## Warning: Unknown or uninitialised column: `is_stimulation`.
```

```
## # A tibble: 6 × 5
##   enzyme          interaction substrate           modification    n_resources
##   <chr>           <chr>       <chr>               <chr>                 <int>
## 1 MAP2K1 (Q02750) ====>       MAPK3_Y204 (P27361) phosphorylation           8
## 2 MAP2K1 (Q02750) ====>       MAPK3_T202 (P27361) phosphorylation           8
## 3 MAP2K1 (Q02750) ====>       MAPK3_T207 (P27361) phosphorylation           2
## 4 MAP2K1 (Q02750) ====>       MAPK3_Y210 (P27361) phosphorylation           2
## 5 MAP2K1 (Q02750) ====>       MAPK3_T80 (P27361)  phosphorylation           1
## 6 MAP2K1 (Q02750) ====>       MAPK3_Y222 (P27361) phosphorylation           1
```

```
## In the previous results, we can see that enzyme-PTM relationships do not
## contain sign (activation/inhibition). We can generate this information
## based on the protein-protein OmniPath interaction dataset.
interactions <- omnipath()
enzsub <- signed_ptms(enzsub, interactions)

## We select again the same kinase and substrate. Now we have information
## about inhibition or activation when we print the enzyme-PTM relationships
print_interactions(
    dplyr::filter(
        enzsub,
        enzyme_genesymbol=="MAP2K1",
        substrate_genesymbol=="MAPK3"
    )
)
```

```
##            enzyme interaction           substrate    modification n_resources
## 2 MAP2K1 (Q02750)  ==( + )==> MAPK3_Y204 (P27361) phosphorylation           8
## 1 MAP2K1 (Q02750)  ==( + )==> MAPK3_T202 (P27361) phosphorylation           8
## 3 MAP2K1 (Q02750)  ==( + )==> MAPK3_T207 (P27361) phosphorylation           2
## 5 MAP2K1 (Q02750)  ==( + )==> MAPK3_Y210 (P27361) phosphorylation           2
## 4 MAP2K1 (Q02750)  ==( + )==>  MAPK3_T80 (P27361) phosphorylation           1
## 6 MAP2K1 (Q02750)  ==( + )==> MAPK3_Y222 (P27361) phosphorylation           1
```

```
## We can also transform the enzyme-PTM relationships into a graph.
enzsub_g <- enzsub_graph(enzsub = enzsub)

## We download PTMs for mouse
enzsub <- enzyme_substrate(
    resources = c("PhosphoSite", "SIGNOR"),
    organism = 10090
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

## Complexes

Some studies indicate that around 80% of the human proteins operate in
complexes, and many proteins belong to several different complexes
(Berggård, Linse, and James 2007). These complexes play critical roles in a large variety of
biological processes. Some well-known examples are the proteasome and the
ribosome. Thus, the description of the full set of protein complexes
functioning in cells is essential to improve our understanding of biological
processes.

The **complexes** query provides access to more than 20000 protein
complexes. This comprehensive database has been created by integrating
different resources. We now download these molecular complexes filtering by
some of the source databases. We check the complexes where a couple of
specific genes participate. First, we look for the complexes where any of
these two genes participate. We then identify the complex where these two
genes are jointly involved. Finally, we perform an enrichment analysis with
the genes taking part in that complex. You should keep an eye on this complex
since it will be used again in the forthcoming sections.

```
## We check the different complexes databases
complex_resources()
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
##  [1] "CFinder"        "CORUM"          "CellChatDB"     "CellPhoneDB"    "Cellinker"      "Compleat"
##  [7] "ComplexPortal"  "Guide2Pharma"   "Havugimana2012" "ICELLNET"       "KEGG-MEDICUS"   "NetworkBlast"
## [13] "PDB"            "SIGNOR"         "SPIKE"          "hu.MAP"         "hu.MAP2"        "hu.MAP3"
```

```
## We query and store complexes from some sources into a dataframe.
the_complexes <- complexes(resources = c("CORUM", "hu.MAP"))
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
## We check all the molecular complexes where a set of genes participate
query_genes <- c("WRN", "PARP1")

## Complexes where any of the input genes participate
wrn_parp1_complexes <- unique(
    complex_genes(
        the_complexes,
        genes = query_genes,
        all_genes = FALSE
    )
)

## We print the components of the different selected components
head(wrn_parp1_complexes$components_genesymbols, 6)
```

```
## [1] "NCAPD2_NCAPG_NCAPH_PARP1_SMC2_SMC4_XRCC1"
## [2] "CCNA2_CDK2_LIG1_PARP1_POLA1_POLD1_POLE_RFC1_RFC2_RPA1_RPA2_RPA3_TOP1"
## [3] "CCNA2_CCNB1_CDK1_PARP1_POLA1_POLD1_POLE_RFC1_RFC2_RPA1_RPA2_RPA3_TOP1"
## [4] "MRE11_PARP1_RAD50_TERF2_TERF2IP_XRCC5_XRCC6"
## [5] "TERF2_WRN"
## [6] "CALR_DHX30_H2AX_H2BC26_HSPA5_NPM1_PARP1"
```

```
## Complexes where all the input genes participate jointly
complexes_query_genes_join <- unique(
    complex_genes(
        the_complexes,
        genes = query_genes,
        all_genes = TRUE
    )
)

## We print the components of the different selected components
complexes_query_genes_join$components_genesymbols
```

```
## [1] "PARP1_WRN_XRCC5_XRCC6"
```

```
wrn_parp1_cplx_genes <- unlist(
    strsplit(wrn_parp1_complexes$components_genesymbols, "_")
)

## We can perform an enrichment analyses with the genes in the complex
enrichment <- gprofiler2::gost(
    wrn_parp1_cplx_genes,
    significant = TRUE,
    user_threshold = 0.001,
    correction_method = "fdr",
    sources = c("GO:BP", "GO:CC", "GO:MF")
)

## We show the most significant results
enrichment$result %>%
    dplyr::select(term_id, source, term_name, p_value) %>%
    dplyr::top_n(5, -p_value)
```

```
##      term_id source               term_name      p_value
## 1 GO:0051276  GO:BP chromosome organization 9.305220e-33
## 2 GO:0006259  GO:BP   DNA metabolic process 1.644597e-30
## 3 GO:0006281  GO:BP              DNA repair 1.888814e-27
## 4 GO:0005694  GO:CC              chromosome 3.902487e-30
## 5 GO:0005654  GO:CC             nucleoplasm 1.290110e-27
```

## Annotations

Biological annotations are statements, usually traceable and curated, about
the different features of a biological entity. At the genetic level,
annotations describe the biological function, the subcellular situation,
the DNA location and many other related properties of a particular gene or
its gene products.

The annotations query provides a large variety of data about proteins
and complexes. These data come from dozens of databases and each kind of
annotation record contains different fields. Because of this, here we have a
record\_id field which is unique within the records of each database. Each row
contains one key value pair and you need to use the record\_id to connect the
related key-value pairs (see examples below).

Now, we focus in the annotations of the complex studied in the previous
section. We first inspect the different available databases in the omnipath
webserver. Then, we download the annotations for our complex itself as a
biological entity. We find annotations related to the nucleus and
transcriptional control, which is in agreement with the enrichment analysis
results of its individual components.

```
## We check the different annotation databases
annotation_resources()
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
##  [1] "Adhesome"             "Almen2009"            "Baccin2019"           "CORUM_Funcat"
##  [5] "CORUM_GO"             "CSPA"                 "CSPA_celltype"        "CancerDrugsDB"
##  [9] "CancerGeneCensus"     "CancerSEA"            "CellCall"             "CellCellInteractions"
## [13] "CellChatDB"           "CellChatDB_complex"   "CellPhoneDB"          "CellPhoneDB_complex"
## [17] "CellTalkDB"           "CellTypist"           "Cellinker"            "Cellinker_complex"
## [21] "ComPPI"               "CytoSig"              "DGIdb"                "DisGeNet"
## [25] "EMBRACE"              "Exocarta"             "GO_Intercell"         "GPCRdb"
## [29] "Guide2Pharma"         "HGNC"                 "HPA_secretome"        "HPA_subcellular"
## [33] "HPA_tissue"           "HPMR"                 "HumanCellMap"         "ICELLNET"
## [37] "ICELLNET_complex"     "IntOGen"              "Integrins"            "InterPro"
## [41] "KEGG-PC"              "Kirouac2010"          "LOCATE"               "LRdb"
## [45] "Lambert2018"          "MCAM"                 "MSigDB"               "Matrisome"
## [49] "MatrixDB"             "Membranome"           "NetPath"              "OPM"
## [53] "PROGENy"              "PanglaoDB"            "Phobius"              "Phosphatome"
## [57] "Ramilowski2015"       "Ramilowski_location"  "SIGNOR"               "SignaLink_function"
## [61] "SignaLink_pathway"    "Surfaceome"           "TCDB"                 "TFcensus"
## [65] "TopDB"                "UniProt_family"       "UniProt_keyword"      "UniProt_location"
## [69] "UniProt_tissue"       "UniProt_topology"     "Vesiclepedia"         "Wang"
## [73] "Zhong2015"            "connectomeDB2020"     "iTALK"                "kinase.com"
## [77] "scConnect"            "scConnect_complex"    "talklr"
```

```
## We can further investigate the features of the complex selected
## in the previous section.

## We first get the annotations of the complex itself:
cplx_annot <- annotations(
    proteins = paste0("COMPLEX:", wrn_parp1_complexes$components_genesymbols)
)

head(dplyr::select(cplx_annot, source, label, value), 10)
```

```
## # A tibble: 10 × 3
##    source   label          value
##    <chr>    <chr>          <chr>
##  1 HGNC     mainclass      Zinc fingers PARP-type
##  2 DisGeNet disease        Colorectal Cancer
##  3 DisGeNet type           disease
##  4 DisGeNet disease        Colorectal Cancer
##  5 DisGeNet type           disease
##  6 DGIdb    category       ENZYME
##  7 DGIdb    category       TRANSCRIPTION FACTOR
##  8 DGIdb    category       ENZYME
##  9 Phobius  tm_helices     0
## 10 Phobius  signal_peptide False
```

Afterwards, we explore the annotations of the individual components of the
complex in some databases. We check the pathways where these proteins
are involved. Once again, we also find many nucleus related annotations when
checking their cellular location.

Then, we explore some annotations of its individual components. Pathways
where the proteins belong:

```
comp_annot <- annotations(
    proteins = wrn_parp1_cplx_genes,
    resources = "NetPath"
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
dplyr::select(comp_annot, genesymbol, value)
```

```
## # A tibble: 86 × 2
##    genesymbol value
##    <chr>      <chr>
##  1 CDK2       Kit Receptor
##  2 CDK2       Epidermal growth factor receptor (EGFR)
##  3 CDK2       B cell receptor (BCR)
##  4 CDK2       Interleukin-2 (IL-2)
##  5 CDK2       Oncostatin-M (OSM)
##  6 CDK2       Thyroid-stimulating hormone (TSH)
##  7 CDK2       Inhibitor of differentiation (ID)
##  8 CDK2       Fibroblast growth factor-1 (FGF1)
##  9 CDK2       Advanced glycation end-products (AGE/RAGE)
## 10 CDK2       Transforming growth factor beta (TGF-beta) receptor
## # ℹ 76 more rows
```

Subcellular localization of our proteins:

```
subcell_loc <- annotations(
    proteins = wrn_parp1_cplx_genes,
    resources = "ComPPI"
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

Since we have same record\_id for some results of our query, we spread these
records across columns:

```
tidyr::spread(subcell_loc, label, value) %>%
dplyr::arrange(desc(score)) %>%
dplyr::top_n(10, score)
```

```
## # A tibble: 10 × 7
##    uniprot genesymbol entity_type source record_id location score
##    <chr>   <chr>      <chr>       <chr>      <dbl> <chr>    <chr>
##  1 P35580  MYH10      protein     ComPPI     10038 cytosol  0.9999999999638732
##  2 Q9NYB0  TERF2IP    protein     ComPPI      3982 nucleus  0.9999999999187149
##  3 P15927  RPA2       protein     ComPPI      4213 nucleus  0.999999999827968
##  4 Q15554  TERF2      protein     ComPPI       815 nucleus  0.9999999956992
##  5 P16104  H2AX       protein     ComPPI     17421 nucleus  0.9999999922553344
##  6 P09884  POLA1      protein     ComPPI     21030 nucleus  0.999999990784
##  7 O95347  SMC2       protein     ComPPI     14522 nucleus  0.9999999903232
##  8 P12956  XRCC6      protein     ComPPI      2846 nucleus  0.99999997629184
##  9 P78527  PRKDC      protein     ComPPI     13298 nucleus  0.999999951616
## 10 Q15021  NCAPD2     protein     ComPPI     14383 nucleus  0.9999999491968
```

The way above, we more or less reconstituted the data as it is in the
original resource. The same can be done much easier by passing the
`wide = TRUE` parameter to `annotations`. In this case,
if the data contains more than one resources, a list of data frames
will be returned.

```
signalink_pathways <- annotations(
    resources = "SignaLink_pathway",
    wide = TRUE
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

## Intercell

Cells perceive cues from their microenvironment and neighboring cells, and
respond accordingly to ensure proper activities and coordination between
them. The ensemble of these communication process is called inter-cellular
signaling (**intercell**).

**Intercell** query provides information about the roles of proteins in
inter-cellular signaling (e.g. if a protein is a ligand, a receptor, an
extracellular matrix (ECM) component, etc.) This query type is very similar to
annotations. However, **intercell** data does not come from original
sources, but combined from several databases by us into categories (we also
refer to the original sources).

We first inspect the different categories available in the OmniPath webserver.
Then, we focus again in our previously selected complex and we check its
the location of its individual components in the inter-cellular context. We
can however see that the components of this particular complex are
intracellular.

```
## We check some of the different intercell categories
intercell_generic_categories()
```

```
##  [1] "transmembrane"                       "transmembrane_predicted"
##  [3] "peripheral"                          "plasma_membrane"
##  [5] "plasma_membrane_transmembrane"       "plasma_membrane_regulator"
##  [7] "plasma_membrane_peripheral"          "secreted"
##  [9] "cell_surface"                        "ecm"
## [11] "ligand"                              "receptor"
## [13] "secreted_enzyme"                     "secreted_peptidase"
## [15] "extracellular"                       "intracellular"
## [17] "receptor_regulator"                  "secreted_receptor"
## [19] "sparc_ecm_regulator"                 "ecm_regulator"
## [21] "ligand_regulator"                    "cell_surface_ligand"
## [23] "cell_adhesion"                       "matrix_adhesion"
## [25] "adhesion"                            "matrix_adhesion_regulator"
## [27] "cell_surface_enzyme"                 "cell_surface_peptidase"
## [29] "secreted_enyzme"                     "extracellular_peptidase"
## [31] "secreted_peptidase_inhibitor"        "transporter"
## [33] "ion_channel"                         "ion_channel_regulator"
## [35] "gap_junction"                        "tight_junction"
## [37] "adherens_junction"                   "desmosome"
## [39] "intracellular_intercellular_related"
```

```
## We import the intercell data into a dataframe
intercell_loc <- intercell(
    scope = "generic",
    aspect = "locational"
)

## We check the intercell annotations for the individual components of
## our previous complex. We filter our data to print it in a good format
dplyr::filter(intercell_loc, genesymbol %in% wrn_parp1_cplx_genes) %>%
dplyr::distinct(genesymbol, parent, .keep_all = TRUE) %>%
dplyr::select(category, genesymbol, parent) %>%
dplyr::arrange(genesymbol)
```

```
## # A tibble: 84 × 3
##    category        genesymbol parent
##    <chr>           <chr>      <chr>
##  1 extracellular   ACTB       extracellular
##  2 intracellular   ACTB       intracellular
##  3 intracellular   ATE1       intracellular
##  4 intracellular   BANF1      intracellular
##  5 secreted        CALR       secreted
##  6 extracellular   CALR       extracellular
##  7 intracellular   CALR       intracellular
##  8 transmembrane   CAMK2D     transmembrane
##  9 plasma_membrane CAMK2D     plasma_membrane
## 10 intracellular   CAMK2D     intracellular
## # ℹ 74 more rows
```

The `intercell_network` function creates the most complete network,
including many interactions which are false positives in the context of
interacellular communication. It is highly recommended to apply some
quality filtering on this network. The `high_confidence` parameter performs
a quiet stringent filtering:

```
icn <- intercell_network(high_confidence = TRUE)
```

Using the function `filter_intercell_network` instead, you have much more
flexibility to adjust the stringency of the filtering to the needs of your
analysis. See the full list of options in the docs of the function.

```
icn <-
    intercell_network() %>%
    filter_intercell_network(
        min_curation_effort = 1,
        consensus_percentile = 33
    )
```

```
## We close graphical connections
while (!is.null(dev.list()))  dev.off()
```

# Conclusion

*[OmnipathR](https://bioconductor.org/packages/3.22/OmnipathR)* provides access to the wealth of data stored in the
OmniPath webservice <http://omnipathdb.org/> from the *R* enviroment.
In addition, it contains some utility functions for visualization, filtering
and analysis. The main strength of *[OmnipathR](https://bioconductor.org/packages/3.22/OmnipathR)* is the
straightforward transformation of the different OmniPath data into commonly
used *R* objects, such as dataframes and graphs. Consequently, it allows an
easy integration of the different types of data and a gateway to the vast
number of *R* packages dedicated to the analysis and representaiton of
biological data. We highlighted these abilities in some of the examples
detailed in previous sections of this document.

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
##  [1] gprofiler2_0.2.4 tidyr_1.3.2      knitr_1.51       magrittr_2.0.4   ggraph_2.2.2     igraph_2.2.1
##  [7] ggplot2_4.0.1    dplyr_1.1.4      OmnipathR_3.18.4 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] bitops_1.0-9        DBI_1.2.3           gridExtra_2.3       httr2_1.2.2         tcltk_4.5.2
##   [6] logger_0.4.1        readxl_1.4.5        rlang_1.1.7         otel_0.2.0          compiler_4.5.2
##  [11] RSQLite_2.4.5       png_0.1-8           vctrs_0.7.1         rvest_1.0.5         stringr_1.6.0
##  [16] pkgconfig_2.0.3     crayon_1.5.3        fastmap_1.2.0       backports_1.5.0     magick_2.9.0
##  [21] labeling_0.4.3      utf8_1.2.6          promises_1.5.0      rmarkdown_2.30      sessioninfo_1.2.3
##  [26] tzdb_0.5.0          ps_1.9.1            tinytex_0.58        purrr_1.2.1         bit_4.6.0
##  [31] xfun_0.56           cachem_1.1.0        jsonlite_2.0.0      progress_1.2.3      blob_1.3.0
##  [36] later_1.4.5         tweenr_2.0.3        parallel_4.5.2      prettyunits_1.2.0   R6_2.6.1
##  [41] bslib_0.10.0        stringi_1.8.7       RColorBrewer_1.1-3  lubridate_1.9.4     jquerylib_0.1.4
##  [46] cellranger_1.1.0    Rcpp_1.1.1          bookdown_0.46       R.utils_2.13.0      readr_2.1.6
##  [51] timechange_0.3.0    tidyselect_1.2.1    dichromat_2.0-0.1   yaml_2.3.12         viridis_0.6.5
##  [56] websocket_1.4.4     curl_7.0.0          processx_3.8.6      tibble_3.3.1        withr_3.0.2
##  [61] S7_0.2.1            evaluate_1.0.5      polyclip_1.10-7     zip_2.3.3           xml2_1.5.2
##  [66] pillar_1.11.1       BiocManager_1.30.27 checkmate_2.3.3     plotly_4.12.0       generics_0.1.4
##  [71] RCurl_1.98-1.17     vroom_1.7.0         chromote_0.5.1      hms_1.1.4           scales_1.4.0
##  [76] glue_1.8.0          lazyeval_0.2.2      tools_4.5.2         data.table_1.18.2.1 fs_1.6.6
##  [81] graphlayouts_1.2.2  XML_3.99-0.20       tidygraph_1.3.1     grid_4.5.2          ggforce_0.5.0
##  [86] cli_3.6.5           rappdirs_0.3.4      viridisLite_0.4.2   gtable_0.3.6        R.methodsS3_1.8.2
##  [91] selectr_0.5-1       sass_0.4.10         digest_0.6.39       ggrepel_0.9.6       htmlwidgets_1.6.4
##  [96] farver_2.1.2        memoise_2.0.1       htmltools_0.5.9     R.oo_1.27.1         lifecycle_1.0.5
## [101] httr_1.4.7          bit64_4.6.0-1       MASS_7.3-65
```

# References

Ben-Shlomo, I., S. Yu Hsu, R. Rauch, H. W. Kowalski, and A. J. W. Hsueh. 2003. “Signaling Receptome: A Genomic and Evolutionary Perspective of Plasma Membrane Receptors Involved in Signal Transduction.” *Science Signaling* 2003 (187): re9–re9. <https://doi.org/10.1126/stke.2003.187.re9>.

Berggård, Tord, Sara Linse, and Peter James. 2007. “Methods for the Detection and Analysis of Proteinprotein Interactions.” *PROTEOMICS* 7 (16): 2833–42. <https://doi.org/10.1002/pmic.200700131>.

Dinkel, H., C. Chica, A. Via, C. M. Gould, L. J. Jensen, T. J. Gibson, and F. Diella. 2010. “Phospho.ELM: A Database of Phosphorylation Sites–Update 2011.” *Nucleic Acids Research* 39 (Database): D261–D267. <https://doi.org/10.1093/nar/gkq1104>.

Dobson, László, Tamás Langó, István Reményi, and Gábor E. Tusnády. 2014. “Expediting Topology Data Gathering for the TOPDB Database.” *Nucleic Acids Research* 43 (D1): D283–D289. <https://doi.org/10.1093/nar/gku1119>.

Drew, Kevin, Chanjae Lee, Ryan L Huizar, Fan Tu, Blake Borgeson, Claire D McWhite, Yun Ma, John B Wallingford, and Edward M Marcotte. 2017. “Integration of over 9, 000 Mass Spectrometry Experiments Builds a Global Map of Human Protein Complexes.” *Molecular Systems Biology* 13 (6): 932. <https://doi.org/10.15252/msb.20167490>.

Garcia-Alonso, Luz, Christian H. Holland, Mahmoud M. Ibrahim, Denes Turei, and Julio Saez-Rodriguez. 2019. “Benchmark and Integration of Resources for the Estimation of Human Transcription Factor Activities.” *Genome Research* 29 (8): 1363–75. <https://doi.org/10.1101/gr.240663.118>.

Giurgiu, Madalina, Julian Reinhard, Barbara Brauner, Irmtraud Dunger-Kaltenbach, Gisela Fobo, Goar Frishman, Corinna Montrone, and Andreas Ruepp. 2018. “CORUM: The Comprehensive Resource of Mammalian Protein Complexes2019.” *Nucleic Acids Research* 47 (D1): D559–D563. <https://doi.org/10.1093/nar/gky973>.

Hornbeck, Peter V., Bin Zhang, Beth Murray, Jon M. Kornhauser, Vaughan Latham, and Elzbieta Skrzypek. 2014. “PhosphoSitePlus, 2014: Mutations, PTMs and Recalibrations.” *Nucleic Acids Research* 43 (D1): D512–D520. <https://doi.org/10.1093/nar/gku1267>.

Keerthikumar, Shivakumar, David Chisanga, Dinuka Ariyaratne, Haidar Al Saffar, Sushma Anand, Kening Zhao, Monisha Samuel, et al. 2016. “ExoCarta: A Web-Based Compendium of Exosomal Cargo.” *Journal of Molecular Biology* 428 (4): 688–92. <https://doi.org/10.1016/j.jmb.2015.09.019>.

Türei, Dénes, Tamás Korcsmáros, and Julio Saez-Rodriguez. 2016. “OmniPath: Guidelines and Gateway for Literature-Curated Signaling Pathway Resources.” *Nature Methods* 13 (12): 966–67. <https://doi.org/10.1038/nmeth.4077>.

Vento-Tormo, Roser, Mirjana Efremova, Rachel A. Botting, Margherita Y. Turco, Miquel Vento-Tormo, Kerstin B. Meyer, Jong-Eun Park, et al. 2018. “Single-Cell Reconstruction of the Early Maternalfetal Interface in Humans.” *Nature* 563 (7731): 347–53. <https://doi.org/10.1038/s41586-018-0698-6>.