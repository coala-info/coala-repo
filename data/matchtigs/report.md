# matchtigs CWL Generation Report

## matchtigs

### Tool Description
minimum plain text representation of kmer sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/matchtigs:2.1.9--hc1c3326_0
- **Homepage**: https://github.com/algbio/matchtigs.git
- **Package**: https://anaconda.org/channels/bioconda/packages/matchtigs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/matchtigs/overview
- **Total Downloads**: 23.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/algbio/matchtigs
- **Stars**: N/A
### Original Help Text
```text
Matchtigs: minimum plain text representation of kmer sets.

Usage: matchtigs [OPTIONS]

Options:
      --gfa-in <GFA_IN>
          GFA file containing the input unitigs. Either a GFA input file a fasta input file, or a bcalm input file must be given
      --fa-in <FA_IN>
          Fasta file containing the input unitigs. If possible, pass GFA or bcalm2 fasta files, as those contain the topology of the graph, speeding up the parsing process. Either a GFA input file a fasta input file, or a bcalm input file must be given. If the file ends in '.gz', then it is expected to be gzip-compressed
      --bcalm-in <BCALM_IN>
          Bcalm2 Fasta file containing the input unitigs. Bcalm2 encodes the topology of the graph inside the fasta file, which makes using this option faster than `--fa-in` for bcalm2 fasta files. Either a GFA input file a fasta input file, or a bcalm input file must be given. If the file ends in '.gz', then it is expected to be gzip-compressed
      --pathtigs-gfa-out <PATHTIGS_GFA_OUT>
          Compute pathtigs and write them to the given file in GFA format. If the file ends in '.gz', then it will be gzip-compressed
      --pathtigs-fa-out <PATHTIGS_FA_OUT>
          Compute pathtigs and write them to the given file in fasta format. If the file ends in '.gz', then it will be gzip-compressed
      --eulertigs-gfa-out <EULERTIGS_GFA_OUT>
          Compute eulertigs and write them to the given file in GFA format. If the file ends in '.gz', then it will be gzip-compressed
      --eulertigs-fa-out <EULERTIGS_FA_OUT>
          Compute eulertigs and write them to the given file in fasta format. If the file ends in '.gz', then it will be gzip-compressed
      --greedytigs-gfa-out <GREEDYTIGS_GFA_OUT>
          Compute greedy matchtigs and write them to the given file in GFA format. If the file ends in '.gz', then it will be gzip-compressed
      --greedytigs-fa-out <GREEDYTIGS_FA_OUT>
          Compute greedy matchtigs and write them to the given file in fasta format. If the file ends in '.gz', then it will be gzip-compressed
      --matchtigs-gfa-out <MATCHTIGS_GFA_OUT>
          Compute matchtigs and write them to the given file in GFA format. If the file ends in '.gz', then it will be gzip-compressed. WARNING: Uses `O(|V|^2)` memory
      --matchtigs-fa-out <MATCHTIGS_FA_OUT>
          Compute matchtigs and write them to the given file in fasta format. If the file ends in '.gz', then it will be gzip-compressed. WARNING: Uses `O(|V|^2)` memory
      --greedytigs-duplication-bitvector-out <GREEDYTIGS_DUPLICATION_BITVECTOR_OUT>
          Output a file with bitvectors in ASCII format, with a 0 for each duplicated instance of a kmer in the greedytigs. The bitvectors are separated by newline characters. Taking all kmers with a 1 results in a set of all original kmers with no duplicates. If the file ends in '.gz', then it will be gzip-compressed
      --matchtigs-duplication-bitvector-out <MATCHTIGS_DUPLICATION_BITVECTOR_OUT>
          Output a file with bitvectors in ASCII format, with a 0 for each duplicated instance of a kmer in the matchtigs. The bitvectors are separated by newline characters. Taking all kmers with a 1 results in a set of all original kmers with no duplicates. If the file ends in '.gz', then it will be gzip-compressed
  -k, --k <K>
          The kmer size used to compute the input unitigs. This is required when using a fasta file as input. GFA files contain the required information
  -t, --threads <THREADS>
          The number of threads used to compute greedy matchtigs and matchtigs [default: 1]
      --blossom5-command <BLOSSOM5_COMMAND>
          The command used to run blossom5 [default: blossom5]
      --dijkstra-node-weight-array-type <DIJKSTRA_NODE_WEIGHT_ARRAY_TYPE>
          The data structure to store the weight of visited nodes in Dijkstra's algorithm [default: HashbrownHashMap]
      --dijkstra-heap-type <DIJKSTRA_HEAP_TYPE>
          The heap data structure used by Dijkstra's algorithm [default: StdBinaryHeap]
      --dijkstra-performance-data-type <DIJKSTRA_PERFORMANCE_DATA_TYPE>
          The performance data collector used by Dijkstra's algorithm [default: None]
      --dijkstra-staged-parallelism-divisor <DIJKSTRA_STAGED_PARALLELISM_DIVISOR>
          If given enables staged parallelism mode. In this mode, the Dijkstras are executed first with full parallelism (according to the given number of threads) but with limited memory resources (see `--dijkstra-resource-limit-factor`). Then the number of threads is divided by this number, and the Dijkstras that failed before due to resource limitations are retried with more resources. The resources are increased relative to the number of threads, i.e. if the number of threads is divided by four, then the resources each thread has is multiplied by four
      --dijkstra-resource-limit-factor <DIJKSTRA_RESOURCE_LIMIT_FACTOR>
          Limits the memory used by each Dijkstra execution if in staged parallelism mode (see `--dijkstra-staged-parallelism-divisor`). Each thread is allowed to use queue space as well as distance array space to store up to `NODES * FACTOR / THREADS` nodes. `NODES` is the number of nodes, `FACTOR` is the factor given by this parameter, and `THREADS` is the number of threads. The number of threads decreases in each stage of execution as described in `--dijkstra-staged-parallelism-divisor` [default: 1]
      --debug-print-graph
          Print the de Bruijn graph constructed from the input unitigs
      --debug-print-walks
          Print the tigs as sequences of edge ids
      --log-level <LOG_LEVEL>
          [default: Info]
      --compression-level <COMPRESSION_LEVEL>
          A value from 0-9 indicating the level of compression used when output. 0 means no compression but fast output, while 9 means "take as long as you like". This only has an effect for output files that end in ".gz" [default: 6]
  -h, --help
          Print help
  -V, --version
          Print version
```

