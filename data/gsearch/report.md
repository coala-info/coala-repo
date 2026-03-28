# gsearch CWL Generation Report

## gsearch_tohnsw

### Tool Description
Build HNSW/HubNSW graph database from a collection of database genomes based on MinHash-like metric

### Metadata
- **Docker Image**: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
- **Homepage**: https://github.com/jean-pierreBoth/gsearch
- **Package**: https://anaconda.org/channels/bioconda/packages/gsearch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gsearch/overview
- **Total Downloads**: 18.4K
- **Last updated**: 2026-01-20
- **GitHub**: https://github.com/jean-pierreBoth/gsearch
- **Stars**: N/A
### Original Help Text
```text
************** initializing logger *****************

Build HNSW/HubNSW graph database from a collection of database genomes based on MinHash-like metric

Usage: gsearch tohnsw [OPTIONS] --dir <hnsw_dir> --kmer <kmer_size> --sketch <sketch_size> --nbng <neighbours> --algo <sketch_algo>

Options:
  -d, --dir <hnsw_dir>                 directory for storing database genomes
  -k, --kmer <kmer_size>               k-mer size to use
  -s, --sketch <sketch_size>           sketch size of minhash to use
  -n, --nbng <neighbours>              Maximum allowed number of neighbors (M) in HNSW
      --ef <ef>                        ef_construct in HNSW
      --scale_modify_f <scale_modify>  scale modification factor in HNSW or HubNSW, must be in [0.2,1] [default: 1.0]
      --algo <sketch_algo>             specifiy the algorithm to use for sketching: prob, super/super2, hll or optdens/revoptdens
      --aa                             --aa Specificy amino acid processing, require no value
      --block                          --block : sketching is done concatenating sequences
  -h, --help                           Print help
```


## gsearch_add

### Tool Description
Add new genome files to a pre-built HNSW graph database

### Metadata
- **Docker Image**: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
- **Homepage**: https://github.com/jean-pierreBoth/gsearch
- **Package**: https://anaconda.org/channels/bioconda/packages/gsearch/overview
- **Validation**: PASS

### Original Help Text
```text
************** initializing logger *****************

Add new genome files to a pre-built HNSW graph database

Usage: gsearch add --hnsw <hnsw_dir> --new <newdata_dir>

Options:
  -b, --hnsw <hnsw_dir>    set the name of directory containing already constructed hnsw data
  -n, --new <newdata_dir>  set directory containing new data
  -h, --help               Print help
```


## gsearch_request

### Tool Description
Request nearest neighbors of query genomes against a pre-built HNSW graph database/index

### Metadata
- **Docker Image**: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
- **Homepage**: https://github.com/jean-pierreBoth/gsearch
- **Package**: https://anaconda.org/channels/bioconda/packages/gsearch/overview
- **Validation**: PASS

### Original Help Text
```text
************** initializing logger *****************

Request nearest neighbors of query genomes against a pre-built HNSW graph database/index

Usage: gsearch request --hnsw <DATADIR> --nbanswers <nb_answers> --query <request_dir>

Options:
  -b, --hnsw <DATADIR>          directory contains pre-built database files
  -n, --nbanswers <nb_answers>  Sets the number of neighbors for the query
  -r, --query <request_dir>     Sets the directory of request genomes
  -h, --help                    Print help
```


## gsearch_ann

### Tool Description
Approximate Nearest Neighbor Embedding using UMAP-like algorithm

### Metadata
- **Docker Image**: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
- **Homepage**: https://github.com/jean-pierreBoth/gsearch
- **Package**: https://anaconda.org/channels/bioconda/packages/gsearch/overview
- **Validation**: PASS

### Original Help Text
```text
************** initializing logger *****************

Approximate Nearest Neighbor Embedding using UMAP-like algorithm

Usage: gsearch ann [OPTIONS] --hnsw <hnsw_dir>

Options:
  -b, --hnsw <hnsw_dir>  directory containing hnsw
  -s, --stats            to get stats on nb neighbours
  -e, --embed            --embed to do an embedding
  -h, --help             Print help
```


## Metadata
- **Skill**: not generated
