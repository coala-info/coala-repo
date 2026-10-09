cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_bracken.out.py
label: krakentools_filter_bracken.out.py
doc: "Filter a Bracken output file by taxonomy IDs to include or exclude.\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs:
  - id: input_file
    type: File
    doc: "Input bracken OUTPUT file (not the report file)"
    inputBinding:
      position: 1
      prefix: -i
  - id: include
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of taxonomy IDs to include in output [default: all]"
    inputBinding:
      position: 101
      prefix: --include
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of taxonomy IDs to exclude in output [default: none]"
    inputBinding:
      position: 101
      prefix: --exclude
  - id: output_file_path
    type: string
    doc: "Output bracken OUTPUT file"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: "Filtered bracken output file"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
