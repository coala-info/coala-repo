cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agc
  - getcol
label: agc_getcol
doc: "Assembled Genomes Compressor - get collection of sequences\n\nTool homepage:
  https://github.com/refresh-bio/agc"
inputs:
  - id: input_agc
    type: File
    doc: Input AGC file
    inputBinding:
      position: 1
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: fast mode (needs more RAM)
    default: false
    inputBinding:
      position: 102
      prefix: -f
  - id: gzip_level
    type:
      - 'null'
      - int
    doc: 'optional gzip with given level (min: 0; max: 9)'
    default: 0
    inputBinding:
      position: 102
      prefix: -g
  - id: line_length
    type:
      - 'null'
      - int
    doc: 'line length (min: 40; max: 2000000000)'
    default: 80
    inputBinding:
      position: 102
      prefix: -l
  - id: threads
    type:
      - 'null'
      - int
    doc: 'no of threads (min: 1; max: 56)'
    default: 28
    inputBinding:
      position: 102
      prefix: -t
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'verbosity level (min: 0; max: 2)'
    default: 0
    inputBinding:
      position: 102
      prefix: -v
  - id: without_reference
    type:
      - 'null'
      - boolean
    doc: without reference
    default: false
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: 'output to files at path (default: output is sent to stdout)'
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
