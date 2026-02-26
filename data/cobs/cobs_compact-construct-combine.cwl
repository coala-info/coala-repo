cwlVersion: v1.2
class: CommandLineTool
baseCommand: cobs compact-construct-combine
label: cobs_compact-construct-combine
doc: "Constructs and combines compact indexes from input directory to output file.\n\
  \nTool homepage: https://panthema.net/cobs"
inputs:
  - id: in_dir
    type: Directory
    doc: path to the input directory
    inputBinding:
      position: 1
  - id: page_size
    type:
      - 'null'
      - int
    doc: the page size of the compact the index
    default: 8192
    inputBinding:
      position: 102
      prefix: --page-size
outputs:
  - id: out_file
    type: File
    doc: path to the output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
