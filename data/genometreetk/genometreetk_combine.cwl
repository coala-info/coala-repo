cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk_combine
label: genometreetk_combine
doc: "Combine all support values into a single tree.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: bootstrap_tree
    type: File
    doc: tree with bootstrap support values
    inputBinding:
      position: 1
  - id: jk_marker_tree
    type: File
    doc: tree with jackknife marker support values
    inputBinding:
      position: 2
  - id: jk_taxa_tree
    type: File
    doc: tree with jackknife taxa support values
    inputBinding:
      position: 3
  - id: output_tree
    type: File
    doc: output tree
    inputBinding:
      position: 4
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 105
      prefix: --silent
  - id: support_type
    type:
      - 'null'
      - string
    doc: type of support values to compute
    inputBinding:
      position: 105
      prefix: --support_type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
stdout: genometreetk_combine.out
