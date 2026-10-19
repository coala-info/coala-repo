cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - parser
label: rgi_rgi_parser
doc: "Creates categorical JSON files for the RGI wheel visualization. An input JSON file containing the RGI results must be given.\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: include_loose
    type:
      - 'null'
      - boolean
    doc: Include loose hits in addition to strict and perfect hits
    inputBinding:
      position: 101
      prefix: --include_loose
  - id: input
    type: File
    doc: RGI results in a .json file
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Name/identifier for the output categorical .json files
    inputBinding:
      position: 101
      prefix: --output
  - id: type
    type:
      - 'null'
      - string
    doc: 'type of input sequence: contig, protein or read'
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: categorical_json_files
    type:
      type: array
      items: File
    doc: Categorical JSON files (output name plus -count-hits.json, -tree-dc.json, -tree-gf.json, -tree-og.json, -tree-rm.json)
    outputBinding:
      glob: $(inputs.output)-*.json
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
