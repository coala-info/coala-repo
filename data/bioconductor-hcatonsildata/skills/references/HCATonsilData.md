# HCATonsilData

Ramon Massoni-Badosa, Federico Marini, Alan O'Callaghan & Helena Crowell

#### 4 November 2025

# 1 Introduction

Palatine tonsils are under constant exposure to antigens via the upper
respiratory tract, which makes them a compelling model secondary lymphoid organ
(SLO) to study the interplay between innate and adaptive immune cells
(Ruddle and Akirav [2009](#ref-ruddle2009secondary)). Tonsils have a non-keratinizing stratified squamous
epithelium, organized into tubular, branched crypts that enlarge the tonsillar
surface. Within the crypts, microfold cells (or M cells) sample antigens at
their apical membrane. Subsequently, antigen presenting cells (APC), such as
dendritic cells (DC), process and present antigens to T cells in the
interfollicular or T cell zone. Alternatively, antigens are kept intact by
follicular dendritic cells (FDC) in lymphoid follicles, where they are
recognized by B cells (Nave, Gebert, and Pabst [2001](#ref-nave2001morphology)). Such recognition triggers the
GC reaction, whereby naive B cells (NBC) undergo clonal selection,
proliferation, somatic hypermutation, class switch recombination (CSR) and
differentiation into long-lived plasma cells (PC) or memory B cells (MBC)
(De Silva and Klein [2015](#ref-de2015dynamics)).

In the context of the Human Cell Atlas (HCA) (Regev et al. [2018](#ref-regev2018human)), we have created
a taxonomy of 121 cell types and states in a human tonsil. Since the transcriptome
is just a snapshot of a cell’s state (Wagner, Regev, and Yosef [2016](#ref-wagner2016revealing)), we have added other
layers to define cell identity: single-cell resolved open chromatin epigenomic
landscapes (scATAC-seq and scRNA/ATAC-seq; i.e. Multiome) as well as protein
(CITE-seq), adaptive repertoire (single-cell B and T cell receptor sequencing;
i.e. scBCR-seq and scTCR-seq) and spatial transcriptomics (ST) profiles.

The HCATonsilData package aims to provide programmatic and modular access to the
datasets of the different modalities and cell types of the tonsil atlas.
HCATonsilData also documents how the dataset was generated and archived in
different repositories, from raw fastq files to processed datasets. It also
explains in detail the cell- and sample-level metadata, and allows users to
traceback the annotation of each cell type through detailed Glossary.

# 2 Installation

HCATonsilData is available in BioConductor and can be installed as follows:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("HCATonsilData")
```

Load the necessary packages in R:

```
library("HCATonsilData")
library("SingleCellExperiment")
library("ExperimentHub")
library("scater")
library("ggplot2")
library("knitr")
library("kableExtra")
library("htmltools")
```

# 3 Overview of the dataset

We obtained a total of 17 human tonsils, which covered three age groups:
children (n=6, 3-5 years), young adults (n=8, 19-35 years), and old adults
(n=3, 56-65 years). We collected them in a discovery cohort (n=10), which we
used to cluster and annotate cell types; and a validation cohort (n=7),
which we used to validate the presence, annotation and markers of the discovered
cell types. The following table corresponds to the donor-level metadata:

```
data("donor_metadata")

kable(
  donor_metadata,
  format = "markdown",
  caption = "Donor Metadata",
  align = "c"
) |> kable_styling(full_width = FALSE)
```

Table 1: Table 2: Donor Metadata

|  | donor\_id | hospital | sex | age | age\_group | cause\_for\_tonsillectomy | cohort\_type | comments |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| BCLL-2-T | BCLL-2-T | Clinic | male | 65 | old\_adult | tonsil removed during surgery for benign squamous pharyngeal papillomatosis | discovery | NA |
| BCLL-6-T | BCLL-6-T | Clinic | male | 35 | young\_adult | sleep apnea | discovery | NA |
| BCLL-8-T | BCLL-8-T | CIMA | male | 4 | child | tonsillitis | discovery | NA |
| BCLL-9-T | BCLL-9-T | CIMA | male | 5 | child | tonsillitis | discovery | NA |
| BCLL-10-T | BCLL-10-T | CIMA | male | 3 | child | tonsillitis | discovery | NA |
| BCLL-11-T | BCLL-11-T | CIMA | female | 5 | child | tonsillitis | discovery | NA |
| BCLL-12-T | BCLL-12-T | CIMA | female | 3 | child | tonsillitis | discovery | NA |
| BCLL-13-T | BCLL-13-T | CIMA | female | 5 | child | tonsillitis | discovery | NA |
| BCLL-14-T | BCLL-14-T | CIMA | male | 26 | young\_adult | sleep apnea | discovery | NA |
| BCLL-15-T | BCLL-15-T | CIMA | male | 33 | young\_adult | sleep apnea | discovery | NA |
| BCLL-20-T | BCLL-20-T | Newcastle | male | 23 | young\_adult | tonsillitis | validation | original id: TIP01 |
| BCLL-21-T | BCLL-21-T | Newcastle | female | 19 | young\_adult | tonsillitis | validation | original id: TIP02 |
| BCLL-22-T | BCLL-22-T | Newcastle | female | 22 | young\_adult | tonsillitis | validation | original id: TIP03 |
| BCLL-24-T | BCLL-24-T | Clinic | male | 63 | old\_adult | tonsil removed during surgery for superficial squamous carcinoma of the laryngeal vocal cord | validation | NA |
| BCLL-25-T | BCLL-25-T | Clinic | female | 25 | young\_adult | tonsillitis | validation | NA |
| BCLL-26-T | BCLL-26-T | Clinic | male | 56 | old\_adult | sleep apnea | validation | NA |
| BCLL-28-T | BCLL-28-T | Newcastle | male | 28 | young\_adult | tonsillitis | validation | original id: TIP04 |

These tonsil samples were processed with different data modalities:

* scRNA-seq ([10X Chromium v3](https://www.10xgenomics.com/products/single-cell-gene-expression))
* scATAC-seq ([10X Chromium](https://www.10xgenomics.com/products/single-cell-atac))
* [10X Multiome](https://www.10xgenomics.com/products/single-cell-multiome-atac-plus-gene-expression): joint RNA and ATAC for each cell.
* [CITE-seq](https://www.nature.com/articles/nmeth.4380): joint transcriptome + ~200 protein surface markers for each cell.
* [Spatial transcriptomics](%5B10X%20Visium%5D%28https%3A//www.10xgenomics.com/products/spatial-gene-expression%29)

The following heatmap informs about which samples were sequenced with which
technology and cohort type:

![](data:image/png;base64...)

For each data modality, we mapped all raw fastq files with the appropriate flavor
of [cellranger](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger)
(e.g. cellranger-atac, spaceranger, etc), and analyzed all datasets within the
[Seurat](https://satijalab.org/seurat/) ecosystem (Hao et al. [2021](#ref-hao2021integrated)). All
fastq files are deposited at EGA under accession number [EGAS00001006375](https://ega-archive.org/studies/EGAS00001006375).
The expression and accessibility matrices are deposited in Zenodo under record [6678331](https://zenodo.org/record/6678331).
The Seurat objects from which the data of this repository is derived are archived in Zenodo under record [8373756](https://zenodo.org/record/8373756).
Finally, the GitHub repository [Single-Cell-Genomics-Group-CNAG-CRG/TonsilAtlas](https://github.com/Single-Cell-Genomics-Group-CNAG-CRG/TonsilAtlas) documents the full
end-to-end analysis, from raw data to final Seurat objects and figures in the paper.

To define the tonsillar cell types, we first aimed to cluster cells using
the combined expression data from scRNA-seq, Multiome and CITE-seq datasets.
However, we noticed that with CITE-seq we detected 2.75X and 2.98X fewer genes
than with scRNA-seq and Multiome, respectively:

![](data:image/png;base64...)

Because we did not want to bias the clustering towards the modality that
provides less information, we first analyzed scRNA-seq and Multiome together,
and used CITE-seq to validate the annotation (see below). However, a recent
benchmarking effort showed that scRNA-seq and single-nuclei RNA-seq (such as
Multiome) mix very poorly (Mereu et al. [2020](#ref-mereu2020benchmarking)). Indeed, we observed massive
batch effects between both modalities (see manuscript). To overcome it, we
found highly variable genes (HVG) for each modality independently. We then
intersected both sets of HVG to remove modality-specific variation. Following
principal component analysis (PCA), we integrated scRNA-seq and Multiome with
Harmony (Korsunsky et al. [2019](#ref-korsunsky2019fast)). Harmony scales well to atlas-level datasets
and ranks among the best-performing tools in different benchmarks.

These steps are performed using [SLOcatoR](https://github.com/massonix/SLOcatoR)
(see methods of the paper), which allowed 1. to remove batch effects between
scRNA-seq and Multiome, 2. to transfer cell type labels from Multiome to scATAC-seq,
and from scRNA-seq to CITE-seq. Thus, this strategy allowed us to annotate clusters
using information across multiple modalities (RNA expression, protein expression,
TF motifs, etc.).

Note: we provide SLOcatoR as an R package to promote reproducibility and
best practices in scientific computing, but we refer the users to properly
benchmarked tools to annotate their datasets such as
[Azimuth](https://www.cell.com/cell/fulltext/S0092-8674%2821%2900583-3),
[scArches](https://www.nature.com/articles/s41587-021-01001-7),
or [Symphony](https://www.nature.com/articles/s41467-021-25957-x).

Within the discovery cohort, we first defined 9 main compartments: (1) NBC and MBC,
(2) GC B cells (GCBC), (3) PC, (4) CD4 T cells, (5) cytotoxic cells
[CD8 T cells, NK, ILC, double negative T cells (DN)], (6) myeloid cells
(DC, macrophages, monocytes, granulocytes, mast cells), (7) FDC, (8) epithelial
cells and (9) plasmacytoid dendritic cells (PDC):

![](data:image/png;base64...)

Subsequently, we clustered and annotated cell subtypes within each of the main
compartments, giving rise to the 121 cell types and states in the atlas. The
following UMAPs inform about the main cell populations and number of cells
per assay in the discovery cohort:

![](data:image/png;base64...)

We then applied SLOcatoR to annotate cells from the validation cohort (1) to confirm
the presence, annotation and markers of cell types; (2) to extend the atlas
through an integrated validation dataset, and (3) to chart compositional
changes in the tonsil during aging. The integrated tonsil atlas represented
over 462,000 single-cell transcriptomes:

![](data:image/png;base64...)

Finally, we focused again on each of the 9 compartments and retransferred the
final annotation level. As an example, here we can see the transferred annotation
for CD4 T cells, from discovery to validation cohort:

![](data:image/png;base64...)

Overall, we could validate most of the cell types, as they preserved their
marker genes and had a high annotation confidence in the validation cohort.
However, (1) transient cell states, (2) underrepresented cell types, or
(3) clusters that are at the intersection between two main compartments (and
might represent doublets) had low annotation confidences. We provide this
interpretation in the Glossary (see below).

# 4 Assay types

HCATonsilData provides access to 5 main types of assays: RNA, ATAC, Multiome,
CITE-seq and Spatial.

## 4.1 scRNA-seq

We can obtain the `SingleCellExperiment` object with gene expression (RNA)
data as follows:

```
(sce <- HCATonsilData(assayType = "RNA", cellType = "All"))
table(sce$assay)
```

This object consists of 377,988 profiled with scRNA-seq (3P)
and 84,364 cells profiled with multiome, for a total of 462,352 cells (37,378
genes were quantified across all of these).

We can dowload a `SingleCellExperiment` object specific to each of the main
subpopulations defined at level 1 as follows:

```
listCellTypes(assayType = "RNA")
#>  [1] "All"        "NBC-MBC"    "GCBC"       "PC"         "CD4-T"
#>  [6] "Cytotoxic"  "myeloid"    "FDC"        "epithelial" "PDC"
(epithelial <- HCATonsilData(assayType = "RNA", cellType = "epithelial"))
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> require("rhdf5")
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> class: SingleCellExperiment
#> dim: 37378 396
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(37378): AL627309.1 AL627309.3 ... AC136616.1 AC023491.2
#> rowData names(3): gene_name highly_variable gene_id
#> colnames(396): bw94nf57_vm85woki_CTCCTTTCACACGGAA-1
#>   bw94nf57_vm85woki_GTAATGCAGTGACCTT-1 ...
#>   TIP04-2_fresh_TCTATACTCGTGAGAG-1 TIP04-2_fresh_TGTCCCAGTACAAGTA-1
#> colData names(39): barcode donor_id ... UMAP_1_20230508 UMAP_2_20230508
#> reducedDimNames(3): PCA UMAP HARMONY
#> mainExpName: NULL
#> altExpNames(0):
data("colors_20230508")
scater::plotUMAP(epithelial, colour_by = "annotation_20230508") +
  ggplot2::scale_color_manual(values = colors_20230508$epithelial) +
  ggplot2::theme(legend.title = ggplot2::element_blank())
#> Scale for colour is already present.
#> Adding another scale for colour, which will replace the existing scale.
```

![](data:image/png;base64...)

As we can see, we can use the same colors as in the publication using the
`colors_20230508` variable.

We can also download datasets from the preprint (discovery cohort, version 1.0) -
we first load a list of matched annotations used throughout the course of the
project, used internally by the main `HCATonsilData()` function:

```
data("annotations_dictionary")
annotations_dictionary[["dict_20220619_to_20230508"]]
#>                MAIT         TCRVδ+ gd T          CD56+ gd T         Nksig CD8 T
#>    "MAIT/Vδ2+ γδ T"     "non-Vδ2+ γδ T"     "ZNF683+ CD8 T"          "EM CD8 T"
#>       C1Q Slancytes     ITGAX Slancytes       MMP Slancytes   SELENOP Slancytes
#>     "C1Q Slan-like"   "ITGAX Slan-like"     "MMP Slan-like" "SELENOP Slan-like"
#>       CD16-CD56- NK
#>   "CD16-CD56dim NK"

# load also a predefined palette of colors, to match the ones used in the manuscript
data("colors_20230508")

(epithelial_discovery <- HCATonsilData("RNA", "epithelial", version = "1.0"))
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> see ?HCATonsilData and browseVignettes('HCATonsilData') for documentation
#> loading from cache
#> class: SingleCellExperiment
#> dim: 37378 277
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(37378): AL627309.1 AL627309.3 ... AC136616.1 AC023491.2
#> rowData names(3): gene_name highly_variable gene_id
#> colnames(277): bw94nf57_vm85woki_CTCCTTTCACACGGAA-1
#>   bw94nf57_vm85woki_GTAATGCAGTGACCTT-1 ...
#>   y7qn780g_p6jkgk63_TGACTCCTCCTAGCCT-1
#>   y7qn780g_p6jkgk63_TGCTTCGGTTAGGAGC-1
#> colData names(32): barcode donor_id ... annotation_20220619
#>   annotation_20230508
#> reducedDimNames(3): PCA UMAP HARMONY
#> mainExpName: NULL
#> altExpNames(0):
scater::plotUMAP(epithelial, colour_by = "annotation_20230508") +
  ggplot2::scale_color_manual(values = colors_20230508$epithelial) +
  ggplot2::theme(legend.title = ggplot2::element_blank())
#> Scale for colour is already present.
#> Adding another scale for colour, which will replace the existing scale.
```

![](data:image/png;base64...)

Here’s a brief explanation of all the variables in the colData slot of the
`SingleCellExperiment` objects:

* barcode: the cell barcode. Combination of [GEM well](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/glossary) and cellranger 10X barcode.
* donor\_id: the donor-specific identifier, which can be used to retrieve donor-level metadata form the table above.
* gem\_id: we gave a unique hashtag to each [GEM well](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/glossary) (10X Chip Channel) in our dataset. This allows to traceback all the metadata for a given cell.
* library\_name: each GEM well can give rise to multiple Illumina libraries. For example, one Multiome GEM well will give rise to 2 illumina libraries (ATAC and RNA).
* assay: 3P (scRNA-seq) or multiome
* sex
* age
* age\_group: kid, young adult, old adult
* hospital: hospital where the tonsils where obtained [Hospital Clinic](https://www.clinicbarcelona.org/), [CIMA](https://cima.cun.es/), or Newcastle.
* cohort\_type: discovery or validation cohort
* cause\_for\_tonsillectomy: condition that led to the tonsillectomy (e.g. tonsillitis, sleep apnea, etc.)
* is\_hashed: whether we used [cell hashing](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-018-1603-1) or not.
* preservation: whether we processed the sample fresh or frozen.
* nCount\_RNA, nFeature\_RNA: number of counts and features (genes) detected per cell.
* pct\_mt, pct\_ribosomal: percentage of counts that map to mitochondrial (^MT) or ribosomal (^RPS) genes.
* pDNN\_hashing, pDNN\_scrublet, pDNN\_union: proportion of doublet nearest neighbors (pDNN) using different doublet annotations.
* S.Score, G2M.Score Phase, CC.Difference: outputs of the [CellCycleScoring](https://rdrr.io/cran/Seurat/man/CellCycleScoring.html) from `Seurat`.
* scrublet\_doublet\_scores: doublet score obtained with [Scrublet](https://www.cell.com/cell-systems/fulltext/S2405-4712%2818%2930474-5?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS2405471218304745%3Fshowall%3Dtrue)
* scrublet\_predicted\_doublet: doublet annotation obtained with Scirpy (doublet or singlet)
* doublet\_score\_scDblFinder: doublet score obtained with [scDblFinder](https://f1000research.com/articles/10-979), which was run in the validation cohort following [the most recent best practices for single-cell analysis](https://www.nature.com/articles/s41576-023-00586-w).
* annotation\_level\_1: annotation used at our level 1 clustering (9 main compartments).
* annotation\_level\_1\_probability: annotation confidence for the level 1 annotation (relevant for validation cohort, as it implied KNN annotation)
* annotation\_figure\_1: annotation used in the figure 1 of our manuscript. This annotation consisted of grouping the final subtypes into main cell types that were distinguishable in the UMAP.
* annotation\_20220215, annotation\_20220619, annotation\_20230508: time-stamped annotation for cell types.
* annotation\_20230508\_probability: annotation confidence for the final annotation (relevant for validation cohort, as it implied KNN annotation)
* UMAP\_1\_level\_1, UMAP\_2\_level\_1: UMAP1 coordinates of the figure 1B of the article.
* annotation\_20220215: see above.
* UMAP\_1\_20220215, UMAP\_2\_20220215: UMAP coordinates used in figures of the preprint for each cell type.

## 4.2 scATAC-seq and Multiome

Since there is not a popular Bioconductor package to analyze or store scATAC-seq data,
we point users to the scATAC-seq and Multiome Seurat objects that we created
using [Signac](https://stuartlab.org/signac/) (Stuart et al. [2021](#ref-stuart2021single)).

Here are the instructions to download the scATAC-seq object (approximately ~9.3 Gb in size):

```
library("Seurat")
library("Signac")

download_dir = tempdir()

options(timeout = 10000000)
atac_url <- "https://zenodo.org/record/8373756/files/TonsilAtlasSeuratATAC.tar.gz"
download.file(
  url = atac_url,
  destfile = file.path(download_dir, "TonsilAtlasSeuratATAC.tar.gz")
)
# Advice: check that the md5sum is the same as the one in Zenodo
untar(
  tarfile = file.path(download_dir, "TonsilAtlasSeuratATAC.tar.gz"),
  exdir = download_dir
)
atac_seurat <- readRDS(
  file.path(download_dir, "scATAC-seq/20230911_tonsil_atlas_atac_seurat_obj.rds")
)
atac_seurat
```

The multiome object contains 68,749 cells that passed both RNA and ATAC QC filters.
Here are the instructions to download the Multiome object (approximately ~5.7 Gb in size):

```
library("Seurat")
library("Signac")

download_dir = tempdir()

options(timeout = 10000000)
multiome_url <- "https://zenodo.org/record/8373756/files/TonsilAtlasSeuratMultiome.tar.gz"
download.file(
  url = multiome_url,
  destfile = file.path(download_dir, "TonsilAtlasSeuratMultiome.tar.gz")
)
# Advice: check that the md5sum is the same as the one in Zenodo
untar(
  tarfile = file.path(download_dir, "TonsilAtlasSeuratMultiome.tar.gz"),
  exdir = download_dir
)
multiome_seurat <- readRDS(
  file.path(download_dir, "/multiome/20230911_tonsil_atlas_multiome_seurat_obj.rds")
)
multiome_seurat
```

**Note**: we may version these two objects in Zenodo to polish the annotation.
Therefore, we recommend users to check that this is the most updated version
of the object in Zenodo.

To recall peaks or visualize chromatin tracks, it is essential to have access to
the [fragments file](https://support.10xgenomics.com/single-cell-atac/software/pipelines/latest/output/fragments).
We modified the original fragments files generated by
cellranger-atac or cellranger-arc to include the [gem\_id](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/glossary)
as prefix. These files can be downloaded as follows (approximate size of ~26.0 Gb, feel free to grab a coffee in the meanwhile):

```
download_dir = tempdir()

fragments_url <- "https://zenodo.org/record/8373756/files/fragments_files.tar.gz"
download.file(
  url = fragments_url,
  destfile = file.path(download_dir, "fragments_files.tar.gz")
)
untar(
  tarfile = file.path(download_dir, "fragments_files.tar.gz"),
  exdir = download_dir
)
```

**Note**: it is paramount to update the paths to the fragments files in each
ChromatinAssay object using the [UpdatePath](https://stuartlab.org/signac/reference/updatepath)
function.

The chromatin accessibility side of these objects was processed using the
general pipeline from [Signac](https://stuartlab.org/signac/articles/pbmc_vignette). Briefly:

* We called peaks using [MACS2](https://pypi.org/project/MACS2/) (as implemented in the [CallPeaks](https://www.rdocumentation.org/packages/Signac/versions/1.10.0/topics/CallPeaks) function), generating pseudobulks for each of the main 9 compartments.
* We quantified the accessibility for each peak and each cell using the [FeatureMatrix](https://stuartlab.org/signac/reference/featurematrix) function.
* We normalized data using the term frequency inverse document frequency (TF-IDF) normalization, as implemented in the [RunTFIDF](https://stuartlab.org/signac/reference/runtfidf) function.
* We reduced the dimensionality using latent semantic indexing ([RunLSI](https://www.rdocumentation.org/packages/Seurat/versions/3.1.4/topics/RunLSI) function)

For Multiome, we additionally computed a weighted KNN graph with the
[FindMultiModalNeighbors](https://satijalab.org/seurat/reference/findmultimodalneighbors) function.

Many variables in the metadata slot are shared with scRNA-seq. Here, we explain
the meaning of the variables that are specific to Multiome or scATAC-seq:

* nCount\_ATAC: total number of counts per cell
* nFeature\_ATAC: total number of peaks detected per cell
* is\_facs\_sorted: whether that particular sample was FACS-sorted to eliminate dead cells
* nucleosome\_signal: as explained in Signac, *Nucleosome banding pattern: The histogram of DNA fragment sizes (determined from the paired-end sequencing reads) should exhibit a strong nucleosome banding pattern corresponding to the length of DNA wrapped around a single nucleosome. We calculate this per single cell, and quantify the approximate ratio of mononucleosomal to nucleosome-free fragments*
* nucleosome\_percentile: percentile rank of each ratio of mononucleosomal to nucleosome-free fragments per cell (see [NucleosomeSignal](https://stuartlab.org/signac/reference/nucleosomesignal) function)
* TSS.enrichment: as explained in Signac, *The ENCODE project has defined an ATAC-seq targeting score based on the ratio of fragments centered at the TSS to fragments in TSS-flanking regions (see <https://www.encodeproject.org/data-standards/terms/>). Poor ATAC-seq experiments typically will have a low TSS enrichment score.*
* TSS.percentile
* RNA.weight: the weight that RNA has in the weighted nearest neighbor graph per cell (multiome-specific)
* ATAC.weight: the weight that RNA has in the weighted nearest neighbor graph per cell (multiome-specific)

## 4.3 CITE-seq

The CITE-seq object can be downloaded as follows (approximate size of ~0.4 Gb):

```
library("Seurat")

download_dir = tempdir()

options(timeout = 10000000)
cite_url <- "https://zenodo.org/record/8373756/files/TonsilAtlasSeuratCITE.tar.gz"
download.file(
  url = cite_url,
  destfile = file.path(download_dir, "TonsilAtlasSeuratCITE.tar.gz")
)
# Advice: check that the md5sum is the same as the one in Zenodo
untar(
  tarfile = file.path(download_dir, "TonsilAtlasSeuratCITE.tar.gz"),
  exdir = download_dir
)

cite_seurat <- readRDS(
  file.path(download_dir, "CITE-seq/20220215_tonsil_atlas_cite_seurat_obj.rds")
)
cite_seurat
```

Together with CITE-seq, we also applied scBCR-seq and scTCR-seq. This data was
analyzed with [scirpy](https://academic.oup.com/bioinformatics/article/36/18/4817/5866543),
(Sturm et al. [2020](#ref-sturm2020scirpy)) and we provide the main output of this analysis (for cytotoxic cells) as a
dataframe, which can be imported as follows:

```
scirpy_df <- read.csv(
  file = file.path(download_dir, "CITE-seq/scirpy_tcr_output.tsv"),
  header = TRUE
)

head(scirpy_df)
```

## 4.4 Spatial transcriptomics

A *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* of the [spatial transcriptomics](%5B10X%20Visium%5D%28https%3A//www.10xgenomics.com/products/spatial-gene-expression%29) dataset may be retrieved via `assayType="Spatial"`. The dataset contains 8 tissue slices with ~1,000-3,000 cells each that were profiled on two separated slides, as well as a low-resolution (H&E staining) image for each slice.

```
library("SpatialExperiment")
(spe <- HCATonsilData(assayType = "Spatial"))
```

To plot gene expression you can use the ggspavis package:

```
library("ggspavis")
sub <- spe[, spe$sample_id == "esvq52_nluss5"]
plt <- plotVisium(sub, fill="SELENOP") +
  scale_fill_gradientn(colors=rev(hcl.colors(9, "Spectral")))
plt$layers[[2]]$aes_params$size <- 1.5
plt$layers[[2]]$aes_params$alpha <- 1
plt$layers[[2]]$aes_params$stroke <- NA
plt
```

# 5 Annotations of the Tonsil Data Atlas

To allow users to traceback the rationale behind each and every of our annotations,
we provide a detailed glossary of 121 cell types and states and related functions
to get the explanation, markers and references of every annotation. You can access
the glossary as a dataframe as follows:

```
glossary_df <- TonsilData_glossary()
head(glossary_df)
#>                annotation_level_1 annotation_detailed
#> PDC                           PDC                 PDC
#> IFN1+ PDC                     PDC           IFN1+ PDC
#> preB                         preB                preB
#> preT                         preT                preT
#> Naive                       CD4_T               Naive
#> CM Pre-non-Tfh              CD4_T      CM Pre-non-Tfh
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              description
#> PDC                                                                                                                                                                                                                                                                                                                                                                    pDCs were previously identified by the standard protein marker CD123 (IL3RA). This cluster had higher expression of IRF8, IL3RA and LILRA4 (Villani et al., 2017)
#> IFN1+ PDC                                                                                                                                                                                                                                                                                                  The second pDC subpopulation was identified by standard protein marker CD123 and as IFN-producing cells. This cluster had higher expression of IRF8, IL3RA, LILRA4 and IFI44, IFI6 (Park et al., 2020; Villani et al., 2017).
#> preB                                                                                                                                                                                                                                                                                                                                                                                                                          Precursor B cells were identified by the expression of CD79B, CD19, PAX5, RAG1/2 (Strauchen et al., 2003).
#> preT                                                                                                                                                                                                                                                                                                                                                                                                                      Precursor T cells in tonsils expressed: CD3G, CD8A, RAG1, DNTT, CD1A, CD1B, CD1C, CD1E (McClory et al., 2012).
#> Naive                                                                                                                                                                                                                Naïve cell is a CD4 T cell that recently migrates from the thymus towards lymph nodes. Naïve CD4 T cells expressed lymph node homing genes such as CCR7 and naïve-associated genes: SELL, LEF1, BACH2 and NOSIP. Also, they were negative for PRDM1 and BCL6 and were CD62L+ and CD45RA+ (Cano-Gamez et al., 2020).
#> CM Pre-non-Tfh After antigen encounter T cells acquire memory and effector functions maintaining the lymph node homing. CM showed an upregulation of IL7R compared to naïve T cells, and higher expression of PRDM1, PASK, ANXA1 and S100A4. They had an intermediate expression of CCR7 and higher expression of CD28 confirming their migratory capacity to secondary lymph nodes and their memory profile based on their effector function. This cluster was CD45RO+, CD28+ and CD29+(Cano-Gamez et al., 2020; Nicolet et al., 2021).
#>                                           marker_genes
#> PDC                                  IRF8,IL3RA,LILRA4
#> IFN1+ PDC                 IRF8,IL3RA,LILRA5,IFI44,IFI6
#> preB                         CD79B,CD19,PAX5,RAG1,RAG2
#> preT           CD3G,CD8A,RAG1,DNTT,CD1A,CD1B,CD1C,CD1E
#> Naive                            SELL,LEF1,BACH2,NOSIP
#> CM Pre-non-Tfh            CCR7,IL7R,ANXA1,ITGB1,S100A4
#>                                                                                  related_refs
#> PDC                                                       Villani2017|10.1126/science.aah4573
#> IFN1+ PDC                Park2020|10.1126/science.aay3224;Villani2017|10.1126/science.aah4573
#> preB                                                 Strauchen2003|10.1177/106689690301100105
#> preT                                                             McClory2012|10.1172/JCI46125
#> Naive                                               Cano-Gamez2020|10.1038/s41467-020-15543-y
#> CM Pre-non-Tfh Cano-Gamez2020|10.1038/s41467-020-15543-y;Nicolet2021|10.4049/jimmunol.2100138
#>                      umap_png related_cell_ontology
#> PDC              pdc_umap.png                    NA
#> IFN1+ PDC        pdc_umap.png                    NA
#> preB             pdc_umap.png                    NA
#> preT             pdc_umap.png                    NA
#> Naive          cd4_t_umap.png                    NA
#> CM Pre-non-Tfh cd4_t_umap.png                    NA
```

To get the glossary for each cell type with nice printing formatting you can use
the `TonsilData_cellinfo()` function:

```
TonsilData_cellinfo("Tfr")
#> Tfr
#> ------------------------------
#> Annotation Level 1: CD4_T
#> Cell Markers: T-follicular regulatory cells in the tonsils are CD25-. These cells down-regulate effector Treg markers (IL2RA, FOXP3, CTLA4). This cluster expressed high levels of FCRL3, CLNK, LEF1, TCF7, RBMS3, SESN3, and PDE3B. The top marker FCRL3 can bind secretory IgA to suppress the Tfr inhibitory function. TCF7 and LEF1 are essential for Tfr development in mice (Wing et al., 2017; Agarwal et al., 2020 ; Yang et al., 2019).
#> Cell Markers: FCRL3,CLNK,LEF1,TCF7,RBMS3,SESN3,PDE3B
#> Related references: Wing2017|10.1073/pnas.1705551114;Agarwal2020|10.1016/j.celrep.2019.12.099;Yang2019|10.1016/j.celrep.2019.05.061
```

Alternatively, you can get a static html with links to markers and articles with
`TonsilData_cellinfo_html`

```
htmltools::includeHTML(
  TonsilData_cellinfo_html("Tfr", display_plot = TRUE)
)
#> /usr/bin/pandoc +RTS -K512m -RTS file4d28968272c78 --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --output file4d28968272c78.html --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/pagebreak.lua --lua-filter /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmarkdown/lua/latex-div.lua --self-contained --variable bs3=TRUE --section-divs --template /home/biocbuild/bbs-3.22-bioc/R/site-library/rmarkdown/rmd/h/default.html --no-highlight --variable highlightjs=1 --variable theme=bootstrap --mathjax --variable 'mathjax-url=https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' --include-in-header /tmp/RtmpaDkdYG/rmarkdown-str4d28926a04204.html
#>
#> Output created: file4d28968272c78.html
```

**Tfr**
**Annotation Level 1:** CD4\_T

---

![](data:image/png;base64...)

---

**Cell type description:** T-follicular regulatory cells in the tonsils are CD25-. These cells down-regulate effector Treg markers (IL2RA, FOXP3, CTLA4). This cluster expressed high levels of FCRL3, CLNK, LEF1, TCF7, RBMS3, SESN3, and PDE3B. The top marker FCRL3 can bind secretory IgA to suppress the Tfr inhibitory function. TCF7 and LEF1 are essential for Tfr development in mice (Wing et al., 2017; Agarwal et al., 2020 ; Yang et al., 2019).

**Marker genes for this cell type:**
[FCRL3](http://www.ncbi.nlm.nih.gov/gene/?term=FCRL3[sym]) [CLNK](http://www.ncbi.nlm.nih.gov/gene/?term=CLNK[sym]) [LEF1](http://www.ncbi.nlm.nih.gov/gene/?term=LEF1[sym]) [TCF7](http://www.ncbi.nlm.nih.gov/gene/?term=TCF7[sym]) [RBMS3](http://www.ncbi.nlm.nih.gov/gene/?term=RBMS3[sym]) [SESN3](http://www.ncbi.nlm.nih.gov/gene/?term=SESN3[sym]) [PDE3B](http://www.ncbi.nlm.nih.gov/gene/?term=PDE3B[sym])

**References:** [Wing2017](https://doi.org/10.1073/pnas.1705551114) [Agarwal2020](https://doi.org/10.1016/j.celrep.2019.12.099) [Yang2019](https://doi.org/10.1016/j.celrep.2019.05.061)

Although we have put massive effort in annotating tonsillar cell types, cell type
annotations are dynamic by nature. New literature or other interpretations of the
data can challenge and refine our annotations. To accommodate this, we have developed
the `updateAnnotation` function, which allows to periodically provide newer
annotations as extra columns in the `colData` slot of the `SingleCellExperiment`
objects. If you want to contribute in one of these versions of the upcoming annotations,
please [open an issue](https://github.com/massonix/HCATonsilData/issues/new) and
describe your annotation.

# 6 Interoperability with other frameworks

While we provide data in the form of SingleCellExperiment objects, you may want to
analyze your data using a different single-cell data container. In future releases,
we will strive to make the SingleCellExperiment objects compatible with
[Seurat v5](https://github.com/satijalab/seurat), which will come out after this
release of BioConductor. Alternatively, you may want to obtain
[AnnData](https://anndata.readthedocs.io/en/latest/) objects to analyze your data
in [scanpy](https://scanpy.readthedocs.io/en/stable/installation.html) ecosystem.
You can convert and save the data as follows:

```
library("zellkonverter")
epithelial <- HCATonsilData(assayType = "RNA", cellType = "epithelial")

epi_anndatafile <- file.path(tempdir(), "epithelial.h5ad")

writeH5AD(sce = epithelial, file = epi_anndatafile)
```

The SingleCellExperiment objects obtained via `HCATonsilData()` can be explored in
detail using e.g. additional Bioconductor packages, such as the `iSEE` package.

This can be as simple as executing this chunk:

```
if (require(iSEE)) {
  iSEE(epithelial)
}
```

# Session information

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
#>  [1] rhdf5_2.54.0                htmltools_0.5.8.1
#>  [3] kableExtra_1.4.0            knitr_1.50
#>  [5] scater_1.38.0               ggplot2_4.0.0
#>  [7] scuttle_1.20.0              ExperimentHub_3.0.0
#>  [9] AnnotationHub_4.0.0         BiocFileCache_3.0.0
#> [11] dbplyr_2.5.1                SingleCellExperiment_1.32.0
#> [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [17] IRanges_2.44.0              S4Vectors_0.48.0
#> [19] BiocGenerics_0.56.0         generics_0.1.4
#> [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [23] HCATonsilData_1.8.0         BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DBI_1.2.3                gridExtra_2.3            httr2_1.2.1
#>  [4] rlang_1.1.6              magrittr_2.0.4           compiler_4.5.1
#>  [7] RSQLite_2.4.3            systemfonts_1.3.1        png_0.1-8
#> [10] vctrs_0.6.5              stringr_1.5.2            pkgconfig_2.0.3
#> [13] SpatialExperiment_1.20.0 crayon_1.5.3             fastmap_1.2.0
#> [16] magick_2.9.0             XVector_0.50.0           labeling_0.4.3
#> [19] rmarkdown_2.30           ggbeeswarm_0.7.2         tinytex_0.57
#> [22] purrr_1.1.0              bit_4.6.0                xfun_0.54
#> [25] cachem_1.1.0             beachmat_2.26.0          jsonlite_2.0.0
#> [28] blob_1.2.4               rhdf5filters_1.22.0      DelayedArray_0.36.0
#> [31] Rhdf5lib_1.32.0          BiocParallel_1.44.0      irlba_2.3.5.1
#> [34] parallel_4.5.1           R6_2.6.1                 stringi_1.8.7
#> [37] bslib_0.9.0              RColorBrewer_1.1-3       jquerylib_0.1.4
#> [40] Rcpp_1.1.0               bookdown_0.45            base64enc_0.1-3
#> [43] Matrix_1.7-4             tidyselect_1.2.1         rstudioapi_0.17.1
#> [46] viridis_0.6.5            dichromat_2.0-0.1        abind_1.4-8
#> [49] yaml_2.3.10              codetools_0.2-20         curl_7.0.0
#> [52] lattice_0.22-7           tibble_3.3.0             withr_3.0.2
#> [55] KEGGREST_1.50.0          S7_0.2.0                 evaluate_1.0.5
#> [58] xml2_1.4.1               Biostrings_2.78.0        pillar_1.11.1
#> [61] BiocManager_1.30.26      filelock_1.0.3           BiocVersion_3.22.0
#> [64] scales_1.4.0             glue_1.8.0               tools_4.5.1
#> [67] BiocNeighbors_2.4.0      ScaledMatrix_1.18.0      cowplot_1.2.0
#> [70] grid_4.5.1               AnnotationDbi_1.72.0     beeswarm_0.4.0
#> [73] BiocSingular_1.26.0      HDF5Array_1.38.0         vipor_0.4.7
#> [76] cli_3.6.5                rsvd_1.0.5               rappdirs_0.3.3
#> [79] textshaping_1.0.4        viridisLite_0.4.2        S4Arrays_1.10.0
#> [82] svglite_2.2.2            dplyr_1.1.4              gtable_0.3.6
#> [85] sass_0.4.10              digest_0.6.37            ggrepel_0.9.6
#> [88] SparseArray_1.10.1       rjson_0.2.23             farver_2.1.2
#> [91] memoise_2.0.1            lifecycle_1.0.4          h5mread_1.2.0
#> [94] httr_1.4.7               bit64_4.6.0-1
```

# References

De Silva, Nilushi S, and Ulf Klein. 2015. “Dynamics of B Cells in Germinal Centres.” *Nature Reviews Immunology* 15 (3): 137–48.

Hao, Yuhan, Stephanie Hao, Erica Andersen-Nissen, William M Mauck III, Shiwei Zheng, Andrew Butler, Maddie J Lee, et al. 2021. “Integrated Analysis of Multimodal Single-Cell Data.” *Cell* 184 (13): 3573–87.

Korsunsky, Ilya, Nghia Millard, Jean Fan, Kamil Slowikowski, Fan Zhang, Kevin Wei, Yuriy Baglaenko, Michael Brenner, Po-ru Loh, and Soumya Raychaudhuri. 2019. “Fast, Sensitive and Accurate Integration of Single-Cell Data with Harmony.” *Nature Methods* 16 (12): 1289–96.

Mereu, Elisabetta, Atefeh Lafzi, Catia Moutinho, Christoph Ziegenhain, Davis J McCarthy, Adrián Álvarez-Varela, Eduard Batlle, et al. 2020. “Benchmarking Single-Cell Rna-Sequencing Protocols for Cell Atlas Projects.” *Nature Biotechnology* 38 (6): 747–55.

Nave, Heike, Andreas Gebert, and Reinhard Pabst. 2001. “Morphology and Immunology of the Human Palatine Tonsil.” *Anatomy and Embryology* 204 (5): 367–73.

Regev, Aviv, Sarah Teichmann, Orit Rozenblatt-Rosen, Michael Stubbington, Kristin Ardlie, Ido Amit, Paola Arlotta, et al. 2018. “The Human Cell Atlas White Paper.” *arXiv Preprint arXiv:1810.05192*.

Ruddle, Nancy H, and Eitan M Akirav. 2009. “Secondary Lymphoid Organs: Responding to Genetic and Environmental Cues in Ontogeny and the Immune Response.” *The Journal of Immunology* 183 (4): 2205–12.

Stuart, Tim, Avi Srivastava, Shaista Madad, Caleb A Lareau, and Rahul Satija. 2021. “Single-Cell Chromatin State Analysis with Signac.” *Nature Methods* 18 (11): 1333–41.

Sturm, Gregor, Tamas Szabo, Georgios Fotakis, Marlene Haider, Dietmar Rieder, Zlatko Trajanoski, and Francesca Finotello. 2020. “Scirpy: A Scanpy Extension for Analyzing Single-Cell T-Cell Receptor-Sequencing Data.” *Bioinformatics* 36 (18): 4817–8.

Wagner, Allon, Aviv Regev, and Nir Yosef. 2016. “Revealing the Vectors of Cellular Identity with Single-Cell Genomics.” *Nature Biotechnology* 34 (11): 1145–60.