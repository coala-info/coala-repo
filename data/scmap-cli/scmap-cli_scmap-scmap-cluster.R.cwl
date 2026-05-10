cwlVersion: v1.2
class: CommandLineTool
baseCommand: scmap-scmap-cluster.R
label: scmap-cli_scmap-scmap-cluster.R
doc: "Assigns cell types to cells in a SingleCellExperiment object using pre-computed
  cluster assignments.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scmap-cli"
inputs:
  - id: index_object_file
    type:
      - 'null'
      - File
    doc: "'SingleCellExperiment' object previously prepared with the scmap-index-cluster.R
      script."
    inputBinding:
      position: 101
      prefix: --index-object-file
  - id: projection_object_file
    type:
      - 'null'
      - File
    doc: "'SingleCellExperiment' object to project."
    inputBinding:
      position: 101
      prefix: --projection-object-file
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold on similarity (or probability for SVM and RF).
    inputBinding:
      position: 101
      prefix: --threshold
  - id: output_object_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_object_file_path`
    inputBinding:
      position: 102
      prefix: --output-object-file
  - id: output_text_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_text_file_path`
    inputBinding:
      position: 103
      prefix: --output-text-file
outputs:
  - id: output_text_file
    type:
      - 'null'
      - File
    doc: File name in which to text-format cell type assignments.
    outputBinding:
      glob: $(inputs.output_text_file_path)
  - id: output_object_file
    type:
      - 'null'
      - File
    doc: File name in which to store serialized R object of type 
      'SingleCellExperiment'.
    outputBinding:
      glob: $(inputs.output_object_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
