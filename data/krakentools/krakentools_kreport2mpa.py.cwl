cwlVersion: v1.2
class: CommandLineTool
baseCommand: kreport2mpa.py
label: krakentools_kreport2mpa.py
doc: "Convert a Kraken report file to MetaPhlAn-style (mpa) report format.\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs:
  - id: report_file
    type: File
    doc: "Input kraken report file for converting"
    inputBinding:
      position: 1
      prefix: -r
  - id: display_header
    type:
      - 'null'
      - boolean
    doc: "Include header [Kraken report filename] in mpa-report file [default: no header]"
    inputBinding:
      position: 101
      prefix: --display-header
  - id: read_count
    type:
      - 'null'
      - boolean
    doc: "Use read count for output [default]"
    inputBinding:
      position: 101
      prefix: --read_count
  - id: percentages
    type:
      - 'null'
      - boolean
    doc: "Use percentages for output [instead of reads]"
    inputBinding:
      position: 101
      prefix: --percentages
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
  - id: remove_spaces
    type:
      - 'null'
      - boolean
    doc: "Replace space with underscore in taxon name [default]"
    inputBinding:
      position: 101
      prefix: --remove-spaces
  - id: keep_spaces
    type:
      - 'null'
      - boolean
    doc: "Do not replace space with underscore in taxon name"
    inputBinding:
      position: 101
      prefix: --keep-spaces
  - id: output_file_path
    type: string
    doc: "Output mpa-report file name"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: "MetaPhlAn-style report"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
