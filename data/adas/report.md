# adas CWL Generation Report

## adas

### Tool Description
FAIL to generate CWL: adas not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/adas:0.1.3--h3ab6199_0
- **Homepage**: https://github.com/jianshu93/adas
- **Package**: https://anaconda.org/channels/bioconda/packages/adas/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/adas/overview
- **Total Downloads**: 804
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jianshu93/adas
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: adas not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: adas not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## adas_adas-build

### Tool Description
Build Hierarchical Navigable Small World Graphs (HNSW) with MinHash sketching

### Metadata
- **Docker Image**: quay.io/biocontainers/adas:0.1.3--h3ab6199_0
- **Homepage**: https://github.com/jianshu93/adas
- **Package**: https://anaconda.org/channels/bioconda/packages/adas/overview
- **Validation**: PASS
### Original Help Text
```text
************** initializing logger *****************

Build Hierarchical Navigable Small World Graphs (HNSW) with MinHash sketching

Usage: adas-build [OPTIONS] --input <FASTA_FILE>

Options:
  -i, --input <FASTA_FILE>
          Input FASTA file
  -k, --kmer-size <KMER_SIZE>
          Size of k-mers, must be ≤14 [default: 8]
  -s, --sketch-size <SKETCH_SIZE>
          Size of the sketch [default: 512]
  -t, --threads <THREADS>
          Number of threads for sketching [default: 1]
      --hnsw-ef <HNSW_EF>
          HNSW ef parameter [default: 1600]
      --max_nb_connection <HNSW_MAX_NB_CONN>
          HNSW max_nb_conn parameter [default: 255]
      --scale_modify_f <scale_modify>
          scale modification factor in HNSW or HubNSW, must be in [0.2,1] [default: 1.0]
  -h, --help
          Print help
  -V, --version
          Print version
```

## adas_adas-search

### Tool Description
Search against Pre-built Hierarchical Navigable Small World Graphs (HNSW) Index

### Metadata
- **Docker Image**: quay.io/biocontainers/adas:0.1.3--h3ab6199_0
- **Homepage**: https://github.com/jianshu93/adas
- **Package**: https://anaconda.org/channels/bioconda/packages/adas/overview
- **Validation**: PASS
### Original Help Text
```text
************** initializing logger *****************

Search against Pre-built Hierarchical Navigable Small World Graphs (HNSW) Index

Usage: adas-search [OPTIONS] --input <FASTA_FILE> --nbng <NB_SEARCH_ANSWERS> --hnsw <DATADIR>

Options:
  -i, --input <FASTA_FILE>        Input FASTA file
  -n, --nbng <NB_SEARCH_ANSWERS>  Number of search answers [default: 128]
  -b, --hnsw <DATADIR>            directory contains pre-built HNSW database files
  -t, --threads <THREADS>         Number of threads for sketching [default: 1]
  -h, --help                      Print help
  -V, --version                   Print version
```

## adas_adas-insert

### Tool Description
Insert into Pre-built Hierarchical Navigable Small World Graphs (HNSW) Index

### Metadata
- **Docker Image**: quay.io/biocontainers/adas:0.1.3--h3ab6199_0
- **Homepage**: https://github.com/jianshu93/adas
- **Package**: https://anaconda.org/channels/bioconda/packages/adas/overview
- **Validation**: PASS
### Original Help Text
```text
************** initializing logger *****************

Insert into Pre-built Hierarchical Navigable Small World Graphs (HNSW) Index

Usage: adas-insert [OPTIONS] --input <FASTA_FILE> --hnsw <DATADIR>

Options:
  -i, --input <FASTA_FILE>  Input FASTA file
  -b, --hnsw <DATADIR>      directory contains pre-built HNSW database files
  -t, --threads <THREADS>   Number of threads for sketching [default: 1]
  -h, --help                Print help
  -V, --version             Print version
```

## adas_adas-chain

### Tool Description
Long Reads Alignment via Anchor Chaining

### Metadata
- **Docker Image**: quay.io/biocontainers/adas:0.1.3--h3ab6199_0
- **Homepage**: https://github.com/jianshu93/adas
- **Package**: https://anaconda.org/channels/bioconda/packages/adas/overview
- **Validation**: PASS
### Original Help Text
```text
Long Reads Alignment via Anchor Chaining

Usage: adas-chain [OPTIONS] --reference <REFERENCE_FASTA> --query <QUERY_FASTA> --output <OUTPUT_PATH>

Options:
  -r, --reference <REFERENCE_FASTA>  Reference FASTA file
  -q, --query <QUERY_FASTA>          Query FASTA file
  -t, --threads <THREADS>            Number of threads (default 1) [default: 1]
  -o, --output <OUTPUT_PATH>         Output path to write the results (SAM format)
  -h, --help                         Print help
  -V, --version                      Print version
```

## adas_adas-knn

### Tool Description
Extract K Nearest Neighbors (K-NN) from HNSW graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/adas:0.1.3--h3ab6199_0
- **Homepage**: https://github.com/jianshu93/adas
- **Package**: https://anaconda.org/channels/bioconda/packages/adas/overview
- **Validation**: PASS
### Original Help Text
```text
************** initializing logger *****************

Extract K Nearest Neighbors (K-NN) from HNSW graph.

Usage: adas-knn [OPTIONS] --hnsw <DATADIR> --output <OUTPUT_PATH>

Options:
  -b, --hnsw <DATADIR>             Directory containing pre-built HNSW database files
  -o, --output <OUTPUT_PATH>       Output path to write the neighbor list (sequence IDs)
  -n, --k-nearest-neighbors <KNN>  Number of k-nearest-neighbors to extract [default: 32]
  -h, --help                       Print help
  -V, --version                    Print version
```

