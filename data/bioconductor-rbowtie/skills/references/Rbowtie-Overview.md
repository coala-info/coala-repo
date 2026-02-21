# An introduction to Rbowtie

Michael Stadler, Dimos Gaidatzis and Anita Lerch

#### 30 October, 2025

#### Package

Rbowtie 1.50.0

# 1 Introduction

The *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)* package provides an **R** wrapper around the popular
*bowtie* (Langmead et al. [2009](#ref-bowtie)) short read aligner and around *SpliceMap* (Au et al. [2010](#ref-SpliceMap)) a *de novo*
splice junction discovery and alignment tool, which makes use of the *bowtie*
software package.

The package is used by the *[QuasR](https://bioconductor.org/packages/3.22/QuasR)* (Gaidatzis et al. [2015](#ref-QuasR)) bioconductor package to
\_qu\_antify and \_a\_nnotate \_s\_hort \_r\_eads. We recommend to use the *[QuasR](https://bioconductor.org/packages/3.22/QuasR)*
package instead of using *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)* directly. The *[QuasR](https://bioconductor.org/packages/3.22/QuasR)*
package provides a simpler interface than *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)* and covers the
whole analysis workflow of typical ultra-high throughput sequencing experiments,
starting from the raw sequence reads, over pre-processing and alignment, up to
quantification.

# 2 Preliminaries

## 2.1 Citing *Rbowtie*

If you use *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)* (Hahne, Lerch, and Stadler [2012](#ref-Rbowtie)) in your work, you can cite it as follows:

```
citation("Rbowtie")
```

```
## The Rbowtie package contains code from two separate software projects.
## If using bowtie only, it can be cited as Langmead et al. (2009). If
## using also SpliceMap, it can be cited in addition Au et al. (2010). The
## Rbowtie package can be cited using the third reference below:
##
##   Langmead B, Trapnell C, Pop M, Salzberg SL. Ultrafast and
##   memory-efficient alignment of short DNA sequences to the human
##   genome. Genome Biology 10(3):R25 (2009).
##
##   Au KF, Jiang H, Lin L, Xing Y, Wong WH. Detection of splice junctions
##   from paired-end RNA-seq data by SpliceMap. Nucleic Acids Research,
##   38(14):4570-8 (2010).
##
##   Hahne F, Lerch A, Stadler MB. Rbowtie: An R wrapper for bowtie and
##   SpliceMap short read aligners. (unpublished)
##
## This free open-source software implements academic research by the
## authors and co-workers. If you use it, please support the project by
## citing the appropriate journal articles.
##
## To see these entries in BibTeX format, use 'print(<citation>,
## bibtex=TRUE)', 'toBibtex(.)', or set
## 'options(citation.bibtex.max=999)'.
```

## 2.2 Installation

*[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)* is a package for the **R** computing environment and it is
assumed that you have already installed **R**. See the **R** project at
(<http://www.r-project.org>). To install the latest version of *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)*,
you will need to be using the latest version of **R**. *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)* is
part of the Bioconductor project at (<http://www.bioconductor.org>). To get
*[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)* together with its dependencies you can use

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("Rbowtie")
```

## 2.3 Loading of *Rbowtie*

In order to run the code examples in this vignette, the *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)*
library need to be loaded.

```
library(Rbowtie)
```

## 2.4 How to get help

Most questions about *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)* will hopefully be answered by the
documentation or references. If you’ve run into a question which isn’t addressed
by the documentation, or you’ve found a conflict between the documentation and
software itself, then there is an active support community which can offer help.

The authors of the package (maintainer: Michael Stadler michael.stadler@fmi.ch) always appreciate
receiving reports of bugs in the package functions or in the documentation. The
same goes for well-considered suggestions for improvements.

Any other questions or problems concerning *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)* should be posted
to the Bioconductor support site (<https://support.bioconductor.org>). Users posting
to the support site for the first time should read the helpful posting guide at
(<https://support.bioconductor.org/info/faq/>). Note that each function in *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)*
has it’s own help page, e.g. `help("bowtie")`. Posting etiquette requires that you
read the relevant help page carefully before posting a problem to the site.

# 3 Example usage for individual Rbowtie functions

Please refer to the *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)* reference manual or the function documentation
(e.g. using `?bowtie`) for a complete description of *[Rbowtie](https://bioconductor.org/packages/3.22/Rbowtie)* functions.
The descriptions provided below are meant to give and overview over all functions
and summarize the purpose of each one.

## 3.1 Build the reference index with `bowtie_build`

To be able to align short reads to a genome, an index has to be build first using
the function `bowtie_build`. Information about arguments can be found with the help
of the `bowtie_build_usage` function or in the manual page `?bowtie_build`.

```
bowtie_build_usage()
```

```
##  [1] "Usage: bowtie2-build-s [options]* <reference_in> <ebwt_outfile_base>"
##  [2] "    reference_in            comma-separated list of files with ref sequences"
##  [3] "    ebwt_outfile_base       write Ebwt data to files with this dir/basename"
##  [4] "Options:"
##  [5] "    -f                      reference files are Fasta (default)"
##  [6] "    -c                      reference sequences given on cmd line (as <seq_in>)"
##  [7] "    -a/--noauto             disable automatic -p/--bmax/--dcv memory-fitting"
##  [8] "    -p/--packed             use packed strings internally; slower, uses less mem"
##  [9] "    --bmax <int>            max bucket sz for blockwise suffix-array builder"
## [10] "    --bmaxdivn <int>        max bucket sz as divisor of ref len (default: 4)"
## [11] "    --dcv <int>             diff-cover period for blockwise (default: 1024)"
## [12] "    --nodc                  disable diff-cover (algorithm becomes quadratic)"
## [13] "    -r/--noref              don't build .3/.4.ebwt (packed reference) portion"
## [14] "    -3/--justref            just build .3/.4.ebwt (packed reference) portion"
## [15] "    -o/--offrate <int>      SA is sampled every 2^offRate BWT chars (default: 5)"
## [16] "    -t/--ftabchars <int>    # of chars consumed in initial lookup (default: 10)"
## [17] "    --threads <int>         # of threads"
## [18] "    --ntoa                  convert Ns in reference to As"
## [19] "    --seed <int>            seed for random number generator"
## [20] "    -q/--quiet              verbose output (for debugging)"
## [21] "    -h/--help               print detailed description of tool and its options"
## [22] "    --usage                 print this usage message"
## [23] "    --version               print version information and quit"
```

`refFiles` below is a vector with filenames of the reference sequence in `FASTA`
format, and `indexDir` specifies an output directory for the index files that will
be generated when calling `bowtie_build`:

```
refFiles <- dir(system.file(package="Rbowtie", "samples", "refs"), full=TRUE)
indexDir <- file.path(tempdir(), "refsIndex")

tmp <- bowtie_build(references=refFiles, outdir=indexDir, prefix="index", force=TRUE)
head(tmp)
```

```
## [1] "Settings:"
## [2] "  Output files: \"/tmp/RtmppPQx4k/refsIndex/index.*.ebwt\""
## [3] "  Line rate: 6 (line is 64 bytes)"
## [4] "  Lines per side: 1 (side is 64 bytes)"
## [5] "  Offset rate: 5 (one in 32)"
## [6] "  FTable chars: 10"
```

## 3.2 Create alignment with `bowtie`

Information about the arguments supported by the `bowtie` function can be obtained
with the help of the `bowtie_usage` function or in the manual page `?bowtie`.

```
bowtie_usage()
```

```
##  [1] "Usage: "
##  [2] "bowtie-align-s [options]* -x <ebwt> {-1 <m1> -2 <m2> | --12 <r> | --interleaved <i> | <s>} [<hit>]"
##  [3] ""
##  [4] "  <ebwt>  Index filename prefix (minus trailing .X.ebwt)."
##  [5] "  <m1>    Comma-separated list of files containing upstream mates (or the"
##  [6] "          sequences themselves, if -c is set) paired with mates in <m2>"
##  [7] "  <m2>    Comma-separated list of files containing downstream mates (or the"
##  [8] "          sequences themselves if -c is set) paired with mates in <m1>"
##  [9] "  <r>     Comma-separated list of files containing Crossbow-style reads.  Can be"
## [10] "          a mixture of paired and unpaired.  Specify \"-\" for stdin."
## [11] "  <i>     Files with interleaved paired-end FASTQ reads."
## [12] "  <s>     Comma-separated list of files containing unpaired reads, or the"
## [13] "          sequences themselves, if -c is set.  Specify \"-\" for stdin."
## [14] "  <hit>   File to write hits to (default: stdout)"
## [15] "Input:"
## [16] "  -q                 query input files are FASTQ .fq/.fastq (default)"
## [17] "  -f                 query input files are (multi-)FASTA .fa/.mfa"
## [18] "  -F k:<int>,i:<int> query input files are continuous FASTA where reads"
## [19] "                     are substrings (k-mers) extracted from a FASTA file <s>"
## [20] "                     and aligned at offsets 1, 1+i, 1+2i ... end of reference"
## [21] "  -r                 query input files are raw one-sequence-per-line"
## [22] "  -c                 query sequences given on cmd line (as <mates>, <singles>)"
## [23] "  -Q/--quals <file>  QV file(s) corresponding to CSFASTA inputs; use with -f -C"
## [24] "  --Q1/--Q2 <file>   same as -Q, but for mate files 1 and 2 respectively"
## [25] "  -s/--skip <int>    skip the first <int> reads/pairs in the input"
## [26] "  -u/--qupto <int>   stop after first <int> reads/pairs (excl. skipped reads)"
## [27] "  -5/--trim5 <int>   trim <int> bases from 5' (left) end of reads"
## [28] "  -3/--trim3 <int>   trim <int> bases from 3' (right) end of reads"
## [29] "  --phred33-quals    input quals are Phred+33 (default)"
## [30] "  --phred64-quals    input quals are Phred+64 (same as --solexa1.3-quals)"
## [31] "  --solexa-quals     input quals are from GA Pipeline ver. < 1.3"
## [32] "  --solexa1.3-quals  input quals are from GA Pipeline ver. >= 1.3"
## [33] "  --integer-quals    qualities are given as space-separated integers (not ASCII)"
## [34] "Alignment:"
## [35] "  -v <int>           report end-to-end hits w/ <=v mismatches; ignore qualities"
## [36] "    or"
## [37] "  -n/--seedmms <int> max mismatches in seed (can be 0-3, default: -n 2)"
## [38] "  -e/--maqerr <int>  max sum of mismatch quals across alignment for -n (def: 70)"
## [39] "  -l/--seedlen <int> seed length for -n (default: 28)"
## [40] "  --nomaqround       disable Maq-like quality rounding for -n (nearest 10 <= 30)"
## [41] "  -I/--minins <int>  minimum insert size for paired-end alignment (default: 0)"
## [42] "  -X/--maxins <int>  maximum insert size for paired-end alignment (default: 250)"
## [43] "  --fr/--rf/--ff     -1, -2 mates align fw/rev, rev/fw, fw/fw (default: --fr)"
## [44] "  --nofw/--norc      do not align to forward/reverse-complement reference strand"
## [45] "  --maxbts <int>     max # backtracks for -n 2/3 (default: 125, 800 for --best)"
## [46] "  --pairtries <int>  max # attempts to find mate for anchor hit (default: 100)"
## [47] "  -y/--tryhard       try hard to find valid alignments, at the expense of speed"
## [48] "  --chunkmbs <int>   max megabytes of RAM for best-first search frames (def: 64)"
## [49] " --reads-per-batch   # of reads to read from input file at once (default: 16)"
## [50] "Reporting:"
## [51] "  -k <int>           report up to <int> good alignments per read (default: 1)"
## [52] "  -a/--all           report all alignments per read (much slower than low -k)"
## [53] "  -m <int>           suppress all alignments if > <int> exist (def: no limit)"
## [54] "  -M <int>           like -m, but reports 1 random hit (MAPQ=0); requires --best"
## [55] "  --best             hits guaranteed best stratum; ties broken by quality"
## [56] "  --strata           hits in sub-optimal strata aren't reported (requires --best)"
## [57] "Output:"
## [58] "  -t/--time          print wall-clock time taken by search phases"
## [59] "  -B/--offbase <int> leftmost ref offset = <int> in bowtie output (default: 0)"
## [60] "  --quiet            print nothing but the alignments"
## [61] "  --refidx           refer to ref. seqs by 0-based index rather than name"
## [62] "  --al <fname>       write aligned reads/pairs to file(s) <fname>"
## [63] "  --un <fname>       write unaligned reads/pairs to file(s) <fname>"
## [64] "  --no-unal          suppress SAM records for unaligned reads"
## [65] "  --max <fname>      write reads/pairs over -m limit to file(s) <fname>"
## [66] "  --suppress <cols>  suppresses given columns (comma-delim'ed) in default output"
## [67] "  --fullref          write entire ref name (default: only up to 1st space)"
## [68] "SAM:"
## [69] "  -S/--sam           write hits in SAM format"
## [70] "  --mapq <int>       default mapping quality (MAPQ) to print for SAM alignments"
## [71] "  --sam-nohead       supppress header lines (starting with @) for SAM output"
## [72] "  --sam-nosq         supppress @SQ header lines for SAM output"
## [73] "  --sam-RG <text>    add <text> (usually \"lab=value\") to @RG line of SAM header"
## [74] "Performance:"
## [75] "  -o/--offrate <int> override offrate of index; must be >= index's offrate"
## [76] "  -p/--threads <int> number of alignment threads to launch (default: 1)"
## [77] "  --mm               use memory-mapped I/O for index; many 'bowtie's can share"
## [78] "  --shmem            use shared mem for index; many 'bowtie's can share"
## [79] "Other:"
## [80] "  --seed <int>       seed for random number generator"
## [81] "  --verbose          verbose output (for debugging)"
## [82] "  --version          print version information and quit"
## [83] "  -h/--help          print this usage message"
```

In the example below, `readsFiles` is the name of a file containing short reads to
be aligned with `bowtie`, and `samFiles` specifies the name of the output file with
the generated alignments.

```
readsFiles <- system.file(package="Rbowtie", "samples", "reads", "reads.fastq")
samFiles <- file.path(tempdir(), "alignments.sam")

bowtie(sequences=readsFiles,
       index=file.path(indexDir, "index"),
       outfile=samFiles, sam=TRUE,
       best=TRUE, force=TRUE)
strtrim(readLines(samFiles), 65)
```

```
## [1] "@HD\tVN:1.0\tSO:unsorted"
## [2] "@SQ\tSN:chr1\tLN:100000"
## [3] "@SQ\tSN:chr2\tLN:100000"
## [4] "@SQ\tSN:chr3\tLN:100000"
## [5] "@PG\tID:Bowtie\tVN:1.3.0\tCL:\"/tmp/RtmpUt8EK0/Rinst277e945f653131/Rbowt"
## [6] "HWUSI-EAS1513_0012:6:48:5769:946#0/1\t0\tchr1\t819\t255\t101M\t*\t0\t0\tTGGAGTTCATG"
## [7] "HWUSI-EAS1513_0012:6:48:6908:952#0/1\t0\tchr2\t1133\t255\t101M\t*\t0\t0\tAACATAGTGA"
## [8] "HWUSI-EAS1513_0012:6:48:8070:953#0/1\t0\tchr1\t7543\t255\t101M\t*\t0\t0\tGTCTGTCTAG"
```

## 3.3 Create spliced alignment with `SpliceMap`

While `bowtie` only generates ungapped alignments, the `SpliceMap` function can be
used to generate spliced alignments. `SpliceMap` is itself using `bowtie`. To use
it, it is necessary to create an index of the reference sequence as described in
[**??**](#bowtieBuild). `SpliceMap` parameters are specified in the form of a named
list, which follows closely the configure file format of the original `SpliceMap`
program(Au et al. [2010](#ref-SpliceMap)). Be aware that `SpliceMap` can only be used for reads that are
at least 50bp long.

```
readsFiles <- system.file(package="Rbowtie", "samples", "reads", "reads.fastq")
refDir <- system.file(package="Rbowtie", "samples", "refs", "chr1.fa")
indexDir <- file.path(tempdir(), "refsIndex")
samFiles <- file.path(tempdir(), "splicedAlignments.sam")

cfg <- list(genome_dir=refDir,
            reads_list1=readsFiles,
            read_format="FASTQ",
            quality_format="phred-33",
            outfile=samFiles,
            temp_path=tempdir(),
            max_intron=400000,
            min_intron=20000,
            max_multi_hit=10,
            seed_mismatch=1,
            read_mismatch=2,
            num_chromosome_together=2,
            bowtie_base_dir=file.path(indexDir, "index"),
            num_threads=4,
            try_hard="yes",
            selectSingleHit=TRUE)
res <- SpliceMap(cfg)
```

```
## [SpliceMap] splitting reads into 25mers...done
## [SpliceMap] aligning 25mers...done
## [SpliceMap] sorting 25mer-alignments...done
## [SpliceMap] indexing 25mer-alignments...done
## [SpliceMap] finding spliced alignments for 1 chromosomes using 2 parallel processes...done
## [SpliceMap] extracting unmapped reads (single read mode)...done
## [SpliceMap] combining spliced alignments...done
## [SpliceMap] reordering final output...done
```

```
res
```

```
## [1] "/tmp/RtmppPQx4k/splicedAlignments.sam"
```

```
strtrim(readLines(samFiles), 65)
```

```
## [1] "@HD\tVN:1.0\tSO:coordinate"
## [2] "@SQ\tSN:chr1\tLN:100000"
## [3] "@PG\tID:SpliceMap\tVN:3.3.5.2 (55)"
## [4] "HWUSI-EAS1513_0012:6:48:5769:946#0\t0\tchr1\t819\t255\t101M\t*\t0\t0\tTGGAGTTCATGTG"
## [5] "HWUSI-EAS1513_0012:6:48:6908:952#0\t4\t*\t0\t0\t*\t*\t0\t0\tAACATAGTGAAGAAACCTCATAG"
## [6] "HWUSI-EAS1513_0012:6:48:8070:953#0\t0\tchr1\t7543\t255\t101M\t*\t0\t0\tGTCTGTCTAGTG"
## [7] "HWUSI-EAS1513_0012:6:48:9942:949#0\t4\t*\t0\t0\t*\t*\t0\t0\tCGGTTCCTGTATCCTTAATAAGT"
```

# 4 Session information

The output in this vignette was produced under:

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] Rbowtie_1.50.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] parallel_4.5.1      knitr_1.50          htmltools_0.5.8.1
## [10] rmarkdown_2.30      lifecycle_1.0.4     cli_3.6.5
## [13] sass_0.4.10         jquerylib_0.1.4     compiler_4.5.1
## [16] tools_4.5.1         evaluate_1.0.5      bslib_0.9.0
## [19] yaml_2.3.10         BiocManager_1.30.26 jsonlite_2.0.0
## [22] rlang_1.1.6
```

# References

Au, K. F., H. Jiang, L. Lin, Y. Xing, and W. H. Wong. 2010. “Detection of Splice Junctions from Paired-End Rna-Seq Data by Splicemap.” *Nucleic Acids Research* 38 (14): 4570–8.

Gaidatzis, D., A. Lerch, F. Hahne, and M. B. Stadler. 2015. “QuasR: Quantify and Annotate Short Reads in R.” *Bioinformatics* 31 (7): 1130–2. <https://doi.org/10.1093/bioinformatics/btu781>.

Hahne, F., A. Lerch, and M. B. Stadler. 2012. “Rbowtie: A R Wrapper for Bowtie and SpliceMap Short Read Aligners.”

Langmead, B., C. Trapnell, M. Pop, and S. L. Salzberg. 2009. “Ultrafast and Memory-Efficient Alignment of Short Dna Sequences to the Human Genome.” *Genome Biology* 10 (3): R25.