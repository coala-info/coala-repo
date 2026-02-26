# strobealign CWL Generation Report

## strobealign

### Tool Description
strobealign 0.17.0

### Metadata
- **Docker Image**: quay.io/biocontainers/strobealign:0.17.0--h5ca1c30_0
- **Homepage**: https://github.com/ksahlin/StrobeAlign
- **Package**: https://anaconda.org/channels/bioconda/packages/strobealign/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/strobealign/overview
- **Total Downloads**: 29.9K
- **Last updated**: 2025-12-18
- **GitHub**: https://github.com/ksahlin/StrobeAlign
- **Stars**: N/A
### Original Help Text
```text
strobealign reference [reads1] [reads2] {OPTIONS}

    strobealign 0.17.0

  OPTIONS:

      -h, --help    Print help and exit
      --version     Print version and exit
      -t [INT], --threads=[INT]
                    Number of threads [1]
      Input/output:
      -o [PATH]     redirect output to file [stdout]
      -v            Verbose output
      --no-progress Disable progress report (enabled by default if output is a terminal)
      -x            Only map reads, no base level alignment (produces PAF file)
      --aemb        Output the estimated abundance value of contigs, the format of output
                    file is: contig_id abundance_value
      --interleaved Interleaved input
      --index-statistics=[PATH]
                    Print statistics of indexing to PATH
      -i, --create-index
                    Do not map reads; only generate the strobemer index and write it to
                    disk. If read files are provided, they are used to estimate read
                    length
      --use-index   Use a pre-generated index previously written with --create-index.
      SAM output:
      --eqx         Emit =/X instead of M CIGAR operations
      --no-PG       Do not output PG header
      -U            Do not output unmapped single-end reads. Do not output pairs where
                    both reads are unmapped
      --rg-id=[ID]  Read group ID
      --rg=[TAG:VALUE...]
                    Add read group metadata to SAM header (can be specified multiple
                    times). Example: SM:samplename
      --details     Add debugging details to SAM records
      -C            Append FASTQ comment to SAM record
      -N [INT]      Retain at most INT secondary alignments (is upper bounded by -M and
                    depends on -S) [0]
      Seeding:
      -r [INT]      Mean read length. This parameter is estimated from the first 500
                    records in each read file. No need to set this explicitly unless you
                    have a reason.
      -m [INT]      Maximum seed length. Defaults to r - 50. For reasonable values on -l
                    and -u, the seed length distribution is usually determined by
                    parameters l and u. Then, this parameter is only active in regions
                    where syncmers are very sparse.
      -k [INT]      Syncmer (strobe) length, has to be below 32. [20]
      -l [INT]      Start of sampling window for second syncmer (i.e., second syncmer must
                    be at least l syncmers downstream). [5]
      -u [INT]      End of sampling window for second syncmer (i.e., second syncmer must
                    be at most u syncmers downstream). [11]
      -c [INT]      Bitcount length between 2 and 63. [8]
      -s [INT]      Submer size used for creating syncmers [k-4]. Only even numbers on k-s
                    allowed. A value of s=k-4 roughly represents w=10 as minimizer window
                    [k-4]. It is recommended not to change this parameter unless you have
                    a good understanding of syncmers as it will drastically change the
                    memory usage and results with non default values.
      -b [INT]      No. of top bits of hash to use as bucket indices (8-31)[determined
                    from reference size]
      --aux-len=[INT]
                    No. of bits to use from secondary strobe hash [17]
      Alignment:
      -A [INT]      Matching score [2]
      -B [INT]      Mismatch penalty [8]
      -O [INT]      Gap open penalty [12]
      -E [INT]      Gap extension penalty [1]
      -L [INT]      Soft clipping penalty [10]
      Collinear Chaining:
      --nams        Use NAMs instead of collinear chaining for alignments
      -H [INT]      Collinear chaining look back heuristic [50]
      --gd=[FLOAT]  Collinear chaining diagonal gap cost [0.1]
      --gl=[FLOAT]  Collinear chaining gap length cost [0.05]
      --vp=[FLOAT]  Collinear chaining best chain score threshold [0.7]
      --sg=[INT]    Collinear chaining skip distance, how far on the reference do we allow
                    anchors to chain [10000]
      --mw=[FLOAT]  Weight given to the number of anchors for the final score of chains
                    [0.01]
      Search parameters:
      --mcs=[mcs]   How multi-context seeds are used. Allowed: 'always' (default),
                    'rescue', 'off', 'first-strobe'
      -f [FLOAT]    Top fraction of repetitive strobemers to filter out from sampling
                    [0.0002]
      -S [FLOAT]    Try candidate sites with mapping score at least S of maximum mapping
                    score [0.5]
      -M [INT]      Maximum number of mapping sites to try [20]
      -R [INT]      Maximum distance (in nucleotides) that filtered seeds may span. The
                    lower the value, the more seeds are rescued. Use 0 to disable rescue.
                    [100]
      reference     Reference in FASTA format
      reads1        Reads 1 in FASTA or FASTQ format, optionally gzip compressed
      reads2        Reads 2 in FASTA or FASTQ format, optionally gzip compressed

Error: Option 'reference' is required
```

