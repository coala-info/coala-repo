# owlents: using OWL directly in ontoProc

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 30, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Illustration with Human Phenotype ontology](#illustration-with-human-phenotype-ontology)

# 1 Introduction

In Bioconductor 3.19, ontoProc can work with OWL RDF/XML
serializations of ontologies, via the
[owlready2](https://owlready2.readthedocs.io/en/v0.42/) python modules.

The `owl2cache` function retrieves OWL from a URL or file
and places it in a cache to avoid repetitious retrievals. The
default cache is the one defined by `BiocFileCache::BiocFileCache()`.
Here we work with the cell ontology. `setup_entities2` will use basilisk
to acquire
owlready2 python modules that parse the OWL and produce an `ontology_index` instance
(defined in CRAN package ontologyIndex).

```
library(ontoProc)
clont_path = owl2cache(url="http://purl.obolibrary.org/obo/cl.owl")
tmp = readLines(clont_path)
bad = grep("STATO_0000416", tmp)[1:2]  # see https://github.com/obophenotype/cell-ontology/issues/3237
tmp = tmp[-bad]
bad = grep("STATO_0000663", tmp)[1:2]  # see https://github.com/obophenotype/cell-ontology/issues/3237
tmp = tmp[-bad]
tf = tempfile()
writeLines(tmp, tf)
cle = setup_entities2(tf)
cle
```

```
## Ontology with 18718 terms
##
## Properties:
##  id: character
##  name: character
##  parents: list
##  children: list
##  ancestors: list
##  obsolete: logical
## Roots:
##  BFO_0000002 - continuant
##  BFO_0000003 - occurrent
##  SO_0000704 - NA
##  SO_0001260 - sequence_collection
##  CHEBI_18059 - lipid
##  CHEBI_25905 - peptide hormone
##  CHEBI_33822 - organic hydroxy compound
##  CHEBI_16646 - carbohydrate
##  CHEBI_33696 - nucleic acid
##  CHEBI_63299 - carbohydrate derivative
##  ... 352 more
```

The usual plotting approach works.

```
sel = c("CL_0000492", "CL_0001054", "CL_0000236",
"CL_0000625", "CL_0000576",
"CL_0000623", "CL_0000451", "CL_0000556")
onto_plot2(cle, sel)
```

![](data:image/png;base64...)

# 2 Illustration with Human Phenotype ontology

We’ll obtain and ad hoc selection of
15 UBERON term names and visualize
the hierarchy.

```
hpont_path = owl2cache(url="http://purl.obolibrary.org/obo/hp.owl")
```

```
## resource BFC451 already in cache from http://purl.obolibrary.org/obo/hp.owl
```

```
hpents = setup_entities2(hpont_path)
kp = grep("UBER", names(hpents$name), value=TRUE)[21:30]
onto_plot2(hpents, kp)
```

![](data:image/png;base64...)

The prefixes of class names in the ontology
give a sense of its scope.

```
t(t(table(sapply(strsplit(names(hpents$name), "_"), "[", 1))))
```

```
##
##          [,1]
##   CHEBI   1849
##   CL      1196
##   GO      2520
##   HP     19726
##   HsapDv    12
##   MPATH     75
##   NBO       64
##   PATO     570
##   PR       206
##   RO         1
##   UBERON  5641
```

To characterize human phenotypes ontologically,
CL, GO, CHEBI, and
UBERON play significant roles.