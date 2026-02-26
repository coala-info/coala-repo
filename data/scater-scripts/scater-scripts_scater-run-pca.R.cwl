cwlVersion: v1.2
class: CommandLineTool
baseCommand: scater-run-pca.R
label: scater-scripts_scater-run-pca.R
doc: "Performs Principal Component Analysis (PCA) on a SingleCellExperiment object.\n\
  \nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts"
inputs:
  - id: detect_outliers
    type:
      - 'null'
      - boolean
    doc: Logical scalar, should outliers be detected based on PCA coordinates 
      generated from column-level metadata?
    inputBinding:
      position: 101
      prefix: --detect-outliers
  - id: exprs_values
    type:
      - 'null'
      - string
    doc: Integer scalar or string indicating which assay of object should be 
      used to obtain the expression values for the calculations.
    inputBinding:
      position: 101
      prefix: --exprs-values
  - id: feature_set
    type:
      - 'null'
      - File
    doc: file (one cell per line) to be used to derive a character vector of row
      names indicating a set of features to use for PCA. This will override any 
      ntop argument if specified.
    inputBinding:
      position: 101
      prefix: --feature-set
  - id: input_object_file
    type: File
    doc: singleCellExperiment object containing expression values and 
      experimental information. Must have been appropriately prepared.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: method
    type:
      - 'null'
      - string
    doc: String specifying how the PCA should be performed.
    default: prcomp
    inputBinding:
      position: 101
      prefix: --method
  - id: ncomponents
    type: int
    doc: Numeric scalar indicating the number of principal components to obtain.
    inputBinding:
      position: 101
      prefix: --ncomponents
  - id: ntop
    type:
      - 'null'
      - int
    doc: Numeric scalar specifying the number of most variable features to use 
      for PCA.
    inputBinding:
      position: 101
      prefix: --ntop
  - id: scale_features
    type:
      - 'null'
      - boolean
    doc: Logical scalar, should the expression values be standardised so that 
      each feature has unit variance? This will also remove features with 
      standard deviations below 1e-8.
    inputBinding:
      position: 101
      prefix: --scale-features
  - id: selected_variables
    type:
      - 'null'
      - string
    doc: Comma-separated list of strings indicating which variables in 
      colData(object) to use for PCA when use_coldata=TRUE.
    inputBinding:
      position: 101
      prefix: --selected-variables
  - id: use_coldata
    type:
      - 'null'
      - boolean
    doc: Logical scalar specifying whether the column data should be used 
      instead of expression values to perform PCA.
    inputBinding:
      position: 101
      prefix: --use-coldata
outputs:
  - id: output_object_file
    type:
      - 'null'
      - File
    doc: file name in which to store serialized R object of type 
      'SingleCellExperiment'.
    outputBinding:
      glob: $(inputs.output_object_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scater-scripts:0.0.5--0
