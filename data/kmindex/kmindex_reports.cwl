cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmindex_reports
label: kmindex_reports
doc: "Reports on kmindex files.\n\nTool homepage: https://github.com/tlemane/kmindex"
inputs:
  - id: command
    type: string
    doc: 'The command to run. Choices: [build|register|query|query2|merge|index-infos|compress|sum-index|sum-query]'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
stdout: kmindex_reports.out
