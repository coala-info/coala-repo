cwlVersion: v1.2
class: CommandLineTool
baseCommand: kreport2krona.py
label: krakentools_kreport2krona.py
doc: "Convert a Kraken report file to the text format used by Krona (ktImportText).\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs:
  - id: report_file
    type: File
    doc: "Input kraken report file for converting"
    inputBinding:
      position: 1
      prefix: -r
  - id: intermediate_ranks
    type:
      - 'null'
      - boolean
    doc: "Include non-traditional taxonomic ranks in output"
    inputBinding:
      position: 101
      prefix: --intermediate-ranks
  - id: no_intermediate_ranks
    type:
      - 'null'
      - boolean
    doc: "Do not include non-traditional taxonomic ranks in output [default]"
    inputBinding:
      position: 101
      prefix: --no-intermediate-ranks
  - id: output_file_path
    type: string
    doc: "Output krona-report file name"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: "Krona text report"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
