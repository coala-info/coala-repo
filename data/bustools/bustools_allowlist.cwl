cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - allowlist
label: bustools_allowlist
doc: "Generates an allowlist (on-list) of barcodes from a sorted BUS file based on
  a frequency threshold.\n\nTool homepage: https://github.com/BUStools/bustools"
inputs:
  - id: sorted_bus_file
    type: File
    doc: Sorted BUS file
    inputBinding:
      position: 1
  - id: threshold
    type:
      - 'null'
      - int
    doc: Minimum number of times a barcode must appear to be included in on-list
    inputBinding:
      position: 102
      prefix: --threshold
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File for the on-list
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
