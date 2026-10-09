cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - nodestats
label: howdesbt_nodestats
doc: "report file sizes and node occupancy stats for a tree\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: tree_topology
    type: File
    doc: "name of the tree topology file"
    inputBinding:
      position: 101
  - id: filters
    type:
      type: array
      items: File
    doc: "the bloom filter files named in the topology file (staged in the working directory)"
  - id: noshow_occupancy
    type:
      - 'null'
      - boolean
    doc: "don't report the number of 1s in each bit vector"
    inputBinding:
      position: 102
      prefix: "--noshow:occupancy"
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
stdout: howdesbt_nodestats.out
