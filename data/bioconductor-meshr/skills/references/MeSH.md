# AnnotationHub-style MeSH ORA Framework from BioC 3.14

Koki Tsuyuzaki1, Gota Morota2, Manabu Ishii3, Takeru Nakazato4 and Itoshi Nikaido1\*

1Laboratory for Bioinformatics Research, RIKEN Center for Biosystems Dynamics Research
2Virginia Polytechnic Institute and State University
3Genome Analytics Japan
4Database Center for Life Science, Research Organization of Information and Systems

\*k.t.the-answer@hotmail.co.jp

#### 30 October 2025

#### Package

meshr 2.16.0

# Contents

* [1 What is MeSH?](#what-is-mesh)
* [2 What is MeSH ORA Framework?](#what-is-mesh-ora-framework)
* [3 Specification change of MeSH ORA Framework from BioC 3.14 (Nov. 2021)](#specification-change-of-mesh-ora-framework-from-bioc-3.14-nov.-2021)
* [4 Access to MeSH data on AnnotationHub](#access-to-mesh-data-on-annotationhub)
* [5 MeSH Enrichment Analysis](#mesh-enrichment-analysis)
* [Session Information](#session-information)

# 1 What is MeSH?

MeSH (Medical Subject Headings) is the NLM (U. S. National Library of Medicine) controlled vocabulary used to manually index articles for MEDLINE/PubMed111 S. J. Nelson and et al. The MeSH translation maintenance system: structure, interface design, and implementation. Stud. Health Technol. Inform., 107: 67-69, 2004. and is a collection of a comprehensive life science vocabulary.

![](data:image/png;base64...)

Figure 1 : MeSH Term

# 2 What is MeSH ORA Framework?

MeSH contains more than 25,000 clinical and biological terms. The amount of MeSH term is about twice as large as that of GO (Gene Ontology)222 M. Ashburner and et al. Gene ontology: tool for the unification of biology. The Gene Ontology Consortium. Nat. Genet., 25(1): 25-29, 2000. and its categories are also wider. Therefore MeSH is expected to be a much detailed and exhaustive gene annotation tool. In particular, MeSH can be an excellent source of information for minor species with small research populations and many genes that have not yet been functionally annotated.

Since BioC 2.14 (Apr. 2014), we have been distributing the information about MeSH itself (`MeSH.db`/`MeSH.AOR.db`/`MeSH.PCR.db`) and the correspondence between MeSH and genes of more than 100 species (`MeSH.XXX.eg.db`-type package) as annotation packages. We have also distributed a software package (*[MeSHDbi](https://bioconductor.org/packages/3.22/MeSHDbi)*) to define classes for the above annotation packages and to help users create their annotation packages, and a software package (*[meshr](https://bioconductor.org/packages/3.22/meshr)*) to perform enrichment analysis using the `MeSH.XXX.eg.db`-type package. Here, we call these MeSH-related packages MeSH ORA framework. Please refer to the previous vignette333 <https://bioconductor.org/packages/3.13/bioc/vignettes/meshr/inst/doc/MeSH.pdf> for the description of creating individual data packages.

# 3 Specification change of MeSH ORA Framework from BioC 3.14 (Nov. 2021)

The specifications of the MeSH ORA framework have changed significantly since BioC 3.14. Specifically, the distribution of all annotation packages will be abolished, and the policy has been switched to one where the data is placed on a cloud server called AnnotationHub, and users are allowed to retrieve the data only when they really need it. Note that this change will also change the specifications of all software packages that used the previous MeSH annotation packages, so backward compatibility will no longer be maintained.

The following are the advantages of this AnnotationHub-style.

* The installation time of the entire Bioconductor packages will be reduced.
* Old data will be archived.
* Data reproducibility is ensured (e.g. the version of the data can be specified, such as “v002”).

In the following sections, we will show you how to use the new AnnotationHub-style MeSH ORA framework. If you want to check the previous style of the MeSH ORA framework for some reason, please check the vignette of meshr in BioC 3.13444 <https://bioconductor.org/packages/3.13/bioc/vignettes/meshr/inst/doc/MeSH.pdf>.

# 4 Access to MeSH data on AnnotationHub

To access the MeSH datasets on AnnotationHub, we firstly install and load the *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* package.

```
library("AnnotationHub")
```

`AnnotationHub()` returns the metadata of all the data stored in the AnnotationHub server.

```
ah <- AnnotationHub()
```

`mcol()` reshapes the result of `ah` as follows.

```
head(mcols(ah))
```

`query()` returns the details of a specific entry of AnnotationHub. Note that this just returns the metadata and not actual data.

```
mcols(query(ah, c("MeSHDb", "MeSH.db", "v002")))
```

By specifying some keywords and adding [[1]] with the `query()`, `query()` downloads the data to our local machine. The internal data (SQLite files) of the previous MeSH annotation packages will be stored as a cache on our local machines by the *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* mechanism.

```
dbfile1 <- query(ah, c("MeSHDb", "MeSH.db", "v002"))[[1]]
dbfile2 <- query(ah, c("MeSHDb", "MeSH.AOR.db", "v002"))[[1]]
dbfile3 <- query(ah, c("MeSHDb", "MeSH.PCR.db", "v002"))[[1]]
dbfile4 <- query(ah, c("MeSHDb", "Danio rerio", "v002"))[[1]]
dbfile5 <- query(ah, c("MeSHDb", "Pseudomonas aeruginosa PAO1", "v002"))[[1]]
```

These SQLite files can be immediately converted into `MeSHDb` objects by running `MeSHDbi::MeSHDb` and can be used for the MeSH enrichment analysis described in the next section.

```
library("MeSHDbi")
MeSH.db <- MeSHDbi::MeSHDb(dbfile1)
MeSH.AOR.db <- MeSHDbi::MeSHDb(dbfile2)
MeSH.PCR.db <- MeSHDbi::MeSHDb(dbfile3)
MeSH.Dre.eg.db <- MeSHDbi::MeSHDb(dbfile4)
MeSH.Pae.PAO1.eg.db <- MeSHDbi::MeSHDb(dbfile5)
```

# 5 MeSH Enrichment Analysis

After the conversion of `MeSHDb` objects from SQLite files as described above, MeSH enrichment analysis can be performed by the *[meshr](https://bioconductor.org/packages/3.22/meshr)* package in much the same way as before BioC 3.13, as follows. For the details of MeSH enrichment analysis, please check the vignette of *[meshr](https://bioconductor.org/packages/3.22/meshr)* in BioC 3.13555 <https://bioconductor.org/packages/3.13/bioc/vignettes/meshr/inst/doc/MeSH.pdf>.

```
library("meshr")

# dummy geneids for demo
geneid <- keys(MeSH.Pae.PAO1.eg.db, keytype="GENEID")
set.seed(1234)
sig.geneid <- sample(geneid, 500)

meshParams <- new("MeSHHyperGParams",
    geneIds = sig.geneid,
    universeGeneIds = geneid,
    annotation = "MeSH.Pae.PAO1.eg.db",
    meshdb = "MeSH.db", # Newly added parameter from BioC 3.14
    category = "A",
    database = "Escherichia coli str. K-12 substr. MG1655",
    pvalueCutoff = 0.5, pAdjust = "BH")
meshR <- meshHyperGTest(meshParams)
```

One point to note is that previously only the `MeSH.XXX.eg.db`-type object had to be prepared in advance and specified as the `annotation` argument, but now due to the *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)*, `MeSH.db` object must also be prepared in advance and specified as a `meshdb` argument like above.

After performing MeSH enrichment analysis, we can check the result of the test by `summary()`.

```
head(summary(meshR))
```

Switching to test another MeSH category and database can be easily done. For example, to choose the category as `B` (Organisms) and the database as reciprocal BLAST best hit (RBBH) with Bacillus subtilis, we can do the following.

```
category(meshParams) <- "B"
database(meshParams) <- "Bacillus subtilis subsp. subtilis str. 168"
meshR <- meshHyperGTest(meshParams)
head(summary(meshR))
```

# Session Information

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```