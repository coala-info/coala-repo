cwlVersion: v1.2
class: CommandLineTool
baseCommand: treemaker
label: treemaker
doc: "Constructs a tree from a classification table\n\nTool homepage: https://github.com/SimonGreenhill/treemaker"
inputs:
  - id: input
    type: File
    doc: inputfile
    inputBinding:
      position: 1
  - id: labels
    type:
      - 'null'
      - boolean
    doc: show node labels
    inputBinding:
      position: 102
      prefix: --labels
  - id: mode
    type:
      - 'null'
      - string
    doc: 'output mode: nexus or newick'
    inputBinding:
      position: 102
      prefix: --mode
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treemaker:1.4--pyh9f0ad1d_0
