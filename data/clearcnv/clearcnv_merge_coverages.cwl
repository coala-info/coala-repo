cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clearCNV
  - merge_coverages
label: clearcnv_merge_coverages
doc: "Merges all .rtbed files into one table in .tsv format.\n\nTool homepage: https://github.com/bihealth/clear-cnv"
inputs:
  - id: bedfile
    type: File
    doc: "Path to the merged .bed file."
    inputBinding:
      position: 101
      prefix: --bedfile
  - id: rtbeds
    type:
      type: array
      items: File
    doc: "Input .rtbed file paths."
    inputBinding:
      position: 101
      prefix: --rtbeds
  - id: coverages
    type: string
    doc: "Output table in .tsv format."
    inputBinding:
      position: 101
      prefix: --coverages
outputs:
  - id: coverages_tsv
    type: File
    doc: "Coverage table"
    outputBinding:
      glob: "$(inputs.coverages)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
