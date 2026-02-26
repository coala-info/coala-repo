cwlVersion: v1.2
class: CommandLineTool
baseCommand: primalbedtools downgrade
label: primalbedtools_downgrade
doc: "Downgrades a BED file to a simpler format.\n\nTool homepage: https://github.com/ChrisgKent/primalbedtools"
inputs:
  - id: bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 1
  - id: merge_alts
    type:
      - 'null'
      - boolean
    doc: Should alt primers be merged?
    inputBinding:
      position: 102
      prefix: --merge-alts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
stdout: primalbedtools_downgrade.out
