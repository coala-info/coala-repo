# yak CWL Generation Report

## yak_count

### Tool Description
Count k-mers in FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/yak:0.1--hed695b0_0
- **Homepage**: https://github.com/lh3/yak
- **Package**: https://anaconda.org/channels/bioconda/packages/yak/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yak/overview
- **Total Downloads**: 10.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lh3/yak
- **Stars**: N/A
### Original Help Text
```text
Usage: yak count [options] <in.fa> [in.fa]
Options:
  -k INT     k-mer size [31]
  -p INT     prefix length [10]
  -b INT     set Bloom filter size to 2**INT bits; 0 to disable [0]
  -H INT     use INT hash functions for Bloom filter [4]
  -t INT     number of worker threads [4]
  -o FILE    dump the count hash table to FILE []
  -K INT     chunk size [100m]
Note: -b37 is recommended for human reads
```


## yak_qv

### Tool Description
Calculate k-mer quality values (QV) for sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/yak:0.1--hed695b0_0
- **Homepage**: https://github.com/lh3/yak
- **Package**: https://anaconda.org/channels/bioconda/packages/yak/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yak qv [options] <kmer.hash> <seq.fa>
Options:
  -l NUM      min sequence length [0]
  -f FLOAT    min k-mer fraction [0.5]
  -e FLOAT    false positive rate [4e-05]
  -p          print QV for each sequence
  -t INT      number of threads [4]
  -K NUM      batch size [1g]
```


## yak_triobin

### Tool Description
Identify and extract triobins from yak files.

### Metadata
- **Docker Image**: quay.io/biocontainers/yak:0.1--hed695b0_0
- **Homepage**: https://github.com/lh3/yak
- **Package**: https://anaconda.org/channels/bioconda/packages/yak/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yak triobin [options] <pat.yak> <mat.yak> <seq.fa>
Options:
  -c INT     min occurrence [2]
  -d INT     mid occurrence [5]
  -t INT     number of threads [8]
```


## yak_trioeval

### Tool Description
Evaluate trios from yak files and a reference FASTA.

### Metadata
- **Docker Image**: quay.io/biocontainers/yak:0.1--hed695b0_0
- **Homepage**: https://github.com/lh3/yak
- **Package**: https://anaconda.org/channels/bioconda/packages/yak/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yak trioeval [options] <pat.yak> <mat.yak> <seq.fa>
Options:
  -c INT     min occurrence [2]
  -d INT     mid occurrence [5]
  -n INT     min streak [2]
  -t INT     number of threads [8]
```


## yak_inspect

### Tool Description
Evaluates k-mer QV and k-mer sensitivity.

### Metadata
- **Docker Image**: quay.io/biocontainers/yak:0.1--hed695b0_0
- **Homepage**: https://github.com/lh3/yak
- **Package**: https://anaconda.org/channels/bioconda/packages/yak/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yak inspect [options] <in1.yak> [in2.yak]
Options:
  -m INT    max count (effective with in2.yak) [20]
Notes: when in2.yak is present, inspect evaluates the k-mer QV of in1.yak and
  the k-mer sensitivity of in2.yak.
```

