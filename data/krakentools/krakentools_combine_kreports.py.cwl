cwlVersion: v1.2
class: CommandLineTool
baseCommand: combine_kreports.py
label: krakentools_combine_kreports.py
doc: "Combine multiple Kraken reports into one report with per-sample and combined columns.\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs:
  - id: report_files
    type:
      type: array
      items: File
    doc: "Input kraken report files to combine"
    inputBinding:
      position: 1
      prefix: -r
  - id: display_headers
    type:
      - 'null'
      - boolean
    doc: "Include header lines"
    inputBinding:
      position: 101
      prefix: --display-headers
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: "Do not include header lines"
    inputBinding:
      position: 101
      prefix: --no-headers
  - id: sample_names
    type:
      - 'null'
      - type: array
        items: string
    doc: "Sample names to use as headers in the new report"
    inputBinding:
      position: 101
      prefix: --sample-names
  - id: only_combined
    type:
      - 'null'
      - boolean
    doc: "Include only the total combined reads column, not the individual sample columns"
    inputBinding:
      position: 101
      prefix: --only-combined
  - id: output_file_path
    type: string
    doc: "Output kraken report file with combined information"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: "Combined kraken report"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
