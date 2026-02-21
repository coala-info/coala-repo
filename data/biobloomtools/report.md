# biobloomtools CWL Generation Report

## biobloomtools

### Tool Description
FAIL to generate CWL: biobloomtools not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobloomtools:2.3.5--h077b44d_6
- **Homepage**: https://github.com/bcgsc/biobloom
- **Package**: https://anaconda.org/channels/bioconda/packages/biobloomtools/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobloomtools/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/biobloom
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: biobloomtools not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: biobloomtools not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## biobloomtools_biobloommaker

### Tool Description
Creates a bf and txt file from a list of fasta files. The input sequences are cut into a k-mers with a sliding window and their hash signatures are inserted into a bloom filter.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobloomtools:2.3.5--h077b44d_6
- **Homepage**: https://github.com/bcgsc/biobloom
- **Package**: https://anaconda.org/channels/bioconda/packages/biobloomtools/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: biobloommaker -p [FILTERID] [OPTION]... [FILE]...
Usage: biobloommaker -p [FILTERID] -r 0.2 [FILE]... [FASTQ1] [FASTQ2] 
Creates a bf and txt file from a list of fasta files. The input sequences are
cut into a k-mers with a sliding window and their hash signatures are inserted
into a bloom filter.

  -p, --file_prefix=N    Filter prefix and filter ID. Required option.
  -o, --output_dir=N     Output location of the filter and filter info files.
  -h, --help             Display this dialog.
      --version          Display version information.
  -v  --verbose          Display verbose output.
  -t, --threads=N        The number of threads to use.

Bloom filter options:
  -f, --fal_pos_rate=N   Maximum false positive rate to use in filter. [0.0075]
  -g, --hash_num=N       Set number of hash functions to use in filter instead
                         of automatically using calculated optimal number of
                         functions.
  -k, --kmer_size=N      K-mer size to use to create filter. [25]
  -d, --no_rep_kmer      Remove all repeat k-mers from the resulting filter in
                         progressive mode.
  -n, --num_ele=N        Set the number of expected elements. If set to 0 number
                         is determined from sequences sizes within files. [0]

Options for progressive filters:
  -r, --progressive=N    Progressive filter creation. The score threshold is
                         specified by N, which may be either a floating point
                         score between 0 and 1 or a positive integer.  If N is a
                         positive integer, it is interpreted as the minimum
                         number of contiguous matching bases required for a
                         match.
  -s, --subtract=N       Path to filter that you want to uses to minimize repeat
                         propagation of k-mers inserted into new filter. You may
                         only use filters with k-mer sizes equal the one you
                         wish to create.
  -d, --no_rep_kmer      Remove all repeat k-mers from the resulting filter in
                         progressive mode.
  -a, --streak=N         The number of hits tiling in second pass needed to jump
                         Several tiles upon a miss. Progressive mode only. [3]
  -l, --file_list=N      A file of list of file pairs to run in parallel.
  -b, --baitScore=N      Score threshold when considering only bait. [r]
  -e, --iterations=N     Pass through files N times if threshold is not met.
  -i, --inclusive        If one paired read matches, both reads will be included
                         in the filter. Only active with the (-r) option.
  -I, --interval         the interval to report file processing status [10000000]
  -P, --print_reads      During progressive filter creation, print tagged reads
                         to STDOUT in FASTQ format for debugging [disabled]

Report bugs to <cjustin@bcgsc.ca>.
```

## biobloomtools_biobloomcategorizer

### Tool Description
Categorize Sequences. The input format may be FASTA, FASTQ, and compressed gz.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobloomtools:2.3.5--h077b44d_6
- **Homepage**: https://github.com/bcgsc/biobloom
- **Package**: https://anaconda.org/channels/bioconda/packages/biobloomtools/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: biobloomcategorizer [OPTION]... -f "[FILTER1]..." [FILE]...
biobloomcategorizer [OPTION]... -e -f "[FILTER1]..." [FILE1.fq] [FILE2.fq]
biobloomcategorizer [OPTION]... -e -f "[FILTER1]..." [SMARTFILE.fq]
Categorize Sequences. The input format may be FASTA, FASTQ, and compressed gz.

  -p, --prefix=N         Output prefix to use. Otherwise will output to current
                         directory.
  -f, --filter_files=N   List of filter files to use. Required option. 
                         eg. "filter1.bf filter2.bf"
  -e, --paired_mode      Uses paired-end information. For BAM or SAM files, if
                         they are poorly ordered, the memory usage will be much
                         larger than normal. Sorting by read name may be needed.
  -i, --inclusive        If one paired read matches, both reads will be included
                         in the filter. 
  -s, --score=N          Score threshold for matching. N may be either a
                         floating point score between 0 and 1 or a positive
                         integer representing the minimum match length in bases.
                         If N is a floating point, the maximum threshold is any 
                         number less than 1, and the minimum is 0 (highest
                         sensitivity). When using binomial scoring this score
                         becomes to the minimum -10*log(FPR) threshold for a 
                         match. [0.15 for default, 100 for binomial]
  -b, --best_hit         The best hit is used rather than the score (-s) threshold.
                         Score will be appended to the header of the output read.
  -w, --with_score       Output multimatches with scores in the order of filter.
  -t, --threads=N        The number of threads to use. [1]
  -g, --gz_output        Outputs all output files in compressed gzip.
      --fa               Output categorized reads in Fasta files.
      --fq               Output categorized reads in Fastq files.
      --chastity         Discard and do not evaluate unchaste reads.
      --no-chastity      Do not discard unchaste reads. [default]
  -l, --file_list=N      A file of list of file pairs to run in parallel. Should
                         only be used when the number of input files is large.
  -v, --version          Display version information.
  -h, --help             Display this dialog.
      --verbose          Display verbose output
  -I, --interval         Interval to report file processing status [10000000]
Advanced options:
  -r, --streak=N         The number of hits tiling in second pass needed to jump
                         Several tiles upon a miss. Small values decrease
                         runtime but decrease sensitivity. [3]
  -c, --ordered          Use ordered filtering. Order of filters matters
                         (filters listed first have higher priority). Only taken
                         advantage of when k-mer sizes and number of hash
                         functions are the same.
  -d, --stdout_filter    Outputs all matching reads to stdout for the first
                         filter listed by -f. Reads are outputed in fastq,
                         and if paired will output will be interlaced.
  -n, --inverse          Inverts the output of -d (everything but first filter).
  -S, --score_type=N     Can be set to 'harmonic' scoring or 'binomial' scoring.
                         harmonic scoring penalizes short runs of matches and
                         bionomial scoring computes the minimum number of k-mer
                         matches needed based on a minimum FPR (-s). [simple]
  -D, --dust             Filter using dust.
  -T, --T_dust           T parameter for dust. [20]
  -W, --window_dust      Window size for dust. [64]

Report bugs to <cjustin@bcgsc.ca>.
```

