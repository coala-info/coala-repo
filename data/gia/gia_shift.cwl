cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia shift
label: gia_shift
doc: "Shifts the intervals of a BED file by a specified amount\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: amount
    type: float
    doc: Amount to shift intervals by (negative values shift to the left)
    inputBinding:
      position: 101
      prefix: --amount
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
  - id: genome
    type:
      - 'null'
      - File
    doc: Path to genome file to use for bounds when shifting
    inputBinding:
      position: 101
      prefix: --genome
  - id: input_file
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
  - id: percent
    type:
      - 'null'
      - boolean
    doc: "Interprets the amount as a fraction of the interval length\ni.e. if the
      amount is 0.5, the interval will be shifted by half of its length. if the amount
      is 2, the interval will be shifted by twice its length."
    inputBinding:
      position: 101
      prefix: --percent
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file to write to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
