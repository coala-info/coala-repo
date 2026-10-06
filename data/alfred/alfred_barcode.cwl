cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - barcode
label: alfred_barcode
doc: "Generate Hamming-distanced barcodes for sequencing experiments.\n\nTool homepage:
  https://github.com/tobiasrausch/alfred"
inputs:
  - id: barcodes_fasta
    type:
      - 'null'
      - File
    doc: Optional FASTA file of candidate barcodes (otherwise all barcodes are enumerated)
    inputBinding:
      position: 1
  - id: target
    type:
      - 'null'
      - int
    doc: min. hamming distance
    inputBinding:
      position: 101
      prefix: --target
  - id: barlen
    type:
      - 'null'
      - int
    doc: barcode length
    inputBinding:
      position: 101
      prefix: --barlen
  - id: enumall
    type:
      - 'null'
      - int
    doc: enumerate all possible barcodes until this length
    inputBinding:
      position: 101
      prefix: --enumall
  - id: entropy
    type:
      - 'null'
      - float
    doc: min. barcode entropy
    inputBinding:
      position: 101
      prefix: --entropy
  - id: outfile_path
    type: string
    doc: output FASTA file
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output FASTA file with the generated barcodes
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
