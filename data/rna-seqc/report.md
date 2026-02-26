# rna-seqc CWL Generation Report

## rna-seqc_rnaseqc

### Tool Description
RNASeQC 2.4.2

### Metadata
- **Docker Image**: quay.io/biocontainers/rna-seqc:2.4.2--h29c0135_1
- **Homepage**: https://github.com/broadinstitute/rnaseqc
- **Package**: https://anaconda.org/channels/bioconda/packages/rna-seqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rna-seqc/overview
- **Total Downloads**: 35.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/broadinstitute/rnaseqc
- **Stars**: N/A
### Original Help Text
```text
rnaseqc [gtf] [bam] [output] {OPTIONS}

    RNASeQC 2.4.2

  OPTIONS:

      -h, --help                        Display this message and quit
      --version                         Display the version and quit
      gtf                               The input GTF file containing features
                                        to check the bam against
      bam                               The input SAM/BAM file containing reads
                                        to process
      output                            Output directory
      -s[sample], --sample=[sample]     The name of the current sample. Default:
                                        The bam's filename
      --bed=[BEDFILE]                   Optional input BED file containing
                                        non-overlapping exons used for fragment
                                        size calculations
      --fasta=[fasta]                   Optional input FASTA/FASTQ file
                                        containing the reference sequence used
                                        for parsing CRAM files
      --chimeric-distance=[DISTANCE]    Set the maximum accepted distance
                                        between read mates. Mates beyond this
                                        distance will be counted as chimeric
                                        pairs. Default: 2000000 [bp]
      --fragment-samples=[SAMPLES]      Set the number of samples to take when
                                        computing fragment sizes. Requires the
                                        --bed argument. Default: 1000000
      -q[QUALITY],
      --mapping-quality=[QUALITY]       Set the lower bound on read quality for
                                        exon coverage counting. Reads below this
                                        number are excluded from coverage
                                        metrics. Default: 255
      --base-mismatch=[MISMATCHES]      Set the maximum number of allowed
                                        mismatches between a read and the
                                        reference sequence. Reads with more than
                                        this number of mismatches are excluded
                                        from coverage metrics. Default: 6
      --offset=[OFFSET]                 Set the offset into the gene for the 3'
                                        and 5' windows in bias calculation. A
                                        positive value shifts the 3' and 5'
                                        windows towards eachother, while a
                                        negative value shifts them apart.
                                        Default: 150 [bp]
      --window-size=[SIZE]              Set the size of the 3' and 5' windows in
                                        bias calculation. Default: 100 [bp]
      --gene-length=[LENGTH]            Set the minimum size of a gene for bias
                                        calculation. Genes below this size are
                                        ignored in the calculation. Default: 600
                                        [bp]
      --legacy                          Use legacy counting rules. Gene and exon
                                        counts match output of RNA-SeQC 1.1.9
      --stranded=[stranded]             Use strand-specific metrics. Only
                                        features on the same strand of a read
                                        will be considered. Allowed values are
                                        'RF', 'rf', 'FR', and 'fr'
      -v, --verbose                     Give some feedback about what's going
                                        on. Supply this argument twice for
                                        progress updates while parsing the bam
      -t[TAG...], --tag=[TAG...]        Filter out reads with the specified tag.
      --chimeric-tag=[TAG]              Reads maked with the specified tag will
                                        be labeled as Chimeric. Defaults to 'mC'
                                        for STAR
      --exclude-chimeric                Exclude chimeric reads from the read
                                        counts
      -u, --unpaired                    Allow unpaired reads to be quantified.
                                        Required for single-end libraries
      --rpkm                            Output gene RPKM values instead of TPMs
      --coverage                        If this flag is provided, coverage
                                        statistics for each transcript will be
                                        written to a table. Otherwise, only
                                        summary coverage statistics are
                                        generated and added to the metrics table
      --coverage-mask=[SIZE]            Sets how many bases at both ends of a
                                        transcript are masked out when computing
                                        per-base exon coverage. Default: 500bp
      -d[threshold],
      --detection-threshold=[threshold] Number of counts on a gene to consider
                                        the gene 'detected'. Additionally, genes
                                        below this limit are excluded from 3'
                                        bias computation. Default: 5 reads
      "--" can be used to terminate flag options and force all following
      arguments to be treated as positional options


Argument parsing error: Flag could not be matched: h
```

