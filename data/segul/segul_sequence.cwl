cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - segul
  - sequence
label: segul_sequence
doc: "Sequence analyses\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (add, extract, filter, id, remove, rename, translate)
    inputBinding:
      position: 1
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: Log file path
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
