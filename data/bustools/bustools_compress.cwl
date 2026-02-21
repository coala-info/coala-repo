cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - compress
label: bustools_compress
doc: "Compress a BUS file, which should be sorted by barcode-umi-ec.\n\nTool homepage:
  https://github.com/BUStools/bustools"
inputs:
  - id: sorted_bus_file
    type: File
    doc: Sorted BUS file (should be sorted by barcode-umi-ec)
    inputBinding:
      position: 1
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Number of rows to compress as a single block
    inputBinding:
      position: 102
      prefix: --chunk-size
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Write to standard output
    inputBinding:
      position: 102
      prefix: --pipe
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write compressed file to OUTPUT
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
