cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - compare
label: fanc_compare
doc: "Create pairwise comparisons of Hi-C matrices or region-based scores (fold-change or difference).\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input1
    type: File
    doc: "First input matrix (e.g. Hic) or region-based file."
    inputBinding:
      position: 1
  - id: input2
    type: File
    doc: "Second input matrix (e.g. Hic) or region-based file."
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "Output ComparisonMatrix file."
    inputBinding:
      position: 3
  - id: comparison
    type:
      - 'null'
      - string
    doc: "Type of comparison. Default: fold-change, other options are: difference"
    inputBinding:
      position: 20
      prefix: --comparison
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format for region-based comparisons. Only relevant when using BED, GFF, or another region-based format as input."
    inputBinding:
      position: 20
      prefix: --output-format
  - id: no_scale
    type:
      - 'null'
      - boolean
    doc: "Do not scale input matrices to the same number of valid pairs"
    inputBinding:
      position: 20
      prefix: --no-scale
  - id: log
    type:
      - 'null'
      - boolean
    doc: "Log2-convert comparison values (AFTER the comparison)"
    inputBinding:
      position: 20
      prefix: --log
  - id: log_matrix
    type:
      - 'null'
      - boolean
    doc: "Log2-convert matrices (BEFORE the comparison)"
    inputBinding:
      position: 20
      prefix: --log-matrix
  - id: ignore_zero
    type:
      - 'null'
      - boolean
    doc: "Do not consider pixels where one matrix entry is zero"
    inputBinding:
      position: 20
      prefix: --ignore-zero
  - id: ignore_infinite
    type:
      - 'null'
      - boolean
    doc: "Do not consider pixels where the comparison yields \"inf\""
    inputBinding:
      position: 20
      prefix: --ignore-infinite
  - id: observed_expected
    type:
      - 'null'
      - boolean
    doc: "O/E transform matrix values before comparison. Only has an effect on matrix comparisons."
    inputBinding:
      position: 20
      prefix: --observed-expected
  - id: uncorrected
    type:
      - 'null'
      - boolean
    doc: "Compare uncorrected matrices. Only has an effect on matrix comparisons."
    inputBinding:
      position: 20
      prefix: --uncorrected
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: comparison
    type:
      type: array
      items: File
    doc: "Comparison object or files."
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
