cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - decompress
label: bustools_decompress
doc: "Decompress or inflate a compressed BUS file\n\nTool homepage: https://github.com/BUStools/bustools"
inputs:
  - id: compressed_bus_file
    type: File
    doc: The compressed BUS file to decompress
    inputBinding:
      position: 1
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Write to standard output.
    inputBinding:
      position: 102
      prefix: --pipe
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File for inflated output.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
