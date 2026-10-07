# conduit-assembler CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| conduit-assembler_conduit_hybrid | PASS |  |

## conduit-assembler_conduit_hybrid

### Tool Description
CONsensus Decomposition Utility In Transcriptome-assembly: hybrid mode corrects nanopore scaffold reads, separated by gene cluster, with Illumina reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
- **Homepage**: https://github.com/NatPRoach/conduit
- **Package**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conduit-assembler/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NatPRoach/conduit
- **Stars**: N/A
### Original Help Text
```text
CONDUIT - CONsensus Decomposition Utility In Transcriptome-assembly:
CONDUIT Version 0.1.2 by Nathan Roach ( nroach2@jhu.edu, https://github.com/NatPRoach/conduit/ )
Usage:
  ./conduit hybrid [options] <clustersDirectory> {-1 <m1> -2 <m2> | -U <r> | --interleaved <i> | -b <bam>}
  <clustersDirectory>   Directory containing the .fasta/.fa or .fastq/.fq files of reads separated by gene cluster
                         NOTE: .gz support coming for nanopore scaffold data, but is not an option at this time

  Illumina data is aligned with Bowtie2, therefore Illumina data is provided in the same format as Bowtie2, namely:

    <m1>                   Files with #1 mates, paired with files in <m2>
                           Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
    <m2>                   Files with #2 mates, paired with files in <m1>
                           Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
    <r>                    Files with unpaired reads
                           Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
    <i>                    File with interleaved paired-end FASTQ/FASTA reads
                           Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
    <bam>                  Files are unaligned BAM sorted by read name.

  <m1>, <m2>, <r> can be comma-separated lists (no whitespace) and can be specified many times.
  E.g. '-U file1.fq,file2.fq -U file3.fq'.

Options (defaults in parentheses):
  Scaffold Type:
    --drna (default)
        Scaffold reads are stranded forward relative to coding strand, enforces --UtoT
    --cdna-rev-stranded
        Scaffold reads are stranded reverse complemented relative to coding strand
    --cdna
        Scaffold reads are NOT stranded
    --sfq (default)
        Scaffold reads are in FASTQ format, enforces --UtoT
    --sfa
        Scaffold reads are in FASTA format
    --UtoT (default)
        Scaffold reads contain Us instead of Ts. Converts U nucleotides to Ts in the sequences
        NOTE: This adds a bit of I/O overhead but doesn't affect things if your sequences are already U free
    --noUtoT
        Scaffold reads do not contain Us and do not need to be converted.
  Illumina Type:
    -u, --unstranded
        Illumina reads are unstranded
    -f, --fwd-stranded
        Illumina reads are stranded s.t. the first mate originates from the RNA strand
        Ignored if scaffold reads are not stranded
    -r, --rev-stranded (default)
        Illumina reads are stranded s.t. the first mate is the reverse complement of the RNA strand
        Ignored if scaffold reads are not stranded
    --ifq (default)
        Illumina reads are in FASTQ format; Mutually exclusive with --ifa
    --ifa
        Illumina reads are in FASTA format; Mutually exclusive with --ifq
  Consensus Collapsing:
    -m, --score-matrix <path>
        Provide an alternative scoring matrix to use in partial order alignment
        Example formatting for the score matrix can be found at poaV2/myNUC3.4.4.mat
    -d, --isoform-delta (35)
        Maximum indel size to be 'corrected', beyond this size a new isoform is declared. Must be between 2 and 255
    -e, --ends-delta (35)
        Maximum size at the ends of isoforms to 'correct' before splitting. Must be between 2 and 255
    -i, --max-iterations (5)
        Maximum number of iterations to align to and correct scaffolds. Does not include optional final polshing step
        Note: Providing a value of 0 will not perform any graph based illumina correction
    -w, --illumina-weight (10)
        Weight of illumina reads relative to nanopore reads when generating consensus
    --final-polish (default)
        Include a final correction of individual isoforms, not in a splice graph
    --no-final-polish
        Do not do a final correction of individual isoforms, not in a splice graph
    --stringent (default)
        Enforce that every base / edge in each final reported isoform is supported by an Illumina read, excluding --stringent-tolerance bp on each end of each isoform
    --no-stringent
        Do not enforce that every base / edge in each final reported isoform is supported by an Illumina read
    --stringent-tolerance (100)
        Number of bases at the end of each isoform that do not have to have Illumina reads supporting them when run in --stringent mode; ignored when run with --no-stringents
  Ouput:
    -o, --output-dir <path> (conduit/)
        <path> where corrected clusters will be written
        NOTE: THIS WILL OVERWRITE EXISTING FILES!
    -n, --no-intermediates (default)
        Does not save FASTA file generated for intermediate rounds of polishing
    -s, --save-intermediates
        Saves the FASTA file generated for intermediate rounds of polishing
  Bowtie2:
    --end-to-end (default)
        Align Illumina reads to ONT scaffolds in end-to-end alignment mode
    --local
        Align Illumina reads to ONT scaffolds in local alignment mode
    -k,--bowtie2-max-alignments (50)
        Maximum number of alignments per Illumina read to be used in final polishing step
  SAMtools:
    --samtools-thread-memory (768 MiB)
        Memory amount to use per SAMtools thread
        Specified either in bytes or with a K, M, or G suffix
  Miscellaneous:
    -h, --help
        Display this help message and exit
    -v, --version
        Display the installed version number of CONDUIT and exit
    --tmp-dir <path> (conduit-tmp/)
        <path> where temporary files will be created
    -t, --threads (4)
        Number of threads to run in parallel (used for both Bowtie2 and Partial Order Graph correction)
```


