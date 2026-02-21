cwlVersion: v1.2
class: CommandLineTool
baseCommand: Parallel
label: biocamlib_Parallel
doc: "A tool to parallelize commands by processing blocks of lines from an input file.\n
  \nTool homepage: https://github.com/PaoloRibeca/BiOCamLib"
inputs:
  - id: command
    type:
      type: array
      items: string
    doc: Consider all the subsequent parameters as the command to be executed in parallel.
      At least one command must be specified.
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debugging information
    inputBinding:
      position: 102
      prefix: --debug
  - id: input
    type:
      - 'null'
      - File
    doc: name of input file
    default: stdin
    inputBinding:
      position: 102
      prefix: --input
  - id: lines_per_block
    type:
      - 'null'
      - int
    doc: number of lines to be processed per block
    default: 10000
    inputBinding:
      position: 102
      prefix: --lines-per-block
  - id: threads
    type:
      - 'null'
      - int
    doc: number of concurrent computing threads to be spawned
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: set verbose execution
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: name of output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocamlib:1.0.0--h9ee0642_0
