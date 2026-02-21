# Introduction To HiCBricks

Koustav Pal1, Ilario Tagliaferri1 and Carmen Maria Livi1

1IFOM - FIRC Institute of Molecular Oncology, Milan, Italy

#### 30 October 2025

#### Abstract

HiCBricks offers user-friendly and efficient solutions for handling large
high-resolution Hi-C datasets. The package provides a R/Bioconductor
framework with the bricks to build more complex data analysis pipelines
and algorithms.

#### Package

HiCBricks 1.28.0

> **Note by the developer**
> HiCBricks is currently in version 1.0. If users find some features to be missing, experience any issue with the package or find any problems in its usage please do open an issue on the [github page](https://github.com/koustav-pal/HiCBricks).

# 1 Introduction

HiCBricks is a library designed for handling large high-resolution Hi-C datasets. Over the years, the Hi-C field has experienced a rapid increase in the size and complexity of datasets. HiCBricks is meant to overcome the challenges related to the analysis of such large datasets within the R environment.

HiCBricks leverages HDF (Hierarchical Data Format) files to allow efficient handling of large Hi-C contact matrices. HiCBricks, implements a Hi-C specific HDF data structure referred to as a *Brick object*, introduces a simple S4 class *BrickContainer* for tracking the Brick objects across resolutions and presents accessor functions allowing users to access and manipulate Hi-C data without all the difficulties of dealing with the complex structure of HDF files.

The HiCBricks package, its set of data retrieval functions along with the *Brick objects* are meant to serve as building blocks for custom Hi-C analysis procedures as well as the development of new R or Bioconductor packages.

# 2 Create Brick objects to store Hi-C data

HiCBricks uses S4 classes and HDF files to efficiently manage large Hi-C datasets. Hereafter, we refer to the structured data contained in HiCBricks HDF files as *Brick objects* and the S4 class used to navigate and access the data within these *Brick objects* as *BrickContainers*. The *Brick object* implement a HDF structure consisting of three layers:

1. The Hi-C **contact matrix**, defined as a complete 2D matrix for each chromosome or chromosome-pair. The contact matrix for the *cis* (intra-chromosomal) contacts for each chromosome is a square `n x n` dimensional matrix. On the other hand, the *trans* (inter-chromosomal) contacts for each chromosome pair is a rectangular `n x m` dimensional matrix. The contact matrix loaded into a *brick object* can include the whole genome, or only specfic chromosomes selected by the end-user.
2. The **bin table**, defined as the set of genomic positions intervals or ranges `(chromosome, start, end)` associated to each row or column of the contact matrix. Hi-C data are usually aggregated and summarized over relatively large genomic intervals (bins) to achieve a more robust quantification of signal (read counts or normalized read counts). These can be defined as either fixed size bins or variable size bins. The latter may be useful for example to handle very high-resolution Hi-C contacts at single restriction fragment resolution.
3. **Annotations** (optional) that the end-user may want to associate to the Hi-C data. This information may be, but is not limited to, Topologically Associated Domain (TAD) calls, peak calls for other chromatin marks, gene expression data. In principle, if the annotation information can be represented as a `GenomicRanges` object, it can be stored in the *Brick object*.

In order to load Hi-C data matrix into a *Brick object* we have to:

1. create the HDF file with HiCBricks specific data structure
2. populate the HDF data structure with Hi-C data

The key advantage of HDF files is that once they have been created and populated with data, the data can be accessed very efficiently without the need to reload the whole matrix into memory each time.

Currently, HiCBricks functionalities allows importing data from text files with complete 2D matrices and binary cooler files (*.mcool* or *.cool*), as described below in section 2.1 and 2.3, respectively.

In section 2.3 below we also explain how to extract data from a binary *.hic* file format (produced by the Juicer111 Durand NC, Shamim MS, Machol I, Rao SSP, Huntley MH, Lander ES, Aiden EL. 2016. Juicer Provides a One-Click System for Analyzing Loop-Resolution Hi-C Experiments. Cell Syst 3: 95–98. Hi-C data analysis framework) to import them into a Brick object.

## 2.1 Creating a Brick object from a text file 2D contact matrix

> All files in this vignette will be created in a temporary directory, the location of which is available through `tempdir()`. Any files stored in this temporary directory will be deleted upon closure of the R session. Users are therefore advised to peruse the code before execution and to replace `tempdir()` with their own project directory locations when working with their own datasets.

First of all load the HiCBricks library:

```
library("HiCBricks")
```

Then get the path to the test datasets provided with the package, and in particular the path to the “bin table” specifying the genomics coordinates associated to each genomic bin used to summarize the Hi-C data. These would correspond to row and columns of the Hi-C contact matrix. In this example the `bin table` provided is for the *drosophila* genome divided in equally sized bins of 100 Kb.

```
Bintable_path <- system.file(file.path("extdata",
"Bintable_100kb.bins"), package = "HiCBricks")
```

Note that in this example the bin table is a space delimited text file with 3 columns for chromosome, start and end coordinates of each genomic bin, respectively. **This format is not mandatory** as:

1. The headers are auto-detected upon load.
2. The **Create\_many\_Bricks** functions has another parameter, `col.index` which takes as input the column index of the columns containing the chr, start and end coordinates. This parameter defaults to `c(1,2,3)`. When users have bin tables with many additional columns, they can take advantage of this parameter and provide the column indices relevant for this function, i.e. the indices corresponding to the chr, start and end columns. The indices must be provided in the specific order of chr,start,end.

There must be a one to one match between elements in the bin table and in the contact matrix. The “Bintable\_100kb.txt” file contains 1194 rows, corresponding to the specific number of genomic bin in each chromosome.

Table 1: Number of rows in the bintable corresponding to each chromosome

| chr | num\_rows |
| --- | --- |
| chr2L | 231 |
| chr2R | 212 |
| chr3L | 246 |
| chr3R | 280 |
| chrX | 225 |

Then, the backbone of the *Brick object* data structure is created using only the bin table. The actual contacts frequencies will be added later. The `Create_many_Bricks` function, as its name suggests creates many *brick objects* at the specified project location (`output_directory`) using the `file_prefix` as the prefix of the *brick objects*. Each *brick object* corresponds to a single pairwise contact matrix for each chromosome pair. It also creates a `HiCBricks_builder_config.json` describing the bricks and the project itself. When re-accessing the same project, users need only point the `load_BrickContainer` towards the `HiCBricks_builder_config.json` or to the project directory using the parameters, `config_file` and `project_dir` respectively.

As output the `Create_many_Bricks` and `load_BrickContainer` function produces an object of class `BrickContainer` containing the description (`experiment_name`) of the entire project, the `resolution` listed in the project, the `chromosomes` and `chromosome lengths` and the list of *brick objects*.

Please note, that the `output_directory` is the project directory and only one project can be stored within the `output_directory`, i.e. only one `HiCBricks_builder_config.json` file can exist inside any given `output_directory`.

```
out_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
dir.create(out_dir)
Create_many_Bricks(BinTable = Bintable_path,
    bin_delim=" ", output_directory = out_dir,
    file_prefix = "HiCBricks_vignette_test", remove_existing=TRUE,
    experiment_name = "HiCBricks vignette test", resolution = 100000)
```

```
## Warning: The `path` argument of `write_lines()` is deprecated as of readr 1.4.0.
## ℹ Please use the `file` argument instead.
## ℹ The deprecated feature was likely used in the HiCBricks package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Experiment name: HiCBricks vignette test
```

```
## Project directory: ../../../../Rtmp7hkMDB/HiCBricks_vignette_test
```

```
## Configuration file: ../../../../Rtmp7hkMDB/HiCBricks_vignette_test/HiCBricks_builder_config.json
```

```
## Resolutions: 100000
```

```
## Chromosomes: chr2L, chr2R, chr3L, chr3R, chrX
```

```
## Lengths: 23100000, 21200000, 24600000, 28000000, 22500000
```

```
## containing 15 matrices across 1 resolutions and 5 chromosomes
```

```
## # A tibble: 15 × 5
##    chrom1 chrom2 resolution mat_type filename
##    <chr>  <chr>  <chr>      <chr>    <chr>
##  1 chr2L  chr2L  100000     cis      HiCBricks_vignette_test_100000_chr2L_vs_ch…
##  2 chr2L  chr2R  100000     trans    HiCBricks_vignette_test_100000_chr2L_vs_ch…
##  3 chr2L  chr3L  100000     trans    HiCBricks_vignette_test_100000_chr2L_vs_ch…
##  4 chr2L  chr3R  100000     trans    HiCBricks_vignette_test_100000_chr2L_vs_ch…
##  5 chr2L  chrX   100000     trans    HiCBricks_vignette_test_100000_chr2L_vs_ch…
##  6 chr2R  chr2R  100000     cis      HiCBricks_vignette_test_100000_chr2R_vs_ch…
##  7 chr2R  chr3L  100000     trans    HiCBricks_vignette_test_100000_chr2R_vs_ch…
##  8 chr2R  chr3R  100000     trans    HiCBricks_vignette_test_100000_chr2R_vs_ch…
##  9 chr2R  chrX   100000     trans    HiCBricks_vignette_test_100000_chr2R_vs_ch…
## 10 chr3L  chr3L  100000     cis      HiCBricks_vignette_test_100000_chr3L_vs_ch…
## 11 chr3L  chr3R  100000     trans    HiCBricks_vignette_test_100000_chr3L_vs_ch…
## 12 chr3L  chrX   100000     trans    HiCBricks_vignette_test_100000_chr3L_vs_ch…
## 13 chr3R  chr3R  100000     cis      HiCBricks_vignette_test_100000_chr3R_vs_ch…
## 14 chr3R  chrX   100000     trans    HiCBricks_vignette_test_100000_chr3R_vs_ch…
## 15 chrX   chrX   100000     cis      HiCBricks_vignette_test_100000_chrX_vs_chr…
```

> **HiCBricks does not overwrite your files without you saying so** Keeping in line with Bioconductor standards and community guidelines, HiCBricks will never replace a user’s files without their explicit permission. When a user defines `remove_existing=TRUE`, they are giving their permission to HiCBricks function to remove any *Brick objects* they may have created previously. Otherwise, without this parameter the `Create_many_Bricks` will not overwrite existing files. You will encounter this parameter in another form, `remove_prior` when populating HDF files with Hi-C data.

We are now ready to load a 2D matrix data into the *Brick objects*. When doing so, we pass to the `Brick_load_matrix` function the BrickContainer object returned as output from the previous step. Then we specify which chromosome (for intra-chromosomal *n x n* contact matrix) or which pair of chromosomes (for inter-chromosomal *n x m* contact matrix) are contained in the `matrix_file`. In case of intra-chromosomal contacts like in this example, `chr1` and `chr2` arguments will have the same value.

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)
Example_dataset_dir <- system.file("extdata", package = "HiCBricks")

Chromosomes <- c("chr2L", "chr3L", "chr3R", "chrX")
for (chr in Chromosomes) {
    Matrix_file <- file.path(Example_dataset_dir,
        paste(paste("Sexton2012_yaffetanay_CisTrans_100000_corrected",
          chr, sep = "_"), "txt.gz", sep = "."))
    Brick_load_matrix(Brick = My_BrickContainer,
        chr1 = chr,
        chr2 = chr,
        resolution = 100000,
        matrix_file = Matrix_file,
        delim = " ",
        remove_prior = TRUE)
}
```

```
## Read 231 lines after Skipping 0 lines
```

```
## Inserting Data at location: 1
```

```
## Data length: 231
```

```
## Loaded 442112 bytes of data...
```

```
## Read 231 records...
```

```
## Read 246 lines after Skipping 0 lines
```

```
## Inserting Data at location: 1
```

```
## Data length: 246
```

```
## Loaded 500312 bytes of data...
```

```
## Read 246 records...
```

```
## Read 280 lines after Skipping 0 lines
```

```
## Inserting Data at location: 1
```

```
## Data length: 280
```

```
## Loaded 645560 bytes of data...
```

```
## Read 280 records...
```

```
## Read 225 lines after Skipping 0 lines
```

```
## Inserting Data at location: 1
```

```
## Data length: 225
```

```
## Loaded 419840 bytes of data...
```

```
## Read 225 records...
```

Note that also in this case we specify a column delimiter `(delim= " ")` for reading the input file. If you have a very large 2D *cis* matrix, you may want to load data up to a certain diagonal, i.e. up to bin pairs separated by a certain distance on the genome. The rationale in this case is that the contact frequency is rapidly decaying with distance, thus you may find a very sparse matrix at longer distances.

In this example we load up to 100 diagonals with `Brick_load_cis_matrix_till_distance`

```
Example_dataset_dir <- system.file("extdata", package = "HiCBricks")
Matrix_file <- file.path(Example_dataset_dir,
    paste(paste("Sexton2012_yaffetanay_CisTrans_100000_corrected",
        "chr2L", sep = "_"), "txt.gz", sep = "."))
Brick_load_cis_matrix_till_distance(Brick = My_BrickContainer,
    chr = "chr2L",
    resolution = 100000,
    matrix_file = Matrix_file,
    delim = " ",
    distance = 100,
    remove_prior = TRUE)
```

```
## Inserting Data at location: 1, 1
```

```
## Data length: 231
```

```
## Loaded 417.09 KB of data...
```

```
## [1] TRUE
```

## 2.2 Creating Brick objects from sparse matrices

Since version 1.6.0, HiCBricks allows the loading of *sparse matrices* into *Brick* objects. *sparse matrices* are text files containing 3 columns. The first two columns corresponds to the bin number of interacting regions. Both the first and the second column contains *bin locations* corresponding to the line number on which the genomic intervals (bin) reside in a lexicographically sorted genome-wide binning table. Furthermore, sparse matrices are in upper triangle format, such that the *bin locations* in the second column are greater than or equal to the *bin locations* present in the first column. The third column in a *sparse matrix* corresponds to the Hi-C interaction values between the bin pairs listed in columns one and two. Finally, *sparse matrices* contain only the non-zero part of Hi-C data, i.e. where a positive interaction value is present for each bin pair.

For this exercise we will use a relatively small dataset available GEO. The dataset corresponds to the C2C12 mouse myoblast cell line. The provided matrix contains ICE normalised values, but is not in sparse format. Furthermore, each bin number in the matrix corresponds to the genomic interval present at that specific line number in the bin table.

```
require(curl)
ftp_location = "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE104nnn/GSE104427/suppl"

sparse_matrix_file = file.path(ftp_location,"GSE104427_c2c12_40000_iced.matrix.gz")
sparse_out_dir <- file.path(tempdir(), "sparse_out_dir")
if(!dir.exists(sparse_out_dir)){
  dir.create(sparse_out_dir)
}
curl_download(url = sparse_matrix_file,
    destfile = file.path(sparse_out_dir, "GSE104427_c2c12_40000_iced.matrix.gz"))

sparse_bintable_file = file.path(ftp_location,"GSE104427_c2c12_40000_abs.bed.gz")
curl_download(url = sparse_matrix_file,
    destfile = file.path(sparse_out_dir, "GSE104427_c2c12_40000_abs.bed.gz"))
```

Since the file contains bin pairs where column one values are greater than or equal to column two values, we need to remove these values to create a sparse matrix.

```
Read_file_df <- read.table(file.path(sparse_out_dir, "GSE104427_c2c12_40000_iced.matrix.gz"))
Read_file_df <- Read_file_df[Read_file_df[,2] >= Read_file_df[,1],]
write.table(x = Read_file_df, file = file.path(sparse_out_dir, "GSE104427_c2c12_40000_iced_uppertri.matrix"),
  quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
```

Furthermore, the bintable contains genome intervals which are continuous, i.e. end position and start positions of neighbouring intervals overlap by 1bp. Also, since R is 1 based, users will find that using the `GenomicRanges::width` function on these intervals leads to a width offset by +1bp. This normally causes issues in `GenomicRanges` functions when users create a “within” overlap operation. So the start coordinates must be offset by +1bp to ensure that the bintable is discontinuous.

```
Read_bintable_df <- read.table(file.path(sparse_out_dir, "GSE104427_c2c12_40000_abs.bed.gz"))
Read_bintable_df[,2] <- Read_bintable_df[,2] + 1
write.table(x = Read_bintable_df[, c(1, 2, 3)], file = file.path(sparse_out_dir, "GSE104427_c2c12_40000_abs_discontinuous.bed"),
  quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
```

Finally, as before we can now create the Brick object as described previously using the `Create_many_Bricks` function and load data into the Brick objects using the function `Brick_load_data_from_sparse`.

```
Bintable_path <- file.path(sparse_out_dir, "GSE104427_c2c12_40000_abs_discontinuous.bed")

My_sparse_brick_object <- Create_many_Bricks(BinTable = Bintable_path,
    bin_delim=" ", output_directory = out_dir,
    file_prefix = "HiCBricks_vignette_test", remove_existing=TRUE,
    experiment_name = "HiCBricks vignette test", resolution = 40000)

Matrix_path <- file.path(sparse_out_dir, "GSE104427_c2c12_40000_iced_uppertri.matrix")

Load_all_sparse <- Brick_load_data_from_sparse(Brick = My_sparse_brick_object,
  table_file = Matrix_path, delim = " ", resolution = 40000)
```

## 2.3 Creating Brick objects from *.mcool* binary files

HiCBricks functions allow converting files with the *mcool* or *cool* (cooler) formats into HDF files with the *Brick* format. On a technical side, it must be noted that *cooler* file formats are also based on HDF, but the conversion to `HiCBricks` data structure allowed us to design more efficient data accessors. `mcool`, is a data formats adopted by the 4D nucleome project to disseminate data. These files contain Hi-C contact matrices in a sparse format, storing the non-zero values of the upper triangular matrix in the HDF file. `mcool` files can include multiple normalisations and resolutions within the same file. HiCBricks, on the other hand stores a single normalisation for multiple resolutions.

In this exercise we will download one mcool file from the 4DN data portal at <https://data.4dnucleome.org/>. For the purposes of this vignette we will use a sample H1 human embryonic stem cell line (H1-hESC) Hi-C data.

> HiCBricks currently accepts mcool and cool files following cool format version 2 and all prior versions. I do not make any guarantees for future versions, since development of the cooler package is independent of the HiCBricks package. If you are a user from the future and have encountered a format specific issue while reading mcool files with HiCBricks, please open an issue on the [HiCBricks github repository](https://github.com/koustav-pal/HiCBricks)

Please note, that these are very large files, and they may require a significant amount of time to download, depending on the speed of network connection.

For convenience, you can download the file using “curl” directly within the R prompt.

```
require(curl)
Consortium.home = "https://data.4dnucleome.org/files-processed"
File = file.path(Consortium.home, "4DNFI7JNCNFB",
    "@@download","4DNFI7JNCNFB.mcool")
mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
dir.create(mcool_out_dir)
curl_download(url = File,
    destfile = file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool"))
```

This file contains normalised Hi-C data for H1-hESC cells obtained using the DpnII restriction enzyme. Note that there are multiple types of normalisations available within the sample. We can check what normalisation weights are available using `Brick_list_mcool_normalisations(names.only = TRUE)`.

HiCBricks accepts from the mcool files, normalization factors for “Knight-Ruitz”, “Vanilla-coverage”, “Vanilla-coverage-square-root” or “Iterative-Correction”. For more details about the different normalizations see Rao et al., 2014222 A 3D map of the human genome at kilobase resolution reveals principles of chromatin looping.
Rao SS, Huntley MH, Durand NC, Stamenova EK, Bochkov ID, Robinson JT, Sanborn AL, Machol I, Omer AD, Lander ES and Aiden EL. Cell, 2014.

The 4D nucleome project disseminates its data with several different resolutions, i.e. different bin sizes. `Brick_list_mcool_resolutions` provides information regarding the different resolutions available within the *mcool* files.

```
mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
mcool_path=file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool")
Brick_list_mcool_resolutions(mcool = mcool_path)
```

Then users can query the mcool files to find out if a given normalisation factor is present for a given resolution.

```
mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
mcool_path=file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool")
Brick_mcool_normalisation_exists(mcool = mcool_path,
    norm_factor = "Iterative-Correction",
    resolution = 10000)
```

HiCBricks allows users to create HDF files with the *Brick* format from *mcool* and *cool* files.

Similar to the previous section, we will start from the *mcool* file content to:

1. Create a *Brick object* containing the HiCBricks data structure
2. populate this HDF data structure with Hi-C data

In the previous example for 2D text matrices, we used the `Create_many_Bricks` function to create *Brick objects* for 2D matrices. Instead, to create *Brick objects* from *mcool* files we will use the `Create_many_Bricks_from_mcool` function.

When creating *Brick objects* from scratch users were required to provide a bin table. Instead when starting from *mcool* files the users do not need to provide a bin table as such information is already embedded within the *mcool* files. Therefore, users can just provide the resolution they want to load, and the corresponding bin table information will be fetched from the *mcool* files.

Using the `chrs` parameter users can limit the structure created to the relevant chromosomes or, if left NULL (default value), the structure for all chromosome and chromosome-pairs will be created.

```
mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
mcool_path=file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool")

out_dir <- file.path(tempdir(), "mcool_to_Brick_test")
dir.create(out_dir)

Create_many_Bricks_from_mcool(output_directory = out_dir,
    file_prefix = "mcool_to_Brick_test",
    mcool = mcool_path,
    resolution = 10000,
    experiment_name = "Testing mcool creation",
    remove_existing = TRUE)
```

You can also add other resolutions using the same function.

```
mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
mcool_path=file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool")

out_dir <- file.path(tempdir(), "mcool_to_Brick_test")

Create_many_Bricks_from_mcool(output_directory = out_dir,
    file_prefix = "mcool_to_Brick_test",
    mcool = mcool_path,
    resolution = 40000,
    experiment_name = "Testing mcool creation",
    remove_existing = TRUE)
```

After the *Brick object* has been created, we will populate the HDF file with values coming from the Hi-C interaction matrix stored within the *mcool* file. For this, we use the `Brick_load_data_from_mcool` function.

```
out_dir <- file.path(tempdir(), "mcool_to_Brick_test")
My_BrickContainer <- load_BrickContainer(project_dir = out_dir)

mcool_out_dir <- file.path(tempdir(), "mcool_out_dir")
mcool_path=file.path(mcool_out_dir, "H1-hESC-HiC-4DNFI7JNCNFB.mcool")

Brick_load_data_from_mcool(Brick = My_BrickContainer,
    mcool = mcool_path,
    resolution = 10000,
    cooler_read_limit = 10000000,
    matrix_chunk = 2000,
    remove_prior = TRUE,
    norm_factor = "Iterative-Correction")
```

There are a few options allowing users to manipulate data read and write speed. `cooler_read_limit` determines the data read buffer upper limit. If the total number of records read per `matrix_chunk` exceeds this parameter value, `matrix_chunk` is dynamically re-evaluated such that the number of records read per matrix chunk is lower than `cooler_read_limit`. `matrix_chunk` determines data write buffer, i.e. the size of the matrix square that will be loaded per iteration through an *mcool* file. `remove_prior` defaults to FALSE to prevent users from overwriting data already loaded into an HDF file.

Note that if the end users wishes to load raw read counts from the cooler file to the Brick object, this can be achieved by specifying the `norm_factor=NULL` parameter.

## 2.4 Creating Brick objects from .hic binary files

The method to create a Brick object from a `.hic` file is still a work in progress and will be a part of the package in a future release. Meanwhile, if users wish to create a `.hic` file into a *Brick object*, they should first use the `hic2cool` utility (version > 0.7) to create an `mcool` file and then read that `mcool` file into a *Brick object*. This utility is available at 4D nucleome [github repository](https://github.com/4dn-dcic/hic2cool).

## 2.5 Exporting data from Brick objects

Users can export entire resolutions out of BrickContainers using the `Brick_export_to_sparse` function. This function will provide as output an delimited file containing upper triangle sparse matrix non-zero values. This tsv along with the bintable from the BrickContainer can then be converted to the mcool format using the cooler command-line tool.

```
# load the Brick Container
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

# export the contact matrix to a a sparse matrix format and save it on a file
Brick_export_to_sparse(Brick=My_BrickContainer,
  out_file="brick_export.tsv",
  remove_file=TRUE,
  resolution=100000,
  sep="\t")

# create a dataframe containing the bintable
bintable<-Brick_get_bintable(My_BrickContainer, resolution = 100000)

require(GenomicRanges)

df1<-data.frame(seqnames=seqnames(bintable),
  start(bintable)-1,
  ends=end(bintable),
  names=c(rep(".",length(bintable))),
  scores=c(rep(".", length(bintable))),
  strands=strand(bintable))

# save the bintable as a bed file
write.table(df1,
  file="bintable.bed",
  quote=FALSE,
  row.names=FALSE,
  col.names=FALSE,
  sep="\t")
```

## 2.6 Converting sparse matrix to mcool

All code from this point on must be executed from the user’s command-line and not from within an R session. After writing both the table and the bintable files, the user should remove the headers from the sparse matrix.

```
sed -e "1d" brick_export.tsv | cut -f3-5 > exported_bins_no_header.tsv
```

Finally, users can create the mcool files using the cooler binary program. This operation leverages on [cooler](https://github.com/mirnylab/cooler).

```
cooler load -f coo \
  --count-as-float \
  --one-based \
  bintable.bed \
  exported_bins_no_header.tsv \
  test_cool_from_hicbricks.cool
```

To create a multi resolution .mcool file, it possibile to use the zoomify command

```
cooler zoomify -p 1 \
  -r 200000,500000 \
  -o 2_test_cool_from_hicbricks.mcool \
  test_cool_from_hicbricks.cool
```

As noted in the cooler documentation, zoomify allows you to *coarsen* your matrix starting from the finest resolution.

# 3 Accessing data in Brick objects

As mentioned above, there are three different types of information stored within *Brick objects*.

1. The Hi-C **contact matrix**, for each chromosome and chromosome-pair.
2. The **bin table**, with the genomic coordinates associated to rows and columns of each Hi-C contact matrix.
3. The custom annotations (optional) that end-users may want to associate to the data.

Both the **bin table** and the **annotations** are represented as `GRanges` objects, i.e. lists of genomic intervals as defined in the Bioconductor package `GenomicRanges`.This is the de-facto standard for working with genomic coordinates in the R/Bioconductor environment.

## 3.1 Accessing genomic coordinates in a Brick object

As mentioned in the introduction to this section, `HiCBricks` objects contain two different types of `GRanges` objects. Hereafter we will refer to them as *ranges* objects.

The first is the bin table, which is central towards the proper functioning of HiCBricks functions, and is mostly inaccessible for user modifications. The second are annotation for the user’s reference and is completely accessible for the user.

Each of the *ranges objects* are stored under a unique id. The bin table always holds the id, “Bintable” whereas other annotations *ranges objects* can hold user-defined unique identifiers. Users can *list* unique identifiers of all *ranges objects* inside a BrickContainer using `Brick_list_rangekeys`. In the example below there are two ranges objects that are listed. The first, is the bin table, whereas the second is an example custom annotation stored in the test HDF file.

> Similar functions are available inside `HiCBricks` to list attributes or features of elements within *Brick objects*. See the package manual pages for functions with names like *Brick\_list\_*. These are the *list* functions. Afterwards, we will also come across the *get* or *fetch* functions. While *list* functions *list* features and attributes of elements within *Brick objects*, *get* and *fetch* functions help users get the same elements.

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_list_rangekeys(Brick = My_BrickContainer, resolution = 100000)
```

```
## [1] "Bintable"
```

If we want to retrieve the bin table, we can retrieve its content using the `Brick_get_bintable` function

```
BrickContainer_file <- file.path(tempdir(),
  "HiCBricks_vignette_test", "HiCBricks_builder_config.json")
My_BrickContainer <- load_BrickContainer(config_file = BrickContainer_file)

Brick_get_bintable(My_BrickContainer, resolution = 100000)
```

```
## GRanges object with 1194 ranges and 0 metadata columns:
##                          seqnames            ranges strand
##                             <Rle>         <IRanges>  <Rle>
##           chr2L:1:100000    chr2L          1-100000      *
##      chr2L:100001:200000    chr2L     100001-200000      *
##      chr2L:200001:300000    chr2L     200001-300000      *
##      chr2L:300001:400000    chr2L     300001-400000      *
##      chr2L:400001:500000    chr2L     400001-500000      *
##                      ...      ...               ...    ...
##   chrX:22000001:22100000     chrX 22000001-22100000      *
##   chrX:22100001:22200000     chrX 22100001-22200000      *
##   chrX:22200001:22300000     chrX 22200001-22300000      *
##   chrX:22300001:22400000     chrX 22300001-22400000      *
##   chrX:22400001:22500000     chrX 22400001-22500000      *
##   -------
##   seqinfo: 5 sequences from an unspecified genome; no seqlengths
```

Otherwise, you can retrieve the object using `Brick_get_ranges` the method called by `Brick_get_bintable`.

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_get_ranges(Brick = My_BrickContainer,
    rangekey = "Bintable", resolution = 100000)
```

```
## GRanges object with 1194 ranges and 0 metadata columns:
##                          seqnames            ranges strand
##                             <Rle>         <IRanges>  <Rle>
##           chr2L:1:100000    chr2L          1-100000      *
##      chr2L:100001:200000    chr2L     100001-200000      *
##      chr2L:200001:300000    chr2L     200001-300000      *
##      chr2L:300001:400000    chr2L     300001-400000      *
##      chr2L:400001:500000    chr2L     400001-500000      *
##                      ...      ...               ...    ...
##   chrX:22000001:22100000     chrX 22000001-22100000      *
##   chrX:22100001:22200000     chrX 22100001-22200000      *
##   chrX:22200001:22300000     chrX 22200001-22300000      *
##   chrX:22300001:22400000     chrX 22300001-22400000      *
##   chrX:22400001:22500000     chrX 22400001-22500000      *
##   -------
##   seqinfo: 5 sequences from an unspecified genome; no seqlengths
```

While fetching the ranges object we can also subset the retrieved *GRanges* by the chromosome of interest.

```
BrickContainer_file <- file.path(tempdir(), "HiCBricks_vignette_test",
  "HiCBricks_builder_config.json")
My_BrickContainer <- load_BrickContainer(config_file = BrickContainer_file)

Brick_get_ranges(Brick = My_BrickContainer,
    rangekey = "Bintable",
    chr = "chr3R",
    resolution = 100000)
```

```
## GRanges object with 280 ranges and 0 metadata columns:
##                           seqnames            ranges strand
##                              <Rle>         <IRanges>  <Rle>
##            chr3R:1:100000    chr3R          1-100000      *
##       chr3R:100001:200000    chr3R     100001-200000      *
##       chr3R:200001:300000    chr3R     200001-300000      *
##       chr3R:300001:400000    chr3R     300001-400000      *
##       chr3R:400001:500000    chr3R     400001-500000      *
##                       ...      ...               ...    ...
##   chr3R:27500001:27600000    chr3R 27500001-27600000      *
##   chr3R:27600001:27700000    chr3R 27600001-27700000      *
##   chr3R:27700001:27800000    chr3R 27700001-27800000      *
##   chr3R:27800001:27900000    chr3R 27800001-27900000      *
##   chr3R:27900001:28000000    chr3R 27900001-28000000      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

### 3.1.1 Identifying matrix row/col using ranges operations

Users may sometimes find it useful to identify the corresponding contact matrix row or column for a particular genomic coordinate.

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_return_region_position(Brick = My_BrickContainer,
    region = "chr2L:5000000:10000000", resolution = 100000)
```

```
##  [1]  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69
## [20]  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88
## [39]  89  90  91  92  93  94  95  96  97  98  99 100
```

This does a **within** overlap operation and returns the corresponding bins indexes, i.e. the indexes of contact matrix rows or columns covering the user-specified region. This function may fail if the region of interest is smaller than the genomic bins corresponding to the region of interest in the contact matrix.

To have a more fine-grain control, users may choose to use `Brick_fetch_range_index` which is also called by the above described `Brick_return_region_position` function. Note that in this case, multiple regions can be provided as input at once, by specifying vectors with multiple values as `chr`, `start` and `end` input parameters. Differently from above, the output of this function is a `GRanges` object, with an entry for each input query regions. The matching genomic bins are stored in the **Indexes** column. This column is of class `IntegerList`.

> Users, unfamiliar with the `IntegerList` and other classes like it are encouraged to check out the IRanges package on Bioconductor.

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_fetch_range_index(Brick = My_BrickContainer,
    chr = "chr2L",
    start = 5000000,
    end = 10000000, resolution = 100000)
```

```
## GRanges object with 1 range and 1 metadata column:
##                          seqnames           ranges strand |       Indexes
##                             <Rle>        <IRanges>  <Rle> | <IntegerList>
##   chr2L:5000000:10000000    chr2L 5000000-10000000      * |  50,51,52,...
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 3.2 Accessing contact matrices in a Brick object

There are three ways to subset matrices.

* By distance
* Selecting sub-matrices
* Selecting rows or columns

### 3.2.1 Retrieving points separated by a certain distance

It is possible to get the interactions between genomic loci separated by a certain distance, which is indicated as number of genomic bins separating the data points of interest: e.g. distance=4 in the following example.

> Note that distances always range between 0 and number of rows or columns in contact matrix - 1. When distance is 0, we are fetching the vector of values corresponding to the interaction frequency between any given bin and itself. Similarly, 1 fetches values corresponding to the interaction frequency between any given bin and its immediate neighbour

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Values <- Brick_get_values_by_distance(Brick = My_BrickContainer,
    chr = "chr2L",
    distance = 4, resolution = 100000)
```

Users have the flexibility to apply custom operations on data while they are retrieved from the *Brick object*. In the example below, the Hi-C contact **frequencies** from the specified diagonal are transformed in log10 scale and their median value is computed. Custom operations are applied by providing function definitions in the parameter `FUN`.

```
Failsafe_median_log10 <- function(x){
    x[is.nan(x) | is.infinite(x) | is.na(x)] <- 0
    return(median(log10(x+1)))
}

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_get_values_by_distance(Brick = My_BrickContainer,
    chr = "chr2L",
    distance = 4, resolution = 100000,
    FUN = Failsafe_median_log10)
```

```
## [1] 1.574806
```

Moreover, these functions can also subset the interaction values by a certain region of interest, such as TADs, by using the `constrain_region` argument. Human readable coordinates can be provided to this particular paramenter in the form of `chr:start:end`. Note that HiCBricks requires the delimiter of the coordinates to always be `:`.

```
Failsafe_median_log10 <- function(x){
    x[is.nan(x) | is.infinite(x) | is.na(x)] <- 0
    return(median(log10(x+1)))
}

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_get_values_by_distance(Brick = My_BrickContainer,
    chr = "chr2L",
    distance = 4,
    constrain_region = "chr2L:1:5000000",
    resolution = 100000,
    FUN = Failsafe_median_log10)
```

```
## [1] 1.594021
```

### 3.2.2 Retrieving subsets of a matrix

HiCBricks, by user-specified human readable coordinates, as defined above. Once again, we ask users to make note of the human readable coordinate format in the `x_coords` and `y_coords` parameters: the only accepted delimiter is `:`.

```
Sub_matrix <- Brick_get_matrix_within_coords(Brick = My_BrickContainer,
    x_coords="chr2L:5000000:10000000",
    force = TRUE,
    resolution = 100000,
    y_coords = "chr2L:5000000:10000000")

dim(Sub_matrix)
```

```
## [1] 50 50
```

The range of genomic bins to be fetched can also be provided as rows and columns indexes. In this case users must be careful about how genomic coordinates are translated into bin indexes. For example, users may think the following code would return the the same values as above, but this is not the case.

```
x_axis <- 5000000/100000
y_axis <- 10000000/100000

Sub_matrix <- Brick_get_matrix(Brick = My_BrickContainer,
    chr1 = "chr3R", chr2 = "chr3R", resolution = 100000,
    x_coords = seq(from = x_axis, to = y_axis),
    y_coords = seq(from = x_axis, to = y_axis))

dim(Sub_matrix)
```

```
## [1] 51 51
```

Notice, that this selection has one more row and column. This is because the region of interest spans from **5000001:10000000**, which starts from the `x_axis + 1` and not from `x_axis`.

Finally, it is also possible to fetch entire rows and columns from the contact matrix. Users can do so by specifying the exact bin name corresponding to names of the matrix rows or columns as indicated in the bintable. If these are names, it is required to specify `by = "ranges"`.

```
Coordinate <- c("chr3R:1:100000","chr3R:100001:200000")

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Test_Run <- Brick_fetch_row_vector(Brick = My_BrickContainer,
    chr1 = "chr3R",
    chr2 = "chr3R",
    by = "ranges",
    resolution = 100000,
    vector = Coordinate)
```

As an alternative, users can also choose to fetch data by position `by = positions`. In this case, the Coordinate vector provides indexes to the rows or columns to be fetched.

```
Coordinate <- c(1,2)

BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Test_Run <- Brick_fetch_row_vector(Brick = My_BrickContainer,
    chr1 = "chr3R",
    chr2 = "chr3R",
    by = "position",
    resolution = 100000,
    vector = Coordinate)
```

If regions is provided, it will subset the corresponding row/col by the specified region. `regions` must be in coordinate format as shown below.

```
Coordinate <- c(1,2)

Test_Run <- Brick_fetch_row_vector(Brick = My_BrickContainer,
    chr1 = "chr3R",
    chr2 = "chr3R",
    by = "position",
    vector = Coordinate,
    resolution = 100000,
    regions = c("chr3R:1:1000000", "chr3R:100001:2000000"))
```

### 3.2.3 Accessing matrix metadata columns

There are several metrics which are computed at the time of matrix loading into the HDF file. Principally,

* **chr1\_bin\_coverage** quantifies the proportion of non-zero rows
* **chr2\_bin\_coverage** quantifies the proportion of non-zero cols
* **chr1\_row\_sums** quantifies the total signal value of any row
* **chr2\_col\_sums** quantifies the total signal value of any col
* **sparsity** quantifies the proportion of non-zero values at a certain distance from the diagonal Sparsity is only quantified if a matrix is defined as sparse during matrix loading.

Users can *list* the names of all the possible matrix metadata columns.

```
Brick_list_matrix_mcols()
```

```
##   chr1_bin_coverage   chr2_bin_coverage       chr1_row_sums       chr2_col_sums
## "chr1_bin_coverage" "chr2_bin_coverage"     "chr1_row_sums"     "chr2_col_sums"
##              sparse
##          "sparsity"
```

And then fetch one such metadata column

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

MCols.dat <- Brick_get_matrix_mcols(Brick = My_BrickContainer,
    chr1 = "chr3R",
    chr2 = "chr3R",
    resolution = 100000,
    what = "chr1_row_sums")
head(MCols.dat, 100)
```

```
##   [1] 2538.805 3170.278 2959.098 2921.390 2757.116 3068.119 3111.509 3072.646
##   [9] 3024.205 3076.787 3006.798 2939.236 3143.769 3151.878 3093.759 3399.773
##  [17] 3311.725 3239.425 3311.089 3241.726 3414.792 3358.425 3115.033 3330.394
##  [25] 3463.415 3402.376 3394.272 3188.478 3251.863 2977.317 3483.218 3315.259
##  [33] 3061.783 3190.476 3102.852 3372.296 3192.926 3440.699 3360.483 3154.227
##  [41] 3461.711 3311.535 3309.858 3375.721 3169.028 3382.453 3082.640 3414.768
##  [49] 3066.742 2955.019 3383.244 3367.213 2949.371 3036.657 3172.426 3322.047
##  [57] 3353.403 2467.674 3196.153 3279.769 3519.861 3604.991 3454.469 3354.993
##  [65] 3526.682 3640.655 3547.313 3401.935 3167.148 3603.053 3278.416 3579.206
##  [73] 3818.347 3277.754 3320.896 3404.382 3475.993 3457.779 3466.846 3502.008
##  [81] 3601.218 3583.631 3522.309 3345.816 3492.843 3664.113 3367.744 3617.543
##  [89] 3690.629 3576.448 3590.656 3489.232 3349.379 3230.860 3447.384 3309.092
##  [97] 2986.439 2986.469 2646.268 3636.050
```

### 3.2.4 Matrix utility functions

There are several utility functions that a user may take advantage of to do various checks.

* Check if a matrix has been loaded into the Brick object.

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_matrix_isdone(Brick = My_BrickContainer,
    chr1 = "chr3R",
    chr2 = "chr3R",
    resolution = 100000)
```

```
## [1] TRUE
```

* Check if a matrix was defined as a sparse matrix

```
Brick_matrix_issparse(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)
```

```
## [1] FALSE
```

* Check the maximum distance until which a matrix was loaded. This particular function is relevant only when the `Brick_load_cis_matrix_till_distance` has been used.

```
Brick_matrix_maxdist(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)
```

```
## [1] 100
```

* Check if a matrix was defined for a particular chromosome pair

```
Brick_matrix_exists(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)
```

```
## [1] TRUE
```

* Check the minimum and maximum values present within the matrix

```
Brick_matrix_minmax(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)
```

```
## [1]    0.00 2311.41
```

* Get the matrix dimensions, irrespective of the maxdist value.

```
Brick_matrix_dimensions(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)
```

```
## [1] 231 231
```

* Get the original filename of a loaded matrix

```
Brick_matrix_filename(Brick = My_BrickContainer,
    chr1 = "chr2L",
    chr2 = "chr2L",
    resolution = 100000)
```

```
## [1] "Sexton2012_yaffetanay_CisTrans_100000_corrected_chr2L.txt.gz"
```

# 4 Example analyses implemented in HiCBricks

## 4.1 Call Topologically Associated Domains with Local score differentiator (LSD)

Local score differentiator (LSD) is a TAD calling procedure based on the directionality index introduced by Dixon et al., 2012333 Topological domains in mammalian genomes identified by analysis of chromatin interactions.
Dixon JR, Selvaraj S, Yue F, Kim A, Li Y, Shen Y, Hu M, Liu JS and Ren B. Nature 2012. LSD is based on the computation of the directionality index (DI), as described in the original article, but differently from the original procedure, the genome is partitioned into TADs based on the local directionality index distribution rather than its global segmentation. Briefly, transition points between negative and positive values marking TAD boundaries
are identified as the local extreme values in the first derivative of DI computed within a local window of user defined size. This has been implemented into *HiCBricks* as a test case example to show how custom data analysis procedures can be integrated inside the *HiCBricks* framework by taking advantage of its accessor functions.

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Chromosome <- c("chr2L", "chr3L", "chr3R", "chrX")
di_window <- 10
lookup_window <- 30
TAD_ranges <- Brick_local_score_differentiator(Brick = My_BrickContainer,
    chrs = Chromosome,
    resolution = 100000,
    di_window = di_window,
    lookup_window = lookup_window,
    strict = TRUE,
    fill_gaps = TRUE,
    chunk_size = 500)
```

```
## [1] Computing DI for chr2L
```

```
## [2] Computing DI Differences for chr2L
```

```
## [2] Done
```

```
## [3] Fetching Outliers chr2L
```

```
## [3] Done
```

```
## [4] Creating Domain list for chr2L
```

```
## [4] Done
```

```
## [1] Computing DI for chr3L
```

```
## [2] Computing DI Differences for chr3L
```

```
## [2] Done
```

```
## [3] Fetching Outliers chr3L
```

```
## [3] Done
```

```
## [4] Creating Domain list for chr3L
```

```
## [4] Done
```

```
## [1] Computing DI for chr3R
```

```
## [2] Computing DI Differences for chr3R
```

```
## [2] Done
```

```
## [3] Fetching Outliers chr3R
```

```
## [3] Done
```

```
## [4] Creating Domain list for chr3R
```

```
## [4] Done
```

```
## [1] Computing DI for chrX
```

```
## [2] Computing DI Differences for chrX
```

```
## [2] Done
```

```
## [3] Fetching Outliers chrX
```

```
## [3] Done
```

```
## [4] Creating Domain list for chrX
```

```
## [4] Done
```

```
## Warning in .merge_two_Seqinfo_objects(x, y): The 2 combined objects have no sequence levels in common. (Use
##   suppressWarnings() to suppress this warning.)
## Warning in .merge_two_Seqinfo_objects(x, y): The 2 combined objects have no sequence levels in common. (Use
##   suppressWarnings() to suppress this warning.)
## Warning in .merge_two_Seqinfo_objects(x, y): The 2 combined objects have no sequence levels in common. (Use
##   suppressWarnings() to suppress this warning.)
```

Briefly, the `lookup_window` value corresponds to the local window used to identify local extreme changes in the DI values. Setting `strict` to TRUE, adds another additional filter wherein the directionality index is required to be less than or greater than 0 at potential transition points identifying a domain boundary. LSD works by identifying domain starts and ends separately. If a particular domain start was not identified, but the adjacent domain end was identified, `fill_gaps` if set to TRUE, will infer the adjacent bin from the adjacent domain end as a domain start bin and create a domain region with both start and end. Any domains identified by `fill_gaps` are annotated under the *level* column in the resulting `GRanges` object with the value 2. `chunk_size` corresponds to the size of the square to retrieve and process per iteration.

As shown previously, we can store these TAD calls inside the *Brick objects*.

```
Name <- paste("LSD",
    di_window,
    lookup_window, sep = "_")
Brick_add_ranges(Brick = My_BrickContainer,
    ranges = TAD_ranges,
    rangekey = Name,
    resolution = 100000)
```

```
## [1] TRUE
```

### 4.1.1 Fetching the TAD calls from the Brick object

As shown previously, we can list the unique identifiers of the stored ranges (*rangekeys*) using the `Brick_list_rangekeys` function and then retrieve them using the `Brick_get_ranges` function.

```
Brick_list_rangekeys(Brick = My_BrickContainer, resolution = 100000)
```

```
## [1] "Bintable"  "LSD_10_30"
```

```
TAD_ranges <- Brick_get_ranges(Brick = My_BrickContainer, rangekey = Name,
    resolution = 100000)
```

## 4.2 Creating sophisticated data visualization plots using HiCBricks

Using `HiCBricks` functions, users can generate sophisticated plot to visualize Hi-C contact matrices. The representation of contact matrices as a grid with numeric values mapped to a color gradient is commonly referred to as a “heatmap” plot. `HiCBricks` allows users to plot one sample or two samples heatmaps. The following examples show multiple options available to generate heatmaps.

### 4.2.1 Plotting one sample heatmaps

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal.pdf"),
    Bricks = list(My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    palette = "Reds",
    width = 10,
    height = 11,
    return_object=TRUE)
```

![A normal heatmap without any transformations](data:image/png;base64...)

Figure 1: A normal heatmap without any transformations

Please note the **palette** argument. It requires the user to provide a palette name from either the *RColorBrewer* or *viridis* packages colour palettes. At this time, HiCBricks does not allow the usage of user defined colour palettes.

In the examples above we are plotting the Hi-C signal (normalized read counts) which is expected to have a rapid decay when moving away from the diagonal. Log transformation of Hi-C signal is a popular choice to limit the range of values and have a more informative heatmap representation. We can apply a log10 transformation to the data before plotting, as in the example below, which results in a denser (less white spaces) heatmap.

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Failsafe_log10 <- function(x){
    x[is.na(x) | is.nan(x) | is.infinite(x)] <- 0
    return(log10(x+1))
}

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal-colours-log10.pdf"),
    Bricks = list(My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 10,
    height = 11,
    return_object=TRUE)
```

![A normal heatmap with colours computed in log10 scale](data:image/png;base64...)

Figure 2: A normal heatmap with colours computed in log10 scale

Please note how we created a new custom function for log10 transformation. This as well as other user-defined custom functions to be applied on the data can be provided with the argument `FUN`.

Sometimes, the Hi-C signal distribution is biased by outlier values which may stretch the range of values in the color gradient. To limit the range of the color gradient we can cap its maximum value to a specified percentile in the distribution with the `value_cap` argument. This will avoid a skewed distribution of colors due to a few outliers with very high signal.

```
Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal-colours-log10-valuecap-99.pdf"),
    Bricks = list(My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 10,
    height = 11,
    return_object = TRUE)
```

![A normal heatmap with colours computed in log10 scale after capping values to the 99th percentile](data:image/png;base64...)

Figure 3: A normal heatmap with colours computed in log10 scale after capping values to the 99th percentile

*value\_cap* takes as input a value ranging from 0,1 specifying the percentile at which the threshold will be applied.

Sometimes, it is desirable to plot the heatmap as a 45 degree rotated heatmap, i.e. in it’s triangular form. This can simply be obtained with the `rotate=TRUE` parameter.

```
Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal-colours-log10-rotate.pdf"),
    Bricks = list(My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    distance = 60,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 10,
    height = 11,
    rotate = TRUE,
    return_object = TRUE)
```

![Same heatmap as before with colours computed in log10 scale after capping values to the 99th percentile with 45 degree rotation](data:image/png;base64...)

Figure 4: Same heatmap as before with colours computed in log10 scale after capping values to the 99th percentile with 45 degree rotation

To improve the appearance of the plot shown in the example above, we can modify the `width` and `height` as the rotated plots width is larger than their height.

```
Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal-colours-log10-rotate-2.pdf"),
    Bricks = list(My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    distance = 60,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 15,
    height = 5,
    rotate = TRUE,
    return_object = TRUE)
```

![Same heatmap as previous, but now the heatmaps are wider than they are taller](data:image/png;base64...)

Figure 5: Same heatmap as previous, but now the heatmaps are wider than they are taller

We can also add more features to this plot, such as the TADs identified in the previous examples.

```
Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal-colours-log10-rotate-2-tads.pdf"),
    Bricks = list(My_BrickContainer),
    tad_ranges = TAD_ranges,
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    colours = "#230C0F",
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 10,
    height = 11,
    return_object = TRUE)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the HiCBricks package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![Normal rectangular heatmap with colours computed in the log scale after capping values to the 99th percentile with TAD calls](data:image/png;base64...)

Figure 6: Normal rectangular heatmap with colours computed in the log scale after capping values to the 99th percentile with TAD calls

Note that by using the `distance` parameter we can limit the maximum distance from the diagonal up to which we plot the heatmap.

> Please ignore the warning messages that appear with this code chunk. The warnings relate to parts of the TADs that are outside the bounds of the plotting area. The function does not remove these regions before plotting, therefore an error is generated.

```
Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-normal-colours-log10-rotate-3-tads.pdf"),
    Bricks = list(My_BrickContainer),
    tad_ranges = TAD_ranges,
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    colours = "#230C0F",
    FUN = Failsafe_log10,
    value_cap = 0.99,
    distance = 60,
    legend_title = "Log10 Hi-C signal",
    palette = "Reds",
    width = 15,
    height = 5,
    line_width = 0.8,
    cut_corners = TRUE,
    rotate = TRUE,
    return_object=TRUE)
```

```
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_line()`).
## Removed 2 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![Normal rotated heatmap with colours computed in the log scale after capping values to the 99th percentile with TAD calls](data:image/png;base64...)

Figure 7: Normal rotated heatmap with colours computed in the log scale after capping values to the 99th percentile with TAD calls

### 4.2.2 Plotting bipartite (two-sample) heatmaps

HiCBricks allows to easily plot more complex figures, including bipartite heatmaps, i.e. showing two Hi-C samples in two halves of the same heatmap. Bipartite heatmaps can be plotted as squares plots or as 45 degrees rotated (triangular) heatmaps, with or without additional features such as TAD borders.

Due to space limitations placed on example datasets within Bioconductor packages, in this vignette example we will use the same dataset as before to showcase how two-sample heatmaps can be drawn using the HiCBricks package.

To plot a two sample heatmap, we need only to include an additional Brick file in the `Brick` parameter. The data from the two brick files will be plotted in the upper and lower triangle, respectively. The first `Brick` file will go to the upper triangle, whereas the second `Brick` file will go to the lower triangle.

> **NOTE:** The main diagonal will be set to the 0 in both plots as the main diagonal overlaps between the two contact matrices.

```
Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    width = 10,
    height = 11,
    return_object = TRUE)
```

![A normal two sample heatmap with colours computed in log10 scale after capping values to the 99th percentile](data:image/png;base64...)

Figure 8: A normal two sample heatmap with colours computed in log10 scale after capping values to the 99th percentile

Since this Hi-C map is sparse there are few informative data points at larger distances. In this case the end-user may want to limit the plot by not showing longer distance interactions. This is achieved using the `distance` parameter. Remember, that we can use any of the `RColorBrewer` or `viridis` colour palettes. For example, we can use the Red to Gray (name `RdGy`) palette from `RColorBrewer`

```
Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99-2.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "RdGy",
    distance = 30,
    width = 10,
    height = 11,
    return_object = TRUE)
```

![A normal two sample heatmap with colours computed in log10 scale on values until the 30th diagonal and capping these values to the 99th percentile.](data:image/png;base64...)

Figure 9: A normal two sample heatmap with colours computed in log10 scale on values until the 30th diagonal and capping these values to the 99th percentile

Finally, we can once again rotate the two sample heatmaps.

```
Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99-rotate.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    distance = 30,
    width = 15,
    height = 4,
    rotate = TRUE,
    return_object = TRUE)
```

![A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 99th percentile.](data:image/png;base64...)

Figure 10: A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 99th percentile

### 4.2.3 Plotting TADs on Bipartite heatmaps

HiCBricks also allows the possibility to plot TADs on the Bipartite heatmaps with categorical colours for each of the TAD calls. Although users may provide more than one category per sample, they should be aware that when TADs overlap, the TAD which is plotted at the end will always be the one that appears at the top, while other overlapping TADs will be hidden at the bottom.

As an example we will prepare a set of TAD calls and store them in the Brick object to compare them.

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Chromosome <- "chr3R"
di_windows <- c(5,10)
lookup_windows <- c(10, 20)
for (i in seq_along(di_windows)) {

    di_window <- di_windows[i]
    lookup_window <- lookup_windows[i]

    TAD_ranges <- Brick_local_score_differentiator(Brick = My_BrickContainer,
        chrs = Chromosome,
        resolution = 100000,
        di_window = di_window,
        lookup_window = lookup_window,
        strict = TRUE,
        fill_gaps=TRUE,
        chunk_size = 500)

    Name <- paste("LSD",
        di_window,
        lookup_window,
        Chromosome,sep = "_")

    Brick_add_ranges(Brick = My_BrickContainer, ranges = TAD_ranges,
      resolution = 100000, rangekey = Name)
}
```

```
## [1] Computing DI for chr3R
```

```
## [2] Computing DI Differences for chr3R
```

```
## [2] Done
```

```
## [3] Fetching Outliers chr3R
```

```
## [3] Done
```

```
## [4] Creating Domain list for chr3R
```

```
## [4] Done
```

```
## [1] Computing DI for chr3R
```

```
## [2] Computing DI Differences for chr3R
```

```
## [2] Done
```

```
## [3] Fetching Outliers chr3R
```

```
## [3] Done
```

```
## [4] Creating Domain list for chr3R
```

```
## [4] Done
```

To plot these TAD calls, they need to be formatted correctly before plotting. This involves assigning categorical values to each of the TAD calls we want to plot. We will assign two categorical variables, one will map the TADs to their respective Hi-C map, whereas the other will map the TADs to their respective category.

```
Chromosome <- "chr3R"
di_windows <- c(5,10)
lookup_windows <- c(10, 20)
TADs_list <- list()
for (i in seq_along(di_windows)) {

    di_window <- di_windows[i]
    lookup_window <- lookup_windows[i]

    Name <- paste("LSD",
        di_window,
        lookup_window,
        Chromosome,sep = "_")

    TAD_ranges <- Brick_get_ranges(Brick = My_BrickContainer,
        resolution = 100000, rangekey = Name)
    # Map TADs to their Hi-C maps
    TAD_ranges$group <- i
    # Map TADs to a specific categorical value for the colours
    TAD_ranges$colour_group <- paste("LSD", di_window, lookup_window,
        sep = "_")
    TADs_list[[Name]] <- TAD_ranges
}

TADs_ranges <- do.call(c, unlist(TADs_list, use.names = FALSE))
```

As described in the manual, the two parameters, `group_col` and
`tad_colour_col` are relevant towards assigning any TAD to its respective Hi-C map or category, respectively. These two parameters take as input, the column names corresponding to their respective columns in the `TADs_ranges` object.
Meanwhile, `colours` and `colours_names` are the relevant parameter for the colours of the TAD boundaries. `colours` is a required parameter in case TAD boundaries are provided, whereas `colours_names` can be left empty in case the user intends to provide `unique(TAD_ranges$colour_group)` as the `colour_names`.

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Colours <- c("#B4436C", "#F78154")
Colour_names <- unique(TADs_ranges$colour_group)

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99-tads.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.97,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    tad_ranges = TADs_ranges,
    group_col = "group",
    tad_colour_col = "colour_group",
    colours = Colours,
    colours_names = Colour_names,
    distance = 30,
    width = 9,
    height = 11,
    return_object=TRUE)
```

![A normal two sample heatmap with colours computed in log10 scale and capping these values to the 97th percentile, with TAD borders](data:image/png;base64...)

Figure 11: A normal two sample heatmap with colours computed in log10 scale and capping these values to the 97th percentile, with TAD borders

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Colours <- c("#B4436C", "#F78154")
Colour_names <- unique(TADs_ranges$colour_group)

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99-rotate-tads.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.97,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    tad_ranges = TADs_ranges,
    group_col = "group",
    tad_colour_col = "colour_group",
    colours = Colours,
    colours_names = Colour_names,
    distance = 30,
    width = 15,
    height = 4,
    rotate = TRUE,
    return_object=TRUE)
```

```
## Warning: Removed 3 rows containing missing values or values outside the scale range
## (`geom_line()`).
## Removed 3 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 97th percentile, with non-truncated TAD borders](data:image/png;base64...)

Figure 12: A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 97th percentile, with non-truncated TAD borders

Note, that while creating rotated plots with TADs, if the parameter `cut_corners` is not set to TRUE, then the default behaviour is to plot continuous lines. To truncate lines at the corners of TADs, users should set this parameter to value `TRUE`.

```
BrickContainer_dir <- file.path(tempdir(), "HiCBricks_vignette_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

Colours <- c("#B4436C", "#F78154")
Colour.names <- unique(TADs_ranges$colour_group)

Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-colours-log10-valuecap-99-rotate-tads-2.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.97,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    tad_ranges = TADs_ranges,
    group_col = "group",
    tad_colour_col = "colour_group",
    colours = Colours,
    colours_names = Colour_names,
    distance = 30,
    width = 15,
    height = 4,
    cut_corners = TRUE,
    rotate = TRUE,
    return_object=TRUE)
```

```
## Warning: Removed 5 rows containing missing values or values outside the scale range
## (`geom_line()`).
## Removed 5 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 97th percentile, with truncated TAD borders](data:image/png;base64...)

Figure 13: A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 97th percentile, with truncated TAD borders

### 4.2.4 Making edits to additional plot elements

There are several features that are not ideal in the above plots that can be fixed according to end-users preferences by adjusting additional parameters.

* The TAD border lines are too thin and are not clearly visible. This problem can be addressed by adjusting the `line_width` parameter.
* The legends are outside the bounds of the plotting area. We can make changes to the legend with a few parameter changes to the `legend_key_width` and `legend_key_height` parameters.

```
Brick_vizart_plot_heatmap(File = file.path(tempdir(),
  "chr3R-1-10MB-bipartite-final.pdf"),
    Bricks = list(My_BrickContainer, My_BrickContainer),
    x_coords = "chr3R:1:10000000",
    y_coords = "chr3R:1:10000000",
    resolution = 100000,
    FUN = Failsafe_log10,
    value_cap = 0.99,
    legend_title = "Log10 Hi-C signal",
    palette = "YlGnBu",
    tad_ranges = TADs_ranges,
    group_col = "group",
    tad_colour_col = "colour_group",
    colours = Colours,
    colours_names = Colour.names,
    distance = 30,
    width = 15,
    height = 4,
    legend_key_width = unit(10, "mm"),
    legend_key_height = unit(5, "mm"),
    line_width = 1.2,
    cut_corners = TRUE,
    rotate = TRUE,
    return_object=TRUE)
```

```
## Warning: Removed 5 rows containing missing values or values outside the scale range
## (`geom_line()`).
## Removed 5 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 99th percentile.](data:image/png;base64...)

Figure 14: A rotated two sample heatmap with colours computed in log10 scale and capping these values to the 99th percentile

### 4.2.5 Modifying text elements in plots

There are several additional parameters which can be used to modify tex elements in plots.

* It is possible to completely remove the x and y axis by setting the parameters `x_axis` and `y_axis` to FALSE.
* The default x and y axis titles can be modified using the `x_axis_title` and `y_axis_title` parameter.
* The plot title can be adjusted using the `title` parameter.
* The legend title can be adjusted using the `legend_title` parameter.
* Furthermore, users can also adjust the number of ticks that appear on the x and y axis when these axis labels are present. The number of ticks can be identified using the `x_axis_num_breaks` and `y_axis_num_breaks` parameters.

Finally, the parameters to modify text size in these individual elements are the following ones:

* `text_size` controls the font size across all plot elements, but is superseded by individual parameters.
* `x_axis_text_size` and `y_axis_text_size` control the text size on the x and y axis.
* `legend_title_text_size` controls the font size of the legend title.
* `legend_text_size` controls the font size of individual legend elements.
* `title_size` controls the size of the plot title.