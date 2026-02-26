cwlVersion: v1.2
class: CommandLineTool
baseCommand: kinship-read
label: kinship-read
doc: "Calculate kinship coefficients from genotype data.\n\nTool homepage: https://bitbucket.org/tguenther/read/src/master/"
inputs:
  - id: input_file
    type: string
    doc: Prefix of input Plink bed/bim/fam files
    inputBinding:
      position: 101
      prefix: --input
  - id: norm_method
    type: string
    doc: Normalization method (either 'mean', 'median', 'max' or 'value')
    inputBinding:
      position: 101
      prefix: --norm_method
  - id: norm_value
    type:
      - 'null'
      - float
    doc: User-specified normalization value
    inputBinding:
      position: 101
      prefix: --norm_value
  - id: use_alternative_thresholds
    type:
      - 'null'
      - boolean
    doc: Use alternative classification thresholds
    inputBinding:
      position: 101
      prefix: --2pow
  - id: window_est
    type:
      - 'null'
      - boolean
    doc: Window based estimate of P0 (as opposed to the genome-wide estimate, 
      default in READv2)
    inputBinding:
      position: 101
      prefix: --window_est
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size
    default: 5000000
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kinship-read:2.1.1--pyh7cba7a3_0
stdout: kinship-read.out
