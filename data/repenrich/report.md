# repenrich CWL Generation Report

## repenrich_RepEnrich_setup.py

### Tool Description
Part I: Prepartion of repetive element psuedogenomes and repetive element
bamfiles. This script prepares the annotation used by downstream applications
to analyze for repetitive element enrichment. For this script to run properly
bowtie must be loaded. The repeat element psuedogenomes are prepared in order
to analyze reads that map to multiple locations of the genome. The repeat
element bamfiles are prepared in order to use a region sorter to analyze reads
that map to a single location of the genome.You will 1) annotation_file: The
repetitive element annotation file downloaded from RepeatMasker.org database
for your organism of interest. 2) genomefasta: Your genome of interest in
fasta format, 3)setup_folder: a folder to contain repeat element setup files
command-line usage EXAMPLE: python master_setup.py
/users/nneretti/data/annotation/mm9/mm9_repeatmasker.txt
/users/nneretti/data/annotation/mm9/mm9.fa
/users/nneretti/data/annotation/mm9/setup_folder

### Metadata
- **Docker Image**: quay.io/biocontainers/repenrich:1.2--py27_1
- **Homepage**: https://github.com/nskvir/RepEnrich
- **Package**: https://anaconda.org/channels/bioconda/packages/repenrich/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/repenrich/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nskvir/RepEnrich
- **Stars**: N/A
### Original Help Text
```text
usage: getargs_genome_maker.py [-h] [--version]
                               [--nfragmentsfile1 nfragmentsfile1]
                               [--gaplength gaplength]
                               [--flankinglength flankinglength]
                               [--is_bed is_bed]
                               annotation_file genomefasta setup_folder

Part I: Prepartion of repetive element psuedogenomes and repetive element
bamfiles. This script prepares the annotation used by downstream applications
to analyze for repetitive element enrichment. For this script to run properly
bowtie must be loaded. The repeat element psuedogenomes are prepared in order
to analyze reads that map to multiple locations of the genome. The repeat
element bamfiles are prepared in order to use a region sorter to analyze reads
that map to a single location of the genome.You will 1) annotation_file: The
repetitive element annotation file downloaded from RepeatMasker.org database
for your organism of interest. 2) genomefasta: Your genome of interest in
fasta format, 3)setup_folder: a folder to contain repeat element setup files
command-line usage EXAMPLE: python master_setup.py
/users/nneretti/data/annotation/mm9/mm9_repeatmasker.txt
/users/nneretti/data/annotation/mm9/mm9.fa
/users/nneretti/data/annotation/mm9/setup_folder

positional arguments:
  annotation_file       List annotation file. The annotation file contains the
                        repeat masker annotation for the genome of interest
                        and may be downloaded at RepeatMasker.org Example
                        /data/annotation/mm9/mm9.fa.out
  genomefasta           File name and path for genome of interest in fasta
                        format. Example /data/annotation/mm9/mm9.fa
  setup_folder          List folder to contain bamfiles for repeats and repeat
                        element psuedogenomes. Example
                        /data/annotation/mm9/setup

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --nfragmentsfile1 nfragmentsfile1
                        Output location of a description file that saves the
                        number of fragments processed per repname. Default
                        ./repnames_nfragments.txt
  --gaplength gaplength
                        Length of the spacer used to build repeat
                        psuedogeneomes. Default 200
  --flankinglength flankinglength
                        Length of the flanking region adjacent to the repeat
                        element that is used to build repeat psuedogeneomes.
                        The flanking length should be set according to the
                        length of your reads. Default 25
  --is_bed is_bed       Is the annotation file a bed file. This is also a
                        compatible format. The file needs to be a tab
                        seperated bed with optional fields. Ex. format chr
                        start end Name_element class family. The class and
                        family should identical to name_element if not
                        applicable. Default FALSE change to TRUE
```


## repenrich_bowtie

### Tool Description
Alignments for short DNA sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/repenrich:1.2--py27_1
- **Homepage**: https://github.com/nskvir/RepEnrich
- **Package**: https://anaconda.org/channels/bioconda/packages/repenrich/overview
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


## repenrich_samtools

### Tool Description
Tools for alignments in the SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/repenrich:1.2--py27_1
- **Homepage**: https://github.com/nskvir/RepEnrich
- **Package**: https://anaconda.org/channels/bioconda/packages/repenrich/overview
- **Validation**: PASS

### Original Help Text
```text
Program: samtools (Tools for alignments in the SAM format)
Version: 1.8 (using htslib 1.8)

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


## Metadata
- **Skill**: generated
