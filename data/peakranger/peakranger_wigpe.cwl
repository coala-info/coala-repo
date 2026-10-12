cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - peakranger
  - wigpe
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
  - id: output_prefix
    type: string
    doc: the output location prefix; result files are written as <prefix>_*
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result files written with the output prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
