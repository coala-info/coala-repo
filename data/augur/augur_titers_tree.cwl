cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - titers
  - tree
label: augur_titers_tree
doc: "Annotate titer drops onto a tree with the tree titer model.\n\nTool homepage:\
  \ https://github.com/nextstrain/augur"
inputs:
  - id: titers
    type:
      type: array
      items: File
    doc: file with titer measurements
    inputBinding:
      position: 1
      prefix: --titers
  - id: tree
    type: File
    doc: tree to perform fit titer model to
    inputBinding:
      position: 1
      prefix: --tree
  - id: allow_empty_model
    type:
      - 'null'
      - boolean
    doc: allow model to be empty
    inputBinding:
      position: 1
      prefix: --allow-empty-model
  - id: attribute_prefix
    type:
      - 'null'
      - string
    doc: prefix for node attributes in the JSON output including cumulative titer
      drop ('cTiter') and per- branch titer drop ('dTiter'). Set a prefix to disambiguate
      annotations from multiple tree model JSONs in the final Auspice JSON.
    inputBinding:
      position: 1
      prefix: --attribute-prefix
  - id: output
    type: string
    doc: JSON file to save titer model
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: JSON file with the titer model.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
