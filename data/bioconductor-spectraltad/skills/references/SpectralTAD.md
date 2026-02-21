# SpectralTAD Vignette

Kellen Cresswell1, John Stansfield1 and Mikhail Dozmorov1

1Department of Biostatistics, Virginia Commonwealth University, Richmond, VA

#### October 30, 2025

#### Abstract

SpectralTAD is an R package designed to identify Topologically Associated Domains (TADs) from Hi-C contact matrices. It uses a modified version of spectral clustering that uses a sliding window to quickly detect TADs. The function works on a range of different formats of contact matrices and returns a list of data frames or GRanges in BED format with TAD coordinates, seperated by hierarchy level. The method does not require users to adjust any parameters to work and gives them control over the number of levels to be returned.

#### Package

SpectralTAD 1.26.0

# Contents

* [1 Introduction](#introduction)
* [2 Getting Started](#getting-started)
  + [2.1 Installation](#installation)
  + [2.2 Input data](#input-data)
    - [2.2.1 Working with \(n \times n\) matrices](#working-with-n-times-n-matrices)
    - [2.2.2 Working with \(n \times (n+3)\) matrices](#working-with-n-times-n3-matrices)
    - [2.2.3 Working with sparse 3-column matrices](#working-with-sparse-3-column-matrices)
    - [2.2.4 Working with other data types](#working-with-other-data-types)
  + [2.3 Running SpectralTAD](#running-spectraltad)
  + [2.4 Filtering TADs](#filtering-tads)
    - [2.4.1 Silhouette score filtering](#silhouette-score-filtering)
    - [2.4.2 Z-score filtering](#z-score-filtering)
  + [2.5 Finding hierarchical TADS](#finding-hierarchical-tads)
  + [2.6 Removing gaps](#removing-gaps)
  + [2.7 Running SpectralTAD with parallelization](#running-spectraltad-with-parallelization)
  + [2.8 Effect of matrix type on runtime](#effect-of-matrix-type-on-runtime)
  + [2.9 Effect of parameters on runtime](#effect-of-parameters-on-runtime)
  + [2.10 Using SpectralTAD output with HiCExplorer and Juicebox](#using-spectraltad-output-with-hicexplorer-and-juicebox)
    - [2.10.1 Using SpectralTAD with HiCExplorer](#using-spectraltad-with-hicexplorer)
    - [2.10.2 Using SpectralTAD with Juicebox](#using-spectraltad-with-juicebox)
* [References](#references)

# 1 Introduction

`SpectralTAD` is a package designed to allow for fast hierarchical TAD calling on a wide-variety of chromatin conformation capture (Hi-C) data. `SpectralTAD` takes a contact matrix as an input and outputs a list of data frames or GRange objects in BED format containing coordinates corresponding to TAD locations. The package contains two functions, `SpectralTAD()` and `SpectralTAD_Par()` with SpectralTAD being a single-CPU TAD-caller and `SpectralTAD_Par` being the parallelized version. This package provides flexibility in the data it accepts, allowing for \(n \times n\) (square numerical matrix), \(n \times (n+3)\) (square numerical matrix with the additional chromosome, start, end columns), and 3-column sparse matrices (described below). There are no parameters required for running the functions, though certain methods for customizing the results are available. The idea is to give users the freedom to control how they call TADs while giving them the option to perform it in an unsupervised manner.

The package is based around the windowed spectral clustering algorithm, introduced by (Cresswell, Stansfield, and Dozmorov [2019](#ref-cresswell:2019aa)) , which is designed to be robust to sparsity, noise, and sequencing depth of Hi-C data.

# 2 Getting Started

## 2.1 Installation

```
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SpectralTAD")
devtools::install_github("dozmorovlab/SpectralTAD")
library(SpectralTAD)
```

## 2.2 Input data

### 2.2.1 Working with \(n \times n\) matrices

\(n \times n\) contact matrices, are most commonly associated with data coming from the Bing Ren lab (<http://chromosome.sdsc.edu/mouse/hi-c/download.html>). These contact matrices are square and symmetric with entry \(ij\) corresponding to the number of contacts between region \(i\) and region \(j\). Below is an example of a \(5 \times 5\) region of an \(n \times n\) contact matrix. Derived from (Rao et al. [2014](#ref-Rao:2014aa)), chromosome 20 data at 25kb resolution. Note the symmetry around the diagonal - the typical shape of chromatin interaction matrix.

```
##             50000    75000   100000   125000   150000
##    50000     2021      727      203      205      155
##    75000      727     3701      583      491      348
##   100000      203      583     2023      603      274
##   125000      205      491      603     3350      676
##   150000      155      348      274      676     2528
```

### 2.2.2 Working with \(n \times (n+3)\) matrices

\(n \times (n+3)\) matrices are commonly associated with the TopDom tad-caller (<http://zhoulab.usc.edu/TopDom/>). These matrices consist of a normal \(n \times n\) matrix but with 3 additional leading columns containg the chromosome, the start of the region and the end of the region. Regions in this case are determined by the resolution of the data. The typical \(n \times (n+3)\) matrix is shown below.

```
##
## 1  chr19  50000  75000 2021  727  203  205  155  165  193
## 2  chr19  75000 100000  727 3701  583  491  348  335  350
## 3  chr19 100000 125000  203  583 2023  603  274  228  213
## 4  chr19 125000 150000  205  491  603 3350  676  447  390
## 5  chr19 150000 175000  155  348  274  676 2528  732  463
## 6  chr19 175000 200000  165  335  228  447  732 3497  998
## 7  chr19 200000 225000  193  350  213  390  463  998 4450
## 8  chr19 225000 250000  135  236  137  259  301  543 1061
## 9  chr19 250000 275000  158  259  183  299  317  554  731
## 10 chr19 275000 300000   96  166  115  171  179  319  416
```

### 2.2.3 Working with sparse 3-column matrices

Sparse 3-column matrices, sometimes referred to as a coordinated lists, are matrices where the first and second column refer to region \(i\) and region \(j\) of the chromosome, and the third column is the number of contacts between them. This style is becoming increasingly popular and is associated with raw data from Rao (<https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63525>), and is the data output produced by the Juicer tool (Durand et al. [2016](#ref-Durand:2016aa)). 3-column matrices are handled internally in the package by converting them to \(n \times n\) matrices using the `HiCcompare` package’s `sparse2full()` function. The first 5 rows of a typical sparse 3-column matrix is shown below.

```
##    region1 region2    IF
##      <num>   <num> <num>
## 1:   50000   50000  2021
## 2:   50000   75000   727
## 3:   75000   75000  3701
## 4:   50000  100000   203
## 5:   75000  100000   583
```

### 2.2.4 Working with other data types

Users can also find TADs from data output by `juicer` (<https://github.com/aidenlab/juicer>, .hic format), `cooler` (<http://cooler.readthedocs.io/en/latest/index.html>, .cool format), and HiC-Pro (<https://github.com/nservant/HiC-Pro>, .matrix and .bed formats) with minor pre-processing using the `HiCcompare` package.

#### 2.2.4.1 Working with .hic files

Sparse matrices can be extracted from .hic files using the `straw` tool <https://github.com/theaidenlab/straw>. See examples on how to use `straw` at <https://github.com/theaidenlab/straw/wiki/CPP#running>. Briefly, `straw` requires several inputs for the extraction of data from a `.hic` file:

`<NONE/VC/VC_SQRT/KR> <hicFile(s)> <chr1>[:x1:x2] <chr2>[:y1:y2] <BP/FRAG> <binsize>`

The first field indicates the type of normalization to be applied. The Vanilla Coverage (VC), the square root of Vanilla Coverage (VC\_SQRT), and Knight-Ruiz (KR) normalization techniques are available to be applied to the contact maps. Alternatively, the raw contact maps can be extracted using the NONE option (recommended for SpectralTAD).

The second field is the file name of the `.hic` file to be extracted. The following two fields are the chromosome numbers for the contact map desired, i.e., for the intrachromosomal map of chr1 the user would enter 1 1 in these fields. The next field determines if basepairs or restriction fragment resolution files will be returned. Typically, the user will want to use the `BP` option. The final field specifies the resolution of the contact map.

For example, to extract the raw matrix corresponding to chromosome 22 at 500kb resolution from the `GSE63525_K562_combined_30.hic` file, we would use the following command:

`./straw NONE GSE63525_K562_combined_30.hic 22 22 BP 500000 > K562.chr22.500kb.txt`

This will extract the data from the `.hic` file and save it to the `K562.chr22.500kb.txt` text file, in the sparse upper triangular matrix format. Typically, chromosome-specific matrices are saved in separate files.
#### Working with .cool files

The cooler software can be downloaded from <http://cooler.readthedocs.io/en/latest/index.html>. It essentially provides access to a catalog of popular HiC datasets. We can pre-process and use .cool files that are associated with cooler files using the following steps:

1. Download `.cool` file from (ftp://cooler.csail.mit.edu/coolers)
2. Convert to text file using `cooler dump --join Rao2014-GM12878-DpnII-allreps-filtered.50kb.cool > Rao.GM12878.50kb.txt`
3. Run the code below

```
#Read in data
cool_mat = read.table("Rao.GM12878.50kb.txt")
#Convert to sparse 3-column matrix using cooler2sparse from HiCcompare
sparse_mats = HiCcompare::cooler2sparse(cool_mat)
#Remove empty matrices if necessary
#sparse_mats = sparse_mats$cis[sapply(sparse_mats, nrow) != 0]
#Run SpectralTAD
spec_tads = lapply(names(sparse_mats), function(x) {
  SpectralTAD(sparse_mats[[x]], chr = x)
})
```

#### 2.2.4.2 Working with HiC-Pro files

HiC-Pro data comes with 2 files, the `.matrix` file and the `.bed` file. The `.matrix` file is a 3-column matrix where instead of coordinates as the 1st and 2nd column, there is an ID. The `.bed` file maps these IDs to genomic coordinates. The steps for analyzing these files is shown below:

```
#Read in both files
mat = read.table("amyg_100000.matrix")
bed = read.table("amyg_100000_abs.bed")
#Convert to modified bed format
sparse_mats = HiCcompare::hicpro2bedpe(mat,bed)
#Remove empty matrices if necessary
#sparse_mats$cis = sparse_mats$cis[sapply(sparse_mats, nrow) != 0]
#Go through all matrices
sparse_tads = lapply(sparse_mats$cis, function(x) {
  #Pull out chromosome
  chr = x[,1][1]
  #Subset to make three column matrix
  x = x[,c(2,5,7)]
  #Run SpectralTAD
  SpectralTAD(x, chr=chr)
})
```

## 2.3 Running SpectralTAD

Once matrices are in an acceptable format, SpectralTAD can be run with as little as two parameters or as many as eight. Below we show how to run the algorithm with just TAD detection and no quality filtering.

```
#Get the rao contact matrix built into the package
data("rao_chr20_25_rep")
head(rao_chr20_25_rep)
```

```
##       V1     V2   V3
## 1  50000  50000 2021
## 2  50000  75000  727
## 3  75000  75000 3701
## 4  50000 100000  203
## 5  75000 100000  583
## 6 100000 100000 2023
```

```
#We see that this is a sparse 3-column contact matrix
#Running the algorithm with resolution specified
results = SpectralTAD(rao_chr20_25_rep, chr = "chr20", resolution = 25000, qual_filter = FALSE, z_clust = FALSE)
#Printing the top 5 TADs
head(results$Level_1, 5)
```

```
## # A tibble: 5 × 4
##   chr     start     end Level
##   <chr>   <dbl>   <dbl> <dbl>
## 1 chr20   50000  325000     1
## 2 chr20  325000  525000     1
## 3 chr20  525000  725000     1
## 4 chr20  725000 1200000     1
## 5 chr20 1200000 1450000     1
```

```
#Repeating without specifying resolution
no_res = SpectralTAD(rao_chr20_25_rep, chr = "chr20", qual_filter = FALSE, z_clust = FALSE)
#We can see below that resolution can be estimated automatically if necessary
identical(results, no_res)
```

```
## [1] TRUE
```

## 2.4 Filtering TADs

### 2.4.1 Silhouette score filtering

One method for filtering TADs is using group-wise silhouette scores. This is done by getting the overall silhouette for each group and removing those with a score of less than .25. A low silhouette score for a given TAD indicates a poor level of connectivity within it.

```
#Running SpectralTAD with silhouette score filtering
qual_filt = SpectralTAD(rao_chr20_25_rep, chr = "chr20", qual_filter = TRUE, z_clust = FALSE, resolution = 25000)
#Showing quality filtered results
head(qual_filt$Level_1,5)
```

```
## # A tibble: 5 × 5
##   chr     start     end Sil_Score Level
##   <chr>   <dbl>   <dbl> <dbl[1d]> <dbl>
## 1 chr20   50000  325000     0.475     1
## 2 chr20  325000  525000     0.699     1
## 3 chr20  525000  725000     0.640     1
## 4 chr20  725000 1200000     0.384     1
## 5 chr20 1200000 1450000     0.676     1
```

```
#Quality filtering generally has different dimensions
dim(qual_filt$Level_1)
```

```
## [1] 168   5
```

```
dim(results$Level_1)
```

```
## [1] 170   4
```

The results when using the quality filtering option are altered to include a new column called `Sil_Score`. This column includes a group-wise silhouette score. In this example a single TAD was removed due to having poor organization (Low silhouette score).

### 2.4.2 Z-score filtering

Z-score filtering is based on observations about the log-normality of the distance between eigenvector gaps from (Cresswell, Stansfield, and Dozmorov [2019](#ref-cresswell:2019aa)). Z-score filtering bypasses the uses of silhouette score and defines a TAD boundary as the area between consecutive regions where the z-score of the eigenvector gap is greater than 2.

```
z_filt = SpectralTAD(rao_chr20_25_rep, chr = "chr20", qual_filter = FALSE, z_clust = TRUE, resolution = 25000)
head(z_filt$Level_1, 5)
```

```
## # A tibble: 5 × 4
##   chr     start     end Level
##   <chr>   <dbl>   <dbl> <dbl>
## 1 chr20   50000  350000     1
## 2 chr20  350000  550000     1
## 3 chr20  550000  675000     1
## 4 chr20  675000 1125000     1
## 5 chr20 1125000 1475000     1
```

```
dim(z_filt$Level_1)
```

```
## [1] 151   4
```

We can see that TADs found using this method are generally more fine than those found using the silhouette score based filtering. Z-score filtering is more suited for people not interested in TAD hierarchies because the initial TADs detected are less broad than those by quality filtering.

## 2.5 Finding hierarchical TADS

Our method is specifically designed to find hierarchical TADs. To do so, users must specify how many levels they are interested in using the `levels` parameter. There is no limit to the number of levels but after a certain point no new TADs will be found due to limitations in TAD size or TAD quality. Hierarchies are found by running the algorithm initially and then iteratively running it on sub-TADs until none can be found. At the levels below the initial level we use z-score filtering by default.

```
#Running SpectralTAD with 3 levels and no quality filtering
spec_hier = SpectralTAD(rao_chr20_25_rep, chr = "chr20", resolution = 25000, qual_filter = FALSE, levels = 3)
#Level 1 remains unchanged
head(spec_hier$Level_1,5)
```

```
## # A tibble: 5 × 4
##   chr     start     end Level
##   <chr>   <dbl>   <dbl> <dbl>
## 1 chr20   50000  325000     1
## 2 chr20  325000  525000     1
## 3 chr20  525000  725000     1
## 4 chr20  725000 1200000     1
## 5 chr20 1200000 1450000     1
```

```
#Level 2 contains the sub-TADs for level 1
head(spec_hier$Level_2,5)
```

```
## # A tibble: 5 × 4
##   chr     start     end Level
##   <chr>   <dbl>   <dbl> <dbl>
## 1 chr20  325000  525000     2
## 2 chr20  525000  725000     2
## 3 chr20 1200000 1450000     2
## 4 chr20 1450000 1750000     2
## 5 chr20 1775000 1975000     2
```

```
#Level 3 contains even finer sub-TADs for level 1 and level 2
head(spec_hier$Level_3,5)
```

```
## # A tibble: 5 × 4
##   chr     start     end Level
##   <chr>   <dbl>   <dbl> <dbl>
## 1 chr20  325000  525000     3
## 2 chr20  525000  725000     3
## 3 chr20 1200000 1450000     3
## 4 chr20 1775000 1975000     3
## 5 chr20 1975000 2175000     3
```

Note that as we move down levels, more gaps form indicating regions where sub-TADs are not present.

## 2.6 Removing gaps

Though, it has been shown that windowed spectral clustering is more robust to sparsity than other common methods(Cresswell, Stansfield, and Dozmorov [2019](#ref-cresswell:2019aa)), there is still some instability caused by consecutive regions of gaps. To counter this, we use a `gap_threshold` parameter to allow users to exclude regions based on how many zeros are included. By default this value is set to 1 which means only columns/rows with 100% of values being zero are removed before analysis. Accordingly, setting this value to .7 would mean rows/columns with 70% zeros would be removed. Since we are not interested in long-range contacts for TAD identification, this percentage only applies to the number of zeros within a specific distance of the diagonal (Defined by the maximum TAD size). Users must be careful not to filter too much as this can remove informative regions of the matrix.

## 2.7 Running SpectralTAD with parallelization

It is sometimes the case that people want to run SpectralTAD on multiple chromosomes at once in parallel. This can be done using the `SpectralTAD_Par` function. SpectralTAD\_Par is identical to SpectralTAD but takes a list of contact matrices as an input. These matrices can be of any of the allowable types and mixing of types is allowed. Users are required to provide a vector of chromosomes, `chr_over`, where it is ordered such that each entry matches up with its corresponding contact matrix in the list of matrices. Users can also input list names using the `labels` parameter. In terms of parallelization, users can either input the number of cores they would like to use or the function will automatically use 1 less than the total number of cores on the computer on which it is ran. The function works on Linux/Mac and Windows with automatic OS detection built in. We show the steps below.

```
#Creating replicates of our HiC data for demonstration
cont_list = replicate(3,rao_chr20_25_rep, simplify = FALSE)
#Creating a vector of chromosomes
chr_over = c("chr20", "chr20", "chr20")
#Creating a list of labels
labels = c("Replicate 1", "Replicate 2", "Replicate 3")
SpectralTAD_Par(cont_list = cont_list, chr_over = chr_over, labels = labels, cores = 3)
```

## 2.8 Effect of matrix type on runtime

The type of matrix input into the algorithm can affect runtimes for the algorithm. \(n \times n\) matrices require no conversion and are the fastest. Meanwhile, \(n \times (n+3)\) matrices take slightly longer to run due to the need to remove the first 3 columns. Sparse 3-column matrices have the highest runtimes due to the complexity of converting them to an \(n \times n\) matrix. The times are summarized below, holding all other parameters constant.

```
library(microbenchmark)
#Converting to nxn
n_n = HiCcompare::sparse2full(rao_chr20_25_rep)
#Converting to nxn+3
n_n_3 = cbind.data.frame("chr20", as.numeric(colnames(n_n)), as.numeric(colnames(n_n))+25000, n_n)
#Defining each function
sparse = SpectralTAD(cont_mat = rao_chr20_25_rep, chr = "chr20", qual_filter = FALSE)
n_by_n = SpectralTAD(cont_mat = n_n, chr = "chr20", qual_filter = FALSE)
n_by_n_3 =SpectralTAD(cont_mat = n_n_3, chr = "chr20", qual_filter = FALSE)

#Benchmarking different parameters
microbenchmark(sparse = SpectralTAD(cont_mat = rao_chr20_25_rep, chr = "chr20", qual_filter = FALSE),
n_by_n = SpectralTAD(cont_mat = n_n, chr = "chr20", qual_filter = FALSE),
n_by_n_3 =SpectralTAD(cont_mat = n_n_3, chr = "chr20", qual_filter = FALSE), unit = "s", times = 3)
```

```
## Unit: seconds
##      expr      min       lq     mean   median       uq      max neval cld
##    sparse 2.468950 2.545065 2.602976 2.621180 2.669989 2.718797     3  a
##    n_by_n 1.960877 2.090673 2.285997 2.220468 2.448557 2.676647     3  ab
##  n_by_n_3 1.936710 1.961107 1.973196 1.985504 1.991439 1.997375     3   b
```

## 2.9 Effect of parameters on runtime

Just as the type of data affects runtime, the parameters used to detect TADs do as well. The main bottleneck is the quality filter function which requires the inversion of a matrix and the calculation of silhouette score.

```
microbenchmark(quality_filter = SpectralTAD(cont_mat = n_n, chr = "chr20", qual_filter = TRUE, z_clust = FALSE), no_filter = SpectralTAD(cont_mat = n_n, chr = "chr20", qual_filter = FALSE, z_clust = FALSE), z_clust = SpectralTAD(cont_mat = n_n, chr = "chr20", qual_filter = FALSE, z_clust = TRUE), times = 3, unit = "s")
```

```
## Unit: seconds
##            expr      min       lq     mean   median       uq      max neval cld
##  quality_filter 2.144714 2.151532 2.160938 2.158350 2.169050 2.179750     3 a
##       no_filter 1.909517 1.933010 1.949487 1.956504 1.969472 1.982439     3  b
##         z_clust 1.302663 1.310069 1.319555 1.317474 1.328001 1.338529     3   c
```

As can be seen using the z-score method is the fastest.

## 2.10 Using SpectralTAD output with HiCExplorer and Juicebox

SpectralTAD is designed to work in tandem with Juicebox (<http://www.aidenlab.org/juicebox/>) and HiCExplorer (<https://hicexplorer.usegalaxy.eu/>), two popular TAD visualization tools. Users may output files, corresponding to either tools.

### 2.10.1 Using SpectralTAD with HiCExplorer

HiCExplorer takes simple bed files. To use SpectralTAD with HiCExplorer, do the following:

```
#Get contact matrix
data("rao_chr20_25_rep")
head(rao_chr20_25_rep)
#Run spectral TAD with output format "hicexplorer" or "bed" and specify the path
spec_hier = SpectralTAD(rao_chr20_25_rep, chr = "chr20", resolution = 25000, qual_filter = FALSE, levels = 3, out_format = "hicexplorer", out_path = "chr20.bed")
```

This code will output a three-column bed file with TAD coordinates for all three levels. hicPlotTADs from HiCExplorer takes a .ini configuration file. To use SpectralTAD results you simply just have to set the output file as the directory under the [tads] subheading. For a full walk-through see (<https://hicexplorer.readthedocs.io/en/latest/content/tools/hicPlotTADs.html#id4>) under the heading “Configuration file template.”

### 2.10.2 Using SpectralTAD with Juicebox

Juicebox takes bedpe files as its primary file type. To use SpectralTAD with Juicebox, do the following:

```
#Get contact matrix
data("rao_chr20_25_rep")
head(rao_chr20_25_rep)
#Run spectral TAD with output format "hicexplorer" or "bed" and specify the path
spec_hier = SpectralTAD(rao_chr20_25_rep, chr = "chr20", resolution = 25000, qual_filter = FALSE, levels = 3, out_format = "juicebox", out_path = "chr20.bedpe")
```

The output for this code is an 11-column bedpe file, which is formatted to work for Juicebox. To use the file, you must first select a HiC matrix in the Juicebox interface (<https://www.aidenlab.org/juicebox/>). This is done by choosing `Load Map -> Select File -> Select Contact Map`. This data corresponds to `Rao and Huntley et al. | Cell 2014 GM12878 (human) in situ ENCODE Batch 1 HIC048` so we select this. Alternatively, you can upload your own hic matrix in .hic or .cool format. To select the TADs called by `SpectralTAD` simply choose `Load Tracks -> Local Track File -> Choose File -> chr20.bedpe`. To view chromosome 20 specifically, select `≡ -> Chromosomes -> chr20`.

# References

Cresswell, Kellen G, John C Stansfield, and Mikhail G Dozmorov. 2019. “SpectralTAD: An R Package for Defining a Hierarchy of Topologically Associated Domains Using Spectral Clustering,” February. <https://doi.org/10.1101/549170>.

Durand, Neva C., Muhammad S. Shamim, Ido Machol, Suhas S. P. Rao, Miriam H. Huntley, Eric S. Lander, and Erez Lieberman Aiden. 2016. “Juicer Provides a One-Click System for Analyzing Loop-Resolution Hi-c Experiments.” *Cell Systems* 3 (1): 95–98. <https://doi.org/10.1016/j.cels.2016.07.002>.

Rao, Suhas S.P., Miriam H. Huntley, Neva C. Durand, Elena K. Stamenova, Ivan D. Bochkov, James T. Robinson, Adrian L. Sanborn, et al. 2014. “A 3D Map of the Human Genome at Kilobase Resolution Reveals Principles of Chromatin Looping.” *Cell* 159 (7): 1665–80. <https://doi.org/10.1016/j.cell.2014.11.021>.