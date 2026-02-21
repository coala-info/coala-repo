# GOfuncR: Gene Ontology Enrichment Using FUNC

Steffi Grote

#### May 23, 2021

# Contents

* [1 Overview](#overview)
  + [1.1 Functions included in `GOfuncR`](#functions-included-in-gofuncr)
  + [1.2 Core function `go_enrich`](#core-function-go_enrich)
* [2 Examples of GO-enrichment analyses for human genes](#examples-of-go-enrichment-analyses-for-human-genes)
  + [2.1 Install annotation package](#install-annotation-package)
  + [2.2 Test for gene set enrichment using the hypergeometric test](#test-for-gene-set-enrichment-using-the-hypergeometric-test)
    - [2.2.1 Hypergeometric test using the default background gene set](#hypergeometric-test-using-the-default-background-gene-set)
    - [2.2.2 Hypergeometric test using a defined background gene set](#hypergeometric-test-using-a-defined-background-gene-set)
    - [2.2.3 Hypergeometric test with correction for gene length](#hypergeometric-test-with-correction-for-gene-length)
    - [2.2.4 Hypergeometric test with genomic regions as input](#hypergeometric-test-with-genomic-regions-as-input)
  + [2.3 Test for enrichment of high scored genes using the Wilcoxon rank-sum test](#test-for-enrichment-of-high-scored-genes-using-the-wilcoxon-rank-sum-test)
  + [2.4 Test for enrichment using the binomial test](#test-for-enrichment-using-the-binomial-test)
  + [2.5 Test for enrichment using the 2x2 contingency table test](#test-for-enrichment-using-the-2x2-contingency-table-test)
* [3 Enrichment analyses with different annotations or ontologies](#enrichment-analyses-with-different-annotations-or-ontologies)
  + [3.1 Other annotation packages](#other-annotation-packages)
  + [3.2 Custom annotations](#custom-annotations)
  + [3.3 Custom gene-coordinates](#custom-gene-coordinates)
  + [3.4 Custom GO-graph](#custom-go-graph)
    - [3.4.1 Conversion from *.obo* format](#conversion-from-.obo-format)
* [4 Additional functionalities](#additional-functionalities)
  + [4.1 Plot distribution of gene-associated variables from an enrichment analysis](#plot-distribution-of-gene-associated-variables-from-an-enrichment-analysis)
  + [4.2 Explore the GO-graph](#explore-the-go-graph)
  + [4.3 Retrieve associations between genes and GO-categories](#retrieve-associations-between-genes-and-go-categories)
  + [4.4 Refine results from go\_enrich](#refine-results-from-go_enrich)
* [5 Schematics](#schematics)
  + [5.1 Schematic 1: Hypergeometric test and FWER calculation](#schematic-1-hypergeometric-test-and-fwer-calculation)
  + [5.2 Schematic 2: circ\_chrom option for genomic regions input](#schematic-2-circ_chrom-option-for-genomic-regions-input)
* [6 Session Info](#session-info)
* [7 References](#references)
* **Appendix**

# 1 Overview

*[GOfuncR](https://bioconductor.org/packages/3.22/GOfuncR)* performs a gene ontology enrichment analysis based on the ontology enrichment software FUNC [1,2].
It provides the standard candidate vs. background enrichment analysis using the **hypergeometric test**, as well as three additional tests: (i) the **Wilcoxon rank-sum test** that is used when genes are ranked, (ii) a **binomial test** that can be used when genes are associated with two counts, e.g. amino acid changes since a common ancestor in two different species, and (iii) a **2x2 contingency table test** that is used in cases when genes are associated with four counts, e.g. non-synonymous or synonymous variants that are fixed between or variable within species.
To correct for multiple testing and interdependency of the tests, family-wise error rates (FWER) are computed based on random permutations of the gene-associated variables (see [Schematic 1](#hyper_scheme) below).
*[GOfuncR](https://bioconductor.org/packages/3.22/GOfuncR)* also provides tools for exploring the ontology graph and the annotations, and options to take gene-length or spatial clustering of genes into account during testing.
GO-annotations and gene-coordinates are obtained from *OrganismDb* packages (*[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)* by default) or *OrgDb* and *TxDb* packages.
The gene ontology graph (obtained from [geneontology](http://current.geneontology.org/ontology/), release date 01-May-2021), is integrated in the package.
It is also possible to provide custom gene coordinates, annotations and ontologies.

![](data:image/png;base64... "overview tests")

input data and test selection

## 1.1 Functions included in `GOfuncR`

| function | description |
| --- | --- |
| [go\_enrich](#go_enrich) | core function for performing enrichment analyses given a candidate gene set |
| [plot\_anno\_scores](#plot_anno) | plots distribution of scores of genes annotated to GO-categories |
| [get\_parent\_nodes](#graph) | returns all parent-nodes of input GO-categories |
| [get\_child\_nodes](#graph) | returns all child-nodes of input GO-categories |
| [get\_names](#get_names) | returns the full names of input GO-categories |
| [get\_ids](#get_ids) | returns all GO-categories that contain the input string |
| [get\_anno\_genes](#get_anno_g) | returns genes that are annotated to input GO-categories |
| [get\_anno\_categories](#get_anno_c) | returns GO-categories that input genes are annotated to |
| [refine](#refine) | restrict results to most specific GO-categories |

## 1.2 Core function `go_enrich`

The function `go_enrich` performs all enrichment analyses given input genes and has the following parameters:

| parameter | default | description |
| --- | --- | --- |
| `genes` | - | a dataframe with gene-symbols or genomic regions and gene-associated variables |
| `test` | ‘hyper’ | statistical test to use (‘hyper’, ‘wilcoxon’, ‘binomial’ or ‘contingency’) |
| `n_randsets` | 1000 | number of randomsets for computing the family-wise error rate |
| `organismDb` | ‘Homo.sapiens’ | *OrganismDb* package for GO-annotations and gene coordinates |
| `gene_len` | FALSE | correct for gene length (only for `test='hyper'`) |
| `regions` | FALSE | chromosomal regions as input instead of independent genes (only for `test='hyper'`) |
| `circ_chrom` | FALSE | use background on circularized chromosome (only for `test='hyper'` and `regions=TRUE`) |
| `silent` | FALSE | suppress output to screen |
| `domains` | NULL | optional vector of GO-domains (if NULL all 3 domains are analyzed) |
| `orgDb` | NULL | optional *OrgDb* package for GO-annotations (overrides `organismDb`) |
| `txDb` | NULL | optional *TxDb* package for gene-coordinates (overrides `organismDb`) |
| `annotations` | NULL | optional dataframe with GO-annotations (overrides `organismDb` and `orgDb`) |
| `gene_coords` | NULL | optional dataframe with gene-coordinates (overrides `organismDb` and `txDb`) |
| `godir` | NULL | optional directory with ontology graph tables to use instead of the integrated GO-graph |

# 2 Examples of GO-enrichment analyses for human genes

## 2.1 Install annotation package

`GOfuncR` uses external packages to obtain the GO-annotations and gene-coordinates.
In the examples we will use the default *[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)* package.
See below for examples [how to use other packages](#other_db) or [how to provide custom annotations](#cu_anno).

```
## install annotation package 'Homo.sapiens' from bioconductor
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install('Homo.sapiens')
```

## 2.2 Test for gene set enrichment using the hypergeometric test

The hypergeometric test evaluates the over- or under-representation of a set of candidate genes in GO-categories, compared to a set of background genes (see [Schematic 1](#hyper_scheme) below).
The input for the hypergeometric test is a dataframe with two columns: (1) a column with gene-symbols and (2) a binary column with `1` for a candidate gene and `0` for a background gene.

### 2.2.1 Hypergeometric test using the default background gene set

The declaration of background genes is optional.
If only candidate genes are defined, then all remaining genes from the annotation package are used as default background.
In this example GO-enrichment of 13 human genes will be tested:

```
## load GOfuncR package
library(GOfuncR)
## create input dataframe with candidate genes
gene_ids = c('NCAPG', 'APOL4', 'NGFR', 'NXPH4', 'C21orf59', 'CACNG2', 'AGTR1',
    'ANO1', 'BTBD3', 'MTUS1', 'CALB1', 'GYG1', 'PAX2')
input_hyper = data.frame(gene_ids, is_candidate=1)
input_hyper
```

```
##    gene_ids is_candidate
## 1     NCAPG            1
## 2     APOL4            1
## 3      NGFR            1
## 4     NXPH4            1
## 5  C21orf59            1
## 6    CACNG2            1
## 7     AGTR1            1
## 8      ANO1            1
## 9     BTBD3            1
## 10    MTUS1            1
## 11    CALB1            1
## 12     GYG1            1
## 13     PAX2            1
```

This dataframe is the only mandatory input for `go_enrich`, however to lower computation time for the examples, we also lower the number of randomsets that are generated to compute the FWER:

```
## run enrichment analysis (n_randets=100 lowers compuation time
## compared to default 1000)
res_hyper = go_enrich(input_hyper, n_randset=100)
```

The output of `go_enrich` is a list of 4 elements:
The most important is the first element which contains the results from the enrichment analysis (ordered by FWER for over-representation of candidate genes):

```
## first element of go_enrich result has the stats
stats = res_hyper[[1]]
## top-GO categories
head(stats)
```

```
##             ontology    node_id                                        node_name raw_p_underrep raw_p_overrep
## 1 biological_process GO:0072025             distal convoluted tubule development      1.0000000  3.710011e-06
## 2 biological_process GO:0072221 metanephric distal convoluted tubule development      1.0000000  3.710011e-06
## 3 biological_process GO:0072235            metanephric distal tubule development      1.0000000  7.785513e-06
## 4 biological_process GO:0072205          metanephric collecting duct development      1.0000000  1.666555e-05
## 5 biological_process GO:0072017                        distal tubule development      1.0000000  2.442552e-05
## 6 cellular_component GO:0098686           hippocampal mossy fiber to CA3 synapse      0.9999975  3.384721e-04
##   FWER_underrep FWER_overrep
## 1             1         0.00
## 2             1         0.00
## 3             1         0.02
## 4             1         0.02
## 5             1         0.04
## 6             1         0.04
```

```
## top GO-categories per domain
by(stats, stats$ontology, head, n=3)
```

```
## stats$ontology: biological_process
##             ontology    node_id                                        node_name raw_p_underrep raw_p_overrep
## 1 biological_process GO:0072025             distal convoluted tubule development              1  3.710011e-06
## 2 biological_process GO:0072221 metanephric distal convoluted tubule development              1  3.710011e-06
## 3 biological_process GO:0072235            metanephric distal tubule development              1  7.785513e-06
##   FWER_underrep FWER_overrep
## 1             1         0.00
## 2             1         0.00
## 3             1         0.02
## ----------------------------------------------------------------------------------
## stats$ontology: cellular_component
##              ontology    node_id                              node_name raw_p_underrep raw_p_overrep
## 6  cellular_component GO:0098686 hippocampal mossy fiber to CA3 synapse      0.9999975  0.0003384721
## 19 cellular_component GO:0098984               neuron to neuron synapse      0.9999285  0.0015729405
## 31 cellular_component GO:0045202                                synapse      0.9997856  0.0020548751
##    FWER_underrep FWER_overrep
## 6              1         0.04
## 19             1         0.33
## 31             1         0.57
## ----------------------------------------------------------------------------------
## stats$ontology: molecular_function
##              ontology    node_id
## 20 molecular_function GO:0001596
## 21 molecular_function GO:0099567
## 40 molecular_function GO:0008466
##                                                                                         node_name
## 20                                                           angiotensin type I receptor activity
## 21 calcium ion binding involved in regulation of postsynaptic cytosolic calcium ion concentration
## 40                                                        glycogenin glucosyltransferase activity
##    raw_p_underrep raw_p_overrep FWER_underrep FWER_overrep
## 20      1.0000000  0.0006434316             1         0.52
## 21      1.0000000  0.0006434316             1         0.52
## 40      0.9999996  0.0012864837             1         0.77
```

The second element is a dataframe with all valid input genes:

```
## all valid input genes
head(res_hyper[[2]])
```

```
##   gene_ids is_candidate
## 1    AGTR1            1
## 2     ANO1            1
## 3    APOL4            1
## 4    BTBD3            1
## 5   CACNG2            1
## 6    CALB1            1
```

The third element states the reference genome for the annotations and the version of the GO-graph:

```
## annotation package used (default='Homo.sapiens') and GO-graph version
res_hyper[[3]]
```

```
##             type           db     version
## 1 go_annotations Homo.sapiens       1.3.1
## 2       go_graph   integrated 23-Mar-2020
```

The fourth element is a dataframe with the minimum p-values from the permutations, which are used to compute the FWER:

```
## minimum p-values from randomsets
head(res_hyper[[4]])
```

```
##             ontology  lower_tail   upper_tail
## 1 biological_process 0.002477327 7.785513e-06
## 2 biological_process 0.004172074 7.785513e-06
## 3 biological_process 0.008133670 1.696065e-05
## 4 biological_process 0.009813285 2.442552e-05
## 5 biological_process 0.010235820 2.885632e-05
## 6 biological_process 0.010235820 4.434725e-05
```

### 2.2.2 Hypergeometric test using a defined background gene set

Instead of using the default background gene set, it will often be more accurate to just include those genes in the background gene set, that were studied in the experiment that led to the discovery of the candidate genes.
For example, if the candidate genes are based on microarray expression data, than the background gene set should consist of all genes on the array.
To define a background gene set, just add lines to the input dataframe where the gene-associated variable in the second column is a `0`.
Note that all candidate genes are implicitly part of the background gene set and do not need to be defined as background.

```
## create input dataframe with candidate and background genes
candi_gene_ids = c('NCAPG', 'APOL4', 'NGFR', 'NXPH4', 'C21orf59', 'CACNG2',
    'AGTR1', 'ANO1', 'BTBD3', 'MTUS1', 'CALB1', 'GYG1', 'PAX2')
bg_gene_ids = c('FGR', 'NPHP1', 'DRD2', 'ABCC10', 'PTBP2', 'JPH4', 'SMARCC2',
    'FN1', 'NODAL', 'CYP1A2', 'ACSS1', 'CDHR1', 'SLC25A36', 'LEPR', 'PRPS2',
    'TNFAIP3', 'NKX3-1', 'LPAR2', 'PGAM2')
is_candidate = c(rep(1,length(candi_gene_ids)), rep(0,length(bg_gene_ids)))
input_hyper_bg = data.frame(gene_ids = c(candi_gene_ids, bg_gene_ids),
    is_candidate)
head(input_hyper_bg)
```

```
##   gene_ids is_candidate
## 1    NCAPG            1
## 2    APOL4            1
## 3     NGFR            1
## 4    NXPH4            1
## 5 C21orf59            1
## 6   CACNG2            1
```

```
tail(input_hyper_bg)
```

```
##    gene_ids is_candidate
## 27     LEPR            0
## 28    PRPS2            0
## 29  TNFAIP3            0
## 30   NKX3-1            0
## 31    LPAR2            0
## 32    PGAM2            0
```

The enrichment analysis is performed like before, again with only 100 randomsets to lower computation time.

```
res_hyper_bg = go_enrich(input_hyper_bg, n_randsets=100)
```

```
head(res_hyper_bg[[1]])
```

```
##             ontology    node_id                node_name raw_p_underrep raw_p_overrep FWER_underrep
## 1 cellular_component GO:0005634                  nucleus      0.9955455    0.03236124             1
## 2 cellular_component GO:0098984 neuron to neuron synapse      1.0000000    0.04894327             1
## 3 cellular_component GO:0031981            nuclear lumen      0.9930224    0.05848093             1
## 4 cellular_component GO:0045202                  synapse      0.9930224    0.05848093             1
## 5 cellular_component GO:0030054            cell junction      0.9780006    0.11928353             1
## 6 cellular_component GO:0005576     extracellular region      0.9676388    0.13654657             1
##   FWER_overrep
## 1         0.25
## 2         0.59
## 3         0.65
## 4         0.65
## 5         0.75
## 6         0.82
```

### 2.2.3 Hypergeometric test with correction for gene length

If the chance of a gene to be discovered as a candidate gene is higher for longer genes (e.g. the chance to have an amino-acid change compared to another species), it can be helpful to also correct for this length-bias in the calculation of the family-wise error rate (FWER).
`go_enrich` therefore offers the `gene_len` option: while with the default `gene_len=FALSE` candidate and background genes are permuted randomly in the randomsets (see [Schematic 1](#hyper_scheme)), `gene_len=TRUE` makes the chance of a gene to be chosen as a candidate gene in a randomset dependent on its gene length.

```
## test input genes again with correction for gene length
res_hyper_len = go_enrich(input_hyper, gene_len=TRUE)
```

Note that the default annotation package *[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)* uses the *hg19* gene-coordinates.
See below for examples how to use [other packages](#other_db) or [custom gene-coordinates](#cu_coord).

### 2.2.4 Hypergeometric test with genomic regions as input

Instead of defining candidate and background genes explicitly in the input dataframe, it is also possible to define entire chromosomal regions as candidate and background regions.
The GO-enrichment is then tested for all genes located in, or overlapping the candidate regions on the plus or the minus strand.

In comparison to defining candidate and background genes explicitly, this option has the advantage that the FWER accounts for spatial clustering of genes.
For the random permutations used to compute the FWER, blocks as long as candidate regions are chosen from the merged candidate and background regions and genes contained in these blocks are considered candidate genes.
The option `circ_chrom` defines whether random candidate blocks are chosen from the same chromosome or not ([Schematic 2](#block_scheme)).

To define chromosomal regions in the input dataframe, the entries in the first column have to be of the form `chr:start-stop`, where `start` always has to be smaller than `stop`.
Note that this option requires the input of background regions.
If multiple candidate regions are provided, in the randomsets they are placed randomly (but without overlap) into the merged candidate and background regions.

```
## create input vector with a candidate region on chromosome 8
## and background regions on chromosome 7, 8 and 9
regions = c('8:81000000-83000000', '7:1300000-56800000', '7:74900000-148700000',
    '8:7400000-44300000', '8:47600000-146300000', '9:0-39200000',
    '9:69700000-140200000')
is_candidate = c(1, rep(0,6))
input_regions = data.frame(regions, is_candidate)
input_regions
```

```
##                regions is_candidate
## 1  8:81000000-83000000            1
## 2   7:1300000-56800000            0
## 3 7:74900000-148700000            0
## 4   8:7400000-44300000            0
## 5 8:47600000-146300000            0
## 6         9:0-39200000            0
## 7 9:69700000-140200000            0
```

```
## run GO-enrichment analysis for genes in the candidate region
res_region = go_enrich(input_regions, n_randsets=100, regions=TRUE)
```

The output of `go_enrich` for genomic regions is identical to the one that is produced for single genes.
The first element of the output list contains the results of the enrichment analysis and the second element contains the candidate and background genes located in the user-defined regions:

```
stats_region = res_region[[1]]
head(stats_region)
```

```
##             ontology    node_id                   node_name raw_p_underrep raw_p_overrep FWER_underrep
## 1 molecular_function GO:0005504          fatty acid binding              1  4.827316e-11          1.00
## 2 molecular_function GO:0033293 monocarboxylic acid binding              1  1.002183e-09          1.00
## 3 molecular_function GO:0031406     carboxylic acid binding              1  4.773405e-08          0.99
## 4 biological_process GO:0015908        fatty acid transport              1  4.809561e-08          0.99
## 5 biological_process GO:0015849      organic acid transport              1  5.463624e-08          0.99
## 6 biological_process GO:0006869             lipid transport              1  1.255590e-06          0.99
##   FWER_overrep
## 1         0.07
## 2         0.07
## 3         0.08
## 4         0.09
## 5         0.09
## 6         0.12
```

```
## see which genes are located in the candidate region
input_genes = res_region[[2]]
candidate_genes = input_genes[input_genes[,2]==1, 1]
candidate_genes
```

```
##  [1] "CHMP4C"  "FABP4"   "FABP5"   "FABP9"   "FABP12"  "IMPA1"   "PAG1"    "PMP2"    "SLC10A5" "SNX16"
## [11] "TPD52"   "ZBTB10"  "ZFAND1"  "ZNF704"
```

Note that the default annotation package *[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)* uses the *hg19* gene-coordinates.
See below for examples how to use [other packages](#other_db) or [custom gene-coordinates](#cu_coord).

## 2.3 Test for enrichment of high scored genes using the Wilcoxon rank-sum test

When genes are not divided into candidate and background genes, but are ranked by some kind of score, e.g. a p-value for differential expression, a Wilcoxon rank-sum test can be performed to find GO-categories where genes with high (or low) scores are over-represented.
This example uses genes ranked by random scores:

```
## create input dataframe with scores in second column
high_score_genes = c('GCK', 'CALB1', 'PAX2', 'GYS1','SLC2A8', 'UGP2', 'BTBD3',
    'MTUS1', 'SYP', 'PSEN1')
low_score_genes = c('CACNG2', 'ANO1', 'ZWINT', 'ENGASE', 'HK2', 'PYGL', 'GYG1')
gene_scores = c(runif(length(high_score_genes), 0.5, 1),
    runif(length(low_score_genes), 0, 0.5))
input_willi = data.frame(gene_ids = c(high_score_genes, low_score_genes),
    gene_scores)
head(input_willi)
```

```
##   gene_ids gene_scores
## 1      GCK   0.6284683
## 2    CALB1   0.7368831
## 3     PAX2   0.7648268
## 4     GYS1   0.7799225
## 5   SLC2A8   0.5804260
## 6     UGP2   0.5568016
```

```
res_willi = go_enrich(input_willi, test='wilcoxon', n_randsets=100)
```

The output is analogous to the one for the hypergeometric test:

```
head(res_willi[[1]])
```

```
##             ontology    node_id                                             node_name raw_p_low_rank
## 1 biological_process GO:0000904        cell morphogenesis involved in differentiation      0.9901175
## 2 biological_process GO:0030182                                neuron differentiation      0.9901175
## 3 biological_process GO:0031175                         neuron projection development      0.9901175
## 4 biological_process GO:0048666                                    neuron development      0.9901175
## 5 biological_process GO:0048667 cell morphogenesis involved in neuron differentiation      0.9901175
## 6 biological_process GO:0048699                                 generation of neurons      0.9901175
##   raw_p_high_rank FWER_low_rank FWER_high_rank
## 1      0.01373432             1           0.32
## 2      0.01373432             1           0.32
## 3      0.01373432             1           0.32
## 4      0.01373432             1           0.32
## 5      0.01373432             1           0.32
## 6      0.01373432             1           0.32
```

Note that when p-values are used as scores, often one would want to look for enrichment of low ranks, i.e. low p-values (or alternatively use (1 - p-value) as score and check for enrichment of high ranks).

## 2.4 Test for enrichment using the binomial test

When genes are associated with two counts *A* and *B*, e.g. amino-acid changes since a common ancestor in two species, a binomial test can be used to identify GO-categories with an enrichment of genes with a high fraction of one of the counts compared to the fraction in the root node.
To perform the binomial test the input dataframe needs a column with the gene symbols and two additional columns with the corresponding counts:

```
## create a toy example dataset with two counts per gene
high_A_genes = c('G6PD', 'GCK', 'GYS1', 'HK2', 'PYGL', 'SLC2A8', 'UGP2',
    'ZWINT', 'ENGASE')
low_A_genes = c('CACNG2', 'AGTR1', 'ANO1', 'BTBD3', 'MTUS1', 'CALB1', 'GYG1',
    'PAX2')
A_counts = c(sample(20:30, length(high_A_genes)),
    sample(5:15, length(low_A_genes)))
B_counts = c(sample(5:15, length(high_A_genes)),
    sample(20:30, length(low_A_genes)))
input_binom = data.frame(gene_ids=c(high_A_genes, low_A_genes), A_counts,
    B_counts)
head(input_binom)
```

```
##   gene_ids A_counts B_counts
## 1     G6PD       23        5
## 2      GCK       29       15
## 3     GYS1       20       13
## 4      HK2       21       12
## 5     PYGL       25       10
## 6   SLC2A8       28       14
```

In this example we also use the `domains` option to reduce the analysis to `molecular_function` and `cellular_component`.
Also the `silent` option is used, which suppresses all output that would be written to the screen (except for warnings and errors):

```
## run binomial test, excluding the 'biological_process' domain,
## suppress output to screen
res_binom = go_enrich(input_binom, test='binomial', n_randsets=100,
    silent=TRUE, domains=c('molecular_function', 'cellular_component'))
head(res_binom[[1]])
```

```
##             ontology    node_id                    node_name raw_p_high_B raw_p_high_A FWER_high_B
## 1 molecular_function GO:0005536              glucose binding    1.0000000 1.212636e-08           1
## 2 molecular_function GO:0030246         carbohydrate binding    1.0000000 1.212636e-08           1
## 3 molecular_function GO:0048029       monosaccharide binding    1.0000000 1.212636e-08           1
## 4 molecular_function GO:0000166           nucleotide binding    0.9999999 1.388479e-07           1
## 5 molecular_function GO:1901265 nucleoside phosphate binding    0.9999999 1.388479e-07           1
## 6 molecular_function GO:0003824           catalytic activity    0.9999993 1.372062e-06           1
##   FWER_high_A
## 1        0.03
## 2        0.03
## 3        0.03
## 4        0.10
## 5        0.10
## 6        0.22
```

## 2.5 Test for enrichment using the 2x2 contingency table test

When genes are associated with four counts (*A*-*D*), e.g. non-synonymous or synonymous variants that are fixed between or variable within species, like for a McDonald-Kreitman test [3], the 2x2 contingency table test can be used.
It can identify GO-categories which have a high ratio of *A/B* compared to *C/D*, which in this example would correspond to a high ratio of *non-synonymous substitutions / synonymous substitutions* compared to *non-synonymous variable / synonymous variable*:

```
## create a toy example with four counts per gene
high_substi_genes = c('G6PD', 'GCK', 'GYS1', 'HK2', 'PYGL', 'SLC2A8', 'UGP2',
    'ZWINT', 'ENGASE')
low_substi_genes = c('CACNG2', 'AGTR1', 'ANO1', 'BTBD3', 'MTUS1', 'CALB1',
    'GYG1', 'PAX2', 'C21orf59')
subs_non_syn = c(sample(5:15, length(high_substi_genes), replace=TRUE),
    sample(0:5, length(low_substi_genes), replace=TRUE))
subs_syn = sample(5:15, length(c(high_substi_genes, low_substi_genes)),
    replace=TRUE)
vari_non_syn = c(sample(0:5, length(high_substi_genes), replace=TRUE),
    sample(0:10, length(low_substi_genes), replace=TRUE))
vari_syn = sample(5:15, length(c(high_substi_genes, low_substi_genes)),
    replace=TRUE)
input_conti = data.frame(gene_ids=c(high_substi_genes, low_substi_genes),
    subs_non_syn, subs_syn, vari_non_syn, vari_syn)
head(input_conti)
```

```
##   gene_ids subs_non_syn subs_syn vari_non_syn vari_syn
## 1     G6PD            8        9            1        7
## 2      GCK           12        8            1       11
## 3     GYS1           11        5            1       12
## 4      HK2            7        6            1       13
## 5     PYGL           14       11            2       14
## 6   SLC2A8           10        5            2        7
```

```
## the corresponding contingency table for the first gene would be:
matrix(input_conti[1, 2:5], ncol=2,
    dimnames=list(c('non-synonymous', 'synonymous'),
    c('substitution','variable')))
```

```
##                substitution variable
## non-synonymous 8            1
## synonymous     9            7
```

```
res_conti = go_enrich(input_conti, test='contingency', n_randset=100)
```

The output is analogous to that of the other tests:

```
head(res_conti[[1]])
```

```
##             ontology    node_id                      node_name raw_p_high_CD raw_p_high_AB FWER_high_CD
## 1 molecular_function GO:0003824             catalytic activity             1  1.978761e-11            1
## 2 molecular_function GO:0005536                glucose binding             1  2.711384e-10            1
## 3 molecular_function GO:0030246           carbohydrate binding             1  2.711384e-10            1
## 4 molecular_function GO:0048029         monosaccharide binding             1  2.711384e-10            1
## 5 molecular_function GO:0016740           transferase activity             1  4.217744e-09            1
## 6 biological_process GO:0005975 carbohydrate metabolic process             1  1.140367e-10            1
##   FWER_high_AB
## 1         0.00
## 2         0.00
## 3         0.00
## 4         0.00
## 5         0.01
## 6         0.02
```

Depending on the counts for each GO-category a Chi-square or Fisher’s exact test is performed.
Note that this is the only test that is not dependent on the distribution of the gene-associated variables in the root nodes.

# 3 Enrichment analyses with different annotations or ontologies

## 3.1 Other annotation packages

Annotation package types suggested for `GOfuncR`:

| annotation package | information used in `GOfuncR` |
| --- | --- |
| [*OrganismDb*](http://www.bioconductor.org/packages/release/BiocViews.html#___OrganismDb) | GO-annotations + gene-coordinates |
| [*OrgDb*](http://www.bioconductor.org/packages/release/BiocViews.html#___OrgDb) | GO-annotations |
| [*TxDb*](http://www.bioconductor.org/packages/release/BiocViews.html#___TxDb) | gene-coordinates |

The default annotation package used by `GOfuncR` is bioconductor’s *OrganismDb* package *[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)*, which contains GO-annotations as well as gene-coordinates.
There are currently also *OrganismDb* packages available for mouse (*[Mus.musculus](https://bioconductor.org/packages/3.22/Mus.musculus)*) and rat (*[Rattus.norvegicus](https://bioconductor.org/packages/3.22/Rattus.norvegicus)*).
After installation those packages can be used in `go_enrich`:

```
## perform enrichment analysis for mouse genes
## ('Mus.musculus' has to be installed)
mouse_gene_ids = c('Gck', 'Gys1', 'Hk2', 'Pygl', 'Slc2a8', 'Ugp2', 'Zwint',
    'Engase')
input_hyper_mouse = data.frame(mouse_gene_ids, is_candidate=1)
res_hyper_mouse = go_enrich(input_hyper_mouse, organismDb='Mus.musculus')
```

Besides *OrganismDb* packages also *OrgDb* packages can be used to get GO-annotations.
These packages have the advantage that they are available for a broader range of species (e.g. *[org.Pt.eg.db](https://bioconductor.org/packages/3.22/org.Pt.eg.db)* for chimp or *[org.Gg.eg.db](https://bioconductor.org/packages/3.22/org.Gg.eg.db)* for chicken).
*OrgDb* packages are specified by the `orgDb` parameter of `go_enrich`:

```
## perform enrichment analysis for chimp genes
## ('org.Pt.eg.db' has to be installed)
chimp_gene_ids = c('SIAH1', 'MIIP', 'ELP3', 'CFB', 'ADARB1', 'TRNT1',
    'DEFB124', 'OR1A1', 'TYR', 'HOXA7')
input_hyper_chimp = data.frame(chimp_gene_ids, is_candidate=1)
res_hyper_chimp = go_enrich(input_hyper_chimp, orgDb='org.Pt.eg.db')
```

When an *OrgDb* package is used for annotations and the `go_enrich` analysis relies on gene-coordinates (i.e. `gene_len=TRUE` or `regions=TRUE`), then an additional *TxDb* package has to be provided for the gene-coordinates:

```
## perform enrichment analysis for chimp genes
## and account for gene-length in FWER
## (needs 'org.Pt.eg.db' and 'TxDb.Ptroglodytes.UCSC.panTro4.refGene' installed)
res_hyper_chimp_genelen = go_enrich(input_hyper_chimp, gene_len=TRUE,
    orgDb='org.Pt.eg.db', txDb='TxDb.Ptroglodytes.UCSC.panTro4.refGene')
```

*OrgDb* + *TxDb* packages can also be useful even if there is an *OrganismDb* package available, for example to use a different reference genome. Here we use the *hg38* gene-coordinates from *[TxDb.Hsapiens.UCSC.hg38.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg38.knownGene)* instead of the default *hg19* from the *OrganismDb* package *[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)*.

```
## run GO-enrichment analysis for genes in the candidate region
## using hg38 gene-coordinates
## (needs 'org.Hs.eg.db' and 'TxDb.Hsapiens.UCSC.hg38.knownGene' installed)
res_region_hg38 = go_enrich(input_regions, regions=TRUE,
    orgDb='org.Hs.eg.db', txDb='TxDb.Hsapiens.UCSC.hg38.knownGene')
```

Note that using *TxDb* packages always requires defining an *OrgDb* package for the annotations.

## 3.2 Custom annotations

Besides using bioconductor’s annotation packages for the mapping of genes to GO-categories, it is also possible to provide the annotations directly as a dataframe with two columns: (1) genes and (2) GO-IDs (parameter `annotations`).

```
## example for a dataframe with custom annotations
head(custom_anno)
```

```
##     gene      go_id
## 1 ABCC10 GO:0006869
## 2 ABCC10 GO:0008559
## 3 ABCC10 GO:0009925
## 4 ABCC10 GO:0015431
## 5 ABCC10 GO:0015711
## 6 ABCC10 GO:0016020
```

```
## run enrichment analysis with custom annotations
res_hyper_anno = go_enrich(input_hyper, annotations=custom_anno)
```

## 3.3 Custom gene-coordinates

Gene-coordinates are used when the FWER is corrected for gene length (`gene_len=TRUE`) or for spatial clustering of genes (`regions=TRUE`).
Instead of using gene-coordinates from bioconductor packages, one can also provide custom gene-coordinates directly as a dataframe with four columns: gene, chromosome, start, end (parameter `gene_coords`).

```
## example for a dataframe with custom gene-coordinates
head(custom_coords)
```

```
##       gene   chr    start      end
## 1    NCAPG  chr4 17812436 17846487
## 2    APOL4 chr22 36585176 36600879
## 3     NGFR chr17 47572655 47592382
## 4    NXPH4 chr12 57610578 57620232
## 5 C21orf59 chr21 33954510 33984918
## 6   CACNG2 chr22 36956916 37098690
```

```
## use correction for gene-length based on custom gene-coordinates
res_hyper_cc = go_enrich(input_hyper, gene_len=TRUE, gene_coords=custom_coords)
```

Note that this allows to use `gene_len=TRUE` to correct the FWER for any user-defined gene ‘weight’, since the correction for gene length just weights each gene with its length (`end - start`).
A gene with a higher weight has a bigger chance of becoming a candidate gene in the randomsets.

## 3.4 Custom GO-graph

A default GO-graph (obtained from [geneontology](http://current.geneontology.org/ontology/), release date 01-May-2021), is integrated in the package.
However, also a custom GO-graph, e.g. a specific version or a different ontology can be provided. `go_enrich` needs a directory which contains three tab-separated files in the GO MySQL Database Schema:
*term.txt*, *term2term.txt* and *graph\_path.txt*.
The full path to this directory needs to be defined in the parameter `godir`.
Specific versions of the GO-graph can be downloaded from <http://archive.geneontology.org/lite/>.
For example, to use the GO-graph from 2018-11-24, download and unpack the files from
<http://archive.geneontology.org/lite/2018-11-24/go_weekly-termdb-tables.tar.gz>.
Assume the files were saved in `/home/user/go_graphs/2018-11-24/`. This directory now contains the needed files `term.txt`, `term2term.txt` and `graph_path.txt` and can be used in `go_enrich`:

```
## run enrichment with custom GO-graph
go_path = '/home/user/go_graphs/2018-11-24/'
res_hyper = go_enrich(input_hyper, godir=go_path)
```

### 3.4.1 Conversion from *.obo* format

At some point [Gene Ontology](http://geneontology.org/) may no longer provide the ontology in the GO MySQL Database Schema; and other ontologies may not be provided in that format at all.
Therefore, custom ontologies might need to be converted to the right format before using them in `GOfuncR`.
On <https://github.com/sgrote/OboToTerm> you can find a python script that converts the widely used `.obo` format to the tables needed (*term.txt*, *term2term.txt* and *graph\_path.txt*).

# 4 Additional functionalities

## 4.1 Plot distribution of gene-associated variables from an enrichment analysis

The function `plot_anno_scores` can be used to get a quick visual overview of the gene-associated variables in GO-categories, that were used in an enrichment analysis.
`plot_anno_scores` takes a result from `go_enrich` as input together with a vector of GO-IDs.
It then plots the combined scores of all input genes for the `go_enrich` analysis in each of the defined GO-categories.
The type of the plot depends on the test that was used in `go_enrich`.
Note that if custom `annotations` were used in `go_enrich`, then they also have to be provided to `plot_anno_scores` (whereas ontology and annotation databases are inferred from the input and loaded in `plot_anno_scores`).

For the **hypergeometric test** pie charts show the amounts of candidate and background genes that are annotated to the GO-categories and the root nodes (candidate genes in the colour of the corresponding root node).
The top panel shows the odds-ratio and 95%-CI from Fisher’s exact test (two-sided) comparing the GO-categories with their root nodes.

```
## hypergeometric test
top_gos_hyper = res_hyper[[1]][1:5, 'node_id']
# GO-categories with a high proportion of candidate genes
top_gos_hyper
```

```
## [1] "GO:0072025" "GO:0072221" "GO:0072235" "GO:0072205" "GO:0072017"
```

```
plot_anno_scores(res_hyper, top_gos_hyper)
```

![](data:image/png;base64...)

`plot_anno_scores` returns an invisible dataframe that contains the stats from Fisher’s exact test shown in the plot:

```
## hypergeometric test with defined background
top_gos_hyper_bg = res_hyper_bg[[1]][1:5, 'node_id']
top_gos_hyper_bg
```

```
## [1] "GO:0005634" "GO:0098984" "GO:0031981" "GO:0045202" "GO:0030054"
```

```
plot_stats = plot_anno_scores(res_hyper_bg, top_gos_hyper_bg)
```

![](data:image/png;base64...)

```
plot_stats
```

```
##        go_id candi_genes bg_genes    root_id root_candi_genes root_bg_genes odds_ratio  ci95_low ci95_high
## 1 GO:0005634           8        5 GO:0005575               12            19   5.255139 0.9221586  36.44260
## 2 GO:0098984           3        0 GO:0005575               12            19        Inf 0.7085715       Inf
## 3 GO:0031981           5        2 GO:0005575               12            19   5.684503 0.7220709  73.46909
## 4 GO:0045202           5        2 GO:0005575               12            19   5.684503 0.7220709  73.46909
## 5 GO:0030054           5        3 GO:0005575               12            19   3.632748 0.5345907  30.35710
##            p
## 1 0.05961029
## 2 0.04894327
## 3 0.07764297
## 4 0.07764297
## 5 0.20551268
```

Note that `go_enrich` reports the hypergeometric tests for over- and under-representation of candidate genes which correspond to the one-sided Fisher’s exact tests.
Also keep in mind that the p-values from this table are not corrected for multiple testing.

For the **Wilcoxon rank-sum test** violin plots show the distribution of the scores of genes that are annotated to each GO-category and the root nodes.
Horizontal lines in the left panel indicate the median of the scores that are annotated to the root nodes.
The Wilcoxon rank-sum test reported in the `go_enrich` result compares the scores annotated to a GO-category with the scores annotated to the corresponding root node.

```
## scores used for wilcoxon rank-sum test
top_gos_willi = res_willi[[1]][1:5, 'node_id']
# GO-categories with high scores
top_gos_willi
```

```
## [1] "GO:0000904" "GO:0030182" "GO:0031175" "GO:0048666" "GO:0048667"
```

```
plot_anno_scores(res_willi, top_gos_willi)
```

![](data:image/png;base64...)

For the **binomial test** pie charts show the amounts of *A* and *B* counts associated with each GO-category and root node, (*A* in the colour of the corresponding root node).
The top-panel shows point estimates and the 95%-CI of *p(A)* in the nodes, as well as horizontal lines that correspond to *p(A)* in the root nodes.
The p-value in the returned object is based on the null hypothesis that *p(A)* in a node equals *p(A)* in the corresponding root node.
Note that `go_enrich` reports that value for one-sided binomial tests.

```
## counts used for the binomial test
top_gos_binom = res_binom[[1]][1:5, 'node_id']
# GO-categories with high proportion of A
top_gos_binom
```

```
## [1] "GO:0005536" "GO:0030246" "GO:0048029" "GO:0000166" "GO:1901265"
```

```
plot_anno_scores(res_binom, top_gos_binom)
```

![](data:image/png;base64...)
Note that domain `biological_process` is missing in that plot because it was excluded from the GO-enrichment analysis in the first place (`res_binom` was created using the `domains` option of `go_enrich`).

For the **2x2 contingency table test** pie charts show the proportions of *A* and *B*, as well as *C* and *D* counts associated with a GO-category.
Root nodes are not shown, because this test is independent of the root category.
The top panel shows the odds ratio and 95%-CI from Fisher’s exact test (two-sided) comparing *A/B* and *C/D* inside one node.
Note that in `go_enrich`, if all four values are >=10, a chi-square test is performed instead of Fisher’s exact test.

```
## counts used for the 2x2 contingency table test
top_gos_conti = res_conti[[1]][1:5, 'node_id']
# GO-categories with high A/B compared to C/D
top_gos_conti
```

```
## [1] "GO:0003824" "GO:0005536" "GO:0030246" "GO:0048029" "GO:0016740"
```

```
plot_anno_scores(res_conti, top_gos_conti)
```

![](data:image/png;base64...)

## 4.2 Explore the GO-graph

The functions `get_parent_nodes` and `get_child_nodes` can be used to explore the ontology-graph.
They list all higher-level GO-categories and sub-GO-categories of input nodes, respectively, together with the distance between them:

```
## get the parent nodes (higher level GO-categories) of two GO-IDs
get_parent_nodes(c('GO:0051082', 'GO:0042254'))
```

```
##    child_go_id parent_go_id                                   parent_name distance
## 1   GO:0042254   GO:0042254                           ribosome biogenesis        0
## 2   GO:0042254   GO:0022613          ribonucleoprotein complex biogenesis        1
## 3   GO:0042254   GO:0044085                 cellular component biogenesis        2
## 4   GO:0042254   GO:0071840 cellular component organization or biogenesis        3
## 5   GO:0042254   GO:0009987                              cellular process        4
## 6   GO:0042254   GO:0008150                            biological_process        5
## 7   GO:0051082   GO:0051082                      unfolded protein binding        0
## 8   GO:0051082   GO:0005515                               protein binding        1
## 9   GO:0051082   GO:0005488                                       binding        2
## 10  GO:0051082   GO:0003674                            molecular_function        3
```

```
## get the child nodes (sub-categories) of two GO-IDs
get_child_nodes(c('GO:0090070', 'GO:0000112'))
```

```
##   parent_go_id child_go_id                                  child_name distance
## 1   GO:0000112  GO:0000112 nucleotide-excision repair factor 3 complex        0
## 2   GO:0000112  GO:0000440  core TFIIH complex portion of NEF3 complex        1
## 3   GO:0090070  GO:0090070  positive regulation of ribosome biogenesis        0
```

Note that a GO-category per definition is also its own parent and child with distance 0.

The function `get_names` can be used to retrieve the names and root nodes of GO-IDs:

```
## get the full names and domains of two GO-IDs
get_names(c('GO:0090070', 'GO:0000112'))
```

```
##        go_id                                     go_name          root_node
## 1 GO:0090070  positive regulation of ribosome biogenesis biological_process
## 2 GO:0000112 nucleotide-excision repair factor 3 complex cellular_component
```

It is also possible to go the other way round and search for GO-categories given part of their name using the function `get_ids`:

```
## get GO-IDs of categories that contain 'blood-brain barrier' in their names
bbb = get_ids('blood-brain barrier')
head(bbb)
```

```
##                                                     node_name          root_node      go_id
## 1            establishment of endothelial blood-brain barrier biological_process GO:0014045
## 2                          maintenance of blood-brain barrier biological_process GO:0035633
## 3                        establishment of blood-brain barrier biological_process GO:0060856
## 4                  establishment of glial blood-brain barrier biological_process GO:0060857
## 5          regulation of establishment of blood-brain barrier biological_process GO:0090210
## 6 positive regulation of establishment of blood-brain barrier biological_process GO:0090211
```

Note that this is just a `grep(..., ignore.case=TRUE)` on the node names of the ontology.
More sophisticated searches, e.g. with regular expressions, could be performed on the table returned by `get_ids('')` which lists all non-obsolete GO-categories.

Like for `go_enrich` also custom ontologies can be used (see the help pages of the functions).

## 4.3 Retrieve associations between genes and GO-categories

`GOfuncR` also offers the functions `get_anno_genes` and `get_anno_categories` to get annotated genes given input GO-categories, and annotated GO-categories given input genes, respectively.
`get_anno_genes` takes a vector of GO-IDs as input, and returns all genes that are annotated to those categories (using the default annotation package *[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)*).
The optional arguments `database` and `genes` can be used to define a [different annotation package](#other_db) and the set of genes which is searched for annotations, respectively.
This function implicitly includes annotations to child nodes.

```
## find all genes that are annotated to GO:0000109
## using default database 'Homo.sapiens'
head(get_anno_genes(go_ids='GO:0000109'))
```

```
##        go_id  gene
## 1 GO:0000109 CETN2
## 2 GO:0000109 ERCC1
## 3 GO:0000109 ERCC3
## 4 GO:0000109 ERCC4
## 5 GO:0000109 ERCC5
## 6 GO:0000109 ERCC8
```

```
## find out wich genes from a set of genes
## are annotated to some GO-categories
genes = c('AGTR1', 'ANO1', 'CALB1', 'GYG1', 'PAX2')
gos = c('GO:0001558', 'GO:0005536', 'GO:0072205', 'GO:0006821')
anno_genes = get_anno_genes(go_ids=gos, genes=genes)
# add the names and domains of the GO-categories
cbind(anno_genes, get_names(anno_genes$go_id)[,2:3])
```

```
##        go_id  gene                                 go_name          root_node
## 1 GO:0001558 AGTR1               regulation of cell growth biological_process
## 2 GO:0006821  ANO1                      chloride transport biological_process
## 3 GO:0072205 CALB1 metanephric collecting duct development biological_process
## 4 GO:0072205  PAX2 metanephric collecting duct development biological_process
```

```
## find all mouse-gene annotations to two GO-categories
## ('Mus.musculus' has to be installed)
gos = c('GO:0072205', 'GO:0000109')
get_anno_genes(go_ids=gos, database='Mus.musculus')
```

`get_anno_categories` on the other hand uses gene-symbols as input and returns associated GO-categories:

```
## get the GO-annotations for two random genes
anno = get_anno_categories(c('BTC', 'SPAG5'))
head(anno)
```

```
##   gene      go_id                                     name             domain
## 1  BTC GO:0005154 epidermal growth factor receptor binding molecular_function
## 2  BTC GO:0005515                          protein binding molecular_function
## 3  BTC GO:0005576                     extracellular region cellular_component
## 4  BTC GO:0005615                      extracellular space cellular_component
## 5  BTC GO:0005886                          plasma membrane cellular_component
## 6  BTC GO:0006915                        apoptotic process biological_process
```

```
## get the GO-annotations for two mouse genes
## ('Mus.musculus' has to be installed)
anno_mus = get_anno_categories(c('Mus81', 'Papola'), database='Mus.musculus')
```

This function only returns direct annotations.
To get also the parent nodes of the GO-categories a gene is annotated to, the function `get_parent_nodes` can be used:

```
# get all direct annotations of NXPH4
direct_anno = get_anno_categories('NXPH4')
direct_anno
```

```
##    gene      go_id                                         name             domain
## 1 NXPH4 GO:0005102                   signaling receptor binding molecular_function
## 2 NXPH4 GO:0005576                         extracellular region cellular_component
## 3 NXPH4 GO:0007218               neuropeptide signaling pathway biological_process
## 4 NXPH4 GO:0045202                                      synapse cellular_component
## 5 NXPH4 GO:0050804 modulation of chemical synaptic transmission biological_process
## 6 NXPH4 GO:0098982                           GABA-ergic synapse cellular_component
```

```
# get parent nodes of directly annotated GO-categories
parent_ids = unique(get_parent_nodes(direct_anno$go_id)[,2])
# add GO-domain
full_anno = get_names(parent_ids)
head(full_anno)
```

```
##        go_id                    go_name          root_node
## 1 GO:0005102 signaling receptor binding molecular_function
## 2 GO:0005515            protein binding molecular_function
## 3 GO:0005488                    binding molecular_function
## 4 GO:0003674         molecular_function molecular_function
## 5 GO:0005576       extracellular region cellular_component
## 6 GO:0110165 cellular anatomical entity cellular_component
```

Like for `go_enrich` also custom annotations and ontologies can be used (see the help pages of the functions).

## 4.4 Refine results from go\_enrich

When there are many significant GO-categories given a FWER-threshold, it may be useful to restrict the results to the most specific categories.
The `refine` function implements the *elim* algorithm from [4], which removes genes from significant child categories and repeats the test to check whether a category would still be significant.

```
## perform enrichment analysis for some genes
gene_ids = c('NCAPG', 'APOL4', 'NGFR', 'NXPH4', 'C21orf59', 'CACNG2', 'AGTR1',
    'ANO1', 'BTBD3', 'MTUS1', 'CALB1', 'GYG1', 'PAX2')
input_hyper = data.frame(gene_ids, is_candidate=1)
res_hyper = go_enrich(input_hyper, n_randset=100)

## perform refinement for categories with FWER < 0.1
refined = refine(res_hyper, fwer=0.1)
```

```
## the result shows p-values and significance before and after refinement
refined
```

```
##       node_id           ontology                                        node_name raw_p_underrep
## 1  GO:0072025 biological_process             distal convoluted tubule development      1.0000000
## 2  GO:0072221 biological_process metanephric distal convoluted tubule development      1.0000000
## 3  GO:0072235 biological_process            metanephric distal tubule development      1.0000000
## 4  GO:0072205 biological_process          metanephric collecting duct development      1.0000000
## 5  GO:0072017 biological_process                        distal tubule development      1.0000000
## 6  GO:0072044 biological_process                      collecting duct development      0.9999999
## 7  GO:0098686 cellular_component           hippocampal mossy fiber to CA3 synapse      0.9999975
## 8  GO:0072234 biological_process           metanephric nephron tubule development      0.9999997
## 9  GO:0072170 biological_process                   metanephric tubule development      0.9999996
## 10 GO:0072243 biological_process       metanephric nephron epithelium development      0.9999996
## 11 GO:0016048 biological_process                detection of temperature stimulus      0.9999994
## 12 GO:0072207 biological_process               metanephric epithelium development      0.9999994
## 13 GO:0003338 biological_process                        metanephros morphogenesis      0.9999992
##    raw_p_overrep FWER_underrep FWER_overrep refined_p_overrep signif
## 1   3.710011e-06             1         0.00      1.000000e+00  FALSE
## 2   3.710011e-06             1         0.00      3.710011e-06   TRUE
## 3   7.785513e-06             1         0.00      1.000000e+00  FALSE
## 4   1.666555e-05             1         0.01      1.666555e-05   TRUE
## 5   2.442552e-05             1         0.02      1.000000e+00  FALSE
## 6   3.881757e-05             1         0.03      1.000000e+00  FALSE
## 7   3.384721e-04             1         0.03      3.384721e-04   TRUE
## 8   8.518749e-05             1         0.06      1.000000e+00  FALSE
## 9   1.017105e-04             1         0.08      1.000000e+00  FALSE
## 10  1.105158e-04             1         0.08      1.000000e+00  FALSE
## 11  1.292120e-04             1         0.08      1.292120e-04   TRUE
## 12  1.391022e-04             1         0.09      1.000000e+00  FALSE
## 13  1.599648e-04             1         0.09      1.599648e-04   TRUE
```

By default `refine` performs the test for over-representation of candidate genes, see `?refine` for how to check for under-representation.

# 5 Schematics

## 5.1 Schematic 1: Hypergeometric test and FWER calculation

![](data:image/png;base64... "hypergeometric test and FWER")

FWER calculation

The FWER for the other tests is computed in the same way: the gene-associated variables (scores or counts) are permuted while the annotations of genes to GO-categories stay fixed.
Then the statistical tests are evaluated again for every GO-category.

## 5.2 Schematic 2: circ\_chrom option for genomic regions input

![](data:image/png;base64... "options for genomic regions input")

options for genomic regions input

To use genomic regions as input, the first column of the `genes` input dataframe has to be of the form `chr:start-stop` and `regions=TRUE` has to be set.
The option `circ_chrom` defines how candidate regions are randomly moved inside the background regions for computing the FWER.
When `circ_chrom=FALSE` (default), candidate regions can be moved to any background region on any chromosome, but are not allowed to overlap multiple background regions.
When `circ_chrom=TRUE`, candidate regions are only moved on the same chromosome and are allowed to overlap multiple background regions.
The chromosome is ‘circularized’ which means that a randomly placed candidate region may start at the end of the chromosome and continue at the beginning.

# 6 Session Info

```
sessionInfo()
```

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] Homo.sapiens_1.3.1                       TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [3] org.Hs.eg.db_3.22.0                      GO.db_3.22.0
##  [5] OrganismDbi_1.52.0                       GenomicFeatures_1.62.0
##  [7] GenomicRanges_1.62.0                     Seqinfo_1.0.0
##  [9] AnnotationDbi_1.72.0                     IRanges_2.44.0
## [11] S4Vectors_0.48.0                         Biobase_2.70.0
## [13] BiocGenerics_0.56.0                      generics_0.1.4
## [15] GOfuncR_1.30.0                           vioplot_0.5.1
## [17] zoo_1.8-14                               sm_2.2-6.0
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0 rjson_0.2.23
##  [4] xfun_0.53                   bslib_0.9.0                 lattice_0.22-7
##  [7] vctrs_0.6.5                 mapplots_1.5.3              tools_4.5.1
## [10] bitops_1.0-9                curl_7.0.0                  parallel_4.5.1
## [13] RSQLite_2.4.3               blob_1.2.4                  pkgconfig_2.0.3
## [16] Matrix_1.7-4                cigarillo_1.0.0             graph_1.88.0
## [19] lifecycle_1.0.4             compiler_4.5.1              Rsamtools_2.26.0
## [22] Biostrings_2.78.0           tinytex_0.57                codetools_0.2-20
## [25] htmltools_0.5.8.1           sass_0.4.10                 RCurl_1.98-1.17
## [28] yaml_2.3.10                 crayon_1.5.3                jquerylib_0.1.4
## [31] BiocParallel_1.44.0         DelayedArray_0.36.0         cachem_1.1.0
## [34] magick_2.9.0                abind_1.4-8                 gtools_3.9.5
## [37] digest_0.6.37               restfulr_0.0.16             bookdown_0.45
## [40] fastmap_1.2.0               grid_4.5.1                  SparseArray_1.10.0
## [43] cli_3.6.5                   magrittr_2.0.4              S4Arrays_1.10.0
## [46] RBGL_1.86.0                 XML_3.99-0.19               bit64_4.6.0-1
## [49] rmarkdown_2.30              XVector_0.50.0              httr_1.4.7
## [52] matrixStats_1.5.0           bit_4.6.0                   png_0.1-8
## [55] memoise_2.0.1               evaluate_1.0.5              knitr_1.50
## [58] BiocIO_1.20.0               rtracklayer_1.70.0          rlang_1.1.6
## [61] Rcpp_1.1.0                  DBI_1.2.3                   BiocManager_1.30.26
## [64] jsonlite_2.0.0              R6_2.6.1                    MatrixGenerics_1.22.0
## [67] GenomicAlignments_1.46.0
```

# 7 References

# Appendix

[1] Ashburner, M. et al. (2000). Gene Ontology: tool for the unification of biology. Nature Genetics 25: 25-29. [<https://doi.org/10.1038/75556>]

[2] Pruefer, K. et al. (2007). FUNC: A package for detecting significant associations between gene
sets and ontological annotations, BMC Bioinformatics 8: 41. [<https://doi.org/10.1186/1471-2105-8-41>]

[3] McDonald, J. H. Kreitman, M. (1991). Adaptive protein evolution at the Adh locus in Drosophila, Nature 351: 652-654. [<https://doi.org/10.1038/351652a0>]

[4] Alexa, A. et al. (2006). Improved scoring of functional groups from gene expression data by decorrelating GO graph structure. Bioinformatics 22, 1600–1607. [<https://doi.org/10.1093/bioinformatics/btl140>]