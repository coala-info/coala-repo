cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk_prune
label: genometreetk_prune
doc: "Prune tree to a specific set of extant taxa.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_tree
    type: File
    doc: input tree in Newick format
    inputBinding:
      position: 1
  - id: taxa_to_retain
    type: File
    doc: input file specify taxa to retain
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
    doc: pruned output tree
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
