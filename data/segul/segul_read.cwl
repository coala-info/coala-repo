cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - segul
  - read
label: segul_read
doc: "Sequence read analyses\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (e.g., summary)
    inputBinding:
      position: 1
  - id: log
    type:
      - 'null'
      - File
    doc: Log file path
    inputBinding:
      position: 102
      prefix: --log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
stdout: segul_read.out
