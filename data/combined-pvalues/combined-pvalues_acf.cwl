cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comb-p
  - acf
label: combined-pvalues_acf
doc: "calculate the autocorrelation of a *sorted* bed file with a set of *distance*\
  \ lags.\n\nTool homepage: https://github.com/brentp/combined-pvalues"
inputs:
  - id: distance
    type:
      - 'null'
      - string
    doc: start:stop:stepsize of distance, e.g. 15:500:50
    inputBinding:
      position: 101
      prefix: -d
  - id: column
    type:
      - 'null'
      - int
    doc: column number (1-based) with p-values for acf calculations
    inputBinding:
      position: 101
      prefix: -c
  - id: full
    type:
      - 'null'
      - boolean
    doc: do full autocorrelation (default is partial)
    inputBinding:
      position: 101
      prefix: --full
  - id: files
    type:
      type: array
      items: File
    doc: sorted BED files to process
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: result written to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
stdout: combined-pvalues_acf.out
