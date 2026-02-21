cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - compare_red
label: phylorank_compare_red
doc: "Compare RED (Relative Evolutionary Divergence) tables and dictionaries.\n\n
  Tool homepage: https://github.com/dparks1134/PhyloRank"
inputs:
  - id: red_table1
    type: File
    doc: First RED table file
    inputBinding:
      position: 1
  - id: red_table2
    type: File
    doc: Second RED table file
    inputBinding:
      position: 2
  - id: red_dict2
    type: File
    doc: Second RED dictionary file
    inputBinding:
      position: 3
  - id: viral
    type:
      - 'null'
      - boolean
    doc: Flag to indicate viral data processing
    inputBinding:
      position: 104
      prefix: --viral
outputs:
  - id: output_table
    type: File
    doc: Output table file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
