cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grzctl
  - pruefbericht
label: grzctl_pruefbericht
doc: "Generate and submit Prüfberichte.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs:
  - id: command
    type: string
    doc: The command to run (generate or submit)
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
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_pruefbericht.out
