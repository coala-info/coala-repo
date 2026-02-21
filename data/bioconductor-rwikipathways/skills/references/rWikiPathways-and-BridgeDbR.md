# rWikiPathways and BridgeDbR

by Alexander Pico

#### 2025-10-30

#### Package

rWikiPathways 1.30.0

*WikiPathways* is a well-known repository for biological pathways that provides unique tools to the research community for content creation, editing and utilization [[1](#ref-Pico2008)].

**R** is a powerful programming language and environment for statistical and exploratory data analysis.

*rWikiPathways* leverages the WikiPathways API to communicate between **R** and WikiPathways, allowing any pathway to be queried, interrogated and downloaded in both data and image formats. Queries are typically performed based on “Xrefs”, standardized identifiers for genes, proteins and metabolites. Once you can identified a pathway, you can use the WPID (WikiPathways identifier) to make additional queries.

*[BridgeDbR](https://doi.org/doi%3A10.18129/B9.bioc.BridgeDbR)* leverages the BridgeDb API [[2](#ref-VanIersel2010)] to provide a number of functions related to ID mapping and identifiers in general for gene, proteins and metabolites.

Together, *BridgeDbR* provides convience to the typical *rWikPathways* user by supplying formal names and codes defined by BridgeDb and used by WikiPathways.

# 1 Prerequisites

In addition to this **rWikiPathways** package, you’ll also need to install **BridgeDbR**:

```
if(!"rWikiPathways" %in% installed.packages()){
    if (!requireNamespace("BiocManager", quietly=TRUE))
        install.packages("BiocManager")
    BiocManager::install("rWikiPathways")
}
library(rWikiPathways)
if(!"BridgeDbR" %in% installed.packages()){
    if (!requireNamespace("BiocManager", quietly=TRUE))
        install.packages("BiocManager")
    BiocManager::install("BridgeDbR")
}
library(BridgeDbR)
```

# 2 Getting started

Lets first check some of the most basic functions from each package. For example, here’s how you check to see which species are currently supported by WikiPathways:

```
    orgNames <- listOrganisms()
    orgNames
```

You should see 30 or more species listed. This list is useful for subsequent queries that take an *organism* argument, to avoid misspelling.

However, some function want the organism code, rather than the full name. Using BridgeDbR’s *getOrganismCode* function, we can get those:

```
    BridgeDbR::getOrganismCode(orgNames[1])
```

# 3 Identifier System Names and Codes

Even more obscure are the various datasources providing official identifiers and how they are named and coded. Fortunately, BridgeDb defines these clearly and simply. And WikiPathways relies on these BridgeDb definitions.

For example, this is how we find the system code for Ensembl:

```
    BridgeDbR::getSystemCode("Ensembl")
```

It’s “En”! That’s simple enough. But some are less obvious…

```
    BridgeDbR::getSystemCode("Entrez Gene")
```

It’s “L” because the resource used to be named “Locus Link”. Sigh… Don’t try to guess these codes. Use this function from BridgeDb (above) to get the correct code. By the way, all the systems supported by BridgeDb are here:
<https://github.com/bridgedb/datasources/blob/main/datasources.tsv>

# 4 How to use BridgeDbR with rWikiPathways

Here are some specific combo functions that are useful. They let you skip worrying about system codes altogether!

1. Getting all the pathways containing the HGNC symbol “TNF”:

```
    tnf.pathways <- findPathwayIdsByXref('TNF', BridgeDbR::getSystemCode('HGNC'))
    tnf.pathways
```

2. Getting all the genes from a pathway as Ensembl identifiers:

```
    getXrefList('WP554', BridgeDbR::getSystemCode('Ensembl'))
```

3. Getting all the metabolites from a pathway as ChEBI identifiers:

```
    getXrefList('WP554', BridgeDbR::getSystemCode('ChEBI'))
```

# 5 Other tips

And if you ever find yourself with a system code, e.g., from a rWikiPathways return result and you’re not sure what it is, then you can use this function:

```
    BridgeDbR::getFullName('Ce')
```

# References

1. Pico AR, Kelder T, Iersel MP van, Hanspers K, Conklin BR, Evelo C: **WikiPathways: Pathway editing for the people**. *PLoS Biol* 2008, **6**:e184+.

2. Iersel M van, Pico A, Kelder T, Gao J, Ho I, Hanspers K, Conklin B, Evelo C: **The BridgeDb framework: Standardized access to gene, protein and metabolite identifier mapping services**. *BMC Bioinformatics* 2010, **11**:5+.