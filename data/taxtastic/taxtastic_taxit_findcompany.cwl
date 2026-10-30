cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - findcompany
label: taxtastic_taxit_findcompany
doc: "Find company for lonely nodes\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: cut
    type:
      - 'null'
      - boolean
    doc: "Produce only one output tax_id per input tax_id, whether or not the output species would themselves be lonely."
    inputBinding:
      position: 1
      prefix: "--cut"
  - id: input
    type:
      - 'null'
      - File
    doc: "Text file to read Tax IDs from, one per line"
    inputBinding:
      position: 1
      prefix: "--input"
  - id: out
    type:
      - 'null'
      - string
    doc: "Output file for new taxids"
    inputBinding:
      position: 1
      prefix: "--out"
  - id: taxdb
    type: File
    doc: "Taxonomy database to work from"
    inputBinding:
      position: 101
  - id: tax_ids
    type:
      - 'null'
      - {type: array, items: string}
    doc: "Tax IDs to look up"
    inputBinding:
      position: 102
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: "New tax_ids (only with --out)"
    outputBinding:
      glob: "$(inputs.out)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_findcompany.out
