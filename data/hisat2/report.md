# hisat2 CWL Generation Report

## hisat2

### Tool Description
HISAT2 is a fast and sensitive alignment program for mapping next-generation sequencing reads (both DNA and RNA) to a population of human genomes (as well as to a single reference genome).

### Metadata
- **Docker Image**: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
- **Homepage**: https://daehwankimlab.github.io/hisat2
- **Package**: https://anaconda.org/channels/bioconda/packages/hisat2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hisat2/overview
- **Total Downloads**: 452.1K
- **Last updated**: 2026-09-07
- **GitHub**: https://github.com/DaehwanKimLab/hisat2
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/hisat2-align-s: option '--h' is ambiguous; possibilities: '--help' '--hadoopout' '--haplotype'
HISAT2 version 2.2.3 by Daehwan Kim (infphilo@gmail.com, www.ccb.jhu.edu/people/infphilo)
Usage: 
  hisat2 [options]* -x <ht2-idx> {-1 <m1> -2 <m2> | -U <r>} [-S <sam>]

  <ht2-idx>  Index filename prefix (minus trailing .X.ht2).
  <m1>       Files with #1 mates, paired with files in <m2>.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <m2>       Files with #2 mates, paired with files in <m1>.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <r>        Files with unpaired reads.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <sam>      File for SAM output (default: stdout)

  <m1>, <m2>, <r> can be comma-separated lists (no whitespace) and can be
  specified many times.  E.g. '-U file1.fq,file2.fq -U file3.fq'.

Options (defaults in parentheses):

 Input:
  -q                 query input files are FASTQ .fq/.fastq (default)
  --qseq             query input files are in Illumina's qseq format
  -f                 query input files are (multi-)FASTA .fa/.mfa
  -r                 query input files are raw one-sequence-per-line
  -c                 <m1>, <m2>, <r> are sequences themselves, not files
  -s/--skip <int>    skip the first <int> reads/pairs in the input (none)
  -u/--upto <int>    stop after first <int> reads/pairs (no limit)
  -5/--trim5 <int>   trim <int> bases from 5'/left end of reads (0)
  -3/--trim3 <int>   trim <int> bases from 3'/right end of reads (0)
  --phred33          qualities are Phred+33 (default)
  --phred64          qualities are Phred+64
  --int-quals        qualities encoded as space-delimited integers

 Presets:                 Same as:
   --fast                 --no-repeat-index
   --sensitive            --bowtie2-dp 1 -k 30 --score-min L,0,-0.5
   --very-sensitive       --bowtie2-dp 2 -k 50 --score-min L,0,-1

 Alignment:
  --bowtie2-dp <int> use Bowtie2's dynamic programming alignment algorithm (0) - 0: no dynamic programming, 1: conditional dynamic programming, and 2: unconditional dynamic programming (slowest)
  --n-ceil <func>    func for max # non-A/C/G/Ts permitted in aln (L,0,0.15)
  --ignore-quals     treat all quality values as 30 on Phred scale (off)
  --nofw             do not align forward (original) version of read (off)
  --norc             do not align reverse-complement version of read (off)
  --no-repeat-index  do not use repeat index

 Spliced Alignment:
  --pen-cansplice <int>              penalty for a canonical splice site (0)
  --pen-noncansplice <int>           penalty for a non-canonical splice site (12)
  --pen-canintronlen <func>          penalty for long introns (G,-8,1) with canonical splice sites
  --pen-noncanintronlen <func>       penalty for long introns (G,-8,1) with noncanonical splice sites
  --min-intronlen <int>              minimum intron length (20)
  --max-intronlen <int>              maximum intron length (500000)
  --known-splicesite-infile <path>   provide a list of known splice sites
  --novel-splicesite-outfile <path>  report a list of splice sites
  --novel-splicesite-infile <path>   provide a list of novel splice sites
  --no-temp-splicesite               disable the use of splice sites found
  --no-spliced-alignment             disable spliced alignment
  --rna-strandness <string>          specify strand-specific information (unstranded)
  --tmo                              reports only those alignments within known transcriptome
  --dta                              reports alignments tailored for transcript assemblers
  --dta-cufflinks                    reports alignments tailored specifically for cufflinks
  --avoid-pseudogene                 tries to avoid aligning reads to pseudogenes (experimental option)
  --no-templatelen-adjustment        disables template length adjustment for RNA-seq reads

 Scoring:
  --mp <int>,<int>   max and min penalties for mismatch; lower qual = lower penalty <6,2>
  --sp <int>,<int>   max and min penalties for soft-clipping; lower qual = lower penalty <2,1>
  --no-softclip      no soft-clipping
  --np <int>         penalty for non-A/C/G/Ts in read/ref (1)
  --rdg <int>,<int>  read gap open, extend penalties (5,3)
  --rfg <int>,<int>  reference gap open, extend penalties (5,3)
  --score-min <func> min acceptable alignment score w/r/t read length
                     (L,0.0,-0.2)

 Reporting:
  -k <int>           It searches for at most <int> distinct, primary alignments for each read. Primary alignments mean 
                     alignments whose alignment score is equal to or higher than any other alignments. The search terminates 
                     when it cannot find more distinct valid alignments, or when it finds <int>, whichever happens first. 
                     The alignment score for a paired-end alignment equals the sum of the alignment scores of 
                     the individual mates. Each reported read or pair alignment beyond the first has the SAM ‘secondary’ bit 
                     (which equals 256) set in its FLAGS field. For reads that have more than <int> distinct, 
                     valid alignments, hisat2 does not guarantee that the <int> alignments reported are the best possible 
                     in terms of alignment score. Default: 5 (linear index) or 10 (graph index).
                     Note: HISAT2 is not designed with large values for -k in mind, and when aligning reads to long, 
                     repetitive genomes, large -k could make alignment much slower.
  --max-seeds <int>  HISAT2, like other aligners, uses seed-and-extend approaches. HISAT2 tries to extend seeds to 
                     full-length alignments. In HISAT2, --max-seeds is used to control the maximum number of seeds that 
                     will be extended. For DNA-read alignment (--no-spliced-alignment), HISAT2 extends up to these many seeds
                     and skips the rest of the seeds. For RNA-read alignment, HISAT2 skips extending seeds and reports 
                     no alignments if the number of seeds is larger than the number specified with the option, 
                     to be compatible with previous versions of HISAT2. Large values for --max-seeds may improve alignment 
                     sensitivity, but HISAT2 is not designed with large values for --max-seeds in mind, and when aligning 
                     reads to long, repetitive genomes, large --max-seeds could make alignment much slower. 
                     The default value is the maximum of 5 and the value that comes with -k times 2.
  -a/--all           HISAT2 reports all alignments it can find. Using the option is equivalent to using both --max-seeds 
                     and -k with the maximum value that a 64-bit signed integer can represent (9,223,372,036,854,775,807).
  --repeat           report alignments to repeat sequences directly

 Paired-end:
  -I/--minins <int>  minimum fragment length (0), only valid with --no-spliced-alignment
  -X/--maxins <int>  maximum fragment length (500), only valid with --no-spliced-alignment
  --fr/--rf/--ff     -1, -2 mates align fw/rev, rev/fw, fw/fw (--fr)
  --no-mixed         suppress unpaired alignments for paired reads
  --no-discordant    suppress discordant alignments for paired reads

 Output:
  -t/--time          print wall-clock time taken by search phases
  --un <path>           write unpaired reads that didn't align to <path>
  --al <path>           write unpaired reads that aligned at least once to <path>
  --un-conc <path>      write pairs that didn't align concordantly to <path>
  --al-conc <path>      write pairs that aligned concordantly at least once to <path>
  (Note: for --un, --al, --un-conc, or --al-conc, add '-gz' to the option name, e.g.
  --un-gz <path>, to gzip compress output, or add '-bz2' to bzip2 compress output.)
  --summary-file <path> print alignment summary to this file.
  --new-summary         print alignment summary in a new style, which is more machine-friendly.
  --quiet               print nothing to stderr except serious errors
  --met-file <path>     send metrics to file at <path> (off)
  --met-stderr          send metrics to stderr (off)
  --met <int>           report internal counters & metrics every <int> secs (1)
  --no-head             suppress header lines, i.e. lines starting with @
  --no-sq               suppress @SQ header lines
  --rg-id <text>        set read group id, reflected in @RG line and RG:Z: opt field
  --rg <text>           add <text> ("lab:value") to @RG line of SAM header.
                        Note: @RG line only printed when --rg-id is set.
  --omit-sec-seq        put '*' in SEQ and QUAL fields for secondary alignments.

 Performance:
  -o/--offrate <int> override offrate of index; must be >= index's offrate
  -p/--threads <int> number of alignment threads to launch (1)
  --reorder          force SAM output order to match order of input reads
  --mm               use memory-mapped I/O for index; many 'hisat2's can share

 Other:
  --temp-directory   set the directory for holding temporary files (/tmp)
  --qc-filter        filter out reads that are bad according to QSEQ filter
  --seed <int>       seed for random number generator (0)
  --non-deterministic seed rand. gen. arbitrarily instead of using read attributes
  --remove-chrname   remove 'chr' from reference names in alignment
  --add-chrname      add 'chr' to reference names in alignment 
  --version          print version information and quit
  -h/--help          print this usage message
Error: Encountered internal HISAT2 exception (#1)
Command: /usr/local/bin/hisat2-align-s --wrapper basic-0 --h 
(ERR): hisat2-align exited with value 1
```
## Metadata
- **Skill**: generated

## hisat2_hisat2-build

### Tool Description
The provided text does not contain help information for the tool. It appears to be a fatal error message from a container runtime (Singularity/Apptainer) indicating a failure to build the image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
- **Homepage**: http://daehwankimlab.github.io/hisat2
- **Package**: https://anaconda.org/channels/bioconda/packages/hisat2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/hisat2:2.2.2--h503566f_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3185313555: no space left on device
```

## hisat2_hisat2_extract_splice_sites.py

### Tool Description
The provided text does not contain help information for the tool. It contains a fatal error message from the Singularity/Apptainer container runtime indicating a failure to build the image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
- **Homepage**: http://daehwankimlab.github.io/hisat2
- **Package**: https://anaconda.org/channels/bioconda/packages/hisat2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/hisat2:2.2.2--h503566f_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3925252812: no space left on device
```

## hisat2_hisat2_extract_exons.py

### Tool Description
Extracts exons from a GTF file for use with HISAT2 index building.

### Metadata
- **Docker Image**: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
- **Homepage**: http://daehwankimlab.github.io/hisat2
- **Package**: https://anaconda.org/channels/bioconda/packages/hisat2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/hisat2:2.2.2--h503566f_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1668944134: no space left on device
```

## hisat2_hisat2_extract_snps_haplotypes_UCSC.py

### Tool Description
A script to extract SNPs and haplotypes from UCSC data for HISAT2. Note: The provided help text contains only system error messages and no usage information.

### Metadata
- **Docker Image**: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
- **Homepage**: http://daehwankimlab.github.io/hisat2
- **Package**: https://anaconda.org/channels/bioconda/packages/hisat2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/hisat2:2.2.2--h503566f_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-2698083871: no space left on device
```

## hisat2_hisat-3n-build

### Tool Description
HISAT2 index builder for 3-nucleotide (3N) aware alignment. (Note: The provided help text contains only system error messages and no usage information.)

### Metadata
- **Docker Image**: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
- **Homepage**: http://daehwankimlab.github.io/hisat2
- **Package**: https://anaconda.org/channels/bioconda/packages/hisat2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/hisat2:2.2.2--h503566f_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-2934959072: no space left on device
```

## hisat2_hisat-3n

### Tool Description
The provided text does not contain help information. It is an error log indicating a failure to build or run the container (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
- **Homepage**: http://daehwankimlab.github.io/hisat2
- **Package**: https://anaconda.org/channels/bioconda/packages/hisat2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/hisat2:2.2.2--h503566f_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1511788607: no space left on device
```


## hisat2-build_hisat2-build

### Tool Description
Builds a HISAT2 index from a set of DNA sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
- **Homepage**: https://daehwankimlab.github.io/hisat2
- **Package**: https://anaconda.org/channels/bioconda/packages/hisat2/overview
- **Validation**: PASS

### Original Help Text
```text
hisat2-build: option '--h' is ambiguous; possibilities: '--haplotype' '--help'
HISAT2 version 2.2.3 by Daehwan Kim (infphilo@gmail.com, http://www.ccb.jhu.edu/people/infphilo)
Usage: hisat2-build [options]* <reference_in> <ht2_index_base>
    reference_in            comma-separated list of files with ref sequences
    hisat2_index_base       write ht2 data to files with this dir/basename
Options:
    -c                      reference sequences given on cmd line (as
                            <reference_in>)
    --large-index           force generated index to be 'large', even if ref
                            has fewer than 4 billion nucleotides
    -a/--noauto             disable automatic -p/--bmax/--dcv memory-fitting
    -p <int>                number of threads
    --bmax <int>            max bucket sz for blockwise suffix-array builder
    --bmaxdivn <int>        max bucket sz as divisor of ref len (default: 4)
    --dcv <int>             diff-cover period for blockwise (default: 1024)
    --nodc                  disable diff-cover (algorithm becomes quadratic)
    -r/--noref              don't build .3/.4.ht2 (packed reference) portion
    -3/--justref            just build .3/.4.ht2 (packed reference) portion
    -o/--offrate <int>      SA is sampled every 2^offRate BWT chars (default: 5)
    -t/--ftabchars <int>    # of chars consumed in initial lookup (default: 10)
    --localoffrate <int>    SA (local) is sampled every 2^offRate BWT chars (default: 3)
    --localftabchars <int>  # of chars consumed in initial lookup in a local index (default: 6)
    --snp <path>            SNP file name
    --haplotype <path>      haplotype file name
    --ss <path>             Splice site file name
    --exon <path>           Exon file name
    --repeat-ref <path>     Repeat reference file name
    --repeat-info <path>    Repeat information file name
    --repeat-snp <path>     Repeat snp file name
    --repeat-haplotype <path>   Repeat haplotype file name
    --seed <int>            seed for random number generator
    -q/--quiet              disable verbose output (for debugging)
    -h/--help               print detailed description of tool and its options
    --usage                 print this usage message
    --version               print version information and quit
Error: Encountered internal HISAT2 exception (#1)
Command: hisat2-build --wrapper basic-0 hisat2-build --h
```

## hisat2-build

### Tool Description
Build HISAT2 index from reference sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
- **Homepage**: https://github.com/DaehwanKimLab/hisat2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
hisat2-build: option '--h' is ambiguous; possibilities: '--haplotype' '--help'
HISAT2 version 2.2.3 by Daehwan Kim (infphilo@gmail.com, http://www.ccb.jhu.edu/people/infphilo)
Usage: hisat2-build [options]* <reference_in> <ht2_index_base>
    reference_in            comma-separated list of files with ref sequences
    hisat2_index_base       write ht2 data to files with this dir/basename
Options:
    -c                      reference sequences given on cmd line (as
                            <reference_in>)
    --large-index           force generated index to be 'large', even if ref
                            has fewer than 4 billion nucleotides
    -a/--noauto             disable automatic -p/--bmax/--dcv memory-fitting
    -p <int>                number of threads
    --bmax <int>            max bucket sz for blockwise suffix-array builder
    --bmaxdivn <int>        max bucket sz as divisor of ref len (default: 4)
    --dcv <int>             diff-cover period for blockwise (default: 1024)
    --nodc                  disable diff-cover (algorithm becomes quadratic)
    -r/--noref              don't build .3/.4.ht2 (packed reference) portion
    -3/--justref            just build .3/.4.ht2 (packed reference) portion
    -o/--offrate <int>      SA is sampled every 2^offRate BWT chars (default: 5)
    -t/--ftabchars <int>    # of chars consumed in initial lookup (default: 10)
    --localoffrate <int>    SA (local) is sampled every 2^offRate BWT chars (default: 3)
    --localftabchars <int>  # of chars consumed in initial lookup in a local index (default: 6)
    --snp <path>            SNP file name
    --haplotype <path>      haplotype file name
    --ss <path>             Splice site file name
    --exon <path>           Exon file name
    --repeat-ref <path>     Repeat reference file name
    --repeat-info <path>    Repeat information file name
    --repeat-snp <path>     Repeat snp file name
    --repeat-haplotype <path>   Repeat haplotype file name
    --seed <int>            seed for random number generator
    -q/--quiet              disable verbose output (for debugging)
    -h/--help               print detailed description of tool and its options
    --usage                 print this usage message
    --version               print version information and quit
Error: Encountered internal HISAT2 exception (#1)
Command: hisat2-build --wrapper basic-0 --h
```

## hisat2_extract_exons.py

### Tool Description
Extract exons from a GTF file

### Metadata
- **Docker Image**: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
- **Homepage**: https://daehwankimlab.github.io/hisat2
- **Package**: https://anaconda.org/channels/bioconda/packages/hisat2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hisat2_extract_exons.py [-h] [-v] [gtf_file]

Extract exons from a GTF file

positional arguments:
  gtf_file       input GTF file (use "-" for stdin)

options:
  -h, --help     show this help message and exit
  -v, --verbose  also print some statistics to stderr
```
