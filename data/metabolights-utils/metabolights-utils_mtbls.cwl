cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtbls
label: metabolights-utils_mtbls
doc: "Metabolights utilities\n\nTool homepage: https://github.com/EBI-Metabolights/metabolights-utils"
inputs:
  - id: command
    type: string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
stdout: metabolights-utils_mtbls.out
