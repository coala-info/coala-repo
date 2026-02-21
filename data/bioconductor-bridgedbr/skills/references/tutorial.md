# BridgeDbR Tutorial

Egon Willighagen

#### 29 October 2025

#### Package

BridgeDbR 2.20.0

# 1 Introduction

[BridgeDb](https://github.com/bridgedb/BridgeDb) is a combination of an application programming interface (API), library, and set of data files
for mapping identifiers for identical objects (Iersel et al. [2010](#ref-VanIersel2010)). Because BridgeDb is
use by projects in bioinformatics, like [WikiPathways](http://wikipathways.org/) (Pico et al. [2008](#ref-Pico2008)) and
[PathVisio](http://pathvisio.org/) (Iersel et al., [n.d.](#ref-VanIersel2008)),
identifier mapping databases are available for gene products (including proteins), metabolites, and metabolic conversions. We are also working on a disease database mapping file.

Questions can be directed to the [BridgeDb Google Group](https://groups.google.com/forum/#!forum/bridgedb-discuss).

The [Bioconductor BridgeDbR package](https://doi.org/10.18129/B9.bioc.BridgeDbR)
page describes how to install the package. After installation, the library can be loaded with the following command:

```
library(BridgeDbR)
```

```
## Loading required package: rJava
```

\*Note: if you have trouble with rJava (required package), please read the [general information](https://www.rforge.net/rJava/docs/index.html) or
follow the instructions [here](https://github.com/hannarud/r-best-practices/wiki/Installing-RJava-%28Ubuntu%29) for Ubuntu.

# 2 Concepts

BridgeDb has a few core concepts which are explained in this section. Much of the API requires one to
be familiar with these concepts, though some are not always applicable. The first concept is an example
of that: organisms, which do not apply to metabolites.

## 2.1 Organisms

However, for genes the organism is important: the same gene has different identifiers in different
organisms. BridgeDb identifies organisms by their latin name and with a two character code. Because
identifier mapping files provided by PathVisio have names with these short codes, it can be useful to
have a conversion method:

```
code <- getOrganismCode("Rattus norvegicus")
code
```

```
## [1] "Rn"
```

## 2.2 Data Sources

Identifiers have a context and this context is often a database. For example, metabolite identfiers
can be provided by the Human Metabolome Database (HMDB), ChemSpider, PubChem, ChEBI, and many others. Similarly,
gene product identifiers can be provided by databases like Ensembl, (NCBI) Entrez Gene, Uniprot etc. Such a database providing identifiers is called a data source in BridgeDb.

Importantly, each such data source is identified by a human readable long name and by a short
system code. This package has methods to interconvert one into the other:

```
fullName <- getFullName("Ce")
fullName
```

```
## [1] "ChEBI"
```

```
code <- getSystemCode("ChEBI")
code
```

```
## [1] "Ce"
```

## 2.3 Identifier Patterns

Another useful aspect of BridgeDb is that it knows about the patterns of identifiers. If this
pattern is unique enough, it can be used used to automatically find the data sources that
match a particular identifier. For example:

```
getMatchingSources("HMDB00555")
```

```
##  [1] "HGNC"                             "NCI Pathway Interaction Database"
##  [3] "EMBL"                             "LipidBank"
##  [5] "GitHub"                           "HMDB"
##  [7] "NCBI Protein"                     "ICD-11"
##  [9] "SUPFAM"                           "Wikipedia"
## [11] "KEGG Pathway"                     "SWISS-MODEL"
## [13] "VMH metabolite"
```

```
getMatchingSources("ENSG00000100030")
```

```
##  [1] "HGNC"                             "NCI Pathway Interaction Database"
##  [3] "EMBL"                             "LipidBank"
##  [5] "GitHub"                           "NCBI Protein"
##  [7] "ICD-11"                           "Ensembl"
##  [9] "SUPFAM"                           "Wikipedia"
## [11] "SWISS-MODEL"                      "VMH metabolite"
## [13] "OpenTargets"
```

You may notice unexpected datasources in the results. That often means that the matcher
for the identifier structure for that resources is very general. For example, the identifier
for Wikipedia can be more or less any string.

## 2.4 Identifier Mapping Databases

The BridgeDb package primarily provides the software framework, and not identifier mapping
data. Identifier Mapping databases can be downloaded from various websites. The package
knows about the download location (provided by PathVisio), and we can query for all gene
product identifier mapping databases:

```
getBridgeNames()
```

## 2.5 Downloading

The package provides
a convenience method to download such identifier mapping databases. For example, we can save the
identifier mapping database for rat to the current folder with:

```
dbLocation <- getDatabase("Rattus norvegicus", location = getwd())
```

The dbLocation variable then contains the location of the identifier mapping file that was
downloaded.

Mapping databases can also be manually downloaded for genes, metabolites, and gene variants
from <https://bridgedb.github.io/data/gene_database/>:

* Genes, Transcripts, and Proteins
* Metabolites
* Metabolic Interactions

Add the dbLocation with the following lines (first obtain in which folder, aka working directory ‘wd’, you are currently).
Add the correct folder location at the dots:

```
getwd()
dbLocation <- ("/home/..../BridgeDb/wikidata_diseases.bridge")
```

## 2.6 Loading Databases

Once you have downloaded an identifier mapping database, either manually or via the `getDatabase()`
method, you need to load the database for the identifier mappings to become available.
It is important to note that the location given to the `loadDatabase()` method is ideally
an absolute path.

```
mapper <- loadDatabase(dbLocation)
```

# 3 Mapping Identifiers

With a loaded database, identifiers can be mapped. The mapping method uses system codes. So, to
map the human Entrez Gene identifier (system code: L) 196410 to Affy identifiers (system code: X) we
use:

```
location <- getDatabase("Homo sapiens")
mapper <- loadDatabase(location)
map(mapper, "L", "196410", "X")
```

## 3.1 Using compact resource identifiers

The `map()` function also has support for compact resource identifiers (CURIEs) as explained
in the Bioregistry.io paper (Hoyt et al. [2022](#ref-Hoyt2022)). The previous example would then be as follows,
where `ncbigene` is the Bioregistry.io prefix matching the `L` data source:

```
location <- getDatabase("Homo sapiens")
mapper <- loadDatabase(location)
map(mapper, compactIdentifier="ncbigene:196410", "X")
```

## 3.2 Mapping multiple identifiers

For mapping multiple identifiers, for example in a data frame, you can use the new “maps()”
convenience method. Let’s assume we have a data frame, data, with a HMDB identifier in the second column,
we can get Wikidata identifiers with this code:

```
input <- data.frame(
    source = rep("Ch", length(data[, 2])),
    identifier = data[, 2]
)
wikidata <- maps(mapper, input, "Wd")
```

# 4 Metabolomics

While you can download the gene and protein identifier mapping databases with the *getDatabase()* method,
this mapping database cannot be used for metabolites. The mapping database for metabolites will have to
be downloaded manually from Figshare, e.g. the
[February 2018 release](https://figshare.com/articles/Metabolite_BridgeDb_ID_Mapping_Database_20180201_/5845134)
version. A full overview of mappings files can be found in this
[Figshare collection](https://figshare.com/collections/Metabolite_BridgeDb_ID_Mapping_Database/4456148).

Each mapping file record will allow you to download the *.bridge* file with the mappings.

If reproducibility is important to you, you can download the file with (mind you, these files are
quite large):

```
## Set the working directory to download the Metabolite mapping file
location <- "data/metabolites.bridge"
checkfile <- paste0(getwd(), "/", location)

## Download the Metabolite mapping file (if it doesn't exist locally yet):
if (!file.exists(checkfile)) {
    download.file(
        "https://figshare.com/ndownloader/files/26001794",
        location
    )
}
# Load the ID mapper:
mapper <- BridgeDbR::loadDatabase(checkfile)
```

With this mapper you can then map metabolite identifiers:

```
map(mapper, "456", source = "Cs", target = "Ck")
```

# References

Hoyt, Charles Tapley, Meghan Balk, Tiffany J. Callahan, Daniel Domingo-Fernández, Melissa A. Haendel, Harshad B. Hegde, Daniel S. Himmelstein, et al. 2022. “Unifying the Identification of Biomedical Entities with the Bioregistry.” *Scientific Data* 9 (1). <https://doi.org/10.1038/S41597-022-01807-3>.

Iersel, Martijn van, Alexander Pico, Thomas Kelder, Jianjiong Gao, Isaac Ho, Kristina Hanspers, Bruce Conklin, and Chris Evelo. 2010. “The BridgeDb Framework: Standardized Access to Gene, Protein and Metabolite Identifier Mapping Services.” *BMC Bioinformatics* 11 (1): 5+. <https://doi.org/10.1186/1471-2105-11-5>.

Iersel, Martijn P. van, Thomas Kelder, Alexander R. Pico, Kristina Hanspers, Susan Coort, Bruce R. Conklin, and Chris Evelo. n.d. “Presenting and exploring biological pathways with PathVisio.” Article. *BMC Bioinformatics* 9. <https://doi.org/10.1186/1471-2105-9-399>.

Pico, Alexander R., Thomas Kelder, Martijn P. van Iersel, Kristina Hanspers, Bruce R. Conklin, and Chris Evelo. 2008. “WikiPathways: Pathway Editing for the People.” *PLoS Biol* 6 (7): e184+. <https://doi.org/10.1371/journal.pbio.0060184>.

# Appendix

# A Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled running pandoc 2.7.3:

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8          LC_NUMERIC=C
##  [3] LC_TIME=en_GB                 LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8       LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8          LC_NAME=en_US.UTF-8
##  [9] LC_ADDRESS=en_US.UTF-8        LC_TELEPHONE=en_US.UTF-8
## [11] LC_MEASUREMENT=en_US.UTF-8    LC_IDENTIFICATION=en_US.UTF-8
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BridgeDbR_2.20.0 rJava_1.0-11     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] curl_7.0.0          evaluate_1.0.5      bslib_0.9.0
## [19] yaml_2.3.10         BiocManager_1.30.26 jsonlite_2.0.0
## [22] rlang_1.1.6
```