cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - bitstats
label: howdesbt_bitstats
doc: "report bit stats for a tree\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
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
  - id: bit_interval
    type:
      - 'null'
      - string
    doc: "interval of bits to use from each filter, as <start>..<end> (by default all bits from each filter)"
    inputBinding:
      position: 102
  - id: bits
    type:
      - 'null'
      - int
    doc: "number of bits to use from each filter; same as 0..<N>"
    inputBinding:
      position: 103
      prefix: "--bits="
      separate: false
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
stdout: howdesbt_bitstats.out
