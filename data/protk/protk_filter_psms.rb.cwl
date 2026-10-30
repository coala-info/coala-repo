cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_psms.rb
label: protk_filter_psms.rb
doc: 'Filter psms in a pepxml file.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: expression
    type: string
    doc: Expression (or comma separated expressions) matched against the search_hit attribute
    inputBinding:
      position: 1
  - id: pepxml_file
    type: File
    doc: Input pepXML file
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run in debug mode
    inputBinding:
      position: 102
      prefix: --debug
  - id: attribute
    type:
      - 'null'
      - string
    doc: Match expression against a specific search_hit attribute
    inputBinding:
      position: 102
      prefix: --attribute
  - id: check_alternatives
    type:
      - 'null'
      - boolean
    doc: Also match expression against to alternative_proteins
    inputBinding:
      position: 102
      prefix: --check-alternatives
  - id: reject
    type:
      - 'null'
      - boolean
    doc: Keep mismatches instead of matches
    inputBinding:
      position: 102
      prefix: --reject
  - id: output_path
    type: string
    doc: An explicitly named output file.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
