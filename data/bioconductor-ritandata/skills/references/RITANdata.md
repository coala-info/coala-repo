# Introduction to RITANdata

#### Michael T. Zimmermann

#### 2025-11-04

RITAN is an R package intended for Rapid Integration of Term Annotation and Network resources. RITANdata is an R package containing data to support RITAN.

```
library(RITANdata)
```

# Pathways, Terms, and Genesets

The R object *geneset\_list* This version of RITAN is distributed with the following annotation resources:

```
names(geneset_list)
```

```
##  [1] "MSigDB_Hallmarks"                 "MSigDB_C2"
##  [3] "MSigDB_C3.TFtargets"              "MSigDB_C3.miRNA"
##  [5] "MSigDB_C5"                        "MSigDB_C7"
##  [7] "GO"                               "GO_slim_PIR"
##  [9] "GO_slim_generic"                  "PathwayCommonsPathways"
## [11] "ReactomePathways"                 "NetPath_Gene_regulation"
## [13] "Chaussabel_Modules"               "Blood_Translaiton_Modules"
## [15] "KEGG_filtered_canonical_pathways" "DisGeNet"
```

Please cite each resource used in your analysis. If you use data from MSigDB, please register at [MSigDB](http://software.broadinstitute.org/gsea/msigdb/index.jsp). Doing so will help to ensure the future availability and extension of these valuable resources.

# Network Resources

The R object, *network\_list*, contains 6 human network-biology resources. Additionally, RITAN leverages existing R packages to access data from HPRD, BioGRID, and STRING. Citation information for each cached resource can be accessed via attr():

```
require(knitr)
```

```
## Loading required package: knitr
```

```
kable( attr(network_list, 'network_data_sources') )
```

| Abbreviation | Citation |
| --- | --- |
| PID | Schaefer CF, Anthony K, Krupa S, Buchoff J, Day M, et al. (2009) PID: the Pathway Interaction Database. Nucleic acids research 37: D674-679. |
| TFe | Yusuf D, Butland SL, Swanson MI, Bolotin E, Ticoll A, et al. (2012) The transcription factor encyclopedia. Genome biology 13: R24. |
| dPPI | Vinayagam A, Stelzl U, Foulle R, Plassmann S, Zenkner M, et al. (2011) A directed protein interaction network for investigating intracellular signal transduction. Science signaling 4: rs8. |
| HPRD | Prasad TS, Kandasamy K, Pandey A (2009) Human Protein Reference Database and Human Proteinpedia as discovery tools for systems biology. Methods in molecular biology 577: 67-79. |
| CCSB | Prasad TS, Kandasamy K, Pandey A (2009) Human Protein Reference Database and Human Proteinpedia as discovery tools for systems biology. Methods in molecular biology 577: 67-79. |
| STRING | Szklarczyk D, Franceschini A, Kuhn M, Simonovic M, Roth A, et al. (2011) The STRING database in 2011: functional interaction networks of proteins, globally integrated and scored. Nucleic acids research 39: D561-568. |
| HumanNet | Lee I, Blom UM, Wang PI, Shim JE, Marcotte EM. Prioritizing candidate disease genes by network-based boosting of genome-wide association data. Genome Res. 2011;21(7):1109-1121. |
| Biogrid | Chatr-Aryamontri A, Breitkreutz BJ, Oughtred R, Boucher L, Heinicke S, Chen D, Stark C, Breitkreutz A, Kolas N, ODonnell L, Reguly T, Nixon J, Ramage L, Winter A, Sellam A, Chang C, Hirschman J, Theesfeld C, Rust J, Livstone MS, Dolinski K, Tyers M. The BioGRID interaction database: 2015 update. Nucleic Acids Research. Nov. 2014 |
| ChEA | Lachmann A, Xu H, Krishnan J, Berger SI, Mazloom AR, Maayan A. (2010) ChEA: transcription factor regulation inferred from integrating genome-wide ChIP-X experiments. Bioinformatics. Oct 1;26(19):2438-44. |

We retrive data from **HPRD** and **BioGrid** through the *ProNet* package. We retrive data from **STRING** through the *STRINGdb* package.

# Background Gene List

In any enrichment analysis, determining your background list of genes is critical. By the “background,” we mean the sum/universe of entities that could have been measured in your study. For example, if you looked for mutations in any coding genes from whole-genome sequencing, then any coding gene in the genome could have been identified. However, if you ran mRNA-Seq on a fibroblast cell line, then only the genes expressed by that cell line could have been assayed.

Many tools, including RITAN, make the default assumption of all human protein coding genes for this background. In RITAN, functions have an optional input argument named *all\_symbols* for defining the background gene list. If no value is given, the function *load\_all\_protein\_coding\_symbols()* will download the current list from genenames.org. We include the R object *cached\_coding\_genes*, which is a cached download of all human protein coding genes. This object is used in the RITAN vignettes, for expediency.

It is up to the user to determine if this is a fitting assumption, or if a different background should be chosen. A few “rules of thumb” would be to use only the genes captured for library generation (e.g. exome capture region), or expressed in the input cells across any condition.