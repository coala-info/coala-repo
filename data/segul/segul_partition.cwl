cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - segul
  - partition
label: segul_partition
doc: "Alignment partition conversion\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: command
    type: string
    doc: Subcommand to execute (convert, help)
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
