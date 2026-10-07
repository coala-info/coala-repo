cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chamois
  - explain
label: chamois_explain_feature
doc: "Explain which features contribute to a class prediction.\n\nTool homepage: https://chamois.readthedocs.io/"
arguments:
  - position: 2
    valueFrom: feature
inputs:
  - id: model
    type:
      - 'null'
      - File
    doc: The path to an alternative model to extract weights from (default is 
      the model shipped with CHAMOIS). This is an option of 'chamois explain'.
    inputBinding:
      position: 1
      prefix: --model
  - id: feature_id
    type: string
    doc: The feature to explain
    inputBinding:
      position: 4
  - id: nonzero
    type:
      - 'null'
      - boolean
    doc: Display non-zero weights instead of only positive weights (cannot be 
      used with min_weight).
    inputBinding:
      position: 3
      prefix: --nonzero
  - id: min_weight
    type:
      - 'null'
      - float
    doc: 'The minimum weight to filter the table with. (default: 0.0)'
    inputBinding:
      position: 3
      prefix: --min-weight
  - id: output
    type:
      - 'null'
      - string
    doc: The path where to write the contribution table in TSV format.
    inputBinding:
      position: 3
      prefix: --output
  - id: render
    type:
      - 'null'
      - boolean
    doc: Display the contribution table in the console.
    inputBinding:
      position: 3
      prefix: --render
outputs:
  - id: stdout
    type: stdout
    doc: Console output (the table when render is set)
  - id: output_table
    type:
      - 'null'
      - File
    doc: Contribution table in TSV format
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
stdout: chamois_explain_feature.out
