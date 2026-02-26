cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agtools
  - gfa2dot
label: agtools_gfa2dot
doc: "Convert GFA file to DOT format (GraphViz)\n\nTool homepage: https://github.com/Vini2/agtools"
inputs:
  - id: abyss
    type:
      - 'null'
      - boolean
    doc: use the ABySS DOT format for the output
    inputBinding:
      position: 101
      prefix: --abyss
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
