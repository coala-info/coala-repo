# cobs CWL Generation Report

## cobs_doc-list

### Tool Description
list documents

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Total Downloads**: 13.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Error: argument for parameter path is required!

Usage: cobs doc-list [options] <path>
Parameters:
  path    path to documents to list
Options:
      --file-type  "list" to read a file list, or filter documents by file type 
                   (any, text, cortex, fasta, fastq, etc)
  -k, --term-size  term size (k-mer size), default: 31
```


## cobs_doc-dump

### Tool Description
Dump documents from a path

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

### Original Help Text
```text
Error: argument for parameter path is required!

Usage: cobs doc-dump [options] <path>
Parameters:
  path    path to documents to dump
Options:
      --file-type        "list" to read a file list, or filter documents by 
                         file type (any, text, cortex, fasta, fastq, etc)
      --no-canonicalize  don't canonicalize DNA k-mers, default: false
  -k, --term-size        term size (k-mer size), default: 31
```


## cobs_classic-construct

### Tool Description
Constructs a COBS index for a given input directory or file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

### Original Help Text
```text
Error: argument for parameter input is required!
Error: argument for parameter out_file is required!

Usage: cobs classic-construct [options] <input> <out_file>
Parameters:
  input     path to the input directory or file
  out_file  path to the output .cobs_classic index file 
Options:
  -C, --clobber              erase output directory if it exists
      --continue             continue in existing output directory
  -f, --false-positive-rate  false positive rate, default: 0.300000
      --file-type            "list" to read a file list, or filter documents by 
                             file type (any, text, cortex, fasta, fastq, etc)
      --keep-temporary       keep temporary files during construction
  -m, --memory               memory in bytes to use, default: 49.989 Gi
      --no-canonicalize      don't canonicalize DNA k-mers, default: false
  -h, --num-hashes           number of hash functions, default: 1
  -s, --sig-size             signature size, default: 0
  -k, --term-size            term size (k-mer size), default: 31
  -T, --threads              number of threads to use, default: max cores
      --tmp-path             directory for intermediate index files, default: 
                             out_file + ".tmp")
```


## cobs_classic-construct-random

### Tool Description
Constructs a random COBS index.

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

### Original Help Text
```text
Error: argument  for unsigned option -h, --num-hashes is missing!

Usage: cobs classic-construct-random [options] <out-file>
Parameters:
  out-file  path to the output file
Options:
  -m, --document-size   number of random 31-mers in document, default: 1000000
  -n, --num-documents   number of random documents in index, default: 10000
  -h, --num-hashes      number of hash functions, default: 1
      --seed            random seed
  -s, --signature-size  number of bits of the signatures (vertical size), 
                        default: 2 Mi
```


## cobs_compact-construct

### Tool Description
Constructs a COBS compact index.

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

### Original Help Text
```text
Error: argument for parameter input is required!
Error: argument for parameter out_file is required!

Usage: cobs compact-construct [options] <input> <out_file>
Parameters:
  input     path to the input directory or file
  out_file  path to the output .cobs_compact index file
Options:
  -C, --clobber              erase output directory if it exists
      --continue             continue in existing output directory
  -f, --false-positive-rate  false positive rate, default: 0.300000
      --file-type            "list" to read a file list, or filter documents by 
                             file type (any, text, cortex, fasta, fastq, etc)
      --keep-temporary       keep temporary files during construction
  -m, --memory               memory in bytes to use, default: 49.989 Gi
      --no-canonicalize      don't canonicalize DNA k-mers, default: false
  -h, --num-hashes           number of hash functions, default: 1
  -p, --page-size            the page size of the compact the index, default: 
                             sqrt(#documents)
  -k, --term-size            term size (k-mer size), default: 31
  -T, --threads              number of threads to use, default: max cores
      --tmp-path             directory for intermediate index files, default: 
                             out_file + ".tmp")
```


## cobs_compact-construct-combine

### Tool Description
Constructs and combines compact indexes from input directory to output file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

### Original Help Text
```text
Error: argument for parameter in-dir is required!
Error: argument for parameter out-file is required!

Usage: cobs compact-construct-combine [options] <in-dir> <out-file>
Parameters:
  in-dir    path to the input directory
  out-file  path to the output file
Options:
  -p, --page-size  the page size of the compact the index, default: 8192
```


## cobs_classic-combine

### Tool Description
Combines multiple COBS indices into a single index.

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

### Original Help Text
```text
Error: argument for parameter in-dir is required!
Error: argument for parameter out-dir is required!
Error: argument for parameter out-file is required!

Usage: cobs classic-combine [options] <in-dir> <out-dir> <out-file>
Parameters:
  in-dir    path to the input directory
  out-dir   path to the output directory
  out-file  path to the output file
Options:
      --keep-temporary  keep temporary files during construction
  -m, --memory          memory in bytes to use, default: 49.989 Gi
  -T, --threads         number of threads to use, default: max cores
```


## cobs_query

### Tool Description
Query the COBS index

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cobs query [options] [query]
Parameters:
  query   the text sequence to search for
Options:
  -f, --file           query (fasta) file to process
  -i, --index          path to index file(s)
      --index-sizes    WARNING: HIDDEN OPTION. USE ONLY IF YOU KNOW WHAT YOU 
                       ARE DOING. Precomputed file sizes of the index. Useful 
                       if --load-complete is given and indexes are streamed 
                       into COBS. This is a hidden option to be used with mof. 
                       This also implies COBS classic index, skipping double 
                       header reading due to streaming.
  -l, --limit          number of results to return, default: all
      --load-complete  load complete index into RAM for batch queries
  -T, --threads        number of threads to use, default: max cores
  -t, --threshold      threshold in percentage of terms in query matching, 
                       default: 0.8
```


## cobs_print-parameters

### Tool Description
Prints parameters for COBS.

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

### Original Help Text
```text
Error: argument  for unsigned option -h, --num-hashes is missing!

Usage: cobs print-parameters [options]
Options:
  -f, --false-positive-rate  false positive rate, default: 0.3
  -n, --num-elements         number of elements to be inserted into the index
  -h, --num-hashes           number of hash functions, default: 1
```


## cobs_print-kmers

### Tool Description
Prints all k-mers of a given DNA sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

### Original Help Text
```text
Error: argument for parameter query is required!

Usage: cobs print-kmers [options] <query>
Parameters:
  query   the dna sequence to search for
Options:
  -k, --kmer-size  the size of one kmer, default: 31
```


## cobs_benchmark-fpr

### Tool Description
Calculate false positive distribution for COBS

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

### Original Help Text
```text
Error: argument for parameter in_file is required!

Usage: cobs benchmark-fpr [options] <in_file>
Parameters:
  in_file  path to the input file
Options:
  -d, --dist       calculate false positive distribution
  -k, --num-kmers  number of kmers of each query, default: 1000
  -q, --queries    number of random queries to run, default: 10000
      --seed       random seed
  -w, --warmup     number of random warmup queries to run, default: 100
```


## cobs_generate-queries

### Tool Description
Generates positive and negative queries from base documents.

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: PASS

### Original Help Text
```text
Error: argument for parameter path is required!

Usage: cobs generate-queries [options] <path>
Parameters:
  path    path to base documents
Options:
      --file-type      "list" to read a file list, or filter documents by file 
                       type (any, text, cortex, fasta, fastq, etc)
  -n, --negative       construct this number of random non-existing negative 
                       queries, default: 0
  -o, --out-file       output file path
  -p, --positive       pick this number of existing positive queries, default: 0
  -S, --seed           random seed
  -s, --size           extend positive terms with random data to this size
  -k, --term-size      term size (k-mer size), default: 31
  -T, --threads        number of threads to use, default: max cores
  -N, --true-negative  check that negative queries actually are not in the 
                       documents (slow)
```


## cobs_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
- **Homepage**: https://panthema.net/cobs
- **Package**: https://anaconda.org/channels/bioconda/packages/cobs/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
COBS version 0.3.1
```

