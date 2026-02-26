cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia_cluster
label: gia_cluster
doc: "Annotates the intervals of a BED file with their Cluster ID\n\nTool homepage:
  https://github.com/noamteyssier/gia"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level to use for output files if applicable
    default: 6
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: Compression threads to use for output files if applicable
    default: 1
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: field_format
    type:
      - 'null'
      - string
    doc: Allow for non-integer chromosome names
    inputBinding:
      position: 101
      prefix: --field-format
  - id: input
    type:
      - 'null'
      - File
    doc: Input BED file to process
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: input_format
    type:
      - 'null'
      - string
    doc: Format of input file
    inputBinding:
      position: 101
      prefix: --input-format
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Assume input is sorted
    default: false
    inputBinding:
      position: 101
      prefix: --sorted
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output BED file to write to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
