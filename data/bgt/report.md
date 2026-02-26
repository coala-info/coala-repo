# bgt CWL Generation Report

## bgt_import

### Tool Description
Import VCF/BCF files into BGT format

### Metadata
- **Docker Image**: quay.io/biocontainers/bgt:r283--h577a1d6_7
- **Homepage**: https://github.com/Dysman/bgTools-playerPrefsEditor
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bgt/overview
- **Total Downloads**: 13.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Dysman/bgTools-playerPrefsEditor
- **Stars**: N/A
### Original Help Text
```text
Usage: bgt import [options] <out-prefix> <in.bcf>|<in.vcf>|<in.vcf.gz>
Options:
  -S           input is VCF
  -t FILE      list of reference names and lengths [null]
  -F           keep filtered variants
  -1           generate .pb1 file (not used for now)
```


## bgt_atomize

### Tool Description
Atomize a VCF/BCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/bgt:r283--h577a1d6_7
- **Homepage**: https://github.com/Dysman/bgTools-playerPrefsEditor
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: bgt atomize [options] <in.bcf>|<in.vcf>
Options:
  -b       BCF output
  -S       VCF input
  -t FILE  list of contig names and lengths (force -S)
  -M       use <M> at a multi-allelic site (override -0)
  -0       use 0 at a multi-allelic genotype
```


## bgt_view

### Tool Description
View and convert VCF/BCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/bgt:r283--h577a1d6_7
- **Homepage**: https://github.com/Dysman/bgTools-playerPrefsEditor
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: bgt view [options] <bgt-prefix> [...]
Options:
  Sample selection:
    -s EXPR      samples list (,sample1,sample2 or a file or expr; see Notes below) [all]
  Site selection:
    -r STR       region [all]
    -B FILE      extract variants overlapping BED FILE []
    -e           exclude variants overlapping BED FILE (effective with -B)
    -i INT       process from the INT-th record (1-based) []
    -n INT       process at most INT records []
    -d FILE      variant annotations in FMF (to work with -a) []
    -M           load variant annotations in RAM (only with -d)
    -a EXPR      alleles list chr:1basedPos:refLen:seq (,allele1,allele2 or a file or expr) []
    -f STR       frequency filters []
  VCF output:
    -b           BCF output (effective without -S/-H)
    -l INT       compression level for BCF [default]
    -u           equivalent to -bl0 (overriding -b and -l)
    -G           don't output sample genotypes
    -C           write AC/AN to the INFO field (auto applied with -f or multipl -s)
  Non-VCF output:
    -S           show samples with a set of alleles (with -a)
    -H           count of haplotypes with a set of alleles (with -a)
    -t STR       comma-delimited list of fields to output. Accepted variables:
                 AC, AN, AC#, AN#, CHROM, POS, END, REF, ALT (# for a group number)
Notes:
  For option -s/-a, EXPR can be one of:
    1) comma-delimited list following a colon/comma. e.g. -s,NA12878,NA12044
    2) space-delimited file with the first column giving a sample/allele name. e.g. -s list.txt
    3) expression if .spl/-d file contains metadata. e.g.: -s"gender=='M'&&population!='CEU'"
  If multiple -s is specified, the AC/AN of the first group will be written to VCF INFO AC1/AN1,
  the second to AC2/AN2, etc.
```


## bgt_fmf

### Tool Description
Process FMF files

### Metadata
- **Docker Image**: quay.io/biocontainers/bgt:r283--h577a1d6_7
- **Homepage**: https://github.com/Dysman/bgTools-playerPrefsEditor
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: fmf [-mn] <in.fmf> [condition]
Options:
  -m   load the entire FMF into RAM
  -n   only output the row name (the 1st column)
```


## bgt_bcfidx

### Tool Description
Index a BCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bgt:r283--h577a1d6_7
- **Homepage**: https://github.com/Dysman/bgTools-playerPrefsEditor
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
bcfidx: invalid option -- '-'
bcfidx: invalid option -- 'h'
bcfidx: invalid option -- 'e'
bcfidx: invalid option -- 'l'
bcfidx: invalid option -- 'p'
Usage: bgt bcfidx [-s minShift] <in.bcf>
```


## Metadata
- **Skill**: generated
