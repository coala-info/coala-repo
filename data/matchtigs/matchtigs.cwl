cwlVersion: v1.2
class: CommandLineTool
baseCommand: matchtigs
label: matchtigs
doc: "minimum plain text representation of kmer sets.\n\nTool homepage: https://github.com/algbio/matchtigs.git"
inputs:
  - id: bcalm_in
    type:
      - 'null'
      - File
    doc: Bcalm2 Fasta file containing the input unitigs. Bcalm2 encodes the 
      topology of the graph inside the fasta file, which makes using this option
      faster than `--fa-in` for bcalm2 fasta files. Either a GFA input file a 
      fasta input file, or a bcalm input file must be given. If the file ends in
      '.gz', then it is expected to be gzip-compressed
    inputBinding:
      position: 101
      prefix: --bcalm-in
  - id: blossom5_command
    type:
      - 'null'
      - string
    doc: The command used to run blossom5
    inputBinding:
      position: 101
      prefix: --blossom5-command
  - id: compression_level
    type:
      - 'null'
      - int
    doc: A value from 0-9 indicating the level of compression used when output. 
      0 means no compression but fast output, while 9 means "take as long as you
      like". This only has an effect for output files that end in ".gz"
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: debug_print_graph
    type:
      - 'null'
      - boolean
    doc: Print the de Bruijn graph constructed from the input unitigs
    inputBinding:
      position: 101
      prefix: --debug-print-graph
  - id: debug_print_walks
    type:
      - 'null'
      - boolean
    doc: Print the tigs as sequences of edge ids
    inputBinding:
      position: 101
      prefix: --debug-print-walks
  - id: dijkstra_heap_type
    type:
      - 'null'
      - string
    doc: The heap data structure used by Dijkstra's algorithm
    inputBinding:
      position: 101
      prefix: --dijkstra-heap-type
  - id: dijkstra_node_weight_array_type
    type:
      - 'null'
      - string
    doc: The data structure to store the weight of visited nodes in Dijkstra's 
      algorithm
    inputBinding:
      position: 101
      prefix: --dijkstra-node-weight-array-type
  - id: dijkstra_performance_data_type
    type:
      - 'null'
      - string
    doc: The performance data collector used by Dijkstra's algorithm
    inputBinding:
      position: 101
      prefix: --dijkstra-performance-data-type
  - id: dijkstra_resource_limit_factor
    type:
      - 'null'
      - float
    doc: Limits the memory used by each Dijkstra execution if in staged 
      parallelism mode (see `--dijkstra-staged-parallelism-divisor`). Each 
      thread is allowed to use queue space as well as distance array space to 
      store up to `NODES * FACTOR / THREADS` nodes. `NODES` is the number of 
      nodes, `FACTOR` is the factor given by this parameter, and `THREADS` is 
      the number of threads. The number of threads decreases in each stage of 
      execution as described in `--dijkstra-staged-parallelism-divisor`
    inputBinding:
      position: 101
      prefix: --dijkstra-resource-limit-factor
  - id: dijkstra_staged_parallelism_divisor
    type:
      - 'null'
      - int
    doc: If given enables staged parallelism mode. In this mode, the Dijkstras 
      are executed first with full parallelism (according to the given number of
      threads) but with limited memory resources (see 
      `--dijkstra-resource-limit-factor`). Then the number of threads is divided
      by this number, and the Dijkstras that failed before due to resource 
      limitations are retried with more resources. The resources are increased 
      relative to the number of threads, i.e. if the number of threads is 
      divided by four, then the resources each thread has is multiplied by four
    inputBinding:
      position: 101
      prefix: --dijkstra-staged-parallelism-divisor
  - id: fa_in
    type:
      - 'null'
      - File
    doc: Fasta file containing the input unitigs. If possible, pass GFA or 
      bcalm2 fasta files, as those contain the topology of the graph, speeding 
      up the parsing process. Either a GFA input file a fasta input file, or a 
      bcalm input file must be given. If the file ends in '.gz', then it is 
      expected to be gzip-compressed
    inputBinding:
      position: 101
      prefix: --fa-in
  - id: gfa_in
    type:
      - 'null'
      - File
    doc: GFA file containing the input unitigs. Either a GFA input file a fasta 
      input file, or a bcalm input file must be given
    inputBinding:
      position: 101
      prefix: --gfa-in
  - id: k
    type:
      - 'null'
      - int
    doc: The kmer size used to compute the input unitigs. This is required when 
      using a fasta file as input. GFA files contain the required information
    inputBinding:
      position: 101
      prefix: --k
  - id: log_level
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --log-level
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads used to compute greedy matchtigs and matchtigs
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: pathtigs_gfa_out
    type:
      - 'null'
      - File
    doc: Compute pathtigs and write them to the given file in GFA format. If the
      file ends in '.gz', then it will be gzip-compressed
    outputBinding:
      glob: $(inputs.pathtigs_gfa_out)
  - id: pathtigs_fa_out
    type:
      - 'null'
      - File
    doc: Compute pathtigs and write them to the given file in fasta format. If 
      the file ends in '.gz', then it will be gzip-compressed
    outputBinding:
      glob: $(inputs.pathtigs_fa_out)
  - id: eulertigs_gfa_out
    type:
      - 'null'
      - File
    doc: Compute eulertigs and write them to the given file in GFA format. If 
      the file ends in '.gz', then it will be gzip-compressed
    outputBinding:
      glob: $(inputs.eulertigs_gfa_out)
  - id: eulertigs_fa_out
    type:
      - 'null'
      - File
    doc: Compute eulertigs and write them to the given file in fasta format. If 
      the file ends in '.gz', then it will be gzip-compressed
    outputBinding:
      glob: $(inputs.eulertigs_fa_out)
  - id: greedytigs_gfa_out
    type:
      - 'null'
      - File
    doc: Compute greedy matchtigs and write them to the given file in GFA 
      format. If the file ends in '.gz', then it will be gzip-compressed
    outputBinding:
      glob: $(inputs.greedytigs_gfa_out)
  - id: greedytigs_fa_out
    type:
      - 'null'
      - File
    doc: Compute greedy matchtigs and write them to the given file in fasta 
      format. If the file ends in '.gz', then it will be gzip-compressed
    outputBinding:
      glob: $(inputs.greedytigs_fa_out)
  - id: matchtigs_gfa_out
    type:
      - 'null'
      - File
    doc: "Compute matchtigs and write them to the given file in GFA format. If the
      file ends in '.gz', then it will be gzip-compressed. WARNING: Uses `O(|V|^2)`
      memory"
    outputBinding:
      glob: $(inputs.matchtigs_gfa_out)
  - id: matchtigs_fa_out
    type:
      - 'null'
      - File
    doc: "Compute matchtigs and write them to the given file in fasta format. If the
      file ends in '.gz', then it will be gzip-compressed. WARNING: Uses `O(|V|^2)`
      memory"
    outputBinding:
      glob: $(inputs.matchtigs_fa_out)
  - id: greedytigs_duplication_bitvector_out
    type:
      - 'null'
      - File
    doc: Output a file with bitvectors in ASCII format, with a 0 for each 
      duplicated instance of a kmer in the greedytigs. The bitvectors are 
      separated by newline characters. Taking all kmers with a 1 results in a 
      set of all original kmers with no duplicates. If the file ends in '.gz', 
      then it will be gzip-compressed
    outputBinding:
      glob: $(inputs.greedytigs_duplication_bitvector_out)
  - id: matchtigs_duplication_bitvector_out
    type:
      - 'null'
      - File
    doc: Output a file with bitvectors in ASCII format, with a 0 for each 
      duplicated instance of a kmer in the matchtigs. The bitvectors are 
      separated by newline characters. Taking all kmers with a 1 results in a 
      set of all original kmers with no duplicates. If the file ends in '.gz', 
      then it will be gzip-compressed
    outputBinding:
      glob: $(inputs.matchtigs_duplication_bitvector_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matchtigs:2.1.9--hc1c3326_0
