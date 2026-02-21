# Loading data

Luca De Sano, Daniele Ramazzotti, Giulio Caravagna, Alex Graudenxi and Marco Antoniotti

#### October 30, 2025

#### Package

TRONCO 2.42.0

## 0.1 Preliminaries

```
library(TRONCO)
data(aCML)
data(crc_maf)
data(crc_gistic)
data(crc_plain)
```

TRONCO transforms input data in a sort of database-alike format, where three main fields are presente: *genotypes* which contains the genomic signatures of the input samples, *annotations* which provides an index to the events present in the data and *types*, a field mapping type of events (e.g., mutations, CNAs, etc.) to colors for display visualization. Other annotations are generated when a dataset is augmented with some metadata. A TRONCO object shall be edited by using TRONCO functions, to avoid to create inconsistencies in its internal representation. Function `is.compliant` can be used to test if a TRONCO object is consistent; the function is called by any TRONCO function before returning a modified object, so to ensure that consistency is preserved – `is.compliant` will raise an error if this is not the case.

TRONCO supports the import of data from 3 formats. The Mutation Annotation Format (*MAF*) is a tab-delimited file containing somatic and/or germline mutation annotations; the *GISTIC* format for copy number alterations as defined by TCGA and a custom boolean matrix format where the user can directly specify the mutational profiles to be importend. Through some data included in the package we will show how to load your datasets in TRONCO.

* **aCML** a TRONCO object that represents the *atypical Chronic Myeloid Leukemia* dataset by Piazza *et al.* (Nat. Gen. 2013 45(1):18-24).
* **crc\_maf** a shortened version of the *colorectal cancer mutation data* made available by the TCGA consortium within the COADREAD. See [this link](https://tcga-data.nci.nih.gov/docs/publications/coadread_2012/) and our PicNiC case study for the real analysis of such data.
* **crc\_gistic** from the same TCGA project, we also provide a shortened version of the focal CNAs in the GISTIC format where 1 represents a low level gain, 2 a high level gain, -1 a heterozygous loss of a gene and -2 its homozygous loss.
* **crc\_plain** a custom boolean matrix where rows are samples, and columns represent events – in this case alterations in a certain gene. Notice with this format one could also custom types of alterations, for instance wider chromosomal aberrations or, in principle, epigenetic states (over-expression, methylated regions, etc.) that are persistent across tumor evolution.

Whatever is dataset created as explained in the next sections, it can be annotated by adding a mnemonic description of the data, which will be used as plot titles when possible.
Function `annotate.description` raises a warning if the dataset was previously annotated.

```
aCML = annotate.description(aCML, 'aCML data (Bioinf.)')
```

## 0.2 Mutations annotated in a MAF format

We use the function `import.MAF` to import a dataset in MAF format, in this case the following TCGA dataset

```
head(crc_maf[, 1:10])
```

```
##      Hugo_Symbol Entrez_Gene_Id       Center NCBI_Build Chromosome
## 27          TP53           7157 hgsc.bcm.edu         36         17
## 246        FBXW7          55294 hgsc.bcm.edu         36          4
## 623          APC            324 hgsc.bcm.edu         36          5
## 649         TP53           7157 hgsc.bcm.edu         36         17
## 928        FBXW7          55294 hgsc.bcm.edu         36          4
## 1390        TP53           7157 hgsc.bcm.edu         36         17
##      Start_position End_position Strand Variant_Classification Variant_Type
## 27          7519131      7519131      +      Missense_Mutation          SNP
## 246       153466817    153466817      +      Nonsense_Mutation          SNP
## 623       112192485    112192485      +      Nonsense_Mutation          SNP
## 649         7518937      7518937      +      Nonsense_Mutation          SNP
## 928       153468834    153468834      +      Missense_Mutation          SNP
## 1390        7517864      7517864      +      Missense_Mutation          SNP
```

A default importation is done without adding parameters to `import.MAF`. In this case, all mutations per gene will be considered equivalent, regardless of the type that is annotated in the MAF. Also, all genes will be imported, and all samples.

```
dataset_maf = import.MAF(crc_maf)
```

```
## *** Importing from dataframe
## Loading MAF dataframe ...DONE
## *** Mutations names: using Hugo_Symbol
## *** Using full MAF: #entries  17
## *** MAF report: TCGA=TRUE
## Type of annotated mutations:
## [1] "Missense_Mutation" "Nonsense_Mutation"
## *** [merge.mutation.types = T] Mutations will be merged and annotated as 'Mutation'
## Number of samples: 9
## [TCGA = TRUE] Number of TCGA patients: 9
## Number of annotated mutations: 17
## Mutations annotated with "Valid" flag (%): 71
## Number of genes (Hugo_Symbol): 6
## Starting conversion from MAF to 0/1 mutation profiles (1 = mutation) :9 x 6
## .................
## Starting conversion from MAF to TRONCO data type.
```

In the above case – where we see that mutations are annotated as `Missense_Mutation` or `Nonsense_Mutation`, if a gene in a sample has both, these will be merged to a unique `Mutation` type. In this case a pair gene name with `Mutation` will be what we call an *event* in our dataset – e.g., APC Mutation.
If one would like to have two distinct events in the dataset, i.e., APC `Missense_Mutation` and APC `Nonsense_Mutation`, parameter `merge.mutation.types` should be set to false in the call to `import.MAF`.

```
dataset_maf = import.MAF(crc_maf, merge.mutation.types = FALSE)
```

```
## *** Importing from dataframe
## Loading MAF dataframe ...DONE
## *** Mutations names: using Hugo_Symbol
## *** Using full MAF: #entries  17
## *** MAF report: TCGA=TRUE
## Type of annotated mutations:
## [1] "Missense_Mutation" "Nonsense_Mutation"
## *** [merge.mutation.types = F] Mutations will be distinguished by type
## Number of samples: 9
## [TCGA = TRUE] Number of TCGA patients: 9
## Number of annotated mutations: 17
## Mutations annotated with "Valid" flag (%): 71
## Number of genes (Hugo_Symbol): 6
## Starting conversion from MAF to 0/1 mutation profiles (1 = mutation) :
## .................
```

Sometimes, we might want to filter out some of the entries in a MAF – maybe restricting the type of genes, mutations or sample that we want to process. If one defines
`filter.fun` as a function that returns `TRUE` only for those entries which shall be considered, he gets a filter process which is applied to each row of the MAF file prior to transforming that into a TRONCO dataset. In this example we select only mutations annotated to APC – we access that through the *Hugo\_Symbol* flag of a MAF.

```
dataset_maf = import.MAF(crc_maf, filter.fun = function(x){ x['Hugo_Symbol'] == 'APC'} )
```

```
## *** Importing from dataframe
## Loading MAF dataframe ...DONE
## *** Mutations names: using Hugo_Symbol
## *** Filtering full MAF: #entries  17
## *** Using reduced MAF: #entries  3
## *** MAF report: TCGA=TRUE
## Type of annotated mutations:
## [1] "Nonsense_Mutation"
## *** [merge.mutation.types = T] Mutations will be merged and annotated as 'Mutation'
## Number of samples: 3
## [TCGA = TRUE] Number of TCGA patients: 3
## Number of annotated mutations: 3
## Mutations annotated with "Valid" flag (%): 33
## Number of genes (Hugo_Symbol): 1
## Starting conversion from MAF to 0/1 mutation profiles (1 = mutation) :3 x 1
## ...
## Starting conversion from MAF to TRONCO data type.
```

It is also sometimes convenient – especially when working with data collected from a single individual patient – to distinguish the type of mutations and their position in a gene, or if they are somehow annotated to COSMIC or other databases. For instance, we might want to want to use the `MA.protein.change` annotation in the MAF file to get composite names such as TP53.R175H, TP53.R213, TP53.R267W etc. This can be done by setting {paste.to.Hugo\_Symbol} to have the relevant name of the MAF annotation

```
dataset_maf = import.MAF(crc_maf,
    merge.mutation.types = FALSE,
    paste.to.Hugo_Symbol = c('MA.protein.change'))
```

```
## *** Importing from dataframe
## Loading MAF dataframe ...DONE
## *** Mutations names: augmenting Hugo_Symbol with values:  MA.protein.change
## *** Using full MAF: #entries  17
## *** MAF report: TCGA=TRUE
## Type of annotated mutations:
## [1] "Missense_Mutation" "Nonsense_Mutation"
## *** [merge.mutation.types = F] Mutations will be distinguished by type
## Number of samples: 9
## [TCGA = TRUE] Number of TCGA patients: 9
## Number of annotated mutations: 17
## Mutations annotated with "Valid" flag (%): 71
## Number of genes (Hugo_Symbol): 16
## Starting conversion from MAF to 0/1 mutation profiles (1 = mutation) :
## .................
```

TRONCO supports custom MAF files, where possibly not all the standard annotations are present, via `irregular = TRUE`.

## 0.3 Copy Number Variants annotated in the GISTIC format

We use the function `import.GISTIC` to import a dataset in GISTIC format, in this case from

```
crc_gistic
```

```
##              NRAS CTNNB1 FBXW7 APC KRAS TP53
## TCGA-A6-2670   -1      0     0  -1    1   -1
## TCGA-A6-2672    0      0     0   0    0    0
## TCGA-A6-2674    0      0     0   0    0    0
## TCGA-A6-2676    0      0     0   0    0    0
## TCGA-A6-2677    0      0     0   0    0   -1
## TCGA-A6-2678    0      0     0   0    0   -1
## TCGA-A6-2683   -1     -1    -1  -1    0   -1
## TCGA-A6-3807    0     -1     0   0   -1   -1
## TCGA-AA-3516    0      0     0   0    0    0
```

In its default execution all the data annotated in the file is imported. But in principle it is possible to avoid to import some genes or samples; in this case it is sufficient to use parameters `filter.genes` and `filter.samples` for this function.

```
dataset_gistic = import.GISTIC(crc_gistic)
```

```
## *** Using full GISTIC: #dim  9  x  6
## *** GISTIC input format conversion started.
## Converting input data to character for import speedup.
## Creating  24 events for 6 genes
## Extracting "Homozygous Loss" events (GISTIC = -2)
## Extracting "Heterozygous Loss" events (GISTIC = -1)
## Extracting "Low-level Gain" events (GISTIC = +1)
## Extracting "High-level Gain" events (GISTIC = +2)
## Transforming events in TRONCO data types .....
## *** Binding events for 4 datasets.
## *** Data extracted, returning only events observed in at least one sample
##  Number of events: n = 7
##  Number of genes: |G| = 6
##  Number of samples: m = 9
```

## 0.4 Custom alterations annotated in a boolean matrix

One can annotate its custom type of alterations in a boolean matrix such as `crc_plain`

```
crc_plain
```

```
##                 TP53 FBXW7 APC CTNNB1 NRAS KRAS
## TCGA-AA-3517-01    1     0   0      0    0    0
## TCGA-AA-3518-01    0     1   0      0    0    0
## TCGA-AA-3519-01    1     0   1      0    0    0
## TCGA-AA-3520-01    1     0   0      0    0    1
## TCGA-AA-3521-01    0     0   1      0    0    1
```

In this case, function `import.genotypes` will convert the matrix to a TRONCO object where events’ names and samples codes will be set from column and row names of the matrix. If this is not possible, these will be generated from templates. By default, the `event.type` is set to `variant` but one can specify a custom name for the alteration that is reported in the matrix

```
dataset_plain = import.genotypes(crc_plain, event.type='myVariant')
```

## 0.5 Downloading data from the cBio portal for cancer genomics

TRONCO uses the R interface to cBio to query data from the portal. All type of data can be downloaded from the portal, which includes MAF/GISTIC data for a lot of different cancer studies. An example of interaction with the portal is archived at the tool’s webpage.

Here, we show how to download lung cancer data somatic mutations for genes TP53, KRAS and PIK3CA, from the lung cancer project run by TCGA, which is archived as *luad\_tcga\_pub* at cBio. If some of the parameters to `cbio.query` are missing the function will become interactive by showing a list of possible data available at the portal.

```
data = cbio.query(
    genes=c('TP53', 'KRAS', 'PIK3CA'),
    cbio.study = 'luad_tcga_pub',
    cbio.dataset = 'luad_tcga_pub_cnaseq',
    cbio.profile = 'luad_tcga_pub_mutations')
```