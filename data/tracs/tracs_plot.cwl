cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_plot
label: tracs_plot
doc: "Generates plots from a pileup file.\n\nTool homepage: https://github.com/gtonkinhill/tracs"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: alpha value for plotting
    default: 0.1
    inputBinding:
      position: 101
      prefix: --alpha
  - id: column_name
    type:
      - 'null'
      - string
    doc: Column name in distance matrix to use
    default: SNP distance
    inputBinding:
      position: 101
      prefix: --column-name
  - id: contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: contigs for plotting
    default: All
    inputBinding:
      position: 101
      prefix: --contigs
  - id: either_strand
    type:
      - 'null'
      - boolean
    doc: turns off the requirement that a variant is supported by both strands
    inputBinding:
      position: 101
      prefix: --either-strand
  - id: height
    type:
      - 'null'
      - int
    doc: height value for plotting
    default: 7
    inputBinding:
      position: 101
      prefix: --height
  - id: input_files
    type:
      type: array
      items: File
    doc: path to query signature
    inputBinding:
      position: 101
      prefix: --input
  - id: min_freq
    type:
      - 'null'
      - float
    doc: minimum frequency to include a variant
    default: 0.0
    inputBinding:
      position: 101
      prefix: --min-freq
  - id: threshold
    type:
      - 'null'
      - float
    doc: threshold to filter transmission distances
    default: None
    inputBinding:
      position: 101
      prefix: --threshold
  - id: type
    type: string
    doc: Type of plot (scatter, line, heatmap)
    inputBinding:
      position: 101
      prefix: --type
  - id: width
    type:
      - 'null'
      - int
    doc: width value for plotting
    default: 10
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: output_file
    type: File
    doc: prefix of output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
