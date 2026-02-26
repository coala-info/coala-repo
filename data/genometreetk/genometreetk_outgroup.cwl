cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genometreetk
  - outgroup
label: genometreetk_outgroup
doc: "Reroot tree with outgroup.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_tree
    type: File
    doc: tree to reroot
    inputBinding:
      position: 1
  - id: taxonomy_file
    type: File
    doc: file indicating taxonomy string for genomes
    inputBinding:
      position: 2
  - id: outgroup_taxon
    type: string
    doc: taxon to use as outgroup (e.g., d__Archaea)
    inputBinding:
      position: 3
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 104
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
