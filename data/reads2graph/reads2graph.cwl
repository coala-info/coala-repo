cwlVersion: v1.2
class: CommandLineTool
baseCommand: reads2graph
label: reads2graph
doc: "Construction of edit-distance graphs from large scale sets of short reads through
  minimizer- and gOMH-bucketing and graph traversal.\n\nTool homepage: https://github.com/Jappy0/reads2graph"
inputs:
  - id: bad_kmer_ratio
    type:
      - 'null'
      - float
    doc: The maximum ratio of bad k-mers out of total number of kmers in a 
      window of a read.
    inputBinding:
      position: 101
      prefix: --bad_kmer_ratio
  - id: bin_size_max
    type:
      - 'null'
      - int
    doc: The larger threshold used to group buckets of different sizes.
    inputBinding:
      position: 101
      prefix: --bin_size_max
  - id: export_help
    type:
      - 'null'
      - string
    doc: Export the help page information. Value must be one of [html, man, ctd,
      cwl].
    inputBinding:
      position: 101
      prefix: --export-help
  - id: input_data
    type:
      - 'null'
      - File
    doc: Please provide a fasta/fastq/ data file.
    inputBinding:
      position: 101
      prefix: --input_data
  - id: k_size
    type:
      - 'null'
      - int
    doc: The size for minimiser.
    inputBinding:
      position: 101
      prefix: --k_size
  - id: max_edit_dis
    type:
      - 'null'
      - int
    doc: The maximum edit distance for constructing edges between reads
    inputBinding:
      position: 101
      prefix: --max_edit_dis
  - id: min_edit_dis
    type:
      - 'null'
      - int
    doc: The minimum edit distance for constructing edges between reads.
    inputBinding:
      position: 101
      prefix: --min_edit_dis
  - id: num_process
    type:
      - 'null'
      - int
    doc: The number of expected processes.
    inputBinding:
      position: 101
      prefix: --num_process
  - id: omh_flag
    type:
      - 'null'
      - boolean
    doc: Do not set this flag by yourself. When the permutation_times larger 
      than the number of k-mer candidates and the kmer size are the same one, 
      bucketing the reads using each kmer candidate.
    inputBinding:
      position: 101
      prefix: --omh_flag
  - id: omh_k
    type:
      - 'null'
      - int
    doc: K-mer size used in order min hashing.
    inputBinding:
      position: 101
      prefix: --omh_k
  - id: omh_seed
    type:
      - 'null'
      - int
    doc: The seed to generate a series of seeds for OMH bucketing.
    inputBinding:
      position: 101
      prefix: --omh_seed
  - id: omh_times
    type:
      - 'null'
      - int
    doc: The number of times to perform permutation in order min hashing.
    inputBinding:
      position: 101
      prefix: --omh_times
  - id: pair_wise
    type:
      - 'null'
      - boolean
    doc: Brute Force calcualte the pairwise edit distance.
    inputBinding:
      position: 101
      prefix: --pair_wise
  - id: probability
    type:
      - 'null'
      - float
    doc: The expected probability P for grouping two similar reads into same 
      bucket by at least one minimiser that does not include the different bases
    inputBinding:
      position: 101
      prefix: --probability
  - id: read_length
    type:
      - 'null'
      - int
    doc: No need to input this parameter, reads2graph will calculate the minimum
      read length.
    inputBinding:
      position: 101
      prefix: --read_length
  - id: save_graph
    type:
      - 'null'
      - boolean
    doc: If ture, reads2graph will save graph to file in graphviz dot format.
    inputBinding:
      position: 101
      prefix: --save_graph
  - id: visit_depth
    type:
      - 'null'
      - int
    doc: The maximum distance of nodes from the give node for updating more 
      potential edges.
    inputBinding:
      position: 101
      prefix: --visit_depth
  - id: window_number
    type:
      - 'null'
      - int
    doc: The window number for minimiser.
    inputBinding:
      position: 101
      prefix: --window_number
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The directory for outputs.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reads2graph:1.0.0--h503566f_1
