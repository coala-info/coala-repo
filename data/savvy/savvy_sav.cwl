cwlVersion: v1.2
class: CommandLineTool
baseCommand: sav
label: savvy_sav
doc: "Missing sub-command\n\nTool homepage: https://github.com/statgen/savvy"
inputs:
  - id: sub_command
    type: string
    doc: Sub-command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the sub-command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
stdout: savvy_sav.out
