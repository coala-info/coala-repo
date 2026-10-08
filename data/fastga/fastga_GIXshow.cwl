cwlVersion: v1.2
class: CommandLineTool
baseCommand: GIXshow
label: fastga_GIXshow
doc: "Shows k-mers and their positions stored in a genome index.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
arguments:
  - position: 100
    valueFrom: $(inputs.source.basename)
inputs:
  - id: source
    type: File
    doc: Genome index (.gix).
  - id: index_files
    type: File[]
    doc: 'Hidden k-mer table files (.<name>.ktab.N) of the index, staged beside it.'
  - id: address
    type:
      - 'null'
      - string
    doc: 'Address or address range to show: <int>[-<int>] or a DNA string.'
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.source)
      - $(inputs.index_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GIXshow.out
