# bsmap CWL Generation Report

## bsmap

### Tool Description
BSMAP is a short-read alignment program for whole-genome bisulfite sequencing.

### Metadata
- **Docker Image**: quay.io/biocontainers/bsmap:2.90--py27_0
- **Homepage**: https://code.google.com/archive/p/bsmap/
- **Package**: https://anaconda.org/channels/bioconda/packages/bsmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bsmap/overview
- **Total Downloads**: 10.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage:	bsmap [options]
       -a  <str>   query a file, FASTA/FASTQ/BAM format
       -d  <str>   reference sequences file, FASTA format
       -o  <str>   output alignment file, BSP/SAM/BAM format, if omitted, the output will be written to STDOUT in SAM format.

  Options for alignment:
       -s  <int>   seed size, default=16(WGBS mode), 12(RRBS mode). min=8, max=16.
       -v  <float> if this value is between 0 and 1, it's interpreted as the mismatch rate w.r.t to the read length.
                   otherwise it's interpreted as the maximum number of mismatches allowed on a read, <=15.
                   example: -v 5 (max #mismatches = 5), -v 0.1 (max #mismatches = read_length * 10%)
                   default=0.08.
       -g  <int>   gap size, BSMAP only allow 1 continuous gap (insert or deletion) with up to 3 nucleotides
                   default=0
       -w  <int>   maximum number of equal best hits to count, <=1000
       -3          using 3-nucleotide mapping approach
       -B  <int>   start from the Nth read or read pair, default: 1
       -E  <int>   end at the Nth read or read pair, default: 4,294,967,295
       -I  <int>   index interval, default=4
       -k  <float> set the cut-off ratio for over-represented kmers, default=5e-07
                   example: -k 1e-6 means the top 0.0001% over-represented kmer will be skipped in alignment
       -p  <int>   number of processors to use, default=8
       -D  <str>   activating RRBS mapping mode and set restriction enzyme digestion sites. 
                   digestion position marked by '-', example: -D C-CGG for MspI digestion.
                   default: none (whole genome shotgun bisulfite mapping mode)
       -S  <int>   seed for random number generation used in selecting multiple hits
                   other seed values generate pseudo random number based on read index number, to allow reproducible mapping results. 
                   default=0. (get seed from system clock, mapping results not resproducible.)
       -n  [0,1]   set mapping strand information. default: 0
                   -n 0: only map to 2 forward strands, i.e. BSW(++) and BSC(-+), 
                   for PE sequencing, map read#1 to ++ and -+, read#2 to +- and --.
                   -n 1: map SE or PE reads to all 4 strands, i.e. ++, +-, -+, -- 
       -M  <str>   set alignment information for the additional nucleotide transition. 
                   <str> is in the form of two different nucleotides N1N2, 
                   indicating N1 in the reads could be mapped to N2 in the reference sequences.
                   default: -M TC, corresponds to C=>U(T) transition in bisulfite conversion. 
                   example: -M GA could be used to detect A=>I(G) transition in RNA editing. 

  Options for trimming:
       -q  <int>   quality threshold in trimming, 0-40, default=0 (no trim)
       -z  <int>   base quality, default=33 [Illumina is using 64, Sanger Institute is using 33]
       -f  <int>   filter low-quality reads containing >n Ns, default=5
       -A  <str>   3-end adapter sequence, default: none (no trim)
       -L  <int>   map the first N nucleotides of the read, default:160 (map the whole read).

  Options for reporting:
       -r  [0,1,2] how to report repeat hits, 0=none(unique hit/pair); 1=random one; 2=all(slow), default:1.
       -R          print corresponding reference sequences in SAM output, default=off
       -u          report unmapped reads, default=off
       -H          do not print header information in SAM format output
       -V  [0,1,2] verbose level: 0=no message displayed (quiet mode); 
                   1=major message (default); 2=detailed message.

  Options for pair-end alignment:
       -b  <str>   query b file
       -m  <int>   minimal insert size allowed, default=28
       -x  <int>   maximal insert size allowed, default=1000

       -h          help
```

