Code

* Show All Code
* Hide All Code

# megadepth quick start guide

David Zhang1\* and Leonardo Collado-Torres2,3\*\*

1UCL
2Lieber Institute for Brain Development, Johns Hopkins Medical Campus
3Center for Computational Biology, Johns Hopkins University

\*david.zhang.12@ucl.ac.uk
\*\*lcolladotor@gmail.com

#### 30 October 2025

#### Package

megadepth 1.20.0

The goal of *[megadepth](https://bioconductor.org/packages/3.22/megadepth)* is to provide an R interface to the command line tool [Megadepth](https://github.com/ChristopherWilks/megadepth) for BigWig and BAM related utilities created by [Christopher Wilks](https://twitter.com/chrisnwilks) (Wilks, Ahmed, Baker, Zhang, Collado-Torres, and Langmead, 2020). This R package enables **fast** processing of BigWig files on downstream packages such as [dasper](https://bioconductor.org/packages/dasper) and [recount3](https://bioconductor.org/packages/recount3). The [Megadepth](https://github.com/ChristopherWilks/megadepth) software also provides utilities for processing BAM files and extracting coverage information from them.

Here is an illustration on how fast *[megadepth](https://bioconductor.org/packages/3.22/megadepth)* is compared to other tools for processing local and remote BigWig files.

![Timing results. Timing comparison for processing 1,000 genomic regions on a bigWig file that is available on the local disk or on a remote resource. We compared megadepth against rtracklayer and pyBigWig. megadepth is typically faster that these other software solutions for computing the mean coverage across a set of 1,000 input genomic regions. Check <https://github.com/LieberInstitute/megadepth/tree/devel/analysis> for more details.](data:image/png;base64...)

Figure 1: Timing results
Timing comparison for processing 1,000 genomic regions on a bigWig file that is available on the local disk or on a remote resource. We compared megadepth against rtracklayer and pyBigWig. megadepth is typically faster that these other software solutions for computing the mean coverage across a set of 1,000 input genomic regions. Check <https://github.com/LieberInstitute/megadepth/tree/devel/analysis> for more details.

Throughout the documentation we use a capital `M` to refer to the software by Christopher Wilks and a lower case `m` to refer to this R/Bioconductor package.

# 1 Basics

## 1.1 Install `megadepth`

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[megadepth](https://bioconductor.org/packages/3.22/megadepth)* is a `R` package available via the [Bioconductor](http://bioconductor.org) repository for packages. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[megadepth](https://bioconductor.org/packages/3.22/megadepth)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("megadepth")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Required knowledge

*[megadepth](https://bioconductor.org/packages/3.22/megadepth)* is based on many other packages and in particular in those that have implemented the infrastructure needed for dealing with RNA-seq data and high-throughput sequencing data in general. You might benefit from being familiar with the BigWig file format and the *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* for importing those files into R as well as exporting BED files (Lawrence, Gentleman, and Carey, 2009). If you are working with annoation files, *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)* and *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* will also be useful to you.

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `megadepth` tag and check [the older posts](https://support.bioconductor.org/t/megadepth/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing `megadepth`

We hope that *[megadepth](https://bioconductor.org/packages/3.22/megadepth)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("megadepth")
#> To cite package 'megadepth' in publications use:
#>
#>   Zhang D, Collado-Torres L (2025). _megadepth: BigWig and BAM related
#>   utilities_. doi:10.18129/B9.bioc.megadepth
#>   <https://doi.org/10.18129/B9.bioc.megadepth>,
#>   https://github.com/LieberInstitute/megadepth - R package version
#>   1.20.0, <http://www.bioconductor.org/packages/megadepth>.
#>
#>   Wilks C, Ahmed O, Baker DN, Zhang D, Collado-Torres L, Langmead B
#>   (2020). "Megadepth: efficient coverage quantification for BigWigs and
#>   BAMs." _bioRxiv_. doi:10.1101/2020.12.17.423317
#>   <https://doi.org/10.1101/2020.12.17.423317>,
#>   <https://www.biorxiv.org/content/10.1101/2020.12.17.423317v1>.
#>
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

# 2 Quick start

To get started, we need to load the *[megadepth](https://bioconductor.org/packages/3.22/megadepth)* package into our R session. This will load all the required dependencies.

```
library("megadepth")
```

Once we have the R package loaded, we need to install the [Megadepth](https://github.com/ChristopherWilks/megadepth) software. We can do so with `install_megadepth()`, which downloads a binary for your OS (Linux, Windows or macOS) 111 Please check [Megadepth](https://github.com/ChristopherWilks/megadepth) for instructions on how to compile the software from source if the binary version doesn’t work for you.. We can then use with an example BigWig file to compute the coverage at a set of regions.

```
## Install the latest version of Megadepth
install_megadepth(force = TRUE)
#> The latest megadepth version is 1.2.0
#> This is not an interactive session, therefore megadepth has been installed temporarily to
#> /tmp/RtmpDzvpdN/megadepth
```

Next, we might want to use *[megadepth](https://bioconductor.org/packages/3.22/megadepth)* to quantify the coverage at a set of regions of the genome of interest to us. Here we will use two example files that are include in the package for illustration and testing purposes. One of them is a [bigWig file](https://genome.ucsc.edu/goldenPath/help/bigWig.html) that contains the base-pair coverage information for a sample of interest and the second one is [BED file](https://genome.ucsc.edu/FAQ/FAQformat.html#format1) which contains the genomic region coordinates of interest. So we first locate them.

```
## Next, we locate the example BigWig and annotation files
example_bw <- system.file("tests", "test.bam.all.bw",
    package = "megadepth", mustWork = TRUE
)
annotation_file <- system.file("tests", "testbw2.bed",
    package = "megadepth", mustWork = TRUE
)

## Where are they?
example_bw
#> [1] "/tmp/RtmpGw7sEv/Rinst16960260a96bde/megadepth/tests/test.bam.all.bw"
annotation_file
#> [1] "/tmp/RtmpGw7sEv/Rinst16960260a96bde/megadepth/tests/testbw2.bed"
```

Once we have located the example files we can proceed to calculating the base-pair coverage for our genomic regions of interest. There are several ways to do this with *[megadepth](https://bioconductor.org/packages/3.22/megadepth)*, but here we use the user-friendly function `get_coverage()`. This function will perform a given operation **op** on the bigWig file for a given set of regions of interest (*annotation*). One of those operations is to compute the mean base-pair coverage for each input region. This is what we’ll do with our example bigWig file.

```
## We can then use megadepth to compute the coverage
bw_cov <- get_coverage(
    example_bw,
    op = "mean",
    annotation = annotation_file
)
bw_cov
#> GRanges object with 4 ranges and 1 metadata column:
#>         seqnames          ranges strand |     score
#>            <Rle>       <IRanges>  <Rle> | <numeric>
#>   [1]      chr10            0-10      * |      0.00
#>   [2]      chr10 8756697-8756762      * |     15.85
#>   [3]      chr10 4359156-4359188      * |      3.00
#>   [4] GL000219.1   168500-168620      * |      1.26
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

`get_coverage()` returns an object that is familiar to *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* users, that is, a `GRanges` object that can be used with other Bioconductor software packages (Huber, Carey, Gentleman, Anders, Carlson, Carvalho, Bravo, Davis, Gatto, Girke, Gottardo, Hahne, Hansen, Irizarry, Lawrence, Love, MacDonald, Obenchain, Oleś, Pagès, Reyes, Shannon, Smyth, Tenenbaum, Waldron, and Morgan, 2015).

This example is just the tip of the iceberg, as [Megadepth](https://github.com/ChristopherWilks/megadepth) and thus *[megadepth](https://bioconductor.org/packages/3.22/megadepth)* can do a lot of useful processing operations on BAM and bigWig files.

# 3 Users guide

## 3.1 Command interface

[Megadepth](https://github.com/ChristopherWilks/megadepth) is very powerful and can do a lot of different things. The R/Bioconductor package provides two functions for interfacing with [Megadepth](https://github.com/ChristopherWilks/megadepth), `megadepth_cmd()` and `megadepth_shell()`. For the first one, `megadepth_cmd()`, you need to know the actual command syntax you want to use and format it accordingly. If you are more comfortable with R functions, `megadepth_shell()` uses *[cmdfun](https://CRAN.R-project.org/package%3Dcmdfun)* to power this interface and capture the standard output stream into R.

To make it easier to use, `megadepth` includes functions that simplify the number of arguments, read in the output files, and converts them into R/Bioconductor friendly objects, such as `get_coverage()` illustrated previously in the quick start section.

We hope that you’ll find `megadepth` and [Megadepth](https://github.com/ChristopherWilks/megadepth) useful for your work. If you are interested in checking how **fast** `megadepth` is, check out the [**speed analysis**](https://github.com/LieberInstitute/megadepth/tree/devel/analysis) comparison against other tools. Note that the size of the files used and the number of genomic regions queried will affect the speed comparisons.

```
## R-like interface
## that captures the standard output into R
head(megadepth_shell(help = TRUE))
#> [1] "megadepth 1.2.0"                  ""
#> [3] "BAM and BigWig utility."          ""
#> [5] "Usage:"                           "  megadepth <bam|bw|-> [options]"

## Command-like interface
megadepth_cmd("--help")
```

```
#> megadepth 1.2.0
#>
#>  BAM and BigWig utility.
#>
#>  Usage:
#>    megadepth <bam|bw|-> [options]
#>
#>  Options:
#>    -h --help                Show this screen.
#>    --version                Show version.
#>    --threads                # of threads to do: BAM decompression OR compute sums over multiple BigWigs in parallel
#>                              if the 2nd is intended then a TXT file listing the paths to the BigWigs to process in parallel
#>                              should be passed in as the main input file instead of a single BigWig file (EXPERIMENTAL).
#>    --prefix                 String to use to prefix all output files.
#>    --no-auc-stdout          Force all AUC(s) to be written to <prefix>.auc.tsv rather than STDOUT
#>    --no-annotation-stdout   Force summarized annotation regions to be written to <prefix>.annotation.tsv rather than STDOUT
#>    --no-coverage-stdout     Force covered regions to be written to <prefix>.coverage.tsv rather than STDOUT
#>    --keep-order             Output annotation coverage in the order chromosomes appear in the BAM/BigWig file
#>                             The default is to output annotation coverage in the order chromosomes appear in the annotation BED file.
#>                             This is only applicable if --annotation is used for either BAM or BigWig input.
#>
#>  BigWig Input:
#>  Extract regions and their counts from a BigWig outputting BED format if a BigWig file is detected as input (exclusive of the other BAM modes):
#>                                            Extracts all reads from the passed in BigWig and output as BED format.
#>                                             This will also report the AUC over the annotated regions to STDOUT.
#>                                             If only the name of the BigWig file is passed in with no other args, it will *only* report total AUC to STDOUT.
#>    --annotation <bed>                      Only output the regions in this BED applying the argument to --op to them.
#>    --op <sum[default], mean, min, max>     Statistic to run on the intervals provided by --annotation
#>    --sums-only                             Discard coordinates from output of summarized regions
#>    --distance (2200[default])              Number of base pairs between end of last annotation and start of new to consider in the same BigWig query window (a form of binning) for performance.  This determines the number of times the BigWig index is queried.
#>    --unsorted (off[default])               There's a performance improvement *if* BED file passed to --annotation is 1) sorted by sort -k1,1 -k2,2n (default is to assume sorted and check for unsorted positions, if unsorted positions are found, will fall back to slower version)
#>    --bwbuffer <1GB[default]>               Size of buffer for reading BigWig files, critical to use a large value (~1GB) for remote BigWigs.
#>                                            Default setting should be fine for most uses, but raise if very slow on a remote BigWig.
#>
#>
#>  BAM Input:
#>  Extract basic junction information from the BAM, including co-occurrence
#>  If only the name of the BAM file is passed in with no other args, it will *only* report total AUC to STDOUT.
#>    --fasta              Path to the reference FASTA file if a CRAM file is passed as the input file (ignored otherwise)
#>                         If not passed, references will be downloaded using the CRAM header.
#>    --junctions          Extract co-occurring jx coordinates, strand, and anchor length, per read
#>                         writes to a TSV file <prefix>.jxs.tsv
#>    --all-junctions      Extract all jx coordinates, strand, and anchor length, per read for any jx
#>                         writes to a TSV file <prefix>.all_jxs.tsv
#>    --longreads          Modifies certain buffer sizes to accommodate longer reads such as PB/Oxford.
#>    --filter-in          Integer bitmask, any bits of which alignments need to have to be kept (similar to samtools view -f).
#>    --filter-out         Integer bitmask, any bits of which alignments need to have to be skipped (similar to samtools view -F).
#>    --add-chr-prefix     Adds "chr" prefix to relevant chromosomes for BAMs w/o it, pass "human" or "mouse".
#>                         Only works for human/mouse references (default: off).
#>
#>  Non-reference summaries:
#>    --alts                       Print differing from ref per-base coverages
#>                                 Writes to a CSV file <prefix>.alts.tsv
#>    --include-softclip           Print a record to the alts CSV for soft-clipped bases
#>                                 Writes total counts to a separate TSV file <prefix>.softclip.tsv
#>    --only-polya                 If --include-softclip, only print softclips which are mostly A's or T's
#>    --include-n                  Print mismatch records when mismatched read base is N
#>    --print-qual                 Print quality values for mismatched bases
#>    --delta                      Print POS field as +/- delta from previous
#>    --require-mdz                Quit with error unless MD:Z field exists everywhere it's
#>                                 expected
#>    --head                       Print sequence names and lengths in SAM/BAM header
#>
#>  Coverage and quantification:
#>    --coverage           Print per-base coverage (slow but totally worth it)
#>    --auc                Print per-base area-under-coverage, will generate it for the genome
#>                         and for the annotation if --annotation is also passed in
#>                         Defaults to STDOUT, unless other params are passed in as well, then
#>                         if writes to a TSV file <prefix>.auc.tsv
#>    --bigwig             Output coverage as BigWig file(s).  Writes to <prefix>.bw
#>                         (also <prefix>.unique.bw when --min-unique-qual is specified).
#>                         Requires libBigWig.
#>    --annotation <BED|window_size>   Path to BED file containing list of regions to sum coverage over
#>                         (tab-delimited: chrm,start,end). Or this can specify a contiguous region size in bp.
#>    --op <sum[default], mean>     Statistic to run on the intervals provided by --annotation
#>    --no-index           If using --annotation, skip the use of the BAM index (BAI) for pulling out regions.
#>                         Setting this can be faster if doing windows across the whole genome.
#>                         This will be turned on automatically if a window size is passed to --annotation.
#>    --min-unique-qual <int>
#>                         Output second bigWig consisting built only from alignments
#>                         with at least this mapping quality.  --bigwig must be specified.
#>                         Also produces second set of annotation sums based on this coverage
#>                         if --annotation is enabled
#>    --double-count       Allow overlapping ends of PE read to count twice toward
#>                         coverage
#>    --num-bases          Report total sum of bases in alignments processed (that pass filters)
#>    --gzip               Turns on gzipping of coverage output (no effect if --bigwig is passsed),
#>                         this will also enable --no-coverage-stdout.
#>
#>  Other outputs:
#>    --read-ends          Print counts of read starts/ends, if --min-unique-qual is set
#>                         then only the alignments that pass that filter will be counted here
#>                         Writes to 2 TSV files: <prefix>.starts.tsv, <prefix>.ends.tsv
#>    --frag-dist          Print fragment length distribution across the genome
#>                         Writes to a TSV file <prefix>.frags.tsv
#>    --echo-sam           Print a SAM record for each aligned read
#>    --ends               Report end coordinate for each read (useful for debugging)
#>    --test-polya         Lower Poly-A filter minimums for testing (only useful for debugging/testing)
#>
#>
```

## 3.2 BAM to bigWig

One use case of [Megadepth](https://github.com/ChristopherWilks/megadepth) is to convert BAM files to bigWig coverage files. To simplify this process and verify that you are not accidentally overwriting valuable files, *[megadepth](https://bioconductor.org/packages/3.22/megadepth)* provides the function `bam_to_bigwig()`. To illustrate this functionality, we first locate an example BAM file. We then generate the output bigWig files

```
## Find the example BAM file
example_bam <- system.file("tests", "test.bam",
    package = "megadepth", mustWork = TRUE
)

## Create the BigWig file
## Currently Megadepth does not support this on Windows
example_bw <- bam_to_bigwig(example_bam, overwrite = TRUE)

## Path to the output files generated by bam_to_bigwig()
example_bw
#>                            all.bw
#> "/tmp/RtmpDzvpdN/test.bam.all.bw"
```

Currently this functionality does not work on Windows. In which case, you can continue the vignette with the following example bigWig file.

```
## On Windows, use the example bigWig file that is already included in
## the R package
example_bw <- system.file("tests", "test.bam.all.bw",
    package = "megadepth", mustWork = TRUE
)
```

## 3.3 Summarize coverage over regions

Once you have a biWig file, you might want to quantify the mean or total expression across a set of genomic coordinates. bigWig files are typically used by genome browsers, and as part of the *[recount](https://bioconductor.org/packages/3.22/recount)* and *[recount3](https://bioconductor.org/packages/3.22/recount3)* projects we have released thousands of them. Before we expand more complex uses cases, you might be interested in `get_coverage()`. This function will use [Megadepth](https://github.com/ChristopherWilks/megadepth) to create a tab-separated value (TSV) file containing the coverage summary information 222 Sum, mean, min or max base-pair coverage for each region. for a given input file that can be read into R using `read_coverage()` 333 If you prefer a `tibble`, use `read_coverage_table()`. as shown below with an example set of genomic regions of interest (*annotation*).

```
## Next, we locate the example annotation BED file
annotation_file <- system.file("tests", "testbw2.bed",
    package = "megadepth", mustWork = TRUE
)

## Now we can compute the coverage
bw_cov <- get_coverage(example_bw, op = "mean", annotation = annotation_file)
bw_cov
#> GRanges object with 4 ranges and 1 metadata column:
#>         seqnames          ranges strand |     score
#>            <Rle>       <IRanges>  <Rle> | <numeric>
#>   [1]      chr10            0-10      * |      0.00
#>   [2]      chr10 8756697-8756762      * |     15.85
#>   [3]      chr10 4359156-4359188      * |      3.00
#>   [4] GL000219.1   168500-168620      * |      1.26
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

If you are familiar with *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)*, you’ll notice that the coverage summaries are basically the same to the one that can be generated with `rtracklayer::import.bw()`, which is what *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* uses internally.

```
## Checking with derfinder and rtracklayer
bed <- rtracklayer::import(annotation_file)

## The file needs a name
names(example_bw) <- "example"

## Read in the base-pair coverage data
regionCov <- derfinder::getRegionCoverage(
    regions = bed,
    files = example_bw,
    verbose = FALSE
)

## Summarize the base-pair coverage data.
## Note that we have to round the mean to make them comparable.
testthat::expect_equivalent(
    round(sapply(regionCov[c(1, 3:4, 2)], function(x) mean(x$value)), 2),
    bw_cov$score,
)
#> Warning: `expect_equivalent()` was deprecated in the 3rd edition.
#> ℹ Use expect_equal(ignore_attr = TRUE)

## If we compute the sum, there's no need to round
testthat::expect_equivalent(
    sapply(regionCov[c(1, 3:4, 2)], function(x) sum(x$value)),
    get_coverage(example_bw, op = "sum", annotation = annotation_file)$score,
)
#> Warning: `expect_equivalent()` was deprecated in the 3rd edition.
#> ℹ Use expect_equal(ignore_attr = TRUE)
```

## 3.4 BAM to junctions

[Megadepth](https://github.com/ChristopherWilks/megadepth) provides utilities that might be of use for future work or that were developed for building *[recount3](https://bioconductor.org/packages/3.22/recount3)*. One of these features is the possibility to extract locally co-ocurring junctions from a BAM file as described in the [Megadepth documentation](https://github.com/ChristopherWilks/megadepth#megadepth-pathtobamfile---junctions). This feature works only for junctions for which a read or (read pair) has 2 or more junctions.

To illustrate this functionality, we will use an example BAM file and generate the locally co-occurring junction table with `bam_to_junctions()`. We’ll then read in the data using `read_junction_table()` 444 The `strand` columns have been switched from 0s and 1s to `+` and `-` for the forward and reverse strands, to match frequently used Bioconductor packages.. `process_junction_table()` can then be used to convert the junctions into a STAR-compatible format.

```
## Find the example BAM file
example_bam <- system.file("tests", "test.bam",
    package = "megadepth", mustWork = TRUE
)

## Run bam_to_junctions()
example_jxs <- bam_to_junctions(example_bam, overwrite = TRUE)

## Path to the output file generated by bam_to_junctions()
example_jxs
#>                            all_jxs.tsv
#> "/tmp/RtmpDzvpdN/test.bam.all_jxs.tsv"

## Read the data as a tibble using the format specified at
## https://github.com/ChristopherWilks/megadepth#megadepth-pathtobamfile---junctions
example_jxs <- read_junction_table(example_jxs)

example_jxs
#> # A tibble: 35 × 7
#>    read_name chr     start     end mapping_strand cigar         unique
#>    <chr>     <chr>   <dbl>   <dbl> <chr>          <chr>          <int>
#>  1 26573693  chr10 4358579 4581019 -              61M222441N11M      0
#>  2 59413733  chr10 8458623 8778558 +              13M319936N59M      0
#>  3 63502504  chr10 8722315 8848720 -              50M126406N22M      1
#>  4 15130473  chr10 8722508 8870679 -              61M148172N11M      1
#>  5 22331161  chr10 8756762 8780518 -              62M23757N10M       1
#>  6 37510913  chr10 8756762 8780518 -              62M23757N10M       1
#>  7 38798461  chr10 8756762 8780518 -              62M23757N10M       1
#>  8 62329988  chr10 8756762 8780518 -              62M23757N10M       1
#>  9 66789502  chr10 8756762 8780518 -              62M23757N10M       1
#> 10 78396176  chr10 8756762 8780518 -              62M23757N10M       1
#> # ℹ 25 more rows

process_junction_table(example_jxs)
#> # A tibble: 5 × 8
#>   chr     start     end strand intron_motif annotated uniquely_mapping_reads
#>   <chr>   <dbl>   <dbl>  <dbl>        <dbl>     <dbl>                  <int>
#> 1 chr10 4358579 4581019      0            0         0                      0
#> 2 chr10 8458623 8778558      0            0         0                      0
#> 3 chr10 8722315 8848720      0            0         0                      1
#> 4 chr10 8722508 8870679      0            0         0                      1
#> 5 chr10 8756762 8780518      0            0         0                     20
#> # ℹ 1 more variable: multimapping_reads <int>
```

## 3.5 Teams involved

*[megadepth](https://bioconductor.org/packages/3.22/megadepth)* was made possible to [David Zhang](https://twitter.com/dyzhang32), the author of *[dasper](https://bioconductor.org/packages/3.22/dasper)*, and a member of the [Mina Ryten](https://snca.atica.um.es/)’s lab at UCL.

The `ReCount` family involves the following teams:

* [Ben Langmead’s lab](http://www.langmead-lab.org/) at JHU Computer Science
* [Kasper Daniel Hansen’s lab](https://www.hansenlab.org/) at JHBSPH Biostatistics Department
* [Leonardo Collado-Torres](http://lcolladotor.github.io/) and [Andrew E. Jaffe](http://aejaffe.com/) from [LIBD](https://www.libd.org/)
* [Abhinav Nellore’s lab](http://nellore.bio/) at OHSU
* [Jeff Leek’s lab](http://jtleek.com/) at JHBSPH Biostatistics Deparment
* Data hosted by [SciServer from IDIES at JHU](https://www.sciserver.org/)

## 3.6 Other related tools

The `ReCount` team has worked on several software solutions and projects that complement each other and enable you to re-use public RNA-seq data. Another Bioconductor package that you might be highly interested in is *[snapcount](https://bioconductor.org/packages/3.22/snapcount)*, which allows you to use the [Snaptron web services](http://snaptron.cs.jhu.edu/). In particular, *[snapcount](https://bioconductor.org/packages/3.22/snapcount)* is best for queries over a particular subset of genes or intervals across all or most of the samples in `recount2`/`Snaptron`.

We remind you that the **main documentation website** for all the `recount3`-related projects is available at [**recount.bio**](https://LieberInstitute/github.io/recount3-docs). Please check that website for more information about how this R/Bioconductor package and other tools are related to each other.

**Thank you!**

P.S. An [alternative version of this vignette is available](https://LieberInstitute.github.io/megadepth/) that was made using *[pkgdown](https://CRAN.R-project.org/package%3Dpkgdown)*.

# 4 Reproducibility

The *[megadepth](https://bioconductor.org/packages/3.22/megadepth)* package (Zhang and Collado-Torres, 2025) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("megadepth.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("megadepth.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 00:54:10 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 20.474 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version   date (UTC) lib source
#>  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi          1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  archive                1.1.12    2025-03-20 [2] CRAN (R 4.5.1)
#>  backports              1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
#>  base64enc              0.1-3     2015-07-28 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase                2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics           0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocIO                 1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel           1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  bitops                 1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  brio                   1.1.5     2024-04-24 [2] CRAN (R 4.5.1)
#>  BSgenome               1.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  bumphunter             1.52.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  checkmate              2.3.3     2025-08-18 [2] CRAN (R 4.5.1)
#>  cigarillo              1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
#>  cmdfun                 1.0.2     2020-10-10 [2] CRAN (R 4.5.1)
#>  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace             2.1-2     2025-09-22 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
#>  data.table             1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  derfinder              1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  derfinderHelper        1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  desc                   1.4.3     2023-12-10 [2] CRAN (R 4.5.1)
#>  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  doRNG                  1.8.6.2   2025-04-02 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  foreach                1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
#>  foreign                0.8-90    2025-03-31 [3] CRAN (R 4.5.1)
#>  Formula                1.2-5     2023-02-24 [2] CRAN (R 4.5.1)
#>  fs                     1.6.6     2025-04-12 [2] CRAN (R 4.5.1)
#>  generics               0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomeInfoDb           1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicAlignments      1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicFeatures        1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicFiles           1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicRanges          1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2                4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  gridExtra              2.3       2017-09-09 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  Hmisc                  5.2-4     2025-10-05 [2] CRAN (R 4.5.1)
#>  hms                    1.1.4     2025-10-17 [2] CRAN (R 4.5.1)
#>  htmlTable              2.4.3     2024-07-21 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  IRanges                2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iterators              1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  locfit                 1.5-9.12  2025-03-05 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics         1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats            1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  megadepth            * 1.20.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  nnet                   7.3-20    2025-01-01 [3] CRAN (R 4.5.1)
#>  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  pkgload                1.4.1     2025-09-23 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  qvalue                 2.42.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RCurl                  1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
#>  readr                  2.1.5     2024-01-10 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
#>  reshape2               1.4.4     2020-04-09 [2] CRAN (R 4.5.1)
#>  restfulr               0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
#>  rjson                  0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  rngtools               1.5.2     2021-09-20 [2] CRAN (R 4.5.1)
#>  rpart                  4.1.24    2025-01-07 [3] CRAN (R 4.5.1)
#>  rprojroot              2.1.1     2025-08-26 [2] CRAN (R 4.5.1)
#>  Rsamtools              2.26.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  RSQLite                2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
#>  rstudioapi             0.17.1    2024-10-22 [2] CRAN (R 4.5.1)
#>  rtracklayer            1.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Arrays               1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors              0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo                1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  SparseArray            1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment   1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  testthat               3.2.3     2025-01-13 [2] CRAN (R 4.5.1)
#>  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
#>  tzdb                   0.5.0     2025-03-15 [2] CRAN (R 4.5.1)
#>  UCSC.utils             1.6.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  utf8                   1.2.6     2025-06-08 [2] CRAN (R 4.5.1)
#>  VariantAnnotation      1.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  vroom                  1.6.6     2025-09-19 [2] CRAN (R 4.5.1)
#>  waldo                  0.6.2     2025-07-11 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53      2025-08-19 [2] CRAN (R 4.5.1)
#>  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpGw7sEv/Rinst16960260a96bde
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 5 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-bioconductor2015)
W. Huber, V. J. Carey, R. Gentleman, et al.
“Orchestrating high-throughput genomic analysis with Bioconductor”.
In: *Nat Methods* (2015).
DOI: [10.1038/nmeth.3252](https://doi.org/10.1038/nmeth.3252).

[[3]](#cite-lawrence2009rtracklayer)
M. Lawrence, R. Gentleman, and V. Carey.
“rtracklayer: an R package for interfacing with
genome browsers”.
In: *Bioinformatics* 25 (2009), pp. 1841-1842.
DOI: [10.1093/bioinformatics/btp328](https://doi.org/10.1093/bioinformatics/btp328).
URL: <http://bioinformatics.oxfordjournals.org/content/25/14/1841.abstract>.

[[4]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[5]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[6]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[7]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[8]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[9]](#cite-wilks2020megadepth)
C. Wilks, O. Ahmed, D. N. Baker, et al.
“Megadepth: efficient coverage quantification for BigWigs and BAMs”.
In: *bioRxiv* (2020).
DOI: [https://doi.org/10.1101/2020.12.17.423317](https://doi.org/https%3A//doi.org/10.1101/2020.12.17.423317).
URL: <https://www.biorxiv.org/content/10.1101/2020.12.17.423317v1>.

[[10]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.

[[11]](#cite-zhang2025megadepth)
D. Zhang and L. Collado-Torres.
*megadepth: BigWig and BAM related utilities*.
<https://github.com/LieberInstitute/megadepth> - R package version 1.20.0.
2025.
DOI: [10.18129/B9.bioc.megadepth](https://doi.org/10.18129/B9.bioc.megadepth).
URL: <http://www.bioconductor.org/packages/megadepth>.