cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consplice
  - constraint
  - select-score
label: consplice_constraint_select-score
doc: "Select an O/E and matching Percentile score to filter on and remove all other non-essential columns after ConSplice scoring.\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs:
  - id: score_file
    type: File
    doc: 'The path to the scored ConSplice file to filter.'
    inputBinding:
      position: 1
      prefix: --score-file
  - id: o_over_e_field
    type: string
    doc: 'The name of the O/E score column within the scored ConSplice file to keep.'
    inputBinding:
      position: 1
      prefix: --o-over-e-field
  - id: pctl_field
    type: string
    doc: 'The name of the Percentile score column within the scored ConSplice file to keep.'
    inputBinding:
      position: 1
      prefix: --pctl-field
  - id: out_file
    type: string
    doc: 'The name of the output file to create.'
    inputBinding:
      position: 1
      prefix: --out-file
  - id: new_oe_name
    type:
      - 'null'
      - string
    doc: 'The new name of the O/E score column in the output file. Default = ''ConSplice_O/E''.'
    inputBinding:
      position: 1
      prefix: --new-oe-name
  - id: new_pctl_name
    type:
      - 'null'
      - string
    doc: 'The new name of the Percentile score column in the output file. Default = ''ConSplice_Percentile''.'
    inputBinding:
      position: 1
      prefix: --new-pctl-name
outputs:
  - id: output
    type: File
    doc: 'The output file.'
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
