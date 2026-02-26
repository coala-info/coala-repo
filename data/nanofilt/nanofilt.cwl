cwlVersion: v1.2
class: CommandLineTool
baseCommand: NanoFilt
label: nanofilt
doc: "Perform quality and length filtering and trimming of long read sequencing data.\n\
  \nTool homepage: https://github.com/wdecoster/nanofilt"
inputs:
  - id: headcrop
    type:
      - 'null'
      - int
    doc: Trim n nucleotides from the start of a read.
    inputBinding:
      position: 101
      prefix: --headcrop
  - id: length
    type:
      - 'null'
      - int
    doc: Filter on a minimum read length.
    inputBinding:
      position: 101
      prefix: --length
  - id: quality
    type:
      - 'null'
      - int
    doc: Filter on a minimum average read quality.
    inputBinding:
      position: 101
      prefix: --quality
  - id: readtype
    type:
      - 'null'
      - string
    doc: Which read type to extract information about from summary. Options are 
      1D, 2D, 1D2
    inputBinding:
      position: 101
      prefix: --readtype
  - id: summary
    type:
      - 'null'
      - File
    doc: Use a summary file from albacore or guppy for filtering.
    inputBinding:
      position: 101
      prefix: --summary
  - id: tailcrop
    type:
      - 'null'
      - int
    doc: Trim n nucleotides from the end of a read.
    inputBinding:
      position: 101
      prefix: --tailcrop
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanofilt:2.8.0--py_0
stdout: nanofilt.out
