# NDExR - R implementaion for NDEx server API

Florian J. Auer1\*, Zaynab Hammoud1\*\* and Frank Kramer1\*\*\*

1University of Augsburg

\*Florian.Auer@informatik.uni-augsburg.de
\*\*Zaynab.Hammoud@informatik.uni-augsburg.de
\*\*\*Frank.Kramer@informatik.uni-augsburg.de

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
  + [2.1 Installation from Bioconductor](#installation-from-bioconductor)
  + [2.2 Installation from GitHub](#installation-from-github)
* [3 Quick Start](#quick-start)
* [4 Connect to a server](#connect-to-a-server)
* [5 Find Networks](#find-networks)
* [6 Simple network operations](#simple-network-operations)
* [7 RCX](#rcx)
* [8 Example Workflow](#example-workflow)
* [9 Aspects and Metadata](#aspects-and-metadata)
* [10 NDEx Network properties](#ndex-network-properties)
* [11 API Compatibility with NDEx versions](#api-compatibility-with-ndex-versions)
* [12 Server REST API configuration](#server-rest-api-configuration)

# 1 Introduction

Networks are a powerful and flexible methodology for expressing
biological knowledge for computation and communication. Albeit
its benefits, the sharing of networks, the collaboration on
network curation, keeping track of changes between
different network versions, and detecting different versions itself,
still is a major problem in network biology.

The Network Data Exchange, or NDEx, is an open-source software framework
to manipulate, store and exchange networks of various types and formats (Pratt et al., 2015, Cell Systems 1, 302-305, October 28, 2015 ©2015 Elsevier Inc. [ScienceDirect](http://www.sciencedirect.com/science/article/pii/S2405471215001477)).
NDEx can be used to upload, share and publicly distribute networks, while providing
an output in formats, that can be used by plenty of other applications.

The public NDEx server is a network data commons which provides pathway collections like the Pathway Interaction Database of the NCI (<http://www.ndexbio.org/#/user/301a91c6-a37b-11e4-bda0-000c29202374>) and the Cancer Cell Maps Initiative (<http://www.ndexbio.org/#/user/b47268a6-8112-11e6-b0a6-06603eb7f303>).

This package provides an interface to query the public NDEx server, as well as private installations, in order to upload, download or modify biological networks.

This document aims to help the user to install and benefit from the
wide range of functionality of this implementation.
The package makes use of the R implementation of the Cytoscape
Cyberinfrastructure (CX) format by the [RCX](https://doi.org/doi%3A10.18129/B9.bioc.RCX) package.
The [RCX](https://doi.org/doi%3A10.18129/B9.bioc.RCX) package provides functions to create, edit, and extend the networks in CX format and
also for the lossless conversion of the networks from and to [iGraph](http://igraph.org/r/) and [Bioconductor graph](https://doi.org/doi%3A10.18129/B9.bioc.graph) objects.

The package is compatible with all NDEx API versions 1.3 and 2.x.

# 2 Installation

## 2.1 Installation from Bioconductor

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("ndexr")
library(ndexr)
```

## 2.2 Installation from GitHub

using [*devtools*](http://cran.r-project.org/web/packages/devtools/index.html) R package

```
require(devtools)
install_github("frankkramer-lab/ndexr")
library(ndexr)
```

using [remotes](https://cran.r-project.org/web/packages/remotes/index.html) R package

```
require(remotes)
install_github("frankkramer-lab/ndexr")
library(ndexr)
```

# 3 Quick Start

A short overview of the most important functions of the package:

```
## load the library!
library(ndexr)

## login to the NDEx server
ndexcon <- ndex_connect("username", "password")

## search the networks for 'EGFR'
networks <- ndex_find_networks(ndexcon, "EGFR")
head(networks, 3)
```

```
##                              ownerUUID isReadOnly subnetworkIds isValid
## 1 efbfa554-57b3-11ed-ae36-0ac135e8bacf      FALSE          NULL    TRUE
## 2 0db1f2dc-103f-11e8-b939-0ac135e8bacf      FALSE          NULL    TRUE
## 3 d98b2215-b7e1-11ea-aaef-0ac135e8bacf       TRUE          NULL    TRUE
##   warnings isShowcase isCertified indexLevel hasLayout hasSample cxFileSize
## 1     NULL      FALSE       FALSE        ALL      TRUE     FALSE     294641
## 2     NULL      FALSE       FALSE        ALL      TRUE     FALSE      93393
## 3     NULL       TRUE       FALSE        ALL      TRUE     FALSE      49094
##   cx2FileSize                                     name
## 1      149583                            NeoPPI - EGFR
## 2       70036                           EGFR Signaling
## 3       29231 CDKN2A–EGFR–TERT Pathway Subtype Network
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             properties
## 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            NA, NA, NA, Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0), Andrey Ivanov, Ph.D.; Xiulei Mo, Ph.D.; Qiankun Niu, Ph.D.; Haian Fu, Ph.D., <p>Mo,  X. <i>et al</i>. (2022). <b>Systematic discovery of mutation-directed neo-protein-protein interactions in cancer</b>.<br/> Cell 185(11):1974-1985<br/>doi: <a href="https://doi.org/10.1016/j.cell.2022.04.014">10.1016/j.cell.2022.04.014</a></p>, rights, rightsHolder, reference, string, string, string
## 2 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, {"signor": "http://signor.uniroma2.it/relation_result.php?id=", "BTO": "http://identifiers.org/bto/BTO:", "uniprot": "http://identifiers.org/uniprot/", "pubmed": "http://identifiers.org/pubmed/", "CID": "http://identifiers.org/pubchem.compound/", "SID": "http://identifiers.org/pubchem.substance/", "chebi": "http://identifiers.org/chebi/CHEBI:", "hgnc.symbol": "http://identifiers.org/hgnc.symbol/"}, ["SIGNOR-EGF"], Theodora Pavlidou, Homo Sapiens (human), Prof. Gianni Cesareni, Attribution-ShareAlike 4.0 International (CC BY-SA 4.0), <div>Perfetto L., <i>et al.</i></div><div><b>SIGNOR: a database of causal relationships between biological entities</b><i>.</i></div><div>Nucleic Acids Res. 2016 Jan 4;44(D1):D548-54</div><div><span><a href="https://doi.org/10.1093/nar/gkv1048" target="_blank">doi: 10.1093/nar/gkv1048</a></span></div>, ["pathway","Signalling Pathway"], <a href="https://github.com/ndexcontent/ndexsignorloader">ndexsignorloader 1.2.0</a>, 0.1, https://signor.uniroma2.it/pathway_browser.php?organism=&pathway_list=SIGNOR-EGF, Edges have been collapsed with attributes converted to lists with exception of direct attribute, @context, labels, author, organism, rightsHolder, rights, reference, networkType, prov:wasGeneratedBy, __normalizationversion, prov:wasDerivedFrom, notes, string, list_of_string, string, string, string, string, string, list_of_string, string, string, string, string
## 3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        NA, NA, NA, NA, NA, NA, Wei Zhang, Cancer, Molecular Network, Homo sapiens, Wei Zhang, <i>Wei Zhang, Ana Bojorquez-Gomez, Daniel Ortiz Velez, Guorong Xu, Kyle S. Sanchez, John Paul Shen, Kevin Chen, Katherine Licon, Collin Melton, Katrina M. Olson, Michael Ku Yu, Justin K. Huang, Hannah Carter, Emma K. Farley, Michael Snyder, Stephanie I. Fraley, Jason F. Kreisberg &amp; Trey Ideker.</i><span style="font-size: 12px;float: none;"> </span><b>A Global Transcriptional Network Connecting Noncoding Mutations to Changes in Tumor Gene Expression. </b><div style="font-size: 12px;">Nature Genetics. 2018 April;</div><a href="https://doi.org/10.1038/s41588-018-0091-2" target="" style="background-color: transparent;">https://doi.org/10.1038/s41588-018-0091-2</a><br/>, author, disease, networkType, organism, rightsHolder, reference, string, string, string, string, string, string
##       owner     version completed
## 1 ivanovlab    20221108      TRUE
## 2    signor 19-Feb-2025      TRUE
## 3  abogosia         1.0      TRUE
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             description
## 1 <p>The protein-protein interactions of <b>EGFR L858R</b> or <b>EGFR</b> wild type detected using the NanoLuc luciferase-based bioluminescence resonance energy transfer (BRETn) technology-based quantitative high-throughput differential screening (qHT-dS) platform. The qHT-dS allows comparative screening of wild-type and mutant allele counterparts for the detection of differential interactions with cancer-associated proteins in live mammalian cells.</p><p>To differentiate gain of interactions (Go-PPI) from loss of interactions (Lo-PPI), the difference between WT and MUT PPI curves were calculated to obtain differential scores (differential_score), corresponding p-values (pvalue_ds), and p-values adjusted for multiple comparisons (qvalue_ds).</p> <p>The <b>statistically significant</b> edges (ss-Go-PPI, light blue) were defined based on the differential_score &gt; 1 and pvalue_ds &lt; 0.01. For ss-Lo-PPI edges (light red) the differential_score &lt; 1 and pvalue_ds &lt; 0.01.<br/></p><p>The <b>high-stringency n</b>edges (hs-Go-PPI, blue or hs-Lo-PPI, red) include the statistically significant PPIs for which qvalue_ds &lt; 0.01, and differential_score ≥ 1.5 or ≤ 1/1.5, respectively.</p><p></p><p>The hs-Go-PPI edges that were further confirmed in a single-lowest-dose assay were prioritized as <b>high-confidence</b> edges (hc-Go-PPI, dark blue).</p>
## 2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           The epidermal growth factor receptor (EGFR) signaling pathway regulates growth, survival, proliferation, and differentiation. The binding of extracellular ligands (EGF) induces homo and heterodimerization, transphosphorylation and activation of four ErbB family receptors: EGFR (ErbB1), ErbB2, ErbB3, and ErbB4. These events trigger a cascade of activation of downstream pathways that include, principally, the MAPK, Akt and JNK pathways, culminating in DNA synthesis and cell proliferation.
## 3                                                                                                                                                                                                                                                                                                                                                                                                                  <div>Pathways characterizing CDKN2A–EGFR–TERT subtypes, defined as subnetwork regions extracted from ReactomeFI by NBS. (<b>Fig. 5e</b>)</div><div><!--StartFragment-->Red circles indicate gain of function.<div>Blue circles indicate loss of function.</div>Yellow nodes indicate noncoding mutations.<div>Cyan nodes indicate coding alteration.</div><div>Blue arrows indicate protein-protein activation.</div><div>Blue lines indicate protein-protein inhibition.</div><div>Pink lines indicate complex protein-protein interaction.</div><div><div>Grey lines indicate protein binding from high-throughput experiments.</div><div>Red arrows indicate transcriptional activation.</div><!--StartFragment--><span style="font-size: 12px;float: none;">Red lines indicate transcriptional repression.</span><div style="font-size: 12px;"><div><!--StartFragment--><span style="font-size: 12px;float: none;">Green lines indicate genetic interaction.</span><br/></div></div></div></div>
##   visibility nodeCount edgeCount creationTime
## 1     PUBLIC       341       340 1.667847e+12
## 2     PUBLIC        32        61 1.617835e+12
## 3     PUBLIC        22        77 1.595523e+12
##                             externalId isDeleted modificationTime cxFormat
## 1 17bf8f9a-5ecd-11ed-ae36-0ac135e8bacf     FALSE     1.669050e+12     <NA>
## 2 f71ab602-97f0-11eb-9e72-0ac135e8bacf     FALSE     1.740026e+12     <NA>
## 3 c2459f34-cd03-11ea-aaef-0ac135e8bacf     FALSE     1.596046e+12     <NA>
```

```
## UUID of the first search result
networkId <- networks[1, "externalId"]
networkId
```

```
## [1] "17bf8f9a-5ecd-11ed-ae36-0ac135e8bacf"
```

```
## get summary of the network
ndex_network_get_summary(ndexcon, networkId)
```

```
## $ownerUUID
## [1] "efbfa554-57b3-11ed-ae36-0ac135e8bacf"
##
## $isReadOnly
## [1] FALSE
##
## $subnetworkIds
## list()
##
## $isValid
## [1] TRUE
##
## $warnings
## list()
##
## $isShowcase
## [1] FALSE
##
## $isCertified
## [1] FALSE
##
## $indexLevel
## [1] "ALL"
##
## $hasLayout
## [1] TRUE
##
## $hasSample
## [1] FALSE
##
## $cxFileSize
## [1] 294641
##
## $cx2FileSize
## [1] 149583
##
## $name
## [1] "NeoPPI - EGFR"
##
## $properties
##   subNetworkId
## 1           NA
## 2           NA
## 3           NA
##                                                                                                                                                                                                                                                        value
## 1                                                                                                                                                                                Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
## 2                                                                                                                                                                                Andrey Ivanov, Ph.D.; Xiulei Mo, Ph.D.; Qiankun Niu, Ph.D.; Haian Fu, Ph.D.
## 3 <p>Mo,  X. <i>et al</i>. (2022). <b>Systematic discovery of mutation-directed neo-protein-protein interactions in cancer</b>.<br/> Cell 185(11):1974-1985<br/>doi: <a href="https://doi.org/10.1016/j.cell.2022.04.014">10.1016/j.cell.2022.04.014</a></p>
##   predicateString dataType
## 1          rights   string
## 2    rightsHolder   string
## 3       reference   string
##
## $owner
## [1] "ivanovlab"
##
## $version
## [1] "20221108"
##
## $completed
## [1] TRUE
##
## $description
## [1] "<p>The protein-protein interactions of <b>EGFR L858R</b> or <b>EGFR</b> wild type detected using the NanoLuc luciferase-based bioluminescence resonance energy transfer (BRETn) technology-based quantitative high-throughput differential screening (qHT-dS) platform. The qHT-dS allows comparative screening of wild-type and mutant allele counterparts for the detection of differential interactions with cancer-associated proteins in live mammalian cells.</p><p>To differentiate gain of interactions (Go-PPI) from loss of interactions (Lo-PPI), the difference between WT and MUT PPI curves were calculated to obtain differential scores (differential_score), corresponding p-values (pvalue_ds), and p-values adjusted for multiple comparisons (qvalue_ds).</p> <p>The <b>statistically significant</b> edges (ss-Go-PPI, light blue) were defined based on the differential_score &gt; 1 and pvalue_ds &lt; 0.01. For ss-Lo-PPI edges (light red) the differential_score &lt; 1 and pvalue_ds &lt; 0.01.<br/></p><p>The <b>high-stringency n</b>edges (hs-Go-PPI, blue or hs-Lo-PPI, red) include the statistically significant PPIs for which qvalue_ds &lt; 0.01, and differential_score ≥ 1.5 or ≤ 1/1.5, respectively.</p><p></p><p>The hs-Go-PPI edges that were further confirmed in a single-lowest-dose assay were prioritized as <b>high-confidence</b> edges (hc-Go-PPI, dark blue).</p>"
##
## $visibility
## [1] "PUBLIC"
##
## $nodeCount
## [1] 341
##
## $edgeCount
## [1] 340
##
## $creationTime
## [1] 1.667847e+12
##
## $externalId
## [1] "17bf8f9a-5ecd-11ed-ae36-0ac135e8bacf"
##
## $isDeleted
## [1] FALSE
##
## $modificationTime
## [1] 1.66905e+12
```

```
## get the entire network as RCX object
rcx <- ndex_get_network(ndexcon, networkId)

## show the content (aspects) of the network
rcx$metaData
```

```
## Meta-data:
##                 name version idCounter elementCount consistencyGroup
## 1              nodes     1.0       340          341                1
## 2              edges     1.0       339          340                1
## 3     nodeAttributes     1.0        NA          344                1
## 4     edgeAttributes     1.0        NA         3740                1
## 5  networkAttributes     1.0        NA            6                1
## 6    cartesianLayout     1.0        NA          341                1
## 7 cyVisualProperties     1.0        NA            3                1
## 8 cyHiddenAttributes     1.0        NA            3                1
## 9      cyTableColumn     1.0        NA           24                1
```

```
## upload network as a new network to the NDEx server
networkId <- ndex_create_network(ndexcon, rcx)

## do some other fancy stuff with the network, then update the
## network on the server
networkId <- ndex_update_network(ndexcon, rcx)

## realize, you did bad things to the poor network, so better delete
## it on the server
ndex_delete_network(ndexcon, networkId)
```

# 4 Connect to a server

First, establish an connection to the NDEx server. This object is
required for most of the other ndexr functions, because it stores
options and authentication details. It is possible to connect to the
server anonymously or provide a username and password to enable further
functionality. If you have set up your own NDEx server, you might change
the host to your local installation.

```
## load the library
library(ndexr)

## connect anonymously
ndexcon <- ndex_connect()

## log in with user name and password
ndexconUser <- ndex_connect(username="username", password="password")

## specify the server
ndexconLocal <- ndex_connect(
  username="username",
  password="password",
  host="localhost:8888/ndex/rest"
)

## manually change the api and connection configuration
ndexcon13 <- ndex_connect(ndexConf=ndex_config$Version_1.3)
```

This package is developed following the structure of the documented api structure. For complete description of the NDEx server api see [*http://www.home.ndexbio.org/using-the-ndex-server-api/*](http://www.home.ndexbio.org/using-the-ndex-server-api/). The R functions are named by the category, context and function they fullfil.
In the following, the usage is described in detail, and hopefully gives a better
understanding of logic behind the naming convention of this package.

# 5 Find Networks

To explore or search the networks on an NDEx server, this package offers
a function to retrieve a list of networks from the server.

```
## list networks on server
networks <- ndex_find_networks(ndexcon)
```

As result you get a data.frame containing information of the networks.

```
names(networks)
```

```
##  [1] "ownerUUID"        "isReadOnly"       "subnetworkIds"    "isValid"
##  [5] "warnings"         "isShowcase"       "isCertified"      "indexLevel"
##  [9] "hasLayout"        "hasSample"        "cxFileSize"       "cx2FileSize"
## [13] "name"             "properties"       "owner"            "version"
## [17] "completed"        "description"      "visibility"       "nodeCount"
## [21] "edgeCount"        "creationTime"     "externalId"       "isDeleted"
## [25] "modificationTime" "cxFormat"         "doi"
```

```
networks[1:5, c("name", "externalId")]
```

```
##                                    name                           externalId
## 1                           Bioregistry 860647c4-f7c1-11ec-ac45-0ac135e8bacf
## 2                            Large_Tree be739fa3-b031-11f0-a218-005056ae3c32
## 3                            Network_15 8b96021d-b033-11f0-a218-005056ae3c32
## 4                           Biomappings 402d1fd6-49d6-11eb-9e72-0ac135e8bacf
## 5 iNeuron TDP-43 KD protein interactome b343879d-8800-11f0-a218-005056ae3c32
```

It is possible to restrict the networks to a specific search string (e.g. “EGFR”),
an account name (only networks of this account will be shown), or limit
the number of fetched networks.

```
## list networks on server (same as previous)
networks <- ndex_find_networks(ndexcon, start = 0, size = 5)

## search for 'EGFR'
networksEgfr <- ndex_find_networks(ndexcon, searchString = "EGFR")
## same as previous
networksEgfr <- ndex_find_networks(ndexcon, "EGFR")
networksEgfr[1:3, ]
```

```
##                              ownerUUID isReadOnly subnetworkIds isValid
## 1 efbfa554-57b3-11ed-ae36-0ac135e8bacf      FALSE          NULL    TRUE
## 2 0db1f2dc-103f-11e8-b939-0ac135e8bacf      FALSE          NULL    TRUE
## 3 d98b2215-b7e1-11ea-aaef-0ac135e8bacf       TRUE          NULL    TRUE
##   warnings isShowcase isCertified indexLevel hasLayout hasSample cxFileSize
## 1     NULL      FALSE       FALSE        ALL      TRUE     FALSE     294641
## 2     NULL      FALSE       FALSE        ALL      TRUE     FALSE      93393
## 3     NULL       TRUE       FALSE        ALL      TRUE     FALSE      49094
##   cx2FileSize                                     name
## 1      149583                            NeoPPI - EGFR
## 2       70036                           EGFR Signaling
## 3       29231 CDKN2A–EGFR–TERT Pathway Subtype Network
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             properties
## 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            NA, NA, NA, Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0), Andrey Ivanov, Ph.D.; Xiulei Mo, Ph.D.; Qiankun Niu, Ph.D.; Haian Fu, Ph.D., <p>Mo,  X. <i>et al</i>. (2022). <b>Systematic discovery of mutation-directed neo-protein-protein interactions in cancer</b>.<br/> Cell 185(11):1974-1985<br/>doi: <a href="https://doi.org/10.1016/j.cell.2022.04.014">10.1016/j.cell.2022.04.014</a></p>, rights, rightsHolder, reference, string, string, string
## 2 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, {"signor": "http://signor.uniroma2.it/relation_result.php?id=", "BTO": "http://identifiers.org/bto/BTO:", "uniprot": "http://identifiers.org/uniprot/", "pubmed": "http://identifiers.org/pubmed/", "CID": "http://identifiers.org/pubchem.compound/", "SID": "http://identifiers.org/pubchem.substance/", "chebi": "http://identifiers.org/chebi/CHEBI:", "hgnc.symbol": "http://identifiers.org/hgnc.symbol/"}, ["SIGNOR-EGF"], Theodora Pavlidou, Homo Sapiens (human), Prof. Gianni Cesareni, Attribution-ShareAlike 4.0 International (CC BY-SA 4.0), <div>Perfetto L., <i>et al.</i></div><div><b>SIGNOR: a database of causal relationships between biological entities</b><i>.</i></div><div>Nucleic Acids Res. 2016 Jan 4;44(D1):D548-54</div><div><span><a href="https://doi.org/10.1093/nar/gkv1048" target="_blank">doi: 10.1093/nar/gkv1048</a></span></div>, ["pathway","Signalling Pathway"], <a href="https://github.com/ndexcontent/ndexsignorloader">ndexsignorloader 1.2.0</a>, 0.1, https://signor.uniroma2.it/pathway_browser.php?organism=&pathway_list=SIGNOR-EGF, Edges have been collapsed with attributes converted to lists with exception of direct attribute, @context, labels, author, organism, rightsHolder, rights, reference, networkType, prov:wasGeneratedBy, __normalizationversion, prov:wasDerivedFrom, notes, string, list_of_string, string, string, string, string, string, list_of_string, string, string, string, string
## 3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        NA, NA, NA, NA, NA, NA, Wei Zhang, Cancer, Molecular Network, Homo sapiens, Wei Zhang, <i>Wei Zhang, Ana Bojorquez-Gomez, Daniel Ortiz Velez, Guorong Xu, Kyle S. Sanchez, John Paul Shen, Kevin Chen, Katherine Licon, Collin Melton, Katrina M. Olson, Michael Ku Yu, Justin K. Huang, Hannah Carter, Emma K. Farley, Michael Snyder, Stephanie I. Fraley, Jason F. Kreisberg &amp; Trey Ideker.</i><span style="font-size: 12px;float: none;"> </span><b>A Global Transcriptional Network Connecting Noncoding Mutations to Changes in Tumor Gene Expression. </b><div style="font-size: 12px;">Nature Genetics. 2018 April;</div><a href="https://doi.org/10.1038/s41588-018-0091-2" target="" style="background-color: transparent;">https://doi.org/10.1038/s41588-018-0091-2</a><br/>, author, disease, networkType, organism, rightsHolder, reference, string, string, string, string, string, string
##       owner     version completed
## 1 ivanovlab    20221108      TRUE
## 2    signor 19-Feb-2025      TRUE
## 3  abogosia         1.0      TRUE
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             description
## 1 <p>The protein-protein interactions of <b>EGFR L858R</b> or <b>EGFR</b> wild type detected using the NanoLuc luciferase-based bioluminescence resonance energy transfer (BRETn) technology-based quantitative high-throughput differential screening (qHT-dS) platform. The qHT-dS allows comparative screening of wild-type and mutant allele counterparts for the detection of differential interactions with cancer-associated proteins in live mammalian cells.</p><p>To differentiate gain of interactions (Go-PPI) from loss of interactions (Lo-PPI), the difference between WT and MUT PPI curves were calculated to obtain differential scores (differential_score), corresponding p-values (pvalue_ds), and p-values adjusted for multiple comparisons (qvalue_ds).</p> <p>The <b>statistically significant</b> edges (ss-Go-PPI, light blue) were defined based on the differential_score &gt; 1 and pvalue_ds &lt; 0.01. For ss-Lo-PPI edges (light red) the differential_score &lt; 1 and pvalue_ds &lt; 0.01.<br/></p><p>The <b>high-stringency n</b>edges (hs-Go-PPI, blue or hs-Lo-PPI, red) include the statistically significant PPIs for which qvalue_ds &lt; 0.01, and differential_score ≥ 1.5 or ≤ 1/1.5, respectively.</p><p></p><p>The hs-Go-PPI edges that were further confirmed in a single-lowest-dose assay were prioritized as <b>high-confidence</b> edges (hc-Go-PPI, dark blue).</p>
## 2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           The epidermal growth factor receptor (EGFR) signaling pathway regulates growth, survival, proliferation, and differentiation. The binding of extracellular ligands (EGF) induces homo and heterodimerization, transphosphorylation and activation of four ErbB family receptors: EGFR (ErbB1), ErbB2, ErbB3, and ErbB4. These events trigger a cascade of activation of downstream pathways that include, principally, the MAPK, Akt and JNK pathways, culminating in DNA synthesis and cell proliferation.
## 3                                                                                                                                                                                                                                                                                                                                                                                                                  <div>Pathways characterizing CDKN2A–EGFR–TERT subtypes, defined as subnetwork regions extracted from ReactomeFI by NBS. (<b>Fig. 5e</b>)</div><div><!--StartFragment-->Red circles indicate gain of function.<div>Blue circles indicate loss of function.</div>Yellow nodes indicate noncoding mutations.<div>Cyan nodes indicate coding alteration.</div><div>Blue arrows indicate protein-protein activation.</div><div>Blue lines indicate protein-protein inhibition.</div><div>Pink lines indicate complex protein-protein interaction.</div><div><div>Grey lines indicate protein binding from high-throughput experiments.</div><div>Red arrows indicate transcriptional activation.</div><!--StartFragment--><span style="font-size: 12px;float: none;">Red lines indicate transcriptional repression.</span><div style="font-size: 12px;"><div><!--StartFragment--><span style="font-size: 12px;float: none;">Green lines indicate genetic interaction.</span><br/></div></div></div></div>
##   visibility nodeCount edgeCount creationTime
## 1     PUBLIC       341       340 1.667847e+12
## 2     PUBLIC        32        61 1.617835e+12
## 3     PUBLIC        22        77 1.595523e+12
##                             externalId isDeleted modificationTime cxFormat
## 1 17bf8f9a-5ecd-11ed-ae36-0ac135e8bacf     FALSE     1.669050e+12     <NA>
## 2 f71ab602-97f0-11eb-9e72-0ac135e8bacf     FALSE     1.740026e+12     <NA>
## 3 c2459f34-cd03-11ea-aaef-0ac135e8bacf     FALSE     1.596046e+12     <NA>
```

```
## search for networks of a user
networksOfUser <- ndex_find_networks(ndexcon, accountName = "ndextutorials")
networksOfUser[1:5, c("name", "owner", "externalId")]
```

```
##                                                 name         owner
## 1 BNFO 286 (Homework) - Direct p53 effectors example ndextutorials
## 2                           BNFO 286 - WNT Signaling ndextutorials
## 3                                         Metabolism ndextutorials
## 4                                  Metabolism of RNA ndextutorials
## 5                             Metabolism of proteins ndextutorials
##                             externalId
## 1 57aac7d2-d959-11ed-b4a3-005056ae23aa
## 2 ff9c05f4-b502-11ec-b3be-0ac135e8bacf
## 3 3bd76cf4-c4a1-11e4-bcc4-000c29cb28fb
## 4 c9243cce-2d32-11e8-b939-0ac135e8bacf
## 5 4197cc9c-c4a6-11e4-bcc4-000c29cb28fb
```

# 6 Simple network operations

To both, users and networks stored on an NDEx server, a universally
unique identifier (UUID) is assigned. Although both have the same format
(i.e. “xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx”, where x is one of
`[a-z0-9]`), it has to be distinguished between the user UUID and the
network UUID, but the difference is obvious by the context. Within RCX
objects and search results, the network UUID is also referred to as
“externalId” (see previous section). This UUID can be
used to access a network on the server and retrieve just a summary of
the network (similar to the results of a network search) or even the
entire network as RCX object (see next section).

Since networks can contain many nodes and edges, and a huge amount of other
attributes, it is typically advisable to first get a network summary, to
check the node and edge counts for a network before retrieving the
entire network. Thereby the structure of the network summary is similar
the structure of the network list

```
## UUID of the first search result
networkId <- networksOfUser[1, "externalId"]

## get network summary
networkSummary <- ndex_network_get_summary(ndexcon, networkId)

names(networkSummary)
```

```
##  [1] "ownerUUID"        "isReadOnly"       "subnetworkIds"    "isValid"
##  [5] "warnings"         "isShowcase"       "isCertified"      "indexLevel"
##  [9] "hasLayout"        "hasSample"        "cxFileSize"       "cx2FileSize"
## [13] "name"             "properties"       "owner"            "version"
## [17] "completed"        "description"      "visibility"       "nodeCount"
## [21] "edgeCount"        "creationTime"     "externalId"       "isDeleted"
## [25] "modificationTime"
```

```
networkSummary[c("name", "externalId")]
```

```
## $name
## [1] "BNFO 286 (Homework) - Direct p53 effectors example"
##
## $externalId
## [1] "57aac7d2-d959-11ed-b4a3-005056ae23aa"
```

```
## get the entire network as RCX object
rcx <- ndex_get_network(ndexcon, networkId)
rcx$metaData
```

```
## Meta-data:
##                 name version idCounter elementCount consistencyGroup
## 1              nodes     1.0       146          146                1
## 2              edges     1.0       537          215                1
## 3     nodeAttributes     1.0        NA          287                1
## 4     edgeAttributes     1.0        NA          595                1
## 5  networkAttributes     1.0        NA            5                1
## 6    cartesianLayout     1.0        NA          146                1
## 7 cyVisualProperties     1.0        NA            3                1
## 8 cyHiddenAttributes     1.0        NA            3                1
## 9      cyTableColumn     1.0        NA           16                1
```

To send a network to an server, there are two possibilities. Either one
wants to update an existing network on the server or create a new one.
In both cases, a UUID is returned, either of the updated network or a
newly generated one for the created network. For updating a network, the
UUID is extracted from the “externalId” property of the “ndexStatus”
aspect, or can be set manually.

```
## create a new network on server
networkId <- ndex_create_network(ndexcon, rcx)

## update a network on server
networkId <- ndex_update_network(ndexcon, rcx)

## same as previous
networkId <- ndex_update_network(ndexcon, rcx, networkId)
```

Besides creating, reading and updating, it is also possible to delete
networks on the server. This operation cannot be undone, so be careful!

```
## deletes the network from the server
ndex_delete_network(ndexcon, networkId)
```

# 7 RCX

For the exchange of network data, NDEx uses the Cytoscape
Cyberinfrastructure Network Interchange Format, or just CX format (See
[*http://www.home.ndexbio.org/data-model/*](http://www.home.ndexbio.org/data-model/)).
CX is an Aspect-Oriented Network Interchange Format encoded in JSON,
which is used as basis for the R implementation of the CX format, namely RCX.
The `RCX` data model is implemented in the corresponding [RCX](https://doi.org/doi%3A10.18129/B9.bioc.RCX) to handle the networks.

# 8 Example Workflow

This example workflow shows how to connect to the public NDEx server, browse and retrieve the pathways of the Pathway Interaction Database of the NCI which are hosted there.

```
## load the library!
library(ndexr)

## login to the NDEx server
ndexcon <- ndex_connect()

## retrieve pathways of user 'nci-pid'
networks_pid <- ndex_find_networks(ndexcon, accountName = "nci-pid")

## list retrieved network information (only the first 10 entries)
networks_pid[1:10, "name"]
```

```
##  [1] "Syndecan-4-mediated signaling events (v2.0)"
##  [2] "Syndecan-3-mediated signaling events (v2.0)"
##  [3] "ErbB1 downstream signaling (v2.0)"
##  [4] "Syndecan-2-mediated signaling events (v2.0)"
##  [5] "ErbB receptor signaling network (v2.0)"
##  [6] "Syndecan-1-mediated signaling events (v2.0)"
##  [7] "EPO signaling pathway (v2.0)"
##  [8] "Ephrin B reverse signaling (v2.0)"
##  [9] "Sumoylation by RanBP2 regulates transcriptional repression (v2.0)"
## [10] "EPHB forward signaling (v2.0)"
```

```
## show information on the first pathways listed
networks_pid[1, ]
```

```
##                              ownerUUID isReadOnly subnetworkIds isValid
## 1 301a91c6-a37b-11e4-bda0-000c29202374       TRUE          NULL    TRUE
##   warnings isShowcase isCertified indexLevel hasLayout hasSample cxFileSize
## 1     NULL      FALSE       FALSE        ALL      TRUE     FALSE     205900
##   cx2FileSize                                        name
## 1      173363 Syndecan-4-mediated signaling events (v2.0)
##                                                                                                                                                                                                                                                                                                                                                                                    properties
## 1 NA, <p>Pillich RT, Chen J, Churas C, Fong D, Gyori BM, Ideker T, Karis K, Liu SN, Ono K, Pico A, Pratt D.<br/><b>NDEx IQuery: a multi-method network gene set analysis leveraging the Network Data Exchange</b>.<br/> Bioinformatics. 2023 Mar 1;39(3):btad118.<br/><a href="https://doi/org/10.1093/bioinformatics/btad118">doi: 10.1093/bioinformatics/btad118</a></p>, reference, string
##     owner        version completed
## 1 nci-pid 2.0 (20220901)      TRUE
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 description
## 1 <p>This is the updated version of an original NCI Pathway Interaction Database (PID) network.</p><p>The list of entities (genes, proteins, chemicals, etc) from the original network was used to query the <a href="https://www.indra.bio" target="_blank"><b>INDRA</b></a> database, retrieving high-quality relationships between entities. INDRA is a database that integrates information from multiple high-quality text mining engines, pathway databases, and small molecule resources. The INDRA-derived relationships are up-to-date and have links to detailed summaries of supporting literature evidence, including the specific supporting text.</p><p>While we have included only high-confidence relationships, text-mining complicated sentences can produce errors such as the reversal of up-regulation vs. down-regulation or the direction of an edge (i.e. B activates A instead of A activates B). Nevertheless, the entity recognition by the text miners is excellent and the text supporting a relationship almost always describes a genuine relationship between the entities.</p><p><b>Legend:</b><br/>BLUE: edges annotated by INDRA only.<br/>RED: edges annotated both by INDRA and PID.<br/>YELLOW: selected element.</p>
##   visibility nodeCount edgeCount creationTime
## 1     PUBLIC        30       173   1.6651e+12
##                             externalId isDeleted modificationTime
## 1 00104179-45d1-11ed-b7d0-0ac135e8bacf     FALSE      1.71813e+12
```

```
## retrieve network data
mynetwork <- ndex_get_network(ndexcon, networks_pid[1, "externalId"])

## visualize the network with RCX
RCX::visualize(mynetwork)
```

![](data:image/png;base64...)

This code snippet starts with loading the ndexr library and connecting to the server anonymously.
Afterwards `ndex_find_networks` retrieves a list of networks of user `nci-pid`, which contains the data of the Pathway Interaction Database. The function `ndex_get_network` downloads the network data and stores in the `RCX` format and is then converted into an igraph object via `RCX::toIgraph`.
Here, the node IDs of the graph are set to readable names and the graph is plotted. Naturally, this graph can be annotated and beautified as required for the specific use cases.

# 9 Aspects and Metadata

In general it is not advisable to retrieve a complete RCX object from a
server without knowing the number of aspects and its corresponding size,
because this may cause unwanted or unnecessary network traffic and
decline in performance. To avoid these problems, a possible workflow is
to download the meta-data of a network at first to check the available
aspects.

```
## get meta-data for a network
metadata <- ndex_network_get_metadata(ndexcon, networkId)

names(metadata)
```

```
## [1] "name"         "elementCount" "version"      "idCounter"
```

```
metadata[c("name", "elementCount")]
```

```
##                 name elementCount
## 1     nodeAttributes          287
## 2      cyTableColumn           16
## 3              edges          215
## 4 cyVisualProperties            3
## 5 cyHiddenAttributes            3
## 6              nodes          146
## 7  networkAttributes            5
## 8    cartesianLayout          146
## 9     edgeAttributes          595
```

Afterwards, only the favored aspects can be downloaded individually.

```
## get aspect 'nodeCitations' for the network
networkAttibutes <- ndex_network_get_aspect(ndexcon, networkId, "networkAttributes")

networkAttibutes
```

```
## Network attributes:
##          name
## 1        name
## 2 description
## 3     version
## 4      labels
## 5    @context
##                                                                                                                                                                                                                                                                                                                                      value
## 1                                                                                                                                                                                                                                                                                       BNFO 286 (Homework) - Direct p53 effectors example
## 2                                                                                                                                                                                                                                                                         Example network for Homework assignment in MED283/BNFO286 class.
## 3                                                                                                                                                                                                                                                                                                                                      1.0
## 4                                                                                                                                                                                                                                                                                                                                3x BCL2L2
## 5 {"pubmed": "http://identifiers.org/pubmed/", "chebi": "http://identifiers.org/chebi/CHEBI:", "uniprot": "http://identifiers.org/uniprot/", "cas": "http://identifiers.org/cas/", "kegg.compound": "http://identifiers.org/kegg.compound/", "hprd": "http://identifiers.org/hprd/", "hgnc.symbol": "http://identifiers.org/hgnc.symbol/"}
##   dataType isList
## 1   string  FALSE
## 2   string  FALSE
## 3   string  FALSE
## 4   string  FALSE
## 5   string  FALSE
```

# 10 NDEx Network properties

Even after creation, it is possible to change the name, the description
or version of a network.

```
ndex_network_update_profile(ndexcon, networkId, name = "My network", version = "1.3")
ndex_network_update_profile(ndexcon, networkId, description = "Nothing to see here")
```

For collaborative work, it is necessary to share networks between
several users and groups. Therefore there are specialized functions to
grant access to a network, change the permissions and withdraw access
permissions. It is possible to use those functions on single users or
groups. Possible permissions are “READ” to have reading access to
private networks, “WRITE” to be able modify, and “ADMIN” for the owner
of the network.

```
## show all user who have permission to a network
ndex_network_get_permission(ndexcon, networkId, "user")

## show all groups who have permission to a network
ndex_network_get_permission(ndexcon, networkId, "group")

## show all users with write access to a network
ndex_network_get_permission(ndexcon, networkId, "user", "WRITE")

## grant an user permission to a network
ndex_network_update_permission(ndexcon, networkId, user = someUserUuid, "READ")

## change the permission of an user to the network
ndex_network_update_permission(ndexcon, networkId, user = someUserUuid, "WRITE")

## withdraw the permission from an user
ndex_network_delete_permission(ndexcon, networkId, user = someUserUuid)
```

Besides permission management on user and group level, it is also
possible to set some system properties on a network that influence the
accessibility further. By default a network is private, which means that
it is only visible to the owner and invited users and groups. If at some
point one decides to make the network readable by anyone, it is possible
to change the visibility of a network to “PUBLIC”.

```
ndex_network_set_systemProperties(ndexcon, networkId, visibility = "PUBLIC")
ndex_network_set_systemProperties(ndexcon, networkId, visibility = "PRIVATE")
```

When a network has reached the point to be published, further edits
should be prevented. While it would be possible to set the access
permissions of all users and groups to “READ”, this approach is very
inconvenient. Therefore, a simpler way is to just set the network to
read-only using the network system properties.

```
ndex_network_set_systemProperties(ndexcon, networkId, readOnly = TRUE)
```

One also has the option at the NDEx server to choose a selection of
their favorite networks for display in his or her home page.

```
ndex_network_set_systemProperties(ndexcon, networkId, showcase = TRUE)
ndex_network_set_systemProperties(ndexcon, networkId, showcase = FALSE)
# change more than one property simultaneously
ndex_network_set_systemProperties(
    ndexcon, networkId, readOnly = TRUE, visibility = "PUBLIC", showcase = TRUE
)
```

**The provenance history aspect is now deprecated within the CX specification! The following description is left here for completeness and compatibility with old network specification!**

The provenance history aspect of an NDEx network is used to document the
workflow of events and information sources that produced the current
network (for the official provenance documentation see
[*http://www.home.ndexbio.org/network-provenance-history/*](http://www.home.ndexbio.org/network-provenance-history/)
). There is a convenience function, that
retrieves the provenance of the network.

```
provenance <- ndex_network_get_provenance(ndexcon, networkId)
```

# 11 API Compatibility with NDEx versions

In the following table all API functions are listed. The functions are
grouped by the content they access, namely networks, users, or groups.
For every function also is shown, if authentication is needed, and by
which version it is supported (Version 2.0 or 1.3). A function marked
with brackets indicates, that, although the function would be supported
by this version, for different reasons no function could be implemented.
Limitations of the single API functions are also given in the column of
the corresponding version.

|  |  |  |  |
| --- | --- | --- | --- |
| **Function name** | **Authentication** | **Version 2.x** | **Version 1.3** |
| ***Networks*** |  |  |  |
| ndex\_find\_networks | no | X | X |
| ndex\_network\_get\_summary | no | X | X |
| ndex\_get\_network | no | X | X |
| ndex\_create\_network | yes | X | X |
| ndex\_update\_network | yes | X | X |
| ndex\_delete\_network | yes | X | X |
| ndex\_network\_get\_metadata | no | X | (x) |
| ndex\_network\_aspect\_get\_metadata | no | (x) |  |
| ndex\_network\_get\_aspect | no | X | (x) |
| ndex\_network\_update\_aspect | yes | (x) |  |
| ndex\_network\_get\_permission | yes | X | only for users, different response |
| ndex\_network\_update\_permission | yes | X | (only for users) |
| ndex\_network\_delete\_permission | yes | X | only for users |
| ndex\_network\_set\_systemProperties | yes | X | only readOnly |
| ndex\_network\_update\_profile | yes | X | X |
| ndex\_network\_get\_provenance | no | (x) | X |
| ***Users*** |  |  |  |
| ndex\_find\_users | no | X | X |
| ndex\_find\_user\_byName | no | X |  |
| ndex\_find\_user\_byId | no | X |  |
| ndex\_create\_user | yes | X |  |
| ndex\_delete\_user | yes | X |  |
| ndex\_update\_user | yes | X |  |
| ndex\_verify\_user | no | X |  |
| ndex\_user\_change\_password | yes | X |  |
| ndex\_user\_mail\_password | no | X |  |
| ndex\_user\_forgot\_password | no | X |  |
| ndex\_user\_list\_groups | yes | X |  |
| ndex\_user\_show\_group | yes | X |  |
| ndex\_user\_list\_permissions | yes | X |  |
| ndex\_user\_show\_permission | yes | X |  |
| ndex\_user\_get\_showcase | no | X |  |
| ndex\_user\_get\_networksummary | yes | X |  |
| ***Groups*** |  |  |  |
| ndex\_find\_groups | no | X | X |
| ndex\_get\_group | no | X |  |
| ndex\_create\_group | yes | X |  |
| ndex\_delete\_group | yes | X |  |
| ndex\_update\_group | yes | X |  |
| ndex\_group\_list\_users | no | X |  |
| ndex\_group\_set\_membership | yes | X |  |
| ndex\_group\_list\_networks | no | X |  |
| ndex\_group\_network\_get\_permission | no | X |  |

# 12 Server REST API configuration

In the section “Connect to a server”, briefly a method for manually
changing the API version was introduced, with the API definition stored
in ndex\_config.

```
names(ndex_config)
```

```
## [1] "defaultVersion" "Version_2.1"    "Version_2.0"    "Version_1.3"
```

```
str(ndex_config, max.level = 3)
```

```
## List of 4
##  $ defaultVersion: chr "Version_2.1"
##  $ Version_2.1   :List of 3
##   ..$ version   : chr "2.1"
##   ..$ connection:List of 3
##   .. ..$ description: chr "URL of the NDEx server"
##   .. ..$ host       : chr "http://www.ndexbio.org"
##   .. ..$ api        : chr "/v2"
##   ..$ api       :List of 5
##   .. ..$ serverStatus:List of 4
##   .. ..$ user        :List of 11
##   .. ..$ group       :List of 6
##   .. ..$ network     :List of 12
##   .. ..$ search      :List of 3
##  $ Version_2.0   :List of 3
##   ..$ version   : chr "2.0"
##   ..$ connection:List of 3
##   .. ..$ description: chr "URL of the NDEx server"
##   .. ..$ host       : chr "http://www.ndexbio.org"
##   .. ..$ api        : chr "/v2"
##   ..$ api       :List of 5
##   .. ..$ serverStatus:List of 3
##   .. ..$ user        :List of 11
##   .. ..$ group       :List of 6
##   .. ..$ network     :List of 12
##   .. ..$ search      :List of 3
##  $ Version_1.3   :List of 3
##   ..$ version   : chr "1.3"
##   ..$ connection:List of 3
##   .. ..$ description: chr "URL of the NDEx server"
##   .. ..$ host       : chr "http://www.ndexbio.org"
##   .. ..$ api        : chr "/rest"
##   ..$ api       :List of 4
##   .. ..$ serverStatus:List of 3
##   .. ..$ user        :List of 1
##   .. ..$ network     :List of 11
##   .. ..$ search      :List of 3
```

This object contains the api definition for several versions (currently
version 1.3 and 2.0). By default, `ndex_connect()` uses the version defined
in `ndex_config$defaultVersion` (“Version\_2.0”). To use another, or even a
customized version to establish a server connection, the ndexConf
parameter can be used, like shown before. In the following, the
structure of such a configuration is elaborated in more detail.

```
names(ndex_config$Version_2.0)
```

```
## [1] "version"    "connection" "api"
```

The main structure of the configuration consists of three elements: The
version is used to distinguish manually set configurations, which is
used in some API functions to work differently for the single versions.

The “connection” element holds information about the default connection
to the server, namely the host (e.g.
“[*http://www.ndexbio.org/*](http://www.ndexbio.org/)”) and the path to
the api (e.g. “/v2” or “/rest”).

The REST API itself is defined in the “api” element, and follows the
scheme of the function names, or the scheme of url paths likewise. E.g.
in the “user” branch the different functions for handling user data are
defined. If required, the functions might be grouped together in
sub-branches furthermore. At the end of an branch, the actual definition
of an API can be found.

To show, how such an API is defined and how to define one by themselves,
let’s have a look at
`ndex_config$Version_2.0$api$user$password$mail`, which is used by
`ndex_user_mail_password()`. Where to find the configuration of the
function is shown in the “REST query” section of the function
documentation. For a better readability, the yaml notation for this
function configuration is used:

```
mail:
  description: "Causes a new password to be generated for ..."
  url: "/user/#USERID#/password"
  method: "PUT"
  params:
    user:
      method: "replace"
      tag: "#USERID#"
    forgot:
      method: "parameter"
      tag: "forgot"
      default: "true"
```

Note: To get the yaml notation for the whole `ndex_config` simply use
`yaml::as.yaml(ndex_config)` (requires package `yaml` to be installed).

The single parameter definitions are given as list by the “params”
parameter. Each parameter is defined by a method, and, if applicable, a
tag, a default value and/or an optional flag. There are three keywords
defining the method: replace, append or parameter.

* **replace:** The String defined by “tag” can be found within the url and
  will be replaced by the given value of the parameter. E.g. the tag
  `#NETWORKID#` in the url `/network/#NETWORKID#/provenance` is
  replaced by a value (e.g. `aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee`)
  given as network id, which leads to the url
  `/network/aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee/provenance`.
* **append:** The given value of the parameter is appended to an url.
  Therefore the order of the parameters in the params definition is
  used. E.g. the url `/network/search` and the given values for
  `start = 0` and `size = 100` generates the following url:
  `/network/search/0/100`
* **parameter:** Encodes the given parameters as url parameter using the
  specified tag as parameter descriptor. E.g. a parameter with the tag
  `username` and the value `SomeName` is encoded in the url `/user` as
  follows: `/user?username=SomeName`

It is also possible to set parameter as optional (except for replace),
or define default values. Values are assigned to the parameters using
the parameter name in the … parameter of the `ndex_helper_encodeParams()`
function. Parameters, that are not defined in the configuration are
ignored.

The easiest to write an own configuration is by simply copying an
existing configuration and tailor it to the needs.

```
# Copy an existing config
custom_ndex_config <- ndex_config$Version_2.0

# Change the host connection for a local NDEx server installation
custom_ndex_config$connection$host <- "localhost:8090"

# Custom path to the REST api
custom_ndex_config$connection$api <- "/api/rest"

# Change the REST path for the ndex_get_network function
custom_ndex_config$api$network$get$url <- "/custom/networks/#NETWORKID#"

# Add some (default) parameters to the function
custom_ndex_config$api$network$get$params$newParam <- list(method = "parameter", tag = "someTag", default = "someValue")
```

It is also possible to write an own configuration in yaml (or convert
`ndex_config` to yaml, see above) and load it as object (`yaml::load` or
`yaml::load_file`) or to translate the configuration into R code using
the function `ndexr:::yamlToRConfig()`

Note: For package maintenance it is advised to add new versions as yaml
definitions in `/R/ndex_api_config.yml` (for example as "Version\_3.0") and update the R code in `/R/ndex_api_config.r`, which defines the `ndex_config` object.

```
yamlToRConfig <- function(
    yamlFile = "R/ndex_api_config.yml", rScriptFile = "R/ndex_api_config.r",
    defaultHeader = ndex_conf_header
) {
    yamlObj <- yaml::yaml.load_file(yamlFile)
    rCodeTxt <- paste0(defaultHeader, listToRCode(yamlObj))
    outFile <- file(rScriptFile)
    writeLines(rCodeTxt, outFile)
    close(outFile)
}

yamlToRConfig()
```