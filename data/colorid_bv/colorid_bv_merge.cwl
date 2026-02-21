cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - colorid_bv
  - merge
label: colorid_bv_merge
doc: "merges (concatenates) indices\n\nTool homepage: https://github.com/hcdenbakker/colorid_bv"
inputs:
  - id: index_1
    type: File
    doc: index to which index 2 will be concatenated
    inputBinding:
      position: 101
      prefix: --index_1
  - id: index_2
    type: File
    doc: index to be concatenated to index 1
    inputBinding:
      position: 101
      prefix: --index_2
outputs:
  - id: out_bigsi
    type: File
    doc: name output index
    outputBinding:
      glob: $(inputs.out_bigsi)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
