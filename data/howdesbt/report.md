# howdesbt CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| howdesbt_bfdistance | PASS |  |
| howdesbt_bitstats | PASS |  |
| howdesbt_build | PASS |  |
| howdesbt_cluster | PASS |  |
| howdesbt_combinebf | PASS |  |
| howdesbt_compressbf | PASS |  |
| howdesbt_dumpbf | PASS |  |
| howdesbt_dumpbv | PASS |  |
| howdesbt_makebf | PASS |  |
| howdesbt_makebv | PASS |  |
| howdesbt_nodestats | PASS |  |
| howdesbt_query | PASS |  |
| howdesbt_querybf | PASS |  |
| howdesbt_validatetree | PASS |  |

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


## howdesbt_build

### Tool Description
build a sequence bloom tree from a topology file and leaves

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== build ===
build-- build a sequence bloom tree from a topology file and leaves
usage: build <filename> [options]
  <filename>           name of the tree toplogy file
  --outtree=<filename> name of topology file to write tree consisting of the
                       filters built
                       (by default we derive a name for the resulting topology
                       from the input filename; but by default no tree is)
                       written for --simple, as it would be the same as the
                       input tree)
  --simple             create tree nodes as simple bloom filters
                       (this is the default)
  --howde              equivalent to --determined,brief --rrr
  --allsome            create tree nodes as all/some bloom filters
  --determined         create tree nodes as determined/how bloom filters
  --determined,brief   create tree nodes as determined/how, but only store
                       active bits
  --uncompressed       create the nodes as uncompressed bit vector(s)
                       (this is the default)
  --rrr                create the nodes as rrr-compressed bit vector(s)
  --roar               create the nodes as roar-compressed bit vector(s)
```

## howdesbt_query

### Tool Description
query a sequence bloom tree

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== query ===
query-- query a sequence bloom tree
usage: query [<queryfilename>[=<F>]] [options]
  --tree=<filename>    name of the tree toplogy file
  <queryfilename>      (cumulative) name of a query file; this is either a
                       fasta file or a file with one nucleotide sequence per
                       line; if no query files are provided, queries are read
                       from stdin
  <queryfilename>=<F>  query file with associated threshold; <F> has the same
                       meaning as in --threshold=<F> but applies only to this
                       query file
  --threshold=<F>      fraction of query kmers that must be present in a leaf
                       to be considered a match; this must be between 0 and 1;
                       this only applies to query files for which <F> is not
                       otherwise specified (by <queryfilename>=<F>)
                       (default is 0.7)
  --adjust             adjust reported number of kmers present, compensating
                       for bloom filter false positives
  --sort               sort matched leaves by the number of query kmers present,
                       and report the number of kmers present
                       (by default we just report the matched leaves without
                       regard to which matches are better)
  --leafonly           disregard internal tree nodes and perform the query only
                       at the leaves
  --distinctkmers      perform the query counting each distinct kmer only once
                       (by default we count a query kmer each time it occurs)
  --consistencycheck   before searching, check that bloom filter properties are
                       consistent across the tree
                       (not needed with --usemanager)
  --justcountkmers     just report the number of kmers in each query, and quit
  --countallkmerhits   report the number of kmers that 'hit', for each
                       query/leaf
  --stat:nodesexamined report the count of nodes examined for each query (as a
                       comment in the output
  --time               report wall time and node i/o time
  --out=<filename>     file for query results; if this is not provided, results
                       are written to stdout
```

## howdesbt_querybf

### Tool Description
query a bloom filter, listing the kmers that "hit"

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== querybf ===
querybf-- query a bloom filter, listing the kmers that "hit"
usage: querybf [<queryfilename>[=<F>]] [options]
  --filter=<filename>  (cumulative) a bloom filter file (usually .bf)
  <queryfilename>      (cumulative) name of a query file; this is either a
                       fasta file or a file with one nucleotide sequence per
                       line; if no query files are provided, queries are read
                       from stdin
  <queryfilename>=<F>  query file with associated threshold; <F> has the same
                       meaning as in --threshold=<F> but applies only to this
                       query file
  --threshold=<F>      fraction of query kmers that must be present in a filter
                       to be considered a match; this must be between 0 and 1;
                       this only applies to query files for which <F> is not
                       otherwise specified (by <queryfilename>=<F>)
                       (default is 0.7)
  --distinctkmers      perform the query counting each distinct kmer only once
                       (by default we count a query kmer each time it occurs)
  --distinctkmers      perform the query counting each distinct kmer only once
                       (by default we count a query kmer each time it occurs)
  --report:all         report both present and absent kmers
                       (by default we only report kmers that are present)
```

## howdesbt_compressbf

### Tool Description
copy bloom filters using a different compression format

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== compressbf ===
compressbf-- copy bloom filters using a different compression format
usage: compressbf <filename> [<filename>..] [options]
  <filename>           (cumulative) a bloom filter file (usually .bf)
  --out=<template>     filename template for resulting bloom filter files;
                       this must contain the substring {in}, which is replaced
                       by the root of the input filename; this option is
                       usually only needed if the output filename would be the;
                       same as the input filename otherwise
                       (by default, we derive a filename from the input file;
                       using simple rules)
  --list=<filename>    file containing a list of bloom filters to compress;
                       this is used in place of the <filename>s on the command
                       line
  --tree=<filename>    name of topology file for tree containing the filters;
                       this is used in place of the <filename>s or --list
  --outtree=<filename> name of topology file to write tree consisting of the
                       compressed filters
                       (by default, when --tree is given, we derive a name for
                       the resulting topology from the input filename)
  --noouttree          don't write the resulting topology file
  --rrr                copy the filter(s) to rrr-compressed bit vector(s)
                       (this is the default)
  --roar               copy the filter(s) to roar-compressed bit vector(s)
  --uncompressed       copy the filter(s) to uncompressed bit vector(s)
                       (this may be very slow)
```

## howdesbt_combinebf

### Tool Description
combine several bloom filters into a single file

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== combinebf ===
combinebf-- combine several bloom filters into a single file
usage: combinebf <filename> [<filename>..] [options]
  <filename>            (cumulative) a bloom filter file (usually .bf); one
                        file is created, containing these bloom filters
  --out=<filename>      name for the combined bloom filter file
                        (by default this is derived from first filter filename)
  --list=<filename>     file containing a list of sets of bloom filters to
                        combine; this is used in place of the <filename>s on
                        the command line
  --siblings=<filename> name of a topology file; siblings from this file are
                        combined into one file for each parent; this is used in
                        place of the <filename>s or --list
  --outtree=<filename>  name of topology file in which to write a tree
                        incorporating the combined siblings
                        (by default, when --siblings is used, we derive a name
                        for the resulting topology from the input filename)
  --noouttree           don't write the resulting topology file
  --dryrun              report the files we'd combine, but don't do it
  --quiet               don't report what files we're combining

When --list is used, each line of the file corresponds to a set of bloom
filters. The format of each line is
  <filename> [<filename>..] [--out=<filename>]
with meaning the same as on the command line.
```

## howdesbt_nodestats

### Tool Description
report file sizes and node occupancy stats for a tree

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== nodestats ===
nodestats-- report file sizes and node occupancy stats for a tree
usage: nodestats <filename> [options]
  <filename>           name of the tree toplogy file
  --noshow:occupancy   don't report the number of 1s in each bit vector
                       (by default we report this, but it can be slow to
                       compute for compressed bit vector types that don't)
                       support rank/select)
```

## howdesbt_bitstats

### Tool Description
report bit stats for a tree

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== bitstats ===
bitstats-- report bit stats for a tree
usage: bitstats <filename> [options]
  <filename>      name of the tree toplogy file
  <start>..<end>  interval of bits to use from each filter; stats are collected
                  only on this subset of each filter's bits
                  (by default we use all bits from each filter)
  --bits=<N>      number of bits to use from each filter; same as 0..<N>
```

## howdesbt_validatetree

### Tool Description
validate that a tree's filters all have consistent properties

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== validatetree ===
validatetree-- validate that a tree's filters all have consistent properties
usage: validatetree <filename>
  <filename>  name of a topology file
  --union     verify the node union property
              (by default we only validate simple properties like the size of
              bloom filters)
```

## howdesbt_dumpbf

### Tool Description
dump the content of a bloom filter to the console

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== dumpbf ===
dumpbf-- dump the content of a bloom filter to the console
usage: dumpbf <filename> [<filename>..] [options]
  <filename>      (cumulative) a bloom filter file (usually .bf)
  --bits=<N>      limit of the number of bits to display from each filter
                  (default is 100)
  <start>..<end>  interval of bits to display from each filter
                  (exclusive of --bits)
  --wrap=<N>      number of bit positions allowed on a line
                  (by default all positions are on the same line)
  --chunk=<N>     number of bit positions shown in each chunk
                  (default is 10)
  --as01          show each bit as a 0 or 1
                  (by default we show zeros as '-' and ones as '+')
  --complement    show the bitwise complement of each filter
  --show:density  show fraction of ones in the filter (instead of showing bits)
  --show:checksum show a checksum of filter's bits (instead of showing bits)
  --show:integers show bit positions as a list of integers
  --show:header   show the filter's header info (instead of any bit data)
```

## howdesbt_bfdistance

### Tool Description
compute the bitwise distance between bloom filters

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== bfdistance ===
bfdistance-- compute the bitwise distance between bloom filters
usage: bfdistance <filename> [<filename>..] [options]
  <filename>         (cumulative) a bloom filter file (usually .bf)
                     only filters with uncompressed bit vectors are allowed
  --list=<filename>  file containing a list of bloom filters
  --focus=<filename> (cumulative) a bloom filter file (usually .bf)
                     (see description below)
  <start>..<end>     interval of bits to use from each filter; distance is
                     calculated only on this subset of each filter's bits
                     (by default we use all bits from each filter)
  --bits=<N>         number of bits to use from each filter; same as 0..<N>
  --show:hamming     show the distance as hamming distance
                     (this is the default)
  --show:intersect   show the 'distance' as the number of 1s in common
  --show:union       show the 'distance' as the number of 1s in either
  --show:theta       show the 'distance' from A to B as N/D, where D is the
                     number of 1s in A and N is the number of 1s A and B have
                     in common; when A is a query and B is a node, this metric
                     corresponds to the threshold setting in the query command

  Compute all-vs-all distances between bloom filters. The <filename>s, plus any
  filenames listed in the list file, comprise a collection of bloom filters.
  Normally, the distances between all pairs in this collection are reported.

  However, if --focus= is specified, the --focus=<filename>s comprise a second
  collection of bloom filters, and the distances between elements from each
  collection are reported.
```

## howdesbt_makebv

### Tool Description
convert a sequence file to a bit vector

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== makebv ===
makebv-- convert a sequence file to a bit vector
usage: makebv <filename> [<filename>..] [options]
  <filename>         (cumulative) a sequence file, e.g. fasta or fastq
                     (one bloom filter is created, for the union of the
                     sequence files)
  --kmersin          input files are kmers
                     (by default input files are expected to be fasta or fastq)
  --out=<filename>   name for bit vector file; the bit vector's compression
                     type is determined by the file extension (e.g. .bv, .rrr
                     or .roar)
                     (by default this is derived from first sequence filename,
                     and an uncompressed bit vector is created)
  --list=<filename>  file containing a list of bit vectors to create; this is
                     used in place of the <filename>s on the command line; the
                     file format is described below
  --asper=<filename> name of an existing bloom filter file to extract settings
                     from; that file's --k, --seed, and --bits will be used if
                     they are not otherwise specified on the command line
  --k=<N>            kmer size (number of nucleotides in a kmer)
                     (default is 20)
  --min=<N>          kmers occuring fewer than N times are left out of the
                     bloom filter
                     (default is 1)
  --threads=<N>      number of threads to use during kmerization
                     (default is 1)
  --seed=<number>    the hash function's 64-bit seed
  --bits=<N>         number of bits in the bloom filter
                     (default is 500000)

When --list is used, each line of the file corresponds to a bit vector. The
format of each line is
  <filename> [<filename>..] [--kmersin] [--out=<filename>]
with meaning the same as on the command line. No other options (e.g. --k or
--bits) are allowed in the file. These are specified on the command line and
will affect all the bit vectors.

When --kmersin is used, each line of the sequence input files is a single kmer,
as the first field in the line. Any additional fields on the line are ignored.
For example, with --k=20 this might be
  ATGACCAGATATGTACTTGC
  TCTGCGAACCCAGACTTGGT
  CAAGACCTATGAGTAGAACG
   ...
Every kmer in the file(s) is added to the bit vector. No counting is performed,
and --min is not allowed.
```

## howdesbt_dumpbv

### Tool Description
dump the content of bit vectors to the console

### Metadata
- **Docker Image**: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
- **Homepage**: https://github.com/medvedevgroup/HowDeSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/howdesbt/overview
- **Validation**: PASS

### Original Help Text
```text
=== dumpbv ===
dumpbv-- dump the content of bit vectors to the console
usage: dumpbv <filename> [<filename>..] [options]
  <filename>      (cumulative) a bit vector file, either .bv, .rrr or .roar
  <filename>:<type>[:<offset>][:<bytes>] bit vector is embedded in another
                  file; <type> is bv, rrr or roar; <offset> is location within
                  the file
  --vectors=<N>   number of bit vectors to generate for each filename; this
                  requires that the filename contain the substring {number}
  --bits=<N>      limit of the number of bits to display from each bit vector
                  (default is 100)
  <start>..<end>  interval of bits to display from each bit vector
                  (exclusive of --bits)
  --wrap=<N>      number of bit positions allowed on a line
                  (by default all positions are on the same line)
  --chunk=<N>     number of bit positions shown in each chunk
                  (default is 10)
  --as01          show each bit as a 0 or 1
                  (by default we show zeros as '-' and ones as '+')
  --complement    show the bitwise complement of each vector
  --show:density  show fraction of ones in the vector (instead of showing bits)
  --show:integers show bit positions as a list of integers
```

## Metadata
- **Skill**: generated
