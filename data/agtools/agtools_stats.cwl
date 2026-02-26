cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agtools
  - stats
label: agtools_stats
doc: "Compute statistics about the graph\n\nTool homepage: https://github.com/Vini2/agtools"
inputs:
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
