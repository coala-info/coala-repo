# Advanced Exploration of the SomaScan Menu

#### 24 April 2024

#### Package

SomaScan.db 0.99.10

# 1 Introduction

This vignette is a follow up to the “Introduction to SomaScan.db” vignette,
and will introduce more advanced capabilities of the `SomaScan.db`
package. Below we illustrate how `SomaScan.db` can be used to deeply
explore the SomaScan menu and execute complex annotation functions, outside of
the basic use of `select` outlined in the introductory vignette. Knowledge of
SQL is not required, but a familiarity with R and SomaScan data is highly
suggested. For an introduction to the `SomaScan.db` package and its
methods, please see `vignette("SomaScan-db", "SomaScan.db")`.

Please note that this vignette will require the installation and usage of
*three* additional Bioconductor R packages: *[GO.db](https://bioconductor.org/packages/3.19/GO.db)*,
*[EnsDb.Hsapiens.v75](https://bioconductor.org/packages/3.19/EnsDb.Hsapiens.v75)*, and *[KEGGREST](https://bioconductor.org/packages/3.19/KEGGREST)*.
Please see the linked pages to find installation instructions for these
packages.

```
library(GO.db)
library(KEGGREST)
library(org.Hs.eg.db)
library(SomaScan.db)
library(withr)
```

# 2 Incorporating Additional Annotations

## 2.1 Gene Ontology

The `SomaScan.db` package allows a user to retrieve Gene Ontology (GO)
identifiers associated with a particular SomaScan `SeqId` (or set of
`SeqIds`). However, the available GO annotations in `SomaScan.db` are
limited; only the GO ID, evidence code, and ontology category are currently
available. This helps prevent the package from accumulating an overwhelming
number of annotation elements, but limits the ability to extract detailed GO
information.

To illustrate this limitation, below we will display the GO terms associated
with the gene “IL31”:

```
il31_go <- select(SomaScan.db, keys = "IL31", keytype = "SYMBOL",
                  columns = c("PROBEID", "GO"))
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
il31_go
```

```
##   SYMBOL   PROBEID         GO EVIDENCE ONTOLOGY
## 1   IL31 10455-196 GO:0002376      IEA       BP
## 2   IL31 10455-196 GO:0005125      IBA       MF
## 3   IL31 10455-196 GO:0005126      IBA       MF
## 4   IL31 10455-196 GO:0005515      IPI       MF
## 5   IL31 10455-196 GO:0005576      TAS       CC
## 6   IL31 10455-196 GO:0005615      IBA       CC
## 7   IL31 10455-196 GO:0005615      IDA       CC
## 8   IL31 10455-196 GO:0007165      IEA       BP
```

In this data frame, IL31 maps to one single `SeqId` (“10455-196”), indicated
by the “PROBEID” column. This `SeqId` and gene are associated with seven
unique GO IDs (in the “GO” column). The GO knowledgebase is vast, however,
and these identifiers are not particularly informative for anyone who
hasn’t memorized their more descriptive term names. Additional details for
each ID would make this table more informative and interpretable. Luckily,
there are two options for retrieving such data:

1. Using an additional set of GO-specific methods to retrieve additional
   information for each GO ID (`Term`, `Ontology`, `Definition`, and
   `Synonym`)
2. Linking results from `SomaScan.db` with another Bioconductor tool, like
   the *[GO.db](https://bioconductor.org/packages/3.19/GO.db)* annotation package

Each of these techniques have their own special utility. Below, we will work
through examples of how the techniques described above can be used to link
GO information with the annotations from `SomaScan.db`.

---

### 2.1.1 GO Methods

The `Term`, `Ontology`, `Definition`, and `Synonym` methods are GO-specific
methods imported from the `AnnotationDbi` package. They are designed to
retrieve a single piece of information, indicated by the method name, that
corresponds to a set of GO identifiers (note: we will skip `Ontology` in this
vignette, as the GO Ontology is already retrievable with `SomaScan.db`).

The `Term` method retrieves a character string defining the role of the gene
product that corresponds to provided GO ID(s). In the example below, we will
retrieve the GO terms for each of the GO IDs in the `select` results generated
previously:

```
Term(il31_go$GO)
```

```
##                  GO:0002376                  GO:0005125
##     "immune system process"         "cytokine activity"
##                  GO:0005126                  GO:0005515
## "cytokine receptor binding"           "protein binding"
##                  GO:0005576                  GO:0005615
##      "extracellular region"       "extracellular space"
##                  GO:0005615                  GO:0007165
##       "extracellular space"       "signal transduction"
```

The `Definition` method retrieves a more detailed and extended definition of
the ontology for the input GO IDs:

```
Definition(il31_go$GO)
```

```
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        GO:0002376
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           "Any process involved in the development or functioning of the immune system, an organismal system for calibrated responses to potential internal or invasive threats."
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        GO:0005125
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             "The activity of a soluble extracellular gene product that interacts with a receptor to effect a change in the activity of the receptor to control the survival, growth, differentiation and effector function of tissues and cells."
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        GO:0005126
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 "Binding to a cytokine receptor."
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        GO:0005515
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           "Binding to a protein."
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        GO:0005576
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          "The space external to the outermost structure of a cell. For cells without external protective or external encapsulating structures this refers to space outside of the plasma membrane. This term covers the host cell environment outside an intracellular parasite."
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        GO:0005615
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "That part of a multicellular organism outside the cells proper, usually taken to be outside the plasma membranes, and occupied by fluid."
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        GO:0005615
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "That part of a multicellular organism outside the cells proper, usually taken to be outside the plasma membranes, and occupied by fluid."
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        GO:0007165
## "The cellular process in which a signal is conveyed to trigger a change in the activity or state of a cell. Signal transduction begins with reception of a signal (e.g. a ligand binding to a receptor or receptor activation by a stimulus such as light), or for signal transduction in the absence of ligand, signal-withdrawal or the activity of a constitutively active receptor. Signal transduction ends with regulation of a downstream cellular process, e.g. regulation of transcription or regulation of a metabolic process. Signal transduction covers signaling from receptors located on the surface of the cell and signaling via molecules located within the cell. For signaling between cells, signal transduction is restricted to events at and within the receiving cell."
```

And finally, the `Synonym` method can be used to retrieve other ontology terms
that are considered to be synonymous to the primary term attached to the GO
ID. For example, “type I programmed cell death” is considered synonymous with
“apoptosis”. It’s worth noting that `Synonym` can return a large set
of results, so we caution against providing a large set of GO IDs to `Synonym`:

```
Synonym(il31_go$GO)
```

```
## $<NA>
## NULL
##
## $`GO:0005125`
## [1] "autocrine activity" "paracrine activity"
##
## $`GO:0005126`
## [1] "hematopoietin/interferon-class (D200-domain) cytokine receptor binding"
## [2] "hematopoietin/interferon-class (D200-domain) cytokine receptor ligand"
##
## $`GO:0005515`
## [1] "GO:0001948"                 "GO:0045308"
## [3] "protein amino acid binding" "glycoprotein binding"
##
## $`GO:0005576`
## [1] "extracellular"
##
## $`GO:0005615`
## [1] "intercellular space"
##
## $`GO:0005615`
## [1] "intercellular space"
##
## $`GO:0007165`
##  [1] "GO:0023014"
##  [2] "GO:0023015"
##  [3] "GO:0023016"
##  [4] "GO:0023033"
##  [5] "GO:0023045"
##  [6] "signaling pathway"
##  [7] "signalling pathway"
##  [8] "signal transduction by cis-phosphorylation"
##  [9] "signal transduction by conformational transition"
## [10] "signal transduction by protein phosphorylation"
## [11] "signal transduction by trans-phosphorylation"
## [12] "signaling cascade"
## [13] "signalling cascade"
```

A GO synonym was not found for the first identifier in the provided vector,
so an `NA` was returned.

These functions are useful for quickly retrieving information for a given GO
ID, but you’ll notice that the results are returned as a vector or list,
rather than a data frame. Depending on the application, this may be
useful - for example, these methods are handy for on-the-fly GO
term or definition lookups, but their format can be cumbersome to incorporate
into a data frame created by `select`.

Let’s return to the `il31_go` data frame we generated previously. How can we
incorporate the additional information obtained by `Term`, `Definition`,
and `Synonym` into this object? Assuming the output is the same length as
the number of rows in `il31_go`, the character vector obtained by `Term`,
`Definition`, or `Synonym`, can be easily appended as a new column in the
`il31_go` data frame:

```
trms <- Term(il31_go$GO)
class(trms)
```

```
## [1] "character"
```

```
length(trms) == length(il31_go$GO)
```

```
## [1] TRUE
```

```
il31_go$TERM <- trms
il31_go
```

```
##   SYMBOL   PROBEID         GO EVIDENCE ONTOLOGY                      TERM
## 1   IL31 10455-196 GO:0002376      IEA       BP     immune system process
## 2   IL31 10455-196 GO:0005125      IBA       MF         cytokine activity
## 3   IL31 10455-196 GO:0005126      IBA       MF cytokine receptor binding
## 4   IL31 10455-196 GO:0005515      IPI       MF           protein binding
## 5   IL31 10455-196 GO:0005576      TAS       CC      extracellular region
## 6   IL31 10455-196 GO:0005615      IBA       CC       extracellular space
## 7   IL31 10455-196 GO:0005615      IDA       CC       extracellular space
## 8   IL31 10455-196 GO:0007165      IEA       BP       signal transduction
```

The same can be done with the output of `Definition`:

```
defs <- Definition(il31_go$GO)
class(defs)
```

```
## [1] "character"
```

```
length(defs) == length(il31_go$GO)
```

```
## [1] TRUE
```

```
il31_go$DEFINITION <- defs
il31_go[ ,c("SYMBOL", "PROBEID", "GO", "TERM", "DEFINITION")]
```

```
##   SYMBOL   PROBEID         GO                      TERM
## 1   IL31 10455-196 GO:0002376     immune system process
## 2   IL31 10455-196 GO:0005125         cytokine activity
## 3   IL31 10455-196 GO:0005126 cytokine receptor binding
## 4   IL31 10455-196 GO:0005515           protein binding
## 5   IL31 10455-196 GO:0005576      extracellular region
## 6   IL31 10455-196 GO:0005615       extracellular space
## 7   IL31 10455-196 GO:0005615       extracellular space
## 8   IL31 10455-196 GO:0007165       signal transduction
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        DEFINITION
## 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Any process involved in the development or functioning of the immune system, an organismal system for calibrated responses to potential internal or invasive threats.
## 2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             The activity of a soluble extracellular gene product that interacts with a receptor to effect a change in the activity of the receptor to control the survival, growth, differentiation and effector function of tissues and cells.
## 3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 Binding to a cytokine receptor.
## 4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Binding to a protein.
## 5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          The space external to the outermost structure of a cell. For cells without external protective or external encapsulating structures this refers to space outside of the plasma membrane. This term covers the host cell environment outside an intracellular parasite.
## 6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        That part of a multicellular organism outside the cells proper, usually taken to be outside the plasma membranes, and occupied by fluid.
## 7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        That part of a multicellular organism outside the cells proper, usually taken to be outside the plasma membranes, and occupied by fluid.
## 8 The cellular process in which a signal is conveyed to trigger a change in the activity or state of a cell. Signal transduction begins with reception of a signal (e.g. a ligand binding to a receptor or receptor activation by a stimulus such as light), or for signal transduction in the absence of ligand, signal-withdrawal or the activity of a constitutively active receptor. Signal transduction ends with regulation of a downstream cellular process, e.g. regulation of transcription or regulation of a metabolic process. Signal transduction covers signaling from receptors located on the surface of the cell and signaling via molecules located within the cell. For signaling between cells, signal transduction is restricted to events at and within the receiving cell.
```

However, this only works cleanly when the output is a character
vector with the same order and number of elements as the input vector.
With the list output of `Synonym`, the process is a little less
straightforward. In addition, it takes multiple steps to generate these
additional annotations and combine them with a `select` data frame.
Instead of performing so many steps, we can utilize another
Bionconductor annotation resource called *[GO.db](https://bioconductor.org/packages/3.19/GO.db)* to retrieve GO
annotation elements in a convenient data frame format.

---

### 2.1.2 GO.db

The *[GO.db](https://bioconductor.org/packages/3.19/GO.db)* R package contains annotations describing the entire
Gene Ontology knowledgebase, assembled using data directly from the
[GO website](http://geneontology.org/). *[GO.db](https://bioconductor.org/packages/3.19/GO.db)* provides a method
to easily retrieve the latest version of the Gene Ontology knowledgebase into
an R session. Like `SomaScan.db`, *[GO.db](https://bioconductor.org/packages/3.19/GO.db)* is an annotation
package that can be queried using the same five methods (`select`, `keys`,
`keytypes`, `columns`, and `mapIds`). By utilizing both `SomaScan.db` and
*[GO.db](https://bioconductor.org/packages/3.19/GO.db)*, it is possible to connect `SeqIds` to GO IDs, then add
additional GO annotations that are not available within `SomaScan.db`.

Let’s walk through an example. First, select a key (and corresponding
GO ID) to use as a starting point:

```
go_ids <- select(SomaScan.db, "IL3RA", keytype = "SYMBOL",
                 columns = c("GO", "SYMBOL"))
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
go_ids
```

```
##    SYMBOL         GO EVIDENCE ONTOLOGY
## 1   IL3RA GO:0004896      IBA       MF
## 2   IL3RA GO:0004912      IDA       MF
## 3   IL3RA GO:0005515      IPI       MF
## 4   IL3RA GO:0005886      NAS       CC
## 5   IL3RA GO:0005886      TAS       CC
## 6   IL3RA GO:0009897      IBA       CC
## 7   IL3RA GO:0019221      IBA       BP
## 8   IL3RA GO:0019955      IBA       MF
## 9   IL3RA GO:0036016      IEA       BP
## 10  IL3RA GO:0038156      IDA       BP
## 11  IL3RA GO:0043235      IBA       CC
```

As shown previously, the GO ID, EVIDENCE code, and ONTOLOGY comprise the
extent of GO information contained in `SomaScan.db`. However, we can use the
GO ID (in the `GO` column) to connect these values to the annotations in
*[GO.db](https://bioconductor.org/packages/3.19/GO.db)*:

```
columns(GO.db)
```

```
## [1] "DEFINITION" "GOID"       "ONTOLOGY"   "TERM"
```

```
go_defs <- select(GO.db, keys = go_ids$GO,
                  columns = c("GOID", "TERM", "DEFINITION"))
```

```
## 'select()' returned many:1 mapping between keys and columns
```

```
go_defs
```

```
##          GOID                                     TERM
## 1  GO:0004896               cytokine receptor activity
## 2  GO:0004912          interleukin-3 receptor activity
## 3  GO:0005515                          protein binding
## 4  GO:0005886                          plasma membrane
## 5  GO:0005886                          plasma membrane
## 6  GO:0009897         external side of plasma membrane
## 7  GO:0019221      cytokine-mediated signaling pathway
## 8  GO:0019955                         cytokine binding
## 9  GO:0036016       cellular response to interleukin-3
## 10 GO:0038156 interleukin-3-mediated signaling pathway
## 11 GO:0043235                         receptor complex
##                                                                                                                                                                                                  DEFINITION
## 1                                                                   Combining with a cytokine and transmitting the signal from one side of the membrane to the other to initiate a change in cell activity.
## 2                                                                Combining with interleukin-3 and transmitting the signal from one side of the membrane to the other to initiate a change in cell activity.
## 3                                                                                                                                                                                     Binding to a protein.
## 4                                                     The membrane surrounding a cell that separates the cell from its external environment. It consists of a phospholipid bilayer and associated proteins.
## 5                                                     The membrane surrounding a cell that separates the cell from its external environment. It consists of a phospholipid bilayer and associated proteins.
## 6                                                             The leaflet of the plasma membrane that faces away from the cytoplasm and any proteins embedded or anchored in it or attached to its surface.
## 7       The series of molecular signals initiated by the binding of a cytokine to a receptor on the surface of a cell, and ending with the regulation of a downstream cellular process, e.g. transcription.
## 8                Binding to a cytokine, any of a group of proteins that function to control the survival, growth and differentiation of tissues and cells, and which have autocrine and paracrine activity.
## 9                 Any process that results in a change in state or activity of a cell (in terms of movement, secretion, enzyme production, gene expression, etc.) as a result of an interleukin-3 stimulus.
## 10 The series of molecular signals initiated by interleukin-3 binding to its receptor on the surface of a target cell, and ending with the regulation of a downstream cellular process, e.g. transcription.
## 11                                                  Any protein complex that undergoes combination with a hormone, neurotransmitter, drug or intracellular messenger to initiate a change in cell function.
```

```
merge(go_ids, go_defs, by.x = "GO", by.y = "GOID")
```

```
##            GO SYMBOL EVIDENCE ONTOLOGY                                     TERM
## 1  GO:0004896  IL3RA      IBA       MF               cytokine receptor activity
## 2  GO:0004912  IL3RA      IDA       MF          interleukin-3 receptor activity
## 3  GO:0005515  IL3RA      IPI       MF                          protein binding
## 4  GO:0005886  IL3RA      NAS       CC                          plasma membrane
## 5  GO:0005886  IL3RA      NAS       CC                          plasma membrane
## 6  GO:0005886  IL3RA      TAS       CC                          plasma membrane
## 7  GO:0005886  IL3RA      TAS       CC                          plasma membrane
## 8  GO:0009897  IL3RA      IBA       CC         external side of plasma membrane
## 9  GO:0019221  IL3RA      IBA       BP      cytokine-mediated signaling pathway
## 10 GO:0019955  IL3RA      IBA       MF                         cytokine binding
## 11 GO:0036016  IL3RA      IEA       BP       cellular response to interleukin-3
## 12 GO:0038156  IL3RA      IDA       BP interleukin-3-mediated signaling pathway
## 13 GO:0043235  IL3RA      IBA       CC                         receptor complex
##                                                                                                                                                                                                  DEFINITION
## 1                                                                   Combining with a cytokine and transmitting the signal from one side of the membrane to the other to initiate a change in cell activity.
## 2                                                                Combining with interleukin-3 and transmitting the signal from one side of the membrane to the other to initiate a change in cell activity.
## 3                                                                                                                                                                                     Binding to a protein.
## 4                                                     The membrane surrounding a cell that separates the cell from its external environment. It consists of a phospholipid bilayer and associated proteins.
## 5                                                     The membrane surrounding a cell that separates the cell from its external environment. It consists of a phospholipid bilayer and associated proteins.
## 6                                                     The membrane surrounding a cell that separates the cell from its external environment. It consists of a phospholipid bilayer and associated proteins.
## 7                                                     The membrane surrounding a cell that separates the cell from its external environment. It consists of a phospholipid bilayer and associated proteins.
## 8                                                             The leaflet of the plasma membrane that faces away from the cytoplasm and any proteins embedded or anchored in it or attached to its surface.
## 9       The series of molecular signals initiated by the binding of a cytokine to a receptor on the surface of a cell, and ending with the regulation of a downstream cellular process, e.g. transcription.
## 10               Binding to a cytokine, any of a group of proteins that function to control the survival, growth and differentiation of tissues and cells, and which have autocrine and paracrine activity.
## 11                Any process that results in a change in state or activity of a cell (in terms of movement, secretion, enzyme production, gene expression, etc.) as a result of an interleukin-3 stimulus.
## 12 The series of molecular signals initiated by interleukin-3 binding to its receptor on the surface of a target cell, and ending with the regulation of a downstream cellular process, e.g. transcription.
## 13                                                  Any protein complex that undergoes combination with a hormone, neurotransmitter, drug or intracellular messenger to initiate a change in cell function.
```

Using this workflow, in just two steps we can link annotation information
*between* annotation package resources (i.e `SomaScan.db` <–> `GO.db`).

---

## 2.2 KEGG Pathways

Note that the same workflow *cannot* be performed for KEGG pathways,
due to KEGG’s data sharing policy. Instead, the package
*[KEGGREST](https://bioconductor.org/packages/3.19/KEGGREST)* must be used. Rather than an annotation database-style
package (like `SomaScan.db` and `GO.db`), *[KEGGREST](https://bioconductor.org/packages/3.19/KEGGREST)* is a package
that provides a client interface in R to the KEGG REST
(REpresentational State Transfer) server. For reference,
REST is an interface that two computer
systems can use to securely exchange information over the internet. Queries
made with the *[KEGGREST](https://bioconductor.org/packages/3.19/KEGGREST)* package retrieve information
directly from the online KEGG database.

Let’s take the same `select` query as we used for GO, but modify it to obtain
KEGG pathway identifiers instead:

```
kegg_sel <- select(SomaScan.db, keys = "CD86", keytype = "SYMBOL",
                   columns = c("PROBEID", "PATH"))
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
kegg_sel
```

```
##    SYMBOL PROBEID  PATH
## 1    CD86 5337-64 04514
## 2    CD86 5337-64 04620
## 3    CD86 5337-64 04672
## 4    CD86 5337-64 04940
## 5    CD86 5337-64 05320
## 6    CD86 5337-64 05322
## 7    CD86 5337-64 05323
## 8    CD86 5337-64 05330
## 9    CD86 5337-64 05332
## 10   CD86 5337-64 05416
## 11   CD86 6232-54 04514
## 12   CD86 6232-54 04620
## 13   CD86 6232-54 04672
## 14   CD86 6232-54 04940
## 15   CD86 6232-54 05320
## 16   CD86 6232-54 05322
## 17   CD86 6232-54 05323
## 18   CD86 6232-54 05330
## 19   CD86 6232-54 05332
## 20   CD86 6232-54 05416
```

We can use the identifiers in the “PATH” column to query the KEGG database
using `KEGGREST::keggGet()`:

```
# Add prefix indicating species (hsa = Homo sapiens)
hsa_names <- paste0("hsa", kegg_sel$PATH)

kegg_res <- keggGet(dbentries = hsa_names) |>
    setNames(hsa_names[1:10L]) # Setting names for results list
```

```
## Warning in keggGet(dbentries = hsa_names): More than 10 inputs supplied, only
## the first 10 results will be returned.
```

Because so much information is returned by `keggGet()`, a maximum number of 10
entries are allowed. Input exceeding 10 entries will be truncated, and only
the first 10 results will be returned (as indicated in the warning message
above). Let’s take a look at what was returned for each KEGG pathway:

```
str(kegg_res$hsa04514)
```

```
## List of 12
##  $ ENTRY      : Named chr "hsa04514"
##   ..- attr(*, "names")= chr "Pathway"
##  $ NAME       : chr "Cell adhesion molecules - Homo sapiens (human)"
##  $ DESCRIPTION: chr "Cell adhesion molecules (CAMs) are (glyco)proteins expressed on the cell surface and play a critical role in a "| __truncated__
##  $ CLASS      : chr "Environmental Information Processing; Signaling molecules and interaction"
##  $ PATHWAY_MAP: Named chr "Cell adhesion molecules"
##   ..- attr(*, "names")= chr "hsa04514"
##  $ DRUG       : chr [1:228] "D02800" "Alefacept (USAN/INN)" "D02811" "Alicaforsen sodium (USAN)" ...
##  $ DBLINKS    : chr "GO: 0050839"
##  $ ORGANISM   : Named chr "NA  Homo sapiens (human) [GN:hsa]"
##   ..- attr(*, "names")= chr "Homo sapiens (human) [GN:hsa]"
##  $ GENE       : chr [1:314] "965" "CD58; CD58 molecule [KO:K06492]" "914" "CD2; CD2 molecule [KO:K06449]" ...
##  $ REL_PATHWAY: Named chr [1:5] "Adherens junction" "Tight junction" "Complement and coagulation cascades" "T cell receptor signaling pathway" ...
##   ..- attr(*, "names")= chr [1:5] "hsa04520" "hsa04530" "hsa04610" "hsa04660" ...
##  $ KO_PATHWAY : chr "ko04514"
##  $ REFERENCE  :List of 25
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:14690046"
##   .. ..$ AUTHORS  : chr "Barclay AN."
##   .. ..$ TITLE    : chr "Membrane proteins with immunoglobulin-like domains--a master superfamily of interaction molecules."
##   .. ..$ JOURNAL  : chr [1:2] "Semin Immunol 15:215-23 (2003)" "DOI:10.1016/S1044-5323(03)00047-2"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:11910893"
##   .. ..$ AUTHORS  : chr "Sharpe AH, Freeman GJ."
##   .. ..$ TITLE    : chr "The B7-CD28 superfamily."
##   .. ..$ JOURNAL  : chr [1:2] "Nat Rev Immunol 2:116-26 (2002)" "DOI:10.1038/nri727"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:9597126"
##   .. ..$ AUTHORS  : chr "Grewal IS, Flavell RA."
##   .. ..$ TITLE    : chr "CD40 and CD154 in cell-mediated immunity."
##   .. ..$ JOURNAL  : chr [1:2] "Annu Rev Immunol 16:111-35 (1998)" "DOI:10.1146/annurev.immunol.16.1.111"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:16034094"
##   .. ..$ AUTHORS  : chr "Dardalhon V, Schubart AS, Reddy J, Meyers JH, Monney L, Sabatos CA, Ahuja R, Nguyen K, Freeman GJ, Greenfield E"| __truncated__
##   .. ..$ TITLE    : chr "CD226 is specifically expressed on the surface of Th1 cells and regulates their expansion and effector functions."
##   .. ..$ JOURNAL  : chr [1:2] "J Immunol 175:1558-65 (2005)" "DOI:10.4049/jimmunol.175.3.1558"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:12234363"
##   .. ..$ AUTHORS  : chr "Montoya MC, Sancho D, Vicente-Manzanares M, Sanchez-Madrid F."
##   .. ..$ TITLE    : chr "Cell adhesion and polarity during immune interactions."
##   .. ..$ JOURNAL  : chr [1:2] "Immunol Rev 186:68-82 (2002)" "DOI:10.1034/j.1600-065X.2002.18607.x"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:15071551"
##   .. ..$ AUTHORS  : chr "Dejana E."
##   .. ..$ TITLE    : chr "Endothelial cell-cell junctions: happy together."
##   .. ..$ JOURNAL  : chr [1:2] "Nat Rev Mol Cell Biol 5:261-70 (2004)" "DOI:10.1038/nrm1357"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:14519386"
##   .. ..$ AUTHORS  : chr "Bazzoni G."
##   .. ..$ TITLE    : chr "The JAM family of junctional adhesion molecules."
##   .. ..$ JOURNAL  : chr [1:2] "Curr Opin Cell Biol 15:525-30 (2003)" "DOI:10.1016/S0955-0674(03)00104-2"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:10798271"
##   .. ..$ AUTHORS  : chr "Becker BF, Heindl B, Kupatt C, Zahler S."
##   .. ..$ TITLE    : chr "Endothelial function and hemostasis."
##   .. ..$ JOURNAL  : chr [1:2] "Z Kardiol 89:160-7 (2000)" "DOI:10.1007/PL00007320"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:9150551"
##   .. ..$ AUTHORS  : chr "Elangbam CS, Qualls CW Jr, Dahlgren RR."
##   .. ..$ TITLE    : chr "Cell adhesion molecules--update."
##   .. ..$ JOURNAL  : chr [1:2] "Vet Pathol 34:61-73 (1997)" "DOI:10.1177/030098589703400113"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:12810109"
##   .. ..$ AUTHORS  : chr "Muller WA."
##   .. ..$ TITLE    : chr "Leukocyte-endothelial-cell interactions in leukocyte transmigration and the inflammatory response."
##   .. ..$ JOURNAL  : chr [1:2] "Trends Immunol 24:327-34 (2003)" "DOI:10.1016/S1471-4906(03)00117-0"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:14519398"
##   .. ..$ AUTHORS  : chr "Yamagata M, Sanes JR, Weiner JA."
##   .. ..$ TITLE    : chr "Synaptic adhesion molecules."
##   .. ..$ JOURNAL  : chr [1:2] "Curr Opin Cell Biol 15:621-32 (2003)" "DOI:10.1016/S0955-0674(03)00107-8"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:15882774"
##   .. ..$ AUTHORS  : chr "Ethell IM, Pasquale EB."
##   .. ..$ TITLE    : chr "Molecular mechanisms of dendritic spine development and remodeling."
##   .. ..$ JOURNAL  : chr [1:2] "Prog Neurobiol 75:161-205 (2005)" "DOI:10.1016/j.pneurobio.2005.02.003"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:11050419"
##   .. ..$ AUTHORS  : chr "Benson DL, Schnapp LM, Shapiro L, Huntley GW."
##   .. ..$ TITLE    : chr "Making memories stick: cell-adhesion molecules in synaptic plasticity."
##   .. ..$ JOURNAL  : chr [1:2] "Trends Cell Biol 10:473-82 (2000)" "DOI:10.1016/S0962-8924(00)01838-9"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:11860281"
##   .. ..$ AUTHORS  : chr "Rosdahl JA, Mourton TL, Brady-Kalnay SM."
##   .. ..$ TITLE    : chr "Protein kinase C delta (PKCdelta) is required for protein tyrosine phosphatase mu (PTPmu)-dependent neurite outgrowth."
##   .. ..$ JOURNAL  : chr [1:2] "Mol Cell Neurosci 19:292-306 (2002)" "DOI:10.1006/mcne.2001.1071"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:10964748"
##   .. ..$ AUTHORS  : chr "Dunican DJ, Doherty P."
##   .. ..$ TITLE    : chr "The generation of localized calcium rises mediated by cell adhesion molecules and their role in neuronal growth cone motility."
##   .. ..$ JOURNAL  : chr [1:2] "Mol Cell Biol Res Commun 3:255-63 (2000)" "DOI:10.1006/mcbr.2000.0225"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:12367625"
##   .. ..$ AUTHORS  : chr "Girault JA, Peles E."
##   .. ..$ TITLE    : chr "Development of nodes of Ranvier."
##   .. ..$ JOURNAL  : chr [1:2] "Curr Opin Neurobiol 12:476-85 (2002)" "DOI:10.1016/S0959-4388(02)00370-7"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:10664064"
##   .. ..$ AUTHORS  : chr "Arroyo EJ, Scherer SS."
##   .. ..$ TITLE    : chr "On the molecular architecture of myelinated fibers."
##   .. ..$ JOURNAL  : chr [1:2] "Histochem Cell Biol 113:1-18 (2000)" "DOI:10.1007/s004180050001"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:14556710"
##   .. ..$ AUTHORS  : chr "Salzer JL."
##   .. ..$ TITLE    : chr "Polarized domains of myelinated axons."
##   .. ..$ JOURNAL  : chr [1:2] "Neuron 40:297-318 (2003)" "DOI:10.1016/S0896-6273(03)00628-7"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:15561584"
##   .. ..$ AUTHORS  : chr "Irie K, Shimizu K, Sakisaka T, Ikeda W, Takai Y."
##   .. ..$ TITLE    : chr "Roles and modes of action of nectins in cell-cell adhesion."
##   .. ..$ JOURNAL  : chr [1:2] "Semin Cell Dev Biol 15:643-56 (2004)" "DOI:10.1016/j.semcdb.2004.09.002"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:15551862"
##   .. ..$ AUTHORS  : chr "Nakanishi H, Takai Y."
##   .. ..$ TITLE    : chr "Roles of nectins in cell adhesion, migration and polarization."
##   .. ..$ JOURNAL  : chr [1:2] "Biol Chem 385:885-92 (2004)" "DOI:10.1515/BC.2004.116"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:15115723"
##   .. ..$ AUTHORS  : chr "Siu MK, Cheng CY."
##   .. ..$ TITLE    : chr "Extracellular matrix: recent advances on its role in junction dynamics in the seminiferous epithelium during spermatogenesis."
##   .. ..$ JOURNAL  : chr [1:2] "Biol Reprod 71:375-91 (2004)" "DOI:10.1095/biolreprod.104.028225"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:15056568"
##   .. ..$ AUTHORS  : chr "Lee NP, Cheng CY."
##   .. ..$ TITLE    : chr "Adaptors, junction dynamics, and spermatogenesis."
##   .. ..$ JOURNAL  : chr [1:2] "Biol Reprod 71:392-404 (2004)" "DOI:10.1095/biolreprod.104.027268"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:15728677"
##   .. ..$ AUTHORS  : chr "Inagaki M, Irie K, Ishizaki H, Tanaka-Okamoto M, Morimoto K, Inoue E, Ohtsuka T, Miyoshi J, Takai Y."
##   .. ..$ TITLE    : chr "Roles of cell-adhesion molecules nectin 1 and nectin 3 in ciliary body development."
##   .. ..$ JOURNAL  : chr [1:2] "Development 132:1525-37 (2005)" "DOI:10.1242/dev.01697"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:12500939"
##   .. ..$ AUTHORS  : chr "Marthiens V, Gavard J, Lambert M, Mege RM."
##   .. ..$ TITLE    : chr "Cadherin-based cell adhesion in neuromuscular development."
##   .. ..$ JOURNAL  : chr [1:2] "Biol Cell 94:315-26 (2002)" "DOI:10.1016/S0248-4900(02)00005-9"
##   ..$ :List of 4
##   .. ..$ REFERENCE: chr "PMID:15923648"
##   .. ..$ AUTHORS  : chr "Krauss RS, Cole F, Gaio U, Takaesu G, Zhang W, Kang JS."
##   .. ..$ TITLE    : chr "Close encounters: regulation of vertebrate skeletal myogenesis by cell-cell contact."
##   .. ..$ JOURNAL  : chr [1:2] "J Cell Sci 118:2355-62 (2005)" "DOI:10.1242/jcs.02397"
```

Some additional data manipulation will be required to extract the desired
information from the results of `keggGet()`. Let’s just extract the pathway
name (`NAME`):

```
kegg_names <- vapply(kegg_res, `[[`, i = "NAME", "", USE.NAMES = FALSE)

kegg_names
```

```
##  [1] "Cell adhesion molecules - Homo sapiens (human)"
##  [2] "Toll-like receptor signaling pathway - Homo sapiens (human)"
##  [3] "Intestinal immune network for IgA production - Homo sapiens (human)"
##  [4] "Type I diabetes mellitus - Homo sapiens (human)"
##  [5] "Autoimmune thyroid disease - Homo sapiens (human)"
##  [6] "Systemic lupus erythematosus - Homo sapiens (human)"
##  [7] "Rheumatoid arthritis - Homo sapiens (human)"
##  [8] "Allograft rejection - Homo sapiens (human)"
##  [9] "Graft-versus-host disease - Homo sapiens (human)"
## [10] "Viral myocarditis - Homo sapiens (human)"
```

Now we can append this vector to our original results from `select`:

```
kegg_sel$PATHNAME <- kegg_names

kegg_sel
```

```
##    SYMBOL PROBEID  PATH
## 1    CD86 5337-64 04514
## 2    CD86 5337-64 04620
## 3    CD86 5337-64 04672
## 4    CD86 5337-64 04940
## 5    CD86 5337-64 05320
## 6    CD86 5337-64 05322
## 7    CD86 5337-64 05323
## 8    CD86 5337-64 05330
## 9    CD86 5337-64 05332
## 10   CD86 5337-64 05416
## 11   CD86 6232-54 04514
## 12   CD86 6232-54 04620
## 13   CD86 6232-54 04672
## 14   CD86 6232-54 04940
## 15   CD86 6232-54 05320
## 16   CD86 6232-54 05322
## 17   CD86 6232-54 05323
## 18   CD86 6232-54 05330
## 19   CD86 6232-54 05332
## 20   CD86 6232-54 05416
##                                                               PATHNAME
## 1                       Cell adhesion molecules - Homo sapiens (human)
## 2          Toll-like receptor signaling pathway - Homo sapiens (human)
## 3  Intestinal immune network for IgA production - Homo sapiens (human)
## 4                      Type I diabetes mellitus - Homo sapiens (human)
## 5                    Autoimmune thyroid disease - Homo sapiens (human)
## 6                  Systemic lupus erythematosus - Homo sapiens (human)
## 7                          Rheumatoid arthritis - Homo sapiens (human)
## 8                           Allograft rejection - Homo sapiens (human)
## 9                     Graft-versus-host disease - Homo sapiens (human)
## 10                            Viral myocarditis - Homo sapiens (human)
## 11                      Cell adhesion molecules - Homo sapiens (human)
## 12         Toll-like receptor signaling pathway - Homo sapiens (human)
## 13 Intestinal immune network for IgA production - Homo sapiens (human)
## 14                     Type I diabetes mellitus - Homo sapiens (human)
## 15                   Autoimmune thyroid disease - Homo sapiens (human)
## 16                 Systemic lupus erythematosus - Homo sapiens (human)
## 17                         Rheumatoid arthritis - Homo sapiens (human)
## 18                          Allograft rejection - Homo sapiens (human)
## 19                    Graft-versus-host disease - Homo sapiens (human)
## 20                            Viral myocarditis - Homo sapiens (human)
```

Other pieces of information can be extracted to the list and reduced to a
character vector or used to build a data frame, which can then be appended to
or merged similar to the pathway name in the code chunks above. For more
details about what can be done with the package, see *[KEGGREST](https://bioconductor.org/packages/3.19/KEGGREST)*.

# 3 Positional Annotation

Similar to the extended GO annotation in the previous section, positional
annotation cannot currently be performed within `SomaScan.db`.
`SomaScan.db` is a platform-centric annotation package, built around the
probes of the SomaScan protein assay, and positional annotation is not
within its scope. However, it *is* possible to retrieve positional
annotations by linking to other Bioconductor annotation resources, which can
then be combined with `SomaScan.db` in a two-step process (similar to above).
The first step uses `SomaScan.db` to retrieve gene-level information
corresponding to SomaScan analytes; the second requires a human transcriptome
or organism-centric annotation package to retrieve the desired chromosomal
locations.

We will provide a brief example of this using the popular organism-centric
package, *[EnsDb.Hsapiens.v75](https://bioconductor.org/packages/3.19/EnsDb.Hsapiens.v75)*, which contains a database of human
annotations derived from `Ensembl release 75`. However, this procedure can
also be performed using transcriptome-centric annotation packages like
*[TxDb.Hsapiens.UCSC.hg19.knownGene](https://bioconductor.org/packages/3.19/TxDb.Hsapiens.UCSC.hg19.knownGene)*.

Let’s say we are interested in collecting position information
associated with the protein target corresponding to `SeqId = 11138-16`.
First, we must determine which gene this `SeqId` maps to:

```
pos_sel <- select(SomaScan.db, "11138-16", columns = c("SYMBOL", "GENENAME",
                                                       "ENTREZID", "ENSEMBL"))
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
pos_sel
```

```
##    PROBEID SYMBOL                           GENENAME ENTREZID         ENSEMBL
## 1 11138-16  RUNX3 RUNX family transcription factor 3      864 ENSG00000020633
```

We now know this probe targets protein encoded by the RUNX3
gene. We can use *[EnsDb.Hsapiens.v75](https://bioconductor.org/packages/3.19/EnsDb.Hsapiens.v75)* to retrieve positional
information about RUNX3, like which chromosome the
RUNX3 is on, its start and stop position, and how many exons it
has (at the time of Ensembl’s `v75` release):

```
# Install package from Bioconductor, if not already installed
if (!require("EnsDb.Hsapiens.v75", quietly = TRUE)) {
    BiocManager::install("EnsDb.Hsapiens.v75")
}

# The central keys of the organism-level database are the Ensembl gene ID
keys(EnsDb.Hsapiens.v75)[1:10L]

# Also contains the Ensembl gene ID, so this column can be used for merging
grep("ENSEMBL", columns(SomaScan.db), value = TRUE)

# These columns will inform us as to what positional information we can
# retrieve from the organism-level database
columns(EnsDb.Hsapiens.v75)

# Build a query to retrieve the prot IDs and start/stop pos of protein domains
pos_res <- select(EnsDb.Hsapiens.v75, keys = "ENSG00000020633",
                  columns = c("GENEBIOTYPE", "SEQCOORDSYSTEM", "GENEID",
                              "PROTEINID", "PROTDOMSTART", "PROTDOMEND"))

# Merge back into `pos_sel` using the "GENEID" column
merge(pos_sel, pos_res, by.x = "ENSEMBL", by.y = "GENEID")
```

# 4 Functional Group Representation

As mentioned in the Introductory Vignette (`vignette("SomaScan-db", package = "SomaScan.db")`),
the `SomaScan.db` annotation database can be queried using values other than
the central database key, the `SeqId` (i.e. the “PROBEID” column). This
section will describe additional methods of retrieving information from the
database without using the `SeqId`.

---

## 4.1 GO Term Coverage

The annotations in `SomaScan.db` can be used to answer general questions about
SomaScan, without the need for a SomaScan dataset/ADAT file as a starting
point. For example, if one were interested in proteins involved in cancer
progression and metastasis (and therefore cell adhesion), is the SomaScan
menu capable of measuring proteins involved in cell adhesion? If so, how
many of these proteins can be measured with SomaScan?

We can answer this by examining the coverage of the GO term
“cell adhesion” in both the 5k and 7k SomaScan menus. We don’t need the
GO identifier to get started, as that information can be retrieved from
`GO.db` using the name of the term as the key:

```
select(GO.db, keys = "cell adhesion", keytype = "TERM",
       columns = c("GOID", "TERM"))
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##            TERM       GOID
## 1 cell adhesion GO:0007155
```

Now that we have the GO ID, we can search in `SomaScan.db` to determine
how many `SeqIds` are associated with cell adhesion.

```
cellAd_ids <- select(SomaScan.db, keys = "GO:0007155", keytype = "GO",
                     columns = "PROBEID", "UNIPROTID")
```

```
## The 'menu' argument can only be used when 'keytype = 'PROBEID''. The results of this query will contain all analytes from the 11k menu.
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
head(cellAd_ids, n = 10L)
```

```
##            GO   PROBEID EVIDENCE ONTOLOGY
## 1  GO:0007155  10037-98      IBA       BP
## 2  GO:0007155  10511-10      IEA       BP
## 3  GO:0007155  10521-10      IEA       BP
## 4  GO:0007155  10539-30      IEA       BP
## 5  GO:0007155  10558-26      IBA       BP
## 6  GO:0007155   10702-1      IBA       BP
## 7  GO:0007155 10748-216      IBA       BP
## 8  GO:0007155 10907-116      IEA       BP
## 9  GO:0007155  10980-11      IDA       BP
## 10 GO:0007155  11067-13      NAS       BP
```

```
# Total number of SeqIds associated with cell adhesion
unique(cellAd_ids$PROBEID) |> length()
```

```
## [1] 451
```

There are 451 unique `SeqIds` associated
with the “cell adhesion” GO term (*unique* is important here because the data
frame above may contain multiple entries per `SeqId`, due to the “EVIDENCE”
column). There are 10731 total `SeqIds` in the
`SomaScan.db` database, so
4.2%
of keys in the database are associated with cell adhesion.

How many of the *total* proteins in the cell adhesion GO term are covered by
the SomaScan menu? To answer this question, we first must use another
annotation package, `org.Hs.eg.db`, to retrieve a list of all human
UniProt IDs associated with the “cell adhesion” GO term.

```
cellAd_prots <- select(org.Hs.eg.db,
                       keys = "GO:0007155",
                       keytype = "GO",
                       columns = "UNIPROT")
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
# Again, we take the unique set of proteins
length(unique(cellAd_prots$UNIPROT))
```

```
## [1] 3294
```

The GO term `GO:0007155` (cell adhesion) contains a total of
3294 unique human UniProt IDs. Now we
can check to see how many of these are covered by the SomaScan menu by
searching for the proteins in `SomaScan.db` with `select`:

```
cellAd_covProts <- select(SomaScan.db, keys = unique(cellAd_prots$UNIPROT),
                          keytype = "UNIPROT", columns = "PROBEID")
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
head(cellAd_covProts, n = 20L)
```

```
##    UNIPROT PROBEID
## 1   P42684 3342-76
## 2   P42684 5261-13
## 3   A0M8X0 3342-76
## 4   A0M8X0 5261-13
## 5   B7UEF2 3342-76
## 6   B7UEF2 5261-13
## 7   B7UEF3 3342-76
## 8   B7UEF3 5261-13
## 9   B7UEF4 3342-76
## 10  B7UEF4 5261-13
## 11  B7UEF5 3342-76
## 12  B7UEF5 5261-13
## 13  Q5T0X6 3342-76
## 14  Q5T0X6 5261-13
## 15  Q5W0C5 3342-76
## 16  Q5W0C5 5261-13
## 17  Q6NZY6 3342-76
## 18  Q6NZY6 5261-13
## 19  Q7Z301 3342-76
## 20  Q7Z301 5261-13
```

`select` will return an `NA` value if a key is not found in the database. As
seen above, some proteins in `GO:0007155` do not map to a `SeqId` in
`SomaScan.db`. To get an accurate count of the proteins that *do* map to a
`SeqId`, we must remove the unmapped proteins by filtering out rows with `NA`
values:

```
cellAd_covProts <- cellAd_covProts[!is.na(cellAd_covProts$PROBEID),]

cellAd_covIDs <- unique(cellAd_covProts$UNIPROT)

length(cellAd_covIDs)
```

```
## [1] 2482
```

We removed duplicates from the list of proteins provided as keys, to get a
final count of 2482 proteins
(75.35%)
from the “cell adhesion” GO term that are covered by the SomaScan menu.

Does this number differ between versions of the SomaScan Menu? Remember that
the 7k menu contains *all* of the `SeqIds` in the 5k menu, so what this really
tells us is: were analytes targeting cell adhesion-related proteins added in
the 7k menu?

```
cellAd_menu <- lapply(c("5k", "7k"), function(x) {
    df <- select(SomaScan.db, keys = unique(cellAd_prots$UNIPROT),
                 keytype = "UNIPROT", columns = "PROBEID",
                 menu = x)

    # Again, removing probes that do not map to a cell adhesion protein
    df <- df[!is.na(df$PROBEID),]
}) |> setNames(c("somascan_5k", "somascan_7k"))
```

```
## The 'menu' argument can only be used when 'keytype = 'PROBEID''. The results of this query will contain all analytes from the 11k menu.
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
## The 'menu' argument can only be used when 'keytype = 'PROBEID''. The results of this query will contain all analytes from the 11k menu.
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
identical(cellAd_menu$somascan_5k, cellAd_menu$somascan_7k)
```

```
## [1] TRUE
```

In this example, the number of `SeqIds` associated with cell adhesion does
*not* differ between SomaScan menu versions (the list of `SeqIds` is
identical). The differences between menu versions can be explored with the
`menu` argument of `select`, or via the `somascan_menu` data object (this is
explained in the Introductory Vignette).

---

## 4.2 Gene Families

A number of gene families are targeted by reagents in the SomaScan assay. How
can these be interrogated using `SomaScan.db`? Is the package capable of
searching for/within specific gene families? The answer is yes, but
a specific function does not exist for analyzing gene families as a whole.
Instead, by using features of `select` and `keys`, `SomaScan.db` can
be queried for common features connecting gene families of interest - more
specifically, the `match=` argument of `select` and the `pattern=` argument of
`keys` can be used to retrieve gene family members that contain a common
pattern in their name.

The `keys` method is capable of using regular expressions (“regex”) to search
for keys in the database that contain a specific pattern of characters. This
feature is especially useful when looking for annotations for a gene family.
For example, a regex pattern can be used to retrieve a list of all IL17
receptor family genes in the database:

```
il17_family <- keys(SomaScan.db, keytype = "SYMBOL", pattern = "IL17")
```

Those keys can then be used to query the database with `select`:

```
select(SomaScan.db, keys = il17_family, keytype = "SYMBOL",
       columns = c("PROBEID", "UNIPROT", "GENENAME"))
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
##      SYMBOL  PROBEID    UNIPROT                  GENENAME
## 1     IL17A  13718-1     Q16552           interleukin 17A
## 2     IL17A  13718-1     Q5T2P0           interleukin 17A
## 3     IL17A  13718-1     Q6NZ94           interleukin 17A
## 4     IL17A  21897-4     Q16552           interleukin 17A
## 5     IL17A  21897-4     Q5T2P0           interleukin 17A
## 6     IL17A  21897-4     Q6NZ94           interleukin 17A
## 7     IL17A  31553-5     Q16552           interleukin 17A
## 8     IL17A  31553-5     Q5T2P0           interleukin 17A
## 9     IL17A  31553-5     Q6NZ94           interleukin 17A
## 10    IL17A  3498-53     Q16552           interleukin 17A
## 11    IL17A  3498-53     Q5T2P0           interleukin 17A
## 12    IL17A  3498-53     Q6NZ94           interleukin 17A
## 13    IL17A  9170-24     Q16552           interleukin 17A
## 14    IL17A  9170-24     Q5T2P0           interleukin 17A
## 15    IL17A  9170-24     Q6NZ94           interleukin 17A
## 16   IL17RA  2992-59     Q96F46 interleukin 17 receptor A
## 17   IL17RA  2992-59     O43844 interleukin 17 receptor A
## 18   IL17RA  2992-59     Q20WK1 interleukin 17 receptor A
## 19    IL17C  9255-13     Q3MIG8           interleukin 17C
## 20    IL17C  9255-13     Q9HC75           interleukin 17C
## 21    IL17C  9255-13     Q9P0M4           interleukin 17C
## 22    IL17C   9255-5     Q3MIG8           interleukin 17C
## 23    IL17C   9255-5     Q9HC75           interleukin 17C
## 24    IL17C   9255-5     Q9P0M4           interleukin 17C
## 25    IL17B 14022-17     Q9UHF5           interleukin 17B
## 26    IL17B 14022-17     Q14CE5           interleukin 17B
## 27    IL17B 14022-17     Q6IAG3           interleukin 17B
## 28    IL17B  3499-77     Q9UHF5           interleukin 17B
## 29    IL17B  3499-77     Q14CE5           interleukin 17B
## 30    IL17B  3499-77     Q6IAG3           interleukin 17B
## 31    IL17D  4136-40     B1AM69           interleukin 17D
## 32    IL17D  4136-40     Q8TAD2           interleukin 17D
## 33   IL17RD  3376-49     B4DXM5 interleukin 17 receptor D
## 34   IL17RD  3376-49     Q2NKP7 interleukin 17 receptor D
## 35   IL17RD  3376-49     Q58EZ7 interleukin 17 receptor D
## 36   IL17RD  3376-49     Q6RVF4 interleukin 17 receptor D
## 37   IL17RD  3376-49     Q6UWI5 interleukin 17 receptor D
## 38   IL17RD  3376-49     Q8N113 interleukin 17 receptor D
## 39   IL17RD  3376-49     Q8NFM7 interleukin 17 receptor D
## 40   IL17RD  3376-49     Q8NFS0 interleukin 17 receptor D
## 41   IL17RD  3376-49     Q9UFA0 interleukin 17 receptor D
## 42   IL17RB 35707-93     Q9BPZ0 interleukin 17 receptor B
## 43   IL17RB 35707-93     Q9NRL4 interleukin 17 receptor B
## 44   IL17RB 35707-93     Q9NRM5 interleukin 17 receptor B
## 45   IL17RB 35707-93     Q9NRM6 interleukin 17 receptor B
## 46   IL17RB 5084-154     Q9BPZ0 interleukin 17 receptor B
## 47   IL17RB 5084-154     Q9NRL4 interleukin 17 receptor B
## 48   IL17RB 5084-154     Q9NRM5 interleukin 17 receptor B
## 49   IL17RB 5084-154     Q9NRM6 interleukin 17 receptor B
## 50   IL17RB  6262-14     Q9BPZ0 interleukin 17 receptor B
## 51   IL17RB  6262-14     Q9NRL4 interleukin 17 receptor B
## 52   IL17RB  6262-14     Q9NRM5 interleukin 17 receptor B
## 53   IL17RB  6262-14     Q9NRM6 interleukin 17 receptor B
## 54   IL17RC  5468-67 A0A8Q3SJ19 interleukin 17 receptor C
## 55   IL17RC  5468-67     Q8NAC3 interleukin 17 receptor C
## 56   IL17RC  5468-67 A0A8Q3SIU5 interleukin 17 receptor C
## 57   IL17RC  5468-67 A0A8Q3SIV5 interleukin 17 receptor C
## 58   IL17RC  5468-67 A0A8Q3SJJ9 interleukin 17 receptor C
## 59   IL17RC  5468-67 A0A8Q3WM30 interleukin 17 receptor C
## 60   IL17RC  5468-67 A0A8Q3SJ01 interleukin 17 receptor C
## 61   IL17RC  5468-67     A8BWC1 interleukin 17 receptor C
## 62   IL17RC  5468-67     A8BWC9 interleukin 17 receptor C
## 63   IL17RC  5468-67     A8BWD5 interleukin 17 receptor C
## 64   IL17RC  5468-67     E9PHG1 interleukin 17 receptor C
## 65   IL17RC  5468-67     E9PHJ6 interleukin 17 receptor C
## 66   IL17RC  5468-67     Q6UVY3 interleukin 17 receptor C
## 67   IL17RC  5468-67     Q6UWD4 interleukin 17 receptor C
## 68   IL17RC  5468-67     Q8NFS1 interleukin 17 receptor C
## 69   IL17RC  5468-67     Q9BR97 interleukin 17 receptor C
## 70   IL17RC  5468-67     C9JSZ3 interleukin 17 receptor C
## 71    IL17F 14026-24     F1JZ09           interleukin 17F
## 72    IL17F 14026-24     Q6NSI0           interleukin 17F
## 73    IL17F 14026-24     Q7Z6P4           interleukin 17F
## 74    IL17F 14026-24     Q96PD4           interleukin 17F
## 75    IL17F 14026-24     Q96PI8           interleukin 17F
## 76    IL17F 14026-24     Q9NUE6           interleukin 17F
## 77    IL17F  21897-4     F1JZ09           interleukin 17F
## 78    IL17F  21897-4     Q6NSI0           interleukin 17F
## 79    IL17F  21897-4     Q7Z6P4           interleukin 17F
## 80    IL17F  21897-4     Q96PD4           interleukin 17F
## 81    IL17F  21897-4     Q96PI8           interleukin 17F
## 82    IL17F  21897-4     Q9NUE6           interleukin 17F
## 83    IL17F  2775-54     F1JZ09           interleukin 17F
## 84    IL17F  2775-54     Q6NSI0           interleukin 17F
## 85    IL17F  2775-54     Q7Z6P4           interleukin 17F
## 86    IL17F  2775-54     Q96PD4           interleukin 17F
## 87    IL17F  2775-54     Q96PI8           interleukin 17F
## 88    IL17F  2775-54     Q9NUE6           interleukin 17F
## 89    IL17F  31553-5     F1JZ09           interleukin 17F
## 90    IL17F  31553-5     Q6NSI0           interleukin 17F
## 91    IL17F  31553-5     Q7Z6P4           interleukin 17F
## 92    IL17F  31553-5     Q96PD4           interleukin 17F
## 93    IL17F  31553-5     Q96PI8           interleukin 17F
## 94    IL17F  31553-5     Q9NUE6           interleukin 17F
## 95   IL17RE 20535-68     B4DMZ3 interleukin 17 receptor E
## 96   IL17RE 20535-68     B2RB34 interleukin 17 receptor E
## 97   IL17RE 20535-68     B2RNR1 interleukin 17 receptor E
## 98   IL17RE 20535-68     B9EH65 interleukin 17 receptor E
## 99   IL17RE 20535-68     J3KQN7 interleukin 17 receptor E
## 100  IL17RE 20535-68     Q6P532 interleukin 17 receptor E
## 101  IL17RE 20535-68     Q8N8H7 interleukin 17 receptor E
## 102  IL17RE 20535-68     Q8N8H8 interleukin 17 receptor E
## 103  IL17RE 20535-68     Q8NFR9 interleukin 17 receptor E
## 104  IL17RE 20535-68     Q8TEC2 interleukin 17 receptor E
## 105 IL17REL     <NA>       <NA>                      <NA>
```

If multiple gene families are of interest, the `keys` argument of `select`
(in combination with `match=TRUE`) can support a regex pattern, and will
accomplish both of the previous steps in a single call:

```
select(SomaScan.db, keys = "NOTCH|ZF", keytype = "SYMBOL",
       columns = c("PROBEID", "SYMBOL", "GENENAME"), match = TRUE)
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
##       SYMBOL   PROBEID                                                GENENAME
## 1     NOTCH2  11297-54                                        notch receptor 2
## 2     NOTCH2   5106-52                                        notch receptor 2
## 3     NOTCH2   8407-84                                        notch receptor 2
## 4    ZFYVE27   13432-9                     zinc finger FYVE-type containing 27
## 5    ZFYVE27   9102-28                     zinc finger FYVE-type containing 27
## 6      ZFP91  13651-54 ZFP91 zinc finger protein, atypical E3 ubiquitin ligase
## 7       MZF1   14662-6                                   myeloid zinc finger 1
## 8     ZFAND5 18317-111                       zinc finger AN1-type containing 5
## 9     ZFAND1   19173-5                       zinc finger AN1-type containing 1
## 10    CREBZF   21134-9                      CREB/ATF bZIP transcription factor
## 11    ZFAND3  21875-31                       zinc finger AN1-type containing 3
## 12     ZFP42  22038-30                               ZFP42 zinc finger protein
## 13     ZFP36   22395-7                               ZFP36 ring finger protein
## 14   ZFAND2B   23319-6                      zinc finger AN1-type containing 2B
## 15   ZFYVE19   26166-2                     zinc finger FYVE-type containing 19
## 16    NOTCH4  26329-69                                        notch receptor 4
## 17     FEZF2 29288-262                                FEZ family zinc finger 2
## 18     ZFP37  29349-78                               ZFP37 zinc finger protein
## 19     VEZF1 29356-246                      vascular endothelial zinc finger 1
## 20    ZFP69B 29397-101                             ZFP69 zinc finger protein B
## 21     IKZF3 32719-135                             IKAROS family zinc finger 3
## 22 NOTCH2NLB   33381-1                               notch 2 N-terminal like B
## 23     ZFP57  33456-11                               ZFP57 zinc finger protein
## 24   ZFYVE21   33555-5                     zinc finger FYVE-type containing 21
## 25    ZFAND6  35258-74                       zinc finger AN1-type containing 6
## 26    NOTCH1    5107-7                                        notch receptor 1
## 27    NOTCH3   5108-72                                        notch receptor 3
```

The `GENENAME` column can also support a regex pattern, and can be used to
search for keywords that are associated with specific gene families (and
not just the gene symbols themselves). Examples include “homeobox”,
“zinc finger”, “notch”, etc.

```
select(SomaScan.db, keys = "homeobox", keytype = "GENENAME",
       columns = c("PROBEID", "SYMBOL"), match = TRUE)
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##        GENENAME   PROBEID SYMBOL
## 1  homeobox A11  22375-15 HOXA11
## 2   homeobox A5  22376-95  HOXA5
## 3  homeobox C11  22474-28 HOXC11
## 4   homeobox D4 22476-115  HOXD4
## 5   homeobox C9   28147-8  HOXC9
## 6  homeobox A10  28162-49 HOXA10
## 7   homeobox B6   28467-4  HOXB6
## 8   homeobox A9  28495-10  HOXA9
## 9   homeobox C6  28769-70  HOXC6
## 10  homeobox B7  29263-40  HOXB7
## 11  homeobox C5  29420-65  HOXC5
## 12  homeobox A7   30504-3  HOXA7
## 13 homeobox D10  33419-10 HOXD10
## 14  homeobox A6  33426-10  HOXA6
## 15  homeobox B8  33444-17  HOXB8
## 16  homeobox C8   33624-3  HOXC8
## 17  homeobox B1  34260-43  HOXB1
## 18  homeobox B4  34757-64  HOXB4
```

# 5 Session info

```
sessionInfo()
```

```
## R version 4.4.0 beta (2024-04-15 r86425)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 22.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.19-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] org.Hs.eg.db_3.19.1  KEGGREST_1.43.0      GO.db_3.19.1
##  [4] tibble_3.2.1         SomaScan.db_0.99.10  AnnotationDbi_1.65.2
##  [7] IRanges_2.37.1       S4Vectors_0.41.7     Biobase_2.63.1
## [10] BiocGenerics_0.49.1  withr_3.0.0          BiocStyle_2.31.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.9              utf8_1.2.4              RSQLite_2.3.6
##  [4] digest_0.6.35           magrittr_2.0.3          evaluate_0.23
##  [7] bookdown_0.39           fastmap_1.1.1           blob_1.2.4
## [10] jsonlite_1.8.8          GenomeInfoDb_1.39.14    DBI_1.2.2
## [13] BiocManager_1.30.22     httr_1.4.7              fansi_1.0.6
## [16] UCSC.utils_0.99.7       Biostrings_2.71.6       jquerylib_0.1.4
## [19] cli_3.6.2               rlang_1.1.3             crayon_1.5.2
## [22] XVector_0.43.1          bit64_4.0.5             cachem_1.0.8
## [25] yaml_2.3.8              tools_4.4.0             memoise_2.0.1
## [28] GenomeInfoDbData_1.2.12 curl_5.2.1              vctrs_0.6.5
## [31] R6_2.5.1                png_0.1-8               lifecycle_1.0.4
## [34] zlibbioc_1.49.3         bit_4.0.5               pkgconfig_2.0.3
## [37] bslib_0.7.0             pillar_1.9.0            glue_1.7.0
## [40] xfun_0.43               knitr_1.46              htmltools_0.5.8.1
## [43] rmarkdown_2.26          compiler_4.4.0
```