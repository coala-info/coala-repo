cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot_qualities.py
label: wub_plot_qualities.py
doc: "Plot the mean quality values across non-overlapping windows in the input sequences.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: win_size
    type:
      - 'null'
      - int
    doc: "Window size (50)."
    inputBinding:
      position: 1
      prefix: -w
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: "Report pdf (plot_qualities.pdf)."
    inputBinding:
      position: 2
      prefix: -r
  - id: input_fastx
    type: File
    doc: "Input (default: stdin)."
    inputBinding:
      position: 100
outputs:
  - id: report
    type: File
    doc: "Quality plot report"
    outputBinding:
      glob: '${ return inputs.report_pdf ? inputs.report_pdf : "plot_qualities.pdf"; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
