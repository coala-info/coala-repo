# splitcode CWL Generation Report

## splitcode

### Tool Description
Sequence identification and read modification tool for FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/splitcode:0.31.6--h077b44d_0
- **Homepage**: https://github.com/pachterlab/splitcode
- **Package**: https://anaconda.org/channels/bioconda/packages/splitcode/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/splitcode/overview
- **Total Downloads**: 6.7K
- **Last updated**: 2025-12-07
- **GitHub**: https://github.com/pachterlab/splitcode
- **Stars**: N/A
### Original Help Text
```text
splitcode 0.31.6

Usage: splitcode [arguments] fastq-files

Sequence identification options (for configuring on the command-line):
-b, --tags       List of tag sequences (comma-separated)
-d, --distances  List of error distance (mismatch:indel:total) thresholds (comma-separated)
-l, --locations  List of locations (file:pos1:pos2) (comma-separated)
-i, --ids        List of tag names/identifiers (comma-separated)
-g, --groups     List of tag group names (comma-separated)
-f, --minFinds   List of minimum times a tag must be found in a read (comma-separated)
-F, --maxFinds   List of maximum times a tag can be found in a read (comma-separated)
-j, --minFindsG  List of minimum times tags in a group must be found in a read (comma-separated group_name:min_times)
-J, --maxFindsG  List of maximum times tags in a group can be found in a read (comma-separated group_name:max_times)
-e, --exclude    List of what to exclude from final barcode (comma-separated; 1 = exclude, 0 = include)
-L, --left       List of what tags to include when trimming from the left (comma-separated; 1 = include, 0 = exclude)
-R, --right      List of what tags to include when trimming from the right (comma-separated; 1 = include, 0 = exclude)
                 (Note: for --left/--right, can specify an included tag as 1:x where x = number of extra bp's to trim
                 from left/right side if that included tag is at the leftmost/rightmost position)
-a, --next       List of what tag names must come immediately after each tag (comma-separated)
-v, --previous   List of what tag names must come immediately before each tag (comma-separated)
                 (Note: for --next/--previous, specify tag names as {name} and specify tag group names as {{group}}
                 Can also specify the number of base pairs that must appear between the current tag and the next/previous tag.
                 E.g. {bc}4-12 means the next/previous tag is 4-12 bases away and has name 'bc')
-U, --subs       Specifies sequence to substitute tag with when found in read (. = original sequence) (comma-separated)
-z, --partial5   Specifies tag may be truncated at the 5′ end (comma-separated min_match:mismatch_freq)
-Z, --partial3   Specifies tag may be truncated at the 3′ end (comma-separated min_match:mismatch_freq)
    --revcomp    Specifies tag may be reverse complemented
Read modification and extraction options (for configuring on the command-line):
-x, --extract    Pattern(s) describing how to extract UMI and UMI-like sequences from reads
                 (E.g. {bc}2<umi_1[5]> means extract a 5-bp UMI sequence, called umi_1, 2 base pairs following the tag named 'bc')
    --no-chain   If an extraction pattern for a UMI/UMI-like sequence is matched multiple times, only extract based on the first match
-5, --trim-5     Number of base pairs to trim from the 5′-end of reads (comma-separated; one number per each FASTQ file in a run)
-3, --trim-3     Number of base pairs to trim from the 3′-end of reads (comma-separated; one number per each FASTQ file in a run)
-w, --filter-len Filter reads based on length (min_length:max_length)
-q, --qtrim      Quality trimming threshold
    --qtrim-5    Perform quality trimming from the 5′-end of reads of each FASTQ file
    --qtrim-3    Perform quality trimming from the 3′-end of reads of each FASTQ file
    --qtrim-pre  Perform quality trimming before sequence identification operations
    --qtrim-naive Perform quality trimming using a naive algorithm (i.e. trim until a base that meets the quality threshold is encountered)
    --phred64    Use phred+64 encoded quality scores
-P, --prefix     Bases that will prefix each final barcode sequence (useful for merging separate experiments)
-D, --min-delta  When matching tags error-tolerantly, specifies how much worse the next best match must be than the best match
    --from-name  Extract sequences from FASTQ header comments. Format: fastq_number,output_file_number,output_position,pattern.
                 (Example: 0,0,0,::;0,0,0,::+ will extract the nucleotides from 1:N:ATCCC+ATCG and put it into the R1 output)
    --random     Insert a random sequence. Format: output_file_number,output_position,length.
Options (configurations supplied in a file):
-c, --config     Configuration file
Output Options:
-m, --mapping    Output file where the mapping between final barcode sequences and names will be written
-o, --output     FASTQ file(s) where output will be written (comma-separated)
                 Number of output FASTQ files should equal --nFastqs (unless --select is provided)
-O, --outb       FASTQ file where final barcodes will be written
                 If not supplied, final barcodes are prepended to reads of first FASTQ file (or as the first read for --pipe)
-u, --unassigned FASTQ file(s) where output of unassigned reads will be written (comma-separated)
                 Number of FASTQ files should equal --nFastqs (unless --select is provided)
-E, --empty      Sequence to fill in empty reads in output FASTQ files (default: no sequence is used to fill in those reads)
    --empty-remove Empty reads are stripped in output FASTQ files (don't even output an empty sequence)
-p, --pipe       Write to standard output (instead of output FASTQ files)
-S, --select     Select which FASTQ files to output (comma-separated) (e.g. 0,1,3 = Output files #0, #1, #3)
    --gzip       Output compressed gzip'ed FASTQ files
    --out-fasta  Output in FASTA format rather than FASTQ format
    --out-bam    Output a BAM file rather than FASTQ files (enter the output BAM file name to -o or --output)
    --keep-com   Preserve the comments of the read names of the input FASTQ file(s)
    --no-output  Don't output any sequences
    --no-outb    Don't output final barcode sequences
    --no-x-out   Don't output extracted UMI-like sequences (should be used with --x-names)
    --mod-names  Modify names of outputted sequences to include identified tag names
    --com-names  Modify names of outputted sequences to include final barcode sequence ID
    --seq-names  Modify names of outputted sequences to include the sequences of identified tags
    --loc-names  Modify names of outputted sequences to include found tag names and locations
    --x-names    Modify names of outputted sequences to include extracted UMI-like sequences
    --x-only     Only output extracted UMI-like sequences
    --bc-names   Modify names of outputted sequences to include final barcode sequence string
-X, --sub-assign Assign reads to a secondary sequence ID based on a subset of tags present (must be used with --assign)
                 (e.g. 0,2 = Generate unique ID based the tags present by subsetting those tags to tag #0 and tag #2 only)
                 The names of the outputted sequences will be modified to include this secondary sequence ID
-C  --compress   Set the gzip compression level (default: 1) (range: 1-9)
-M  --sam-tags   Modify the default SAM tags (default: CB:Z:,RX:Z:,BI:i:,SI:i:,BC:Z:,LX:Z:,YM:Z:)
Other Options:
-N, --nFastqs    Number of FASTQ file(s) per run
                 (default: 1) (specify 2 for paired-end)
-n, --numReads   Maximum number of reads to process from supplied input
-A, --append     An existing mapping file that will be added on to
-k, --keep       File containing a list of arrangements of tag names to keep
-r, --remove     File containing a list of arrangements of tag names to remove/discard
-y, --keep-grp   File containing a list of arrangements of tag groups to keep
-Y, --remove-grp File containing a list of arrangements of tag groups to remove/discard
-t, --threads    Number of threads to use
-s, --summary    File where summary statistics will be written to
-h, --help       Displays usage information
    --assign     Assign reads to a final barcode sequence identifier based on tags present
    --barcode-encode Optimize barcode assignment using a sequence of group names (e.g. group1,group2,group3)
    --bclen      The length of the final barcode sequence identifier (default: 16)
    --inleaved   Specifies that input is an interleaved FASTQ file
    --keep-r1-r2 Use R1.fastq, R2.fastq, etc. file name formats when demultiplexing using --keep or --keep-grp
    --remultiplex  Turn on remultiplexing mode
    --unmask       Turn on unmasking mode (extract differences from a masked vs. unmasked FASTA)
    --lift         Turn lift mode (make variant genomes from VCF files)
    --version    Prints version number
    --cite       Prints citation information
```


## Metadata
- **Skill**: generated
