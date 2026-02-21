# HDCytoData package

Lukas M. Weber1,2 and Charlotte Soneson3,4

1Institute of Molecular Life Sciences, University of Zurich, Zurich, Switzerland
2SIB Swiss Institute of Bioinformatics, Zurich, Switzerland
3Friedrich Miescher Institute for Biomedical Research, Basel, Switzerland
4SIB Swiss Institute of Bioinformatics, Basel, Switzerland

#### 4 November 2025

#### Package

HDCytoData 1.30.0

# Contents

* [1 Overview](#overview)
* [2 Datasets](#datasets)
  + [2.1 Programmatic access to list of datasets](#programmatic-access-to-list-of-datasets)
* [3 How to load data](#how-to-load-data)
  + [3.1 Using the data](#using-the-data)
  + [3.2 Transformation of raw data](#transformation-of-raw-data)
  + [3.3 Exploring the data](#exploring-the-data)
* [4 Contribution guidelines](#contribution-guidelines)
* [5 Citation](#citation)

# 1 Overview

The `HDCytoData` package is an extensible resource containing a set of publicly available high-dimensional flow cytometry and mass cytometry (CyTOF) benchmark datasets, which have been formatted into `SummarizedExperiment` and `flowSet` Bioconductor object formats. The data objects are hosted on Bioconductor’s `ExperimentHub` platform.

The objects each contain one or more tables of cell-level expression values, as well as all required metadata. Row metadata includes sample IDs, group IDs, patient IDs, reference cell population or cluster labels (where available), and labels identifying ‘spiked in’ cells (where available). Column metadata includes channel names, protein marker names, and protein marker classes (cell type, cell state, as well as non protein marker columns).

Note that raw expression values should be transformed prior to any downstream analyses (see below).

Currently, the package includes benchmark datasets used in our previous work to evaluate methods for clustering and differential analyses. The datasets are provided here in `SummarizedExperiment` and `flowSet` formats in order to make them easier to access and integrate into R/Bioconductor workflows.

For more details, see our paper describing the `HDCytoData` package:

* [Weber L.M. and Soneson C. (2019), *HDCytoData: Collection of high-dimensional cytometry benchmark datasets in Bioconductor object formats*, F1000Research, 8:1459, v2.](https://f1000research.com/articles/8-1459)

# 2 Datasets

The package contains the following datasets, which can be grouped into datasets useful for benchmarking methods for (i) clustering, and (ii) differential analyses.

* Clustering:
  + Levine\_32dim
  + Levine\_13dim
  + Samusik\_01
  + Samusik\_all
  + Nilsson\_rare
  + Mosmann\_rare
* Differential analyses:
  + Krieg\_Anti\_PD\_1
  + Bodenmiller\_BCR\_XL
  + Weber\_AML\_sim (multiple datasets from several simulation scenarios)
  + Weber\_BCR\_XL\_sim (multiple datasets from several simulation scenarios)

Extensive documentation is available in the help files for the objects. For each dataset, this includes a description of the dataset (e.g. biological context, number of samples and conditions, number of cells, number of reference cell populations, number and classes of protein markers, etc.), as well as an explanation of the object structures, details on accessor functions required to access the expression tables and metadata, and references to original data sources.

File sizes are listed in the help files for the datasets. The `removeCache` function from the `ExperimentHub` package can be used to clear the local download cache (see `ExperimentHub` documentation).

The help files can be accessed by the dataset names, e.g. `?Bodenmiller_BCR_XL` or `help(Bodenmiller_BCR_XL)`.

## 2.1 Programmatic access to list of datasets

An updated list of all available datasets can also be obtained programmatically using the `ExperimentHub` accessor functions, as follows. This retrieves a table of metadata from the `ExperimentHub` database, which includes information such as the ExperimentHub ID, title, and description for each dataset.

```
suppressPackageStartupMessages(library(ExperimentHub))

# Create ExperimentHub instance
ehub <- ExperimentHub()

# Find HDCytoData datasets
ehub <- query(ehub, "HDCytoData")
ehub
```

```
## ExperimentHub with 56 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: NA
## # $species: Homo sapiens, Mus musculus
## # $rdataclass: flowSet, SummarizedExperiment
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH2240"]]'
##
##            title
##   EH2240 | Levine_32dim_SE
##   EH2241 | Levine_32dim_flowSet
##   EH2242 | Levine_13dim_SE
##   EH2243 | Levine_13dim_flowSet
##   EH2244 | Samusik_01_SE
##   ...      ...
##   EH3060 | Weber_BCR_XL_sim_random_seeds_rep3_flowSet
##   EH3061 | Weber_BCR_XL_sim_less_distinct_less_50pc_SE
##   EH3062 | Weber_BCR_XL_sim_less_distinct_less_50pc_flowSet
##   EH3063 | Weber_BCR_XL_sim_less_distinct_less_75pc_SE
##   EH3064 | Weber_BCR_XL_sim_less_distinct_less_75pc_flowSet
```

```
# Retrieve metadata table
md <- as.data.frame(mcols(ehub))

head(md, 2)
```

```
##                       title dataprovider      species taxonomyid genome
## EH2240      Levine_32dim_SE           NA Homo sapiens       9606   <NA>
## EH2241 Levine_32dim_flowSet           NA Homo sapiens       9606   <NA>
##                                                                                                                                                                                                                                                                                                        description
## EH2240 Mass cytometry (CyTOF) dataset from Levine et al. (2015), containing 32 dimensions (surface protein markers). Manually gated cell population labels are available for 14 populations. Cells are human bone marrow cells from 2 healthy donors. This dataset can be used to benchmark clustering algorithms.
## EH2241 Mass cytometry (CyTOF) dataset from Levine et al. (2015), containing 32 dimensions (surface protein markers). Manually gated cell population labels are available for 14 populations. Cells are human bone marrow cells from 2 healthy donors. This dataset can be used to benchmark clustering algorithms.
##        coordinate_1_based                          maintainer rdatadateadded
## EH2240                  1 Lukas M. Weber <lmweb012@gmail.com>     2019-01-15
## EH2241                  1 Lukas M. Weber <lmweb012@gmail.com>     2019-01-15
##        preparerclass         tags           rdataclass
## EH2240    HDCytoData Experime.... SummarizedExperiment
## EH2241    HDCytoData Experime....              flowSet
##                                               rdatapath
## EH2240      HDCytoData/Levine_32dim/Levine_32dim_SE.rda
## EH2241 HDCytoData/Levine_32dim/Levine_32dim_flowSet.rda
##                                                   sourceurl sourcetype
## EH2240 http://imlspenticton.uzh.ch/robinson_lab/HDCytoData/        FCS
## EH2241 http://imlspenticton.uzh.ch/robinson_lab/HDCytoData/        FCS
```

# 3 How to load data

This section shows how to load the datasets, using one of the datasets (`Bodenmiller_BCR_XL`) as an example.

The datasets can be loaded by either (i) referring to named functions for each dataset, or (ii) creating an `ExperimentHub` instance and referring to the dataset IDs. Both methods are demonstrated below.

See the help files (e.g. `?Bodenmiller_BCR_XL`) for details about the structure of the `SummarizedExperiment` or `flowSet` objects.

Load the datasets using named functions:

```
suppressPackageStartupMessages(library(HDCytoData))

# Load 'SummarizedExperiment' object using named function
Bodenmiller_BCR_XL_SE()
```

```
## see ?HDCytoData and browseVignettes('HDCytoData') for documentation
```

```
## loading from cache
```

```
## class: SummarizedExperiment
## dim: 172791 35
## metadata(2): experiment_info n_cells
## assays(1): exprs
## rownames: NULL
## rowData names(4): group_id patient_id sample_id population_id
## colnames(35): Time Cell_length ... DNA-1 DNA-2
## colData names(3): channel_name marker_name marker_class
```

```
# Load 'flowSet' object using named function
Bodenmiller_BCR_XL_flowSet()
```

```
## see ?HDCytoData and browseVignettes('HDCytoData') for documentation
## loading from cache
```

```
## Warning in updateObjectFromSlots(object, ..., verbose = verbose): dropping
## slot(s) 'colnames' from object = 'flowSet'
```

```
## A flowSet with 16 experiments.
##
## column names(39): Time Cell_length ... sample_id population_id
```

Alternatively, load the datasets by creating an `ExperimentHub` instance:

```
# Create ExperimentHub instance
ehub <- ExperimentHub()

# Find HDCytoData datasets
query(ehub, "HDCytoData")
```

```
## ExperimentHub with 56 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: NA
## # $species: Homo sapiens, Mus musculus
## # $rdataclass: flowSet, SummarizedExperiment
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH2240"]]'
##
##            title
##   EH2240 | Levine_32dim_SE
##   EH2241 | Levine_32dim_flowSet
##   EH2242 | Levine_13dim_SE
##   EH2243 | Levine_13dim_flowSet
##   EH2244 | Samusik_01_SE
##   ...      ...
##   EH3060 | Weber_BCR_XL_sim_random_seeds_rep3_flowSet
##   EH3061 | Weber_BCR_XL_sim_less_distinct_less_50pc_SE
##   EH3062 | Weber_BCR_XL_sim_less_distinct_less_50pc_flowSet
##   EH3063 | Weber_BCR_XL_sim_less_distinct_less_75pc_SE
##   EH3064 | Weber_BCR_XL_sim_less_distinct_less_75pc_flowSet
```

```
# Load 'SummarizedExperiment' object using dataset ID
ehub[["EH2254"]]
```

```
## see ?HDCytoData and browseVignettes('HDCytoData') for documentation
```

```
## loading from cache
```

```
## class: SummarizedExperiment
## dim: 172791 35
## metadata(2): experiment_info n_cells
## assays(1): exprs
## rownames: NULL
## rowData names(4): group_id patient_id sample_id population_id
## colnames(35): Time Cell_length ... DNA-1 DNA-2
## colData names(3): channel_name marker_name marker_class
```

```
# Load 'flowSet' object using dataset ID
ehub[["EH2255"]]
```

```
## see ?HDCytoData and browseVignettes('HDCytoData') for documentation
## loading from cache
```

```
## Warning in updateObjectFromSlots(object, ..., verbose = verbose): dropping
## slot(s) 'colnames' from object = 'flowSet'
```

```
## A flowSet with 16 experiments.
##
## column names(39): Time Cell_length ... sample_id population_id
```

## 3.1 Using the data

Once the datasets have been loaded from `ExperimentHub`, they can be used as normal within an R session. For example, using the `SummarizedExperiment` form of the dataset loaded above:

```
# Load dataset in 'SummarizedExperiment' format
d_SE <- Bodenmiller_BCR_XL_SE()
```

```
## see ?HDCytoData and browseVignettes('HDCytoData') for documentation
```

```
## loading from cache
```

```
# Inspect object
d_SE
```

```
## class: SummarizedExperiment
## dim: 172791 35
## metadata(2): experiment_info n_cells
## assays(1): exprs
## rownames: NULL
## rowData names(4): group_id patient_id sample_id population_id
## colnames(35): Time Cell_length ... DNA-1 DNA-2
## colData names(3): channel_name marker_name marker_class
```

```
length(assays(d_SE))
```

```
## [1] 1
```

```
assay(d_SE)[1:6, 1:6]
```

```
##       Time Cell_length        CD3     CD45       BC1        BC2
## [1,] 33073          30 120.823265 454.6009  576.8983 10.0057297
## [2,] 36963          35 135.106171 624.6824  564.6299  5.5991135
## [3,] 37892          30  -1.664619 601.0125 3077.2668  1.7105789
## [4,] 41345          58 115.290245 820.7125 6088.5967 22.5641403
## [5,] 42475          35  14.373802 326.6405 4606.6929 -0.6584854
## [6,] 44620          31  37.737877 557.0137 4854.1519 -0.4517288
```

```
rowData(d_SE)
```

```
## DataFrame with 172791 rows and 4 columns
##         group_id patient_id          sample_id population_id
##         <factor>   <factor>           <factor>      <factor>
## 1         BCR-XL   patient1    patient1_BCR-XL   CD4 T-cells
## 2         BCR-XL   patient1    patient1_BCR-XL   CD4 T-cells
## 3         BCR-XL   patient1    patient1_BCR-XL   NK cells
## 4         BCR-XL   patient1    patient1_BCR-XL   CD4 T-cells
## 5         BCR-XL   patient1    patient1_BCR-XL   CD8 T-cells
## ...          ...        ...                ...           ...
## 172787 Reference   patient8 patient8_Reference   CD8 T-cells
## 172788 Reference   patient8 patient8_Reference   CD4 T-cells
## 172789 Reference   patient8 patient8_Reference   CD4 T-cells
## 172790 Reference   patient8 patient8_Reference   CD4 T-cells
## 172791 Reference   patient8 patient8_Reference   CD8 T-cells
```

```
colData(d_SE)
```

```
## DataFrame with 35 rows and 3 columns
##                channel_name marker_name marker_class
##                 <character> <character>     <factor>
## Time                   Time        Time         none
## Cell_length     Cell_length Cell_length         none
## CD3          CD3(110:114)Dd         CD3         type
## CD45          CD45(In115)Dd        CD45         type
## BC1            BC1(La139)Dd         BC1         none
## ...                     ...         ...          ...
## HLA-DR      HLA-DR(Yb174)Dd      HLA-DR         type
## BC7            BC7(Lu175)Dd         BC7         none
## CD7            CD7(Yb176)Dd         CD7         type
## DNA-1        DNA-1(Ir191)Dd       DNA-1         none
## DNA-2        DNA-2(Ir193)Dd       DNA-2         none
```

```
metadata(d_SE)
```

```
## $experiment_info
##     group_id patient_id          sample_id
## 1     BCR-XL   patient1    patient1_BCR-XL
## 2  Reference   patient1 patient1_Reference
## 3     BCR-XL   patient2    patient2_BCR-XL
## 4  Reference   patient2 patient2_Reference
## 5     BCR-XL   patient3    patient3_BCR-XL
## 6  Reference   patient3 patient3_Reference
## 7     BCR-XL   patient4    patient4_BCR-XL
## 8  Reference   patient4 patient4_Reference
## 9     BCR-XL   patient5    patient5_BCR-XL
## 10 Reference   patient5 patient5_Reference
## 11    BCR-XL   patient6    patient6_BCR-XL
## 12 Reference   patient6 patient6_Reference
## 13    BCR-XL   patient7    patient7_BCR-XL
## 14 Reference   patient7 patient7_Reference
## 15    BCR-XL   patient8    patient8_BCR-XL
## 16 Reference   patient8 patient8_Reference
##
## $n_cells
##    patient1_BCR-XL patient1_Reference    patient2_BCR-XL patient2_Reference
##               2838               2739              16675              16725
##    patient3_BCR-XL patient3_Reference    patient4_BCR-XL patient4_Reference
##              12252               9434               8990               6906
##    patient5_BCR-XL patient5_Reference    patient6_BCR-XL patient6_Reference
##               8543              11962               8622              11038
##    patient7_BCR-XL patient7_Reference    patient8_BCR-XL patient8_Reference
##              14770              15974              11653              13670
```

## 3.2 Transformation of raw data

Note that flow and mass cytometry data should be transformed prior to performing any downstream analyses, such as clustering. Standard transformations include the `asinh` with `cofactor` parameter equal to 5 for mass cytometry (CyTOF) data, or 150 for flow cytometry data (see Bendall et al. 2011, Supplementary Figure S2).

## 3.3 Exploring the data

Interactive visualizations to explore the datasets can be generated from the `SummarizedExperiment` objects using the [iSEE](http://bioconductor.org/packages/iSEE) (“Interactive SummarizedExperiment Explorer”) package, available from Bioconductor (Soneson, Lun, Marini, and Rue-Albrecht, 2018), which provides a Shiny-based graphical user interface to explore single-cell datasets stored in the `SummarizedExperiment` format. For more details, see the `iSEE` package vignettes.

# 4 Contribution guidelines

We welcome contributions or suggestions for new datasets to include in the `HDCytoData` package. Contribution guidelines are provided in the [Contribution guidelines](http://bioconductor.org/packages/release/data/experiment/vignettes/HDCytoData/inst/doc/Contribution_%20_guidelines.html) vignette, available from [Bioconductor](http://bioconductor.org/packages/HDCytoData).

# 5 Citation

If the `HDCytoData` package is useful in your work, please cite the following paper:

* [Weber L.M. and Soneson C. (2019), *HDCytoData: Collection of high-dimensional cytometry benchmark datasets in Bioconductor object formats*, F1000Research, 8:1459, v2.](https://f1000research.com/articles/8-1459)