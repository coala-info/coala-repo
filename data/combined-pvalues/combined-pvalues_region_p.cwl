cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comb-p
  - region_p
label: combined-pvalues_region_p
doc: "calculate a p-value of a region using the Stouffer-Liptak method or the z-score\
  \ method.\n\nTool homepage: https://github.com/brentp/combined-pvalues"
inputs:
  - id: pvals
    type: File
    doc: BED containing all the p values used to generate the regions
    inputBinding:
      position: 101
      prefix: -p
  - id: regions
    type: File
    doc: BED containing all the regions
    inputBinding:
      position: 101
      prefix: -r
  - id: step
    type:
      - 'null'
      - int
    doc: step size for acf calculation; should be the same value as the step sent
      to -d of acf
    inputBinding:
      position: 101
      prefix: --step
  - id: column
    type:
      - 'null'
      - string
    doc: column containing the p-value of interest; column number (1-based) or header
      name
    inputBinding:
      position: 101
      prefix: -c
  - id: zscore
    type:
      - 'null'
      - boolean
    doc: use z-score correction
    inputBinding:
      position: 101
      prefix: -z
outputs:
  - id: output
    type: stdout
    doc: result written to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
stdout: combined-pvalues_region_p.out
