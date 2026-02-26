cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agtools
  - rename
label: agtools_rename
doc: "Rename segments, paths and walks in a GFA file\n\nTool homepage: https://github.com/Vini2/agtools"
inputs:
  - id: graph
    type:
      type: array
      items: File
    doc: path(s) to the assembly graph file(s)
    inputBinding:
      position: 101
      prefix: --graph
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for the graph elements
    default: ''
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: output
    type: Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
