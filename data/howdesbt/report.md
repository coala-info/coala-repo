# howdesbt CWL Generation Report

## howdesbt_makebf

### Tool Description
convert a sequence file to a bloom filter

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Total Downloads**: 22.8K
- **Last updated**: 2025-06-18
- **GitHub**: https://github.com/medvedevgroup/HowDeSBT
- **Stars**: N/A
### Original Help Text
```text
makebf-- convert a sequence file to a bloom filter
usage: makebf <filename> [<filename>..] [options]
  <filename>         (cumulative) a sequence file, e.g. fasta, fastq, or kmers
                     (one bloom filter is created, for the union of the
                     sequence files)
  --kmersin          input files are kmers
                     (by default input files are expected to be fasta or fastq)
  --out=<filename>   name for bloom filter file
                     (by default this is derived from first sequence filename)
  --list=<filename>  file containing a list of bloom filters to create; this is
                     used in place of the <filename>s on the command line; the
                     file format is described below
  --asper=<filename> name of an existing bloom filter file to extract settings
                     from; that file's --k, --hashes, --seed, --modulus,
                     --bits and compression type will be used if they are not
                     otherwise specified on the command line
  --k=<N>            kmer size (number of nucleotides in a kmer)
                     (default is 20)
  --min=<N>          kmers occuring fewer than N times are left out of the
                     bloom filter; this does not apply when --kmersin is used
                     (default is 1)
  --threads=<N>      number of threads to use during kmerization
                     (default is 1)
  --hashes=<N>       how many hash functions to use for the filter
                     (default is 1)
  --seed=<number>    the hash function's 56-bit seed
  --seed=<number>,<number>  both the hash function seeds; the second seed is
                     only used if more than one hash function is being used
                     (by default the second seed is the first seed plus 1)
  --modulus=<M>      set the hash modulus, if larger than the number of bits
                     (by default this is the same as the number of bits)
  --bits=<N>         number of bits in the bloom filter
                     (default is 500000)
  --uncompressed     make the filter with uncompressed bit vector(s)
                     (this is the default)
  --rrr              make the filter with RRR-compressed bit vector(s)
  --roar             make the filter with roar-compressed bit vector(s)
  --stats[=<filename>] write bloom filter stats to a text file
                     (if no filename is given this is derived from the bloom
                     filter filename)

When --list is used, each line of the file corresponds to a bloom filter. The
format of each line is
  <filename> [<filename>..] [--kmersin] [--out=<filename>]
with meaning the same as on the command line. No other options (e.g. --k or
--bits) are allowed in the file. These are specified on the command line and
will affect all the bloom filters.

When --kmersin is used, each line of the sequence input files is a single kmer,
as the first field in the line. Any additional fields on the line are ignored.
For example, with --k=20 this might be
  ATGACCAGATATGTACTTGC
  TCTGCGAACCCAGACTTGGT
  CAAGACCTATGAGTAGAACG
   ...
Every kmer in the file(s) is added to the filter. No counting is performed,
and --min is not allowed.
```


## howdesbt_cluster

### Tool Description
determine a tree topology by clustering bloom filters

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
cluster-- determine a tree topology by clustering bloom filters
usage: cluster [options]
  --list=<filename> file containing a list of bloom filters to cluster; only
                    filters with uncompressed bit vectors are allowed
  <filename>        same as --list=<filename>
  --out=<filename>  name for tree toplogy file
                    (by default this is derived from the list filename)
  --tree=<filename> same as --out=<filename>
  --nodename=<template> filename template for internal tree nodes
                    this must contain the substring {number}
                    (by default this is derived from the list filename)
  <start>..<end>    interval of bits to use from each filter; the clustering
                    algorithm only considers this subset of each filter's bits
                    (by default we use the first 100000 bits)
  --bits=<N>        number of bits to use from each filter; same as 0..<N>
  --cull            remove nodes from the binary tree; remove those for which
                    saturation of determined is more than 2 standard deviations
                    below the mean
                    (this is the default)
  --cull=<Z>sd      remove nodes for which saturation of determined is more
                    than <Z> standard deviations below the mean
  --cull=<S>        remove nodes for which saturation of determined is less
                    than <S>; e.g. <S> can be "0.20" or "20%"
  --keepallnodes    keep all nodes of the binary tree
  --nocull          (same as --keepallnodes)
  --nobuild         perform the clustering but don't build the tree's nodes
                    (this is the default)
  --build           perform clustering, then build the uncompressed nodes
```

