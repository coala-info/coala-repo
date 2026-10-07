cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comb-p
  - fdr
label: combined-pvalues_fdr
doc: "perform Benjamini-Hochberg FDR correction on a BED file with p-values.\n\nTool\
  \ homepage: https://github.com/brentp/combined-pvalues"
inputs:
  - id: column
    type:
      - 'null'
      - int
    doc: column number (1-based) of the p-values
    inputBinding:
      position: 101
      prefix: -c
  - id: qvality
    type:
      - 'null'
      - boolean
    doc: use qvality (needs --null and qvality on the PATH)
    inputBinding:
      position: 101
      prefix: --qvality
  - id: null_column
    type:
      - 'null'
      - int
    doc: column number of the p-values under the null (e.g. shuffled data) used for
      the correction; otherwise Benjamini-Hochberg is used
    inputBinding:
      position: 101
      prefix: --null
  - id: bed_file
    type: File
    doc: bed file to correct
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: result written to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
stdout: combined-pvalues_fdr.out
