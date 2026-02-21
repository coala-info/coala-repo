# Functional analysis of mouse mammary gland RNA-Seq using fgsea instead of topGO

Aurelien Brionne1, Amelie Juanchich1 and Christelle Hennequet-Antier1

1Institut national de recherche pour l'agriculture, l'alimentation et l'environnement (INRAE)

#### 30 October, 2025

# Contents

* [Introduction](#introduction)
* [1 Genes of interest](#genes-of-interest)
* [2 GO annotation of genes](#go-annotation-of-genes)
* [3 Functional GO enrichment](#functional-go-enrichment)
  + [3.1 GO enrichment tests](#go-enrichment-tests)
  + [3.2 Combine enriched GO terms](#combine-enriched-go-terms)
* [References](#references)

# Introduction

In this vignette, we perform a functional Gene Set Enrichment Analysis (GSEA) from differential Expression analysis from genes of luminal cells in the mammary gland. (see `utils::vignette("mouse_bioconducor", package ="ViSEAGO")`)

# 1 Genes of interest

We load examples files from *[ViSEAGO](https://bioconductor.org/packages/3.22/ViSEAGO)* package using `system.file` from the locally installed package. We read gene identifiers (GeneID) and corresponding statistical values (BH padj) for all results.

in this example, gene identifiers were **ranked** based on the BH padj from Differential expression analysis.

```
# load gene identifiants and padj test results from Differential Analysis complete tables
PregnantvsLactate<-data.table::fread(
    system.file(
        "extdata/data/input",
        "pregnantvslactate.complete.txt",
        package = "ViSEAGO"
    ),
    select = c("Id","padj")
)

VirginvsLactate<-data.table::fread(
     system.file(
        "extdata/data/input",
        "virginvslactate.complete.txt",
        package = "ViSEAGO"
    ),
    select = c("Id","padj")
)

VirginvsPregnant<-data.table::fread(
    system.file(
        "extdata/data/input",
        "virginvspregnant.complete.txt",
        package = "ViSEAGO"
    ),
    select = c("Id","padj")
)

# rank Id based on statistical value (BH padj in this example)
data.table::setorder(PregnantvsLactate,padj)
data.table::setorder(VirginvsLactate,padj)
data.table::setorder(VirginvsPregnant,padj)
```

Here, we display the header from the *PregnantvsLactate* **ranked** data.table.

```
          Id         padj
       <int>        <num>
    1: 11941 1.722774e-09
    2: 12992 1.722774e-09
    3: 13358 1.722774e-09
    4: 13645 1.722774e-09
    5: 69219 1.836763e-09
   ---
15800: 79221 1.000000e+00
15801: 80979 1.000000e+00
15802: 83558 1.000000e+00
15803: 84111 1.000000e+00
15804: 97476 1.000000e+00
```

# 2 GO annotation of genes

In this study, we build a `myGENE2GO` object using the Bioconductor *[org.Mm.eg.db](https://bioconductor.org/packages/3.22/org.Mm.eg.db)* database package for the mouse species. This object contains all available GO annotations for categories Molecular Function (MF), Biological Process (BP), and Cellular Component (CC).

NB: Don’t forget to check if the last current annotation database version is installed in your R session! See `ViSEAGO::available_organisms(Bioconductor)`.

```
# connect to Bioconductor
Bioconductor<-ViSEAGO::Bioconductor2GO()

# load GO annotations from Bioconductor
myGENE2GO<-ViSEAGO::annotate(
    "org.Mm.eg.db",
    Bioconductor
)
```

```
# display summary
myGENE2GO
```

```
- object class: gene2GO
- database: Bioconductor
- stamp/version: 2019-Jul10
- organism id: org.Mm.eg.db

GO annotations:
- Molecular Function (MF): 22707 annotated genes with 91986 terms (4121 unique terms)
- Biological Process (BP): 23210 annotated genes with 164825 terms (12224 unique terms)
- Cellular Component (CC): 23436 annotated genes with 107852 terms (1723 unique terms)
```

# 3 Functional GO enrichment

## 3.1 GO enrichment tests

We perform a functional Gene Set Enrichment Analysis (GSEA) from differential Expression analysis from genes of luminal cells in the mammary gland.
Here, gene list were **ranked** based on the BH padj from Differential expression analysis.
The enriched **Biological process** (BP) are obtained using a GSEA test with `ViSEAGO::runfgsea`, which is a wrapper from algorithms developped in *[fgsea](https://bioconductor.org/packages/3.22/fgsea)* package [[1](#ref-fgsea)].
we perform the GO enrichment tests for BP category with `fgseaMultilevel`algorithm.

```
# perform fgseaMultilevel tests
BP_PregnantvsLactate<-ViSEAGO::runfgsea(
    geneSel=PregnantvsLactate,
    ont="BP",
    gene2GO=myGENE2GO,
    method ="fgseaMultilevel",
    params = list(
        scoreType = "pos",
         minSize=5
    )
)

BP_VirginvsLactate<-ViSEAGO::runfgsea(
    geneSel=VirginvsLactate,
    gene2GO=myGENE2GO,
    ont="BP",
    method ="fgseaMultilevel",
    params = list(
        scoreType = "pos",
         minSize=5
    )
)

BP_VirginvsPregnant<-ViSEAGO::runfgsea(
    geneSel=VirginvsPregnant,
    gene2GO=myGENE2GO,
    ont="BP",
    method ="fgseaMultilevel",
    params = list(
        scoreType = "pos",
         minSize=5
    )
)
```

## 3.2 Combine enriched GO terms

We combine the results of the three GSEA tests into an object using `ViSEAGO::merge_enrich_terms` method.

```
# merge fgsea results
BP_sResults<-ViSEAGO::merge_enrich_terms(
    cutoff=0.01,
    Input=list(
        PregnantvsLactate="BP_PregnantvsLactate",
        VirginvsLactate="BP_VirginvsLactate",
        VirginvsPregnant="BP_VirginvsPregnant"
    )
)
```

```
# display a summary
BP_sResults
```

```
- object class: enrich_GO_terms
- ontology: BP
- method: fgsea
- summary:
 PregnantvsLactate
    method : fgseaMultilevel
    sampleSize : 101
    minSize : 5
    maxSize : Inf
    eps : 0
    scoreType : pos
    nproc : 0
    gseaParam : 1
    BPPARAM : fgseaMultilevel
    absEps : 101
 VirginvsLactate
    method : fgseaMultilevel
    sampleSize : 101
    minSize : 5
    maxSize : Inf
    eps : 0
    scoreType : pos
    nproc : 0
    gseaParam : 1
    BPPARAM : fgseaMultilevel
    absEps : 101
 VirginvsPregnant
    method : fgseaMultilevel
    sampleSize : 101
    minSize : 5
    maxSize : Inf
    eps : 0
    scoreType : pos
    nproc : 0
    gseaParam : 1
    BPPARAM : fgseaMultilevel
    absEps : 101- enrichment pvalue cutoff:
        PregnantvsLactate : 0.01
        VirginvsLactate : 0.01
        VirginvsPregnant : 0.01
- enrich GOs (in at least one list): 184 GO terms of 3 conditions.
        PregnantvsLactate : 67 terms
        VirginvsLactate : 58 terms
        VirginvsPregnant : 64 terms
```

Now you can follow mouse bioconductor vignette for next steps beginning with *3.3 Graphs of GO enrichment tests* section (`utils::vignette("mouse_bioconducor", package ="ViSEAGO")`).

# References

1. Korotkevich G, Sukhov V, Sergushichev A. Fast gene set enrichment analysis. bioRxiv [Internet]. Cold Spring Harbor Labs Journals; 2019; <https://doi.org/10.1101/060012>