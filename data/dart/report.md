# dart CWL Generation Report

## dart

### Tool Description
DART v1.4.6 (Hsin-Nan Lin & Wen-Lian Hsu)

### Metadata
- **Docker Image**: quay.io/biocontainers/dart:1.4.6--h13024bc_7
- **Homepage**: https://github.com/hsinnan75/Dart
- **Package**: https://anaconda.org/channels/bioconda/packages/dart/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dart/overview
- **Total Downloads**: 34.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hsinnan75/Dart
- **Stars**: N/A
### Original Help Text
```text
DART v1.4.6 (Hsin-Nan Lin & Wen-Lian Hsu)

Usage: dart -i Index_Prefix -f <ReadFile_A1 ReadFile_B1 ...> [-f2 <ReadFile_A2 ReadFile_B2 ...>] -o|-bo Alignment_Output

Options: -t INT        number of threads [4]
         -f            files with #1 mates reads
         -f2           files with #2 mates reads
         -mis INT      maximal number of mismatches in an alignment
         -max_dup INT  maximal number of repetitive fragments (between 100-10000) [100]
         -o            alignment filename in SAM format
         -bo           alignment filename in BAM format
         -j            splice junction output filename [junctions.tab]
         -m            output multiple alignments [false]
         -all_sj       detect all splice junction regardless of mapq score [false]
         -p            paired-end reads are interlaced in the same file
         -unique       output unique alignments
         -max_intron   the maximal intron size [500000]
         -min_intron   the minimal intron size [10]
         -v            version
```

