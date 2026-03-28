# isoseq3 CWL Generation Report

## isoseq3_refine

### Tool Description
Remove polyA and concatemers from FL reads and generate FLNC transcripts (FL to FLNC)

### Metadata
- **Docker Image**: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/IsoSeq3
- **Package**: https://anaconda.org/channels/bioconda/packages/isoseq3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/isoseq3/overview
- **Total Downloads**: 59.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/IsoSeq3
- **Stars**: N/A
### Original Help Text
```text
isoseq refine - Remove polyA and concatemers from FL reads and generate FLNC transcripts (FL to FLNC)

Usage:
  isoseq refine [options] <demux.bam|xml> <primer.fasta|xml> <flnc.bam|xml>

  demux.bam|xml       STR    Input cDNA demuxed BAM or ConsensusReadSet XML
  primer.fasta|xml    STR    Input primer FASTA or BarcodeSet XML
  flnc.bam|xml        STR    Output flnc BAM or ConsensusReadSet XML

Preprocessing:
  --min-polya-length  INT    Minimum poly(A) tail length. [20]
  --require-polya            Require FL reads to have a poly(A) tail and remove it.
  --min-rq            FLOAT  Minimum CCS RQ. Default is -1, deactivated [-1]

  -h,--help                  Show this help and exit.
  --version                  Show application version and exit.
  -j,--num-threads    INT    Number of threads to use, 0 means autodetection. [0]
  --log-level         STR    Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file          FILE   Log to a file, instead of stderr.
  -v,--verbose               Use verbose output.

Copyright (C) 2004-2023     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## isoseq3_cluster2

### Tool Description
Cluster FLNC reads and generate transcripts, much faster than "cluster" (FLNC to TRANSCRIPTS)

### Metadata
- **Docker Image**: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/IsoSeq3
- **Package**: https://anaconda.org/channels/bioconda/packages/isoseq3/overview
- **Validation**: PASS

### Original Help Text
```text
isoseq cluster2 - Cluster FLNC reads and generate transcripts, much faster than "cluster" (FLNC to TRANSCRIPTS)

Usage:
  isoseq cluster2 [options] <flnc.bam|xml|fofn> <transcripts.bam>

  flnc.bam|xml|fofn  STR   Input flnc BAM, ConsensusReadSet XML, or FOFN
  transcripts.bam    STR   Output transcripts BAM

  --singletons             Output FLNCs that could not be clustered.
  --sort-threads     INT   Number of sorting threads per BAM file. Equivalent to open file handles per BAM. Defaults to
                           -j. [0]
  --write-bam        STR   Write annotated BAM file.

  -h,--help                Show this help and exit.
  --version                Show application version and exit.
  -j,--num-threads   INT   Number of threads to use, 0 means autodetection. [0]
  --log-level        STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file         FILE  Log to a file, instead of stderr.

Copyright (C) 2004-2023     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## isoseq3_cluster

### Tool Description
Cluster FLNC reads and generate transcripts (FLNC to TRANSCRIPTS)

### Metadata
- **Docker Image**: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/IsoSeq3
- **Package**: https://anaconda.org/channels/bioconda/packages/isoseq3/overview
- **Validation**: PASS

### Original Help Text
```text
isoseq cluster - Cluster FLNC reads and generate transcripts (FLNC to TRANSCRIPTS)

Usage:
  isoseq cluster [options] <flnc.bam|xml> <transcripts.bam|xml>

  flnc.bam|xml          STR   Input flnc BAM or ConsensusReadSet XML
  transcripts.bam|xml   STR   Input transcripts BAM or TranscriptSet XML

Clustering:
  --poa-cov             INT   Maximum number of CCS reads used for POA consensus. [100]

Output:
  --min-subreads-split  INT   Subread threshold for HQ/LQ split. [7]
  --split-bam           INT   Split BAM output files into at maximum N files; 0 means no splitting [0]
  --singletons                Output FLNCs that could not be clustered.

  -h,--help                   Show this help and exit.
  --version                   Show application version and exit.
  -j,--num-threads      INT   Number of threads to use, 0 means autodetection. [0]
  --log-level           STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file            FILE  Log to a file, instead of stderr.
  -v,--verbose                Use verbose output.

Copyright (C) 2004-2023     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## isoseq3_bcstats

### Tool Description
Generates stats for group barcodes and (optionally) molecular barcodes

### Metadata
- **Docker Image**: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/IsoSeq3
- **Package**: https://anaconda.org/channels/bioconda/packages/isoseq3/overview
- **Validation**: PASS

### Original Help Text
```text
isoseq bcstats - Generates stats for group barcodes and (optionally) molecular barcodes

Usage:
  isoseq bcstats [options] <input.bam|xml|fofn>

  input.bam|xml|fofn  STR   Input BAM, ConsensusReadSet XML, or FOFN

  --molecular,-U            Emit stats for molecular barcodes (UMIs) as well as cell barcodes. This results in a tsv
                            with one line for each cell barcode and one line for each molecular barcode.
  -o,--output         STR   Output tsv of stats for input BAM files. [/dev/stdout]
  -R,--json           STR   Path to emit output JSON report. [/dev/stderr]
  --deduplicated,-D         To mark as de-duplicated. This allows for faster analysis and sanity checks across
                            versions.
  --batch-size,-Z     INT   Batch size for processing. [65536]
  --percentile,-P     INT   Percentile to use when calculating real vs non-real cells. This option is only relevant
                            when --method is set to 'percentile'. [99]
  -T,--target         STR   Whether to determine real vs non-real cells by read count ('readcount') or UMI count
                            ('umicount'). Valid choices: (readcount, umicount). [umicount]
  -M,--method         STR   Whether to determine real vs non-real cells using Knee-finding ('knee') or Percentile-based
                            method ('percentile'). Valid choices: (knee, percentile). [knee]

  -h,--help                 Show this help and exit.
  --version                 Show application version and exit.
  -j,--num-threads    INT   Number of threads to use, 0 means autodetection. [0]
  --log-level         STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file          FILE  Log to a file, instead of stderr.
  -v,--verbose              Use verbose output.

isoseq bcstats generates stats for group barcodes (CB:Z,XC:Z, or CR:Z) and (optionally) molecular barcodes (XM:Z, UR:Z, or UB:Z).

Copyright (C) 2004-2023     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## isoseq3_summarize

### Tool Description
Create barcode overview from transcripts (TRANSCRIPTS to CSV)

### Metadata
- **Docker Image**: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/IsoSeq3
- **Package**: https://anaconda.org/channels/bioconda/packages/isoseq3/overview
- **Validation**: PASS

### Original Help Text
```text
isoseq summarize - Create barcode overview from transcripts (TRANSCRIPTS to CSV)

Usage:
  isoseq summarize [options] <transcripts.bam|xml> <summary.csv>

  transcripts.bam|xml  STR   Input transcripts BAM or TranscriptSet XML
  summary.csv          STR   Output summary CSV

Options:
  -h,--help                  Show this help and exit.
  --version                  Show application version and exit.
  --log-level          STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file           FILE  Log to a file, instead of stderr.

Copyright (C) 2004-2023     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## isoseq3_collapse

### Tool Description
Collapse transcripts based on genomic mapping

### Metadata
- **Docker Image**: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/IsoSeq3
- **Package**: https://anaconda.org/channels/bioconda/packages/isoseq3/overview
- **Validation**: PASS

### Original Help Text
```text
isoseq collapse - Collapse transcripts based on genomic mapping

Usage:
  isoseq collapse [options] <alignments.bam|xml> <flnc.bam|xml> <out.gff>

  alignments.bam|xml              STR    Alignments mapping Transcripts to reference genome
  flnc.bam|xml                    STR    FLNC BAM, optional input
  out.gff                         STR    Collapsed transcripts GFF

Alignment Filter Options:
  --min-aln-coverage              FLOAT  Ignore alignments with less than minimum query read coverage. [0.99]
  --min-aln-identity              FLOAT  Ignore alignments with less than minimum alignment identity. [0.95]

Collapse Options:
  --max-fuzzy-junction            INT    Ignore mismatches or indels shorter than or equal to N. [5]
  --max-5p-diff                   INT    Maximum allowed 5' difference if on same exon. [50]
  --max-3p-diff                   INT    Maximum allowed 3' difference if on same exon. [100]
  --do-not-collapse-extra-5exons         Do not collapse 5' shorter transcripts which miss one or multiple 5' exons to
                                         a longer transcript.
  --max-batch-mem                 FLOAT  Maximum memory for batch loading, in megabytes (MB). Batches can be slightly
                                         larger than this value. Value <= 0 loads all data in memory at once. [4096]
  --split-group-size              INT    Groups larger than this will be linearly split for parallel processing. [100]
  --keep-non-real-cells                  Do not skip reads with non-real cells.

  -h,--help                              Show this help and exit.
  --version                              Show application version and exit.
  -j,--num-threads                INT    Number of threads to use, 0 means autodetection. [0]
  --log-level                     STR    Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file                      FILE   Log to a file, instead of stderr.

Copyright (C) 2004-2023     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## isoseq3_tag

### Tool Description
Remove cell barcodes and UMIs from FL reads and generate tagged FL transcripts (FL to FLT)

### Metadata
- **Docker Image**: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/IsoSeq3
- **Package**: https://anaconda.org/channels/bioconda/packages/isoseq3/overview
- **Validation**: PASS

### Original Help Text
```text
isoseq tag - Remove cell barcodes and UMIs from FL reads and generate tagged FL transcripts (FL to FLT)

Usage:
  isoseq tag [options] <demux.bam> <flt.bam>

  demux.bam          STR   Input cDNA demuxed BAM or ConsensusReadSet XML
  flt.bam            STR   Output FLT BAM or ConsensusReadSet XML

Tag:
  --design           STR   Barcoding design. Specifies which bases to use as cell/molecular barcodes. [T-8U-10B]
  --min-read-length  INT   Minimum read length after trimming. [50]

  -h,--help                Show this help and exit.
  --version                Show application version and exit.
  -j,--num-threads   INT   Number of threads to use, 0 means autodetection. [0]
  --log-level        STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file         FILE  Log to a file, instead of stderr.
  -v,--verbose             Use verbose output.

Copyright (C) 2004-2023     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## isoseq3_correct

### Tool Description
Correct group barcodes given a barcode truth set

### Metadata
- **Docker Image**: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/IsoSeq3
- **Package**: https://anaconda.org/channels/bioconda/packages/isoseq3/overview
- **Validation**: PASS

### Original Help Text
```text
isoseq correct - Correct group barcodes given a barcode truth set

Usage:
  isoseq correct [options] <flnc.bam|xml|fofn> <flnc-bccorr.bam|xml>

  flnc.bam|xml|fofn       STR   Input flnc BAM, ConsensusReadSet XML, or FOFN
  flnc-bccorr.bam|xml     STR   Output Barcode-corrected flnc BAM or ConsensusReadSet XML

  --barcodes,-B           STR   Plain text file containing known 'true' barcodes, one per line. This 'include list'
                                specifies the barcode-set to which raw cell barcodes are remapped by minimum edit
                                distance. May be gzip-compressed.
  --max-edit-distance,-M  INT   Maximum edit distance for mapping barcodes to those in the truth set. Increasing this
                                parameter will increase yield but potentially introduce errors. [2]
  --filter,-F             STR   Filtering mode. Set to 'missing' to remove reads which could not be corrected, and
                                'failing' to remove those as well as reads failing max-edit-distance thresholding.
                                Valid choices: (missing, failing, none). [none]
  --percentile,-P         INT   Percentile to use when calculating real vs non-real cells. This option is only relevant
                                when --method is set to 'percentile'. [99]
  --method                STR   Whether to determine real vs non-real cells using Knee-finding ('knee') or
                                Percentile-based method ('percentile'). Valid choices: (knee, percentile). [knee]

  -h,--help                     Show this help and exit.
  --version                     Show application version and exit.
  -j,--num-threads        INT   Number of threads to use, 0 means autodetection. [0]
  --log-level             STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file              FILE  Log to a file, instead of stderr.
  -v,--verbose                  Use verbose output.

isoseq correct corrects group barcodes (XC:Z) given a barcode truth set. Additionally, tags reads as real cell/not real cells via "rc" and pass/fail via "gp". Valid records from real cells are non-zero for both tags.

Copyright (C) 2004-2023     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## isoseq3_dedup

### Tool Description
Deduplicate PCR artifacts (FLTNC to DEDUP)

### Metadata
- **Docker Image**: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/IsoSeq3
- **Package**: https://anaconda.org/channels/bioconda/packages/isoseq3/overview
- **Validation**: PASS

### Original Help Text
```text
isoseq dedup - Deduplicate PCR artifacts (FLTNC to DEDUP)

Usage:
  isoseq dedup [options] <fltnc.bam|xml> <dedup.fltnc.bam|xml>

  fltnc.bam|xml             STR   Input FLTNC BAM or ConsensusReadSet XML
  dedup.fltnc.bam|xml       STR   Output dedup BAM or ConsensusReadSet XML

Dedup:
  --poa-cov                 INT   Maximum number of input reads used for POA consensus. [10]
  --max-tag-mismatches      INT   Maximum number of mismatches between tags. [1]
  --max-tag-shift           INT   Tags may be shifted by at maximum of N bases. [1]
  --max-insert-length-diff  INT   Maximum insert lengths difference. [50]
  --max-insert-pad          INT   Maximum number of missing flanking bases on either insert side. [5]
  --min-concordance-perc    INT   Minimum insert alignment concordance in %. [97]
  --max-insert-gaps         INT   Maximum number of insert gaps per 20 bp window. [5]
  --keep-non-real-cells           Do not skip reads with non-real cells.
  --keep-fail-barcodes            Do not skip reads with failed barcodes.

  -h,--help                       Show this help and exit.
  --version                       Show application version and exit.
  -j,--num-threads          INT   Number of threads to use, 0 means autodetection. [0]
  --log-level               STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file                FILE  Log to a file, instead of stderr.
  -v,--verbose                    Use verbose output.

Copyright (C) 2004-2023     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## isoseq3_groupdedup

### Tool Description
Deduplicate PCR artifacts grouped by cell barcode (barcode-sorted FLTNC to DEDUP)

### Metadata
- **Docker Image**: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/IsoSeq3
- **Package**: https://anaconda.org/channels/bioconda/packages/isoseq3/overview
- **Validation**: PASS

### Original Help Text
```text
isoseq groupdedup - Deduplicate PCR artifacts grouped by cell barcode (barcode-sorted FLTNC to DEDUP)

Usage:
  isoseq groupdedup [options] <fltnc.bam|xml|fofn> <fltnc.bam|xml>

  fltnc.bam|xml|fofn       STR   Input FLTNC BAM, ConsensusReadSet XML, or FOFN, sorted by cell barcode (CB or XC tags)
  fltnc.bam|xml            STR   Output BAM or ConsensusReadSet XML

GroupDedup:
  --poa-cov                INT   Maximum number of input reads used for POA consensus. [10]
  --max-tag-mismatches     INT   Maximum number of mismatches between tags. [1]
  --max-tag-shift          INT   Tags may be shifted by at maximum of N bases. [1]
  --max-length-difference  INT   Maximum insert lengths difference. [50]
  --max-insert-pad         INT   Maximum number of missing flanking bases on either insert side. [5]
  --min-concordance-perc   INT   Minimum insert alignment concordance in %. [97]
  --max-insert-gaps        INT   Maximum number of insert gaps per 20 bp window. [5]
  --barcode-tag,-C         STR   Specify BAM cell/group tag by which to group. If empty, checks CB and XC.
  --no-poa                       Select highest-pass read in set instead of generating consensus sequence with POA
                                 (partial order alignment).
  --batch-size             INT   Number of BAM records to load per batch. [500000]
  --keep-non-real-cells          Do not skip reads with non-real cells.
  --keep-fail-barcodes           Do not skip reads with failed barcodes.

  -h,--help                      Show this help and exit.
  --version                      Show application version and exit.
  -j,--num-threads         INT   Number of threads to use, 0 means autodetection. [0]
  --log-level              STR   Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]
  --log-file               FILE  Log to a file, instead of stderr.
  -v,--verbose                   Use verbose output.

Copyright (C) 2004-2023     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated
