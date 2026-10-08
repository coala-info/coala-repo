cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - boundaries
label: fanc_boundaries
doc: "Determine domain boundaries from insulation scores.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type: File
    doc: "Input InsulationScores or regions file."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Boundary BED file, or file prefix ('<window size>.bed' is appended) for several window sizes."
    inputBinding:
      position: 2
  - id: window_sizes
    type:
      - 'null'
      - string
    doc: "Insulation index window size to calculate boundaries on. Separate multiple window sizes with comma, e.g. 1mb,500kb,100kb"
    inputBinding:
      position: 20
      prefix: --window-sizes
  - id: delta
    type:
      - 'null'
      - int
    doc: "Window size for calculating the delta vector (in bins). Calculation takes into account d bins upstream and d bins downstream for a total window size of 2*d + 1 bins. Default 3."
    inputBinding:
      position: 20
      prefix: --delta
  - id: min_score
    type:
      - 'null'
      - float
    doc: "Report only peaks where the two surrounding extrema of the delta vector have at least this difference in height. Default: no threshold."
    inputBinding:
      position: 20
      prefix: --min-score
  - id: sub_bin_precision
    type:
      - 'null'
      - boolean
    doc: "Report boundary positions with sub-bin precision. This works because the minimum or the the insulation score track can be determined with sub-bin precision. Default: False"
    inputBinding:
      position: 20
      prefix: --sub-bin-precision
  - id: log
    type:
      - 'null'
      - boolean
    doc: "log-transform index values before boundary calling."
    inputBinding:
      position: 20
      prefix: --log
  - id: maxima
    type:
      - 'null'
      - boolean
    doc: "Call maxima of the insulation score instead of minima."
    inputBinding:
      position: 20
      prefix: --maxima
outputs:
  - id: boundaries
    type:
      type: array
      items: File
    doc: "Boundary BED file(s)."
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
