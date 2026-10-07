cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deacon
  - index
  - intersect
label: deacon_index_intersect
doc: "Intersect multiple minimizer indexes (A ∩ B…)\n\nTool homepage: https://github.com/bede/deacon"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Path(s) to two or more index file(s)
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: Path to output index file
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: index
    type: File
    doc: Combined minimizer index file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
