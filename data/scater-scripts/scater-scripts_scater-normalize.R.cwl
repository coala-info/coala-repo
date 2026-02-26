cwlVersion: v1.2
class: CommandLineTool
baseCommand: scater-normalize.R
label: scater-scripts_scater-normalize.R
doc: "Normalizes expression values in a SingleCellExperiment object.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts"
inputs:
  - id: centre_size_factors
    type:
      - 'null'
      - boolean
    doc: Logical scalar indicating whether size fators should be centred.
    inputBinding:
      position: 101
      prefix: --centre-size-factors
  - id: exprs_values
    type:
      - 'null'
      - string
    doc: String indicating which assay contains the count data that should be 
      used to compute log-transformed expression values.
    inputBinding:
      position: 101
      prefix: --exprs-values
  - id: input_object_file
    type: File
    doc: File name in which a serialized R SingleCellExperiment object where 
      object matrix found
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: log_exprs_offset
    type:
      - 'null'
      - float
    doc: Numeric scalar specifying the offset to add when log-transforming 
      expression values. If ‘NULL’, value is taken from 
      ‘metadata(object)$log.exprs.offset’ if defined, otherwise 1.
    inputBinding:
      position: 101
      prefix: --log-exprs-offset
  - id: return_log
    type:
      - 'null'
      - boolean
    doc: Logical scalar, should normalized values be returned on the log2 scale?
    inputBinding:
      position: 101
      prefix: --return-log
outputs:
  - id: output_object_file
    type:
      - 'null'
      - File
    doc: File name in which to store serialized R object of type 
      'SingleCellExperiment'.
    outputBinding:
      glob: $(inputs.output_object_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scater-scripts:0.0.5--0
