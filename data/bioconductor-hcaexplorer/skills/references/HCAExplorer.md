# What is the Human Cell Atlas?

From the [Human Cell Atlas (HCA) website](https://www.humancellatlas.org/):

> The cell is the core unit of the human body—the key to understanding the
> biology of health and the ways in which molecular dysfunction leads to disease.
> Yet our characterization of the hundreds of types and subtypes of cells in the
> human body is limited, based partly on techniques that have limited resolution
> and classifications that do not always map neatly to each other. Genomics has
> offered a systematic approach, but it has largely been applied in bulk to many
> cell types at once—masking critical differences between cells—and in isolation
> from other valuable sources of data.
>
> Recent advances in single-cell genomic analysis of cells and tissues have put
> systematic, high-resolution and comprehensive reference maps of all human cells
> within reach. In other words, we can now realistically envision a human cell
> atlas to serve as a basis for both understanding human health and diagnosing,
> monitoring, and treating disease.
>
> At its core, a cell atlas would be a collection of cellular reference maps,
> characterizing each of the thousands of cell types in the human body and where
> they are found. It would be an extremely valuable resource to empower the global
> research community to systematically study the biological changes associated
> with different diseases, understand where genes associated with disease are
> active in our bodies, analyze the molecular mechanisms that govern the
> production and activity of different cell types, and sort out how different cell
> types combine and work together to form tissues.

The Human Cell Atlas facilitates queries on it's [data coordination platform with
a RESTFUL API](https://dss.data.humancellatlas.org/).

## Installation

To install this package, use Bioconductor's `BiocManager` package.

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install('HCAExplorer')
```

```
library(HCAExplorer)
```

# Obtaining Metadata files from the HCAExplorer

One of the primary tasks of the HCAExplorer is to obtain metadata files of
projects and then pass them down to other pipelines to download useful
information like expression matrices. To illustrate the functionality of the
package, we will first embark on the task of obtaining expression matrices
from a selection of projects. We will first, initiate an HCAExplorer object,
then look at functions useful for navigating the HCAExplorer object, and finally
we will download the manifest file and use it to obtain expression matrices as
a LoomExperiment object.

## Connecting to the Human Cell Atlas

The *[HCAExplorer](https://bioconductor.org/packages/3.10/HCAExplorer)* package relies on having network
connectivety. Also, the a link to a viable digest of the Human Cell Atlas must
also be operational. The backend that we are using will be using is refered to
as the “azul backend”. This package is meant to mirror the functionality of the
[HCA Data Explorer](https://data.humancellatlas.org/explore/projects).

The `HCAExplorer` object serves as the representation of the Human Cell
Atlas. Upon creation, it will automatically perform a cursorary query and
display a small table showing the first few project of the entire HCA. This
intial table contains some columns that we have determined are most useful
to users. The output also displays the url of the instance of the HCA digest
being used, the current query, relevant information about the quantity of data
being displayed, and finally the table of projects.

By default, 15 entries per page will be displayed in the result and the
default url to the HCA DCP will be used. These two values can be changed in
the constructor or later on using methods.

If the HCA cannot be reached, an error will be thrown displaying the status of
the request.

```
hca <- HCAExplorer(url = 'https://service.explore.data.humancellatlas.org', per_page = 15)
hca
```

```
## class: HCAExplorer
## Using azul backend at:
##   https://service.explore.data.humancellatlas.org
##
## Donor count: 287
## Specimens: 649
## Estimated Cells: 4357497
## Files: 507981
## File Size: 26.2 Tb
##
## Showing projects with 15 results per page.# A tibble: 15 x 7
##    projects.projec… samples.sampleE… samples.organ protocols.libra…
##    <fct>            <fct>            <fct>         <fct>
##  1 1.3 Million Bra… specimens        brain         10X v2 sequenci…
##  2 A Single-Cell T… specimens        pancreas      inDrop
##  3 A single-cell m… specimens        embryo        10X 3' v1 seque…
##  4 A single-cell r… specimens        lung, medias… 10X v2 sequenci…
##  5 A single-cell t… specimens        eye           10X v2 sequenci…
##  6 Assessing the r… organoids        <NA>          10X v2 sequenci…
##  7 Bone marrow pla… specimens        hematopoieti… MARS-seq
##  8 Cell hashing wi… specimens        blood         CITE-seq
##  9 Census of Immun… specimens        immune syste… 10X v2 sequenci…
## 10 Comparison, cal… cellLines        <NA>          Drop-Seq, DroNc…
## 11 Dissecting the … specimens        liver         10X v2 sequenci…
## 12 HDCA project: s… specimens        cerebellum, … 10x 3' v3 seque…
## 13 Ischaemic sensi… specimens        esophagus, s… 10X v2 sequenci…
## 14 Melanoma infilt… specimens        tumor, lymph… Smart-seq2
## 15 Precursors of h… specimens        blood         Smart-seq2
## # … with 3 more variables: protocols.pairedEnd <fct>,
## #   donorOrganisms.genusSpecies <fct>, samples.disease <fct>
## Showing page 1 of 2
```

Upon displaying the object, multiple fields can be seen:

* The class: `HCAExplorer`
* The azul-backend address that is currently being used.
* The current query.
* The projects being shown and whether a `link` to more results is available.
* The number of projects being shown per\_page.
* The results `tibble` of the query. (This table is abbreviated to show only
  columns that we determined are most useful to the user.)

The results `tibble` can be obtained using the `results()` method.

```
results(hca)
```

```
## # A tibble: 15 x 50
##    protocols.libra… protocols.instr… protocols.paire… protocols.workf…
##    <fct>            <fct>            <fct>            <fct>
##  1 10X v2 sequenci… Illumina HiSeq … FALSE            ""
##  2 inDrop           Illumina HiSeq … TRUE             ""
##  3 10X 3' v1 seque… Illumina HiSeq … FALSE            ""
##  4 10X v2 sequenci… Illumina HiSeq … FALSE            optimus_v1.3.5
##  5 10X v2 sequenci… Illumina HiSeq … FALSE            optimus_v1.3.5
##  6 10X v2 sequenci… Illumina HiSeq … TRUE             optimus_v1.3.1,…
##  7 MARS-seq         Illumina NextSe… TRUE             ""
##  8 CITE-seq         Illumina Hiseq … FALSE            ""
##  9 10X v2 sequenci… Illumina HiSeq X FALSE            optimus_v1.3.2
## 10 Drop-Seq, DroNc… Illumina NextSe… TRUE             ""
## 11 10X v2 sequenci… Illumina Hiseq … FALSE            optimus_v1.3.5
## 12 10x 3' v3 seque… Illumina NovaSe… FALSE            ""
## 13 10X v2 sequenci… Illumina HiSeq … FALSE            optimus_v1.3.1,…
## 14 Smart-seq2       Illumina HiSeq … TRUE             ""
## 15 Smart-seq2       Illumina HiSeq … FALSE            ""
## # … with 46 more variables: protocols.assayType <fct>, entryId <fct>,
## #   projects.projectTitle <fct>, projects.projectShortname <fct>,
## #   projects.laboratory <fct>, projects.arrayExpressAccessions <fct>,
## #   projects.geoSeriesAccessions <fct>,
## #   projects.insdcProjectAccessions <fct>,
## #   projects.insdcStudyAccessions <fct>, samples.sampleEntityType <fct>,
## #   samples.effectiveOrgan <fct>, samples.disease <fct>,
## #   samples.source <fct>, samples.id <fct>,
## #   samples.preservationMethod <fct>, samples.organPart <fct>,
## #   samples.organ <fct>, specimens.id <fct>, specimens.organ <fct>,
## #   specimens.organPart <fct>, specimens.disease <fct>,
## #   specimens.preservationMethod <fct>, specimens.source <fct>,
## #   donorOrganisms.id <fct>, donorOrganisms.genusSpecies <fct>,
## #   donorOrganisms.organismAge <fct>,
## #   donorOrganisms.organismAgeUnit <fct>,
## #   donorOrganisms.organismAgeRange <fct>,
## #   donorOrganisms.biologicalSex <fct>, donorOrganisms.disease <fct>,
## #   cellSuspensions.organ <fct>, cellSuspensions.organPart <fct>,
## #   cellSuspensions.selectedCellType <fct>,
## #   cellSuspensions.totalCells <fct>, fileTypeSummaries.fileType <fct>,
## #   fileTypeSummaries.count <fct>, fileTypeSummaries.totalSize <fct>,
## #   samples.modelOrganPart <fct>, samples.modelOrgan <fct>,
## #   cellLines.id <fct>, cellLines.cellLineType <fct>,
## #   cellLines.modelOrgan <fct>, organoids.id <fct>,
## #   organoids.modelOrgan <fct>, organoids.modelOrganPart <fct>,
## #   samples.cellLineType <fct>
```

There are various columns that can be displayed in an HCAExplorer object. By
default, only a few columns are shown. We can change which columns are shown
by using `select`. For example, the following will only show
`projects.projectTitle` and `samples.organ` columns when the object as shown.

```
hca <- hca %>% select('projects.projectTitle', 'samples.organ')
hca
```

```
## class: HCAExplorer
## Using azul backend at:
##   https://service.explore.data.humancellatlas.org
##
## Donor count: 287
## Specimens: 649
## Estimated Cells: 4357497
## Files: 507981
## File Size: 26.2 Tb
##
## Showing projects with 15 results per page.# A tibble: 15 x 2
##    projects.projectTitle                    samples.organ
##    <fct>                                    <fct>
##  1 1.3 Million Brain Cells from E18 Mice    brain
##  2 A Single-Cell Transcriptomic Map of the… pancreas
##  3 A single-cell molecular map of mouse ga… embryo
##  4 A single-cell reference map of transcri… lung, mediastinal lymph node, …
##  5 A single-cell transcriptome atlas of th… eye
##  6 Assessing the relevance of organoids to… <NA>
##  7 Bone marrow plasma cells from hip repla… hematopoietic system
##  8 Cell hashing with barcoded antibodies e… blood
##  9 Census of Immune Cells                   immune system, blood
## 10 Comparison, calibration, and benchmarki… <NA>
## 11 Dissecting the human liver cellular lan… liver
## 12 HDCA project: single cell transcriptomi… cerebellum, lung, heart
## 13 Ischaemic sensitivity of human tissue b… esophagus, spleen
## 14 Melanoma infiltration of stromal and im… tumor, lymph node, skin of body
## 15 Precursors of human CD4+ cytotoxic T ly… blood
## Showing page 1 of 2
```

The original selection can be restored with `resetSelect()`

```
hca <- resetSelect(hca)
hca
```

```
## class: HCAExplorer
## Using azul backend at:
##   https://service.explore.data.humancellatlas.org
##
## Donor count: 287
## Specimens: 649
## Estimated Cells: 4357497
## Files: 507981
## File Size: 26.2 Tb
##
## Showing projects with 15 results per page.# A tibble: 15 x 7
##    projects.projec… samples.sampleE… samples.organ protocols.libra…
##    <fct>            <fct>            <fct>         <fct>
##  1 1.3 Million Bra… specimens        brain         10X v2 sequenci…
##  2 A Single-Cell T… specimens        pancreas      inDrop
##  3 A single-cell m… specimens        embryo        10X 3' v1 seque…
##  4 A single-cell r… specimens        lung, medias… 10X v2 sequenci…
##  5 A single-cell t… specimens        eye           10X v2 sequenci…
##  6 Assessing the r… organoids        <NA>          10X v2 sequenci…
##  7 Bone marrow pla… specimens        hematopoieti… MARS-seq
##  8 Cell hashing wi… specimens        blood         CITE-seq
##  9 Census of Immun… specimens        immune syste… 10X v2 sequenci…
## 10 Comparison, cal… cellLines        <NA>          Drop-Seq, DroNc…
## 11 Dissecting the … specimens        liver         10X v2 sequenci…
## 12 HDCA project: s… specimens        cerebellum, … 10x 3' v3 seque…
## 13 Ischaemic sensi… specimens        esophagus, s… 10X v2 sequenci…
## 14 Melanoma infilt… specimens        tumor, lymph… Smart-seq2
## 15 Precursors of h… specimens        blood         Smart-seq2
## # … with 3 more variables: protocols.pairedEnd <fct>,
## #   donorOrganisms.genusSpecies <fct>, samples.disease <fct>
## Showing page 1 of 2
```

To toggle whether projects, samples, or file are being displayed in the
`tibble`, the `activate()` method can be used to choose which to display.

```
## The HCAExplorer object is activated here by 'samples'
hca <- hca %>% activate('samples')
hca
```

```
## class: HCAExplorer
## Using azul backend at:
##   https://service.explore.data.humancellatlas.org
##
## Donor count: 287
## Specimens: 649
## Estimated Cells: 4357497
## Files: 507981
## File Size: 26.2 Tb
##
## Showing projects with 15 results per page.# A tibble: 15 x 12
##    samples.id projects.projec… samples.sampleE… samples.organ
##    <fct>      <fct>            <fct>            <fct>
##  1 E18_20160… 1.3 Million Bra… specimens        brain
##  2 H1_pancre… A Single-Cell T… specimens        pancreas
##  3 embryo_po… A single-cell m… specimens        embryo
##  4 PP006, PP… A single-cell r… specimens        lung, medias…
##  5 17-011-R,… A single-cell t… specimens        eye
##  6 Org_HPSI0… Assessing the r… organoids        <NA>
##  7 Hip8_spec… Bone marrow pla… specimens        hematopoieti…
##  8 Specimen_… Cell hashing wi… specimens        blood
##  9 5_BM7, 7_… Census of Immun… specimens        immune syste…
## 10 cell_line… Comparison, cal… cellLines        <NA>
## 11 P3TLH_liv… Dissecting the … specimens        liver
## 12 XDD:0600:… HDCA project: s… specimens        cerebellum, …
## 13 A12-Oes-0… Ischaemic sensi… specimens        esophagus, s…
## 14 1209_LN, … Melanoma infilt… specimens        tumor, lymph…
## 15 Subject16… Precursors of h… specimens        blood
## # … with 8 more variables: samples.organPart <fct>,
## #   cellSuspensions.selectedCellType <fct>,
## #   protocols.libraryConstructionApproach <fct>,
## #   protocols.pairedEnd <fct>, donorOrganisms.genusSpecies <fct>,
## #   donorOrganisms.organismAge <fct>, donorOrganisms.biologicalSex <fct>,
## #   samples.disease <fct>
## Showing page 1 of 2
```

```
## Revert back to showing projects with 'projects'
hca <- hca %>% activate('projects')
hca
```

```
## class: HCAExplorer
## Using azul backend at:
##   https://service.explore.data.humancellatlas.org
##
## Donor count: 287
## Specimens: 649
## Estimated Cells: 4357497
## Files: 507981
## File Size: 26.2 Tb
##
## Showing projects with 15 results per page.# A tibble: 15 x 7
##    projects.projec… samples.sampleE… samples.organ protocols.libra…
##    <fct>            <fct>            <fct>         <fct>
##  1 1.3 Million Bra… specimens        brain         10X v2 sequenci…
##  2 A Single-Cell T… specimens        pancreas      inDrop
##  3 A single-cell m… specimens        embryo        10X 3' v1 seque…
##  4 A single-cell r… specimens        lung, medias… 10X v2 sequenci…
##  5 A single-cell t… specimens        eye           10X v2 sequenci…
##  6 Assessing the r… organoids        <NA>          10X v2 sequenci…
##  7 Bone marrow pla… specimens        hematopoieti… MARS-seq
##  8 Cell hashing wi… specimens        blood         CITE-seq
##  9 Census of Immun… specimens        immune syste… 10X v2 sequenci…
## 10 Comparison, cal… cellLines        <NA>          Drop-Seq, DroNc…
## 11 Dissecting the … specimens        liver         10X v2 sequenci…
## 12 HDCA project: s… specimens        cerebellum, … 10x 3' v3 seque…
## 13 Ischaemic sensi… specimens        esophagus, s… 10X v2 sequenci…
## 14 Melanoma infilt… specimens        tumor, lymph… Smart-seq2
## 15 Precursors of h… specimens        blood         Smart-seq2
## # … with 3 more variables: protocols.pairedEnd <fct>,
## #   donorOrganisms.genusSpecies <fct>, samples.disease <fct>
## Showing page 1 of 2
```

Looking at the bottom of the output, it can be that there are more pages of
results to be shown. The next set of entries can be obtained using the
`nextResults` method.

```
hca <- nextResults(hca)
hca
```

```
## class: HCAExplorer
## Using azul backend at:
##   https://service.explore.data.humancellatlas.org
##
## Donor count: 287
## Specimens: 649
## Estimated Cells: 4357497
## Files: 507981
## File Size: 26.2 Tb
##
## Showing projects with 15 results per page.# A tibble: 15 x 7
##    projects.projec… samples.sampleE… samples.organ protocols.libra…
##    <fct>            <fct>            <fct>         <fct>
##  1 Profiling of CD… cellLines        <NA>          10X v2 sequenci…
##  2 Reconstructing … specimens        placenta, de… 10X v2 sequenci…
##  3 SS2 1 Cell Inte… specimens        kidney        Smart-seq2
##  4 Single Cell Tra… specimens        kidney        inDrop
##  5 Single cell pro… specimens, cell… embryo        10X v2 sequenci…
##  6 Single cell tra… specimens        pancreas      Smart-seq2
##  7 Single-cell RNA… cellLines        <NA>          Smart-seq2
##  8 Single-cell RNA… specimens        pancreas      Smart-seq2
##  9 Spatio-temporal… specimens        kidney        10X v2 sequenci…
## 10 Structural Remo… specimens        colon         10X 3' v2 seque…
## 11 Systematic comp… specimens        blood, brain  CEL-seq2, Smart…
## 12 Tabula Muris: T… specimens        bladder orga… Smart-seq2
## 13 The Single Cell… specimens        kidney        10X 5' v2 seque…
## 14 The emergent la… specimens        embryo, pres… 10X v2 sequenci…
## 15 Transcriptomic … specimens        eye           10x 3' v3 seque…
## # … with 3 more variables: protocols.pairedEnd <fct>,
## #   donorOrganisms.genusSpecies <fct>, samples.disease <fct>
## Showing page 2 of 2
```

## Querying the HCAExplorer

Once the HCAExplorer object is made, one can beging browsing the data present in
the Human Cell Atlas.

Suppose we would like to search projects that have samples taken from a
particular organ. First, it is helpdul to understand which fields are available
to query upon. To do this, use the `fields()` method.

```
hca <- HCAExplorer()
fields(hca)
```

```
##  [1] "organ"                       "sampleEntityType"
##  [3] "project"                     "assayType"
##  [5] "instrumentManufacturerModel" "institution"
##  [7] "donorDisease"                "organismAgeUnit"
##  [9] "organismAge"                 "pairedEnd"
## [11] "preservationMethod"          "genusSpecies"
## [13] "projectTitle"                "modelOrganPart"
## [15] "disease"                     "workflow"
## [17] "contactName"                 "effectiveOrgan"
## [19] "organPart"                   "publicationTitle"
## [21] "cellLineType"                "libraryConstructionApproach"
## [23] "biologicalSex"               "laboratory"
## [25] "projectDescription"          "selectedCellType"
## [27] "fileFormat"                  "modelOrgan"
```

This function return all possible fields that can be queried upon. We can now
see that their is a field named “organ”. Since, we are looking at what
values are avaiable for querying on organs, we can now use the `values()`
method to do just that.

```
values(hca, 'organ')
```

```
## # A tibble: 33 x 2
##    value                hits
##    <fct>                <fct>
##  1 blood                6
##  2 kidney               5
##  3 pancreas             4
##  4 brain                3
##  5 embryo               3
##  6 lung                 3
##  7 eye                  2
##  8 heart                2
##  9 hematopoietic system 2
## 10 liver                2
## # … with 23 more rows
```

We can now see all possible values of 'organ' across all project as well as
their frequency. Let's now decide that we would like to see projects that
involve either blood or brain samples. The next step is to perform the query.

The HCAExplorer extends the functionality of the *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* package's
`filter()` and `select()` methods.

The `filter()` method allows the user to query the Human Cell Atlas by relating
fields to certain values. Character fields can be queried using the operators:

* `==`
* `%in%`

Combination operators can be used to combine queries

* `&`

We can use either the `==` or `%in%` operator in a filter statement to contruct
a query.

```
hca2 <- hca %>% filter(organ == c('blood', 'brain'))
hca <- hca %>% filter(organ %in% c('blood', 'brain'))
hca
```

```
## class: HCAExplorer
## Using azul backend at:
##   https://service.explore.data.humancellatlas.org
##
## Donor count: 53
## Specimens: 161
## Estimated Cells: 1676505
## Files: 106677
## File Size: 6.8 Tb
##
## Showing projects with 15 results per page.# A tibble: 8 x 7
##   projects.projec… samples.sampleE… samples.organ protocols.libra…
##   <fct>            <fct>            <fct>         <fct>
## 1 1.3 Million Bra… specimens        brain         10X v2 sequenci…
## 2 A single-cell r… specimens        lung, medias… 10X v2 sequenci…
## 3 Cell hashing wi… specimens        blood         CITE-seq
## 4 Census of Immun… specimens        immune syste… 10X v2 sequenci…
## 5 Precursors of h… specimens        blood         Smart-seq2
## 6 Reconstructing … specimens        placenta, de… 10X v2 sequenci…
## 7 Systematic comp… specimens        blood, brain  CEL-seq2, Smart…
## 8 Tabula Muris: T… specimens        bladder orga… Smart-seq2
## # … with 3 more variables: protocols.pairedEnd <fct>,
## #   donorOrganisms.genusSpecies <fct>, samples.disease <fct>
## Showing page 1 of 1
```

Suppose we also wish to also search for results based on the disease.
We already know a “disease” field exists from our `field()` function. Now we
can see what disease values are present in our current results.

```
values(hca, 'disease')
```

```
## # A tibble: 2 x 2
##   value                         hits
##   <fct>                         <fct>
## 1 normal                        3
## 2 orofaciodigital syndrome VIII 1
```

These are the possible values only for the results of our previous search.
Now suppose we would like to search for project only that have samples with no
disease (we see through `values()` that this is labeled as “normal”). We can
now accomplish this with any of the following searchs. To show multiple
searches, we will also use the methods `undoQuery()` and `resetQuery()` to step
reset our search. `undoQuery()` can step back one or many queries.
`resetQuery()` undos all queries.

```
hca <- hca %>% filter(disease == 'normal')
hca <- undoQuery(hca, n = 2L)

hca <- hca %>% filter(organ %in% c('Brain', 'brain'), disease == 'normal')
hca <- resetQuery(hca)

hca <- hca %>% filter(organ %in% c('Brain', 'brain') & disease == 'normal')
hca
```

```
## class: HCAExplorer
## Using azul backend at:
##   https://service.explore.data.humancellatlas.org
##
## Donor count: 4
## Specimens: 4
## Estimated Cells: 1345175
## Files: 21243
## File Size: 3.1 Tb
##
## Showing projects with 15 results per page.# A tibble: 2 x 7
##   projects.projec… samples.sampleE… samples.organ protocols.libra…
##   <fct>            <fct>            <fct>         <fct>
## 1 1.3 Million Bra… specimens        brain         10X v2 sequenci…
## 2 Systematic comp… specimens        blood, brain  CEL-seq2, Smart…
## # … with 3 more variables: protocols.pairedEnd <fct>,
## #   donorOrganisms.genusSpecies <fct>, samples.disease <fct>
## Showing page 1 of 1
```

We can refine out search further by using subsetting to only include
a few results. Here, the `[` symbol can be used to select paricular rows by
either index or project name. These selections are added to our search as a
query against the “projectId”. Here we take the first two results from our
HCAExplorer object.

```
hca <- hca[1:2,]
hca
```

```
## class: HCAExplorer
## Using azul backend at:
##   https://service.explore.data.humancellatlas.org
##
## Donor count: 4
## Specimens: 4
## Estimated Cells: 1345175
## Files: 21243
## File Size: 3.1 Tb
##
## Showing projects with 15 results per page.# A tibble: 2 x 7
##   projects.projec… samples.sampleE… samples.organ protocols.libra…
##   <fct>            <fct>            <fct>         <fct>
## 1 1.3 Million Bra… specimens        brain         10X v2 sequenci…
## 2 Systematic comp… specimens        blood, brain  CEL-seq2, Smart…
## # … with 3 more variables: protocols.pairedEnd <fct>,
## #   donorOrganisms.genusSpecies <fct>, samples.disease <fct>
## Showing page 1 of 1
```

## Obtaining manifest files from the HCAExplorer

Now that we have completed our query, we can obtain the file manifest of our
selected projects. First, we must find which possible file formats are
available for download. To do this, we use the `getManifestFileFormats()`.

```
formats <- getManifestFileFormats(hca)
formats
```

```
## [1] "fastq"    "fastq.gz" "csv"      "txt"      "bam"      "results"
## [7] "matrix"   "bai"      "unknown"
```

Now that we have the possible file formats, we can download the manifest
as a `tibble`. To do this, we use the `getManifest()` method.

```
manifest <- getManifest(hca, fileFormat = formats[1])
manifest
```

```
## # A tibble: 16,377 x 42
##    bundle_uuid bundle_version      file_name file_format read_index
##    <chr>       <dttm>              <chr>     <chr>       <chr>
##  1 1585915b-6… 2019-05-16 21:18:13 E18_2016… fastq       read1
##  2 1585915b-6… 2019-05-16 21:18:13 E18_2016… fastq       index1
##  3 168c5bd1-f… 2019-05-16 21:18:13 E18_2016… fastq       read2
##  4 168c5bd1-f… 2019-05-16 21:18:13 E18_2016… fastq       index1
##  5 168c5bd1-f… 2019-05-16 21:18:13 E18_2016… fastq       read1
##  6 1656e6a7-7… 2019-05-16 21:18:13 E18_2016… fastq       index1
##  7 1656e6a7-7… 2019-05-16 21:18:13 E18_2016… fastq       read2
##  8 823ce84b-b… 2019-05-16 21:18:13 E18_2016… fastq       index1
##  9 823ce84b-b… 2019-05-16 21:18:13 E18_2016… fastq       read1
## 10 1656e6a7-7… 2019-05-16 21:18:13 E18_2016… fastq       read1
## # … with 16,367 more rows, and 37 more variables: file_size <dbl>,
## #   file_uuid <chr>, file_version <dttm>, file_sha256 <chr>,
## #   file_content_type <chr>, cell_suspension.provenance.document_id <chr>,
## #   cell_suspension.estimated_cell_count <dbl>,
## #   cell_suspension.selected_cell_type <chr>,
## #   sequencing_protocol.instrument_manufacturer_model <chr>,
## #   sequencing_protocol.paired_end <lgl>,
## #   library_preparation_protocol.library_construction_approach <chr>,
## #   project.provenance.document_id <chr>,
## #   project.contributors.institution <chr>,
## #   project.contributors.laboratory <chr>,
## #   project.project_core.project_short_name <chr>,
## #   project.project_core.project_title <chr>,
## #   specimen_from_organism.provenance.document_id <chr>,
## #   specimen_from_organism.diseases <chr>,
## #   specimen_from_organism.organ <chr>,
## #   specimen_from_organism.organ_part <chr>,
## #   specimen_from_organism.preservation_storage.preservation_method <chr>,
## #   donor_organism.sex <chr>,
## #   donor_organism.biomaterial_core.biomaterial_id <chr>,
## #   donor_organism.provenance.document_id <chr>,
## #   donor_organism.genus_species <chr>, donor_organism.diseases <chr>,
## #   donor_organism.organism_age <dbl>,
## #   donor_organism.organism_age_unit <chr>,
## #   cell_line.provenance.document_id <lgl>,
## #   cell_line.biomaterial_core.biomaterial_id <lgl>,
## #   organoid.provenance.document_id <lgl>,
## #   organoid.biomaterial_core.biomaterial_id <lgl>,
## #   organoid.model_organ <lgl>, organoid.model_organ_part <lgl>,
## #   `_entity_type` <chr>, sample.provenance.document_id <chr>,
## #   sample.biomaterial_core.biomaterial_id <chr>
```

```
sessionInfo()
```

```
## R version 3.6.1 (2019-07-05)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.10-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.10-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] HCAExplorer_1.0.0 dplyr_0.8.3       BiocStyle_2.14.0  knitr_1.25
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.2          pillar_1.4.2        compiler_3.6.1
##  [4] BiocManager_1.30.9  plyr_1.8.4          tools_3.6.1
##  [7] zeallot_0.1.0       digest_0.6.22       lifecycle_0.1.0
## [10] jsonlite_1.6        evaluate_0.14       tibble_2.1.3
## [13] pkgconfig_2.0.3     rlang_0.4.1         tidygraph_1.1.2
## [16] igraph_1.2.4.1      cli_1.1.0           curl_4.2
## [19] yaml_2.2.0          parallel_3.6.1      xfun_0.10
## [22] stringr_1.4.0       httr_1.4.1          hms_0.5.1
## [25] S4Vectors_0.24.0    vctrs_0.2.0         stats4_3.6.1
## [28] tidyselect_0.2.5    glue_1.3.1          R6_2.4.0
## [31] fansi_0.4.0         rmarkdown_1.16      readr_1.3.1
## [34] purrr_0.3.3         tidyr_1.0.0         magrittr_1.5
## [37] backports_1.1.5     htmltools_0.4.0     BiocGenerics_0.32.0
## [40] assertthat_0.2.1    utf8_1.1.4          stringi_1.4.3
## [43] crayon_1.3.4
```

# Developer notes

* The `S3` object-oriented programming paradigm is used.
* Methods from the `dplyr` package can be used to manipulate objects in the
  `HCAExplorer` package.
* In the future, we wish to expand the functionalit of this packages to cover
  the remaining functionality of the hca dcp api.