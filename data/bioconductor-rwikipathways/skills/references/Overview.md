# Overview

by Alexander Pico

#### 2025-10-30

#### Package

rWikiPathways 1.30.0

*WikiPathways* is a well-known repository for biological pathways that provides unique tools to the research community for content creation, editing and utilization [[1](#ref-Pico2008)].

**R** is a powerful programming language and environment for statistical and exploratory data analysis.

*rWikiPathways* leverages the WikiPathways API to communicate between **R** and WikiPathways, allowing any pathway to be queried, interrogated and downloaded in both data and image formats. Queries are typically performed based on “Xrefs”, standardized identifiers for genes, proteins and metabolites. Once you can identified a pathway, you can use the WPID (WikiPathways identifier) to make additional queries.

# 1 Prerequisites

All you need is this **rWikiPathways** package! If you’re viewing this vignette, then you’ve probably already installed and loaded **rWikiPathways**, e.g., by means of:

```
if(!"rWikiPathways" %in% installed.packages()){
    if (!requireNamespace("BiocManager", quietly=TRUE))
        install.packages("BiocManager")
    BiocManager::install("rWikiPathways")
}
library(rWikiPathways)
```

# 2 Getting started

Lets first get oriented with what WikiPathways contains. For example, here’s how you check to see which species are currently supported by WikiPathways:

```
    listOrganisms()
```

You should see 30 or more species listed. This list is useful for subsequent queries that take an *organism* argument, to avoid misspelling.

Next, let’s see how many pathways are available for Human:

```
    hs.pathways <- listPathways('Homo sapiens')
    hs.pathways
```

Yikes! That is a lot of information. Let’s break that down a bit:

```
    ?listPathways
    length(hs.pathways)
```

Ok. The help docs tell us that for each Human pathway we are getting a lot of information. A simple *length* function might be all you really want to know. Or if you’re interested in just one particular piece of information, check out these functions:

```
    ?listPathwayIds
    ?listPathwayNames
    ?listPathwayUrls
```

These return simple lists containing just a particular piece of information for each pathway result.

Finally, there’s another way to find pathways of interest: by Xref. An Xref is simply a standardized identifier form an official source. WikiPathways relies on BridgeDb [[2](#ref-VanIersel2010)] to provide dozens of Xref sources for genes, proteins and metabolites. See the full list at
<https://github.com/bridgedb/datasources/blob/main/datasources.tsv>

With **rWikiPathways**, the approach is simple. Take a supported identifier for a molecule of interest, e.g., an official gene symbol from HGNC, “TNF” and check the *system code* for the datasource, e.g., HGNC = H (this comes from the second column in the datasources.txt table linked to above), and then form your query:

```
    tnf.pathways <- findPathwaysByXref('TNF','H')
    tnf.pathways
```

Ack! That’s a lot of information. We provide not only the pathway information, but also the search result score in case you want to rank results, etc. Again, if all you’re interested in is WPIDs, names or URLs, then there are these handy alternatives that will just return simple lists:

```
    ?findPathwayIdsByXref
    ?findPathwayNamesByXref
    ?findPathwayUrlsByXref
```

*Be aware*: a simple *length* function may be misleading here since a given pathway will be listed multiple times if the Xref is present mutiple times.

# 3 My favorite pathways

At this point, we should have one or more pathways identified from the queries above. Let’s assume we identified ‘WP554’, the Ace Inhibitor Pathway (<https://wikipathways.org/instance/WP554>). We will use its WPID (WP554)
in subsequent queries.

First off, we can get information about the pathway (if we didn’t already collect it above):

```
    getPathwayInfo('WP554')
```

Next, we can get all the Xrefs contained in the pathway, mapped to a datasource of our choice. How convenient! We use the same *system codes* as described above. So, for example, if we want all the genes listed as Entrez Genes from this pathway:

```
    getXrefList('WP554','L')
```

Alternatively, if we want them listed as Ensembl IDs instead, then…

```
    getXrefList('WP554', 'En')
```

And, if we want the metabolites, drugs and other small molecules associated with the pathways, then we’d simply provide the system code of a chemical database, e.g., Ce (ChEBI) or Ik (InCHIKey):

```
    getXrefList('WP554', 'Ce')
    getXrefList('WP554', 'Ik')
```

It’s that easy!

# 4 Give me more

We also provide methods for retrieving pathways as data files and as images. The native file format for WikiPathways is GPML, a custom XML specification. You can retrieve this format by…

```
    gpml <- getPathway('WP554')
```

WikiPathways also provides a monthly data release archived at <http://data.wikipathways.org>. The archive includes GPML, GMT and SVG collections by organism and timestamped. There’s an R function for grabbing files from the archive…

```
    downloadPathwayArchive()
```

This will simply open the archive in your default browser so you can look around (in case you don’t know what you are looking for). By default, it opens to the latest collection of GPML files. However, if you provide an organism, then it will download that file to your current working directory or specified **destpath**. For example, here’s how you’d get the latest GMT file for mouse:

```
    downloadPathwayArchive(organism="Mus musculus", format="gmt")
```

And if you might want to specify an archive date so that you can easily share and reproduce your script at any time in the future and get the same result. Remember, new pathways are being added to WikiPathways every month and existing pathways are improved continuously!

```
    downloadPathwayArchive(date="20171010", organism="Mus musculus", format="gmt")
```

# 5 Wrapping up

That’s an overview of the **rWikiPathways** package. Check out other vignettes and the complete list of package functions:

```
    browseVignettes('rWikiPathways')
    help(package='rWikiPathways')
```

# References

1. Pico AR, Kelder T, Iersel MP van, Hanspers K, Conklin BR, Evelo C: **WikiPathways: Pathway editing for the people**. *PLoS Biol* 2008, **6**:e184+.

2. Iersel M van, Pico A, Kelder T, Gao J, Ho I, Hanspers K, Conklin B, Evelo C: **The BridgeDb framework: Standardized access to gene, protein and metabolite identifier mapping services**. *BMC Bioinformatics* 2010, **11**:5+.