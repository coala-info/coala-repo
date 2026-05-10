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
  - id: distance_matrix_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `distance_matrix_path`
    inputBinding:
      position: 102
      prefix: --distance-matrix
  - id: output_path
    type:
      - 'null'
      - string
    doc: The path where to write the sequence annotations in
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The path where to write the catalog search results in TSV format.
    outputBinding:
      glob: $(inputs.output_path)
  - id: distance_matrix
    type:
      - 'null'
      - File
    doc: The path where to write the generated pairwise distance matrix.
    outputBinding:
      glob: $(inputs.distance_matrix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
