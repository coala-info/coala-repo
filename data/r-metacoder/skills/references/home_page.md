[![](images/hex_sticker.png)

metacoder](index.html)

* [Example](example.html)
* Workshop
  + [Introduction](workshop--00--introduction.html)
  + [Required software](workshop--00--required_software.html)
  + [Required datasets](workshop--00--required_data.html)
  + [Getting data into R](workshop--03--parsing.html)
  + [Manipulating taxonomic data](workshop--04--manipulating.html)
  + [Plotting taxonomic data](workshop--05--plotting.html)
  + [Data quality control](workshop--06--quality_control.html)
  + [Diversity and Ordination](workshop--07--diversity_stats.html)
* Publication
  + [PLOS Comp Bio paper](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005404)
  + [Human microbiome](publication--05--16s_human_microbiome.html)
  + [TARA Oceans](publication--06--tara_oceans.html)
  + [Digital PCR: SILVA](publication--01--silva.html)
  + [Digital PCR: RDP](publication--02--rdp.html)
  + [Digital PCR: Greengenes](publication--03--greengenes.html)
  + [Digital PCR: Comparing databases](publication--04--16s_database_comparision.html)
  + [Voting Geography](publication--08--voting.html)
  + [Gene Expression](publication--09--gene_expression.html)
* Appendices
  + [Introduction to R](appendix--00--intro_to_r.html)
  + [Introduction to RStudio](appendix--00--intro_to_rstudio.html)
  + [Glossary](appendix--00--glossary.html)
  + [Slide show](appendix--00--presentation_page.html)
  + [Poster](appendix--00--poster_page.html)
  + [Metacoder source code](https://github.com/grunwaldlab/metacoder)
  + [Website source code](https://github.com/grunwaldlab/metacoder_documentation)
* [FAQ](faq.html)
* [About](about.html)

# Metacoder documentation

#### Zachary S. L. Foster and Niklaus J. Grünwald

#### 2021-07-23

## Introduction

Metacoder is an R package for **[parsing](appendix--00--glossary.html#parsing_anchor)**, plotting, and manipulating large **[taxonomic](appendix--00--glossary.html#taxonomy_anchor)** data sets, like those generated from modern high-throughput sequencing, like metabarcoding (i.e. amplification metagenomics, 16S metagenomics, etc). It provides a tree-based visualization called “heat trees” used to depict statistics for every taxon in a taxonomy using color and size. It also provides various functions to do common tasks in microbiome bioinformatics on data in the `taxmap` format defined by the `metacoder` package, such as:

* Summing read counts/abundance per taxon
* Converting counts to proportions and **[rarefaction](appendix--00--glossary.html#rarefaction_anchor)** of counts using `vegan`
* Comparing the abundance (or other characteristics) of groups of samples (e.g., experimental treatments) per taxon
* Combining data for groups of samples
* Simulated PCR, via EMBOSS primersearch, for testing primer specificity and coverage of taxonomic groups
* Converting common microbiome formats for data and reference databases into the objects defined by the `metacoder` package.
* Converting to and from the `phyloseq` format and the `metacoder` format

## Relationship with other packages

Many of these operations can be done using other packages like `phyloseq`, which also provides tools for diversity analysis. The main strength of `metacoder` is that its functions use the flexible data types defined by `metacoder`, which has powerful parsing and subsetting abilities that take into account the hierarchical relationship between taxa and user-defined data. In general, `metacoder` is more of an abstracted tool kit, whereas `phyloseq` has more specialized functions for community diversity data, but they both can do similar things. I encourage you to try both to see which fits your needs and style best. You can also combine the two in a single analysis by converting between the two data types when needed using the `parse_phyloseq` and `as_phyloseq` functions.

## Installation

This project is available on CRAN and can be installed like so:

```
install.packages("metacoder")
```

You can also install the development version for the newest features, bugs, and bug fixes:

```
install.packages("devtools")
devtools::install_github("grunwaldlab/metacoder")
```

## Dependencies

The function that simulates PCR requires `primersearch` from the EMBOSS (Rice, Longden, and Bleasby 2000) tool kit to be installed. This is not an R package, so it is not automatically installed. Type `?primersearch` after installing and loading metacoder for installation instructions.

## Future development

Metacoder is under active development and many new features are planned. Some improvements that are being explored include:

* Barcoding gap analysis and associated plotting functions
* A function to aid in retrieving appropriate sequence data from NCBI for *in silico* PCR from whole genome sequences
* Graphing of different node shapes in heat trees, possibly including pie graphs or [PhyloPics](http://phylopic.org/).
* Adding the ability to plot specific edge lengths in the heat trees so they can be used for phylogenetic trees.
* Adding more data import and export functions to make parsing and writing common formats easier.

To see the details of what is being worked on, check out the [issues](https://github.com/grunwaldlab/metacoder/issues) tab of the metacoder [Github site](https://github.com/grunwaldlab).

## Acknowledgements

Metacoder’s major dependencies are `taxize`, `vegan`, `igraph`, `dplyr`, and `ggplot2`.

## Feedback and contributions

We would like to hear about users’ thoughts on the package and any errors they run into. Please report errors, questions or suggestions on the [issues](https://github.com/grunwaldlab/metacoder/issues) tab of the Metacoder [Github site](https://github.com/grunwaldlab). We also welcome contributions via a Github [pull request](https://help.github.com/articles/using-pull-requests/). You can also talk with us using our [Google groups](https://groups.google.com/forum/#!forum/metacoder-discussions) site or the comments section below.

## References

Rice, Peter, Ian Longden, and Alan Bleasby. 2000. “EMBOSS: The European Molecular Biology Open Software Suite.” Elsevier Current Trends.

Metacoder's documentation by [The Grunwald lab and the USDA Horticultural Crops Research Unit](http://grunwaldlab.cgrb.oregonstate.edu/) is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).
Based on a work at <https://github.com/grunwaldlab/metacoder_documentation>.