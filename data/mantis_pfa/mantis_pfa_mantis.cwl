cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis
label: mantis_pfa_mantis
doc: "Mantis is a k-mer based sequence analysis tool.\n\nTool homepage: https://github.com/PedroMTQ/Mantis"
inputs:
  - id: command
    type: string
    doc: The subcommand to run (build, mst, validatemst, query, validate, stats,
      help)
    inputBinding:
      position: 1
  - id: query
    type: string
    doc: The query sequence or file
    inputBinding:
      position: 2
  - id: dbg_prefix
    type: string
    doc: Prefix for the de Bruijn graph
    inputBinding:
      position: 103
      prefix: -p
  - id: extended_build
    type:
      - 'null'
      - boolean
    doc: Enable extended build options
    inputBinding:
      position: 103
      prefix: -e
  - id: index_prefix
    type: string
    doc: Prefix for the index files
    inputBinding:
      position: 103
      prefix: -p
  - id: input_list
    type: File
    doc: List of input files for building or validation
    inputBinding:
      position: 103
      prefix: -i
  - id: kmer_value
    type:
      - 'null'
      - int
    doc: K-mer size for query
    inputBinding:
      position: 103
      prefix: -k
  - id: log_slots
    type: int
    doc: Number of log slots for building the index
    inputBinding:
      position: 103
      prefix: -s
  - id: num_experiments
    type: int
    doc: Number of experiments for MST validation
    inputBinding:
      position: 103
      prefix: -n
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 103
      prefix: -t
  - id: number_of_samples
    type: int
    doc: Number of samples for statistics
    inputBinding:
      position: 103
      prefix: -n
  - id: query_prefix
    type: string
    doc: Prefix for query files
    inputBinding:
      position: 103
      prefix: -p
  - id: query_type_1
    type:
      - 'null'
      - boolean
    doc: Specify query type 1
    inputBinding:
      position: 103
      prefix: '-1'
  - id: query_type_j
    type:
      - 'null'
      - boolean
    doc: Specify query type j
    inputBinding:
      position: 103
      prefix: -j
  - id: size_of_jmer
    type:
      - 'null'
      - int
    doc: Size of j-mer for statistics
    inputBinding:
      position: 103
      prefix: -j
  - id: stats_type
    type:
      - 'null'
      - string
    doc: Type of statistics to compute
    inputBinding:
      position: 103
      prefix: -t
  - id: use_dmer
    type:
      - 'null'
      - boolean
    doc: Use d-mer for MST construction
    inputBinding:
      position: 103
      prefix: -d
  - id: use_kmer
    type:
      - 'null'
      - boolean
    doc: Use k-mer for MST construction
    inputBinding:
      position: 103
      prefix: -k
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: build_output
    type: Directory
    doc: Output directory for the build command
    outputBinding:
      glob: $(inputs.build_output)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for query results
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
