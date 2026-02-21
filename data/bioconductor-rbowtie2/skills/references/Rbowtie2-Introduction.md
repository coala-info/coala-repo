# An Introduction to Rbowtie2

#### Zheng Wei and Wei Zhang

#### 2025-10-30

## Introduction

The package provides an R wrapper of [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) and [AdapterRemoval](https://github.com/MikkelSchubert/adapterremoval). Bowtie2 is the popular sequencing reads aligner, which is good at aligning reads with length above 50bp[1]. AdapterRemoval is a convenient tool for rapid adapter trimming, identification, and read merging[2]. Both of them are implemented with C++. We wrap them into an R package that provide user friendly interfaces for R users.

You can preprocess the raw sequencing data by using AadapterRemoval even if adapter(s) information is missing. Then, Bowtie2 can aligned these preprocessed reads to the references.

This package is developed and maintained by members of [Xiaowo Wang Lab](http://bioinfo.au.tsinghua.edu.cn/member/xwwang)

MOE Key Laboratory of Bioinformatics and Bioinformatics Division,

TNLIST / Department of Automation, Tsinghua University

contact:{wei-z14,w-zhang16}(at)mails.tsinghua.edu.cn

## An Example Workflow by Using Rbowtie2

### Installation

To install the latest version of Rbowtie2, you will need to be using the latest version of R. Rbowtie2 is part of Bioconductor project, so you can install Rbowtie2 and its dependencies like this:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("Rbowtie2")
```

### Loading

Just like other R package, you need to load Rbowtie2 like this each time before using the package.

```
library(Rbowtie2)
```

### AdapterRemoval

All package functions mentioned in this subsection use the binary of AdapterRemoval.

#### Idetitify Adapter

If you know the adapter sequence of reads files, you can skip this step. Besides,single end data is not support for this function yet so adapter sequence has to be known .

reads\_1 and reads\_2 are raw paired-end reads file with fastq format. adapters is two adapters character vector.

```
td <- tempdir()
reads_1 <- system.file(package="Rbowtie2", "extdata", "adrm", "reads_1.fq")
reads_2 <- system.file(package="Rbowtie2", "extdata", "adrm", "reads_2.fq")
(adapters <-
    identify_adapters(file1=reads_1,file2=reads_2,
                      basename=file.path(td,"reads"),
                      "--threads 3",overwrite=TRUE))
```

```
## arguments 'show.output.on.console', 'minimized' and 'invisible' are for Windows only
```

```
## [1] "AGATCGGAAGAGCACACGTCTGAACTCCAGTCACCACCTAATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAAAAAAAAAAAAAAAA"
## [2] "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
```

#### Remove Adapter

With known adapter sequence, remove\_adapter function can be call to trim adapters.

```
(cmdout<-remove_adapters(file1=reads_1,file2=reads_2,adapter1 = adapters[1],
                adapter2 = adapters[2],
output1=file.path(td,"reads_1.trimmed.fq"),
output2=file.path(td,"reads_2.trimmed.fq"),
basename=file.path(td,"reads.base"),overwrite=TRUE,"--threads 3"))
```

```
## arguments 'show.output.on.console', 'minimized' and 'invisible' are for Windows only
```

```
## [1] "\rProcessed a total of 1,000 reads in 0.0s; 169,000 reads per second "
## [2] "on average ..."
```

#### Additional Arguments and Version

If you need to set additional arguments like “–threads 3” above, you can call function below to print all options available. The fixed arguments like file1, file2 and basename etc. are invalid.

```
adapterremoval_usage()
```

```
## arguments 'show.output.on.console', 'minimized' and 'invisible' are for Windows only
```

```
##   [1] "AdapterRemoval ver. 2.2.1a"
##   [2] ""
##   [3] "This program searches for and removes remnant adapter sequences from"
##   [4] "your read data.  The program can analyze both single end and paired end"
##   [5] "data.  For detailed explanation of the parameters, please refer to the"
##   [6] "man page.  For comments, suggestions  and feedback please contact Stinus"
##   [7] "Lindgreen (stinus@binf.ku.dk) and Mikkel Schubert (MikkelSch@gmail.com)."
##   [8] ""
##   [9] "If you use the program, please cite the paper:"
##  [10] "    Schubert, Lindgreen, and Orlando (2016). AdapterRemoval v2: rapid"
##  [11] "    adapter trimming, identification, and read merging."
##  [12] "    BMC Research Notes, 12;9(1):88."
##  [13] ""
##  [14] "    http://bmcresnotes.biomedcentral.com/articles/10.1186/s13104-016-1900-2"
##  [15] ""
##  [16] ""
##  [17] "Arguments:                           Description:"
##  [18] "  --help                             Display this message."
##  [19] "  --version                          Print the version string."
##  [20] ""
##  [21] "  --file1 FILE [FILE ...]            Input files containing mate 1 reads or"
##  [22] "                                       single-ended reads; one or more files"
##  [23] "                                       may be listed [REQUIRED]."
##  [24] "  --file2 [FILE ...]                 Input files containing mate 2 reads; if"
##  [25] "                                       used, then the same number of files as"
##  [26] "                                       --file1 must be listed [OPTIONAL]."
##  [27] ""
##  [28] "FASTQ OPTIONS:"
##  [29] "  --qualitybase BASE                 Quality base used to encode Phred scores"
##  [30] "                                       in input; either 33, 64, or solexa"
##  [31] "                                       [current: 33]."
##  [32] "  --qualitybase-output BASE          Quality base used to encode Phred scores"
##  [33] "                                       in output; either 33, 64, or solexa."
##  [34] "                                       By default, reads will be written in"
##  [35] "                                       the same format as the that specified"
##  [36] "                                       using --qualitybase."
##  [37] "  --qualitymax BASE                  Specifies the maximum Phred score"
##  [38] "                                       expected in input files, and used when"
##  [39] "                                       writing output. ASCII encoded values"
##  [40] "                                       are limited to the characters '!'"
##  [41] "                                       (ASCII = 33) to '~' (ASCII = 126),"
##  [42] "                                       meaning that possible scores are 0 -"
##  [43] "                                       93 with offset 33, and 0 - 62 for"
##  [44] "                                       offset 64 and Solexa scores [default:"
##  [45] "                                       41]."
##  [46] "  --mate-separator CHAR              Character separating the mate number (1"
##  [47] "                                       or 2) from the read name in FASTQ"
##  [48] "                                       records [default: '/']."
##  [49] "  --interleaved                      This option enables both the"
##  [50] "                                       --interleaved-input option and the"
##  [51] "                                       --interleaved-output option [current:"
##  [52] "                                       off]."
##  [53] "  --interleaved-input                The (single) input file provided"
##  [54] "                                       contains both the mate 1 and mate 2"
##  [55] "                                       reads, one pair after the other, with"
##  [56] "                                       one mate 1 reads followed by one mate"
##  [57] "                                       2 read. This option is implied by the"
##  [58] "                                       --interleaved option [current: off]."
##  [59] "  --interleaved-output               If set, trimmed paired-end reads are"
##  [60] "                                       written to a single file containing"
##  [61] "                                       mate 1 and mate 2 reads, one pair"
##  [62] "                                       after the other. This option is"
##  [63] "                                       implied by the --interleaved option"
##  [64] "                                       [current: off]."
##  [65] "  --combined-output                  If set, all reads are written to the"
##  [66] "                                       same file(s), specified by --output1"
##  [67] "                                       and --output2 (--output1 only if"
##  [68] "                                       --interleaved-output is not set). Each"
##  [69] "                                       read is further marked by either a"
##  [70] "                                       \"PASSED\" or a \"FAILED\" flag, and any"
##  [71] "                                       read that has been FAILED (including"
##  [72] "                                       the mate for collapsed reads) are"
##  [73] "                                       replaced with a single 'N' with Phred"
##  [74] "                                       score 0 [current: off]."
##  [75] ""
##  [76] "OUTPUT FILES:"
##  [77] "  --basename BASENAME                Default prefix for all output files for"
##  [78] "                                       which no filename was explicitly set"
##  [79] "                                       [current: your_output]."
##  [80] "  --settings FILE                    Output file containing information on"
##  [81] "                                       the parameters used in the run as well"
##  [82] "                                       as overall statistics on the reads"
##  [83] "                                       after trimming [default:"
##  [84] "                                       BASENAME.settings]"
##  [85] "  --output1 FILE                     Output file containing trimmed mate1"
##  [86] "                                       reads [default:"
##  [87] "                                       BASENAME.pair1.truncated (PE),"
##  [88] "                                       BASENAME.truncated (SE), or"
##  [89] "                                       BASENAME.paired.truncated (interleaved"
##  [90] "                                       PE)]"
##  [91] "  --output2 FILE                     Output file containing trimmed mate 2"
##  [92] "                                       reads [default:"
##  [93] "                                       BASENAME.pair2.truncated (only used in"
##  [94] "                                       PE mode, but not if"
##  [95] "                                       --interleaved-output is enabled)]"
##  [96] "  --singleton FILE                   Output file to which containing paired"
##  [97] "                                       reads for which the mate has been"
##  [98] "                                       discarded [default:"
##  [99] "                                       BASENAME.singleton.truncated]"
## [100] "  --outputcollapsed FILE             If --collapsed is set, contains"
## [101] "                                       overlapping mate-pairs which have been"
## [102] "                                       merged into a single read (PE mode) or"
## [103] "                                       reads for which the adapter was"
## [104] "                                       identified by a minimum overlap,"
## [105] "                                       indicating that the entire template"
## [106] "                                       molecule is present. This does not"
## [107] "                                       include which have subsequently been"
## [108] "                                       trimmed due to low-quality or"
## [109] "                                       ambiguous nucleotides [default:"
## [110] "                                       BASENAME.collapsed]"
## [111] "  --outputcollapsedtruncated FILE    Collapsed reads (see --outputcollapsed)"
## [112] "                                       which were trimmed due the presence of"
## [113] "                                       low-quality or ambiguous nucleotides"
## [114] "                                       [default:"
## [115] "                                       BASENAME.collapsed.truncated]"
## [116] "  --discarded FILE                   Contains reads discarded due to the"
## [117] "                                       --minlength, --maxlength or --maxns"
## [118] "                                       options [default: BASENAME.discarded]"
## [119] ""
## [120] "TRIMMING SETTINGS:"
## [121] "  --adapter1 SEQUENCE                Adapter sequence expected to be found in"
## [122] "                                       mate 1 reads [current:"
## [123] "                                       AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNATCTCGTATGCCGTCTTCTGCTTG]."
## [124] "  --adapter2 SEQUENCE                Adapter sequence expected to be found in"
## [125] "                                       mate 2 reads [current:"
## [126] "                                       AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT]."
## [127] "  --adapter-list FILENAME            Read table of white-space separated"
## [128] "                                       adapters pairs, used as if the first"
## [129] "                                       column was supplied to --adapter1, and"
## [130] "                                       the second column was supplied to"
## [131] "                                       --adapter2; only the first adapter in"
## [132] "                                       each pair is required SE trimming mode"
## [133] "                                       [current: <not set>]."
## [134] ""
## [135] "  --mm MISMATCH_RATE                 Max error-rate when aligning reads"
## [136] "                                       and/or adapters. If > 1, the max"
## [137] "                                       error-rate is set to 1 /"
## [138] "                                       MISMATCH_RATE; if < 0, the defaults"
## [139] "                                       are used, otherwise the user-supplied"
## [140] "                                       value is used directly [defaults: 1/3"
## [141] "                                       for trimming; 1/10 when identifying"
## [142] "                                       adapters]."
## [143] "  --maxns MAX                        Reads containing more ambiguous bases"
## [144] "                                       (N) than this number after trimming"
## [145] "                                       are discarded [current: 1000]."
## [146] "  --shift N                          Consider alignments where up to N"
## [147] "                                       nucleotides are missing from the 5'"
## [148] "                                       termini [current: 2]."
## [149] ""
## [150] "  --trimns                           If set, trim ambiguous bases (N) at"
## [151] "                                       5'/3' termini [current: off]"
## [152] "  --trimqualities                    If set, trim bases at 5'/3' termini with"
## [153] "                                       quality scores <= to --minquality"
## [154] "                                       value [current: off]"
## [155] "  --trimwindows INT                  If set, quality trimming will be carried"
## [156] "                                       out using window based approach, where"
## [157] "                                       windows with an average quality less"
## [158] "                                       than --minquality will be trimmed. If"
## [159] "                                       >= 1, this value will be used as the"
## [160] "                                       window size. If the value is < 1, the"
## [161] "                                       value will be multiplied with the read"
## [162] "                                       length to determine a window size per"
## [163] "                                       read. If the resulting window size is"
## [164] "                                       0 or larger than the read length, the"
## [165] "                                       read length is used as the window"
## [166] "                                       size. This option implies"
## [167] "                                       --trimqualities [current: <not set>]."
## [168] "  --minquality PHRED                 Inclusive minimum; see --trimqualities"
## [169] "                                       for details [current: 2]"
## [170] "  --minlength LENGTH                 Reads shorter than this length are"
## [171] "                                       discarded following trimming [current:"
## [172] "                                       15]."
## [173] "  --maxlength LENGTH                 Reads longer than this length are"
## [174] "                                       discarded following trimming [current:"
## [175] "                                       4294967295]."
## [176] "  --collapse                         When set, paired ended read alignments"
## [177] "                                       of --minalignmentlength or more bases"
## [178] "                                       are combined into a single consensus"
## [179] "                                       sequence, representing the complete"
## [180] "                                       insert, and written to either"
## [181] "                                       basename.collapsed or"
## [182] "                                       basename.collapsed.truncated (if"
## [183] "                                       trimmed due to low-quality bases"
## [184] "                                       following collapse); for single-ended"
## [185] "                                       reads, putative complete inserts are"
## [186] "                                       identified as having at least"
## [187] "                                       --minalignmentlength bases overlap"
## [188] "                                       with the adapter sequence, and are"
## [189] "                                       written to the the same files"
## [190] "                                       [current: off]."
## [191] "  --minalignmentlength LENGTH        If --collapse is set, paired reads must"
## [192] "                                       overlap at least this number of bases"
## [193] "                                       to be collapsed, and single-ended"
## [194] "                                       reads must overlap at least this"
## [195] "                                       number of bases with the adapter to be"
## [196] "                                       considered complete template molecules"
## [197] "                                       [current: 11]."
## [198] "  --minadapteroverlap LENGTH         In single-end mode, reads are only"
## [199] "                                       trimmed if the overlap between read"
## [200] "                                       and the adapter is at least X bases"
## [201] "                                       long, not counting ambiguous"
## [202] "                                       nucleotides (N); this is independent"
## [203] "                                       of the --minalignmentlength when using"
## [204] "                                       --collapse, allowing a conservative"
## [205] "                                       selection of putative complete inserts"
## [206] "                                       while ensuring that all possible"
## [207] "                                       adapter contamination is trimmed"
## [208] "                                       [current: 0]."
## [209] ""
## [210] "DEMULTIPLEXING:"
## [211] "  --barcode-list FILENAME            List of barcodes or barcode pairs for"
## [212] "                                       single or double-indexed"
## [213] "                                       demultiplexing. Note that both indexes"
## [214] "                                       should be specified for both"
## [215] "                                       single-end and paired-end trimming, if"
## [216] "                                       double-indexed multiplexing was used,"
## [217] "                                       in order to ensure that the"
## [218] "                                       demultiplexed reads can be trimmed"
## [219] "                                       correctly [current: <not set>]."
## [220] "  --barcode-mm N                     Maximum number of mismatches allowed"
## [221] "                                       when counting mismatches in both the"
## [222] "                                       mate 1 and the mate 2 barcode for"
## [223] "                                       paired reads."
## [224] "  --barcode-mm-r1 N                  Maximum number of mismatches allowed for"
## [225] "                                       the mate 1 barcode; if not set, this"
## [226] "                                       value is equal to the '--barcode-mm'"
## [227] "                                       value; cannot be higher than the"
## [228] "                                       '--barcode-mm value'."
## [229] "  --barcode-mm-r2 N                  Maximum number of mismatches allowed for"
## [230] "                                       the mate 2 barcode; if not set, this"
## [231] "                                       value is equal to the '--barcode-mm'"
## [232] "                                       value; cannot be higher than the"
## [233] "                                       '--barcode-mm value'."
## [234] "  --demultiplex-only                 Only carry out demultiplexing using the"
## [235] "                                       list of barcodes supplied with"
## [236] "                                       --barcode-list; do not attempt to trim"
## [237] "                                       adapters to carry out other"
## [238] "                                       processing."
## [239] ""
## [240] "MISC:"
## [241] "  --identify-adapters                Attempt to identify the adapter pair of"
## [242] "                                       PE reads, by searching for overlapping"
## [243] "                                       reads [current: off]."
## [244] "  --seed SEED                        Sets the RNG seed used when choosing"
## [245] "                                       between bases with equal Phred scores"
## [246] "                                       when collapsing. Note that runs are"
## [247] "                                       not deterministic if more than one"
## [248] "                                       thread is used. If not specified, a"
## [249] "                                       seed is generated using the current"
## [250] "                                       time."
## [251] "  --threads THREADS                  Maximum number of threads [current: 1]"
## [252] ""
```

You can get version information by call:

```
adapterremoval_version()
```

```
## arguments 'show.output.on.console', 'minimized' and 'invisible' are for Windows only
```

```
## [1] "AdapterRemoval ver. 2.2.1a"
```

### Bowtie2

All package functions mentioned in this subsection use the binary of Bowtie2. Note that Bowtie2 is support 64bit R.

#### Build Bowtie2 Index

Before aligning reads, bowtie2 index should be build. refs is a character vector of fasta reference file paths. A prefix of bowtie index should be set to argument bt2Index. Then, 6 index files with .bt2 file name extension will be created with bt2Index prefix.

```
td <- tempdir()
refs <- dir(system.file(package="Rbowtie2", "extdata", "bt2","refs"),full=TRUE)
(cmdout<-bowtie2_build(references=refs,
              bt2Index=file.path(td, "lambda_virus"), "--threads 4 --quiet",
              overwrite=TRUE))
```

```
## arguments 'show.output.on.console', 'minimized' and 'invisible' are for Windows only
```

```
## character(0)
```

#### Additional Arguments of Bowtie Build

If you need to set additional arguments like “–threads 4 –quiet” above, you can call function below to print all options available. The fixed arguments references, bt2Index are invalid.

```
bowtie2_build_usage()
```

```
## arguments 'show.output.on.console', 'minimized' and 'invisible' are for Windows only
```

```
##  [1] "Bowtie 2 version 2.4.4 by Ben Langmead (langmea@cs.jhu.edu, www.cs.jhu.edu/~langmea)"
##  [2] "Usage: bowtie2-build [options]* <reference_in> <bt2_index_base>"
##  [3] "    reference_in            comma-separated list of files with ref sequences"
##  [4] "    bt2_index_base          write bt2 data to files with this dir/basename"
##  [5] "*** Bowtie 2 indexes work only with v2 (not v1).  Likewise for v1 indexes. ***"
##  [6] "Options:"
##  [7] "    -f                      reference files are Fasta (default)"
##  [8] "    -c                      reference sequences given on cmd line (as"
##  [9] "                            <reference_in>)"
## [10] "    --large-index           force generated index to be 'large', even if ref"
## [11] "                            has fewer than 4 billion nucleotides"
## [12] "    --debug                 use the debug binary; slower, assertions enabled"
## [13] "    --sanitized             use sanitized binary; slower, uses ASan and/or UBSan"
## [14] "    --verbose               log the issued command"
## [15] "    -a/--noauto             disable automatic -p/--bmax/--dcv memory-fitting"
## [16] "    -p/--packed             use packed strings internally; slower, less memory"
## [17] "    --bmax <int>            max bucket sz for blockwise suffix-array builder"
## [18] "    --bmaxdivn <int>        max bucket sz as divisor of ref len (default: 4)"
## [19] "    --dcv <int>             diff-cover period for blockwise (default: 1024)"
## [20] "    --nodc                  disable diff-cover (algorithm becomes quadratic)"
## [21] "    -r/--noref              don't build .3/.4 index files"
## [22] "    -3/--justref            just build .3/.4 index files"
## [23] "    -o/--offrate <int>      SA is sampled every 2^<int> BWT chars (default: 5)"
## [24] "    -t/--ftabchars <int>    # of chars consumed in initial lookup (default: 10)"
## [25] "    --threads <int>         # of threads"
## [26] "    --seed <int>            seed for random number generator"
## [27] "    -q/--quiet              verbose output (for debugging)"
## [28] "    -h/--help               print detailed description of tool and its options"
## [29] "    --usage                 print this usage message"
## [30] "    --version               print version information and quit"
```

#### Bowtie2 Alignment

The variable reads\_1 and reads\_1 are preprocessed reads file paths. With bowtie2 index, reads will be mapped to reference by calling bowtie2. The result is saved in a sam file whose path is set to output

```
reads_1 <- system.file(package="Rbowtie2", "extdata",
                       "bt2", "reads", "reads_1.fastq")
reads_2 <- system.file(package="Rbowtie2", "extdata",
                       "bt2", "reads", "reads_2.fastq")
if(file.exists(file.path(td, "lambda_virus.1.bt2"))){
    (cmdout<-bowtie2_samtools(bt2Index = file.path(td, "lambda_virus"),
        output = file.path(td, "result"),
        outputType = "sam",
        seq1=reads_1,
        seq2=reads_2,
        overwrite=TRUE,
        bamFile = NULL,
        "--threads 3"))
    head(readLines(file.path(td, "result.sam")))
}
```

```
## arguments 'show.output.on.console', 'minimized' and 'invisible' are for Windows only
```

```
## [1] "@HD\tVN:1.0\tSO:unsorted"
## [2] "@SQ\tSN:gi|9626243|ref|NC_001416.1|\tLN:48502"
## [3] "@PG\tID:bowtie2\tPN:bowtie2\tVN:2.4.4\tCL:\"/tmp/Rtmpag192S/Rinst277fef6b8160d8/Rbowtie2/bowtie2-align-s --wrapper basic-0 --threads 3 -x /tmp/Rtmp1YTOgL/lambda_virus -S /tmp/Rtmp1YTOgL/result.sam -1 /tmp/Rtmpag192S/Rinst277fef6b8160d8/Rbowtie2/extdata/bt2/reads/reads_1.fastq -2 /tmp/Rtmpag192S/Rinst277fef6b8160d8/Rbowtie2/extdata/bt2/reads/reads_2.fastq\""
## [4] "r1\t99\tgi|9626243|ref|NC_001416.1|\t18401\t42\t122M\t=\t18430\t227\tTGAATGCGAACTCCGGGACGCTCAGTAATGTGACGATAGCTGAAAACTGTACGATAAACNGTACGCTGAGGGCAGAAAAAATCGTCGGGGACATTNTAAAGGCGGCGAGCGCGGCTTTTCCG\t+\"@6<:27(F&5)9)\"B:%B+A-%5A?2$HCB0B+0=D<7E/<.03#!.F77@6B==?C\"7>;))%;,3-$.A06+<-1/@@?,26\">=?*@'0;$:;??G+:#+(A?9+10!8!?()?7C>\tAS:i:-5\tXN:i:0\tXM:i:3\tXO:i:0\tXG:i:0\tNM:i:3\tMD:Z:59G13G21G26\tYS:i:-4\tYT:Z:CP"
## [5] "r1\t147\tgi|9626243|ref|NC_001416.1|\t18430\t42\t198M\t=\t18401\t-227\tGTGACGATAGCTGAAAACTGTACGATAAACGGTACGCTGAGGGCGGAAAAAATCGTCGGGGACATNGTANAGGCGGCGAGCGCGGCTTTNCCGCGCCAGCGTGAAAGCAGTGTGGACTGGCCGTCAGGTACCCGTACTGTCACCGTGACCGATGACCATCCTTTTGATCGCCAGATAGTGGTGCTTCCGCTGACGTTN\tB+9+D)1\"7>:@=D&D0@:@7:10@;<CA9>('A5D*G0@>!6%+,B<(%@#+8$@$+!-1=1::@:;99E((>--9H>H))\"?8&4-9#C:E*#&?D@6!;6'-@&$3>2.11,?AG9?-:?CBA.?1#+!0$@?C'*=B#/&:F&/-,E<>-F#++)/B0:2!E;.D8&?9;+G/2;E=>*<5@94H8CA9&F$?&\tAS:i:-4\tXN:i:0\tXM:i:4\tXO:i:0\tXG:i:0\tNM:i:4\tMD:Z:65T3A19T107T0\tYS:i:-5\tYT:Z:CP"
## [6] "r2\t99\tgi|9626243|ref|NC_001416.1|\t8886\t42\t275M\t=\t8973\t275\tNTTNTGATGCGGGCTTGTGGAGTTCAGCCGATCTGACTTATGTCATTACCTATGAAATGTGAGGACGCTATGCCTGTACCAAATCCTACAATGCCGGTGAAAGGTGCCGGGATCACCCTGTGGGTTTATAAGGGGATCGGTGACCCCTACGCGAATCCGCTTTCAGACGTTGACTGGTCGCGTCTGGCAAAAGTTAAAGACCTGACGCCCGGCGAACTGACCGCTGAGNCCTATGACGACAGCTATCTCGATGATGAAGATGCAGACTGGACTGC\t(#!!'+!$\"\"%+(+)'%)%!+!(&++)''\"#\"#&#\"!'!(\"%'\"\"(\"+&%$%*%%#$%#%#!)*'(#\")(($&$'&%+&#%*)*#*%*')(%+!%%*\"$%\"#+)$&&+)&)*+!\"*)!*!(\"&&\"*#+\"&\"'(%)*(\"'!$*!!%$&&&$!!&&\"(*\"$&\"#&!$%'%\"#)$#+%*+)!&*)+(\"\"#!)!%*#\"*)*')&\")($+*%%)!*)!('(%\"\"+%\"$##\"#+(('!*(($*'!\"*('\"+)&%#&$+('**$$&+*&!#%)')'(+(!%+\tAS:i:-14\tXN:i:0\tXM:i:8\tXO:i:0\tXG:i:0\tNM:i:8\tMD:Z:0A0C0G0A108C23G9T81T46\tYS:i:-5\tYT:Z:CP"
```

#### Additional Arguments and Version of Bowtie2 Aligner

If you need to set additional arguments like “–threads 3” above, you can call function below to print all options available. The fixed arguments like bt2Index, samOutput and seq1 etc. are invalid.

```
bowtie2_usage()
```

```
## arguments 'show.output.on.console', 'minimized' and 'invisible' are for Windows only
```

```
##   [1] "Bowtie 2 version 2.4.4 by Ben Langmead (langmea@cs.jhu.edu, www.cs.jhu.edu/~langmea)"
##   [2] "Usage: "
##   [3] "  bowtie2 [options]* -x <bt2-idx> {-1 <m1> -2 <m2> | -U <r> | --interleaved <i> | -b <bam>} [-S <sam>]"
##   [4] ""
##   [5] "  <bt2-idx>  Index filename prefix (minus trailing .X.bt2)."
##   [6] "             NOTE: Bowtie 1 and Bowtie 2 indexes are not compatible."
##   [7] "  <m1>       Files with #1 mates, paired with files in <m2>."
##   [8] "             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2)."
##   [9] "  <m2>       Files with #2 mates, paired with files in <m1>."
##  [10] "             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2)."
##  [11] "  <r>        Files with unpaired reads."
##  [12] "             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2)."
##  [13] "  <i>        Files with interleaved paired-end FASTQ/FASTA reads"
##  [14] "             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2)."
##  [15] "  <bam>      Files are unaligned BAM sorted by read name."
##  [16] "  <sam>      File for SAM output (default: stdout)"
##  [17] ""
##  [18] "  <m1>, <m2>, <r> can be comma-separated lists (no whitespace) and can be"
##  [19] "  specified many times.  E.g. '-U file1.fq,file2.fq -U file3.fq'."
##  [20] ""
##  [21] "Options (defaults in parentheses):"
##  [22] ""
##  [23] " Input:"
##  [24] "  -q                 query input files are FASTQ .fq/.fastq (default)"
##  [25] "  --tab5             query input files are TAB5 .tab5"
##  [26] "  --tab6             query input files are TAB6 .tab6"
##  [27] "  --qseq             query input files are in Illumina's qseq format"
##  [28] "  -f                 query input files are (multi-)FASTA .fa/.mfa"
##  [29] "  -r                 query input files are raw one-sequence-per-line"
##  [30] "  -F k:<int>,i:<int> query input files are continuous FASTA where reads"
##  [31] "                     are substrings (k-mers) extracted from a FASTA file <s>"
##  [32] "                     and aligned at offsets 1, 1+i, 1+2i ... end of reference"
##  [33] "  -c                 <m1>, <m2>, <r> are sequences themselves, not files"
##  [34] "  -s/--skip <int>    skip the first <int> reads/pairs in the input (none)"
##  [35] "  -u/--upto <int>    stop after first <int> reads/pairs (no limit)"
##  [36] "  -5/--trim5 <int>   trim <int> bases from 5'/left end of reads (0)"
##  [37] "  -3/--trim3 <int>   trim <int> bases from 3'/right end of reads (0)"
##  [38] "  --trim-to [3:|5:]<int> trim reads exceeding <int> bases from either 3' or 5' end"
##  [39] "                     If the read end is not specified then it defaults to 3 (0)"
##  [40] "  --phred33          qualities are Phred+33 (default)"
##  [41] "  --phred64          qualities are Phred+64"
##  [42] "  --int-quals        qualities encoded as space-delimited integers"
##  [43] ""
##  [44] " Presets:                 Same as:"
##  [45] "  For --end-to-end:"
##  [46] "   --very-fast            -D 5 -R 1 -N 0 -L 22 -i S,0,2.50"
##  [47] "   --fast                 -D 10 -R 2 -N 0 -L 22 -i S,0,2.50"
##  [48] "   --sensitive            -D 15 -R 2 -N 0 -L 22 -i S,1,1.15 (default)"
##  [49] "   --very-sensitive       -D 20 -R 3 -N 0 -L 20 -i S,1,0.50"
##  [50] ""
##  [51] "  For --local:"
##  [52] "   --very-fast-local      -D 5 -R 1 -N 0 -L 25 -i S,1,2.00"
##  [53] "   --fast-local           -D 10 -R 2 -N 0 -L 22 -i S,1,1.75"
##  [54] "   --sensitive-local      -D 15 -R 2 -N 0 -L 20 -i S,1,0.75 (default)"
##  [55] "   --very-sensitive-local -D 20 -R 3 -N 0 -L 20 -i S,1,0.50"
##  [56] ""
##  [57] " Alignment:"
##  [58] "  -N <int>           max # mismatches in seed alignment; can be 0 or 1 (0)"
##  [59] "  -L <int>           length of seed substrings; must be >3, <32 (22)"
##  [60] "  -i <func>          interval between seed substrings w/r/t read len (S,1,1.15)"
##  [61] "  --n-ceil <func>    func for max # non-A/C/G/Ts permitted in aln (L,0,0.15)"
##  [62] "  --dpad <int>       include <int> extra ref chars on sides of DP table (15)"
##  [63] "  --gbar <int>       disallow gaps within <int> nucs of read extremes (4)"
##  [64] "  --ignore-quals     treat all quality values as 30 on Phred scale (off)"
##  [65] "  --nofw             do not align forward (original) version of read (off)"
##  [66] "  --norc             do not align reverse-complement version of read (off)"
##  [67] "  --no-1mm-upfront   do not allow 1 mismatch alignments before attempting to"
##  [68] "                     scan for the optimal seeded alignments"
##  [69] "  --end-to-end       entire read must align; no clipping (on)"
##  [70] "   OR"
##  [71] "  --local            local alignment; ends might be soft clipped (off)"
##  [72] ""
##  [73] " Scoring:"
##  [74] "  --ma <int>         match bonus (0 for --end-to-end, 2 for --local) "
##  [75] "  --mp <int>         max penalty for mismatch; lower qual = lower penalty (6)"
##  [76] "  --np <int>         penalty for non-A/C/G/Ts in read/ref (1)"
##  [77] "  --rdg <int>,<int>  read gap open, extend penalties (5,3)"
##  [78] "  --rfg <int>,<int>  reference gap open, extend penalties (5,3)"
##  [79] "  --score-min <func> min acceptable alignment score w/r/t read length"
##  [80] "                     (G,20,8 for local, L,-0.6,-0.6 for end-to-end)"
##  [81] ""
##  [82] " Reporting:"
##  [83] "  (default)          look for multiple alignments, report best, with MAPQ"
##  [84] "   OR"
##  [85] "  -k <int>           report up to <int> alns per read; MAPQ not meaningful"
##  [86] "   OR"
##  [87] "  -a/--all           report all alignments; very slow, MAPQ not meaningful"
##  [88] ""
##  [89] " Effort:"
##  [90] "  -D <int>           give up extending after <int> failed extends in a row (15)"
##  [91] "  -R <int>           for reads w/ repetitive seeds, try <int> sets of seeds (2)"
##  [92] ""
##  [93] " Paired-end:"
##  [94] "  -I/--minins <int>  minimum fragment length (0)"
##  [95] "  -X/--maxins <int>  maximum fragment length (500)"
##  [96] "  --fr/--rf/--ff     -1, -2 mates align fw/rev, rev/fw, fw/fw (--fr)"
##  [97] "  --no-mixed         suppress unpaired alignments for paired reads"
##  [98] "  --no-discordant    suppress discordant alignments for paired reads"
##  [99] "  --dovetail         concordant when mates extend past each other"
## [100] "  --no-contain       not concordant when one mate alignment contains other"
## [101] "  --no-overlap       not concordant when mates overlap at all"
## [102] ""
## [103] " BAM:"
## [104] "  --align-paired-reads"
## [105] "                     Bowtie2 will, by default, attempt to align unpaired BAM reads."
## [106] "                     Use this option to align paired-end reads instead."
## [107] "  --preserve-tags    Preserve tags from the original BAM record by"
## [108] "                     appending them to the end of the corresponding SAM output."
## [109] ""
## [110] " Output:"
## [111] "  -t/--time          print wall-clock time taken by search phases"
## [112] "  --un <path>        write unpaired reads that didn't align to <path>"
## [113] "  --al <path>        write unpaired reads that aligned at least once to <path>"
## [114] "  --un-conc <path>   write pairs that didn't align concordantly to <path>"
## [115] "  --al-conc <path>   write pairs that aligned concordantly at least once to <path>"
## [116] "    (Note: for --un, --al, --un-conc, or --al-conc, add '-gz' to the option name, e.g."
## [117] "    --un-gz <path>, to gzip compress output, or add '-bz2' to bzip2 compress output.)"
## [118] "  --quiet            print nothing to stderr except serious errors"
## [119] "  --met-file <path>  send metrics to file at <path> (off)"
## [120] "  --met-stderr       send metrics to stderr (off)"
## [121] "  --met <int>        report internal counters & metrics every <int> secs (1)"
## [122] "  --no-unal          suppress SAM records for unaligned reads"
## [123] "  --no-head          suppress header lines, i.e. lines starting with @"
## [124] "  --no-sq            suppress @SQ header lines"
## [125] "  --rg-id <text>     set read group id, reflected in @RG line and RG:Z: opt field"
## [126] "  --rg <text>        add <text> (\"lab:value\") to @RG line of SAM header."
## [127] "                     Note: @RG line only printed when --rg-id is set."
## [128] "  --omit-sec-seq     put '*' in SEQ and QUAL fields for secondary alignments."
## [129] "  --sam-no-qname-trunc"
## [130] "                     Suppress standard behavior of truncating readname at first whitespace "
## [131] "                     at the expense of generating non-standard SAM."
## [132] "  --xeq              Use '='/'X', instead of 'M,' to specify matches/mismatches in SAM record."
## [133] "  --soft-clipped-unmapped-tlen"
## [134] "                     Exclude soft-clipped bases when reporting TLEN"
## [135] "  --sam-append-comment"
## [136] "                     Append FASTA/FASTQ comment to SAM record"
## [137] ""
## [138] " Performance:"
## [139] "  -p/--threads <int> number of alignment threads to launch (1)"
## [140] "  --reorder          force SAM output order to match order of input reads"
## [141] "  --mm               use memory-mapped I/O for index; many 'bowtie's can share"
## [142] ""
## [143] " Other:"
## [144] "  --qc-filter        filter out reads that are bad according to QSEQ filter"
## [145] "  --seed <int>       seed for random number generator (0)"
## [146] "  --non-deterministic"
## [147] "                     seed rand. gen. arbitrarily instead of using read attributes"
## [148] "  --version          print version information and quit"
## [149] "  -h/--help          print this usage message"
```

You can get version information by call:

```
bowtie2_version()
```

```
## arguments 'show.output.on.console', 'minimized' and 'invisible' are for Windows only
```

```
## [1] "/tmp/Rtmpag192S/Rinst277fef6b8160d8/Rbowtie2/bowtie2-align-s version 2.4.4"
## [2] "64-bit"
## [3] "Built on nebbiolo2"
## [4] "Thu 30 Oct 05:58:19 UTC 2025"
## [5] "Compiler: gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04) "
## [6] "Options: -O3 -msse2 -funroll-loops -g3 -std=c++11 -DPOPCNT_CAPABILITY -DNO_SPINLOCK -DWITH_QUEUELOCK=1"
## [7] "Sizeof {int, long, long long, void*, size_t, off_t}: {4, 8, 8, 8, 8, 8}"
```

## Session Infomation

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
## [1] Rbowtie2_2.16.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.53
##  [5] magrittr_2.0.4    cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1
##  [9] rmarkdown_2.30    lifecycle_1.0.4   cli_3.6.5         sass_0.4.10
## [13] jquerylib_0.1.4   compiler_4.5.1    tools_4.5.1       evaluate_1.0.5
## [17] bslib_0.9.0       yaml_2.3.10       rlang_1.1.6       jsonlite_2.0.0
```

## Acknowledgement

We would like to thank Huan Fang for package testing and valuable suggestions.

## References

[1] Langmead, B., & Salzberg, S. L. (2012). Fast gapped-read alignment with Bowtie 2. Nature methods, 9(4), 357-359.

[2] Schubert, Lindgreen, and Orlando (2016). AdapterRemoval v2: rapid adapter trimming, identification, and read merging. BMC Research Notes, 12;9(1):88.