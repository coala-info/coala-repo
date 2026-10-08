cwlVersion: v1.2
class: CommandLineTool
baseCommand: gadma-get_confidence_intervals
label: gadma_gadma-get_confidence_intervals
doc: "GADMA module for calculating confidence intervals from the result table of local search runs on bootstrapped data.\n\nTool homepage: https://github.com/ctlab/GADMA"
inputs:
  - id: log
    type:
      - 'null'
      - boolean
    doc: 'If log then logarithm will be used to calculate confidence intervals.'
    inputBinding:
      position: 1
      prefix: --log
  - id: tex
    type:
      - 'null'
      - boolean
    doc: 'LaTex output.'
    inputBinding:
      position: 1
      prefix: --tex
  - id: acc
    type:
      - 'null'
      - int
    doc: 'Precision of an output (default: 5).'
    inputBinding:
      position: 1
      prefix: --acc
  - id: results_file
    type: File
    doc: 'Filename (.csv or .pkl) with result from local search runs on bootstrapped data. Output of gadma-run_ls_on_boot_data.'
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Confidence intervals
stdout: gadma_gadma-get_confidence_intervals.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0
