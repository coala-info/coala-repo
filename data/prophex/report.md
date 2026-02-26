# prophex CWL Generation Report

## prophex_index

### Tool Description
Constructs index for prophex

### Metadata
- **Docker Image**: quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2
- **Homepage**: https://github.com/prophyle/prophex
- **Package**: https://anaconda.org/channels/bioconda/packages/prophex/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prophex/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/prophyle/prophex
- **Stars**: N/A
### Original Help Text
```text
Usage:   prophex index [options] <idxbase>
Options: -k INT    k-mer length for k-LCP
         -s        construct k-LCP and SA in parallel
         -i        sampling distance for SA
         -h        print help message
```


## prophex_query

### Tool Description
Query a prophex index

### Metadata
- **Docker Image**: quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2
- **Homepage**: https://github.com/prophyle/prophex
- **Package**: https://anaconda.org/channels/bioconda/packages/prophex/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   prophex query [options] <idxbase> <in.fq>

Options: -k INT    length of k-mer
         -u        use k-LCP for querying
         -v        output set of chromosomes for every k-mer
         -p        do not check whether k-mer is on border of two contigs, and show such k-mers in output
         -b        print sequences and base qualities
         -l STR    log file name to output statistics
         -t INT    number of threads [1]
         -h        print help message
```


## prophex_klcp

### Tool Description
Construct k-LCP array

### Metadata
- **Docker Image**: quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2
- **Homepage**: https://github.com/prophyle/prophex
- **Package**: https://anaconda.org/channels/bioconda/packages/prophex/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   prophex klcp [options] <idxbase>

Options: -k INT    length of k-mer
         -s        construct k-LCP and SA in parallel
         -i        sampling distance for SA
         -h        print help message
```


## prophex_bwtdowngrade

### Tool Description
Downgrades a BWT index to an older version.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2
- **Homepage**: https://github.com/prophyle/prophex
- **Package**: https://anaconda.org/channels/bioconda/packages/prophex/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   prophex bwtdowngrade <input.bwt> <output.bwt>
         -h        print help message
```


## prophex_bwt2fa

### Tool Description
Convert BWT index to FASTA format

### Metadata
- **Docker Image**: quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2
- **Homepage**: https://github.com/prophyle/prophex
- **Package**: https://anaconda.org/channels/bioconda/packages/prophex/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   prophex bwt2fa <idxbase> <output.fa>
         -h        print help message
```

