cwlVersion: v1.2
class: CommandLineTool
baseCommand: Haplex
label: fastk_Haplex
doc: "Finds heterozygous k-mer pairs (haplotype k-mers) in a k-mer table. Deprecated by the authors but still available.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
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
  - id: haplotype_mode
    type: boolean
    doc: Required flag -H of Haplex.
    inputBinding:
      position: 50
      prefix: '-H'
  - id: count_range
    type:
      - 'null'
      - string
    doc: 'Accept only haplotypes with count in given range (inclusive): <int>:<int>.'
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
stdout: fastk_Haplex.out
