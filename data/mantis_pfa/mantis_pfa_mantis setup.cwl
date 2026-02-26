cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis
label: mantis_pfa_mantis setup
doc: "Mantis is a k-mer based sequence analysis tool.\n\nTool homepage: https://github.com/PedroMTQ/Mantis"
inputs:
  - id: query
    type: string
    doc: query
    inputBinding:
      position: 1
  - id: build_output
    type: Directory
    doc: build_output
    inputBinding:
      position: 102
      prefix: -o
  - id: dbg_prefix
    type: string
    doc: dbg_prefix
    inputBinding:
      position: 102
      prefix: -p
  - id: distance_mode
    type:
      - 'null'
      - boolean
    doc: Use distance mode
    inputBinding:
      position: 102
      prefix: -d
  - id: extended_build
    type:
      - 'null'
      - boolean
    doc: Extended build option
    inputBinding:
      position: 102
      prefix: -e
  - id: index_prefix
    type: string
    doc: index_prefix
    inputBinding:
      position: 102
      prefix: -p
  - id: input_list
    type: File
    doc: input_list
    inputBinding:
      position: 102
      prefix: -i
  - id: json_output
    type:
      - 'null'
      - boolean
    doc: JSON output
    inputBinding:
      position: 102
      prefix: -j
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer
    inputBinding:
      position: 102
      prefix: -k
  - id: kmer_mode
    type:
      - 'null'
      - boolean
    doc: Use k-mer mode
    inputBinding:
      position: 102
      prefix: -k
  - id: log_slots
    type: int
    doc: log-slots
    inputBinding:
      position: 102
      prefix: -s
  - id: num_experiments
    type: int
    doc: num_experiments
    inputBinding:
      position: 102
      prefix: -n
  - id: num_threads
    type:
      - 'null'
      - int
    doc: num_threads
    inputBinding:
      position: 102
      prefix: -t
  - id: number_of_samples
    type: int
    doc: number_of_samples
    inputBinding:
      position: 102
      prefix: -n
  - id: query_mode
    type:
      - 'null'
      - boolean
    doc: Query mode 1
    inputBinding:
      position: 102
      prefix: '-1'
  - id: query_prefix
    type: string
    doc: query_prefix
    inputBinding:
      position: 102
      prefix: -p
  - id: size_of_jmer
    type:
      - 'null'
      - int
    doc: size-of-jmer
    inputBinding:
      position: 102
      prefix: -j
  - id: stats_type
    type:
      - 'null'
      - string
    doc: type
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output_file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
