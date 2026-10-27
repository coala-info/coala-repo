cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_apply
doc: "Apply a statistic (AUC, meanI, varI, minI, maxI, stddevI, CVI) to a data track over each region of a region track (binary operator apply).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 1
    valueFrom: "$(inputs.write_bedgraph ? 'write_bg' : 'write')"
  - position: 2
    valueFrom: $(inputs.output_name)
  - position: 3
    valueFrom: apply
  - position: 4
    valueFrom: $(inputs.statistic)
inputs:
  - id: statistic
    type:
      type: enum
      name: apply_statistic
      symbols: [AUC, meanI, varI, minI, maxI, stddevI, CVI]
    doc: Statistic computed by apply over each region.
  - id: regions
    type: File
    doc: Track whose intervals define the regions (for example BED).
    inputBinding:
      position: 5
  - id: data
    type: File
    doc: Data track the statistic is computed on.
    inputBinding:
      position: 6
  - id: output_name
    type: string
    doc: Output file name (the 'write' operator; a wiggle file, or bedGraph with write_bedgraph).
    default: out.wig
  - id: write_bedgraph
    type: ['null', boolean]
    doc: Use the 'write_bg' operator, which writes bedGraph instead of wiggle.
outputs:
  - id: output_file
    type: File
    doc: The track written by the 'write' operator.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
