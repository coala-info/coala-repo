cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitp
label: splitp
doc: "Streaming SPLiT-seq read pre-processing\n\nTool homepage: https://github.com/COMBINE-lab/splitp"
inputs:
  - id: bc_map
    type: string
    doc: the map of oligo-dT to random hexamers
    inputBinding:
      position: 1
  - id: end
    type: int
    doc: end position of the random barcode
    inputBinding:
      position: 102
      prefix: --end
  - id: one_hamming
    type:
      - 'null'
      - boolean
    doc: consider 1-hamming distance neighbors of random hexamers
    inputBinding:
      position: 102
      prefix: --one-hamming
  - id: read_file
    type: File
    doc: the input R2 file
    inputBinding:
      position: 102
      prefix: --read-file
  - id: start
    type: int
    doc: start position of the random barcode
    inputBinding:
      position: 102
      prefix: --start
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splitp:0.2.0--h9948957_1
stdout: splitp.out
