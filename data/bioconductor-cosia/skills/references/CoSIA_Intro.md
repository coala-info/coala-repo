# CoSIA, an R package for Cross Species Investigation and Analysis

Anisha Haldar, Vishal H. Oza, Nathaniel DeVoss, Amanda D. Clark and Brittany N. Lasseigne

#### 11 December 2025

---

# 1 Summary

**C**r**o**ss **S**pecies **I**nvestigation and **A**nalysis (`CoSIA`) is a package that provides researchers with an alternative methodology for comparing across species and tissues using normal wild-type RNA-Seq Gene Expression data from Bgee. Using RNA-Seq Gene Expression data, CoSIA provides multiple visualization tools to explore the transcriptome diversity and variation across genes, tissues, and species. CoSIA uses the Coefficient of Variation and Shannon Entropy and Specificity to calculate transcriptome diversity and variation. CoSIA also provides additional conversion tools and utilities to provide a streamlined methodology for cross-species comparison.

![Figure 1. CoSIA_Workflow](data:image/png;base64...)

CoSIA is split into 3 methods that provide various resources in order for researchers to conduct cross species analysis using gene expression metrics.

* Method 1 uses `getConversion` to convert inputs between different gene identifiers in the same species as well as orthologs in different species. The other modules access tissue- and/or species-specific gene expression.
* Method 2 uses `getGEx` to obtain raw read counts that undergo Variance Stabilizing Transformation via DESeq2 methodology. Gene expression values are visualized for a single gene *across multiple tissues in single model organism* or *across multiple species in a single tissue* using the plotting methods, `plotTissueGEx` & `plotSpeciesGEx`, respectively.
* Method 3 uses `getGExMetrics` to calculate median-based Coefficient of Variation (variability) and Shannon Entropy (diversity & specificity). There are two accompanying plotting methods, `plotCVGEx` & `plotDSGEx` that are used to visualize the variation and diversity & specificity (DS) of gene expression across genes, tissues, and species.

---

## 1.1 Installation

In R:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("CoSIA")
```

## 1.2 Generating a CoSIAn object

### 1.2.1 Load CoSIA

```
library(CoSIA)
load("../inst/extdata/proccessed/monogenic_kidney_genes.rda")

# downsampling data for figure
set.seed(42)
monogenic_kid_sample <- dplyr::sample_n(monogenic_kidney_genes, 20)
```

### 1.2.2 Arguments and options table

(#tab:Table1.) CoSIA Arguments and Options.

| Slot Name | Possible Value Options | Default |
| --- | --- | --- |
| gene\_set | “character”, c(characters), data.frame$column | N/A |
| i\_species; o\_species; map\_species | “h\_sapiens”, “m\_musculus”, “r\_noregicus”, “d\_rerio”, “d\_melangoaster”, “c\_elegans” | N/A |
| mapping\_tool | “annotationDBI”, “biomaRt” | annotationDBI |
| input\_id; output\_ids | “Ensembl\_id”, “Entrez\_id”, “Symbol” | N/A |
| ortholog\_database | “NCBIOrtho”, “HomoloGene” | HomoloGene |
| map\_tissue | c(“tissue”), “tissue”; see `getTissues` | N/A |
| metric\_type | “CV\_Tissue”, “CV\_Species”, “DS\_Gene”, “DS\_Gene\_all”, “DS\_Tissue”, “DS\_Tissue\_all” | N/A |

### 1.2.3 Find possible tissues with `getTissues`

The function `getTissues` retrieves tissues available for a single species:

```
CoSIA::getTissues("d_rerio")
```

…or tissues shared across a list of species:

```
CoSIA::getTissues(c("m_musculus", "r_norvegicus"))
#> # A tibble: 21 × 1
#>    Common_Anatomical_Entity_Name
#>    <chr>
#>  1 adult mammalian kidney
#>  2 brain
#>  3 cerebellum
#>  4 colon
#>  5 duodenum
#>  6 esophagus
#>  7 frontal cortex
#>  8 heart
#>  9 ileum
#> 10 jejunum
#> # ℹ 11 more rows
```

*NOTE*: To compare across all shared tissues for your selected species, you can assign the `getTissues` output to an object as input for `map_tissues` when initializing a CoSIAn object.

### 1.2.4 Initializing a CoSIAn object

```
CoSIAn_Obj <- CoSIA::CoSIAn(
    gene_set = unique(monogenic_kid_sample$Gene),
    i_species = "h_sapiens",
    o_species = c(
        "h_sapiens",
        "r_norvegicus"
    ),
    input_id = "Symbol",
    output_ids = "Ensembl_id",
    map_species = c(
        "h_sapiens",
        "r_norvegicus"
    ),
    map_tissues = c(
        "adult mammalian kidney",
        "heart"
    ),
    mapping_tool = "annotationDBI",
    ortholog_database = "HomoloGene",
    metric_type = "CV_Species"
)

str(CoSIAn_Obj)
#> Formal class 'CoSIAn' [package "CoSIA"] with 13 slots
#>   ..@ gene_set         : chr [1:20] "SDCCAG8" "TACO1" "FANCA" "BMP7" ...
#>   ..@ i_species        : chr "h_sapiens"
#>   ..@ input_id         : chr "Symbol"
#>   ..@ o_species        : chr [1:2] "h_sapiens" "r_norvegicus"
#>   ..@ output_ids       : chr "Ensembl_id"
#>   ..@ mapping_tool     : chr "annotationDBI"
#>   ..@ ortholog_database: chr "HomoloGene"
#>   ..@ converted_id     :'data.frame':    1 obs. of  1 variable:
#>   .. ..$ X0: num 0
#>   ..@ map_tissues      : chr [1:2] "adult mammalian kidney" "heart"
#>   ..@ map_species      : chr [1:2] "h_sapiens" "r_norvegicus"
#>   ..@ gex              :'data.frame':    1 obs. of  1 variable:
#>   .. ..$ X0: num 0
#>   ..@ metric_type      : chr "CV_Species"
#>   ..@ metric           :'data.frame':    1 obs. of  1 variable:
#>   .. ..$ X0: num 0
```

*NOTE*: Any species you plan to compare must be specified in `map_species` AND `o_species`.

*NOTE*: The `getGEx` function requires that “Ensembl\_id” is included as an `output_id`. Here, we convert gene symbols into Ensembl IDs.

## 1.3 Use Cases with Monogenic Kidney Disease-Associated Genes

The following use cases provide running examples of CoSIA applications with [Natera’s Monogenic Kidney Disease Panel](https://www.natera.com/resource-library/renasight/385-genes-associated-with-monogenic-disorders-linked-to-kidney-disease). We will perform id conversion, obtain and visualize gene expression data, and calculate and visualize CV and DS of gene expression across three species (human, mouse, & rat) and two tissues (kidney & heart).

### 1.3.1 Use Case #1: Converting Gene Symbols to Ensembl IDs (`getConversion`)

CoSIA can convert input ids to any of the types listed in Table @ref(tab:Table1.).

```
CoSIAn_Obj_convert <- CoSIA::getConversion(CoSIAn_Obj)

head(CoSIA::viewCoSIAn(CoSIAn_Obj_convert, "converted_id"))
#> [[1]]
#>  [1] "SDCCAG8" "SDCCAG8" "TACO1"   "FANCA"   "BMP7"    "AP2S1"   "SCARB2"
#>  [8] "AQP2"    "XDH"     "PCBD1"   "AMN"     "PPP3CA"  "LMX1B"   "NPHS1"
#> [15] "EBP"     "SLX4"    "CYP11B2" "TTR"     "BICC1"   "OFD1"    "UCP3"
```

---

### 1.3.2 Use Case #2: Obtaining and visualizing curated non-diseased kidney and heart gene expression data for human, mouse, rat from Bgee

Now we will use the converted IDs with `getGEx` to obtain heart and kidney gene expression data for human, mouse and rat curated from Bgee.

```
CoSIAn_Obj_gex <- CoSIA::getGEx(CoSIAn_Obj_convert)

head(CoSIA::viewCoSIAn(CoSIAn_Obj_gex, "gex"), 5)
```

These data can be visualized with `plotSpeciesGEx` to plot expression of a single gene in a single tissue across species or `plotTissueGEx` to plot expression of a single gene in a single species across tissues.

Here we are plotting gene expression for the [TACO1](https://www.proteinatlas.org/ENSG00000136463-TACO1) gene in kidney tissue for human, mouse, and rat.

```
CoSIAn_Obj_gexplot <- CoSIA::plotSpeciesGEx(CoSIAn_Obj_gex, "adult mammalian kidney", "ENSG00000136463")

CoSIAn_Obj_gexplot
```

![Figure 3. Gene Expression of TACO1 in Kidney Across Selected Species](data:image/png;base64...)

CoSIA produces an interactive plot of expression values for TACO1 in kidney for human mouse and rat. Hovering over the plot displays sample-specific VST read count values. For file size compliance, we have included a static plot for this output.
*NOTE:* Expression values are not meant to be compared across species in this plot. The next two use cases demonstrate appropriate methods for comparing gene expression patterns across species.

---

### 1.3.3 Use Case #3: Gene expression variability across species for kidney tissue by calculating and visualizing median-based Coefficient of Variation (CV)

Calculating and visualizing median-based coefficient of variation allows for a relative comparison of gene expression variability between species. In CoSIA, CV is calculated as the standard deviation over the median using VST read count values. In the section [1.2.4](#initializing-a-cosian-object), we set `metric_type= "CV_Species"` to calculate CV for the monogenic kidney gene set across human and rat.

```
CoSIAn_Obj_CV <- CoSIA::getGExMetrics(CoSIAn_Obj_convert)

CoSIAn_Obj_CVplot <- CoSIA::plotCVGEx(CoSIAn_Obj_CV)

CoSIAn_Obj_CVplot
```

![Figure 4. Gene Expression Variability Across Species in Kidney Tissue](data:image/png;base64...)

Here we see relatively low variability in gene expression of most genes in rat and human, with the exception of relatively high levels of variation in `metric_type= "CV_Tissue"` displays the variability of gene expression for the monogenic gene set across selected, shared tissues.

---

### 1.3.4 Use Case #4: Gene expression diversity and specificity across tissues and species for monogenic kidney-disease associated genes

Diversity and specificity metrics are also suitable for comparing gene expression patterns across species. In CoSIA, diversity and specificity (based on Shannon’s entropy) are calculated using min-max scaled median VST values generated each gene in a tissue- and species-specific manner. Values are used to calculate diversity and specificity as in [Martínez & Reyes-Valdés, 2008](https://www.pnas.org/doi/10.1073/pnas.0803479105).

In the final use case, we are calculating and visualizing diversity and specificity for kidney and heart tissue across the monogenic kidney gene set by setting `metric_type= "DS_Tissue"`. There are additional metric\_types for the CoSIAn objects, view @ref(tab:Table2.) This example is not run, but the code and the resulting static output is included.

```
CoSIAn_Obj_DS <- CoSIA::CoSIAn(
    gene_set = unique(monogenic_kid_sample$Gene),
    i_species = "h_sapiens",
    o_species = c("h_sapiens", "r_norvegicus"),
    input_id = "Symbol",
    output_ids = "Ensembl_id",
    map_species = c("h_sapiens", "r_norvegicus"),
    map_tissues = c("adult mammalian kidney", "heart"),
    mapping_tool = "annotationDBI",
    ortholog_database = "HomoloGene",
    metric_type = "DS_Tissue"
)

CoSIAn_Obj_DS <- CoSIA::getConversion(CoSIAn_Obj_DS)

CoSIAn_Obj_DS <- CoSIA::getGExMetrics(CoSIAn_Obj_DS)

CoSIAn_Obj_DSplot <- CoSIA::plotDSGEx(CoSIAn_Obj_DS)

CoSIAn_Obj_DSplot
```

![Figure 5. Diversity vs Specificity of Genes in Geneset Across Anatomical Entity Names](data:image/png;base64...)

There is low specificity in kidney tissue, indicating there are more genes from the set that are expressed in kidney. We see higher specificity in heart tissue, indicating that there are fewer genes from the set that are expressed in heart.

(#tab:Table2.) CoSIA Metric Type options.

| Metric Type | Function |
| --- | --- |
| DS\_Gene | calculates diversity and specificity across genes in `gene_set` in the tissues listed in `map_tissue` |
| DS\_Gene\_all | calculates diversity and specificity across genes in `gene_set` in the all the available tissues in a species |
| DS\_Tissue | calculates diversity and specificity across tissues listed in `map_tissue` in the genes in `gene_set` |
| DS\_Tissue\_all | calculates diversity and specificity across tissues listed in `map_tissue` in the all the genes in a species |

Session info

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] CoSIAdata_1.10.0    CoSIA_1.10.1        ExperimentHub_3.0.0
#> [4] AnnotationHub_4.0.0 BiocFileCache_3.0.0 dbplyr_2.5.1
#> [7] BiocGenerics_0.56.0 generics_0.1.4      BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0           xfun_0.54
#>  [3] bslib_0.9.0               httr2_1.2.2
#>  [5] Biobase_2.70.0            vctrs_0.6.5
#>  [7] tools_4.5.2               stats4_4.5.2
#>  [9] curl_7.0.0                tibble_3.3.0
#> [11] AnnotationDbi_1.72.0      RSQLite_2.4.5
#> [13] blob_1.2.4                pkgconfig_2.0.3
#> [15] homologene_1.4.68.19.3.27 S4Vectors_0.48.0
#> [17] lifecycle_1.0.4           compiler_4.5.2
#> [19] Biostrings_2.78.0         Seqinfo_1.0.0
#> [21] htmltools_0.5.9           sass_0.4.10
#> [23] yaml_2.3.12               pillar_1.11.1
#> [25] crayon_1.5.3              jquerylib_0.1.4
#> [27] cachem_1.1.0              org.Hs.eg.db_3.22.0
#> [29] tidyselect_1.2.1          digest_0.6.39
#> [31] dplyr_1.1.4               purrr_1.2.0
#> [33] bookdown_0.46             BiocVersion_3.22.0
#> [35] fastmap_1.2.0             cli_3.6.5
#> [37] org.Rn.eg.db_3.22.0       magrittr_2.0.4
#> [39] utf8_1.2.6                withr_3.0.2
#> [41] filelock_1.0.3            rappdirs_0.3.3
#> [43] bit64_4.6.0-1             rmarkdown_2.30
#> [45] XVector_0.50.0            httr_1.4.7
#> [47] bit_4.6.0                 otel_0.2.0
#> [49] png_0.1-8                 memoise_2.0.1
#> [51] evaluate_1.0.5            knitr_1.50
#> [53] IRanges_2.44.0            annotationTools_1.84.0
#> [55] rlang_1.1.6               glue_1.8.0
#> [57] DBI_1.2.3                 BiocManager_1.30.27
#> [59] jsonlite_2.0.0            R6_2.6.1
```