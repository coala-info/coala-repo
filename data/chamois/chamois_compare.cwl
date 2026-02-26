cwlVersion: v1.2
class: CommandLineTool
baseCommand: chamois_compare
label: chamois_compare
doc: "Compare chemical classes predicted by CHAMOIS for BGCs against a set of queries.\n\
  \nTool homepage: https://chamois.readthedocs.io/"
inputs:
  - id: input
    type: string
    doc: The chemical classes predicted by CHAMOIS for BGCs.
    inputBinding:
      position: 101
      prefix: --input
  - id: model
    type:
      - 'null'
      - string
    doc: The path to an alternative model used for predicting classes.
    default: None
    inputBinding:
      position: 101
      prefix: --model
  - id: queries
    type: string
    doc: The compounds to search in the predictions, as a SMILES, InChi, or 
      InChiKey.
    inputBinding:
      position: 101
      prefix: --query
  - id: rank
    type:
      - 'null'
      - int
    doc: The maximum search rank to record in the table output.
    default: 10
    inputBinding:
      position: 101
      prefix: --rank
  - id: render
    type:
      - 'null'
      - boolean
    doc: Display best match for each query.
    default: false
    inputBinding:
      position: 101
      prefix: --render
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The path where to write the catalog search results in TSV format.
    outputBinding:
      glob: $(inputs.output)
  - id: distance_matrix
    type:
      - 'null'
      - File
    doc: The path where to write the generated pairwise distance matrix.
    outputBinding:
      glob: $(inputs.distance_matrix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
