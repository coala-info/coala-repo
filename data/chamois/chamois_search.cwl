cwlVersion: v1.2
class: CommandLineTool
baseCommand: chamois_search
label: chamois_search
doc: "Searches a compound class catalog for predicted chemical classes.\n\nTool homepage:
  https://chamois.readthedocs.io/"
inputs:
  - id: catalog
    type: File
    doc: The path to the compound class catalog to compare predictions to.
    inputBinding:
      position: 101
      prefix: --catalog
  - id: input
    type: File
    doc: The chemical classes predicted by CHAMOIS for BGCs.
    inputBinding:
      position: 101
      prefix: --input
  - id: model
    type:
      - 'null'
      - string
    doc: The path to an alternative model used for predicting classes.
    inputBinding:
      position: 101
      prefix: --model
  - id: rank
    type:
      - 'null'
      - int
    doc: The maximum search rank to record in the table output.
    inputBinding:
      position: 101
      prefix: --rank
  - id: render
    type:
      - 'null'
      - boolean
    doc: Display best match for each query.
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
