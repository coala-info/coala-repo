# bindashtree CWL Generation Report

## bindashtree

### Tool Description
Binwise Densified MinHash and Rapid Neighbor-joining Tree Construction

### Metadata
- **Docker Image**: quay.io/biocontainers/bindashtree:0.1.1--h3ab6199_0
- **Homepage**: https://github.com/jianshu93/bindashtree
- **Package**: https://anaconda.org/channels/bioconda/packages/bindashtree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bindashtree/overview
- **Total Downloads**: 714
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jianshu93/bindashtree
- **Stars**: N/A
### Original Help Text
```text
************** initializing logger *****************

Binwise Densified MinHash and Rapid Neighbor-joining Tree Construction

Usage: bindashtree [OPTIONS] --input <INPUT_LIST_FILE> --output_tree <OUTPUT_TREE_FILE>

Options:
  -i, --input <INPUT_LIST_FILE>
          Genome list file (one FASTA/FNA file per line), .gz supported
  -k, --kmer_size <KMER_SIZE>
          K-mer size [default: 16]
  -s, --sketch_size <SKETCH_SIZE>
          MinHash sketch size [default: 10240]
  -d, --densification <DENS_OPT>
          Densification strategy: 0=Optimal Densification, 1=Reverse Optimal Densification/faster Densification [default: 0]
  -t, --threads <THREADS>
          Number of threads to use in parallel [default: 1]
      --tree <TREE_METHOD>
          Tree construction method: naive, rapidnj, hybrid [default: rapidnj]
      --chunk_size <chunk_size>
          Chunk size for RapidNJ/Hybrid methods [default: 30]
      --naive_percentage <naive_percentage>
          Percentage of steps naive for hybrid method [default: 90]
      --output_matrix <OUTPUT_MATRIX_FILE>
          Output the phylip distance matrix to a file
      --output_tree <OUTPUT_TREE_FILE>
          Output the resulting tree in Newick format to a file
  -h, --help
          Print help
  -V, --version
          Print version
```

