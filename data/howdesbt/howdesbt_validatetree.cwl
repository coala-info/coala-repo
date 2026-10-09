cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - validatetree
label: howdesbt_validatetree
doc: "validate that a tree's filters all have consistent properties\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: tree_topology
    type: File
    doc: "name of a topology file"
    inputBinding:
      position: 101
  - id: filters
    type:
      type: array
      items: File
    doc: "the bloom filter files named in the topology file (staged in the working directory)"
  - id: union
    type:
      - 'null'
      - boolean
    doc: "verify the node union property (by default only simple properties like the size of bloom filters are validated)"
    inputBinding:
      position: 102
      prefix: "--union"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.filters)
      - $(inputs.tree_topology)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
stdout: howdesbt_validatetree.out
