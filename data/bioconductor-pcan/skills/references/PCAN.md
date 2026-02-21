# Contents

* [1 Introduction](#introduction)
  + [1.1 Use case](#use-case)
  + [1.2 Prior knowledge](#prior-knowledge)
    - [1.2.1 Mendelian disorders and associated genes](#mendelian-disorders-and-associated-genes)
    - [1.2.2 Human phenotype of mendelian disorders](#human-phenotype-of-mendelian-disorders)
    - [1.2.3 Custom prior knowledge](#custom-prior-knowledge)
* [2 Direct comparison of phenotypes](#direct-comparison-of-phenotypes)
  + [2.1 Phenotypes associated to the gene candidate](#phenotypes-associated-to-the-gene-candidate)
  + [2.2 Information content and semantic similariy](#information-content-and-semantic-similariy)
  + [2.3 Comparing two sets of phenotype](#comparing-two-sets-of-phenotype)
* [3 The pathway consensus approach](#the-pathway-consensus-approach)
  + [3.1 Additional prior knowledge](#additional-prior-knowledge)
  + [3.2 Genes belonging to the pathways of the candidate](#genes-belonging-to-the-pathways-of-the-candidate)
  + [3.3 Genes interacting with the candidate](#genes-interacting-with-the-candidate)
* [4 Session info](#session-info)
* [5 References](#references)
* **Appendix**

# 1 Introduction

This document explores different ways to assess the relevance
of a gene for a set of human phenotypes using the PCAN package.

```
library(PCAN)
```

```
## Loading required package: BiocParallel
```

```
## Some functions can be parallelized.
## They use the bpmapply function from the BiocParallel library.
## Follow instructions provided in the BiocParallel manual to
## configure your parallelization backend.
## options(MulticoreParam=quote(MulticoreParam(workers=4)))
```

## 1.1 Use case

This document demonstrates the capabilities of the PCAN package through the
analysis of the following example.

Here, we pretend that we don’t know anything about the
genetics of the [Joubert syndrome 9](http://omim.org/entry/612285).
The symptoms of this syndrome can be formally described by the following
terms from the
[Human Phenotype Ontology](http://www.human-phenotype-ontology.org/)
(**???**)
(according to this version of the
[phenotype\_annotation.tab](http://compbio.charite.de/hudson/job/hpo.annotations/1039/artifact/misc/phenotype_annotation.tab)):

| HP | Name |
| --- | --- |
| HP:0000483 | Astigmatism |
| HP:0000510 | Retinitis pigmentosa |
| HP:0000518 | Cataract |
| HP:0000639 | Nystagmus |
| HP:0001249 | Intellectual disability |
| HP:0001250 | Seizures |
| HP:0002119 | Ventriculomegaly |
| HP:0002419 | Molar tooth sign on MRI |

Let’s store these phenoytpes in the `hpOfInterest` vector:

`hpOfInterest <- c("HP:0000483", "HP:0000510", "HP:0000518", "HP:0000639", "HP:0001249", "HP:0001250", "HP:0002119", "HP:0002419")`

The [CC2D2A](http://www.ncbi.nlm.nih.gov/gene/57545) is known to
be associated to the [Joubert syndrome 9](http://omim.org/entry/612285)
according to [OMIM](http://omim.org). **Let’s pretend** in the frame of
this example that **we don’t know this association**
and that this gene came out from sequencing data related to an individual
suffering from the *Joubert syndrome 9*.

***The aim of the following analyses is to assess the relevance of this gene
for the set of phenotypes under focus.***

## 1.2 Prior knowledge

To achieve the goal described above, we rely on prior knowledge about
genetics of disorders and human phenotypes.

### 1.2.1 Mendelian disorders and associated genes

Genes known to be associated to disorders were identified using
[clinVar](http://www.ncbi.nlm.nih.gov/clinvar/) (**???**).
In this package we provide part of this information taken from the
ClinVarFullRelease\_2015-05.xml.gz
file.

The `geneByTrait` data frame provides the entrez gene IDs associated to
disorder. Association were filtered according to the following criteria:

* they all come from OMIM;
* they all have a **pathogenic** *clinical status*;
* they all have one of the following *origins*: **germline**, **de novo**,
  **inherited**, **maternal**, **paternal**, **biparental** or **uniparental**.

```
data(geneByTrait, package="PCAN")
head(geneByTrait, n=3)
```

```
##       entrez   db     id
## 2       3293 OMIM 264300
## 12      8813 OMIM 608799
## 22 101927631 OMIM 608799
```

```
dim(geneByTrait)
```

```
## [1] 4569    3
```

The `traitDef` data frame provides the names of the different disorders:

```
data(traitDef, package="PCAN")
head(traitDef, n=3)
```

```
##        db     id                                 name
## 8015 OMIM 610443      17q21.31 microdeletion syndrome
## 8016 OMIM 616034 2,4-Dienoyl-CoA reductase deficiency
## 8017 OMIM 300438   2-methyl-3-hydroxybutyric aciduria
```

The `geneDef` data frame provides basic information about the genes:

```
data(geneDef, package="PCAN")
head(geneDef, n=3)
```

```
##   entrez                     name symbol
## 1   2720    galactosidase, beta 1   GLB1
## 2   1509              cathepsin D   CTSD
## 3    846 calcium-sensing receptor   CASR
```

Since **we pretend** that we don’t know the association between the
*Joubert syndrome 9* (`disId <- "612285"`) and
*CC2D2A* (`genId <- "57545"`),
**let’s remove** it from the `geneByTrait` data frame:

```
geneByTrait <- geneByTrait[
    which(geneByTrait$id!=disId | geneByTrait$entrez!=genId),
]
dim(geneByTrait)
```

```
## [1] 4568    3
```

### 1.2.2 Human phenotype of mendelian disorders

OMIM disorders were associated to human phenotype using the
[phenotype\_annotation.tab](http://compbio.charite.de/hudson/job/hpo.annotations/1039/artifact/misc/phenotype_annotation.tab) file. The associations are
available in the `hpByTrait` data frame:

```
data(hpByTrait, package="PCAN")
head(hpByTrait, n=3)
```

```
##               hp   db     id
## 71837 HP:0000003 OMIM 100100
## 71839 HP:0000010 OMIM 100100
## 71840 HP:0000028 OMIM 100100
```

Description of the different HP terms were obtained from the
[hp.obo](http://compbio.charite.de/hudson/job/hpo/1529/artifact/hp/hp.obo) file.
They are available in the `hpDef` data frame:

```
data(hpDef, package="PCAN")
head(hpDef, n=3)
```

```
##           id                                     name
## 2 HP:0000002               Abnormality of body height
## 3 HP:0000003             Multicystic kidney dysplasia
## 7 HP:0000008 Abnormality of female internal genitalia
```

The same
[hp.obo](http://compbio.charite.de/hudson/job/hpo/1529/artifact/hp/hp.obo) file
was used to get the descendant HP and the ancestor HP for each HP term. They
are available in the `hp_descendants` and the `hp_ancestors` lists
respectively:

```
data(hp_descendants, hp_ancestors, package="PCAN")
lapply(head(hp_descendants, n=3), head)
```

```
## $`HP:0000002`
## [1] "HP:0000098" "HP:0000839" "HP:0001519" "HP:0001533" "HP:0001548"
## [6] "HP:0003498"
##
## $`HP:0000003`
## [1] "HP:0000003"
##
## $`HP:0000008`
## [1] "HP:0000013" "HP:0000130" "HP:0000131" "HP:0000132" "HP:0000134"
## [6] "HP:0000136"
```

```
lapply(head(hp_ancestors, n=3), head)
```

```
## $`HP:0000002`
## [1] "HP:0001507" "HP:0000118" "HP:0000001" "HP:0000002"
##
## $`HP:0000003`
## [1] "HP:0000107" "HP:0012210" "HP:0000077" "HP:0010935" "HP:0000079"
## [6] "HP:0000119"
##
## $`HP:0000008`
## [1] "HP:0000812" "HP:0010460" "HP:0012243" "HP:0000078" "HP:0000119"
## [6] "HP:0000118"
```

We only kept information related to the descendants of
Phenotypic abnormality
([HP:0000118](http://www.human-phenotype-ontology.org/hpoweb/showterm?id=HP:0000118)).

The `geneByHp` data frame, showing gene associated to each HP term, has been
created from the `geneByTrait` and the `hpByTrait`data frames. This data frame
is available in the package: `data(geneByHp, package="PCAN")`. However, since
**we pretend** in the frame of this example that we don’t know the association
between the *Joubert syndrome 9* and *CC2D2A*, we need to rebuild the `geneByHp`
data frame using our filtered `geneByTrait` data frame:

```
geneByHp <- unique(merge(
    geneByTrait,
    hpByTrait,
    by="id"
)[,c("entrez", "hp")])
head(geneByHp, n=3)
```

```
##   entrez         hp
## 1   1131 HP:0005199
## 2   1131 HP:0001374
## 3   1131 HP:0003422
```

### 1.2.3 Custom prior knowledge

Several objects representing some biological knowledge are attached to this
package for the convenience of the user.
Nevertheless, the package functions could be used with other source of
knowledge depending on the user needs and the updates of the different
resources.

In the frame of this project we provide some R scripts
(available in the `inst/DataPackage-Generator/` folder of the package)
allowing the generation
of a package gathering up-to-date information from different databases:

* [clinVar](http://www.ncbi.nlm.nih.gov/clinvar/) (**???**)
* [MedGen](http://www.ncbi.nlm.nih.gov/medgen/)
* [Human-Phenotype-Ontology](http://www.human-phenotype-ontology.org/)
  (**???**)
* [Orphanet](http://www.orpha.net/) (**???**)

Generating such a package is a way to get up-to-date information from these
sources. However, some other means could be more convenient for some users.
That’s why this data resource is not tightly coupled with the PCAN package.

# 2 Direct comparison of phenotypes

## 2.1 Phenotypes associated to the gene candidate

Let’s use our prior knowledge to find disorders, and eventually
human phenotypes, associated to the gene candidate *CC2D2A*:

```
genDis <- traitDef[
    match(
        geneByTrait[which(geneByTrait$entrez==genId), "id"],
        traitDef$id
    ),
]
genDis
```

```
##         db     id                   name
## 10479 OMIM 249000 Meckel syndrome type 1
## 10484 OMIM 612284 Meckel syndrome type 6
## 8809  OMIM 216360         COACH syndrome
```

```
genHpDef <- hpDef[
    match(
        geneByHp[which(geneByHp$entrez==genId), "hp"],
        hpDef$id
    ),
]
genHp <- genHpDef$id
dim(genHpDef)
```

```
## [1] 119   2
```

```
head(genHpDef)
```

```
##              id                              name
## 1765 HP:0002342 Intellectual disability, moderate
## 1974 HP:0002650                         Scoliosis
## 136  HP:0000154                        Wide mouth
## 1696 HP:0002240                      Hepatomegaly
## 2157 HP:0002896             Neoplasm of the liver
## 1716 HP:0002269 Abnormality of neuronal migration
```

How many of these 119 HP terms are shared with
the 8 HP related to the syndrome under
focus?

```
genHpDef[which(genHpDef$id %in% hpOfInterest),]
```

```
##              id                    name
## 506  HP:0000639               Nystagmus
## 1817 HP:0002419 Molar tooth sign on MRI
## 972  HP:0001250                Seizures
```

However some of the 116
*CC2D2A* associated HPs which are not among the
8 HPs of interest present strong similarity
with the last ones.
For example the
*Dandy-Walker malformation*
([HP:0001305](http://www.human-phenotype-ontology.org/hpoweb/showterm?id=HP:0001305))
phenotype, associated to *CC2D2A*,
is an indirect but closely related
[descendant](http://www.human-phenotype-ontology.org/hpoweb/showterm?id=HP:0001305&GETIMAGE=ANCESTORS)
of
*Ventriculomegaly*
([HP:0002119](http://www.human-phenotype-ontology.org/hpoweb/showterm?id=HP:0002119))
phenotype of interest.

The following steps describe a way to measure similarity between
different HP terms.

## 2.2 Information content and semantic similariy

Here we measure semantic similarity between HPs using gene information
content (IC). The formula below shows how information content
is computed for each HP term \(p\):

\[ IC\_{p} = -ln\left(\frac{|p|}{|root|}\right) \]

Where \(|p|\) is the number of gene associated to the HP term \(p\)
and all its descendants. \(root\), in our case, is
*Phenotypic abnormality*
([HP:0000118](http://www.human-phenotype-ontology.org/hpoweb/showterm?id=HP:0000118)). By definition:
\(IC\_{root} = -ln\left(\frac{|root|}{|root|}\right) = 0\).

Let’s use the `computeHpIC` function to compute IC for all HP terms
descendants of *Phenotypic abnormality* in the human phenotype ontology. This
function needs to know the genes associated to each HP and the
descendants of each HP term.

```
info <- unstack(geneByHp, entrez~hp)
ic <- computeHpIC(info, hp_descendants)
```

Let’s have a look at the distribution of IC:

![](data:image/png;base64...)

IC is an measure of the specificity of genes associated to HPs.
The higher IC, the more specific.

Semantic similarity (\(SS\_{p\_{1}p\_{2}}\)) between two HP terms is
then defined as the
IC of the most informative common ancestor (MICA) (i.e. showing
the higher IC).

Let’s use the `clacHpSim` function to compute the semantic similarity
between different couples of HP terms:

```
hp1 <- "HP:0000518"
hp2 <- "HP:0030084"
hpDef[which(hpDef$id %in% c(hp1, hp2)), 1:2]
```

```
##              id         name
## 401  HP:0000518     Cataract
## 9645 HP:0030084 Clinodactyly
```

```
calcHpSim(hp1, hp2, IC=ic, ancestors=hp_ancestors)
```

```
## [1] 0
```

```
hp1 <- "HP:0002119"
hp2 <- "HP:0001305"
hpDef[which(hpDef$id %in% c(hp1, hp2)), 1:2]
```

```
##              id                      name
## 1012 HP:0001305 Dandy-Walker malformation
## 1601 HP:0002119          Ventriculomegaly
```

```
calcHpSim(hp1, hp2, IC=ic, ancestors=hp_ancestors)
```

```
## [1] 2.850015
```

## 2.3 Comparing two sets of phenotype

Now, we can compute semantic similarity between all
HP of interest and *CC2D2A* associated HPs using
the `compMat` function:

```
compMat <- compareHPSets(
    hpSet1=genHp, hpSet2=hpOfInterest,
    IC=ic,
    ancestors=hp_ancestors,
    method="Resnik",
    BPPARAM=SerialParam()
)
dim(compMat)
```

```
## [1] 119   8
```

```
head(compMat)
```

```
##            HP:0000483 HP:0000510 HP:0000518 HP:0000639 HP:0001249 HP:0001250
## HP:0002342          0          0          0          0  1.4502253  0.5169219
## HP:0002650          0          0          0          0  0.0000000  0.0000000
## HP:0000154          0          0          0          0  0.0000000  0.0000000
## HP:0002240          0          0          0          0  0.0000000  0.0000000
## HP:0002896          0          0          0          0  0.0000000  0.0000000
## HP:0002269          0          0          0          0  0.4262711  0.4262711
##            HP:0002119 HP:0002419
## HP:0002342  0.4262711  0.4262711
## HP:0002650  0.0000000  0.0000000
## HP:0000154  0.0000000  0.0000000
## HP:0002240  0.0000000  0.0000000
## HP:0002896  0.0000000  0.0000000
## HP:0002269  0.9002305  0.9002305
```

Then we compute the symmetric semantic similarity score of the
matrix to get single value corresponding to similarity
between the two sets of HP terms: the HP terms of interest
and *CC2D2A* associated HPs.

```
hpSetCompSummary(compMat, method="bma", direction="symSim")
```

```
## [1] 1.357548
```

Unfortunately it is not easy to interpret such a score
and to assess it’s significance. To do it we need to
compare the score of the candidate gene (*CC2D2A*)
to the score of all the other genes for which we can compute
it. Let’s compute the score for all the genes:

```
## Compute semantic similarity between HP of interest and all HP terms
## This step is time consumming and can be parallelized.
## Use the BPPARAM parameter to specify your own
## back-end with appropriate number of workers.
hpGeneResnik <- compareHPSets(
    hpSet1=names(ic), hpSet2=hpOfInterest,
    IC=ic,
    ancestors=hp_ancestors,
    method="Resnik",
    BPPARAM=SerialParam()
)
## Group the results by gene
hpByGene <- unstack(geneByHp, hp~entrez)
hpMatByGene <- lapply(
    hpByGene,
    function(x){
        hpGeneResnik[x, , drop=FALSE]
    }
)
## Compute the corresponding scores
resnSss <- unlist(lapply(
    hpMatByGene,
    hpSetCompSummary,
    method="bma", direction="symSim"
))
## Get the score of the gene candidate
candScore <- resnSss[genId]
candScore
```

```
##    57545
## 1.357548
```

And now, we can compare the score of the candidate to all the others:

```
candRank <- sum(resnSss >= candScore)
candRank
```

```
## [1] 130
```

```
candRelRank <- candRank/length(resnSss)
candRelRank
```

```
## [1] 0.04086765
```

![](data:image/png;base64...)

**According to a direct comparison, the candidate gene *CC2D2A*
is in the top 4.1% genes the most relevant
for the set of HPs of interest. This result can be used for candidate
prioritization.**

# 3 The pathway consensus approach

Often, gene candidates are not known yet to be associated to any
genetic disorders. In such cases the prior knowledge can not be
used to associate HP terms to the gene and the direct comparison
of HP sets is not possible. In such situation we can focus genes
known to interact with the gene of interest or known to be involved
in the same biological processes and compute a consensus score
taking all of them into account. This *pathway consensus* approach
can also be used in addition to the direct comparison to provide
further confidence or insight into the relationship between the
gene candidate and the syndrome under focus.

## 3.1 Additional prior knowledge

To be able to apply such an approach we obviously need some information
about gene pathways or gene network. For the convenience of the user
we provide such an information within the package. However the user can
use any kind of resource depending on the needs.

Gene belonging to Reactome (**???**) pathways are provided in the
`hsEntrezByRPath` object. The name of the pathway can be found
in the `rPath` data frame.

```
data(hsEntrezByRPath, rPath, package="PCAN")
head(rPath, n=3)
```

```
##                   Pathway
## REACT_268024 REACT_268024
## REACT_75842   REACT_75842
## REACT_116145 REACT_116145
##                                                             Pathway_name
## REACT_268024                                    Intraflagellar transport
## REACT_75842  Antigen processing: Ubiquitination & Proteasome degradation
## REACT_116145                             PPARA activates gene expression
```

```
lapply(head(hsEntrezByRPath, 3), head)
```

```
## $REACT_268024
## [1] "23059" "51626" "83658" "83657" "79659" "8655"
##
## $REACT_75842
## [1] "29882" "10393" "51529" "25847" "64682" "29945"
##
## $REACT_116145
## [1] "19"    "34"    "2180"  "51129" "183"   "27063"
```

The STRING database (**???**) was used to get gene interactions.
This information, focused on Homo sapiens genes and on interaction
with a score higher than 500, can be found in the `hqStrNw` data frame:

```
data(hqStrNw, package="PCAN")
head(hqStrNw, n=3)
```

```
##   gene1 gene2 upstream
## 1   381   381    FALSE
## 2   381 23647    FALSE
## 3   381  8546    FALSE
```

## 3.2 Genes belonging to the pathways of the candidate

Here we are going to assess the relevance of genes involved in the
same pathways as *CC2D2A* for the HP terms of interest.

First, let’s identify the pathways in which *CC2D2A* is involved:

```
candPath <- names(hsEntrezByRPath)[which(unlist(lapply(
    hsEntrezByRPath,
    function(x) genId %in% x
)))]
rPath[which(rPath$Pathway %in% candPath),]
```

```
##                   Pathway                                       Pathway_name
## REACT_267965 REACT_267965 Anchoring of the basal body to the plasma membrane
```

Then we can retrieve the symmetric semantic similarity scores for all these
genes when the information is available. Let’s use the `hpGeneListComp`
function:

```
rPathRes <- hpGeneListComp(
    geneList=hsEntrezByRPath[[candPath]],
    ssMatByGene = hpMatByGene,
    geneSSScore = resnSss
)
```

This function returns a list with many information. Have a look at
`?hpGeneListComp` to get a complete description of this output.
Among the `scores` element of this output provides the scores for the
genes in the submitted list:

```
length(rPathRes$scores)
```

```
## [1] 88
```

```
sum(!is.na(rPathRes$scores))
```

```
## [1] 39
```

Among the 88 genes belonging to the same
pathway as *CC2D2A*, a score could be computed for only
39 of them.

The `p.value` element of the output provides the p-value returned
by `wilcox.test` comparing these scores to the scores of all the
genes not in the provided list.

![](data:image/png;base64...)

**This result show that in general the genes belonging to the
*Anchoring of the basal body to the plasma membrane* pathway
in which *CC2D2A* is involved are relevant
for the set of phenotype of interest.**

To get further insight we can explore the score of all
the genes belonging to this pathway:

```
pathSss <- rPathRes$scores[which(!is.na(rPathRes$scores))]
names(pathSss) <- geneDef[match(names(pathSss), geneDef$entrez), "symbol"]
par(mar=c(7.1, 4.1, 4.1, 2.1))
barplot(
    sort(pathSss),
    las=2,
    ylab=expression(Sim[sym]),
    main=rPath[which(rPath$Pathway %in% candPath),"Pathway_name"]
)
p <- c(0.25, 0.5, 0.75, 0.95)
abline(
    h=quantile(resnSss, probs=p),
    col="#BE0000",
    lty=c(2, 1, 2, 2),
    lwd=c(2, 2, 2, 1)
)
text(
    rep(0,4),
    quantile(resnSss, probs=p),
    p,
    pos=3,
    offset=0,
    col="#BE0000",
    cex=0.6
)
legend(
    "topleft",
    paste0(
        "Quantiles of the distribution of symmetric semantic similarity\n",
        "scores for all the genes."
    ),
    lty=1,
    col="#BE0000",
    cex=0.6
)
```

![](data:image/png;base64...)

Finally the `hpGeneHeatmap` function can be used to explore which
HP term of interest are best matched to each of the genes under
focus:

```
geneLabels <- geneDef$symbol[which(!duplicated(geneDef$entrez))]
names(geneLabels) <- geneDef$entrez[which(!duplicated(geneDef$entrez))]
hpLabels <- hpDef$name
names(hpLabels) <- hpDef$id
hpGeneHeatmap(
    rPathRes,
    genesOfInterest=genId,
    geneLabels=geneLabels,
    hpLabels=hpLabels,
    clustByGene=TRUE,
    clustByHp=TRUE,
    palFun=colorRampPalette(c("white", "red")),
    goiCol="blue",
    main=rPath[which(rPath$Pathway %in% candPath),"Pathway_name"]
)
```

![](data:image/png;base64...)

## 3.3 Genes interacting with the candidate

The same kind of analysis can be done with genes direct neighbors
of *CC2D2A* in the STRING database network:

```
neighbors <- unique(c(
    hqStrNw$gene1[which(hqStrNw$gene2==genId)],
    hqStrNw$gene2[which(hqStrNw$gene1==genId)],
    genId
))
neighRes <- hpGeneListComp(
    geneList=neighbors,
    ssMatByGene = hpMatByGene,
    geneSSScore = resnSss
)
```

![](data:image/png;base64...)

![](data:image/png;base64...)

![](data:image/png;base64...)

# 4 Session info

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
## [1] PCAN_1.38.0         BiocParallel_1.44.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] magick_2.9.0        xfun_0.53           jsonlite_2.0.0
##  [7] htmltools_0.5.8.1   tinytex_0.57        sass_0.4.10
## [10] rmarkdown_2.30      evaluate_1.0.5      jquerylib_0.1.4
## [13] fastmap_1.2.0       yaml_2.3.10         lifecycle_1.0.4
## [16] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
## [19] codetools_0.2-20    Rcpp_1.1.0          digest_0.6.37
## [22] R6_2.6.1            parallel_4.5.1      magrittr_2.0.4
## [25] bslib_0.9.0         tools_4.5.1         cachem_1.1.0
```

# 5 References

# Appendix