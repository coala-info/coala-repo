# emirge CWL Generation Report

## emirge_emirge_makedb.py

### Tool Description
emirge_makedb.py creates a reference database and the necessay indices for use by EMIRGE from an rRNA reference database. Without extra parameters, emirge_makedb.py will 1) download the most recent SILVA SSU database, 2) filter it by sequence length, 3) cluster at 97% sequence identity, 4) replace ambiguous bases with random characters and 5) create a bowtie index.

### Metadata
- **Docker Image**: quay.io/biocontainers/emirge:0.61.1--py27_1
- **Homepage**: https://github.com/csmiller/EMIRGE
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/emirge/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/csmiller/EMIRGE
- **Stars**: N/A
### Original Help Text
```text
Usage: emirge_makedb.py [OPTIONS]

emirge_makedb.py creates a reference database and the necessay indices for use by
EMIRGE from an rRNA reference database. Without extra parameters, emirge_makedb.py
will 1) download the most recent SILVA SSU database, 2) filter it by sequence
length, 3) cluster at 97% sequence identity, 4) replace ambiguous bases
with random characters and 5) create a bowtie index.

Requires vsearch executable can be found in path for clustering.
https://github.com/torognes/vsearch

Requires bowtie-build (from bowtie version 1) can be found in path
    


Options:
  -h, --help            show this help message and exit
  -g [SSU|LSU], --gene=[SSU|LSU]
                        build database from this gene (SSU=Small Subunit rRNA;
                        LSU=Large Subunit rRNA) default = SSU
  -p THREADS, --threads=THREADS
                        number of threads to use for vsearch clustering of
                        database (default = use all available)
  -t DIR, --tmpdir=DIR  working directory for temporary files (default = /tmp)
  -r N, --release=N     SILVA release number (default: current SILVA release)
  -m LEN, --min-len=LEN
                        minimum reference sequence length (default = 1200)
  -M LEN, --max-len=LEN
                        maximum reference sequence length (default = 2000)
  -i FLOAT, --id=FLOAT  Cluster at this fractional identity level (default =
                        0.97)
  -k, --keep            keep intermediary files (default: do not keep)
  -V FILE, --vsearch=FILE
                        path to vsearch binary (default: look in $PATH)
  -B FILE, --bowtie-build=FILE
                        path to bowtie-build binary (default: look in $PATH)
  --silva-license-accepted
                        I have read and accepted the SILVA license.
```


## emirge_bowtie-build

### Tool Description
Builds a Bowtie index from a reference sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/emirge:0.61.1--py27_1
- **Homepage**: https://github.com/csmiller/EMIRGE
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
No input sequence or sequence file specified!
Usage: bowtie-build [options]* <reference_in> <ebwt_outfile_base>
    reference_in            comma-separated list of files with ref sequences
    ebwt_outfile_base       write Ebwt data to files with this dir/basename
Options:
    -f                      reference files are Fasta (default)
    -c                      reference sequences given on cmd line (as <seq_in>)
    --large-index           force generated index to be 'large', even if ref
                            has fewer than 4 billion nucleotides
    -C/--color              build a colorspace index
    -a/--noauto             disable automatic -p/--bmax/--dcv memory-fitting
    -p/--packed             use packed strings internally; slower, uses less mem
    --bmax <int>            max bucket sz for blockwise suffix-array builder
    --bmaxdivn <int>        max bucket sz as divisor of ref len (default: 4)
    --dcv <int>             diff-cover period for blockwise (default: 1024)
    --nodc                  disable diff-cover (algorithm becomes quadratic)
    -r/--noref              don't build .3/.4.ebwt (packed reference) portion
    -3/--justref            just build .3/.4.ebwt (packed reference) portion
    -o/--offrate <int>      SA is sampled every 2^offRate BWT chars (default: 5)
    -t/--ftabchars <int>    # of chars consumed in initial lookup (default: 10)
    --threads <int>         # of threads
    --ntoa                  convert Ns in reference to As
    --seed <int>            seed for random number generator
    -q/--quiet              verbose output (for debugging)
    -h/--help               print detailed description of tool and its options
    --usage                 print this usage message
    --version               print version information and quit
```


## emirge_emirge_rename_fasta.py

### Tool Description
Rewrites an emirge fasta file to include proper sequence names and prior probabilities (abundance estimates) in the record headers, and sorts the sequences from most to least abundant

### Metadata
- **Docker Image**: quay.io/biocontainers/emirge:0.61.1--py27_1
- **Homepage**: https://github.com/csmiller/EMIRGE
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: emirge_rename_fasta.py [options] <iter.DIR> > renamed.fasta

emirge_rename_fasta.py rewrites an emirge fasta file to include proper
sequence names and prior probabilities (abundance estimates) in the
record headers, and sorts the sequences from most to least abundant

iter.DIR is one of the iteration directories created by emirge (for
example: emirge_working_dir/iter.40).  If no iter.DIR is given,
emirge_rename_fasta.py assumes that iter.DIR is the current working
directory.

Note that, with default options, bases with no read support are
labeled 'N', and terminal N's are trimmed

Options:
  -h, --help            show this help message and exit
  -p PROB_MIN, --prob_min=PROB_MIN
                        Only include sequences in output with prior
                        probability above PROB_MIN (Default: include all
                        sequences)
  -r RECORD_PREFIX, --record_prefix=RECORD_PREFIX
                        Add the specified prefix to each fasta record title
  -n, --no_N            Don't change bases with no read support to N.
                        Caution: these bases are not supported by reads in the
                        input data, but will usually be from a closely related
                        sequence.
  -t, --no_trim_N       Don't trim off N bases with no read support from ends
                        of sequences.  Ignored if --no_N is also passed
```


## emirge_bowtie

### Tool Description
Alignments for short DNA sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/emirge:0.61.1--py27_1
- **Homepage**: https://github.com/csmiller/EMIRGE
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
No index, query, or output file specified!
Usage: 
bowtie [options]* <ebwt> {-1 <m1> -2 <m2> | --12 <r> | --interleaved <i> | <s>} [<hit>]

  <m1>    Comma-separated list of files containing upstream mates (or the
          sequences themselves, if -c is set) paired with mates in <m2>
  <m2>    Comma-separated list of files containing downstream mates (or the
          sequences themselves if -c is set) paired with mates in <m1>
  <r>     Comma-separated list of files containing Crossbow-style reads.  Can be
          a mixture of paired and unpaired.  Specify "-" for stdin.
  <i>     Files with interleaved paired-end FASTQ reads.
  <s>     Comma-separated list of files containing unpaired reads, or the
          sequences themselves, if -c is set.  Specify "-" for stdin.
  <hit>   File to write hits to (default: stdout)
Input:
  -q                 query input files are FASTQ .fq/.fastq (default)
  -f                 query input files are (multi-)FASTA .fa/.mfa
  -r                 query input files are raw one-sequence-per-line
  -c                 query sequences given on cmd line (as <mates>, <singles>)
  -C                 reads and index are in colorspace
  -Q/--quals <file>  QV file(s) corresponding to CSFASTA inputs; use with -f -C
  --Q1/--Q2 <file>   same as -Q, but for mate files 1 and 2 respectively
  -s/--skip <int>    skip the first <int> reads/pairs in the input
  -u/--qupto <int>   stop after first <int> reads/pairs (excl. skipped reads)
  -5/--trim5 <int>   trim <int> bases from 5' (left) end of reads
  -3/--trim3 <int>   trim <int> bases from 3' (right) end of reads
  --phred33-quals    input quals are Phred+33 (default)
  --phred64-quals    input quals are Phred+64 (same as --solexa1.3-quals)
  --solexa-quals     input quals are from GA Pipeline ver. < 1.3
  --solexa1.3-quals  input quals are from GA Pipeline ver. >= 1.3
  --integer-quals    qualities are given as space-separated integers (not ASCII)
  --large-index      force usage of a 'large' index, even if a small one is present
Alignment:
  -v <int>           report end-to-end hits w/ <=v mismatches; ignore qualities
    or
  -n/--seedmms <int> max mismatches in seed (can be 0-3, default: -n 2)
  -e/--maqerr <int>  max sum of mismatch quals across alignment for -n (def: 70)
  -l/--seedlen <int> seed length for -n (default: 28)
  --nomaqround       disable Maq-like quality rounding for -n (nearest 10 <= 30)
  -I/--minins <int>  minimum insert size for paired-end alignment (default: 0)
  -X/--maxins <int>  maximum insert size for paired-end alignment (default: 250)
  --fr/--rf/--ff     -1, -2 mates align fw/rev, rev/fw, fw/fw (default: --fr)
  --nofw/--norc      do not align to forward/reverse-complement reference strand
  --maxbts <int>     max # backtracks for -n 2/3 (default: 125, 800 for --best)
  --pairtries <int>  max # attempts to find mate for anchor hit (default: 100)
  -y/--tryhard       try hard to find valid alignments, at the expense of speed
  --chunkmbs <int>   max megabytes of RAM for best-first search frames (def: 64)
 --reads-per-batch   # of reads to read from input file at once (default: 16)
Reporting:
  -k <int>           report up to <int> good alignments per read (default: 1)
  -a/--all           report all alignments per read (much slower than low -k)
  -m <int>           suppress all alignments if > <int> exist (def: no limit)
  -M <int>           like -m, but reports 1 random hit (MAPQ=0); requires --best
  --best             hits guaranteed best stratum; ties broken by quality
  --strata           hits in sub-optimal strata aren't reported (requires --best)
Output:
  -t/--time          print wall-clock time taken by search phases
  -B/--offbase <int> leftmost ref offset = <int> in bowtie output (default: 0)
  --quiet            print nothing but the alignments
  --refidx           refer to ref. seqs by 0-based index rather than name
  --al <fname>       write aligned reads/pairs to file(s) <fname>
  --un <fname>       write unaligned reads/pairs to file(s) <fname>
  --no-unal          suppress SAM records for unaligned reads
  --max <fname>      write reads/pairs over -m limit to file(s) <fname>
  --suppress <cols>  suppresses given columns (comma-delim'ed) in default output
  --fullref          write entire ref name (default: only up to 1st space)
Colorspace:
  --snpphred <int>   Phred penalty for SNP when decoding colorspace (def: 30)
     or
  --snpfrac <dec>    approx. fraction of SNP bases (e.g. 0.001); sets --snpphred
  --col-cseq         print aligned colorspace seqs as colors, not decoded bases
  --col-cqual        print original colorspace quals, not decoded quals
  --col-keepends     keep nucleotides at extreme ends of decoded alignment
SAM:
  -S/--sam           write hits in SAM format
  --mapq <int>       default mapping quality (MAPQ) to print for SAM alignments
  --sam-nohead       supppress header lines (starting with @) for SAM output
  --sam-nosq         supppress @SQ header lines for SAM output
  --sam-RG <text>    add <text> (usually "lab=value") to @RG line of SAM header
Performance:
  -o/--offrate <int> override offrate of index; must be >= index's offrate
  -p/--threads <int> number of alignment threads to launch (default: 1)
  --mm               use memory-mapped I/O for index; many 'bowtie's can share
  --shmem            use shared mem for index; many 'bowtie's can share
Other:
  --seed <int>       seed for random number generator
  --verbose          verbose output (for debugging)
  --version          print version information and quit
  -h/--help          print this usage message
```


## emirge_samtools

### Tool Description
Tools for alignments in the SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/emirge:0.61.1--py27_1
- **Homepage**: https://github.com/csmiller/EMIRGE
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Program: samtools (Tools for alignments in the SAM format)
Version: 1.7 (using htslib 1.7)

Usage:   samtools <command> [options]

Commands:
  -- Indexing
     dict           create a sequence dictionary file
     faidx          index/extract FASTA
     index          index alignment

  -- Editing
     calmd          recalculate MD/NM tags and '=' bases
     fixmate        fix mate information
     reheader       replace BAM header
     targetcut      cut fosmid regions (for fosmid pool only)
     addreplacerg   adds or replaces RG tags
     markdup        mark duplicates

  -- File operations
     collate        shuffle and group alignments by name
     cat            concatenate BAMs
     merge          merge sorted alignments
     mpileup        multi-way pileup
     sort           sort alignment file
     split          splits a file by read group
     quickcheck     quickly check if SAM/BAM/CRAM file appears intact
     fastq          converts a BAM to a FASTQ
     fasta          converts a BAM to a FASTA

  -- Statistics
     bedcov         read depth per BED region
     depth          compute the depth
     flagstat       simple stats
     idxstats       BAM index stats
     phase          phase heterozygotes
     stats          generate stats (former bamcheck)

  -- Viewing
     flags          explain BAM flags
     tview          text alignment viewer
     view           SAM<->BAM<->CRAM conversion
     depad          convert padded BAM to unpadded BAM
```

