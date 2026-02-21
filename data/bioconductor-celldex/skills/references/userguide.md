# Pokédex for Cell Types

Aaron Lun\*, Jared M. Andrews1, Friederike Dündar2 and Daniel Bunis3

1Washington University in St. Louis, School of Medicine, St. Louis, MO, USA
2Applied Bioinformatics Core, Weill Cornell Medicine
3Bakar Computational Health Sciences Institute, University of California San Francisco, San Francisco, CA

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: February 29, 2024

#### Package

celldex 1.20.0

# 1 Overview

The *[celldex](https://bioconductor.org/packages/3.22/celldex)* package provides convenient access to several cell type reference datasets.
Most of these references are derived from bulk RNA-seq or microarray data of cell populations
that (hopefully) consist of a pure cell type after sorting and/or culturing.
The aim is to provide a common resource for further analysis like cell type annotation of single cell expression data
or deconvolution of cell type proportions in bulk expression datasets.

Each dataset contains a log-normalized expression matrix that is intended to be comparable
to log-UMI counts from common single-cell protocols (Aran et al. [2019](#ref-aran2019reference))
or gene length-adjusted values from bulk datasets.
By default, gene annotation is returned in terms of gene symbols,
but they can be coerced to Ensembl annotation with `ensembl=TRUE` for more robust cross-referencing across studies.

Typically, each reference provides three levels of cell type annotation in its column metadata:

* `label.main`, broad annotation that defines the major cell types.
  This has few unique levels that allows for fast annotation but at low resolution.
* `label.fine`, fine-grained annotation that defines subtypes or states.
  This has more unique levels that results in slower annotation but at much higher resolution.
* `label.ont`, fine-grained annotation mapped to the standard vocabulary in the [Cell Ontology](https://www.ebi.ac.uk/ols/ontologies/cl).
  This enables synchronization of labels across references as well as dynamic adjustment of the resolution.

# 2 Finding references

We can examine the available references using the `surveyReferences()` function.
This returns a `DataFrame` of the reference’s name and version,
along with additional information like the title, description, species, number of samples, available labels, and so on.

```
library(celldex)
surveyReferences()
```

```
## DataFrame with 7 rows and 10 columns
##                     name     version        path                  title
##              <character> <character> <character>            <character>
## 1                   dice  2024-02-26          NA Human bulk RNA-seq d..
## 2       blueprint_encode  2024-02-26          NA Human bulk RNA-seq d..
## 3                 immgen  2024-02-26          NA Mouse microarray exp..
## 4           mouse_rnaseq  2024-02-26          NA Bulk RNA-seq data of..
## 5                   hpca  2024-02-26          NA Microarray data from..
## 6 novershtern_hematopo..  2024-02-26          NA Bulk microarray expr..
## 7          monaco_immune  2024-02-26          NA Human bulk RNA-seq d..
##              description taxonomy_id  genome   samples
##              <character>      <List>  <List> <integer>
## 1 Human bulk RNA-seq d..        9606              1561
## 2 Human bulk RNA-seq d..        9606               259
## 3 Mouse microarray exp..       10090               830
## 4 Bulk RNA-seq data of..       10090 MGSCv37       358
## 5 Microarray data from..        9606               713
## 6 Bulk microarray expr..        9606               211
## 7 Human bulk RNA-seq d..        9606  GRCh38       114
##                            labels
##                            <List>
## 1 label.main,label.fine,label.ont
## 2 label.main,label.fine,label.ont
## 3 label.main,label.fine,label.ont
## 4 label.main,label.fine,label.ont
## 5 label.main,label.fine,label.ont
## 6 label.main,label.fine,label.ont
## 7 label.main,label.fine,label.ont
##                                                                                sources
##                                                                   <SplitDataFrameList>
## 1                   PubMed:30449622:NA,ExperimentHub:EH3488:NA,ExperimentHub:EH3489:NA
## 2                             PubMed:22955616:NA,PubMed:24091925:NA,PubMed:30643263:NA
## 3                                   PubMed:18800157:NA,GEO:GSE15907:NA,GEO:GSE37448:NA
## 4                  PubMed:30858345:NA,URL:https://github.com/B..:NA,PubMed:30643263:NA
## 5 PubMed:24053356:NA,PubMed:30643263:NA,GitHub:dviraran/SingleR:adc4a0e4d5cfa79db18f..
## 6                           PubMed:21241896:NA,GEO:GSE24759:NA,ExperimentHub:EH3490:NA
## 7                          PubMed:30726743:NA,GEO:GSE107011:NA,ExperimentHub:EH3496:NA
```

Alternatively, users can search the text of each reference’s metadata to identify relevant datasets.
This may require some experimentation as it depends on the level of detail in the metadata supplied by the uploader.

```
searchReferences("B cell")
```

```
## DataFrame with 4 rows and 10 columns
##                     name     version        path                  title
##              <character> <character> <character>            <character>
## 1                   dice  2024-02-26          NA Human bulk RNA-seq d..
## 2           mouse_rnaseq  2024-02-26          NA Bulk RNA-seq data of..
## 3 novershtern_hematopo..  2024-02-26          NA Bulk microarray expr..
## 4          monaco_immune  2024-02-26          NA Human bulk RNA-seq d..
##              description taxonomy_id  genome   samples
##              <character>      <List>  <List> <integer>
## 1 Human bulk RNA-seq d..        9606              1561
## 2 Bulk RNA-seq data of..       10090 MGSCv37       358
## 3 Bulk microarray expr..        9606               211
## 4 Human bulk RNA-seq d..        9606  GRCh38       114
##                            labels
##                            <List>
## 1 label.main,label.fine,label.ont
## 2 label.main,label.fine,label.ont
## 3 label.main,label.fine,label.ont
## 4 label.main,label.fine,label.ont
##                                                               sources
##                                                  <SplitDataFrameList>
## 1  PubMed:30449622:NA,ExperimentHub:EH3488:NA,ExperimentHub:EH3489:NA
## 2 PubMed:30858345:NA,URL:https://github.com/B..:NA,PubMed:30643263:NA
## 3          PubMed:21241896:NA,GEO:GSE24759:NA,ExperimentHub:EH3490:NA
## 4         PubMed:30726743:NA,GEO:GSE107011:NA,ExperimentHub:EH3496:NA
```

```
searchReferences(
    defineTextQuery("immun%", partial=TRUE) &
    defineTextQuery("10090", field="taxonomy_id")
)
```

```
## DataFrame with 1 row and 10 columns
##          name     version        path                  title
##   <character> <character> <character>            <character>
## 1      immgen  2024-02-26          NA Mouse microarray exp..
##              description taxonomy_id genome   samples
##              <character>      <List> <List> <integer>
## 1 Mouse microarray exp..       10090              830
##                            labels
##                            <List>
## 1 label.main,label.fine,label.ont
##                                              sources
##                                 <SplitDataFrameList>
## 1 PubMed:18800157:NA,GEO:GSE15907:NA,GEO:GSE37448:NA
```

Keep in mind that the search results are not guaranteed to be reproducible -
more datasets may be added over time, and existing datasets may be updated with new versions.
Once a dataset of interest is identified, users should explicitly list the name and version of the dataset in their scripts to ensure reproducibility.

# 3 General-purpose references

## 3.1 Human primary cell atlas (HPCA)

The HPCA reference consists of publicly available microarray datasets derived from human primary cells (Mabbott et al. [2013](#ref-hpcaRef)).
Most of the labels refer to blood subpopulations but cell types from other tissues are also available.

```
library(celldex)
ref <- fetchReference("hpca", "2024-02-26")
```

---

This reference also contains many cells and cell lines that have been treated or collected from pathogenic conditions.

## 3.2 Blueprint/ENCODE

The Blueprint/ENCODE reference consists of bulk RNA-seq data for pure stroma and immune cells
generated by Blueprint (Martens and Stunnenberg [2013](#ref-blueprintRef)) and ENCODE projects (The ENCODE Project Consortium [2012](#ref-encodeRef)).

```
ref <- fetchReference("blueprint_encode", "2024-02-26")
```

---

This reference is best suited to mixed samples that do not require fine resolution,
and is particularly suited for situations where easily interpretable labels are required quickly.
It provides decent immune cell granularity, though it does not contain finer monocyte and dendritic cell subtypes.

## 3.3 Mouse RNA-seq

This reference consists of a collection of mouse bulk RNA-seq data sets downloaded from the gene expression omnibus (Benayoun et al. [2019](#ref-Benayoun2019)).
A variety of cell types are available, again mostly from blood but also covering several other tissues.

```
ref <- fetchReference("mouse_rnaseq", "2024-02-26")
```

---

This reference is best suited to bulk tissue samples from brain, blood, or heart where low-resolution labels are adequate.

# 4 Immune references

## 4.1 Immunological Genome Project (ImmGen)

The ImmGen reference consists of microarray profiles of pure mouse immune cells from
the [project of the same name](http://www.immgen.org/) (Heng et al. [2008](#ref-ImmGenRef)).
This is currently the most highly resolved immune reference -
possibly overwhelmingly so, given the granularity of the fine labels.

```
ref <- fetchReference("immgen", "2024-02-26")
```

---

This reference provides exhaustive coverage of a dizzying number of cell subtypes.
However, this can be a double-edged sword as the high resolution can be difficult to interpret,
especially for samples derived from experimental conditions that are not of interest.
Users may want to remove certain samples themselves depending on the use case.

## 4.2 Database of Immune Cell Expression/eQTLs/Epigenomics (DICE)

The DICE reference consists of bulk RNA-seq samples of sorted cell populations
from the [project of the same name](https://dice-database.org) (Schmiedel et al. [2018](#ref-diceRef)).

```
ref <- fetchReference("dice", "2024-02-26")
```

---

This reference is particularly useful to those interested in CD4+ T cell subsets,
though the lack of CD4+ central memory and effector memory samples may decrease accuracy in some cases.
In addition, the lack of dendritic cells and a single B cell subset may result in those populations being improperly labeled or having their label pruned in a typical PBMC sample.

## 4.3 Novershtern hematopoietic data

The Novershtern reference (previously known as Differentiation Map)
consists of microarray datasets for sorted hematopoietic cell populations
from [GSE24759](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE24759) (Novershtern et al. [2011](#ref-dmapRef)).

```
ref <- fetchReference("novershtern_hematopoietic", "2024-02-26")
```

This reference provides the greatest resolution for myeloid and progenitor cells among the human immune references.
It has fewer T cell subsets than the other immune references but contains many more NK, erythroid, and granulocytic subsets.
It is likely the best option for bone marrow samples.

## 4.4 Monaco immune data

The Monaco reference consists of bulk RNA-seq samples of sorted immune cell populations
from [GSE107011](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE107011) (Monaco et al. [2019](#ref-monaco_immuneRef)).

```
ref <- fetchReference("monaco_immune", "2024-02-26")
```

This is the human immune reference that best covers all of the bases for a typical PBMC sample.
It provides expansive B and T cell subsets, differentiates between classical and non-classical monocytes, includes basic dendritic cell subsets, and also includes neutrophil and basophil samples to help identify small contaminating populations that may have slipped into a PBMC preparation.

# 5 Adding new references

Want to contribute your own reference dataset to this package?
It’s easy!
Just follow these simple steps for instant fame and prestige.

1. Obtain log-normalized expression values and cell type labels.
   While not strictly required, we recommend trying to organize the labels into `label.fine`, `label.main` and `label.ont`,
   so that users have a consistent experience with your reference.
   Let’s just make up something here.

   ```
   norm <- matrix(runif(1000), ncol=20)
   rownames(norm) <- sprintf("GENE_%i", seq_len(nrow(norm)))

   labels <- DataFrame(label.main=rep(LETTERS[1:5], each=4))
   labels$label.fine <- sprintf("%s%i", labels$label.main, rep(c(1, 1, 2, 2), 5))
   labels$label.ont <- sprintf("CL:000%i", rep(1:5, each=4))
   ```
2. Assemble the metadata for your dataset.
   This should be a list structured as specified in the [Bioconductor metadata schema](https://artifactdb.github.io/bioconductor-metadata-index/bioconductor/v1.json).
   Check out some examples from `fetchMetadata()` - note that the `application.takane` property will be automatically added later, and so can be omitted from the list that you create.

   ```
   meta <- list(
       title="My reference",
       description="This is my reference dataset",
       taxonomy_id="10090",
       genome="GRCh38",
       sources=list(
           list(provider="GEO", id="GSE12345"),
           list(provider="PubMed", id="1234567")
       ),
       maintainer_name="Chihaya Kisaragi",
       maintainer_email="kisaragi.chihaya@765pro.com"
   )
   ```
3. Save your normalized expression matrix and labels to disk with `saveReference()`.
   This saves the dataset into a “staging directory” using language-agnostic file formats - check out the [**alabaster**](https://github.com/ArtifactDB/alabaster.base) framework for more details.
   In more complex cases involving multiple datasets, users may save each dataset into a subdirectory of the staging directory.

   ```
   # Simple case: you only have one dataset to upload.
   staging <- tempfile()
   saveReference(norm, labels, staging, meta)
   list.files(staging, recursive=TRUE)
   ```

   ```
   ##  [1] "OBJECT"                       "_bioconductor.json"
   ##  [3] "_environment.json"            "assays/0/OBJECT"
   ##  [5] "assays/0/array.h5"            "assays/names.json"
   ##  [7] "column_data/OBJECT"           "column_data/basic_columns.h5"
   ##  [9] "row_data/OBJECT"              "row_data/basic_columns.h5"
   ```

   ```
   # Complex case: you have multiple subdatasets to upload.
   staging <- tempfile()
   dir.create(staging)
   saveReference(norm, labels, file.path(staging, "foo"), meta)
   saveReference(norm, labels, file.path(staging, "bar"), meta) # and so on.
   ```

   You can check that everything was correctly saved by reloading the on-disk data into the R session for inspection.
   This yields a `SummarizedExperiment` with the log-expression matrix in the assay named `"logcounts"`.

   ```
   alabaster.base::readObject(file.path(staging, "foo"))
   ```

   ```
   ## class: SummarizedExperiment
   ## dim: 50 20
   ## metadata(0):
   ## assays(1): logcounts
   ## rownames(50): GENE_1 GENE_2 ... GENE_49 GENE_50
   ## rowData names(0):
   ## colnames: NULL
   ## colData names(3): label.main label.fine label.ont
   ```
4. Open a [pull request (PR)](https://github.com/LTLA/scRNAseq/pulls) for the addition of a new reference.
   You will need to provide a few things here:

   * The name of your dataset.
     This should be short enough to type yet distinct from the existing references.
   * The version of your dataset.
     This is usually just the current date… or whenever you started putting together the dataset for upload.
     The exact date doesn’t really matter as long as we can establish a timeline for later versions.
   * The code used to assemble the reference dataset as an Rmarkdown file.
     This should be added to the [`scripts/`](https://github.com/LTLA/celldex/tree/master/scripts) directory of this package,
     in order to provide some record of how the dataset was created.
5. Wait for us to grant temporary upload permissions to your GitHub account.
6. Upload your staging directory to [**gypsum** backend](https://github.com/ArtifactDB/gypsum-worker) with `gypsum::uploadDirectory()`.
   On the first call to this function, it will automatically prompt you to log into GitHub so that the backend can authenticate you.
   If you are on a system without browser access (e.g., most computing clusters), a [token](https://github.com/settings/tokens) can be manually supplied via `gypsum::setAccessToken()`.

   ```
   gypsum::uploadDirectory(staging, "celldex", "my_dataset_name", "my_version")
   ```

   You can check that everything was successfully uploaded by just calling `fetchReference()`:

   ```
   fetchReference("my_dataset_name", "my_version")
   ```

   If you realized you made a mistake, no worries.
   Use the following call to clear the erroneous dataset, and try again:

   ```
   gypsum::rejectProbation("scRNAseq", "my_dataset_name", "my_version")
   ```
7. Comment on the PR to notify us that the dataset has finished uploading and you’re happy with it.
   We’ll review it and make sure everything’s in order.
   If some fixes are required, we’ll just clear the dataset so that you can upload a new version with the necessary changes.
   Otherwise, we’ll approve the dataset.
   Note that once a version of a dataset is approved, no further changes can be made to that version;
   you’ll have to upload a new version if you want to modify something.

# Session information

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] celldex_1.20.0              SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1          jsonvalidate_1.5.0
##  [3] alabaster.se_1.10.0       dplyr_1.1.4
##  [5] blob_1.2.4                filelock_1.0.3
##  [7] Biostrings_2.78.0         fastmap_1.2.0
##  [9] BiocFileCache_3.0.0       digest_0.6.37
## [11] lifecycle_1.0.4           alabaster.matrix_1.10.0
## [13] KEGGREST_1.50.0           alabaster.base_1.10.0
## [15] RSQLite_2.4.3             magrittr_2.0.4
## [17] compiler_4.5.1            rlang_1.1.6
## [19] sass_0.4.10               tools_4.5.1
## [21] yaml_2.3.10               knitr_1.50
## [23] S4Arrays_1.10.0           htmlwidgets_1.6.4
## [25] bit_4.6.0                 curl_7.0.0
## [27] DelayedArray_0.36.0       abind_1.4-8
## [29] HDF5Array_1.38.0          gypsum_1.6.0
## [31] grid_4.5.1                ExperimentHub_3.0.0
## [33] Rhdf5lib_1.32.0           cli_3.6.5
## [35] rmarkdown_2.30            crayon_1.5.3
## [37] httr_1.4.7                DelayedMatrixStats_1.32.0
## [39] DBI_1.2.3                 cachem_1.1.0
## [41] rhdf5_2.54.0              parallel_4.5.1
## [43] AnnotationDbi_1.72.0      BiocManager_1.30.26
## [45] XVector_0.50.0            alabaster.schemas_1.10.0
## [47] vctrs_0.6.5               V8_8.0.1
## [49] Matrix_1.7-4              jsonlite_2.0.0
## [51] bookdown_0.45             bit64_4.6.0-1
## [53] alabaster.ranges_1.10.0   crosstalk_1.2.2
## [55] h5mread_1.2.0             jquerylib_0.1.4
## [57] glue_1.8.0                DT_0.34.0
## [59] BiocVersion_3.22.0        tibble_3.3.0
## [61] pillar_1.11.1             rappdirs_0.3.3
## [63] htmltools_0.5.8.1         rhdf5filters_1.22.0
## [65] R6_2.6.1                  dbplyr_2.5.1
## [67] httr2_1.2.1               sparseMatrixStats_1.22.0
## [69] evaluate_1.0.5            lattice_0.22-7
## [71] AnnotationHub_4.0.0       png_0.1-8
## [73] memoise_2.0.1             bslib_0.9.0
## [75] Rcpp_1.1.0                SparseArray_1.10.1
## [77] xfun_0.54                 pkgconfig_2.0.3
```

# References

Aran, D., A. P. Looney, L. Liu, E. Wu, V. Fong, A. Hsu, S. Chak, et al. 2019. “Reference-based analysis of lung single-cell sequencing reveals a transitional profibrotic macrophage.” *Nat. Immunol.* 20 (2): 163–72.

Benayoun, Bérénice A., Elizabeth A. Pollina, Param Priya Singh, Salah Mahmoudi, Itamar Harel, Kerriann M. Casey, Ben W. Dulken, Anshul Kundaje, and Anne Brunet. 2019. “Remodeling of epigenome and transcriptome landscapes with aging in mice reveals widespread induction of inflammatory responses.” *Genome Research* 29: 697–709. <https://doi.org/10.1101/gr.240093.118>.

Heng, Tracy S. P., Michio W. Painter, Kutlu Elpek, Veronika Lukacs-Kornek, Nora Mauermann, Shannon J. Turley, Daphne Koller, et al. 2008. “The immunological genome project: Networks of gene expression in immune cells.” *Nature Immunology* 9 (10): 1091–4. <https://doi.org/10.1038/ni1008-1091>.

Mabbott, Neil A., J. K. Baillie, Helen Brown, Tom C. Freeman, and David A. Hume. 2013. “An expression atlas of human primary cells: Inference of gene function from coexpression networks.” *BMC Genomics* 14. <https://doi.org/10.1186/1471-2164-14-632>.

Martens, Joost H A, and Hendrik G. Stunnenberg. 2013. “BLUEPRINT: Mapping human blood cell epigenomes.” *Haematologica* 98: 1487–9. <https://doi.org/10.3324/haematol.2013.094243>.

Monaco, Gianni, Bernett Lee, Weili Xu, Seri Mustafah, You Yi Hwang, Christophe Carré, Nicolas Burdin, et al. 2019. “RNA-Seq Signatures Normalized by mRNA Abundance Allow Absolute Deconvolution of Human Immune Cell Types.” *Cell Reports* 26 (6): 1627–1640.e7. <https://doi.org/10.1016/j.celrep.2019.01.041>.

Novershtern, Noa, Aravind Subramanian, Lee N. Lawton, Raymond H. Mak, W. Nicholas Haining, Marie E. McConkey, Naomi Habib, et al. 2011. “Densely Interconnected Transcriptional Circuits Control Cell States in Human Hematopoiesis.” *Cell* 144 (2): 296–309. <https://doi.org/10.1016/j.cell.2011.01.004>.

Schmiedel, Benjamin J., Divya Singh, Ariel Madrigal, Alan G. Valdovino-Gonzalez, Brandie M. White, Jose Zapardiel-Gonzalo, Brendan Ha, et al. 2018. “Impact of Genetic Polymorphisms on Human Immune Cell Gene Expression.” *Cell* 175 (6): 1701–1715.e16. <https://doi.org/10.1016/j.cell.2018.10.022>.

The ENCODE Project Consortium. 2012. “An integrated encyclopedia of DNA elements in the human genome.” *Nature*. <https://doi.org/10.1038/nature11247>.