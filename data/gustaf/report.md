# gustaf CWL Generation Report

## gustaf

### Tool Description
GUSTAF uses SeqAns STELLAR to find splits as local matches on different strands or chromosomes. Criteria and penalties to chain these matches can be specified. Output file contains the breakpoints along the best chain.

### Metadata
- **Docker Image**: quay.io/biocontainers/gustaf:1.0.10--h8ecad89_1
- **Homepage**: https://github.com/seqan/seqan/tree/master/apps/gustaf/README.rst
- **Package**: https://anaconda.org/channels/bioconda/packages/gustaf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gustaf/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-08-12
- **GitHub**: https://github.com/seqan/seqan
- **Stars**: N/A
### Original Help Text
```text
gustaf - Gustaf - Generic mUlti-SpliT Alignment Finder: Tool for split-read mapping allowing multiple splits.
=============================================================================================================

SYNOPSIS
    gustaf [OPTIONS] <GENOME FASTA FILE> <READ FASTA FILE>
    gustaf [OPTIONS] <GENOME FASTA FILE> <READ FASTA FILE> <READ FASTA FILE 2>

DESCRIPTION
    GUSTAF uses SeqAns STELLAR to find splits as local matches on different
    strands or chromosomes. Criteria and penalties to chain these matches can
    be specified. Output file contains the breakpoints along the best chain.

    The genome file is used as database input, the read file as query input.

    All STELLAR options are supported. See STELLAR documentation for STELLAR
    parameters and options.

    (c) 2011-2025 by Kathrin Trappe

REQUIRED ARGUMENTS
    FASTA_FILE_1 INPUT_FILE
          Valid filetypes are: .fq, .fastq, .fasta, and .fa.
    FASTA_FILE_2 List of INPUT_FILE's
          Either one (single-end) or two (paired-end) read files. Valid
          filetypes are: .fq, .fastq, .fasta, and .fa.

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.

  Main Options:
    -tp, --transPen INTEGER
          Interchromosomal translocation penalty Default: 5.
    -ip, --invPen INTEGER
          Inversion penalty Default: 5.
    -op, --orderPen INTEGER
          Intrachromosomal order change penalty Default: 0.
    -oth, --overlapThresh DOUBLE
          Allowed overlap between matches Default: 0.5.
    -gth, --gapThresh INTEGER
          Allowed gap length between matches, default value corresponse to
          expected size of microindels (5 bp) Default: 5.
    -ith, --initGapThresh INTEGER
          Allowed initial or ending gap length at begin and end of read with
          no breakpoint (e.g. due to sequencing errors at the end) Default:
          15.
    -bth, --breakendThresh INTEGER
          Allowed initial or ending gap length at begin and end of read that
          creates a breakend/breakpoint (e.g. for reads extending into
          insertions) Default: 30.
    -tth, --tandemThresh INTEGER
          Minimal length of (small) insertion/duplication with double overlap
          to be considered tandem repeat Default: 50.
    -pth, --breakpoint-pos-range INTEGER
          Allowed difference in breakpoint position Default: 5.
    -cbp, --complex-breakpoints
          Disable inferring complex SVs
    -st, --support INTEGER
          Number of supporting reads Default: 2.
    -mst, --mate-support INTEGER
          Number of supporting concordant mates Default: 2.
    -ll, --library-size INTEGER
          Library size of paired-end reads
    -le, --library-error INTEGER
          Library error (sd) of paired-end reads
    -rc, --revcompl
          Disable reverse complementing second mate pair input file.

  Input Options:
    -m, --matchfile INPUT_FILE
          File of (stellar) matches Valid filetypes are: .gff and .GFF.

  Output Options:
    -gff, --gffOut OUTPUT_FILE
          Name of gff breakpoint output file. Valid filetypes are: .txt and
          .gff. Default: breakpoints.gff.
    -vcf, --vcfOut OUTPUT_FILE
          Name of vcf breakpoint output file. Valid filetypes are: .vcf and
          .txt. Default: breakpoints.vcf.
    -j, --jobName STRING
          Job/Queue name Default: .
    -do, --dots
          Enable graph output in dot format

  Parallelization Options:
    -nth, --numThreads INTEGER
          Number of threads for parallelization of I/O. Default: 1.

  Main Options:
    -e, --epsilon DOUBLE
          Maximal error rate (max 0.25). In range [0.0000001..0.25]. Default:
          0.05.
    -l, --minLength INTEGER
          Minimal length of epsilon-matches. In range [0..inf]. Default: 100.
    -f, --forward
          Search only in forward strand of database.
    -r, --reverse
          Search only in reverse complement of database.
    -a, --alphabet STRING
          Alphabet type of input sequences (dna, rna, dna5, rna5, protein,
          char). One of dna, dna5, rna, rna5, protein, and char.
    -v, --verbose
          Set verbosity mode.

  Filtering Options:
    -k, --kmer INTEGER
          Length of the q-grams (max 32). In range [1..32].
    -rp, --repeatPeriod INTEGER
          Maximal period of low complexity repeats to be filtered. Default: 1.
    -rl, --repeatLength INTEGER
          Minimal length of low complexity repeats to be filtered. Default:
          1000.
    -c, --abundanceCut DOUBLE
          k-mer overabundance cut ratio. In range [0..1]. Default: 1.

  Verification Options:
    -x, --xDrop DOUBLE
          Maximal x-drop for extension. Default: 5.
    -vs, --verification STRING
          Verification strategy: exact or bestLocal or bandedGlobal One of
          exact, bestLocal, and bandedGlobal. Default: exact.
    -dt, --disableThresh INTEGER
          Maximal number of verified matches before disabling verification for
          one query sequence (default infinity). In range [0..inf].
    -n, --numMatches INTEGER
          Maximal number of kept matches per query and database. If STELLAR
          finds more matches, only the longest ones are kept. Default: 50.
    -s, --sortThresh INTEGER
          Number of matches triggering removal of duplicates. Choose a smaller
          value for saving space. Default: 500.

VERSION
    Last update: August 2014
    gustaf version: 1.0.0
    SeqAn version: 2.5.1
```


## Metadata
- **Skill**: generated
