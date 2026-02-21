# Topology-based pathway analysis of RNA-seq data

Ivana Ihnatova1\* and Ludwig Geistlinger2\*\*

1Institute of Biostatistics and Analyses, Masarykova University Brno
2School of Public Health, City University of New York

\*ihnatova@iba.muni.cz
\*\*ludwig.geistlinger@sph.cuny.edu

#### *4 January 2019*

#### Abstract

The *ToPASeq* package implements methods for topology-based pathway analysis of RNA-seq data. This includes Topological Analysis of Pathway Phenotype Association (TAPPA; Gao and Wang, 2007), PathWay Enrichment Analysis (PWEA; Hung et al., 2010), and the Pathway Regulation Score (PRS; Ibrahim et al., 2012).

#### Package

ToPASeq 1.16.1

# Contents

* [1 Setup](#setup)
* [2 Preparing the data](#preparing-the-data)
* [3 Differential expression](#differential-expression)
* [4 Pathway analysis](#pathway-analysis)
  + [4.1 Pathway Regulation Score (PRS)](#pathway-regulation-score-prs)

# 1 Setup

**Note:** the *[ToPASeq](https://bioconductor.org/packages/3.8/ToPASeq)* package currently undergoes a major rework due to
the change of the package maintainer. It is recommended to use the topology-based methods
implemented in the *[EnrichmentBrowser](https://bioconductor.org/packages/3.8/EnrichmentBrowser)* or the *[graphite](https://bioconductor.org/packages/3.8/graphite)*
package instead.

We start by loading the package.

```
library(ToPASeq)
```

# 2 Preparing the data

For RNA-seq data, we consider transcriptome profiles of four primary human
airway smooth muscle cell lines in two conditions: control and treatment with
dexamethasone
[Himes et al., 2014](https://doi.org/10.1371/journal.pone.0099625).

We load the *[airway](https://bioconductor.org/packages/3.8/airway)* dataset

```
library(airway)
data(airway)
```

For further analysis, we only keep genes that are annotated to an ENSEMBL gene ID.

```
airSE <- airway[grep("^ENSG", rownames(airway)),]
dim(airSE)
```

```
## [1] 63677     8
```

```
assay(airSE)[1:4,1:4]
```

```
##                 SRR1039508 SRR1039509 SRR1039512 SRR1039513
## ENSG00000000003        679        448        873        408
## ENSG00000000005          0          0          0          0
## ENSG00000000419        467        515        621        365
## ENSG00000000457        260        211        263        164
```

# 3 Differential expression

The *[EnrichmentBrowser](https://bioconductor.org/packages/3.8/EnrichmentBrowser)* package incorporates established
functionality from the *[limma](https://bioconductor.org/packages/3.8/limma)* package for differential expression
analysis.
This involves the `voom` transformation when applied to RNA-seq data.
Alternatively, differential expression analysis for RNA-seq data can also be
carried out based on the negative binomial distribution with *[edgeR](https://bioconductor.org/packages/3.8/edgeR)*
and *[DESeq2](https://bioconductor.org/packages/3.8/DESeq2)*.

This can be performed using the function `EnrichmentBrowser::deAna`
and assumes some standardized variable names:

* **GROUP** defines the sample groups being contrasted,
* **BLOCK** defines paired samples or sample blocks, as e.g. for batch effects.

For more information on experimental design, see the
[limma user’s guide](https://www.bioconductor.org/packages/devel/bioc/vignettes/limma/inst/doc/usersguide.pdf),
chapter 9.

For the airway dataset, the **GROUP** variable indicates whether the cell
lines have been treated with dexamethasone (1) or not (0).

```
airSE$GROUP <- ifelse(airway$dex == "trt", 1, 0)
table(airSE$GROUP)
```

```
##
## 0 1
## 4 4
```

Paired samples, or in general sample batches/blocks, can be defined via a
**BLOCK** column in the `colData` slot.
For the airway dataset, the sample blocks correspond to the four different cell
lines.

```
airSE$BLOCK <- airway$cell
table(airSE$BLOCK)
```

```
##
## N052611 N061011 N080611  N61311
##       2       2       2       2
```

For RNA-seq data, the `deAna` function can be used to carry out differential
expression analysis between the two groups either based on functionality from
*limma* (that includes the `voom` transformation), or
alternatively, the frequently used *edgeR* or *DESeq2*
package. Here, we use the analysis based on *edgeR*.

```
library(EnrichmentBrowser)
airSE <- deAna(airSE, de.method="edgeR")
```

```
## Excluding 50740 genes not satisfying min.cpm threshold
```

```
rowData(airSE, use.names=TRUE)
```

```
## DataFrame with 12937 rows and 4 columns
##                                  FC           edgeR.STAT
##                           <numeric>            <numeric>
## ENSG00000000003  -0.404945626610932     35.8743710016452
## ENSG00000000419   0.182985434777531     5.90960619951562
## ENSG00000000457  0.0143477674070905   0.0233923316993606
## ENSG00000000460  -0.141173372957313    0.492929955080683
## ENSG00000000971   0.402240426474171     27.8509962017613
## ...                             ...                  ...
## ENSG00000273270   -0.12979385333726    0.901598359265221
## ENSG00000273290   0.505580471641003     23.0905678847793
## ENSG00000273311 0.00161557580855132 8.04821151395742e-05
## ENSG00000273329  -0.222817127090519     1.42723325850574
## ENSG00000273344  0.0151704005097405    0.005435032737617
##                                 PVAL            ADJ.PVAL
##                            <numeric>           <numeric>
## ENSG00000000003  0.00023480446553515 0.00213458295385677
## ENSG00000000419   0.0388020657296094  0.0915691945173217
## ENSG00000000457     0.88192930278718   0.922279475398735
## ENSG00000000460    0.500971503870371   0.619013213521584
## ENSG00000000971 0.000568781941938381 0.00403820532305421
## ...                              ...                 ...
## ENSG00000273270    0.367980257149634   0.495892935815196
## ENSG00000273290  0.00106330522558279 0.00639218387702814
## ENSG00000273311    0.993044448477588   0.996356136959404
## ENSG00000273329    0.263765393265588   0.388294594068834
## ENSG00000273344     0.94290685117858   0.962777106053456
```

# 4 Pathway analysis

Pathways are typically represented as graphs, where the nodes are genes and edges
between the nodes represent interaction between genes.

The *[graphite](https://bioconductor.org/packages/3.8/graphite)* package provides pathway collections from major
pathway databases such as KEGG, Biocarta, Reactome, and NCI.

Here, we retrieve human KEGG pathways.

```
library(graphite)
pwys <- pathways(species="hsapiens", database="kegg")
pwys
```

```
## KEGG pathways for hsapiens
## 303 entries, retrieved on 18-11-2018
```

As the airway dataset uses ENSEMBL gene IDs, but the nodes of the pathways are
based on NCBI Entrez Gene IDs,

```
nodes(pwys[[1]])
```

```
##  [1] "ENTREZID:10327"  "ENTREZID:124"    "ENTREZID:125"    "ENTREZID:126"
##  [5] "ENTREZID:127"    "ENTREZID:128"    "ENTREZID:130"    "ENTREZID:130589"
##  [9] "ENTREZID:131"    "ENTREZID:160287" "ENTREZID:1737"   "ENTREZID:1738"
## [13] "ENTREZID:2023"   "ENTREZID:2026"   "ENTREZID:2027"   "ENTREZID:217"
## [17] "ENTREZID:218"    "ENTREZID:219"    "ENTREZID:220"    "ENTREZID:2203"
## [21] "ENTREZID:221"    "ENTREZID:222"    "ENTREZID:223"    "ENTREZID:224"
## [25] "ENTREZID:226"    "ENTREZID:229"    "ENTREZID:230"    "ENTREZID:2538"
## [29] "ENTREZID:2597"   "ENTREZID:26330"  "ENTREZID:2645"   "ENTREZID:2821"
## [33] "ENTREZID:3098"   "ENTREZID:3099"   "ENTREZID:3101"   "ENTREZID:387712"
## [37] "ENTREZID:3939"   "ENTREZID:3945"   "ENTREZID:3948"   "ENTREZID:441531"
## [41] "ENTREZID:501"    "ENTREZID:5105"   "ENTREZID:5106"   "ENTREZID:5160"
## [45] "ENTREZID:5161"   "ENTREZID:5162"   "ENTREZID:5211"   "ENTREZID:5213"
## [49] "ENTREZID:5214"   "ENTREZID:5223"   "ENTREZID:5224"   "ENTREZID:5230"
## [53] "ENTREZID:5232"   "ENTREZID:5236"   "ENTREZID:5313"   "ENTREZID:5315"
## [57] "ENTREZID:55276"  "ENTREZID:55902"  "ENTREZID:57818"  "ENTREZID:669"
## [61] "ENTREZID:7167"   "ENTREZID:80201"  "ENTREZID:83440"  "ENTREZID:84532"
## [65] "ENTREZID:8789"   "ENTREZID:92483"  "ENTREZID:92579"  "ENTREZID:9562"
```

we first map the gene IDs in the airway dataset from ENSEMBL to ENTREZ IDs.

```
airSE <- idMap(airSE, org="hsa", from="ENSEMBL", to="ENTREZID")
```

```
## Loading required package: org.Hs.eg.db
```

```
## Loading required package: AnnotationDbi
```

```
##
```

```
## Encountered 125 from.IDs with >1 corresponding to.ID
```

```
## (the first to.ID was chosen for each of them)
```

```
## Excluded 1036 from.IDs without a corresponding to.ID
```

```
## Encountered 12 to.IDs with >1 from.ID (the first from.ID was chosen for each of them)
```

Next, we define all genes with adjusted *p*-value below 0.01 as differentially
expressed, and collect their log2 fold change for further analysis.

```
all <- names(airSE)
de.ind <- rowData(airSE)$ADJ.PVAL < 0.01
de <- rowData(airSE)$FC[de.ind]
names(de) <- all[de.ind]
```

This results in 2,426 DE genes - out of 11,780 genes in total.

```
length(all)
```

```
## [1] 11889
```

```
length(de)
```

```
## [1] 2443
```

## 4.1 Pathway Regulation Score (PRS)

The Pathway Regulation Score (PRS) incorporates the pathway topology by weighting
the indiviudal gene-level log2 fold changes by the number of downstream DE genes.
The weighted absolute fold changes are summed across the pathway and statistical
significance is assessed by permutation of genes.
[Ibrahim et al., 2012](https://doi.org/10.1089/cmb.2011.0182)

```
res <- prs(de, all, pwys[1:100], nperm=100)
```

```
## 9 pwys were filtered out
```

```
head(res)
```

```
##                                  nPRS    p.value
## Arachidonic acid metabolism 11.820679 0.00990099
## cGMP-PKG signaling pathway  10.631185 0.00990099
## Histidine metabolism         9.524565 0.00990099
## cAMP signaling pathway       8.281481 0.00990099
## Ras signaling pathway        7.793608 0.00990099
## beta-Alanine metabolism      5.821917 0.00990099
```

Corresponding gene weights (number of downstream DE genes) can be obtained for a
pathway of choice via

```
ind <- grep("Ras signaling pathway", names(pwys))
weights <- prsWeights(pwys[[ind]], de, all)
weights
```

```
##       572      5898      3479     10928      3082      9846      4254
##         0         6         0         4         5         0         0
##      5601      5291       387     11186     10235     10681      2255
##         0         0         0         1        21         0         5
##       998      5566      9462      5337      5063      2260      2782
##         0         0        22         0         1         0         0
##      8315        25      5594      6655      6789      2254      5595
##         0         0         0         0         0         0         0
##      3551       208      8605     10156      4233      5599      8036
##         0         0         1         0         0         0         0
##      5878      4790      5602      2549      5869      2784     55770
##         0         0         1         1         0         0         0
##      7422      5924      2246      5159     59345      6654      5906
##         5        22         0         0        23         0         0
##      5321     10000      8503      5228      7010      5290     81579
##         1         0         4         0         0         4         0
##      5335      6237      2002      5605      5908      2791     91860
##         0        21         1         0         0         0         0
##      5338     25759      4301     10298      5894      3845     22800
##         0         0         0         0         2         0        21
##      5156      2113      5879     51196      2250      2247      2252
##         2         0         2        21         0         0         0
##      3480      8844       207      1969      5567        27     23179
##         2         0         0         0        23         1         7
##       805      5899      5868     56034      5295      5921      1956
##         0         0         0         5         4         0         0
##      4915     53358      5058      7424       284      5578      5922
##         0         1         0         5         5         0         0
##      8817      3815      2114     22808       808      5900      6464
##         0         0         0         0         0         7         0
##      2264      5966      2277       382      3481      5604      5881
##         2         0         0         0         0         1         2
## 100271927     80310      3643       598      5293      2783     55970
##         0         0         0         0         4        23         0
##      5970      7423      2787      3265      9610     11145      2788
##         0         0        23         0         2         0         0
##       627      2885      5781      5062     29110      1946      1435
##         0         0         1         0         0         0         0
##      8398      4303      4908     22821     54331      5320      4763
##         0         0         0         0        23         1         0
##      8831      5154       801      4893      1147      5863      1945
##         0         0        23         0         0         0         5
```

Inspecting the genes with maximum number of downstream DE genes

```
weights[weights == max(weights)]
```

```
## 59345  5567  2783  2787 54331   801
##    23    23    23    23    23    23
```

reveals important upstream regulators including several G protein subunits
such as subunit beta 2 (Entrez Gene ID
[2783](https://www.ncbi.nlm.nih.gov/gene/?term=2783)).