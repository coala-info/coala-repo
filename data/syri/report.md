# syri CWL Generation Report

## syri

### Tool Description
SyRI is a tool for identifying structural variations (SVs) in genomes based on pairwise alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/syri:1.7.1--py311hcf77733_1
- **Homepage**: https://github.com/schneebergerlab/syri
- **Package**: https://anaconda.org/channels/bioconda/packages/syri/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/syri/overview
- **Total Downloads**: 22.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/schneebergerlab/syri
- **Stars**: N/A
### Original Help Text
```text
usage: syri [-h] -c INFILE [-r REF] [-q QRY] [-d DELTA] [-F {T,S,B,P}] [-f]
            [-k] [--dir DIR] [--prefix PREFIX] [--seed SEED] [--nc NCORES]
            [--novcf] [--samplename SNAME] [--nosr] [--invgaplen INVGL]
            [--tdgaplen TDGL] [--tdmaxolp TDOLP] [-b BRUTERUNTIME]
            [--unic TRANSUNICOUNT] [--unip TRANSUNIPERCENT] [--inc INCREASEBY]
            [--no-chrmatch] [--nosv] [--nosnp] [--all] [--allow-offset OFFSET]
            [--cigar] [-s SSPATH] [--hdrseq] [--maxsize MAXS]
            [--log {DEBUG,INFO,WARN}] [--lf LOG_FIN] [--version]

Input Files:
  -c INFILE             File containing alignment coordinates (default: None)
  -r REF                Genome A (which is considered as reference for the
                        alignments). Required for local variation (large
                        indels, CNVs) identification. (default: None)
  -q QRY                Genome B (which is considered as query for the
                        alignments). Required for local variation (large
                        indels, CNVs) identification. (default: None)
  -d DELTA              .delta file from mummer. Required for short variation
                        (SNPs/indels) identification when CIGAR string is not
                        available (default: None)

Additional arguments:
  -F {T,S,B,P}          Input file type. T: Table, S: SAM, B: BAM, P: PAF
                        (default: T)
  -f                    As a default, syri filters out low quality and small
                        alignments. Use this parameter to use the full list of
                        alignments without any filtering. (default: True)
  -k                    Keep intermediate output files (default: False)
  --dir DIR             path to working directory (if not current directory).
                        All files must be in this directory. (default: None)
  --prefix PREFIX       Prefix to add before the output file Names (default: )
  --seed SEED           seed for generating random numbers (default: 1)
  --nc NCORES           number of cores to use in parallel (max is number of
                        chromosomes) (default: 1)
  --novcf               Do not combine all files into one output file
                        (default: False)
  --samplename SNAME    Sample name to be used in the output VCF file.
                        (default: sample)

SR identification:
  --nosr                Set to skip structural rearrangement identification
                        (default: False)
  --invgaplen INVGL     Maximum allowed gap-length between two alignments of a
                        multi-alignment inversion. It affects the selection of
                        large inversions that can have different length in the
                        reference and query genomes. (default: 1000000000)
  --tdgaplen TDGL       Maximum allowed gap-length between two alignments of a
                        multi-alignment translocation or duplication (TD).
                        Larger values increases TD identification sensitivity
                        but also runtime. (default: 500000)
  --tdmaxolp TDOLP      Maximum allowed overlap between two translocations.
                        Value should be in range (0,1]. (default: 0.8)
  -b BRUTERUNTIME       Cutoff to restrict brute force methods to take too
                        much time (in seconds). Smaller values would make
                        algorithm faster, but could have marginal effects on
                        accuracy. In general case, would not be required.
                        (default: 60)
  --unic TRANSUNICOUNT  Number of uniques bps for selecting translocation.
                        Smaller values would select smaller TLs better, but
                        may increase time and decrease accuracy. (default:
                        1000)
  --unip TRANSUNIPERCENT
                        Percent of unique region requried to select
                        translocation. Value should be in range (0,1]. Smaller
                        values would allow selection of TDs which are more
                        overlapped with other regions. (default: 0.5)
  --inc INCREASEBY      Minimum score increase required to add another
                        alignment to translocation cluster solution (default:
                        1000)
  --no-chrmatch         Do not allow SyRI to automatically match chromosome
                        ids between the two genomes if they are not equal
                        (default: False)

ShV identification:
  --nosv                Set to skip structural variation identification
                        (default: False)
  --nosnp               Set to skip SNP/Indel (within alignment)
                        identification (default: False)
  --all                 Use duplications too for variant identification
                        (default: False)
  --allow-offset OFFSET
                        BPs allowed to overlap (default: 5)
  --cigar               Find SNPs/indels using CIGAR string. Necessary for
                        alignments generated using aligners other than nucmers
                        (default: False)
  -s SSPATH             path to show-snps from mummer (default: show-snps)
  --hdrseq              Output highly-diverged regions (HDRs) sequence.
                        (default: False)
  --maxsize MAXS        Max size for printing sequence of large SVs
                        (insertions, deletions and HDRs). Only affect printing
                        (.out/.vcf file) and not the selection. SVs larger
                        than this value would be printed as symbolic SVs. For
                        no cut-off use -1. (default: -1)

options:
  -h, --help            show this help message and exit
  --log {DEBUG,INFO,WARN}
                        log level (default: INFO)
  --lf LOG_FIN          Name of log file (default: syri.log)
  --version             show program's version number and exit
```

