cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk append
label: genometreetk_append
doc: "Append taxonomy to extant tree labels.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_tree
    type: File
    doc: input tree to decorate
    inputBinding:
      position: 1
  - id: input_taxonomy
    type: File
    doc: input taxonomy file
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
  - id: output_tree
    type: File
    doc: output tree with taxonomy appended to extant taxon labels
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
