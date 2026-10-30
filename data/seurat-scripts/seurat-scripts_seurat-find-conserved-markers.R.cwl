cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-find-conserved-markers.R
label: seurat-scripts_seurat-find-conserved-markers.R
doc: 'Find markers conserved across groups of cells (Seurat FindConservedMarkers).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: Query file with Seurat object in either RDS-Seurat, Loom or SCE
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: markers_output_file
    type: string
    doc: Output path for tab separated conserved marker genes file.
    inputBinding:
      position: 2
      prefix: --markers_output_file=
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
  - id: ident_1
    type:
      - 'null'
      - string
    doc: Identity class to define markers for
    inputBinding:
      position: 4
      prefix: --ident-1=
      separate: false
  - id: ident_2
    type:
      - 'null'
      - string
    doc: A second identity class for comparison. If NULL (default) - use all other cells for comparison.
    inputBinding:
      position: 5
      prefix: --ident-2=
      separate: false
  - id: grouping_var
    type:
      - 'null'
      - string
    doc: grouping variable
    inputBinding:
      position: 6
      prefix: --grouping-var=
      separate: false
  - id: assay
    type:
      - 'null'
      - string
    doc: of assay to fetch data for (default is RNA)
    inputBinding:
      position: 7
      prefix: --assay=
      separate: false
  - id: slot
    type:
      - 'null'
      - string
    doc: Slot to pull data from; note that if test.use is negbinom, poisson, or DESeq2, slot will be set to counts.
    inputBinding:
      position: 8
      prefix: --slot=
      separate: false
  - id: meta_method
    type:
      - 'null'
      - string
    doc: 'method for combining p-values. Should be a function from the metap package: invchisq, invt, logitp, meanp, meanz, maximump, minimump, sumlog, sumz, truncated, votep, wilkinsonp'
    inputBinding:
      position: 9
      prefix: --meta-method=
      separate: false
  - id: reduction
    type:
      - 'null'
      - string
    doc: Reduction to use in differential expression testing - will test for DE on cell embeddings
    inputBinding:
      position: 10
      prefix: --reduction=
      separate: false
  - id: features
    type:
      - 'null'
      - string
    doc: Genes to test. Default is to use all genes
    inputBinding:
      position: 11
      prefix: --features=
      separate: false
  - id: logfc_threshold
    type:
      - 'null'
      - int
    doc: Limit testing to genes which show, on average, at least X-fold difference (log-scale) between the two groups of cells. Default is 0.25 Increasing logfc.threshold speeds up the function, but can miss weaker signals.
    inputBinding:
      position: 12
      prefix: --logfc-threshold=
      separate: false
  - id: test_use
    type:
      - 'null'
      - string
    doc: Identifies differentially expressed genes between two groups using (see options)
    inputBinding:
      position: 13
      prefix: --test-use=
      separate: false
  - id: min_pct
    type:
      - 'null'
      - int
    doc: only test genes that are detected in a minimum fraction of min.pct cells in either of the two populations. Meant to speed up the function by not testing genes that are very infrequently expressed. Default is 0.1
    inputBinding:
      position: 14
      prefix: --min-pct=
      separate: false
  - id: min_diff_pct
    type:
      - 'null'
      - float
    doc: only test genes that show a minimum difference in the fraction of detection between the two groups. Set to -Inf by default
    inputBinding:
      position: 15
      prefix: --min-diff-pct=
      separate: false
  - id: do_not_verbose
    type:
      - 'null'
      - boolean
    doc: Print a progress bar once expression testing begins
    inputBinding:
      position: 16
      prefix: --do-not-verbose
  - id: only_pos
    type:
      - 'null'
      - boolean
    doc: Only return positive markers (FALSE by default)
    inputBinding:
      position: 17
      prefix: --only-pos
  - id: max_cells_per_ident
    type:
      - 'null'
      - float
    doc: Down sample each identity class to a max number. Default is no downsampling. Not activated by default (set to Inf)
    inputBinding:
      position: 18
      prefix: --max-cells-per-ident=
      separate: false
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed for downsampling
    inputBinding:
      position: 19
      prefix: --random-seed=
      separate: false
  - id: latent_vars
    type:
      - 'null'
      - string
    doc: Variables to test, used only when test.use is one of LR, negbinom, poisson, or MAST.
    inputBinding:
      position: 20
      prefix: --latent-vars=
      separate: false
  - id: min_cells_feature
    type:
      - 'null'
      - int
    doc: Minimum number of cells expressing the feature in at least one of the two groups, currently only used for poisson and negative binomial tests
    inputBinding:
      position: 21
      prefix: --min-cells-feature=
      separate: false
  - id: min_cells_group
    type:
      - 'null'
      - int
    doc: Minimum number of cells in one of the groups
    inputBinding:
      position: 22
      prefix: --min-cells-group=
      separate: false
  - id: pseudocount_use
    type:
      - 'null'
      - int
    doc: Pseudocount to add to averaged expression values when calculating logFC. 1 by default.
    inputBinding:
      position: 23
      prefix: --pseudocount-use=
      separate: false
  - id: mean_fxn
    type:
      - 'null'
      - string
    doc: Function to use for fold change or average difference calculation. If NULL, the appropriate function will be chose according to the slot used
    inputBinding:
      position: 24
      prefix: --mean-fxn=
      separate: false
  - id: fc_name
    type:
      - 'null'
      - string
    doc: Name of the fold change, average difference, or custom function column in the output data.frame. If NULL, the fold change column will be named according to the logarithm base (eg, avg_log2FC), or if using the scale.data slot avg_diff.
    inputBinding:
      position: 25
      prefix: --fc-name=
      separate: false
  - id: base
    type:
      - 'null'
      - int
    doc: The base with respect to which logarithms are computed.
    inputBinding:
      position: 26
      prefix: --base=
      separate: false
outputs:
  - id: markers_output_file
    type: File
    doc: Output path for tab separated conserved marker genes file.
    outputBinding:
      glob: $(inputs.markers_output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
