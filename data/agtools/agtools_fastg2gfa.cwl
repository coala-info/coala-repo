cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agtools
  - fastg2gfa
label: agtools_fastg2gfa
doc: "Convert FASTG file to GFA format\n\nTool homepage: https://github.com/Vini2/agtools"
inputs:
  - id: graph
    type:
      type: array
      items: File
    doc: path(s) to the assembly graph file(s)
    inputBinding:
      position: 101
      prefix: --graph
  - id: ksize
    type: int
    doc: k-mer size used for the assembly
    default: 141
    inputBinding:
      position: 101
      prefix: --ksize
outputs:
  - id: output
    type: Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
