cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - memote
  - report
label: memote_report
doc: "Generate one of three different types of reports.\n\nTool homepage: https://memote.readthedocs.io/"
inputs:
  - id: command
    type: string
    doc: The command to run (diff, history, or snapshot)
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
    dockerPull: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
stdout: memote_report.out
