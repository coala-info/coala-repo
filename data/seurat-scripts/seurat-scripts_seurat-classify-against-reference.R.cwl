cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-classify-against-reference.R
label: seurat-scripts_seurat-classify-against-reference.R
doc: 'Classify query cells against a reference Seurat object (Seurat FindTransferAnchors and TransferData).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: query_file
    type: File
    doc: File containing seurat object to use as the query.
    inputBinding:
      position: 1
      prefix: --query-file=
      separate: false
  - id: reference_file
    type: File
    doc: File containing seurat object to use as the reference.
    inputBinding:
      position: 2
      prefix: --reference-file=
      separate: false
  - id: output_object_file
    type: string
    doc: File name in which to store serialized R object of type 'Seurat'.'
    inputBinding:
      position: 3
      prefix: --output-object-file=
      separate: false
  - id: transfer_refdata
    type: string
    doc: 'Data to transfer. The name of the metadata field or assay from the reference object provided. This requires the reference parameter to be specified. '
    inputBinding:
      position: 4
      prefix: --transfer-refdata=
      separate: false
  - id: transfer_weight_reduction
    type: string
    doc: 'Dimensional reduction to use for the weighting anchors. Options are: pcaproject - Use the projected PCA used for anchor building; pca - Use an internal PCA on the query only; cca - Use the CCA used for anchor building; custom DimReduc - User provided DimReduc paths as RDS, computed on the query cells'
    inputBinding:
      position: 5
      prefix: --transfer-weight-reduction=
      separate: false
  - id: query_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 6
      prefix: --query-format=
      separate: false
  - id: reference_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 7
      prefix: --reference-format=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 8
      prefix: --output-format=
      separate: false
  - id: output_anchorset_file
    type:
      - 'null'
      - string
    doc: File name in which to store serialized R object for the anchorset.
    inputBinding:
      position: 9
      prefix: --output-anchorset-file=
      separate: false
  - id: output_anchorset_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 10
      prefix: --output-anchorset-format=
      separate: false
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: 'Name of normalization method used: LogNormalize or SCT.'
    inputBinding:
      position: 11
      prefix: --normalization-method=
      separate: false
  - id: reference_assay
    type:
      - 'null'
      - string
    doc: Assay to use from reference.
    inputBinding:
      position: 12
      prefix: --reference-assay=
      separate: false
  - id: query_assay
    type:
      - 'null'
      - string
    doc: Assay to use from query.
    inputBinding:
      position: 13
      prefix: --query-assay=
      separate: false
  - id: reduction
    type:
      - 'null'
      - string
    doc: Dimensional reduction to perform when finding anchors.
    inputBinding:
      position: 14
      prefix: --reduction=
      separate: false
  - id: reference_reduction
    type:
      - 'null'
      - string
    doc: Name of dimensional reduction to use from the reference if running the pcaproject workflow. Optionally enables reuse of precomputed reference dimensional reduction. If NULL (default), use a PCA computed on the reference object.
    inputBinding:
      position: 15
      prefix: --reference_reduction=
      separate: false
  - id: project_query
    type:
      - 'null'
      - boolean
    doc: Project the PCA from the query dataset onto the reference. Use only in rare cases.
    inputBinding:
      position: 16
      prefix: --project-query
  - id: l2_norm
    type:
      - 'null'
      - boolean
    doc: Execute a l2 normalization on the query.
    inputBinding:
      position: 17
      prefix: --l2-norm
  - id: features
    type:
      - 'null'
      - string
    doc: Features to use for dimensional reductionFeatures to use for dimensional reduction.
    inputBinding:
      position: 18
      prefix: --features=
      separate: false
  - id: npcs
    type:
      - 'null'
      - int
    doc: Number of PCs to compute on reference. If null, then use an existing PCA structure in the reference object.
    inputBinding:
      position: 19
      prefix: --npcs=
      separate: false
  - id: dims
    type:
      - 'null'
      - string
    doc: Which dimensions to use from the reduction to specify the neighbor search space.
    inputBinding:
      position: 20
      prefix: --dims=
      separate: false
  - id: k_anchor
    type:
      - 'null'
      - int
    doc: How many neighbors (k) to use when picking anchors.
    inputBinding:
      position: 21
      prefix: --k-anchor=
      separate: false
  - id: k_filter
    type:
      - 'null'
      - int
    doc: How many neighbors (k) to use when filtering anchors.
    inputBinding:
      position: 22
      prefix: --k-filter=
      separate: false
  - id: k_score
    type:
      - 'null'
      - int
    doc: How many neighbors (k) to use when scoring anchors.
    inputBinding:
      position: 23
      prefix: --k-score=
      separate: false
  - id: max_features
    type:
      - 'null'
      - int
    doc: The maximum number of features to use when specifying the neighborhood search space in the anchor filtering.
    inputBinding:
      position: 24
      prefix: --max-features=
      separate: false
  - id: nn_method
    type:
      - 'null'
      - string
    doc: 'Method for nearest neighbor finding. Options include: rann, annoy.'
    inputBinding:
      position: 25
      prefix: --nn-method=
      separate: false
  - id: eps
    type:
      - 'null'
      - int
    doc: Error bound on the neighbor finding algorithm (from RANN).
    inputBinding:
      position: 26
      prefix: --eps=
      separate: false
  - id: approx_pca
    type:
      - 'null'
      - boolean
    doc: Use truncated singular value decomposition to approximate PCA.
    inputBinding:
      position: 27
      prefix: --approx-pca
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print progress bars and output.
    inputBinding:
      position: 28
      prefix: --verbose
  - id: transfer_l2_norm
    type:
      - 'null'
      - boolean
    doc: Perform L2 normalization on the cell embeddings after dimensional reduction
    inputBinding:
      position: 29
      prefix: --transfer-l2-norm
  - id: transfer_dims
    type:
      - 'null'
      - string
    doc: Set of dimensions to use in the anchor weighting procedure.
    inputBinding:
      position: 30
      prefix: --transfer-dims=
      separate: false
  - id: transfer_k_weight
    type:
      - 'null'
      - int
    doc: Number of neighbors to consider when weighting anchors
    inputBinding:
      position: 31
      prefix: --transfer-k-weight=
      separate: false
  - id: transfer_sd_weight
    type:
      - 'null'
      - int
    doc: Controls the bandwidth of the Gaussian kernel for weighting
    inputBinding:
      position: 32
      prefix: --transfer-sd-weight=
      separate: false
  - id: transfer_eps
    type:
      - 'null'
      - int
    doc: Error bound on the neighbor finding algorithm (from RANN), for transfer
    inputBinding:
      position: 33
      prefix: --transfer-eps=
      separate: false
  - id: transfer_prediction_assay
    type:
      - 'null'
      - boolean
    doc: Return an Assay object with the prediction scores for each class stored in the data slot.
    inputBinding:
      position: 34
      prefix: --transfer-prediction-assay
  - id: transfer_n_trees
    type:
      - 'null'
      - int
    doc: More trees gives higher precision when using annoy approximate nearest neighbor search.
    inputBinding:
      position: 35
      prefix: --transfer-n-trees=
      separate: false
  - id: transfer_slot
    type:
      - 'null'
      - string
    doc: Slot to store the imputed data. Must be either 'data' (default) or 'counts'
    inputBinding:
      position: 36
      prefix: --transfer-slot=
      separate: false
  - id: transfer_no_store_weights
    type:
      - 'null'
      - boolean
    doc: Don't store the weights matrix used for predictions in the returned query object.
    inputBinding:
      position: 37
      prefix: --transfer-no-store-weights
  - id: metadata_col
    type:
      - 'null'
      - string
    doc: Col name to store metadata in.
    inputBinding:
      position: 38
      prefix: --metadata-col=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R object of type 'Seurat'.'
    outputBinding:
      glob: $(inputs.output_object_file)
  - id: output_anchorset_file
    type:
      - 'null'
      - File
    doc: File name in which to store serialized R object for the anchorset.
    outputBinding:
      glob: $(inputs.output_anchorset_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
