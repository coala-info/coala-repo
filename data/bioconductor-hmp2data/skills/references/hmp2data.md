# HMP2Data

John Stansfield1, Ekaterina Smirnova1, Ni Zhao2, Jennifer Fettweis1, Levi Waldron3,4 and Mikhail Dozmorov1

1Virginia Commonwealth University, Richmond, VA
2The Johns Hopkins University, Baltimore, MD
3Graduate School of Public Health and Health Policy, City University of New York, New York, NY
4Institute for Implementation Science in Population Health, City University of New York, New York, NY

#### November 4, 2025

#### Abstract

HMP2Data is a Bioconductor package providing the data of the integrative Human Microbiome Project (iHMP), also known as the second phase of HMP project (HMP2). It contains 16S rRNA sequencing data from three longitudinal studies, 1) MOMS-PI, pregnancy and preterm birth; 2) IBD, gut disease onset, inflammatory bowel disease; and 3) T2D, onset of type 2 diabetes and respiratory viral infection. Where available, other data is also provided, such as cytokine measures. Raw data files were downloaded from the HMP Data Analysis and Coordination Center. Processed data is provided as matrices, SummarizedExperiment, MultiAssayExperiment, and phyloseq class objects.

#### Package

HMP2Data 1.24.0

# Contents

* [1 Prerequisites](#prerequisites)
* [2 MOMS-PI](#moms-pi)
  + [2.1 16S data](#s-data)
  + [2.2 Cytokine data](#cytokine-data)
  + [2.3 MultiAssayExperiment](#multiassayexperiment)
    - [2.3.1 Subsetting the MultiAssayExperiment object](#subsetting-the-multiassayexperiment-object)
* [3 IBD](#ibd)
* [4 T2D](#t2d)
* [5 Features](#features)
  + [5.1 Frequency Table Generation](#frequency-table-generation)
  + [5.2 Visits Histograms](#visits-histograms)
  + [5.3 UpsetR plots](#upsetr-plots)
    - [5.3.1 MOMS-PI 16S rRNA data](#moms-pi-16s-rrna-data)
    - [5.3.2 MOMS-PI Cytokines data](#moms-pi-cytokines-data)
    - [5.3.3 IBD data](#ibd-data)
    - [5.3.4 T2D data](#t2d-data)
* [6 Exporting Data to CSV Format](#exporting-data-to-csv-format)
  + [6.1 Preparing the data](#preparing-the-data)
  + [6.2 Save data as CSV](#save-data-as-csv)
* [7 Session Info](#session-info)

# 1 Prerequisites

`HMP2Data` can be installed using `BiocManager` as follows.

```
# Check if BiocManager is installed
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
# Install HMP2Data package using BiocManager
BiocManager::install("HMP2Data")
```

Or the development version of the package can be installed from GitHub as shown below.

```
BiocManager::install("jstansfield0/HMP2Data")
```

The following packages will be used in this vignette to provide demonstrative
examples of what a user might do with *[HMP2Data](https://bioconductor.org/packages/3.22/HMP2Data)*.

```
library(HMP2Data)
library(phyloseq)
library(SummarizedExperiment)
library(MultiAssayExperiment)
library(dplyr)
library(ggplot2)
library(UpSetR)
```

Once installed, `HMP2Data` provides functions to access the HMP2 data.

# 2 MOMS-PI

The MOMS-PI data can be loaded as follows.

## 2.1 16S data

Load 16S data as a matrix, rows are Greengene IDs, columns are sample names:

```
data("momspi16S_mtx")
momspi16S_mtx[1:5, 1:3]
#>        EP003595_K10_MV1D EP003595_K100_BRCD EP003595_K90_BCKD
#> 807795                20                  0                 0
#> 134726                 1                  0                 0
#> 215097                 2                  0                 0
#> 542066                 1                  0                 0
#> 851634                 1                  0                 0
```

Load the Greengenes taxonomy table as a matrix, rows are Greengene IDs, columns are taxonomic ranks:

```
data("momspi16S_tax")
colnames(momspi16S_tax)
#> [1] "Kingdom" "Phylum"  "Class"   "Order"   "Family"  "Genus"   "Species"
momspi16S_tax[1:5, 1:3]
#>        Kingdom    Phylum           Class
#> 807795 "Bacteria" "Firmicutes"     "Bacilli"
#> 134726 "Bacteria" "Firmicutes"     "Bacilli"
#> 215097 "Bacteria" "Proteobacteria" "Betaproteobacteria"
#> 542066 "Bacteria" "Actinobacteria" "Actinobacteria"
#> 851634 "Bacteria" "Bacteroidetes"  "Bacteroidia"
```

Load the 16S sample annotation data as a matrix, rows are samples, columns are annotations:

```
data("momspi16S_samp")
colnames(momspi16S_samp)
#>  [1] "file_id"          "md5"              "size"             "urls"
#>  [5] "sample_id"        "file_name"        "subject_id"       "sample_body_site"
#>  [9] "visit_number"     "subject_gender"   "subject_race"     "study_full_name"
#> [13] "project_name"
momspi16S_samp[1:5, 1:3]
#>                                             file_id
#> EP003595_K10_MV1D  e50d0c183689e4053ccb35f8b21a49f3
#> EP003595_K100_BRCD e50d0c183689e4053ccb35f8b2764c15
#> EP003595_K90_BCKD  e50d0c183689e4053ccb35f8b21cadf2
#> EP003595_K90_BRCD  e50d0c183689e4053ccb35f8b220d6c8
#> EP004835_K10_MCKD  6d91411d5ede0689305232cc77a70550
#>                                                 md5   size
#> EP003595_K10_MV1D  414907dbe12def470ca5395c6ac52947  45248
#> EP003595_K100_BRCD 90fa414ae826af7ed836e26d34244e2c  41152
#> EP003595_K90_BCKD  46516ead384e98552532f8980c9db06c  37056
#> EP003595_K90_BRCD  eea4e103b75e2dc94e1a0657840e3edc  37056
#> EP004835_K10_MCKD  3b0b16edee96c3d3429408140c2a7f0e 105809
# Check if sample names match between the 16S and sample data
# all.equal(colnames(momspi16S_mtx), rownames(momspi16S_samp)) # Should be TRUE
```

The `momspi16S` function assembles those matrices into a `phyloseq` object.

```
momspi16S_phyloseq <- momspi16S()
momspi16S_phyloseq
#> phyloseq-class experiment-level object
#> otu_table()   OTU Table:         [ 7665 taxa and 9107 samples ]
#> sample_data() Sample Data:       [ 9107 samples by 13 sample variables ]
#> tax_table()   Taxonomy Table:    [ 7665 taxa by 7 taxonomic ranks ]
```

Here we have a `phyloseq` object containing the 16S rRNA seq data for 7665 taxa and 9107 samples.

## 2.2 Cytokine data

The MOMS-PI cytokine data can be loaded as a matrix, rownames are cytokine names, colnames are sample names:

```
data("momspiCyto_mtx")
momspiCyto_mtx[1:5, 1:5]
#>         EP004835_K10_MVAX EP004835_K20_MVAX EP004835_K30_MVAX EP004835_K40_MVAX
#> Eotaxin             68.05             60.08             37.84             31.87
#> FGF                265.45             -2.00             -2.00            108.76
#> G-CSF              624.79           2470.70             -2.00             -2.00
#> GM-CSF              51.39             -2.00             42.01             28.75
#> IFN-g              164.58            193.22            184.53            185.97
#>         EP004835_K50_MVAX
#> Eotaxin             23.75
#> FGF                 78.31
#> G-CSF               -2.00
#> GM-CSF              -2.00
#> IFN-g              116.39
```

The cytokine data has 29 rows and 1396 columns.

Load the cytokine sample annotation data as a matrix, rows are samples, columns are annotations:

```
data("momspiCyto_samp")
colnames(momspiCyto_samp)
#>  [1] "file_id"          "md5"              "size"             "urls"
#>  [5] "sample_id"        "file_name"        "subject_id"       "sample_body_site"
#>  [9] "visit_number"     "subject_gender"   "subject_race"     "study_full_name"
#> [13] "project_name"
momspiCyto_samp[1:5, 1:5]
#>                                            file_id
#> EP004835_K10_MVAX 31b14547707f47bb99f1e1ab41000829
#> EP004835_K20_MVAX 31b14547707f47bb99f1e1ab41000b86
#> EP004835_K30_MVAX 31b14547707f47bb99f1e1ab41001aa5
#> EP004835_K40_MVAX 31b14547707f47bb99f1e1ab4100223f
#> EP004835_K50_MVAX 31b14547707f47bb99f1e1ab41002bf4
#>                                                md5 size
#> EP004835_K10_MVAX 006d9076e88889e231fed6866f8743d8  409
#> EP004835_K20_MVAX 6cbbebbc9da2efdcf7280f3ebd00a897  409
#> EP004835_K30_MVAX f8c5541931022f8a32ed511d7ceeee75  401
#> EP004835_K40_MVAX a8478ba7c7bd1bd721fdc570e8879139  394
#> EP004835_K50_MVAX 36a8c5ba1490ba7132e2bfaaaf391283  392
#>                                                                                                         urls
#> EP004835_K10_MVAX fasp://aspera.ihmpdcc.org/ptb/cytokine/host/analysis/EP004835_K10_MVAX.CytokineProfile.txt
#> EP004835_K20_MVAX fasp://aspera.ihmpdcc.org/ptb/cytokine/host/analysis/EP004835_K20_MVAX.CytokineProfile.txt
#> EP004835_K30_MVAX fasp://aspera.ihmpdcc.org/ptb/cytokine/host/analysis/EP004835_K30_MVAX.CytokineProfile.txt
#> EP004835_K40_MVAX fasp://aspera.ihmpdcc.org/ptb/cytokine/host/analysis/EP004835_K40_MVAX.CytokineProfile.txt
#> EP004835_K50_MVAX fasp://aspera.ihmpdcc.org/ptb/cytokine/host/analysis/EP004835_K50_MVAX.CytokineProfile.txt
#>                                          sample_id
#> EP004835_K10_MVAX 6791a23c10c0086065c25315502e9555
#> EP004835_K20_MVAX 6791a23c10c0086065c25315502e9854
#> EP004835_K30_MVAX 6791a23c10c0086065c25315502e9908
#> EP004835_K40_MVAX 6791a23c10c0086065c25315502e9e9d
#> EP004835_K50_MVAX 6791a23c10c0086065c25315502ea468
```

The function `momspiCytokines` will make a `SummarizedExperiment` containing cytokine data

```
momspiCyto <- momspiCytokines()
momspiCyto
#> class: SummarizedExperiment
#> dim: 29 1396
#> metadata(0):
#> assays(1): ''
#> rownames(29): Eotaxin FGF ... FGF basic IL-17
#> rowData names(1): cytokine
#> colnames(1396): EP004835_K10_MVAX EP004835_K20_MVAX ...
#>   EP996091_K40_MVAX EP996091_K60_MVAX
#> colData names(13): file_id md5 ... study_full_name project_name
```

The cytokine data contains data for 29 cytokines over 1396 samples.

## 2.3 MultiAssayExperiment

We can construct a `MultiAssayExperiment` that will contain 16S and cytokine data for the common samples. Use the `momspiMultiAssay` function.

```
momspiMA <- momspiMultiAssay()
momspiMA
#> A MultiAssayExperiment object of 2 listed
#>  experiments with user-defined names and respective classes.
#>  Containing an ExperimentList class object of length 2:
#>  [1] 16S: matrix with 7665 rows and 9107 columns
#>  [2] cytokines: matrix with 29 rows and 1396 columns
#> Functionality:
#>  experiments() - obtain the ExperimentList instance
#>  colData() - the primary/phenotype DataFrame
#>  sampleMap() - the sample coordination DataFrame
#>  `$`, `[`, `[[` - extract colData columns, subset, or experiment
#>  *Format() - convert into a long or wide DataFrame
#>  assays() - convert ExperimentList to a SimpleList of matrices
#>  exportClass() - save data to flat files
```

### 2.3.1 Subsetting the MultiAssayExperiment object

The 16S rRNA data can be extracted from the MultiAssayExperiment object as follows.

```
rRNA <- momspiMA[[1L]]
```

Or the cytokines data like so.

```
cyto <- momspiMA[[2L]]
```

The sample data can be accessed with the `colData` command.

```
colData(momspiMA) %>% head()
#> DataFrame with 6 rows and 12 columns
#>                                   file_id                    md5      size
#>                               <character>            <character> <integer>
#> EP003595_K10_MV1D  e50d0c183689e4053ccb.. 414907dbe12def470ca5..     45248
#> EP003595_K100_BRCD e50d0c183689e4053ccb.. 90fa414ae826af7ed836..     41152
#> EP003595_K90_BCKD  e50d0c183689e4053ccb.. 46516ead384e98552532..     37056
#> EP003595_K90_BRCD  e50d0c183689e4053ccb.. eea4e103b75e2dc94e1a..     37056
#> EP004835_K10_MCKD  6d91411d5ede06893052.. 3b0b16edee96c3d34294..    105809
#> EP004835_K10_MRCD  6d91411d5ede06893052.. 5825f20630620036d9be..    128316
#>                                      urls              sample_id
#>                               <character>            <character>
#> EP003595_K10_MV1D  http://downloads.hmp.. 8938ac880f194a32bc6b..
#> EP003595_K100_BRCD http://downloads.hmp.. 8938ac880f194a32bc6b..
#> EP003595_K90_BCKD  http://downloads.hmp.. 8938ac880f194a32bc6b..
#> EP003595_K90_BRCD  http://downloads.hmp.. 8938ac880f194a32bc6b..
#> EP004835_K10_MCKD  http://downloads.hmp.. e50d0c183689e4053ccb..
#> EP004835_K10_MRCD  http://downloads.hmp.. e50d0c183689e4053ccb..
#>                                subject_id sample_body_site visit_number
#>                               <character>      <character>    <integer>
#> EP003595_K10_MV1D  858ed4564f11795ec13d..           vagina            1
#> EP003595_K100_BRCD 858ed4564f11795ec13d..           rectum           10
#> EP003595_K90_BCKD  858ed4564f11795ec13d..    buccal mucosa            9
#> EP003595_K90_BRCD  858ed4564f11795ec13d..           rectum            9
#> EP004835_K10_MCKD  e50d0c183689e4053ccb..    buccal mucosa            1
#> EP004835_K10_MRCD  e50d0c183689e4053ccb..           rectum            1
#>                    subject_gender subject_race study_full_name
#>                       <character>  <character>     <character>
#> EP003595_K10_MV1D          female      unknown          momspi
#> EP003595_K100_BRCD         female      unknown          momspi
#> EP003595_K90_BCKD          female      unknown          momspi
#> EP003595_K90_BRCD          female      unknown          momspi
#> EP004835_K10_MCKD          female      unknown          momspi
#> EP004835_K10_MRCD          female      unknown          momspi
#>                              project_name
#>                               <character>
#> EP003595_K10_MV1D  Integrative Human Mi..
#> EP003595_K100_BRCD Integrative Human Mi..
#> EP003595_K90_BCKD  Integrative Human Mi..
#> EP003595_K90_BRCD  Integrative Human Mi..
#> EP004835_K10_MCKD  Integrative Human Mi..
#> EP004835_K10_MRCD  Integrative Human Mi..
```

To extract only the samples with both 16S and cytokine data we can use the `intersectColumns` function.

```
completeMA <- intersectColumns(momspiMA)
completeMA
#> A MultiAssayExperiment object of 2 listed
#>  experiments with user-defined names and respective classes.
#>  Containing an ExperimentList class object of length 2:
#>  [1] 16S: matrix with 7665 rows and 0 columns
#>  [2] cytokines: matrix with 29 rows and 0 columns
#> Functionality:
#>  experiments() - obtain the ExperimentList instance
#>  colData() - the primary/phenotype DataFrame
#>  sampleMap() - the sample coordination DataFrame
#>  `$`, `[`, `[[` - extract colData columns, subset, or experiment
#>  *Format() - convert into a long or wide DataFrame
#>  assays() - convert ExperimentList to a SimpleList of matrices
#>  exportClass() - save data to flat files
```

# 3 IBD

Load 16S data as a matrix, rows are SILVA IDs, columns are sample names:

```
data("IBD16S_mtx")
IBD16S_mtx[1:5, 1:5]
#>          206534 206536 206538 206547 206548
#> IP8BSoli      0      0      0      0      0
#> UncTepi3      0      0      0      0      0
#> Unc004ii      0      0      0      0      0
#> Unc00re8      3      3      0      0      0
#> Unc018j2      0      0      0      0      0
```

Load the SILVA taxonomy table as a matrix, rows are SILVA IDs, columns are taxonomic ranks:

```
data("IBD16S_tax")
colnames(IBD16S_tax)
#> [1] "Kingdom" "Phylum"  "Class"   "Order"   "Family"  "Genus"
IBD16S_tax[1:5, 1:5]
#>          Kingdom    Phylum           Class                 Order
#> IP8BSoli "Bacteria" "Proteobacteria" "Alphaproteobacteria" "Rhodospirillales"
#> UncTepi3 "Bacteria" "Proteobacteria" "Betaproteobacteria"  "Burkholderiales"
#> Unc004ii "Bacteria" "Firmicutes"     "Clostridia"          "Clostridiales"
#> Unc00re8 "Bacteria" "Bacteroidetes"  "Bacteroidia"         "Bacteroidales"
#> Unc018j2 "Bacteria" "Firmicutes"     "Clostridia"          "Clostridiales"
#>          Family
#> IP8BSoli "Acetobacteraceae"
#> UncTepi3 "Comamonadaceae"
#> Unc004ii "Christensenellaceae"
#> Unc00re8 "Prevotellaceae"
#> Unc018j2 "FamilyXIII"
```

Load the 16S sample annotation data as a matrix, rows are samples, columns are annotations:

```
data("IBD16S_samp")
colnames(IBD16S_samp) %>% head()
#> [1] "Project"       "sample_id"     "subject_id"    "site_sub_coll"
#> [5] "data_type"     "week_num"
IBD16S_samp[1:5, 1:5]
#>             Project sample_id subject_id site_sub_coll  data_type
#> 206534 M2008CSC3_BP    206534      M2008     M2008CSC3 biopsy_16S
#> 206536 M2008CSC1_BP    206536      M2008     M2008CSC1 biopsy_16S
#> 206538 M2008CSC2_BP    206538      M2008     M2008CSC2 biopsy_16S
#> 206547 M2014CSC2_BP    206547      M2014     M2014CSC2 biopsy_16S
#> 206548 M2014CSC1_BP    206548      M2014     M2014CSC1 biopsy_16S
```

The IBD `phyloseq` object can be loaded as follows.

```
IBD <- IBD16S()
IBD
#> phyloseq-class experiment-level object
#> otu_table()   OTU Table:         [ 982 taxa and 178 samples ]
#> sample_data() Sample Data:       [ 178 samples by 490 sample variables ]
#> tax_table()   Taxonomy Table:    [ 982 taxa by 6 taxonomic ranks ]
```

# 4 T2D

Load 16S data as a matrix, rows are Greengene IDs, columns are sample names:

```
data("T2D16S_mtx")
T2D16S_mtx[1:5, 1:5]
#>        HMP2_J00825_1_ST_T0_B0_0120_ZN9YTFN-01_AA31J
#> 198059                                            4
#> 985239                                            2
#> 840914                                          256
#> 174924                                            7
#> 180898                                            2
#>        HMP2_J00826_1_ST_T0_B0_0120_ZN9YTFN-1011_AA31J
#> 198059                                              0
#> 985239                                              1
#> 840914                                           5870
#> 174924                                              2
#> 180898                                              0
#>        HMP2_J00827_1_ST_T0_B0_0120_ZN9YTFN-1012_AA31J
#> 198059                                              2
#> 985239                                              0
#> 840914                                           2759
#> 174924                                              0
#> 180898                                              0
#>        HMP2_J00828_1_ST_T0_B0_0120_ZN9YTFN-1013_AA31J
#> 198059                                              0
#> 985239                                              0
#> 840914                                           6733
#> 174924                                              2
#> 180898                                              0
#>        HMP2_J00829_1_ST_T0_B0_0120_ZN9YTFN-1014_AA31J
#> 198059                                              2
#> 985239                                              1
#> 840914                                           3028
#> 174924                                              4
#> 180898                                              2
```

Load the Greengenes taxonomy table as a matrix, rows are Greengene IDs, columns are taxonomic ranks:

```
data("T2D16S_tax")
colnames(T2D16S_tax)
#> [1] "Kingdom" "Phylum"  "Class"   "Order"   "Family"  "Genus"   "Species"
T2D16S_tax[1:5, 1:5]
#>        Kingdom    Phylum          Class         Order
#> 198059 "Bacteria" "Firmicutes"    "Clostridia"  "Clostridiales"
#> 985239 "Bacteria" "Firmicutes"    "Clostridia"  "Clostridiales"
#> 840914 "Bacteria" "Bacteroidetes" "Bacteroidia" "Bacteroidales"
#> 174924 "Bacteria" "Firmicutes"    "Clostridia"  "Clostridiales"
#> 180898 "Bacteria" "Firmicutes"    "Clostridia"  "Clostridiales"
#>        Family
#> 198059 "Lachnospiraceae"
#> 985239 "Lachnospiraceae"
#> 840914 "Prevotellaceae"
#> 174924 "Ruminococcaceae"
#> 180898 "Lachnospiraceae"
```

Load the 16S sample annotation data as a matrix, rows are samples, columns are annotations:

```
data("T2D16S_samp")
colnames(T2D16S_samp)
#>  [1] "file_id"          "md5"              "size"             "urls"
#>  [5] "sample_id"        "file_name"        "subject_id"       "sample_body_site"
#>  [9] "visit_number"     "subject_gender"   "subject_race"     "study_full_name"
#> [13] "project_name"
T2D16S_samp[1:5, 1:5]
#>                                                                         file_id
#> HMP2_J00825_1_ST_T0_B0_0120_ZN9YTFN-01_AA31J   6cca313bce90a4392c3d5cf23fdb43db
#> HMP2_J00826_1_ST_T0_B0_0120_ZN9YTFN-1011_AA31J 6cca313bce90a4392c3d5cf23fda16c7
#> HMP2_J00827_1_ST_T0_B0_0120_ZN9YTFN-1012_AA31J 6cca313bce90a4392c3d5cf23fd946a5
#> HMP2_J00828_1_ST_T0_B0_0120_ZN9YTFN-1013_AA31J 6cca313bce90a4392c3d5cf23fdb6783
#> HMP2_J00829_1_ST_T0_B0_0120_ZN9YTFN-1014_AA31J 6cca313bce90a4392c3d5cf23fdaa426
#>                                                                             md5
#> HMP2_J00825_1_ST_T0_B0_0120_ZN9YTFN-01_AA31J   52ae217fbb3b5888906574e7c0eda10a
#> HMP2_J00826_1_ST_T0_B0_0120_ZN9YTFN-1011_AA31J f7f85c444703ec4259d5358e2662fe72
#> HMP2_J00827_1_ST_T0_B0_0120_ZN9YTFN-1012_AA31J 4b9bf6bf9cc0e62372ecb73ebd303cae
#> HMP2_J00828_1_ST_T0_B0_0120_ZN9YTFN-1013_AA31J 30251158c0b00b8d15f0027786cad84d
#> HMP2_J00829_1_ST_T0_B0_0120_ZN9YTFN-1014_AA31J 8584c0c7319c3ac7654a3cf022329f95
#>                                                 size
#> HMP2_J00825_1_ST_T0_B0_0120_ZN9YTFN-01_AA31J   96000
#> HMP2_J00826_1_ST_T0_B0_0120_ZN9YTFN-1011_AA31J 86000
#> HMP2_J00827_1_ST_T0_B0_0120_ZN9YTFN-1012_AA31J 83000
#> HMP2_J00828_1_ST_T0_B0_0120_ZN9YTFN-1013_AA31J 98000
#> HMP2_J00829_1_ST_T0_B0_0120_ZN9YTFN-1014_AA31J 89000
#>                                                                                                                                                                  urls
#> HMP2_J00825_1_ST_T0_B0_0120_ZN9YTFN-01_AA31J     fasp://aspera.ihmpdcc.org/t2d/genome/microbiome/16s/analysis/hmqcp/HMP2_J00825_1_ST_T0_B0_0120_ZN9YTFN-01_AA31J.biom
#> HMP2_J00826_1_ST_T0_B0_0120_ZN9YTFN-1011_AA31J fasp://aspera.ihmpdcc.org/t2d/genome/microbiome/16s/analysis/hmqcp/HMP2_J00826_1_ST_T0_B0_0120_ZN9YTFN-1011_AA31J.biom
#> HMP2_J00827_1_ST_T0_B0_0120_ZN9YTFN-1012_AA31J fasp://aspera.ihmpdcc.org/t2d/genome/microbiome/16s/analysis/hmqcp/HMP2_J00827_1_ST_T0_B0_0120_ZN9YTFN-1012_AA31J.biom
#> HMP2_J00828_1_ST_T0_B0_0120_ZN9YTFN-1013_AA31J fasp://aspera.ihmpdcc.org/t2d/genome/microbiome/16s/analysis/hmqcp/HMP2_J00828_1_ST_T0_B0_0120_ZN9YTFN-1013_AA31J.biom
#> HMP2_J00829_1_ST_T0_B0_0120_ZN9YTFN-1014_AA31J fasp://aspera.ihmpdcc.org/t2d/genome/microbiome/16s/analysis/hmqcp/HMP2_J00829_1_ST_T0_B0_0120_ZN9YTFN-1014_AA31J.biom
#>                                                                       sample_id
#> HMP2_J00825_1_ST_T0_B0_0120_ZN9YTFN-01_AA31J   932d8fbc70ae8f856028b3f67c4ef6ac
#> HMP2_J00826_1_ST_T0_B0_0120_ZN9YTFN-1011_AA31J 932d8fbc70ae8f856028b3f67c4f0716
#> HMP2_J00827_1_ST_T0_B0_0120_ZN9YTFN-1012_AA31J 932d8fbc70ae8f856028b3f67c4f21b0
#> HMP2_J00828_1_ST_T0_B0_0120_ZN9YTFN-1013_AA31J 932d8fbc70ae8f856028b3f67c4f35bd
#> HMP2_J00829_1_ST_T0_B0_0120_ZN9YTFN-1014_AA31J 932d8fbc70ae8f856028b3f67c4f4fe6
```

The T2D `phyloseq` object can be loaded like so.

```
T2D <- T2D16S()
T2D
#> phyloseq-class experiment-level object
#> otu_table()   OTU Table:         [ 12062 taxa and 2208 samples ]
#> sample_data() Sample Data:       [ 2208 samples by 13 sample variables ]
#> tax_table()   Taxonomy Table:    [ 12062 taxa by 7 taxonomic ranks ]
```

# 5 Features

## 5.1 Frequency Table Generation

The sample-level annotation data contianed in `HMP2Data` can be summarized using the `table_two` function. First, we need to make a list of the `phyloseq` and `SummarizedExperiment` objects which can then be entered into the `table_two()` table generating function.

```
list("MOMS-PI 16S" = momspi16S_phyloseq, "MOMS-PI Cytokines" = momspiCyto, "IBD 16S" = IBD, "T2D 16S" = T2D) %>% table_two()
```

|  | MOMS-PI 16S | | MOMS-PI Cytokines | | IBD 16S | | T2D 16S | |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  | N | % | N | % | N | % | N | % |
| **Body Site** |  |  |  |  |  |  |  |  |
| buccal mucosa | 3313 | 36.38 | 311 | 22.28 | 0 | 0 | 0 | 0 |
| cervix of uterus | 162 | 1.78 | 0 | 0 | 0 | 0 | 0 | 0 |
| feces | 765 | 8.4 | 0 | 0 | 0 | 0 | 1041 | 47.15 |
| rectum | 2679 | 29.42 | 0 | 0 | 0 | 0 | 0 | 0 |
| unknown | 146 | 1.6 | 0 | 0 | 0 | 0 | 0 | 0 |
| vagina | 2042 | 22.42 | 979 | 70.13 | 0 | 0 | 0 | 0 |
| blood cell | 0 | 0 | 106 | 7.59 | 0 | 0 | 0 | 0 |
| nasal cavity | 0 | 0 | 0 | 0 | 0 | 0 | 1167 | 52.85 |
| **Sex** |  |  |  |  |  |  |  |  |
| male | 0 | 0 | 0 | 0 | 84 | 47.19 | 1248 | 56.52 |
| female | 9107 | 100 | 1396 | 100 | 94 | 52.81 | 947 | 42.89 |
| unknown | 0 | 0 | 0 | 0 | 0 | 0 | 13 | 0.59 |
| **Race** |  |  |  |  |  |  |  |  |
| african american | 0 | 0 | 0 | 0 | 0 | 0 | 117 | 5.3 |
| asian | 0 | 0 | 0 | 0 | 0 | 0 | 235 | 10.64 |
| caucasian | 0 | 0 | 0 | 0 | 0 | 0 | 1657 | 75.05 |
| ethnic other | 0 | 0 | 0 | 0 | 0 | 0 | 73 | 3.31 |
| hispanic or latino | 0 | 0 | 0 | 0 | 0 | 0 | 126 | 5.71 |
| american indian or alaska native | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| unknown | 9107 | 100 | 1396 | 100 | 178 | 100 | 0 | 0 |
| **total samples** | 9107 | 100 | 1396 | 100 | 178 | 100 | 2208 | 100 |

We can also create a table of the breakdown of samples by visit number quantile.

```
list("MOMS-PI 16S" = momspi16S_phyloseq, "MOMS-PI Cytokines" = momspiCyto, "IBD 16S" = IBD, "T2D 16S" = T2D) %>% visit_table()
```

|  | MOMS-PI 16S | | MOMS-PI Cytokines | | IBD 16S | | T2D 16S | |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  | N | % | N | % | N | % | N | % |
| First quantile | 8911 | 97.85 | 1126 | 80.66 | 163 | 91.57 | 1610 | 72.92 |
| Second quantile | 130 | 1.43 | 230 | 16.48 | 15 | 8.43 | 105 | 4.76 |
| Third quantile | 66 | 0.72 | 40 | 2.87 | NA | NA | 493 | 22.33 |

The patient-level characteristics can be summarized using the `patient_table()` function.

```
list("MOMS-PI 16S" = momspi16S_phyloseq, "MOMS-PI Cytokines" = momspiCyto, "IBD 16S" = IBD, "T2D 16S" = T2D) %>% patient_table()
```

|  | MOMS-PI 16S | | MOMS-PI Cytokines | | IBD 16S | | T2D 16S | |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  | N | % | N | % | N | % | N | % |
| **Sex** |  |  |  |  |  |  |  |  |
| male | 0 | 0 | 0 | 0 | 41 | 50.62 | 38 | 46.34 |
| female | 596 | 100 | 235 | 100 | 40 | 49.38 | 39 | 47.56 |
| unknown | 0 | 0 | 0 | 0 | 0 | 0 | 5 | 6.1 |
| **Race** |  |  |  |  |  |  |  |  |
| african american | 0 | 0 | 0 | 0 | 0 | 0 | 4 | 4.88 |
| asian | 0 | 0 | 0 | 0 | 0 | 0 | 14 | 17.07 |
| caucasian | 0 | 0 | 0 | 0 | 0 | 0 | 52 | 63.41 |
| ethnic other | 0 | 0 | 0 | 0 | 0 | 0 | 9 | 10.98 |
| hispanic or latino | 0 | 0 | 0 | 0 | 0 | 0 | 3 | 3.66 |
| american indian or alaska native | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| unknown | 596 | 100 | 235 | 100 | 81 | 100 | 0 | 0 |
| **Total patients** | 596 | 100 | 235 | 100 | 81 | 100 | 82 | 100 |

## 5.2 Visits Histograms

Here we plot histograms of the number of samples at each visit for the data MOMS-PI 16S data. Note that there are 196 samples at visit numbers over 20.

```
# set up ggplots
p1 <- ggplot(momspi16S_samp, aes(x = visit_number)) +
  geom_histogram(bins = 20, color = "#00BFC4", fill = "lightblue") +
  xlim(c(0,20)) + xlab("Visit number") + ylab("Count")
# theme(panel.background = element_blank(), panel.grid = element_blank())
p1
```

![](data:image/png;base64...)

We can plot the histogram of the number of samples at each visit for all studies.
Note that the X-axis is capped at count of 40 for better visualization.

```
# make data.frame for plotting
plot_visits <- data.frame(study = c(rep("MOMS-PI Cytokines", nrow(momspiCyto_samp)),
                     rep("IBD 16S", nrow(IBD16S_samp)),
                     rep("T2D 16S", nrow(T2D16S_samp))),
          visits = c(momspiCyto_samp$visit_number,
                     IBD16S_samp$visit_number,
                     T2D16S_samp$visit_number))
p2 <- ggplot(plot_visits, aes(x = visits, fill = study)) +
  geom_histogram(position = "dodge", alpha = 0.7, bins = 30, color = "#00BFC4") + xlim(c(0, 40)) +
  theme(legend.position = c(0.8, 0.8))  +
  xlab("Visit number") + ylab("Count")
p2
```

![](data:image/png;base64...)

Note that there are 677 samples at visit numbers over 40.

## 5.3 UpsetR plots

### 5.3.1 MOMS-PI 16S rRNA data

Here we plot the body sites which samples were taken from for each patient in the MOMS-PI 16S data.

```
# set up data.frame for UpSetR
tmp_data <- split(momspi16S_samp, momspi16S_samp$subject_id)
momspi_upset <- lapply(tmp_data, function(x) {
  table(x$sample_body_site)
})
momspi_upset <- bind_rows(momspi_upset)
tmp <- as.matrix(momspi_upset[, -1])
tmp <- (tmp > 0) *1
tmp[is.na(tmp)] <- 0
momspi_upset <- data.frame(patient = names(tmp_data), tmp)

# plot
upset(momspi_upset, order.by = 'freq', matrix.color = "blue", text.scale = 2)
```

![](data:image/png;base64...)

### 5.3.2 MOMS-PI Cytokines data

Here we plot the body sites which samples were taken from for each patient in the MOMS-PI cytokines data.

```
# set up data.frame for UpSetR
tmp_data <- split(momspiCyto_samp, momspiCyto_samp$subject_id)
momspiCyto_upset <- lapply(tmp_data, function(x) {
  table(x$sample_body_site)
})
momspiCyto_upset <- bind_rows(momspiCyto_upset)
tmp <- as.matrix(momspiCyto_upset[, -1])
tmp <- (tmp > 0) *1
tmp[is.na(tmp)] <- 0
momspiCyto_upset <- data.frame(patient = names(tmp_data), tmp)

# plot
upset(momspiCyto_upset, order.by = 'freq', matrix.color = "blue", text.scale = 2)
```

![](data:image/png;base64...)

### 5.3.3 IBD data

The IBD patients only had samples taken from the feces.

```
# set up data.frame for UpSetR
tmp_data <- split(IBD16S_samp, IBD16S_samp$subject_id)
IBD_upset <- lapply(tmp_data, function(x) {
  table(x$biopsy_location)
})
IBD_upset <- bind_rows(IBD_upset)
tmp <- as.matrix(IBD_upset[, -1])
tmp <- (tmp > 0) *1
tmp[is.na(tmp)] <- 0
IBD_upset <- data.frame(patient = names(tmp_data), tmp)

# plot
upset(IBD_upset, order.by = 'freq', matrix.color = "blue", text.scale = 2)
```

![](data:image/png;base64...)

### 5.3.4 T2D data

Here we plot the body sites which samples were taken from for each patient in the T2D 16S rRNA data.

```
# set up data.frame for UpSetR
tmp_data <- split(T2D16S_samp,T2D16S_samp$subject_id)
T2D_upset <- lapply(tmp_data, function(x) {
  table(x$sample_body_site)
})
T2D_upset <- bind_rows(T2D_upset)
tmp <- as.matrix(T2D_upset)
tmp <- (tmp > 0) *1
tmp[is.na(tmp)] <- 0
T2D_upset <- data.frame(patient = names(tmp_data), tmp)

# plot
upset(T2D_upset, order.by = 'freq', matrix.color = "blue", text.scale = 2)
```

![](data:image/png;base64...)

# 6 Exporting Data to CSV Format

To our knowledge, R and Bioconductor provide the most and best methods for the
analysis of microbiome data. However, we realize they are not the only analysis
environments and wish to provide methods to export the data from
*[HMP16SData](https://bioconductor.org/packages/3.22/HMP16SData)* to CSV format.

## 6.1 Preparing the data

For `SummarizedExperiment` objects, we will need to separate the data and metadata first before exportation. First, make a `data.frame` for participant data.

```
momspi_cytokines_participants <- colData(momspiCyto)
momspi_cytokines_participants[1:5, ]
#> DataFrame with 5 rows and 13 columns
#>                                  file_id                    md5      size
#>                              <character>            <character> <integer>
#> EP004835_K10_MVAX 31b14547707f47bb99f1.. 006d9076e88889e231fe..       409
#> EP004835_K20_MVAX 31b14547707f47bb99f1.. 6cbbebbc9da2efdcf728..       409
#> EP004835_K30_MVAX 31b14547707f47bb99f1.. f8c5541931022f8a32ed..       401
#> EP004835_K40_MVAX 31b14547707f47bb99f1.. a8478ba7c7bd1bd721fd..       394
#> EP004835_K50_MVAX 31b14547707f47bb99f1.. 36a8c5ba1490ba7132e2..       392
#>                                     urls              sample_id
#>                              <character>            <character>
#> EP004835_K10_MVAX fasp://aspera.ihmpdc.. 6791a23c10c0086065c2..
#> EP004835_K20_MVAX fasp://aspera.ihmpdc.. 6791a23c10c0086065c2..
#> EP004835_K30_MVAX fasp://aspera.ihmpdc.. 6791a23c10c0086065c2..
#> EP004835_K40_MVAX fasp://aspera.ihmpdc.. 6791a23c10c0086065c2..
#> EP004835_K50_MVAX fasp://aspera.ihmpdc.. 6791a23c10c0086065c2..
#>                           file_name             subject_id sample_body_site
#>                         <character>            <character>      <character>
#> EP004835_K10_MVAX EP004835_K10_MVAX e50d0c183689e4053ccb..           vagina
#> EP004835_K20_MVAX EP004835_K20_MVAX e50d0c183689e4053ccb..           vagina
#> EP004835_K30_MVAX EP004835_K30_MVAX e50d0c183689e4053ccb..           vagina
#> EP004835_K40_MVAX EP004835_K40_MVAX e50d0c183689e4053ccb..           vagina
#> EP004835_K50_MVAX EP004835_K50_MVAX e50d0c183689e4053ccb..           vagina
#>                   visit_number subject_gender subject_race study_full_name
#>                      <integer>    <character>  <character>     <character>
#> EP004835_K10_MVAX            1         female      unknown          momspi
#> EP004835_K20_MVAX            2         female      unknown          momspi
#> EP004835_K30_MVAX            3         female      unknown          momspi
#> EP004835_K40_MVAX            4         female      unknown          momspi
#> EP004835_K50_MVAX            5         female      unknown          momspi
#>                             project_name
#>                              <character>
#> EP004835_K10_MVAX Integrative Human Mi..
#> EP004835_K20_MVAX Integrative Human Mi..
#> EP004835_K30_MVAX Integrative Human Mi..
#> EP004835_K40_MVAX Integrative Human Mi..
#> EP004835_K50_MVAX Integrative Human Mi..
```

Then we need to pull out the data matrix.

```
momspi_cytokines <- assay(momspiCyto)
momspi_cytokines[1:5, 1:5]
#>         EP004835_K10_MVAX EP004835_K20_MVAX EP004835_K30_MVAX EP004835_K40_MVAX
#> Eotaxin             68.05             60.08             37.84             31.87
#> FGF                265.45             -2.00             -2.00            108.76
#> G-CSF              624.79           2470.70             -2.00             -2.00
#> GM-CSF              51.39             -2.00             42.01             28.75
#> IFN-g              164.58            193.22            184.53            185.97
#>         EP004835_K50_MVAX
#> Eotaxin             23.75
#> FGF                 78.31
#> G-CSF               -2.00
#> GM-CSF              -2.00
#> IFN-g              116.39
```

For `phyloseq` objects the data, metadata, and taxonomy can be separated as follows. First, pull out metadata.

```
momspi_16S_participants <- sample_data(momspi16S_phyloseq)
```

Next, we can save the counts data as a matrix.

```
momspi16s_data <- as.matrix(otu_table(momspi16S_phyloseq))
```

Finally, the taxonomy table can be extracted.

```
momspi16s_taxa <- tax_table(momspi16S_phyloseq) %>% as.data.frame()
```

## 6.2 Save data as CSV

The data can be saved as `.csv` files as follows.

```
library(readr)
write_csv(data.frame(file_id = rownames(momspi_cytokines_participants), momspi_cytokines_participants), "momspi_cytokines_participants.csv")
write_csv(data.frame(momspi_cytokines), "momspi_cytokines.csv")
```

# 7 Session Info

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
#>  [1] UpSetR_1.4.0                ggplot2_4.0.0
#>  [3] dplyr_1.1.4                 MultiAssayExperiment_1.36.0
#>  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [9] IRanges_2.44.0              S4Vectors_0.48.0
#> [11] BiocGenerics_0.56.0         generics_0.1.4
#> [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [15] phyloseq_1.54.0             HMP2Data_1.24.0
#> [17] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3            gridExtra_2.3        httr2_1.2.1
#>   [4] permute_0.9-8        rlang_1.1.6          magrittr_2.0.4
#>   [7] ade4_1.7-23          compiler_4.5.1       RSQLite_2.4.3
#>  [10] mgcv_1.9-3           png_0.1-8            systemfonts_1.3.1
#>  [13] vctrs_0.6.5          reshape2_1.4.4       stringr_1.5.2
#>  [16] pkgconfig_2.0.3      crayon_1.5.3         fastmap_1.2.0
#>  [19] magick_2.9.0         dbplyr_2.5.1         XVector_0.50.0
#>  [22] labeling_0.4.3       rmarkdown_2.30       tzdb_0.5.0
#>  [25] tinytex_0.57         bit_4.6.0            xfun_0.54
#>  [28] cachem_1.1.0         jsonlite_2.0.0       biomformat_1.38.0
#>  [31] blob_1.2.4           rhdf5filters_1.22.0  DelayedArray_0.36.0
#>  [34] Rhdf5lib_1.32.0      parallel_4.5.1       cluster_2.1.8.1
#>  [37] R6_2.6.1             bslib_0.9.0          stringi_1.8.7
#>  [40] RColorBrewer_1.1-3   jquerylib_0.1.4      Rcpp_1.1.0
#>  [43] bookdown_0.45        assertthat_0.2.1     iterators_1.0.14
#>  [46] knitr_1.50           readr_2.1.5          BiocBaseUtils_1.12.0
#>  [49] splines_4.5.1        igraph_2.2.1         Matrix_1.7-4
#>  [52] tidyselect_1.2.1     rstudioapi_0.17.1    dichromat_2.0-0.1
#>  [55] abind_1.4-8          yaml_2.3.10          vegan_2.7-2
#>  [58] codetools_0.2-20     curl_7.0.0           lattice_0.22-7
#>  [61] tibble_3.3.0         plyr_1.8.9           withr_3.0.2
#>  [64] S7_0.2.0             KEGGREST_1.50.0      evaluate_1.0.5
#>  [67] survival_3.8-3       BiocFileCache_3.0.0  xml2_1.4.1
#>  [70] ExperimentHub_3.0.0  Biostrings_2.78.0    pillar_1.11.1
#>  [73] BiocManager_1.30.26  filelock_1.0.3       foreach_1.5.2
#>  [76] hms_1.1.4            BiocVersion_3.22.0   scales_1.4.0
#>  [79] glue_1.8.0           tools_4.5.1          AnnotationHub_4.0.0
#>  [82] data.table_1.17.8    rhdf5_2.54.0         grid_4.5.1
#>  [85] ape_5.8-1            AnnotationDbi_1.72.0 nlme_3.1-168
#>  [88] cli_3.6.5            rappdirs_0.3.3       kableExtra_1.4.0
#>  [91] textshaping_1.0.4    S4Arrays_1.10.0      viridisLite_0.4.2
#>  [94] svglite_2.2.2        gtable_0.3.6         sass_0.4.10
#>  [97] digest_0.6.37        SparseArray_1.10.1   farver_2.1.2
#> [100] multtest_2.66.0      memoise_2.0.1        htmltools_0.5.8.1
#> [103] lifecycle_1.0.4      httr_1.4.7           bit64_4.6.0-1
#> [106] MASS_7.3-65
```