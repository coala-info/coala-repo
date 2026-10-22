cwlVersion: v1.2
class: CommandLineTool
baseCommand: scater-calculate-cpm.R
label: scater-scripts_scater-calculate-cpm.R
doc: "Calculates counts per million (CPM) for a SingleCellExperiment object.\n\nTool
  homepage: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts"
inputs:
  - id: input_object_file
    type: File
    doc: File name containing serialized SingleCellExperiment object or count 
      matrix.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: exprs_values
    type:
      - 'null'
      - string
    doc: A string specifying the assay of the object containing the count 
      matrix, if the object is a SingleCellExperiment.
    inputBinding:
      position: 101
      prefix: --exprs-values
  - id: size_factors
    type:
      - 'null'
      - string
    doc: A logical scalar (TRUE or FALSE) indicating whether size factors in the 
      object should be used to compute effective library sizes. If not, all size 
      factors are deleted and library size-based factors are used instead. 
      Alternatively, a numeric vector containing a size factor for each cell.
    inputBinding:
      position: 101
      prefix: --size-factors
  - id: output_object_file_path
    type:
      - 'null'
      - string
    doc: File name in which to store serialized R object of type 'Scater'.
    inputBinding:
      position: 102
      prefix: --output-object-file
  - id: output_text_file_path
    type:
      - 'null'
      - string
    doc: File name in which to store CPM values.
    inputBinding:
      position: 103
      prefix: --output-text-file
outputs:
  - id: output_object_file
    type:
      - 'null'
      - File
    doc: Serialized R object with the CPM values
    outputBinding:
      glob: $(inputs.output_object_file_path)
  - id: output_text_file
    type:
      - 'null'
      - File
    doc: Text file with the CPM values
    outputBinding:
      glob: $(inputs.output_text_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scater-scripts:0.0.5--0
