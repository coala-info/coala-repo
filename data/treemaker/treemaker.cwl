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
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treemaker:1.4--pyh9f0ad1d_0
