cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comb-p
  - filter
label: combined-pvalues_filter
doc: "count the number of switches in sign in the regions and output the region_bed\
  \ intervals with the sum of positive and negative t-scores.\n\nTool homepage: https://github.com/brentp/combined-pvalues"
inputs:
  - id: p_column
    type:
      - 'null'
      - string
    doc: p-value column from p_bed
    inputBinding:
      position: 101
      prefix: -p
  - id: t_column
    type:
      - 'null'
      - string
    doc: t-statistic or directionality column from p_bed
    inputBinding:
      position: 101
      prefix: -t
  - id: coef
    type:
      - 'null'
      - string
    doc: name of coefficient column in BED
    inputBinding:
      position: 101
      prefix: --coef
  - id: filter
    type:
      - 'null'
      - boolean
    doc: don't print row if there's a switch in t-scores
    inputBinding:
      position: 101
      prefix: --filter
  - id: max_p
    type:
      - 'null'
      - float
    doc: filter regions with any p-value > this value
    inputBinding:
      position: 101
      prefix: --max-p
  - id: region_p
    type:
      - 'null'
      - float
    doc: filter regions with combined p-value > this value
    inputBinding:
      position: 101
      prefix: --region-p
  - id: region_bed
    type: File
    doc: file containing the regions
    inputBinding:
      position: 1
  - id: p_bed
    type: File
    doc: file containing the raw p-values
    inputBinding:
      position: 2
outputs:
  - id: output
    type: stdout
    doc: result written to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
stdout: combined-pvalues_filter.out
