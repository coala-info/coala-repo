# celarefData

#### Sarah Williams

#### 2025-10-30

* [Overview](#overview)
* [Data](#data)
  + [Dataset : Farmer et al 2017, Mouse lacrimal gland](#dataset-farmer-et-al-2017-mouse-lacrimal-gland)
  + [Dataset : Watkins et al 2009, PBMC microarrays](#dataset-watkins-et-al-2009-pbmc-microarrays)
  + [Dataset : 10X genomics, pbmc4k, k=7](#dataset-10x-genomics-pbmc4k-k7)
  + [Dataset : Zeisel et al 2015, Mouse brain](#dataset-zeisel-et-al-2015-mouse-brain)
  + [Dataset : Zheng et al 2017, Pure PBMCs](#dataset-zheng-et-al-2017-pure-pbmcs)
* [Use](#use)
* [References](#references)

# Overview

The celarefData package is a repository of a few public datasets that have been processed using the *celaref* package. This includes some example data for the *celaref* package vignette (please refer to full examples there), and some other potentially useful preprocessed reference datasets.

# Data

The data in this package is a series of data frames output from the *contrast\_each\_group\_to\_the\_rest* function of the *celaref* package. That is, these are differential experession results (calculated using MAST Finak et al. (2015)), of each cell cluster versus the rest of the experiment.

For details and explanation see the celaref package vignette. The commands used to make these data files are also in the make-data.R file of this package.

### Dataset : Farmer et al 2017, Mouse lacrimal gland

Farmer et al. (2017) have published a survey of cell types in the mouse lacrimal gland at two developmental stages in paper (*Defining epithelial cell dynamics and lineage relationships in the developing lacrimal gland*). Only the more mature P4 timepoint is included.

Data:

* Farmer2017\_lacrimalP4

### Dataset : Watkins et al 2009, PBMC microarrays

The (‘Watkins2009’) ‘HaemAtlas’ (Watkins et al. 2009) microarray dataset of purified PBMC cell types was downloaded as a normalised table from the ‘haemosphere’ website: <http://haemosphere.org/datasets/show> (Graaf et al. 2016)

Processing for those data files via *contrast\_each\_group\_to\_the\_rest\_for\_norm\_ma\_with\_limma* is described in the vignette.

Data:

* de\_table\_Watkins2009\_pbmcs

### Dataset : 10X genomics, pbmc4k, k=7

10X genomics has several datasets available to download from their website, including the pbmc4k dataset, which contains PBMCs derived from a healthy individual. The kmeans k=7 cell-cluster assignments were chosen. Source dataset available here: (<https://support.10xgenomics.com/single-cell-gene-expression/datasets/2.1.0/pbmc4k>)

Data:

* de\_table\_10X\_pbmc4k\_k7

### Dataset : Zeisel et al 2015, Mouse brain

In their paper ‘Cell types in the mouse cortex and hippocampus revealed by single-cell RNA-seq’, Zeisel et al. (2015) performed single cell RNA sequencing in mouse, in two tissues (sscortex and ca1hippocampus).

This data was download from the link provided in the paper: <http://linnarssonlab.org/cortex>

As described in make-data.R, both counts and cell annotations were parsed from this file: <https://storage.googleapis.com/linnarsson-lab-www-blobs/blobs/cortex/expression_mRNA_17-Aug-2014.txt>

Data:

* de\_table\_Zeisel2015\_cortex
* de\_table\_Zeisel2015\_hc

### Dataset : Zheng et al 2017, Pure PBMCs

As part of their analysis described in *‘Massively parallel digital transcriptional profiling of single cells’*, Zheng et al generated a reference dataset of PBMC (peripheral blood mononuclear cell) sub-populations (Zheng et al. 2017). These cell types are:

* CD34+
* CD56+ NK
* CD4+/CD45RA+/CD25- Naive T
* CD4+/CD25 T Reg
* CD8+/CD45RA+ Naive Cytotoxic
* CD4+/CD45RO+ Memory
* CD8+ Cytotoxic T
* CD19+ B
* CD4+ T Helper2
* CD14+ Monocyte
* Dendritic

They used a bead-based purification approach described in their paper, followed by the analysis which they have shared at <https://github.com/10XGenomics/single-cell-3prime-paper/tree/master/pbmc68k_analysis>

---

To create the derived differential expression tables suitable for using as a reference dataset with celaref.

1. Data and scripts obtained from <https://github.com/10XGenomics/single-cell-3prime-paper/tree/master/pbmc68k_analysis>
2. Cell cluster labels were obtained by the (rather nicely reproduceable) analysis scripts (specifically ‘main\_process\_pure\_pbmc.R’ ) also provided by Zheng et al at: <https://github.com/10XGenomics/single-cell-3prime-paper/tree/master/pbmc68k_analysis>
3. Cells were subsetted to a *maximum of 1000 per group* - enough for the differential expression for this puropose.
4. Gene-level ID was set to the GeneSymbol, choosing the more highly expressed ensemblID if multiple mappings exist. The *de\_table\_Zheng2017purePBMC* dataset has GeneSymbol IDs, wherease *de\_table\_Zheng2017purePBMC\_ensembl* was converted back to ensemble IDs.

Exact commands are provided in celarefData make-data.R script.

# Use

```
library(ExperimentHub)
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
eh = ExperimentHub()
ExperimentHub::listResources(eh, "celarefData")
```

```
## [1] "de_table_10X_pbmc4k_k7"             "de_table_Watkins2009_pbmcs"
## [3] "de_table_Zeisel2015_cortex"         "de_table_Zeisel2015_hc"
## [5] "de_table_Farmer2017_lacrimalP4"     "de_table_Zheng2017purePBMC"
## [7] "de_table_Zheng2017purePBMC_ensembl"
```

```
de_table.10X_pbmc4k_k7        <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_10X_pbmc4k_k7')[[1]]
```

```
## see ?celarefData and browseVignettes('celarefData') for documentation
```

```
## loading from cache
```

```
de_table.Watkins2009PBMCs     <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Watkins2009_pbmcs')[[1]]
```

```
## see ?celarefData and browseVignettes('celarefData') for documentation
## loading from cache
```

```
de_table.zeisel.cortex        <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Zeisel2015_cortex')[[1]]
```

```
## see ?celarefData and browseVignettes('celarefData') for documentation
## loading from cache
```

```
de_table.zeisel.hippo         <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Zeisel2015_hc')[[1]]
```

```
## see ?celarefData and browseVignettes('celarefData') for documentation
## loading from cache
```

```
de_table.Farmer2017lacrimalP4 <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Farmer2017_lacrimalP4')[[1]]
```

```
## see ?celarefData and browseVignettes('celarefData') for documentation
## loading from cache
```

```
de_table.Zheng2017purePBMC         <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Zheng2017purePBMC')[[1]]
```

```
## see ?celarefData and browseVignettes('celarefData') for documentation
## loading from cache
```

```
## see ?celarefData and browseVignettes('celarefData') for documentation
```

```
## loading from cache
```

```
de_table.Zheng2017purePBMC_ensembl <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Zheng2017purePBMC_ensembl')[[1]]
```

```
## see ?celarefData and browseVignettes('celarefData') for documentation
## loading from cache
```

```
head(de_table.10X_pbmc4k_k7)
```

```
##      ID      ensembl_ID GeneSymbol total_count          pval   log2FC ci_inner
## 1  TRAC ENSG00000277734       TRAC       11252  0.000000e+00 1.609764 1.553279
## 2  LDHB ENSG00000111716       LDHB       10039  0.000000e+00 1.410714 1.366698
## 3   LTB ENSG00000227507        LTB       21543 2.595127e-262 1.383209 1.310434
## 4 RPS29 ENSG00000213741      RPS29      145084  0.000000e+00 1.216305 1.174395
## 5  IL32 ENSG00000008517       IL32       14403 3.342627e-214 1.243103 1.169736
## 6  CD3D ENSG00000167286       CD3D        7808  0.000000e+00 1.219050 1.167091
##   ci_outer           fdr group  sig sig_up gene_count rank rescaled_rank
## 1 1.666249  0.000000e+00     1 TRUE   TRUE      15407    1  6.490556e-05
## 2 1.454730  0.000000e+00     1 TRUE   TRUE      15407    2  1.298111e-04
## 3 1.455983 5.631425e-260     1 TRUE   TRUE      15407    3  1.947167e-04
## 4 1.258216  0.000000e+00     1 TRUE   TRUE      15407    4  2.596222e-04
## 5 1.316471 6.058806e-212     1 TRUE   TRUE      15407    5  3.245278e-04
## 6 1.271010  0.000000e+00     1 TRUE   TRUE      15407    6  3.894334e-04
##         dataset
## 1 10X_pbmc4k_k7
## 2 10X_pbmc4k_k7
## 3 10X_pbmc4k_k7
## 4 10X_pbmc4k_k7
## 5 10X_pbmc4k_k7
## 6 10X_pbmc4k_k7
```

# References

Farmer, D’Juan T., Sara Nathan, Jennifer K. Finley, Kevin Shengyang Yu, Elaine Emmerson, Lauren E. Byrnes, Julie B. Sneddon, Michael T. McManus, Aaron D. Tward, and Sarah M. Knox. 2017. “Defining epithelial cell dynamics and lineage relationships in the developing lacrimal gland.” *Development* 144 (13): 2517–28. <https://doi.org/10.1242/dev.150789>.

Finak, Greg, Andrew McDavid, Masanao Yajima, Jingyuan Deng, Vivian Gersuk, Alex K. Shalek, Chloe K. Slichter, et al. 2015. “MAST: A flexible statistical framework for assessing transcriptional changes and characterizing heterogeneity in single-cell RNA sequencing data.” *Genome Biology* 16 (1): 1–13. <https://doi.org/10.1186/s13059-015-0844-5>.

Graaf, Carolyn A. de, Jarny Choi, Tracey M. Baldwin, Jessica E. Bolden, Kirsten A. Fairfax, Aaron J. Robinson, Christine Biben, et al. 2016. “Haemopedia: An Expression Atlas of Murine Hematopoietic Cells.” *Stem Cell Reports* 7 (3): 571–82. <https://doi.org/10.1016/j.stemcr.2016.07.007>.

Watkins, Nicholas a, Arief Gusnanto, Bernard de Bono, Subhajyoti De, Diego Miranda-Saavedra, Debbie L Hardie, Will G J Angenent, et al. 2009. “A HaemAtlas: characterizing gene expression in differentiated human blood cells.” *Blood* 113 (19): e1–9. <https://doi.org/10.1182/blood-2008-06-162958>.

Zeisel, A., A. B. M. Manchado, S. Codeluppi, P. Lonnerberg, G. La Manno, A. Jureus, S. Marques, et al. 2015. “Cell types in the mouse cortex and hippocampus revealed by single-cell RNA-seq.” *Science* 347 (6226): 1138–42. <https://doi.org/10.1126/science.aaa1934>.

Zheng, Grace X. Y., Jessica M. Terry, Phillip Belgrader, Paul Ryvkin, Zachary W. Bent, Ryan Wilson, Solongo B. Ziraldo, et al. 2017. “Massively parallel digital transcriptional profiling of single cells.” *Nature Communications* 8: 1–12. <https://doi.org/10.1038/ncomms14049>.