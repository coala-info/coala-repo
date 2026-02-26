cwlVersion: v1.2
class: CommandLineTool
baseCommand: scater-run-tsne.R
label: scater-scripts_scater-run-tsne.R
doc: "Performs t-SNE dimensionality reduction on a SingleCellExperiment object.\n\n\
  Tool homepage: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts"
inputs:
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
      names, indicating a set of features to use for t-SNE. This will override 
      any ntop argument if specified.
    inputBinding:
      position: 101
      prefix: --feature-set
  - id: initial_dims
    type:
      - 'null'
      - int
    doc: Integer scalar passed to Rtsne, specifying the number of principal 
      components to be retained if pca=TRUE.
    inputBinding:
      position: 101
      prefix: --initial-dims
  - id: input_object_file
    type: File
    doc: singleCellExperiment object containing expression values and 
      experimental information. Must have been appropriately prepared.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: n_dimred
    type:
      - 'null'
      - int
    doc: Integer scalar, number of dimensions of the reduced dimension slot to 
      use when use_dimred is supplied. Defaults to all available dimensions.
    inputBinding:
      position: 101
      prefix: --n-dimred
  - id: ncomponents
    type:
      - 'null'
      - int
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
  - id: pca
    type:
      - 'null'
      - boolean
    doc: Logical scalar passed to Rtsne, indicating whether an initial PCA step 
      should be performed. This is ignored if use_dimred is specified.
    inputBinding:
      position: 101
      prefix: --pca
  - id: perplexity
    type:
      - 'null'
      - float
    doc: Numeric scalar defining the perplexity parameter, see ?Rtsne for more 
      details.
    inputBinding:
      position: 101
      prefix: --perplexity
  - id: scale_features
    type:
      - 'null'
      - boolean
    doc: Logical scalar, should the expression values be standardised so that 
      each feature has unit variance?
    inputBinding:
      position: 101
      prefix: --scale-features
  - id: use_dimred
    type:
      - 'null'
      - string
    doc: String or integer scalar specifying the entry of reducedDims(object) to
      use as input to Rtsne. Default is to not use existing reduced dimension 
      results.
    inputBinding:
      position: 101
      prefix: --use-dimred
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
