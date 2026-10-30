cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-find-markers.R
label: seurat-scripts_seurat-find-markers.R
doc: 'Find markers (differentially expressed genes) for each cluster (Seurat FindMarkers).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a serialized R matrix object may be found.
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: output_text_file
    type: string
    doc: File name in which to store text format matrix containing a ranked list of putative markers, and associated statistics (p-values, ROC score, etc.).
    inputBinding:
      position: 2
      prefix: --output-text-file=
      separate: false
  - id: genes_use
    type:
      - 'null'
      - File
    doc: File to be used to derive a vector of genes to test. Default is to use all genes.
    inputBinding:
      position: 3
      prefix: --genes-use=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 4
      prefix: --input-format=
      separate: false
  - id: logfc_threshold
    type:
      - 'null'
      - float
    doc: Limit testing to genes which show, on average, at least X-fold difference (log-scale) between the two groups of cells. Default is 0.25 Increasing logfc.threshold speeds up the function, but can miss weaker signals.
    inputBinding:
      position: 5
      prefix: --logfc-threshold=
      separate: false
  - id: min_pct
    type:
      - 'null'
      - float
    doc: Only test genes that are detected in a minimum fraction of min.pct cells in either of the two populations. Meant to speed up the function by not testing genes that are very infrequently expressed. Default is 0.1.
    inputBinding:
      position: 6
      prefix: --min-pct=
      separate: false
  - id: min_diff_pct
    type:
      - 'null'
      - float
    doc: Only test genes that show a minimum difference in the fraction of detection between the two groups. Set to -Inf by default.
    inputBinding:
      position: 7
      prefix: --min-diff-pct=
      separate: false
  - id: only_pos
    type:
      - 'null'
      - string
    doc: Only return positive markers (FALSE by default).
    inputBinding:
      position: 8
      prefix: --only-pos=
      separate: false
  - id: test_use
    type:
      - 'null'
      - string
    doc: Denotes which test to use. Available options are 'wilcox', 'bimod', 'roc', 't', 'tobit', 'poisson', 'negbinom', 'MAST', 'DESeq2'. See ?FindMarkers() for more info.
    inputBinding:
      position: 9
      prefix: --test-use=
      separate: false
  - id: max_cells_per_ident
    type:
      - 'null'
      - float
    doc: Down sample each identity class to a max number. Default is no downsampling. Not activated by default (set to Inf).
    inputBinding:
      position: 10
      prefix: --max-cells-per-ident=
      separate: false
  - id: min_cells_gene
    type:
      - 'null'
      - int
    doc: Minimum number of cells expressing the gene in at least one of the two groups, currently only used for poisson and negative binomial tests.
    inputBinding:
      position: 11
      prefix: --min-cells-gene=
      separate: false
  - id: min_cells_group
    type:
      - 'null'
      - int
    doc: Minimum number of cells in one of the groups.
    inputBinding:
      position: 12
      prefix: --min-cells-group=
      separate: false
outputs:
  - id: output_text_file
    type: File
    doc: File name in which to store text format matrix containing a ranked list of putative markers, and associated statistics (p-values, ROC score, etc.).
    outputBinding:
      glob: $(inputs.output_text_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
