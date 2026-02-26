cwlVersion: v1.2
class: CommandLineTool
baseCommand: tspex
label: tspex
doc: "Compute gene tissue-specificity from an expression matrix and save the output.\n\
  \nTool homepage: https://github.com/apcamargo/tspex"
inputs:
  - id: input_file
    type: File
    doc: Expression matrix file in the TSV, CSV or Excel formats.
    inputBinding:
      position: 1
  - id: method
    type: string
    doc: 'Tissue-specificity metric. Allowed values are: "counts", "tau", "gini",
      "simpson", "shannon_specificity", "roku_specificity", "tsi", "zscore", "spm",
      "spm_dpm", "js_specificity", "js_specificity_dpm".'
    inputBinding:
      position: 2
  - id: disable_transformation
    type:
      - 'null'
      - boolean
    doc: By default, tissue-specificity values are transformed so that they 
      range from 0 (perfectly ubiquitous) to 1 (perfectly tissue-specific). If 
      this parameter is used, transformation will be disabled and each metric 
      will have have a diferent range of possible values.
    default: false
    inputBinding:
      position: 103
      prefix: --disable_transformation
  - id: log_transform
    type:
      - 'null'
      - boolean
    doc: Log-transform expression values.
    default: false
    inputBinding:
      position: 103
      prefix: --log
  - id: threshold
    type:
      - 'null'
      - int
    doc: Threshold to be used with the "counts" metric. If another method is 
      chosen, this parameter will be ignored.
    default: 0
    inputBinding:
      position: 103
      prefix: --threshold
outputs:
  - id: output_file
    type: File
    doc: Output TSV file containing tissue-specificity values.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tspex:0.6.3--pyhdfd78af_0
