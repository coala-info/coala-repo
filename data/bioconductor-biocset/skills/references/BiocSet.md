# BiocSet: Representing Element Sets in the Tidyverse

Kayla Morrell1 and Martin Morgan1

1Roswell Park Comprehensive Cancer Center, Buffalo, NY

#### 2025-10-29

#### Package

BiocSet 1.24.0

# 1 Introduction

`BiocSet` is a package that represents element sets in a tibble format with the
`BiocSet` class. Element sets are read in and converted into a tibble format.
From here, typical `dplyr` operations can be performed on the element set.
`BiocSet` also provides functionality for mapping different ID types and
providing reference urls for elements and sets.

# 2 Installation

Install the most recent version from Bioconductor:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BiocSet")
```

The development version is also available for install from GitHub:

```
BiocManager::install("Kayla-Morrell/BiocSet")
```

Then load `BiocSet`:

```
library(BiocSet)
```

# 3 BiocSet

## 3.1 Input and Output

`BiocSet` can create a `BiocSet` object using two different input methods. The
first is to input named character vectors of element sets. `BiocSet` returns
three tibbles, `es_element` which contains the elements, `es_set` which contains
the sets and `es_elementset` which contains elements and sets together.

```
tbl <- BiocSet(set1 = letters, set2 = LETTERS)
tbl
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 52 × 1
#>   element
#>   <chr>
#> 1 a
#> 2 b
#> 3 c
#> # ℹ 49 more rows
#>
#> es_set():
#> # A tibble: 2 × 1
#>   set
#>   <chr>
#> 1 set1
#> 2 set2
#>
#> es_elementset() <active>:
#> # A tibble: 52 × 2
#>   element set
#>   <chr>   <chr>
#> 1 a       set1
#> 2 b       set1
#> 3 c       set1
#> # ℹ 49 more rows
```

The second method of creating a `BiocSet` object would be to read in a `.gmt`
file. Using `import()`, a path to a downloaded `.gmt` file is read in and a
`BiocSet` object is returned. The example below uses a hallmark element set
downloaded from [GSEA](http://software.broadinstitute.org/esea/index.jsp), which is also included with this package. This
`BiocSet` includes a `source` column within the `es_elementset` tibble for
reference as to where the element set came from.

```
gmtFile <- system.file(package = "BiocSet",
                        "extdata",
                        "hallmark.gene.symbol.gmt")
tbl2 <- import(gmtFile)
tbl2
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 4,386 × 1
#>   element
#>   <chr>
#> 1 JUNB
#> 2 CXCL2
#> 3 ATF3
#> # ℹ 4,383 more rows
#>
#> es_set():
#> # A tibble: 50 × 2
#>   set                              source
#>   <chr>                            <chr>
#> 1 HALLMARK_TNFA_SIGNALING_VIA_NFKB http://www.broadinstitute.org/gsea/msigdb/ca…
#> 2 HALLMARK_HYPOXIA                 http://www.broadinstitute.org/gsea/msigdb/ca…
#> 3 HALLMARK_CHOLESTEROL_HOMEOSTASIS http://www.broadinstitute.org/gsea/msigdb/ca…
#> # ℹ 47 more rows
#>
#> es_elementset() <active>:
#> # A tibble: 7,324 × 2
#>   element set
#>   <chr>   <chr>
#> 1 JUNB    HALLMARK_TNFA_SIGNALING_VIA_NFKB
#> 2 CXCL2   HALLMARK_TNFA_SIGNALING_VIA_NFKB
#> 3 ATF3    HALLMARK_TNFA_SIGNALING_VIA_NFKB
#> # ℹ 7,321 more rows
```

`export()` allows for a `BiocSet` object to be exported into a temporary file
with the extention `.gmt`.

```
fl <- tempfile(fileext = ".gmt")
gmt <- export(tbl2, fl)
gmt
#> GMTFile object
#> resource: /tmp/RtmpzG8gtA/file36e87e213b2dbd.gmt
```

We also support importing files to create an `OBOSet` object which extends
the `BiocSet` class. The default only displays the most basic amount of columns
needed to perform certain tasks, but the argument `extract_tag = everything`
allows for additional columns to be imported as well. The following workflow
will demonstrate the use of both export and import to create a smaller subset
of the large obo file that is accessable from GeneOntology.

```
download.file("http://current.geneontology.org/ontology/go.obo", "obo_file.obo")

foo <- import("obo_file.obo", extract_tag = "everything")

small_tst <- es_element(foo)[1,] %>%
    unnest("ancestors") %>%
    select("element", "ancestors") %>%
    unlist() %>%
    unique()

small_oboset <- foo %>% filter_elementset(element %in% small_tst)

fl <- tempfile(fileext = ".obo")
export(small_oboset, fl)
```

Then you can import this smaller obo file which we utilize here, in tests, and
example code.

```
oboFile <- system.file(package = "BiocSet",
                        "extdata",
                        "sample_go.obo")
obo <- import(oboFile)
obo
#> class: OBOSet
#>
#> es_element():
#> # A tibble: 8 × 3
#>   element    name                             obsolete
#>   <chr>      <chr>                            <lgl>
#> 1 GO:0033955 mitochondrial DNA inheritance    FALSE
#> 2 GO:0000002 mitochondrial genome maintenance FALSE
#> 3 GO:0007005 mitochondrion organization       FALSE
#> # ℹ 5 more rows
#>
#> es_set():
#> # A tibble: 8 × 2
#>   set        name
#>   <chr>      <chr>
#> 1 GO:0000002 mitochondrial genome maintenance
#> 2 GO:0006996 organelle organization
#> 3 GO:0007005 mitochondrion organization
#> # ℹ 5 more rows
#>
#> es_elementset() <active>:
#> # A tibble: 36 × 3
#>   element    set        is_a
#>   <chr>      <chr>      <lgl>
#> 1 GO:0033955 GO:0000002 TRUE
#> 2 GO:0000002 GO:0000002 FALSE
#> 3 GO:0007005 GO:0006996 TRUE
#> # ℹ 33 more rows
```

## 3.2 Implemented functions

A feature available to `BiocSet` is the ability to activate different
tibbles to perform certain functions on. When a `BiocSet` is created, the tibble
`es_elementset` is automatically activated and all functions will be performed
on this tibble. `BiocSet` adopts the use of many common `dplyr` functions such
as `filter()`, `select()`, `mutate()`, `summarise()`, and `arrange()`. With
each of the functions the user is able to pick a different tibble to activate
and work on by using ‘verb\_tibble’. After the function is executed than the
‘active’ tibble is returned back to the tibble that was active before the
function call. Some examples are shown below of how these functions work.

```
tbl <- BiocSet(set1 = letters, set2 = LETTERS)
tbl
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 52 × 1
#>   element
#>   <chr>
#> 1 a
#> 2 b
#> 3 c
#> # ℹ 49 more rows
#>
#> es_set():
#> # A tibble: 2 × 1
#>   set
#>   <chr>
#> 1 set1
#> 2 set2
#>
#> es_elementset() <active>:
#> # A tibble: 52 × 2
#>   element set
#>   <chr>   <chr>
#> 1 a       set1
#> 2 b       set1
#> 3 c       set1
#> # ℹ 49 more rows
tbl %>% filter_element(element == "a" | element == "A")
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 2 × 1
#>   element
#>   <chr>
#> 1 a
#> 2 A
#>
#> es_set():
#> # A tibble: 2 × 1
#>   set
#>   <chr>
#> 1 set1
#> 2 set2
#>
#> es_elementset() <active>:
#> # A tibble: 2 × 2
#>   element set
#>   <chr>   <chr>
#> 1 a       set1
#> 2 A       set2
tbl %>% mutate_set(pval = rnorm(1:2))
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 52 × 1
#>   element
#>   <chr>
#> 1 a
#> 2 b
#> 3 c
#> # ℹ 49 more rows
#>
#> es_set():
#> # A tibble: 2 × 2
#>   set     pval
#>   <chr>  <dbl>
#> 1 set1  -0.416
#> 2 set2   1.84
#>
#> es_elementset() <active>:
#> # A tibble: 52 × 2
#>   element set
#>   <chr>   <chr>
#> 1 a       set1
#> 2 b       set1
#> 3 c       set1
#> # ℹ 49 more rows
tbl %>% arrange_elementset(desc(element))
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 52 × 1
#>   element
#>   <chr>
#> 1 a
#> 2 b
#> 3 c
#> # ℹ 49 more rows
#>
#> es_set():
#> # A tibble: 2 × 1
#>   set
#>   <chr>
#> 1 set1
#> 2 set2
#>
#> es_elementset() <active>:
#> # A tibble: 52 × 2
#>   element set
#>   <chr>   <chr>
#> 1 z       set1
#> 2 y       set1
#> 3 x       set1
#> # ℹ 49 more rows
```

## 3.3 Set operations

`BiocSet` also allows for common set operations to be performed on the `BiocSet`
object. `union()` and `intersection()` are the two set operations available in
`BiocSet`. We demonstate how a user can find the union between two `BiocSet`
objects or within a single `BiocSet` object. Intersection is used in the same
way.

```
# union of two BiocSet objects
es1 <- BiocSet(set1 = letters[c(1:3)], set2 = LETTERS[c(1:3)])
es2 <- BiocSet(set1 = letters[c(2:4)], set2 = LETTERS[c(2:4)])
union(es1, es2)
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 8 × 1
#>   element
#>   <chr>
#> 1 a
#> 2 b
#> 3 c
#> # ℹ 5 more rows
#>
#> es_set():
#> # A tibble: 2 × 1
#>   set
#>   <chr>
#> 1 set1
#> 2 set2
#>
#> es_elementset() <active>:
#> # A tibble: 8 × 2
#>   element set
#>   <chr>   <chr>
#> 1 a       set1
#> 2 b       set1
#> 3 c       set1
#> # ℹ 5 more rows

# union within a single BiocSet object
es3 <- BiocSet(set1 = letters[c(1:10)], set2 = letters[c(4:20)])
union_single(es3)
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 20 × 1
#>   element
#>   <chr>
#> 1 a
#> 2 b
#> 3 c
#> # ℹ 17 more rows
#>
#> es_set():
#> # A tibble: 1 × 1
#>   set
#>   <chr>
#> 1 union
#>
#> es_elementset() <active>:
#> # A tibble: 20 × 2
#>   element set
#>   <chr>   <chr>
#> 1 a       union
#> 2 b       union
#> 3 c       union
#> # ℹ 17 more rows
```

# 4 Case study I

Next, we demonstrate the a couple uses of `BiocSet` with an experiment dataset
`airway` from the package `airway`. This data is from an RNA-Seq experiment on
airway smooth muscle (ASM) cell lines.

The first step is to load the library and the necessary data.

```
library(airway)
data("airway")
se <- airway
```

The function `go_sets()` discovers the keys from the org object and uses
`AnnotationDbi::select` to create a mapping to GO ids. `go_sets()` also allows
the user to indicate which evidence type or ontology type they would like when
selecting the GO ids. The default is using all evidence types and all ontology
types. We represent these identifieres as a `BiocSet` object. Using the
`go_sets` function we are able to map the Ensembl ids and GO ids from the genome
wide annotation for Human data in the `org.Hs.eg.db` package. The Ensembl ids
are treated as elements while the GO ids are treated as sets.

```
library(org.Hs.eg.db)
go <- go_sets(org.Hs.eg.db, "ENSEMBL")
go
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 23,586 × 1
#>   element
#>   <chr>
#> 1 ENSG00000060642
#> 2 ENSG00000182858
#> 3 ENSG00000049167
#> # ℹ 23,583 more rows
#>
#> es_set():
#> # A tibble: 18,862 × 1
#>   set
#>   <chr>
#> 1 GO:0000009
#> 2 GO:0000012
#> 3 GO:0000014
#> # ℹ 18,859 more rows
#>
#> es_elementset() <active>:
#> # A tibble: 408,845 × 2
#>   element         set
#>   <chr>           <chr>
#> 1 ENSG00000060642 GO:0000009
#> 2 ENSG00000182858 GO:0000009
#> 3 ENSG00000049167 GO:0000012
#> # ℹ 408,842 more rows

# an example of subsetting by evidence type
go_sets(org.Hs.eg.db, "ENSEMBL", evidence = c("IPI", "TAS"))
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 18,384 × 1
#>   element
#>   <chr>
#> 1 ENSG00000076248
#> 2 ENSG00000020922
#> 3 ENSG00000168685
#> # ℹ 18,381 more rows
#>
#> es_set():
#> # A tibble: 4,764 × 2
#>   set        evidence
#>   <chr>      <named list>
#> 1 GO:0000012 <chr [1]>
#> 2 GO:0000014 <chr [1]>
#> 3 GO:0000018 <chr [1]>
#> # ℹ 4,761 more rows
#>
#> es_elementset() <active>:
#> # A tibble: 64,125 × 2
#>   element         set
#>   <chr>           <chr>
#> 1 ENSG00000076248 GO:0000012
#> 2 ENSG00000020922 GO:0000014
#> 3 ENSG00000168685 GO:0000018
#> # ℹ 64,122 more rows
```

Some users may not be interested in reporting the non-descriptive elements. We
demonstrate subsetting the `airway` data to include non-zero assays and then
filter out the non-descriptive elements.

```
se1 = se[rowSums(assay(se)) != 0,]
go %>% filter_element(element %in% rownames(se1))
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 16,655 × 1
#>   element
#>   <chr>
#> 1 ENSG00000060642
#> 2 ENSG00000182858
#> 3 ENSG00000049167
#> # ℹ 16,652 more rows
#>
#> es_set():
#> # A tibble: 18,862 × 1
#>   set
#>   <chr>
#> 1 GO:0000009
#> 2 GO:0000012
#> 3 GO:0000014
#> # ℹ 18,859 more rows
#>
#> es_elementset() <active>:
#> # A tibble: 316,864 × 2
#>   element         set
#>   <chr>           <chr>
#> 1 ENSG00000060642 GO:0000009
#> 2 ENSG00000182858 GO:0000009
#> 3 ENSG00000049167 GO:0000012
#> # ℹ 316,861 more rows
```

It may also be of interest to users to know how many elements are in each set.
Using the `count` function we are able to calculate the elements per set.

```
go %>% group_by(set) %>% dplyr::count()
#> Warning: The `add` argument of `group_by()` is deprecated as of dplyr 1.0.0.
#> ℹ Please use the `.add` argument instead.
#> ℹ The deprecated feature was likely used in the dplyr package.
#>   Please report the issue at <https://github.com/tidyverse/dplyr/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> # A tibble: 18,862 × 2
#> # Groups:   set [18,862]
#>    set            n
#>    <chr>      <int>
#>  1 GO:0000009     2
#>  2 GO:0000012    12
#>  3 GO:0000014    10
#>  4 GO:0000015     4
#>  5 GO:0000016     1
#>  6 GO:0000017     2
#>  7 GO:0000018     5
#>  8 GO:0000019     2
#>  9 GO:0000022     2
#> 10 GO:0000023     2
#> # ℹ 18,852 more rows
```

It may also be helpful to remove sets that are empty. Since we have shown how
to calculate the number of elements per set, we know that this data set does
not contain any empty sets. We decide to demonstrate regardless for those users
that may need this functionality.

```
drop <- es_activate(go, elementset) %>% group_by(set) %>%
    dplyr::count() %>% filter(n == 0) %>% pull(set)
go %>% filter_set(!(set %in% drop))
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 23,586 × 1
#>   element
#>   <chr>
#> 1 ENSG00000060642
#> 2 ENSG00000182858
#> 3 ENSG00000049167
#> # ℹ 23,583 more rows
#>
#> es_set():
#> # A tibble: 18,862 × 1
#>   set
#>   <chr>
#> 1 GO:0000009
#> 2 GO:0000012
#> 3 GO:0000014
#> # ℹ 18,859 more rows
#>
#> es_elementset() <active>:
#> # A tibble: 408,845 × 2
#>   element         set
#>   <chr>           <chr>
#> 1 ENSG00000060642 GO:0000009
#> 2 ENSG00000182858 GO:0000009
#> 3 ENSG00000049167 GO:0000012
#> # ℹ 408,842 more rows
```

To simplify mapping we created a couple `map` functions. `map_unique()` is used
when there is known 1:1 mapping, This takes four arguements, a `BiocSet`
object, an `AnnotationDbi` object, the id to map from, and the id to map to.
`map_multiple()` needs a fifth argument to indicate how the function should
treat an element when there is multiple mapping. Both functions utilize
`mapIds` from `AnnotationDbi` and return a `BiocSet` object. In the example
below we show how to use `map_unique` to map `go`’s ids from Ensembl to gene
symbols.

```
go %>% map_unique(org.Hs.eg.db, "ENSEMBL", "SYMBOL")
#> 'select()' returned 1:many mapping between keys and columns
#> Joining with `by = join_by(element)`
#> `mutate_if()` ignored the following grouping variables:
#> Joining with `by = join_by(element)`
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 20,482 × 1
#>   element
#>   <chr>
#> 1 ALG12
#> 2 PIGV
#> 3 APLF
#> # ℹ 20,479 more rows
#>
#> es_set():
#> # A tibble: 18,862 × 1
#>   set
#>   <chr>
#> 1 GO:0000009
#> 2 GO:0000012
#> 3 GO:0000014
#> # ℹ 18,859 more rows
#>
#> es_elementset() <active>:
#> # A tibble: 359,141 × 2
#>   element set
#>   <chr>   <chr>
#> 1 ALG12   GO:0000009
#> 2 PIGV    GO:0000009
#> 3 APLF    GO:0000012
#> # ℹ 359,138 more rows
```

Another functionality of `BiocSet` is the ability to add information to the
tibbles. Using the `GO.db` library we are able to map definitions to the GO
ids. From there we can add the mapping to the tibble using `map_add()` and the
mutate function.

```
library(GO.db)
map <- map_add_set(go, GO.db, "GOID", "DEFINITION")
go %>% mutate_set(definition = map)
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 23,586 × 1
#>   element
#>   <chr>
#> 1 ENSG00000060642
#> 2 ENSG00000182858
#> 3 ENSG00000049167
#> # ℹ 23,583 more rows
#>
#> es_set():
#> # A tibble: 18,862 × 2
#>   set        definition
#>   <chr>      <chr>
#> 1 GO:0000009 Catalysis of the transfer of a mannose residue to an oligosacchari…
#> 2 GO:0000012 The repair of single strand breaks in DNA. Repair of such breaks i…
#> 3 GO:0000014 Catalysis of the hydrolysis of ester linkages within a single-stra…
#> # ℹ 18,859 more rows
#>
#> es_elementset() <active>:
#> # A tibble: 408,845 × 2
#>   element         set
#>   <chr>           <chr>
#> 1 ENSG00000060642 GO:0000009
#> 2 ENSG00000182858 GO:0000009
#> 3 ENSG00000049167 GO:0000012
#> # ℹ 408,842 more rows
```

The library `KEGGREST` is a client interface to the KEGG REST server.
KEGG contains pathway maps that represent interaction, reaction and relation
networks for various biological processes and diseases. `BiocSet` has a
function that utilizes `KEGGREST` to develop a `BiocSet` object that contains
the elements for every pathway map in KEGG.

Due to limiations of the KEGGREST package, `kegg_sets` can take some time to
run depending on the amount of pathways for the species of interest. Therefore
we demonstrate using `BiocFileCache` to make the data available to the user.

```
library(BiocFileCache)
rname <- "kegg_hsa"
exists <- NROW(bfcquery(query=rname, field="rname")) != 0L
if (!exists)
{
    kegg <- kegg_sets("hsa")
    fl <- bfcnew(rname = rname, ext = ".gmt")
    export(kegg_sets("hsa"), fl)
}
kegg <- import(bfcrpath(rname=rname))
```

Within the `kegg_sets()` function we remove pathways that do not contain any
elements. We then mutate the element tibble using the `map_add` function to
contain both Ensembl and Entrez ids.

```
map <- map_add_element(kegg, org.Hs.eg.db, "ENTREZID", "ENSEMBL")
#> 'select()' returned 1:many mapping between keys and columns
kegg <- kegg %>% mutate_element(ensembl = map)
```

Since we are working with ASM data we thought we would subset the `airway` data
to contain only the elements in the asthma pathway. This filter is performed
on the KEGG id, which for asthma is “hsa05310”.

```
asthma <- kegg %>% filter_set(set == "hsa05310")

se <- se[rownames(se) %in% es_element(asthma)$ensembl,]

se
#> class: RangedSummarizedExperiment
#> dim: 8305 8
#> metadata(1): ''
#> assays(1): counts
#> rownames(8305): ENSG00000000419 ENSG00000000938 ... ENSG00000273085
#>   ENSG00000273213
#> rowData names(10): gene_id gene_name ... seq_coord_system symbol
#> colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
#> colData names(9): SampleName cell ... Sample BioSample
```

The filtering can also be done for multiple pathways.

```
pathways <- c("hsa05310", "hsa04110", "hsa05224", "hsa04970")
multipaths <- kegg %>% filter_set(set %in% pathways)

multipaths
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 9,432 × 2
#>   element ensembl
#>   <chr>   <chr>
#> 1 10327   ENSG00000117448
#> 2 124     ENSG00000187758
#> 3 125     ENSG00000196616
#> # ℹ 9,429 more rows
#>
#> es_set():
#> # A tibble: 4 × 2
#>   set      source
#>   <chr>    <chr>
#> 1 hsa04110 <NA>
#> 2 hsa04970 <NA>
#> 3 hsa05224 <NA>
#> # ℹ 1 more row
#>
#> es_elementset() <active>:
#> # A tibble: 435 × 2
#>   element set
#>   <chr>   <chr>
#> 1 1017    hsa04110
#> 2 1019    hsa04110
#> 3 1021    hsa04110
#> # ℹ 432 more rows
```

# 5 Case study II

This example will start out the same way that Case Study I started, by loading
in the `airway` dataset, but we will also do some reformating of the data. The
end goal is to be able to perform a Gene Set Enrichment Analysis on the data and
return a BiocSet object of the gene sets.

```
data("airway")
airway$dex <- relevel(airway$dex, "untrt")
```

Similar to other analyses we perform a differential expression analysis on the
`airway` data using the library `DESeq2` and then store the results into a
tibble.

```
library(DESeq2)
library(tibble)
des <- DESeqDataSet(airway, design = ~ cell + dex)
des <- DESeq(des)
#> estimating size factors
#> estimating dispersions
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> final dispersion estimates
#> fitting model and testing
res <- results(des)

tbl <- res %>%
    as.data.frame() %>%
    as_tibble(rownames = "ENSEMBL")
```

Since we want to use `limma::goana()` to perform the GSEA we will need to have
ENTREZ identifiers in the data, as well as filter out some `NA` information.
Later on this will be considered our ‘element’ tibble.

```
tbl <- tbl %>%
    mutate(
        ENTREZID = mapIds(
            org.Hs.eg.db, ENSEMBL, "ENTREZID", "ENSEMBL"
        ) %>% unname()
    )
#> 'select()' returned 1:many mapping between keys and columns

tbl <- tbl %>% filter(!is.na(padj), !is.na(ENTREZID))
tbl
#> # A tibble: 15,041 × 8
#>    ENSEMBL        baseMean log2FoldChange  lfcSE   stat  pvalue    padj ENTREZID
#>    <chr>             <dbl>          <dbl>  <dbl>  <dbl>   <dbl>   <dbl> <chr>
#>  1 ENSG000000000…    709.         -0.381  0.101  -3.79  1.52e-4 1.28e-3 7105
#>  2 ENSG000000004…    520.          0.207  0.112   1.84  6.53e-2 1.96e-1 8813
#>  3 ENSG000000004…    237.          0.0379 0.143   0.264 7.92e-1 9.11e-1 57147
#>  4 ENSG000000004…     57.9        -0.0882 0.287  -0.307 7.59e-1 8.95e-1 55732
#>  5 ENSG000000009…   5817.          0.426  0.0883  4.83  1.38e-6 1.82e-5 3075
#>  6 ENSG000000010…   1282.         -0.241  0.0887 -2.72  6.58e-3 3.28e-2 2519
#>  7 ENSG000000010…    610.         -0.0476 0.167  -0.286 7.75e-1 9.03e-1 2729
#>  8 ENSG000000011…    369.         -0.500  0.121  -4.14  3.48e-5 3.42e-4 4800
#>  9 ENSG000000014…    183.         -0.124  0.180  -0.689 4.91e-1 7.24e-1 90529
#> 10 ENSG000000014…   2814.         -0.0411 0.103  -0.400 6.89e-1 8.57e-1 57185
#> # ℹ 15,031 more rows
```

Now that the data is ready for GSEA we can go ahead and use `goana()` and make
the results into a tibble. This tibble will be considered our ‘set’ tibble.

```
library(limma)
#>
#> Attaching package: 'limma'
#> The following object is masked from 'package:DESeq2':
#>
#>     plotMA
#> The following object is masked from 'package:BiocGenerics':
#>
#>     plotMA
go_ids <- goana(tbl$ENTREZID[tbl$padj < 0.05], tbl$ENTREZID, "Hs") %>%
    as.data.frame() %>%
    as_tibble(rownames = "GOALL")
go_ids
#> # A tibble: 20,639 × 6
#>    GOALL      Term                                    Ont       N    DE     P.DE
#>    <chr>      <chr>                                   <chr> <dbl> <dbl>    <dbl>
#>  1 GO:0002376 immune system process                   BP     1813   612 2.37e-19
#>  2 GO:0002682 regulation of immune system process     BP     1145   390 5.22e-13
#>  3 GO:0002764 immune response-regulating signaling p… BP      397   119 1.27e- 2
#>  4 GO:0006955 immune response                         BP     1178   382 1.27e- 9
#>  5 GO:0007154 cell communication                      BP     4459  1490 1.18e-52
#>  6 GO:0007165 signal transduction                     BP     4115  1373 1.35e-46
#>  7 GO:0008150 biological_process                      BP    12355  3387 7.72e-55
#>  8 GO:0009987 cellular process                        BP    12117  3311 2.50e-45
#>  9 GO:0023052 signaling                               BP     4454  1489 9.46e-53
#> 10 GO:0048583 regulation of response to stimulus      BP     3115  1020 2.45e-28
#> # ℹ 20,629 more rows
```

The last thing we need to do is create a tibble that we will consider our
‘elementset’ tibble. This tibble will be a mapping of all the elements and sets.

```
foo <- AnnotationDbi::select(
    org.Hs.eg.db,
    tbl$ENTREZID,
    "GOALL",
    "ENTREZID") %>% as_tibble()
#> 'select()' returned many:many mapping between keys and columns
foo <- foo %>% dplyr::select(-EVIDENCEALL) %>% distinct()
foo <- foo %>% filter(ONTOLOGYALL == "BP") %>% dplyr::select(-ONTOLOGYALL)
foo
#> # A tibble: 922,717 × 2
#>    ENTREZID GOALL
#>    <chr>    <chr>
#>  1 7105     GO:0002218
#>  2 7105     GO:0002221
#>  3 7105     GO:0002253
#>  4 7105     GO:0002376
#>  5 7105     GO:0002682
#>  6 7105     GO:0002683
#>  7 7105     GO:0002684
#>  8 7105     GO:0002753
#>  9 7105     GO:0002757
#> 10 7105     GO:0002758
#> # ℹ 922,707 more rows
```

The function `BiocSet_from_elementset()` allows for users to create a BiocSet
object from tibbles. This function is helpful when there is metadata contained
in the tibble that should be in the BiocSet object. For this function to work
properly, the columns that are being joined on need to be named correctly. For
instance, in order to use this function on the tibbles we created we need to
change the column in the ‘element’ tibble to ‘element’, the column in the ‘set’
tibble to ‘set’ and the same will be for the ‘elementset’ tibble. We demonstrate
this below and then create the BiocSet object with the simple function.

```
foo <- foo %>% dplyr::rename(element = ENTREZID, set = GOALL)
tbl <- tbl %>% dplyr::rename(element = ENTREZID)
go_ids <- go_ids %>% dplyr::rename(set = GOALL)
es <- BiocSet_from_elementset(foo, tbl, go_ids)
#> more elements in 'element' than in 'elementset'
#> more elements in 'set' than in 'elementset'
es
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 12,364 × 8
#>   element ENSEMBL         baseMean log2FoldChange lfcSE   stat  pvalue   padj
#>   <chr>   <chr>              <dbl>          <dbl> <dbl>  <dbl>   <dbl>  <dbl>
#> 1 55775   ENSG00000042088     190.         -0.420 0.159 -2.65  0.00808 0.0388
#> 2 1161    ENSG00000049167     138.         -0.257 0.184 -1.40  0.163   0.376
#> 3 7515    ENSG00000073050     299.         -0.108 0.135 -0.801 0.423   0.668
#> # ℹ 12,361 more rows
#>
#> es_set():
#> # A tibble: 14,035 × 6
#>   set        Term                                Ont       N    DE  P.DE
#>   <chr>      <chr>                               <chr> <dbl> <dbl> <dbl>
#> 1 GO:0000012 single strand break repair          BP       13     2 0.873
#> 2 GO:0000018 regulation of DNA recombination     BP      124    24 0.944
#> 3 GO:0000019 regulation of mitotic recombination BP        6     1 0.822
#> # ℹ 14,032 more rows
#>
#> es_elementset() <active>:
#> # A tibble: 922,717 × 2
#>   element set
#>   <chr>   <chr>
#> 1 55775   GO:0000012
#> 2 1161    GO:0000012
#> 3 7515    GO:0000012
#> # ℹ 922,714 more rows
```

For those users that may need to put this metadata filled BiocSet object back
into an object similar to GRanges or SummarizedExperiment, we have created
functions that allow for the BiocSet object to be created into a tibble or
data.frame.

```
tibble_from_element(es)
#> Joining with `by = join_by(set)`
#> Joining with `by = join_by(element)`
#> # A tibble: 12,355 × 14
#>    element   set   Term  Ont   N     DE    P.DE  ENSEMBL baseMean log2FoldChange
#>    <chr>     <lis> <lis> <lis> <lis> <lis> <lis> <list>  <list>   <list>
#>  1 1         <chr> <chr> <chr> <dbl> <dbl> <dbl> <chr>   <dbl>    <dbl [16]>
#>  2 100       <chr> <chr> <chr> <dbl> <dbl> <dbl> <chr>   <dbl>    <dbl [437]>
#>  3 1000      <chr> <chr> <chr> <dbl> <dbl> <dbl> <chr>   <dbl>    <dbl [182]>
#>  4 10000     <chr> <chr> <chr> <dbl> <dbl> <dbl> <chr>   <dbl>    <dbl [170]>
#>  5 10001     <chr> <chr> <chr> <dbl> <dbl> <dbl> <chr>   <dbl>    <dbl [75]>
#>  6 10003     <chr> <chr> <chr> <dbl> <dbl> <dbl> <chr>   <dbl>    <dbl [15]>
#>  7 10004     <chr> <chr> <chr> <dbl> <dbl> <dbl> <chr>   <dbl>    <dbl [10]>
#>  8 100048912 <chr> <chr> <chr> <dbl> <dbl> <dbl> <chr>   <dbl>    <dbl [29]>
#>  9 10005     <chr> <chr> <chr> <dbl> <dbl> <dbl> <chr>   <dbl>    <dbl [87]>
#> 10 10006     <chr> <chr> <chr> <dbl> <dbl> <dbl> <chr>   <dbl>    <dbl [119]>
#> # ℹ 12,345 more rows
#> # ℹ 4 more variables: lfcSE <list>, stat <list>, pvalue <list>, padj <list>

head(data.frame_from_elementset(es))
#> Joining with `by = join_by(set)`
#> Joining with `by = join_by(element)`
#>   element        set                       Term Ont  N DE    P.DE
#> 1   55775 GO:0000012 single strand break repair  BP 13  2 0.87313
#> 2    1161 GO:0000012 single strand break repair  BP 13  2 0.87313
#> 3    7515 GO:0000012 single strand break repair  BP 13  2 0.87313
#> 4    7374 GO:0000012 single strand break repair  BP 13  2 0.87313
#> 5   23411 GO:0000012 single strand break repair  BP 13  2 0.87313
#> 6   55247 GO:0000012 single strand break repair  BP 13  2 0.87313
#>           ENSEMBL  baseMean log2FoldChange     lfcSE       stat       pvalue
#> 1 ENSG00000042088 190.04800     -0.4203301 0.1587016 -2.6485568 8.083626e-03
#> 2 ENSG00000049167 137.52707     -0.2572243 0.1842862 -1.3957870 1.627786e-01
#> 3 ENSG00000073050 298.53745     -0.1077740 0.1345475 -0.8010109 4.231254e-01
#> 4 ENSG00000076248 313.06225     -0.2522296 0.1281833 -1.9677261 4.909956e-02
#> 5 ENSG00000096717 518.11796      0.1861007 0.1220428  1.5248803 1.272889e-01
#> 6 ENSG00000109674  47.91403     -1.4272603 0.3159240 -4.5177333 6.250514e-06
#>           padj
#> 1 3.880916e-02
#> 2 3.758741e-01
#> 3 6.682899e-01
#> 4 1.588857e-01
#> 5 3.166932e-01
#> 6 7.351289e-05
```

# 6 Information look up

A final feature to `BiocSet` is the ability to add reference information about
all of the elements/sets. A user could utilize the function `url_ref()` to add
information to the `BiocSet` object. If a user has a question about a specific
id then they can follow the reference url to get more informtion. Below is an
example of using `url_ref()` to add reference urls to the `go` data set we
worked with above.

```
url_ref(go)
#> class: BiocSet
#>
#> es_element():
#> # A tibble: 23,586 × 2
#>   element         url
#>   <chr>           <chr>
#> 1 ENSG00000060642 https://www.ensembl.org/Homo_sapiens/Gene/Summary?db=core;g=E…
#> 2 ENSG00000182858 https://www.ensembl.org/Homo_sapiens/Gene/Summary?db=core;g=E…
#> 3 ENSG00000049167 https://www.ensembl.org/Homo_sapiens/Gene/Summary?db=core;g=E…
#> # ℹ 23,583 more rows
#>
#> es_set():
#> # A tibble: 18,862 × 2
#>   set        url
#>   <chr>      <chr>
#> 1 GO:0000009 http://amigo.geneontology.org/amigo/medial_search?q=GO:0000009
#> 2 GO:0000012 http://amigo.geneontology.org/amigo/medial_search?q=GO:0000012
#> 3 GO:0000014 http://amigo.geneontology.org/amigo/medial_search?q=GO:0000014
#> # ℹ 18,859 more rows
#>
#> es_elementset() <active>:
#> # A tibble: 408,845 × 2
#>   element         set
#>   <chr>           <chr>
#> 1 ENSG00000060642 GO:0000009
#> 2 ENSG00000182858 GO:0000009
#> 3 ENSG00000049167 GO:0000012
#> # ℹ 408,842 more rows
```

# 7 Session info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] limma_3.66.0                tibble_3.3.0
#>  [3] DESeq2_1.50.0               BiocFileCache_3.0.0
#>  [5] dbplyr_2.5.1                GO.db_3.22.0
#>  [7] org.Hs.eg.db_3.22.0         AnnotationDbi_1.72.0
#>  [9] airway_1.29.0               SummarizedExperiment_1.40.0
#> [11] Biobase_2.70.0              GenomicRanges_1.62.0
#> [13] Seqinfo_1.0.0               IRanges_2.44.0
#> [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [17] generics_0.1.4              MatrixGenerics_1.22.0
#> [19] matrixStats_1.5.0           BiocSet_1.24.0
#> [21] dplyr_1.1.4                 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1    farver_2.1.2        blob_1.2.4
#>  [4] S7_0.2.0            filelock_1.0.3      Biostrings_2.78.0
#>  [7] fastmap_1.2.0       digest_0.6.37       lifecycle_1.0.4
#> [10] statmod_1.5.1       KEGGREST_1.50.0     RSQLite_2.4.3
#> [13] magrittr_2.0.4      compiler_4.5.1      rlang_1.1.6
#> [16] sass_0.4.10         tools_4.5.1         utf8_1.2.6
#> [19] yaml_2.3.10         knitr_1.50          S4Arrays_1.10.0
#> [22] ontologyIndex_2.12  bit_4.6.0           curl_7.0.0
#> [25] DelayedArray_0.36.0 RColorBrewer_1.1-3  plyr_1.8.9
#> [28] abind_1.4-8         BiocParallel_1.44.0 withr_3.0.2
#> [31] purrr_1.1.0         grid_4.5.1          ggplot2_4.0.0
#> [34] scales_1.4.0        dichromat_2.0-0.1   cli_3.6.5
#> [37] rmarkdown_2.30      crayon_1.5.3        httr_1.4.7
#> [40] DBI_1.2.3           cachem_1.1.0        parallel_4.5.1
#> [43] formatR_1.14        BiocManager_1.30.26 XVector_0.50.0
#> [46] vctrs_0.6.5         Matrix_1.7-4        jsonlite_2.0.0
#> [49] bookdown_0.45       bit64_4.6.0-1       locfit_1.5-9.12
#> [52] tidyr_1.3.1         jquerylib_0.1.4     glue_1.8.0
#> [55] codetools_0.2-20    gtable_0.3.6        BiocIO_1.20.0
#> [58] pillar_1.11.1       rappdirs_0.3.3      htmltools_0.5.8.1
#> [61] R6_2.6.1            httr2_1.2.1         evaluate_1.0.5
#> [64] lattice_0.22-7      png_0.1-8           memoise_2.0.1
#> [67] bslib_0.9.0         Rcpp_1.1.0          SparseArray_1.10.0
#> [70] xfun_0.53           pkgconfig_2.0.3
```