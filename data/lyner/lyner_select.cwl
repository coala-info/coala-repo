cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - select
label: lyner_select
doc: "Select a datum based on its name (e.g. 'matrix' or 'estimate'), making it the
  target of commands such as `show`, `save` and `plot`.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: what
    type: string
    doc: The name of the datum to select (e.g. 'matrix' or 'estimate')
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_select.out
