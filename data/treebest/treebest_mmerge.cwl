cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - mmerge
label: treebest_mmerge
doc: "Merge multiple trees into a forest or reroot trees\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: forest
    type: File
    doc: Input forest file
    inputBinding:
      position: 1
  - id: reroot
    type:
      - 'null'
      - boolean
    doc: reroot
    inputBinding:
      position: 102
      prefix: -r
  - id: species_tree
    type:
      - 'null'
      - File
    doc: species tree [default taxa tree]
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_mmerge.out
