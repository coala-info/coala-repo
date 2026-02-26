# bifrost CWL Generation Report

## bifrost_Bifrost

### Tool Description
Highly parallel construction, indexing and querying of colored and compacted de Bruijn graphs

### Metadata
- **Docker Image**: quay.io/biocontainers/bifrost:1.3.5--h5ca1c30_3
- **Homepage**: https://github.com/pmelsted/bifrost
- **Package**: https://anaconda.org/channels/bioconda/packages/bifrost/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bifrost/overview
- **Total Downloads**: 34.6K
- **Last updated**: 2025-08-04
- **GitHub**: https://github.com/pmelsted/bifrost
- **Stars**: N/A
### Original Help Text
```text
Bifrost 1.3.5

Highly parallel construction, indexing and querying of colored and compacted de Bruijn graphs

Usage: Bifrost [COMMAND] [PARAMETERS]

[COMMAND]:

   build                   Build a compacted de Bruijn graph, with or without colors
   update                  Update a compacted (colored) de Bruijn graph with new sequences
   query                   Query a compacted (colored) de Bruijn graph

[PARAMETERS]: build

   > Mandatory with required argument:

   -s, --input-seq-file     Input sequence file in fasta/fastq(.gz) format
                            Multiple files can be provided as a list in a text file (one file per line)
                            K-mers with exactly 1 occurrence in the input sequence files will be discarded
   -r, --input-ref-file     Input reference file in fasta/fastq(.gz) or gfa(.gz) format
                            Multiple files can be provided as a list in a text file (one file per line)
                            All k-mers of the input reference files are used
   -o, --output-file        Prefix for output file(s)

   > Optional with required argument:

   -t, --threads            Number of threads (default: 1)
   -k, --kmer-length        Length of k-mers (default: 31)
   -m, --min-length         Length of minimizers (default: auto)
   -B, --bloom-bits         Number of Bloom filter bits per k-mer (default: 24)
   -T, --tmp-dir            Path for tmp directory (default: creates tmp directory in output directory)
   -l, --load-mbbf          Input Blocked Bloom Filter file, skips filtering step (default: no input)
   -w, --write-mbbf         Output Blocked Bloom Filter file (default: no output)

   > Optional with no argument:

   -c, --colors             Color the compacted de Bruijn graph
   -i, --clip-tips          Clip tips shorter than k k-mers in length
   -d, --del-isolated       Delete isolated contigs shorter than k k-mers in length
   -f, --fasta-out          Output file in fasta format (only sequences) instead of gfa (unless graph is colored)
   -b, --bfg-out            Output file in bfg/bfi format (Bifrost graph/index) instead of gfa (unless graph is colored)
   -n, --no-compress-out    Output files must be uncompressed
   -N, --no-index-out       Do not make index file
   -v, --verbose            Print information messages during execution

[PARAMETERS]: update

  > Mandatory with required argument:

   -g, --input-graph-file   Input graph file to update in gfa(.gz) or bfg format
   -s, --input-seq-file     Input sequence file in fasta/fastq(.gz) format
                            Multiple files can be provided as a list in a text file (one file per line)
                            K-mers with exactly 1 occurrence in the input sequence files will be discarded
   -r, --input-ref-file     Input reference file in fasta/fastq(.gz) or gfa(.gz) format
                            Multiple files can be provided as a list in a text file (one file per line)
                            All k-mers of the input reference files are used
   -o, --output-file        Prefix for output file(s)

   > Optional with required argument:

   -I, --input-index-file   Input index file associated with graph to update in bfi format
   -C, --input-color-file   Input color file associated with graph to update in color.bfg format
   -t, --threads            Number of threads (default: 1)
   -k, --kmer-length        Length of k-mers (default: read from input graph file if built with Bifrost or 31)
   -m, --min-length         Length of minimizers (default: read from input graph if built with Bifrost, auto otherwise)
   -T, --tmp-dir            Path for tmp directory (default: creates tmp directory in output directory)

   > Optional with no argument:

   -i, --clip-tips          Clip tips shorter than k k-mers in length
   -d, --del-isolated       Delete isolated contigs shorter than k k-mers in length
   -f, --fasta-out          Output file in fasta format (only sequences) instead of gfa (unless colors are output)
   -b, --bfg-out            Output file in bfg/bfi format (Bifrost graph/index) instead of gfa (unless graph is colored)
   -n, --no-compress-out    Output files must be uncompressed
   -N, --no-index-out       Do not make index file
   -v, --verbose            Print information messages during execution

[PARAMETERS]: query

  > Mandatory with required argument:

   -g, --input-graph-file   Input graph file to query in gfa(.gz) or bfg format.
   -q, --input-query-file   Input query file in fasta/fastq(.gz) format.. Each record is a query.
                            Multiple files can be provided as a list in a text file (one file per line)
   -o, --output-file        Prefix for output file

   > Optional with required argument:

   -e, --min_ratio-kmers    Minimum ratio of k-mers from each query that must occur in the graph
   -E, --min-nb-colors      Minimum number of colors from each query that must occur in the graph
   -I, --input-index-file   Input index file associated with graph to query in bfi format
   -C, --input-color-file   Input color file associated with the graph to query in color.bfg format
   -t, --threads            Number of threads (default: 1)
   -k, --kmer-length        Length of k-mers (default: read from input graph if built with Bifrost or 31)
   -m, --min-length         Length of minimizers (default: read from input graph if built with Bifrost, auto otherwise)
   -T, --tmp-dir            Path for tmp directory (default: creates tmp directory in output directory)

   > Optional with no argument:

   -Q, --files-as-queries   All fastq/fastq records in each input query file constitute a single query.
   -p, --ratio-found-km     Output the ratio of found k-mers for each query (disable parameters -e and -E)
   -a, --approximate        Graph is searched using exact and inexact k-mers (1 substitution or indel allowed per k-mer)
   -v, --verbose            Print information messages during execution
```

