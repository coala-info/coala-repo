cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - segmetrics
label: cnvkit_segmetrics
doc: "Compute segment-level metrics from bin-level log2 ratios.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: cnarray
    type: File
    doc: "Bin-level copy ratio data file (*.cnn, *.cnr)."
    inputBinding:
      position: 1
  - id: segments
    type: File
    doc: "Segmentation data file (*.cns, output of the 'segment' command)."
    inputBinding:
      position: 101
      prefix: --segments
  - id: drop_low_coverage
    type:
      - 'null'
      - boolean
    doc: "Drop very-low-coverage bins before calculations to avoid negative bias in poor-quality tumor samples."
    inputBinding:
      position: 101
      prefix: --drop-low-coverage
  - id: output
    type: string
    doc: "Output table file name."
    inputBinding:
      position: 101
      prefix: --output
  - id: mean
    type:
      - 'null'
      - boolean
    doc: "Mean log2 ratio (unweighted)."
    inputBinding:
      position: 101
      prefix: --mean
  - id: median
    type:
      - 'null'
      - boolean
    doc: "Median."
    inputBinding:
      position: 101
      prefix: --median
  - id: mode
    type:
      - 'null'
      - boolean
    doc: "Mode (i.e. peak density of bin log2 ratios)."
    inputBinding:
      position: 101
      prefix: --mode
  - id: t_test
    type:
      - 'null'
      - boolean
    doc: "One-sample t-test of bin log2 ratios versus 0.0."
    inputBinding:
      position: 101
      prefix: --t-test
  - id: stdev
    type:
      - 'null'
      - boolean
    doc: "Standard deviation."
    inputBinding:
      position: 101
      prefix: --stdev
  - id: sem
    type:
      - 'null'
      - boolean
    doc: "Standard error of the mean."
    inputBinding:
      position: 101
      prefix: --sem
  - id: mad
    type:
      - 'null'
      - boolean
    doc: "Median absolute deviation (standardized)."
    inputBinding:
      position: 101
      prefix: --mad
  - id: mse
    type:
      - 'null'
      - boolean
    doc: "Mean squared error."
    inputBinding:
      position: 101
      prefix: --mse
  - id: iqr
    type:
      - 'null'
      - boolean
    doc: "Inter-quartile range."
    inputBinding:
      position: 101
      prefix: --iqr
  - id: bivar
    type:
      - 'null'
      - boolean
    doc: "Tukey's biweight midvariance."
    inputBinding:
      position: 101
      prefix: --bivar
  - id: ci
    type:
      - 'null'
      - boolean
    doc: "Confidence interval (by bootstrap)."
    inputBinding:
      position: 101
      prefix: --ci
  - id: pi
    type:
      - 'null'
      - boolean
    doc: "Prediction interval."
    inputBinding:
      position: 101
      prefix: --pi
  - id: alpha
    type:
      - 'null'
      - float
    doc: "Level to estimate confidence and prediction intervals; use with --ci and --pi. [Default: 0.05]"
    inputBinding:
      position: 101
      prefix: --alpha
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: "Number of bootstrap iterations to estimate confidence interval; use with --ci. [Default: %(default)d]"
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: smooth_bootstrap
    type:
      - 'null'
      - boolean
    doc: "Apply Gaussian noise to bootstrap samples, a.k.a. smoothed bootstrap, to estimate confidence interval; use with --ci."
    inputBinding:
      position: 101
      prefix: --smooth-bootstrap
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output table file name."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
