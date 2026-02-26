cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agtools
  - gfa2adj
label: agtools_gfa2adj
doc: "Get adjacency matrix of the assembly graph\n\nTool homepage: https://github.com/Vini2/agtools"
inputs:
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiter for adjacency file. Supports a comma and a tab.
    default: comma
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: graph
    type:
      type: array
      items: File
    doc: path(s) to the assembly graph file(s)
    inputBinding:
      position: 101
      prefix: --graph
outputs:
  - id: output
    type: Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
