cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis
label: mantis_validatemst
doc: "Validates the MST structure of the de Bruijn graph.\n\nTool homepage: https://github.com/splatlab/mantis"
inputs:
  - id: query
    type:
      - 'null'
      - string
    doc: Prefix of input files.
    inputBinding:
      position: 1
  - id: query_file
    type:
      - 'null'
      - File
    doc: Query file.
    inputBinding:
      position: 2
  - id: build_output
    type: Directory
    doc: directory where results should be written
    inputBinding:
      position: 103
  - id: dbg_prefix
    type:
      - 'null'
      - Directory
    doc: Directory containing the mantis dbg.
    inputBinding:
      position: 103
  - id: delete_rrr
    type:
      - 'null'
      - boolean
    doc: Remove the previous color class RRR representation.
    inputBinding:
      position: 103
      prefix: --delete-RRR
  - id: eqclass_dist
    type:
      - 'null'
      - boolean
    doc: write the eqclass abundance distribution
    inputBinding:
      position: 103
      prefix: --eqclass_dist
  - id: index_prefix
    type: Directory
    doc: The directory where the index is stored.
    inputBinding:
      position: 103
  - id: input_list
    type: File
    doc: file containing list of input filters
    inputBinding:
      position: 103
  - id: json
    type:
      - 'null'
      - boolean
    doc: Write the output in JSON format
    inputBinding:
      position: 103
      prefix: --json
  - id: keep_rrr
    type:
      - 'null'
      - boolean
    doc: Keep the previous color class RRR representation.
    inputBinding:
      position: 103
      prefix: --keep-RRR
  - id: kmer
    type:
      - 'null'
      - int
    doc: size of k for kmer.
    inputBinding:
      position: 103
  - id: log_slots
    type: string
    doc: log of number of slots in the output CQF
    inputBinding:
      position: 103
  - id: num_experiments
    type: int
    doc: Number of experiments.
    inputBinding:
      position: 103
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
  - id: number_of_samples
    type:
      - 'null'
      - int
    doc: Number of experiments.
    inputBinding:
      position: 103
  - id: query_prefix
    type:
      - 'null'
      - string
    doc: Prefix of input files.
    inputBinding:
      position: 103
  - id: size_of_jmer
    type:
      - 'null'
      - int
    doc: 'value of j for constituent jmers of a kmer (default: 23).'
    default: 23
    inputBinding:
      position: 103
  - id: stats_type
    type:
      - 'null'
      - string
    doc: 'what stats? (mono, cc_density, color_dist, jmerkmer), default: mono'
    default: mono
    inputBinding:
      position: 103
  - id: use_colorclasses
    type:
      - 'null'
      - boolean
    doc: Use color classes as the color info representation instead of MST
    inputBinding:
      position: 103
      prefix: --use-colorclasses
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Where to write query output.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
