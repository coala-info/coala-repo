cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comb-p
  - hist
label: combined-pvalues_hist
doc: "draw a histogram of the distribution of a given column and check for uniformity\
  \ with the chisq test.\n\nTool homepage: https://github.com/brentp/combined-pvalues"
inputs:
  - id: column
    type:
      - 'null'
      - int
    doc: column number (1-based) for the histogram
    inputBinding:
      position: 101
      prefix: -c
  - id: bins
    type:
      - 'null'
      - int
    doc: number of bins in the histogram
    inputBinding:
      position: 101
      prefix: -n
  - id: file
    type: File
    doc: bed file
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: result written to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
stdout: combined-pvalues_hist.out
