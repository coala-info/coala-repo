cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - genemetrics
label: cnvkit_genemetrics
doc: "Identify targeted genes with copy number gain or loss.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filename
    type: File
    doc: "Processed sample coverage data file (*.cnr), the output of the 'fix' sub-command."
    inputBinding:
      position: 1
  - id: segment
    type:
      - 'null'
      - File
    doc: "Segmentation calls (.cns), the output of the 'segment' command)."
    inputBinding:
      position: 101
      prefix: --segment
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Copy number change threshold to report a gene gain/loss. [Default: 0.2]"
    inputBinding:
      position: 101
      prefix: --threshold
  - id: min_probes
    type:
      - 'null'
      - int
    doc: "Minimum number of covered probes to report a gain/loss. [Default: %(default)d]"
    inputBinding:
      position: 101
      prefix: --min-probes
  - id: drop_low_coverage
    type:
      - 'null'
      - boolean
    doc: "Drop very-low-coverage bins before segmentation to avoid false-positive deletions in poor-quality tumor samples."
    inputBinding:
      position: 101
      prefix: --drop-low-coverage
  - id: male_reference
    type:
      - 'null'
      - boolean
    doc: "Assume inputs were normalized to a male reference (i.e. female samples will have +1 log-coverage of chrX; otherwise male samples would have -1 chrX)."
    inputBinding:
      position: 101
      prefix: --male-reference
  - id: sample_sex
    type:
      - 'null'
      - string
    doc: "Specify the sample's chromosomal sex as male or female. (Otherwise guessed from X and Y coverage). (choices: m, y, male, Male, f, x, female, Female)"
    inputBinding:
      position: 101
      prefix: --sample-sex
  - id: output
    type: string
    doc: "Output table file name."
    inputBinding:
      position: 101
      prefix: --output
  - id: diploid_parx_genome
    type:
      - 'null'
      - string
    doc: "Considers the given human genome's PAR of chromosome X as autosomal. Example: 'grch38'"
    inputBinding:
      position: 101
      prefix: --diploid-parx-genome
  - id: mean
    type:
      - 'null'
      - boolean
    doc: "Mean log2-ratio (unweighted)."
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
    doc: "Mode (i.e. peak density of log2 ratios)."
    inputBinding:
      position: 101
      prefix: --mode
  - id: ttest
    type:
      - 'null'
      - boolean
    doc: "One-sample t-test of bin log2 ratios versus 0.0."
    inputBinding:
      position: 101
      prefix: --ttest
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
