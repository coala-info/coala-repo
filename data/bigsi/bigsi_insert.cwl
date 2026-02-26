cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigsi-v0.3.1 insert
label: bigsi_insert
doc: "Inserts a bloom filter into the graph e.g. bigsi insert ERR1010211.bloom\nERR1010211\n\
  \nTool homepage: https://github.com/Phelimb/BIGSI"
inputs:
  - id: config
    type: string
    doc: Basic text / string value
    inputBinding:
      position: 1
  - id: bloomfilter
    type: File
    doc: Bloom filter file to insert
    inputBinding:
      position: 2
  - id: sample
    type: string
    doc: Sample name
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigsi:0.3.1--py_0
stdout: bigsi_insert.out
