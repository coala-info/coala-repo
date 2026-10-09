# kart CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| kart | PASS |  |
| kart_bwt_index | PASS |  |

## kart

### Tool Description
kart v2.5.6 (Hsin-Nan Lin & Wen-Lian Hsu)

### Metadata
- **Docker Image**: quay.io/biocontainers/kart:2.5.6--h13024bc_6
- **Homepage**: https://github.com/hsinnan75/Kart
- **Package**: https://anaconda.org/channels/bioconda/packages/kart/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kart/overview
- **Total Downloads**: 22.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hsinnan75/Kart
- **Stars**: N/A
### Original Help Text
```text
Error! Unknown parameter: --help
kart v2.5.6 (Hsin-Nan Lin & Wen-Lian Hsu)

Usage: kart -i Index_Prefix -f <ReadFile_A1 ReadFile_B1 ...> [-f2 <ReadFile_A2 ReadFile_B2 ...>] -o Output

Options: -t INT        number of threads [4]
         -f            files with #1 mates reads (format:fa, fq, fq.gz)
         -f2           files with #2 mates reads (format:fa, fq, fq.gz)
         -o            alignment filename in SAM format [output.sam]
         -bo           alignment filename in BAM format
         -m            output multiple alignments
         -g INT        max gaps (indels) [5]
         -p            paired-end reads are interlaced in the same file
         -pacbio       pacbio data
         -v            version
```

## kart_bwt_index

### Tool Description
Build the BWT index of a reference FASTA file for Kart

### Metadata
- **Docker Image**: quay.io/biocontainers/kart:2.5.6--h13024bc_6
- **Homepage**: https://github.com/hsinnan75/Kart
- **Package**: https://anaconda.org/channels/bioconda/packages/kart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bwt_index Ref_File[ex. ref.fa] Prefix[ex. MyRef]
```
