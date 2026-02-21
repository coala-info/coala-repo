# Contents

* [1 Abstract](#abstract)
* [2 Introduction](#introduction)
* [3 Software features](#software-features)
* [4 Example](#example)
  + [4.1 Define input data](#define-input-data)
  + [4.2 Build MetaboSignal network-table](#build-metabosignal-network-table)
  + [4.3 Customize MetaboSignal network-table](#customize-metabosignal-network-table)
  + [4.4 Build distance matrix](#build-distance-matrix)
  + [4.5 Build shortest-paths subnetwork](#build-shortest-paths-subnetwork)
* [References](#references)

MetaboSignal

Andrea Rodriguez Martinez,
Rafael Ayala, Joram M. Posma, Ana L. Neves, Marc-Emmanuel Dumas

May 25, 2017

# 1 Abstract

“MetaboSignal” is an R package designed to overlay metabolic and signaling pathways reported in the Kyoto Encyclopedia of Genes and Genomes (KEGG). It is a network-based approach that allows exploring the topological relationship between genes (signaling- or metabolic-genes) and metabolites. MetaboSignal is ideally suited to identify biologically relevant candidate genes in metabolomics quantitative trait locus (mQTL) mapping studies, especially in the case of *trans*-acting associations. It can be also used to provide mechanistic explanations of the metabolic perturbations observed in genetic modes (e.g. knock-out) or to identify target metabolic pathways of signaling genes.

# 2 Introduction

The Kyoto Encyclopedia of Genes and Genomes (KEGG) (Kanehisa & Goto [2000](#ref-kanehisa2000)) is the reference database to explore biochemical pathways and cellular processes. KEGG pathways are stored and displayed as graphical diagrams composed by nodes (e.g. metabolites, genes, reactions) and edges, which represent the physical interaction (e.g. metabolic reaction, activaction, or binding) between pairs of nodes.

In the last years, various tools have been developed for analyzing and customizing metabolic or signaling KEGG graphs independently (Zhang & Wiemann [2009](#ref-zhang2009); Posma *et al.* [2014](#ref-posma2014)). However, these approaches ignore the interconnection between the genome and the metabolome, and consequently they cannot provide an integrated overview of regulatory events leading to the observed metabolic patterns. In order to address this problem, we have developed an R-based toolbox, called MetaboSignal, that allows building organism-specific KEGG metabolic and signaling networks that account for the interaction between metabolites and genes (both metabolic and signaling). Importantly, our approach allows creating tissue-specific networks, where genes undetected in a given target tissue are neglected.

# 3 Software features

The metabolic and signaling KEGG pathways of interest are parsed using the KEGGgraph package (Zhang & Wiemann [2009](#ref-zhang2009)), to generate organism-specific metabolic and signaling directed network-tables (i.e. 3-column matrix). The user can decide whether gene nodes will represent organism-specific KEGG gene IDs or orthology IDs. Importantly, in the case of human, MetaboSignal allows building tissue-specific signaling networks, where genes not expressed in a given target tissue are neglected. Tissue filtering is achieved using the hpar package (Gatto), which is based on data from the Human Protein Atlas database.

The metabolic and signaling networks are then merged to build a MetaboSignal network, which can be further customized according to different criteria. For instance, undesired nodes can be removed or nodes representing chemical isomers of the same compound can be clustered into a common node. MetaboSignal evaluates network topology (e.g. node betweeness) and calculates a distance matrix (Csardi & Nepusz [2006](#ref-csardi2006igraph)) containing the shortest path lengths from a list of genes to a list of metabolites of interest. MetaboSignal also builds subnetworks containing betweenness-ranked shortest paths from a list of genes to a list of metabolites (presumably selected based on the distance matrix).

Finally, the original network or the sub-networks are exported to be visualized in CytoScape (Shannon *et al.* [2003](#ref-shannon2003)). MetaboSignal also generates several attribute files that allow customization of the node parameters. Alternatively, the network can be transformed into an igraph object and visualized in R.

# 4 Example

In order to illustrate the functionality of our package, we have used transcriptomic and metabonomic datasets from white adipose tissue of rat congenic strains derived from the diabetic Goto-Kakizaki (GK) and normoglycemic Brown-Norway (BN) rats. Despite of the strong genetic similarities between the congenic strains, each strain exhibits distinctive metabolic and gene expression patterns.

We next describe how MetaboSignal was used to provide a mechanistic explanation of the gene-metabolite associations found in this study. As an example, we will use the associations between the genes: *G6pc3* (303565), *Ship2* (65038) or *Ppp2r5b* (309179) and D-glucose.

## 4.1 Define input data

We built a rat-specific MetaboSignal network by merging two metabolic pathways: “glycolysis” and “inositol phosphate metabolism”, with two signaling pathways: “insulin signaling pathway” and “PI3K-Akt signaling pathway”.

We used the function “MS\_keggFinder( )” to find the “organism\_code” of the rat and the IDs of the pathways of interest. Notice that the IDs of all metabolic and signaling pathways of a given organism can be retrieved by calling the function “MS\_getPathIds()”.

```
MS_keggFinder(KEGG_database = "organism", match = "rattus")
```

```
## $rattus
##                                    T                        organism_code
##                             "T01003"                                "rno"
##                        organism_name                          description
##            "Rattus norvegicus (rat)" "Eukaryotes;Animals;Mammals;Rodents"
```

```
MS_keggFinder(KEGG_database = "pathway", match = c("glycol",
    "inositol phosphate", "insulin signal", "akt"),
    organism_code = "rno")
```

```
## $glycol
##                                                  path_ID
##                                               "rno00010"
##                                         path_Description
## "Glycolysis / Gluconeogenesis - Rattus norvegicus (rat)"
##
## $`inositol phosphate`
##                                                   path_ID
##                                                "rno00562"
##                                          path_Description
## "Inositol phosphate metabolism - Rattus norvegicus (rat)"
##
## $`insulin signal`
##                                               path_ID
##                                            "rno04910"
##                                      path_Description
## "Insulin signaling pathway - Rattus norvegicus (rat)"
##
## $akt
##                                                path_ID
##                                             "rno04151"
##                                       path_Description
## "PI3K-Akt signaling pathway - Rattus norvegicus (rat)"
```

Based on this,

```
metabo_paths <- c("rno00010", "rno00562")
signaling_paths <- c("rno04910", "rno04151")
```

## 4.2 Build MetaboSignal network-table

We used the selected metabo\_paths and signaling\_paths to build a MetaboSignal network-table.

```
MetaboSignal_table <- MS_keggNetwork(metabo_paths = metabo_paths,
    signaling_paths = signaling_paths)
```

MetaboSignal\_table is a three-column matrix where each row represents an edge between two nodes (source to target). The third column indicates the type of interaction. Since we did not use the option “expand\_genes”, the gene nodes of the network represent orthology KEGG IDs. Note that clustering gene-isoforms by orthology IDs is a very convenient strategy to reduce network dimensionality without losing biological information.

## 4.3 Customize MetaboSignal network-table

Given that we were not interest in discriminating between different isomers of D-glucose, we used the function “MS\_replaceNodes( )” to group the IDs of alpha-D-glucose (“cpd:C00267”), beta-D-glucose (“cpd:C00221”) and D-glucose (“cpd:C00031”).

```
MetaboSignal_table <- MS_replaceNode(node1 = c("cpd:C00267",
    "cpd:C00221"), node2 = "cpd:C00031", MetaboSignal_table)
```

We used the function “MS\_findMappedNodes( )” to check that the glucose isomers had been successfully clustered.

```
MS_findMappedNodes(nodes = c("cpd:C00267", "cpd:C00221",
    "cpd:C00031"), MetaboSignal_table)
```

```
## $mapped_nodes
## [1] "cpd:C00031"
##
## $unmapped_nodes
## [1] "cpd:C00267" "cpd:C00221"
```

## 4.4 Build distance matrix

We used the function “MetaboSignal\_distances( )” to calculate the shortest path lengths from our genes of interest: *G6pc3* (303565), *Ship2* (65038) or *Ppp2r5b* (309179) to D-glucose (“cpd:C00031”). We used the default mode (mode = “SP”), which indicates that all the network is considered as directed, except the edges linked to the target metabolite (in this case D-glucose) that are considered as undirected. This option is designed to reach metabolites acting as substrates of irreversible reactions, while keeping the directionality of the network.

```
## Get KEGG IDs
MS_convertGene(genes = c("303565", "65038", "309179"),
    organism_code = "rno", organism_name = "rat", output = "matrix")
```

```
##      KEGG_ID  entrez_ID
## [1,] "K01084" "303565"
## [2,] "K15909" "65038"
## [3,] "K11584" "309179"
```

```
MS_distances(MetaboSignal_table, organism_code = "rno",
    source_genes = c("K01084", "K15909", "K11584"),
    target_metabolites = "cpd:C00031", names = TRUE)
```

```
##        cpd:C00031
## G6PC            1
## SHIP2           4
## PPP2R5          3
```

## 4.5 Build shortest-paths subnetwork

Finally, we used the function “MetaboSignal\_shortestPathsNetwork( )” to build a subnetwork containing betweenness-ranked shortest paths from our genes of interest: *G6pc3* (303565), *Ship2* (65038) or *Ppp2r5b* (309179) to D-glucose (“cpd:C00031”).

```
MS_shortestPathsNetwork(MetaboSignal_table, organism_code = "rno",
    source_nodes = c("K01084", "K15909", "K11584"),
    target_nodes = "cpd:C00031", type = "bw", file_name = "MS")
```

This function exported three files in the working directory: “MS\_Network.txt”,
“MS\_NodesType.txt”, and “MS\_TargetNodes.txt”. These files were imported into cytoscape using the options:
file-import-network and file-import-table. The attribute files were used to customize the network
(e.g. the nodes were coloured based on the molecular entity they represent), producing a final graph that
looks as follows:

![](data:image/png;base64...)

# References

Csardi, G. & Nepusz, T. (2006). The igraph software package for complex network research. *InterJournal*, **Complex Systems**, 1695. Retrieved from <http://igraph.org>

Gatto, L. *Hpar: Human protein atlas in r*.

Kanehisa, M. & Goto, S. (2000). KEGG: Kyoto encyclopedia of genes and genomes. *Nucleic Acids Research*, **28**, 27–30. Retrieved from <http://nar.oxfordjournals.org/content/28/1/27>

Posma, J.M., Robinette, S.L., Holmes, E. & Nicholson, J.K. (2014). MetaboNetworks, an interactive matlab-based toolbox for creating, customizing and exploring sub-networks from kegg. *Bioinformatics*, **30**, 893–895. Retrieved from <http://bioinformatics.oxfordjournals.org/content/30/6/893>

Shannon, P., Markiel, A., Ozier, O., Baliga, N.S., Wang, J.T., Ramage, D., Amin, N. & Ideker, B.S.T. (2003). Cytoscape: A software environment for integrated models of biomolecular interaction networks. *Genome Research*, **13**, 2498–2504. Retrieved from <http://genome.cshlp.org/content/13/11/2498>

Zhang, J.D. & Wiemann, S. (2009). KEGGgraph: A graph approach to kegg pathway in r and bioconductor. *Bioinformatics*, **25**, 1470–1471. Retrieved from <http://bioinformatics.oxfordjournals.org/content/25/11/1470>