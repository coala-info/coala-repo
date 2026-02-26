# ropebwt3 CWL Generation Report

## ropebwt3_sw

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Total Downloads**: 7.1K
- **Last updated**: 2025-11-26
- **GitHub**: https://github.com/lh3/ropebwt3
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
ERROR: unknown option
```


## ropebwt3_mem

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
ERROR: unknown option
```


## ropebwt3_hapdiv

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
ERROR: unknown option
```


## ropebwt3_suffix

### Tool Description
Build suffix array and BWT for a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 suffix [options] <idx.fmr> <seq.fa> [...]
```


## ropebwt3_build

### Tool Description
Builds a BWT index for a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 build [options] <in.fa> [...]
Options:
  Algorithm:
    -m NUM      batch size [7G]
    -t INT      total number of threads [4]
    -p INT      #threads for sais and run sais and merge together (more RAM) [0]
    -l INT      leaf block size in B+-tree [512]
    -n INT      max number children per internal node [64]
    -2          use the ropebwt2 algorithm (libsais by default)
    -s          build BWT in the reverse lexicographical order (RLO; force -2)
    -r          build BWT in RCLO (force -2)
  Input:
    -i FILE     read existing index from FILE []
    -L          one sequence per line in the input
    -F          no forward strand
    -R          no reverse strand
  Output:
    -o FILE     output to FILE [stdout]
    -d          dump in the fermi-delta format (FMD)
    -b          dump in the ropebwt format (FMR)
    -e          dump in the BRE format
    -T          output the index in the Newick format (for debugging)
    -S FILE     save the current index to FILE after each input file []
```


## ropebwt3_merge

### Tool Description
Merge multiple FMR files into a single FMR file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 merge [options] <base.fmr> <other1.fmr> [...]
Options:
  -t INT     number of threads [1]
  -o FILE    output FMR to FILE [stdout]
```


## ropebwt3_plain2fmd

### Tool Description
Convert plain text to FM-index

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 plain2fmd [-o output.fmd] <in.txt>
```


## ropebwt3_ssa

### Tool Description
Builds a suffix array for a FM-index.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 ssa [options] <in.fmd>
Options:
  -t INT     number of threads [4]
  -s INT     sample rate one SA per 2**INT bases [8]
  -o FILE    output to file [stdout]
```


## ropebwt3_get

### Tool Description
Get sequences from an FMR index

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 get <idx.fmr> <int> [...]
```


## ropebwt3_stat

### Tool Description
Compute statistics for an FMD-index.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 stat [-M] <idx.fmd>
```


## ropebwt3_kount

### Tool Description
Count k-mers in FMD-index files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 kount [options] <in1.fmd> [in2.fmd [...]]
Options:
  -k INT       k-mer length [51]
  -m INT       min k-mer occurrence [100]
```


## ropebwt3_fa2line

### Tool Description
Convert FASTA file to line-based format

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ropebwt3 fa2line [options] <seq.fa> [...]
```


## ropebwt3_fa2kmer

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
- **Homepage**: https://github.com/lh3/ropebwt3
- **Package**: https://anaconda.org/channels/bioconda/packages/ropebwt3/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
ERROR: unknown option
```

