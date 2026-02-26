cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrpast_show
label: mrpast_show
doc: "Show results from mrpast solver.\n\nTool homepage: https://aprilweilab.github.io/"
inputs:
  - id: solved_result
    type: File
    doc: A JSON file output by the solver.
    inputBinding:
      position: 1
  - id: sort_by
    type:
      - 'null'
      - string
    doc: Sort parameters by the column name.
    inputBinding:
      position: 102
      prefix: --sort-by
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
stdout: mrpast_show.out
