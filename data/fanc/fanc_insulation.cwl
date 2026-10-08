cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - insulation
label: fanc_insulation
doc: "Calculate insulation scores for a Hic object.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type: File
    doc: "Input matrix (Hi-C, fold-change map, ...)."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output file (FAN-C object), or file prefix for bed, gff or bigwig output (the window size is appended)."
    inputBinding:
      position: 2
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Format of the output file. By default, this is a FAN-C InsulationScore object, for maximum compatibility with other analyses. Other options are \"bed\", \"bigwig\", and \"gff\""
    inputBinding:
      position: 20
      prefix: --output-format
  - id: window_sizes
    type:
      - 'null'
      - type: array
        items: string
    doc: "Window sizes in base pairs. You can also use abbreviated number format (i.e. 1.5M, 250kb, etc). If not specified, will choose the window sizes based on the matrix resolution r when calculating scores. Specifically: r*3, r*5, r*7, r*10, and r*15"
    inputBinding:
      position: 20
      prefix: --window-sizes
  - id: region
    type:
      - 'null'
      - string
    doc: "Region selector (<chr>:<start>-<end>) to only calculate II for this region."
    inputBinding:
      position: 20
      prefix: --region
  - id: impute
    type:
      - 'null'
      - boolean
    doc: "Impute missing values in matrix. If set, missing matrix values (where an entire Hi-C bin has 0 contacts) will be replaced by the expected value at the given distance."
    inputBinding:
      position: 20
      prefix: --impute
  - id: offset
    type:
      - 'null'
      - int
    doc: "Window offset in base pairs from the diagonal."
    inputBinding:
      position: 20
      prefix: --offset
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: "Do not log2-transform insulation index after normalisation. Log-transformation roughly centers values around 0, but if you need this to be exactly centered, use the \"--geom-mean\" option."
    inputBinding:
      position: 20
      prefix: --no-log
  - id: no_norm
    type:
      - 'null'
      - boolean
    doc: "Do not normalise index to insulation average Default is whole chromosome normalisation - to normalise to smaller regions, use --normalisation-window."
    inputBinding:
      position: 20
      prefix: --no-norm
  - id: normalisation_window
    type:
      - 'null'
      - int
    doc: "Size of the normalisation window (moving average) in bins. Default: whole chromosome."
    inputBinding:
      position: 20
      prefix: --normalisation-window
  - id: subtract_mean
    type:
      - 'null'
      - boolean
    doc: "Subtract mean instead of dividing by it when \"-n\" is enabled. You probably do not want this, unless you are working with log-transformed matrices (e.g. fold- change matrices)"
    inputBinding:
      position: 20
      prefix: --subtract-mean
  - id: geom_mean
    type:
      - 'null'
      - boolean
    doc: "Use geometric mean for normalisation (rather than arithmetic mean). Useful in conjunction with --log to center the distribution at 0. This is very important when comparing insulation scores, for example using the \"fanc compare\" command!"
    inputBinding:
      position: 20
      prefix: --geom-mean
  - id: trim_mean
    type:
      - 'null'
      - float
    doc: "Use a trimmed mean for insulation index normalisation with this cutoff (fraction of scores)"
    inputBinding:
      position: 20
      prefix: --trim-mean
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: scores
    type:
      type: array
      items: File
    doc: "The insulation scores object, or one file per window size for text formats."
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
