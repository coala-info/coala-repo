cwlVersion: v1.2
class: CommandLineTool
baseCommand: wigpe
label: peakranger_wigpe
doc: WigPE 1.18
inputs:
  - id: data
    type: File
    doc: the data file
    inputBinding:
      position: 101
      prefix: --data
  - id: ext_length
    type:
      - 'null'
      - int
    doc: read extension length
    inputBinding:
      position: 101
      prefix: --ext_length
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: compress the output
    inputBinding:
      position: 101
      prefix: --gzip
  - id: split
    type:
      - 'null'
      - boolean
    doc: generate one wig file per chromosome
    inputBinding:
      position: 101
      prefix: --split
  - id: strand
    type:
      - 'null'
      - boolean
    doc: generate one wig file per strand
    inputBinding:
      position: 101
      prefix: --strand
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress when possible
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: the output location
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
