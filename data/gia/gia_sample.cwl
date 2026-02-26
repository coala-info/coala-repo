cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia_sample
label: gia_sample
doc: "Randomly sample a BED file\n\nTool homepage: https://github.com/noamteyssier/gia"
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
  - id: fraction
    type:
      - 'null'
      - float
    doc: Fraction of intervals to sample (choose one of n or f)
    inputBinding:
      position: 101
      prefix: --fraction
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
  - id: number
    type:
      - 'null'
      - int
    doc: Number of intervals to sample (choose one of n or f)
    inputBinding:
      position: 101
      prefix: --number
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed to use for random number generation (no default)
    inputBinding:
      position: 101
      prefix: --seed
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
