cwlVersion: v1.2
class: CommandLineTool
baseCommand: barcode_table_to_json
label: callingcardstools_barcode_table_to_json
doc: "Converts a barcode table to JSON format.\n\nTool homepage: https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: barcode_table
    type: File
    doc: old pipeline barcode table
    inputBinding:
      position: 101
      prefix: --barcode_table
  - id: batch
    type: string
    doc: batch name, eg the run number like run_1234
    inputBinding:
      position: 101
      prefix: --batch
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level
    default: info
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
stdout: callingcardstools_barcode_table_to_json.out
