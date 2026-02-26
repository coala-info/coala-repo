# ptrimmer CWL Generation Report

## ptrimmer

### Tool Description
pTrimmer is a tool for trimming primer sequences from sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ptrimmer:1.4.0--h96c455f_1
- **Homepage**: https://github.com/DMU-lilab/pTrimmer
- **Package**: https://anaconda.org/channels/bioconda/packages/ptrimmer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ptrimmer/overview
- **Total Downloads**: 14.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/DMU-lilab/pTrimmer
- **Stars**: N/A
### Original Help Text
```text
[Err::ParseOpt::100] Please give the [required] parameters!
Program: pTrimmer (v1.4.0)
CreateDate: 2017-09-21
UpdateDate: 2024-01-10
Author: XiaolongZhang (xiaolongzhang2015@163.com)

Usage: pTrimmer [options]

Options:
       -h|--help        print help information
       -l|--keep        keep the complete reads if failed to locate primer
                        sequence [default: discard the reads]
       -t|--seqtype     [required] the sequencing type [single|pair]
       -a|--ampfile     [required] input amplicon file [.txt]
       -f|--read1       [required] read1(forward) for fastq file [.fq|.gz]
       -d|--trim1       [required] the trimmed read1 of fastq file
       -r|--read2       [optional] read2(reverse) for fastq file (paired-end seqtype) [.fq|.gz]
       -e|--trim2       [optional] the trimmed read2 of fastq file (paired-end seqtype)
       -z|--gzip        [optional] output trimmed fastq file in Gzip format
       -i|--info        [optional] add the primer information for each trimmed read
       -s|--summary     [optional] the trimming information of each amplicon [default: Summary.ampcount]
       -q|--minqual     [optional] the minimum average quality to keep after trimming [20]
       -k|--kmer        [optional] the kmer length for indexing [8]
       -m|--mismatch    [optional] the maximum mismatch for primer seq [3]
```

