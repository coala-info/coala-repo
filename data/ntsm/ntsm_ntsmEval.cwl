cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntsmEval
label: ntsm_ntsmEval
doc: "Processes sets of counts files and compares their similarity. If only a single
  file is provided general QC information returned.\n\nTool homepage: https://github.com/JustinChu/ntsm"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Sets of counts files
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: Output results of all tests tried, not just those that pass the score 
      threshold.
    inputBinding:
      position: 102
      prefix: --all
  - id: dim
    type:
      - 'null'
      - int
    doc: Number of dimensions to consider in PCA.
    default: 20
    inputBinding:
      position: 102
      prefix: --dim
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Error rate threshold for PCA based search
    default: 0.01
    inputBinding:
      position: 102
      prefix: --error_rate
  - id: genome_size
    type:
      - 'null'
      - int
    doc: Diploid genome size for error rate estimation.
    default: 6200000000
    inputBinding:
      position: 102
      prefix: --genome_size
  - id: large
    type:
      - 'null'
      - float
    doc: Search radius for large PCA based search
    default: 15.0
    inputBinding:
      position: 102
      prefix: --large
  - id: merge
    type:
      - 'null'
      - string
    doc: After analysis merge counts and output to file.
    inputBinding:
      position: 102
      prefix: --merge
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Keep only sites with this coverage and above.
    default: 1
    inputBinding:
      position: 102
      prefix: --min_cov
  - id: miss_large
    type:
      - 'null'
      - float
    doc: Missing site threshold large PCA based search
    default: 0.3
    inputBinding:
      position: 102
      prefix: --miss_large
  - id: miss_small
    type:
      - 'null'
      - float
    doc: Missing site threshold small for PCA based search
    default: 0.01
    inputBinding:
      position: 102
      prefix: --miss_small
  - id: norm
    type:
      - 'null'
      - string
    doc: Set of values use to center the data before rotation during PCA. 
      [Required if -p is enabled]
    inputBinding:
      position: 102
      prefix: --norm
  - id: only_merge
    type:
      - 'null'
      - boolean
    doc: Do not perform an analysis. Only functions when -e (--merge) option is 
      specified.
    inputBinding:
      position: 102
      prefix: --only_merge
  - id: pca
    type:
      - 'null'
      - string
    doc: Use PCA information to speed up analysis. Input is a set of rotational 
      values from a PCA.
    inputBinding:
      position: 102
      prefix: --pca
  - id: score_thresh
    type:
      - 'null'
      - float
    doc: Score threshold
    default: 0.5
    inputBinding:
      position: 102
      prefix: --score_thresh
  - id: skew
    type:
      - 'null'
      - float
    doc: 'Divides the score by coverage. Formula: (cov1*cov2)^skew Set to zero for
      no skew.'
    default: 0.2
    inputBinding:
      position: 102
      prefix: --skew
  - id: small
    type:
      - 'null'
      - float
    doc: Search radius for small PCA based search
    default: 2.0
    inputBinding:
      position: 102
      prefix: --small
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to run.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
stdout: ntsm_ntsmEval.out
