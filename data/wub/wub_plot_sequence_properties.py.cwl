cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot_sequence_properties.py
label: wub_plot_sequence_properties.py
doc: "Plot histograms of lengths and quality values.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: "Input format (fastq)."
    inputBinding:
      position: 1
      prefix: -f
  - id: bins
    type:
      - 'null'
      - int
    doc: "Number of bins on histograms (50)."
    inputBinding:
      position: 2
      prefix: -b
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: "Report pdf (plot_sequence_properties.pdf)."
    inputBinding:
      position: 3
      prefix: -r
  - id: joint_plot
    type:
      - 'null'
      - boolean
    doc: "Produce joint plot of lengths and mean quality values (False)."
    inputBinding:
      position: 4
      prefix: -j
  - id: input_fastx
    type: File
    doc: "Input (default: stdin)."
    inputBinding:
      position: 100
outputs:
  - id: report
    type: File
    doc: "Histogram report"
    outputBinding:
      glob: '${ return inputs.report_pdf ? inputs.report_pdf : "plot_sequence_properties.pdf"; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
