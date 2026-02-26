cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa-plus
label: hmftools-bwa-plus_bwa-plus
doc: "bwa-plus is a tool for sequence alignment.\n\nTool homepage: https://github.com/hartwigmedical/bwa-plus"
inputs:
  - id: command
    type: string
    doc: The command to execute (index, mem, version)
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-bwa-plus:1.0.0--h077b44d_0
stdout: hmftools-bwa-plus_bwa-plus.out
