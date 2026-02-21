# The `mosdef` User’s Guide

Leon Dammer1\* and Federico Marini1,2\*\*

1Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI), Mainz
2Research Center for Immunotherapy (FZI), Mainz

\*dammerle@uni-mainz.de
\*\*marinif@uni-mainz.de

#### 30 October 2025

#### Package

mosdef 1.6.0

# 1 Introduction

This vignette describes how to use the *[mosdef](https://bioconductor.org/packages/3.22/mosdef)* package for performing tasks commonly associated to your Differential Expression workflows.

This includes functionality for

* plotting your expression values and differential expression results, both individually and as summary overviews (`gene_plot`, `de_volcano`, `go_volcano`, `plot_ma`, `get_expr_values`)
* running different methods for functional enrichment analysis, providing a unified API that simplifies the calls to the individual methods, ensuring the results are also provided in a standardized format (`run_cluPro`, `run_topGO`, `run_goseq`)
* decorating and improving your analysis reports (assuming these are generated as Rmarkdown documents).
  This can enhance the experience of browsing the results by automatical linking to external databases (ENSEMBL, GTEX, HPA, NCBI, … via `create_link_` functions, wrapped into a `buttonifier` to seamlessly multiply the information in a simple tabular representation).
  Additional info on frequently used features such as genes and Gene Ontology terms can also be embedded with `geneinfo_to_html` and `go_to_html`

The *[mosdef](https://bioconductor.org/packages/3.22/mosdef)* package as a whole aims to collect the MOSt frequently used DE-related Functions, and is open to further contributions from the community.

All in all, the objective for *[mosdef](https://bioconductor.org/packages/3.22/mosdef)* is to streamline the generation of comprehensive, information-rich analysis reports.

Historically, many of these functions (at least conceptually) have been developed in some of our other Bioconductor packages, such as *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)*, *[ideal](https://bioconductor.org/packages/3.22/ideal)* and *[GeneTonic](https://bioconductor.org/packages/3.22/GeneTonic)*.
*[mosdef](https://bioconductor.org/packages/3.22/mosdef)* is the attempt to achieve a better modularization for the most common tasks in the DE workflow.

## 1.1 Required input

In order to use *[mosdef](https://bioconductor.org/packages/3.22/mosdef)* in your workflow, two main inputs are required:

* `de_container`, a dataset containing the expression matrix. For example, a `DESeqDataSet` object in the *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* workflow
* `res_de`, a dataset, such as a `DESeqResults` storing the results of the differential expression analysis

Additionally, the `mapping` parameters, shared by a number of functions, refers to the annotation of your species provided by *[AnnotationDbi](https://bioconductor.org/packages/3.22/AnnotationDbi)*-like packages, which are commonplace in the Bioconductor environment.
For human, this would be *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)*, and for mouse *[org.Mm.eg.db](https://bioconductor.org/packages/3.22/org.Mm.eg.db)*.

Currently, *[mosdef](https://bioconductor.org/packages/3.22/mosdef)* is able to feed on the classes used throughout the *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* approach, but can easily be extended for the corresponding implementations in *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* and *[limma](https://bioconductor.org/packages/3.22/limma)*.

## 1.2 Demonstrating `mosdef` on the `macrophage data`

In the remainder of this vignette, we will illustrate the main features of *[mosdef](https://bioconductor.org/packages/3.22/mosdef)* on a publicly available dataset from Alasoo et al., “Shared genetic effects on chromatin and gene expression indicate a role for enhancer priming in immune response”, published in Nature Genetics, January 2018 (Alasoo et al. [2018](#ref-Alasoo2018))
[doi:10.1038/s41588-018-0046-7](https://doi.org/10.1038/s41588-018-0046-7).

The data is made available via the *[macrophage](https://bioconductor.org/packages/3.22/macrophage)* Bioconductor package, which contains the files output from the Salmon quantification (version 0.12.0, with Gencode v29 reference), as well as the values summarized at the gene level, which we will use to exemplify the analysis steps.

In the `macrophage` experimental setting, the samples are available from 6 different donors, in 4 different conditions (naive, treated with Interferon gamma, with SL1344, or with a combination of Interferon gamma and SL1344).
For simplicity, we will restrict our attention on the comparison between Interferon gamma treated samples vs naive samples.

# 2 Installation

To install *[mosdef](https://bioconductor.org/packages/3.22/mosdef)*, you can run the following commands:

```
if (!require("BiocManager")) {
  install.packages("BiocManager")
}
BiocManager::install("mosdef")
```

If you want to install the development version from GitHub, you can alternatively
run this command:

```
BiocManager::install("imbeimainz/mosdef")
```

# 3 Getting started

Once installed, the *[mosdef](https://bioconductor.org/packages/3.22/mosdef)* package can be loaded and attached to your current workspace as follows:

```
library("mosdef")
```

# 4 Load the data

We will use the well known `macrophage` data as an example.

If you are familiar with the DE workflow, you can skim over this section and read more on the functionality of *[mosdef](https://bioconductor.org/packages/3.22/mosdef)* in Section [5](#mosdefenrich).

```
suppressPackageStartupMessages({
  library("macrophage")
  library("DESeq2")
  library("org.Hs.eg.db")
})
data(gse, package = "macrophage")
dds_macrophage <- DESeqDataSet(gse, design = ~ line + condition)
#> using counts and average transcript lengths from tximeta
rownames(dds_macrophage) <- substr(rownames(dds_macrophage), 1, 15)
```

We perform some filtering on the features to be kept, and define the set of differentially expressed genes contrasting the `IFNg` and the `naive` samples.

Notably, we correctly specify the `lfcThreshold` parameter instead of a post-hoc approach to filter the DE table based on the log2 fold change values - see <https://support.bioconductor.org/p/101504/> for an excellent explanation on why to prefer the more rigorous (yet, likely conservative) method defined in the chunk below.

```
keep <- rowSums(counts(dds_macrophage) >= 10) >= 6
dds_macrophage <- dds_macrophage[keep, ]

dds_macrophage <- DESeq(dds_macrophage)
#> estimating size factors
#> using 'avgTxLength' from assays(dds), correcting for library size
#> estimating dispersions
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> final dispersion estimates
#> fitting model and testing
res_macrophage_IFNg_vs_naive <- results(dds_macrophage,
                                        contrast = c("condition", "IFNg", "naive"),
                                        lfcThreshold = 1,
                                        alpha = 0.05)
```

Please refer to the vignette of the *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* or *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* packages for more complex experimental designs and/or additional options in each workflow.

# 5 Generating enrichment results with a unified API

*[mosdef](https://bioconductor.org/packages/3.22/mosdef)* allows you to create your enrichment results right from your `DESeqDataset` and `DESeqResults` objects using 3 possible algorithms, widely used:

* *[topGO](https://bioconductor.org/packages/3.22/topGO)*
* *[goseq](https://bioconductor.org/packages/3.22/goseq)*
* *[clusterProfiler](https://bioconductor.org/packages/3.22/clusterProfiler)*

For more information on the differences between these algorithms we refer to their individual vignettes and publications.

All of these algorithms require an annotation to function properly, so make sure you have installed and use the correct one for your experimental data.
The default is `org.Mm.eg.db` (Mus musculus). The `macrophage` data however stems from human, so we need `org.Hs.eg.db`, and we load this package in the following chunk:

```
library("AnnotationDbi")
library("org.Hs.eg.db")
```

We also want to add a symbol column for later use - and, in order to add a human readable name for our features of interest:

```
res_macrophage_IFNg_vs_naive$symbol <-
  AnnotationDbi::mapIds(org.Hs.eg.db,
                        keys = row.names(res_macrophage_IFNg_vs_naive),
                        column = "SYMBOL",
                        keytype = "ENSEMBL",
                        multiVals = "first"
)
#> 'select()' returned 1:many mapping between keys and columns
```

We indeed recommend to use identifiers as row names that are machine-readable and stable over time, such as ENSEMBL or GENCODE.
To ensure that we are using objects that would work out-of-the-box into *[mosdef](https://bioconductor.org/packages/3.22/mosdef)*, we provide some utilities to check that in advance - this can relax the need of specifying a number of parameters in the other functions.

```
mosdef_de_container_check(dds_macrophage)
mosdef_res_check(res_macrophage_IFNg_vs_naive)
```

## 5.1 `mosdef` and `topGO`

*[topGO](https://bioconductor.org/packages/3.22/topGO)* is a widely used option to obtain a set of spot-on Gene Ontology terms, removing some of the more generic ones and therefore also reducing the redundancy which is inherent in the GO database (Ashburner et al. [2000](#ref-Ashburner2000)).

```
library("topGO")
#> Loading required package: graph
#> Loading required package: GO.db
#> Loading required package: SparseM
#>
#> groupGOTerms:    GOBPTerm, GOMFTerm, GOCCTerm environments built.
#>
#> Attaching package: 'topGO'
#> The following object is masked from 'package:IRanges':
#>
#>     members
res_enrich_macrophage_topGO <- run_topGO(
  de_container = dds_macrophage,
  res_de = res_macrophage_IFNg_vs_naive,
  ontology = "BP",
  mapping = "org.Hs.eg.db",
  FDR_threshold = 0.05,
  gene_id = "symbol",
  de_type = "up_and_down",
  add_gene_to_terms = TRUE,
  topGO_method2 = "elim",
  min_counts = 20,
  top_de = 700,
  verbose = TRUE
)
#> 'select()' returned 1:many mapping between keys and columns
#> 'select()' returned 1:many mapping between keys and columns
#> Your dataset has 1024 DE genes.
#> You selected 700 (68.36%) genes for the enrichment analysis.
#> You are analyzing up_and_down-regulated genes in the `res_de` container
#> Warning in run_topGO(de_container = dds_macrophage, res_de =
#> res_macrophage_IFNg_vs_naive, : NAs introduced by coercion
#> 6102 GO terms were analyzed. Not all of them are significantly enriched.
#> We suggest further subsetting the output list by for example:
#> using a pvalue cutoff in the column:
#> 'p.value_elim'.
```

The `run_topGO` function will return a table with the analysis for all possible GO terms (currently when using the “BP” ontology on the macrophage dataset that is 6102 terms).
Not all of these results are significant, and this list can (should) be further subset/filtered. For example by using a p-value cutoff.

The key parameters for `run_topGO()` are defined as follows:

* `de_container`: Your `DESeqDataset` object
* `res_de`: Your `DESeqResults` object
* `ontology`: Which gene ontology to analyse, default is “BP”
* `mapping`: The annotation/species
* `gene_id`: Which format the genes are provided. If you provide a `DESeqDataset` and `DESeqResults`, then *[mosdef](https://bioconductor.org/packages/3.22/mosdef)* does it for you and uses symbols. If you provide vectors please specify a value.
* `FDR_threshold`: The pvalue to use to count a gene as significant. The default is 0.05 but if you want a stricter analysis you could set this to 0.01 for example
* `de_type`: Which genes to analyse. The default is all (“up\_and\_down”)
  Other possibilities are only up-/down-regulated (“up”/“down”) genes.
* `add_gene_to_terms`: Logical, whether to add a column with all genes annotated to each GO term.
* `topGO_method2`: Character, specifying which of the methods implemented by `topGO` is to be used. The default is elim. For more info look at the documentation of *[topGO](https://bioconductor.org/packages/3.22/topGO)*.
* `min_counts`: Minimum number of counts a gene has to have to be considered for the background.
  The default is 0 and we advise this parameter is only used by expert users that understand the impact of selecting “non-standard” backgrounds.
* `top_de`: The number of genes to be considered in the enrich analysis.
  The default is all genes, this can be reduced to reduce redundancy.
  In this case, we take the top 700 highest DE genes based of padj score.
  If this number is bigger than the total amount of de genes the parameter defaults back to all genes.
* `verbose`: Whether or not to summarise the analysis in a message.

```
head(res_enrich_macrophage_topGO)
#>        GO.ID
#> 1 GO:0002250
#> 2 GO:0002503
#> 3 GO:0019886
#> 4 GO:0031640
#> 5 GO:0001916
#> 6 GO:0045087
#>                                                                                Term
#> 1                                                          adaptive immune response
#> 2                        peptide antigen assembly with MHC class II protein complex
#> 3 antigen processing and presentation of exogenous peptide antigen via MHC class II
#> 4                                              killing of cells of another organism
#> 5                               positive regulation of T cell mediated cytotoxicity
#> 6                                                            innate immune response
#>   Annotated Significant Expected Rank in p.value_classic p.value_elim
#> 1       390          89    16.30                       3      4.3e-22
#> 2        13          13     0.54                      31      1.0e-18
#> 3        27          15     1.13                      56      1.8e-14
#> 4        61          18     2.55                      95      2.7e-11
#> 5        31          13     1.30                     108      1.0e-10
#> 6       831         105    34.73                      16      3.2e-10
#>   p.value_classic
#> 1              NA
#> 2         1.0e-18
#> 3         1.9e-14
#> 4         2.8e-11
#> 5         1.1e-10
#> 6         1.5e-25
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            genes
#> 1                                                       ASCL2,B2M,BTN3A1,BTN3A2,BTN3A3,C1QB,C1RL,C1S,C2,C3,C4A,C4B,CD1A,CD274,CD28,CD40,CD7,CD74,CD80,CEACAM1,CLEC10A,CLEC6A,CR1L,CSF2RB,CTLA4,CTSS,CX3CR1,ERAP2,EXO1,FGL1,GPR183,HLA-A,HLA-B,HLA-C,HLA-DMA,HLA-DMB,HLA-DOA,HLA-DOB,HLA-DPA1,HLA-DPB1,HLA-DQA1,HLA-DQB1,HLA-DQB2,HLA-DRA,HLA-DRB1,HLA-DRB5,HLA-E,HLA-F,HLA-H,ICAM1,IL12RB1,IL12RB2,IL18BP,IL27,IL4I1,IRF1,IRF7,ITK,JAK2,JAK3,KLRK1,LAG3,LAMP3,LILRA1,LILRB3,MCOLN2,NOD2,P2RX7,PCYT1A,PDCD1,PDCD1LG2,RIPK2,RNF19B,RSAD2,SECTM1,SIT1,SLAMF1,SLAMF6,SLAMF7,SLC11A1,TAP1,TAP2,TBX21,TLR8,TNFRSF11A,TNFRSF21,TNFSF13B,TNFSF18,ZC3H12A
#> 2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     B2M,HLA-DMA,HLA-DMB,HLA-DOA,HLA-DOB,HLA-DPA1,HLA-DPB1,HLA-DQA1,HLA-DQB1,HLA-DQB2,HLA-DRA,HLA-DRB1,HLA-DRB5
#> 3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           B2M,CD74,CTSS,HLA-DMA,HLA-DMB,HLA-DOA,HLA-DOB,HLA-DPA1,HLA-DPB1,HLA-DQA1,HLA-DQB1,HLA-DQB2,HLA-DRA,HLA-DRB1,HLA-DRB5
#> 4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      APOL1,C1S,C2,C3,C4A,CCL13,CCL8,CFB,CXCL10,CXCL11,CXCL9,GBP1,GBP2,GBP3,GBP5,GBP7,NCF1,PIM1
#> 5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               B2M,CD1A,HLA-A,HLA-B,HLA-C,HLA-DRA,HLA-DRB1,HLA-E,HLA-F,HLA-H,IL12RB1,P2RX7,TAP2
#> 6 ACOD1,ADAM8,AIM2,APOBEC3A,APOBEC3D,APOBEC3G,APOL1,B2M,C1QB,C1RL,C1S,C2,C3,C4A,C4B,CALCOCO2,CALHM6,CASP4,CD274,CD300H,CD300LF,CD40,CD74,CEACAM1,CFB,CFH,CIITA,CLEC10A,CLEC6A,COLEC12,CTSS,CX3CR1,CXCL10,CYLD,DTX3L,EDN1,GBP1,GBP2,GBP3,GBP4,GBP5,GBP6,GBP7,GCH1,GSDMD,H2BC21,HLA-A,HLA-B,HLA-C,HLA-DPA1,HLA-E,HLA-F,IFI27,IFI35,IFIH1,IFIT2,IFIT3,IFITM1,IFITM2,IL12RB1,IL27,IRF1,IRF7,ISG20,JAK2,JAK3,KLRK1,LAG3,LILRA2,MCOLN2,MEFV,MSRB1,NCF1,NLRC5,NMI,NOD2,NUB1,OPTN,P2RX7,PIM1,PML,RAB20,RALB,RIPK2,RNF19B,RSAD2,SCIMP,SERPING1,SLAMF1,SLAMF6,SLAMF7,SLC11A1,STAT1,STAT2,TIFA,TLR10,TLR8,TRAFD1,TRIM17,TRIM22,TRIM69,UBD,UBE2L6,ZBP1,ZNFX1
```

This will return a table with 9 columns. They contain:

* `GO.ID`: The computer readable GO term ID.
* `Term`: The human readable GO term name.
* `Annotated`: The overall number of detected genes associated with this term (as defined in the `de_container` or in the `bg_genes` parameters).
* `Significant`: The number of DE genes associated with this term (as defined in the `res_de` or in the `de_genes` parameters)
* `Expected`: The expected number of genes associated with this term.
* `Rank in p.value_classic`: specifies the rank of each term, if using the ascending order of `p.value_classic` to sort the entries.
* `p.value_elim`: p-value for the enrichment test of each term (recommended for sorting the table), based on the `elim` algorithm in `topGO`.
* `p.value_classic`: p-value for the enrichment, using the “classical” Fisher test.
* `genes`: Specifies which DE genes are associated with that term (separated by a comma). This column will later on be used to label the genes in the `go_volcano()` function (see below in Section [6.2](#volcanoplots))

## 5.2 `mosdef` and `goseq`

The method implemented in the *[goseq](https://bioconductor.org/packages/3.22/goseq)* package is able to handle the selection bias inherent in assays such as RNA-seq, whereas highly expressed genes have a higher probability of being detected as differentially expressed.

Parameters like `top_de`, `min_counts`, `verbose`, `FDR_threshold` and `de_type` can also be used here (for more detail on these parameters see above), as they are a part of the shared API with `run_topGO` and `run_cluPro`.

Importantly, the feature length retrieval is based on the `goseq()` function, and this requires that the corresponding TxDb packages are installed and available. So make sure one is installed on your machine. For human samples, the recommended one is *[TxDb.Hsapiens.UCSC.hg38.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg38.knownGene)*.

```
goseq_macrophage <- run_goseq(
  de_container = dds_macrophage,
  res_de = res_macrophage_IFNg_vs_naive,
  mapping = "org.Hs.eg.db",
  testCats = "GO:BP" # which categories to test of ("GO:BP, "GO:MF", "GO:CC")
)
#> Your dataset has 1024 DE genes.
#> You selected 1024 (100.00%) genes for the enrichment analysis.
#> You are analyzing up_and_down-regulated genes in the `res_de` container
#> Can't find hg38/ensGene length data in genLenDataBase...
#> Warning in grep(txdbPattern, installedPackages): argument 'pattern' has length
#> > 1 and only the first element will be used
#> Found the annotation package, TxDb.Hsapiens.UCSC.hg38.knownGene
#> Trying to get the gene lengths from it.
#> Loading required package: GenomicFeatures
#>
#> Attaching package: 'GenomicFeatures'
#> The following object is masked from 'package:topGO':
#>
#>     genes
#> Warning in pcls(G): initial point very close to some inequality constraints
#> Fetching GO annotations...
#> For 3708 genes, we could not find any categories. These genes will be excluded.
#> To force their use, please run with use_genes_without_cat=TRUE (see documentation).
#> This was the default behavior for version 1.15.1 and earlier.
#> Calculating the p-values...
#> 'select()' returned 1:1 mapping between keys and columns
#> 'select()' returned 1:many mapping between keys and columns
head(goseq_macrophage)
#>        category over_represented_pvalue under_represented_pvalue numDEInCat
#> 1741 GO:0006955            5.719860e-54                        1        243
#> 606  GO:0002376            9.613425e-49                        1        295
#> 518  GO:0002250            2.631944e-40                        1        104
#> 2355 GO:0009607            5.294480e-38                        1        199
#> 8066 GO:0051707            1.162022e-37                        1        195
#> 6167 GO:0043207            1.311644e-37                        1        195
#>      numInCat                                 term ontology        p.adj
#> 1741     1475                      immune response       BP 8.207426e-50
#> 606      2162                immune system process       BP 6.897152e-45
#> 518       391             adaptive immune response       BP 1.258859e-36
#> 2355     1306          response to biotic stimulus       BP 1.899262e-34
#> 8066     1270           response to other organism       BP 3.136798e-34
#> 6167     1271 response to external biotic stimulus       BP 3.136798e-34
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                genes
#> 1741                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ENSG00000125347,ENSG00000162645,ENSG00000145365,ENSG00000137496,ENSG00000154451,ENSG00000231389,ENSG00000204257,ENSG00000100342,ENSG00000162654,ENSG00000164509,ENSG00000204267,ENSG00000131203,ENSG00000213886,ENSG00000168394,ENSG00000242574,ENSG00000163568,ENSG00000183734,ENSG00000101017,ENSG00000117228,ENSG00000244731,ENSG00000019582,ENSG00000204252,ENSG00000089041,ENSG00000179583,ENSG00000136436,ENSG00000188820,ENSG00000120217,ENSG00000204287,ENSG00000131979,ENSG00000096996,ENSG00000113263,ENSG00000169248,ENSG00000117226,ENSG00000026751,ENSG00000224389,ENSG00000004468,ENSG00000197646,ENSG00000164136,ENSG00000149131,ENSG00000008517,ENSG00000089692,ENSG00000184588,ENSG00000078081,ENSG00000223865,ENSG00000073861,ENSG00000164308,ENSG00000173369,ENSG00000169245,ENSG00000196126,ENSG00000167207,ENSG00000204642,ENSG00000079385,ENSG00000123146,ENSG00000179344,ENSG00000181374,ENSG00000186470,ENSG00000198502,ENSG00000234745,ENSG00000000971,ENSG00000152207,ENSG00000213809,ENSG00000140853,ENSG00000121858,ENSG00000243649,ENSG00000026950,ENSG00000206341,ENSG00000204592,ENSG00000102794,ENSG00000141574,ENSG00000153064,ENSG00000138755,ENSG00000172183,ENSG00000141655,ENSG00000206503,ENSG00000123609,ENSG00000123240,ENSG00000115415,ENSG00000213512,ENSG00000163599,ENSG00000162931,ENSG00000204525,ENSG00000198736,ENSG00000096968,ENSG00000198829,ENSG00000168329,ENSG00000205220,ENSG00000127951,ENSG00000013374,ENSG00000151651,ENSG00000137193,ENSG00000135148,ENSG00000232629,ENSG00000158270,ENSG00000197721,ENSG00000165949,ENSG00000173762,ENSG00000104312,ENSG00000101916,ENSG00000156587,ENSG00000111801,ENSG00000104951,ENSG00000166278,ENSG00000102524,ENSG00000018280,ENSG00000170581,ENSG00000108688,ENSG00000169508,ENSG00000197272,ENSG00000026103,ENSG00000068079,ENSG00000140749,ENSG00000178562,ENSG00000153898,ENSG00000241106,ENSG00000196735,ENSG00000185201,ENSG00000090339,ENSG00000284690,ENSG00000205846,ENSG00000275718,ENSG00000243811,ENSG00000124256,ENSG00000204577,ENSG00000184678,ENSG00000185885,ENSG00000120337,ENSG00000121594,ENSG00000104518,ENSG00000188389,ENSG00000132274,ENSG00000140464,ENSG00000100368,ENSG00000146072,ENSG00000116514,ENSG00000166710,ENSG00000108700,ENSG00000128383,ENSG00000125730,ENSG00000162739,ENSG00000239713,ENSG00000132514,ENSG00000186074,ENSG00000103313,ENSG00000161929,ENSG00000189171,ENSG00000119917,ENSG00000174123,ENSG00000163874,ENSG00000121797,ENSG00000163131,ENSG00000105639,ENSG00000083799,ENSG00000104894,ENSG00000104760,ENSG00000203805,ENSG00000119922,ENSG00000196954,ENSG00000035720,ENSG00000158477,ENSG00000124201,ENSG00000139832,ENSG00000174371,ENSG00000185507,ENSG00000185880,ENSG00000081985,ENSG00000134321,ENSG00000104974,ENSG00000120436,ENSG00000137959,ENSG00000136960,ENSG00000173198,ENSG00000144118,ENSG00000124508,ENSG00000182326,ENSG00000078401,ENSG00000139178,ENSG00000115267,ENSG00000100226,ENSG00000137078,ENSG00000117090,ENSG00000158517,ENSG00000163840,ENSG00000183347,ENSG00000113749,ENSG00000239998,ENSG00000186810,ENSG00000136689,ENSG00000161217,ENSG00000064932,ENSG00000054219,ENSG00000204616,ENSG00000137628,ENSG00000135636,ENSG00000159403,ENSG00000142089,ENSG00000110848,ENSG00000065427,ENSG00000075240,ENSG00000204632,ENSG00000082074,ENSG00000158714,ENSG00000158481,ENSG00000158813,ENSG00000187554,ENSG00000171522,ENSG00000237541,ENSG00000099985,ENSG00000104856,ENSG00000113916,ENSG00000275385,ENSG00000189067,ENSG00000178999,ENSG00000271503,ENSG00000254087,ENSG00000106952,ENSG00000168811,ENSG00000111335,ENSG00000163735,ENSG00000255833,ENSG00000163564,ENSG00000152778,ENSG00000164300,ENSG00000136044,ENSG00000173193,ENSG00000198719,ENSG00000196664,ENSG00000085265,ENSG00000243414,ENSG00000076248,ENSG00000184371,ENSG00000226979,ENSG00000119508,ENSG00000157873,ENSG00000136560,ENSG00000041880,ENSG00000111331,ENSG00000138496,ENSG00000104432,ENSG00000135047,ENSG00000092445,ENSG00000188313,ENSG00000112149,ENSG00000137265
#> 606  ENSG00000125347,ENSG00000162645,ENSG00000145365,ENSG00000137496,ENSG00000154451,ENSG00000231389,ENSG00000204257,ENSG00000100342,ENSG00000162654,ENSG00000134470,ENSG00000164509,ENSG00000204267,ENSG00000131203,ENSG00000213886,ENSG00000168394,ENSG00000242574,ENSG00000163568,ENSG00000183734,ENSG00000101017,ENSG00000117228,ENSG00000244731,ENSG00000019582,ENSG00000204252,ENSG00000089041,ENSG00000179583,ENSG00000136436,ENSG00000170989,ENSG00000185338,ENSG00000188820,ENSG00000120217,ENSG00000188906,ENSG00000204287,ENSG00000131979,ENSG00000096996,ENSG00000113263,ENSG00000169248,ENSG00000117226,ENSG00000026751,ENSG00000240065,ENSG00000224389,ENSG00000004468,ENSG00000197646,ENSG00000164136,ENSG00000149131,ENSG00000008517,ENSG00000089692,ENSG00000184588,ENSG00000078081,ENSG00000223865,ENSG00000073861,ENSG00000164308,ENSG00000173369,ENSG00000169245,ENSG00000196126,ENSG00000167207,ENSG00000110852,ENSG00000204642,ENSG00000079385,ENSG00000123146,ENSG00000179344,ENSG00000181374,ENSG00000186470,ENSG00000198502,ENSG00000234745,ENSG00000000971,ENSG00000152207,ENSG00000188404,ENSG00000213809,ENSG00000140853,ENSG00000121858,ENSG00000092010,ENSG00000243649,ENSG00000026950,ENSG00000206341,ENSG00000204592,ENSG00000102794,ENSG00000141574,ENSG00000168062,ENSG00000153064,ENSG00000138755,ENSG00000172183,ENSG00000141655,ENSG00000206503,ENSG00000123609,ENSG00000188676,ENSG00000117115,ENSG00000123240,ENSG00000115415,ENSG00000213512,ENSG00000163599,ENSG00000162931,ENSG00000204525,ENSG00000182782,ENSG00000198736,ENSG00000096968,ENSG00000198829,ENSG00000168329,ENSG00000205220,ENSG00000127951,ENSG00000013374,ENSG00000002933,ENSG00000151651,ENSG00000137193,ENSG00000135148,ENSG00000135424,ENSG00000232629,ENSG00000158270,ENSG00000197721,ENSG00000106565,ENSG00000165949,ENSG00000173762,ENSG00000088992,ENSG00000104312,ENSG00000101916,ENSG00000156587,ENSG00000111801,ENSG00000104951,ENSG00000123685,ENSG00000166278,ENSG00000102524,ENSG00000018280,ENSG00000170581,ENSG00000182580,ENSG00000108688,ENSG00000169508,ENSG00000231925,ENSG00000197272,ENSG00000026103,ENSG00000204264,ENSG00000068079,ENSG00000140749,ENSG00000178562,ENSG00000153898,ENSG00000241106,ENSG00000196735,ENSG00000162692,ENSG00000185201,ENSG00000090339,ENSG00000049130,ENSG00000099377,ENSG00000284690,ENSG00000153094,ENSG00000205846,ENSG00000275718,ENSG00000243811,ENSG00000124256,ENSG00000204577,ENSG00000184678,ENSG00000185885,ENSG00000090554,ENSG00000120337,ENSG00000121594,ENSG00000104518,ENSG00000188389,ENSG00000162367,ENSG00000116016,ENSG00000064201,ENSG00000132274,ENSG00000140464,ENSG00000100368,ENSG00000146072,ENSG00000116514,ENSG00000173821,ENSG00000166710,ENSG00000108700,ENSG00000128383,ENSG00000125730,ENSG00000162739,ENSG00000239713,ENSG00000132514,ENSG00000186074,ENSG00000103313,ENSG00000161929,ENSG00000189171,ENSG00000119917,ENSG00000174123,ENSG00000163874,ENSG00000121797,ENSG00000163131,ENSG00000105639,ENSG00000083799,ENSG00000104894,ENSG00000104760,ENSG00000135124,ENSG00000133800,ENSG00000203805,ENSG00000119922,ENSG00000196954,ENSG00000023330,ENSG00000035720,ENSG00000158477,ENSG00000124201,ENSG00000139832,ENSG00000174371,ENSG00000006747,ENSG00000185507,ENSG00000119969,ENSG00000185880,ENSG00000081985,ENSG00000134321,ENSG00000125810,ENSG00000162337,ENSG00000104974,ENSG00000120436,ENSG00000137959,ENSG00000136960,ENSG00000173198,ENSG00000144118,ENSG00000170271,ENSG00000124508,ENSG00000182326,ENSG00000078401,ENSG00000139178,ENSG00000150630,ENSG00000115267,ENSG00000100226,ENSG00000137078,ENSG00000117090,ENSG00000158517,ENSG00000163840,ENSG00000183347,ENSG00000141682,ENSG00000113749,ENSG00000239998,ENSG00000186810,ENSG00000134256,ENSG00000136689,ENSG00000161217,ENSG00000139192,ENSG00000064932,ENSG00000054219,ENSG00000204616,ENSG00000137628,ENSG00000135636,ENSG00000159403,ENSG00000154639,ENSG00000142089,ENSG00000110848,ENSG00000065427,ENSG00000075240,ENSG00000204632,ENSG00000100628,ENSG00000082074,ENSG00000158714,ENSG00000070501,ENSG00000158481,ENSG00000158813,ENSG00000187554,ENSG00000146918,ENSG00000171522,ENSG00000237541,ENSG00000099985,ENSG00000104856,ENSG00000113916,ENSG00000275385,ENSG00000189067,ENSG00000178999,ENSG00000271503,ENSG00000254087,ENSG00000106952,ENSG00000168811,ENSG00000196684,ENSG00000111335,ENSG00000163735,ENSG00000255833,ENSG00000163564,ENSG00000152778,ENSG00000135821,ENSG00000164300,ENSG00000123610,ENSG00000136044,ENSG00000173193,ENSG00000198719,ENSG00000196664,ENSG00000085265,ENSG00000142405,ENSG00000243414,ENSG00000076248,ENSG00000184371,ENSG00000226979,ENSG00000113249,ENSG00000119508,ENSG00000157873,ENSG00000136560,ENSG00000041880,ENSG00000111331,ENSG00000138496,ENSG00000153208,ENSG00000104432,ENSG00000135047,ENSG00000129422,ENSG00000092445,ENSG00000188313,ENSG00000112149,ENSG00000137265
#> 518                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ENSG00000125347,ENSG00000137496,ENSG00000231389,ENSG00000204257,ENSG00000204267,ENSG00000168394,ENSG00000242574,ENSG00000183734,ENSG00000101017,ENSG00000244731,ENSG00000019582,ENSG00000204252,ENSG00000089041,ENSG00000120217,ENSG00000204287,ENSG00000096996,ENSG00000113263,ENSG00000026751,ENSG00000224389,ENSG00000197646,ENSG00000089692,ENSG00000078081,ENSG00000223865,ENSG00000073861,ENSG00000164308,ENSG00000173369,ENSG00000196126,ENSG00000167207,ENSG00000204642,ENSG00000079385,ENSG00000179344,ENSG00000186470,ENSG00000198502,ENSG00000234745,ENSG00000213809,ENSG00000026950,ENSG00000206341,ENSG00000204592,ENSG00000141574,ENSG00000141655,ENSG00000206503,ENSG00000163599,ENSG00000204525,ENSG00000096968,ENSG00000168329,ENSG00000232629,ENSG00000197721,ENSG00000173762,ENSG00000104312,ENSG00000101916,ENSG00000111801,ENSG00000104951,ENSG00000166278,ENSG00000102524,ENSG00000018280,ENSG00000169508,ENSG00000197272,ENSG00000178562,ENSG00000153898,ENSG00000241106,ENSG00000196735,ENSG00000090339,ENSG00000205846,ENSG00000204577,ENSG00000120337,ENSG00000121594,ENSG00000188389,ENSG00000100368,ENSG00000146072,ENSG00000116514,ENSG00000166710,ENSG00000125730,ENSG00000162739,ENSG00000132514,ENSG00000163874,ENSG00000163131,ENSG00000105639,ENSG00000104760,ENSG00000158477,ENSG00000174371,ENSG00000185507,ENSG00000081985,ENSG00000134321,ENSG00000104974,ENSG00000182326,ENSG00000139178,ENSG00000137078,ENSG00000117090,ENSG00000161217,ENSG00000159403,ENSG00000110848,ENSG00000204632,ENSG00000158481,ENSG00000237541,ENSG00000104856,ENSG00000113916,ENSG00000254087,ENSG00000168811,ENSG00000076248,ENSG00000226979,ENSG00000157873,ENSG00000041880,ENSG00000135047,ENSG00000137265
#> 2355                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ENSG00000125347,ENSG00000162645,ENSG00000145365,ENSG00000137496,ENSG00000154451,ENSG00000231389,ENSG00000100342,ENSG00000162654,ENSG00000164509,ENSG00000204267,ENSG00000131203,ENSG00000213886,ENSG00000163568,ENSG00000101017,ENSG00000117228,ENSG00000244731,ENSG00000019582,ENSG00000089041,ENSG00000179583,ENSG00000136436,ENSG00000188820,ENSG00000120217,ENSG00000131979,ENSG00000096996,ENSG00000169248,ENSG00000117226,ENSG00000026751,ENSG00000224389,ENSG00000197646,ENSG00000164136,ENSG00000149131,ENSG00000186439,ENSG00000089692,ENSG00000184588,ENSG00000073861,ENSG00000173369,ENSG00000169245,ENSG00000196126,ENSG00000167207,ENSG00000204642,ENSG00000079385,ENSG00000181374,ENSG00000234745,ENSG00000000971,ENSG00000213809,ENSG00000140853,ENSG00000243649,ENSG00000204592,ENSG00000102794,ENSG00000168062,ENSG00000153064,ENSG00000138755,ENSG00000172183,ENSG00000141655,ENSG00000206503,ENSG00000123609,ENSG00000123240,ENSG00000115415,ENSG00000213512,ENSG00000162931,ENSG00000204525,ENSG00000198736,ENSG00000096968,ENSG00000168329,ENSG00000127951,ENSG00000013374,ENSG00000151651,ENSG00000137193,ENSG00000135148,ENSG00000178726,ENSG00000158270,ENSG00000165949,ENSG00000104312,ENSG00000176485,ENSG00000101916,ENSG00000156587,ENSG00000104951,ENSG00000123685,ENSG00000166278,ENSG00000018280,ENSG00000170581,ENSG00000108688,ENSG00000197272,ENSG00000101412,ENSG00000068079,ENSG00000153898,ENSG00000162692,ENSG00000140465,ENSG00000185201,ENSG00000284690,ENSG00000136514,ENSG00000136826,ENSG00000205846,ENSG00000275718,ENSG00000243811,ENSG00000124256,ENSG00000184678,ENSG00000185885,ENSG00000121594,ENSG00000104518,ENSG00000188389,ENSG00000064201,ENSG00000132274,ENSG00000140464,ENSG00000108950,ENSG00000100368,ENSG00000116514,ENSG00000173821,ENSG00000166710,ENSG00000108700,ENSG00000128383,ENSG00000125730,ENSG00000162739,ENSG00000239713,ENSG00000132514,ENSG00000186074,ENSG00000103313,ENSG00000161929,ENSG00000119917,ENSG00000174123,ENSG00000163874,ENSG00000085563,ENSG00000163131,ENSG00000167914,ENSG00000105639,ENSG00000083799,ENSG00000104894,ENSG00000119922,ENSG00000196954,ENSG00000035720,ENSG00000124201,ENSG00000139832,ENSG00000185507,ENSG00000204397,ENSG00000185880,ENSG00000165806,ENSG00000081985,ENSG00000134321,ENSG00000120436,ENSG00000100985,ENSG00000137959,ENSG00000144118,ENSG00000182326,ENSG00000078401,ENSG00000139178,ENSG00000115267,ENSG00000166920,ENSG00000117090,ENSG00000158517,ENSG00000163840,ENSG00000183347,ENSG00000141682,ENSG00000239998,ENSG00000064932,ENSG00000204616,ENSG00000137628,ENSG00000159403,ENSG00000154639,ENSG00000142089,ENSG00000167992,ENSG00000075240,ENSG00000204632,ENSG00000158714,ENSG00000125355,ENSG00000187554,ENSG00000104856,ENSG00000175175,ENSG00000275385,ENSG00000134326,ENSG00000189067,ENSG00000178999,ENSG00000271503,ENSG00000254087,ENSG00000106952,ENSG00000168811,ENSG00000111335,ENSG00000163735,ENSG00000255833,ENSG00000163564,ENSG00000152778,ENSG00000117632,ENSG00000164300,ENSG00000136044,ENSG00000173193,ENSG00000196664,ENSG00000085265,ENSG00000243414,ENSG00000184371,ENSG00000226979,ENSG00000175445,ENSG00000154920,ENSG00000157873,ENSG00000136560,ENSG00000111331,ENSG00000114698,ENSG00000138496,ENSG00000092445,ENSG00000188313,ENSG00000137265
#> 8066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ENSG00000125347,ENSG00000162645,ENSG00000145365,ENSG00000137496,ENSG00000154451,ENSG00000231389,ENSG00000100342,ENSG00000162654,ENSG00000164509,ENSG00000204267,ENSG00000131203,ENSG00000213886,ENSG00000163568,ENSG00000101017,ENSG00000117228,ENSG00000244731,ENSG00000019582,ENSG00000089041,ENSG00000179583,ENSG00000136436,ENSG00000188820,ENSG00000120217,ENSG00000131979,ENSG00000096996,ENSG00000169248,ENSG00000117226,ENSG00000026751,ENSG00000224389,ENSG00000197646,ENSG00000164136,ENSG00000149131,ENSG00000186439,ENSG00000089692,ENSG00000184588,ENSG00000073861,ENSG00000173369,ENSG00000169245,ENSG00000196126,ENSG00000167207,ENSG00000204642,ENSG00000079385,ENSG00000181374,ENSG00000234745,ENSG00000000971,ENSG00000213809,ENSG00000140853,ENSG00000243649,ENSG00000204592,ENSG00000102794,ENSG00000168062,ENSG00000153064,ENSG00000138755,ENSG00000172183,ENSG00000141655,ENSG00000206503,ENSG00000123609,ENSG00000123240,ENSG00000115415,ENSG00000213512,ENSG00000162931,ENSG00000204525,ENSG00000198736,ENSG00000096968,ENSG00000168329,ENSG00000127951,ENSG00000013374,ENSG00000151651,ENSG00000137193,ENSG00000135148,ENSG00000178726,ENSG00000158270,ENSG00000165949,ENSG00000104312,ENSG00000176485,ENSG00000101916,ENSG00000156587,ENSG00000123685,ENSG00000166278,ENSG00000018280,ENSG00000170581,ENSG00000108688,ENSG00000197272,ENSG00000101412,ENSG00000068079,ENSG00000153898,ENSG00000162692,ENSG00000140465,ENSG00000185201,ENSG00000284690,ENSG00000136514,ENSG00000205846,ENSG00000275718,ENSG00000243811,ENSG00000124256,ENSG00000184678,ENSG00000185885,ENSG00000121594,ENSG00000104518,ENSG00000064201,ENSG00000132274,ENSG00000140464,ENSG00000108950,ENSG00000100368,ENSG00000116514,ENSG00000173821,ENSG00000166710,ENSG00000108700,ENSG00000128383,ENSG00000125730,ENSG00000162739,ENSG00000239713,ENSG00000132514,ENSG00000186074,ENSG00000103313,ENSG00000161929,ENSG00000119917,ENSG00000174123,ENSG00000163874,ENSG00000085563,ENSG00000163131,ENSG00000167914,ENSG00000105639,ENSG00000083799,ENSG00000104894,ENSG00000119922,ENSG00000196954,ENSG00000035720,ENSG00000124201,ENSG00000139832,ENSG00000185507,ENSG00000204397,ENSG00000185880,ENSG00000165806,ENSG00000081985,ENSG00000134321,ENSG00000120436,ENSG00000100985,ENSG00000137959,ENSG00000144118,ENSG00000182326,ENSG00000078401,ENSG00000139178,ENSG00000115267,ENSG00000166920,ENSG00000117090,ENSG00000158517,ENSG00000163840,ENSG00000183347,ENSG00000141682,ENSG00000239998,ENSG00000064932,ENSG00000204616,ENSG00000137628,ENSG00000159403,ENSG00000154639,ENSG00000142089,ENSG00000167992,ENSG00000075240,ENSG00000204632,ENSG00000158714,ENSG00000125355,ENSG00000187554,ENSG00000104856,ENSG00000175175,ENSG00000275385,ENSG00000134326,ENSG00000189067,ENSG00000178999,ENSG00000271503,ENSG00000254087,ENSG00000106952,ENSG00000168811,ENSG00000111335,ENSG00000163735,ENSG00000255833,ENSG00000163564,ENSG00000152778,ENSG00000117632,ENSG00000164300,ENSG00000136044,ENSG00000173193,ENSG00000196664,ENSG00000085265,ENSG00000243414,ENSG00000184371,ENSG00000226979,ENSG00000175445,ENSG00000157873,ENSG00000136560,ENSG00000111331,ENSG00000114698,ENSG00000138496,ENSG00000092445,ENSG00000188313,ENSG00000137265
#> 6167                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ENSG00000125347,ENSG00000162645,ENSG00000145365,ENSG00000137496,ENSG00000154451,ENSG00000231389,ENSG00000100342,ENSG00000162654,ENSG00000164509,ENSG00000204267,ENSG00000131203,ENSG00000213886,ENSG00000163568,ENSG00000101017,ENSG00000117228,ENSG00000244731,ENSG00000019582,ENSG00000089041,ENSG00000179583,ENSG00000136436,ENSG00000188820,ENSG00000120217,ENSG00000131979,ENSG00000096996,ENSG00000169248,ENSG00000117226,ENSG00000026751,ENSG00000224389,ENSG00000197646,ENSG00000164136,ENSG00000149131,ENSG00000186439,ENSG00000089692,ENSG00000184588,ENSG00000073861,ENSG00000173369,ENSG00000169245,ENSG00000196126,ENSG00000167207,ENSG00000204642,ENSG00000079385,ENSG00000181374,ENSG00000234745,ENSG00000000971,ENSG00000213809,ENSG00000140853,ENSG00000243649,ENSG00000204592,ENSG00000102794,ENSG00000168062,ENSG00000153064,ENSG00000138755,ENSG00000172183,ENSG00000141655,ENSG00000206503,ENSG00000123609,ENSG00000123240,ENSG00000115415,ENSG00000213512,ENSG00000162931,ENSG00000204525,ENSG00000198736,ENSG00000096968,ENSG00000168329,ENSG00000127951,ENSG00000013374,ENSG00000151651,ENSG00000137193,ENSG00000135148,ENSG00000178726,ENSG00000158270,ENSG00000165949,ENSG00000104312,ENSG00000176485,ENSG00000101916,ENSG00000156587,ENSG00000123685,ENSG00000166278,ENSG00000018280,ENSG00000170581,ENSG00000108688,ENSG00000197272,ENSG00000101412,ENSG00000068079,ENSG00000153898,ENSG00000162692,ENSG00000140465,ENSG00000185201,ENSG00000284690,ENSG00000136514,ENSG00000205846,ENSG00000275718,ENSG00000243811,ENSG00000124256,ENSG00000184678,ENSG00000185885,ENSG00000121594,ENSG00000104518,ENSG00000064201,ENSG00000132274,ENSG00000140464,ENSG00000108950,ENSG00000100368,ENSG00000116514,ENSG00000173821,ENSG00000166710,ENSG00000108700,ENSG00000128383,ENSG00000125730,ENSG00000162739,ENSG00000239713,ENSG00000132514,ENSG00000186074,ENSG00000103313,ENSG00000161929,ENSG00000119917,ENSG00000174123,ENSG00000163874,ENSG00000085563,ENSG00000163131,ENSG00000167914,ENSG00000105639,ENSG00000083799,ENSG00000104894,ENSG00000119922,ENSG00000196954,ENSG00000035720,ENSG00000124201,ENSG00000139832,ENSG00000185507,ENSG00000204397,ENSG00000185880,ENSG00000165806,ENSG00000081985,ENSG00000134321,ENSG00000120436,ENSG00000100985,ENSG00000137959,ENSG00000144118,ENSG00000182326,ENSG00000078401,ENSG00000139178,ENSG00000115267,ENSG00000166920,ENSG00000117090,ENSG00000158517,ENSG00000163840,ENSG00000183347,ENSG00000141682,ENSG00000239998,ENSG00000064932,ENSG00000204616,ENSG00000137628,ENSG00000159403,ENSG00000154639,ENSG00000142089,ENSG00000167992,ENSG00000075240,ENSG00000204632,ENSG00000158714,ENSG00000125355,ENSG00000187554,ENSG00000104856,ENSG00000175175,ENSG00000275385,ENSG00000134326,ENSG00000189067,ENSG00000178999,ENSG00000271503,ENSG00000254087,ENSG00000106952,ENSG00000168811,ENSG00000111335,ENSG00000163735,ENSG00000255833,ENSG00000163564,ENSG00000152778,ENSG00000117632,ENSG00000164300,ENSG00000136044,ENSG00000173193,ENSG00000196664,ENSG00000085265,ENSG00000243414,ENSG00000184371,ENSG00000226979,ENSG00000175445,ENSG00000157873,ENSG00000136560,ENSG00000111331,ENSG00000114698,ENSG00000138496,ENSG00000092445,ENSG00000188313,ENSG00000137265
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            genesymbols
#> 1741                                                                                                                                                                                                                                                                                                                                      ACOD1,ADAM8,ADGRE5,AIM2,APOBEC3A,APOBEC3D,APOBEC3G,APOL1,APPL2,ASCL2,AURKB,B2M,BANK1,BCL6,BTN2A2,BTN3A1,BTN3A2,BTN3A3,C1QB,C1R,C1RL,C1S,C2,C3,C4A,C4B,CALCOCO2,CALHM6,CASP4,CCL13,CCL15,CCL18,CCL5,CCL7,CCL8,CCRL2,CD1A,CD1C,CD274,CD28,CD300H,CD300LF,CD37,CD38,CD40,CD69,CD7,CD74,CD80,CD83,CEACAM1,CFB,CFH,CIITA,CLEC10A,CLEC6A,COLEC12,CR1L,CSF1,CSF2RB,CTLA4,CTSL,CTSS,CX3CR1,CXCL10,CXCL11,CXCL5,CXCL9,CXCR3,CYLD,CYSLTR1,CYSLTR2,DDX60,DLL1,DTX3L,DYSF,EDA,EDN1,ENPP2,ERAP2,EXO1,FAS,FCN1,FGL1,FGL2,FYB1,GBP1,GBP2,GBP3,GBP4,GBP5,GBP6,GBP7,GCH1,GPR183,GPR31,GRAMD4,GSDMD,GTPBP1,H2BC21,HLA-A,HLA-B,HLA-C,HLA-DMA,HLA-DMB,HLA-DOA,HLA-DOB,HLA-DPA1,HLA-DPB1,HLA-DQA1,HLA-DQA1,HLA-DQB1,HLA-DQB2,HLA-DRA,HLA-DRB1,HLA-DRB5,HLA-E,HLA-F,HLA-G,HLA-H,HRH2,ICAM1,IDO1,IFI27,IFI35,IFI44L,IFIH1,IFIT2,IFIT3,IFIT5,IFITM1,IFITM2,IFITM3,IGSF6,IL12A,IL12RB1,IL12RB2,IL15,IL18BP,IL1RN,IL27,IL31RA,IL32,IL4I1,IL7,IRF1,IRF4,IRF7,ISG20,ITK,JAK2,JAK3,KARS1,KLRK1,LAG3,LAMP3,LILRA1,LILRA2,LILRB3,LITAF,LTA,LY75,LYN,MCOLN2,MEFV,MSRB1,NCF1,NLRC5,NMI,NOD2,NR4A3,NUB1,OAS2,OAS3,OPTN,OSM,P2RX7,PARP14,PARP3,PARP9,PCYT1A,PDCD1,PDCD1LG2,PDE4B,PIM1,PLPP4,PLSCR1,PML,PSMB10,PTGER4,PYHIN1,RAB20,RALB,RELB,RIPK2,RNF19B,RSAD2,S100A13,SBNO2,SCIMP,SECTM1,SERINC5,SERPING1,SIT1,SLAMF1,SLAMF6,SLAMF7,SLAMF8,SLC11A1,STAP1,STAT1,STAT2,SUCNR1,TANK,TAP1,TAP2,TBX21,TICAM2,TIFA,TIFAB,TLR10,TLR5,TLR7,TLR8,TNFRSF11A,TNFRSF14,TNFRSF21,TNFSF10,TNFSF13B,TNFSF18,TNFSF8,TRAFD1,TRIM17,TRIM22,TRIM31,TRIM69,TYRO3,UBD,UBE2L6,UNG,ZBP1,ZC3H12A,ZNFX1
#> 606  ACOD1,ADAM8,ADGRE5,AIM2,ALAS1,APOBEC3A,APOBEC3D,APOBEC3G,APOL1,APPL2,ASB2,ASCL2,AURKB,B2M,BANK1,BATF2,BATF3,BCL2L11,BCL6,BTN2A2,BTN3A1,BTN3A2,BTN3A3,C1QB,C1R,C1RL,C1S,C2,C3,C4A,C4B,CALCOCO2,CALHM6,CASP4,CCL13,CCL15,CCL18,CCL5,CCL7,CCL8,CCRL2,CD101,CD1A,CD1C,CD274,CD28,CD300H,CD300LF,CD37,CD38,CD40,CD69,CD7,CD74,CD80,CD83,CD93,CEACAM1,CFB,CFH,CIITA,CLEC10A,CLEC2B,CLEC6A,COLEC12,CR1L,CSF1,CSF2RB,CTLA4,CTSL,CTSS,CX3CR1,CXADR,CXCL10,CXCL11,CXCL5,CXCL9,CXCR3,CYLD,CYSLTR1,CYSLTR2,DDX60,DLL1,DTX3L,DYSF,EDA,EDN1,ENPP2,EPAS1,EPHB3,ERAP2,EXO1,FAS,FAXDC2,FCN1,FGL1,FGL2,FLT3LG,FYB1,GBP1,GBP2,GBP3,GBP4,GBP5,GBP6,GBP7,GCH1,GLUL,GPR183,GPR31,GRAMD4,GSDMD,GTPBP1,H2BC21,HAVCR1,HCAR2,HELLS,HLA-A,HLA-B,HLA-C,HLA-DMA,HLA-DMB,HLA-DOA,HLA-DOB,HLA-DPA1,HLA-DPB1,HLA-DQA1,HLA-DQA1,HLA-DQB1,HLA-DQB2,HLA-DRA,HLA-DRB1,HLA-DRB5,HLA-E,HLA-F,HLA-G,HLA-H,HRH2,HSD3B7,HSH2D,ICAM1,IDO1,IDO2,IFI27,IFI35,IFI44L,IFIH1,IFIT2,IFIT3,IFIT5,IFITM1,IFITM2,IFITM3,IGSF6,IL12A,IL12RB1,IL12RB2,IL15,IL15RA,IL18BP,IL1RN,IL27,IL31RA,IL32,IL4I1,IL7,IRF1,IRF4,IRF7,ISG20,ITGA7,ITK,JAK2,JAK3,KARS1,KITLG,KLRK1,LAG3,LAMP3,LILRA1,LILRA2,LILRB3,LITAF,LRP5,LRRK2,LTA,LY75,LYN,LYVE1,MCOLN2,MEFV,MERTK,MSRB1,MTUS1,NCAPG2,NCF1,NLRC5,NLRP12,NMI,NOD2,NR4A3,NUB1,OAS2,OAS3,OPTN,OSM,P2RX4,P2RX7,PADI2,PARP14,PARP3,PARP9,PCYT1A,PDCD1,PDCD1LG2,PDE4B,PIM1,PLPP4,PLSCR1,PMAIP1,PML,POLB,PSMB10,PSMB8,PSMB9,PSME1,PTGER4,PYHIN1,RAB20,RALB,RELB,RIPK2,RNF19B,RNF213,RSAD2,S100A13,S1PR1,SBNO2,SCIMP,SCIN,SECTM1,SELL,SERINC5,SERPING1,SIT1,SLAMF1,SLAMF6,SLAMF7,SLAMF8,SLC11A1,SOCS1,STAP1,STAT1,STAT2,SUCNR1,TAL1,TANK,TAP1,TAP2,TAPBP,TAPBPL,TBX21,TESC,TICAM2,TIFA,TIFAB,TLR10,TLR5,TLR7,TLR8,TMEM176A,TMEM176B,TNFAIP6,TNFRSF11A,TNFRSF14,TNFRSF21,TNFSF10,TNFSF13B,TNFSF18,TNFSF8,TRAFD1,TRIM17,TRIM22,TRIM31,TRIM69,TSPAN32,TYRO3,UBD,UBE2L6,UNG,VCAM1,VEGFC,ZBP1,ZC3H12A,ZNFX1
#> 518                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ASCL2,B2M,BCL6,BTN3A1,BTN3A2,BTN3A3,C1QB,C1R,C1RL,C1S,C2,C3,C4A,C4B,CD1A,CD1C,CD274,CD28,CD40,CD69,CD7,CD74,CD80,CEACAM1,CLEC10A,CLEC6A,CR1L,CSF2RB,CTLA4,CTSL,CTSS,CX3CR1,ERAP2,EXO1,FGL1,GPR183,HLA-A,HLA-B,HLA-C,HLA-DMA,HLA-DMB,HLA-DOA,HLA-DOB,HLA-DPA1,HLA-DPB1,HLA-DQA1,HLA-DQA1,HLA-DQB1,HLA-DQB2,HLA-DRA,HLA-DRB1,HLA-DRB5,HLA-E,HLA-F,HLA-G,HLA-H,ICAM1,IL12A,IL12RB1,IL12RB2,IL18BP,IL27,IL4I1,IRF1,IRF4,IRF7,ITK,JAK2,JAK3,KLRK1,LAG3,LAMP3,LILRA1,LILRB3,LTA,LYN,MCOLN2,NOD2,P2RX7,PARP3,PCYT1A,PDCD1,PDCD1LG2,RELB,RIPK2,RNF19B,RSAD2,SECTM1,SIT1,SLAMF1,SLAMF6,SLAMF7,SLC11A1,TAP1,TAP2,TBX21,TLR8,TNFRSF11A,TNFRSF14,TNFRSF21,TNFSF13B,TNFSF18,UNG,ZC3H12A
#> 2355                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ABCB1,ACOD1,ADAM8,AIM2,APOBEC3A,APOBEC3D,APOBEC3G,APOL1,APPL2,AURKB,B2M,BANK1,BATF2,BATF3,C1QB,C1R,C1RL,C1S,C2,C3,C4A,C4B,CALCOCO2,CALHM6,CARD16,CASP4,CASP7,CCL13,CCL15,CCL18,CCL5,CCL7,CCL8,CD274,CD300H,CD300LF,CD37,CD40,CD74,CD80,CEACAM1,CFB,CFH,CIITA,CLEC10A,CLEC6A,CMPK2,COLEC12,COXFA4L3,CSF1,CSF2RB,CTSS,CX3CR1,CXADR,CXCL10,CXCL11,CXCL5,CXCL9,CYLD,CYP1A1,DDX60,DTX3L,E2F1,EDN1,EME1,FAM20A,FCN1,FGL2,GBP1,GBP2,GBP3,GBP4,GBP5,GBP6,GBP7,GCH1,GPR31,GRAMD4,GSDMA,GSDMD,H2BC21,HLA-A,HLA-B,HLA-C,HLA-DPA1,HLA-DRB1,HLA-E,HLA-F,HLA-G,IDO1,IFI27,IFI35,IFI44L,IFIH1,IFIT2,IFIT3,IFIT5,IFITM1,IFITM2,IFITM3,IL12A,IL12RB1,IL12RB2,IL15,IL18BP,IL27,IL31RA,IL4I1,IRF1,IRF4,IRF7,ISG20,JAK2,JAK3,KLF4,KLRK1,LAG3,LILRA2,LITAF,LPL,LTA,LYN,MCOLN2,MEFV,MMP9,MSRB1,NCF1,NLRC5,NMI,NOD2,NUB1,OAS2,OAS3,OPTN,P2RX7,PARP14,PARP9,PDCD1,PDCD1LG2,PDE4B,PIM1,PLAAT3,PLSCR1,PLSCR4,PMAIP1,PML,PPM1E,PYHIN1,RAB20,RALB,RELB,RIPK2,RNF19B,RNF213,RSAD2,RTP4,SBNO2,SCIMP,SERINC5,SERPING1,SLAMF1,SLAMF6,SLAMF7,SLAMF8,SLC11A1,STAP1,STAT1,STAT2,STMN1,TANK,TAP2,TBX21,THBD,TICAM2,TIFA,TIFAB,TLR10,TLR5,TLR7,TLR8,TMEM255A,TNFRSF11A,TNFRSF14,TNFSF8,TRAFD1,TRDN,TRIM17,TRIM22,TRIM31,TRIM69,TSPAN32,TYRO3,UBD,UBE2L6,VCAM1,VWCE,ZBP1,ZC3H12A,ZNFX1
#> 8066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ABCB1,ACOD1,ADAM8,AIM2,APOBEC3A,APOBEC3D,APOBEC3G,APOL1,APPL2,AURKB,B2M,BANK1,BATF2,BATF3,C1QB,C1R,C1RL,C1S,C2,C3,C4A,C4B,CALCOCO2,CALHM6,CARD16,CASP4,CASP7,CCL13,CCL15,CCL18,CCL5,CCL7,CCL8,CD274,CD300H,CD300LF,CD37,CD40,CD74,CD80,CEACAM1,CFB,CFH,CIITA,CLEC10A,CLEC6A,CMPK2,COLEC12,COXFA4L3,CSF1,CSF2RB,CTSS,CX3CR1,CXADR,CXCL10,CXCL11,CXCL5,CXCL9,CYLD,CYP1A1,DDX60,DTX3L,E2F1,EDN1,FAM20A,FCN1,FGL2,GBP1,GBP2,GBP3,GBP4,GBP5,GBP6,GBP7,GCH1,GPR31,GRAMD4,GSDMA,GSDMD,H2BC21,HLA-A,HLA-B,HLA-C,HLA-DPA1,HLA-DRB1,HLA-E,HLA-F,HLA-G,IDO1,IFI27,IFI35,IFI44L,IFIH1,IFIT2,IFIT3,IFIT5,IFITM1,IFITM2,IFITM3,IL12A,IL12RB1,IL12RB2,IL15,IL18BP,IL27,IL31RA,IRF1,IRF4,IRF7,ISG20,JAK2,JAK3,KLRK1,LAG3,LILRA2,LITAF,LPL,LTA,LYN,MCOLN2,MEFV,MMP9,MSRB1,NCF1,NLRC5,NMI,NOD2,NUB1,OAS2,OAS3,OPTN,P2RX7,PARP14,PARP9,PDCD1LG2,PDE4B,PIM1,PLAAT3,PLSCR1,PLSCR4,PMAIP1,PML,PPM1E,PYHIN1,RAB20,RALB,RELB,RIPK2,RNF19B,RNF213,RSAD2,RTP4,SBNO2,SCIMP,SERINC5,SERPING1,SLAMF1,SLAMF6,SLAMF7,SLAMF8,SLC11A1,STAP1,STAT1,STAT2,STMN1,TANK,TAP2,TBX21,THBD,TICAM2,TIFA,TIFAB,TLR10,TLR5,TLR7,TLR8,TMEM255A,TNFRSF11A,TNFRSF14,TNFSF8,TRAFD1,TRDN,TRIM17,TRIM22,TRIM31,TRIM69,TSPAN32,TYRO3,UBD,UBE2L6,VCAM1,VWCE,ZBP1,ZC3H12A,ZNFX1
#> 6167                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ABCB1,ACOD1,ADAM8,AIM2,APOBEC3A,APOBEC3D,APOBEC3G,APOL1,APPL2,AURKB,B2M,BANK1,BATF2,BATF3,C1QB,C1R,C1RL,C1S,C2,C3,C4A,C4B,CALCOCO2,CALHM6,CARD16,CASP4,CASP7,CCL13,CCL15,CCL18,CCL5,CCL7,CCL8,CD274,CD300H,CD300LF,CD37,CD40,CD74,CD80,CEACAM1,CFB,CFH,CIITA,CLEC10A,CLEC6A,CMPK2,COLEC12,COXFA4L3,CSF1,CSF2RB,CTSS,CX3CR1,CXADR,CXCL10,CXCL11,CXCL5,CXCL9,CYLD,CYP1A1,DDX60,DTX3L,E2F1,EDN1,FAM20A,FCN1,FGL2,GBP1,GBP2,GBP3,GBP4,GBP5,GBP6,GBP7,GCH1,GPR31,GRAMD4,GSDMA,GSDMD,H2BC21,HLA-A,HLA-B,HLA-C,HLA-DPA1,HLA-DRB1,HLA-E,HLA-F,HLA-G,IDO1,IFI27,IFI35,IFI44L,IFIH1,IFIT2,IFIT3,IFIT5,IFITM1,IFITM2,IFITM3,IL12A,IL12RB1,IL12RB2,IL15,IL18BP,IL27,IL31RA,IRF1,IRF4,IRF7,ISG20,JAK2,JAK3,KLRK1,LAG3,LILRA2,LITAF,LPL,LTA,LYN,MCOLN2,MEFV,MMP9,MSRB1,NCF1,NLRC5,NMI,NOD2,NUB1,OAS2,OAS3,OPTN,P2RX7,PARP14,PARP9,PDCD1LG2,PDE4B,PIM1,PLAAT3,PLSCR1,PLSCR4,PMAIP1,PML,PPM1E,PYHIN1,RAB20,RALB,RELB,RIPK2,RNF19B,RNF213,RSAD2,RTP4,SBNO2,SCIMP,SERINC5,SERPING1,SLAMF1,SLAMF6,SLAMF7,SLAMF8,SLC11A1,STAP1,STAT1,STAT2,STMN1,TANK,TAP2,TBX21,THBD,TICAM2,TIFA,TIFAB,TLR10,TLR5,TLR7,TLR8,TMEM255A,TNFRSF11A,TNFRSF14,TNFSF8,TRAFD1,TRDN,TRIM17,TRIM22,TRIM31,TRIM69,TSPAN32,TYRO3,UBD,UBE2L6,VCAM1,VWCE,ZBP1,ZC3H12A,ZNFX1
```

The function will return a table with 10 columns

* `category`: The computer readable GO term ID.
* `over_represented_pvalue`: p-value for the overrepresentation test for enrichment (as specified by the `goseq` algorithm)
* `under_represented_pvalue`: p-value for the underrepresentation test for enrichment
* `numDEInCat`: The number of DE genes associated with this term (as defined in the `res_de` or in the `de_genes` parameters) (similar to the `Annotated` column of the output from `run_topGO()`)
* `numInCat` The overall number of detected genes associated with this term (as defined in the `de_container` or in the `bg_genes` parameters).
* `term`: The human readable GO term name.
* `ontology`: The ontology used to run the enrichment tests (BP/MF/CC)
* `p.adj`: FDR of your findings adjusted for multiple testing
* `genes`: Lists the DE gene identifiers associated with that term (separated by a comma)
* `genesymbols`: Lists the DE gene symbols associated with that term (separated by a comma)

## 5.3 `mosdef` and `clusterProfiler`

Parameters like `top_de`, `min_counts`, `verbose`, `FDR_threshold` and `de_type`
can also be used here (For more detail on these parameters see above).
If you want to further customize the call of `enrichGO()` inside the function, have a look at the documentation for `enrichGO()` from *[clusterProfiler](https://bioconductor.org/packages/3.22/clusterProfiler)* Those parameters can be added to the `run_cluPro()` function call within the ellipsis (`...`).
For example, as we are doing in the chunk that follows, we set Biological Process as the ontology to be used, by specifying `ont = "BP"`

```
clupro_macrophage <- run_cluPro(
  de_container = dds_macrophage,
  res_de = res_macrophage_IFNg_vs_naive,
  mapping = "org.Hs.eg.db",
  keyType = "SYMBOL",
  ont = "BP"
)
head(clupro_macrophage)
```

Importantly, `keyType` is relevant for the `enrichGO()` function that is wrapped in this routine.
If using `DESeqDataset` and `DESeqResults`, this has to be “SYMBOL” which is also the default.
If you use vectors please specify here what type of IDs you provide.

Again, to save time when rendering the vignette, we load the objects provided alongside this package to demonstrate the output (see also [this script included in the package](https://github.com/imbeimainz/mosdef/blob/devel/inst/scripts/create_mosdef_data.R) to inspect the code used to generate the objects):

```
data(res_enrich_macrophage_cluPro, package = "mosdef")
```

The function will return a large enrich result containing some metadata and the enrichment results with 9 columns.

```
head(res_enrich_macrophage_cluPro)
#>                    ID
#> GO:0002250 GO:0002250
#> GO:0002252 GO:0002252
#> GO:0009617 GO:0009617
#> GO:0002460 GO:0002460
#> GO:0019882 GO:0019882
#> GO:0002396 GO:0002396
#>                                                                                                                          Description
#> GO:0002250                                                                                                  adaptive immune response
#> GO:0002252                                                                                                   immune effector process
#> GO:0009617                                                                                                     response to bacterium
#> GO:0002460 adaptive immune response based on somatic recombination of immune receptors built from immunoglobulin superfamily domains
#> GO:0019882                                                                                       antigen processing and presentation
#> GO:0002396                                                                                              MHC protein complex assembly
#>            GeneRatio   BgRatio       pvalue     p.adjust       qvalue
#> GO:0002250    99/789 374/13083 4.458881e-38 2.055544e-34 1.713618e-34
#> GO:0002252    90/789 488/13083 2.959548e-22 6.821758e-19 5.687005e-19
#> GO:0009617    86/789 485/13083 3.940453e-20 6.055163e-17 5.047928e-17
#> GO:0002460    60/789 261/13083 6.133599e-20 7.068973e-17 5.893098e-17
#> GO:0019882    36/789 103/13083 8.753721e-19 8.070930e-16 6.728386e-16
#> GO:0002396    16/789  18/13083 3.616983e-18 2.144588e-15 1.787850e-15
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               geneID
#> GO:0002250 IRF1/IL18BP/HLA-DPA1/HLA-DMA/TAP2/TAP1/HLA-DMB/ASCL2/CD40/C4A/CD74/HLA-DOA/P2RX7/CD274/HLA-DRA/IL12RB1/ITK/SLAMF7/C4B/PDCD1LG2/SERPING1/LAG3/LAMP3/HLA-DPB1/TBX21/ERAP2/C1QB/HLA-DRB1/NOD2/HLA-F/CEACAM1/HLA-DQB1/BTN3A2/HLA-DRB5/HLA-B/KLRK1/BTN3A1/HLA-E/TNFRSF11A/HLA-A/CTLA4/HLA-C/JAK2/CX3CR1/HLA-DQB2/CR1L/CD7/RIPK2/TLR8/BTN3A3/IL4I1/C2/TNFSF13B/SLC11A1/GPR183/IL27/CD28/MCOLN2/HLA-DOB/HLA-DQA1/ICAM1/CLEC6A/LILRB3/TNFSF18/CD80/PDCD1/CSF2RB/TNFRSF21/RNF19B/B2M/C3/SLAMF6/CLEC10A/ZC3H12A/CTSS/JAK3/FGL1/CD1A/EXO1/IRF7/RSAD2/LILRA1/C1S/C1RL/SIT1/SLAMF1/C1R/HLA-G/CD1C/RELB/BCL6/LYN/IL12A/UNG/LTA/TNFRSF14/PARP3/CTSL/IRF4
#> GO:0002252                                                                                              TAP2/HLA-DMB/ASCL2/CD40/C4A/CD74/P2RX7/HLA-DRA/IL12RB1/SLAMF7/C4B/SERPING1/LAG3/TBX21/C1QB/HLA-DRB1/NOD2/HLA-F/CEACAM1/BTN3A2/HLA-B/CFH/KLRK1/CFB/HLA-E/HLA-A/NMI/HLA-C/SUCNR1/CX3CR1/FGL2/CR1L/RIPK2/TLR8/BTN3A3/IL4I1/C2/SLC11A1/GPR183/IL27/IFI35/CD28/ICAM1/TNFSF18/CD80/CSF2RB/RNF19B/B2M/C3/SLAMF6/SCIMP/S100A13/ZC3H12A/JAK3/PLPP4/STAP1/CD1A/EXO1/IRF7/RSAD2/C1S/C1RL/SLAMF1/NCF1/LILRA2/SBNO2/DDX60/DYSF/C1R/KARS1/HLA-G/SLAMF8/CD1C/PTGER4/RELB/BCL6/LITAF/LYN/IL12A/APPL2/DLL1/TLR7/FCN1/TICAM2/UNG/LTA/NR4A3/TNFRSF14/PARP3/IRF4
#> GO:0009617                                                                                                   GBP2/IL18BP/GBP5/GBP4/TAP2/IDO1/CD40/GBP1/P2RX7/CD274/GCH1/CXCL11/GBP3/C4B/PDCD1LG2/TRDN/PDE4B/CXCL10/HLA-DRB1/NOD2/HLA-B/KLRK1/NLRC5/CFB/HLA-E/ACOD1/BANK1/CXCL9/TNFRSF11A/HLA-A/OPTN/GBP7/JAK2/CX3CR1/THBD/COLEC12/RIPK2/PLAAT3/C2/SLC11A1/IL27/VCAM1/CYP1A1/H2BC21/CD80/GSDMD/FAM20A/CSF2RB/RNF213/B2M/C3/SCIMP/TLR10/ZC3H12A/GSDMA/CASP4/STAP1/ZNFX1/CARD16/CASP7/IL12RB2/GPR31/MMP9/EDN1/C15orf48/GBP6/LILRA2/SBNO2/SLAMF8/TMEM255A/PTGER4/PPM1E/CMPK2/LITAF/LYN/TNFSF8/IL12A/OAS2/CXCL5/TIFAB/TICAM2/LTA/LPL/TNFRSF14/OAS3/PLSCR4
#> GO:0002460                                                                                                                                                                                                                                                                                 IL18BP/TAP2/ASCL2/CD40/C4A/CD74/P2RX7/CD274/HLA-DRA/IL12RB1/C4B/SERPING1/TBX21/C1QB/HLA-DRB1/NOD2/HLA-F/CEACAM1/BTN3A2/HLA-B/HLA-E/HLA-A/HLA-C/JAK2/CR1L/RIPK2/TLR8/BTN3A3/IL4I1/C2/TNFSF13B/SLC11A1/IL27/CD28/ICAM1/CLEC6A/CD80/CSF2RB/B2M/C3/SLAMF6/ZC3H12A/JAK3/CD1A/EXO1/IRF7/RSAD2/C1S/C1RL/SLAMF1/C1R/HLA-G/CD1C/RELB/BCL6/IL12A/UNG/LTA/PARP3/IRF4
#> GO:0019882                                                                                                                                                                                                                                                                                                                                                                                             HLA-DPA1/HLA-DMA/TAP2/TAP1/HLA-DMB/CD74/HLA-DOA/HLA-DRA/HLA-DPB1/ERAP2/HLA-DRB1/NOD2/HLA-F/HLA-DQB1/HLA-DRB5/HLA-B/PSME1/HLA-E/HLA-A/HLA-C/FGL2/HLA-DQB2/SLC11A1/TAPBP/PSMB8/HLA-DOB/HLA-DQA1/ICAM1/B2M/CTSS/CD1A/TAPBPL/HLA-G/CD1C/RELB/CTSL
#> GO:0002396                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             HLA-DPA1/HLA-DMA/HLA-DMB/HLA-DOA/HLA-DRA/HLA-DPB1/HLA-DRB1/HLA-DQB1/HLA-DRB5/HLA-A/HLA-DQB2/TAPBP/HLA-DOB/HLA-DQA1/B2M/TAPBPL
#>            Count
#> GO:0002250    99
#> GO:0002252    90
#> GO:0009617    86
#> GO:0002460    60
#> GO:0019882    36
#> GO:0002396    16
```

The definitions of these columns are included in the extensive *[clusterProfiler](https://bioconductor.org/packages/3.22/clusterProfiler)* package documentation, please refer to that for more details.

## 5.4 Alternative ways to run enrichment analyses, within `mosdef`

All of these functions tailored to run enrichment methods also work if you only have/provide a vector of differentially expressed genes and a vector of background genes.
Most of the above mentioned parameters work here as well (`top_de`, `verbose`), however parameters like `min_counts` and `de_type` will not affect the result, since they need further information which can only be found in the `DESeqDataset` and `DESeqResults` (in this case, access to the counts from the `DESeqDataset` object `de_container` and the Log2FoldChange from the `DESeqResults` object passed to `res_de`).

```
res_subset <- deresult_to_df(res_macrophage_IFNg_vs_naive)[1:100, ]
myde <- res_subset$id
myassayed <- rownames(res_macrophage_IFNg_vs_naive)
## Here keys are Ensembl not symbols
res_enrich_macrophage_topGO_vec <- run_topGO(
  de_genes = myde,
  bg_genes = myassayed,
  mapping = "org.Hs.eg.db",
  gene_id = "ensembl"
)
#> Your dataset has 100 DE genes.
#> You selected 100 (100.00%) genes for the enrichment analysis.
#> 6105 GO terms were analyzed. Not all of them are significantly enriched.
#> We suggest further subsetting the output list by for example:
#> using a pvalue cutoff in the column:
#> 'p.value_elim'.
head(res_enrich_macrophage_topGO_vec)
#>        GO.ID
#> 1 GO:0002503
#> 2 GO:0002250
#> 3 GO:0019886
#> 4 GO:0031640
#> 5 GO:0034341
#> 6 GO:0071346
#>                                                                                Term
#> 1                        peptide antigen assembly with MHC class II protein complex
#> 2                                                          adaptive immune response
#> 3 antigen processing and presentation of exogenous peptide antigen via MHC class II
#> 4                                              killing of cells of another organism
#> 5                                                    response to type II interferon
#> 6                                           cellular response to type II interferon
#>   Annotated Significant Expected Rank in p.value_classic p.value_elim
#> 1        14           7     0.08                      37      7.4e-13
#> 2       391          28     2.36                       3      2.3e-12
#> 3        28           8     0.17                      44      3.5e-12
#> 4        61           8     0.37                      73      2.8e-09
#> 5       118          14     0.71                      18      9.7e-08
#> 6        96           9     0.58                      80      2.0e-07
#>   p.value_classic
#> 1         7.4e-13
#> 2         3.8e-23
#> 3         3.5e-12
#> 4         2.8e-09
#> 5         8.3e-15
#> 6         5.7e-09
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                             genes
#> 1                                                                                                                                                                                                                                                                                                                                                 ENSG00000196126,ENSG00000204252,ENSG00000204257,ENSG00000204287,ENSG00000223865,ENSG00000231389,ENSG00000242574
#> 2 ENSG00000019582,ENSG00000026751,ENSG00000073861,ENSG00000078081,ENSG00000089041,ENSG00000089692,ENSG00000096996,ENSG00000101017,ENSG00000113263,ENSG00000120217,ENSG00000125347,ENSG00000137496,ENSG00000164308,ENSG00000167207,ENSG00000168394,ENSG00000173369,ENSG00000183734,ENSG00000196126,ENSG00000197646,ENSG00000204252,ENSG00000204257,ENSG00000204267,ENSG00000204287,ENSG00000223865,ENSG00000224389,ENSG00000231389,ENSG00000242574,ENSG00000244731
#> 3                                                                                                                                                                                                                                                                                                                                 ENSG00000019582,ENSG00000196126,ENSG00000204252,ENSG00000204257,ENSG00000204287,ENSG00000223865,ENSG00000231389,ENSG00000242574
#> 4                                                                                                                                                                                                                                                                                                                                 ENSG00000100342,ENSG00000117226,ENSG00000117228,ENSG00000154451,ENSG00000162645,ENSG00000169245,ENSG00000169248,ENSG00000244731
#> 5                                                                                                                                                                                                                                 ENSG00000019582,ENSG00000096996,ENSG00000101017,ENSG00000117226,ENSG00000117228,ENSG00000125347,ENSG00000131979,ENSG00000136436,ENSG00000154451,ENSG00000162645,ENSG00000162654,ENSG00000179583,ENSG00000213886,ENSG00000231389
#> 6                                                                                                                                                                                                                                                                                                                 ENSG00000096996,ENSG00000117226,ENSG00000117228,ENSG00000125347,ENSG00000154451,ENSG00000162645,ENSG00000162654,ENSG00000179583,ENSG00000231389
```

# 6 Plotting expression values in the context of DE

*[mosdef](https://bioconductor.org/packages/3.22/mosdef)* provides some wrappers to commonly used visualizations of individual genes, as well as summary visualizations for all features at once.

## 6.1 Individual genes - `gene_plot()`

An elegant way to plot the expression values (by default the normalized counts) of a certain gene of interest, split up by a covariate of interest - for example, the `condition`, IFNg vs naive.

```
gene_plot(
  de_container = dds_macrophage,
  gene = "ENSG00000125347",
  intgroup = "condition"
)
```

![](data:image/png;base64...)

Key parameters are in this case:

* `de_container`: Your `DESeqDataset`
* `gene`: The gene of interest
* `intgroup`: A character vector of names in `colData(de_container)` used for grouping the expression values.

Notably, `gene_plot()` also has some heuristics to suggest an appropriate layer of plotting the data points, depending on the number of samples included in each individual group - this include the simple jittered points, a boxplot, a violin plot, or a sina plot.
This automatic behavior can be suppressed by specifying a different value for the `plot_type` parameter.

## 6.2 All genes at once - Volcano plots

Volcano plots are one of the most well known and used plots to display differentially expressed genes.
These functions return a basic `ggplot` object including the most important parts when creating a volcano plot.

```
volcPlot <- de_volcano(
  res_de = res_macrophage_IFNg_vs_naive,
  mapping = "org.Hs.eg.db",
  logfc_cutoff = 1,
  FDR = 0.05,
  labeled_genes = 25
)
#> 'select()' returned 1:many mapping between keys and columns
volcPlot
#> Warning: Removed 17782 rows containing missing values or values outside the scale range
#> (`geom_text_repel()`).
```

![](data:image/png;base64...)

Again, an overview on the key parameters:

* `res_de`: Your `DESeqResults`
* `mapping`: The annotation/species: Important to generate symbols for labeling.
* `labeled_genes`: The number of the top DE genes to be labeled. Default is 30.
* `logfc_cutoff` and `FDR`: Where to draw the lines in the plot and which genes to mark as significant. The default is 1 (meaning L2FC +/-1): So genes with a FoldChange higher than 1 or lower -1 and a padj value below 0.05.

This plot can be later modified by the user, like any regular `ggplot` object. For example:

```
library("ggplot2")

volcPlot +
  ggtitle("macrophage Volcano") +
  ylab("-log10 PValue") +
  xlab("Log 2 FoldChange (Cutoff 1/-1)")
#> Warning: Removed 17782 rows containing missing values or values outside the scale range
#> (`geom_text_repel()`).
```

![](data:image/png;base64...)

For further possibilities please look at the *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* documentation.

In addition to only focusing on differentially expressed genes, in a volcano plot the user can also highlight genes associated with a certain GO term of interest.
This can be done with the `go_volcano()` function:

```
Volc_GO <- go_volcano(
  res_de = res_macrophage_IFNg_vs_naive,
  res_enrich = res_enrich_macrophage_topGO,
  term_index = 1,
  logfc_cutoff = 1,
  FDR = 0.05,
  mapping = "org.Hs.eg.db",
  n_overlaps = 50,
  col_to_use = "symbol",
  enrich_col = "genes",
  down_col = "black",
  up_col = "black",
  highlight_col = "tomato"
)

Volc_GO
#> Warning: Removed 17716 rows containing missing values or values outside the scale range
#> (`geom_label_repel()`).
#> Warning: ggrepel: 25 unlabeled data points (too many overlaps). Consider
#> increasing max.overlaps
```

![](data:image/png;base64...)

The key parameters:

* `res_de`: Your `DESeqResults`
* `res_enrich`: Your enrichment results
* `term_index`: The index(row) where your term of interest is located in your enrichment result.
* `logfc_cutoff` and `FDR`: Where to draw the lines in the plot and which genes to mark as significant. The default is one (meaning L2FC +/-1): So genes with a FoldChange higher than 1 or lower -1 and a padj value below 0.05.
* `mapping`: The annotation/species: Important to generate symbols for labeling.
* `n_overlaps`: The number of overlaps `ggrepel` is supposed to allow for labeling (increases number of labeled genes).
* `col_to_use`: Name of the column in your res\_de containing the gene symbols.
* `enrich_col`: Name of the column in your res\_enrich containing the gene symbols. For an example see `run_topGO` data provided in mosdef: `data(res_enrich_macrophage_topGO, package = "mosdef")`.
* `down_col`: Colour for your downregulated genes (genes with a `logfc_cutoff` below the value specified).
* `up_col`: Colour for your upregulated genes (genes with a `logfc_cutoff` above the value specified).
* `highlight_col`: Colour for your genes associated with the given term of interest.

## 6.3 All genes at once - MA plots

An alternative to the volcano plot, less focused on the individual significance values and more focused on the combination of mean expression and changes in expression levels, is the MA plot. It can be considered an extension of the Bland-Altman plot for genomics data.
This grants an overview of the differentially expressed genes across the different levels of expression.

`plot_ma()` also allows you to set x and y labels right away, but we provide some default values.
However, similar to `de_volcano()`, these can also be set later on by directly modifying the returned `ggplot` object.

```
maplot <- plot_ma(
  res_de = res_macrophage_IFNg_vs_naive,
  FDR = 0.05,
  hlines = 1
)
# For further parameters please check the function documentation
maplot
```

![](data:image/png;base64...)

All key parameters at a glance:

* `res_de`: Your `DESeqResults` object
* `FDR`: Which padj cutoff value to set for genes to be counted as DE (default < 0.05)
* `hlines`: whether or not (and where) to draw the horizontal line (optional)

Further control on the aspect of the output plot is enabled via the other possible parameters; please refer to the documentation of the `plot_ma()` function itself.

If desired, `plot_ma()` further allows you to highlight certain genes of interest to you, if providing them via the `intgenes` parameter.

```
maplot_genes <- plot_ma(
  res_de = res_macrophage_IFNg_vs_naive,
  FDR = 0.1,
  add_rug = FALSE,
  intgenes = c(
    "SLC7A2",
    "CFLAR",
    "PDK4",
    "IFNGR1"
  ), # suggested genes of interest
  hlines = 1,
  intgenes_color = "darkblue"
)
maplot_genes
```

![](data:image/png;base64...)

# 7 Beautifying and enhancing analysis reports

Analysis reports, often generated via Rmarkdown, are a great way of handing over data, results, and output to collaborators, colleagues, PIs, …

*[mosdef](https://bioconductor.org/packages/3.22/mosdef)* provides a set of functions aiming to enhance the report quality, e.g. by turning normal tables into interactive tables, linking to a number of additional external databases - thus simplifying the search & exploration steps which naturally follow the inspection of a DE table.

## 7.1 More information on features/genes

The life of a bioinformatician, but also the life of a biologist and a medical scientist, often contains a fair amount of searches into external databases, in order to obtain additional information on the shortlisted features.

Simplifying the time to reach these resources and embedding them into one info-rich analysis report is *[mosdef](https://bioconductor.org/packages/3.22/mosdef)*’s proposal to streamline this as a whole.

All of these (except ENSEMBL, using their internal identifier system) require gene symbols as the input.
Currently, *[mosdef](https://bioconductor.org/packages/3.22/mosdef)* has functions to create automated links to:

* ENSEMBL (<https://www.ensembl.org/index.html>)
* GeneCards (<https://www.genecards.org/>): For information/overview on the gene
* Pubmed (<https://pubmed.ncbi.nlm.nih.gov/>): For gene/GOterm related publications
* NCBI (<https://www.ncbi.nlm.nih.gov/>): For overview and chromosomal information on the gene
* dbPTM (<https://awi.cuhk.edu.cn/dbPTM/>): For post-translational modifications
* GTEX (<https://www.gtexportal.org/home/>): For data on expression of the gene in different tissues
* UniProt (“<https://www.uniprot.org/>”): For information on the protein related to the gene
* Human Protein Atlas (“<https://www.proteinatlas.org/>”): For information on the protein related to the gene for humans specifically

You can access all of these easily by using one function that uses a `data.frame` as input:

```
# creating a smaller subset for visualization purposes and to keep the main res_de
res_subset <- deresult_to_df(res_macrophage_IFNg_vs_naive, FDR = 0.05)[1:100, ]

buttonifier(
  df = res_subset,
  col_to_use = "symbol",
  create_buttons_to = c("GC", "NCBI", "GTEX", "UNIPROT", "dbPTM", "HPA", "PUBMED"),
  ens_col = "id",
  ens_species = "Homo_sapiens"
)
```

Again, an overview of the key parameters:

* `df`: A data.frame object containing your data. To get one from your `DESeqResults` data use the function: `deresult_to_df()`.
* `col_to_use`: Column where the gene names are stored, default is “SYMBOL”, in this example however the column is named “symbol”.
* `create_buttons_to`: All of the supported websites. You can pick however many you want.
* `ens_col`: Where to find the Ensembl IDs in case you want to turn those into buttons too. If not this defaults to NULL and that part is skipped.
* `ens_species`: The species you are working on. Only needed if you want to turn the Ensembl IDs into buttons.

Importantly, the `buttonifier()` function directly returns a `DT::datatable` by default (not a `data.frame`).
This is to ensure that the `escape = FALSE` parameter of `datatable` is set and not forgotten as the links/buttons will not work otherwise (or at least, will displayed very oddly as “simple text”, not interpreted as the code to generate buttons).

Advanced users that want further customization options to their `datatable` can ensure a `data.frame` is returned using the `output_format` parameter (then the `escape = FALSE` must be set by hand):

```
res_subset <- deresult_to_df(res_macrophage_IFNg_vs_naive, FDR = 0.05)[1:100, ]

res_subset <- buttonifier(res_subset,
  col_to_use = "symbol",
  create_buttons_to = c("GC", "NCBI", "HPA"),
  output_format = "DF"
)

DT::datatable(res_subset,
  escape = FALSE,
  rownames = FALSE,
  # other parameters specifically controlling the look of the DT...
  options = list(
    scrollX = TRUE
  )
)
```

As an additional prettifying element, the information on the log2 fold change can be also encoded with small transparent colored bars, representing the underlying effect sizes.
This can be done with the `de_table_painter()` function, displayed in the following chunk:

```
de_table_painter(res_subset,
                 rounding_digits = 3,
                 signif_digits = 5)
```

```
## This also works directly on the DESeqResults objects:
de_table_painter(res_macrophage_IFNg_vs_naive[1:50, ],
                 rounding_digits = 3,
                 signif_digits = 5)
```

All of the functions included inside the `buttonifier()` function are also available as singular functions in case you are only interested in a subset of them.
As a reminder: all functions, except the one related to the ENSEMBL database, can use/need gene symbols as input, so that the call to build up the table from its individual columns could be specified as in the following chunk:

```
res_subset <- deresult_to_df(res_macrophage_IFNg_vs_naive, FDR = 0.05)[1:100, ]

row.names(res_subset) <- create_link_ENSEMBL(row.names(res_subset), species = "Homo_sapiens")
res_subset$symbol_GC <-  create_link_GeneCards(res_subset$symbol)
res_subset$symbol_PubMed <- create_link_PubMed(res_subset$symbol)
res_subset$symbol_NCBI <- create_link_NCBI(res_subset$symbol)
res_subset$symbol_dbPTM <- create_link_dbPTM(res_subset$symbol)
res_subset$symbol_GTEX <- create_link_GTEX(res_subset$symbol)
res_subset$symbol_UniProt <- create_link_UniProt(res_subset$symbol)
res_subset$symbol_HPA <- create_link_HPA(res_subset$symbol)

DT::datatable(res_subset, escape = FALSE,
              options = list(
                scrollX = TRUE
              )
)
```

For information on singular genes you can use:

```
geneinfo_to_html("IRF1",
  res_de = res_macrophage_IFNg_vs_naive,
  col_to_use = "symbol"
)
```

**IRF1**
Link to the NCBI Gene database: [IRF1@NCBI](http://www.ncbi.nlm.nih.gov/gene/?term=IRF1[sym])
Link to the GeneCards database: [IRF1@GeneCards](https://www.genecards.org/cgi-bin/carddisp.pl?gene=IRF1)
Link to the GTEx Portal: [IRF1@GTEX](https://www.gtexportal.org/home/gene/IRF1)
Link to the UniProt Portal: [IRF1@UNIPROT](https://www.uniprot.org/uniprot/?query=IRF1)
Link to related articles on Pubmed: [IRF1@Pubmed](https://pubmed.ncbi.nlm.nih.gov/?term=IRF1)
**DE p-value (adjusted):** 5.580818e-93
**DE log2FoldChange:** 5.56

It can however also be used without a res\_de for a general overview.

```
geneinfo_to_html("ACTB")
```

**ACTB**
Link to the NCBI Gene database: [ACTB@NCBI](http://www.ncbi.nlm.nih.gov/gene/?term=ACTB[sym])
Link to the GeneCards database: [ACTB@GeneCards](https://www.genecards.org/cgi-bin/carddisp.pl?gene=ACTB)
Link to the GTEx Portal: [ACTB@GTEX](https://www.gtexportal.org/home/gene/ACTB)
Link to the UniProt Portal: [ACTB@UNIPROT](https://www.uniprot.org/uniprot/?query=ACTB)
Link to related articles on Pubmed: [ACTB@Pubmed](https://pubmed.ncbi.nlm.nih.gov/?term=ACTB)

This can be a practical way to generate some HTML content to be embedded e.g. in other contexts such as dashboards, as it is currently implemented in *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)*, *[ideal](https://bioconductor.org/packages/3.22/ideal)* and *[GeneTonic](https://bioconductor.org/packages/3.22/GeneTonic)*.

## 7.2 More information on GO terms

We display an interactive table for a subset of GO terms - in this case, we select the first 100 rows.

```
res_enrich_macrophage_topGO$GO.ID <- create_link_GO(res_enrich_macrophage_topGO$GO.ID)

DT::datatable(res_enrich_macrophage_topGO[1:100, ],
              escape = FALSE,
              options = list(
                scrollX = TRUE
              )
)
```

Setting `escape = FALSE` is important here to ensure the link is turned into a button - since we are dealing with a `datatable` where we need to interpret some content directly as HTML code.

To get information on a singular GO term of interest you can use:

```
go_to_html("GO:0001525")
```

**GO ID:** [GO:0001525@AMIGO](http://amigo.geneontology.org/amigo/term/GO%3A0001525)
**Pubmed results:** [angiogenesis@Pubmed](https://pubmed.ncbi.nlm.nih.gov/?term=angiogenesis)
**Term:** angiogenesis
**Ontology:** BP

**Definition:** Blood vessel formation when new vessels emerge from the proliferation of pre-existing blood vessels.
**Synonym:** blood vessel formation from pre-existing blood vessels

This not only creates a link to the AmiGO database, but also extracts some information about the term itself from the *[GO.db](https://bioconductor.org/packages/3.22/GO.db)* package.

This approach can be extended to link to additional external resources on genesets, such as MSigDB or Reactome.

# Session Info

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
#>  [1] ggplot2_4.0.0
#>  [2] TxDb.Hsapiens.UCSC.hg38.knownGene_3.22.0
#>  [3] GenomicFeatures_1.62.0
#>  [4] topGO_2.62.0
#>  [5] SparseM_1.84-2
#>  [6] GO.db_3.22.0
#>  [7] graph_1.88.0
#>  [8] org.Hs.eg.db_3.22.0
#>  [9] AnnotationDbi_1.72.0
#> [10] DESeq2_1.50.0
#> [11] SummarizedExperiment_1.40.0
#> [12] Biobase_2.70.0
#> [13] MatrixGenerics_1.22.0
#> [14] matrixStats_1.5.0
#> [15] GenomicRanges_1.62.0
#> [16] Seqinfo_1.0.0
#> [17] IRanges_2.44.0
#> [18] S4Vectors_0.48.0
#> [19] BiocGenerics_0.56.0
#> [20] generics_0.1.4
#> [21] macrophage_1.25.0
#> [22] mosdef_1.6.0
#> [23] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1            BiocIO_1.20.0            bitops_1.0-9
#>   [4] ggplotify_0.1.3          filelock_1.0.3           tibble_3.3.0
#>   [7] R.oo_1.27.1              BiasedUrn_2.0.12         polyclip_1.10-7
#>  [10] XML_3.99-0.19            lifecycle_1.0.4          httr2_1.2.1
#>  [13] lattice_0.22-7           MASS_7.3-65              crosstalk_1.2.2
#>  [16] magrittr_2.0.4           sass_0.4.10              rmarkdown_2.30
#>  [19] jquerylib_0.1.4          yaml_2.3.10              ggtangle_0.0.7
#>  [22] cowplot_1.2.0            DBI_1.2.3                RColorBrewer_1.1-3
#>  [25] abind_1.4-8              purrr_1.1.0              R.utils_2.13.0
#>  [28] RCurl_1.98-1.17          yulab.utils_0.2.1        tweenr_2.0.3
#>  [31] rappdirs_0.3.3           gdtools_0.4.4            enrichplot_1.30.0
#>  [34] ggrepel_0.9.6            tidytree_0.4.6           codetools_0.2-20
#>  [37] DelayedArray_0.36.0      DOSE_4.4.0               DT_0.34.0
#>  [40] ggforce_0.5.0            tidyselect_1.2.1         aplot_0.2.9
#>  [43] UCSC.utils_1.6.0         farver_2.1.2             goseq_1.62.0
#>  [46] BiocFileCache_3.0.0      GenomicAlignments_1.46.0 jsonlite_2.0.0
#>  [49] systemfonts_1.3.1        tools_4.5.1              progress_1.2.3
#>  [52] treeio_1.34.0            Rcpp_1.1.0               glue_1.8.0
#>  [55] SparseArray_1.10.0       xfun_0.53                geneLenDataBase_1.45.0
#>  [58] mgcv_1.9-3               qvalue_2.42.0            GenomeInfoDb_1.46.0
#>  [61] dplyr_1.1.4              withr_3.0.2              BiocManager_1.30.26
#>  [64] fastmap_1.2.0            digest_0.6.37            R6_2.6.1
#>  [67] gridGraphics_0.5-1       dichromat_2.0-0.1        biomaRt_2.66.0
#>  [70] RSQLite_2.4.3            cigarillo_1.0.0          R.methodsS3_1.8.2
#>  [73] tidyr_1.3.1              fontLiberation_0.1.0     data.table_1.17.8
#>  [76] rtracklayer_1.70.0       prettyunits_1.2.0        httr_1.4.7
#>  [79] htmlwidgets_1.6.4        S4Arrays_1.10.0          pkgconfig_2.0.3
#>  [82] gtable_0.3.6             blob_1.2.4               S7_0.2.0
#>  [85] XVector_0.50.0           clusterProfiler_4.18.0   htmltools_0.5.8.1
#>  [88] fontBitstreamVera_0.1.1  bookdown_0.45            fgsea_1.36.0
#>  [91] scales_1.4.0             png_0.1-8                ggfun_0.2.0
#>  [94] knitr_1.50               reshape2_1.4.4           rjson_0.2.23
#>  [97] nlme_3.1-168             curl_7.0.0               cachem_1.1.0
#> [100] stringr_1.5.2            parallel_4.5.1           restfulr_0.0.16
#> [103] pillar_1.11.1            grid_4.5.1               vctrs_0.6.5
#> [106] dbplyr_2.5.1             evaluate_1.0.5           magick_2.9.0
#> [109] tinytex_0.57             cli_3.6.5                locfit_1.5-9.12
#> [112] compiler_4.5.1           Rsamtools_2.26.0         rlang_1.1.6
#> [115] crayon_1.5.3             labeling_0.4.3           plyr_1.8.9
#> [118] fs_1.6.6                 ggiraph_0.9.2            stringi_1.8.7
#> [121] BiocParallel_1.44.0      txdbmaker_1.6.0          Biostrings_2.78.0
#> [124] lazyeval_0.2.2           GOSemSim_2.36.0          fontquiver_0.2.1
#> [127] Matrix_1.7-4             hms_1.1.4                patchwork_1.3.2
#> [130] bit64_4.6.0-1            KEGGREST_1.50.0          igraph_2.2.1
#> [133] memoise_2.0.1            bslib_0.9.0              ggtree_4.0.0
#> [136] fastmatch_1.1-6          bit_4.6.0                ape_5.8-1
#> [139] gson_0.1.0
```

# References

Alasoo, Kaur, Julia Rodrigues, Subhankar Mukhopadhyay, Andrew J Knights, Alice L Mann, Kousik Kundu, Christine Hale, Gordon Dougan, and Daniel J Gaffney. 2018. “Shared genetic effects on chromatin and gene expression indicate a role for enhancer priming in immune response.” *Nature Genetics* 50 (3): 424–31. <https://doi.org/10.1038/s41588-018-0046-7>.

Ashburner, Michael, Catherine A Ball, Judith A Blake, David Botstein, Heather Butler, J Michael Cherry, Allan P Davis, et al. 2000. “Gene Ontology: tool for the unification of biology.” *Nature Genetics* 25 (1): 25–29. <https://doi.org/10.1038/75556>.