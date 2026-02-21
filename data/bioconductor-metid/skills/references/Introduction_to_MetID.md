# Introduction to MetID

#### Xuchen Wang

#### 2025-10-30

## Introduction

Metabolomics offers the opportunity to characterize complex diseases. The use of both LC-MS and GC-MS increases the coverage of the metabolome by taking advantage of their complementary features. Although numerous ions are detected using these platforms, only a small subset of the metabolites corresponding to these ions can be identified. The vast majority of them are either unknowns or “known-unknowns”. So we propose an innovative network-based approach to enhance our ability to determine the identities of significant ions detected by LC-MS. Specifically, it uses a probabilistic framework to determine the identities of known-unknowns by prioritizing their putative metabolite IDs. This will be accomplished by exploiting the inter-dependent relationships between metabolites in biological organisms based on knowledge from pathways/biochemical networks. This is the R package MetID that implements the algorithm.

The main function in this package is get\_scores\_for\_LC\_MS. See ?get\_scores\_for\_LC\_MC for documentation. This function takes an input dataset and assigns scores for each putative identifications. When working with this function, you must:

* Have a data file with .csv or .txt extension. Otherwise, you need to read it in R as a ‘data.frame’ object first.
* Check if the colnames of your data meet requirements: columns named exactly as ‘metid’ (IDs for peaks), ‘query\_m.z’ (query mass of peaks), ‘exact\_m.z’ (exact mass of putative IDs), ‘kegg\_id’ (IDs of putative IDs from KEGG Database), ‘pubchem\_cid’ (CIDs of putative IDs from PubChem Database).

## Example

This example shows the usage of function get\_scores\_for\_LC\_MS with a small dataset: demo1. This dataset only contains 3 compounds and is documented in ?demo1. Note: the scores are only meaningful when we have a dataset with a large number of compounds. So the result of demo1 dataset does not make sense.

##### Load MetID package first.

```
library(MetID)
```

##### Load demo1 dataset.

```
data("demo1")
dim(demo1)
#> [1] 20  6
head(demo1)
#>   Query.Mass                                                   Name     Formula
#> 1   371.2283        sn-Glycerol 3-phosphate bis(cyclohexylammonium) C15H35N2O6P
#> 2   371.2283              1,4-Bis(chloromethyl)-2,5-diheptylbenzene   C22H36Cl2
#> 3   450.3221 N-(3�_��,12�_��-dihydroxy-5�_�_-cholan-24-oyl)-glycine   C26H43NO5
#> 4   450.3221                                      Glycodeoxycholate   C26H43NO5
#> 5   450.3221                     Deoxycholic acid glycine conjugate   C26H43NO5
#> 6   450.3221                Chenodeoxycholic acid glycine conjugate   C26H43NO5
#>   Exact.Mass PubChem.CID KEGG.ID
#> 1   370.2233
#> 2   370.2194
#> 3   449.3141
#> 4   449.3141
#> 5   449.3141    22833539
#> 6   449.3141
```

##### Check the form of demo1 dataset.

```
names(demo1)
#> [1] "Query.Mass"  "Name"        "Formula"     "Exact.Mass"  "PubChem.CID"
#> [6] "KEGG.ID"
```

##### Change colnames of demo1.

Since the colnames do not meet our requirement, we need to change its colnames before we use get\_scores\_for\_LC\_MS function.

```
colnames(demo1) <- c('query_m.z','name','formula','exact_m.z','pubchem_cid','kegg_id')
out <- get_scores_for_LC_MS(demo1, type = 'data.frame', na='-', mode='POS')
#> Start building network: it may take several minutes......
#> Start getting random samples: it may take several minutes......
#> Start writing scores......
#> Completed!
head(out)
#>   query_m.z                                                   name     formula
#> 1  371.2283        sn-Glycerol 3-phosphate bis(cyclohexylammonium) C15H35N2O6P
#> 2  371.2283              1,4-Bis(chloromethyl)-2,5-diheptylbenzene   C22H36Cl2
#> 3  450.3221 N-(3�_��,12�_��-dihydroxy-5�_�_-cholan-24-oyl)-glycine   C26H43NO5
#> 4  450.3221                                      Glycodeoxycholate   C26H43NO5
#> 5  450.3221                     Deoxycholic acid glycine conjugate   C26H43NO5
#> 6  450.3221                Chenodeoxycholic acid glycine conjugate   C26H43NO5
#>   exact_m.z pubchem_cid kegg_id       inchikey metid             score
#> 1  370.2233                               <NA>     1                 -
#> 2  370.2194                               <NA>     1                 -
#> 3  449.3141                               <NA>     2                 -
#> 4  449.3141                               <NA>     2                 -
#> 5  449.3141    22833539         WVULKSPCQVQLCU     2 0.483333333333333
#> 6  449.3141                               <NA>     2                 -
```

## Other data sources

We also include a large dataset (demo2) which generates meaningful scores. As well as data frames, MetID works with data that is stored in other ways, like csv files and text files.