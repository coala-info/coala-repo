cwlVersion: v1.2
class: CommandLineTool
baseCommand: primalbedtools amplicon
label: primalbedtools_amplicon
doc: "Primertrim the amplicons\n\nTool homepage: https://github.com/ChrisgKent/primalbedtools"
inputs:
  - id: bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 1
  - id: primertrim
    type:
      - 'null'
      - boolean
    doc: Primertrim the amplicons
    inputBinding:
      position: 102
      prefix: --primertrim
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
stdout: primalbedtools_amplicon.out
