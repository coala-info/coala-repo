# svviz CWL Generation Report

## svviz

### Tool Description
svviz version 1.6.2

### Metadata
- **Docker Image**: quay.io/biocontainers/svviz:1.6.2--py27h24bf2e0_0
- **Homepage**: https://github.com/svviz/svviz
- **Package**: https://anaconda.org/channels/bioconda/packages/svviz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svviz/overview
- **Total Downloads**: 18.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/svviz/svviz
- **Stars**: N/A
### Original Help Text
```text
usage: svviz [options] [demo] [ref breakpoint...] [ref vcf]

svviz version 1.6.2

positional arguments:
  ref                   reference fasta file (a .faidx index file will be created if it doesn't exist so you need 
                        write permissions for this directory)
  breakpoints           information about the breakpoint to be analyzed; see below for information

optional arguments:
  -h, --help            show this help message and exit

required parameters:
  -b BAM, --bam BAM     sorted, indexed bam file containing reads of interest to plot; can be specified multiple 
                        times to load multiple samples

input parameters:
  -t TYPE, --type TYPE  event type: either del[etion], ins[ertion], inv[ersion], mei (mobile element insertion), 
                        tra[nslocation], largedeletion (ldel), breakend (bkend) or batch (for reading variants  
                        from a VCF file in batch mode)
  -A ANNOTATIONS, --annotations ANNOTATIONS
                        bed or gtf file containing annotations to plot; will be compressed and indexed using 
                        samtools tabix in place if needed (can specify multiple annotations files)
  --fasta FASTA         An additional indexable fasta file specifying insertion sequences (eg mobile element 
                        sequences)
  -q MAPQ, --min-mapq MAPQ
                        minimum mapping quality for reads (default: 0)
  --pair-min-mapq PAIR_MAPQ
                        include only read pairs where at least one read end both exceeds PAIR_MAPQ and 
                        falls near the variant being analyzed (default: 0)
  --max-multimapping-similarity MAX_SIMILARITY
                        maximum ratio between best and second-best alignment scores within visualization 
                        region in order to retain read (default: 0.95)
  -a QUALITY, --aln-quality QUALITY
                        minimum score of the Smith-Waterman alignment against the ref or alt allele in order to be 
                        considered (multiplied by 2)
  --aln-score-delta DELTA
                        minimum difference in scores between ref alignment score and alt alignment score 
                        to be assigned to one allele (use an integer to specify a hard score difference 
                        threshold, or a float to specify a score difference relative to the read size; 
                        default: 2)
  --include-supplementary
                        include supplementary alignments (ie, those with the 0x800 bit set in the bam flags); 
                        default: false
  --fast                implements some optimizations designed to find exact sequence matches quickly;
                        will substantially increase speed on Illumina data but may result in some inexact
                        results; default: false
  --sample-reads SAMPLE_READS
                        use at most this many reads (pairs), sampling randomly if need be, useful 
                        when running in batch mode (default: use all reads)
  --max-reads MAX_READS
                        maximum number of reads allowed, totaled across all samples, useful when running in batch 
                        mode (default: unlimited)
  --max-size MAX_SIZE   maximum event size allowed, totaled across all chromosome parts in bp; if either the ref 
                        allele or alt allele exceeds this size, it will be skipped (default: unlimited)
  --max-deletion-size MAX_DELETION_SIZE
                        deletion size above which the deletion is analyzed in breakend mode (default: don't 
                        convert to breakend mode)

interface parameters:
  -v, --version         show svviz version number and exit
  -p PORT, --port PORT  define a port to use for the web browser (default: random port)
  --processes PROCESSES
                        how many processes to use for read realignment (default: use all available cores)
  --no-web              don't show the web interface
  --save-reads OUT_BAM_PATH
                        save relevant reads to this file (bam)
  --verbose VERBOSE     how verbose the progress and logging should be
  -e EXPORT, --export EXPORT
                        export view to file; in single variant-mode, the exported file format is determined from 
                        the filename extension unless --format is specified; in batch mode, this should be the name 
                        of a directory into which to save the files (use --format to set format); setting --export 
                        automatically sets --no-web
  --format FORMAT       file export format, either svg, png or 
                        pdf; by default, this is pdf (batch mode) or automatically identified from the file 
                        extension of --export
  -O, --open-exported   automatically open the exported file
  --converter CONVERTER
                        which program should be used to convert the output into PDF or PNG; choose from [webkitToPDF, 
                        librsvg, inkscape] (default: auto)
  --thicker-lines       Reads are shown with thicker lines, potentially overlapping one another, but increasing 
                        contrast when zoomed out
  --context CONTEXT     Number of additional nucleotides of genomic context to either side of the visualization 
                        (useful for showing nearby annotations)
  -f, --flanks          Show reads in regions flanking the structural variant; these reads do not 
                        contribute to the ref or alt allele read counts (default: false)
  --skip-cigar          Don't color mismatches, insertions and deletions
  --dotplots            generate dotplots to show sequence homology within the aligned region; requires some 
                        additional optional python libraries (scipy and PIL) and may take several minutes for 
                        longer variants
  --export-insert-sizes
                        plot the insert size distributions for each sample, for each event
  --summary SUMMARY_FILE
                        save summary statistics to this (tab-delimited) file

presets:
  --lenient             lowers the minimum alignment quality, showing reads even when breakpoints are only 
                        approximately correct, or reads of lower quality (eg PacBio); and requires a larger 
                        difference in alignment scores in order to assign a read to an allele

Breakpoint formats:
Format for deletion (-t del) breakpoints is '<chrom> <start> <end>'
Format for largedeletion (-t ldel) breakpoints is '<chrom> <start> <end>'
Format for insertion (-t ins) breakpoints is '<chrom> <pos> [end] <seq>'; 
  specify 'end' to create a compound deletion-insertion, otherwise insertion 
  position is before 'pos'
Format for inversion (-t inv) breakpoints is '<chrom> <start> <end>'
Format for mobile element insertion (-t mei) is '<mobile_elements.fasta> 
  <chrom> <pos> <ME name> [ME strand [start [end]]]'
Format for a translocation (-t tra) is 'chrom1 start1 chrom2 start2 orientation'
Format for a breakend (-t bkend) is 'chrom1 start1 strand1 chrom2 start2 strand2'

For an example, run 'svviz demo'.

Submit bug reports and feature requests at
https://github.com/svviz/svviz/issues
```

