# slimfastq CWL Generation Report

## slimfastq

### Tool Description
Compresses and decompresses FASTQ files using a custom algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/slimfastq:2.04--h503566f_5
- **Homepage**: https://github.com/Infinidat/slimfastq
- **Package**: https://anaconda.org/channels/bioconda/packages/slimfastq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/slimfastq/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Infinidat/slimfastq
- **Stars**: N/A
### Original Help Text
```text
Usage: 
-u  usr-filename : (default: stdin)
-f comp-filename : required - compressed
-d               : decode (instead of encoding) 
-O               : silently overwrite existing files
-l level         : compression level 1 to 4 (default is 3 ) 
-1, -2, -3, -4   : alias for -l 1, -l 2, etc 
 Where levels are:
 1: Uses less than 4M memory (!), yields the worse compression (still much better than gzip)
 2: Uses about 30M memory, resonable compression 
 3: Uses about 80M memory, best compression <default level> 
 4: Compress a little more, but very costly (competition mode?) 

-v               : version : internal version 
-h               : help : this message 
-s               : stat : information about a compressed file 
-q               : suppress extra stats info that could have been seen by -s 

DWIM (Do what I mean) - Intuitive use of 'slimfastq A B' : 
If A appears to be a fastq file, and:
    B does not exists, or -O option is used: compress A to B 
If A appears to be a slimfastq file, and: 
    B does not exist, or -O option is used: decompress A to B 
    B is omitted: decompress A to stdout 
Examples: 
% slimfastq <file.fastq> <new-file.sfq>   : compress <file.fastq> to <new-file.sfq> 
% slimfastq -1 <file.fastq> <new-file.sfq*: compress <file.fastq> to <new-file.sfq>, using level 1 
% slimfastq <file.sfq>                    : decompress <file.sfq> to stdout 
% slimfastq <file.sfq> <file.fastq        : decompress <file.sfq> to <file.fastq*
% gzip -dc <file.fastq.gz> | slimfastq -f <file.sfq> : convert from gzip to sfq format
Verification example:
% md5sum <file.fastq>                      : remember checksum 
% slimfastq <file.fastq> <new-file.sfq>    : compress 
% slimfastq <new-file.sfq> | md5sum -      : decompress pipe to md5sum, compare checksums 

Note: to support pipes and reduce the use of resources, slimfastq was coded to run in a 
single thread. For a multi-session example - efficiently compressing multiple files in 
parallel - please use tools/slimfastq.multi -h (or make install; slimfastq.multi -h)
```

