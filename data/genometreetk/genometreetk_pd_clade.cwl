cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk pd_clade
label: genometreetk_pd_clade
doc: "Calculate phylogenetic diversity of named groups.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: decorated_tree
    type: File
    doc: tree with labeled internal nodes
    inputBinding:
      position: 1
  - id: taxa_list
    type: File
    doc: list of ingroup taxa, one per line, to calculated PD over
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
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
