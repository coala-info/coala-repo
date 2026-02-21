# pbsv CWL Generation Report

## pbsv_discover

### Tool Description
Find structural variant (SV) signatures in read alignments (BAM to SVSIG).

### Metadata
- **Docker Image**: quay.io/biocontainers/pbsv:2.11.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbsv
- **Package**: https://anaconda.org/channels/bioconda/packages/pbsv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbsv/overview
- **Total Downloads**: 63.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/pbsv
- **Stars**: N/A
### Original Help Text
```text
pbsv discover - Find structural variant (SV) signatures in read alignments (BAM to SVSIG).

Usage:
  pbsv discover [options] <ref.in.bam|xml> <ref.out.svsig.gz>

  ref.in.bam|xml                  STR    Coordinate-sorted aligned reads in which to identify SV signatures.
  ref.out.svsig.gz                STR    Structural variant signatures output.

Basic Options:
  --hifi,--ccs                           Use options optimized for HiFi reads: -y 97

Sample Options:
  -s,--sample                     STR    Override sample name tag from BAM read group.

Alignment Filter Options:
  -q,--min-mapq                   INT    Ignore alignments with mapping quality < N. [5]
  -m,--min-ref-span               STR    Ignore alignments with reference length < N bp. [100]
  -y,--min-gap-comp-id-perc       FLOAT  Ignore alignments with gap-compressed sequence identity < N%. [70]

Downsample Options:
  -w,--downsample-window-length   STR    Window in which to limit coverage, in basepairs. [10K]
  -a,--downsample-max-alignments  INT    Consider up to N alignments in a window; 0 means disabled. [100]

Discovery Options:
  -r,--region                     STR    Limit discovery to this reference region: CHR|CHR:START-END.
  -l,--min-svsig-length           STR    Ignore SV signatures with length < N bp. [7]
  -b,--tandem-repeats             STR    Tandem repeat intervals for indel clustering.
  -k,--max-skip-split             STR    Ignore alignment pairs separated by > N bp of a read or reference. [100]

  -h,--help                              Show this help and exit.
  --version                              Show application version and exit.
  --log-level                     STR    Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file                      FILE   Log to a file, instead of stderr.

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## pbsv_call

### Tool Description
Call structural variants from SV signatures and assign genotypes (SVSIG to VCF).

### Metadata
- **Docker Image**: quay.io/biocontainers/pbsv:2.11.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pbsv
- **Package**: https://anaconda.org/channels/bioconda/packages/pbsv/overview
- **Validation**: PASS

### Original Help Text
```text
pbsv call - Call structural variants from SV signatures and assign genotypes (SVSIG to VCF).

Usage:
  pbsv call [options] <ref.fa|xml> <ref.in.svsig.gz|fofn> <ref.out.vcf>

  ref.fa|xml                                  STR   Reference genome assembly against which to call variants.
  ref.in.svsig.gz|fofn                        STR   SV signatures from one or more samples.
  ref.out.vcf                                 STR   Variant call format (VCF) output.

Basic Options:
  -r,--region                                 STR   Limit discovery to this reference region: CHR|CHR:START-END.
  --hifi,--ccs                                      Use options optimized for HiFi reads: -S 0 -P 10.

Variant Options:
  -t,--types                                  STR   Call these SV types: "DEL", "INS", "INV", "DUP", "BND".
                                                    [DEL,INS,INV,DUP,BND]
  -m,--min-sv-length                          STR   Ignore variants with length < N bp. [20]
  --max-ins-length                            STR   Ignore insertions with length > N bp. [15K]
  --max-dup-length                            STR   Ignore duplications with length > N bp. [1M]

SV Signature Cluster Options:
  --cluster-max-length-perc-diff              INT   Do not cluster signatures with difference in length > P%. [25]
  --cluster-max-ref-pos-diff                  STR   Do not cluster signatures > N bp apart in reference. [200]
  --cluster-min-basepair-perc-id              INT   Do not cluster signatures with basepair identity < P%. [10]

Consensus Options:
  -x,--max-consensus-coverage                 INT   Limit to N reads for variant consensus. [20]
  -s,--poa-scores                             STR   Score POA alignment with triplet match,mismatch,gap. [1,-2,-2]
  --min-realign-length                        STR   Consider segments with > N length for re-alignment. [100]

Call Options:
  -A,--call-min-reads-all-samples             INT   Ignore calls supported by < N reads total across samples. [3]
  -O,--call-min-reads-one-sample              INT   Ignore calls supported by < N reads in every sample. [3]
  -S,--call-min-reads-per-strand-all-samples  INT   Ignore calls supported by < N reads per strand total across samples
                                                    [1]
  -B,--call-min-bnd-reads-all-samples         INT   Ignore BND calls supported by < N reads total across samples [2]
  -P,--call-min-read-perc-one-sample          INT   Ignore calls supported by < P% of reads in every sample. [20]
  --preserve-non-acgt                               Preserve non-ACGT in REF allele instead of replacing with N.

Genotyping:
  --gt-min-reads                              INT   Minimum supporting reads to assign a sample a non-reference
                                                    genotype. [1]

Annotations:
  --annotations                               FILE  Annotate variants by comparing with sequences in fasta.Default
                                                    annotations are ALU, L1, SVA.
  --annotation-min-perc-sim                   INT   Annotate variant if sequence similarity > P%. [60]

Variant Filtering Options:
  --min-N-in-gap                              STR   Consider >= N consecutive "N" bp as a reference gap. [50]
  --filter-near-reference-gap                 STR   Flag variants < N bp from a gap as "NearReferenceGap". [1K]
  --filter-near-contig-end                    STR   Flag variants < N bp from a contig end as "NearContigEnd". [1K]

  -h,--help                                         Show this help and exit.
  --version                                         Show application version and exit.
  -j,--num-threads                            INT   Number of threads to use, 0 means autodetection. [0]
  --log-level                                 STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).
                                                    [WARN]
  --log-file                                  FILE  Log to a file, instead of stderr.

Copyright (C) 2004-2024     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated
