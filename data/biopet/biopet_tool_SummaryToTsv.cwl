cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - SummaryToTsv
label: biopet_tool_SummaryToTsv
doc: "Extract values from a Biopet summary JSON into a TSV table.\n\nTool homepage: https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: summary
    type: File
    doc: Biopet summary JSON file
    inputBinding:
      position: 101
      prefix: --summary
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output TSV file; stdout when not given
    inputBinding:
      position: 101
      prefix: --outputFile
  - id: value_path
    type:
      type: array
      items: string
      inputBinding:
        prefix: --path
    doc: Values to extract, as <header_name>=<namespace>:<lower_namespace>:...
    inputBinding:
      position: 101
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Level to aggregate data: root, sample or lib'
    inputBinding:
      position: 101
      prefix: --mode
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: tsv
    type:
      - 'null'
      - File
    doc: Output TSV file
    outputBinding:
      glob: '$(inputs.output_file ? inputs.output_file : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_tool_SummaryToTsv.out
