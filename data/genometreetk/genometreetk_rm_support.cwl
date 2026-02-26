cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genometreetk
  - rm_support
label: genometreetk_rm_support
doc: "Remove support values from tree.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_tree
    type: File
    doc: tree to strip
    inputBinding:
      position: 1
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 102
      prefix: --silent
outputs:
  - id: output_tree
    type: File
    doc: output tree
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
