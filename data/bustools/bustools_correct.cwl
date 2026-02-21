cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - correct
label: bustools_correct
doc: "Correct barcodes in BUS files using an on-list\n\nTool homepage: https://github.com/BUStools/bustools"
inputs:
  - id: bus_files
    type:
      type: array
      items: File
    doc: Input BUS files
    inputBinding:
      position: 1
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Dump uncorrected to corrected barcodes (optional)
    inputBinding:
      position: 102
      prefix: --dump
  - id: nocorrect
    type:
      - 'null'
      - boolean
    doc: Skip barcode error correction and only keep perfect matches to on-list
    inputBinding:
      position: 102
      prefix: --nocorrect
  - id: onlist
    type:
      - 'null'
      - File
    doc: File of on-list barcodes to correct to
    inputBinding:
      position: 102
      prefix: --onlist
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Write to standard output
    inputBinding:
      position: 102
      prefix: --pipe
  - id: replace
    type:
      - 'null'
      - boolean
    doc: The file of on-list barcodes is a barcode replacement file
    inputBinding:
      position: 102
      prefix: --replace
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File for corrected bus output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
