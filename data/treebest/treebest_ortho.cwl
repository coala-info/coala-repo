cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - ortho
label: treebest_ortho
doc: "Ortholog and paralog inference from a gene tree with species and duplication tags (NHX format).\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: nh_tree
    type: File
    doc: Gene tree in NH or NHX format
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Tab-separated gene pairs with their ortholog/paralog inference
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_ortho.out
