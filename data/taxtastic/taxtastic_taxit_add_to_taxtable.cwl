cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - add_to_taxtable
label: taxtastic_taxit_add_to_taxtable
doc: "Add nodes to an existing taxtable csv\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: out
    type:
      - 'null'
      - string
    doc: "Destination for output taxtable [default: stdout]"
    inputBinding:
      position: 1
      prefix: "--out"
  - id: taxtable
    type: File
    doc: "A taxtable to augment"
    inputBinding:
      position: 101
  - id: nodes_csv
    type: File
    doc: "A CSV file containing nodes to add to taxtable. Must contain columns 'tax_id', 'tax_name', 'rank', and 'parent_id'. Each record must have a parent_id already in the taxtable, or defined on an earlier row."
    inputBinding:
      position: 102
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: "Augmented taxtable (only with --out)"
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
stdout: taxtastic_taxit_add_to_taxtable.out
