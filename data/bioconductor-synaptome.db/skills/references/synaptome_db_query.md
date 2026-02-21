# SynaptomeDB: database for Synaptic proteome

### Manual for querying SynaptomeDB

#### Oksana Sorokina, Anatoly Sorokin, J. Douglas Armstrong

#### 27.08.2025

# Introduction

58 published synaptic proteomic datasets (2000-2022 years) that describe over 8,000 proteins were integrated and combined with direct protein-protein interactions and functional metadata to build a network resource.

The set includes 29 post synaptic proteome (PSP) studies (2000 to 2019) contributing a total of 5,560 mouse and human unique gene identifiers; 19 presynaptic studies (2004 to 2022) describe 2,772 unique human and mouse gene IDs, and 11 studies that span the whole synaptosome and report 7,198 unique genes.

NB: With the latest update of the database we have added 6 new studies: 1 presynaptic and 5 postsynaptic, new compsrtment (Synaptic Vesicle), and coding mutations for Autistic Spectral Disorder (ASD) and epilepsy (Epi).

To reconstruct protein-protein interaction (PPI) networks for the pre- and post-synaptic proteomes we used human PPI data filtered for the highest confidence direct and physical interactions from BioGRID, Intact and DIP. The resulting postsynaptic proteome (PSP) network contains 4,817 nodes and 27,788 edges in the Largest Connected Component (LCC). The presynaptic network is significantly smaller and comprises 2,221 nodes and 8,678 edges in the LCC.

The database includes: proteomic and interactomic data with supporting information on compartment, specie and brain region, GO function information for three species: mouse, rat and human, disease annotation for human (based on Human Disease Ontology (HDO) and GeneToModel table, which links certain synaptic proteins to existing computational models of synaptic plasticity and synaptic signal transduction

The original files are maintained at Eidnburgh Datashare <https://doi.org/10.7488/ds/3017>. Updated database file could be found here: <https://doi.org/10.7488/ds/3771>

The dataset was described in the paper:

1. Sorokina, O., Mclean, C., Croning, M.D.R. et al.
   *A unified resource and configurable model of the synapse proteome and its role in disease*. Sci Rep 11, 9967 (2021). <https://doi.org/10.1038/s41598-021-88945-7>.

## Database content overview

Following diagrams illustrate content of the database available for analysis by the package functions. Source code for construction of figures ar available in the Appendix [statistics code](#statistics) section.

### Presynaptic datasets

![](data:image/png;base64...)

Number of identified proteins in Presynaptic datasets

### Postsynaptic datasets

![](data:image/png;base64...)

Number of identified proteins in Postsynaptic datasets

### Synaptic Vesicle

![](data:image/png;base64...)

Number of identified proteins in Synaptic Vesicle datasets (note the difference in the color scale)

### Brain region distribution

![](data:image/png;base64...)

Number of identified proteins in different Brain Regions(stacked)

![](data:image/png;base64...)

Number of identified proteins in different Brain Regions(grouped)

# Overview of capabilities

## 1.Get information for a specific gene or gene set.

The dataset can be used to answer frequent questions such as “What is known about my favourite gene? Is it pre- or postsynaptic? Which brain region was it identified in?”, “Which publication it was reported in?” Information could be obtained by submitting gene EntrezID or Gene name

```
t <- getGeneInfoByEntrez(1742)
pander(head(t))
```

Table continues below

| GeneID | Localisation | MGI | HumanEntrez | MouseEntrez | HumanName |
| --- | --- | --- | --- | --- | --- |
| 1 | Postsynaptic | MGI:1277959 | 1742 | 13385 | DLG4 |
| 1 | Postsynaptic | MGI:1277959 | 1742 | 13385 | DLG4 |
| 1 | Postsynaptic | MGI:1277959 | 1742 | 13385 | DLG4 |
| 1 | Postsynaptic | MGI:1277959 | 1742 | 13385 | DLG4 |
| 1 | Postsynaptic | MGI:1277959 | 1742 | 13385 | DLG4 |
| 1 | Postsynaptic | MGI:1277959 | 1742 | 13385 | DLG4 |

Table continues below

| MouseName | PaperPMID | Paper | Dataset | Year | SpeciesTaxID |
| --- | --- | --- | --- | --- | --- |
| Dlg4 | 10818142 | WALIKONIS\_2000 | FULL | 2000 | 10116 |
| Dlg4 | 10862698 | HUSI\_2000 | FULL | 2000 | 10090 |
| Dlg4 | 11895482 | SATON\_2002 | FULL | 2002 | 10090 |
| Dlg4 | 14532281 | LI\_2004 | FULL | 2004 | 10116 |
| Dlg4 | 14720225 | YOSHIMURA\_2004 | FULL | 2004 | 10116 |
| Dlg4 | 15020595 | PENG\_2002 | FULL | 2004 | 10116 |

| BrainRegion |
| --- |
| Forebrain |
| Forebrain |
| Forebrain |
| Forebrain |
| Forebrain |
| Forebrain |

```
t <- getGeneInfoByName("CASK")
pander(head(t))
```

Table continues below

| GeneID | Localisation | MGI | HumanEntrez | MouseEntrez | HumanName |
| --- | --- | --- | --- | --- | --- |
| 409 | Postsynaptic | MGI:1309489 | 8573 | 12361 | CASK |
| 409 | Postsynaptic | MGI:1309489 | 8573 | 12361 | CASK |
| 409 | Postsynaptic | MGI:1309489 | 8573 | 12361 | CASK |
| 409 | Postsynaptic | MGI:1309489 | 8573 | 12361 | CASK |
| 409 | Postsynaptic | MGI:1309489 | 8573 | 12361 | CASK |
| 409 | Postsynaptic | MGI:1309489 | 8573 | 12361 | CASK |

Table continues below

| MouseName | PaperPMID | Paper | Dataset | Year | SpeciesTaxID |
| --- | --- | --- | --- | --- | --- |
| Cask | 15169875 | JORDAN\_2004 | FULL | 2004 | 10090 |
| Cask | 16635246 | COLLINS\_2006 | FULL | 2006 | 10090 |
| Cask | 17623647 | DOSEMESI\_2007 | FULL | 2007 | 10116 |
| Cask | 18056256 | TRINIDAD\_2008 | FULL | 2008 | 10090 |
| Cask | 18056256 | TRINIDAD\_2008 | FULL | 2008 | 10090 |
| Cask | 18056256 | TRINIDAD\_2008 | FULL | 2008 | 10090 |

| BrainRegion |
| --- |
| Brain |
| Forebrain |
| Cerebral cortex |
| Midbrain |
| Cerebellum |
| Hippocampus |

```
t <- getGeneInfoByName(c("CASK", "DLG2"))
pander(head(t))
```

Table continues below

| GeneID | Localisation | MGI | HumanEntrez | MouseEntrez | HumanName |
| --- | --- | --- | --- | --- | --- |
| 6 | Postsynaptic | MGI:1344351 | 1740 | 23859 | DLG2 |
| 6 | Postsynaptic | MGI:1344351 | 1740 | 23859 | DLG2 |
| 6 | Postsynaptic | MGI:1344351 | 1740 | 23859 | DLG2 |
| 6 | Postsynaptic | MGI:1344351 | 1740 | 23859 | DLG2 |
| 6 | Postsynaptic | MGI:1344351 | 1740 | 23859 | DLG2 |
| 6 | Postsynaptic | MGI:1344351 | 1740 | 23859 | DLG2 |

Table continues below

| MouseName | PaperPMID | Paper | Dataset | Year | SpeciesTaxID |
| --- | --- | --- | --- | --- | --- |
| Dlg2 | 10862698 | HUSI\_2000 | FULL | 2000 | 10090 |
| Dlg2 | 11895482 | SATON\_2002 | FULL | 2002 | 10090 |
| Dlg2 | 14532281 | LI\_2004 | FULL | 2004 | 10116 |
| Dlg2 | 14720225 | YOSHIMURA\_2004 | FULL | 2004 | 10116 |
| Dlg2 | 15169875 | JORDAN\_2004 | FULL | 2004 | 10090 |
| Dlg2 | 15748150 | TRINIDAD\_2005 | FULL | 2005 | 10090 |

| BrainRegion |
| --- |
| Forebrain |
| Forebrain |
| Forebrain |
| Forebrain |
| Brain |
| Brain |

## 2.Get internal GeneIDs for the list of genes.

Obtaining Internal database GeneIDs is a useful intermediate step for more complex queries including those for building protein-protein interaction (PPI) networks for compartments and brain regions. Internal GeneID is specie-neutral and unique, which allows exact identification of the object of interest in case of redundancy (e.g. one Human genes matches on a few mouse ones, etc.)

```
t <- findGenesByEntrez(c(1742, 1741, 1739, 1740))
pander(head(t))
```

Table continues below

| GeneID | MGI | HumanEntrez | MouseEntrez | RatEntrez | HumanName |
| --- | --- | --- | --- | --- | --- |
| 1 | MGI:1277959 | 1742 | 13385 | 29495 | DLG4 |
| 6 | MGI:1344351 | 1740 | 23859 | 64053 | DLG2 |
| 15 | MGI:1888986 | 1741 | 53310 | 58948 | DLG3 |
| 46 | MGI:107231 | 1739 | 13383 | 25252 | DLG1 |

| MouseName | RatName |
| --- | --- |
| Dlg4 | Dlg4 |
| Dlg2 | Dlg2 |
| Dlg3 | Dlg3 |
| Dlg1 | Dlg1 |

```
t <- findGenesByName(c("SRC", "SRCIN1", "FYN"))
pander(head(t))
```

Table continues below

| GeneID | MGI | HumanEntrez | MouseEntrez | RatEntrez | HumanName |
| --- | --- | --- | --- | --- | --- |
| 48 | MGI:1933179 | 80725 | 56013 | 56029 | SRCIN1 |
| 585 | MGI:98397 | 6714 | 20779 | 83805 | SRC |
| 710 | MGI:95602 | 2534 | 14360 | 25150 | FYN |

| MouseName | RatName |
| --- | --- |
| Srcin1 | Srcin1 |
| Src | Src |
| Fyn | Fyn |

## 3.Get disease information for the gene set

Synaptic genes are annotated with disease information from Human Disease Ontology, where available. To get disease information one can submit the list of Human Entrez Is or Human genes names, it could be also the list of Internal GeneIDs if using `getGeneDiseaseByIDs` function

```
t <- getGeneDiseaseByName (c("CASK", "DLG2", "DLG1"))
pander(head(t))
```

| HumanEntrez | HumanName | HDOID | Description |
| --- | --- | --- | --- |
| 1740 | DLG2 | DOID:936 | brain\_disease |
| 8573 | CASK | DOID:936 | brain\_disease |
| 1739 | DLG1 | DOID:331 | central\_nervous\_system\_disease |
| 1740 | DLG2 | DOID:331 | central\_nervous\_system\_disease |
| 8573 | CASK | DOID:331 | central\_nervous\_system\_disease |
| 1739 | DLG1 | DOID:863 | nervous\_system\_disease |

```
t <- getGeneDiseaseByEntres (c(8573, 1742, 1739))
pander(head(t))
```

| HumanEntrez | HumanName | HDOID | Description |
| --- | --- | --- | --- |
| 8573 | CASK | DOID:936 | brain\_disease |
| 1739 | DLG1 | DOID:331 | central\_nervous\_system\_disease |
| 1742 | DLG4 | DOID:331 | central\_nervous\_system\_disease |
| 8573 | CASK | DOID:331 | central\_nervous\_system\_disease |
| 1739 | DLG1 | DOID:863 | nervous\_system\_disease |
| 1742 | DLG4 | DOID:863 | nervous\_system\_disease |

## 5.Get information about the studies, combined into dataset

One can obtain the overview of synaptic proteome papers combined into the database, which includes paper PMID, specie Tax ID, year of publication, subcellular localisation, brain region and number of proteins identified in the paper. This information may help to choose the specific study(ies) for further work.

```
p <- getPapers()
pander(head(p))
```

Table continues below

| PaperPMID | SpeciesTaxID | Year | Name | Localisation | BrainRegion |
| --- | --- | --- | --- | --- | --- |
| 10818142 | 10116 | 2000 | WALIKONIS\_2000 | Postsynaptic | Forebrain |
| 10862698 | 10090 | 2000 | HUSI\_2000 | Postsynaptic | Forebrain |
| 11895482 | 10090 | 2002 | SATON\_2002 | Postsynaptic | Forebrain |
| 14532281 | 10116 | 2004 | LI\_2004 | Postsynaptic | Forebrain |
| 14720225 | 10116 | 2004 | YOSHIMURA\_2004 | Postsynaptic | Forebrain |
| 15007177 | 10116 | 2004 | BLONDEAU\_2004 | Presynaptic | Brain |

| Method | Ngenes |
| --- | --- |
| Shotgun | 29 |
| Shotgun | 77 |
| Shotgun | 45 |
| Shotgun | 138 |
| Shotgun | 436 |
| Shotgun | 209 |

## 6.Get the table of frequently identified proteins

It is also possible to obtain the list of proteins found in more than one study, for the whole synaptic proteome. For that, the user needs to provide a “count” value as a desired minimal number of identifications (e.g. 2 or more). The command returns the table with gene identifiers and “Npmid” column, which contains the number of studies where this gene was identified.

```
#find all proteins in synaptic proteome identified 2 times or more
gp <- findGeneByPaperCnt(cnt = 2)
pander(head(gp))
```

Table continues below

| GeneID | MGI | HumanEntrez | MouseEntrez | RatEntrez | HumanName |
| --- | --- | --- | --- | --- | --- |
| 1 | MGI:1277959 | 1742 | 13385 | 29495 | DLG4 |
| 2 | MGI:88256 | 815 | 12322 | 25400 | CAMK2A |
| 3 | MGI:96568 | 9118 | 226180 | 24503 | INA |
| 4 | MGI:98388 | 6711 | 20742 | 305614 | SPTBN1 |
| 5 | MGI:88257 | 816 | 12323 | 24245 | CAMK2B |
| 6 | MGI:1344351 | 1740 | 23859 | 64053 | DLG2 |

| MouseName | RatName | Npmid |
| --- | --- | --- |
| Dlg4 | Dlg4 | 48 |
| Camk2a | Camk2a | 54 |
| Ina | Ina | 50 |
| Sptbn1 | Sptbn1 | 45 |
| Camk2b | Camk2b | 46 |
| Dlg2 | Dlg2 | 43 |

## 7.Get the table of proteins identified in specific studies

Following section 5, when the information for all considered proteomic studies was obtained, user can select specific study(ies) by PMID and get the proteins identified in those studies. By providing `count` value user can extract either all proteins from specified studies (count = 1), or just frequently found ones (count >=2). As above, the command returns the table with gene identifiers with `Npmid` column, which contains the number of studies where this protein was identified

```
spg <- findGeneByPapers(p$PaperPMID[1:5], cnt = 1)
pander(head(spg))
```

Table continues below

| GeneID | MGI | HumanEntrez | MouseEntrez | RatEntrez | HumanName |
| --- | --- | --- | --- | --- | --- |
| 1 | MGI:1277959 | 1742 | 13385 | 29495 | DLG4 |
| 2 | MGI:88256 | 815 | 12322 | 25400 | CAMK2A |
| 3 | MGI:96568 | 9118 | 226180 | 24503 | INA |
| 4 | MGI:98388 | 6711 | 20742 | 305614 | SPTBN1 |
| 5 | MGI:88257 | 816 | 12323 | 24245 | CAMK2B |
| 6 | MGI:1344351 | 1740 | 23859 | 64053 | DLG2 |

| MouseName | RatName | Npmid |
| --- | --- | --- |
| Dlg4 | Dlg4 | 5 |
| Camk2a | Camk2a | 5 |
| Ina | Ina | 5 |
| Sptbn1 | Sptbn1 | 4 |
| Camk2b | Camk2b | 4 |
| Dlg2 | Dlg2 | 4 |

## 8.Get the table of proteins frequently identified in specific compartment

Most of the times, user is interested in the specific compartment rather then in total synaptic proteome. To help identify the genes most probably residenting in the specific compartment and exclude possible contaminants,
findGeneByCompartmentPaperCnt function provides the table of proteins found `cnt` or more times in different compartment-paper pairs.

```
gcp <- findGeneByCompartmentPaperCnt(cnt = 2)
pander(head(gcp))
```

Table continues below

| GeneID | MGI | HumanEntrez | MouseEntrez | RatEntrez | HumanName |
| --- | --- | --- | --- | --- | --- |
| 1 | MGI:1277959 | 1742 | 13385 | 29495 | DLG4 |
| 1 | MGI:1277959 | 1742 | 13385 | 29495 | DLG4 |
| 1 | MGI:1277959 | 1742 | 13385 | 29495 | DLG4 |
| 1 | MGI:1277959 | 1742 | 13385 | 29495 | DLG4 |
| 2 | MGI:88256 | 815 | 12322 | 25400 | CAMK2A |
| 2 | MGI:88256 | 815 | 12322 | 25400 | CAMK2A |

| MouseName | RatName | Localisation | Npmid |
| --- | --- | --- | --- |
| Dlg4 | Dlg4 | Postsynaptic | 29 |
| Dlg4 | Dlg4 | Presynaptic | 4 |
| Dlg4 | Dlg4 | Synaptosome | 16 |
| Dlg4 | Dlg4 | Synaptic\_Vesicle | 3 |
| Camk2a | Camk2a | Postsynaptic | 28 |
| Camk2a | Camk2a | Presynaptic | 13 |

```
# Now user can select the specific compartment and proceed working with
# obtained list of frequently found proteins
presgp <- gcp[gcp$Localisation == "Presynaptic",]
dim(presgp)
#> [1] 1542   10
pander(head(presgp))
```

Table continues below

| GeneID | MGI | HumanEntrez | MouseEntrez | RatEntrez | HumanName |
| --- | --- | --- | --- | --- | --- |
| 1 | MGI:1277959 | 1742 | 13385 | 29495 | DLG4 |
| 2 | MGI:88256 | 815 | 12322 | 25400 | CAMK2A |
| 3 | MGI:96568 | 9118 | 226180 | 24503 | INA |
| 4 | MGI:98388 | 6711 | 20742 | 305614 | SPTBN1 |
| 5 | MGI:88257 | 816 | 12323 | 24245 | CAMK2B |
| 6 | MGI:1344351 | 1740 | 23859 | 64053 | DLG2 |

| MouseName | RatName | Localisation | Npmid |
| --- | --- | --- | --- |
| Dlg4 | Dlg4 | Presynaptic | 4 |
| Camk2a | Camk2a | Presynaptic | 13 |
| Ina | Ina | Presynaptic | 12 |
| Sptbn1 | Sptbn1 | Presynaptic | 8 |
| Camk2b | Camk2b | Presynaptic | 8 |
| Dlg2 | Dlg2 | Presynaptic | 3 |

## 9.Get PPI interactions for my list of genes

Custom Protein-protein interactions based on bespoke subsets of molecules could be extracted in two general ways: “induced” and “limited”. In the first case, the command will return all possible interactors for the genes within the whole interactome. In the second case it will return only interactions between the genes of interest. PPIs could be obtained by submitting list of EntrezIDs or gene names, or Internal IDs - in all cases the interactions will be returned as a list of interacting pairs of Intenal GeneIDs.

```
t <- getPPIbyName(
    c("CASK", "DLG4", "GRIN2A", "GRIN2B","GRIN1"),
    type = "limited")
pander(head(t))
```

| A | B |
| --- | --- |
| 38 | 1 |
| 7 | 1 |
| 1 | 7 |
| 1 | 38 |
| 1 | 9 |
| 9 | 1 |

```
t <- getPPIbyEntrez(c(1739, 1740, 1742, 1741), type='induced')
pander(head(t))
```

| A | B |
| --- | --- |
| 1 | 2871 |
| 6 | 2871 |
| 15 | 2871 |
| 1 | 617 |
| 1 | 30 |
| 156 | 1 |

```
 #obtain PPIs for the list of frequently found genes in presynaptc compartment
t <- getPPIbyEntrez(presgp$HumanEntrez, type='induced')
pander(head(t))
```

| A | B |
| --- | --- |
| 365 | 148 |
| 1048 | 148 |
| 52 | 365 |
| 52 | 1048 |
| 321 | 1048 |
| 321 | 365 |

## 10.Get the molecular structure of synaptic compartment

Three main synaptic compartments considered in the database are “presynaptic”, “postsynaptic” and “synaptosome”. Genes are classified to compartments based on respective publications, so that each gene can belong to one or two, or even three compartments. The full list of genes for specific compartment could be obtained with command `getAllGenes4Compartment`, which returns the table with main gene identifiers, like internal GeneIDs, MGI ID, Human Entrez ID, Human Gene Name, Mouse Entrez ID, Mouse Gene Name, Rat Entrez ID, Rat Gene Name.

If you need to check which genes of your list belong to specific compartment, you can use `getGenes4Compartment` command, which will select from your list only genes associated with specific compartment. To obtain the PPI network for compartment one has to submit the list of Internal GeneIDs obtained with previous commands.

```
#getting the list of compartment
comp <- getCompartments()
pander(comp)
```

| ID | Name | Description |
| --- | --- | --- |
| 1 | Postsynaptic | Postsynaptic |
| 2 | Presynaptic | Presynaptic |
| 3 | Synaptosome | Synaptosome |
| 4 | Synaptic\_Vesicle | Synaptic\_Vesicle |

```
#getting all genes for postsynaptic compartment
gns <- getAllGenes4Compartment(compartmentID = 1)
pander(head(gns))
```

Table continues below

| GeneID | MGI | HumanEntrez | MouseEntrez | RatEntrez | HumanName |
| --- | --- | --- | --- | --- | --- |
| 1 | MGI:1277959 | 1742 | 13385 | 29495 | DLG4 |
| 2 | MGI:88256 | 815 | 12322 | 25400 | CAMK2A |
| 3 | MGI:96568 | 9118 | 226180 | 24503 | INA |
| 4 | MGI:98388 | 6711 | 20742 | 305614 | SPTBN1 |
| 5 | MGI:88257 | 816 | 12323 | 24245 | CAMK2B |
| 6 | MGI:1344351 | 1740 | 23859 | 64053 | DLG2 |

| MouseName | RatName |
| --- | --- |
| Dlg4 | Dlg4 |
| Camk2a | Camk2a |
| Ina | Ina |
| Sptbn1 | Sptbn1 |
| Camk2b | Camk2b |
| Dlg2 | Dlg2 |

```
#getting full PPI network for postsynaptic compartment
ppi <- getPPIbyIDs4Compartment(gns$GeneID,compartmentID =1, type = "induced")
pander(head(ppi))
```

| A | B |
| --- | --- |
| 365 | 148 |
| 1048 | 148 |
| 52 | 365 |
| 52 | 1048 |
| 321 | 1048 |
| 321 | 365 |

## 11.Get the molecular structure of the brain region.

Three are 12 brain regions considered in the database based on respective publications, so that each gene can belong to the single or to the several brain regions. Brain regions differ between species, and specie brain region information is not 100% covered in the database(e.g. we don’t have yet studies for Human Striatum, but do have for Mouse and Rat), that’s why when querying the database for brain region information you will need to specify the specie. The full list of genes for specific region could be obtained wuth command `getAllGenes4BrainRegion`, which returns the table with main gene identifiers, like internal Gene IDs, MGI ID, Human Entrez ID, Human Gene Name, Mouse Entrez ID, Mouse Gene Name, Rat Entrez ID, Rat Gene Name.

If you need to check which genes of your list were identified in specific region, you can use `getGenes4BrainRegion` command, which will select only genes associated with specific region from your list.

To obtain the PPI network for brain region you need to submit the list of Internal GeneIDs obtained with previous commands.

```
#getting the full list of brain regions
reg <- getBrainRegions()
pander(reg)
```

| ID | Name | Description | InterlexID | ParentID |
| --- | --- | --- | --- | --- |
| 1 | Brain | Whole brain | ILX:0101431 | 1 |
| 2 | Forebrain | Whole forebrain | ILX:0104355 | 1 |
| 3 | Midbrain | Midbrain | ILX:0106935 | 1 |
| 4 | Cerebellum | Cerebellum | ILX:0101963 | 1 |
| 5 | Telencephalon | Telencephalon | ILX:0111558 | 2 |
| 6 | Hypothalamus | Hypothalamus | ILX:0105177 | 2 |
| 7 | Hippocampus | Hippocampus | ILX:0105021 | 5 |
| 8 | Striatum | Striatum | ILX:0111098 | 5 |
| 9 | Cerebral cortex | Neocortex | ILX:0101978 | 5 |
| 10 | Frontal lobe | Frontal lobe/frontal cortex | ILX:0104451 | 9 |
| 11 | Occipital lobe | Occipital lobe | ILX:0107883 | 9 |
| 12 | Temporal lobe | Temporal lobe | ILX:0111590 | 9 |
| 13 | Parietal lobe | Parietal lobe | ILX:0108534 | 9 |
| 14 | Prefrontal cortex | Prefrontal cortex | ILX:0109209 | 10 |
| 15 | Motor cortex | Motor cortex | ILX:0107119 | 10 |
| 16 | Visual cortex | Visual cortex | ILX:0112513 | 11 |
| 17 | Medial cortex | Medial cortex | ILX:0106634 | 9 |
| 18 | Caudal cortex | Caudal cortex | NA | 9 |

```
#getting all genes for mouse Striatum
gns <- getAllGenes4BrainRegion(brainRegion = "Striatum",taxID = 10090)
pander(head(gns))
```

Table continues below

| GeneID | Localisation | MGI | HumanEntrez | MouseEntrez | HumanName |
| --- | --- | --- | --- | --- | --- |
| 1 | Postsynaptic | MGI:1277959 | 1742 | 13385 | DLG4 |
| 2 | Postsynaptic | MGI:88256 | 815 | 12322 | CAMK2A |
| 3 | Postsynaptic | MGI:96568 | 9118 | 226180 | INA |
| 4 | Postsynaptic | MGI:98388 | 6711 | 20742 | SPTBN1 |
| 6 | Postsynaptic | MGI:1344351 | 1740 | 23859 | DLG2 |
| 7 | Postsynaptic | MGI:95821 | 2904 | 14812 | GRIN2B |

| MouseName | PMID | Paper | Year | SpeciesTaxID | BrainRegion |
| --- | --- | --- | --- | --- | --- |
| Dlg4 | 30071621 | ROY\_2018 | 2018 | 10090 | Striatum |
| Camk2a | 30071621 | ROY\_2018 | 2018 | 10090 | Striatum |
| Ina | 30071621 | ROY\_2018 | 2018 | 10090 | Striatum |
| Sptbn1 | 30071621 | ROY\_2018 | 2018 | 10090 | Striatum |
| Dlg2 | 30071621 | ROY\_2018 | 2018 | 10090 | Striatum |
| Grin2b | 30071621 | ROY\_2018 | 2018 | 10090 | Striatum |

```
#getting full PPI network for postsynaptic compartment
ppi <- getPPIbyIDs4BrainRegion(
    gns$GeneID, brainRegion = "Striatum",
    taxID = 10090, type = "limited")
pander(head(ppi))
```

| A | B |
| --- | --- |
| 365 | 148 |
| 1048 | 148 |
| 52 | 365 |
| 52 | 1048 |
| 321 | 1048 |
| 321 | 365 |

## 12.Checking third-party list against Synaptic Proteome db

```
#check which genes from 250 random EntrezIds are in the database
listG<-findGenesByEntrez(1:250)
dim(listG)
#> [1] 124   8
head(listG)
#> # A tibble: 6 × 8
#>   GeneID MGI       HumanEntrez MouseEntrez RatEntrez HumanName MouseName RatName
#>    <int> <chr>           <int>       <int>     <int> <chr>     <chr>     <chr>
#> 1     34 MGI:87994         226       11674     24189 ALDOA     Aldoa     Aldoa
#> 2     35 MGI:2137…          87      109711     81634 ACTN1     Actn1     Actn1
#> 3     39 MGI:1019…         160       11771    308578 AP2A1     Ap2a1     Ap2a1
#> 4     54 MGI:87918         118       11518     24170 ADD1      Add1      Add1
#> 5     85 MGI:87919         119       11519     24171 ADD2      Add2      Add2
#> 6     97 MGI:1890…          81       60595     63836 ACTN4     Actn4     Actn4

#check which genes from subset identified as synaptic are presynaptic
getCompartments()
#> # A tibble: 4 × 3
#>      ID Name             Description
#>   <int> <chr>            <chr>
#> 1     1 Postsynaptic     Postsynaptic
#> 2     2 Presynaptic      Presynaptic
#> 3     3 Synaptosome      Synaptosome
#> 4     4 Synaptic_Vesicle Synaptic_Vesicle
presG <- getGenes4Compartment(listG$GeneID, 2)
dim(presG)
#> [1] 67  8
head(presG)
#> # A tibble: 6 × 8
#>   GeneID MGI       HumanEntrez MouseEntrez RatEntrez HumanName MouseName RatName
#>    <int> <chr>           <int>       <int>     <int> <chr>     <chr>     <chr>
#> 1     34 MGI:87994         226       11674     24189 ALDOA     Aldoa     Aldoa
#> 2     35 MGI:2137…          87      109711     81634 ACTN1     Actn1     Actn1
#> 3     39 MGI:1019…         160       11771    308578 AP2A1     Ap2a1     Ap2a1
#> 4     54 MGI:87918         118       11518     24170 ADD1      Add1      Add1
#> 5     85 MGI:87919         119       11519     24171 ADD2      Add2      Add2
#> 6     97 MGI:1890…          81       60595     63836 ACTN4     Actn4     Actn4

#check which genes from subset identified as synaptic are found in
#human cerebellum
getBrainRegions()
#> # A tibble: 18 × 5
#>       ID Name              Description                 InterlexID  ParentID
#>    <int> <chr>             <chr>                       <chr>          <int>
#>  1     1 Brain             Whole brain                 ILX:0101431        1
#>  2     2 Forebrain         Whole forebrain             ILX:0104355        1
#>  3     3 Midbrain          Midbrain                    ILX:0106935        1
#>  4     4 Cerebellum        Cerebellum                  ILX:0101963        1
#>  5     5 Telencephalon     Telencephalon               ILX:0111558        2
#>  6     6 Hypothalamus      Hypothalamus                ILX:0105177        2
#>  7     7 Hippocampus       Hippocampus                 ILX:0105021        5
#>  8     8 Striatum          Striatum                    ILX:0111098        5
#>  9     9 Cerebral cortex   Neocortex                   ILX:0101978        5
#> 10    10 Frontal lobe      Frontal lobe/frontal cortex ILX:0104451        9
#> 11    11 Occipital lobe    Occipital lobe              ILX:0107883        9
#> 12    12 Temporal lobe     Temporal lobe               ILX:0111590        9
#> 13    13 Parietal lobe     Parietal lobe               ILX:0108534        9
#> 14    14 Prefrontal cortex Prefrontal cortex           ILX:0109209       10
#> 15    15 Motor cortex      Motor cortex                ILX:0107119       10
#> 16    16 Visual cortex     Visual cortex               ILX:0112513       11
#> 17    17 Medial cortex     Medial cortex               ILX:0106634        9
#> 18    18 Caudal cortex     Caudal cortex               <NA>               9
listR <- getGenes4BrainRegion(listG$GeneID,
                              brainRegion = "Cerebellum", taxID = 10090)
dim(listR)
#> [1] 186  12
head(listR)
#> # A tibble: 6 × 12
#>   GeneID Localisation MGI     HumanEntrez MouseEntrez HumanName MouseName   PMID
#>    <int> <chr>        <chr>         <int>       <int> <chr>     <chr>      <int>
#> 1     34 Postsynaptic MGI:87…         226       11674 ALDOA     Aldoa     1.81e7
#> 2     34 Postsynaptic MGI:87…         226       11674 ALDOA     Aldoa     3.01e7
#> 3     34 Synaptosome  MGI:87…         226       11674 ALDOA     Aldoa     3.20e7
#> 4     34 Synaptosome  MGI:87…         226       11674 ALDOA     Aldoa     3.21e7
#> 5     35 Postsynaptic MGI:21…          87      109711 ACTN1     Actn1     1.81e7
#> 6     35 Postsynaptic MGI:21…          87      109711 ACTN1     Actn1     3.01e7
#> # ℹ 4 more variables: Paper <chr>, Year <int>, SpeciesTaxID <int>,
#> #   BrainRegion <chr>
```

## 13.Visualisatiion of PPI network with Igraph.

Combine information from PPI data.frame obtained with functions like `getPPIbyName`, `getPPIbyEntrez`, `getPPIbyIDs4Compartment` or `getPPIbyIDs4BrainRegion` with information about genes obtained from `getGenesByID` to make interpretable undirected PPI graph in igraph format. In this format network could be further analysed and visualized by algorithms from igraph package.

```
library(igraph)
#>
#> Attaching package: 'igraph'
#> The following objects are masked from 'package:dplyr':
#>
#>     as_data_frame, groups, union
#> The following objects are masked from 'package:BiocGenerics':
#>
#>     normalize, path, union
#> The following objects are masked from 'package:generics':
#>
#>     components, union
#> The following objects are masked from 'package:stats':
#>
#>     decompose, spectrum
#> The following object is masked from 'package:base':
#>
#>     union
g<-getIGraphFromPPI(
    getPPIbyIDs(c(48, 129,  975,  4422, 5715, 5835), type='lim'))
plot(g,vertex.label=V(g)$RatName,vertex.size=25)
```

![](data:image/png;base64...)

## 1.Export of PPI network as a table.

If Igraph is not an option, the PPI network could be exported as an interpretible table to be processed with other tools, e.g. Cytoscape,etc.

```
tbl<-getTableFromPPI(getPPIbyIDs(c(48, 585, 710), type='limited'))
tbl
#> # A tibble: 2 × 16
#>       A     B MGI.A     HumanEntrez.A MouseEntrez.A RatEntrez.A HumanName.A
#>   <int> <int> <chr>             <int>         <int>       <int> <chr>
#> 1   710   710 MGI:95602          2534         14360       25150 FYN
#> 2   585   585 MGI:98397          6714         20779       83805 SRC
#> # ℹ 9 more variables: MouseName.A <chr>, RatName.A <chr>, MGI.B <chr>,
#> #   HumanEntrez.B <int>, MouseEntrez.B <int>, RatEntrez.B <int>,
#> #   HumanName.B <chr>, MouseName.B <chr>, RatName.B <chr>
```

# References

1. Sorokina, O., Mclean, C., Croning, M.D.R. et al.
   *A unified resource and configurable model of the synapse proteome and its role in disease*. Sci Rep 11, 9967 (2021). <https://doi.org/10.1038/s41598-021-88945-7>.

# Appendix

## Statistics graph code

```
gp<-findGeneByCompartmentPaperCnt(1)

# presynaptic stats
presgp <- gp[gp$Localisation == "Presynaptic",]
syngp <- gp[gp$Localisation == "Synaptosome",]
presg <- getGeneInfoByIDs(presgp$GeneID)
mpres <- merge(presgp, presg, by = c("GeneID","Localisation"))
mmpres <- mpres[, c('GeneID',
                    'HumanEntrez.x',
                    'HumanName.x',
                    'Npmid',
                    'PaperPMID',
                    'Paper',
                    'Year')]
papers <- getPapers()
prespap <- papers[papers$Localisation == "Presynaptic",]
mmmpres <- mmpres[mmpres$PaperPMID %in% prespap$PaperPMID,]
mmmpres$found <- 0
for(i in 1:dim(mmmpres)[1]) {
    if (mmmpres$Npmid[i] == 1) {
        mmmpres$found[i] <- '1'
    } else if (mmmpres$Npmid[i] > 1 & mmmpres$Npmid[i] < 4) {
        mmmpres$found[i] <- '2-3'
    } else if (mmmpres$Npmid[i] >= 4 & mmmpres$Npmid[i] < 10) {
        mmmpres$found[i] <- '4-9'
    } else if (mmmpres$Npmid[i] >= 10) {
        mmmpres$found[i] <- '>10'
    }
}

mmmpres$found<- factor(mmmpres$found,
                        levels = c('1','2-3','4-9','>10'),
                        ordered=TRUE)
tp<-unique(mmmpres$Paper)
mmmpres$Paper<- factor(mmmpres$Paper,
                        levels =tp[order(as.numeric(sub('^[^0-9]+_([0-9]+)',
                                                        '\\1',tp)))],
                        ordered=TRUE)

ummpres<-unique(mmmpres[,c('GeneID','Paper','found')])
ggplot(ummpres) + geom_bar(aes(y = Paper, fill = found))
```

```
#postsynaptic stats
pstgp <- gp[gp$Localisation == "Postsynaptic",]
postg <- getGeneInfoByIDs(pstgp$GeneID)
mpost <- merge(pstgp, postg, by = c("GeneID","Localisation"))
mmpost <- mpost[, c('GeneID',
                    'HumanEntrez.x',
                    'HumanName.x','Npmid',
                    'PaperPMID','Paper','Year')]
postspap <- papers[papers$Localisation == "Postsynaptic",]
mmmpost <- mmpost[mmpost$PaperPMID %in% postspap$PaperPMID,]
mmmpost$found <- 0
for(i in 1:dim(mmmpost)[1]) {
    if (mmmpost$Npmid[i] == 1) {
        mmmpost$found[i] <- '1'
    } else if (mmmpost$Npmid[i] > 1 & mmmpost$Npmid[i] < 4) {
        mmmpost$found[i] <- '2-3'
    } else if (mmmpost$Npmid[i] >= 4 & mmmpost$Npmid[i] < 10) {
        mmmpost$found[i] <- '4-9'
    } else if (mmmpost$Npmid[i] >= 10) {
        mmmpost$found[i] <- '>10'
    }
}
mmmpost$found<- factor(mmmpost$found,levels = c('1','2-3','4-9','>10'),
                        ordered=TRUE)
tp<-unique(mmmpost$Paper)
mmmpost$Paper<- factor(mmmpost$Paper,
                        levels =tp[order(as.numeric(sub('^[^0-9]+_([0-9]+)',
                                                        '\\1',tp)))],
                        ordered=TRUE)
ummpos<-unique(mmmpost[,c('GeneID','Paper','found')])
ggplot(ummpos) + geom_bar(aes(y = Paper, fill = found))
```

```
svgp <- gp[gp$Localisation == "Synaptic_Vesicle",]
svg <- getGeneInfoByIDs(svgp$GeneID)
mpost <- merge(svgp, svg, by = c("GeneID","Localisation"))
mpost$Paper<-paste0(mpost$Paper,ifelse('FULL'==mpost$Dataset,'','_SVR'))
mmpost <- mpost[, c('GeneID','HumanEntrez.x','HumanName.x','Npmid',
                    'PaperPMID','Paper','Year')]
postspap <- papers[papers$Localisation == "Synaptic_Vesicle",]
mmmpost <- mmpost[mmpost$PaperPMID %in% postspap$PaperPMID,]
mmmpost$found <- 0
for(i in 1:dim(mmmpost)[1]) {
    if (mmmpost$Npmid[i] == 1) {
        mmmpost$found[i] <- '1'
    } else if (mmmpost$Npmid[i] > 1 & mmmpost$Npmid[i] < 4) {
        mmmpost$found[i] <- '2-3'
    } else if (mmmpost$Npmid[i] >= 4 & mmmpost$Npmid[i] < 6) {
        mmmpost$found[i] <- '4-5'
    } else if (mmmpost$Npmid[i] >= 6) {
        mmmpost$found[i] <- '>6'
    }
}

mmmpost$found<- factor(mmmpost$found,levels = c('1','2-3','4-5','>6'),
                        ordered=TRUE)
tp<-unique(mmmpost$Paper)
mmmpost$Paper<- factor(mmmpost$Paper,
                        levels =tp[order(as.numeric(sub('^[^0-9]+_([0-9]+)_?.*',
                                                        '\\1',tp)))],
                        ordered=TRUE)

ummpos<-unique(mmmpost[,c('GeneID','Paper','found')])
g<-ggplot(ummpos) + geom_bar(aes(y = Paper, fill = found))
g
```

```
#brain region statistics
totg <- getGeneInfoByIDs(gp$GeneID)
mtot <- merge(gp, totg, by = c("GeneID","Localisation"))
mmptot <- mtot[, c('GeneID',
                    'HumanEntrez.x',
                    'HumanName.x',
                    'Localisation',
                    'Npmid',
                    'Paper',
                    'BrainRegion')]
untot<-unique(mmptot[,c('GeneID','BrainRegion','Localisation')])
loccolors<-c("#3D5B59","#B5E5CF","#FCB5AC", "#B99095")
loccolors<-loccolors[1:length(unique(untot$Localisation))]
ggplot(untot) + geom_bar(aes(y = BrainRegion, fill = Localisation)) +
    scale_fill_manual(values = loccolors)
```

```
table(untot$Localisation,untot$BrainRegion)-> m
as.data.frame(m)->udf
names(udf)<-c('Localisation','BrainRegion','value')
ggplot(udf, aes(fill=Localisation, y=value, x=BrainRegion)) +
    geom_bar(position="dodge", stat="identity")+
    scale_fill_manual(values = loccolors) +
    theme(axis.text.x = element_text(face="plain",
                                        color="#993333",
                                        angle=45,vjust = 1,
                                        hjust=1,size = rel(1.5)))
```

### Session Info

|  |  |
| --- | --- |
| **version** | R version 4.5.1 (2025-06-13) |
| **os** | Ubuntu 24.04.3 LTS |
| **system** | x86\_64, linux-gnu |
| **ui** | X11 |
| **language** | (EN) |
| **collate** | C |
| **ctype** | en\_US.UTF-8 |
| **tz** | America/New\_York |
| **date** | 2025-08-27 |
| **pandoc** | 2.7.3 @ /usr/bin/ (via rmarkdown) |
| **quarto** | 1.7.32 @ /usr/local/bin/quarto |

Table continues below

|  | package | ondiskversion | loadedversion | attached |
| --- | --- | --- | --- | --- |
| **AnnotationDbi** | AnnotationDbi | 1.71.1 | 1.71.1 | FALSE |
| **AnnotationHub** | AnnotationHub | 3.99.6 | 3.99.6 | TRUE |
| **Biobase** | Biobase | 2.69.0 | 2.69.0 | FALSE |
| **BiocFileCache** | BiocFileCache | 2.99.6 | 2.99.6 | TRUE |
| **BiocGenerics** | BiocGenerics | 0.55.1 | 0.55.1 | TRUE |
| **BiocManager** | BiocManager | 1.30.26 | 1.30.26 | FALSE |
| **BiocVersion** | BiocVersion | 3.22.0 | 3.22.0 | FALSE |
| **Biostrings** | Biostrings | 2.77.2 | 2.77.2 | FALSE |
| **bit** | bit | 4.6.0 | 4.6.0 | FALSE |
| **bit64** | bit64 | 4.6.0.1 | 4.6.0-1 | FALSE |
| **blob** | blob | 1.2.4 | 1.2.4 | FALSE |
| **bslib** | bslib | 0.9.0 | 0.9.0 | FALSE |
| **cachem** | cachem | 1.1.0 | 1.1.0 | FALSE |
| **cli** | cli | 3.6.5 | 3.6.5 | FALSE |
| **crayon** | crayon | 1.5.3 | 1.5.3 | FALSE |
| **curl** | curl | 7.0.0 | 7.0.0 | FALSE |
| **DBI** | DBI | 1.2.3 | 1.2.3 | FALSE |
| **dbplyr** | dbplyr | 2.5.0 | 2.5.0 | TRUE |
| **devtools** | devtools | 2.4.5 | 2.4.5 | FALSE |
| **dichromat** | dichromat | 2.0.0.1 | 2.0-0.1 | FALSE |
| **digest** | digest | 0.6.37 | 0.6.37 | FALSE |
| **dplyr** | dplyr | 1.1.4 | 1.1.4 | TRUE |
| **ellipsis** | ellipsis | 0.3.2 | 0.3.2 | FALSE |
| **evaluate** | evaluate | 1.0.4 | 1.0.4 | FALSE |
| **farver** | farver | 2.1.2 | 2.1.2 | FALSE |
| **fastmap** | fastmap | 1.2.0 | 1.2.0 | FALSE |
| **filelock** | filelock | 1.0.3 | 1.0.3 | FALSE |
| **fs** | fs | 1.6.6 | 1.6.6 | FALSE |
| **generics** | generics | 0.1.4 | 0.1.4 | TRUE |
| **ggplot2** | ggplot2 | 3.5.2 | 3.5.2 | TRUE |
| **glue** | glue | 1.8.0 | 1.8.0 | FALSE |
| **gtable** | gtable | 0.3.6 | 0.3.6 | FALSE |
| **htmltools** | htmltools | 0.5.8.1 | 0.5.8.1 | FALSE |
| **htmlwidgets** | htmlwidgets | 1.6.4 | 1.6.4 | FALSE |
| **httpuv** | httpuv | 1.6.16 | 1.6.16 | FALSE |
| **httr** | httr | 1.4.7 | 1.4.7 | FALSE |
| **httr2** | httr2 | 1.2.1 | 1.2.1 | FALSE |
| **igraph** | igraph | 2.1.4 | 2.1.4 | TRUE |
| **IRanges** | IRanges | 2.43.0 | 2.43.0 | FALSE |
| **jquerylib** | jquerylib | 0.1.4 | 0.1.4 | FALSE |
| **jsonlite** | jsonlite | 2.0.0 | 2.0.0 | FALSE |
| **KEGGREST** | KEGGREST | 1.49.1 | 1.49.1 | FALSE |
| **knitr** | knitr | 1.50 | 1.50 | FALSE |
| **labeling** | labeling | 0.4.3 | 0.4.3 | FALSE |
| **later** | later | 1.4.3 | 1.4.3 | FALSE |
| **lifecycle** | lifecycle | 1.0.4 | 1.0.4 | FALSE |
| **magrittr** | magrittr | 2.0.3 | 2.0.3 | FALSE |
| **memoise** | memoise | 2.0.1 | 2.0.1 | FALSE |
| **mime** | mime | 0.13 | 0.13 | FALSE |
| **miniUI** | miniUI | 0.1.2 | 0.1.2 | FALSE |
| **pander** | pander | 0.6.6 | 0.6.6 | TRUE |
| **pillar** | pillar | 1.11.0 | 1.11.0 | FALSE |
| **pkgbuild** | pkgbuild | 1.4.8 | 1.4.8 | FALSE |
| **pkgconfig** | pkgconfig | 2.0.3 | 2.0.3 | FALSE |
| **pkgload** | pkgload | 1.4.0 | 1.4.0 | FALSE |
| **png** | png | 0.1.8 | 0.1-8 | FALSE |
| **profvis** | profvis | 0.4.0 | 0.4.0 | FALSE |
| **promises** | promises | 1.3.3 | 1.3.3 | FALSE |
| **purrr** | purrr | 1.1.0 | 1.1.0 | FALSE |
| **R6** | R6 | 2.6.1 | 2.6.1 | FALSE |
| **rappdirs** | rappdirs | 0.3.3 | 0.3.3 | FALSE |
| **rbibutils** | rbibutils | 2.3 | 2.3 | FALSE |
| **RColorBrewer** | RColorBrewer | 1.1.3 | 1.1-3 | FALSE |
| **Rcpp** | Rcpp | 1.1.0 | 1.1.0 | FALSE |
| **Rdpack** | Rdpack | 2.6.4 | 2.6.4 | FALSE |
| **remotes** | remotes | 2.5.0 | 2.5.0 | FALSE |
| **rlang** | rlang | 1.1.6 | 1.1.6 | FALSE |
| **rmarkdown** | rmarkdown | 2.29 | 2.29 | FALSE |
| **RSQLite** | RSQLite | 2.4.3 | 2.4.3 | FALSE |
| **S4Vectors** | S4Vectors | 0.47.0 | 0.47.0 | FALSE |
| **sass** | sass | 0.4.10 | 0.4.10 | FALSE |
| **scales** | scales | 1.4.0 | 1.4.0 | FALSE |
| **Seqinfo** | Seqinfo | 0.99.2 | 0.99.2 | FALSE |
| **sessioninfo** | sessioninfo | 1.2.3 | 1.2.3 | FALSE |
| **shiny** | shiny | 1.11.1 | 1.11.1 | FALSE |
| **synaptome.data** | synaptome.data | 0.99.6 | 0.99.6 | TRUE |
| **synaptome.db** | synaptome.db | 0.99.17 | 0.99.17 | TRUE |
| **tibble** | tibble | 3.3.0 | 3.3.0 | FALSE |
| **tidyselect** | tidyselect | 1.2.1 | 1.2.1 | FALSE |
| **urlchecker** | urlchecker | 1.0.1 | 1.0.1 | FALSE |
| **usethis** | usethis | 3.1.0 | 3.1.0 | FALSE |
| **utf8** | utf8 | 1.2.6 | 1.2.6 | FALSE |
| **vctrs** | vctrs | 0.6.5 | 0.6.5 | FALSE |
| **viridisLite** | viridisLite | 0.4.2 | 0.4.2 | FALSE |
| **withr** | withr | 3.0.2 | 3.0.2 | FALSE |
| **xfun** | xfun | 0.53 | 0.53 | FALSE |
| **xtable** | xtable | 1.8.4 | 1.8-4 | FALSE |
| **XVector** | XVector | 0.49.0 | 0.49.0 | FALSE |
| **yaml** | yaml | 2.3.10 | 2.3.10 | FALSE |

|  | is\_base | date | source |
| --- | --- | --- | --- |
| **AnnotationDbi** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **AnnotationHub** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **Biobase** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **BiocFileCache** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **BiocGenerics** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **BiocManager** | FALSE | 2025-06-05 | CRAN (R 4.5.1) |
| **BiocVersion** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **Biostrings** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **bit** | FALSE | 2025-03-06 | CRAN (R 4.5.1) |
| **bit64** | FALSE | 2025-01-16 | CRAN (R 4.5.1) |
| **blob** | FALSE | 2023-03-17 | CRAN (R 4.5.1) |
| **bslib** | FALSE | 2025-01-30 | CRAN (R 4.5.1) |
| **cachem** | FALSE | 2024-05-16 | CRAN (R 4.5.1) |
| **cli** | FALSE | 2025-04-23 | CRAN (R 4.5.1) |
| **crayon** | FALSE | 2024-06-20 | CRAN (R 4.5.1) |
| **curl** | FALSE | 2025-08-19 | CRAN (R 4.5.1) |
| **DBI** | FALSE | 2024-06-02 | CRAN (R 4.5.1) |
| **dbplyr** | FALSE | 2024-03-19 | CRAN (R 4.5.1) |
| **devtools** | FALSE | 2022-10-11 | CRAN (R 4.5.1) |
| **dichromat** | FALSE | 2022-05-02 | CRAN (R 4.5.1) |
| **digest** | FALSE | 2024-08-19 | CRAN (R 4.5.1) |
| **dplyr** | FALSE | 2023-11-17 | CRAN (R 4.5.1) |
| **ellipsis** | FALSE | 2021-04-29 | CRAN (R 4.5.1) |
| **evaluate** | FALSE | 2025-06-18 | CRAN (R 4.5.1) |
| **farver** | FALSE | 2024-05-13 | CRAN (R 4.5.1) |
| **fastmap** | FALSE | 2024-05-15 | CRAN (R 4.5.1) |
| **filelock** | FALSE | 2023-12-11 | CRAN (R 4.5.1) |
| **fs** | FALSE | 2025-04-12 | CRAN (R 4.5.1) |
| **generics** | FALSE | 2025-05-09 | CRAN (R 4.5.1) |
| **ggplot2** | FALSE | 2025-04-09 | CRAN (R 4.5.1) |
| **glue** | FALSE | 2024-09-30 | CRAN (R 4.5.1) |
| **gtable** | FALSE | 2024-10-25 | CRAN (R 4.5.1) |
| **htmltools** | FALSE | 2024-04-04 | CRAN (R 4.5.1) |
| **htmlwidgets** | FALSE | 2023-12-06 | CRAN (R 4.5.1) |
| **httpuv** | FALSE | 2025-04-16 | CRAN (R 4.5.1) |
| **httr** | FALSE | 2023-08-15 | CRAN (R 4.5.1) |
| **httr2** | FALSE | 2025-07-22 | CRAN (R 4.5.1) |
| **igraph** | FALSE | 2025-01-23 | CRAN (R 4.5.1) |
| **IRanges** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **jquerylib** | FALSE | 2021-04-26 | CRAN (R 4.5.1) |
| **jsonlite** | FALSE | 2025-03-27 | CRAN (R 4.5.1) |
| **KEGGREST** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **knitr** | FALSE | 2025-03-16 | CRAN (R 4.5.1) |
| **labeling** | FALSE | 2023-08-29 | CRAN (R 4.5.1) |
| **later** | FALSE | 2025-08-20 | CRAN (R 4.5.1) |
| **lifecycle** | FALSE | 2023-11-07 | CRAN (R 4.5.1) |
| **magrittr** | FALSE | 2022-03-30 | CRAN (R 4.5.1) |
| **memoise** | FALSE | 2021-11-26 | CRAN (R 4.5.1) |
| **mime** | FALSE | 2025-03-17 | CRAN (R 4.5.1) |
| **miniUI** | FALSE | 2025-04-17 | CRAN (R 4.5.1) |
| **pander** | FALSE | 2025-03-01 | CRAN (R 4.5.1) |
| **pillar** | FALSE | 2025-07-04 | CRAN (R 4.5.1) |
| **pkgbuild** | FALSE | 2025-05-26 | CRAN (R 4.5.1) |
| **pkgconfig** | FALSE | 2019-09-22 | CRAN (R 4.5.1) |
| **pkgload** | FALSE | 2024-06-28 | CRAN (R 4.5.1) |
| **png** | FALSE | 2022-11-29 | CRAN (R 4.5.1) |
| **profvis** | FALSE | 2024-09-20 | CRAN (R 4.5.1) |
| **promises** | FALSE | 2025-05-29 | CRAN (R 4.5.1) |
| **purrr** | FALSE | 2025-07-10 | CRAN (R 4.5.1) |
| **R6** | FALSE | 2025-02-15 | CRAN (R 4.5.1) |
| **rappdirs** | FALSE | 2021-01-31 | CRAN (R 4.5.1) |
| **rbibutils** | FALSE | 2024-10-04 | CRAN (R 4.5.1) |
| **RColorBrewer** | FALSE | 2022-04-03 | CRAN (R 4.5.1) |
| **Rcpp** | FALSE | 2025-07-02 | CRAN (R 4.5.1) |
| **Rdpack** | FALSE | 2025-04-09 | CRAN (R 4.5.1) |
| **remotes** | FALSE | 2024-03-17 | CRAN (R 4.5.1) |
| **rlang** | FALSE | 2025-04-11 | CRAN (R 4.5.1) |
| **rmarkdown** | FALSE | 2024-11-04 | CRAN (R 4.5.1) |
| **RSQLite** | FALSE | 2025-08-20 | CRAN (R 4.5.1) |
| **S4Vectors** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **sass** | FALSE | 2025-04-11 | CRAN (R 4.5.1) |
| **scales** | FALSE | 2025-04-24 | CRAN (R 4.5.1) |
| **Seqinfo** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **sessioninfo** | FALSE | 2025-02-05 | CRAN (R 4.5.1) |
| **shiny** | FALSE | 2025-07-03 | CRAN (R 4.5.1) |
| **synaptome.data** | FALSE | 2025-08-27 | Bioconductor 3.22 (R 4.5.1) |
| **synaptome.db** | FALSE | 2025-08-27 | Bioconductor 3.22 (R 4.5.1) |
| **tibble** | FALSE | 2025-06-08 | CRAN (R 4.5.1) |
| **tidyselect** | FALSE | 2024-03-11 | CRAN (R 4.5.1) |
| **urlchecker** | FALSE | 2021-11-30 | CRAN (R 4.5.1) |
| **usethis** | FALSE | 2024-11-26 | CRAN (R 4.5.1) |
| **utf8** | FALSE | 2025-06-08 | CRAN (R 4.5.1) |
| **vctrs** | FALSE | 2023-12-01 | CRAN (R 4.5.1) |
| **viridisLite** | FALSE | 2023-05-02 | CRAN (R 4.5.1) |
| **withr** | FALSE | 2024-10-28 | CRAN (R 4.5.1) |
| **xfun** | FALSE | 2025-08-19 | CRAN (R 4.5.1) |
| **xtable** | FALSE | 2019-04-21 | CRAN (R 4.5.1) |
| **XVector** | FALSE | 2025-08-26 | Bioconductor 3.22 (R 4.5.1) |
| **yaml** | FALSE | 2024-07-26 | CRAN (R 4.5.1) |