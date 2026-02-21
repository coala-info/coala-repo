# Analyzing Bisulfite-seq data with dmrseq

Keegan Korthauer

#### 29 October 2025

#### Abstract

A basic task in the analysis of count data from Whole Genome Bisulfite-Sequencing is the detection of differentially methylated regions. The count data consist of, for each sample, the number of methylated reads and the total number of reads covering CpG. An important analysis question is to detect regions (collections of neighboring CpGs) with systematic differences between conditions, as compared to within-condition variability. These so-called Differentially Methylated Regions (DMRs) are thought to be more informative than single CpGs in terms of of biological function. Although several methods exist to quantify and perform statistical inference on changes at the individual CpG level, detection of DMRs is still limited to aggregating signifiant CpGs without proper inference at the region level. The package **dmrseq** addresses this gap by providing a rigorous permutation-based approach to detect and perform inference for differential methylation by use of generalized least squares models that account for inter-individual and inter-CpG variability to generate region-level statistics that can be comparable across the genome. This allows the framework to perform well even on samples as small as two per group. This vignette explains the use of the package and demonstrates typical workflows. This vignette was generated with dmrseq package version 1.30.0

#### Package

dmrseq 1.30.0

# 1 Quick start

**If you use dmrseq in published research, please cite:**

> Korthauer, K., Chakraborty, S., Benjamini, Y., and Irizarry, R.A.
> Detection and accurate False Discovery Rate control of differentially
> methylated regions from Whole Genome Bisulfite Sequencing
> *Biostatistics*, 2018 (in press).

This package builds upon the
[bsseq](http://bioconductor.org/packages/bsseq) package (Hansen, Langmead, and Irizarry [2012](#ref-Hansen2012)),
which provides efficient storage and manipulation of bisulfite
sequencing data and inference for differentially methylated CpGs.
The main goal of **dmrseq** (Korthauer et al. [2018](#ref-Korthauer183210))
is to provide inference for differentially methylated *regions*, or
groups of CpGs.

Here we show the most basic steps for a differential methylation
analysis. There are a variety of steps upstream of **dmrseq** that result
in the generation of counts of methylated reads and total reads covering each
CpG for each sample, including mapping of sequencing reads to a reference
genome with and without bisulfite conversion. You can use the software
of your preference for this step (one option is
[Bismark](https://www.bioinformatics.babraham.ac.uk/projects/bismark/)), as
long as you are able to obtain counts of methylation and coverage (as
opposed to solely methylation proportions, as discussed below).

This package uses a specific data structure to store and manipulate
bisulfite sequencing data introduced by the **bsseq** package. This data
structure is a *class* called `BSseq`. Objects of the class `BSseq` contain
all pertinent information for a bisulfite sequencing experiment, including
the number of reads corresponding to methylation, and the total number
of reads at each
CpG site, the location of each CpG site, and experimental metadata on the
samples. Note that here we focus on CpG methylation, since this is the
most common form of methylation in humans and many other organisms; take
care when applying this method to other types of methylation and make sure
that it will
be able to scale to the number of methylation sites, and that similar
assumptions can be made regarding spatial correlation. Also note that
the default settings for smoothing parameters and spacing/gap parameters
are set to values that we found useful, but may need to be altered for
datasets for other organisms.

To store your data in a `BSseq` object, make sure you have the following
neccessary components:

1. genomic positions, including chromosome and location, for methylation loci.
2. a (matrix) of M (Methylation) values, describing the number of reads
   supporting methylation covering a single loci.
   Each row in this matrix is a methylation loci and each column is a sample.
3. a (matrix) of Cov (Coverage) values,
   describing the total number of reads covering a single loci.
   Each row in this matrix is a methylation loci and each column is a sample.

The following code chunk assumes that `chr` and `pos` are vectors of
chromosome names and positions, respectively, for each CpG in the dataset.
You can also provide a `GRanges` object instead of `chr` and `pos`. It
also assumes that the matrices of methylation and coverage values (described
above) are named `M` and `Cov`, respectively. Note, `M` and `Cov` can also
be data stored on-disk (not in memory) using HDF5 files with the `HDF5Array`
package or `DelayedMatrix` with the `DelayedArray` package.

The `sampleNames` and `trt` objects are
vectors with sample labels and condition labels for each sample. A condition
label could be something like
treatment or control, a tissue type, or a continous measurement.
This is the covariate for which you wish to test for differences in
methylation. Once the `BSseq` object is constructed and the sample covariate
information is added, DMRs are obtained by running the `dmrseq` function.
A continuous covariate is assumed if the data type of the `testCovariate`
arugment in `dmrseq` is
continuous, with the exception of if there are only two unique values
(then a two group comparison is carried out).

```
bs <- BSseq(chr = chr, pos = pos,
            M = M, Cov = Cov,
            sampleNames = sampleNames)
pData(bs)$Condition <- trt

regions <- dmrseq(bs=bs, testCovariate="Condition")
```

For more information on constructing and manipulating `BSseq` objects,
see the [bsseq](http://bioconductor.org/packages/bsseq) vignettes.

* If you used *Bismark* to align your bisulfite sequencing data,
  you can use the `read.bismark` function to read bismark files
  into `BSseq` objects. See below for more details.

# 2 How to get help for dmrseq

Please post **dmrseq** questions to the
**Bioconductor support site**, which serves as a searchable knowledge
base of questions and answers:

<https://support.bioconductor.org>

Posting a question and tagging with “dmrseq” will automatically send
an alert to the package authors to respond on the support site. See
the first question in the list of [Frequently Asked Questions](#FAQ)
(FAQ) for information about how to construct an informative post.

# 3 Input data

## 3.1 Why counts instead of methylation proportions?

As input, the **dmrseq** package expects count data as obtained, e.g.,
from Bisulfite-sequencing. The value in the *i*-th row and the *j*-th column of
the `M` matrix tells how many methylated reads can be assigned to CpG *i*
in sample *j*. Likewise, the value in the *i*-th row and the *j*-th column of
the `Cov` matrix tells how many total reads can be assigned to CpG *i*
in sample *j*. Although we might be tempted to combine these matrices into
one matrix that contains the methylation *proportion* (`M`/`Cov`) at each CpG
site, it is critical to notice that this would be throwing away a lot of
information. For example, some sites have much higher coverage than others,
and naturally, we have more confidence in those with many reads mapping to them.
If we only kept the proportions, a CpG with 2 out of 2 reads methylated would
be treated the same as a CpG with 30 out of 30 reads methylated.

## 3.2 How many samples do I need?

To use **dmrseq**, you need to have at least 2 samples in each condition.
Without this replicates, it is impossible to distinguish between biological
variability due to condition/covariate of interest, and inter-individual
variability within condition.

If your experiment contains additional samples, perhaps from other conditions
that are not of interest in the current test, these should be filtered out
prior to running **dmrseq**. Rather than creating a new filtered object,
the filtering step can be included in the call to the main function `dmrseq`.
For more details, see the
[Filtering CpGs and samples Section](#filtering-cpgs-and-samples).

## 3.3 Bismark input

If you used Bismark for mapping and methylation level extraction, you can
use the `read.bismark` function from the **bsseq** package to read the
data directly into
a `BSeq` object.

The following example is from the help page of the function. After running
Bismark’s methylation extractor, you should have output files with names
that end in `.bismark.cov.gz`. You can specify a vector of file names with
the `file` argument, and a corresponding vector of `sampleNames`. It is
recommended that you set `rmZeroCov` to TRUE in order to remove CpGs with
no coverage in any of the samples, and set `strandCollapse` to TRUE in order
to combine CpGs on opposite strands into one observation (since CpG methylation)
is symmetric.

```
library(dmrseq)
infile <- system.file("extdata/test_data.fastq_bismark.bismark.cov.gz",
                        package = 'bsseq')
bismarkBSseq <- read.bismark(files = infile,
                               rmZeroCov = TRUE,
                               strandCollapse = FALSE,
                               verbose = TRUE)
bismarkBSseq
```

```
## An object of type 'BSseq' with
##   2013 methylation loci
##   1 samples
## has not been smoothed
## All assays are in-memory
```

See the [bsseq](http://bioconductor.org/packages/bsseq) help pages for
more information on using this function.

## 3.4 Count matrix input

If you haven’t used Bismark, but you have count data for number of methylated
reads and total coverage for each CpG, along with their corresponding chromosome
and position information, you can construct a `BSseq` object from scratch,
like below. Notice that the `M` and `Cov` matrices have the same dimension, and
`chr` and `pos` have the same number of elements as rows in the count matrices
(which corresponds to the number of CpGs). Also note that the number of columns
in the count matrices matches the number of elements in `sampleNames` and the
condition variable ’celltype`.

```
head(M)
```

```
## <6 x 4> DelayedMatrix object of type "double":
##      imr90.r1 imr90.r2 h1.r1 h1.r2
## [1,]       18       23    47    63
## [2,]       66       63    91    78
## [3,]       23       27    54    58
## [4,]       12       17    34    46
## [5,]       46       38    46    42
## [6,]        3        3    20    22
```

```
head(Cov)
```

```
## <6 x 4> DelayedMatrix object of type "double":
##      imr90.r1 imr90.r2 h1.r1 h1.r2
## [1,]      115      137    93   112
## [2,]      140      137   108    91
## [3,]      168      175   138   152
## [4,]      153      165   116   108
## [5,]      174      166   136   123
## [6,]       43       42    79    69
```

```
head(chr)
```

```
## [1] "chr21" "chr21" "chr21" "chr21" "chr21" "chr21"
```

```
head(pos)
```

```
## [1] 9719962 9720054 9720224 9720323 9720909 9721175
```

```
dim(M)
```

```
## [1] 300684      4
```

```
dim(Cov)
```

```
## [1] 300684      4
```

```
length(chr)
```

```
## [1] 300684
```

```
length(pos)
```

```
## [1] 300684
```

```
print(sampleNames)
```

```
## [1] "imr90.r1" "imr90.r2" "h1.r1"    "h1.r2"
```

```
print(celltype)
```

```
## [1] "imr90" "imr90" "h1"    "h1"
```

```
bs <- BSseq(chr = chr, pos = pos,
            M = M, Cov = Cov,
            sampleNames = sampleNames)
show(bs)
```

```
## An object of type 'BSseq' with
##   300684 methylation loci
##   4 samples
## has not been smoothed
## All assays are in-memory
```

The example data contains CpGs from chromosome 21 for four samples
from Lister et al. ([2009](#ref-Lister2009)). To load this data directly (already in the `BSseq` format),
simply type `data(BS.chr21)`.
Two of the samples are replicates of the cell type ‘imr90’
and the other two are replicates of the cell type ‘h1’. Now that we have the
data loaded into a `BSseq` object, we can use **dmrseq**
to find regions of the genome where these two cell types have significantly
different methylation levels. But first, we need to add the sample metadata
that indicates which samples are from which cell type (the `celltype`
varialbe above). This information, which we call ‘metadata’,
will be used by the `dmrseq` function to decide
which samples to compare to one another. The next section shows how to add
this information to the `BSseq` object.

## 3.5 Sample metadata

To add sample metadata, including the covariate of interest, you can add it
to the
`BSseq` object by adding columns to the `pData` slot. You must have at least
one column of `pData`, which contains the covariate of interest. Additional
columns are optional.

```
pData(bs)$CellType <- celltype
pData(bs)$Replicate <- substr(sampleNames,
                              nchar(sampleNames), nchar(sampleNames))

pData(bs)
```

```
## DataFrame with 4 rows and 2 columns
##             CellType   Replicate
##          <character> <character>
## imr90.r1       imr90           1
## imr90.r2       imr90           2
## h1.r1             h1           1
## h1.r2             h1           2
```

We will then tell the `dmrseq` function which metadata variable to use
for testing for methylation differences by setting the `testCovariate`
parameter equal to its column name.

## 3.6 Smoothing

Note that unlike in **bsseq**, you do not need to carry out the smoothing step
with a separate function. In addition, you should not use **bsseq**’s `BSmooth()`
function to smooth the methylation levels, since **dmrseq** smooths in a very
different way. Briefly, **dmrseq** smooths methylation *differences*, so it
carries out the smoothing step once. This is automatically done with the main
`dmrseq` function. **bsseq** on the other hand, smooths each sample
independently, so smoothing needs to be carried out once per sample.

## 3.7 Filtering CpGs and samples

For pairwise comparisons, **dmrseq** analyzes all CpGs that have at least one
read in at least one sample per group.
Thus, if your dataset contains CpGs with zero reads in every sample within a
group, you should filter them out prior to running `dmrseq`. Likewise,
if your `bsseq` object contains extraneous samples that are part of the
experiment but not the differential methylation testing of interest, these
should be filtered out as well.

Filtering `bsseq` objects is straightforward:

* Subset rows to filter CpG loci
* Subset columns to filter samples

If we wish to remove all CpGs that have no coverage in at least one sample
and only keep samples with a CellType of “imr90” or “h1”, we would do so with:

```
# which loci and sample indices to keep
loci.idx <- which(DelayedMatrixStats::rowSums2(getCoverage(bs, type="Cov")==0) == 0)
sample.idx <- which(pData(bs)$CellType %in% c("imr90", "h1"))

bs.filtered <- bs[loci.idx, sample.idx]
```

Note that this is a trivial example, since our toy example object `BS.chr21`
already contains only loci with coverage at least one read in all samples as well
as only samples from the “imr90” and “h1” conditions.

Also note that instead of creating a separate object, the filtering step
can be combined with the call to `dmrseq` by replacing the `bs` input with a
filtered version `bs[loci.idx, sample.idx]`.

## 3.8 Adjusting for covariates

There are two ways to adjust for covariates in the dmrseq model. The first way
is to specify the `adjustCovariate` parameter of the `dmrseq()` function as
a column of the `pData()` slot that contains the covariate you
would like to adjust for. This will include that covariate directly in the
model. This is ideal if the adjustment covariate is continuous or has more
than two groups.

The second way is to specify the `matchCovariate` parameter of the `dmrseq`
function as a column of the `pData()` slot that contains the covariate you
would like to match on. This will restrict the permutations considered to only
those where the `matchCovariate` is balanced. For example, the `matchCovariate`
could represent the sex of each sample. In that case, a permutation that
includes all males in one group and all females in another would not be
considered (since there is a plausible biological difference that may induce
the null distribution to resemble non-null). This matching adjustment is ideal
for two-group comparisons.

# 4 Differentially Methylated Regions

The standard differential expression analysis steps are wrapped
into a single function, `dmrseq`. The estimation steps performed
by this function are described briefly below, as well as in
more detail in the **dmrseq** paper. Here we run the results for a subset
of 20,000 CpGs in the interest of computation time.

```
testCovariate <- "CellType"
regions <- dmrseq(bs=bs[240001:260000,],
                  cutoff = 0.05,
                  testCovariate=testCovariate)
```

```
## Assuming the test covariate CellType is a factor.
```

```
## Condition: imr90 vs h1
```

```
## Parallelizing using 4 workers/cores (backend: BiocParallel:MulticoreParam).
```

```
## Computing on 1 chromosome(s) at a time.
```

```
## Detecting candidate regions with coefficient larger than 0.05 in magnitude.
```

```
## ...Chromosome chr21: Smoothed (0.1 min). 380 regions scored (0.15 min).
## * 380 candidates detected
## Performing balanced permutations of condition across samples to generate a null distribution of region test statistics
##
## Beginning permutation 1
## ...Chromosome chr21: Smoothed (0.07 min). 173 regions scored (0.07 min).
## * 1 out of 2 permutations completed (173 null candidates)
##
## Beginning permutation 2
## ...Chromosome chr21: Smoothed (0.07 min). 151 regions scored (0.06 min).
## * 2 out of 2 permutations completed (151 null candidates)
```

Progress messages are printed to the console if `verbose` is TRUE.
The text, `condition h1 vs imr90`, tells you that positive methylation
differences mean h1 has higher methylation than imr90 (see below for
more details).

## 4.1 Output of dmrseq

The results object is a `GRanges` object with the coordiates
of each candidate region, and contains the following metadata columns (which
can be extracted with the `$` operator:

1. `L` = the number of CpGs contained in the region,
2. `area` = the sum of the smoothed beta values
3. `beta` = the coefficient value for the condition difference (Note: if the
   test covariate is categorical with more than 2 groups, there will be
   more than one beta column),
4. `stat` = the test statistic for the condition difference,
5. `pval` = the permutation *p*-value for the significance of the test
   statistic, and
6. `qval` = the *q*-value for the test statistic (adjustment
   for multiple comparisons to control false discovery rate).
7. `index = an`IRanges` containing the indices of the region’s
   first CpG to last CpG.

```
show(regions)
```

```
## GRanges object with 380 ranges and 7 metadata columns:
##         seqnames            ranges strand |         L      area       beta
##            <Rle>         <IRanges>  <Rle> | <integer> <numeric>  <numeric>
##     [1]    chr21 43605625-43606688      * |        24  12.73094  -1.243455
##     [2]    chr21 44356429-44357250      * |        18   9.17973  -1.201346
##     [3]    chr21 44516290-44525100      * |       154  26.03485  -0.438070
##     [4]    chr21 44079752-44084490      * |        89  14.32149  -0.451037
##     [5]    chr21 44477228-44484542      * |       183  22.96151  -0.354231
##     ...      ...               ...    ... .       ...       ...        ...
##   [376]    chr21 43628482-43628903      * |         8  0.536424 -0.0754552
##   [377]    chr21 43951797-43952020      * |         5  0.277526  0.0713785
##   [378]    chr21 43769879-43770694      * |         9  0.905185  0.0447750
##   [379]    chr21 44403584-44403679      * |         6  0.340733 -0.0329621
##   [380]    chr21 43584709-43584897      * |         5  0.302315  0.0292136
##              stat       pval      qval       index
##         <numeric>  <numeric> <numeric>   <IRanges>
##     [1]  -18.5650 0.00307692 0.0259829     845-868
##     [2]  -12.5613 0.00307692 0.0259829 15147-15164
##     [3]  -12.2668 0.00307692 0.0259829 18812-18965
##     [4]  -11.7191 0.00307692 0.0259829   9742-9830
##     [5]  -11.0596 0.00307692 0.0259829 17954-18136
##     ...       ...        ...       ...         ...
##   [376] -0.431015   0.904615  0.914239   1356-1363
##   [377]  0.348837   0.923077  0.930422   6801-6805
##   [378]  0.287736   0.938462  0.943427   4490-4498
##   [379] -0.234484   0.944615  0.947108 16341-16346
##   [380]  0.132277   0.972308  0.972308     351-355
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

The above steps are carried out on a very small subset of data (20,000 CpGs).
This package loads data into memory one chromosome at a
time. For on human data, this means objects with a few million
entries per sample (since there are roughly 28.2 million total CpGs in the human
genome, and the largest chromosomes will have more than 2 million CpGs).
This means that whole-genome `BSseq` objects for several samples can use up
several GB of RAM. In order to improve speed, the package allows for easy
parallel processing of chromosomes, but be aware that using more cores will
also require the use of more RAM.

To use more cores, use the `register` function of
[BiocParallel](http://bioconductor.org/packages/BiocParallel). For example,
the following chunk (not evaluated here), would register 4 cores, and
then the functions above would
split computation over these cores.

```
library("BiocParallel")
register(MulticoreParam(4))
```

## 4.2 Steps of the dmrseq method

**dmrseq** is a two-stage approach that first detects candidate regions and then
explicitly evaluates statistical significance at the region level while
accounting for known sources of variability.
Candidate DMRs are defined by segmenting the genome into groups of CpGs
that show consistent evidence of differential methylation.
Because the methylation levels of neighboring CpGs are highly correlated,
we first smooth the signal to combat loss of power due to low coverage as done
in **bsseq**.

In the second stage, we compute a statistic for each candidate
DMR that takes into account variability between biological replicates
and spatial correlation among neighboring loci. Significance of each
region is assessed via a permutation procedure which uses a pooled null
distribution that can be generated from as few as two biological replicates,
and false discovery rate is controlled using the Benjamini-Hochberg
procedure.

For more details, refer to the **dmrseq** paper (Korthauer et al. [2018](#ref-Korthauer183210)).

## 4.3 Detecting large-scale methylation blocks

The default smoothing parameters (`bpSpan`, `minInSpan`, and `maxGapSmooth`)
are designed to focus on local DMRs, generally in the range of hundreds to
thousands of bases. In some applications, such as cancer, it is of interest
to effectively ‘zoom out’ in order to detect larger (lower-resolution)
methylation blocks on the order of hundreds of thousands to millions of bases.
To do so, you can
set the `block` argument to true, which will only include candidate regions with
at least `blockSize` basepairs (default = 5000). This setting will also merge
candidate regions that (1) are in the same direction and (2) are less than 1kb
apart with no covered CpGs separating them. The region-level model used is also
slightly modified - instead of a loci-specific intercept for each CpG in the
region, the intercept term is modeled as a natural spline with one interior
knot per each 10kb of length (up to 10 interior knots).

In addition, detecting large-scale blocks requires that
the smoothing window be increased to minimize the impact of noisy local
methylation measurements. To do so, the values of the
smoothing parameters should be increased. For example, to use a smoothing window
that captures at least 500 CpGs or 50,000 basepairs that are spaced apart by no
more than 1e6 bases, use `minInSpan=500`, `bpSpan=5e4`, and `maxGapSmooth=1e6`.
In addition, to avoid a block being broken up simply due to a gap with no
covered CpGs, you can increase the `maxGap` parameter.

```
testCovariate <- "CellType"
blocks <- dmrseq(bs=bs[120001:125000,],
                  cutoff = 0.05,
                  testCovariate=testCovariate,
                  block = TRUE,
                  minInSpan = 500,
                  bpSpan = 5e4,
                  maxGapSmooth = 1e6,
                  maxGap = 5e3)
```

```
## Searching for large scale blocks with at least 5000 basepairs.
```

```
## Assuming the test covariate CellType is a factor.
```

```
## Condition: imr90 vs h1
```

```
## Parallelizing using 4 workers/cores (backend: BiocParallel:MulticoreParam).
```

```
## Computing on 1 chromosome(s) at a time.
```

```
## Detecting candidate regions with coefficient larger than 0.05 in magnitude.
```

```
## ...Chromosome chr21: Smoothed (0 min). 3 regions scored (0.37 min).
## * 3 candidates detected
## Performing balanced permutations of condition across samples to generate a null distribution of region test statistics
##
## Beginning permutation 1
## ...Chromosome chr21: Smoothed (0 min). No candidates found.
## No regions found.
## * 1 out of 2 permutations completed ( null candidates)
##
## Beginning permutation 2
## ...Chromosome chr21: Smoothed (0 min). No candidates found.
## No regions found.
## * 2 out of 2 permutations completed ( null candidates)
```

```
## Warning in dmrseq(bs = bs[120001:125000, ], cutoff = 0.05, testCovariate =
## testCovariate, : No candidate regions found in permutation, so inference can't
## be carried out. Try decreasing the cutoff, or running on a larger dataset if
## you are currently using a subset.
```

```
head(blocks)
```

```
## GRanges object with 3 ranges and 7 metadata columns:
##       seqnames            ranges strand |         L      area      beta
##          <Rle>         <IRanges>  <Rle> | <integer> <numeric> <numeric>
##   [1]    chr21 32345307-32520539      * |      1458  345.9647 -0.582317
##   [2]    chr21 32700803-32766102      * |       775   54.9953 -0.187589
##   [3]    chr21 32789489-32811767      * |       260   18.6190 -0.272892
##            stat      pval      qval     index
##       <numeric> <logical> <logical> <IRanges>
##   [1] -38.37178      <NA>      <NA>    1-1458
##   [2]  -8.55934      <NA>      <NA> 3670-4444
##   [3]  -7.08400      <NA>      <NA> 4736-4995
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

The top hit is 175 thousand basepairs wide.
In general, it also might be advised to decrease the cutoff when detecting
blocks, since a smaller methylation
difference might be biologically significant if it is maintained
over a large genomic region. Note that block-finding can be more computationally
intensive since we are fitting region-level models to large numbers of CpGs at a
time. In the toy example above we are only searching over 5,000 CpGs (which
span
467
thousand basepairs), so we do not find enough null
candidate regions to carry out inference and obtain significance levels.

# 5 Exploring and exporting results

## 5.1 Explore how many regions were significant

How many regions were significant at the FDR (*q*-value) cutoff of 0.05? We
can find this by counting how many values in the `qval` column of the `regions`
object were less than 0.05.
You can also subset the regions by an FDR cutoff.

```
sum(regions$qval < 0.05)
```

```
## [1] 144
```

```
# select just the regions below FDR 0.05 and place in a new data.frame
sigRegions <- regions[regions$qval < 0.05,]
```

## 5.2 Hypo- or Hyper- methylation?

You can determine the proportion of regions with hyper-methylation by counting
how many had a positive direction of effect (positive statistic).

```
sum(sigRegions$stat > 0) / length(sigRegions)
```

```
## [1] 0.25
```

To interpret the direction of effect, note that for a two-group comparison
**dmrseq** uses alphabetical order of the covariate of interest.
The condition with a higher alphabetical rank will become the reference category.
For example, if
the two conditions are “A” and “B”, the “A” group will be the reference category,
so a positive direction of effect means that
“B” is hyper-methylated relative to “A”. Conversely, a negative direction of
effect means that “B” is hypo-methylated relative to “A”.

## 5.3 Plot DMRs

It can be useful to visualize individual DMRs, so we provide a plotting
function that is based off of **bsseq**’s plotting functions. There is also
functionality to add annotations using the
[annotatr](http://bioconductor.org/packages/annotatr) package to
see the nearby CpG categories (island, shore, shelf, open sea) and nearby
coding sequences.

To retrieve annotations for genomes supported by **annotatr**, use the
helper function `getAnnot`, and pass this annotation object to the `plotDMRs`
function as the `annoTrack` parameter.

```
# get annotations for hg18
annoTrack <- getAnnot("hg18")

plotDMRs(bs, regions=regions[1,], testCovariate="CellType",
    annoTrack=annoTrack)
```

![](data:image/png;base64...)

Here we also plot the top methylation block from the block analysis:

```
plotDMRs(bs, regions=blocks[1,], testCovariate="CellType",
    annoTrack=annoTrack)
```

![](data:image/png;base64...)

## 5.4 Plot distribution of methylation values and coverage

It can also be helpful to visualize overall distributions of methylation values
and / or coverage. The function `plotEmpiricalDistribution` will plot the
methylation values of
the covariate of interest (specified with `testCovariate`).

```
plotEmpiricalDistribution(bs, testCovariate="CellType")
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the dmrseq package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

By changing the `type` argument to `Cov`, it will also plot the distribution of
coverage values. In addition, samples can be plotted separately by setting
`bySample` to true.

```
plotEmpiricalDistribution(bs, testCovariate="CellType",
                          type="Cov", bySample=TRUE)
```

![](data:image/png;base64...)

## 5.5 Exporting results to CSV files

A plain-text file of the results can be exported using the
base R functions *write.csv* or *write.delim*.
We suggest using a descriptive file name indicating the variable
and levels which were tested.

```
write.csv(as.data.frame(regions),
          file="h1_imr90_results.csv")
```

## 5.6 Extract raw mean methylation differences

For a two-group comparison, it might be of interest to extract the raw mean
methylation differences over the DMRs. This can be done with the helper function
`meanDiff`. For example, we can extract the raw mean difference values for
the regions at FDR level 0.05 (using the `sigRegions` object created
in the section
[Explore how many regions were significant](#explore-how-many-regions-were-significant)).

```
rawDiff <- meanDiff(bs, dmrs=sigRegions, testCovariate="CellType")
str(rawDiff)
```

```
##  num [1:144] -0.4778 0.0175 -0.0067 -0.0179 -0.3864 ...
```

# 6 Simulating DMRs

If you have multiple samples from the same condition (e.g. control samples),
the function `simDMRS` will split these into two artificial sample groups
and then add *in silico* DMRs. This can then be used to assess sensitivity
and specificity of DMR approaches, since we hope to be able to recover the
DMRs that were spiked in, but not identify too many other differences (since
we don’t expect any biological difference between the two artificial sample
groups).

The use of this function is demonstrated below, although note that in this
toy example, we do not have enough samples from the same biological condition to
split into two groups, so instead we shuffle the cell types to create a null
sample comparison.

```
data(BS.chr21)

# reorder samples to create a null comparison
BS.null <- BS.chr21[1:20000,c(1,3,2,4)]

# add 100 DMRs
BS.chr21.sim <- simDMRs(bs=BS.null, num.dmrs=100)

# bsseq object with original null + simulated DMRs
show(BS.chr21.sim$bs)
```

```
## An object of type 'BSseq' with
##   20000 methylation loci
##   4 samples
## has not been smoothed
## All assays are in-memory
```

```
# coordinates of spiked-in DMRs
show(BS.chr21.sim$gr.dmrs)
```

```
## GRanges object with 100 ranges and 0 metadata columns:
##         seqnames            ranges strand
##            <Rle>         <IRanges>  <Rle>
##     [1]    chr21 14075123-14075914      *
##     [2]    chr21 15651548-15653639      *
##     [3]    chr21 15145030-15146678      *
##     [4]    chr21 13943173-13943964      *
##     [5]    chr21 13572948-13575604      *
##     ...      ...               ...    ...
##    [96]    chr21 14957083-14957560      *
##    [97]    chr21 15789959-15791380      *
##    [98]    chr21 13532780-13533346      *
##    [99]    chr21 13706416-13709182      *
##   [100]    chr21 10039099-10040540      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
# effect sizes
head(BS.chr21.sim$delta)
```

```
## [1] 0.4228185 0.3398747 0.3715057 0.4152266 0.1770527 0.1451405
```

The resulting object is a list with the following elements:

* `gr.dmrs`: a `GRanges` object containing the coordinates of the true spiked
  in DMRs
* `dmr.mncov`: a numeric vector containing the mean coverage of the
  simulated DMRs
* `dmr.L`: a numeric vector containing the sizes (number of CpG loci) of the
  simulated DMRs
* `bs`: the `BSSeq` object containing the original null data + simulated DMRs
* `delta`: a numeric vector of effect sizes (proportion differences) of the
  simulated DMRs.

# 7 Session info

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
##  [1] rtracklayer_1.70.0
##  [2] org.Hs.eg.db_3.22.0
##  [3] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [4] GenomicFeatures_1.62.0
##  [5] AnnotationDbi_1.72.0
##  [6] dmrseq_1.30.0
##  [7] bsseq_1.46.0
##  [8] SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0
## [10] MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0
## [12] GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0
## [14] IRanges_2.44.0
## [15] S4Vectors_0.48.0
## [16] BiocGenerics_0.56.0
## [17] generics_0.1.4
## [18] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] magrittr_2.0.4            magick_2.9.0
##   [5] farver_2.1.2              rmarkdown_2.30
##   [7] BiocIO_1.20.0             vctrs_0.6.5
##   [9] memoise_2.0.1             Rsamtools_2.26.0
##  [11] DelayedMatrixStats_1.32.0 RCurl_1.98-1.17
##  [13] tinytex_0.57              htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0           AnnotationHub_4.0.0
##  [17] curl_7.0.0                Rhdf5lib_1.32.0
##  [19] SparseArray_1.10.0        rhdf5_2.54.0
##  [21] sass_0.4.10               bslib_0.9.0
##  [23] plyr_1.8.9                httr2_1.2.1
##  [25] cachem_1.1.0              GenomicAlignments_1.46.0
##  [27] lifecycle_1.0.4           iterators_1.0.14
##  [29] pkgconfig_2.0.3           Matrix_1.7-4
##  [31] R6_2.6.1                  fastmap_1.2.0
##  [33] digest_0.6.37             regioneR_1.42.0
##  [35] RSQLite_2.4.3             beachmat_2.26.0
##  [37] labeling_0.4.3            filelock_1.0.3
##  [39] httr_1.4.7                abind_1.4-8
##  [41] compiler_4.5.1            rngtools_1.5.2
##  [43] bit64_4.6.0-1             withr_3.0.2
##  [45] S7_0.2.0                  BiocParallel_1.44.0
##  [47] DBI_1.2.3                 HDF5Array_1.38.0
##  [49] R.utils_2.13.0            rappdirs_0.3.3
##  [51] DelayedArray_0.36.0       rjson_0.2.23
##  [53] gtools_3.9.5              permute_0.9-8
##  [55] tools_4.5.1               R.oo_1.27.1
##  [57] glue_1.8.0                h5mread_1.2.0
##  [59] restfulr_0.0.16           nlme_3.1-168
##  [61] rhdf5filters_1.22.0       grid_4.5.1
##  [63] reshape2_1.4.4            gtable_0.3.6
##  [65] BSgenome_1.78.0           tzdb_0.5.0
##  [67] R.methodsS3_1.8.2         data.table_1.17.8
##  [69] hms_1.1.4                 XVector_0.50.0
##  [71] BiocVersion_3.22.0        foreach_1.5.2
##  [73] pillar_1.11.1             stringr_1.5.2
##  [75] limma_3.66.0              splines_4.5.1
##  [77] dplyr_1.1.4               BiocFileCache_3.0.0
##  [79] lattice_0.22-7            bit_4.6.0
##  [81] tidyselect_1.2.1          locfit_1.5-9.12
##  [83] Biostrings_2.78.0         knitr_1.50
##  [85] bookdown_0.45             xfun_0.53
##  [87] statmod_1.5.1             annotatr_1.36.0
##  [89] stringi_1.8.7             UCSC.utils_1.6.0
##  [91] yaml_2.3.10               evaluate_1.0.5
##  [93] codetools_0.2-20          cigarillo_1.0.0
##  [95] tibble_3.3.0              BiocManager_1.30.26
##  [97] cli_3.6.5                 bumphunter_1.52.0
##  [99] jquerylib_0.1.4           dichromat_2.0-0.1
## [101] Rcpp_1.1.0                GenomeInfoDb_1.46.0
## [103] dbplyr_2.5.1              outliers_0.15
## [105] png_0.1-8                 XML_3.99-0.19
## [107] parallel_4.5.1            ggplot2_4.0.0
## [109] readr_2.1.5               blob_1.2.4
## [111] doRNG_1.8.6.2             sparseMatrixStats_1.22.0
## [113] bitops_1.0-9              scales_1.4.0
## [115] purrr_1.1.0               crayon_1.5.3
## [117] rlang_1.1.6               KEGGREST_1.50.0
```

# References

Hansen, Kasper D, Benjamin Langmead, and Rafael A Irizarry. 2012. “BSmooth: from whole genome bisulfite sequencing reads to differentially methylated regions.” *Genome Biology* 13 (10): R83. <https://doi.org/10.1186/gb-2012-13-10-r83>.

Korthauer, Keegan, Sutirtha Chakraborty, Yuval Benjamini, and Rafael A. Irizarry. 2018. “Detection and Accurate False Discovery Rate Control of Differentially Methylated Regions from Whole Genome Bisulfite Sequencing.” *Biostatistics*. <https://doi.org/10.1101/183210>.

Lister, Ryan, Mattia Pelizzola, Robert H Dowen, R David Hawkins, Gary C Hon, Julian Tonti-Filippini, Joseph R Nery, et al. 2009. “Human DNA methylomes at base resolution show widespread epigenomic differences.” *Nature* 462 (7271): 315–22. <https://doi.org/10.1038/nature08514>.