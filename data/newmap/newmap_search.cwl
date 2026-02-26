cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - newmap
  - search
label: newmap_search
doc: "Search for unique k-mers in a FASTA file.\n\nTool homepage: https://github.com/hoffmangroup/newmap"
inputs:
  - id: fasta_file
    type: File
    doc: File of (gzipped) fasta file for kmer generation
    inputBinding:
      position: 1
  - id: index_file
    type:
      - 'null'
      - File
    doc: File of reference index file to count occurances in.
    default: basename of fasta_file with the awfmi extension
    inputBinding:
      position: 2
  - id: exclude_sequences
    type:
      - 'null'
      - string
    doc: A comma separated list of sequence IDs to exclude from fasta_file. 
      Cannot be used with --include-sequences.
    default: all sequences in fasta_file
    inputBinding:
      position: 103
      prefix: --exclude-sequences
  - id: include_sequences
    type:
      - 'null'
      - string
    doc: A comma separated list of sequence IDs to select from fasta_file. 
      Cannot be used with --exclude-sequences.
    default: all sequences in fasta_file
    inputBinding:
      position: 103
      prefix: --include-sequences
  - id: initial_search_length
    type:
      - 'null'
      - string
    doc: Specify the initial search length. Only valid when the search range is 
      a continuous range separated by a colon.
    default: midpoint of the range
    inputBinding:
      position: 103
      prefix: --initial-search-length
  - id: kmer_batch_size
    type:
      - 'null'
      - int
    doc: Maximum number of k-mers to batch per reference sequence from input 
      fasta file. Use to control memory usage.
    default: 10000000
    inputBinding:
      position: 103
      prefix: --kmer-batch-size
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to parallelize k-mer counting.
    default: 1
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: search_range
    type:
      - 'null'
      - string
    doc: 'Search set of sequence lengths to determine uniqueness. Use a comma separated
      list of increasing lengths or a full inclusive set of lengths separated by a
      colon. Examples: 20,24,30 or 20:30.'
    default: 20:200
    inputBinding:
      position: 103
      prefix: --search-range
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional information to standard error
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write the binary files containing the 'unique' lengths to.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newmap:0.2--py312h9c9b0c2_1
