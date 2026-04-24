cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia_spacing
label: gia_spacing
doc: "Calculates the spacing between intervals in a BED file\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level to use for output files if applicable
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: Compression threads to use for output files if applicable
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
  - id: is_sorted
    type:
      - 'null'
      - boolean
    doc: Input BED file is sorted
    inputBinding:
      position: 101
      prefix: --is-sorted
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
