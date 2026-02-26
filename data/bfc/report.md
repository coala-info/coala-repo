# bfc CWL Generation Report

## bfc

### Tool Description
Corrects sequencing errors in FASTQ files using a Bloom filter and k-mer counting.

### Metadata
- **Docker Image**: quay.io/biocontainers/bfc:r181--h577a1d6_12
- **Homepage**: https://github.com/Wilfred/bfc
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bfc/overview
- **Total Downloads**: 16.4K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/Wilfred/bfc
- **Stars**: N/A
### Original Help Text
```text
Usage: bfc [options] <to-count.fq> [to-correct.fq]
Options:
  -s FLOAT     approx genome size (k/m/g allowed; change -k and -b) [unset]
  -k INT       k-mer length [33]
  -t INT       number of threads [1]
  -b INT       set Bloom filter size to pow(2,INT) bits [33]
  -H INT       use INT hash functions for Bloom filter [4]
  -d FILE      dump hash table to FILE [null]
  -E           skip error correction
  -R           refine bfc-corrected reads
  -r FILE      restore hash table from FILE [null]
  -w INT       no more than 5 ec or 2 highQ ec in INT-bp window [10]
  -c INT       min k-mer coverage [3]
  -Q           force FASTA output
  -1           drop reads containing unique k-mers
  -v           show version number
  -h           show command line help
```

