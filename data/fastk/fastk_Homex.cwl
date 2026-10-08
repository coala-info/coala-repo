cwlVersion: v1.2
class: CommandLineTool
baseCommand: Homex
label: fastk_Homex
doc: "Estimates the homozygous and heterozygous k-mer error rate from a k-mer table.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
arguments:
  - position: 100
    valueFrom: $(inputs.table.basename)
inputs:
  - id: table
    type: File
    doc: k-mer table stub file (.ktab) made by FastK.
  - id: table_parts
    type: File[]
    doc: 'Hidden table part files (.<name>.ktab.N) made by FastK; they are staged beside the stub.'
  - id: error_count
    type: int
    doc: Counts <= this value are considered errors.
    inputBinding:
      position: 50
      prefix: '-e'
      separate: false
  - id: correct_range
    type: string
    doc: 'Counts in this range are considered correct: <int>:<int>.'
    inputBinding:
      position: 50
      prefix: '-g'
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.table)
      - $(inputs.table_parts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Homex.out
