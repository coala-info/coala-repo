cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-integration.R
label: seurat-scripts_seurat-integration.R
doc: 'Integrate Seurat objects: find anchors and integrate the data (Seurat FindIntegrationAnchors and IntegrateData).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_files
    type:
      type: array
      items: File
    doc: A list of Seurat objects between which to find anchors for downstream integration. Input files in either RDS-Seurat, Loom or SCE, comma separated.
    inputBinding:
      position: 1
      prefix: --input-object-files=
      separate: false
      itemSeparator: ','
  - id: output_object_file
    type: string
    doc: FILE IN
    inputBinding:
      position: 2
      prefix: --output-object-file=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 3
      prefix: --input-format=
      separate: false
  - id: reference_object_files
    type:
      - 'null'
      - type: array
        items: File
    doc: A vector specifying the object/s to be used as a reference during integration. If NULL (default), all pairwise anchors are found (no reference/s). If not NULL, the corresponding objects in this list will be used as references. When using a set of specified references, anchors are first found between each query and each reference. The references are then integrated through pairwise integration. Each query is then mapped to the integrated reference.
    inputBinding:
      position: 4
      prefix: --reference-object-files=
      separate: false
      itemSeparator: ','
  - id: reference_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 5
      prefix: --reference-format=
      separate: false
  - id: assay_list
    type:
      - 'null'
      - string
    doc: A vector of assay names specifying which assay to use when constructing anchors. If NULL, the current default assay for each object is used.
    inputBinding:
      position: 6
      prefix: --assay-list=
      separate: false
  - id: anchor_features
    type:
      - 'null'
      - string
    doc: A numeric value (this will call 'SelectIntegrationFeatures' to select the provided number of features to be used in anchor finding) or a file with a vector of features to be used as input to the anchor finding process (comma separated)
    inputBinding:
      position: 7
      prefix: --anchor-features=
      separate: false
  - id: do_not_scale
    type:
      - 'null'
      - boolean
    doc: Whether or not to scale the features provided. Only call if you have previously scaled the features you want to use for each object in the object.list
    inputBinding:
      position: 8
      prefix: --do-not-scale
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: 'Name of normalization method used: LogNormalize or SCT'
    inputBinding:
      position: 9
      prefix: --normalization-method=
      separate: false
  - id: sct_clip_range
    type:
      - 'null'
      - string
    doc: Numeric of length two specifying the min and max values the Pearson residual will be clipped to
    inputBinding:
      position: 10
      prefix: --sct-clip-range=
      separate: false
  - id: reduction
    type:
      - 'null'
      - string
    doc: Dimensional reduction to perform when finding anchors. Can be cca (Canonical correlation analysis) or rpca (Reciprocal PCA)
    inputBinding:
      position: 11
      prefix: --reduction=
      separate: false
  - id: do_not_l2_norm
    type:
      - 'null'
      - boolean
    doc: Perform L2 normalization on the CCA cell embeddings after dimensional reduction
    inputBinding:
      position: 12
      prefix: --do-not-l2-norm
  - id: dims
    type:
      - 'null'
      - string
    doc: Which dimensions to use from the CCA to specify the neighbor search space
    inputBinding:
      position: 13
      prefix: --dims=
      separate: false
  - id: k_anchor
    type:
      - 'null'
      - int
    doc: How many neighbors (k) to use when picking anchors
    inputBinding:
      position: 14
      prefix: --k-anchor=
      separate: false
  - id: k_filter
    type:
      - 'null'
      - int
    doc: How many neighbors (k) to use when filtering anchors
    inputBinding:
      position: 15
      prefix: --k-filter=
      separate: false
  - id: k_score
    type:
      - 'null'
      - int
    doc: How many neighbors (k) to use when scoring anchors
    inputBinding:
      position: 16
      prefix: --k-score=
      separate: false
  - id: max_features
    type:
      - 'null'
      - int
    doc: The maximum number of features to use when specifying the neighborhood search space in the anchor filtering
    inputBinding:
      position: 17
      prefix: --max-features=
      separate: false
  - id: nn_method
    type:
      - 'null'
      - string
    doc: 'Method for nearest neighbor finding. Options include: rann, annoy'
    inputBinding:
      position: 18
      prefix: --nn-method=
      separate: false
  - id: n_trees
    type:
      - 'null'
      - int
    doc: More trees gives higher precision when using annoy approximate nearest neighbor search
    inputBinding:
      position: 19
      prefix: --n-trees=
      separate: false
  - id: eps
    type:
      - 'null'
      - int
    doc: Error bound on the neighbor finding algorithm (from RANN)
    inputBinding:
      position: 20
      prefix: --eps=
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print progress bars and output
    inputBinding:
      position: 21
      prefix: --verbose
  - id: new_assay_name
    type:
      - 'null'
      - string
    doc: Name for the new assay containing the integrated data
    inputBinding:
      position: 22
      prefix: --new-assay-name=
      separate: false
  - id: integrate_features_pca
    type:
      - 'null'
      - string
    doc: Vector of features to use when computing the PCA to determine the weights. Only set if you want a different set from those used in the anchor finding process
    inputBinding:
      position: 23
      prefix: --integrate-features-pca=
      separate: false
  - id: features_to_integrate
    type:
      - 'null'
      - string
    doc: Vector of features to integrate. By default, will use the features used in anchor finding.
    inputBinding:
      position: 24
      prefix: --features-to-integrate=
      separate: false
  - id: integrate_dims
    type:
      - 'null'
      - string
    doc: Number of dimensions to use in the anchor weighting procedure
    inputBinding:
      position: 25
      prefix: --integrate-dims=
      separate: false
  - id: k_weight
    type:
      - 'null'
      - int
    doc: Number of neighbors to consider when weighting anchors
    inputBinding:
      position: 26
      prefix: --k-weight=
      separate: false
  - id: weight_reduction
    type:
      - 'null'
      - string
    doc: 'Dimension reduction to use when calculating anchor weights. This can be one of: A string, specifying the name of a dimension reduction present in all objects to be integrated; A vector of strings, specifying the name of a dimension reduction to use for each object to be integrated; A vector of DimReduc objects, specifying the object to use for each object in the integration; NULL, in which case a new PCA will be calculated and used to calculate anchor weights. Note that, if specified, the requested dimension reduction will only be used for calculating anchor weights in the first merge between reference and query, as the merged object will subsequently contain more cells than was in query, and weights will need to be calculated for all cells in the object.'
    inputBinding:
      position: 27
      prefix: --weight-reduction=
      separate: false
  - id: sd_weight
    type:
      - 'null'
      - int
    doc: Controls the bandwidth of the Gaussian kernel for weighting
    inputBinding:
      position: 28
      prefix: --sd-weight=
      separate: false
  - id: sample_tree
    type:
      - 'null'
      - string
    doc: Specify the order of integration. If NULL, will compute automatically.
    inputBinding:
      position: 29
      prefix: --sample-tree=
      separate: false
  - id: preserve_order
    type:
      - 'null'
      - boolean
    doc: Do not reorder objects based on size for each pairwise integration.
    inputBinding:
      position: 30
      prefix: --preserve-order
  - id: integrate_eps
    type:
      - 'null'
      - int
    doc: Error bound on the neighbor finding algorithm (from 'RANN')
    inputBinding:
      position: 31
      prefix: --integrate-eps=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format
    inputBinding:
      position: 32
      prefix: --output-format=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: FILE IN
    outputBinding:
      glob: $(inputs.output_object_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
