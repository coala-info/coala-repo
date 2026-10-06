cwlVersion: v1.2
class: CommandLineTool
baseCommand: [Bifrost, query]
label: bifrost_query
doc: "Query a compacted (colored) de Bruijn graph\n\nTool homepage: https://github.com/pmelsted/bifrost"
inputs:
  - id: input_graph_file
    type: File
    doc: Input graph file to query in gfa(.gz) or bfg format
    inputBinding:
      position: 1
      prefix: -g
  - id: input_query_file
    type:
      type: array
      items: File
      inputBinding:
        prefix: -q
    doc: Input query files in fasta/fastq(.gz) format (or a text file listing them); each record is a
      query
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Prefix for output file
    inputBinding:
      position: 1
      prefix: -o
  - id: min_ratio_kmers
    type:
      - 'null'
      - float
    doc: Minimum ratio of k-mers from each query that must occur in the graph
    inputBinding:
      position: 1
      prefix: -e
  - id: min_nb_colors
    type:
      - 'null'
      - int
    doc: Minimum number of colors from each query that must occur in the graph
    inputBinding:
      position: 1
      prefix: -E
  - id: input_index_file
    type:
      - 'null'
      - File
    doc: Input index file associated with graph to query in bfi format
    inputBinding:
      position: 1
      prefix: -I
  - id: input_color_file
    type:
      - 'null'
      - File
    doc: Input color file associated with the graph to query in color.bfg format
    inputBinding:
      position: 1
      prefix: -C
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (default: 1)'
    inputBinding:
      position: 1
      prefix: -t
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'Length of k-mers (default: read from input graph if built with Bifrost or 31)'
    inputBinding:
      position: 1
      prefix: -k
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Length of minimizers (default: read from input graph if built with Bifrost, auto otherwise)'
    inputBinding:
      position: 1
      prefix: -m
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: 'Path for tmp directory (default: creates tmp directory in output directory)'
    inputBinding:
      position: 1
      prefix: -T
  - id: files_as_queries
    type:
      - 'null'
      - boolean
    doc: All fasta/fastq records in each input query file constitute a single query
    inputBinding:
      position: 1
      prefix: -Q
  - id: ratio_found_km
    type:
      - 'null'
      - boolean
    doc: Output the ratio of found k-mers for each query (disables -e and -E)
    inputBinding:
      position: 1
      prefix: -p
  - id: approximate
    type:
      - 'null'
      - boolean
    doc: Search the graph with exact and inexact k-mers (1 substitution or indel allowed per k-mer)
    inputBinding:
      position: 1
      prefix: -a
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print information messages during execution
    inputBinding:
      position: 1
      prefix: -v
outputs:
  - id: query_result
    type: File
    doc: Query result table (one row per query, one column per color)
    outputBinding:
      glob: $(inputs.output_file).tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifrost:1.3.5--h5ca1c30_3
