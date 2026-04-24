cwlVersion: v1.2
class: CommandLineTool
baseCommand: query_phenomizer
label: query_phenomizer
doc: "Give hpo terms either on the form 'HP:0001623', or '0001623'\n\nTool homepage:
  https://www.github.com/moonso/query_phenomizer"
inputs:
  - id: hpo_terms
    type:
      - 'null'
      - type: array
        items: string
    doc: HPO terms to query
    inputBinding:
      position: 1
  - id: check_terms
    type:
      - 'null'
      - boolean
    doc: Check if the term(s) exist
    inputBinding:
      position: 102
      prefix: --check-terms
  - id: p_value_limit
    type:
      - 'null'
      - float
    doc: Specify the highest p-value that you want included.
    inputBinding:
      position: 102
      prefix: --p-value-limit
  - id: password
    type:
      - 'null'
      - string
    doc: A password for phenomizer
    inputBinding:
      position: 102
      prefix: --password
  - id: to_json
    type:
      - 'null'
      - boolean
    doc: If result should be printed to json format
    inputBinding:
      position: 102
      prefix: --to-json
  - id: username
    type:
      - 'null'
      - string
    doc: A username for phenomizer
    inputBinding:
      position: 102
      prefix: --username
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Specify the path to a file for storing the phenomizer output.
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/query_phenomizer:1.2.1--pyh7cba7a3_0
