cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk midpoint
label: genometreetk_midpoint
doc: "Reroot tree at midpoint.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_tree
    type: File
    doc: tree to reroot
    inputBinding:
      position: 1
  - id: output_tree
    type: File
    doc: output tree
    inputBinding:
      position: 2
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 103
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
stdout: genometreetk_midpoint.out
