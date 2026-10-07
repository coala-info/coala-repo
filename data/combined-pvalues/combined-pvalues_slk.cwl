cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comb-p
  - slk
label: combined-pvalues_slk
doc: "Stouffer-Liptak-Kechris correction of correlated p-values\n\nTool homepage:\
  \ https://github.com/brentp/combined-pvalues"
inputs:
  - id: acf
    type:
      - 'null'
      - File
    doc: acf file containing the lagged correlations (output of acf); sets the max
      distance and the distance lags
    inputBinding:
      position: 101
      prefix: --acf
  - id: column
    type:
      - 'null'
      - int
    doc: column number (1-based) that has the value to take the acf
    inputBinding:
      position: 101
      prefix: -c
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
stdout: combined-pvalues_slk.out
