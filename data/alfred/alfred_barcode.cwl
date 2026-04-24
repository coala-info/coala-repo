cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - barcode
label: alfred_barcode
doc: "Generate Hamming-distanced barcodes for sequencing experiments.\n\nTool homepage:
  https://github.com/tobiasrausch/alfred"
inputs:
  - id: distance
    type:
      - 'null'
      - int
    doc: Minimum Hamming distance between barcodes
    inputBinding:
      position: 101
      prefix: --dist
  - id: length
    type:
      - 'null'
      - int
    doc: Barcode length
    inputBinding:
      position: 101
      prefix: --len
  - id: number
    type:
      - 'null'
      - int
    doc: Number of barcodes to generate
    inputBinding:
      position: 101
      prefix: --num
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output filename for the generated barcodes
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
