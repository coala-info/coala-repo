# OmniPath Bioconductor workshop

Denes Turei\*, Alberto Valdeolivas, Attila Gabor and Julio Saez-Rodriguez1

1Institute for Computational Biomedicine, Heidelberg University

\*turei.denes@gmail.com

#### 29 January 2026

#### Abstract

OmniPath is a database of molecular signaling knowledge, combining data
from more than 100 resources. It contains protein-protein and gene
regulatory interactions, enzyme-PTM relationships, protein complexes,
annotations about protein function, structure, localization and
intercellular communication. OmniPath focuses on networks with directed
interactions and effect signs (activation or inhibition) which are suitable
inputs for many modeling techniques. OmniPath also features a large
collection of proteins’ intercellular communication roles and interactions.
OmniPath is distributed by a web service at <https://omnipathdb.org/>. The
Bioconductor package OmnipathR is an R client with full support for all
features of the OmniPath web server. Apart from OmniPath, it provides
direct access to more than 15 further signaling databases (such as BioPlex,
InBioMap, EVEX, Harmonizome, etc) and contains a number of convenience
methods, such as igraph integration, and a close integration with the
NicheNet pipeline for ligand activity prediction from transcriptomics data.
In this demo we show the diverse data in OmniPath and the versatile and
convenient ways to access this data by OmnipathR.

#### Package

OmnipathR 3.18.4

# Contents

* [1 Introduction](#introduction)
* [2 Overview](#overview)
  + [2.1 Pre-requisites](#pre-requisites)
  + [2.2 Participation](#participation)
  + [2.3 *R* / *Bioconductor* packages used](#r-bioconductor-packages-used)
  + [2.4 Time outline](#time-outline)
  + [2.5 Workshop goals and objectives](#workshop-goals-and-objectives)
  + [2.6 Learning goals](#learning-goals)
  + [2.7 Learning objectives](#learning-objectives)
* [3 Workshop](#workshop)
  + [3.1 Data from OmniPath](#data-from-omnipath)
    - [3.1.1 Networks](#networks)
      * [3.1.1.1 Igraph integration](#igraph-integration)
    - [3.1.2 Enzyme-substrate relationships](#enzyme-substrate-relationships)
    - [3.1.3 Protein complexes](#protein-complexes)
    - [3.1.4 Annotations](#annotations)
      * [3.1.4.1 Combining networks with annotations](#combining-networks-with-annotations)
    - [3.1.5 Intercellular communication roles](#intercellular-communication-roles)
    - [3.1.6 Metadata](#metadata)
  + [3.2 Data from other resources](#data-from-other-resources)
  + [3.3 General purpose functionalities](#general-purpose-functionalities)
    - [3.3.1 Identifier translation](#identifier-translation)
    - [3.3.2 Gene Ontology](#gene-ontology)
  + [3.4 Useful tips](#useful-tips)
  + [3.5 Further information](#further-information)
* [Session info](#session-info)
* [References](#references)
* **Appendix**

# 1 Introduction

Database knowledge is essential for omics data analysis and modeling. Despite
being an important factor, contributing to the outcome of studies, often
subject to little attention. With [OmniPath](https://omnipathdb.org/) our aim
is to raise awarness of the diversity of available resources and facilitate
access to these resources in a uniform and transparent way. OmniPath has been
developed in a close contact to mechanistic modeling applications and
functional omics analysis, hence it is especially suitable for these fields.
OmniPath has been used for the analysis of various omics data. In the
[Saez-Rodriguez group](https://saezlab.org) we often use it in a pipeline
with our footprint based methods [DoRothEA](https://saezlab.github.io/dorothea/) and [PROGENy](https://saezlab.github.io/progeny/) and our causal reasoning method
[CARNIVAL](https://saezlab.github.io/CARNIVAL/) to infer signaling mechanisms
from transcriptomics data.

One recent novelty of OmniPath is a collection of intercellular communication
interactions. Apart from simply merging data from existing resources,
OmniPath defines a number of intercellular communication roles, such as
ligand, receptor, adhesion, enzyme, matrix, etc, and generalizes the terms
*ligand* and *receptor* by introducing the terms *transmitter*, *receiver*
and *mediator*. This unique knowledge base is especially adequate for the
emerging field of cell-cell communication analysis, typically from single
cell transcriptomics, but also from other kinds of data.

# 2 Overview

## 2.1 Pre-requisites

No special pre-requisites apart from basic knowledge of R. OmniPath, the
database resource in the focus of this workshop has been published in [1,2],
however you don’t need to know anything about OmniPath to benefit from the
workshop. In the workshop we will demonstrate the [R/Bioconductor package](https://bioconductor.org/packages/release/bioc/html/OmnipathR.html)
[OmnipathR](https://github.com/saezlab/OmnipathR). If you would like to try
the examples yourself we recommend to install the latest version of the
package before the workshop:

```
library(devtools)
install_github('saezlab/OmnipathR')
```

## 2.2 Participation

In the workshop we will present the design and some important features of the
OmniPath database, so can be confident you get the most out of it. Then we
will demonstrate further useful features of the OmnipathR package, such as
accessing other resources, building graphs. Participants are encouraged to
experiment with the examples and shape the contents of the workshop by asking
questions. We are happy to recieve questions and topic suggestions **by
email** also **before the workshop**. These could help us to adjust the
contents to the interests of the participants.

## 2.3 *R* / *Bioconductor* packages used

* OmnipathR
* igraph
* dplyr

## 2.4 Time outline

Total: 45 minutes

| Activity | Time |
| --- | --- |
| OmniPath database overview | 5m |
| Network datasets | 10m |
| Other OmniPath databases | 5m |
| Intercellular communication | 10m |
| Igraph integration | 5m |
| Further resources | 10m |

## 2.5 Workshop goals and objectives

In this workshop you will get familiar with the design and features of the
OmniPath databases. For example, to know some important details about the
datasets and parameters which help you to query the database the most
suitable way according to your purposes. You will also learn about
functionalities of the *OmnipathR* package which might make your work
easier.

## 2.6 Learning goals

* Learn about the OmniPath database, its contents and how it can be useful
* Get a picture about the OmnipathR package capabilities
* Learn about the datasets and parameters of various OmniPath query types

## 2.7 Learning objectives

* Try examples of each OmniPath query type with various parameters
* Build igraph networks, search for paths
* Access some further interesting resources

# 3 Workshop

```
library(OmnipathR)
```

## 3.1 Data from OmniPath

OmniPath consists of five major databases, each combining many original
resources. The five databases are:

* Network (interactions)
* Enzyme-substrate relationships (enzsub)
* Protein complexes (complexes)
* Annotations (annotations)
* Intercellular communication roles (intercell)

The parameters for each database (query type) are available in the web
service, for example: <https://omnipathdb.org/queries/interactions>. The
R package supports all features of the web service and the parameter
names and values usually correspond to the web service parameters which
you would use in a HTTP query string.

### 3.1.1 Networks

The network database contains protein-protein, gene regulatory and miRNA-mRNA
interactions. Soon more interaction types will be added. Some of these
categories can be further divided into datasets which are defined by the
type of evidences. A full list of network datasets:

* Protein-protein interactions *(post\_translational)*
  + **omnipath:** literature curated, directed interactions with effect signs;
    corresponds to the first edition of OmniPath, hence the confusing name
    is due to historical reasons
  + **pathwayextra:** directed and signed interactions, without literature
    references (might be literature curated, but references are not
    available)
  + **kinaseextra:** enzyme-PTM interactions without literature references
  + **ligrecextra:** ligand-receptor interactions without literature
    references
* Gene regulatory interactions *(transcriptional)*
  + **dorothea:** a comprehensive collection built out of 18 resources,
    contains literature curated, ChIP-Seq, gene expression derived
    and TF binding site predicted data, with 5 confidence levels (A-E)
  + **tf\_target:** additional literature curated interactions
* miRNA interactions *(post\_transcriptional and mirna\_transcriptional)*
  + **mirnatarget:** literature curated miRNA-mRNA interactions
  + **tf\_mirna:** literature curated TF-miRNA interactions (transcriptional
    regulations of miRNA)
* lncRNA interactions *(lncrna\_post\_transcriptional)*
  + **lncrna\_mrna:** literature curated lncRNA-mRNA interactions
* Small molecule-protein interactions *(small\_molecule\_protein)*
  + **small\_molecule:** metabolites, intrinsic ligands or drug compounds
    targeting human proteins

The functions accessing the above datasets are listed
[here](https://r.omnipathdb.org/reference/omnipath-interactions.html).

Not individual interactions but resource are classified into the datasets
above, so these can overlap. Each interaction type and dataset has its
dedicated function in `OmnipathR`, above we provide links to their help
pages. As an example, let’s see the gene regulatory interactions:

```
gri <- transcriptional()
gri
```

```
## # A tibble: 131,398 × 16
##    source                target source_genesymbol target_genesymbol is_directed is_stimulation is_inhibition
##    <chr>                 <chr>  <chr>             <chr>                   <dbl>          <dbl>         <dbl>
##  1 P01106                O14746 MYC               TERT                        1              1             0
##  2 P17947                P02818 SPI1              BGLAP                       1              1             0
##  3 COMPLEX:P05412_P17535 P05412 JUN_JUND          JUN                         1              1             0
##  4 COMPLEX:P01100_P17535 P05412 FOS_JUND          JUN                         1              1             0
##  5 COMPLEX:P17275        P05412 JUNB              JUN                         1              1             0
##  6 COMPLEX:P05412_P17275 P05412 JUN_JUNB          JUN                         1              1             0
##  7 COMPLEX:P05412_P15407 P05412 FOSL1_JUN         JUN                         1              1             0
##  8 COMPLEX:P15407_P17275 P05412 FOSL1_JUNB        JUN                         1              1             0
##  9 COMPLEX:P17535        P05412 JUND              JUN                         1              1             0
## 10 COMPLEX:P05412        P05412 JUN               JUN                         1              1             0
## # ℹ 131,388 more rows
## # ℹ 9 more variables: consensus_direction <dbl>, consensus_stimulation <dbl>, consensus_inhibition <dbl>,
## #   sources <chr>, references <chr>, curation_effort <dbl>, dorothea_level <chr>, n_references <dbl>,
## #   n_resources <int>
```

The interaction data frame contains the UniProt IDs and Gene Symbols of
the interacting partners, the list of resources and references (PubMed IDs)
for each interaction, and whether the interaction is directed,
stimulatory or inhibitory.

#### 3.1.1.1 Igraph integration

The network data frames can be converted to igraph graph objects, so you
can make use of the graph and visualization methods of igraph:

```
gr_graph <- interaction_graph(gri)
gr_graph
```

```
## IGRAPH 2d7650a DN-- 15846 131398 --
## + attr: name (v/c), up_ids (v/c), is_directed (e/n), is_stimulation (e/n), is_inhibition (e/n),
## | consensus_direction (e/n), consensus_stimulation (e/n), consensus_inhibition (e/n), sources
## | (e/x), references (e/x), curation_effort (e/n), dorothea_level (e/c), n_references (e/n),
## | n_resources (e/n)
## + edges from 2d7650a (vertex names):
##  [1] MYC       ->TERT  SPI1      ->BGLAP JUN_JUND  ->JUN   FOS_JUND  ->JUN   JUNB      ->JUN
##  [6] JUN_JUNB  ->JUN   FOSL1_JUN ->JUN   FOSL1_JUNB->JUN   JUND      ->JUN   JUN       ->JUN
## [11] FOSL2_JUNB->JUN   FOSL2_JUN ->JUN   FOSB_JUNB ->JUN   FOSL1_JUND->JUN   FOSL2_JUND->JUN
## [16] FOSB_JUN  ->JUN   JUNB_JUND ->JUN   FOS_JUNB  ->JUN   FOS_JUN   ->JUN   FOSB_JUND ->JUN
## [21] SMAD3     ->JUN   SMAD4     ->JUN   STAT5A    ->IL2   STAT5B    ->IL2   RELA      ->FAS
## + ... omitted several edges
```

On this network we can use `OmnipathR`’s `find_all_paths` function, which
is able to look up all paths up to a certain length between two set of
nodes:

```
paths <- find_all_paths(
    graph = gr_graph,
    start = c('EGFR', 'STAT3'),
    end = c('AKT1', 'ULK1'),
    attr = 'name'
)
```

```
## Warning: `cross2()` was deprecated in purrr 1.0.0.
## ℹ Please use `tidyr::expand_grid()` instead.
## ℹ See <https://github.com/tidyverse/purrr/issues/768>.
## ℹ The deprecated feature was likely used in the OmnipathR package.
##   Please report the issue at <https://github.com/saezlab/OmnipathR/issues>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

```
## Warning: `cross()` was deprecated in purrr 1.0.0.
## ℹ Please use `tidyr::expand_grid()` instead.
## ℹ See <https://github.com/tidyverse/purrr/issues/768>.
## ℹ The deprecated feature was likely used in the purrr package.
##   Please report the issue at <https://github.com/tidyverse/purrr/issues>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

*As this is a gene regulatory network, the paths are TFs regulating the
transcription of other TFs.*

### 3.1.2 Enzyme-substrate relationships

Enzyme-substrate interactions are also available also in the interactions
query, but the enzyme-substrate query type provides additional information
about the PTM types and residues.

```
enz_sub <- enzyme_substrate()
enz_sub
```

```
## # A tibble: 47,840 × 12
##    enzyme substrate enzyme_genesymbol substrate_genesymbol residue_type residue_offset modification    sources
##    <chr>  <chr>     <chr>             <chr>                <chr>                 <dbl> <chr>           <chr>
##  1 P06239 O14543    LCK               SOCS3                Y                       204 phosphorylation KEA;MI…
##  2 P06239 O14543    LCK               SOCS3                Y                       221 phosphorylation KEA;MI…
##  3 P12931 O14746    SRC               TERT                 Y                       707 phosphorylation BEL-La…
##  4 P06241 O15117    FYN               FYB1                 Y                       651 phosphorylation HPRD;K…
##  5 P06241 O15117    FYN               FYB1                 Y                       595 phosphorylation HPRD;K…
##  6 P06241 O15117    FYN               FYB1                 Y                       697 phosphorylation HPRD;K…
##  7 P06241 O15117    FYN               FYB1                 Y                       625 phosphorylation Phosph…
##  8 P06241 O15117    FYN               FYB1                 Y                       571 phosphorylation Phosph…
##  9 P06241 O15117    FYN               FYB1                 Y                       771 phosphorylation Phosph…
## 10 P06241 O15117    FYN               FYB1                 Y                       559 phosphorylation Phosph…
## # ℹ 47,830 more rows
## # ℹ 4 more variables: references <chr>, curation_effort <dbl>, n_references <dbl>, n_resources <int>
```

This data frame also can be converted to an igraph object:

```
es_graph <- enzsub_graph(enz_sub)
es_graph
```

```
## IGRAPH c93e1ac DN-- 5167 47840 --
## + attr: name (v/c), up_ids (v/c), residue_type (e/c), residue_offset (e/n), modification (e/c),
## | sources (e/x), references (e/x), curation_effort (e/n), n_references (e/n), n_resources (e/n)
## + edges from c93e1ac (vertex names):
##  [1] LCK  ->SOCS3  LCK  ->SOCS3  SRC  ->TERT   FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1
##  [8] FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1
## [15] FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1   FYN  ->FYB1
## [22] ABL1 ->PLSCR1 ABL1 ->PLSCR1 SRC  ->PLSCR1 SRC  ->PLSCR1 ABL1 ->TP73   CDK2 ->TP73   CHEK1->TP73
## [29] AURKB->BIRC5  AURKB->BIRC5  AURKB->BIRC5  CDK1 ->BIRC5  PDPK1->PDPK1  PDPK1->PDPK1  PDPK1->PDPK1
## [36] PDPK1->PDPK1  PDPK1->PDPK1  PDPK1->PDPK1  PDPK1->PDPK1  PDPK1->PDPK1  PDPK1->PDPK1  PDPK1->PDPK1
## [43] PDPK1->PDPK1  PDPK1->PDPK1  SRC  ->PDPK1  SRC  ->PDPK1  SRC  ->PDPK1  SRC  ->PDPK1  SRC  ->PDPK1
## + ... omitted several edges
```

It is also possible to add effect signs (stimulatory or inhibitory) to
enzyme-PTM relationships:

```
es_signed <- signed_ptms(enz_sub)
```

### 3.1.3 Protein complexes

```
cplx <- complexes()
cplx
```

```
## # A tibble: 52,085 × 7
##    name         components                 components_genesymbols stoichiometry sources references identifiers
##    <chr>        <chr>                      <chr>                  <chr>         <chr>   <chr>      <chr>
##  1 NFY          P23511_P25208_Q13952       NFYA_NFYB_NFYC         1:1:1         CORUM;… 9372932;1… CORUM:4478…
##  2 mTORC2       P42345_P68104_P85299_Q6R3… DEPTOR_EEF1A1_MLST8_M… 0:0:0:0:0:0   SIGNOR  <NA>       SIGNOR:SIG…
##  3 mTORC1       P42345_Q8N122_Q8TB45_Q96B… AKT1S1_DEPTOR_MLST8_M… 0:0:0:0:0     SIGNOR  <NA>       SIGNOR:SIG…
##  4 SCF-betaTRCP P63208_Q13616_Q9Y297       BTRC_CUL1_SKP1         1:1:1         CORUM;… 9990852    CORUM:227;…
##  5 CBP/p300     Q09472_Q92793              CREBBP_EP300           0:0           SIGNOR… <NA>       SIGNOR:SIG…
##  6 P300/PCAF    Q09472_Q92793_Q92831       CREBBP_EP300_KAT2B     0:0:0         SIGNOR  <NA>       SIGNOR:SIG…
##  7 SMAD2/SMAD4  Q13485_Q15796              SMAD2_SMAD4            1:2           Comple… 12923550;… PDB:1u7v;S…
##  8 SMAD3/SMAD4  P84022_Q13485              SMAD3_SMAD4            2:1           Comple… 12923550;… PDB:1U7F;P…
##  9 SMAD4/JUN    P05412_Q13485              JUN_SMAD4              0:0           SIGNOR  <NA>       SIGNOR:SIG…
## 10 SMAD2/SMURF2 Q15796_Q9HAU4              SMAD2_SMURF2           1:1           Comple… 11389444   Compleat:H…
## # ℹ 52,075 more rows
```

The resulted data frame provides the constitution and stoichiometry of
protein complexes, with references.

### 3.1.4 Annotations

The annotations query type includes a diverse set of resources (about 60 of
them), about protein function, localization, structure and expression. For
most use cases it is better to convert the data into wide data frames, as
these correspond to the original format of the resources. If you load more
than one resources into wide data frames, the result will be a list of
data frames, otherwise one data frame. See a few examples with localization
data from UniProt, tissue expression from Human Protein Atlas and
pathway information from SignaLink:

```
uniprot_loc <- annotations(
    resources = 'UniProt_location',
    wide = TRUE
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
uniprot_loc
```

```
## # A tibble: 76,883 × 5
##    uniprot    genesymbol entity_type location                     features
##    <chr>      <chr>      <chr>       <chr>                        <chr>
##  1 A0A087X1C5 CYP2D7     protein     Membrane                     Multi-pass membrane protein
##  2 A0A087X1C5 CYP2D7     protein     Cytoplasm                    <NA>
##  3 A0A087X1C5 CYP2D7     protein     Mitochondrion                <NA>
##  4 A0A0B4J2F0 PIGBOS1    protein     Mitochondrion outer membrane Single-pass membrane protein
##  5 A0A0C5B5G6 MT-RNR1    protein     Nucleus                      <NA>
##  6 A0A0C5B5G6 MT-RNR1    protein     Secreted                     <NA>
##  7 A0A0C5B5G6 MT-RNR1    protein     Mitochondrion                <NA>
##  8 A0A0K2S4Q6 CD300H     protein     Membrane                     Single-pass type I membrane protein
##  9 A0A0K2S4Q6 CD300H     protein     Secreted                     <NA>
## 10 A0A0U1RRE5 NBDY       protein     Cytoplasm                    <NA>
## # ℹ 76,873 more rows
```

The `entity_type` field can be protein, mirna or complex. Protein complexes
mostly annotated based on the consensus of their members, we should be aware
that this is an *in silico* inference.

In case of spelling mistake either in parameter names or values `OmnipathR`
either corrects the mistake or gives a warning or error:

```
uniprot_loc <- annotations(
    resources = 'Uniprot_location',
    wide = TRUE
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
## Warning in omnipath_check_param(.): The following resources are not available: Uniprot_location. Check the
## resource names for spelling mistakes.
```

Above the name of the resource is wrong. If the parameter name is wrong, it
throws an error:

```
uniprot_loc <- annotations(
    resuorces = 'UniProt_location',
    wide = TRUE
)
```

```
## Error in `annotations()`:
## ! Downloading the entire annotations database is not allowed by default because of its huge size (>1GB). If you really want to do that, you find static files at https://archive.omnipathdb.org/. However we recommend to query a set of proteins or a few resources, depending on your interest.
```

Singular vs. plural forms and a few synonyms are automatically corrected:

```
uniprot_loc <- annotations(
    resource = 'UniProt_location',
    wide = TRUE
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

Another example with tissue expression from Human Protein Atlas:

```
hpa_tissue <- annotations(
    resources = 'HPA_tissue',
    wide = TRUE,
    # Limiting to a handful of proteins for a faster vignette build:
    proteins = c('DLL1', 'MEIS2', 'PHOX2A', 'BACH1', 'KLF11', 'FOXO3', 'MEFV')
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
hpa_tissue
```

```
## # A tibble: 469 × 15
##    uniprot genesymbol entity_type organ          tissue cell_type level status prognostic favourable pathology
##    <chr>   <chr>      <chr>       <chr>          <chr>  <chr>     <chr> <chr>  <lgl>      <lgl>      <lgl>
##  1 O43524  FOXO3      protein     Skin           Skin 1 fibrohis… Not … Suppo… FALSE      FALSE      FALSE
##  2 O43524  FOXO3      protein     Lung           Lung   alveolar… High  Suppo… FALSE      FALSE      FALSE
##  3 O43524  FOXO3      protein     Endometrium    Endom… cells in… High  Suppo… FALSE      FALSE      FALSE
##  4 O43524  FOXO3      protein     testis cancer  testi… <NA>      High  <NA>   NA         NA         TRUE
##  5 O43524  FOXO3      protein     prostate canc… prost… <NA>      Medi… <NA>   NA         NA         TRUE
##  6 O43524  FOXO3      protein     Tonsil         Tonsil squamous… High  Suppo… FALSE      FALSE      FALSE
##  7 O43524  FOXO3      protein     Endometrium    Endom… glandula… High  Suppo… FALSE      FALSE      FALSE
##  8 O43524  FOXO3      protein     Kidney         Kidney cells in… Medi… Suppo… FALSE      FALSE      FALSE
##  9 O43524  FOXO3      protein     Nasopharynx    Nasop… respirat… Low   Suppo… FALSE      FALSE      FALSE
## 10 O43524  FOXO3      protein     Stomach        Stoma… glandula… Medi… Suppo… FALSE      FALSE      FALSE
## # ℹ 459 more rows
## # ℹ 4 more variables: n_not_detected <dbl>, n_low <dbl>, n_medium <dbl>, n_high <dbl>
```

And pathway annotations from SignaLink:

```
slk_pathw <- annotations(
    resources = 'SignaLink_pathway',
    wide = TRUE
)
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
slk_pathw
```

```
## # A tibble: 2,578 × 4
##    uniprot genesymbol entity_type pathway
##    <chr>   <chr>      <chr>       <chr>
##  1 P20963  CD247      protein     T-cell receptor
##  2 P43403  ZAP70      protein     T-cell receptor
##  3 P43403  ZAP70      protein     Receptor tyrosine kinase
##  4 Q9NYJ8  TAB2       protein     Receptor tyrosine kinase
##  5 Q9NYJ8  TAB2       protein     JAK/STAT
##  6 Q9NYJ8  TAB2       protein     Innate immune pathways
##  7 Q9NYJ8  TAB2       protein     Toll-like receptor
##  8 O43318  MAP3K7     protein     B-cell receptor
##  9 O43318  MAP3K7     protein     TNF pathway
## 10 O43318  MAP3K7     protein     WNT
## # ℹ 2,568 more rows
```

#### 3.1.4.1 Combining networks with annotations

Annotations can be easily added to network data frames, in this case both
the source and target nodes will have their annotation data. This function
accepts either the name of an annotation resource or an annotation data
frame:

```
network <- omnipath()

network_slk_pw <- annotated_network(network, 'SignaLink_pathway')
```

```
## Warning in readLines(con = path, encoding = encoding): incomplete final line found on
## 'https://omnipathdb.org/resources'
```

```
network_slk_pw
```

```
## # A tibble: 120,864 × 17
##    source target source_genesymbol target_genesymbol is_directed is_stimulation is_inhibition
##    <chr>  <chr>  <chr>             <chr>                   <dbl>          <dbl>         <dbl>
##  1 P0DP25 P48995 CALM3             TRPC1                       1              0             1
##  2 P0DP23 P48995 CALM1             TRPC1                       1              0             1
##  3 P0DP24 P48995 CALM2             TRPC1                       1              0             1
##  4 Q03135 P48995 CAV1              TRPC1                       1              1             0
##  5 P14416 P48995 DRD2              TRPC1                       1              1             0
##  6 Q99750 P48995 MDFI              TRPC1                       1              0             1
##  7 Q14571 P48995 ITPR2             TRPC1                       1              1             0
##  8 P29966 P48995 MARCKS            TRPC1                       1              0             1
##  9 Q13255 P48995 GRM1              TRPC1                       1              1             0
## 10 Q13586 P48995 STIM1             TRPC1                       1              1             0
## # ℹ 120,854 more rows
## # ℹ 10 more variables: consensus_direction <dbl>, consensus_stimulation <dbl>, consensus_inhibition <dbl>,
## #   sources <chr>, references <chr>, curation_effort <dbl>, n_references <int>, n_resources <int>,
## #   pathway_source <chr>, pathway_target <chr>
```

### 3.1.5 Intercellular communication roles

The `intercell` database assigns roles to proteins such as ligand, receptor,
adhesion, transporter, ECM, etc. The design of this database is far from
being simple, best is to check the description in the recent OmniPath paper
[1].

```
ic <- intercell()
ic
```

```
## # A tibble: 388,239 × 15
##    category     parent database scope aspect source uniprot genesymbol entity_type consensus_score transmitter
##    <chr>        <chr>  <chr>    <chr> <chr>  <chr>  <chr>   <chr>      <chr>                 <dbl> <lgl>
##  1 transmembra… trans… UniProt… gene… locat… resou… Q8IUH4  ZDHHC13    protein                   4 FALSE
##  2 transmembra… trans… UniProt… gene… locat… resou… A6NGZ8  SMIM9      protein                   5 FALSE
##  3 transmembra… trans… UniProt… gene… locat… resou… Q8N292  GAPT       protein                   5 FALSE
##  4 transmembra… trans… UniProt… gene… locat… resou… Q9Y5I2  PCDHA10    protein                   3 FALSE
##  5 transmembra… trans… UniProt… gene… locat… resou… Q99466  NOTCH4     protein                   5 FALSE
##  6 transmembra… trans… UniProt… gene… locat… resou… Q5T3U5  ABCC10     protein                   5 FALSE
##  7 transmembra… trans… UniProt… gene… locat… resou… Q9NQX5  NPDC1      protein                   5 FALSE
##  8 transmembra… trans… UniProt… gene… locat… resou… Q9HCJ2  LRRC4C     protein                   6 FALSE
##  9 transmembra… trans… UniProt… gene… locat… resou… O60741  HCN1       protein                   6 FALSE
## 10 transmembra… trans… UniProt… gene… locat… resou… Q96ES6  MFSD3      protein                   4 FALSE
## # ℹ 388,229 more rows
## # ℹ 4 more variables: receiver <lgl>, secreted <lgl>, plasma_membrane_transmembrane <lgl>,
## #   plasma_membrane_peripheral <lgl>
```

This data frame is about individual proteins. To create a network of
intercellular communication, we provide the `intercell_network`
function:

```
icn <- intercell_network(high_confidence = TRUE)
icn
```

```
## NULL
```

The result is similar to the `annotated_network`, each interacting partner
has its intercell annotations. In the `intercell` database, OmniPath aims to
ship all available information, which means it might contain quite some
false positives. The `high_confidence` option is a shortcut to stringent
filter settings based on the number and consensus of provenances. Using
instead the `filter_intercell_network` function, you can have a fine control
over the quality filters. It has many options which are described in the
manual.

```
icn <- intercell_network()
icn_hc <- filter_intercell_network(
    icn,
    ligand_receptor = TRUE,
    consensus_percentile = 30,
    loc_consensus_percentile = 50,
    simplify = TRUE
)
```

The `filter_intecell` function does a similar procedure on an intercell
annotation data frame.

### 3.1.6 Metadata

The list of available resources for each query type can be retrieved
by the `..._resources` functions. For example, the annotation resources
are:

```
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

Categories in the `intercell` query also can be listed:

```
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
# intercell_categories() # this would show also the specific categories
```

## 3.2 Data from other resources

An increasing number of other resources (currently around 20) can be directly
accessed by `OmnipathR` (not from the omnipathdb.org domain, but from their
original providers). As an example,

## 3.3 General purpose functionalities

### 3.3.1 Identifier translation

`OmnipathR` uses UniProt data to translate identifiers. You may find a list
of the available identifiers in the manual page of `translate_ids` function.
The evaluation of the parameters is tidyverse style, and both UniProt’s
notation and a simple internal notation can be used. Furthermore, it can
handle vectors, data frames or list of vectors.

```
d <- data.frame(uniprot_id = c('P00533', 'Q9ULV1', 'P43897', 'Q9Y2P5'))
d <- translate_ids(
    d,
    uniprot_id = uniprot, # the source ID type and column name
    genesymbol # the target ID type using OmniPath's notation
)
d
```

```
##   uniprot_id genesymbol
## 1     P00533       EGFR
## 2     Q9ULV1       FZD4
## 3     P43897       TSFM
## 4     Q9Y2P5    SLC27A5
```

It is possible to have one source ID type and column in one call, but
multiple target ID types and columns: to translate a network, two calls
are necessary. *Note: certain functionality fails recently due to changes
in other packages, will be fixed in a few days.*

```
network <- omnipath()
network <- translate_ids(
    network,
    source = uniprot_id,
    source_entrez = entrez
)
network <- translate_ids(
    network,
    target = uniprot_id,
    target_entrez = entrez
)
```

### 3.3.2 Gene Ontology

`OmnipathR` is able to look up ancestors and descendants in ontology trees,
and also exposes the ontology tree in three different formats: as a
data frame, as a list of lists or as an igraph graph object. All these
can have two directions: child-to-parent (`c2p`) or parent-to-child (`p2c`).

```
go <- go_ontology_download()
go$rel_tbl_c2p
```

```
## NULL
```

To convert the relations to list or graph format, use the
`relations_table_to_list` or `relations_table_to_graph` functions. To
swap between `c2p` and `p2c` use the `swap_relations` function.

```
go_graph <- relations_table_to_graph(go$rel_tbl_c2p)
go_graph
```

```
## NULL
```

It can also translate term IDs to term names:

```
ontology_ensure_name('GO:0000022')
```

```
## NULL
```

*The first call takes a few seconds as it loads the database, subsequent
calls are faster.*

## 3.4 Useful tips

`OmnipathR` features a logging facility, a YML configuration file and
a cache directory. By default the highest level messages are printed to
the console, and you can browse the full log from R by calling
`omnipath_log()`. The cache can be controlled by a number of functions,
for example you can search for cache files by `omnipath_cache_search()`,
and delete them by `omnipath_cache_remove`:

```
omnipath_cache_search('dorothea')
```

```
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$key
## [1] "8e1fed15bbe7704374f40d278e719e18b4a9d60f"
##
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$url
## [1] "https://omnipathdb.org/interactions?genesymbols=yes&datasets=dorothea,tf_target,collectri&organisms=9606&dorothea_levels=A,B&fields=sources,references,curation_effort,dorothea_level&license=academic"
##
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$post
## list()
##
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$payload
## list()
##
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$ext
## [1] "rds"
##
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$versions
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$versions$`1`
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$versions$`1`$number
## [1] "1"
##
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$versions$`1`$path
## [1] "/home/biocbuild/.cache/OmnipathR/8e1fed15bbe7704374f40d278e719e18b4a9d60f-1.rds"
##
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$versions$`1`$dl_started
## [1] "2026-01-29 20:10:01 EST"
##
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$versions$`1`$status
## [1] "ready"
##
## $`8e1fed15bbe7704374f40d278e719e18b4a9d60f`$versions$`1`$dl_finished
## [1] "2026-01-29 20:10:01 EST"
```

The configuration can be set by `options`, all options are prefixed with
`omnipath.`, and can be saved by `omnipath_save_config`. For example, to
exclude all OmniPath resources which don’t allow for-profit use:

```
options(omnipath.license = 'commercial')
```

The internal state is contained by the `omnipathr.env` environment.

## 3.5 Further information

Find more examples in the other vignettes and the manual. For example, the
NicheNet vignette presents the integratation between `OmnipathR` and
`nichenetr`, a method for prediction of ligand-target gene connections.
Another Bioconductor package `wppi` is able to add context specific scores
to networks, based on genes of interest, functional annotations and network
proximity (random walks with restart). The new `paths` vignette presents
some approaches to construct pathways from networks. The design of the
OmniPath database is described in our recent paper [1], while an in depth
analysis of the pathway resources is available in the first OmniPath
paper [2].

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
## [1] OmnipathR_3.18.4 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] xfun_0.56           bslib_0.10.0        httr2_1.2.2         websocket_1.4.4     processx_3.8.6
##  [6] tzdb_0.5.0          vctrs_0.7.1         tools_4.5.2         ps_1.9.1            generics_0.1.4
## [11] parallel_4.5.2      curl_7.0.0          tibble_3.3.1        RSQLite_2.4.5       blob_1.3.0
## [16] pkgconfig_2.0.3     R.oo_1.27.1         checkmate_2.3.3     readxl_1.4.5        lifecycle_1.0.5
## [21] compiler_4.5.2      stringr_1.6.0       progress_1.2.3      chromote_0.5.1      htmltools_0.5.9
## [26] sass_0.4.10         yaml_2.3.12         tidyr_1.3.2         later_1.4.5         pillar_1.11.1
## [31] crayon_1.5.3        jquerylib_0.1.4     R.utils_2.13.0      cachem_1.1.0        sessioninfo_1.2.3
## [36] zip_2.3.3           tidyselect_1.2.1    rvest_1.0.5         digest_0.6.39       stringi_1.8.7
## [41] dplyr_1.1.4         purrr_1.2.1         bookdown_0.46       fastmap_1.2.0       cli_3.6.5
## [46] logger_0.4.1        magrittr_2.0.4      utf8_1.2.6          XML_3.99-0.20       withr_3.0.2
## [51] readr_2.1.6         prettyunits_1.2.0   promises_1.5.0      backports_1.5.0     rappdirs_0.3.4
## [56] bit64_4.6.0-1       lubridate_1.9.4     timechange_0.3.0    rmarkdown_2.30      httr_1.4.7
## [61] igraph_2.2.1        bit_4.6.0           otel_0.2.0          cellranger_1.1.0    R.methodsS3_1.8.2
## [66] hms_1.1.4           memoise_2.0.1       evaluate_1.0.5      knitr_1.51          tcltk_4.5.2
## [71] rlang_1.1.7         Rcpp_1.1.1          glue_1.8.0          DBI_1.2.3           selectr_0.5-1
## [76] BiocManager_1.30.27 xml2_1.5.2          vroom_1.7.0         jsonlite_2.0.0      R6_2.6.1
## [81] fs_1.6.6
```

# References

# Appendix

[1] D Turei, A Valdeolivas, L Gul, N Palacio-Escat, M Klein, O Ivanova,
M Olbei, A Gabor, F Theis, D Modos, T Korcsmaros and J Saez-Rodriguez (2021)
Integrated intra- and intercellular signaling knowledge for multicellular
omics analysis. *Molecular Systems Biology* 17:e9923

[2] D Turei, T Korcsmaros and J Saez-Rodriguez (2016) OmniPath: guidelines and
gateway for literature-curated signaling pathway resources. *Nature Methods*
13(12)