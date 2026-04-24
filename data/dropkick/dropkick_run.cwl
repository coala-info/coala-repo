cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropkick run
label: dropkick_run
doc: "Run dropkick to identify ambient RNA in single-cell data.\n\nTool homepage:
  https://github.com/KenLauLab/dropkick"
inputs:
  - id: counts
    type: File
    doc: Input (cell x gene) counts matrix as .h5ad or tab delimited text file
    inputBinding:
      position: 1
  - id: alphas
    type:
      - 'null'
      - type: array
        items: float
    doc: Ratio(s) between l1 and l2 regularization for regression model.
    inputBinding:
      position: 102
      prefix: --alphas
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Save dropkick scores and labels for each barcode to a flat .csv file.
    inputBinding:
      position: 102
      prefix: --csv
  - id: directions
    type:
      - 'null'
      - type: array
        items: string
    doc: Direction of thresholding for each heuristic in '--metrics'.
    inputBinding:
      position: 102
      prefix: --directions
  - id: metrics
    type:
      - 'null'
      - type: array
        items: string
    doc: Heuristics for thresholding to build training set for model.
    inputBinding:
      position: 102
      prefix: --metrics
  - id: min_genes
    type:
      - 'null'
      - int
    doc: Minimum number of genes detected to keep cell.
    inputBinding:
      position: 102
      prefix: --min-genes
  - id: n_ambient
    type:
      - 'null'
      - int
    doc: Number of top genes by dropout rate to use for ambient profile.
    inputBinding:
      position: 102
      prefix: --n-ambient
  - id: n_hvgs
    type:
      - 'null'
      - int
    doc: Number of highly variable genes for training model.
    inputBinding:
      position: 102
      prefix: --n-hvgs
  - id: n_iter
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for optimization.
    inputBinding:
      position: 102
      prefix: --n-iter
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: Maximum number of threads for cross validation.
    inputBinding:
      position: 102
      prefix: --n-jobs
  - id: quietly
    type:
      - 'null'
      - boolean
    doc: Run without printing processing updates to console.
    inputBinding:
      position: 102
      prefix: --quietly
  - id: seed
    type:
      - 'null'
      - int
    doc: Random state for cross validation.
    inputBinding:
      position: 102
      prefix: --seed
  - id: thresh_methods
    type:
      - 'null'
      - type: array
        items: string
    doc: Method used for automatic thresholding on each heuristic in 
      '--metrics'.
    inputBinding:
      position: 102
      prefix: --thresh-methods
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory. Output will be placed in 
      [output-dir]/[name]_dropkick.h5ad. Default './'.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropkick:1.2.8--py310h7eb0018_0
