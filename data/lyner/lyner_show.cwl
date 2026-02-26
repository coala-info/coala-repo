cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - show
label: lyner_show
doc: "Show the content of a lyner pipe.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: pipe
    type: string
    doc: The lyner pipe to show.
    inputBinding:
      position: 1
  - id: matrix
    type:
      - 'null'
      - boolean
    doc: Show the matrix representation of the pipe.
    inputBinding:
      position: 102
      prefix: --matrix
  - id: selection
    type:
      - 'null'
      - string
    doc: Show only the specified selection.
    inputBinding:
      position: 102
      prefix: --selection
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_show.out
