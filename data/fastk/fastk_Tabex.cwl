cwlVersion: v1.2
class: CommandLineTool
baseCommand: Tabex
label: fastk_Tabex
doc: "Lists the k-mers and counts of a k-mer table, optionally restricted to an address range or thresholded by count.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
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
  - id: address
    type:
      - 'null'
      - string[]
    doc: 'Address or address range to list: <int>[-<int>] or <dna:string>.'
    inputBinding:
      position: 101
  - id: one_code
    type:
      - 'null'
      - boolean
    doc: Produce 1-code as output.
    inputBinding:
      position: 50
      prefix: '-1'
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Output tab-delimited ASCII.
    inputBinding:
      position: 50
      prefix: '-A'
  - id: check_sorting
    type:
      - 'null'
      - boolean
    doc: Check sorting.
    inputBinding:
      position: 50
      prefix: '-C'
  - id: threshold
    type:
      - 'null'
      - int
    doc: Trim all k-mers with counts less than threshold.
    inputBinding:
      position: 50
      prefix: '-t'
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
stdout: fastk_Tabex.out
