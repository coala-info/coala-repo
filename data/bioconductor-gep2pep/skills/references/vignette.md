# Introduction to gep2pep

#### Francesco Napolitano

* [About gep2pep](#about-gep2pep)
  + [Toy and real-world examples](#toy-and-real-world-examples)
* [Creating a repository of pathways](#creating-a-repository-of-pathways)
* [Creating Pathway Expression Profiles](#creating-pathway-expression-profiles)
* [Performing Analysis](#performing-analysis)
  + [Performing Condition-Set Enrichment Analysis (CondSEA).](#performing-condition-set-enrichment-analysis-condsea.)
  + [Performing Pathway-Set Enrichment Analysis (PathSEA)](#performing-pathway-set-enrichment-analysis-pathsea)
* [A real-world example](#a-real-world-example)
  + [Drug Set Enrichment Analysis (DSEA)](#drug-set-enrichment-analysis-dsea)
  + [Gene2drug analysis](#gene2drug-analysis)
* [Advanced access to the repository](#advanced-access-to-the-repository)
* [Further documentation](#further-documentation)
* [References](#references)

## About gep2pep

Pathway Expression Profiles (PEPs) are based on the expression of all the pathways (or generic gene sets) belonging to a collection under a given experimental condition, as opposed to individual genes. `gep2pep` supports the conversion of gene expression profiles (GEPs) to PEPs and performs enrichment analysis of both pathways and conditions.

`gep2pep` creates a local repository of gene sets, which can also be imported from the MSigDB database [1]. The local repository is in the `repo` format. When a GEP, defined as a ranked list of genes, is passed to `buildPEPs`, the stored database of pathways is used to convert the GEP to a PEP and permanently store the latter.

One type of analysis that can be performed on PEPs and that is directly supported by `gep2pep` is the Drug-Set Enrichment Analysis (DSEA, see reference below). It finds pathways that are consistently dysregulated by a set of drugs, as opposed to a background of other drugs. Of course PEPs may refer to non-pharmacological conditions (genetic perturbations, disease states, etc.) for analogous analyses. See the `CondSEA` function.

A complementary approach is that of finding conditions under which a set of pathways is consistently UP- or DOWN-regulated. This is the pathway-based version of the Gene Set Enrichment Analysis (GSEA). As an application example, this approach can be used to find drugs mimicking the dysregulation of a gene by looking for drugs dysregulating the pathways involving the gene (this has been published as the `gene2drug` tool [3]). See the `PathSEA` function.

### Toy and real-world examples

This vignette uses toy data, as real data can be computationally expensive. Connectivity Map data [4] (drug induced gene expression profiles) pre-converted to PEPs can be downloaded from <http://dsea.tigem.it> in the `gep2pep` format. At the end of this vignette, a precomputed example is reported in which that data is used.

## Creating a repository of pathways

In order to use the package, it must be loaded as follows (the GSEABase package will also be used in this vignette to access gene set data):

```
library(gep2pep)
suppressMessages(library(GSEABase))
```

The [MSigDB](http://software.broadinstitute.org/gsea/msigdb) is a curated database of gene set collections. The entire database can be downloaded as a single XML file and used by `gep2pep`. The following commented code would import the database once downloaded (gep2pep uses a slight variation of the `BroadCollection` type used by MSigDB, named `CategorizedCollection`, thus a conversion is necessary):

```
## db <- importMSigDB.xml("msigdb_v6.1.xml")
## db <- as.CategorizedCollection(db)
```

However, for this vignette a small excerpt will be used.

```
db <- loadSamplePWS()
```

The database is in `GSEABase::GeneSetCollection` format and includes 30 pathways, each of which is included in one of 3 different collections. Following MSigDB conventions, each collection is identified by a “category” and “subCategory” fields. But the CategorizedCollection type allows them to be arbitrary strings, as opposed to MSigDB categories. This allows for the creation of custom collection with categories. `gep2pep` puts together into a single collection identifier using `makeCollectionIDs`.

```
colltypes <- sapply(db, collectionType)
cats <- sapply(colltypes, attr, "category")
subcats <- sapply(colltypes, attr, "subCategory")
print(cats)
##  [1] "c3" "c3" "c3" "c3" "c3" "c3" "c3" "c3" "c3" "c3" "c3" "c3" "c3" "c3" "c3"
## [16] "c3" "c3" "c3" "c3" "c3" "c4" "c4" "c4" "c4" "c4" "c4" "c4" "c4" "c4" "c4"
print(subcats)
##  [1] "TFT" "TFT" "TFT" "TFT" "TFT" "TFT" "TFT" "TFT" "TFT" "TFT" "MIR" "MIR"
## [13] "MIR" "MIR" "MIR" "MIR" "MIR" "MIR" "MIR" "MIR" "CGN" "CGN" "CGN" "CGN"
## [25] "CGN" "CGN" "CGN" "CGN" "CGN" "CGN"
makeCollectionIDs(db)
##  [1] "c3_TFT" "c3_TFT" "c3_TFT" "c3_TFT" "c3_TFT" "c3_TFT" "c3_TFT" "c3_TFT"
##  [9] "c3_TFT" "c3_TFT" "c3_MIR" "c3_MIR" "c3_MIR" "c3_MIR" "c3_MIR" "c3_MIR"
## [17] "c3_MIR" "c3_MIR" "c3_MIR" "c3_MIR" "c4_CGN" "c4_CGN" "c4_CGN" "c4_CGN"
## [25] "c4_CGN" "c4_CGN" "c4_CGN" "c4_CGN" "c4_CGN" "c4_CGN"
```

In order to build a local `gep2pep` repository containing pathway data, `createRepository` is used:

```
repoRoot <- file.path(tempdir(), "gep2pep_data")
rp <- createRepository(repoRoot, db)
## Repo root created.
## Repo created.
## [00:10:16] Storing pathway data for collection: c3_TFT
## [00:10:16] Storing pathway data for collection: c3_MIR
## [00:10:16] Storing pathway data for collection: c4_CGN
```

The repository is in `repo` format (see later in this document how to access the repository directly). However, knowing `repo` is not necessary to use `gep2pep`. The following lists the contents of the repository, loads the `GeneSetCollection` object containing all the TFT database gene sets and finally shows the description of the pathway “E47\_01”:

```
rp
##                  ID Dims     Size
##  gep2pep repository    2  34.3 kB
##         c3_TFT_sets   10 18.83 kB
##         c3_MIR_sets   10 17.88 kB
##         c4_CGN_sets   10  7.42 kB
##          conditions    1     49 B
TFTsets <- loadCollection(rp, "c3_TFT")
TFTsets
## GeneSetCollection
##   names: AAANWWTGC_UNKNOWN, AAAYRNCTG_UNKNOWN, ..., SP1_01 (10 total)
##   unique identifiers: MEF2C, ATP1B1, ..., MEX3B (3156 total)
##   types in collection:
##     geneIdType: SymbolIdentifier (1 total)
##     collectionType: CategorizedCollection (1 total)
description(TFTsets[["E47_01"]])
## [1] "Genes having at least one occurence of the transcription factor binding site V$E47_01 (v7.4 TRANSFAC) in the regions spanning up to 4 kb around their transcription starting sites."
```

`rp$get` is a `repo` command, see later in this vignette.

## Creating Pathway Expression Profiles

Pathway Expression Profiles (PEPs) are created from Gene Expression Profiles (GEPs) using pathway information from the repository. GEPs must be provided as a matrix with rows corresponding to genes and columns corresponding to conditions (*conditions*). Genes and conditions must be specified through row and column names respectively. The values must be ranks: for each condition, the genes must be ranked from that being most UP-regulated (rank 1) to that being most DOWN-regulated (rank equal to the number of rows of the matrix).

One well known database that can be obtained in this format is for example the Connectivty Map. A small excerpt (after further processing) is included with the `gep2pep`. The excerpt must be considered as a dummy example, as it only includes 500 genes for 5 conditions. It can be loaded as follows:

```
geps <- loadSampleGEP()
dim(geps)
## [1] 485   5
geps[1:5, 1:3]
##            (+)_chelidonine (+)_isoprenaline (+/_)_catechin
## AKT3                    87              115            404
## MED6                   347              398             33
## NR2E3                  373              119            440
## NAALAD2                227              317            377
## CDKN2B-AS1             216               79             21
```

The GEPs can be converted to PEPs using the `buildPEPs` function. They are stored as repository items by the names “category\_subcategory”.

```
buildPEPs(rp, geps)
## [00:10:16] Working on collection: c3_TFT (1/3)
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## [00:10:17] Storing PEPs to the repository...
## [00:10:17] Storing condition information...
## [00:10:17] Done.
## [00:10:17] Working on collection: c3_MIR (2/3)
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## [00:10:17] Storing PEPs to the repository...
## [00:10:17] Storing condition information...
## [00:10:17] Done.
## [00:10:17] Working on collection: c4_CGN (3/3)
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## ================
## [00:10:17] Storing PEPs to the repository...
## [00:10:17] Storing condition information...
## [00:10:17] Done.
```

Each PEP is composed of an Enrichment Score (ES) – p-value (PV) pair associated to each pathway. ESs and PVs are stored in two separated matrices. For each condition, the p-value reports wether a pathway is significantly dysregulated and the sign of the corresponding ES indicates the direction (UP- or DOWN-regulation).

```
loadESmatrix(rp, "c3_TFT")[1:3, 1:3]
##        (+)_chelidonine (+)_isoprenaline (+/_)_catechin
## M3128       -0.3732815        0.4763897      0.2029289
## M11607       0.3762838        0.2299253      0.2882820
## M12599       0.4585062        0.2365145     -0.2372061
loadPVmatrix(rp, "c3_TFT")[1:3, 1:3]
##        (+)_chelidonine (+)_isoprenaline (+/_)_catechin
## M3128        0.2267728       0.05876085      0.8885505
## M11607       0.1248594       0.65717027      0.3809141
## M12599       0.4407217       0.98408373      0.9836051
```

## Performing Analysis

### Performing Condition-Set Enrichment Analysis (CondSEA).

Suppose the stored PEPs correspond to pharmacological perturbations. Then `gep2pep` can perform Drug-Set Enrichment Analysis (DSEA, see Napolitano et al., 2016, Bioinformatics). It finds pathways that are consistently dysregulated by a set of drugs, as opposed to a background of other drugs. Of course PEPs may refer to non-pharmacological conditions (genetic perturbations, disease states, etc.) for analogous analyses (Condition-Set Enrichment Analysis, CondSEA). Given a set `pgset` of drugs of interest, CondSEA (which in this case is a DSEA) is performed as follows:

```
pgset <- c("(+)_chelidonine", "(+/_)_catechin")
psea <- CondSEA(rp, pgset)
## [00:10:17] Working on collection: c3_TFT
## [00:10:17] Common conditions removed from bgset
## [00:10:17] Ranking collection
## [00:10:17] Computing enrichments
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## [00:10:17] Done.
## [00:10:17] Working on collection: c3_MIR
## [00:10:17] Ranking collection
## [00:10:17] Computing enrichments
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## [00:10:17] Done.
## [00:10:17] Working on collection: c4_CGN
## [00:10:17] Ranking collection
## [00:10:17] Computing enrichments
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## [00:10:17] Done.
```

The result is a list of of 2 elements, named “CondSEA” and “details”, the most important of which is the former. Per-collection results can be accessed as follows:

```
getResults(psea, "c3_TFT")
##                ES  PV
## M5067   1.0000000 0.2
## M3128  -0.6666667 0.6
## M11607  0.6666667 0.6
## M16694 -0.6666667 0.6
## M14463  0.6666667 0.6
## M14686 -0.6666667 0.6
## M12599  0.5000000 0.9
## M10817 -0.5000000 0.9
## M4831   0.3333333 1.0
## M2501          NA  NA
```

In this dummy example the statistical background is made of only 3 GEPs (we added 5 in total), thus, as expected, there are no significant p-values. For the c3\_MIR collection, the pathway most UP-regulated by the chosen set of two drugs is M5012, while the most DOWN-regulated is M18759. They are respectively described as:

```
sets <- loadCollection(rp, "c3_MIR")
wM5012 <- which(sapply(sets, setIdentifier)=="M5012")
wM18759 <- which(sapply(sets, setIdentifier)=="M18759")

description(sets[[wM5012]])
## [1] "Genes having at least one occurrence of the motif TGCACTG in their 3' untranslated region. The motif represents putative target (i.e., seed match) of human mature miRNAs hsa-miR-148a, hsa-miR-152, hsa-miR-148b (v7.1 miRBase)."

description(sets[[wM18759]])
## [1] "Genes having at least one occurrence of the motif GCACTTT in their 3' untranslated region. The motif represents putative target (i.e., seed match) of human mature miRNAs hsa-miR-17-5p, hsa-miR-20a, hsa-miR-106a, hsa-miR-106b, hsa-miR-20b, hsa-miR-519d (v7.1 miRBase)."
```

The analysis can be exported in XLS format as follows:

```
exportSEA(rp, psea)
```

Performing `CondSEA` using Pathway Expression Profiles derived from drug-induced gene expression profiles yields Drug Set Enrichment Analysis (DSEA [2]).

### Performing Pathway-Set Enrichment Analysis (PathSEA)

A complementary approach to CondSEA is Pathway-Set Enrichment Analysis (PathSEA). PathSEA searches for conditions that consistently dysregulate a set of pathways. It can be seen as a pathway-based version of the popular Gene Set Enrichment Analysis (GSEA). The PathSEA is run independently in each pathway collection.

```
pathways <- c("M11607", "M10817", "M16694",         ## from c3_TFT
              "M19723", "M5038", "M13419", "M1094") ## from c4_CGN
w <- sapply(db, setIdentifier) %in% pathways
subdb <- db[w]

psea <- PathSEA(rp, subdb)
## [00:10:17] Working on collection: c3_TFT
## [00:10:17] Common pathway sets removed from bgset
## [00:10:17] Column-ranking collection
## [00:10:17] Computing enrichments
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## [00:10:17] done
## [00:10:17] Working on collection: c4_CGN
## [00:10:17] Common pathway sets removed from bgset
## [00:10:17] Column-ranking collection
## [00:10:17] Computing enrichments
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## Warning in ks.test.default(x, y, ...): Parameter(s) maxCombSize ignored
## [00:10:17] done
```

```
getResults(psea, "c3_TFT")
##                         ES        PV
## (+/_)_catechin   0.6666667 0.3333333
## (_)_mk_801       0.6666667 0.3333333
## (_)_atenolol     0.6666667 0.3333333
## (+)_isoprenaline 0.5000000 0.6785714
## (+)_chelidonine  0.3333333 0.9880952
```

PathSEA results are analogous to those of CondSEA, but condition-wise. A set of pathways con also be obtained starting from a gene of interest, for example:

```
pathways <- gene2pathways(rp, "FAM126A")
pathways
## GeneSetCollection
##   names: MYOD_01, E47_01, CMYB_01, AAAYWAACM_HFH4_01 (4 total)
##   unique identifiers: KCNE1L, FAM126A, ..., MGST1 (2362 total)
##   types in collection:
##     geneIdType: SymbolIdentifier (1 total)
##     collectionType: CategorizedCollection (1 total)
```

Using a gene to obtain the pathways and performing `PathSEA` with drug-induced Pathway Expression Profiles yields “gene2drug” analysis, see the following reference:

* Napolitano F. et al, gene2drug: a Computational Tool for Pathway-based Rational Drug Repositioning, bioRxiv (2017) 192005; doi: <https://doi.org/10.1101/192005>

## A real-world example

Precomputed Pathway Expression Profiles of the Connectivity Map data in the gep2pep format can be downloaded, unpacked and opened as follows:

```
download.file("http://dsea.tigem.it/data/Cmap_MSigDB_v6.1_PEPs.tar.gz",
  "Cmap_MSigDB_v6.1_PEPs.tar.gz")

untar("Cmap_MSigDB_v6.1_PEPs.tar.gz")

rpBig <- openRepository("Cmap_MSigDB_v6.1_PEPs")
```

Using these data, two kinds of analysis can be performed:

1. Drug Set Enrichment Analysis, which looks for commond pathways shared by a set of drugs.
2. Gene2drug analysis, which looks for drugs dysregulating a gene of interest.

The analyses below are not built at runtime with this document and could become outdated.

### Drug Set Enrichment Analysis (DSEA)

Drug Set Enrichment Analysis for a set of HDAC inhibitors using the Gene Ontology collections can be performed as follows:

```
csea <- CondSEA(rpBig, c("scriptaid", "trichostatin_a", "valproic_acid",
                      "vorinostat", "hc_toxin", "bufexamac"),
                collections=c("C5_BP", "C5_MF", "C5_CC"))
## [16:41:40] Working on collection: C5_BP
## [16:41:42] Common conditions removed from bgset
## [16:41:42] Row-ranking collection
## [16:41:48] Computing enrichments
## [16:41:58] done
## [16:41:58] Working on collection: C5_MF
## [16:41:58] Row-ranking collection
## [16:42:00] Computing enrichments
## [16:42:02] done
## [16:42:02] Working on collection: C5_CC
## [16:42:02] Row-ranking collection
## [16:42:03] Computing enrichments
## [16:42:04] done
```

The following code retrieves information about the top 10 pathways ranked by CondSEA in GO-MF.

```
library(GSEABase)
setids <- sapply(loadCollection(rpBig, "C5_MF"), setIdentifier)
MFresults <- getResults(csea, "C5_MF")
w <- match(rownames(MFresults)[1:10], setids)
top10 <- loadCollection(rpBig, "C5_MF")[w]
sapply(top10, setName)
##  [1] "GO_TRANSCRIPTION_FACTOR_ACTIVITY_PROTEIN_BINDING"
##  [2] "GO_TRANSCRIPTION_COACTIVATOR_ACTIVITY"
##  [3] "GO_PHOSPHATIDYLCHOLINE_1_ACYLHYDROLASE_ACTIVITY"
##  [4] "GO_RETINOIC_ACID_RECEPTOR_BINDING"
##  [5] "GO_PRE_MRNA_BINDING"
##  [6] "GO_N_ACETYLTRANSFERASE_ACTIVITY"
##  [7] "GO_CYTOSKELETAL_PROTEIN_BINDING"
##  [8] "GO_PEPTIDE_N_ACETYLTRANSFERASE_ACTIVITY"
##  [9] "GO_ACETYLTRANSFERASE_ACTIVITY"
## [10] "GO_HYDROGEN_EXPORTING_ATPASE_ACTIVITY"
```

Note that 2 main effects of HDAC inhibitors have been correctly identified: regulation of transcription, and alteration of the acetylation/deacetylation homeostasis. The full analysis can be exported to the Excel format with:

```
exportSEA(rpBig, csea)
```

### Gene2drug analysis

A Gene2drug analysis can be performed starting by a gene of interest, for example the TFEB gene. Pathways including the gene are found as follows:

```
pws <- gene2pathways(rpBig, "TFEB")
```

The following code runs the PathSEA analysis on the pathways involving TFEB. Also in this case the analysis is performed on Gene Ontology collections. Note that a warning is thrown as the GO-CC category has no annotation for TFEB (this is ok).

```
psea <- PathSEA(rpBig, pws, collections=c("C5_BP", "C5_MF", "C5_CC"))
## Warning: [17:17:13] There is at least one selected collections for
## which no pathway has been provided
## [17:17:13] Removing pathways not in specified collections
## [17:17:13] Working on collection: C5_BP
## [17:17:13] Common pathway sets removed from bgset
## [17:17:15] Column-ranking collection
## [17:17:22] Computing enrichments
## [17:17:29] done
## [17:17:29] Working on collection: C5_MF
## [17:17:29] Common pathway sets removed from bgset
## [17:17:29] Column-ranking collection
## [17:17:30] Computing enrichments
## [17:17:32] done
```

Thus the top 10 drugs causing (or mimicking) TFEB upregulation are:

```
getResults(psea, "C5_BP")[1:10,]
##                      ES           PV
## loperamide    0.7324720 1.504075e-11
## proadifen     0.7278256 2.079448e-11
## hydroquinine  0.7220082 3.110434e-11
## bepridil      0.6904276 2.616027e-10
## clomipramine  0.6891810 2.839879e-10
## alexidine     0.6741085 7.574142e-10
## digitoxigenin 0.6737685 7.741670e-10
## lanatoside_c  0.6651556 1.342553e-09
## helveticoside 0.6642112 1.425479e-09
## ouabain       0.6631157 1.527949e-09
```

Note that the top drug, loperamide, has been demonstrated to induce TFEB translocation at very low concentrations [3]. As before, the full analysis can be exported to the Excel format with:

```
exportSEA(rpBig, psea)
```

## Advanced access to the repository

`gep2pep` users don’t need to understand how to interact with a `gep2pep` repository, however it can be useful in some cases. `gep2pep` repositories are in the `repo` format (see the `repo` package), so they can be accessed as any other `repo` repository. However item tags should not be changed, as they are used by `gep2pep` to identify data types. Each `gep2pep` repository always contains a special *project* item including repository and session information, which can be shown as follows:

```
rp$info("gep2pep repository")
## Project name: gep2pep repository
## Description: This repository contains pathway information and possibly Pathway Expression Profiles created with the gep2pep package.
## Resources: c3_TFT_sets
##  c3_MIR_sets
##  c4_CGN_sets
##  conditions
##  c3_TFT
##  c3_MIR
##  c4_CGN
## Platform: x86_64-pc-linux-gnu
## OS: Ubuntu 24.04.3 LTS
## R version: 4.5.1 Patched (2025-08-23 r88802)
## Packages: GSEABase 1.72.0
##  graph 1.88.0
##  annotate 1.88.0
##  XML 3.99.0.19
##  AnnotationDbi 1.72.0
##  IRanges 2.44.0
##  S4Vectors 0.48.0
##  Biobase 2.70.0
##  BiocGenerics 0.56.0
##  generics 0.1.4
##  gep2pep 1.30.0
##  knitr 1.50
```

Poject name and description can be provided when creating the repository (`createRepository`), or edited with `rp$set("gep2pep repository", newname="my project name", description="my project description")`. The repository will also contain an item for each pathway collection, and possibly an item for each corresponding PEP collection, as in this example:

```
rp
##                  ID Dims     Size
##  gep2pep repository    2  34.3 kB
##         c3_TFT_sets   10 18.83 kB
##         c3_MIR_sets   10 17.88 kB
##         c4_CGN_sets   10  7.42 kB
##          conditions    4    173 B
##              c3_TFT    2   1022 B
##              c3_MIR    2    974 B
##              c4_CGN    2     1 kB
```

In order to look at the space that the repository is using, the following command can be used:

```
rp$info()
## Root:            /tmp/RtmpCrcXo4/gep2pep_data
## Number of items: 8
## Total size:      81.55 kB
```

`put`, `set` and other `repo` commands can be used to alter repository contents directly, however this could leave the repository in an inconsistent state. The following code checks a repository for possible problems:

```
checkRepository(rp)
## [00:10:18] Checking repository consistency...
## Checking: gep2pep repository... ok.
## Checking: c3_TFT_sets... ok.
## Checking: c3_MIR_sets... ok.
## Checking: c4_CGN_sets... ok.
## Checking: conditions... ok.
## Checking: c3_TFT... ok.
## Checking: c3_MIR... ok.
## Checking: c4_CGN... ok.
##
## Checking for extraneous files in repo root... ok.
##
## [00:10:18] Cheching for gep2pep data consistency...
##
## [00:10:18] Checking conditions list...
## [00:10:18] Ok.
## [00:10:18] Checking PEPs...
## [00:10:18] Checking collection: c3_TFT...
## [00:10:18] ok.
## [00:10:18] Checking collection: c3_MIR...
## [00:10:18] ok.
## [00:10:18] Checking collection: c4_CGN...
## [00:10:18] ok.
## [00:10:18] Checking wether different PEP collections include the same conditions...
## [00:10:18] All PEP collections have the same conditions
```

The last check (summary of commond conditions) ensures that the same conditions have been computed for all the pathway collections, which is however not mandatory.

## Further documentation

Additional methodological help can be found at:

1. <http://dsea.tigem.it>
2. <http://gene2drug.tigem.it>
3. Open access papers [2] and [3].

## References

[1] Subramanian A. et al. Gene set enrichment analysis: A knowledge-based approach for interpreting genome-wide expression profiles. PNAS 102, 15545-15550 (2005).

[2] Napolitano F. et al, Drug-set enrichment analysis: a novel tool to investigate drug mode of action. Bioinformatics 32, 235-241 (2016).

[3] Napolitano F. et al, gene2drug: a Computational Tool for Pathway-based Rational Drug Repositioning, bioRxiv (2017) 192005; doi: <https://doi.org/10.1101/192005>

[4] Lamb, J. et al. The Connectivity Map: Using Gene-Expression Signatures to Connect Small Molecules, Genes, and Disease. Science 313, 1929-1935 (2006).

---

*Built with `gep2pep` version 1.30.0*