cwlVersion: v1.2
class: CommandLineTool
baseCommand: scater-calculate-qc-metrics.R
label: scater-scripts_scater-calculate-qc-metrics.R
doc: "Calculate QC metrics for single-cell RNA-seq data.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts"
inputs:
  - id: cell_controls
    type:
      - 'null'
      - File
    doc: file (one cell per line) to be used to derive a vector of cell (sample)
      names used to identify cell controls (for example, blank wells or bulk 
      controls).
    inputBinding:
      position: 101
      prefix: --cell-controls
  - id: detection_limit
    type:
      - 'null'
      - float
    doc: A numeric scalar to be passed to 'nexprs', specifying the lower 
      detection limit for expression.
    inputBinding:
      position: 101
      prefix: --detection-limit
  - id: exprs_values
    type:
      - 'null'
      - string
    doc: A string indicating which ‘assays’ in the ‘object’ should be used to 
      define expression.
    inputBinding:
      position: 101
      prefix: --exprs-values
  - id: feature_controls
    type:
      - 'null'
      - File
    doc: file containing a list of the control files with one file per line. 
      Each control file should have one feature (e.g. gene) per line. A named 
      list is created (names derived from control file names) containing one or 
      more vectors to identify feature controls (for example, ERCC spike-in 
      genes, mitochondrial genes, etc)
    inputBinding:
      position: 101
      prefix: --feature-controls
  - id: input_object_file
    type: File
    doc: singleCellExperiment object containing expression values and 
      experimental information. Must have been appropriately prepared.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: percent_top
    type:
      - 'null'
      - string
    doc: Comma-separated list of integers. Each element is treated as a number 
      of top genes to compute the percentage of library size occupied by the 
      most highly expressed genes in each cell.
    inputBinding:
      position: 101
      prefix: --percent-top
  - id: use_spikes
    type:
      - 'null'
      - boolean
    doc: A logical scalar indicating whether existing spike-in sets in ‘object’ 
      should be automatically added to 'feature_controls', see '?isSpike'.
    inputBinding:
      position: 101
      prefix: --use-spikes
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
