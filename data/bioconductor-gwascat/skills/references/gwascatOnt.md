# GWAS catalog: Phenotypes systematized by the experimental factor ontology

Vincent J. Carey, stvjc at channing.harvard.edu

#### August 2015

# Contents

* [1 Introduction](#introduction)
* [2 Views of the EFO](#views-of-the-efo)
* [3 Graph operations](#graph-operations)
* [4 Connections to the GWAS catalog](#connections-to-the-gwas-catalog)

# 1 Introduction

The EMBL-EBI curation of the GWAS catalog (originated at NHGRI)
includes labelings of GWAS hit records with terms from the EBI Experimental
Factor Ontology (EFO). The Bioconductor *[gwascat](https://bioconductor.org/packages/3.22/gwascat)*
package includes a *[graph](https://bioconductor.org/packages/3.22/graph)* representation of the ontology
and records the EFO assignments of GWAS results in its basic
representations of the catalog.

# 2 Views of the EFO

Term names are regimented.

```
library(gwascat)
requireNamespace("graph")
data(efo.obo.g)
efo.obo.g
```

```
## A graphNEL graph with directed edges
## Number of Nodes = 16331
## Number of Edges = 22186
```

```
sn = head(graph::nodes(efo.obo.g))
sn
```

```
## [1] "EFO:0000001" "BFO:0000007" "BFO:0000016" "BFO:0000019" "BFO:0000020"
## [6] "BFO:0000023"
```

The nodeData of the graph includes a `def` field.
We will process that to create a data.frame.

```
nd = graph::nodeData(efo.obo.g)
alldef = sapply(nd, function(x) unlist(x[["def"]]))
allnames = sapply(nd, function(x) unlist(x[["name"]]))
alld2 = sapply(alldef, function(x) if(is.null(x)) return(" ") else x[1])
mydf = data.frame(id = names(allnames), concept=as.character(allnames), def=unlist(alld2))
```

We can create an interactive data table for all terms, but for
performance we limit the table size to terms involving the string
‘autoimm’.

```
limdf = mydf[ grep("autoimm", mydf$def, ignore.case=TRUE), ]
requireNamespace("DT")
```

```
## Loading required namespace: DT
```

```
suppressWarnings({
DT::datatable(limdf, rownames=FALSE, options=list(pageLength=5))
})
```

# 3 Graph operations

The use of the graph representation allows various approaches
to traversal and selection. Here we examine metadata for a
term of interest, transform to an undirected graph, and obtain
the adjacency list for that term.

```
graph::nodeData(efo.obo.g, "EFO:0000540")
```

```
## $`EFO:0000540`
## $`EFO:0000540`$name
## $`EFO:0000540`$name[[1]]
## [1] "immune system disease"
##
##
## $`EFO:0000540`$def
## $`EFO:0000540`$def[[1]]
## [1] "\"A group of non-neoplastic and neoplastic disorders resulting from the deregulation and/or deficiency of immune system functions.  It includes autoimmune disorders (e.g., lupus erythematosus, dermatomyositis, rheumatoid arthritis), congenital and acquired immunodeficiency syndromes including the acquired immune deficiency syndrome (AIDS), and neoplasms (e.g., lymphomas and malignancies secondary to transplantation.)\" []"
##
##
## $`EFO:0000540`$xref
## NULL
```

```
ue = graph::ugraph(efo.obo.g)
neighISD = graph::adj(ue, "EFO:0000540")[[1]]
sapply(graph::nodeData(graph::subGraph(neighISD, efo.obo.g)), "[[", "name")
```

```
## $`EFO:0000408`
## [1] "disease"
##
## $`EFO:0000398`
## [1] "dermatomyositis"
##
## $`EFO:0000404`
## [1] "diffuse scleroderma"
##
## $`EFO:0000676`
## [1] "psoriasis"
##
## $`EFO:0000706`
## [1] "spondyloarthropathy"
##
## $`EFO:0000717`
## [1] "systemic scleroderma"
##
## $`EFO:0000783`
## [1] "myositis"
##
## $`EFO:0002498`
## [1] "aggressive insulitis"
##
## $`EFO:0002502`
## [1] "benign insulitis"
##
## $`EFO:0003775`
## [1] "Job's syndrome"
##
## $`EFO:0003778`
## [1] "psoriatic arthritis"
##
## $`EFO:0003785`
## [1] "allergy"
##
## $`EFO:0004246`
## [1] "mucocutaneous lymph node syndrome"
##
## $`EFO:0004599`
## [1] "acute graft vs. host disease"
##
## $`EFO:0004711`
## [1] "elephantiasis"
##
## $`EFO:0005140`
## [1] "autoimmune disease"
##
## $`EFO:0005555`
## [1] "gamma chain deficiency"
##
## $`EFO:0005565`
## [1] "janus kinase-3 deficiency"
##
## $`EFO:0005809`
## [1] "type II hypersensitivity reaction disease"
##
## $`Orphanet:179`
## [1] "Birdshot chorioretinopathy"
##
## $`Orphanet:183770`
## [1] "Rare genetic immune disease"
```

With RBGL we can compute paths to terms from root.

```
requireNamespace("RBGL")
p = RBGL::sp.between( efo.obo.g, "EFO:0000685", "EFO:0000001")
sapply(graph::nodeData(graph::subGraph(p[[1]]$path_detail, efo.obo.g)), "[[", "name")
```

```
## $`EFO:0000685`
## [1] "rheumatoid arthritis"
##
## $`EFO:0005856`
## [1] "arthritis"
##
## $`EFO:0005140`
## [1] "autoimmune disease"
##
## $`EFO:0000540`
## [1] "immune system disease"
##
## $`EFO:0000408`
## [1] "disease"
##
## $`BFO:0000016`
## [1] "disposition"
##
## $`BFO:0000020`
## [1] "material property"
##
## $`EFO:0000001`
## [1] "experimental factor "
```

# 4 Connections to the GWAS catalog

The `mcols` element of the `GRanges` instances provided by
gwascat include mapped EFO terms and EFO URIs.

```
data(ebicat_2020_04_30)
names(S4Vectors::mcols(ebicat_2020_04_30))
```

```
##  [1] "DATE ADDED TO CATALOG"      "PUBMEDID"
##  [3] "FIRST AUTHOR"               "DATE"
##  [5] "JOURNAL"                    "LINK"
##  [7] "STUDY"                      "DISEASE/TRAIT"
##  [9] "INITIAL SAMPLE SIZE"        "REPLICATION SAMPLE SIZE"
## [11] "REGION"                     "CHR_ID"
## [13] "CHR_POS"                    "REPORTED GENE(S)"
## [15] "MAPPED_GENE"                "UPSTREAM_GENE_ID"
## [17] "DOWNSTREAM_GENE_ID"         "SNP_GENE_IDS"
## [19] "UPSTREAM_GENE_DISTANCE"     "DOWNSTREAM_GENE_DISTANCE"
## [21] "STRONGEST SNP-RISK ALLELE"  "SNPS"
## [23] "MERGED"                     "SNP_ID_CURRENT"
## [25] "CONTEXT"                    "INTERGENIC"
## [27] "RISK ALLELE FREQUENCY"      "P-VALUE"
## [29] "PVALUE_MLOG"                "P-VALUE (TEXT)"
## [31] "OR or BETA"                 "95% CI (TEXT)"
## [33] "PLATFORM [SNPS PASSING QC]" "CNV"
## [35] "MAPPED_TRAIT"               "MAPPED_TRAIT_URI"
## [37] "STUDY ACCESSION"            "GENOTYPING TECHNOLOGY"
```

```
adinds = grep("autoimmu", ebicat_2020_04_30$MAPPED_TRAIT)
adgr = ebicat_2020_04_30[adinds]
adgr
```

```
## gwasloc instance with 46 records and 38 attributes per record.
## Extracted:  2020-04-30 23:24:51
## metadata()$badpos includes records for which no unique locus was given.
## Genome:  GRCh38
## Excerpt:
## GRanges object with 5 ranges and 3 metadata columns:
##       seqnames    ranges strand |     DISEASE/TRAIT        SNPS   P-VALUE
##          <Rle> <IRanges>  <Rle> |       <character> <character> <numeric>
##   [1]       12 103493699      * | Autoimmune traits   rs1320344     6e-11
##   [2]       12 111773070      * | Autoimmune traits rs191252491     1e-08
##   [3]       17  47252111      * | Autoimmune traits  rs73316435     6e-08
##   [4]       19  10352442      * | Autoimmune traits  rs34536443     4e-28
##   [5]        6    412802      * | Autoimmune traits   rs9392504     1e-10
##   -------
##   seqinfo: 24 sequences from GRCh38 genome
```

```
S4Vectors::mcols(adgr)[, c("MAPPED_TRAIT", "MAPPED_TRAIT_URI")]
```

```
## DataFrame with 46 rows and 2 columns
##               MAPPED_TRAIT       MAPPED_TRAIT_URI
##                <character>            <character>
## 1       autoimmune disease http://www.ebi.ac.uk..
## 2       autoimmune disease http://www.ebi.ac.uk..
## 3       autoimmune disease http://www.ebi.ac.uk..
## 4       autoimmune disease http://www.ebi.ac.uk..
## 5       autoimmune disease http://www.ebi.ac.uk..
## ...                    ...                    ...
## 42  autoimmune thyroid d.. http://www.ebi.ac.uk..
## 43  autoimmune thyroid d.. http://www.ebi.ac.uk..
## 44  salivary gland lesio.. http://www.ebi.ac.uk..
## 45  autoimmune thyroid d.. http://www.ebi.ac.uk..
## 46  autoimmune thyroid d.. http://www.ebi.ac.uk..
```