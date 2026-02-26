cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk_pull
label: genometreetk_pull
doc: "Create taxonomy file from a decorated tree.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_tree
    type: File
    doc: decorated tree
    inputBinding:
      position: 1
  - id: no_validation
    type:
      - 'null'
      - boolean
    doc: do not assume decorated nodes adhear to standard taxonomy
    inputBinding:
      position: 102
      prefix: --no_validation
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 102
      prefix: --silent
outputs:
  - id: output_taxonomy
    type: File
    doc: output taxonomy file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
