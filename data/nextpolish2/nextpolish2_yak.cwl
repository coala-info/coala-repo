cwlVersion: v1.2
class: CommandLineTool
baseCommand: yak
label: nextpolish2_yak
doc: "yak <command> <argument>\n\nTool homepage: https://github.com/Nextomics/NextPolish2"
inputs:
  - id: command
    type: string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: argument
    type:
      - 'null'
      - string
    doc: Argument for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextpolish2:0.2.2--h74ec884_0
stdout: nextpolish2_yak.out
