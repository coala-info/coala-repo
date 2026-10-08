cwlVersion: v1.2
class: CommandLineTool
baseCommand: Vennex
label: fastk_Vennex
doc: "Shows a Venn diagram table of the k-mer counts shared between two or more k-mer tables.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
arguments:
  - position: 100
    valueFrom: '$(inputs.tables.map(function(f){return f.basename;}))'
inputs:
  - id: tables
    type: File[]
    doc: k-mer table stub files (.ktab).
  - id: table_parts
    type: File[]
    doc: 'Hidden table part files (.<name>.ktab.N) of all the input tables.'
  - id: histogram_range
    type:
      - 'null'
      - string
    doc: 'Histogram range [<int>:]<int>. [default: 100]'
    inputBinding:
      position: 50
      prefix: '-h'
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: histograms
    type:
      type: array
      items: File
    doc: Venn histogram files written by Vennex.
    outputBinding:
      glob: |
        ${
          return ['*.hist'];
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.tables)
      - $(inputs.table_parts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Vennex.out
