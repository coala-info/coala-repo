cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comb-p
  - manhattan
label: combined-pvalues_manhattan
doc: "a manhattan plot of values in a BED file.\n\nTool homepage: https://github.com/brentp/combined-pvalues"
inputs:
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: the p-value is already -log10'd, don't re -log10
    inputBinding:
      position: 101
      prefix: --no-log
  - id: bonferonni
    type:
      - 'null'
      - boolean
    doc: plot a line for the bonferonni of 0.05
    inputBinding:
      position: 101
      prefix: -b
  - id: column
    type:
      - 'null'
      - string
    doc: index of the column containing the p-value
    inputBinding:
      position: 101
      prefix: --col
  - id: image
    type: string
    default: manhattan.png
    doc: save the image to this file
    inputBinding:
      position: 101
      prefix: --image
  - id: title
    type:
      - 'null'
      - string
    doc: title for the image
    inputBinding:
      position: 101
      prefix: --title
  - id: ymax
    type:
      - 'null'
      - float
    doc: max (-log) y-value for plot
    inputBinding:
      position: 101
      prefix: --ymax
  - id: lines
    type:
      - 'null'
      - boolean
    doc: plot the p-values as lines extending from the x-axis rather than points
    inputBinding:
      position: 101
      prefix: --lines
  - id: regions
    type:
      - 'null'
      - File
    doc: points in these bed regions are colored differently
    inputBinding:
      position: 101
      prefix: --regions
  - id: subplots
    type:
      - 'null'
      - boolean
    doc: plot qq-plot and p-value histogram as sub-plots
    inputBinding:
      position: 101
      prefix: --subplots
  - id: bed_file
    type: File
    doc: bed-file to plot
    inputBinding:
      position: 1
outputs:
  - id: plot
    type: File
    doc: manhattan plot image
    outputBinding:
      glob: $(inputs.image)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
