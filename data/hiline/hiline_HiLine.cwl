cwlVersion: v1.2
class: CommandLineTool
baseCommand: HiLine
label: hiline_HiLine
doc: "A HiC alignment and classification pipeline.\n\nTool homepage: https://github.com/wtsi-hpag/HiLine"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., params, align-sam-reads, valid-pairs, 
      save-stats)
    inputBinding:
      position: 1
  - id: command_args
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
    dockerPull: quay.io/biocontainers/hiline:0.2.4--py39h8aee962_0
stdout: hiline_HiLine.out
