# Submitting your organism to GenomeInfoDb

Sonali Arora and H. Khan1

1Vignette translation from Sweave to Rmarkdown / HTML

#### Modified: 16 January 2013; Compiled: 04 December, 2025

#### Package

GenomeInfoDb 1.46.2

# Contents

* [1 Background](#background)
* [2 Support for existing organisms](#support-for-existing-organisms)
* [3 File format for new organism](#file-format-for-new-organism)
* [4 Example File](#example-file)
* [5 Contacting us with your new file](#contacting-us-with-your-new-file)

This document is meant for package developers wanting to submit an organism
which does not already exist in *[GenomeInfoDb](https://bioconductor.org/packages/3.22/GenomeInfoDb)*, to be a part of
*[GenomeInfoDb](https://bioconductor.org/packages/3.22/GenomeInfoDb)*.

# 1 Background

*GenomeInfoDb* provides a multitude of functions to subset and access seqName
mappings and styles associated with an organism. One can use the supplementary
manual “GenomeInfoDb.pdf” to see such functions. Alternately if there is no
support for an organism for one’s choice, one can submit a tab delimited file
(as detailed by the sections below) to request their favorite organism to become
a part of GenomeInfoDb package.

# 2 Support for existing organisms

GenomeInfoDb already provides support for a multitude of organisms, to see a
detailed list of organism and the supported seqname styles associated with those
organism, one can simply run :

```
library(GenomeInfoDb)
names(genomeStyles())
```

```
##  [1] "Arabidopsis_thaliana"     "Caenorhabditis_elegans"
##  [3] "Canis_familiaris"         "Cyanidioschyzon_merolae"
##  [5] "Drosophila_melanogaster"  "Gossypium_hirsutum"
##  [7] "Homo_sapiens"             "Mus_musculus"
##  [9] "Oryza_sativa"             "Populus_trichocarpa"
## [11] "Rattus_norvegicus"        "Saccharomyces_cerevisiae"
## [13] "Zea_mays"
```

# 3 File format for new organism

If your favorite organism does not exist in the above list, one can submit a tab
delimited file in the following format and request for your organism to be added
to *[GenomeInfoDb](https://bioconductor.org/packages/3.22/GenomeInfoDb)*

1. The file name should be in the following format: `genus\_{}species.txt`
2. The columns should be tab-delimited in the following order

   * circular
   * auto
   * sex
   * 1 column per seqname style and 1 row per chromosome name (not all
     chromosomes of a given organism necessarily belong to the mapping) where
     circular denotes all the circular chromosomes, auto denotes all the
     autosomes and sex denotes all the allosomes or sex chromosomes.
3. The entries should be in T/F format for columns circular, auto and sex.

# 4 Example File

One can look at existing organism files under GenomeInfoDb/extdata/dataFiles in
their R/library to get a further idea about the format of files.

# 5 Contacting us with your new file

Once your file is ready, Please send your file to:

```
packageDescription("GenomeInfoDb")$Maintainer
```

```
## [1] "Hervé Pagès <hpages.on.github@gmail.com>"
```