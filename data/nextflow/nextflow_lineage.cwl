cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nextflow
  - lineage
label: nextflow_lineage
doc: "Explore workflows lineage metadata\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: sub_command
    type: string
    doc: 'The lineage sub-command to execute. Available commands: check, diff, find,
      list, render, view.'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the selected sub-command.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_lineage.out
